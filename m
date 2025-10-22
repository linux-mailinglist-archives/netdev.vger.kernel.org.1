Return-Path: <netdev+bounces-231913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C5BFE9A5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051AD188B8D2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790FE26F292;
	Wed, 22 Oct 2025 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcgz6FPN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614121ABB1;
	Wed, 22 Oct 2025 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176769; cv=fail; b=ZgFGblI2ttOItB5jdfQfAK4Mc9sQP4LScxQg3PYPLADXuKeBNRt2BjOzfy72/PC/nnepNrJmqPFFOSuacEyC8ggVvEi7Denip7S0LoNtZhUSl0vk6w2c43s/V7ymm1hbmEh4OCHCiUM8miHbW+wD1gRPwc0g9nqW8gRQiLz4T2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176769; c=relaxed/simple;
	bh=ADJsf2CfOSWXkB67ku4AOf5txKq4lKIkeYlKkp5BCW4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fam7+QDrNCqOS2221MvdhWaU0SfMLsQrluPSeBwYLd2QAGf78njlRM2e0iTaeX6qcjWi3AM3JCPL6ooYOu47pfbFUMMfdyaKSq6a3w/Hjpgsg9ZA+BXuGguf7olsi8m0tUqwUVCEeVw3RIYO7tZkHTNeFUCIceoQO88scyaSnLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcgz6FPN; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761176767; x=1792712767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=ADJsf2CfOSWXkB67ku4AOf5txKq4lKIkeYlKkp5BCW4=;
  b=lcgz6FPNwmIwieS8HvCiabspmxqk/tIEO1QUBHfDxMWc2mJl870NCTef
   jiZOF+k9hm7e2+6fmBTPd6S+ZH3s98WdFV0kRmVIunwui+To4vAquBb6S
   d3vBcwV/LkfExG4kkFGy9DsFoeGjY5uHa3l/tI/cZrUWSjQmgRwTklxyz
   3ogNKvtJ/xWgb+LkfioeTXRHMdj+dPO4W3HMWIG9G1TToYqTrWTe5nXtg
   rFKkZvdIHDkzkoLARKROptUpV3nYiMwVs2XTIKA192Y/Tn0sajzIckgCT
   NO7VSuCTnFBof9SdJB6M2894OpJfDgoC4ZVH/XKqGK60vPDVijGKvk/Dj
   Q==;
X-CSE-ConnectionGUID: JxnyBEL4SeKnqu67+cdXBQ==
X-CSE-MsgGUID: KxPDNNuYTNeiWQugb0abHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62547395"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="asc'?scan'208";a="62547395"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 16:46:06 -0700
X-CSE-ConnectionGUID: knWFv4URR5C2pwTMrQElWg==
X-CSE-MsgGUID: 2KihSjskQK6+JEyRoruamQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="asc'?scan'208";a="189130732"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 16:46:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 16:46:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 16:46:04 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 16:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWt6/GMaGvGAZVVSXF/XcUeI87L4BWlrXmGUoHf8UwdIM9wrUhuFFPaTdL9jb9DZXHSrGapkRcY7tK1TkMN1lR+SptcBg76uypEdFHguGK9qtfigLejYkxEHaXgYBmTfjQ6YiUx5AEeRpfb3hDMg0yTBVBx3o5P+Zw68PzfX4c9nnlQx9/JRaPcJk6O73l/vbusunhAswhye9ZZd/nNJ/F1r0xTEkmlNLfncfiLWPy3RQUewo4QM+ZmeQvwrMYq0yBQAm058runEeAsYRvgim9PtBPfaGWZ0thalvt0YGxwKeLFKhkKshmOxhvlga8oCeQyYopXqHSpCtYJ7Z7uNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mIR3BJi2Zk2p49478emrs7bkJIpsVUMFc0a1X6eLpw=;
 b=t9+571TqaUcnBF3KBmlIGauy5uz9omlU+9BNGE1L6Pn9zQMxAJs9M/n32hgZ4CLv6LPSM8rXmFFI0nLZxIjrhYgV4zwfjlxsZexcrsOX5CTuynAXx+Wi/EnAqtcXGnbxuyhuPuWiXk5N1nPu5frW9UOyiE+11u4QAT9Be4ftO28KsfcdagUTUrl4e+ex6vhzXewJx1x/+Dg9xleU7EKuCmVfHtxQJvXHC9yyKd8t2HjhMhWTwRVEWwaxowoB0gMQKR2svcAYVM61POA0kNQX2mUwwIfsoWD7NUyuAtBghEU2LVMw4+exdEmCIhXxLMqtpJPpSIaa4TuYWVVO6fUgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB8142.namprd11.prod.outlook.com (2603:10b6:610:18c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 23:46:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 23:46:02 +0000
Message-ID: <417c677f-268a-4163-b07e-deea8f9b9b40@intel.com>
Date: Wed, 22 Oct 2025 16:46:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next PATCH 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: I Viswanath <viswanathiyyappan@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <sdf@fomichev.me>, <kuniyu@google.com>,
	<ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
	<andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
	<david.hunter.linux@gmail.com>, <khalid@kernel.org>
References: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
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
In-Reply-To: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------k1KrFz0aLHN5G48Le3h9yk6e"
X-ClientProxiedBy: MW4PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:303:6a::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: b6afe578-c67c-4778-2f58-08de11c52870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1BnWDFQUHJCVXB6QjVjckU0SHI4V0NCcHU2cmxRYzl3ZjgzSmRUaXpSUzBx?=
 =?utf-8?B?YUhvYUlIQ2diUzZBb010Vm9oMy9HYUUzR1lGQkQxRVNLbmdWVzdIY1d3RjZN?=
 =?utf-8?B?V2YvV01ObkEzMXlWMGc4aXcyZ2RFS0hkdlVZVDBmcWR5aDRadzFOSERjUWZ4?=
 =?utf-8?B?UndaL0l3UzJlMlh0Z0trVUk0N3BTbEtGZlk3Mlpqem8xOThUalVqcTU2czBr?=
 =?utf-8?B?YzRLZTdYbE9BMHZveEJ0dFY5NjY1eGwvUG5NZXdtSTBIdmJvamcwSlprWHBG?=
 =?utf-8?B?czNUS1RnV1ltZVJhTGJZcEh2dC9TVW4reFkzVWN2MkZVbWZCekhjUHE3RWE0?=
 =?utf-8?B?L21yRTdLNXd2dHAxWkpjU3VSb1VnT2JSM2h6Y1NLM0pZUlpxSFM1QlpaOUtW?=
 =?utf-8?B?VUkvcEVMTzhZU0VRaG5NV2tUUE5OL1lxaDgxNU1DTFVjOVBCekZWS0hHV3dQ?=
 =?utf-8?B?NFkzdFdnSlhLSUpCcFJYenV0ckwwNldFNVhqUmpPVzR2cHhWdTl0NHBSdyto?=
 =?utf-8?B?Y0tUVzRhM01CK3VDVWRjZlFCU3ltZC9NTEI5RTlqSkxuMHFNTUF2a002K3ZH?=
 =?utf-8?B?SFloZlBBMUFiZS9ubFJ6NkNsNjgxNklOdlVpc2E1M0dZdjVobFZtd0ZJU3lY?=
 =?utf-8?B?QlFncnZrcW5RSWZDZXdaMnJQRFhlV2grRjh4VjQ1d3FjRGdZeTZNVU5qZXlR?=
 =?utf-8?B?SEZBcndEUU82aDFuT1ltRE5PYVlVZVZKS21MUm5CdjJLVitzYWJXYlBBWXFj?=
 =?utf-8?B?d3dPWGM5S0xjRXAwSkt0NFpzdkF0YXkzUllpa0hIS3dVampTa0lrWHQxb3lQ?=
 =?utf-8?B?dUowNlc2MDlxMXpNRFJWeGlnVjhsNGgvRHoySm9sM1B2bFFYLzBEWDJWMlE0?=
 =?utf-8?B?d3ZaaTZ0QjJpQXo5TFljanh0NXNDcmZwLzRicTRIbjhBYVl0SUo3RktrOVdR?=
 =?utf-8?B?Q0xjbnpaMW5mWitqa3NGc1QrVlp0N0FnZmM0UmZUSWZHTlZmblZiUjBlZGRH?=
 =?utf-8?B?UXE3RUdhdGc3dHNsUjMwNW15TExGVUczV01pUkkxY1B2ck9BcHpnOTlDTVF3?=
 =?utf-8?B?dk5pYzA5NXVRWFlkbStuNEVmZURXbmpwbkU4VXVKQko3eU9SMVJQVk53OXZF?=
 =?utf-8?B?Sk4yRUM1QmRrZURJQUlOZlhTcXIxYmYxVnBEQTRCTzNzSWJ6dTYrTU1Jeitn?=
 =?utf-8?B?TUxYc29Na2g0a1lBSDYrTTVQL3UxeTRLSGlWRGVsNERFdU1CVWgrNEp2STIy?=
 =?utf-8?B?YWZOMVFVM1hoWlAxck9YSlEwTjVSaFFBMm1OQ2JaaHFuVW1vTTBlTEwrZjRt?=
 =?utf-8?B?Z3RVK25mWjlkSTJFenUwK0FGZkFkMnZNaDc1QTdYRy9tSzI3bGZkRit3WEdy?=
 =?utf-8?B?KzdyL3IvOXhPYmNEM2VheUJxOEh4d0llMGMxMGtUQkNwamxtNXh4Z3V3OE1N?=
 =?utf-8?B?Yk9vSVIvTjNWcEIxV0Q3aTQzK3QxYnY3U1B3UnRYQzErVnpnemNoTkhMS0Ro?=
 =?utf-8?B?NS9TUXFDUDAxbU5tc09vaW5NV3RHN2lNdVRZS1duVmdpNWdMRmdibXp2ek5w?=
 =?utf-8?B?SktrMjZVVlBOQkFLMnlLTFR5azJiUVg0a3lBbXN4bzZubzZWSnBNYjhTbVJL?=
 =?utf-8?B?RDEyekwwenoyRkdUb1YwTlJjYmFkVE1FWkNFanVyOW1xVDZzSjl6QlZLa2RM?=
 =?utf-8?B?SG1Nd1BDMmxabTd3eDZjalk5TS9sd0YyMmRiR3I2RjBVeVoxWnc0T1ppSjF4?=
 =?utf-8?B?WStFNTJjL0VmRXNVVWVDR3NiYzc1eHFoazZMeEVXVW85dHJmSmtYZzl2SDN0?=
 =?utf-8?B?VjdZT1dkSHh1a3NoZEVXdHp3dEpHVlhZUFdiK2JBbXN2NlIwaWlOZFU3SlJ5?=
 =?utf-8?B?c085RVJ0Z3Zlb0ZiME9OMVhURXNDczV4MjBQVFVsWXdQbG0waDl0bnZHUUpo?=
 =?utf-8?B?a1JJS1VsSHlzU3BzY1Z5Tm5GazBLVmZPTE9jZnRNMm5GRXcrdmdHQkFaNG8x?=
 =?utf-8?Q?5hW/N0BCaX/8nUaJf8rrWCLIQPfXqo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDIxMzlyeTNicjQvTW0rd3pmb0g0SXFRQ1IrM1ZDaVJSWTJUTDNIZWgzRGpS?=
 =?utf-8?B?RWZyM3BOdGJISnF6TW5OL3NLSmMyOGpWaWc2aHlRMHZVSis2RVZEK3laTEY0?=
 =?utf-8?B?eFNFeUxqYmVlWi96SEFabnJScCthWldhR2FoRVVVRzR3WkRoR0RpTG8xZGtB?=
 =?utf-8?B?bXpEMTFlWHFwSWlEMG5TcFVEUW5zTlJad3NabUNDL2hpaTZxVXU0VVptM0ZW?=
 =?utf-8?B?U3RMdjRaZHBFNU1oMnV5bUhaWlZYdDZ1NDF5VE53U2F1QXVrcmNqY3YyS2Ix?=
 =?utf-8?B?alJRRkExcTdobnZvUHYrT0hKSHVtUFhkSys4bVE4cEEwUlZwZW01QU9HcmJ6?=
 =?utf-8?B?bFNaZkk2OVpmNm9FQW1nUlEwcndKOFZIWVZkOWtxMmIxK1kyMDRNKzBOWjVY?=
 =?utf-8?B?Wmsra25QVFZnU1BScXNrSGdZSG9NZnNSMW5KNnJtdFg5UHIxM014RHR5N1l3?=
 =?utf-8?B?L1EvYnJwQjZiSjNLR0NObGZSTlhwSS90SXh5ZXIxZVRUQWdJLzVSV1FtWnJN?=
 =?utf-8?B?Uy83dFp0UmNJWFd2QUdJbnVzQU5YNkFzNDYxcm1sL1phVDI0eElFbDJTYTho?=
 =?utf-8?B?V3RpeG1PUzZYRUcwTmQxYnRTU051bFJWSFlWZGVGQmZOQnVBNk4xdTR5VWha?=
 =?utf-8?B?dGRwZFNVNWpva1VtR2FhMU1Ra1RNdDhPUEFpejBqZXRSWjJuT243aWl3R042?=
 =?utf-8?B?UXh1aDU0UEtPRFBwd0JPMk1vQ0VNOVVsZUdNR0tkYmZ5aGJMcHFUZ29kRHdT?=
 =?utf-8?B?VWMrOElPbktCQ2dvMjd5VEZqYTdsNktsNEtTUTZXdkFVTHJER0FtVW9Kb3Bh?=
 =?utf-8?B?ZWl0Z0JPY0xnMmFaczEwd2pjTnNVUExIRGN5SHpNam5NeDJhS3hzdmdLaVFa?=
 =?utf-8?B?MEk0OVRrcG9IZkVqcTQ5SkNKUUtBd2RzQ0xxcTFwMU80a3RCQ1JmaHpqZWFt?=
 =?utf-8?B?S09zWXV2OU9udjhQbFlUcmxiYlVvSjh4cDVkeTNaRnZyL3lpTW80VDBsZ0xy?=
 =?utf-8?B?blIwaXFCZUNSZk1WazVRS2hqZFN6aUU1Tnd3aytLYTVZSUJHQ1JoWnZ5OWN5?=
 =?utf-8?B?bUg2MkpOTk1MckhlR2dkMnNqK1RNdlhYSUtsNkxsKzVGMkdQVjdEdEw2aVJz?=
 =?utf-8?B?OXVUUHBidnY5bFBCTjBWV3JrT2lQaHVHdUFtd1B4V1RTUGZzUTlvN2xLRExa?=
 =?utf-8?B?cWNraGtueTFoaGZrY01IQ0NZVnFMUlYzN0Q4ZHZKY2ZhazV5dm92TFMwRmY0?=
 =?utf-8?B?MGJDcWswcWJwWlhubmxCRDB4c2ZmWmVaWFpLaHF0dy9PK3B3bDdvNGZ6ekZp?=
 =?utf-8?B?YTQ4TXJSV0NheEJ5VHk2WCt0bFdIbUdWemtCYWQ4cE9ZOXNad1hzUEdHV1RW?=
 =?utf-8?B?NENSQ293Q3NrVU00d1J6N3Y1a2x6NGxSZFpEOVJEY3dMdnZwL1JCNmFXMXY2?=
 =?utf-8?B?WFkya203dGpZeXVNOVRNWCtCa1hWWXBUbnZuVUpFejIzSmlXSkwxbzhXZFEv?=
 =?utf-8?B?a0wzMnlBUWRYWE5BeWVjYjdlYU1rVTdtbXNwWW56K3RMbm5YdkpTQmQzaWgx?=
 =?utf-8?B?V0hpNXdmK1k0NThvd3lHVFVaWDg5TG1qcklEUHBWWHQwdDh6SnowMHBVMXl0?=
 =?utf-8?B?MUYyL0Rua1lyNHc2T2R1QkNyYzBuRW9nVHc0SDJSUXFZeUxBYkwxLzFiNzZ4?=
 =?utf-8?B?NXZSblp2NkUyZHlOUTgxRDUyd0orRnpraVhsa1lyUmVlYm5QZzBCamlRZUx1?=
 =?utf-8?B?SE5haWRhTG1WcG5iSlovbWhqUHB3ZUd0c2JuZDZwNjhSTWhlb3dNSE91d1BP?=
 =?utf-8?B?ckZVME9qRGF0MHV3aUlucnU0TWxKV0dUeU9yemlUMkdMOFUvUlFZb0RjWGsw?=
 =?utf-8?B?OUxlRVZleHFQVVhhdE5RRWNMVVc0d2d0YjhUYldkN1pKU0JxSVQ3SHRpbkZo?=
 =?utf-8?B?OVN1N3JZaDNrNzUvcGR6RkRObTcza01CbXlsK0JYenUzNWFsZktYOS9nWTEv?=
 =?utf-8?B?N3BBRis3MTNQSEdGanJBKzFQRklrem5GUC90bE4wOE01c3BLQk1FV1lZRkVy?=
 =?utf-8?B?U2dNU3V4K0pxdldYV1I4VDBnYUpwajdacnhEU0pHRjlNSDdBMUxOUWZCbTd0?=
 =?utf-8?B?RzFYQ282N1RxbjZEMGhSV0dXWUJMRFpUTlZ5SHlkZ0R5cjlxbE1uajN5Z2VS?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6afe578-c67c-4778-2f58-08de11c52870
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 23:46:01.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: web8LIVDDz3jdz+NMCCU+vJlLKw8qYfbejCKIzF57WQLJG27nLx+7P/lazc68iSsQg1WlS3RWH8IPzNT+0p4bxCkgGHmWQ9kpTbWOi6mpNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8142
X-OriginatorOrg: intel.com

--------------k1KrFz0aLHN5G48Le3h9yk6e
Content-Type: multipart/mixed; boundary="------------6ajnYMF4x0WUpoaO1ZEmkenv";
 protected-headers="v1"
Message-ID: <417c677f-268a-4163-b07e-deea8f9b9b40@intel.com>
Date: Wed, 22 Oct 2025 16:46:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next PATCH 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: I Viswanath <viswanathiyyappan@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com, khalid@kernel.org
References: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
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
In-Reply-To: <20251020134857.5820-1-viswanathiyyappan@gmail.com>

--------------6ajnYMF4x0WUpoaO1ZEmkenv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/20/2025 6:48 AM, I Viswanath wrote:
> 3. All calls to modify rx_mode should pass through the set_rx_mode +
>     schedule write_rx_config execution flow.
>=20
> 1 and 2 are guaranteed because of the properties of work queues
>=20
> Drivers need to ensure 3
>=20

Is there any mechanism to make this guarantee either implemented or at
least verified by the core? If not that, what about some sort of way to
lint driver code and make sure its correct?

In my experience, requiring drivers to do something right typically
results in a long tail of correcting drivers into the future..

--------------6ajnYMF4x0WUpoaO1ZEmkenv--

--------------k1KrFz0aLHN5G48Le3h9yk6e
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPlsuAUDAAAAAAAKCRBqll0+bw8o6OWM
AP9Fv0xin3oivYBWT4FirPi06lmmGhwIMHLCD5w1ytF3LAD/WexdOgLoTtauYpYtjwjKtKWQw22N
q2fZQo3QlRwn4Q8=
=WxQo
-----END PGP SIGNATURE-----

--------------k1KrFz0aLHN5G48Le3h9yk6e--

