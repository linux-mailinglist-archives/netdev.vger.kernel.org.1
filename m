Return-Path: <netdev+bounces-79419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E215879257
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C951C20ECC
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC78E78B46;
	Tue, 12 Mar 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVBIBUkh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051578685
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240256; cv=fail; b=tA8p1Mb78aNS0sQNSRckINYetBg6ZiCqIGShqNPmxjODJuHPgrv+EWu4Aku06lNrweD/i6+x2/LFk6NwhJOvAn/ZQyNl2SwD+Nm0+h7pW6MhGav4FtAw250P0eZYGBKnKSNQrC4ChpYATTGN+3b0vBB1K2a0mu+C9W7LxxObr/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240256; c=relaxed/simple;
	bh=3Av+xAS9uy3APLEwFYpRtsQhWNptnN9PD5puTKwDxOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HpUxlRBOjNLXKx7zIsaP1ZpEMiAyaQ0LXdM/vZoR/6L1EmQRsVgmjv699swO67zL6WZNqqNVK8fDsQuWX3+22BJf+12m0cb5f453tLnX+0qx1kPVN/67xQF0QxA0Crfls6hkV5jkQBvPE9m5TUnUJUebvgE1fbmpsi3b62EbKRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVBIBUkh; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710240254; x=1741776254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Av+xAS9uy3APLEwFYpRtsQhWNptnN9PD5puTKwDxOI=;
  b=eVBIBUkhg/BhKcvObFxr6NVFOpDIGp7Dat/NKp0kLFD2NFajQhliDZrH
   p0OH+7Q7R+km2KVyomthNi3J53KkssmKfrShoZuIuK+rXacX2yIVvGx51
   RX53BElBOn1F9xp5zzw3r93laPBc5rp0HXQWSMeUJvPsjK+AuPZ1nivWG
   bQjzNDX8tGwh/AjK2lPI+U96Bm0ZbYxqDdk93flyli6NTrCBNMMuwj//F
   FH/7PU82at+bUNEpDZgR4khmTrffRsyeEp2yH4FIp90Yh/4fX9iRsuyNG
   43NMncFeizFbM9l4vMtWBwBYpc+yMnNlruAuS5eQaVpWhgljZxyYsSycE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8757841"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8757841"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 03:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12093959"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 03:44:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 03:44:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 03:44:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 03:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi9ovAZdqoLzaFCI7UG+JJwRdAi1wyTPpFdkn1MRuNazW/fuPjQnBK2l1fSUDDQ9/BZObV7Yy8ocO6ht9zIpR1DR0yUXWNJh2pQM2snA1n3bCXsg0xXk+tydNH7KoC+jmO/2hmMM4W5Rsnfr5tHEFQusVXjVG5ORWL0CfGNv1rQquxrU4HmUysLMKsxX7LtxXh867HLoGgH7bdI6m2dCnf8MtobadTR+dW0GZr48jnLnqhaTHvvV6JexBY8kksQPuiVWNbD8bBXbJzgoTKBUz6dUdFxJpZbT2kpMykCpGEJ6fYRhdkcljdEtgrPCE++fAsw08SgZgIs4ut/xlUeKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Av+xAS9uy3APLEwFYpRtsQhWNptnN9PD5puTKwDxOI=;
 b=QpVcd4rHw6KSXs64nlXXqb5rJn+e5odBv5JPLuZ3e35ixOcnY7B0F5aKyaexq1Q2YnzpZqlawNcmplwwZUJyPwGWfYsufzetwN+MbiDOFI2acyDbDXeymFuFQ/KB8+YjdbaKSSBLsPhBZCBf9ZtP+YMEXavjIIeGkuJ6OZf7eWFBmgy6pdywc7ufDHUzORqOQHwD7Y04KLPP9LQrzsaU+Dz8eVc2zBYl3xdNt0v2LY1W3QyigxFKA/lZRlZ27c7mwOc/kXPOZiiuA4YrWACeEm+U2DINUuCLuuK1I6ct6V1l4EbJuR3yp9dXeIgNPf8dn4IDQTDZFOT05gcNqgSRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by SA2PR11MB4841.namprd11.prod.outlook.com (2603:10b6:806:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Tue, 12 Mar
 2024 10:44:11 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688%6]) with mapi id 15.20.7386.017; Tue, 12 Mar 2024
 10:44:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: fix i40e_count_filters()
 to count only active/new filters
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: fix i40e_count_filters()
 to count only active/new filters
Thread-Index: AQHadFaWqnaxy7YatEafUTlaR4lkV7Ez2KIAgAARzNA=
Date: Tue, 12 Mar 2024 10:44:10 +0000
Message-ID: <SJ0PR11MB586671B12E1854FE2C05A172E52B2@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240312081343.24311-1-aleksandr.loktionov@intel.com>
 <431b679b-9933-470c-acda-172d12ea4090@molgen.mpg.de>
In-Reply-To: <431b679b-9933-470c-acda-172d12ea4090@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|SA2PR11MB4841:EE_
x-ms-office365-filtering-correlation-id: 7e8c812f-fc18-4d3f-9ef0-08dc42815a27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2iBoxuKkBkRzU6B3czt2IZpU/Nhg9gxp1KamQ71KVWoFau9QrFHPCpHUeHIc4ESmaj9VPB7Z2oGCNHJ0MJVvcKRS23w9KZmRlQ3WIBi4/zyvkm7KA6TfD2mQxSnXEvVZnMj1wJSFb8SdXU654nfvYTO+QXbdE97v9hujh3GgvAJWIUrwAcqflvuV01xJuA52bfoAofZdkWXtJDQn1mbew/TJTbuzgqnO2NHcW7Ywsbc18vF5mXr18bF2ZUQVbKmMugDqjL88CCoPE9FrNRbTPwZwQYSY1QGsxFnsHAh+XrJzIH37g492M2KAG8XaWdlb9pNihy2kQaDVlHonPBYh7YNzjxiPsrWb3ehoO+b3pqSi7ct9qki1E6XjAfonJ0ERsPguEkWhIIToP1v/TkPyqV9LcDHwAjoLrt/2tOLF6AQaKfjXOw4zHpAiU0W0psM9jtpFBegB18q69xCcPaTk76nOhZ4WXWWHPD0xjCyG8AUQmI9XsevcKBytM5g0/WdWfKpLJJBunzsODbHhlKaY9SYL2ixw/ExLdTj+3UourzRu8Eb7pO6Qw9WNpnyOEJ3tuZ08TrZNR3+esXua7ZflHFOUMrRjxKiTJlgfK03DtskBtBSJ3n3T8aWzUfLrayxAjIa7zbmanNv5EU9/ugNw0cilCeSxzpNdbgtwX6jFvfCc0miKqjV26Zh4SsRddGNl2Ln/Cc28zdmao12P4OwLur6zGCYL1r4tR0oows/ozNM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2szZE00aFU0Z1MrZ0YwS2R5UWZWTTgrYkZHeW5ZTzZXQkhrakxPcSswdGhw?=
 =?utf-8?B?ajdjQmQ5VklTbDJUZXhtaG9IRURxa21neERhTGdMUmZJdStpejhOcUV1UmhB?=
 =?utf-8?B?M1p1bDZNbXgwaFErd3pJa0VWODFHZjZGTmJlQ3BBbGVTU1lJWGFjN2t3UlFn?=
 =?utf-8?B?UTVIRUhnUER3NWt1elZyYU9UaVNVenJCSm56OU0xVVBWcXhOaDBxRGE1SEZN?=
 =?utf-8?B?c0dKQm82REZockk3Q0ZpUTdKV0Zmck1CMUo1MVNjbkEvTmdXa3h4WU81OEhN?=
 =?utf-8?B?dlJkNXpKR2VkOVZSMWEwelR3RTZqd0xqZC9NeHJDejhnbGtJR1gxangvSGxs?=
 =?utf-8?B?bDgwSFRoUzVTakpOT0RxYmFZekR0OTEwVm5VQWNzWXczd29XWTRzejE2aUVO?=
 =?utf-8?B?QmxBb3pyQW13b1pmVWZsNUk0WW5JSjVyenJxREl2TDFzM2Y3Rzd2WVJObzVB?=
 =?utf-8?B?UE5USVJscTg3VzlHd1FETFZMeVRrQzh1bGhuL2FUODZ0d2wyb1J2ajFEckNh?=
 =?utf-8?B?WXJKVUovc2lEWUxNY0xtT0llL0Y2cEM0ZUlyNVZUUzZDWkN0WFBtNXFqdEc0?=
 =?utf-8?B?ZWFXTVF0YnZlejI4Um9JOTdyMzVwMFlaQTRZdFFaQ21VRmp5QTdQc0ZBcFdE?=
 =?utf-8?B?ZFFhU254R2l6ZEJpcnlmbW13Z05OM1Q0cXFTY3N0aEhSMzM3ZThlM0UzSTRW?=
 =?utf-8?B?L1h2N3dOSzQwSDhNUEF5ZnVROHBPa0c2RExZOHhmallFVDNCZDYrcFMzS1lL?=
 =?utf-8?B?d0I5dGlpZGQ2VXZaVmhGQlFSbDlmYXNBeW5RMjFJMjB6MEprYlZpUndKbVVN?=
 =?utf-8?B?R2F2K3dKcHlvTU8xMGtkckg2VC9LZGF2UlQzTmhvRnVqcFd4bGZMU0sxN2hZ?=
 =?utf-8?B?NzE0cStLTlRXam10azd6dWVrRnpZNzQ2b29DRU5WeE11Uk84WVYxOHFsbXRJ?=
 =?utf-8?B?eVM2M0l2QVhCbU5oRllLZWdyb1BJQ1g5RXh4d0RYWHR0QVBiaDFzZmF0eWNy?=
 =?utf-8?B?eTlvUmEwY1o4bWNrS3BmbWxHYTU3WEN3SXV3cnFhOTF3ei90cVZDYyszaC95?=
 =?utf-8?B?aHVvTVNzL3dVZDZxdmVQMTduNGpEZFNTZWtZUTRIc3E1bEljQS9aWjEzQ011?=
 =?utf-8?B?YXRWQjEydlBXTXZXMFltK0MwNlBuUHdKTkgrSDUrYzBoZWFJQ0JXQmxvSzNu?=
 =?utf-8?B?TkkxamV3dktUVEx3MEZkUmwxMVZmU2Q1a0MyYWtHNFBXQkRCalR3eHpUT2E1?=
 =?utf-8?B?NlF5VWZCd3NCdXNXYWlSTnVlWWRzVUtzdFZPQ1NtdUhiWWFmeHFFdStpeDBZ?=
 =?utf-8?B?Qjh2K1V3WnpoQnZveFFFUXZ3eGdNeWhGT2Z0Njc5azdEZEZkVHlJcTAyR1FW?=
 =?utf-8?B?OHlQVDR1TDJPckZYcUh6ejNOZlFiOWlSNWk0VFNmdy9kMW8vVzJqRTBvbm1x?=
 =?utf-8?B?UHdkRm5OYmZBRVhuZGo0SFJFVU5GN3laSHFZTTRPQlBORUk2Z2YvZ0NWSzl4?=
 =?utf-8?B?RkQ2Q0lxaDZJY3l6WDU4eGxFQ043QTMrOW1tWGdUY2VJUUxYekk1TGxBSFU3?=
 =?utf-8?B?K0RqSVRiUGl0dHczbmlMOVpRbGFNZFFMb0hTRGJIeFNMK09ibUlWL09XZ0FF?=
 =?utf-8?B?c1ovL0dLM3JoaHlSOTlpS0hieDB0RG5QNk15NFJKL09IeTZ2Zi9GVFR0aE5P?=
 =?utf-8?B?eTRONTNrS0Z2TmJzaU1xTWxEcHk5aGpHL1E4c0RmQ0lReXRpT0hucnpoaTZ2?=
 =?utf-8?B?bUVHU1dDVUIxTnR5L2VqaS8zb29TYjhtTC8xKzFvS1FwbkRhaUZETnZkOXJo?=
 =?utf-8?B?S2pWMkRTdEpWR0dVTS9CWkI0TWRBU2UvSTFTWEhoRTdpRGhDWVl5dlV1Nzcw?=
 =?utf-8?B?VnFiSzVLV2ZkcW5UeTRCdFhyTEhVYTdrOGw3NEJwWGVFbk9hTjQ4Qkk5S2Z1?=
 =?utf-8?B?ZlR1dm1sanYraEdkS3IwTzZVb0Y2aDA0Q2xNU291ckJaWGdpNG5jRmxiSmVX?=
 =?utf-8?B?VlM2OFhGRlhGQjBTTzZVaUtJWDRZajNhUEt3VjBtTlA5Y0xHWitNYnB5ZnRt?=
 =?utf-8?B?a0MzSFFQSnB0R1ZHZTR5L1VBN0hacHVDcEtFVlNnaVlVTjZxNWE4RThXL29H?=
 =?utf-8?B?Z3ZHTWNUWHF3N3k5eHdHMU5UelRvd0I1THFCQy9VZXc2M0IxTFpWbHRsRHhD?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8c812f-fc18-4d3f-9ef0-08dc42815a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 10:44:11.0021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbClkyRHMA2qEvNZpVRf8x+FlTYhnfRlANW9HQ/pwYGgkglclAWQwCtQvssDcZMAaVK0WRqK8T28vVZmonqC2HXvde24/qakLTMAODYZAOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4841
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTIsIDIwMjQgMTA6
MzYgQU0NCj4gVG86IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGlu
dGVsLmNvbT4NCj4gQ2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBOZ3V5ZW4s
IEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBLdWJhbGV3c2tpLA0KPiBBcmthZGl1c3ogPGFya2FkaXVzei5rdWJhbGV3c2tp
QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wt
bmV0XSBpNDBlOiBmaXgNCj4gaTQwZV9jb3VudF9maWx0ZXJzKCkgdG8gY291bnQgb25seSBhY3Rp
dmUvbmV3IGZpbHRlcnMNCj4gDQo+IERlYXIgQWxla3NhbmRyLA0KPiANCj4gDQo+IFRoYW5rIHlv
dSBmb3IgeW91ciBwYXRjaC4NCj4gDQo+IEFtIDEyLjAzLjI0IHVtIDA5OjEzIHNjaHJpZWIgQWxl
a3NhbmRyIExva3Rpb25vdjoNCj4gPiBGaXggY291bnRlciB0byBiZSBidW1wZWQgb25seSBmb3Ig
bmV3IG9yIGFjdGl2ZSBmaWx0ZXJzLg0KPiANCj4gQWx0aG91Z2ggaXTigJlzIGEgc21hbGwgZGlm
ZnN0YXQsIGNvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlLCBhbmQgYXQNCj4gbGVhc3QgZGVzY3Jp
YmUgdGhlIHByb2JsZW0gaW4gbW9yZSBkZXRhaWwuDQo+IA0KPiBIb3cgY2FuIHRoaXMgYmUgdGVz
dGVkPw0KPiANClRoZSBidWcgdXN1YWxseSBhZmZlY3RzIHVudHJ1c3RlZCBWRnMsIGJlY2F1c2Ug
dGhleSBhcmUgbGltaXRlZCB0byAxOE1BQ3MsIGl0IGFmZmVjdHMgdGhlbSBiYWRseSwgbm90IGxl
dHRpbmcgdG8gY3JlYXRlIE1BQyBmaWx0ZXJzLg0KTm90IHN0YWJsZSB0byByZXByb2R1Y2UsIGl0
IGhhcHBlbnMgd2hlbiBWRiB1c2VyIGNyZWF0ZXMgTUFDIGZpbHRlcnMgd2hlbiBvdGhlciBNQUNW
TEFOIG9wZXJhdGlvbnMgYXJlIGhhcHBlbmVkIGluIHBhcmFsbGVsLg0KQnV0IGNvbnNlcXVlbmNl
IGlzIHRoYXQgVkYgY2FuJ3QgcmVjZWl2ZSBkZXNpcmVkIHRyYWZmaWMuDQoNCj4gPiBGaXhlczog
NjIxNjUwY2FiZWU1ICgiaTQwZTogUmVmYWN0b3JpbmcgVkYgTUFDIGZpbHRlcnMgY291bnRpbmcN
Cj4gdG8NCj4gPiBtYWtlIG1vcmUgcmVsaWFibGUiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZWtz
YW5kciBMb2t0aW9ub3YNCj4gPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiA+IFJl
dmlld2VkLWJ5OiBBcmthZGl1c3ogS3ViYWxld3NraQ0KPiA8YXJrYWRpdXN6Lmt1YmFsZXdza2lA
aW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQw
ZS9pNDBlX21haW4uYyB8IDcgKysrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+ID4gaW5kZXggODlhMzQwMS4uNjAxMGE0OSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFp
bi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4u
Yw0KPiA+IEBAIC0xMjU3LDggKzEyNTcsMTEgQEAgaW50IGk0MGVfY291bnRfZmlsdGVycyhzdHJ1
Y3QgaTQwZV92c2kNCj4gKnZzaSkNCj4gPiAgIAlpbnQgYmt0Ow0KPiA+ICAgCWludCBjbnQgPSAw
Ow0KPiA+DQo+ID4gLQloYXNoX2Zvcl9lYWNoX3NhZmUodnNpLT5tYWNfZmlsdGVyX2hhc2gsIGJr
dCwgaCwgZiwgaGxpc3QpDQo+ID4gLQkJKytjbnQ7DQo+ID4gKwloYXNoX2Zvcl9lYWNoX3NhZmUo
dnNpLT5tYWNfZmlsdGVyX2hhc2gsIGJrdCwgaCwgZiwgaGxpc3QpIHsNCj4gPiArCQlpZiAoZi0+
c3RhdGUgPT0gSTQwRV9GSUxURVJfTkVXIHx8DQo+ID4gKwkJICAgIGYtPnN0YXRlID09IEk0MEVf
RklMVEVSX0FDVElWRSkNCj4gPiArCQkJKytjbnQ7DQo+ID4gKwl9DQo+ID4NCj4gPiAgIAlyZXR1
cm4gY250Ow0KPiA+ICAgfQ0KPiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCg==

