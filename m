Return-Path: <netdev+bounces-239694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDFC6B5E9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83FA4E9264
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6259377E9A;
	Tue, 18 Nov 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fpg/a+6b"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25236923C;
	Tue, 18 Nov 2025 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492776; cv=fail; b=p43stqXpFyAhK0WKxfAo3XvOiq2Tltk/8V0gfIt2sO+BEdCPDQIUkjYKQS8o38qEcz03JDLNTQt34Zp/hLQZhwDbuLp/6tC+Ou9yTZtk3iPoKeE7nWFBwzaHLGS/tJJD4AdrAb6kVrdRk2FaXCormgDf+WJOQ0DSJqaTuXN/TCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492776; c=relaxed/simple;
	bh=ZoZR35FolYkqVTwplfFngZgYpaY3nPEjrnWSC2f5/xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZA6BIR2+Cv2oa8qQM2BEKsTzKywJ6M3Z7dISYfD9Jw6P6f6l+diuUfAxhJCQhadbGiT4/ADCQPGI/TswSXjvRGCaF4YccLO467e20KbeEbn9a9627c+ZYQOAMfHdYj60EH8QYtabeV8ZTMJJzcVjsJylTAuTHqbjISffsxLRwnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fpg/a+6b; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3xYaAg7KaUWdgd990FgQKrbABSd+/jAJkItkgaM8yWUP0mCi7v07UxOimbYWLwwXh/jjHLk3fpsrjR1k7l5snQ5Vv6jnMnsc5n1m6l0JyF7xpLW87oLUPVEAXFEdS8hfAQCtXJZcu4s00LrfuFJjOr0wQeK7F2PKAgLTwNv9eY2gmPcZD/U/imY1/sZYS6TYkYPbCP6XMlHxaMRfKnwuz4kMR5rn8//p8oLYeT6bQiIdzeGCDsrL279Ps3swXi/+uVjMksF1fWwfgVM2AxnNSqRIwRkPUbg+w6y+NTZR2ialPQkpvk+YwfYgFMXGOXPHdbmQC8khwe+R/EwQDwzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VFQOH0eMXaWvL2Ur0YEJT57xr4U1DfA5ICkoaN0/Ts=;
 b=mT45TDVjRGVYnqk/Vhqq7/nvBOzp5uyOjW2wtq28JoP3aVY/2zgfw169fpC4mtaoE3nOwf0fYKCOCRQa98rgotQHeEvA6TJD0dpBjpoNjZD6DDWsgIsCMVsDBtFXDC8dz+tyJNkE7w01hkQsgElUDPrrNU/h/+fyoj1am7ii25S0/cJgLcQr8NOS9SMEAJlXds90mVe5qZZOnPYQ5J5liHX/huSO+dCdgeOq/ePhCqOrcqUdTFCOoLvcrs6tsXk8Rn+Pyhi/6GPggyZM6ImvskZYhySRH75fcOJVSAIrD6zK9oJWgAL9bcpoSY7SQEV/oQDvyj2fOFD2ZhcKe9xoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VFQOH0eMXaWvL2Ur0YEJT57xr4U1DfA5ICkoaN0/Ts=;
 b=fpg/a+6bjYmpQ31yAPDD9mMDhQShEWOSfhvUxnhnZTB/M+17mLN7pFOc+yNOJwWAuXAdtHXOmGDhzNkvvnSHOVpQYLFIjjABK6MLrDxe50RYurMnz+4xJak2yC9DN4xl/hGdjp9m3PGiLDveBTuLuMhNyTk+MyodpoE9A+fBw5U+7iyweKouo+1gcqHzqAv32a4FI+tUPJsIAQcn7MRCct48+3s7RSKQP4RrczvMefJCEYUlOTq7TFMtPcZTJk6nrGMqt1+LYwiUD7arBGMCY0jncoCrHcaV+szGnYXHby/Ij6iX+/PiUOEn2yHlmjwaEPmF11Cc27a6yiySTRuDTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:06:04 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:06:04 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs with xpcs-plat driver
Date: Tue, 18 Nov 2025 21:05:29 +0200
Message-Id: <20251118190530.580267-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b6d738-e415-4e8d-3b73-08de26d58555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzhkSkc4OTdDdkRlZERRamQzZDZERHg2RHZOcGN4SjVEREMrSkpoVEJGVWFF?=
 =?utf-8?B?VlAzYWR4d1EyQi9sQUxpYUdWeHY0Y1RHTVUwMUNuN3QyNyt0ZC9IeEcyYXgw?=
 =?utf-8?B?REdCeE93NlhlNjdoMlRUaUNhN3NibkRtcURJc21LcE03L2cwb3lNY3V2ZlZ6?=
 =?utf-8?B?N2VyTW1XcEgzeXU1OUJLRk9vWHp1NllySjhUcnBtZUpGZmpyaGZEY3BhcDhn?=
 =?utf-8?B?Rm5tam9uWXJZN0dOSVRYMXVzaEEveUd3UE16Z3BBa2xPSjZ1VFdrTFpLczAw?=
 =?utf-8?B?SkVjTWF2cGNDc0VNUUFmOHRlVWFQV2VnaXd5QmlCbDVKZElwSmdPSlE3SGMy?=
 =?utf-8?B?MVVEZVpYWmtOZmdxL0s1NGhjN3duS0h3YVpzOHBJWVBGT1IxanhoblViS2Yr?=
 =?utf-8?B?UjhkL1JwT0Z4bi8xNHpNUXRLUDlVTzE4bEJiRndiYnBzd2hzUkZCVDZXKzZB?=
 =?utf-8?B?WTBSOHdqTitadHhBdytmcnhSNUxnblJqaGNSTDZZMndWOGdlZXhuS1JTVTI5?=
 =?utf-8?B?a2gvcVZPdDhIUzFzOGNuWXhxRUVwNjhZM21pb0hKMHhtZ1lkMTZZUjhkQStR?=
 =?utf-8?B?aXRFcnZsL2JxQVpoRURzTHFJL1NydXdWUGtVRUI4V0VsZjI3bnBqSUJDVE5m?=
 =?utf-8?B?UTJUNzV1ZWxTc3RNOS9zQmcxZ3VraEdmNzJTSHlVTndNVlpteGo3SE40OUZy?=
 =?utf-8?B?UFBMcllFbE9ablhTanBlK1MwZEZ1UUlPcnNzSGhaQWxUVkpTZ2h0VUxaMVhB?=
 =?utf-8?B?RVBoSDZlUnNJUnBDcDRQQnpUc3NwNXhMS2VyYldmdlhOYkZYVzVjVFdPZVlr?=
 =?utf-8?B?cmlZRk80QWFPNUQxb0VlYkV1dnh1Q25tQkQzMVdrbVJSNTJQTzZLU1YyRkhO?=
 =?utf-8?B?eXh3aVRyTmpUZjA0YTBPeSt5djN0QktOa2s5clpwbkVaMk9oY3dnR1N1N2RN?=
 =?utf-8?B?RkVocG5zd2w2d2xrNVkvTGtnMSt2Uy9MSEg4TzNneVBlTGJRdmU2ZHdrdTlM?=
 =?utf-8?B?cFNpM2FNbVFsS2tYRGl4YVpaNUpMZm45MUJNZkYyRndCUFZQQ01FT3pDVUtD?=
 =?utf-8?B?L3pvbkR0VlBjaWFiTFdpdFoxZndwVEtuKzBGRnVSNVBnZ3graHYyM0o2TFNO?=
 =?utf-8?B?ODZNV3FWNkNaeDg4aUVtVXhIWkF0T3ZybFNKQXkxa1dESFJaQVZJWWNWS1lx?=
 =?utf-8?B?RU9TWEpxVTh6V1Z3RGU3SEhMMUZOQkZmeTFYVy82MmdHNERRdXpQN0k2SXht?=
 =?utf-8?B?ZGNmcmR2TjNCcDROWWhTWE9iUjE3c2JURE9wdFhBYUZYZEdoMm5Od2UvWjlo?=
 =?utf-8?B?eXpjQnJLYlplYWZ1bHZBRlVxNTd4V09sV2ZFUFNUUDIyYnJYN1BlblVDdXlx?=
 =?utf-8?B?NWwrbEY3Tktjb1RacHA2d29zSDIwTFUzU3lBYXhwTVNHWTlNcVFieHZsY2VS?=
 =?utf-8?B?MTN5dHF4WVFXeXJoT3cyQ0N5RTdvQXZ4Sm9iQWhUZGlTL2dYV2JPREZHSXky?=
 =?utf-8?B?c09yb2I0OVcwaWtON1ZBK0JzaEhoQXQ1SXBhZVZaN2duR2UyMCt6WjdMVnBU?=
 =?utf-8?B?WEJpQUJDQVRoWW15aEd2bVdSdjU2YUYvQm8rUGxrMFFLVElJQStkZ1V6dytS?=
 =?utf-8?B?VGxVOEdHS0lSUnJ0eHR0b3JGOUF6OEZaTTV0L0d6ZFVFSHBDNnc1cnU5QzFh?=
 =?utf-8?B?bmRNZGZCNG1LVU1jdzZudkZKcFVTL1ZDbllxL090RlY5WkZhaDlicGRGZjN0?=
 =?utf-8?B?ZlpRbFU2ZXZSc0RkRmRUZy9xSHRDQkl3T01yY0JKY25iK1IrWnRuWXVULy9J?=
 =?utf-8?B?MXFkMzF0cnZXcGVjWlBBUSswcWlmOXBvZkwxUGRQeDkxdDhDdmwyRHhpanlo?=
 =?utf-8?B?aE1Uc0Z5WUFGOFlFb3dKeGRFcVZ5RlVtNE9XU09jSjJjdEtJdXhHYmtReWt2?=
 =?utf-8?Q?8OyNsbQHX1d2vSGxDQZNhgSQ2EkcLjUq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGVWcDJmU2JFWnRKYkFudkMwcHo2SUUwRTRrcXBXRzQ4QlJySllQUjA0SGp5?=
 =?utf-8?B?eDB6MjlTVHoxM0NJNmE3V24wQVRFTXVjblRDbDJrNHZuSkZRYmRlSnN3K2RH?=
 =?utf-8?B?bUEyeUZMZGRzcnI4RkZ2L0prakJtMWdsaUdjSVUwU3lZYklBbDZRdjZ6ZlVZ?=
 =?utf-8?B?NlN4TzlVUlVQVnpXZVc2MURFcThOYVJ2eE51aVpSTG5iM3BGSFBubTBNSi9P?=
 =?utf-8?B?Wm1DNFV5MHRkMjVmdzYwak5Vc2JxZEFxZk5LbEQxa0RWS3BGQTFrYTFkMlF0?=
 =?utf-8?B?UkIrTmhGVS92RXhFNi90QUJWR1NMOExMelVQS2x5bEc4cGZtUjlFVFFhdlc2?=
 =?utf-8?B?MWdTWUI0SSsxTENoZ2ZXLzdaRGkxWGFDNjBNVFRUZ3NKYU1yakRLMGwxOGxo?=
 =?utf-8?B?NEE3VXFnWE8xSlFmZ2w1R0Zzc0NhNVhEWExuWjh3TnRzVEVJT3kxU3BKUTRo?=
 =?utf-8?B?ZnZGOXBOYTZVS0M2RXZZSXRSM3haUGZ1MlRpbXRSdmRnS2dDQU4yOFJwR3FH?=
 =?utf-8?B?azAxMW80SXVrN05ESzRxZCtkMm1GQmtVSTBwcnMxV3hlZXJIN2RWYkJxY3dp?=
 =?utf-8?B?WTlSU1ppU1h1cE5MODQ2LzZ6b3JLNFRBbzROd0lsall3ZnlRbzNZTzZFVU56?=
 =?utf-8?B?RFhSNmxMM2orU3hodHZCdWhvUmZtMDlnT3RoZ1pKeVE2bUxIbGkxRFpoWHda?=
 =?utf-8?B?aDhqRTJzUzFsa1RLSCtCcnl0VE5URG00MlZLaExUcVQ1US9nYlpvcWxmbGsr?=
 =?utf-8?B?WElMQno2OFVRZDk2dnBibjBDZkt1MFErK2ZmT3Q4b2MrWUpEQ1JNdks4clVv?=
 =?utf-8?B?YmRhWWFheWd4UHdUalkyRUluMWZCN2djYVEzTU1HRStJNXRzZGxabkRwaXhy?=
 =?utf-8?B?eGRDS2dNL2pZRUtENjhNb1RTa2kxaitaMGNaNmEzWmFKS1J5L0lZcTI2Vzd2?=
 =?utf-8?B?MTd6c1Bhdzl3clpBcjhONm9obXJKV2hyOFJEY1RiWHVJb0wyMDRwZWRTelVr?=
 =?utf-8?B?MVB4QUROeW1yMmRNN0VpZ3A2MkZOYVNzYUVGUlJDL1MvU1ZLd3k5Zk9senBL?=
 =?utf-8?B?Q0xDdmthS0tCSW9Db0dsL28xa25GZEZXZlpQVk4xZENieFJ1dkpZOVJ1d3hG?=
 =?utf-8?B?UFVNeklvUEp0VmF0Q2JIOU5yVENrWWxLU2d1M2JMZ0RkZGxKeFVCYnFnVFQx?=
 =?utf-8?B?NVE1dFpNeUt6MmtCbU0rVzNZWVdGSFB1aWlPUGxZVnREWHpaOFdkMDVJaHB0?=
 =?utf-8?B?ZERZSzBlYjRLeTVnZzVyc29DRkhtaThsMEtQdHNSZVpZL1BCSjZCV2xTQTJP?=
 =?utf-8?B?RDUrdUlWam5tOFdVNTZ5d1VFWVNuZWRuSUdlZjlCUGVBdkJjTTZMS0RzQnQ0?=
 =?utf-8?B?Z0owOXlkZ2RNR1BrQ29ubzI4MUc1ajMrODhtZit5MkhGWkZ0clJtMGV1blhn?=
 =?utf-8?B?VnliUS80NnpOWE55WHBld0x5cEp1SUExUVNIc1Jzajl3b3IzWUE5TExZV1Rr?=
 =?utf-8?B?ZEFycVAxbDQrREhoZ1JzNjJKS2pJWHBSOVZrVU9HUnVzMFI0UW8zc1Z6d2ZG?=
 =?utf-8?B?MGorME1odDFVMGJPczlrVENqa3hTL2ZUNlNPUTlrMmRybmZpWFdrL3hFTHJ4?=
 =?utf-8?B?WTNWcWpxN3BsMWJHalVJSEVqZlRpWi9DWnAvbW5GbU14ZmUySVVENGdKVTlo?=
 =?utf-8?B?TldyRlZXNDRMUC9id0Q0cDVJSmFuYlIxc0lMN2h6QlRSQ1h4M0ljbWFTQm1n?=
 =?utf-8?B?cGQ0SzdXZWNQT2hkYm9YSHh3YWppcFg2OUZQUnVvZXhJZnJyQXB1ckZxMUtu?=
 =?utf-8?B?M0tiZWx0SEZsY0g0UmtLY0h5R0c0TDhvdEFBc0w3c0hXVjNVa3oyN0hWakxJ?=
 =?utf-8?B?UGU1U1NNRjJJa2lOVUJGT0pRWXg4UTFPN0NLai9tSWxCWmgybzU1elh3WWEv?=
 =?utf-8?B?VkliWmdKdi93V092TW0vT01ZU3EzU3dPenluTVhRaEtnNjh4NUJrVXRlU3hv?=
 =?utf-8?B?Snl6U2NyTDNiZGFpSkdpam5CeUVRc3ByMEMwUlRObWpzY1dsaW9NMVF6blQz?=
 =?utf-8?B?KzhydU1PTWRoaWUxQmdEVGVJNXc1RzBZcWRUM3JORERZcnVtUUhuQjJnbDNM?=
 =?utf-8?B?SEFnSjJxY1U2Sm5RalJiQi9MZ0FpQ3hCeENZdXEwU2ZIZ1orZVFNTjdVL3Ji?=
 =?utf-8?Q?ldQ7YDGc7SOjZ7d/77+VzfI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b6d738-e415-4e8d-3b73-08de26d58555
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:06:04.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CDiPf3Ww5GfswU1AhMyfl7JSOzkargBFxjOwtfz9Rgu8WbA2TUbOos7tySOfz8nVWZWTFKp0/YRECi3iEbhlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

The code in sja1105_mdio.c does the same thing as the one added by Serge
Semin in drivers/net/pcs/pcs-xpcs-plat.c (implements a virtual MDIO bus,
backed by either a direct or an indirect register access method), except
the latter is generic after the conversion to regmap.

Except for just one problem: pcs-xpcs-plat.c expects to probe on a
device tree node, and the SJA1105 and SJA1110 doesn't describe its XPCS
on the SGMII ports in the device tree.

This is both a problem and a design intention. I've long held the view
that for SPI devices which don't have a common .dtsi but whose bindings
have to be written many times by many people for many boards, less is
more, and all the details like internal subdevices can probably stay
hidden even if those devices are being configured by the kernel.

I've also held the view that DSA should delegate its responsibility for
configuring non-essential subdevices to other drivers in their
respective subsystems, and that the switching IP core (the one with the
DSA driver) should merely be one of the MFD children of a MFD parent
that is in charge of the spi_device.

This would mean something like the "mscc,vsc7512" example from
Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml, but:
- retrofitting that model onto the SJA1105 bindings (and any other
  switch on a non-MMIO bus, where the ethernet-switch node coincides
  with the SPI/I2C bus device node) is a huge pain for backwards and
  especially forward compatibility, as it implies that the switch can be
  either a spi_device or a platform_device after the conversion
- if it sounds like it is conflicting with the first requirement of
  "less is more", yes it is

I've tried various ways of using the xpcs-plat driver while
avoiding major DT bindings changes for this switch, like
fwnode_create_software_node() and custom platform data.
Platform data was ugly and software nodes didn't work at all, for
reasons explained here:
https://lore.kernel.org/lkml/20230223203713.hcse3mkbq3m6sogb@skbuf/

I have to give huge credits to Andy Shevchenko, who after more than one
year remembered the discussion and referenced Hervé Codina's work on PCI
DT overlays, as well as a presentation from Lizhi Hou and Rob Herring.

I think I found the compromise solution that allows me to make progress,
which is to create a dynamic OF changeset that attaches the PCS node to
the live device tree, if it wasn't described already in the DTS, or use
the one from the DTS if it's already there. With a proper OF node, the
xpcs-plat driver probes just fine.

As for where to attach the XPCS node? Memory-mapped devices (in the
SPI address space, mind you) don't naturally sit well in the
"ethernet-switch" node, because that has #address-cells = <0>
and #size-cells = <0>.

We can't modify #address-cells and #size-cells, because "ethernet-switch"
has a reg-less "ethernet-ports" child node as per dsa.yaml, and the PCS
would sit on the same hierarchical level as that. Essentially this is
another angle of the argument that the DSA OF node shouldn't coincide
with the SPI bus device node, as this implies it is in control of the
entire address space.

The compromise, retrofit-ready solution here is to create a "regs"
container node which is a child of the ethernet-switch and
has #address-cells = <1> and #size-cells = <1>, then attach the XPCS to
that.

There also exists a use case where the XPCS is manually described
in the device tree, and that is when we need to describe SGMII lane
polarity inversion (not yet supported, TBD). In that case,
sja1105_fill_device_tree() simply backs off for the already present PCS
nodes, and sja1105_mfd_add_pcs_cells() works all the same.

A small implementation note in sja1105_create_pcs():
xpcs_create_fwnode() is NULL-tolerant via fwnode_device_is_available(),
so we don't need to explicitly handle the case where
priv->pcs_fwnode[port] wasn't assigned by sja1105_create_pcs_nodes()
(because the OF node exists in the DTS). This case currently returns
-ENODEV and will be handled by the next change.

Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/Kconfig        |   1 +
 drivers/net/dsa/sja1105/Makefile       |   1 -
 drivers/net/dsa/sja1105/sja1105.h      |  29 ++-
 drivers/net/dsa/sja1105/sja1105_main.c |  82 +++++++--
 drivers/net/dsa/sja1105/sja1105_mdio.c | 233 -------------------------
 drivers/net/dsa/sja1105/sja1105_mfd.c  | 228 +++++++++++++++++++++++-
 drivers/net/dsa/sja1105/sja1105_mfd.h  |   2 +
 drivers/net/dsa/sja1105/sja1105_spi.c  |  49 ++++--
 8 files changed, 342 insertions(+), 283 deletions(-)
 delete mode 100644 drivers/net/dsa/sja1105/sja1105_mdio.c

diff --git a/drivers/net/dsa/sja1105/Kconfig b/drivers/net/dsa/sja1105/Kconfig
index 932bca545d69..eef06e419559 100644
--- a/drivers/net/dsa/sja1105/Kconfig
+++ b/drivers/net/dsa/sja1105/Kconfig
@@ -8,6 +8,7 @@ tristate "NXP SJA1105 Ethernet switch family support"
 	select PACKING
 	select CRC32
 	select MFD_CORE
+	select OF_DYNAMIC
 	help
 	  This is the driver for the NXP SJA1105 (5-port) and SJA1110 (10-port)
 	  automotive Ethernet switch family. These are managed over an SPI
diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
index 3ac2d77dbe6c..94907116c1cc 100644
--- a/drivers/net/dsa/sja1105/Makefile
+++ b/drivers/net/dsa/sja1105/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_NET_DSA_SJA1105) += sja1105.o
 sja1105-objs := \
     sja1105_spi.o \
     sja1105_main.o \
-    sja1105_mdio.o \
     sja1105_mfd.o \
     sja1105_flower.o \
     sja1105_ethtool.o \
diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 22fce143cb76..96954f1f5bcf 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -44,6 +44,8 @@
 #define SJA1105_RGMII_DELAY_MAX_PS \
 	SJA1105_RGMII_DELAY_PHASE_TO_PS(1017)
 
+#define SJA1105_SGMII_PORT		4
+
 typedef enum {
 	SPI_READ = 0,
 	SPI_WRITE = 1,
@@ -91,7 +93,6 @@ struct sja1105_regs {
 	u64 rmii_ref_clk[SJA1105_MAX_NUM_PORTS];
 	u64 rmii_ext_tx_clk[SJA1105_MAX_NUM_PORTS];
 	u64 stats[__MAX_SJA1105_STATS_AREA][SJA1105_MAX_NUM_PORTS];
-	u64 pcs_base[SJA1105_MAX_NUM_PORTS];
 };
 
 enum {
@@ -109,6 +110,13 @@ enum sja1105_internal_phy_t {
 	SJA1105_PHY_BASE_T1,
 };
 
+struct sja1105_pcs_resource {
+	struct resource res;
+	int port;
+	const char *cell_name;
+	const char *compatible;
+};
+
 struct sja1105_info {
 	u64 device_id;
 	/* Needed for distinction between P and R, and between Q and S
@@ -148,10 +156,6 @@ struct sja1105_info {
 	bool (*rxtstamp)(struct dsa_switch *ds, int port, struct sk_buff *skb);
 	void (*txtstamp)(struct dsa_switch *ds, int port, struct sk_buff *skb);
 	int (*clocking_setup)(struct sja1105_private *priv);
-	int (*pcs_mdio_read_c45)(struct mii_bus *bus, int phy, int mmd,
-				 int reg);
-	int (*pcs_mdio_write_c45)(struct mii_bus *bus, int phy, int mmd,
-				  int reg, u16 val);
 	int (*disable_microcontroller)(struct sja1105_private *priv);
 	const char *name;
 	bool supports_mii[SJA1105_MAX_NUM_PORTS];
@@ -161,6 +165,8 @@ struct sja1105_info {
 	bool supports_2500basex[SJA1105_MAX_NUM_PORTS];
 	enum sja1105_internal_phy_t internal_phy[SJA1105_MAX_NUM_PORTS];
 	const u64 port_speed[SJA1105_SPEED_MAX];
+	const struct sja1105_pcs_resource *pcs_resources;
+	size_t num_pcs_resources;
 };
 
 enum sja1105_key_type {
@@ -273,8 +279,9 @@ struct sja1105_private {
 	struct regmap *regmap;
 	struct devlink_region **regions;
 	struct sja1105_cbs_entry *cbs;
-	struct mii_bus *mdio_pcs;
 	struct phylink_pcs *pcs[SJA1105_MAX_NUM_PORTS];
+	struct fwnode_handle *pcs_fwnode[SJA1105_MAX_NUM_PORTS];
+	struct of_changeset of_cs;
 	struct sja1105_ptp_data ptp_data;
 	struct sja1105_tas_data tas_data;
 };
@@ -302,16 +309,6 @@ int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled,
 			   struct netlink_ext_ack *extack);
 void sja1105_frame_memory_partitioning(struct sja1105_private *priv);
 
-/* From sja1105_mdio.c */
-int sja1105_mdiobus_register(struct dsa_switch *ds);
-void sja1105_mdiobus_unregister(struct dsa_switch *ds);
-int sja1105_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg);
-int sja1105_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
-			       u16 val);
-int sja1110_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg);
-int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
-			       u16 val);
-
 /* From sja1105_devlink.c */
 int sja1105_devlink_setup(struct dsa_switch *ds);
 void sja1105_devlink_teardown(struct dsa_switch *ds);
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6da5c655dae7..70aecdf9fd0e 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
+#include <linux/pcs/pcs-xpcs.h>
 #include <linux/netdev_features.h>
 #include <linux/netdevice.h>
 #include <linux/if_bridge.h>
@@ -3032,6 +3033,44 @@ static int sja1105_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int sja1105_create_pcs(struct dsa_switch *ds, int port)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct phylink_pcs *pcs;
+
+	if (priv->phy_mode[port] != PHY_INTERFACE_MODE_SGMII &&
+	    priv->phy_mode[port] != PHY_INTERFACE_MODE_2500BASEX)
+		return 0;
+
+	pcs = xpcs_create_pcs_fwnode(priv->pcs_fwnode[port]);
+	if (IS_ERR(pcs))
+		return PTR_ERR(pcs);
+
+	priv->pcs[port] = pcs;
+
+	return 0;
+}
+
+static void sja1105_destroy_pcs(struct dsa_switch *ds, int port)
+{
+	struct sja1105_private *priv = ds->priv;
+
+	if (priv->pcs[port]) {
+		xpcs_destroy_pcs(priv->pcs[port]);
+		priv->pcs[port] = NULL;
+	}
+}
+
+static int sja1105_port_setup(struct dsa_switch *ds, int port)
+{
+	return sja1105_create_pcs(ds, port);
+}
+
+static void sja1105_port_teardown(struct dsa_switch *ds, int port)
+{
+	sja1105_destroy_pcs(ds, port);
+}
+
 /* The programming model for the SJA1105 switch is "all-at-once" via static
  * configuration tables. Some of these can be dynamically modified at runtime,
  * but not the xMII mode parameters table.
@@ -3086,16 +3125,9 @@ static int sja1105_setup(struct dsa_switch *ds)
 		goto out_flower_teardown;
 	}
 
-	rc = sja1105_mdiobus_register(ds);
-	if (rc < 0) {
-		dev_err(ds->dev, "Failed to register MDIO bus: %pe\n",
-			ERR_PTR(rc));
-		goto out_ptp_clock_unregister;
-	}
-
 	rc = sja1105_devlink_setup(ds);
 	if (rc < 0)
-		goto out_mdiobus_unregister;
+		goto out_ptp_clock_unregister;
 
 	rtnl_lock();
 	rc = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
@@ -3125,8 +3157,6 @@ static int sja1105_setup(struct dsa_switch *ds)
 
 out_devlink_teardown:
 	sja1105_devlink_teardown(ds);
-out_mdiobus_unregister:
-	sja1105_mdiobus_unregister(ds);
 out_ptp_clock_unregister:
 	sja1105_ptp_clock_unregister(ds);
 out_flower_teardown:
@@ -3147,7 +3177,6 @@ static void sja1105_teardown(struct dsa_switch *ds)
 	rtnl_unlock();
 
 	sja1105_devlink_teardown(ds);
-	sja1105_mdiobus_unregister(ds);
 	sja1105_ptp_clock_unregister(ds);
 	sja1105_flower_teardown(ds);
 	sja1105_tas_teardown(ds);
@@ -3166,6 +3195,8 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.connect_tag_protocol	= sja1105_connect_tag_protocol,
 	.setup			= sja1105_setup,
 	.teardown		= sja1105_teardown,
+	.port_setup		= sja1105_port_setup,
+	.port_teardown		= sja1105_port_teardown,
 	.set_ageing_time	= sja1105_set_ageing_time,
 	.port_change_mtu	= sja1105_change_mtu,
 	.port_max_mtu		= sja1105_get_max_mtu,
@@ -3362,32 +3393,51 @@ static int sja1105_probe(struct spi_device *spi)
 		return rc;
 	}
 
+	rc = sja1105_fill_device_tree(ds);
+	if (rc) {
+		dev_err(ds->dev, "Failed to fill device tree: %pe\n",
+			ERR_PTR(rc));
+		return rc;
+	}
+
 	rc = sja1105_mfd_add_devices(ds);
 	if (rc) {
 		dev_err(ds->dev, "Failed to create child devices: %pe\n",
 			ERR_PTR(rc));
-		return rc;
+		goto restore_device_tree;
 	}
 
 	if (IS_ENABLED(CONFIG_NET_SCH_CBS)) {
 		priv->cbs = devm_kcalloc(dev, priv->info->num_cbs_shapers,
 					 sizeof(struct sja1105_cbs_entry),
 					 GFP_KERNEL);
-		if (!priv->cbs)
-			return -ENOMEM;
+		if (!priv->cbs) {
+			rc = -ENOMEM;
+			goto restore_device_tree;
+		}
 	}
 
-	return dsa_register_switch(priv->ds);
+	rc = dsa_register_switch(priv->ds);
+	if (rc)
+		goto restore_device_tree;
+
+	return 0;
+
+restore_device_tree:
+	sja1105_restore_device_tree(ds);
+	return rc;
 }
 
 static void sja1105_remove(struct spi_device *spi)
 {
 	struct sja1105_private *priv = spi_get_drvdata(spi);
+	struct dsa_switch *ds = priv->ds;
 
 	if (!priv)
 		return;
 
-	dsa_unregister_switch(priv->ds);
+	dsa_unregister_switch(ds);
+	sja1105_restore_device_tree(ds);
 }
 
 static void sja1105_shutdown(struct spi_device *spi)
diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
deleted file mode 100644
index d5577c702902..000000000000
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ /dev/null
@@ -1,233 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright 2021 NXP
- */
-#include <linux/pcs/pcs-xpcs.h>
-#include <linux/of_mdio.h>
-#include "sja1105.h"
-
-#define SJA1110_PCS_BANK_REG		SJA1110_SPI_ADDR(0x3fc)
-
-int sja1105_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg)
-{
-	struct sja1105_private *priv = bus->priv;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	addr = (mmd << 16) | reg;
-
-	if (mmd != MDIO_MMD_VEND1 && mmd != MDIO_MMD_VEND2)
-		return 0xffff;
-
-	if (mmd == MDIO_MMD_VEND2 && (reg & GENMASK(15, 0)) == MII_PHYSID1)
-		return NXP_SJA1105_XPCS_ID >> 16;
-	if (mmd == MDIO_MMD_VEND2 && (reg & GENMASK(15, 0)) == MII_PHYSID2)
-		return NXP_SJA1105_XPCS_ID & GENMASK(15, 0);
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, addr, &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-int sja1105_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd,
-			       int reg, u16 val)
-{
-	struct sja1105_private *priv = bus->priv;
-	u64 addr;
-	u32 tmp;
-
-	addr = (mmd << 16) | reg;
-	tmp = val;
-
-	if (mmd != MDIO_MMD_VEND1 && mmd != MDIO_MMD_VEND2)
-		return -EINVAL;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, addr, &tmp, NULL);
-}
-
-int sja1110_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg)
-{
-	struct sja1105_private *priv = bus->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	int offset, bank;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	if (regs->pcs_base[phy] == SJA1105_RSV_ADDR)
-		return -ENODEV;
-
-	addr = (mmd << 16) | reg;
-
-	if (mmd == MDIO_MMD_VEND2 && (reg & GENMASK(15, 0)) == MII_PHYSID1)
-		return NXP_SJA1110_XPCS_ID >> 16;
-	if (mmd == MDIO_MMD_VEND2 && (reg & GENMASK(15, 0)) == MII_PHYSID2)
-		return NXP_SJA1110_XPCS_ID & GENMASK(15, 0);
-
-	bank = addr >> 8;
-	offset = addr & GENMASK(7, 0);
-
-	/* This addressing scheme reserves register 0xff for the bank address
-	 * register, so that can never be addressed.
-	 */
-	if (WARN_ON(offset == 0xff))
-		return -ENODEV;
-
-	tmp = bank;
-
-	rc = sja1105_xfer_u32(priv, SPI_WRITE,
-			      regs->pcs_base[phy] + SJA1110_PCS_BANK_REG,
-			      &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, regs->pcs_base[phy] + offset,
-			      &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
-			       u16 val)
-{
-	struct sja1105_private *priv = bus->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	int offset, bank;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	if (regs->pcs_base[phy] == SJA1105_RSV_ADDR)
-		return -ENODEV;
-
-	addr = (mmd << 16) | reg;
-
-	bank = addr >> 8;
-	offset = addr & GENMASK(7, 0);
-
-	/* This addressing scheme reserves register 0xff for the bank address
-	 * register, so that can never be addressed.
-	 */
-	if (WARN_ON(offset == 0xff))
-		return -ENODEV;
-
-	tmp = bank;
-
-	rc = sja1105_xfer_u32(priv, SPI_WRITE,
-			      regs->pcs_base[phy] + SJA1110_PCS_BANK_REG,
-			      &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	tmp = val;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, regs->pcs_base[phy] + offset,
-				&tmp, NULL);
-}
-
-static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
-{
-	struct dsa_switch *ds = priv->ds;
-	struct mii_bus *bus;
-	int rc = 0;
-	int port;
-
-	if (!priv->info->pcs_mdio_read_c45 || !priv->info->pcs_mdio_write_c45)
-		return 0;
-
-	bus = mdiobus_alloc_size(0);
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "SJA1105 PCS MDIO bus";
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-pcs",
-		 dev_name(ds->dev));
-	bus->read_c45 = priv->info->pcs_mdio_read_c45;
-	bus->write_c45 = priv->info->pcs_mdio_write_c45;
-	bus->parent = ds->dev;
-	/* There is no PHY on this MDIO bus => mask out all PHY addresses
-	 * from auto probing.
-	 */
-	bus->phy_mask = ~0;
-	bus->priv = priv;
-
-	rc = mdiobus_register(bus);
-	if (rc) {
-		mdiobus_free(bus);
-		return rc;
-	}
-
-	for (port = 0; port < ds->num_ports; port++) {
-		struct phylink_pcs *pcs;
-
-		if (dsa_is_unused_port(ds, port))
-			continue;
-
-		if (priv->phy_mode[port] != PHY_INTERFACE_MODE_SGMII &&
-		    priv->phy_mode[port] != PHY_INTERFACE_MODE_2500BASEX)
-			continue;
-
-		pcs = xpcs_create_pcs_mdiodev(bus, port);
-		if (IS_ERR(pcs)) {
-			rc = PTR_ERR(pcs);
-			goto out_pcs_free;
-		}
-
-		priv->pcs[port] = pcs;
-	}
-
-	priv->mdio_pcs = bus;
-
-	return 0;
-
-out_pcs_free:
-	for (port = 0; port < ds->num_ports; port++) {
-		if (priv->pcs[port]) {
-			xpcs_destroy_pcs(priv->pcs[port]);
-			priv->pcs[port] = NULL;
-		}
-	}
-
-	mdiobus_unregister(bus);
-	mdiobus_free(bus);
-
-	return rc;
-}
-
-static void sja1105_mdiobus_pcs_unregister(struct sja1105_private *priv)
-{
-	struct dsa_switch *ds = priv->ds;
-	int port;
-
-	if (!priv->mdio_pcs)
-		return;
-
-	for (port = 0; port < ds->num_ports; port++) {
-		if (priv->pcs[port]) {
-			xpcs_destroy_pcs(priv->pcs[port]);
-			priv->pcs[port] = NULL;
-		}
-	}
-
-	mdiobus_unregister(priv->mdio_pcs);
-	mdiobus_free(priv->mdio_pcs);
-	priv->mdio_pcs = NULL;
-}
-
-int sja1105_mdiobus_register(struct dsa_switch *ds)
-{
-	struct sja1105_private *priv = ds->priv;
-
-	return sja1105_mdiobus_pcs_register(priv);
-}
-
-void sja1105_mdiobus_unregister(struct dsa_switch *ds)
-{
-	struct sja1105_private *priv = ds->priv;
-
-	sja1105_mdiobus_pcs_unregister(priv);
-}
diff --git a/drivers/net/dsa/sja1105/sja1105_mfd.c b/drivers/net/dsa/sja1105/sja1105_mfd.c
index 9e60cd3b5d01..7785e7d33c3d 100644
--- a/drivers/net/dsa/sja1105/sja1105_mfd.c
+++ b/drivers/net/dsa/sja1105/sja1105_mfd.c
@@ -7,12 +7,40 @@
 #include "sja1105.h"
 #include "sja1105_mfd.h"
 
+#define SJA1105_MAX_NUM_MDIOS	2
+#define SJA1105_MAX_NUM_PCS	4
+#define SJA1105_MAX_NUM_CELLS	(SJA1105_MAX_NUM_MDIOS + \
+				 SJA1105_MAX_NUM_PCS + \
+				 1) /* sentinel */
+
 static const struct resource sja1110_mdio_cbtx_res =
 	DEFINE_RES_REG_NAMED(0x709000, 0x1000, "mdio_cbtx");
 
 static const struct resource sja1110_mdio_cbt1_res =
 	DEFINE_RES_REG_NAMED(0x704000, 0x4000, "mdio_cbt1");
 
+static void sja1105_mfd_add_pcs_cells(struct sja1105_private *priv,
+				      struct device_node *regs_node,
+				      struct mfd_cell *cells,
+				      int *num_cells)
+{
+	for (int i = 0; i < priv->info->num_pcs_resources; i++) {
+		const struct sja1105_pcs_resource *pcs_res;
+
+		pcs_res = &priv->info->pcs_resources[i];
+
+		cells[(*num_cells)++] = (struct mfd_cell) {
+			.name = pcs_res->cell_name,
+			.of_compatible = pcs_res->compatible,
+			.of_reg = pcs_res->res.start,
+			.use_of_reg = true,
+			.resources = &pcs_res->res,
+			.num_resources = 1,
+			.parent_of_node = regs_node,
+		};
+	}
+}
+
 static void sja1105_mfd_add_mdio_cells(struct sja1105_private *priv,
 				       struct device_node *mdio_node,
 				       struct mfd_cell *cells,
@@ -50,12 +78,16 @@ static void sja1105_mfd_add_mdio_cells(struct sja1105_private *priv,
 int sja1105_mfd_add_devices(struct dsa_switch *ds)
 {
 	struct device_node *switch_node = dev_of_node(ds->dev);
+	struct mfd_cell cells[SJA1105_MAX_NUM_CELLS] = {};
+	struct device_node *regs_node, *mdio_node;
 	struct sja1105_private *priv = ds->priv;
-	struct device_node *mdio_node;
-	struct mfd_cell cells[2] = {};
 	int num_cells = 0;
 	int rc = 0;
 
+	regs_node = of_get_available_child_by_name(switch_node, "regs");
+	if (regs_node)
+		sja1105_mfd_add_pcs_cells(priv, regs_node, cells, &num_cells);
+
 	mdio_node = of_get_available_child_by_name(switch_node, "mdios");
 	if (mdio_node)
 		sja1105_mfd_add_mdio_cells(priv, mdio_node, cells, &num_cells);
@@ -64,6 +96,198 @@ int sja1105_mfd_add_devices(struct dsa_switch *ds)
 		rc = devm_mfd_add_devices(ds->dev, PLATFORM_DEVID_AUTO, cells,
 					  num_cells, NULL, 0, NULL);
 
+	of_node_put(regs_node);
 	of_node_put(mdio_node);
 	return rc;
 }
+
+static bool sja1105_child_node_exists(struct device_node *node,
+				      const char *name,
+				      const struct resource *res)
+{
+	struct device_node *child = of_get_child_by_name(node, name);
+	u32 reg[2];
+
+	for_each_child_of_node(node, child) {
+		if (!of_node_name_eq(child, name))
+			continue;
+
+		if (of_property_read_u32_array(child, "reg", reg, ARRAY_SIZE(reg)))
+			continue;
+
+		if (reg[0] == res->start && reg[1] == resource_size(res))
+			return true;
+	}
+
+	return false;
+}
+
+static int sja1105_create_pcs_nodes(struct sja1105_private *priv,
+				    struct device_node *regs_node)
+{
+	struct dsa_switch *ds = priv->ds;
+	struct device *dev = ds->dev;
+	struct device_node *pcs_node;
+	const u32 reg_io_width = 4;
+	char node_name[32];
+	u32 reg_props[2];
+	int rc;
+
+	for (int i = 0; i < priv->info->num_pcs_resources; i++) {
+		const struct sja1105_pcs_resource *pcs_res;
+
+		pcs_res = &priv->info->pcs_resources[i];
+
+		if (sja1105_child_node_exists(regs_node, "ethernet-pcs",
+					      &pcs_res->res))
+			continue;
+
+		snprintf(node_name, sizeof(node_name), "ethernet-pcs@%llx",
+			 pcs_res->res.start);
+
+		pcs_node = of_changeset_create_node(&priv->of_cs, regs_node,
+						    node_name);
+		if (!pcs_node) {
+			dev_err(dev, "Failed to create PCS node %s\n", node_name);
+			return -ENOMEM;
+		}
+
+		rc = of_changeset_add_prop_string(&priv->of_cs, pcs_node,
+						  "compatible",
+						  pcs_res->compatible);
+		if (rc) {
+			dev_err(dev, "Failed to add compatible property to %s: %pe\n",
+				node_name, ERR_PTR(rc));
+			return rc;
+		}
+
+		reg_props[0] = pcs_res->res.start;
+		reg_props[1] = resource_size(&pcs_res->res);
+		rc = of_changeset_add_prop_u32_array(&priv->of_cs, pcs_node,
+						     "reg", reg_props, 2);
+		if (rc) {
+			dev_err(dev, "Failed to add reg property to %s: %pe\n",
+				node_name, ERR_PTR(rc));
+			return rc;
+		}
+
+		rc = of_changeset_add_prop_string(&priv->of_cs, pcs_node,
+						  "reg-names",
+						  pcs_res->res.name);
+		if (rc) {
+			dev_err(dev, "Failed to add reg-names property to %s: %pe\n",
+				node_name, ERR_PTR(rc));
+			return rc;
+		}
+
+		rc = of_changeset_add_prop_u32_array(&priv->of_cs, pcs_node,
+						     "reg-io-width",
+						     &reg_io_width, 1);
+		if (rc) {
+			dev_err(dev, "Failed to add reg-io-width property to %s: %pe\n",
+				node_name, ERR_PTR(rc));
+			return rc;
+		}
+
+		dev_dbg(dev, "Created OF node %pOF\n", pcs_node);
+		priv->pcs_fwnode[pcs_res->port] = of_fwnode_handle(pcs_node);
+	}
+
+	return 0;
+}
+
+static struct device_node *sja1105_create_regs_node(struct sja1105_private *priv,
+						    struct device_node *switch_node)
+{
+	struct device *dev = priv->ds->dev;
+	struct device_node *regs_node;
+	const u32 addr_size_cells = 1;
+	int rc;
+
+	regs_node = of_changeset_create_node(&priv->of_cs, switch_node, "regs");
+	if (!regs_node) {
+		dev_err(dev, "Failed to create 'regs' device tree node\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rc = of_changeset_add_prop_u32_array(&priv->of_cs, regs_node,
+					     "#address-cells",
+					     &addr_size_cells, 1);
+	if (rc) {
+		dev_err(dev, "Failed to add #address-cells property: %pe\n",
+			ERR_PTR(rc));
+		return ERR_PTR(rc);
+	}
+
+	rc = of_changeset_add_prop_u32_array(&priv->of_cs, regs_node,
+					     "#size-cells",
+					     &addr_size_cells, 1);
+	if (rc) {
+		dev_err(dev, "Failed to add #size-cells property: %pe\n",
+			ERR_PTR(rc));
+		return ERR_PTR(rc);
+	}
+
+	return regs_node;
+}
+
+int sja1105_fill_device_tree(struct dsa_switch *ds)
+{
+	struct device_node *switch_node, *regs_node;
+	struct sja1105_private *priv = ds->priv;
+	bool regs_node_created = false;
+	struct device *dev = ds->dev;
+	int rc;
+
+	switch_node = dev_of_node(dev);
+	of_changeset_init(&priv->of_cs);
+
+	regs_node = of_get_child_by_name(switch_node, "regs");
+	if (!regs_node) {
+		regs_node = sja1105_create_regs_node(priv, switch_node);
+		if (IS_ERR(regs_node)) {
+			rc = PTR_ERR(regs_node);
+			goto out_destroy_changeset;
+		}
+
+		regs_node_created = true;
+		dev_dbg(dev, "Created OF node %pOF\n", regs_node);
+	}
+
+	rc = sja1105_create_pcs_nodes(priv, regs_node);
+	if (rc)
+		goto out_destroy_changeset;
+
+	rc = of_changeset_apply(&priv->of_cs);
+	if (rc) {
+		dev_err(dev, "Failed to apply device tree changeset: %pe\n",
+			ERR_PTR(rc));
+		goto out_destroy_changeset;
+	}
+
+	/* Don't destroy the changeset - we need it for reverting later */
+	goto out_put_regs_node;
+
+out_destroy_changeset:
+	of_changeset_destroy(&priv->of_cs);
+out_put_regs_node:
+	if (!regs_node_created)
+		of_node_put(regs_node);
+
+	return rc;
+}
+
+void sja1105_restore_device_tree(struct dsa_switch *ds)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct device *dev = ds->dev;
+	int rc;
+
+	rc = of_changeset_revert(&priv->of_cs);
+	if (rc) {
+		dev_err(dev, "Failed to revert device tree changeset: %pe\n",
+			ERR_PTR(rc));
+	}
+
+	of_changeset_destroy(&priv->of_cs);
+}
diff --git a/drivers/net/dsa/sja1105/sja1105_mfd.h b/drivers/net/dsa/sja1105/sja1105_mfd.h
index c33c8ff24e25..7195c3aa1437 100644
--- a/drivers/net/dsa/sja1105/sja1105_mfd.h
+++ b/drivers/net/dsa/sja1105/sja1105_mfd.h
@@ -5,5 +5,7 @@
 #define _SJA1105_MFD_H
 
 int sja1105_mfd_add_devices(struct dsa_switch *ds);
+int sja1105_fill_device_tree(struct dsa_switch *ds);
+void sja1105_restore_device_tree(struct dsa_switch *ds);
 
 #endif
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 087acded7827..8af3d01d0f5c 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -617,9 +617,28 @@ static const struct sja1105_regs sja1110_regs = {
 	.ptpclkrate = SJA1110_SPI_ADDR(0x74),
 	.ptpclkcorp = SJA1110_SPI_ADDR(0x80),
 	.ptpsyncts = SJA1110_SPI_ADDR(0x84),
-	.pcs_base = {SJA1105_RSV_ADDR, 0x1c1400, 0x1c1800, 0x1c1c00, 0x1c2000,
-		     SJA1105_RSV_ADDR, SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
-		     SJA1105_RSV_ADDR, SJA1105_RSV_ADDR, SJA1105_RSV_ADDR},
+};
+
+/* See port compatibility matrix in Documentation/networking/dsa/sja1105.rst */
+static const struct sja1105_pcs_resource sja1105rs_pcs_resources[] = {
+	{ DEFINE_RES_REG_NAMED(0x0, 0x800000, "direct"),
+	  SJA1105_SGMII_PORT, "sja1105-pcs", "nxp,sja1105-pcs"
+	},
+};
+
+static const struct sja1105_pcs_resource sja1110_pcs_resources[] = {
+	{ DEFINE_RES_REG_NAMED(0x705000, 0x1000, "indirect"),
+	  1, "sja1110-pcs", "nxp,sja1110-pcs"
+	},
+	{ DEFINE_RES_REG_NAMED(0x706000, 0x1000, "indirect"),
+	  2, "sja1110-pcs", "nxp,sja1110-pcs"
+	},
+	{ DEFINE_RES_REG_NAMED(0x707000, 0x1000, "indirect"),
+	  3, "sja1110-pcs", "nxp,sja1110-pcs"
+	},
+	{ DEFINE_RES_REG_NAMED(0x708000, 0x1000, "indirect"),
+	  4, "sja1110-pcs", "nxp,sja1110-pcs"
+	},
 };
 
 const struct sja1105_info sja1105e_info = {
@@ -771,8 +790,6 @@ const struct sja1105_info sja1105r_info = {
 	.ptp_cmd_packing	= sja1105pqrs_ptp_cmd_packing,
 	.rxtstamp		= sja1105_rxtstamp,
 	.clocking_setup		= sja1105_clocking_setup,
-	.pcs_mdio_read_c45	= sja1105_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1105_pcs_mdio_write_c45,
 	.regs			= &sja1105pqrs_regs,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
@@ -785,6 +802,8 @@ const struct sja1105_info sja1105r_info = {
 	.supports_rmii		= {true, true, true, true, true},
 	.supports_rgmii		= {true, true, true, true, true},
 	.supports_sgmii		= {false, false, false, false, true},
+	.pcs_resources		= sja1105rs_pcs_resources,
+	.num_pcs_resources	= ARRAY_SIZE(sja1105rs_pcs_resources),
 	.name			= "SJA1105R",
 };
 
@@ -808,8 +827,6 @@ const struct sja1105_info sja1105s_info = {
 	.ptp_cmd_packing	= sja1105pqrs_ptp_cmd_packing,
 	.rxtstamp		= sja1105_rxtstamp,
 	.clocking_setup		= sja1105_clocking_setup,
-	.pcs_mdio_read_c45	= sja1105_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1105_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 3,
@@ -821,6 +838,8 @@ const struct sja1105_info sja1105s_info = {
 	.supports_rmii		= {true, true, true, true, true},
 	.supports_rgmii		= {true, true, true, true, true},
 	.supports_sgmii		= {false, false, false, false, true},
+	.pcs_resources		= sja1105rs_pcs_resources,
+	.num_pcs_resources	= ARRAY_SIZE(sja1105rs_pcs_resources),
 	.name			= "SJA1105S",
 };
 
@@ -847,8 +866,6 @@ const struct sja1105_info sja1110a_info = {
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
 	.disable_microcontroller = sja1110_disable_microcontroller,
-	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 4,
@@ -872,6 +889,8 @@ const struct sja1105_info sja1110a_info = {
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_PHY_BASE_T1},
+	.pcs_resources		= sja1110_pcs_resources,
+	.num_pcs_resources	= ARRAY_SIZE(sja1110_pcs_resources),
 	.name			= "SJA1110A",
 };
 
@@ -898,8 +917,6 @@ const struct sja1105_info sja1110b_info = {
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
 	.disable_microcontroller = sja1110_disable_microcontroller,
-	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 4,
@@ -923,6 +940,8 @@ const struct sja1105_info sja1110b_info = {
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_NO_PHY},
+	.pcs_resources		= &sja1110_pcs_resources[2], /* ports 3 and 4 */
+	.num_pcs_resources	= ARRAY_SIZE(sja1110_pcs_resources) - 2,
 	.name			= "SJA1110B",
 };
 
@@ -949,8 +968,6 @@ const struct sja1105_info sja1110c_info = {
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
 	.disable_microcontroller = sja1110_disable_microcontroller,
-	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 4,
@@ -974,6 +991,8 @@ const struct sja1105_info sja1110c_info = {
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_NO_PHY, SJA1105_NO_PHY,
 				   SJA1105_NO_PHY},
+	.pcs_resources		= &sja1110_pcs_resources[3], /* port 4 */
+	.num_pcs_resources	= ARRAY_SIZE(sja1110_pcs_resources) - 3,
 	.name			= "SJA1110C",
 };
 
@@ -1000,8 +1019,6 @@ const struct sja1105_info sja1110d_info = {
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
 	.disable_microcontroller = sja1110_disable_microcontroller,
-	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 4,
@@ -1025,5 +1042,7 @@ const struct sja1105_info sja1110d_info = {
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_NO_PHY, SJA1105_NO_PHY,
 				   SJA1105_NO_PHY},
+	.pcs_resources		= sja1110_pcs_resources,
+	.num_pcs_resources	= ARRAY_SIZE(sja1110_pcs_resources),
 	.name			= "SJA1110D",
 };
-- 
2.34.1


