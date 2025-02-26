Return-Path: <netdev+bounces-169794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FDFA45B63
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8186F1887EFC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30272459D5;
	Wed, 26 Feb 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kQ74kyFE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB192459D0;
	Wed, 26 Feb 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564729; cv=fail; b=Yt56/lz8i9wBBgw09236S9Wy7f8jTB0qFuPUoHGU5taBeT80rTSODXjOmviK1IJe8r5GnOPOvxIEBEo/5VRGzmguClKaM1lyLQ3fm7m1LGSSOZfiypm4XivYXG+oWC/Mmik+vELCeCkB9DfLn/PNQaFWcM/lu7TJlQASW38mlC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564729; c=relaxed/simple;
	bh=Xc0DaAK1JyaVK5ZfLLjxeXucoZSPLz1a8NL0MIiEl3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I5SBiSPYOS8E6jV7800w7QxsL0zxCStiHr/h0vFdsLFgN+GHwagFD5S8u4bHjttM1TSV3cy2gRIG8aEXBtbWGSR18h6DmtjKlqLUTDy9sqMo9yAwdBbOw2FOoruNQ4Fn3D5WJUXkkeKIBRHdiU3DoTH+Vfzg//1HtLyaJjXAVBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kQ74kyFE; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN+vtBZKLqIDvwyjV9THrKo4DymUcKmrcbYz1fB6scNz1TayLuTGJybforLHijYPmTMmGIi15Px5Gz6ZJMATKQmr4IPA1Yijm6RjPVaVw7dxIE5m7jer8SbEhEmvnEloNl3JhfJGkaEqb4VW9lILXT5DDHFD5w+dtWkISB4iXnhYp7FK7aGQIjHiQGz3qIdD1L5CgjeeJhYg+B+ZRxLpCRd1P2T4cEe5zSumZd1NGDrYlAmTDm6iW4TQ/m7nGRzZ9l0/hF/J2t62/tGpj/Kr7zM11aU6XyfdX1AEL2mjEYA8sXNcmKt53qRRt/xzMVDEs0f0G8/vuK46I3HNygDYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QsDKY2CSLlQddoeVqcNL3EzhTiLQkZI5yk+dqrF2ms=;
 b=Dv7CImHhfcirSFYNx8F/r/naV7q32MiUa0mrdcf+8cpBBA3yIgJlv2ulBDmhOGk2M+Xf2EpwzNh+NcbkM3/EEbWzAyqhgGjfBvFDHzkaeG/C2TfxccwysOrYbNVa8sIRxahBW0DS5WHD0qYJCcnvhqCwaRQoFYZVLizlVKquI/h+lXuap8IcSZT7Qv70JwttTd18l+jVYTKemEKsjCW2tLx62PlAswvtUvKPotah+TPC7MKrcJdqYqfHoYjKJh6k+qV7NPt6dmLnj/HjzkQ0XegXBGThnJTBVZVkY5F0gG/07ZfcfN7w8en8M+xE1fOfGxweTivXuQJFHLv7lFddiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QsDKY2CSLlQddoeVqcNL3EzhTiLQkZI5yk+dqrF2ms=;
 b=kQ74kyFEbAtNAaxN08BIkzpI4KVzCAHhlTUjUGgRYlHVWUbA2Rou7qFTYOfvF+bpnUAco9wOxXLskJzyzuImSsitdF85RmEpQYWiYMPFmSjy65OITBZGtrOvQ5xmcjPN+H7yB59sg+ycxdyFmbPYWUVpSn7UAYJRJy2niJB6A38Q99Qv7jCl2maLviInNCAqLezmg+C8fQhTqbRewyXhtORfDy3d1nbm7BuQQFoEi2jyrLWisEyXg9v0l/5xbEmkiJJXOKbv69KQvH75L2YBgevpPk45zRghx1XFo69lGOyAP9b2GqexI/psDW2dVQKunKRnxxa0MKPOHuLt2iELZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 10:12:05 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 10:12:05 +0000
Message-ID: <dd1f65bf-8579-4d32-9c9c-9815d25cc116@nvidia.com>
Date: Wed, 26 Feb 2025 10:11:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z63e-aFlvKMfqNBj@shell.armlinux.org.uk>
 <05987b45-94b9-4744-a90d-9812cf3566d9@nvidia.com>
 <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
 <86fae995-1700-420b-8d84-33ab1e1f6353@nvidia.com>
 <Z7X6Z8yLMsQ1wa2D@shell.armlinux.org.uk>
 <203871c2-c673-4a98-a0a3-299d1cf71cf0@nvidia.com>
 <Z7YtWmkVl0rWFvQO@shell.armlinux.org.uk>
 <fd4af708-0c92-4295-9801-bf53db3a16cc@nvidia.com>
 <Z7ZF0dA4-jwU7O2E@shell.armlinux.org.uk>
 <31731125-ab8f-48d9-bd6f-431d49431957@nvidia.com>
 <Z77myuNCoe_la7e4@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z77myuNCoe_la7e4@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0503.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: e0780930-e3f7-4ac7-eade-08dd564e04bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZytlR0l2SDcxNnBWN3paRW0yejFCc0wvOWxNckFYWWZVWk1aMVYwN0dKYUE5?=
 =?utf-8?B?eFRlVy8zRm1kbHc5TU5leEZOSzVaN3ZJOVhhWnYzZTFWRkxrZGdoaExTUEZm?=
 =?utf-8?B?dWlLdjNnYUoyZ3ByaDJkM2RrOVVpVlZsT2M0NnhucmZPTExpWlZ2YThubmw2?=
 =?utf-8?B?NDI4Z1FSSnJ6RWI2ZWh6U2UwbWZLUmEreDV0SU5BdW1UL0FObi9reW1ibkJD?=
 =?utf-8?B?Qy9IeEF4c0JMN1VPZ2p5NGF0QUpDcWc5TzNxTUhPNHErM1VHbjRHdXczbDhK?=
 =?utf-8?B?UTMyQWFiVlFwcVpNTUNSZFcxMW1XUTFMdFp4QThpQ29SQ0U1dDFBZWZBaDV5?=
 =?utf-8?B?ZHE2WVhLRHI0WlpBR015VTFIdTVBQ24rQXRMRE91emxEc0hVcDFVSGtyRVhJ?=
 =?utf-8?B?SHJQVDB1a25oQ3RzdXMveFFDYkcrRE52NmczQ08wRGJJY1g0d1N0bDVmSkJY?=
 =?utf-8?B?TWVxTHlxYnNpbTZKc2ZIQ2pGb2w4U3hKMTZIMmxNTFVWcUtGc2Vza2F5UlBQ?=
 =?utf-8?B?eTRWVmdCb3lxZWtJMWdveHl5dUNlWnhQOXl1aHg1cHdIREw2UWJhaFJuU3FF?=
 =?utf-8?B?eGNFTGhJZUFLajVJRWVCQStMeE1Ncll1eFIvamNvUGZ2bmE3Z3R2bWdmSFpE?=
 =?utf-8?B?bXNEcThkRmFXdWZISHd5eWJsTXlEUmIrVnpBSXRRSm9FQW5odThVZWFCSmto?=
 =?utf-8?B?em9kSUh5bjZrZ0ZINW5zakhOZ0hiR0lhb2RmazhuVXY2dU8ycmpOcUduZ0hF?=
 =?utf-8?B?K2NFSDFhZ3JLRkN0U3luNHNzR0Z4eE12cUtMMHR2RExJWXh3b3p1aWhELytL?=
 =?utf-8?B?VWFkTnBJVGlnWU4xL09qeElOTWpYdEkySUtEK1Qxd3o3ckdiMVVqZ3QzYzEw?=
 =?utf-8?B?V0ZhZURDQlZvVW85QlZpRzl0b2ptTFNLT3hEREpWYTBtUEZya2x1N25ZWi94?=
 =?utf-8?B?dzc0YWhaSko3cE9xbmV5b05kaDgzbzMxbkpOaGdVZ2dHL3V6UTlua083UWxS?=
 =?utf-8?B?N0pFVTljWWFzOHllTzBHRWNnZjI0WnZsamVEVFlmUVo2NU1jdnRRTXJpTzNJ?=
 =?utf-8?B?VGh5ZEgzMER5RW93WE1wVFQvYzFuL0ZmN1RObUcrOTNuODFnWFN4aXZlWUVu?=
 =?utf-8?B?THJ3Nmo5WnVUQVFabW5UMExaNkV4ZmRwbUJvdGFEN0VqVEQxamdtM0JTYkJo?=
 =?utf-8?B?bDVDdndWSnc5aGhZT01CaStoYm0zd3V1eG9Id2RFT3B1bW1oTi9RSmlDU2F5?=
 =?utf-8?B?Z0pkcE4rSUxMYWs1aEg0WUV4czlUYWJFYUhsbEdsWGsvdHN3N0pPMlRLOVoy?=
 =?utf-8?B?a0lYbXRDb1Y4dmVSdWtqN2ZRV2JldUhncE9uZXN3eXhqZG44eU9Fb01OSHdm?=
 =?utf-8?B?c3UxTUxleThPQ0s2bmthSFN2a0hob2podEptT09hYkR3RFEvYzk4RzRZaTlD?=
 =?utf-8?B?MXZiblY1UDJ0SWZmWm05VTZFQ2JGTk5oTm1PZzdJbzBOZkVQU0dtdWpKbVhM?=
 =?utf-8?B?d29DbFpNYXFPOVo2VDdkNWtyODZxNFRYYXduZmljNUVtS0M0N3NzY05FRDVF?=
 =?utf-8?B?QURid25FU3R3WGpjRXhST1RPQU9rZStiLzJBTEJxRnhMZmdZVTNKVVQxdW5v?=
 =?utf-8?B?YWhiV09kQkdNMjF2QnVoelc3Y1R6UHI5d0t6RERNd1ZkYy9jbFpqUWo2ejJW?=
 =?utf-8?B?TkR4SVRoMUhBVzZEU2Q0QWUvNDV5RXdUcXpsWnZYSUlZMW1tMTU4cHVDM1Zq?=
 =?utf-8?B?dGZyR0prM29zN1F1Rk9wa0dYWG5vYVQrOTNxeW9IaGM0WVJESUFvbS9xa1Fl?=
 =?utf-8?B?cUY3SUJYdkZicE5ZU1hRQjh3UG0zaWErS2xqNnJjWTYwL0wvYmREbHd6Y3g2?=
 =?utf-8?Q?eHkPu2wgCJO0Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUlhdGpXcU16MlZIZGdUcEFOTnN6NWVYYlp0dEUwNXVIalZMeFArSFk5VVo2?=
 =?utf-8?B?aFViY3FNK3h5dncrNS94RFQ3RG45bXNhRGJIU0JmQWVGZ2VJZmpNcW9ZSE1k?=
 =?utf-8?B?K1lxbDNBOHR3Y3lpTkhRQWt1SnJBRDQzZnFETXplOGhiRmpaN1VzMXdpNXF4?=
 =?utf-8?B?VFRkNGhGaDNVYzNmZXRWWDJyZ2o4UDZKUDdrT1Y5TStNSHBRaVBWM0lJSkQ1?=
 =?utf-8?B?MW9LWW9pVlhsVU9lOFhvTzJ2OE9nNE8zWUZnR2RnR2xtWkJTYWZySG81Ym1K?=
 =?utf-8?B?ZXhQVDhkVk43Z1ZUU2VTeTFQdGlxQ3NjTmZJQUtWcnh2U0JybVVkcThkL0s0?=
 =?utf-8?B?enlsSFc0NHg1ei95Ny9Zd1ZvdWJha1JudjRYb1FJbzZKRHRhUHNxUFhEdWo1?=
 =?utf-8?B?YVBLZ3VDc3NOTzVkTDA0cFRBRHUwQlk1OG1ib1ZaSVdsR09iVTBSY0ErYVI1?=
 =?utf-8?B?SVhTeXF4cWpiaFAxYTc0dHV0d1FUNFE2SW5adkpMK0JKK0w3eTJRN3h2dExC?=
 =?utf-8?B?RmhCYy96NHVXbzNjeHd3ZVk1L1VoWHYzMkFCMDlaQUxPcGhGVUF2NnVBMnVV?=
 =?utf-8?B?R1hadXB6MWlUQUJHZnF4cWpqVncyK1ZFcWRUK0l5ejIwSWpveHova01FTkM3?=
 =?utf-8?B?ekJGby9uNjNzZTRER1crRi94cHRDR0o4cGdPeS9PNzExcUFXMGw4UEVhOXRo?=
 =?utf-8?B?Yy9rUHFweWxCVkJ0SkFWWWt6bmlUdFZHVmdBdjVXZFZrM3ZjT25vdWFMalhm?=
 =?utf-8?B?aW00QWF6QU8rR0p0L0dTYmdkbWIwNDBYeFIxeEtmMndETWZGOVJvd1k4Y2xn?=
 =?utf-8?B?cUpkN0hxZDBrZmtlRzRkWFNCMGg2TXJ1L1hPVkZXSzZ2Tng5Sis5Mm52cE9o?=
 =?utf-8?B?TEZ1NjBmR2JQUHErZ1NkTGs3eGRkZ3BPVlZjRXNhNWRodzlEYXR6ZGZPc3pU?=
 =?utf-8?B?VlZKTWc0MDF3S29pU2YvNVBWMnR3RE1mWW9uZHhNNCszUDBzanZ5dU9TV0Mv?=
 =?utf-8?B?d1J1c0l6QjgxaGRlb01BZGJpQzJjbW52ajdWcDNwczNSN2hWQmdnSENnb1Vi?=
 =?utf-8?B?WitpYjY3SWN5VEs1WkFEM29US2gxbzRnbmFrS3lySVRCVDRyd1lzQUxYNEJt?=
 =?utf-8?B?Q1hCOFRCMThpMkkwakdFVjFMamd6WmZrRWk3UW9xQkdpSkFPa2NsbyswRytP?=
 =?utf-8?B?bE0xRGlybW4vcUZHNG9PYktnN1UvQ3NWM25EMm1OSjFJT0VrTStTdGY4Q2NC?=
 =?utf-8?B?ZStZL2xmM3hSRTNjM2FhMXMySzhKVUhxT2hFajcvd0kwMm5tTWNucndqa3JH?=
 =?utf-8?B?QUtpaVVBOExHa3ZSZXhMR3N5Z1Z5ZzFWOEg0dWg0YndkTGd1ZEdDSGRYSWpm?=
 =?utf-8?B?RnNFbHpmTTQrWXRXZ1VIY3hmYlVhQ2VxK0pKTzIrUEVhSUJ3Z09kYVpBaWk2?=
 =?utf-8?B?NXI1bG5LWVVEUWdFRnhhOUJvQlYrRE9zSkZVQ3JCZG9GN2ppeTh0NzFYL1Vk?=
 =?utf-8?B?SU9iY2RIWU44YmtIU1RIN1JJeGljSlBQa0N6dSt0aFZFbGxMOHB5cG9uWVJr?=
 =?utf-8?B?bjJFR25xb0x3S2tjSlliNXNYdktSTjdxdnZwM1c2aEx2QW1uUHo0NG0wN013?=
 =?utf-8?B?MWQvZTlLVDVLS2xjNFA2Ty9HWFhPNVRPb1FPM0hoeHNOZDBiU2p5NUM0ODQ5?=
 =?utf-8?B?VjIzVHBLZjF3bW1PQ2RKZ3RCZ2ZXQklsTkVhL2twVC8zRWV0cVlEZE5PUXNE?=
 =?utf-8?B?K0hoa0Y2MGVkejlGNkp2cFVFa2lPamlONVNBOWZ4T2doUDVVeGRIY0VkbFJu?=
 =?utf-8?B?Tm1rVEoxbkE4TmxWR25XTEdpdXphSHVVTTR1NlIybXdXZVZDb2lWb3ZqK3Bw?=
 =?utf-8?B?K3BwbldJUUZLNWRadTV5WFZQUDVWQ1BKTGlwdm1hMWhMOEVMVGQzT0paVERW?=
 =?utf-8?B?VWtMYzlTeSt3RmpGR3ljRzA1cEhBa2pLa21qK0Fmd293aW9hZ1I0NWQrMmMr?=
 =?utf-8?B?S0dtMWg0N1JXWmVLWEhOZzlSWmxwcW1LdUtJN1E5VEd2ZHkzaXFMRkV2a1g1?=
 =?utf-8?B?NEhwVnRsTUNzQ3IybU5xZzdKeWYrTGNGU09IbE5qS0loTkszMk1ZQVd3RDhH?=
 =?utf-8?B?eWhTSHVaTjRKKy8yS1UrZ3pXWmpBTFFjajZ0NU1WY0FDVWU2anMxbW1lNnBJ?=
 =?utf-8?Q?VBZNbfMwWWLXs5M8BIr1PoEkRRbzd5Xk6iHWIOVxdFAz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0780930-e3f7-4ac7-eade-08dd564e04bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 10:12:04.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSkxRapeTjIR6NFXi6lhx+h7IcqRbzXrJtvwHHany+lJfAd3ViEOmUSDJVbrA60fD43sQs+lvLl0r4R/utVWeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837


On 26/02/2025 10:02, Russell King (Oracle) wrote:
> On Tue, Feb 25, 2025 at 02:21:01PM +0000, Jon Hunter wrote:
>> Hi Russell,
>>
>> On 19/02/2025 20:57, Russell King (Oracle) wrote:
>>> So, let's try something (I haven't tested this, and its likely you
>>> will need to work it in to your other change.)
>>>
>>> Essentially, this disables the receive clock stop around the reset,
>>> something the stmmac driver has never done in the past.
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 1cbea627b216..8e975863a2e3 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -7926,6 +7926,8 @@ int stmmac_resume(struct device *dev)
>>>    	rtnl_lock();
>>>    	mutex_lock(&priv->lock);
>>> +	phy_eee_rx_clock_stop(priv->dev->phydev, false);
>>> +
>>>    	stmmac_reset_queues_param(priv);
>>>    	stmmac_free_tx_skbufs(priv);
>>> @@ -7937,6 +7939,9 @@ int stmmac_resume(struct device *dev)
>>>    	stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
>>> +	phy_eee_rx_clock_stop(priv->dev->phydev,
>>> +			      priv->phylink_config.eee_rx_clk_stop_enable);
>>> +
>>>    	stmmac_enable_all_queues(priv);
>>>    	stmmac_enable_all_dma_irq(priv);
>>
>>
>> Sorry for the delay, I have been testing various issues recently and needed
>> a bit more time to test this.
>>
>> It turns out that what I had proposed last week does not work. I believe
>> that with all the various debug/instrumentation I had added, I was again
>> getting lucky. So when I tested again this week on top of vanilla v6.14-rc2,
>> it did not work :-(
>>
>> However, what you are suggesting above, all by itself, is working. I have
>> tested this on top of vanilla v6.14-rc2 and v6.14-rc4 and it is working
>> reliably. I have also tested on some other boards that use the same stmmac
>> driver (but use the Aquantia PHY) and I have not seen any issues. So this
>> does fix the issue I am seeing.
>>
>> I know we are getting quite late in the rc for v6.14, but not sure if we
>> could add this as a fix?
> 
> The patch above was something of a hack, bypassing the layering, so I
> would like to consider how this should be done properly.
> 
> I'm still wondering whether the early call to phylink_resume() is
> symptomatic of this same issue, or whether there is a PHY that needs
> phy_start() to be called to output its clock even with link down that
> we don't know about.
> 
> The phylink_resume() call is relevant to this because I'd like to put:
> 
> 	phy_eee_rx_clock_stop(priv->dev->phydev,
> 			      priv->phylink_config.eee_rx_clk_stop_enable);
> 
> in there to ensure that the PHY is correctly configured for clock-stop,
> but given stmmac's placement that wouldn't work.
> 
> I'm then thinking of phylink_pre_resume() to disable the EEE clock-stop
> at the PHY.
> 
> I think the only thing we could do is try solving this problem as per
> above and see what the fall-out from it is. I don't get the impression
> that stmmac users are particularly active at testing patches though, so
> it may take months to get breakage reports.


We can ask Furong to test as he seems to active and making changes, but 
otherwise I am not sure how well it is being tested across various 
devices. On the other hand, it feels like there are still lingering 
issues like this with the driver and so I would hope this is moving in 
the right direction.

Let me know if you have a patch you want me to test and I will run in on 
our Tegra186, Tegra194 and Tegra234 devices that all use this.

Thanks
Jon

-- 
nvpublic


