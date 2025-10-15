Return-Path: <netdev+bounces-229751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C628BE0873
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6F4D5616A0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D93305E21;
	Wed, 15 Oct 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aP6ABFhb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413902E03FA
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557590; cv=fail; b=pbrPDYH42nYXXKih/U8mTzNh5SLIWfLGXBOX+EcFKDpw4uDGRmOZh02WgMj8rW9pXMcxgTpZS65xvxx05cw6n4dkAt0Ztw1GeiTr96lxU/wuozedhQBrPYYgeInu8oR9LRDANkvJuHnu54Yf2Y6p/Gs4vHgxPLhfeoewZyMUYF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557590; c=relaxed/simple;
	bh=SUt9DJbDaz7xqX3WsN31HVO4dTbOD7rYLaikULg+BNI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jLoTMWDPm0mcz+w4oDqpSlqIeI6C0vBApj4XGB0wmhJ4PvWbp2ouwslm4YMkYbQA+fKd4MXpJDGgMxz+6VHfRXNJg719DewzFbWd6YUcIcO87UFqEZLIQBrbPcn68IdB4sGbS9BtnSBcQnn6IaTZ4uzOIrwbk1Ghy4gyBWEvs9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aP6ABFhb; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760557590; x=1792093590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=SUt9DJbDaz7xqX3WsN31HVO4dTbOD7rYLaikULg+BNI=;
  b=aP6ABFhbHfBel7A7uNF4MZTxTgd9Sf45ia6sw7nfAqLjlCK6shn6rzaT
   muOAAPKQ8E3nnr42jSVWkJsSGDYAyVha9wM/Sb2/+ReDpuoazo8mcDl1J
   ouEnzfGb0oTCeS5f+mV/iHNsL9jJvGNVlE+KQLFQ7+VeBRoXfc7MdVnx5
   bH/fnHAuOnztCUlLHpK4YfbF+oPlKu8HwamVrI3HasNdjJZiBVN/eX0K7
   vfo8Z72nwdoVfjML9+nBdynqNsjwf+qgJGW34rTwl0rqnUrdJMwKKTLCh
   5Cdi+wF2g7Pw8dUudERRCh2PhBiUW0dVg0TgSaE7sI4M2WcHlNss2ldaJ
   A==;
X-CSE-ConnectionGUID: qsXQ/5thQEyHFrTxYC9V0Q==
X-CSE-MsgGUID: +Rew9VS2Rf2ZqcGUAjtnpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73853573"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="73853573"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:46:29 -0700
X-CSE-ConnectionGUID: lvOINn2GSy2pIfbLf5JIxw==
X-CSE-MsgGUID: QNhVeQyQRJeVWvgbySRtmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="181396126"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:46:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 12:46:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 12:46:27 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 12:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm/NRVLvu647yMvboTOUmxxC6RGIcUc+2+rJFYWmjUSePKaQaOrkLXuFX2pEQqBKw+e9gJqYRlakofBx5wt6po7lN/lVHO/vKvvv1oMqQRrFuAM4fwEPLWsQugtqYaJVITx4UgMgzt5y/3PlDXq+T1f89KwzCeHA3bJPGZtFIiCdv0rdQn7Xz2uT5QPma52Q7F4waS9gl++FqepEqJmcbwD8G5phX1i96bPIYbKkX0a8fMWFn7PMUNQQrjjJtzXS+q66dzptDNiS+cxGJcjI2v2An3QSl7fD8Pvl1RRY+LsOzK2MtMmj27BT4Oem6Ze6YHTnuKB+Eizt8lAOQbigaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUt9DJbDaz7xqX3WsN31HVO4dTbOD7rYLaikULg+BNI=;
 b=nWx5GqJ2h6HDXnECtJUNSCYu8gmhHXIez3D+94+2GE4qxgyGzu3eQVRrmZELT9IkROeWoB+nzgVHDA/ZmCcINlacbm5xsTApnnG64iIzwmt5o5omx2KeBOcJYelg3Sy+Scwdc9atb278ptCz1YVPOYuOcmS22bJbjcdU+FVXVxVF6tn9QpB5JFqML3Uto0KSXKbsjvdoQnEu46DWh7F5FxHKAYuQexDlsKSiZ9tm4tfMyilFm37J59SG9GsxFF8dGNsql7teUSDSdX8MP+/0sboXMSvafm7XMPgn0RKhzqt+vzLmb6CR4mxfJZ8hy/BwQ4bqK1qqFJzvl5tejuD2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 19:46:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 19:46:24 +0000
Message-ID: <626c6242-58fc-45cb-a1c6-799443688c1a@intel.com>
Date: Wed, 15 Oct 2025 12:46:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] ti: icssg: convert to ndo_hwtstamp API
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
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-3-vadim.fedorenko@linux.dev>
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
In-Reply-To: <20251014224216.8163-3-vadim.fedorenko@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------0NoCYtCLQ9LtPa2KzIBvmCPi"
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2b1e32-396e-4835-d0a5-08de0c2385e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG1mTUp1RXJGR1AxWWdoNkVWRlhFSnpzYVdVeGQ0RzlyNVNJaW5lUWp1TzRh?=
 =?utf-8?B?V1dlYmJ3QldUSVVVUFVrcGFneHBiNkNXSzY1SndHNERyRjVqRUdEWURwOUxL?=
 =?utf-8?B?LzZaYnhyOTYzaC9DSm1iTDF2YkxVVTF3dDhObnBKY21zamR1V0JMbkVWS3dx?=
 =?utf-8?B?bzk2b3lzU3ZORDlPTUVON0lQUXJLK0g0NkQ3RjZUekN6cFpOM0UzeDVhWUhL?=
 =?utf-8?B?RllrTmNkMHU1ZUlqU1NOL200MjNLU1lNSEtNb0xpOEE3TUhDUU1UTEFRVDZW?=
 =?utf-8?B?dUZ4eHhUNVlRMkNDVFVITEZ1USswZ1VoanBYaFpaQnV5K2g5dk84K2NGOUZJ?=
 =?utf-8?B?OWJzS2xMTG5QNXk1OE5uTk5kYWNBSzFBSFdwNHgydjFxb1dzZDAraWJQZXcz?=
 =?utf-8?B?ZEkyREVtSzJ5d01tU1NGRmQwc3k3OHQwTmlBZi9KKzhORU1HbmhpbnhlTEgz?=
 =?utf-8?B?MDVlRndoaDlnNkM3UjVRWjNtVkhYZm9GVmJYWnBOMENVeHBBaUlMS2N2RWMw?=
 =?utf-8?B?NXpSRFQ3eEI5WXlWalQ1QXlrbDl2MS90elQ0a1BQR1FBMVJoWU1xVnlCNlpw?=
 =?utf-8?B?MTdiZy8wdlo4UFIzUXp1aEhsSkRSSDI2MUs1dlhQaXMrRmtaZDhJSEdyVVhs?=
 =?utf-8?B?UHJocWJVQ2diczBBd1VjNUlyaFFyZGh1czg1TkxSK0RyZjh5Q2RNenE0VzdU?=
 =?utf-8?B?M0ZyVjF2Nkw0VEUyNkxxK25FaGI2Myt2TXFmMEJEUkEyQ3BvRGxqYVU5a3o3?=
 =?utf-8?B?b0QzRTVabi9TWVAybWNOVHBiQ3RUTnpMZGVZRk8ybThldTRvTUxFTjhRWVBn?=
 =?utf-8?B?aWtoVVBJNTZVampnb28raGdPdWJRTFNwMHdDbXVOTkZXTm5zVm5sM2hTRGVZ?=
 =?utf-8?B?SEpYRjBRU1RVcU9NSllIS1l5UzJPTWFWVmgwYTBWYjVKUGcxMk9pMm9GWGR5?=
 =?utf-8?B?dkQ5K3hSd2hYUDY5eXJvbG1jb0VGaUZHQUhxclRXSDZNUUJ2NjQ4dUpkeHFZ?=
 =?utf-8?B?TjVkN3hLUjR5Y0NuRmRvNVRnMUlaeW5RazVZL3dyei9QQVEwb0c3Z3ZReVph?=
 =?utf-8?B?bERxdW9yOE52SVloMWd3RTNhcWR5UjhaQkEzQ3h0TkZuVStyTjBJNmlLTnRZ?=
 =?utf-8?B?SzlQRHM2TzJhUE1tenA4c2RIeXJmbGdpWkJxN0l6OVkyR0luQUFXQUY3clZO?=
 =?utf-8?B?d2ZveUhoUDlKWUJXT2JSdEdsUVlpMzU1L0ZzbmdOTzBrd2NaRnNoQWQ5ekp4?=
 =?utf-8?B?MFVjc0FVMjk1Nk9lVUgrWnVWclJrNFV0RElUUTRON2xuTmFuNUo1Um9VcGk4?=
 =?utf-8?B?RmhsZEJmZGhOL0NpcnM0cSt2Y3VQeWxLQ3lkVGpoaCtoQ0o3a3g0Z0tvRFQx?=
 =?utf-8?B?c254eWVhYy9zMkNBdW04aHJacC9jcXRaY0dUS2QxRzZrcmE2LzBwVFN3K2Mz?=
 =?utf-8?B?N1J3SGpLcEVKYWdxWjVYRVk5eWZRdmlnVE9VYzduOUxiMUlZWSt2Zkt6cEps?=
 =?utf-8?B?bExtMWxrd0RKd1h0OGFUSi82dGxlSTZnVjA4bnRNM2d0T3hHc3gvODZzWCsx?=
 =?utf-8?B?TVBvNE45OW5ZdHNCK1NLYWhLSGVDS0QyZmo5N0lIU1dLTU9mU21ueUVxSm1K?=
 =?utf-8?B?Z2I3dTRIWWRwQXBSOEFML29jWDNmb2pkSWZHQlRIRGxKK1dCNVJKcFpOVGQr?=
 =?utf-8?B?S2VTSDJrUEl6M0daRFk2RXJEQTZ2WVpYTkl5Nk1Vc05aR0twVGdxaWJ6RG1x?=
 =?utf-8?B?aTJYVGJ1enNIUlk5SDBqT3luVUo1ZE1XL3FDUVdYSW96bld4U1lNL0piTmNS?=
 =?utf-8?B?WFZrTU1oeFRJeC9Mc215RURHY3pSQXNUeXpoUUFyQXpWS2N3cVhJMDFyMWxn?=
 =?utf-8?B?R2ZEQ0NmQ2dKb0UzR0tWN2IvYVpDM3l3NzkrWWJvM05DcEF3aGtzSytFMjNx?=
 =?utf-8?B?MjQ5Yll0THgzdUxtaXEzSFNZQmlZcEtackl6TGJBK0dLTnByZ3lGT2lqUjRI?=
 =?utf-8?Q?JOwPcXV4ww+4KmKbEn1YVJrP9Elk38=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3h6YXF3VW5pZFJZdlp0TGVDQmJsTDRveHFoTzUvZDRCa3RDMVBuQkFuc1ll?=
 =?utf-8?B?NjVCc2h5YnRyeEtmeVQ4V1U4RU9uSWpIYjYxMVo2QXpZTThJZ2M4VVhRM3Ax?=
 =?utf-8?B?ZnVLUTh3SDcxSXpZaHh2R3d4bjhuUGNsdTVTekc4d2NEbUdiREthbDBoMHRM?=
 =?utf-8?B?cDlZMFZRY2YyV0RueWdYTGJoYVl0dFJmUGMyUEs5d0xmelVaNXZQTysxdjg3?=
 =?utf-8?B?S1lPVEQzS1VRUThBTkp6NU9LanNQeVlhVDBNRDdEMldrMkh2dEtxRDFRbll6?=
 =?utf-8?B?VDZUR25lbGxjQ2ZWajljcWsrVU1ObktmNk9oMHQ2eG4rWDdNMnA5V0x5R2J6?=
 =?utf-8?B?TWpTa3FJWG1DczErZzNYcWZuYjBFQnk3dUJjbmVCRUF5RzBwSG5selNCZkta?=
 =?utf-8?B?OE9aY203VWJBUW1Ybi9maklFc2sxbzJBUnA4UTdrYWY0TDFEYWJyTGxBSUs4?=
 =?utf-8?B?R2VVTWxRSllkamhja251ZFVscTFVT3pWbkM5N0pMc0JQOWpXb0t4a2pzeXRG?=
 =?utf-8?B?ckcxZ2U3ay80Y1NTaSttVmlLTW40ZnNaRkhQQlRyY3pJSzVOb0lpUDFvZUN3?=
 =?utf-8?B?WDkyczJlemJxZUtDQUlpa21wSktOY2psRnRYaUtHL3p2RFIrWEdQQzRKQUlK?=
 =?utf-8?B?YjNrZnE5dENaUURMQUZ4cENmVHVoTDRJTVgwWk5VZC9lVGx0ZTk4VWxBeWpI?=
 =?utf-8?B?akxNeE5oTkZFOXVPSHpabWFZRmN6YUdUVWdqa0xqb3ZEcEMvRksvK285QXdw?=
 =?utf-8?B?RzRtRG4zVEMycHp0d3p5VGxCZXlackN6a1pRZTVmVitsMGhrWmdaMDlKL3Q2?=
 =?utf-8?B?b05SYXpva0QvZ0Y2aFRpYkZOWmpObzNHRjJyU3pCbFI3ZFBjcEtudEg4VUNN?=
 =?utf-8?B?bWRibzByQ0RwcXhIcUNVbTNjQndDa1ZiZUpFZG0veWdRaGV5MTVSNi9zbUlr?=
 =?utf-8?B?VFlIZ01nYWM4eHdGcCt3cnkya0FwcEY2TXZvdHNsL2xBWkYrMzV6b05SdzA1?=
 =?utf-8?B?aWZoRnlNK0tQR1hjK0pDbGFUYktLWlB4Y2hTVGhLa1EwUmFZTFk3QXp6Y0xM?=
 =?utf-8?B?UHhpWWRzdjRzOWNkVG03bFowRUwzK0kwUDhoZDIxM2Q5RG5pSHlydTlBTGlw?=
 =?utf-8?B?dmJNNGpUTFk5UzhWM2d3L3hvV2lFUzgrdkk4ZWxHSHR0OFMvOFpWNlJOMHlJ?=
 =?utf-8?B?b0haaXVmckx2KzVpaWh0T0xOYzV3T2dpSG9OVys3cENEK1dIdWM0bWpFL0xE?=
 =?utf-8?B?YWhJai81RDB0cHJDVmU4S2xkZVdNSVMya0FhekJrVWpGRUtia3Bld1pKMHpC?=
 =?utf-8?B?N1BvVjFZUXFMeUlySHNHeTAwUzl6Rmpsdkl5c3VIaXVMRytBTy9zOVJtYjRX?=
 =?utf-8?B?clRIQVpGQ2pkU05xR3lGU0pOZmY4aEd4bHNGZ0NPVXFmVmdkZ1BPa3hmbWlK?=
 =?utf-8?B?Z0lCeDgyb0N2eEk1cXJFMnNDNjFXUVBSbStpNTlySngwOENOaE12VHIvSi9Q?=
 =?utf-8?B?QUNFQkh1b3I3UWZHcEpCa2RWM2YzS3ZnemozUFR3MXlVcDYvdGh4SVRxU3pk?=
 =?utf-8?B?VW5iY3hKL2ZSSGF0QXEyVUlURElQaTBudTZrNmhkalgvV2xRZXdPL1E4QXY2?=
 =?utf-8?B?VXNVSUI1RGZibnVhRHRYWmgrWXpyYjExNGRHYW5RcTJkZ290VFBkSC9MaU5Y?=
 =?utf-8?B?T29RdUVsUncwUGZ6OGpKUWJtcjlEdFJTY0N1N29vM2phZGVYejlSbWFiMGFK?=
 =?utf-8?B?WEJyQTZZUjlZeVVpRG8vbHpVaHVLcVhiN3ZXUGord0E0Q1BIVEpiRDhQU0Vh?=
 =?utf-8?B?SDJQSUQ2d29UQ1l6Ly9JK0w2VE9qTitqMVQ0QU4zMnpmazZkM2xJcWllSEdv?=
 =?utf-8?B?YjJDTm1nNm5VZ0VJYUIrOCtONkpIUHllcGdSYVJqc2RFZ0gvRlJuNEZqcnMr?=
 =?utf-8?B?R2xZeUZ5ZW9Xa0EzaGZ1d0FqcndobE5SU2xWK2tGaFZPNDZXWGJlYzN2cTlN?=
 =?utf-8?B?UUpUbndtL25QcERBeHJuMTI0cWRlZTNSWU1tcFhueTF3ejNTR3daTnhvTy9I?=
 =?utf-8?B?ZlF6dHVxcVFqeklTNDd5MktvREpiT0ZTQXdJb09uREh3TDc5a2QvbFNCRzYw?=
 =?utf-8?B?UzJTWWlRYTN3aEhyaFc1S2NVZEkyZ3djRStxbnNoTFNlKzlaaDRySXpqc0Zl?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2b1e32-396e-4835-d0a5-08de0c2385e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:46:24.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i508WZvhFEEmUdoHolXJFcu/1Ud1vxx6xPHNmm7PSAVBZPYa9y4KjLZxgPqzgMev6c2VQrT+a1Nxh95+3Zq6BiYNtNfnw/sBD1UvMlbE1z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-OriginatorOrg: intel.com

--------------0NoCYtCLQ9LtPa2KzIBvmCPi
Content-Type: multipart/mixed; boundary="------------SZfUUUDq5Syxisr0jtEbFpm0";
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
Message-ID: <626c6242-58fc-45cb-a1c6-799443688c1a@intel.com>
Subject: Re: [PATCH net-next v2 2/7] ti: icssg: convert to ndo_hwtstamp API
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20251014224216.8163-3-vadim.fedorenko@linux.dev>

--------------SZfUUUDq5Syxisr0jtEbFpm0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/14/2025 3:42 PM, Vadim Fedorenko wrote:
> Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() API.
> .ndo_eth_ioctl() implementation becomes pure phy_do_ioctl(), remove
> it from common module, remove exported symbol and replace ndo callback.=

>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------SZfUUUDq5Syxisr0jtEbFpm0--

--------------0NoCYtCLQ9LtPa2KzIBvmCPi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO/6DwUDAAAAAAAKCRBqll0+bw8o6F6o
AQDq+AtS7zWNxKfha1NsiZX7zT1/ojTpJyd1foE6BDaDDQEAohwolOy5GuWt+R32LiZv6db8du3l
Wh5IlYiF3u3Gsgw=
=5Te8
-----END PGP SIGNATURE-----

--------------0NoCYtCLQ9LtPa2KzIBvmCPi--

