Return-Path: <netdev+bounces-170340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A86DA48474
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF62176F0B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C91B4140;
	Thu, 27 Feb 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h854CENr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4611B3952;
	Thu, 27 Feb 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672091; cv=fail; b=Et4urVHFgqSDX4n1m49q+NaNlaAWFYXdxYETYzPFGnI0hvKqwaQRrJL0FnLVuTDZFm+1Sy2AvOpnIgVZU4wMayJuiHsSiOAz4YNrsb8vSGWf/58o9u/cBnzYokYN1ZcWkCMzMGZrcgFx7F+VlQ0/wDb1lLFix5024C/yv8fHU+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672091; c=relaxed/simple;
	bh=pyIWCrKJ6mvO9xZbg896aimWnTlIWFXhcR6GnEWoVNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iXc/QSaESjoviUX9McTa0uC9rXUhAyOF7grXwuFQbsdmT7WYKt6bVsOvQmmh8Skt+yj4JM6VrTRu0w4LaSSQdUSfoAQj7aHJFTH9ygRO473G+KzouDzJ5GtIE6PwD85IRCys4MvHtLlX7JteU1wSj/Ug+dosqh+b50Xbj/MJ37s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=h854CENr; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHHIbJk85mGZ8I2dnCfzjQprO883BjJuROxua05sD+qHCIrfHOZ7wmzdFq31hP8iSWpBANmk8+Iy7/D32QnpfrR4+DBYubqKLAzsaRx264qeOA0e3hfoeRCvfD3QNQ02w5kQ+gXnfR3XPeYv38mnrXXzNFwYITGkyYTAzXkxZJJEYOzPUOFJZZ3wXSJssUaBx1mLJ262K8hu/xF/Yjbzs1ygEXjLS5ILtxjwVcaC0r4LwJ7s4xoBx2CnGjyecnKnnTK2xXo2gT9iRgxpZ8KMH3K+hCH0R/a6e55T9CcBIOgGRheZleyJCFkWSgt+LvG9wWd3Lsmx/3SX178ngeV85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qxURBpFjxq0DXD1aCXUxlnHxtzbNWVb0HgjT7V5ZpI=;
 b=jUlLrJNZnYaILeFjsbP0VpoC/RuQjTk+TTzb4vxgl/uTrslLHptx4h/PuvNR0+reFFlpdHGc2Hf5qgfX1PSfSxeCQgUAW5h9bIr+DYoD40YbLvWFiRhZB02sZCyn0DKsRHWZrEw4PTKVbl4YqmN9nKIvCA2A14pShE69R7jiHRXE/d/M4N7vi6oK2/h70Le/A2/oJdg/TAkUfL5t3Fetm8/EnFOv0SgHtzeEAM8k9sz4OST4ZhQ+tJCJLGJeEtzZuwsFf1fLnufqqZx5+blfLfCdcyerdpH+IGrV7peGq/cokqF8meyp97TXuWUyRQb/m7Wlwdenf1RXDre9rFUnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qxURBpFjxq0DXD1aCXUxlnHxtzbNWVb0HgjT7V5ZpI=;
 b=h854CENrQQbKZ1Kbhndglu4CFEntrb2/9OS+rC8WpqcCYyyn4vKisCOiqHG0nQ4FaR87M/SQSPiZEV2eLTBXtgAGWfZxhGiPTbxtlgbJdUM3hC55Wo948W8j54pN7pObSCQftebCqj72259YU7M2BA1o+5JFia+yaaj9+oO9Kes1IlpYbVWNATYVdY6X9QqfNY/+dwD5nZfmJuNIPAKRrw6dZjfaiuGJXJgwdt70xyvOBMb4QV4DWC8rJwplrrnQe1o3+CN6LGDbwHfz5A1rOeqMzdkRygHEJSElRcaF/zocZXaZV7th1fSvW44A9+fGiOrWwjfbhDrECs9wKTKXsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by AS4PR04MB9266.eurprd04.prod.outlook.com (2603:10a6:20b:4e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Thu, 27 Feb
 2025 16:01:26 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:01:26 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 1/3] net: phy: nxp-c45-tja11xx: add support for TJA1121
Date: Thu, 27 Feb 2025 18:00:54 +0200
Message-ID: <20250227160057.2385803-2-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
References: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::13) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|AS4PR04MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: b7195286-e2c6-459f-30b6-08dd5747fd35
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0MxUFJsSE1MaEhObkVpL3U4M1pjNE43TGxCN3puc3gxbmVzYk5Ucllzamcr?=
 =?utf-8?B?Ykttd3JsT1YzNUVjVjd3QUx0MVRrNUhTZTRmblRXcVhOSDdteGo1dFRpYVR5?=
 =?utf-8?B?VTFobjEyQUk2WVZuMFpwVHdGUjkydTRYN0EyaDAvT0p1N3FjTUwyM1pRSFp6?=
 =?utf-8?B?K3pJMU5rWXozUFh2dXRlU051VVFqdGJScTNYbnZ0U1NicFlIRHgzRFVHN2E4?=
 =?utf-8?B?dmFMSkF4U1lhajJEcEt2UFB2cnZxRWNXY1QzcjU4TTlyb1VIRWlzcitwbXpM?=
 =?utf-8?B?c2kvVjY4RkcyUkk1KzVQaU01dGV0UGxzUG40WjUxYlFsWkdnend5ZzBueVR4?=
 =?utf-8?B?RHA5VjdyZGdtcloyY1BFTm0vYVVmc1BxWmV1akJGSW93dXM2bUp5TlB5UUZy?=
 =?utf-8?B?N3pnK0lORmpKZVBKTUV0akJ2VUgxU1dydnFjWU1ycGNLOEEyczlObmtYcXhI?=
 =?utf-8?B?c0FFT2VDVHBxdHNtZzFRd29KUHhkZThBam5yTndoMVdJVk5jVXJaSVFYanhM?=
 =?utf-8?B?MmxZb3J0SEEzQXQ4cFBtWHBCbnIrVE05cStYejE2R3JlL2k0WnBnaytKRHVK?=
 =?utf-8?B?bUZlQUVPR1RzMjBOSDNqamhlL1hzWU1RNjd2MmFSNE9HbGtFQlY1QjBzUXRh?=
 =?utf-8?B?WFA2MWt1WmN6SkJYcTJFaWJLMDVwdWJZdVJzd0dXQTJGd1RjUlU5OUIrSHBS?=
 =?utf-8?B?R25qMFFoU2JoclZoYW94NnhMMkhKcHZoc0U5OERCc2UwU3MzMEJkM1ljVTRK?=
 =?utf-8?B?SDRLcU44Z3hCWCt5T2xhbkorZXQzc3AvalkyZDhlZ3M1bnFRbFo0VjFJaEI4?=
 =?utf-8?B?OGZON3FPbFE3RTVMVnpZQ2pDNCtsclFOTEZsZUt0N2hKcDdKL2dDd2lKRE9R?=
 =?utf-8?B?dVVBYVNTQW9WOEkyMDJPWkxVV1BBUVRwSkUwajErSUM5c3BBb245QkRDR2Ft?=
 =?utf-8?B?SlEvQUJmdWpOV3pmOU1hUWw5YjhGRDdJdkVVZUh1d1JpeFI0Nkw5a29rd0ZX?=
 =?utf-8?B?MVRqM1JCVFI2Kzl1MEVtOGZEc0FjL05hOFh2SkVlaXdlQmJSL2xQSThWL1pH?=
 =?utf-8?B?eElXWFdoUE15MlMwRTRDQkZvR21jRHJBL25LMnk1OStBQ3dJVS9EbnZ3ZG5V?=
 =?utf-8?B?UkxHSktUUnBINUhQR09XMkovUmRMdUoveWFoUzhoRCtVNmVjdW5PbkErNnUw?=
 =?utf-8?B?UHdFRlV1cUJRenE2b084NkdTRXJjRjFWeDZEdUdjL0ZCVXJPeFRmWG5QRGlI?=
 =?utf-8?B?bE5xM3ZlR2NqYlJGSGhIQnc5OElmMzZ5a0lqVWJvZmJQc3k0TnVqTHVMcDRu?=
 =?utf-8?B?VE52ZDBCK1VEVmhQOUVFemtsVDhWWDFMMTNwMWVVYTI3ZDJYS0F6MjVqQXow?=
 =?utf-8?B?a29QMFQzOW1RNUIvdVFOQjFheGR0dEZiM0V0TGxMbjIvL0hhWjc0N2pReFAr?=
 =?utf-8?B?WVV3aXhNV0JIZ3pSbzlBQTRTelBOZThySW0rQnpldllJdTVSeEEwM01LMTJT?=
 =?utf-8?B?NTZVTnhBZDVMdlYrdkRYTWU3RFF2UkIrSlpqWGQ0WDhESnhuL1NINCtISGp1?=
 =?utf-8?B?V3IrMDlXdldsY1pYa2d1S3V2TVUveGtodEZndmVGaHk1YjI2ZjVPQTdwMWFa?=
 =?utf-8?B?Q0NlMUZTL1lPTW9QMWRnYU9tVTdmaXBDK1FtTmNDbExZa0poSWd5Q1BTZmpo?=
 =?utf-8?B?cWs3VVRnb0FQU0FzeUp4VG9LeG5CbUh3NGdyRFhxR1o5Unhlb0xIclh4SUVH?=
 =?utf-8?B?ZWgyd05sMkUwUlFES2VVQmlmbThOTGJXaGpzU1FuSVN5MENCZlFuNjdUS2Uv?=
 =?utf-8?B?cWtwWTV4OElNWmpJQ05mcDhpK1E1NWFZMVdBb0VDWmN5YzZUYnRPNVBmZk1z?=
 =?utf-8?Q?Q0exMH+1WUSxE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amp2eTN5ZmhVbzBhb05ETTZyY2l0S2JEbVhHZXhId1dIT1Q5UXU0MzNNbW5N?=
 =?utf-8?B?d055d09HK3F3Nzl3OVU2RDl2dktTS3pvbTdOSHZYelpUd2l4ak9GRDZWazBn?=
 =?utf-8?B?WjEyWlI1NXFGUFFGYW1vRFl1THJCYjJPbktzajNEalA4MkFrNytXWEw4SXR2?=
 =?utf-8?B?eXZZcnJtVlJHQmdYUFZsbzAxV3hoN3kvdnBaVlJYZUVKT3VHWjZ2VU9zUlpq?=
 =?utf-8?B?N2lZOFBHbGR2aVNPbi9IVVNCYTJ0U2VybFRidlhrZFB0Z1cxcE1aRDJSb0ox?=
 =?utf-8?B?OFdQcDBtZ3JGWkIzOGFvNEs4TElFUW8vbDlmNFpIbVlnVzR3d25xQ0pOVHFD?=
 =?utf-8?B?RHViWHVWdXVDUnhYdmN4NlEzUEpFQ0xvY0U3WkF2T05ROUp1aStSbDQ4Mm9L?=
 =?utf-8?B?UUtTU3dlcFpiclVIMGd5RkcwcEd5ZWN4bEdlNDJ5SVRoR3Q4c3d5aGVqTS9x?=
 =?utf-8?B?cnZWUS92dkRMSlFvWW5jOTFpSnRZMFFRcW5TSkl5WU1rK3BkaUpXTEl2bGx3?=
 =?utf-8?B?akg2MnFzeUpGUjlNRTF3TURvcW9lS2w5dFpSSk5ObFExV1E5OGlzTTZBMmtD?=
 =?utf-8?B?UHFWcldpcWYyN1Nuc2xqNzhWYVBpaVVMTjVIOWN4Z2Y4UWc0SkZSUmxEOUNw?=
 =?utf-8?B?ckFDMWJKYVRPc2pnMFJDTFp3M1g0cStTenlvVkJkM0dTZmwyUVpPazNzYjFs?=
 =?utf-8?B?aUhGakdQOWdhU0ovTTlGTHl1WXYvV2pDWjlqRTh0MUprS0R6N3NxVStYV2o0?=
 =?utf-8?B?aXBHODhLd1FTdzd5ZG5yeUoxT0NIMURhanlJaldqOWtDUmN3SXQ2NE5rY1k2?=
 =?utf-8?B?dmpYbFp1RTVQd2NHTTZMempFcDA0NkF6TFBnRWlrTnQyS3dZTHU4eFFwNDB4?=
 =?utf-8?B?aTJMQ2hBa2tWaDNJa2J0UDZVTWdTd2h3WkNuQVVsckxaSTd2a0licXRodXV3?=
 =?utf-8?B?VjFnT0w2cC9rWEd5b0w2K2RVMlVZUitVYzN6MTBYR1NuNWNFMnhFNm05eUdQ?=
 =?utf-8?B?RUk1QVFONVFzY1JVYVZjOUxLR2wwMFYyRFpjdkVIdGJsYlNDZUd5UzRDNnVt?=
 =?utf-8?B?NXlIcmFHelJJdFNoY3B5Q1MxNDRCOWlpUEh3UGZhRXNNUlZxM05wZW02WXhJ?=
 =?utf-8?B?ZXNLTWZjSVduZGVBaXowdzVqTUpyclV1Y3FMMGZlUzFaREpZYVUyVW8xM2s4?=
 =?utf-8?B?OWVCdDdNcTcwb1AyMGp5L0x0blFMbkRZNjVrU21lR1VsR1FEZ1lSdkZLdjhV?=
 =?utf-8?B?YStTaWZqUE9wU2Z0c3FIZzRvSDBLTFRaU21uZWZtdUJHVmhQck9tS2tGRVRx?=
 =?utf-8?B?L25uSC94YjdBTXRHdmJFVXV5OCswUUY0Rk1NcGl2bXNYeXQvM3kzeXVZRU5v?=
 =?utf-8?B?VTJtSWJkeXA1akFKT3ZlWG92eWZXdTJFVHRYbjdVdkVpTGFldFFBUm44SHJz?=
 =?utf-8?B?WVdhZjU4N3NJMHA2c08rY2ptT0JreWNBY3dISnVHcGJtOFVxMnorWk1PSFZ6?=
 =?utf-8?B?Tm0xMjN3aGZBSkNBRzMzUzExZGhHY1hhVk4wMDNoMUpBWXROUmdVWCsvTytl?=
 =?utf-8?B?ekRqZEdteWY1bkE3elhVQmlwNS9jTWVwMElETXJzZW5IVUlLMlZJZjlTSG5W?=
 =?utf-8?B?ZmdnM3RiK09vbDNFbGRuNzRhRTRxaithT3p5Qk9SYU12VE9BYk9UZkUvMWEr?=
 =?utf-8?B?Y0F5dTB1MHp6UXEvVW1vbjVON0VMaFFjZ00zODhpNjlrcmlTMWNzRWkxdkFO?=
 =?utf-8?B?T0M5YVBJb1gxM0NRbW9rL1NqWE03TlY0aFo5dG5XR2pOSnNvdDZKd01NUEZT?=
 =?utf-8?B?ZlhFVTAzTy9qakpKYjdSNlM1ZDE4MnFhSnpPQ0o4cmR4VWhIVTJYL2NkaWZW?=
 =?utf-8?B?TjhSUXRPanB1dXMyQXRabk9FTC9zNkVxUVc1ckVLdUhvVW1UVzY4ZVZhSWpl?=
 =?utf-8?B?clg1LzZiTDZlYTViZER2LzU1dStKM1VNTFlEWC9LVi9MZnYyK3B1TXYyTGxE?=
 =?utf-8?B?OTFQQVkwRjhFTHVvWVNVbFFscERsdWdsVVdHSzBqeE9waFU5cjZxNjgzanJy?=
 =?utf-8?B?YUV2ZXhVUDZ4K0FtQ1VkNHdGN1pVM3NDN044RGcxZmxUaDAvd2VQdzg5OWFM?=
 =?utf-8?Q?2jzUUeKBBC0O/hRo1Gu35TMxr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7195286-e2c6-459f-30b6-08dd5747fd35
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:01:26.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJu3mkxzd0hykfMbPXLc3D5uy2gtMQCCBjeYWnWQc5ph19HpC9HZZRmrXExqopzy74CpEnwAgnHMqOsyP+O4ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9266

Add naming for TJA1121 since TJA1121 is based on TJA1120 but with
additional MACsec IP.
Same applies for TJA1103 which shares the same hardware as TJA1104 with
the latter having MACsec IP enabled.

Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/Kconfig           | 2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 41c15a2c2037..d29f9f7fd2e1 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -328,7 +328,7 @@ config NXP_C45_TJA11XX_PHY
 	depends on MACSEC || !MACSEC
 	help
 	  Enable support for NXP C45 TJA11XX PHYs.
-	  Currently supports the TJA1103, TJA1104 and TJA1120 PHYs.
+	  Currently supports the TJA1103, TJA1104, TJA1120 and TJA1121 PHYs.
 
 config NXP_TJA11XX_PHY
 	tristate "NXP TJA11xx PHYs support"
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 34231b5b9175..244b5889e805 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* NXP C45 PHY driver
- * Copyright 2021-2023 NXP
+ * Copyright 2021-2025 NXP
  * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
  */
 
@@ -19,7 +19,9 @@
 
 #include "nxp-c45-tja11xx.h"
 
+/* Same id: TJA1103, TJA1104 */
 #define PHY_ID_TJA_1103			0x001BB010
+/* Same id: TJA1120, TJA1121 */
 #define PHY_ID_TJA_1120			0x001BB031
 
 #define VEND1_DEVICE_CONTROL		0x0040
@@ -1959,7 +1961,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
-		.name			= "NXP C45 TJA1103",
+		.name			= "NXP C45 TJA1103 or TJA1104",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
 		.probe			= nxp_c45_probe,
@@ -1983,7 +1985,7 @@ static struct phy_driver nxp_c45_driver[] = {
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
-		.name			= "NXP C45 TJA1120",
+		.name			= "NXP C45 TJA1120 or TJA1121",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1120_phy_data,
 		.probe			= nxp_c45_probe,
-- 
2.48.1


