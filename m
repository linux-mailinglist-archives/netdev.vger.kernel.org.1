Return-Path: <netdev+bounces-212616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA9B2177B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F84190319F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124652E3B01;
	Mon, 11 Aug 2025 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKExgkCN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD328505F
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947917; cv=fail; b=cNx9gzS+TTRjzEx6O3+86YU4ceVRvbiECTIFXgCLL0i6NKDbeEDx9qkI0qadPYF739AuRMARjGzT0TMgdUyTa8Yt6dYkGoudtauyTaCdGfma8FAlwQKS5KI6rMHLi+7cu9uqtIUNUphac8eOxYfQAywpG91nsKEu04lAgFlUSGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947917; c=relaxed/simple;
	bh=oSqfoMJ2oCPgiLvZXD4ql8AKFG3zXE/GLjPopT2SlU4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YtJxvMrWnWlb2hh587dSy+QO7J7Voiy5rOY5JVtPCU7TVp2A0ZRzeHvvHTT2CgqvXHdPQ4E873emt74G9FyPvYagbItp2X+eLX/wddKrJghniMBvi+mQjVOYHLGFFCIdPlzgEIqQE89meFM+xitbtFrPdgHILydWAj7HucF4ex4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKExgkCN; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754947915; x=1786483915;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=oSqfoMJ2oCPgiLvZXD4ql8AKFG3zXE/GLjPopT2SlU4=;
  b=HKExgkCNrbro3yxXKOCd9oD3If7/GxwAjJlE44jYV5SRcaqVk1KTB+z6
   YNJYmz8txREIWKXWAEbEfMVjT4n5VxxpAPTlJiDPrxYeNZeNN0udpNghW
   gsSmzoJzlmuLlnKXa+xDKCYKSPi9dd48HJ1xNJJveafy013Ko8hPgOOnu
   dte4fEfVhXdxK/vPSHmCX3TaQIZL3xgxFvKLnwjvpnVlIpA2JOf2AhAMU
   wYRASEAnJ8TaXy0pBYm7xyYMOr3a1zFUH/4CIBtx9WHck1pO/ZXHGn1St
   WcS8M/G026ypZa+BcgP+Y5PvBctZX/RpzpNoAgXNxqxAz1rvDXlWlt+4a
   A==;
X-CSE-ConnectionGUID: wXZm/qqtTkKEacNi4++mpA==
X-CSE-MsgGUID: R99+Um2oRgWua2KlqPOsjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67480411"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="asc'?scan'208";a="67480411"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:31:55 -0700
X-CSE-ConnectionGUID: 0cd7P9clTK+ENFRxdFpHJA==
X-CSE-MsgGUID: birzj9tvRDiQxvi2pOcHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="asc'?scan'208";a="165220142"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:31:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:31:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 14:31:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:31:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfZmJWVYdi674ze3LZ/61a3wVueOwkkuH49dAVaguQyW7ZiEC/2moi4VdOhEOlzWiPoPg9OaQXQwe9h+EDYsl5gcIYsQOrsBLLg7kwA2f95t+WP3KoYuwifvUT/60sq6++KzG7ZUQ0VSoEuDTY8myDAVx7KlyYL2M2FtlwtS3Cu5qMMf+ZntrRCYjcO4qNuYhVUyQlj6UJZN/cVvoLYg9eIJW2L/Va5kOja5C3MiaQLWYZKIhcVtvX8bg3unj7cj/XSty2zK8wN1XSlb90MX3VXimh9lLI4YZw2UXNDrWBXgLxx7wXpx+rnzRDXtmW29Muf0PAOr4IJqz0dBw0bcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiE9KhhNaGL/5Mlf8tJVznne/SQgS/9cSo+A1VKi7Ao=;
 b=G6DAxLyt2mlEPn8X10j2LSrvnijZ5YL3NfucYI96IgjY7vMR6SbYZ+qM8+0vRv4t7aMkhfb1gWJNtJCieiVJDp8VlnP5WAi967PAv/E2QHACcIwsbklmeHnu3/64IPodPCi2HcxFHGay313XIMi00bA40m1O0GMsbRM5lITM4OO1rTz/3tC5Ih0j6pGuWu2tA8D0DoX72JBRtHNExx6fp8yK8U2LrXU/wUGXrFlZSgsVWcCVsKJelbJHh5lVXGo56DRjtLj7JbGOgsEX3CF9OQWO0th0VvpnU/tcpEf3lh47/1Dk/cp5pG4dG/4RRjkqN8Pmu0ha7nwOH+YndJvlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PPF9EFFC957B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 21:31:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 21:31:42 +0000
Message-ID: <c5b09040-0484-484c-a8b7-0675b97c3b9f@intel.com>
Date: Mon, 11 Aug 2025 14:31:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix incorrect counter for buffer allocation
 failures
To: Jason Xing <kerneljasonxing@gmail.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
CC: Michal Kubiak <michal.kubiak@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <maciej.fijalkowski@intel.com>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <anthony.l.nguyen@intel.com>
References: <20250808155310.1053477-1-michal.kubiak@intel.com>
 <f0752ae6-25f8-4504-b23b-052f60007deb@molgen.mpg.de>
 <CAL+tcoAwKcy-E6LkLhwvKA9+es5RuFmg4+kPZ8dV08-s-VopPA@mail.gmail.com>
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
In-Reply-To: <CAL+tcoAwKcy-E6LkLhwvKA9+es5RuFmg4+kPZ8dV08-s-VopPA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------0vG0lIf3u1bkZaz4KbhqOdGH"
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PPF9EFFC957B:EE_
X-MS-Office365-Filtering-Correlation-Id: a32fd8a5-71a2-459c-491b-08ddd91e76ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHdlMWRJc0tZSyszQWFocUVDZWZyemtHaG8wUjR6cmd3S1gwa3RzeDBFczMr?=
 =?utf-8?B?VFFWZFJVWXllUXJwVWRYaW1NRDd1ekxtVGxUM0F0bkd3bXkvNVYxSEVnMHFF?=
 =?utf-8?B?RndaMEdGODk3SENhZWs5b29MajJmV0VHSlhOYzk1OSs4aEhIdGJmaXNCc25o?=
 =?utf-8?B?OXpCeU1EYTZCMktMR3FmSktTT0JUU0N6QVBOaUNnL0cweXM5a0ZoeDFNVXIr?=
 =?utf-8?B?dk93VUV0Ti9LelNKeUJES21pYksvQzZPQ0tGb2pIY1VwaDk2b0c1QlZlekVv?=
 =?utf-8?B?WDFwUmc3TFBCUmkrMnJ3alpyekNja1lCbXdBdElWWHIvL3R0WHRWYWRGbEtV?=
 =?utf-8?B?QkcwdUtuSi9jbFJEOUN1UTUwSFk2VElxeW1SWURSVHNvWmFlRmRCUlhvdjhM?=
 =?utf-8?B?YmtaWGRVWVpxelBDNkRmc2VDeHNmNkZ4eTNoUnJNV1lJUEhWZ0NDZ3lkTDFh?=
 =?utf-8?B?V1NCSXRLTUdKaDU0b1RQYUFnc3BSbm9VUXp4VkdEZC92MjRzLzVJV0k1YlNs?=
 =?utf-8?B?d2x4MWtjVW1KK2xFMHBWdmNiNWk0MEd4TzZJTjQ4U3pWU1EwVnpUWWdmU2hw?=
 =?utf-8?B?bFYrMWRiVEU5M2FrU3AwS0RlVkJGZWZ0UXVQZVM1VXBGQnZVMWhXYU90ZFJV?=
 =?utf-8?B?VU53OHB4ZzZ2QmRVaC9uMFhHZzNSZ2R2NGs5Wk5TRUtGK1lQNXJ5L2lmU2RX?=
 =?utf-8?B?VGxzQjBEdUQ3eVlTRE56K1AydDVoWlhLRFljYTdsQmRvYkxnNDBmWDJRUlR2?=
 =?utf-8?B?T2ZxWG43cVZSbloyVGdjcUovazNPYW94M3VpcC96bkx4YlNSTW9KQ3VLK1lh?=
 =?utf-8?B?ZVUwNjA3eHNHMzNWN0VZeFJFeS9UMkNjMkxQWmpaUTFTWHdwSXgwRStRZzMx?=
 =?utf-8?B?TlFkSENseWQwaElZTlp6NUd5WkJxY2tnQlRmM0xGc2J0VFJldnhrVzQ3eU1W?=
 =?utf-8?B?Zkloa1BOR1ZmdUJPeERZc1dxbG1yM1pvOU9VVFBhaGJNNXlsVVBkL1ZLcmJy?=
 =?utf-8?B?T2hLTjRtbW5QbG0wczhUSDNyc3U1NTNSUkNUNWFJYjljWTZKSnpTQmREdGRZ?=
 =?utf-8?B?UmVTWUxhbHVaNVRIMlBqSm5WcE1BT2Z5TzloRElhZCthWDBNRG4ydnBxZnNr?=
 =?utf-8?B?VWtVRGRQcE40Z3pXR3RPeXZ0ZmpLdXdtQ3Y0OS9JQStrdElncUJoU3hPQTJQ?=
 =?utf-8?B?bHo5ZzVjejVNWk8raUdhNVlyWFlmZE9xRC9wOXpIL3pEdWh1MWlIZmFvWldm?=
 =?utf-8?B?aG43eHFDb3VHaEg4RUI1M3NlWW82NW9kS2ViNWx3bXVWS28xeUZtYi9nLzRa?=
 =?utf-8?B?aUFvMTZ5MUNqb0xNWi9qTlZXanBwMDM4R2RxL2g3RGR2VDRzR241NjRFcFlU?=
 =?utf-8?B?cTEwRlJmbkFpSlBLaXZNaFZUbEcyRG5NTjI5NzYyOFNJRVRCeGVJT1ZNUWF1?=
 =?utf-8?B?NzlaSVpPQ0dqNWJHd3lVcmtGdUlkZXVJaE1PWXZVZU93bURMYVFEQjVOb1Zt?=
 =?utf-8?B?T0s3R05Lbm10T0RpNlRwYTZGc05KYklCdC9FTzV6V2lVZHQ1ckoxQ1Zqb25T?=
 =?utf-8?B?bVB2SlNjUXlGbngyK0xYaENEcU1aSHQ2UXJMUDJKWVE1d2txMFRuN1VRQk4y?=
 =?utf-8?B?bEloa3dWQzBsc0tTQlVEdWg2VEY3QWw0WFg0c3ZzbndsU2V4V1RvMGh5WGs5?=
 =?utf-8?B?MzA5UHBuOG45a2ZCd3luN3Y3Q2k4VWFxNjJXVXJBWFN4c3Z1WWhzanRIdzZL?=
 =?utf-8?B?eUJzNC9kTUM5aXBHeThRYng5NXRMWHRQbnVDb0VySDhOOHp5QWI4UWF2U0tp?=
 =?utf-8?B?OGVlSDE3N3l2MHYwTUZqNjNPOThpV0NpK3dlbGdLeXZJbmd5R2RLanBOaFNB?=
 =?utf-8?B?enAxbGhlTVl1NjNZbFVNcmkzQS9jZ2l0cGNQR1RLbmk5dFB4MVZaejhTVUJT?=
 =?utf-8?Q?T3+wFF7HcBQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtYL2VXdnlFZm5jTDJraVFQM2hFUW01SzN1L3RzaGg3T3QxblE3VUM3S01Y?=
 =?utf-8?B?M1ZkRURuODl2TnZlT0ZsOG80Tk5XMmw0bXA5SUtTUHdBaXpLM0E3RFEwb0Z4?=
 =?utf-8?B?b3FERzVNVmowa2lkZHV6eXI2K3VlTDAvRmxmeE1EVXRSYWZRODlTL1Q3MmhY?=
 =?utf-8?B?SEZ0L3N5RXljQ0p4Vjh2M0UySXlyTUR5Tm5XTkRyblkyWUoyZjJERWc0SWNa?=
 =?utf-8?B?VGlTcXRPS1dibWpUVTZmUUpCZC9mR2pyUkkxR1E4N1BLMWJPNHZLMXdlUiti?=
 =?utf-8?B?QmxyM21iUk9MRTB2cU9EcC90OHRuTDJPaUdPL051dWVqcXNUbm1jUVZwdFBN?=
 =?utf-8?B?L2FIeFNGRFVIMzRXMWlabG9tMFFJS1RPcFp5ZlRMcDdaUTY0MjFqaENEZ3JP?=
 =?utf-8?B?NEFONlljV0t2ME9yZjlKTlRsUFhmQWxCZ0QrUEQ4S3ZMNnJXdzQxcGZxbFZh?=
 =?utf-8?B?dnVQU0V4ODV4K1pKVm9zMmFZUG9nZmU3cUVvMUpJNkxrN3VpdWtYc3Qrc3Vu?=
 =?utf-8?B?aU51bnhwYVpIc3FlVmRiNlZia1ZNckx5aGFDSXIwT3hEMXFlSW1pVmF6NUZv?=
 =?utf-8?B?TXQ5ekpzL2RVR2lHQ3RNQ0dhL3JzNWs3elRDVEp3M09GMzBlZml3OUVpQll6?=
 =?utf-8?B?QW9DY1dJSEJKZEQ3bDJxTlV6cjlMK0lTWjhOT0M0Vk4zSWNWVWNuK2FUNFMy?=
 =?utf-8?B?dlJ4VkgySFgydzExRnUrdGl2dmNLSFZDUURvRWFJWCtrekVBQ1RuNHFUeW1s?=
 =?utf-8?B?R2ZIUG93SkNOSjFFS1RjMml4cEJsTXNKNFJJcmV2UkQvZlQybkFYV1NMRm4z?=
 =?utf-8?B?R0VNM3F2emE1K1VxVUJWUTE2SFFvc3JkamhsMmNyeHBYdWxuTUZ3aUFUSkg2?=
 =?utf-8?B?RjY3NHByNGdmWUVIRTFIUzNWT1NGcU5WOGRYMk51RHp5b2lOdnRiMjVWaUND?=
 =?utf-8?B?MVQzQlhzU1VoV2lpYmRtWjMveVk0R1V1RENFa3UrVFJHRjFEYkdnYURKOUxx?=
 =?utf-8?B?SGhnRXF2d0FUYWFad0F5dzhEcDZJdHFMLzVUSmphaG5Oajg3MnZITDEyYlY3?=
 =?utf-8?B?b3VwTDB0N2dtcGM0N3IyM3Z4WXRyQTBEc3ZrRWpBR0RpU0NNdlVRZmFVKy9q?=
 =?utf-8?B?VlV6WUMwQ2JoZUplejJBa2FFclBvZUlNNUJ5aHVxa1NGc3VFRnh5eU5tZHFw?=
 =?utf-8?B?NGxwSHVvS0o4M3ZJeWhQb25lcUlJRlJtUWJxUVdUVlJKWmxWZE9BVDFyTEtF?=
 =?utf-8?B?cHZoaEk3MDBrd2FjWmtaK1VROXZFWXZNZDI0citIbHN4cGd1YUtPSWJJNGtI?=
 =?utf-8?B?YVdFRVNmVTZvOHVaUHZ2Qm10bEdvU2lINkpCQk1nQml5VmMyenRSZjJxK0oy?=
 =?utf-8?B?dmpncVZYMlZoREZzVHRoOHltaGhwNmhOaEpVaVNBK2RnSU5GRTRZVUtwdWE0?=
 =?utf-8?B?YWxvWS9PZXEwLzdYQnpWSENVUjgyeFE4YkpYZS9FUU5kR2RoenJlVmtnOC9v?=
 =?utf-8?B?cG1LNDA5RmJRT0hlVC9sc1JaTXNjYmJVRGpDM09RdkdZSHVHNlNsTzlFL1Rq?=
 =?utf-8?B?Q0hpY1IyWmFoMFo5YWx4TmJWZU9lY2JqcnpXMEM4RDI4a2VJYXFaZ3Vmd0lp?=
 =?utf-8?B?TDhiSmRIUUxmYWM0OWdKSXM5Y3dmc01VcUdwR2tlbzZoTkN1U1lrWWFOcWxh?=
 =?utf-8?B?SDd3bVd0bkRUWU9Mc3lPbHljc1liVU9IYlBLSEpZbzRKMFpiNWFwWEFIbFBh?=
 =?utf-8?B?cGtPRmFMN2d3bWJSZ2Ntbk9zVWFGeU44bnBEZ2RaK09IY2VzYUlZTGt6ZnVR?=
 =?utf-8?B?SDYvTHFyWWtURTZ5WFYxa241enEzTHBZS3U1cFUzRjQ2bnBETVVCemFST3VE?=
 =?utf-8?B?U1lYVTQ4OGd3UjUrbzV5UXhLd0gzazhjeThUd2NaQlprV1FicDJwZlNWUnVU?=
 =?utf-8?B?QXVsWHZISS9MQ2xRY0xYdFNqWVd2OXd2UEVJUzF5cDFzcm56dEdBSC9mRkdw?=
 =?utf-8?B?SnFQKytkblFxODFUcjN5WlA4VHp2MG1kM2Q1UmhMTHZnamdWb1FYUWJyaldy?=
 =?utf-8?B?bzJmVWxRNjBqMGNieDJuOE5KRlpGUWVRVXBMNGtKZXlicHY3d0tPbjRCYzFE?=
 =?utf-8?B?em4wUWlEUkdtY1Y4cWtpMjh6bXZ3c2VMWC8rdjJNTEJkWHZUZzM3SnFzUkxC?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a32fd8a5-71a2-459c-491b-08ddd91e76ab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:31:42.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VO08bZBA+0/7O3V2GmwdVVod13CajSFKelZ7YcDYhnegQcC6RhhP3Z60sgBHD80YuVmSna7zgGnnsRrd9gUeK7lqbupHd8VqF+EeLsH6b4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9EFFC957B
X-OriginatorOrg: intel.com

--------------0vG0lIf3u1bkZaz4KbhqOdGH
Content-Type: multipart/mixed; boundary="------------XsOxEf09HdJYwoRnz4ZDVQtc";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Michal Kubiak <michal.kubiak@intel.com>,
 intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com
Message-ID: <c5b09040-0484-484c-a8b7-0675b97c3b9f@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix incorrect counter for buffer allocation
 failures
References: <20250808155310.1053477-1-michal.kubiak@intel.com>
 <f0752ae6-25f8-4504-b23b-052f60007deb@molgen.mpg.de>
 <CAL+tcoAwKcy-E6LkLhwvKA9+es5RuFmg4+kPZ8dV08-s-VopPA@mail.gmail.com>
In-Reply-To: <CAL+tcoAwKcy-E6LkLhwvKA9+es5RuFmg4+kPZ8dV08-s-VopPA@mail.gmail.com>

--------------XsOxEf09HdJYwoRnz4ZDVQtc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/9/2025 6:08 AM, Jason Xing wrote:
> On Sat, Aug 9, 2025 at 5:38=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.=
de> wrote:
>>
>> Dear Michal,
>>
>>
>> Thank you for your patch.
>>
>>
>> Am 08.08.25 um 17:53 schrieb Michal Kubiak:
>>> Currently, the driver increments `alloc_page_failed` when buffer allo=
cation fails
>>> in `ice_clean_rx_irq()`. However, this counter is intended for page a=
llocation
>>> failures, not buffer allocation issues.
>>>
>>> This patch corrects the counter by incrementing `alloc_buf_failed` in=
stead,
>>> ensuring accurate statistics reporting for buffer allocation failures=
=2E
>>>
>>> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx sid=
e")
>>> Reported-by: Jacob Keller <jacob.e.keller@intel.com>
>>> Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>> Thank you, but I merely asked to send in the patch separately and didn=
=E2=80=99t
>> spot the error. So, I=E2=80=99d remove the tag, but you add the one at=
 the end.
>>
>>> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
>=20
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>=20
>>> ---
>>>   drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/=
ethernet/intel/ice/ice_txrx.c
>>> index 93907ab2eac7..1b1ebfd347ef 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
>>> @@ -1337,7 +1337,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring =
*rx_ring, int budget)
>>>                       skb =3D ice_construct_skb(rx_ring, xdp);
>>>               /* exit if we failed to retrieve a buffer */
>>>               if (!skb) {
>>> -                     rx_ring->ring_stats->rx_stats.alloc_page_failed=
++;
>>> +                     rx_ring->ring_stats->rx_stats.alloc_buf_failed+=
+;
>>>                       xdp_verdict =3D ICE_XDP_CONSUMED;
>>>               }
>>>               ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
>>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>>
>> Kind regards,
>>
>> Paul
>>
>>
>> PS: A little off-topic: As this code is present since v6.3-rc1, I
>> wonder, why this has not been causing any user visible issues in the
>> last two years. Can somebody explain this?
>>
>=20
> From my limited experience, upgrading to the new kernel (like v6.x) is
> not an easy thing. Plus not that many people monitor the driver
> counter on the machine with the ice driver loaded. Sometimes we
> neglect this error because it doesn't harm the real and overall
> workload even when the allocation fails. Things like this sometimes
> happen in other areas :)
>=20

Exactly this. An end user is unlikely to know the difference between the
buffer allocated vs page allocated failures. Even if they see the
counters going up, how would they know that the counter going up was a bu=
g?

This counter really is just for user visibility into a problem
occurring. Reporting the right counter is critical from a developer
perspective as we might use the fact that one but not the other is going
up in an attempt to isolate issues.. but the end user is unlikely to
ever notice without code inspection.

> Thanks,
> Jason
>=20


--------------XsOxEf09HdJYwoRnz4ZDVQtc--

--------------0vG0lIf3u1bkZaz4KbhqOdGH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaJphOwUDAAAAAAAKCRBqll0+bw8o6K97
AP9Vm/xBKi/RPIVwIKEYLcwiRHZ+VkfnjkYj/VSlq7xvoQEA9S76OlfogvvSg4JaB9+5jO8/pThH
yVnIErxQoX0agQQ=
=++sm
-----END PGP SIGNATURE-----

--------------0vG0lIf3u1bkZaz4KbhqOdGH--

