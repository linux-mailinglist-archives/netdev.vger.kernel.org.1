Return-Path: <netdev+bounces-230174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCE5BE5027
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656AB1885D11
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ADD2248A8;
	Thu, 16 Oct 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXLegvTA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850183346AA
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638389; cv=fail; b=D2JpZkeyutIaxL3z8zJGX2/GrwVBctwnmwYEkTQdR3sDWQ3Y3UUHCiDapGFitYVRf359XkEE9FUvl6abhWCubNuxrz4E+ZBLTpaEf63VhC5uwwGIUWUYvYy952uMVE9z+vaTLDe4ZvvgxaD0vp8LQFHKnr0adVRLDhPR6HgvXcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638389; c=relaxed/simple;
	bh=KweKhBX7Lzny91D8XIWSyuIvjqegvhA516de3Rps3lQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJM9JaCqctMms7hqExs584+o35XuTVZJzxfwrBD1woVfzUqiCIANwnsN4tDEFiXNppIy6OBgTYaeF5DLdNIdEcjvoiqzPHOnot5p7bTJQWg2700v8RDxcDVfW+HqnxVMj0x6ltNTLp62n09VfZeIs5DvTCFwUp0xqS51XAAQljo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXLegvTA; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760638388; x=1792174388;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=KweKhBX7Lzny91D8XIWSyuIvjqegvhA516de3Rps3lQ=;
  b=KXLegvTA+KVUqk8ghLAUlFQQh/oAK1RXDHW41iLYlzrz4syBHDqt4Uu+
   cCvMSbz8LOXGmp368KTidMwpXKAtiLYpviFO93Uk+sQ8OzG7bZz5LXC5k
   O5cdT/oKgA2ZBIl+Uw71plBAy6QF6kJYP1QysgmWC+JG8PobjaDaKCnBd
   3yMyl9iMpwgcPphDGGRimLGqcwIX9QXBWe45rARv7A0LTv/sffaTj02W/
   ubNcdLGjT7R3T4Uzlixvjc90A5Rw9H3NMMnZH6TuT4y0JbsOl5PAAhP3p
   y0Rcg5UaTBwz2L5OTaTKe49Pq7m5MbWmJwELEIrTKzPtLVR3wzU8a7WKy
   w==;
X-CSE-ConnectionGUID: 8hiDR8UeTJe9W2hXl6RZ1Q==
X-CSE-MsgGUID: LC57/atfSEezTqcpEtjbtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62937317"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="62937317"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 11:13:07 -0700
X-CSE-ConnectionGUID: Nwe38f1lSTmy1ur4waYkkw==
X-CSE-MsgGUID: qcwQqd+aT9KPKYmR/M6nlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="182320432"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 11:13:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 11:13:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 11:13:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 11:13:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE3axQhPNSbCC77hw0PNKraF1p6pg22pUWqzdd5/ieA8csxS3ANFa3Zfd4tYu65+HmfN5WAknXw5vzwE88gJ7WGJheZq9XZFOpcNq3lreZLCLz6sa9tOxwZcOasmm6CLtwCb319u6nUneseVNp/u0H5MR40R3O/ZLSHme5Q/QvRRUmLgJ3diqV3Uk+8ceXwlDFDx5iuaoB5YpxPy47M1skUvH3MU+CXuK0+m2bbg98xqtA+EDMJmdWGNQZrD4fey5PYMO01ynJJf2PhCxvE8wuih65UiEHXBwYB2xLaQA6GUiQHaQ0YgFsDBFfWpsZ1w7mGinsmEMqDrq2MSmFKogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KweKhBX7Lzny91D8XIWSyuIvjqegvhA516de3Rps3lQ=;
 b=kShca1UNzcvthHpGjs3GNzpCcCVjWTd7HgXz4PFv4esxHuIP90ZeETiiR94G5JM4IqHkhprthAfSI5U5G/51hUEvH7DwtR7GpDtJ23HQZC2rZWb4W1n/rsBLdVbXYdDQoqy+MXTbxv0RVbQgmTUtOTPLJUGHKpFhnMjukYoDtGv1Q6WVMaWoD5sAjZQdRPXzG4XheAuyN5I0VAZNsllZOwCCZJfl1h/xFv+jYynpdCKgsfmtiZncsZEbFUcAGUeGog27gPVevdPfenrhaJIrN3pnh7KZoHPGSU3HoVECFNjCoPeCNWxQBdSeuEACAcQmek4WaNx2gC4UrDh7XMm0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS4PPF07B018B9F.namprd11.prod.outlook.com (2603:10b6:f:fc02::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 18:13:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 18:13:02 +0000
Message-ID: <89d95051-3a72-4668-a1cc-2f22b990f63a@intel.com>
Date: Thu, 16 Oct 2025 11:13:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/7] cxgb4: convert to ndo_hwtstamp API
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Egor Pomozov
	<epomozov@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Dimitris
 Michailidis" <dmichail@fungible.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Simon
 Horman" <horms@kernel.org>, <netdev@vger.kernel.org>
References: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
 <20251016152515.3510991-6-vadim.fedorenko@linux.dev>
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
In-Reply-To: <20251016152515.3510991-6-vadim.fedorenko@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------jVevuLkRUn7kBifQF88eiSiK"
X-ClientProxiedBy: MW4PR04CA0282.namprd04.prod.outlook.com
 (2603:10b6:303:89::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS4PPF07B018B9F:EE_
X-MS-Office365-Filtering-Correlation-Id: 75781ab4-da7a-4362-159f-08de0cdfa566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amNmTFlRYUNPVkxHd1lCRmdCdGxXMXAzNzJuczBHQ216VGZPN29kb21PRFJ6?=
 =?utf-8?B?MWJhVEtIaWozNlo3b0FhL01DU0gvTzMyTXgxTWRTTFJ5VEppRU9lQTJsS2lV?=
 =?utf-8?B?MUNHYXNhVGFBY3lyRGdqZUNCVzFqY1BDRVo2OUg4MWVuNW5xQTJrYVlWMy9D?=
 =?utf-8?B?eVlqcy9HNGNkWWd2VVZaTWtEZDRzRDJmRUJkTkRiYkNyTzNCWitTTkZiN2Nw?=
 =?utf-8?B?TUJ3YTFibnhzR1Zuc3hvQXN1N3U0ODg0UThKUjlNY0R3VzVpYmdHN2RrVDZx?=
 =?utf-8?B?MkRhbTI0cGljVEgzUUcvNG9raWs1b0p4VWNoVTJyQjV0eXBzZXVoTUtuQTJZ?=
 =?utf-8?B?bEF4L08wTW5oZGVsV0JpVkxJUzROVll2UmNGM2tWT0M4dStSV0JwNko1bUhV?=
 =?utf-8?B?N2NrVGQraEt4Sm4zcXZrN1RqcGlZSW9UN3RLRUl0cjkrTDZyUk5WWFZSeVBF?=
 =?utf-8?B?VEdpLzJLWHVoOVpNL1VpTFdMMjE1VzJqSnVoVVBCbGJJTVdIaHlka0hkSmFT?=
 =?utf-8?B?NjNhQW5rQzM0SWFWNVByN0RCcmd3UmxjVk9tMzZQa3Q1S01pTGRsNHptbEY5?=
 =?utf-8?B?bjJ1MndYaERydkJybWE5VERuSVVQM0ZhR3F0aXY2T01wWjhSUWxOaE5WQldP?=
 =?utf-8?B?U2JJTlZoTkpqanhYSmI2RWdHTk4wNVFxdVBmeXhHNk5oa0ZZZTZ6Uno4bEYy?=
 =?utf-8?B?Rlo5R1pxTWlXQUgra2huNzZpZjdLT3ZGK3VsUnp1alZ0RzlnN2JqRkhpZDhE?=
 =?utf-8?B?RzY4SVAzTC9yUndTSk9oUURSNURQbFYrMnArcHprbndKWlFQZFZDNnJrbTFK?=
 =?utf-8?B?TjVBUU1ndzVKeXk0c3lOeWtER1lPNStGT2V4UE1ZaVRaMG9nRTdmZzB3Z2l1?=
 =?utf-8?B?YTNNRzNCbWpraFVYTG5CNXZQR3Nqek1yZGZ1N0JRNW1oamdaSUZjWktRYjRG?=
 =?utf-8?B?S20vMjNhQ3IxSDFNb0JBZGw2cTd3a3U1SXZoN2tSTExwNTdLcmovMHhSM21O?=
 =?utf-8?B?T0haTThtdThYQVNMWjE3VWE4NFN1T1BYcDNBOTBJVEF4K3B5VVVvdU9UcDd1?=
 =?utf-8?B?K2FpenRPaHE3cmNoVXh5SkJMV3B1VVBnVjd3b1JWUGpaNWVrenp5SnBjRmhk?=
 =?utf-8?B?MEY1ZzdhTUJ5QU1kS3NHdmJ1UEdzOUk5THRUV280cHJzWXc3VGNSSW5ISHpD?=
 =?utf-8?B?YzVMRkhWdEQxeUxsTFZ4dmMvV1VlRmZhY1NMTi9ibWEyaEFNc2VtMTU3K1Z4?=
 =?utf-8?B?eU1qOG1MaWFXR3pPdGxaUHBUVFV2ZEVnSkxONW0zQ2JMclgxMk1FZDd0aWdx?=
 =?utf-8?B?ZUxUNE5DT2F3OGZaU0FIdGpCQStCQTFQdHlGTlpaYnNhcVgvNWhvWmg0NXJq?=
 =?utf-8?B?Mm5KN3VaKzFzM00vaW9TUmFaYkhsbUpHdWJxR0hOYkxqZnlDT2JDNHdqampq?=
 =?utf-8?B?ZVhSbS96bS8wZGllK0xpSHJtelpEaDN5d2tyWTd2WXk3eUVidk52L2kwVkw2?=
 =?utf-8?B?MjZrNzczRzl0T01WaWNDVlJ0bjh4c3FER3Ric0ZSbjVPMTJaUmoyT3BGanJJ?=
 =?utf-8?B?eFNKcUFLWW5CRk1PNHdNMUFMa1g3UTZTNkJnTnVia1NDOStRTFdKNXBGWFFH?=
 =?utf-8?B?QnZIOWZxVHBsUDJkcStNS0VJWmk4dWJ2KzZ6c3hzTy9qcmVXNHo5TElSM3VC?=
 =?utf-8?B?ZUdwSkQyYjVHMTdoTlg0VExPR0lsYnpGTUROVkxuMytneHd3T29MTmluQVcr?=
 =?utf-8?B?MStPTGM1cDZJaUxpWU5mL0ptSWt5dlhxaVVQZWhnak9DM0FFeU1LNWtnTTdq?=
 =?utf-8?B?NHBLYlBKcHNMdk5iMzBMYmJLL0VDQ3ZpZElvNlQvd2ZRdERUNTF4RExrOHhG?=
 =?utf-8?B?bGFsRWtDRU9rYVZXMGJoSHdRREpmanJpalA0eGh5ZFl2NFNuYi9SQnNkUFB3?=
 =?utf-8?B?ajNUY3RRS0pEb20rRjBXZmJaenVwRlBuZmE0cWVEWEZEM3pDSjA0cWxTaW1p?=
 =?utf-8?Q?6o8r1j5m3wxZ4Q89lTbkP3W1NgYiyU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEE0UzJVVkVpaDN3bENGN1JtSzc2dDZpVnU5Z1RydThSTmFLaFIxUmFUWFlm?=
 =?utf-8?B?QkJlWko5TGtML3FWNG1GWEdBVlhySjA0a3BManoyWFJYV2dSUEFBcjVwdUtx?=
 =?utf-8?B?QmZaclVFRjlLekJXWnBDVGUxbmdLWlVxUExRcHc3NGljQ2hEZVZxK2ptenZr?=
 =?utf-8?B?ajB4ODNRWWZuanBZaHowSVBueDBHK1BaWllFSmk0em8xSVZEbHltbTRYTVJx?=
 =?utf-8?B?b243MTZKRU1oOGhNV0EyY0hUVFd0QkFEeFpEQmtQMEtCc0xrdG4rdEZvVkpP?=
 =?utf-8?B?N2hUNmFpbDREVWgwRWdhaWhjVUlVNGxGZ0VuNkJXZE1zcXhlaEpSUlNkdGVh?=
 =?utf-8?B?T1duMExpaDF6VlZicmgrMDdMaS9BK2xzb2lvWVM5WTdJTGU2TFpxYUwvaFh4?=
 =?utf-8?B?dnlXYkNrMGdqekZ5TC9ydW9RUVEyU2FwQnBxV0xJK2Q1R0s0dlR6QWJmdVNB?=
 =?utf-8?B?UVpKNlVSNkNxTGZhandQcUZNSDdJQ016MjhpMU8vZkF6RlZVQzd6bGJiSGhU?=
 =?utf-8?B?SWdRWmZIR3ZBVG9WVUFzQ2YvZWRVNUVUY2xSbGhtOENTSU43eWRqWlp5aXFD?=
 =?utf-8?B?cTRxUjFKZ1daTkI4dmhxSmZ2WkZQWkFpYzI5WmlMT2xoRW00eXBKb21DSFh1?=
 =?utf-8?B?eS94aFI1QnZka2huRjl0cFhyeHk5Nlp4N01PdnpPVkNwUDhkZE9jemhsdFA5?=
 =?utf-8?B?bVgwZGpkZk9jc2Y0YWhJT0cvczQ4NEZxZGtmZkRjdWpqUDRPWjEzVUlOc1BT?=
 =?utf-8?B?QXEvYkMzOFowK0JPTUw5QloycFlRcTUvZm5GR1dYNVM0bTAyRC9QNjhrRGNt?=
 =?utf-8?B?anBlUm1JVkNpUmpWbUF0Z05xVHp1czNucGo4bFFWcUx0TVdlT1UwQjYwWllh?=
 =?utf-8?B?Q0g5eElGRnBlWlRTVTFJOGFrbTI0YjdSU1RnOXQyMFRXL0NYN3NCa1lBT213?=
 =?utf-8?B?WlhqWHJqclhPdXNKb28zSkJzbnplYlBPbCtSUHZrenY2TGt4WEhiNDYybnhO?=
 =?utf-8?B?cTNZNG0rM0J1U3ZmVVZFOGZtaUJRMGVvZ2lsaXRtNmJTYjdaalZPMWlUdWQz?=
 =?utf-8?B?Ykd3Y2ZWVzFPU2h1VU95ckNZUDV5WHVGN2xmNkZSWkpYVStudk5MeXZzWFh6?=
 =?utf-8?B?M0dXaWhEeEN5WnlrczljNlFmajI1dVVQSHdzZlFrUmdlRS9acFdSNXpJMXJM?=
 =?utf-8?B?UlhiZ01pbExFRFV0d1YvcFBxNExXSElqakdMVmp4S0toUUFHMHhVcGI4SnV0?=
 =?utf-8?B?MWRBU3ZhY2VNYU5aWTVEYk04U0VOYU95MjVKRFNpcjN3c1MzSG5kQlZ1M2Q5?=
 =?utf-8?B?ZDdKRGtHZVZpZ0htVmdJTmdhRlpQYkhUU2E4bFRzbjRvMjQ5VVFqTVZOWkRy?=
 =?utf-8?B?dGg3cGUwVnhJOTZ4MVdUbkl5bitLQXhiWnJrOFRZanJsRzFMRzhVVEt3VnE4?=
 =?utf-8?B?S2VYZ0cwQlY2MmZvay8rbzJhREdqdGplRUVRb2lEWWhwWndaa2M5N1NYM2lz?=
 =?utf-8?B?dTFUSlVGZkJ3TWhXNGhUNkRTSy9FNnpubDd6L1lZRU9CZldmUWU2Nm9jZ0JM?=
 =?utf-8?B?SFBxMzlKWDkzZE9INEZ2L01SOE85QWRiYjBrMUJMdG1CWElhcHVMY09lU1pV?=
 =?utf-8?B?WUdYRXlKdFdPVlJvSHdIczVvWHBtVWRiemp4ZUkxWmRhZUczd2J6SUFLeCtL?=
 =?utf-8?B?emxFQTJiWGh3NzZxQUN1c0F3emN3RnVVUTJnQUdFZVF0RzhHa0x1dU1YY01v?=
 =?utf-8?B?clAyTlpGV24zemo5WjN5ZnVVMUlWL3pEcTd2RDdFcWE0blJaSU03V08xRHJn?=
 =?utf-8?B?UWRyVDN1a3NySkJrSlZ0ZzBYSXRibUc3U2hFNG5qeVZCTDlqVW1sZWdNSHhP?=
 =?utf-8?B?T0FOakhmSUhjUC8yZnNvUlQ3MGdCbDNxZ2dzSnFGbmlYUDlaVzYxallyWnRm?=
 =?utf-8?B?L0I2UWxuQktMN2dhZ3JEOEtWMEN2NytmSVFXWnNiSXFGZSs0ajBJUFhuVEQx?=
 =?utf-8?B?WVhPeWpwSEhVN1hOZ3lKTnprWU9PZTJvTzhOajlGM0w2ZzlnQXpreFVBSHZZ?=
 =?utf-8?B?TFlpaDJuM2p4NFBRZ2t2OG9hNGJOZlRoaTRjZHQzSjMrUkdVQk1QL254YnZT?=
 =?utf-8?B?RDdKL1BDNnRmakZ1OStYZ3ZhT0daTVJidkZJajgxaXlMdTFVL2dZUURRUXUv?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75781ab4-da7a-4362-159f-08de0cdfa566
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:13:02.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CebmVVaAcfvKS9YnZwC3AsKkw0p/KdK0UBh0j4h6pkDJeDuyhgnoC5adDWMgpZ+W7szOz5xXm1Lr3HyJTZvv2/zWTSSCMTgsAKofYWBwQWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF07B018B9F
X-OriginatorOrg: intel.com

--------------jVevuLkRUn7kBifQF88eiSiK
Content-Type: multipart/mixed; boundary="------------vRsj22QBs7gp0HXkebaSZhxW";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Message-ID: <89d95051-3a72-4668-a1cc-2f22b990f63a@intel.com>
Subject: Re: [PATCH net-next v3 5/7] cxgb4: convert to ndo_hwtstamp API
References: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
 <20251016152515.3510991-6-vadim.fedorenko@linux.dev>
In-Reply-To: <20251016152515.3510991-6-vadim.fedorenko@linux.dev>

--------------vRsj22QBs7gp0HXkebaSZhxW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/16/2025 8:25 AM, Vadim Fedorenko wrote:
> Convert to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
>=20
> There is some change in the logic as well. Previously, the driver was
> storing newly requested configuration regardless of whether it was
> applied or not. In case of request validation error, inconsistent
> configuration would be returned by the driver. New logic stores
> configuration only if was properly validated and applied. It brings the=

> consistency between reported and actual configuration.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------vRsj22QBs7gp0HXkebaSZhxW--

--------------jVevuLkRUn7kBifQF88eiSiK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPE1rQUDAAAAAAAKCRBqll0+bw8o6Byr
AQDKJXKS523O4J8eHt9TGkAYZSL5UV4kiYlBgs2A/ud8BwEAx5ODYgffi0UCGG+Gl6KAhr7FbTfX
7iaKUcJEHDiTsQ4=
=tn5J
-----END PGP SIGNATURE-----

--------------jVevuLkRUn7kBifQF88eiSiK--

