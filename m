Return-Path: <netdev+bounces-130136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B1988848
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 17:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB34F1F21B8B
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E61C1739;
	Fri, 27 Sep 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MwkxJagD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3DF142621;
	Fri, 27 Sep 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727451001; cv=fail; b=qDyr9ShEBM+DJQx34zGL6Hqa/eBm/RXWStjh21YBw+GVffMathqOY8bKlz6K8xkVqMQCjhcF/0IKpMNpYvnh2guObaDdeKzfmIuJ35t99lL+NQ6zjBUrqXiW1RzRoAP61EFgwFAlH8h1JbuWzhmDiKZ8vSeprVBVYZjv71Le0i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727451001; c=relaxed/simple;
	bh=Neay3oEIunPkLgN6OS/ExqVxBw4kSmZZ5daAFlQsVd8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rGQZ46J866do/NFROx2509n6bB8R41suUkuaYtrKMBOdanQj1XctpfgTX9gdhZdTGH6U9Tr0igO4g2/sRc25q9aQyZxiLPDbiE1ErgFP48UKVKKMrWDNB4Yr4NLI6rkudAhsyrbQDyND5H7q6wrB5ufNWRLdrTm+7uBOmCYP+1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MwkxJagD; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/xbDSCA/cs/13qqMunStJcjl9s9xa0B2dQMcmd5LnGTVPla4KaJ8TI/sAsGkBRfGgha9ifoDkow784ec8x/+2FNPgAGs/lt0PKbOTNs3lFPQr89BwWKc5XFnXaJJN/b2TCtRd1g6F66O0zrTET39tG9JWyhA8WwCkOJdNxh7yuHJo4ZPvc3B/EUqCjcjJFFWaoacZzwaoUKHuTtLDm95jE0ka/8vGX8cdfsbvmr/l/yQXRKsNKz1dhg4uZFzKNNCHoZl+IU4Q39866/lWtFsCsWVi9ZQd8lEEbC4cBTfYXwkJPCaIat27VXBZ7Bsh93Rf4s26bM0Xh8qedn6lZt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAeitlLstPEf29pPGBMA6cmSZZmHUJmylCSZAa/xfls=;
 b=rXr7PALWthGN7ufisrnGiHQnA/AX1jLOpi+0uaTMcFrAGO6JgwjOJ9HfqHJRPGaFifq/yPXOI3FmNbWuhup6G6WZ2msJRmS4aSi2bRycjKboo3Kxh+ZeUc4eNvZ6clsY+YqkBK4MKFcp0ilHeRbXruWYyJ4TFYdm6uoUd7KQ+iHOTu+ez4DeQXWIUYhIOTc+T1ICPlIF+HRb7q9zX6ubQaG/kj/yV9jozqaleQEewLpIe6uGcp+L7YxYeQaBySzNWSYxrHGnPOcGkU8G6vMIw2rS5+H+jHqgcTj9dv0lbdTNGvFxqHb4rityuNiUiMqodVPhiKy0i0OZYPk5qZxYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAeitlLstPEf29pPGBMA6cmSZZmHUJmylCSZAa/xfls=;
 b=MwkxJagDzBqcY7B5W9papaUKqnth54oEGAz3IzfAKmv1g5DHJaZi3UQtm8r+oTg88+aDENCiih4EOR9hKWNpPpcZrbRS70ft1aLPvi91JgPh6/BWDDpkxSTWW8tZG4dr14Kvqyw9WNVsmJ/yW35yB1NDD3EJWODaBTDgppTMyq96/W9tliMceaxU+NhupMDrskBjkCDJKU75qGANj2ORBdXJs+TdpJJtjcY9fM1fq3Rqu04A44bTV7AXFuK/tEMC5a+jJ6XBlW6XFSSGeWQZRVJIlDZTY01q7w2IwdqAVbzw5K3+dPkZt9FGcnJHuhPc6t3oSPBAc+zIb2rTZdGNng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Fri, 27 Sep
 2024 15:29:56 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%4]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 15:29:56 +0000
Message-ID: <6fdc8e96-0535-460f-a2da-cd698cff8324@nvidia.com>
Date: Fri, 27 Sep 2024 16:28:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: dwmac-tegra: Fix link bring-up sequence
To: Thierry Reding <thierry.reding@gmail.com>,
 Paritosh Dixit <paritoshd@nvidia.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bhadram Varka <vbhadram@nvidia.com>,
 Revanth Kumar Uppala <ruppala@nvidia.com>, netdev@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20240923134410.2111640-1-paritoshd@nvidia.com>
 <qcdec6h776mb5vms54wksqmkoterxj4vt7tndtfppck2ao733t@nlhyy7yhwfgf>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <qcdec6h776mb5vms54wksqmkoterxj4vt7tndtfppck2ao733t@nlhyy7yhwfgf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0372.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::17) To DM8PR12MB5447.namprd12.prod.outlook.com
 (2603:10b6:8:36::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a28c3f-0c3c-4aa3-979b-08dcdf093d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHNha2JPZkZhME8ybVlSbnNETmY4WGpoUm9melZXRGRzUUxYRk0reGFvYlY4?=
 =?utf-8?B?U1o2VDhHWDZnb05qNVdCaEN2QWQrNVlkR2JXWkdpek1YNmQrSVVucWtiK0tx?=
 =?utf-8?B?blU0OFZ3WEIyckpBLzM1Q3U0bUkyVlg1MnBaV0pzTE44N25sczhtSEN0NHAz?=
 =?utf-8?B?SElMN3oxTUZtZmhhYTR1U09oUkU4MTRKTDhTZWIxL3lLaTM3M3pDKyswQ05E?=
 =?utf-8?B?ZnNoRThUVEpWcWU3TlIzNWZ1NHpMd3ZHTHpQRG9vWUJuc3pidmxEVm1aT2sy?=
 =?utf-8?B?ckxYNFBFb2pOT3Y2dDV2Njd5OVgzcVZrZTdlRGRNeldETUdkalJlQlNtc2xi?=
 =?utf-8?B?dHNwcnRTZ05FWVB2eTBmUytLQUlSdXNwR3FITWZ2bGljcG12TnZRaDc1ZkRa?=
 =?utf-8?B?KzAvK2JUdHJtbjZoMWpDN3ZCampRNG9FMTBDMVUwMG8vemcvMTgvdDhlT3BM?=
 =?utf-8?B?TU5xVmFIbURDbWQzRkZvRG45SFNsSHRGNWRQelRKZ0krKy9UTi96Qk9lbDM5?=
 =?utf-8?B?ekNYd3R0N2xEeHg5dFdUMWVWVjRSREUyM2pUdkpSbjAxWEd5d3ZPcW00blVP?=
 =?utf-8?B?RWFuU1p2TGl6TFJvNzI0V2Uxa1NyL3JKN0NOa052eXQ2SFFDMVdVQjNpMjV4?=
 =?utf-8?B?TTZCaFY3UzJWckFMbmNURG9tUXVYSkV6TVc1bmQrWWdxZUxkWElRQW0rK3ZB?=
 =?utf-8?B?cUxROHphT1FBZms5YXgrWFIrWWE2SmZNQTdpbklSUGlLb3MycXZOeFl0ZXNS?=
 =?utf-8?B?b3p4NlI0RTZhUG1NTlRtZno4RzVDUkF2YTZlL0k3Ni9xQ1FPVU5ZTUxUTFNt?=
 =?utf-8?B?ZHB4dXRqRW9GQlU1bEtwLzR0aS8xUExIT3QzRVE4K3pQN0hscm9XNUZZcExs?=
 =?utf-8?B?Z2llQzB3UXJ1NUV6Um5mZVVWSUo3NGFOVW5tWVE5STJQNG80bERPZzhxV2Ew?=
 =?utf-8?B?M0dEZEtkYnpKb0hHRkRrak1lUFlINTErc2dmbEZiSGsxRWFEZ0NCQ0duOC9z?=
 =?utf-8?B?ektaYzVHQy91S2NaelF3eVhraFlvcncwOExoV3p6R01yMVo3ZUM5dWxRWXEz?=
 =?utf-8?B?WmpCYllacERxczM0blkzUmJHeDBzRFZTVUdGd3lWZVgvdE1vWTVyT1RqeCtZ?=
 =?utf-8?B?Wnd1MEN5bWVDdlA0d2orSEJGYkh1aXlKZkpJOXA0Y25icVZBSFNxczZxc0Nq?=
 =?utf-8?B?ZUcrSmVWY0w1REhWUVA3TmwzTmtWTzkrcDdjZmYrRU8rdG1yVkp4OXMwaklY?=
 =?utf-8?B?S0ozbmpyUS9CL1lQc3BYREY1L2dEQmVyOThKalAySzZ0dmZlRDEzSXlwMkpy?=
 =?utf-8?B?b25ZUDVqeFk3dWxRVzJXUkMxVEJFWDd4T2gzaFR6eUFzb1BhWXFYUWd0bVl1?=
 =?utf-8?B?eXZqbFI4THdldXFpS3orRmpCQVFBcXdEN3JuV1VsdVlSOFlDdFcxbUZkT2s5?=
 =?utf-8?B?Zm1YcEp6TElNUnE2WkJCN1VIcERiYVROY0drNHR0UmxBVjJtQ0JkYU5YOGQ1?=
 =?utf-8?B?Q3pUc1l3STZNWlhKbjZpbzkydWh6MnBCNUdnRGlNR0xIb1NSUXExenNHc1Fi?=
 =?utf-8?B?WGlWYjVlOHd4Y0hYUjkrNTI3MjRKZnNwWVYwT3RkQVdmSnBpbGVYL0FpU2l1?=
 =?utf-8?B?Um9wcVFLZmo1R2hCdi9XbDA1VFVjd3BtcUI4L3dJRzEyTVFhOGNEZCtTWkZN?=
 =?utf-8?B?YjI5cUxnclY1K3FQWXVPYmdoV0FHM1phT205N2hwaFBhRVYwY1J6SC9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUxYSlVlaDlVeitFNGY2ZHJRaGx3WnBnRUtlOWtsSmNBcDdNdFRYNEQ5VTVX?=
 =?utf-8?B?bExuand2SWVxeFM0dnlqS3MzZTJIR1NmS3NBbjhlaWxjdTVnbnZETFVEeWJD?=
 =?utf-8?B?c3YrSGx2MHlHK3dwVHN1VlJOaEkzdXNkMVpINU52blpIN1NMME1vYjB0NFJp?=
 =?utf-8?B?UWlqUGZ0bjdLSWczb1ZYTEdxeHlWNFJzNTdkU0xBVGhZcXBWbWl1RnIySFU3?=
 =?utf-8?B?b09wTk1sbWc4WkFDWEtNUmtES0N2U3JTQjVPc2ZxUXA3czRzK0hSS3lYcGxo?=
 =?utf-8?B?RVgrNHFxTnl0WFU1U0FtdVlLZ2ZGQTBOU1QzOE5oekNPc24rS2w2SXFOME01?=
 =?utf-8?B?VVFuVW90NlYrSmhLTXk3RzR0Rk1jYlJ6QTdsTGN0bWNRczdOTFRMVk1qVUJD?=
 =?utf-8?B?RnlUdWRJMVdWeW9KWmMzVnRCYjdScE1pcVgwM1RwdEtHLzBHTUJKY2Q2Y1Iy?=
 =?utf-8?B?UU9tcXVaZXMzdVpKREFmd0R3bk5QVGRZM3hjUlF4M0lZanZabjhVTlNsc1Fi?=
 =?utf-8?B?R3ZEQ3NJUkJYcVZZaW0wQXZpR3l1cFpzSDA1MVQ5a3p6TjNaZWZYd3NuRk9n?=
 =?utf-8?B?eENqUEh4dnRieHMralpqUURVcGsrMUlXanIxL0ZTY2NtY2YvUjVuZDVyK2lN?=
 =?utf-8?B?WGhrK0pERE56WSs5dWNPZ3piOVU2cmZqZEc0KzRNNFJGbkVRRFM0OVV1cEs3?=
 =?utf-8?B?aDFKKzNWMDBNNDdQdDZsM1F5TW95QzAyend2Wmc5L2FSWUU4NnYvamp2Tkth?=
 =?utf-8?B?eFo2N2xRSGE2S2lTWkdFNjNwVGNGcjZkYVI5RXIxVWFpZUxZWUNCME5kSzVS?=
 =?utf-8?B?d2g1UlNtYUhtVTRDaXpIZm5uTlVrU21QOTE0UTdmZEVqVzE3Mnk5RlEvUFZw?=
 =?utf-8?B?SEdEb291MjZTQ04zS0Y1LzVlT2V0eVBJc3BvOGhWMnVlR29IZ3VrQjRoUHRZ?=
 =?utf-8?B?QjF1Zm5QWlVFbmw4bDlBQ3RtdWlHME4wN1pFeTNmclgxU244a0dmUnNqdi9Q?=
 =?utf-8?B?Y1daZjkrZlB5Z2lXUnhEN1hwMGlrblBZLy96TUlvK0RqeVF3SndHV3lLN2Fs?=
 =?utf-8?B?Tm1uRWJJeFJ6bkx2U1VlQlE1cG1HOGV1SzNodTF5Uy8vVVE0ZnVKc2FJdWVT?=
 =?utf-8?B?NkdGUG80cC9JTTlrdmRkelhFWVBlM3hWK0Y1S3ZNek1RbXdCNGtzc3EyOEVM?=
 =?utf-8?B?ZGJkYlU3Z1hPZkJvS011TytybXRTY0Fxa3JtVEY0UVFHQ29tQ2FDRFVraWtT?=
 =?utf-8?B?bEdUd254SU5BVGlmeXMxNFJob1gyWGEyaXVnWmZvS0VsUVpuRVhNb3AwUy9Y?=
 =?utf-8?B?TFBvYU54L0I3Q2hkckszRUl3L2RTRGVwQjc5TlFIdDNHOVNhSXJTOGNLUDdz?=
 =?utf-8?B?czZLWVRXcXVyK216cG05c0ZweWVrZXE2cXpqWXVxc1M4aWZzcDFoa0J6Ky9l?=
 =?utf-8?B?RjhRc01nTUppL1Z5empPWmw4U1Z2b2FaOC81WFNESExKVUpIckUxUUVJeGhP?=
 =?utf-8?B?SjJyMDlKUUl5cEF2TUxXaWlCYjcvcmlRU0FUNWtid0M5NmpjZHlSckFvZW9F?=
 =?utf-8?B?OEliTHg4bkZMM1F3ZE4vVHEyejRMb2tPMm1LTmRkVlJlYU1rKytQOVNlVlZw?=
 =?utf-8?B?ZWZyYkdVNVJCOEFFeUFISElnR2pIWDd2UFVualpleDg4OGh6b0t1ZXlHMCtj?=
 =?utf-8?B?ZU5XWktXNHpRZTBlcUFEa3JiNUFYcCtTd2tQRUp6UzJUYkQ1NCtEblZ5WFhE?=
 =?utf-8?B?VjNmWWxBMUVqVDJkaEtuNnc2MXE2YXErM2RJekxEdkF3MXdkUTZoT3NMTVVh?=
 =?utf-8?B?c2lZaFpWNTRtYUNObHJoTG5KNlFvVU8vYWdOL3U2eFF1SHJKTWhMMDR3S0I4?=
 =?utf-8?B?RktkcVA5ekZMMS80L3NXd0xZK0N4bDVLZEVyQnpYL0N0dzVUU2Fnc3Rnc05k?=
 =?utf-8?B?Z0lvQ2ZSeFFVaFJiTlBNTGU1Y2dHbEltNjE5OHBGT0k4NXVkd0ZmRW1lU3Va?=
 =?utf-8?B?WFF5b3Z4RExBS1pjS042WFNqRksvVTVIUzFuTzkwOGhPMlkycHQ0eU43WVpQ?=
 =?utf-8?B?QzdsSDZBRVNaNDZyTjY5eHRjZlJNNmxtK2U2enBVTDFZdkZDaE1JcENSckRj?=
 =?utf-8?B?dm5tR0RGcU5zdEpVSjR0aWduVkE3K29ubjlFRThFMldsbitMa1J1RGZGZU91?=
 =?utf-8?Q?zN5PDPVa85pVGmfCUDOBC0Wvnr7IL9QnW7UPYlZCOYz+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a28c3f-0c3c-4aa3-979b-08dcdf093d8e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:29:56.2310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+Xfa07W6ziIu+0nbxru2FyHzpwsj1KR2f3qNDKj9xFiZdHIflZ30KCM1cf0daQpW3fdDXmFZwBxeHpRhIMDeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235

Hi Thierry,

On 25/09/2024 14:40, Thierry Reding wrote:
> On Mon, Sep 23, 2024 at 09:44:10AM GMT, Paritosh Dixit wrote:
>> The Tegra MGBE driver sometimes fails to initialize, reporting the
>> following error, and as a result, it is unable to acquire an IP
>> address with DHCP:
>>
>>   tegra-mgbe 6800000.ethernet: timeout waiting for link to become ready
>>
>> As per the recommendation from the Tegra hardware design team, fix this
>> issue by:
>> - clearing the PHY_RDY bit before setting the CDR_RESET bit and then
>> setting PHY_RDY bit before clearing CDR_RESET bit. This ensures valid
>> data is present at UPHY RX inputs before starting the CDR lock.
> 
> Did you do any testing with only these changes and without the delays?
> Sounds to me like the sequence was blatantly wrong before, so maybe
> fixing that already fixes the issue?


Paritosh was able to confirm that the 30ms delay was the key one to 
fixing this specific issue. However, when we reviewed this with the 
design team the other delays and updates to the sequence were 
recommended. This has been implemented internally in the relevant 
drivers and so we wanted to align the upstream driver with this too. So 
we are trying to keep the sequence aligned.

>> - adding the required delays when bringing up the UPHY lane. Note we
>> need to use delays here because there is no alternative, such as
>> polling, for these cases.
> 
> One reason why I'm hoping that's enough is because ndelay() isn't great.
> For one it can return early, and it's also usually not very precise. If
> I look at the boot log on a Tegra234 device, the architecture timer (off
> of which the ndelay() implementation on arm64 runs) runs at 31.25 MHz so
> that gives us around 32 ns of precision.
> 
> On the other hand, some of these delays are fairly long for busy loops.
> I'm not too worried about those 50ns ones, but the 500ns is quite a long
> time (from the point of view of a CPU).
> 
> All in all, I wonder if we wouldn't be better off increasing these
> delays to the point where we can use usleep_range(). That will make
> the overall lane bringup slightly longer (though it should still be well
> below 1ms, so hardly noticeable from a user's perspective) but has the
> benefit of not blocking the CPU during this time.


Yes we can certainly increase the delay and use usleep_range() as you 
prefer. Let us know what you would recommend here.

Cheers,
Jon

-- 
nvpublic

