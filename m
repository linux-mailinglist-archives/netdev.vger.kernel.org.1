Return-Path: <netdev+bounces-202677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC45AEE94D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CB41653FD
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F121FF54;
	Mon, 30 Jun 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHZ7NbY1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A722FE08
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317524; cv=fail; b=OuYVbfWghRsmOSjwvHlQ2fe2gqZgzb4ckeo4yMtb3SDRu/sHMhwcj3/laGENiZDnfuWexcLhoRQ+lu89ZacHnO2lRuqt2raz2vaZN6g+o53BKer9+cM7nycrxCcRZyh4FwHOZoY/2AmiZMpEunZk5Bq+ucyA5uehE5RDqP31oxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317524; c=relaxed/simple;
	bh=N/vR75wNDmWMIkHWSmIECKbyBbT2bXeBWM7f1guVlwk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDCmc4bMXz0wTiBzn1EMSQM4KDcR0enCNo76PvUgV7mYr6SU95TgqvWA13wb92J251twA6pYsL8LOCh4JgrHC+SVgM20VQ/uniBlJmYXqz/Oqwbw7jB5a8BlIeNB9zyGS62rq58zC5UP8g9QiT/yQinOF1ZrdL+AJueJT7eSYnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHZ7NbY1; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751317523; x=1782853523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=N/vR75wNDmWMIkHWSmIECKbyBbT2bXeBWM7f1guVlwk=;
  b=XHZ7NbY1j7YTWD3wnc3c5/cG1lfVXQ4LhzyT6gL5hRC8omR7eR0wW8dR
   ssDepwd7SzUV0YISq0iDpuCJpoE736FDlEEz9xiphmlIJsVNApkuRfu1W
   r0IgBzpCxxKltDDF6LFI1kIRQ4yBRiRfJsumMMmjgX9eY8eLaQumuCyIK
   PzxsGoHqFSXQ7bKq14McWNXrBGGdT9mALvF53f4HkMFg6JCzGTUauIq1b
   fbc0ezcjdMhlpuisG/JdgZmptk+9hiPIVTIK9cXlMg+/WCdUea5Q2mEn4
   0c97ZS3tiI/hdF9D2NuS7TUIDB29QqFnmW7jjSfPnuXdy4ZVCFWpFc0g+
   Q==;
X-CSE-ConnectionGUID: mhCx/oVMTTSwHrBp1BpJ0A==
X-CSE-MsgGUID: 8TyHLOUvTdukUPiYTq3Xmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53666477"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="asc'?scan'208";a="53666477"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 14:05:22 -0700
X-CSE-ConnectionGUID: DIx1U37ITZu7tAm3CnFUnw==
X-CSE-MsgGUID: 3gA/QvVcSt2eGZRD9OrsSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="asc'?scan'208";a="157611521"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 14:05:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 14:05:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 14:05:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 14:05:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkMDWntaojpuOb47J5OcPn8ZgXXi1sbfj1RAw3t8P00m9fYX2Sny47481SsiwlAq1TBTo54dM98DLpytf6rojcI+EwSis904gz5JC/M0c5iAdq93mX+egdAyuyPy+ma+V65rPJa164zUcNxBAq5ps1naI/G6T1pyzLGL2XtBfvgTCwX+6H025Rwz0aOTaLsz9kkOdHQ8W5t2HYfTavmZT5OUE2Fyy2elSX4aaKjb1gC3l6LgseP/yRRX44nuT3+CWu89qmMCY6Mz22Eq6PN9BDD49EVRLMji6GM24vnZs7Rea2YbC9W1Zg6bb5iSHh9UmsqCipXlwjnVOrhNgDmfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/vR75wNDmWMIkHWSmIECKbyBbT2bXeBWM7f1guVlwk=;
 b=Hp/2ggxe+sH22U0XRLvC5clHeFBVw5vWAmgpRgFaV/+CujPKYpM+b5wICtSNs9tIWPQCPaGd1NcpOGv8DEolmh55KVe2ODtbiOh3sUnNb62wd/ASXKpkXAfksXE236N1Cpjwj+6EBC9lOFjzQrCg6RkmlGI9xalBT1s9ehrw6hEn6iktu7wckYeM3q4F1NGk4IpyfqTVIOCUn+7RPTwB247iIKwwAvN+tW/+iic0NLqsUtUz0o+2IsZgcUETK4vjr3vx+LSF/8pw1k6I5r1H6VXYYMdaxelExSVxcHo/t6aeeycQLIheL11lCaFQWhTUQy6fkDbowPPFpx759Xcg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 30 Jun
 2025 21:05:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 21:05:05 +0000
Message-ID: <e7c5748d-5956-47f5-8135-f1d709a7c66a@intel.com>
Date: Mon, 30 Jun 2025 14:05:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 4/5] ixgbe: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-5-vladimir.oltean@nxp.com>
 <7d330d84-42ab-43aa-94f1-5240b67c49dc@intel.com>
 <a9d50186-bffa-4b3c-9d97-831269a84fbe@intel.com>
 <20250630205639.ayydzdmh6et2zlyb@skbuf>
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
In-Reply-To: <20250630205639.ayydzdmh6et2zlyb@skbuf>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------rFwIkrDyYwDZFHpSw1lNnRfe"
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: aea21da6-8c8c-4e35-6d5f-08ddb819c965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUVtdlU4QVNlZVJJZnEvazJLWXN2R0ZIWCt2UUFPNTh5cXdYWFc2TDRPcldo?=
 =?utf-8?B?RHlYdnZlbzdaT3NsMDU2bDZtb3hVeEsyVE9vVFc4aXVackl4K2dYK0hHYzNn?=
 =?utf-8?B?WEh5MFRRdzgvL1lGaXNvcW9FMWxoUWxkWHNmbmJjeDVzNXJHWG1KY0tWZm5a?=
 =?utf-8?B?TGRnK0FKOERjK2lrYlJseHdBVm5PVWMwYjJHT1Y3R2ZlaGZ6QTZaRzg4RUt0?=
 =?utf-8?B?b2JjWmNNN1JpeWNRZ2ZwL3ZzL1kwUURZdy8xRVQvV2phbUdCT25GRTJEVkha?=
 =?utf-8?B?VmdybWRrRkpPTG5RQzZySmhpVHpXM3RSUWpNRE1XYVprRDF4Z1RJUGVlWU1Z?=
 =?utf-8?B?RVN5aDNWYUI5TEZQV0lMS0t1UFpSYTlnYnhsWDZoUTI2d1JJQlY0VEVLSkV3?=
 =?utf-8?B?Q08zY3VWY0Fqb0R2cDFXVk5wOWdKQUxwaHZqNzVPT2pER1pkN3FYRW1jdTdE?=
 =?utf-8?B?NHpTVm5kT2JxNjdITXIzeHB1WEZQcU5kcGZHbzhXME1vbS9SN2N0R2hrQ1Y0?=
 =?utf-8?B?TDdRV3E1ZjNSR3F2d3FmSVFvenZPcXptTm9kUFBVUnZSc2p4UUlEenluYUhM?=
 =?utf-8?B?aU0xQlVZeVArQ3h3T0xzaFZmS1ZJZ1R6bmduNUVzQjVsOS9GTy84NmRYMlk5?=
 =?utf-8?B?dzROSGJxS2NSRDVaMHBGUkhRbTBieEJHNXQ0ei9FcTRzVTNnZUJaY3dRRFpq?=
 =?utf-8?B?VCs0VDlUOExqZUxpcCtXY24rOG4vNE9IZFFQZE5jZktkTncvdy9zTUFUdm4r?=
 =?utf-8?B?aXlXcDZONE93WlIvRzlzc21IbXJHVnlvVmZJdWwzMUs1dVNHZjZvWll4bTZs?=
 =?utf-8?B?ajJEWERvTkExUUNTWHd3SWVIWGlheGxObk1CRG1vNkV2WHFsQ2ZtKzExdVZp?=
 =?utf-8?B?cm42aHpoTVZMODArV3kybWRvOXNpWDgvU2k4K29DVGFadml0L3RxdEh1eEE2?=
 =?utf-8?B?OThSYkh2Y1hxSmdzaEdBSHhhODh4OUNXQXdsWmRxRVNvUjlQWnd2NEJodG12?=
 =?utf-8?B?L0VlMHdtcExQWTQ3aXBSQjJtTnRCeVJ4dFcxcys2Qi9ORFBtYnZyNlg2czlS?=
 =?utf-8?B?b2dJUVM3N0RYS3ZvUlFqN0dnREE0dGhCd3U0cFFINW9PelFXMmJ5UXJWMU4x?=
 =?utf-8?B?cFh4OSt5WjJGQkZqTmhlc2VDRmtEYkNMZ1BFWnhpUm9oZUpzU2RFMnlJblFj?=
 =?utf-8?B?QUExeU95elJncG8vZ0Z6T0JWbjJZMHdyanNtNStId1hacW82endoWVRXLzBx?=
 =?utf-8?B?RE95N3JBUkJWY1MyUGFrdFphNXJLbTgyOUVmcm1OdE5BZE1ETVg2ZjFGK3RK?=
 =?utf-8?B?L0VLL2ZCOFZzRGJRM21MZ1Ayd3htZTM5QXE4dExHUldVSFVIb1dDRW1XZVQy?=
 =?utf-8?B?ZlRtR1g2bjlYbElmRHdmWnBuRURXQis1a25tMTMybjNUZGMvSWVRL2dKRmNy?=
 =?utf-8?B?c1l2cm80bzlkUnJEL3QzZjJ2QzBHb2pFd3NydkJOcGZoT3JYWXdlSmRoU2tp?=
 =?utf-8?B?c2p3akFoRFkyNmp1UzVJUnN5RzdnN1VKMWxDVnc4SXFlWUlLcjB2QUFFM011?=
 =?utf-8?B?WnFwQXhwWlZLWUJBWCtuVDd0c0lFS2pqUHpYK3JuMmdDNXc2WnJNbHYrbGFV?=
 =?utf-8?B?WGllSUp3NWZEMEdpNFZnQ09YUzVreEkxNFJyMTdwbFhNb216NlFtcjVuL3Yx?=
 =?utf-8?B?akR5aWlOcGdVVHluMUI1VzlrQTFKTHJVTStLTmwvYVJ3eVlXTTlHOVZVMFJ4?=
 =?utf-8?B?cWpOQjVZQ1F1TTZzSFhuZlpCd2x3L1M2VjdOMU1CMC8vQ1Y3U2RpQXNVbUcx?=
 =?utf-8?B?cnZ6WG9ySGVzNnBnQW1heDB4MEdsclVYekJXSno1Tlo0VGRzeEFwcmxBOUlx?=
 =?utf-8?B?RWpFeGgvQkxUMmdJbExvRm9ZZkVsWmdkNjhCbDFaMWNvTVlFQ0xpVnpvME85?=
 =?utf-8?Q?1lHlQqD5jB0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEoralNFTzhIcjFOdnR6TUtTS3kyYXVjL0RkTXZ1ZlFhTW9TZDY0WUo5elNn?=
 =?utf-8?B?WkthaGsyZHBRSWlKSmg2ODBuTkh5c2toNUVrbjc5aFZEREFudUhnRWZuNFJs?=
 =?utf-8?B?NEZrTUpDM1RCRW1kOWZROTRCSHVyTnp5SDExbi9kK25hTlloYnN2aXRTZERR?=
 =?utf-8?B?NU52VkNDTFV1K1R3RzRUbmszVEdKZERxUkpiVUhTeTBqY2p3czBlZmhGd3Nz?=
 =?utf-8?B?eHc2QnhXQms4aFc5ZThzSUNmNGx3L01TTjJ2ZFNZWDY2cncwWTI4ZUs3Wkdp?=
 =?utf-8?B?QklWT3VTVDRpUVVHVEtaMVQvUzNnUW4vdzZYcXcyQUxJZjFMc0ZCRUNSbzN5?=
 =?utf-8?B?STFYZkNiQ3IyRldkUjhlSGVLWVIwRGI4MWpvSEN3WGQ4UWRWRVV0SFBkakV3?=
 =?utf-8?B?Mlo3b2NSdEdTenRsVGtrY01Lc3h5M1J2UVN2T0ZQdU5Ca1BuT3R4bFRUR1JF?=
 =?utf-8?B?Q0RWTlFSNVBNejNHenJQMlBQaDZKWHBqeGNJbTluQVpCMHV6QWlrc1dONStK?=
 =?utf-8?B?WDU2QjU4M2ZOTDJNUmlqZ2Z3bWZaZlNNTGk4V0dCVE9LTDhNOXJwY2ZucTNW?=
 =?utf-8?B?TmhlaUZabzJxT0s3SXpYSnVmYjBUc2dPbm5XQk5tZm9FM24zcFVrRWlvZWFV?=
 =?utf-8?B?bG5BQ2F0cFNoTWVmdHBnOXI3emo3N3BUanJyck9qS2IwT1RkdHhJMzFmSWo2?=
 =?utf-8?B?ekR5bmxQV2xVK1d1S2paWWZOMHg2UWh4S0VZeGEzdTUrSmt4eWFzc2tQQUdh?=
 =?utf-8?B?aVNOYnhaSS9aWDR4Uk9hN05TRWxCNzJ4c0VrLzk3c3BpN2g2a0lwSW9WcHI0?=
 =?utf-8?B?UFUwMUVqM1J1Um1WcHdqSHd3UEJ1MWJOK0Y2b3M0TDRyeEtSUGxON0trcWtJ?=
 =?utf-8?B?U2R0TTlzeW9WMEZmWk83T3JtM3NZWUU3UkZvcU9sUWNXaWZTMHVoT3ZBZ1Nj?=
 =?utf-8?B?SWVOZS85R0RTSDRlaDl4bVlRTStsYllud2xuWklDWCtlUzQ2VzM4OC84aGxI?=
 =?utf-8?B?YmszNWYycTJqcklxZ3JqL0FDbS9GRGJtT0J3QksvQXZTMEo0b0VCT1A3YnF2?=
 =?utf-8?B?bDBHVkhoVkNQNDQrVnl4YlV3SkJqYnlyUFQveE5wbFNESms5a3VXcWVqTHpz?=
 =?utf-8?B?N3RjTm1OWCtma2dSQXdiajFBcGc0TXhDdS9KSXdxZkd2dllUbVZmMTZUUUNK?=
 =?utf-8?B?ekVDamtyUlpaTC9UV2I2a2diTXpWVVFkWm9yOG80UVErUkViUVBRcllUakhy?=
 =?utf-8?B?Nml0L1dpcFdyUTE5WXNla2lMcTZYeEQvdjdaTDA5dlJtM09YT1N5VjlMNEg4?=
 =?utf-8?B?cGl4TmdFT2VYd25WZXZkRDhQYWJOei9DZzNUaXArZFBMLy8vWDFHNzh6ZFRy?=
 =?utf-8?B?eUVkQ0hEWW1oZmFhVERFTFJjUllacUx3Mkl1aksvRE9CQWU0YS9vd29vOWRK?=
 =?utf-8?B?ejBXcDhBZTUzNDl4MGxUeWtkeDZwSittSUhVc1YxOTc5T1RIQ2ZtTnhLclY1?=
 =?utf-8?B?Z2FBSStTWG9pV0UxQVJMVmFtZ2V3bHowc3g4bWVXYk9salR3V05May9xRjNm?=
 =?utf-8?B?aThNMytEUjlnc1FIeVlzU0hUa1JuK3M3WUM3Yk9aeFpMZVdWTW5NUFUzYnk4?=
 =?utf-8?B?VnphUEdteTVaLzkyZTR5ZUVmWGFBVzNzRVY4dTg2R1ZFTlBrQUx2U052djBm?=
 =?utf-8?B?ZWsyVVZzQStaUDBnZW1mWkovZmphTk9NUUZieklvY2NNQ3ZLbUNEalhRQlRG?=
 =?utf-8?B?ZHU1WDU2dFcyUHpIZFBZR3ZnZHVyQjJmQ3pMK3BZeTloWDRJdHdEdVFpbHg5?=
 =?utf-8?B?SC9hbm0zMjVjbS9YbGppaldGNldFbERZemFNa0pDSXpTUjFhd1dGdU1qbWxw?=
 =?utf-8?B?NXpqMXpLWkVpSmUvSWRENTRBVUNCcnl3dHk3U2x4bGdkSitaWlQ4TGhSdy9L?=
 =?utf-8?B?TEtZUitJZGtLbm9mREZESmRrSERzZHNqOHdsQ1ZkaHNhTldKbURGWEZ1RVdu?=
 =?utf-8?B?Z1g3QjJhaE16QmRadjdKMkZMMDUzakp6aG5rU3lBSTQ5cS83NG9IL3lGNS9a?=
 =?utf-8?B?bUREZFMya3RQbExzTnhvSTZYOXA2ZVp2dXBWeU9oQS9NMmpxeDV3bjQxRzNu?=
 =?utf-8?B?MmttY2FQbmJSbHFPdzZFYjFkeUNVMDhVVDVKYXNxNjVQZ0dmRmYyVHpScjJP?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aea21da6-8c8c-4e35-6d5f-08ddb819c965
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 21:05:05.0352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TST2+j2H0ej1Vleiez/CQ90echWgm5wRMwWBCiABjhUH2W+6t2q/1UOPBvr7NSUrKMi7Cp6EwSnUGiDGT8QZexDS5uF7olHJ2iJkDuA8PYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-OriginatorOrg: intel.com

--------------rFwIkrDyYwDZFHpSw1lNnRfe
Content-Type: multipart/mixed; boundary="------------lV0hkUndWGvgFCPHw7tja1D0";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>
Message-ID: <e7c5748d-5956-47f5-8135-f1d709a7c66a@intel.com>
Subject: Re: [PATCH iwl-next 4/5] ixgbe: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-5-vladimir.oltean@nxp.com>
 <7d330d84-42ab-43aa-94f1-5240b67c49dc@intel.com>
 <a9d50186-bffa-4b3c-9d97-831269a84fbe@intel.com>
 <20250630205639.ayydzdmh6et2zlyb@skbuf>
In-Reply-To: <20250630205639.ayydzdmh6et2zlyb@skbuf>

--------------lV0hkUndWGvgFCPHw7tja1D0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/30/2025 1:56 PM, Vladimir Oltean wrote:
>=20
> Ugh :-/ sorry for the trouble, and thanks for doing the hard work of
> characterizing this.
>=20

No worries.

> Indeed, my first conversion of ixgbe was in August 2023, as this commit=

> can attest:
> https://github.com/vladimiroltean/linux/commit/0351ebf1eee3381ccfba9d31=
a924d1dd887a316f
>=20
> At that time, Przemyslaw's commit fd5ef5203ce6 ("ixgbe: wrap
> netdev_priv() usage") didn't exist, and "struct ixgbe_adapter *adapter =
=3D
> netdev_priv(netdev);" was the de facto idiom in the driver, which I the=
n
> replicated two more times, in the new ixgbe_ptp_hwtstamp_set() and
> ixgbe_ptp_hwtstamp_get() functions. Not only did I not notice that this=

> change took place, but it also compiled just fine, making me completely=

> unsuspecting...
>=20

It would be nice if we had a mechanism to provide type safety for the
netdev_priv.. but with C I don't really know of a good way. If you
provide your own macro you can do type checks on that.. but I'm not sure
how else we could implement this to avoid the type issues.

The use of such a wrapper private structure is essentially required
either in devlink code or netdev code because both of the parent structs
want flexible array private members, so they can't both be ixgbe_adapter.=


Of course validating with KASAN would have caught this faster.. I am
actually quite surprised that we manage to get into
ice_ptp_set_timestamp_mode() and invoke the register access functions
without immediately crashing.

At least its caught before this merged and caused memory corruption on
production systems!

> Tony, let me know how you would like to proceed.


--------------lV0hkUndWGvgFCPHw7tja1D0--

--------------rFwIkrDyYwDZFHpSw1lNnRfe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaGL8AAUDAAAAAAAKCRBqll0+bw8o6IgE
AQDerDl9NoEBj9IB2+nZHFRSihVgkhvqvU7rWeX+Rxyb+QD/dcrr+PcctYxkg4NQG3zX0P2fyBLv
SjZ/OGQI0zBvqAc=
=oVkk
-----END PGP SIGNATURE-----

--------------rFwIkrDyYwDZFHpSw1lNnRfe--

