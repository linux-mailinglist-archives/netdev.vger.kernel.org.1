Return-Path: <netdev+bounces-209816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62AB10F90
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957081885B16
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB02EACEF;
	Thu, 24 Jul 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="G2TgRBHY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A912D6611;
	Thu, 24 Jul 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373925; cv=fail; b=F3U4ib0sVTr6EUFbbtcQgsmYfqpoEsDiERsbUwzi+faWlIvHwM35/Vb02ilxhEgIUm2keAsANQxFzdWW+zPjKPOIPg1/rh7kwOLJrNKCWvNVgl7wEGzPeemJIg8wqqRTOax0uyqlQuOnER12LNM/0HpX2kgB3eGvNXwsLUjLOIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373925; c=relaxed/simple;
	bh=uklcU31Aq2jYzvy6rnjxIyM/8gOrXOG1sY+czEztPVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HMYftcwtevfj89C0hsCp4aahniFnj4DxTMdpUciKMuKmMIVfL11NkZ06Ckgj5PGttKBqOZtuusLlOgrF0aX2116HFpMMLxeh9b5t4rJBd/58uZLG/VRtRB0pK3sqJ1Olwm4wYF+Ou1uXWb1Z6TpXVLQPgoagl8AzxDo8zlinB0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=G2TgRBHY; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpiub2R7OlvDZmyMKT/TMGf6ViUlPZ3L18lvQCg+DaIuhfylKFTIZ/rPJVx79lwuvO/s7Loiy3NhPNMpST7BMfDWN1dy0SEfnTAQvOQptUOWo5Aayo9UwOu1iGsaGPkH8NFzjIJivtqnLctwAYQa+YmDqaMjBLZOUYjFfsLnWH+q3VCC+lMrhIXAz8iOab2RjYCXQVj6gkINU6+GAf0OyKsnhq0nHzzJKmjHAjTwAYb6cTunu/yli3X22I6jmscOhRFOI3dXv4BIT2wuLOqBsQWp9epWjTd/0GLfxpg+SNHc0EEnlkxizx6GysqrN2KXeTvQ69djfEdqD/sVQ4I0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7EZ/TWEMf9C4JuC1JOaxbWPxIoeruNORWUSNmiwa5A=;
 b=HG127Zy5Oe7sBjnk0h/MuMBvYKmRIVOBzUFbZ4Hm3f0cNQJQaSjRnSjCRGakunvGAsZo/biDfH7FXFEKumiQnU81h+STbByjK67Hl0M89mqLei5tX9ktsJqH6MlKoUAGSb2YFtqtKgrvzl+mZTsMqNqWeKzU/ltZvqqRQZIqKQsXIDNCMHCcuJVKVY7UoBkKIR1x7i6+F4vwEVzeiYDwmZjOypEMafLE8X8/dIcW3sYv1Q0JeBTJbibfrX8o2Aiuep+mCW3Lr6I6lk8ZhAru72eRsHOXHzyWo97Fr00upjUjoKbpYHfbtiS5HpTXqBHhF6zcOuKZ14z7kE1jQV4CQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7EZ/TWEMf9C4JuC1JOaxbWPxIoeruNORWUSNmiwa5A=;
 b=G2TgRBHYsKgQgRn3O/NzXthe14Srm365UXqGR2y4IynrslXiiDGE9dRDMRAZPOw8lRniSF3Smw5nXtOFOqmhLDq3aZ4PpWIPRVtHqtTSCjfvavA0YzZ9CLWbZVlR7b+AZONqZyIx/u6JqelHNX71NMWfg7XzWtoGGRcyXY746Fma7aRQrSn+q5t+Dlt7nYjiS/7vchBxyOZBhBM4IiZXjJ9QENzqKeECkK3EucpvHnm6xfcwBEKb+chCkcozHMqBzzCwqpw4qoVmmT5WuAo+fK/JBAwseO1snbwSJFiekcpySVi16eiSit68q5ggGv3bnpQ0FU0S7ljlr28Ln+oQKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by CO1PR03MB5682.namprd03.prod.outlook.com (2603:10b6:303:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 16:18:39 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 16:18:39 +0000
Message-ID: <4df7133e-5dcd-4d3d-9a58-d09ad5fd7ec3@altera.com>
Date: Thu, 24 Jul 2025 21:48:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
 <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>
 <6fsqayppkyubkucghk5i6m7jjgytajtzm4wxhtdkh7i2v3znk5@vwqbzz5uffyy>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <6fsqayppkyubkucghk5i6m7jjgytajtzm4wxhtdkh7i2v3znk5@vwqbzz5uffyy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::18) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|CO1PR03MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b387483-af5e-4132-3fac-08ddcacdbfd8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEMvNFpGbHJxcGVVTXFZTGtxdkkvWUcvME9qVnJQWlcyVHRjODVnTmxMVWdi?=
 =?utf-8?B?cTM0UEJrS2pHOHpzWXkxVFhNQmp5eko4aXptWmdsc01iMzd6VG5DZTYrNTY0?=
 =?utf-8?B?TzQzdThrbmxkaTZ6dFpmN1lKU3U4b00zVXQzdEJGMXBEZ2c5SUkrUDZyL2xX?=
 =?utf-8?B?Q3lwVTJEd3Vadkg2Tk9xcEZGQVU1MzhBalA0S2laRnJ0K0ZtS201MU5pcWJZ?=
 =?utf-8?B?cHgyTlhwUE5HV3FiOGt6dm1WSlVBUUFFdUNRZVVYc3laNVY0Z0JxQUI4eVJs?=
 =?utf-8?B?SWFCaGd3dHpZeW5INkU0QkZpdGN4YldYRjA4bEJjcDV4T3ZtVnk4RzQ4MjZS?=
 =?utf-8?B?SEJjN092a0xIL2Y0QU9aeDY5NDBRZ3dxTm53bE5QWmFmb2FNT3g1UFRVK000?=
 =?utf-8?B?eURidTVRdDVPczNHZGprVmF1SDNLdTVxUWRjYUwxQ0h5ODBPUG9FUmpqaHVo?=
 =?utf-8?B?aU5JN2FPVFB0VGkzMkd1Vk8zN3oxTDVZVExnbGF0SHBrQkhIMEQrQXdKSm81?=
 =?utf-8?B?bTZicDhsemVCZXhocDBzTHNMelRmU0ZxK1ZZUmRmOWQ5dm8wQWh4TW1pdXpa?=
 =?utf-8?B?ZWoxbWpGNm54L2Fmczl5cE9pTU82RE9VdDd5YkNNckVHSDZBS3lzZHo3U0ZP?=
 =?utf-8?B?aUt3ZklTa2hPakc5c0Fmano0RDJuV0ZZQ1RMQTdyOVA4REdCa3lwcGVPWHdM?=
 =?utf-8?B?RzFQVkRzVHZqTE5XdklpN3E2cm92aG1NUGhzYVVqaXNOeWFTM1gyaVZGT3ND?=
 =?utf-8?B?RnE2UXlqYS9Ka0JHYmR6WVMyUHhJcnZYNXFTbEsxNDNsZy9QOXJjdEp1MzZH?=
 =?utf-8?B?TXpaT3hTcllyMEtCR1B5Q25EU3hYZnNhTWVGOWNTbzNmdHVLdUdaL1VPMHB3?=
 =?utf-8?B?alNMVjZCb1VhbEkyclBnT0p2TlJlS05UTHo3bkpVUUdWODZhWVdjNFNMekFp?=
 =?utf-8?B?ZHYxdzJXZUFSQkpja3JveGtaOCt6NHBMWEl4eGF5bm1CUWdMNTBDMlJqdm9C?=
 =?utf-8?B?RkM0ZmR3ZDhpdWl3THpLOUEyT1hERGxMTVhkUnRmeElWMTlwZmVWMDdZakVI?=
 =?utf-8?B?dWFCSXhoZmpVNlNEVnNBblNHZStaTkNXS0ZYejhlYjcvMFJoeUhSWHVXU1hT?=
 =?utf-8?B?M2VaRGNac2E5M3pFV1FONUcyOXJERGdaU0RFNXBrUlJoeXlYTUM1OXY0em1a?=
 =?utf-8?B?MWJ5dC9hZHN2MlpNemdPN0lacmN5VDFTVUt3QXkwa3JhRURMWkFLeUZwVVFl?=
 =?utf-8?B?WWpHN216MUxiZWRqRFF2cm5PZHdQei9XQlJ3TEVqOHNSVmIraC80K2ZXem5v?=
 =?utf-8?B?VnVqblFocHY1UDNWYmpmdFpnNXB3UTFKYkt3ZTI3QlYvUnF0UmZndHF4dm9s?=
 =?utf-8?B?d2RSTVRpK0FNTU1sWm9kYjRjQWJzWjNtRmRiTXM2RU5FNXh4K0d4eGlFL0o3?=
 =?utf-8?B?MTVwWFowZzdicUJybGg4M25ISXROTGd3dGhMZFRaa2ovR0laZmsxUGtGdDYz?=
 =?utf-8?B?Zng2T1U1MFI3UXplZzNiR1RoZHBBeG1ZdnB2TTZ1K0V6NTY1WDBWKy91emhN?=
 =?utf-8?B?Qm5ObDNvN0dXSkIrc2t0ME4wRkhDRXB4QUpSVWovTmxvVWk2UGIvOUlwQlY3?=
 =?utf-8?B?aWZtT2JHN3VtRWxvVmxaa1FMazVEN0loQkZ2OVE2OGY5YjFmV2VPNFhsR1dD?=
 =?utf-8?B?YUsvcm1KSExweHVONWRkc0x6QStUY2JpODgyZ044NWZES2I2VHJaOUFjSTZW?=
 =?utf-8?B?U1ZVcVM2LzExY0VFUU5PWWs1VkZVUkpDUnJBSGVqeklHVlBSOG9RbXhlanhU?=
 =?utf-8?B?dnlCdUxGRmYwMUZuREp3dXJGaWlQUFVHd20zRXhJUFNYTFYxZmIxN3dmZ3hv?=
 =?utf-8?B?QnRtLys1NEVkZElMbVV5MWgzZEpmaEprR2d5QUZ3aUpIaXcwTlBTU0gvbmR3?=
 =?utf-8?Q?nZ6XVzgOMtI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVR1czNRa1JaUWRiSkp4VGZuSnFSTjFBY0Z4NXh3YlNKL08rbmJCT1h1R2xI?=
 =?utf-8?B?ejUrUmFVMEkrOUxtVWFmSnpFOHl2V2ZGckRPeExQRk1YU3V6eVpGS3BQbkJF?=
 =?utf-8?B?dVBaS0JQUmtaVUtnMkVEbFEzVXR5TnlBWWRyZHJSRFhkbVNFVnF2aFRkQXVF?=
 =?utf-8?B?T3dSZVlob2FIQmJaRnpSZDZHczIzNEdGM0dLRVl1cGV2VldEQytRRzU3OE8r?=
 =?utf-8?B?MzVyRVltY0o2VXFXY1NSanZKTHNYZFYwUHV2emIyamt6YWZWWFFLUmRYRlM2?=
 =?utf-8?B?ckRoVkk3YXlsNE41WFd3N282SlZzcDRwZmdObGwvMkp6Z3dna0JRTG5iS1Js?=
 =?utf-8?B?SURJYlM5V2RJaFhnTkZmeXdDQzJNU1cxNE1ZdENweTdTYnQ2eEVkUTNzeTVE?=
 =?utf-8?B?dnl5eDV0MUI3QWhQdHFlK3UzakZYUEwyUjV0bmxhQW0wL0ZpQmlSM2EyNlhO?=
 =?utf-8?B?LytVZmUvTUswY2gwSDVYS0tTdnplREdVU1ZVb0NUOG1QbmJuSVlpaVBkdmsx?=
 =?utf-8?B?TFNCNVlNMmtEakZxV3hOT0Zmc2dSVWZ0MkhKSVlUMVlDUEMwc1FTdlJVZG5q?=
 =?utf-8?B?Zmtia2FIRnY0SUczTkVudk93TlV5VnR5eS9hdDB5ZWltTFRacmRuUGxTLzk0?=
 =?utf-8?B?NFlPVkwvTjVPV0VHWElOOUN0cWVLdTZDS1ZRaU14NWc0YXFKa2tYR2poVTdj?=
 =?utf-8?B?bGVERjRRY3NKUTRqdC9CUmNiOE5iWVo1VWlhZC9FdTZXSHp1MmdZVUpYaTNL?=
 =?utf-8?B?U0krKzdWU3NnZ3htVE0rTnA0bzBMWStuYytSQW9aelN5aHBFcWpGMm5NRC92?=
 =?utf-8?B?Vk02OG4zZ2J2bDYvZ3hQNktBcW05NzZ5dHNsMnhoMzZYSjM3NDBXY2RxQ2lS?=
 =?utf-8?B?N3VWSkFKdjBVSVpaSVZpMFRsUjhWZlJrdXpwd0ZjNE9FNXhQakpFRVUvaE9h?=
 =?utf-8?B?K0R3TUZ4MFRyR08rR0Q2aURreExpVWVoS0lhVXV6ZFpXZ1YxU3hpM3c2aEFh?=
 =?utf-8?B?ZHhqUk9jeVl0dXE2Z2dUbEk5ZHcwRHZrdGVTY3Q4NTZ0Rmo5Z0Y5YUkxUGVJ?=
 =?utf-8?B?VDg5SENtbEF6NytreWltSGN0a3pEQUh6T2tGY2FlY1loWXAyd2wzZE5VY3Fa?=
 =?utf-8?B?aDY3dUdhRXp4a21BWG0yVXhnclh4aW4vcWNPYi9RcXlxSGR1dENYSW5GY3BK?=
 =?utf-8?B?Z1REem94aWExV2xZU3NTdXRUWTAwbFlZQXlWbkxaSFNGKytjVVdweTB4MWhP?=
 =?utf-8?B?dW9tVzJydmdGamlGUHZyQ2IvVnlCdFFqQ0YrbmxNdVErdFZSejhRZHlScFNL?=
 =?utf-8?B?N3VpdTkvYWtDdEJYTGx1cVh4RmdQcjNYL1pFdE9zYTVJU2pDMFdTZUdmekw2?=
 =?utf-8?B?RFZOVWFOQmZINWpxSkZ4K2wvUzVvY3RHWmJXMXlHUGxmNmRjLzh1dzRGbGpl?=
 =?utf-8?B?WTNFR0JOOGE1NDJ3S2ZZYXVoMkpWc3RxQ2NZQXY4TlZKMkVJSHJtVDRVVjBQ?=
 =?utf-8?B?VmZJeG9ET1dOelpNdGdHbm1mKzh2TUYxTU03TGI4V0ZzSWVDWVFDUVBkNGk2?=
 =?utf-8?B?MlRhanVCTitXMTNjcTNaM05PYlYzVmtTZXpEVlRqNVZTb2NFN0NyN0NlM1Nx?=
 =?utf-8?B?Nlh4eXp0MWN6K3d4R1JvaXVVWkEvY21OMVVZSFJDeFFyOUhtL2lpWFZ6ZWJN?=
 =?utf-8?B?Q0VGV2hGV3dJVzllQ0FjV2hkNGFPZzJXT2lvbXFuc3R3dmV3bno0SjZiU2wv?=
 =?utf-8?B?Y2V3WWVnYWNYb0k0TVhVMWZEUG9CaGJneDFMTVFoSnFNRVgwSjczL21TUC9i?=
 =?utf-8?B?Zmp0SUhaU200RCt0R09pTi8xVitXMjZUaUI2QXU5V1BkZGNpbVYza3FxelFo?=
 =?utf-8?B?ME4rNVpQRUg2NGRqcXl2UlRRWlhFaTloZ2hqcFVnNW8wQ3ZHTlBFbHo4dERK?=
 =?utf-8?B?eS9LN3FuWnhLSnA1SGMyT09aVVNvelpCZ2FFc1l5c2lIdjR0cjZnUTh4ZFZX?=
 =?utf-8?B?MmdSSzV1TjlJN0F2cDhHaVhmZUVzb0thL0ZUaUhLaFNJd1g2ZnpXaHdsRDJ1?=
 =?utf-8?B?WlpxSTYzazlYTDdralo0UHZqcGFNNGN0OW1DSGF3V3Nld1oxSDJOaUFoRlFM?=
 =?utf-8?B?TmNXclEwblVjb0pCcUpST2JZY3A1RXRCREgxTDJyU0JnUTBmM3dxaEdLTTdY?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b387483-af5e-4132-3fac-08ddcacdbfd8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 16:18:39.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhCN+jQh6IYfwcN9ai/2JSOK+fpOJ9Hh0RWXPk8oqveAeqbkgeU/gJ83XVqPkXWMJ9zz453x2GahBBMxFOgvsZ9g0oHL8Lr5D9Kpo/XFLKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5682

On 7/17/2025 5:17 PM, Serge Semin wrote:
> DW XGMAC IP-core of v2.x and older don't support 10/100Mbps modes
> neither in the XGMII nor in the GMII interfaces. That's why I dropped
> the 10/100Mbps link capabilities retaining 1G, 2.5G and 10G speeds
> only (the only speeds supported for DW XGMAC 1.20a/2.11a Tx in the
> MAC_Tx_Configuration.SS register field). Although I should have
> dropped the MAC_5000FD too since it has been supported since v3.0
> IP-core version. My bad.(
> 
> Starting from DW XGMAC v3.00a IP-core the list of the supported speeds
> has been extended to: 10/100Mbps (MII), 1G/2.5G (GMII), 2.5G/5G/10G
> (XGMII). Thus the more appropriate fix here should take into account
> the IP-core version. Like this:
> 	if (dma_cap->mbps_1000 && MAC_Version.SNPSVER >= 0x30)
> 		dma_cap->mbps_10_100 = 1;
> 
> Then you can use the mbps_1000 and mbps_10_100 flags to set the proper
> MAC-capabilities to hw->link.caps in the dwxgmac2_setup() method. I
> would have added the XGMII 2.5G/5G MAC-capabilities setting up to the
> dwxgmac2_setup() method too for the v3.x IP-cores and newer.

Hi Serge,

 From the databook, I noticed the condition:
(DWCXG_XGMII_GMII == 1) && <DWC-XGMAC-V2_20 feature authorized>
which seems to suggest that 10/100 Mbps support was introduced starting
from version 2.20.

Am I interpreting this correctly, or is this feature only fully
supported from v3.00 onwards.

Best Regards,
Rohan

