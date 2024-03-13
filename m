Return-Path: <netdev+bounces-79604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE9387A217
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 04:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EEE1F23F39
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 03:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C4101DE;
	Wed, 13 Mar 2024 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVuR0ew+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C049476
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302142; cv=fail; b=QlkL1txtslTFZMsmaIIj0RbpxvFVvn3JNiN0p1iOpiOANk7mwWHs8XE5unhqZAO2nVPZprRKbrVC8SLrrc7gV4+wSBrUm0idflF+VLAxRojTKvhmFede/s23dLij+LYlfZZmET44R7U5FwOry1nVzRUjTGg7lV/0a6HnxwcwhE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302142; c=relaxed/simple;
	bh=+8jievE2i/ytvM31uaya6Jq/odVg3o6j82dqF0hoopE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aIZx6uqgIri9COh0r9VTyOGNMDDbdntqOPbKiXqP5oZADfQ0B/WA0D5fKCSkSvGIZNj76vOmntbpaGUY1Q7gOsx3Mv9dkTLl2gac/hwaZ5Mu2WX//XhGLu8svbwAddZSYj9tTLDgSKniSdb8DD7ssaW8eGZiZmoGYbQmkEpZth0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVuR0ew+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710302140; x=1741838140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+8jievE2i/ytvM31uaya6Jq/odVg3o6j82dqF0hoopE=;
  b=kVuR0ew+uYdDvuLZnURT9f8IDkHZrTTD241xc1dLP129Ikln+4mX3CPI
   TFvOHqgFPjntbkIltvoXg7Zg2BmdH6v+1k1OqRBCrY5Vh59QkJUySzEzD
   /ED7QdUtHErZ+kK3ACgCV30x2vTognNVE2WD6xGZz9UYO9eqZrG54fMid
   gqgJyZ0WAJnwK+sAwHLCqiy37oAJGGdj5ydXjzQ5fXcsVoJIS/klilPdA
   A08y8OR+R+sPjqvYpYpiMfH2QoQVxg1jxpMlA4NcxkjwtT3HrKZqlxMU4
   izh+aHUQaMQ+thrzL4LXSl0T5q++RebEXvEbsgPa7SLrpLJZ2C/unQw28
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4914521"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4914521"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 20:55:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11697503"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 20:55:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 20:55:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 20:55:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 20:55:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 20:55:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvVEQsWh60OvW7gR1vdQNk3c1wsUfaXYVkY1+s/y7lVRb9gHblF5hwWTv+JoQVo1HLog2KcuPZYR8+9Hw2B2YP5dCowxkLNOTHiPCkPnTZEPx/8CDwmi1S9VDTDESwrZpk0ngqxMPi027qfiPFQpja4zA4PTU0VzwPTyCh34ZdTDXtHCTw5V4A8+IKe6kKcVHec61uaYTAt5zh4lGXDnYyHlM2ey9SqowspCys2p9YO6+0GB60loLZ3/eeEC/ja/YgEyNlPtaa0aV21uXx1ULT3pIrUbJdeKOgB26mB0NLf81ypu/fqWJL08NJ45XsBnIv1VQ7foPHKNdU8bkBGi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZWFk7vUAdO+r361ZqPYMsYXm9pmonCZ83L6anD7K2M=;
 b=FIznllk73meqVbgEqjOzRBJgyyMrjNE52QrWyfguKtOIuASyr0f5xTZ1kWjdfDTPh0HbwNsbA2ke8UZaFIMeLm4mfZO+t0X3f7tg2rOp/rR8ZCB3Y9EpcgBL2SLwU8QGpc3UmU+VwGSncMWDzVIa6gHCW/Qz7BqsmdK9Z1gCKcJo/WNyZtVh55WVxscSyJanFdvJlSRlaJH0hNvnjUdhsaVEStjWiFpwW2cOsNqg/JZ3bQ5YwsRzxVyGw7dK0PrD29VdzfXZWS0+66QB5RRvXGiZzqb5mOZP5u69IkbjwepMdwgD4z7lHq90nGX+Rcmzz+qjqazch1JoNnyaKAvMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 03:55:36 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7386.016; Wed, 13 Mar 2024
 03:55:35 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Brady, Alan"
	<alan.brady@intel.com>, "horms@kernel.org" <horms@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 2/2] net: intel: implement
 modern PM ops declarations
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 2/2] net: intel: implement
 modern PM ops declarations
Thread-Index: AQHab3E2e3haonoWd0eT3aRjUufUaLE1FTyw
Date: Wed, 13 Mar 2024 03:55:35 +0000
Message-ID: <CYYPR11MB842975830940F22571722F8ABD2A2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240306025023.800029-1-jesse.brandeburg@intel.com>
 <20240306025023.800029-3-jesse.brandeburg@intel.com>
In-Reply-To: <20240306025023.800029-3-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM4PR11MB5231:EE_
x-ms-office365-filtering-correlation-id: 05b28d38-3324-48d7-5b84-08dc4311705f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dSAXSjRUBqDkNOA7Bh+puWQ4udFuMFpVoEz6xUAXyZRj1X8rYE0HbHLEnIaMXPGte4oN+vI65iT1TdhUl2p0C1m/9WvnRCy7AP4I6wUV25zRRi7ovTFX69xWo+RvcE09aEpwX4EEQ0aazKA0ykHqvrPHbQke/Z7e66q5W8BMgHiDpk357eZh1/8+CjDXJnJYoub6SBnAyIcf3WHviM5HH2y76r3C39cc+aApeGzXQMGgMb4621orvKICYB4JKjZb43kYoGR8oHKTaQ7nlSRLEV1A/evYCCXh0xYsB30lggDItcCYaCds2J8vlBHwgcO3OiJcvxF7xUELlN/2GogyROUbT9WMfio/AHBRIBBJBKT4X3PyTyNCHZKtl6/d2B3RsfjbX4AuEjzVl4f1rKT0VFJtrwR4dMrHHl/njicADlS4U7WYCj7uBhBEMsdm5p+2l0Q1jTSTE1ociT3xFoCWkBxad+0ZdazgIPIoq3O+0MIS3YkDMHysfeG+x5wqFIKmHSWwdfQ2jWbWEfIDlmxldPTWpJXr6Rhl6dznQLJt9d+JQkaBUcx6hn7r8RMuFJdl38Q52jZ1f5u4crlO9A7aOrv7ch/bsHNxqH0bD7iyKayZayyWD5RiQ0lOUYcMUwBS4MYzqvkHKt9LyzFU6OWjOLzz2XAZQK66tQifxo9+YQYB/3AXoTcMYzCg1OExhQdrWN4PnvYu1XC5bR+EnkgzqOEDyXcmp2k2rUJCElR7yw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+DPf5wkU6qT9gakZfAWSr92B7fYEs8F8wbgA4njSLx9/iNqOjgrxOBU0W2Pz?=
 =?us-ascii?Q?r7FNGoITudFOSZ2452HjEQGsTs2sIYTDwYvseNxYUHTT0kb7FMjD7/v2kKw8?=
 =?us-ascii?Q?+xKOwnDLkcnppu9qKkLTr6va5qA1pdZD76rnfJBOuFsGWFZmG2rH8VEhoftb?=
 =?us-ascii?Q?OrpzV9QKw+GoStauJ9LttxXRPlWpFCdwTc5srEepZqvz1daptdeDYOvWUiG2?=
 =?us-ascii?Q?Yyn7Mk1RqK7QADhiyrm8w9BZ/MNOCemOklM7R08iRo8DMjbmr+jiVb29GkkA?=
 =?us-ascii?Q?wsNzsX0Eu/LDXlzvRvPK0Oebm4TlQ98/rvfjZCrACcWb1B36vDIkKWw9bKmh?=
 =?us-ascii?Q?sppYMru+gTcZTfSSpreQE4K7LQx9/yKjcc+ivd5jbNTNAa5RmcRw0H0ojswY?=
 =?us-ascii?Q?L1RyC6A9SNAdawWgCPvuw6jyogD7G2O88QJ/qJ3MHCmqpvTx69FnlbigrVas?=
 =?us-ascii?Q?K55RAQyosRV0hgJajNo7kRThfIWaOqY4g/pJTu8wbDxTHUydQgyfZ8vgbMXx?=
 =?us-ascii?Q?jowAqrN0Bqh6p+vTS2kCrIKgDeYvnT3m4V0wGHiy2dmUVEKe1rxzaAM07ghE?=
 =?us-ascii?Q?atelbEk+SXGyNJsb0oODNLdNtkAy4IeXGsfy3Rkc7NuRrhf8EeL/hCvJ50IU?=
 =?us-ascii?Q?SfnJjk0EfoXq32LK7Bn9JwYTOghZQa9/RuwkxWhfzxRz/ECSjAIaX7FixqrB?=
 =?us-ascii?Q?2bQMwHdfNkMLGLMdN0NaGhezsirGi4DRaNupl0OxaUqhysHzOgE9GJb+DV7N?=
 =?us-ascii?Q?a0TDvwK6pzvEG0iSkTyhBe0zKDMcb+awmdL6U3yAZ+CtnFcYembGs1tEbq+0?=
 =?us-ascii?Q?X2RD7eNG2dnMF2n1AXpj+4BEMlwxXZ/V3JTkdSPbgVoVpzWsOxa+ldxT/6XG?=
 =?us-ascii?Q?rOwdQWCQ8jjQAEFCJJZBjunKRFcsXW/gk+5l6lsh4mOIagHCmDDxqRMvNgV6?=
 =?us-ascii?Q?PrSR6IcvdAiWXvQZmt/uOkd5JI8UqIltCNo3He92+LDZvkZiZIoQnyGDKuVy?=
 =?us-ascii?Q?P3EbIKb33p41+kpc3+5r+kdQf2s1arT8Kl1GcvRT6xE2ft81Backd8gsg3OU?=
 =?us-ascii?Q?aLfKdB9JO8pLW5aqIp9Fu8u0H7AgZ1DfAGEOT/fHBb2EFuo2wGjQ7a0kBvEp?=
 =?us-ascii?Q?OpGcQNAr9T6jrPol+fVvEpeCrp41EQSh7QU82A6tCamg9kaTiUwOge3tBf6P?=
 =?us-ascii?Q?dvxO3biT45E1Enkv6nJ9efjm1p3qEE/zPFIWJfhC1MnJJ8NAsJ6ga2XHFJBy?=
 =?us-ascii?Q?1FXw87YKavc6Jtt60D4XisZubcgOlg1fB6fsccTNM8jAvwGGq7fy62K41RQV?=
 =?us-ascii?Q?DuRj4R7RovFEDP894oWkx0iSEOeLNpgHjAxgAIgQNCRu/WKUY/qZrW/Vp7QH?=
 =?us-ascii?Q?oYLIKTJ10f4O6XaxhVUsx0b3JPJ3fThPtgd1Z9OvAne0J1xm2/+UyCLKhWAy?=
 =?us-ascii?Q?zSH32oq7ddfL3xvagZmUcFqYtD1fK4Ln+7sa1zGk1QpmZq6NzcDA7fhRWt2Y?=
 =?us-ascii?Q?8TIQrTrHywUbJLv8UOYAI/eFxBLjnhHyK84CI6sZceVZTbc7btFw3cDsSkC2?=
 =?us-ascii?Q?Iyb/sdSb8IZdLvTRWtJKeqemSbyU1bfRBDfm+T0JHXw1MoOygoSOGup2Yiju?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b28d38-3324-48d7-5b84-08dc4311705f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 03:55:35.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZlsfKYGt3ia5GpO2V7JzJHFT39Vk5xcMSduUNbucAcz6wWuw6ozLlip8uYMHFHpsTeNXWL2D2Rvh3NSxcUV8v3yZjfL1w7+dh1BMcIxKvTIebMs/hXohlax861tHfwU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Wednesday, March 6, 2024 8:20 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; Eric Dumazet <edumazet=
@google.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Brady, Alan <=
alan.brady@intel.com>; horms@kernel.org; Jakub Kicinski <kuba@kernel.org>; =
Paolo Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/2] net: intel: implement =
modern PM ops declarations
>
> Switch the Intel networking drivers to use the new power management ops d=
eclaration formats and macros, which allows us to drop __maybe_unused, as w=
ell as a bunch of ifdef checking CONFIG_PM.
>
> This is safe to do because the compiler drops the unused functions, verif=
ied by checking for any of the power management function symbols being pres=
ent in System.map for a build without CONFIG_PM.
>
> If a driver has runtime PM, define the ops with pm_ptr(), and if the driv=
er has Simple PM, use pm_sleep_ptr(), as well as the new versions of the ma=
cros for declaring the members of the pm_ops structs.
>
> Checked with network-enabled allnoconfig, allyesconfig, allmodconfig on x=
64_64.
>
> Reviewed-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: added ice driver changes to series
> v1: original net-next posting
>     all changes except for ice were reviewed by Simon Horman
>     no other changes besides to ice
> ---
>  drivers/net/ethernet/intel/e100.c             |  8 +++---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 14 +++++-----
>  drivers/net/ethernet/intel/e1000e/netdev.c    | 22 +++++++---------
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 10 +++----
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 10 +++----
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +++---
>  drivers/net/ethernet/intel/ice/ice_main.c     | 12 +++------
>  drivers/net/ethernet/intel/igb/igb_main.c     | 26 +++++++------------
>  drivers/net/ethernet/intel/igbvf/netdev.c     |  6 ++---
>  drivers/net/ethernet/intel/igc/igc_main.c     | 24 ++++++-----------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  8 +++---  .../net/ether=
net/intel/ixgbevf/ixgbevf_main.c |  8 +++---
>  12 files changed, 64 insertions(+), 92 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


