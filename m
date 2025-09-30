Return-Path: <netdev+bounces-227411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DEEBAED1B
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 01:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC617A3309
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576032D2490;
	Tue, 30 Sep 2025 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eD+6v8XQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738B2EAE3;
	Tue, 30 Sep 2025 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276762; cv=fail; b=Q+kqRenTm3YIuK8OAWRAuCJ6rWG5sTerW8HsFeD3Yp9RFvP6SRXWam4JIeXPmfIMZDWGDkpABTBUZDCO9L5yGZLMpwN7PN1xnK2RISjziSAtPZf8cWf/EZ+DFCCMzbY0LyigkYRRwpC9eRQm7SieGLrpFpKX5FseES7IwSJ3s/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276762; c=relaxed/simple;
	bh=pStBe3QeDB1LmRkJASDIiU07AXJhUwNZoaWHCp5bukI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F8GbA6//yJzlbkCVo6L13N+thE1Bi/leNUPuqnT6SyZhHJFdwQNSCKVUy7cw8TT/d3JGnB4S2b4YlxnuT9Ivr8XB2iWXAXrQq7rwtZLKBpCJwzzTmNifdddz6EVev70HIIN+elJCP21Z2IeFtxtBi0fmwV4rntvcVhfH++17p8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eD+6v8XQ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759276760; x=1790812760;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=pStBe3QeDB1LmRkJASDIiU07AXJhUwNZoaWHCp5bukI=;
  b=eD+6v8XQ1NYtLPrByhYAfYEVJHv+NSX72u9oHs/87wRTRj5+bitLn0iK
   NL+wLR+P7JC7iOYIev1Rr2Btio9w/RI2y7gL0BVv1n4NJAPjLAI8v6of+
   RsZwavigrRXEPOzoExLCKr9hVxAxtVXF/hzyo7GyQQtSlpmf/o8gNHTLy
   yGCsxEuNt3NE9/Ea4rESJlYqzbzyhQVTQVvnQHIlNI1XDdtMefYV9db6F
   oW2xBfsYUnIOsXSvlDyWyrRZFSxe6PwYOCta+oRkUgaAVZsLuTA7s2qQN
   tH/qljMtKkH4KEgo1x+4lSm7H/kW0wmxOIMJwdaZPGyRD7huCWROgywun
   g==;
X-CSE-ConnectionGUID: eR1bVOt3QXSeu03/fwpWwA==
X-CSE-MsgGUID: ZgPVdgB5ScaZL8TqS+d/wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61712545"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="asc'?scan'208";a="61712545"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 16:59:20 -0700
X-CSE-ConnectionGUID: jcra+L3sST+1K469vyiGRA==
X-CSE-MsgGUID: hv/r5eoNTNCW/rglwjBJuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="asc'?scan'208";a="183843374"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 16:59:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 16:59:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 16:59:18 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 16:59:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE7rKIZ1qnfC9IbNrFXuWB/cYK6E5OJzxIvUhpxbok7rXG9BRPx43qZn1N/ufhARCMGtw/RRD6KOSY1azf7FS3TCbigXfpy/xYEzeQpgYZjm+zMA6dwYTI0wL+JLAOn+YyMiPdzdxBNAXkaRUvOZTFcdYr7Gqwx8mhelvM1aHc1iEMSaoO4+B6l1CN8ZwTMgi63WHBBPB5Gd8HjuVW1ka2nKr1cEif7aocowZTwvu69q0c82LHO7eR43xJns6AbBK8TNZdQS9g+mbcMLDS5V0M8OQwaj9DRjKwcEgC4DFRAbXDV6Bl/Q9Cz15KeNFDxcmWn9h5dsQpK09CJDsEaBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRZUr+O1zcIouR10RmMMKiDX6BSupybEDd1QcsMSmXg=;
 b=rTDvPc/k6KOkcEmSBj74hynZ/WFe8h6PiYMgQxOOusIsRV4br/IG4IYZZxE9sZhfsoW87/vE7mpfaHWB9Q7AMOi+c25vcMNvaVms9jWwHfWWEOCeKRVSIqPcMDVIFucvL31RFWFN3JB+MdCZXwvDmGyo8x5nqRFbnsyN2kPuXeXdUUfZT0ejEOjZdOMo8AHdqEtlTV3W5qhZl8UixBDaAYFOGqu8lYWr9khD/+x0wtJJSmRB0uExZc5TBPa6TZbYvtZWSM4a45E9yN1CkKq7AsUKUJMpLbDhd5qCDCYcZA16sENZOh9xneRJ7sS4O7oConf5fGNnc0keDdbyOkbVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA3PR11MB9087.namprd11.prod.outlook.com (2603:10b6:208:57f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 23:59:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 23:59:08 +0000
Message-ID: <0cae855b-e842-47a1-9aaf-b2a297ec32d6@intel.com>
Date: Tue, 30 Sep 2025 16:59:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] net: ethernet: ti: Remove IS_ERR_OR_NULL checks
 for knav_dma_open_channel
To: Nishanth Menon <nm@ti.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>, Paolo Abeni <pabeni@redhat.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Santosh Shilimkar <ssantosh@kernel.org>, Simon Horman <horms@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-4-nm@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250930121609.158419-4-nm@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------uSBUrIRhQa0JwYPHSJ0QAmSX"
X-ClientProxiedBy: MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA3PR11MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8e9cb9-f1c5-454c-f534-08de007d580d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG9BZ296NHNRWHZ6cXlsTzd1VmNvS0dWMnluY3BMbHFNY2Q5NXFpVkhBODZN?=
 =?utf-8?B?UmRHdmlPMXJVQU03eURKS3hmbWFmWnNUc3dvTDNTNWs5WXlCWVlCS3U3LzNx?=
 =?utf-8?B?VDJjZ0prT3I1RDFBVGdmaTBzbTdtbGJ6OFhVR09VMTIxMzRaM0RJYVE1YVNs?=
 =?utf-8?B?Ui9UQnQ2aWJEcXNvVDcvSlI5NStkcWkvLzA5cGFPenhIT2FBcUlHd0pxSmZP?=
 =?utf-8?B?WGNha2d1K3E1Zm5peGlKVU9Nb0JPdG01dE9wS2dHSC84dEZiaHBBczllOTNF?=
 =?utf-8?B?RXhBaXBtMUZ2OUNBRHNuK1hFWWpoZnNVNFVEY0c1VnJuMXo3TGxXdXNGR0lu?=
 =?utf-8?B?dm5teUtJRCtQd3ZwbjFKRWsvdWRQbFlEQXAvdmh5MFA2MkpuMHN2REF1aS9j?=
 =?utf-8?B?aTZmVkdQU2dtYVJjTWN1L0o0RkU2RXFZNGg2Q3IzREdPSXltWnA4N0dwcGFD?=
 =?utf-8?B?bHZWRzk0bXlCaDRScUkwRkVEMENjMmhJSDBnMldJSVhtWXVqTm5mN2gyUzZ2?=
 =?utf-8?B?eGF0REVFRUtZaHpGcXFCR0ZUbzZxUWJUZ25wYUZyT1o4V3dxVlByTkJuQlhS?=
 =?utf-8?B?eThTb21LN0RncnpiMEsvRTM3bmpQUW1QdzhhbWcreklJTGFRbGwra3BBb3lK?=
 =?utf-8?B?NVpHM1psZlUyalZIOGRkdEt2bFYyQjA2R3Z1c0s3dlQweTJJYlJvTENBaXMy?=
 =?utf-8?B?L0dMNFBDdVRvNnNMSHhDd2R6Q3R6K29SaDgvYkY1eDhWbWFzUnZvUnRFVUE2?=
 =?utf-8?B?djU1VFZGYmQzZEc1WGpVVnVVbGRNZUl4UDc2ZlBFMEF6VWMwZHMzMTVoV3pr?=
 =?utf-8?B?TGtuU3czb0FWUUVaaEhQU1VBUGo3bXYwYjlMUzFKOHE4MVlQSFdqTW9aZVl5?=
 =?utf-8?B?Ym9rMEpYOHQzdmNiTi8rVlZQT0EvMWhKMmpic0hjbURIUnBIeTlBaVh4RUpw?=
 =?utf-8?B?dmFZRlZoNVgxQ2htN055M011cGFyeTNOY1NjQ1hBUUhIWm9LcmgzMmlxZkhw?=
 =?utf-8?B?NG1ZRjh3U3lVYmRnUCsrZzRmc1licVU4SU4yUGxFcFFQdjV3bVJYcUVxcE0x?=
 =?utf-8?B?alNiS25PUFFFZHpGMUcrcHZSREdTcnp6azB3dnd1L05qODVjOUcwclc0SS9h?=
 =?utf-8?B?SEc2Vyt3T1UrQ01yVUg3R0txRHBWMzhOL2dwODNFelE3b3NYR2l6aG9VU1px?=
 =?utf-8?B?dUo1TzJGYUdzeGd5cEY2c2FCdFNPanIzTCs4UkFzTTNYdmkvTWtzWGptaVc2?=
 =?utf-8?B?ZUd1Yi8vYndWTjI5Y3BENEUrY3VoVXNOaUUybGZuMkZXUzcwZVdyT0Q0QzIr?=
 =?utf-8?B?TTJkM0U5SnFrQzhuY3dPekhTSUdVcTViL3pyaGFwK3pyeEhLSEppeXpZM2F6?=
 =?utf-8?B?Rm9TSjZheXk1SEVoTXREQ2ZVUVM1ZWg2aUNqdllHSmxTMXh3dVVqRjd0QWRo?=
 =?utf-8?B?eFpkQW05TUppalh0VmthMGhIa2U4dHhQWUdMckRYbXZrdEsrQ1hiZm10eEFO?=
 =?utf-8?B?QzJoOEpERDAySDVFUmNScGJ4TWt6WmVxT3ZrUTErZ1lyVUJzQVM0amtUcnY1?=
 =?utf-8?B?NmZhamZ4cDhIMWN3blUxVElwTXpPM1VkalovOXZiUGw2ZktqK0FNWkxCN1lr?=
 =?utf-8?B?WEtiV3F1VC9QMDVYSTlkT05GcFZ6cDZiZkxudmVkZ1R0RmZaVlZGdldTMTA3?=
 =?utf-8?B?bjlsMDZrWEdkdWhRYWdad09BVWczTXZyMGxxM3dlY1c5Mzk0NUNOVWc4U0U0?=
 =?utf-8?B?c29kWi9NT0Rmb3FnSnBhVEczNEUyZUhKS2R6OUZqelg0eXp2S1FubjRaVndF?=
 =?utf-8?B?SXlWbzlVdHVmRmcwemNUL3UycWgzNHRXblRGSUJ5bWNKcjBTQXhWSXpLOXYy?=
 =?utf-8?B?MkM3Y0Y4Y0cwMzlvNG9xTE9KYjJMQ1Z4S25UMzNvRy9QSWNIc2lRV3d5TzdW?=
 =?utf-8?B?ZHVSWFhUYU1yNXJhK1BWY283RmlaZmZRMjdpeEhKKys3d1BQSWJvdUo4aEE5?=
 =?utf-8?B?WUttTndsZzRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajNIMFlyUXZod21FZENFbXpZUXJoa2trMENXZzgyMmtCc3BObjBzN3VlMEth?=
 =?utf-8?B?VUxuN3JMc012S1JsSy9XbkRGZUJlRTZJMDIwdlFqeGZNdkxHVW9zRXZNMEVl?=
 =?utf-8?B?bTZPK3U5Q1p5bk50VmtZb0lxaE9KMzAyOEpDSCtrUlZGQytrbnRlWU1HWi91?=
 =?utf-8?B?cDdkemNLRjlQcE1JNGtxZWhUK2gzMGJ5d21IWHZBOVlERWNPNFBtWWhVNFdI?=
 =?utf-8?B?U2NEallJQ2RtZDlLclh1WG5VdUxodXkrUllGa1d2d0xQbGJIYnBFTjc2ZUFz?=
 =?utf-8?B?MVJMTnBVek5TZllHTFIrYURXWlFuMEhtSXhDWDRLWTRKMEpURWF1dThqZTFY?=
 =?utf-8?B?VENuNThQWGtoN2MrdnlYbWZGUjFNU0dCL1pUYUNnRkpldSs2RFAvWmxKRHJs?=
 =?utf-8?B?OXRVZ0NldEsrMS92MllmeXdwTXhDOUQxRTBRQXdISnMyeTF6dDdaY2ZRaW1i?=
 =?utf-8?B?SmJzb2hqWTYzMkx4RktmSldMVWxLb1ErSTlXK3BJVjFCY3Z3V2dnT2J4enE1?=
 =?utf-8?B?aDZWRkRXQ2JhVjhZa2V2NkZMSTJ1M2lGUW1EczVualZoZVd4a1ZlaXhpUUhl?=
 =?utf-8?B?M0ZZOXFmdm1OdlJhMGpVM2tOcS8ya1h5R3hMOWd2M2dUd09BRXlNQzJKOVJX?=
 =?utf-8?B?TkZSaUJZT096b3o2aHROd2tzRE5WWHMzRTczd0dWQytKd1hZcVRYYW8xR2tM?=
 =?utf-8?B?bFpzbkFaVkFxV00raW03ekZsTTdGc1BuZ1cwWjBTaG5FL2lONHZVMUhNalgy?=
 =?utf-8?B?RlBIZU1OZTFQME9FY2IxekdMQTZmTnFVT2p3d2NROGNuYUpGUit5ajNqRkZp?=
 =?utf-8?B?eXlXSUMrVDJxMTRrWSs2a0c2aDVKVUxGZFdyMDlyekVRdlV3c3gzNTVMZGZN?=
 =?utf-8?B?SFdDR1E0U1RQSFJ4TFdoMUlZcEZqZ1hqcFdWNXNBV085empRUjJCTHRiYWVt?=
 =?utf-8?B?clFjR0h5U2hWRzBoNDlybU5tRUFwN1ViY0VzemJJc2U4U1hsNGQ4Y0oyUkky?=
 =?utf-8?B?cmRVU0JjT1NOYzRoVmRISVloMCtEOFhlTk9udTM3TkdTcTRiNVFJTjJRMEdX?=
 =?utf-8?B?ekJVdkQ0SnlRT0RHWmlTUS9lcUpZZlp4QzczdWdRTWVLZlRvdEFHU3REckRt?=
 =?utf-8?B?U0g1eUlDMjE4ZmFZeW5oemFXQ0NJNFFxVnJuRDliUzRaaFI2elliaXV0QTdy?=
 =?utf-8?B?R0NwNVN3NWxTbFRlUS9CWnRxTi81T0Y0SVdWc2VsVnV6N3VMb1M5eVZpUWp6?=
 =?utf-8?B?dmpnRyt0UGhNVFJBY2tvS21Ec21DaVA5Sk8vZ2x6T0Q1VG0zWmFBWGVFbTAx?=
 =?utf-8?B?N3hsRGpLclZid1lCdTg3THE0SGh6YVZNbDY2SCsxb2drb21DTVZ1TXNFN3JS?=
 =?utf-8?B?S3JHR1ZQK3NxbjdpZHF4aGlXbU9mR2xnVExOMW9YdzdFWkM3UUw1TXVxZUZR?=
 =?utf-8?B?ZzNmcTAxRXRUeXRwNGY1VmlNNEFSeHlaR2JkSVd6dUI3ZDJFNGFhZ25WNFl6?=
 =?utf-8?B?WWFobGtMZ2FBWWkvL3cwMmQ4VTlPSlNLdmpJejFSMm5OYmVvZ2drMFVwZ05k?=
 =?utf-8?B?Nzd4Nk1TQW5yYWppcCtvdGNRSHJZYnljOC9SY2tIbGJtOU1OK0dVMVNwWUJF?=
 =?utf-8?B?bG5hNHNKRzNKREw0aU5teldYTTVXVFI5ck5MZmdpQ21WNVJ3SDJ3TmtYZ25i?=
 =?utf-8?B?eTRXT29pK0NYZzhTYm9mU3l3MkFvVDNvYXBoUFpVcGNDc0xQUFdEQTdIZnRl?=
 =?utf-8?B?L0xYekdON1pRd0RobTdMbEIrM2tsZEFHQkJYOTlKNEVySmtmQldGbXpTN3Jn?=
 =?utf-8?B?cXNBRHNLTnM3M0QwWGQ4UXprRmlRR2FtVmtFYnhVdU1nL3lmV1ZZbFNPTXF6?=
 =?utf-8?B?VlRpaU54M1U4OG5YTk5mZXNaaFRpcDFrWHZGZ3dnd2t0cHFSS2hLd3hoUGtk?=
 =?utf-8?B?ZUxFMlNmZXRURERIc2NHckJtcldzdDN3WU9hcWE2bkZKeGZqY2lCUnp5RExJ?=
 =?utf-8?B?bXpsQkNveUxQU0ZFY2xubWl0N2YxUzMvR2FjN2JQR2xCSGFWcGE0UWY3OWc3?=
 =?utf-8?B?R2VxNUlydUkvT2FVYzNQYm4wdkNmM09UVElQbXNiTnB1WVhzOXppalQvV2ZY?=
 =?utf-8?B?Qi9KcUk0Nllud0dmZFJBaFJkcDcrcWcrTC9kc3JzVG1oYmE4QnVLMHBJVFlJ?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8e9cb9-f1c5-454c-f534-08de007d580d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 23:59:08.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDxNCk+l/qgv2ppwPmyBJhQl5jWyBQ6lnjnC4dOTHnkbMg5O6dzRXK21yhycfERmHFuMhYAEi6GN5QfrYdhhcJh9crUSXdm7chmV2f79I3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9087
X-OriginatorOrg: intel.com

--------------uSBUrIRhQa0JwYPHSJ0QAmSX
Content-Type: multipart/mixed; boundary="------------EOaqb7R37ssZdl5JCHcJHaOK";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Nishanth Menon <nm@ti.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Simon Horman <horms@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Message-ID: <0cae855b-e842-47a1-9aaf-b2a297ec32d6@intel.com>
Subject: Re: [PATCH V2 3/3] net: ethernet: ti: Remove IS_ERR_OR_NULL checks
 for knav_dma_open_channel
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-4-nm@ti.com>
In-Reply-To: <20250930121609.158419-4-nm@ti.com>

--------------EOaqb7R37ssZdl5JCHcJHaOK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/30/2025 5:16 AM, Nishanth Menon wrote:
> knav_dma_open_channel now only returns NULL on failure instead of error=

> pointers. Replace IS_ERR_OR_NULL checks with simple NULL checks.
>=20
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in V2:
> * renewed version
> * Dropped the fixes since code refactoring was involved.
>=20

Whats the justification for splitting this apart from patch 1 of 3?

It seems like we ought to just do all this in a single patch. I don't
see the value in splitting this apart into 3 patches, unless someone
else on the list thinks it is valuable.

> V1: https://lore.kernel.org/all/20250926150853.2907028-1-nm@ti.com/
>=20
>  drivers/net/ethernet/ti/netcp_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/etherne=
t/ti/netcp_core.c
> index 2f9d26c791e3..5ee13db568f0 100644
> --- a/drivers/net/ethernet/ti/netcp_core.c
> +++ b/drivers/net/ethernet/ti/netcp_core.c
> @@ -1338,7 +1338,7 @@ int netcp_txpipe_open(struct netcp_tx_pipe *tx_pi=
pe)
> =20
>  	tx_pipe->dma_channel =3D knav_dma_open_channel(dev,
>  				tx_pipe->dma_chan_name, &config);
> -	if (IS_ERR_OR_NULL(tx_pipe->dma_channel)) {
> +	if (!tx_pipe->dma_channel) {
>  		dev_err(dev, "failed opening tx chan(%s)\n",
>  			tx_pipe->dma_chan_name);
>  		ret =3D -EINVAL;
> @@ -1359,7 +1359,7 @@ int netcp_txpipe_open(struct netcp_tx_pipe *tx_pi=
pe)
>  	return 0;
> =20
>  err:
> -	if (!IS_ERR_OR_NULL(tx_pipe->dma_channel))
> +	if (tx_pipe->dma_channel)
>  		knav_dma_close_channel(tx_pipe->dma_channel);
>  	tx_pipe->dma_channel =3D NULL;
>  	return ret;
> @@ -1678,7 +1678,7 @@ static int netcp_setup_navigator_resources(struct=
 net_device *ndev)
> =20
>  	netcp->rx_channel =3D knav_dma_open_channel(netcp->netcp_device->devi=
ce,
>  					netcp->dma_chan_name, &config);
> -	if (IS_ERR_OR_NULL(netcp->rx_channel)) {
> +	if (!netcp->rx_channel) {
>  		dev_err(netcp->ndev_dev, "failed opening rx chan(%s\n",
>  			netcp->dma_chan_name);
>  		ret =3D -EINVAL;


--------------EOaqb7R37ssZdl5JCHcJHaOK--

--------------uSBUrIRhQa0JwYPHSJ0QAmSX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaNxuygUDAAAAAAAKCRBqll0+bw8o6O/8
AQCc/r/7/sfI6HkT3/74oxgeaWB5p7BFpxkgmdV8DaTRWAEAksYTFGGgrYZei9dMorDoAxS4t2Qu
AfdfmAXTsSSH4wE=
=RxOt
-----END PGP SIGNATURE-----

--------------uSBUrIRhQa0JwYPHSJ0QAmSX--

