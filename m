Return-Path: <netdev+bounces-94165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2888BE7D9
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252541F29300
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ACD165FD4;
	Tue,  7 May 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8ZEkNHI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919116132A;
	Tue,  7 May 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097298; cv=fail; b=KJm9/GYxoYXwG78h5+nRCzDJm+bWws6uRbkQ1VhJ30ghTVJgWZxb3NUYXjJ9FqNJBquxM0dY1RjznZKCBJWJqmT4V7XyR8uN9M9q+NyZhaa9zMqcuQajDp1/grDnjcNwTgesh+D+zzReDSzNyRNUxsgI7Hg7lpBnoPKSi/kR7+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097298; c=relaxed/simple;
	bh=TJtXAgodlfk2muYMs1ZHEwK/pCWhBrUeUvz41xe/PNw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fzMTdTewKfJv95NCTbHe0LnF3Eh0rs3UTTxCDqGCsj+Bh84qtgnv60sak8PafEsmkImXQzDsbZFCWVl3p5xGnJRYyuwbRzRbRX6riHzaZi0/dGLmeXacfSWG4SzvF479jDHb1OVjl3GibW5GgdLrIKg9yMTIJyFVzWhsB0ovqCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8ZEkNHI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715097298; x=1746633298;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=TJtXAgodlfk2muYMs1ZHEwK/pCWhBrUeUvz41xe/PNw=;
  b=H8ZEkNHIQ7HzREGqfQA4gTH+X2N4R48UnJo6HQcH3Ve8zkj102eSYE1l
   DmxFkx42R+6zwuD8Oe5xUkmfBwIUSzUdPBWPtIWy3KTp1dXITjYuhQMh/
   XLZs96Vp5l+fBqdkaliKRv5jj8bUOLd5bZD4EBj35w1P+YGiNigIik0Xl
   Wgwp4Pu3e9kuX1ITp4uYn0jEcALSefg1DZTa+UOb0rVt8SkVWaFgyqaSU
   c9jFiJYHR2Xg3FuudH0KNNi95vW9S+mhuxi+jlQZHdpF0D4UoDXhzuyb2
   ZDYPnNi9cPeHQDPKIOWh9ZMg2AZ1jA0Z1xWlYdgE9pi3/83ccvolkR6x0
   g==;
X-CSE-ConnectionGUID: gnlKjX+VTO2VbPW2ZLQT1w==
X-CSE-MsgGUID: 8VVPCw2TTwuseeuGP5Hopg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14690625"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="14690625"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:54:57 -0700
X-CSE-ConnectionGUID: +dAE8OswRVSiU7klsTrCRA==
X-CSE-MsgGUID: mZBpqNoxSnmCPN9FHhiY0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="29088897"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 08:54:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:54:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:54:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 08:54:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 08:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htWYmJy31eXfjergSa9a8DBfNELbRCPMLjlNv0YLUPt5y1dMXexIz4Cvh6OWElsfPA5bpbob/p9/EdUnliEn7tsaa5bJevYe8q7sB4JU3+X6mTv9o+r34L/AunznI58J9GzmN8l0NHqqG7nvjNXHRDavhSXbMuxV0bvy05T7Krq9HNd7zJlSdIC/Iofsbid7XqAEj+9tprQUDa23izeLjDiaIUryf/pc+0PM0SHavGM8c0KAPj6oprW6UdNttEGWCzI0YXrZTFkvxbZ3HIA3XEW1T+WvzgzHZb0q6nDuKO8LFuelsILoPByJ81MMeL7Vqnw43OFL+6ukqnGXLoY2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yocex2f039OEQzoZ87Ru2nEr1g5DkLXmF70q2YrfF0=;
 b=Vgmbo2Y60nEc79+HdX3tlJ0DDsqCTSkMHk8nmYqKMgyeCVqu5QLbvRl056GwQr7pfGrmy5WTpkugjd+0CPE+mEOX+b+TuP3Ab9piAmRZj/tPC7hsqSKrAlznBat0JYInFpzY3rEx4LaEMO5Fo6Xgtn0/MQeOFSpcWOvOuhDG8zVvrI+UPXcS7hNXrEtn3hgipyfkOBdcUqCBSWQdCAZTuHQdCR0wj1HGesQIS86f/w+yKAB3nXAVEX/HisNRKHIm2SfJ99oR8EOYtDOEhneV3Xt1ukjtMhafQ35QFSzblXcpV1rBspFB0SrN+XQD+5hlkCeStbc2qSXbDU95k3JkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:54:52 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:54:52 +0000
Message-ID: <9b9a42af-1a73-4896-9bfe-afd55ae5b278@intel.com>
Date: Tue, 7 May 2024 17:54:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ethernet: mediatek: use ADMAv1 instead of
 ADMAv2.0 on MT7981 and MT7986
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>, "Sean
 Wang" <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <6747c038f4fc3b490e1b7a355cdaaf361e359def.1715084578.git.daniel@makrotopia.org>
 <9a694114ffbbf5f03384b0cbf0c27b9528c94576.1715084578.git.daniel@makrotopia.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <9a694114ffbbf5f03384b0cbf0c27b9528c94576.1715084578.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW4PR11MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: bae6844f-7c73-4539-7404-08dc6eae0869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHhmNVNKTnhNL3R1Tkg2eVhvanpzZ21taFZuMUpwTWNvYWU3SXZIMGpSTU8x?=
 =?utf-8?B?b3E3L3BwS0hrb3lqakNOSzFNTHhxMldpdGlZR29Tak4xbE91d0lNYXF6cjg2?=
 =?utf-8?B?TCtZTXl1Q3hYaFBsZzNmVlZmMjQ2czNFK3lUSGN4c3ZQN2d4T0pMdTdGZ1hH?=
 =?utf-8?B?RG0yUWZWUFV6eFBHWkQ1RG12U1V0TVAvTXFjdHJURnk3SExKTHhtS3BpeGta?=
 =?utf-8?B?VXBlWmZNYnBDbzNEc1hDNk5Rbmc0ekgwL0NxSTA3dDdRVUhoSVhleDFPSXoy?=
 =?utf-8?B?TTdVd2lsSmZZK29teVJkcVB4YW9zVFhyMUZjblpOK0YyL1dBVmRWYy96WkRq?=
 =?utf-8?B?QUF1a1h3R2dSTE84TXJadnFZeVFtclY3bVRmc0k0b2llTm5senBUMSs3ZEUy?=
 =?utf-8?B?NkFzR2NWdksyWlBNbHpibVdhL1ArL1R3ajJRN3dCWmhzYUlUcll0R01LaWRH?=
 =?utf-8?B?OWdSODBBMFpFZUI3NGE5RFl0YXh0ZmhuZG1qTnF3SGYyOVFJWm9admdSdU8r?=
 =?utf-8?B?UHdkeVpPaSsycDJieGZ5VnRybzBjajJPdXhjV1VoZUFZZ3QwM0dNUUhsTFRm?=
 =?utf-8?B?UDJ4eVFDNXpjWUNlMFpGZ2xFWUxjL2N4bDZ2QW5EMktPUGhxK0hvM1VJWTI5?=
 =?utf-8?B?NnVCbTI1REhEQldXNHh1OEZra2JLKy9WeU5nUXdTZ0EzeDJidVVuSHNkb21P?=
 =?utf-8?B?Y29qbWxqZFZxZXpsZjJsdHhxaEIxTEdzVmNyTXZ4clRTWGpsaHJPYWo2TkJ3?=
 =?utf-8?B?RWFCMXNWQWhnNXdvTW9kdWplL09kUlBUVG9JNEU3NXM2SW1MUXFNUE14a0Jw?=
 =?utf-8?B?aURKckhPWWZtL0kyM2FSNTNqU2U3UjNjbzZFVkFJd0lwVUlhMkE4bHJmNHlt?=
 =?utf-8?B?ZVpab0U3b2kySTk0ck1IdWRhbEphS1hENW9qQ1JhV3JiS0F4ODhhZDdtVHRt?=
 =?utf-8?B?SkFiUEN4clhreWpQRUhyVzN6UW5YQ1pBcUhVYU50TTVxNDZzRFo1WUhPV1dF?=
 =?utf-8?B?c2NmZGtqVm1zRUMvbi9RUTNsb00vRklTNHoreGFVVnpmTHVwdmpsVmhhWWpM?=
 =?utf-8?B?YWU0SHE4WmJKSG9kdXJCN25JQTVMeTAxQmkxdFpPVFhKSHB1dnV6dmtQaS9Q?=
 =?utf-8?B?Umw2SFB5U3l2cFJMWXJ1Zm84MXRwVG5CSnorRzhNSW4ya0NmRDJJa3FiNFZX?=
 =?utf-8?B?dTdKZ0FKS1VGZTVWNTRSdUtPTm9adlNJS0pFenI5TEg0RHk5SG1NcEsybXM4?=
 =?utf-8?B?NGErd1FPdGlTOVlHYkorT01ZVVJyWkN3clVVcGFjeU5jVFFZOU91Zk50djEw?=
 =?utf-8?B?cHZUV0FMWmh1YnIwZG10RWRvclNOdzE0SG95Mm9VZHVkZzA2UWtaeWd4bVJj?=
 =?utf-8?B?N0t4aFlYUzE2dFNSM1poNHY3ZVZHM3VLNUpnM3RoSmQ5Q3o5cllUM1pUcERa?=
 =?utf-8?B?dUZiajQwazBSV3hObnNnTXhMSW9RNi9nRHp1YnBzOE5YZCtzcUlLSys4YTlJ?=
 =?utf-8?B?blczbmdsbGRIQWdJdXVFeUtETlgrQXVMRDc4RS9CS2FJUHpUWWwvVnd5bWFt?=
 =?utf-8?B?TFd4d3JuODFCWFFlT09YN2dZbnJUOS85WjF1T25BWUdrTm9iUitwVHN6alFZ?=
 =?utf-8?B?K0F1NTIxV1M3cGxQalgweVpxZ2hRc0lLZmo2dnB5SEVVVTFBY1BEQ0NsUUcv?=
 =?utf-8?B?UXBTWWNOSjdzYjgxUVFPRVE5VEIxVFFLdzdqYlVtZTRwVVNlSVkvQmVpUGRB?=
 =?utf-8?Q?/OZEI/IMhoVF/JjSeL0y8x3PZSxiYDEwG7aNveS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnpJZzFTSmF5djN0cVZEWE5jL2lGVXVQQitEQTJWK2JEV3VaRWgvMkZoZ0Zy?=
 =?utf-8?B?VWVmUTduSUtUck1CY0UyR29TY0RyQSticVNTUnpnbVJOUy9IeHdZOCtWTXRH?=
 =?utf-8?B?QUV2azNWN2lPVVVNc2RlbnZaUlhzZ2hFTENWSS9kVUV2QWZiS0dLNGpCRExC?=
 =?utf-8?B?ZXFweFRUSlI3ek1BTlRBQVFoZDMzWDFsa2JsTHBmTU0yWTlBbjNKUndkOUZw?=
 =?utf-8?B?S0hzSHkvaElBd1pYMkk1Ri85SW1aSG9sKzQyMS81UUxHSkZmaTFqaUxVWmhD?=
 =?utf-8?B?dE1yZnlleVd3alhUSEdvZ2U0eU5JNGFaUjREMlRNNDFhNU5sdkJsdU1JenRD?=
 =?utf-8?B?VXhHNjF0YjVQZ2J4WFhEeWtWbjlCOGdQbTMzQ3ZCb3NHTWhiODJYRVRHeFNi?=
 =?utf-8?B?NHRrakhyWDNiSjZaOExFTlRpY0s1L0l5a3dBY21JNUI0SVVNckZ4MkU2MWs4?=
 =?utf-8?B?YlJ5VnZ6alhkVGkvVWJEdG5YRHlyUlhqY3RuMVVxeWlmSDl6aVZubFFqS21u?=
 =?utf-8?B?b0MwTldHRkVwWWZPOFd2aDhFSG83aWF4d2EzR2kwQUNDTEtESUR6bW81VzY0?=
 =?utf-8?B?cWI1Mm1sVnVOU1d4dXV4VkhKR1FiOTVROUJCVXVuUUhRT1hEN25tbVRNUTRt?=
 =?utf-8?B?eGgyMHZUckh6VDZEL0NGMGVHS3B4bzRpTDhLbFlZZDZvY0k1Tkk2QUF5VkdT?=
 =?utf-8?B?dHZYZDVWWUU0S3hGcUQvZ3ZKd0xPRnJUUTlRVkd5dnE3Sm0xUFJ2SVN0QndE?=
 =?utf-8?B?UitVT2V6UlgybGdMb2d3NFZld1dRY2IvUXlIak9jdmtmcDNDNnMvczJaY2lL?=
 =?utf-8?B?S0pmNnAyaVQ5ZHhla3BneTU0QnovMFJhWVgrY0ZuMXFnenV1V09BMzVrUlhi?=
 =?utf-8?B?RjlvZWFrMVd1L1pXRG11Rmk5ay91TGZpMnJOc2pwMjNua2xDT1NsS0hPT0dX?=
 =?utf-8?B?T0tSUG9Ma2VkNnkyKzlrNmZwZmhEZ3VGT3lLSW9BUTU5NDBHdnU4WXJBYXpZ?=
 =?utf-8?B?dGkzRy9NTnh2b013bEg3Mzk4WjhMRFpPcTNyL0V6M0NCUmRFN3ZwRmw0RTFm?=
 =?utf-8?B?dDU1aGZYZXJGaDZzV29BNjdiOW0wTkdBa0JoNVpab0ZCS2JmSCt5a1RWbCtS?=
 =?utf-8?B?aGIveUNtYndiOHpFSld4Q2ZxdHBpcGN3TkowbXdickIxUGNpcC9KY3pOdmds?=
 =?utf-8?B?RkY0SjJ6dm93VXZCaDJkVHFhc3RQQkl1SDI2bmIyamYxeC9hZ1RnZjdZaXFt?=
 =?utf-8?B?cnJwSi9BK0h1cVZMV09NRjBEeDdrTWdQV2hvdHgrVkJqZmEvY1kxbkF3VWpv?=
 =?utf-8?B?dUNNUm43YitMSXpvL1kyZmFpQ0wza282MExReGZ0NXNlYUMyemhxd3pHc0Uy?=
 =?utf-8?B?ck1TVXh2MngxdWxOdkgxNDE2bGZDblBwMXhaRWpVeld5OTVIRXptMElNRG4v?=
 =?utf-8?B?Vy9GNkczS0lYUllyU1NDc29rV2FSS25LeVBxWUQ5Y1FPSk5RU1lpNFVTT2tF?=
 =?utf-8?B?aXM2ZVhSUE9WeDAyanF6dWJjaHFVWUYya2ZGNUFSbnVyQ2RBdzJCWGl3NEdS?=
 =?utf-8?B?aUNscURJbmhHd1pNTGNpT2xoa0ZSZVNQdUh6TDJ6ZVpVSHV2VGNYNG1JZ0FL?=
 =?utf-8?B?SmFyZ3dOK0ZFMzE0UkpqT1pYa1FwZEUzMHI4dnRDUVZjNXZKR2xZZGdreHFl?=
 =?utf-8?B?ZktDRXBNU3JHN1pPUVNtWGY3amM2T2kxVDI2RlkrVmtiZjVjd0ZDeFhqZ05K?=
 =?utf-8?B?TjRvQ2JLSDlCUU5wWEFlZTFVNHV1OUxZUm1lVVJpSzZyYnNaeFpUYlN2RTVl?=
 =?utf-8?B?UFBMelNmS3hTdDhjRyt1alozQVhjbE5JSkp5VDZZbE02NjBFdTNpMk4yMWdn?=
 =?utf-8?B?bURvZDJtRjl6eThBNzVJenM4Yjd0T24xTCtaSWdkbk15V3VUc0JmUWI4d2ZT?=
 =?utf-8?B?WTAwbkxiK2FYTEJZUjA4NENvSkw1TTAwSHdZVWRBckY1QitsUSt2Wm1tWHAy?=
 =?utf-8?B?UUV6Q0ZXcXFHYUdTMjd5MHZKd1ZPRGdVNEJGcmlQV3U4ZDdqMlk4U2JybHd1?=
 =?utf-8?B?bUdYWVA3bUxoZGlveHdMZXRWMEI0ZzVkUXFoV1NCTFFnNDFRUzN5THFhWXZB?=
 =?utf-8?B?VkRxRGRDdCt0aU1ET2ZTNkVTY0NtSjZDUW1JQ0FNSFBTN3NyRnhBVk1XQ05y?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bae6844f-7c73-4539-7404-08dc6eae0869
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:54:52.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adrXBkzz8BaodIuvaURg4gmtpp91/wCeI2Ca3dSHJJAWgRgu6z32kfH+X4gSIcRKiNsz7HL5T1eJFIxvPHTT3bOqMy+uDmJRq9PS90mlA9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6984
X-OriginatorOrg: intel.com

On 5/7/24 14:25, Daniel Golle wrote:
> ADMAv2.0 is plagued by RX hangs which can't easily detected and happen upon

nit: missing "be" after "can't",
but no need to respin just for that

> receival of a corrupted Ethernet frame.
> 
> Use ADMAv1 instead which is also still present and usable, and doesn't
> suffer from that problem.
> 
> Fixes: 197c9e9b17b1 ("net: ethernet: mtk_eth_soc: introduce support for mt7986 chipset")
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: improve commit message
>   drivers/net/ethernet/mediatek/mtk_eth_soc.c | 46 ++++++++++-----------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 3eefb735ce19..d7d73295f0dc 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -110,16 +110,16 @@ static const struct mtk_reg_map mt7986_reg_map = {

MT7981 uses the same regmap, so is covered too, fine

>   	.tx_irq_mask		= 0x461c,
>   	.tx_irq_status		= 0x4618,
>   	.pdma = {
> -		.rx_ptr		= 0x6100,
> -		.rx_cnt_cfg	= 0x6104,
> -		.pcrx_ptr	= 0x6108,
> -		.glo_cfg	= 0x6204,
> -		.rst_idx	= 0x6208,
> -		.delay_irq	= 0x620c,
> -		.irq_status	= 0x6220,
> -		.irq_mask	= 0x6228,
> -		.adma_rx_dbg0	= 0x6238,
> -		.int_grp	= 0x6250,
> +		.rx_ptr		= 0x4100,
> +		.rx_cnt_cfg	= 0x4104,
> +		.pcrx_ptr	= 0x4108,
> +		.glo_cfg	= 0x4204,
> +		.rst_idx	= 0x4208,
> +		.delay_irq	= 0x420c,
> +		.irq_status	= 0x4220,
> +		.irq_mask	= 0x4228,
> +		.adma_rx_dbg0	= 0x4238,
> +		.int_grp	= 0x4250,
>   	},
>   	.qdma = {
>   		.qtx_cfg	= 0x4400,

// ...

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

