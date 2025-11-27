Return-Path: <netdev+bounces-242264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094DBC8E339
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08AA3B1CC5
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DEA32ED2D;
	Thu, 27 Nov 2025 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YpxFJQzB"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399332E75E
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245383; cv=fail; b=VBzW1ecfshPCs6hdh3I2okruXGTXGjo48JyixmtlpMolLXrMjgWrt55NzSZGezjOSG9s+MJMKjKAuhsrc90y7LLuXV2F0bbY2zJ88nM0WtYZnx2wMZaRt7zC7aU+EzJxmmfSUIe+dIl++veY7wFn6rtnO5poAI8w0DN9ezJhCcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245383; c=relaxed/simple;
	bh=CQWU3PfyrYeVaTqPnN2DkIgejFYV00njLe9uwALs3n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihIs8eA3+3p5fxSwD2RmzgpYrkquJ2eXqGv/o5CyEcuDQkYNMa//6bnZIlMn6ij4UCqgLqWRzYqHvEXToG9DYTfzUyR4wT1yHUc+pG0VSvTsHPUERzSWxk09bFM0EskZ76hXWtiDRprC59x9h4xiKqMOd/bOVQiv+10yi9gnAAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YpxFJQzB; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dd3vhHrJZnykCFM7K/NJd/a9aovIetoLSEnRHPlJIpNjVf9JRvv+RCtlEAmVb9TxULMfqHfMvLMABRxCR1NJPJdAnqUKarlyecmvlD9SCFFpLP4xm8AwHYfiTLjZMYvAT7pIklnvccdF4RRjUI4VPDUxRy4tvVRNulFISvo0oVY7Bc5kF11wbJwcPArawMImmgWK4s/BiWgGHPO4Sn2hg3GsLeQAXv/Uhnr8kJqaQsWXv1qZsEw0QZ7WjBM+t11Dec85cEmn5/VdqeEr2fsOASGMebbcrtlrbnPYMm8YT/mHhaPI8K7OhyIGHPiN8aM6hAgHyIazbaQi6RHKhfrJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6qS3bsn8hBkYksO3HNv2snwnduBtLfVX6gOAbq9IIc=;
 b=OOUflhY9697HLFC/CWPWHxBovU97U8rR5VeEPjz0ZdZPjQPzTT226ztrSu8TOnz8xQcq+AcWVp/leBhGFhbzrEeT9yXG/lX1K2i35L7aY30tcMxTHg2SHZTv1zrCXA4XvVV8pi5rna2zN682D5Q8R72irI51HIUsx4JI6pQtrInrJbQT33DvYWCbKz/irRw8f8r+t2CPzgT7tTC1YgcZ/UCeLmCLVQGLiBm+nmJOg6nlXRqCcbCuci3Fhglx4H//ny7HVYIYpX6FEJ/7uSbd9yrmoek5qLSn75jUQJrUd+ZhDxpRaL618VdhEZRIYxShHa7/yOliRYOo+b1dFNZ7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6qS3bsn8hBkYksO3HNv2snwnduBtLfVX6gOAbq9IIc=;
 b=YpxFJQzBnBO0/aiLcJYDKIwgneT3kX5qoKXGVThKQkTNoKhE6M+35FWg/kmNMSlN5sDxxN/nCB/m/fTAp19l5Logv2p670rH5OXzqHRfXnqU4oC6B6fURnEfZvyq/CRu/O8GWAdwoZ+3hXI9WwMvin6ol/Y0LfaHgHMST6qu/mlTHmMooGWx7xZ5l73vn4/hOthlzDKLkCdlbu1PyU0dK0Gqyho/08cVNi7XAHDtaFP5bgPXU6MDoaQIcE+GR/HkcLEgDCR4+TZzsuYIiN7S/VDec56N47jzpcdWQTQNlR61JPYwMQixUizub94D/XrE1RZ2XT7KwkeOKOLqcTDIUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH net-next 10/15] net: dsa: tag_rtl4_a: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:57 +0200
Message-ID: <20251127120902.292555-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9e6ad7-b8fb-4edd-7a80-08de2dadd0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEkvN2dKbGIvODBBOHc3TzdCOVNLOVg2K05PV1NTaE1wT25XblNjQStFTVRw?=
 =?utf-8?B?QSs1YVVhaURBVmZsTkZ1MU8wcmxiZ0tRTjBvc08wdFlPZlVmUjlkNGkwYVRl?=
 =?utf-8?B?cElzMFpmVHRmNGczL3JEOGlMLzhMWWU5NjJuWG5tczNNWC9pQkNJcVlXaXF3?=
 =?utf-8?B?TWo0OXZnQm5pd1VvR2k1UW9YNktEOFdVNUJrcWF4V1ZrbGNFbUNEYWQrclNv?=
 =?utf-8?B?MjA3dkttQVVZM2dEY1ovSjJQbVZ1blpUaVlTVGxDN05oYkFDTmc2c1B1YVlT?=
 =?utf-8?B?YWxqOFpLTTMyUndyc1NYbzZDVUJ2L1MvdERFemd3eVNudW50bFN3WjNuOGk4?=
 =?utf-8?B?T200S2JhdHJSd1E5VElLM3JrTHc3RHZXSjJhRVNmb3djWkVGaXR0NFZWYjJm?=
 =?utf-8?B?RllSRnNaVDhzb2g5dnBKazlGRjduZzJ2REtWVTd3NlVXVDNka3R0a1RYVlQy?=
 =?utf-8?B?QmdTQ0YrODhjTTRNYnVXd0JtK2FFUmQwVTcrbFcwR0tTZ0FYQnNXc3YrcW9F?=
 =?utf-8?B?T0pBOEZCenVPWGlERnJXUHpQMUpWcVV3dnFaZFlkT0w4VVl2L2NhQkkzWW5E?=
 =?utf-8?B?TEF3VFIwREJwaS9IWTVMUERsRzhHOElMU2REaUU5T2xBL1pJL1dnYUhxdHRE?=
 =?utf-8?B?TmdPdG1yWlpQOUlmdWhGaTJzMjZhcDM0d3hXR2wwVEpLY2duc0dXWTB1Tklz?=
 =?utf-8?B?VCtJZmh2MjkyM0FwOVlrU2lodlNQcjlkYzVadnVxQ21KRE9OdVpGeUFwR0pI?=
 =?utf-8?B?R0ZmQkNBQk5GZXlCVlc1eWkrM2xsNzNzS3MxaCtvSUFacThxVUpiZ3Qzd2U0?=
 =?utf-8?B?WW5WdEo4M0wrdDRLeHVaWUhsMFdna2JrTFFRMlliWU9CN0p6amU3Yjlsb09N?=
 =?utf-8?B?TVFmVUJUeFpyaGIwMEgwYWk1NVYyZlpwU1lMZjZkQnh4d1ppa21hZ1htTndi?=
 =?utf-8?B?bWdJcFVHNzNCRHBHS1hoQUNYd1ZzWlhCV3NsNG5vYUFwZDN1OEdIcFNEK2lt?=
 =?utf-8?B?by96UWN1K0NVWkdOMmdCa054eFhXaXRTYlpKR3g1UGVIR0NLM2l6U05QY1BO?=
 =?utf-8?B?S0I2UEFGbG9rMmZyczNyWU5vMDFVNUwrdFpKQU93WnZBeERncURHL0ZaREEr?=
 =?utf-8?B?cElKOUFBeVlQMUFTYWZjSjFRSDA3Umh1OHdCNFBtak9WVGhqbGhxZFBGTlND?=
 =?utf-8?B?QWhXTU9IRzloeUphWVErRFNjZ0VQdytuTm82SkI2VWFGT0Z1OWVxQUw2T0V1?=
 =?utf-8?B?d1J2T0NzUTlXaFRwTWV5emIrNXlEUXgwVlRYY3V1UEV5K0w1Sk50NUZFZnZI?=
 =?utf-8?B?akFLVCtDSHZudFJKNVB4SUgvZjhjSGhsc0dPb3YzTFROM3FNWnVGa1dFT3RP?=
 =?utf-8?B?cUVHNEE2ZTZrUE5raDFEdXhnQkNITDFPSXU5Wm5lZE4vZEI2b1NaVTNDMG5W?=
 =?utf-8?B?ZTR6c1FzWXFnUWQ4K0V1eEVqYVpZTlBXOWllanFPNGJrdlk0QWpjTWNRQ0pW?=
 =?utf-8?B?TlhJU0g0ZVg2OUJWaUw1VTc3WUNCa3ptczhKRG5jOTdZZm5KcThLTTJwaEpB?=
 =?utf-8?B?N0s0Ui8xK0dYNVU3OTlhaVFpcENOK2RhY3F5bmkxNWowVkowNHlHbXVRaE5T?=
 =?utf-8?B?YW90REZHTzBkMXhmc211Q2RqL1BiV1kwb043SDJQaDd3WmNNNDc5N0swbU9h?=
 =?utf-8?B?OUw3VFFJcHlBUGlNSEJ5Qm5VaTNKV2NHOTZNcFZqK1Z0K1VQTi92WXhSREVm?=
 =?utf-8?B?UWljcmIyajN4eWdDTmh5NytKKzFVekRVRjZCZFFmR25CMDVNUUtlMnlWd1FN?=
 =?utf-8?B?aGovU3ZWMUJKRXZoSGNEbXRZYkFRcW1QZENlbVpiUURBTXorYUl2NE9vSGQr?=
 =?utf-8?B?UWMyckcwUnc4djRxTUJFb1BsYVZOTzI5bXJYUThNZ1RjK1p0R3lTS2pid2xp?=
 =?utf-8?Q?4n454K0yGtOY9xCfFm8OPkm8/ZdWGyGA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUNPeWFYNjJQYitBZ0ZFenc2S1RmWEZHM0lRdTlnUW83MW85TWN3S1BPc0Nk?=
 =?utf-8?B?ZW1NV1grYWlNdElwL1dMbjdRUVhweDVrRHIxM0xKK0VxaXV0UWxVSkFWZGND?=
 =?utf-8?B?dTdlUThKQWVCM0VkZVpWWTllRExSanJsdnRtZUdoM1dzeDdrMWp2RkpnRFFO?=
 =?utf-8?B?YmpTcytRZFVIQ3N1MldYS0c5cHJHUldKV3lYYlN6N2JYbU9LdHpzc0JPMWJK?=
 =?utf-8?B?NkVqdXBaVTFtUVJEV0xJaFJJanp6ejRUM3pHb3VQNnFiK01uV2w1b1BOTmxy?=
 =?utf-8?B?SUJiTEQydGs0VTM0UmloQUMxRkJPRFR6OERRMFZVZ1BXd2FWNU1qdi9Ra0wx?=
 =?utf-8?B?WUZ1MlJsVzgrT2R3dFkwV0RaQWdkK1F5Um5qdDVUa2VDWFV6R3VwSnpiL3dr?=
 =?utf-8?B?OVh5Q011QUFvKzhlWUlZaUJVcjRQT1l2UkFod1VlMmQ0YXkyNTNXeXFFcTlC?=
 =?utf-8?B?ODBRSDJYdXZVNXdXYWhocW4yQ1grR0RFY0d3aTU3a2lQeVNBdjhlTEZZUHM2?=
 =?utf-8?B?SCs2TVhESFZDUS9aemRIUko1OW5mRFA3aXRzeVc5WXlyRkNONGdYNkNwMkV0?=
 =?utf-8?B?TjFWY2NaQUFoaWNzdUJ1NDA5c29SWGZUbWwwcDlYMENsYTVmMG5RdnJQVXZS?=
 =?utf-8?B?RXJZTmFGVngvR3kyUXNjVjZvZktCRUl4VGlLNWMzUzA4NUNXYWFkcW1ma1Rl?=
 =?utf-8?B?UFJtMjhZL0lSZjF5ZTduYjlUcU1oMlNrSEEvUlRCYVlFazRIeGFkSDhBRkhl?=
 =?utf-8?B?MjdaU05YS0hWQ0ZxM0JXU1RwT3JXNVNRdUZCd1JmWC9Nam5IcDh1eW4rQi9P?=
 =?utf-8?B?S2VWRHJuT3JURlh5Z2M2THBvSTZObjRNeWphUWgyVUdrR2NmNVBaS1F4UVVy?=
 =?utf-8?B?MXhpZ3Z1bW42QkREODdaRHU0dWtFMmh1eU8wR1FQVmVrM0pXRlpxbWJXMW01?=
 =?utf-8?B?a2l3eUFEeUkxRHpMdGhURVEwUHhJU0hrY3RCZ2NlVmt5SkkrMjlDTmZZZzVN?=
 =?utf-8?B?bWhuN2E3Z2tRNnF1ZHdIOE1LWndkMklwR0srRERoakVHU1RUdlJIU1hUWTdJ?=
 =?utf-8?B?WWF6bklTVUo2a1U3V3RPSnN3TDlycjhDeVhtZzB1UjlOdkNrRmVkNlBVWjJw?=
 =?utf-8?B?dGNRYzNkUHRvUFBpRzM3QytETlhFRm9Ld2NzTUNBNS9ER092UXhRemlKRXpK?=
 =?utf-8?B?WFVVMmlGM01aTEM2WVc4amVxRVVqekJreUFLeVV1b3RySWY4Z01ocW92SWkz?=
 =?utf-8?B?UXUxaFpRdTlOUFhURCtCWEJmYlozOVNTVFo3S2s0MEhlblFDTStnUEFxb21F?=
 =?utf-8?B?YmFQKzBpcXZOSVB2VDdyam5Fb0lQUzRNeFQ2amtSZTNwSVYvUnZ5Rld5eDNH?=
 =?utf-8?B?ZWJmRXVkZkhRSHJ6QUdLVVBNWjlrYnYvaDdhMXpTa0grRHlQTTJnaitINCtP?=
 =?utf-8?B?Vys4bG1yYUwvRy9md05sY1l4OUpqNVEzREVnbVJQVlhsaE15NmU5WXRYZVBG?=
 =?utf-8?B?MUxGRmUyU2N0cEx3SFhTYklGd29NRlptblpoTEpxczQxdW9LbFpmZW5WYWpC?=
 =?utf-8?B?azJib2VFbVJGNFNwK0dLYitVYzZ2YnhWV3QxMUlHSk9jSGl1elV0WHRPbjZa?=
 =?utf-8?B?YmI1dCs4aXMzN0N3QytJb0NyQXpTK016b2NMaTBEdzZ4ZUVjUmNscmJqVU42?=
 =?utf-8?B?ME1RQ250L0x4RVEzb2tkWXdDaDMrZFN3RG9FWUJKeVNhdmEzWENscU9sYk1q?=
 =?utf-8?B?aW5pTUIwVytyK0ZiOUdubHpKNndCWlFray9GeVpQcThoY2JpUmRWYmVoUW1J?=
 =?utf-8?B?a2kySEE0TjNxUXR4UlhaV2wzMlhhajlVK3laU1NIdm9iS1p1QW5EemF3azMz?=
 =?utf-8?B?V0xmdzNLV2V0NWYyQkRHOFYwUkR2VEJlaUdRQ05Ib3RoblFsY0VuaDUrbEFn?=
 =?utf-8?B?UXZSWkQvNWpGNkZ1LzllODNiOVd6b01wNGFpM3U0c2djaUN2QlNQZXJpZlNK?=
 =?utf-8?B?U1I5L1B3Tzl3bzdhUjFycGVFK2YxamhtdUo2K0NST01BV1MxVUt2R0ZNU1V3?=
 =?utf-8?B?dnZpaWdXZmFodnJRT0QrUmFjUmZraHpCTDVwQnBWbHVwMEd3V2d2bWwrdWhi?=
 =?utf-8?B?YlRLVkxuQmxDcjVqemIzaTltektaRm81OHZqeEZHMmc0K2R3a1Y0ZGhheC85?=
 =?utf-8?B?c0F4RVF2T1NuZDgxb25QS0ZoOGZneWJ3Sm40RUtDTnp0N2ZlTFBXY2U3c2Yr?=
 =?utf-8?B?Q2RHbDZ5aXFTRnIzL2Rob2JDd1ZRPT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9e6ad7-b8fb-4edd-7a80-08de2dadd0c5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:29.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+lWWjUd7PDTY1JERqS8GZB4u2cb96g0PDLhRBY+ADtnba/pzTrCqreNNPpPw0OcLFhKdNmwIMXU8QnZraCUZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "rtl4a" tagging protocol populates a bit mask for the TX ports,
so we can use dsa_xmit_port_mask() to centralize the decision of how to
set that field.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "Alvin Šipraga" <alsi@bang-olufsen.dk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_rtl4_a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index feaefa0e179b..3cc63eacfa03 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -57,7 +57,7 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 
 	out = (RTL4_A_PROTOCOL_RTL8366RB << RTL4_A_PROTOCOL_SHIFT);
 	/* The lower bits indicate the port number */
-	out |= BIT(dp->index);
+	out |= dsa_xmit_port_mask(skb, dev);
 
 	p = (__be16 *)(tag + 2);
 	*p = htons(out);
-- 
2.43.0


