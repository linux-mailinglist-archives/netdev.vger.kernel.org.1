Return-Path: <netdev+bounces-209992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BECEB11B4F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 11:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943251771AD
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8402D1303;
	Fri, 25 Jul 2025 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4olP04b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1542A19C54B
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437426; cv=fail; b=YuHm3p2eTHy7sAyA1xkKM89s3j/QGrKzPlWDQd8zdvPhG3/TWBEqCjq4c1XqvvtcsmWJFeEhFqeZ14qDJoZRRCks7akwJdPGUhVzJT7tMc13eXEXZML8FSyZbBb7AeMfuvg4KCnneGlT3SObFk1AA0RxCW4gaHc3vZvAMFl7MvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437426; c=relaxed/simple;
	bh=yG1HAvcyar43DZsxeja4zL4ZX97DV7tlIuxjiBGmzdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZiCPvmT3gwLenffI+Pf91BIgb8LNfnlqDMPfB7m2+b188BsZ2tWRuXGGE71b7/ok8LL41krTpDXWgAFncCxo8B2vt/LcFuLWlw69AKnTRF4ew0bqba5PTs5Oq8Gj07LVYudVgrw3P9BcQMDnRS7kzZmZkGmZ36rsqxvvE0zN1kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4olP04b; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753437424; x=1784973424;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yG1HAvcyar43DZsxeja4zL4ZX97DV7tlIuxjiBGmzdw=;
  b=M4olP04bNiL3xIgrEoNopAlA8BeRcRLhIGb5RNebSjRyHq/L1GOdOO2s
   ngqsi/8kea18KJOecbOfbB6YMTPKysNMdrw5XOusMyiampn67Alz3aaeR
   P/BiJJwnmPAad21bGDS4siT82q4XiRY+n1gCPXSzD1GZmWYglV/DeeyR0
   I8Q1+nlh1K7eoSEhsSG8rvMDV8QWjFuCMrwdQR1UHoI0hZInCq5TlJnmc
   8xq5Mzx6YCRPVIFPYuRAIVold2zevwlTtt+xmIjkJyyRQ4hfucQH4+apR
   uyGhKEgLQzImmriA3d7r5SV8851TCPLCrbok/USaXAYqFIz1F8C0p/Hbs
   Q==;
X-CSE-ConnectionGUID: LO24L4j1R9uOWO57mKmgvg==
X-CSE-MsgGUID: th12ws/GQVOzMuVAna02Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59423096"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59423096"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:56:58 -0700
X-CSE-ConnectionGUID: 76acKAOLQPCnnbVt/cVykQ==
X-CSE-MsgGUID: rejaU6zRTSWASMJDFgxveQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="197976522"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:56:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:56:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 02:56:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4I5q27gOqhGCVfQpD+b/qral3eYnYvPgeGUIa7ehd8S/OD3SahN45Zpfmo1NkYxtDJXNgaoXvVvj48QrPk1XZahKuhPfCH1Ibq/Aa+R6GG2lNrVWysGLOebVakrBWbj5Qmn6pudxUhi44sg9X3901vtn5xx/JpWTTwFLwav4nIBjJBWkptTHrKgdzDg0xGL9tYtf4nrktyRStQzfmFyg1YESjRA54+7M6qf/2Uq8hjKaLjL34jMkQ9Rdkc4Hn/gvZb9xXxJ/qotup3ve+TvzKQXXgtQYi1MTaWsmEvI5aFCMpyHY8dnomLX2vkNeSMv1aen1fSQXukJua0ujDiLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umQ2sGhP2P52UKfXyVjaXxRGXUR2L+uVc2yY2DGifjU=;
 b=kEifG9pkLKgmf+7TjdPVq2YLPQjoLAAHEMSfWvXpiMgfkQ4F6+q+FYfCWq6vhZJn81VTZG1BaB4wyvevLhUSxciAn+dMS3CbH+Kej3E5UTVuWE3j/k8M0bz+arly9XkGzxDZfg0sXgptchC22ZtGSY7rh11BTExmB6p3RafxYoTtZV6E039jON4TgDlvFKkUWYPzK+LdmPXp2sJwbxj9FaAZp+AlO2VgHMwUqhaZheW2SpL68pLvylVcJlaQdVxXVcp04UqNP0AH8foGXDzuRMJ5EoquRtrXQV4zWVWSDHhafRHZuL6ZY9ImVKaOznf2CnxhKKqKAjnR5i62T2asjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 25 Jul
 2025 09:56:38 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 09:56:38 +0000
Date: Fri, 25 Jul 2025 11:56:26 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander H Duyck <alexander.duyck@gmail.com>
CC: Mohsin Bashir <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <alexanderduyck@fb.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <vadim.fedorenko@linux.dev>, <jdamato@fastly.com>,
	<sdf@fomichev.me>, <aleksander.lobakin@intel.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next 5/9] eth: fbnic: Add XDP pass, drop, abort
 support
Message-ID: <aINUysHmm9157btU@boxer>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
 <20250723145926.4120434-6-mohsin.bashr@gmail.com>
 <aIEdS6fnblUEuYf5@boxer>
 <d47b541e48002d8edfc8331183c4617fb3d74f8a.camel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d47b541e48002d8edfc8331183c4617fb3d74f8a.camel@gmail.com>
X-ClientProxiedBy: DU2PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 1760431a-92cd-4aa8-1a11-08ddcb618c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/mDCkWL0fjGwrObz2Go1YLcKm1Boihntd+nOM5WKN5G9m17OMY/T2hMcVGKe?=
 =?us-ascii?Q?1XjCoTfHx59MBN3h5FLpOj/mGfoDKWKi5SfDQPYXpyUedS8h2E0DczVr2ZK2?=
 =?us-ascii?Q?OvvsZ4/ejPdA5rI1ZzsrKfFNvZIEemzI98f1usVqfWnIhIbrWu4BQ0WwXqiw?=
 =?us-ascii?Q?bq0QU37DWiSYF7liC3nndI4KKNlKZshK8rGLJgpwVqp/vS7YOVfE2bsJMrsW?=
 =?us-ascii?Q?i7rPDRofUqYTJRE53qcf3mk84tGU3wxYwB01wNw9JOLDvhtXDPLbXAvInRqn?=
 =?us-ascii?Q?OVEja7yYMiOgboe2LHW/LHIL47vqAR3cEOGi1j5fxbMsfAkufehEqEadWROq?=
 =?us-ascii?Q?JC/vzBoEFjvf0loHLk1Eivgf7TV48yX8Hi3K/IEAFWne/Y9+2Dz6GaVVcRXu?=
 =?us-ascii?Q?YnaU2NTWwHKla8lDPvmpKFwwCgR0AkxDooOz6X6ldoW0LPun3p7fnPa2iUDC?=
 =?us-ascii?Q?1dyRyBEGWxD+MhIeDdjoie7oy2xOnve0pajWfsCdV3aojMydaBxBevZYDYSI?=
 =?us-ascii?Q?3xCHylTnzHaguAqD6ecxXjrC/ZORxSrxihSEPACwY9SHBj0lfCn9epYU9d9p?=
 =?us-ascii?Q?xgNQ3hW1krOMeY8l2uqELH/WWCqOqXj9hRtLxFgR5L/+isYH5dz81qyruSmM?=
 =?us-ascii?Q?saWvimcCps/H1dNKc58BbfqpANKUOCGFeagRTscRmL7JeKj5gd8QkIrQtYRH?=
 =?us-ascii?Q?vm8Yv0zkombOSQXx850unZ7DyGd9N/xRvzTbsNOov6AIkCPa7GkMLsugnW30?=
 =?us-ascii?Q?MkrjS9GoCZ3Zx0g0haCRS/6GCW+vitNa8ynI6RPJaK8PMgeQ+linWTDZ2nh8?=
 =?us-ascii?Q?wRuDnJSwhCNY/gSjCiq2wQfaG4JnJftmgz5BLeWuuyPjmG/LUeffBCXhQzC7?=
 =?us-ascii?Q?bigCP9LQo1QyIIZzJETwuK67iUzgeF9dya25BhNM/+0Y4fqyAj2Y+PGiaGXH?=
 =?us-ascii?Q?6qf9qU0JnAGU2jzymuA1y3QS2TLE68A+bi6Rvbb7lHzqNpA44YGlAD+k7STS?=
 =?us-ascii?Q?khLwMJzIc31m7EcLNiqrv0kVKo1jgq52U1R5/jphb9/PGA+GH0xGtpdx0Ym4?=
 =?us-ascii?Q?aoSN/4Cyp9ekaaxY6dZJEn8WZ+On+I9Pj0PTFZfbwXSW+fFI3tzyB0j+8hmb?=
 =?us-ascii?Q?ymh9+l7wCWjF0yqETW5kNbsFYc6c1baUk98yoNXDe0Agx2gc7+K5l2QLy90f?=
 =?us-ascii?Q?x25lu6NVvhwLilI2w4nSIL1rAmKsIMGQQ9Xm/pxMua/yNZlB4/cC0+z0mkYa?=
 =?us-ascii?Q?LU4NEHTWndTPfH/22HIMrym1vf4PTyY8aoEkjS0C2BFDzwfsAFi/0CxNx2JS?=
 =?us-ascii?Q?fkPN4vhq3ZPG9vXfanxB/GoJHVZ5NxFpuPZcLFtIBRZ1cJR4Hrl1LTO/Wrf9?=
 =?us-ascii?Q?SQEAFWK1MM0z5wIDxa+mGuoup2EpZWY5+ti85KrKO0RQwX1g9JYaPJ2gwJ1U?=
 =?us-ascii?Q?af7wb8II6ZQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTG4VrRHOfoFsbTMfUduuSHQsq1HvnFrPb8TYZnfo4fUzU7yMAg0aaVBesdj?=
 =?us-ascii?Q?N2lvwWPrgtdNgHRzeN4bYcwJPNu5FhQrb1iOsm49oIFIDeThkuLmfjzbVyFp?=
 =?us-ascii?Q?W/8Tlnm3hcfG/DDYtqDIk4PX43MAzDNUmFdTOE7okaTfgnCAn4PerM9i9ze0?=
 =?us-ascii?Q?6jHBu4rJMTafiPbhdZOaB3XWhtSkYma7cTHjqClG939fESlYsMldwoq0uM4Y?=
 =?us-ascii?Q?/PC999OvS667ofTVgm+v4Wb0U+yEnMXkRV1dhlqapsbqWmUF4ZLLa8CBDewP?=
 =?us-ascii?Q?AE0o+VZtTogUw9UxFCRIiXN9TuRXkAkAGxHZYokfTiivoNKS1Nw5xyB07tGu?=
 =?us-ascii?Q?yW8FsMFMfcJYnTIZRt0902krdTPKALUMxISUXBBrgIlS7wobwqRX7iqzyZqE?=
 =?us-ascii?Q?qqAYwKxMJI1Hbu29tRMphKWcITDoTUBWn/u4NCGrrL+EF6gNVVF3BFED1olX?=
 =?us-ascii?Q?GP3zKM+FCcLFZ0dno6cQDYjz5sgAhNFMeV6mpbxemUpmRsYty9zE0TrAC9/+?=
 =?us-ascii?Q?x37wFd2WU9Tja2Qdw/Lxz9QjDeUOhasFfr4JjMMIi5E5WUNA1NYEcY0ief/r?=
 =?us-ascii?Q?wH9cPKr1Wh1XXdJm/JDHcSMhbWDFfNuW3G34/f30vMbPYPUO6oU+QwMqlcC1?=
 =?us-ascii?Q?QRlV1TyymgbJRgeU6AJzQlu1liGcuAhqGOmDKrClsTKNJt/XHhhJbLmLfliQ?=
 =?us-ascii?Q?kgCRFj0UTFPEHo/tq5OliqegbVwdufx8XEiwQZqdNKJHZEEkOCvKYQS8EFiS?=
 =?us-ascii?Q?Kwz/V85Rf2NOUEZxj1Ng95RjhVtwydE3T7ZZD3f5Kfu37pajqJ9H+N9+sb4U?=
 =?us-ascii?Q?duqxK6LhYu5uSeQ6BXZSOnpa2saWy79j4+WHaNXsBxZBqPxaTBPNtBTstCQl?=
 =?us-ascii?Q?k+74oXyb5AqOKvDLe8R/Qf+dqHFL2rgjfmphzSKEE6GNHKr2XSe/KAlSY/9I?=
 =?us-ascii?Q?m9Cs37F7zYvHLE9BfBJN54rhimCEUAgsuLEe/9oStoYJZ+9RTXqNLQo4qMYM?=
 =?us-ascii?Q?N6dtgUnfv5DchTTd1efsswX+Lv3hW327UBpwYzONQNeTQ7ueRhiN6uvSPoM5?=
 =?us-ascii?Q?DYFyaogLhU5VmP1V1GtheT8+BBa9G6JeW/cRyRgTGAWcj97wO77TqExPWMCF?=
 =?us-ascii?Q?zxhpFekwFTPz7b/zULD/F909H0F0eTRKZoZg12qMTggLY+rZS9OsMcPR44Nd?=
 =?us-ascii?Q?dCq+nP9gCNcMLn9auahpNzh38q0g+24wOVktO3NJyz4493xPg1iqUhFBRynq?=
 =?us-ascii?Q?WwVnmsUa4LQCuRNaKMuQ37eiL0qECnUiAFI/jItcbu7PDQmhgx74tv06C3hh?=
 =?us-ascii?Q?SvJYO6DQvjmNTLcWaZo5vFPw6dSuesl+DTUcI7Wax7G+lhH42Al+Pbj9T/mI?=
 =?us-ascii?Q?K06uV1NKnHcFkV7d5E3bD0M8Pyta9lx4if8SRm+AUeJ5nJMDaJ7djsxnjyic?=
 =?us-ascii?Q?sZ2YIQVmBWNhQIcyGv5EyrY+pOUJIRJSzmGtzrSBx++Ahijh5SLO8cWCM9Oe?=
 =?us-ascii?Q?gWZ9HkgJ04r7XAAdNs2cty6FCSvhAJerJjPsyRgLgs47Vmg2wn+4iPKS3/V5?=
 =?us-ascii?Q?CiPWQugMN/Fpd1rrPoH+Kt4xoZXCHSiVEp9JHIkajS7Eza877wnRmbgKDytX?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1760431a-92cd-4aa8-1a11-08ddcb618c6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 09:56:38.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlIrogUKybgtHNIxuT/m0rXsSGmC7nlf0PPkdTanCEZKlPUE6zC7Jn6xaRO+rOOGP0Jc8GybDbjNvEMLnztZNoGxSE4Wi5I9xuGWKZnmmQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-OriginatorOrg: intel.com

On Thu, Jul 24, 2025 at 02:14:11PM -0700, Alexander H Duyck wrote:
> On Wed, 2025-07-23 at 19:35 +0200, Maciej Fijalkowski wrote:
> > On Wed, Jul 23, 2025 at 07:59:22AM -0700, Mohsin Bashir wrote:
> > > Add basic support for attaching an XDP program to the device and support
> > > for PASS/DROP/ABORT actions.
> > > In fbnic, buffers are always mapped as DMA_BIDIRECTIONAL.
> > > 
> > > Testing:
> > > 
> > > Hook a simple XDP program that passes all the packets destined for a
> > > specific port
> > > 
> > > iperf3 -c 192.168.1.10 -P 5 -p 12345
> > > Connecting to host 192.168.1.10, port 12345
> > > [  5] local 192.168.1.9 port 46702 connected to 192.168.1.10 port 12345
> > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > [SUM]   1.00-2.00   sec  3.86 GBytes  33.2 Gbits/sec    0
> > > 
> > > XDP_DROP:
> > > Hook an XDP program that drops packets destined for a specific port
> > > 
> > >  iperf3 -c 192.168.1.10 -P 5 -p 12345
> > > ^C- - - - - - - - - - - - - - - - - - - - - - - - -
> > > [ ID] Interval           Transfer     Bitrate         Retr
> > > [SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec    0       sender
> > > [SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec            receiver
> > > iperf3: interrupt - the client has terminated
> > > 
> > > XDP with HDS:
> > > 
> > > - Validate XDP attachment failure when HDS is low
> > >    ~] ethtool -G eth0 hds-thresh 512
> > >    ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
> > >    ~] Error: fbnic: MTU too high, or HDS threshold is too low for single
> > >       buffer XDP.
> > > 
> > > - Validate successful XDP attachment when HDS threshold is appropriate
> > >   ~] ethtool -G eth0 hds-thresh 1536
> > >   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
> > > 
> > > - Validate when the XDP program is attached, changing HDS thresh to a
> > >   lower value fails
> > >   ~] ethtool -G eth0 hds-thresh 512
> > >   ~] netlink error: fbnic: Use higher HDS threshold or multi-buf capable
> > >      program
> > > 
> > > - Validate HDS thresh does not matter when xdp frags support is
> > >   available
> > >   ~] ethtool -G eth0 hds-thresh 512
> > >   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_mb_12345.o sec xdp.frags
> > > 
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> > > ---
> > >  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 11 +++
> > >  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 35 +++++++
> > >  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  5 +
> > >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 95 +++++++++++++++++--
> > >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
> > >  5 files changed, 140 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > > index 84a0db9f1be0..d7b9eb267ead 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > > @@ -329,6 +329,17 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	/* If an XDP program is attached, we should check for potential frame
> > > +	 * splitting. If the new HDS threshold can cause splitting, we should
> > > +	 * only allow if the attached XDP program can handle frags.
> > > +	 */
> > > +	if (fbnic_check_split_frames(fbn->xdp_prog, netdev->mtu,
> > > +				     kernel_ring->hds_thresh)) {
> > > +		NL_SET_ERR_MSG_MOD(extack,
> > > +				   "Use higher HDS threshold or multi-buf capable program");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > >  	if (!netif_running(netdev)) {
> > >  		fbnic_set_rings(fbn, ring, kernel_ring);
> > >  		return 0;
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > > index d039e1c7a0d5..0621b89cbf3d 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > > @@ -504,6 +504,40 @@ static void fbnic_get_stats64(struct net_device *dev,
> > >  	}
> > >  }
> > >  
> > > +bool fbnic_check_split_frames(struct bpf_prog *prog, unsigned int mtu,
> > > +			      u32 hds_thresh)
> > > +{
> > > +	if (!prog)
> > > +		return false;
> > > +
> > > +	if (prog->aux->xdp_has_frags)
> > > +		return false;
> > > +
> > > +	return mtu + ETH_HLEN > hds_thresh;
> > > +}
> > > +
> > > +static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
> > > +{
> > > +	struct bpf_prog *prog = bpf->prog, *prev_prog;
> > > +	struct fbnic_net *fbn = netdev_priv(netdev);
> > > +
> > > +	if (bpf->command != XDP_SETUP_PROG)
> > > +		return -EINVAL;
> > > +
> > > +	if (fbnic_check_split_frames(prog, netdev->mtu,
> > > +				     fbn->hds_thresh)) {
> > > +		NL_SET_ERR_MSG_MOD(bpf->extack,
> > > +				   "MTU too high, or HDS threshold is too low for single buffer XDP");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	prev_prog = xchg(&fbn->xdp_prog, prog);
> > > +	if (prev_prog)
> > > +		bpf_prog_put(prev_prog);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static const struct net_device_ops fbnic_netdev_ops = {
> > >  	.ndo_open		= fbnic_open,
> > >  	.ndo_stop		= fbnic_stop,
> > > @@ -513,6 +547,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
> > >  	.ndo_set_mac_address	= fbnic_set_mac,
> > >  	.ndo_set_rx_mode	= fbnic_set_rx_mode,
> > >  	.ndo_get_stats64	= fbnic_get_stats64,
> > > +	.ndo_bpf		= fbnic_bpf,
> > >  	.ndo_hwtstamp_get	= fbnic_hwtstamp_get,
> > >  	.ndo_hwtstamp_set	= fbnic_hwtstamp_set,
> > >  };
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> > > index 04c5c7ed6c3a..bfa79ea910d8 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> > > @@ -18,6 +18,8 @@
> > >  #define FBNIC_TUN_GSO_FEATURES		NETIF_F_GSO_IPXIP6
> > >  
> > >  struct fbnic_net {
> > > +	struct bpf_prog *xdp_prog;
> > > +
> > >  	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
> > >  	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
> > >  
> > > @@ -104,4 +106,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
> > >  int fbnic_phylink_get_fecparam(struct net_device *netdev,
> > >  			       struct ethtool_fecparam *fecparam);
> > >  int fbnic_phylink_init(struct net_device *netdev);
> > > +
> > > +bool fbnic_check_split_frames(struct bpf_prog *prog,
> > > +			      unsigned int mtu, u32 hds_threshold);
> > >  #endif /* _FBNIC_NETDEV_H_ */
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > > index 71af7b9d5bcd..486c14e83ad5 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > > @@ -2,17 +2,26 @@
> > >  /* Copyright (c) Meta Platforms, Inc. and affiliates. */
> > >  
> > >  #include <linux/bitfield.h>
> > > +#include <linux/bpf.h>
> > > +#include <linux/bpf_trace.h>
> > >  #include <linux/iopoll.h>
> > >  #include <linux/pci.h>
> > >  #include <net/netdev_queues.h>
> > >  #include <net/page_pool/helpers.h>
> > >  #include <net/tcp.h>
> > > +#include <net/xdp.h>
> > >  
> > >  #include "fbnic.h"
> > >  #include "fbnic_csr.h"
> > >  #include "fbnic_netdev.h"
> > >  #include "fbnic_txrx.h"
> > >  
> > > +enum {
> > > +	FBNIC_XDP_PASS = 0,
> > > +	FBNIC_XDP_CONSUME,
> > > +	FBNIC_XDP_LEN_ERR,
> > > +};
> > > +
> > >  enum {
> > >  	FBNIC_XMIT_CB_TS	= 0x01,
> > >  };
> > > @@ -877,7 +886,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
> > >  
> > >  	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
> > >  	frame_sz = hdr_pg_end - hdr_pg_start;
> > > -	xdp_init_buff(&pkt->buff, frame_sz, NULL);
> > > +	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
> > >  	hdr_pg_start += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
> > >  			FBNIC_BD_FRAG_SIZE;
> > >  
> > > @@ -966,6 +975,38 @@ static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
> > >  	return skb;
> > >  }
> > >  
> > > +static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
> > > +				     struct fbnic_pkt_buff *pkt)
> > > +{
> > > +	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
> > > +	struct bpf_prog *xdp_prog;
> > > +	int act;
> > > +
> > > +	xdp_prog = READ_ONCE(fbn->xdp_prog);
> > > +	if (!xdp_prog)
> > > +		goto xdp_pass;
> > 
> > Hi Mohsin,
> > 
> > I thought we were past the times when we read prog pointer per each
> > processed packet and agreed on reading the pointer once per napi loop?
> 
> This is reading the cached pointer from the netdev. Are you saying you
> would rather have this as a stack pointer instead? I don't really see
> the advantage to making this a once per napi poll session versus just
> reading it once per packet.

Hi Alex,

this is your only reason (at least currently in this patch) to load the
cacheline from netdev struct whereas i was just suggesting to piggyback on
the fact that bpf prog pointer will not change within single napi loop.

it's up to you of course and should be considered as micro-optimization.

> 
> > 
> > > +
> > > +	if (xdp_buff_has_frags(&pkt->buff) && !xdp_prog->aux->xdp_has_frags)
> > > +		return ERR_PTR(-FBNIC_XDP_LEN_ERR);
> > 
> > when can this happen and couldn't you catch this within ndo_bpf? i suppose
> > it's related to hds setup.
> 
> I was looking over the code and really the MTU is just a suggestion for
> what size packets we can expect to receive. The MTU doesn't guarantee
> the receive size, it is just the maximum transmission unit and
> represents the minimum frame size we should support.
> 
> Much like what I did on the Intel NICs back in the day we can receive
> up to the maximum frame size in almost all cases regardless of MTU

mtu is usually an indicator what actual max frame size you are configuring
on rx side AFAICT. i asked about xdp_has_frags being looked up in hot path
as it's not what i usually have seen.

> setting. Otherwise we would have to shut down the NIC and change the
> buffer allocations much like we used to do on the old drivers every
> time you changed the MTU.
> 

