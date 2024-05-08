Return-Path: <netdev+bounces-94506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006C8BFB6D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43972843C1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA681741;
	Wed,  8 May 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyk4vq/o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE288172A;
	Wed,  8 May 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165976; cv=fail; b=SsK4gKi1T5prKMCyXot+BPTJ2KrcX6K558xXXGVs1VAO6oRN88inlT6OmXG62G/JNDMP2lKNrXK1wGPs6MLi6dwiuZRcLdikIGCWFXHFH2iGhlb5js78clLblMXsi8iWCN84lkJbBlgwsfg4Svalt6NHMerYIzxSS8xIn67wKME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165976; c=relaxed/simple;
	bh=0c5CwIj8u8wiB+SCacM0VxLymM9gERmMPm9w/9X7zsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBy3yMytahX4RY5CIleWhq6D6emeFVpaDQV6ImP2XEEv9Ffs2M+8NEhq+bTkUnuh76QbJ9q3JHkAKvTKF8/T92YNjRVS5LQHZGhWMu0xy+gxM6zVqQstiy2pcMjJEJul2KrVT1VNiBUe7f61fyWcGXpgR1QKfheqSY8rUneNAPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyk4vq/o; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715165974; x=1746701974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0c5CwIj8u8wiB+SCacM0VxLymM9gERmMPm9w/9X7zsk=;
  b=cyk4vq/oJDDUe59EsaM9XxFd2/SHH/1TPHTz+qlgPfW0raMVL/rRkN5O
   Y9rZJ8/UVbkVVbOxi3LoSo7oVk2zY82Dc6d50rrOHmaJh6/xxnVn7tCaU
   GjI8Hu8FzyBOywjHDd4B+buhbQwi2ImL+DIn2/N5nWJvC3IZU3znrfsGj
   AGCetxtQ3Bl7+TS2KNS4LGmsHILLuBQ81SOPFjlBbtKzc1uR19lGEKoTj
   BfkSMu2bXUAuUdluDn8E4z/tCIVzb184Y2zKUAJQxYwwLCURJABKtKokp
   s/mXRK5ZoKPLu5EEOvjNAeBZi1o3wWxIeGI51o4jdrQZcIZCwJUFp3pkn
   Q==;
X-CSE-ConnectionGUID: BMiRaOsyTICcGUK4lWemhA==
X-CSE-MsgGUID: FZfVkK6OSLikVfPbj4DR4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14822492"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14822492"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 03:59:34 -0700
X-CSE-ConnectionGUID: 6cBnY4SOSWSedxR7ik63sA==
X-CSE-MsgGUID: ZA8LfoW9QoqjVG7K2XhXMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28904701"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 03:59:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 03:59:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 03:59:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 03:59:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhJhy+GDL5mxKIB+zelniKVfnGNUXlhBQRfmivCRKO8grBo9qY9LRuAYz1p/DJdroj/CmqnP+Fxp2TdAJ9LflC/nXbnVQ996pRm9fajqZc8PdLDsRUVn6V0l9uQOE6IGjyjqL4uPEnYl07xD7k6SfXwmdH4AG7+iCzPuJDxrSTmw3qiZa6VWncfsvRpt9d/hXJAJjbWKfDPTvdgOy121DrDz9DfC+35BtzsvB33TMFR9DEsxKRWmFMtjIAu7H97EFAA7sO7TCzGAV5/CvlkQozoQzGwHABGVEmfL+qTlXkB39ru8q2O2TYUFhH98zM51haWzBZmRt+WhHfs8YRHmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c5CwIj8u8wiB+SCacM0VxLymM9gERmMPm9w/9X7zsk=;
 b=dRqi7N3Y2oid6MjpOykJJUxHptQwk2GnjSx2i9NS1loGNWTZctj619Yu4iXjNATf5SO1Xfq7TphWyeK7Xc/rXV+NBI4XtBrZf5f560awoWzno5e3wvJQ7Bf+hINsfyaUnU8quAtBUmrFq3Ain6dn69eopIapmBtu5Z4IjJm96QYsrWRhbsrxbzDLByQ0p1T2J1Sa1w5MjmxGpdqZmCzqGrGfDbsr1QDBKtRxsNDRPTmGNnPSbOnIzJnbcZ6VRxEjGMriRcJ8SfhOvxTUT44KAKGipRMiLR5gBfVXfR+nhURxIjEB5rbtjsbuhGHMpWTVvStRlwbXNuQ6SOrdk8k1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 10:59:30 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%3]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 10:59:29 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	=?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] i40e: flower: validate control
 flags
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] i40e: flower: validate
 control flags
Thread-Index: AQHakA4H8oC9gTU1l0OioxlsondKuLGJzQLAgAA1+oCAAJnmgIACr6yA
Date: Wed, 8 May 2024 10:59:29 +0000
Message-ID: <PH0PR11MB501346BC00585D68F58485BB96E52@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240416144320.15300-1-ast@fiberby.net>
 <PH0PR11MB5013807F66C976477212B27C961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
 <7cf42f1b-d7e2-4957-bee9-e875c61d19e2@fiberby.net>
 <b63df398-f210-4ec6-8403-f447683e184f@intel.com>
In-Reply-To: <b63df398-f210-4ec6-8403-f447683e184f@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH7PR11MB7499:EE_
x-ms-office365-filtering-correlation-id: 991723a1-2135-47e3-bcc1-08dc6f4def4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MTBULzVUd1QxckEyS0t1SWdFMHo4Zi9kNUthd2pvNTVVcUpOTEhXWVl6emp1?=
 =?utf-8?B?U2JOQXI0SXdCYW1pRE9KSklVY2VMQUZYYjRaNWJFWlA2UWl3N1VKS3B6c1Ru?=
 =?utf-8?B?SmQrbldIL05oYkxpclBsb3FKTGUrdXMvbzhaY3ZNU0tiTjRZY0ZuTkYyL0Jj?=
 =?utf-8?B?WmNOS3ZqY3JOamw3QWVMbVF1SE8rR2lGQXRGbFROT2ZERjR0NDd2SmM1RXJr?=
 =?utf-8?B?b2dnTkdNekhlQ0VkRFRtRTBCTG1OU2VDTW5VaUdGaU9XdXNCMU5BNDY1SkNZ?=
 =?utf-8?B?cHA3d0ZKcWdKbHpSL3lxcHphZWhRcUVtcFhUQWpVaTlBZUNzQ0w3ZkVZT1gr?=
 =?utf-8?B?MFNnUGEvZ25RUjFEL0Z6cmdleFF2Q1l6RnoyQ2hVUVJCcTBCM2JLWk5zV0xo?=
 =?utf-8?B?bkRoZDJscnhiWkNocjJIRkZYN09kYk9kN0M3MzB0ZWo0czVCQUVpbnBrYW8v?=
 =?utf-8?B?Uzhnc05XSDdVU2wvenRSTGV5Wk8vdFB1dUY4WlVVdE1LaFBUMDUydTQxczBn?=
 =?utf-8?B?a1FOWXp1TUc3WnoyOThzZGpXbW84UlM1M1A4SThyR1VTcGZOS2E5akMwblRp?=
 =?utf-8?B?MDRFbURnTXVobzhrenF4SnlGR2NSS0NjWUVINHBmQzlaWkFLVXBhNG8ydlNk?=
 =?utf-8?B?STRzTGJiV3RWeU9WUWJ0STRrS0FUWllSVEFUd2lXUEVFZ3lJNXRlUHUyNDZr?=
 =?utf-8?B?MlQxWEJqNDNrTmhZdnNnSEFwc1daeXdvVmRJQ3lTNkZkdEdNekhRSlVPWmVq?=
 =?utf-8?B?bVVjUVEvV3lPeEVIeXh3NS9ZenA1K1FLb2l4bzVLR3FjWlJ1Vi8yZUR4RnVz?=
 =?utf-8?B?TVlXS3g1ZnRLd1FoZUpPVUFMNjJJR0pNS0NFcXRwQ3RoTXBFZkdiREkwZm9k?=
 =?utf-8?B?U0FTYUMzWFVENytBWVBvTGcvSUZHMzNWemFpSkRtKzNmMURJZmpLc2pGaU1k?=
 =?utf-8?B?WnVZZkh4YmtLbHFlU2RwUXd2QWY4Uko5QXdEeDZOanNFRlpoWjVtdzcyb2dy?=
 =?utf-8?B?UmNFRFh5bGxsRVFva2dnZ3UzYmNIK29IT1JKTnRxUUxpTnU2M3FVSHZnZnhI?=
 =?utf-8?B?YzVnNnZqYUFRcnpIbHlBQXdSUjRXOUZSLzNLcGROK0dscXhUV252REpXdmJ3?=
 =?utf-8?B?MCtlYWgxaEVqR01scnlHMG12eWlFQ0ZtdDNNa3pialNaTnlBQ20yMlhYdmNm?=
 =?utf-8?B?TUFHRlBYdFRucFZGQUJjcnVjQVdRUEwxWmYrY04rTm5UWjM2NFF0Z3l1L0ti?=
 =?utf-8?B?bzVWQ0FoM1kxOVJTbW5za1BCN3Uzb1pXbFV5M0RPSGxBS3Q5TUg2eXEvTlBt?=
 =?utf-8?B?L2pOMnhIRjI2ekk2Y1RmK0VzTjBLZ2RKaWhobjkxRGtsMmdUUnpsOVdoaHEz?=
 =?utf-8?B?aG5RZTRUWUU4TDNaUnc5eW1hRWxiQUtDYmpIaDV5dnlGbXRpNjNmT2FFRmMr?=
 =?utf-8?B?TzBNYjFsMXV4UHlHSFJENkRKQlhDQUtNUCtrWXlqTXhhOEw2ekN1MUpTeHM5?=
 =?utf-8?B?a2Rnczg4cW4wSGN1dGMvSFZ6V1VZcXNFMzErandjRFI0MjlQTnBuenV5NHJr?=
 =?utf-8?B?YTczRU1QVkVLZFFwMG9vZmFxc09ub0psb0UvVkdtUytWZGlPV0p0LzRLVk5H?=
 =?utf-8?B?MTlqa2hTTGVsMHk3UTJhVVEzeVlXYTRjemhwOEViV05JeWFwb1M0ekRhQzYv?=
 =?utf-8?B?YkRWakRuSGY5OERaRnk4Mmlic3BVekE5eEYxeENWSm95L3JoZ1E2L1hRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkdBNElOaEVzeVhmRC9QZ09YYm52SHFITmhpRGxUMmg1T0RoR05BTXUxOVFq?=
 =?utf-8?B?eHJ3b1dxZUIvSWJtTGVVMUxsMlpVSFR1d3ozckkwSVZiR3IweHBqZUdGaHFD?=
 =?utf-8?B?ckE0SlJ0MzN5NTR5TVY3WSs1QThJR1RJT04zL0x5KzJnaVl3aDV2UGUwN3Z0?=
 =?utf-8?B?OW5jRDlGZGNKTmxZQlJ3Unoxc1orVERMQWxVcndESEMrU1B2Q29XVDRXQytR?=
 =?utf-8?B?UG8vbHpkTmR0WXV3U0FMS1JzYVdxQml6eDhSUlBLaXR0NitNWGNrUVMzdjFQ?=
 =?utf-8?B?RzY4eklNSXNGY0kvaWoyNVRRT205eXMxT0ZHNFVRL0VLQ2FuaHpxRW1yNW9p?=
 =?utf-8?B?aERqd01sUEk4bDdDcXYyMnFFVmd5RWpHUzJkZmxpWGx1V3RXK2wxMVYraS9R?=
 =?utf-8?B?UHVNOG5sUXdVSmtMdGZHNHZ0c25MVXJMWDJWdGhuWXVGcVRhZzNhdGhFS3p4?=
 =?utf-8?B?R2tIYVM1d0s1NWx5UkdoVDg5czRHVVJHQzdOZEc1T1JBSlBqMDRHREZUZTJM?=
 =?utf-8?B?Wm42SGJiNU1aYkUvdnJOWEhJTHRkbDRKUVJEKzdEUHg0bFkrZG9rNzNYeXB3?=
 =?utf-8?B?SDBrS0lrZnVlQXFEUUg2Tnk2N3NXYmlKNVFBQkVRWnQrditYbkZtSzVadkV1?=
 =?utf-8?B?bkJLOGNVRWVUa3BUaUxIL0VFN2NydUtmQldGeTRIcVpzejV3anVMdVByUU93?=
 =?utf-8?B?SStQcGdBQVVtdGpvc094MzVrUmtPR094K0gySVhBVzRwZi9yanB4S1NHczhB?=
 =?utf-8?B?UW9GV1lCMTY3NHFCMWk3MVdXTVlhRW42Ky9hQ0hxb3dSMTRZVWpuU1FoYm92?=
 =?utf-8?B?QWtCcUFpeHo5WVR1WkVkdE9GQ0xjVWxvNCsyaG5kUGJCV3ExWFJMeHQ5WWYw?=
 =?utf-8?B?OW1tcWlNakRiM3NUL2hnbzd3UDFMK2pWVktTbThaNXlMUmxrQThvT2pjMHJL?=
 =?utf-8?B?QSs2N1d3Y0Y1c3M5OHUzaWlpT295WEI2cGIzMnpFdW9OaEs5WmpLSmJKc1hU?=
 =?utf-8?B?WDNHV29jV3YrMHA1N0lucCtVcTlrNmpOWFNoenA0U2QzbzdJeUpTeWdXVlBl?=
 =?utf-8?B?a1FvNDY5NTR6aVdyNHhWUkU1eXFhTHJPTXpzV0hkdHNCYS8zakNnZ2cwa2ly?=
 =?utf-8?B?WHphZk55Wm5makNiZFRwUmhYU0c4YUZWZ1hYZ0w2QlZsMzYraS9nSEc2S1FY?=
 =?utf-8?B?eEdWVGtDTWhid3phR2NrT1B1VDRtNkVzMGppd2ZiUU1RNHYyV29IZmpwQTJs?=
 =?utf-8?B?UzhIU3NDVVR4NXZ0aHZ0NDdHL1d6RlgrNE91VmtraE5ma21XQnlYNXRodkFZ?=
 =?utf-8?B?SU0wSGp3cDJ5VW9VK0F6eG1pYktHN05JeHY2YklwOFhsSm5kSE1US2Z2NVE0?=
 =?utf-8?B?dWxVblU3czdxWE1KTXorbGRlTUhRaTFUVnlKclVHRlhQemN0a3dXNTlERWhk?=
 =?utf-8?B?TVJSanl6UzEveGlHcGNrbmtZb0JHWlMrM3ZnREp2SkJlVGhBQXdjV01CUnlt?=
 =?utf-8?B?UG8vNXdia0l6T1plTTdYSWYvS2lLdXJCbXhoT1NwUlRMVW4yWW5rT0RITFdT?=
 =?utf-8?B?Slk3bWk3WGFZeW8valVvYzkzdGlDMEdOc0RweTZGZ1UxL20xNVJoNnpKd2hh?=
 =?utf-8?B?SDFXUDVITEpWcTd0TkNPMG5LbkRha3A3VmQzNTNDa01PMFNBYmV2b3ZzY1lG?=
 =?utf-8?B?ZFl1NllnU2lwRlN4N3FLVXF1emcramNBaE9CbWQ1aG5mZWN6dmh1UXlNdHJv?=
 =?utf-8?B?ZXFGdnNvK2lYNHRzREFnOXdxNHh0QUNtV1hTUEphcllQakZ6WUNDSEFMMlll?=
 =?utf-8?B?RUxkYmVYN0orWmMvZmZqSWxVNzRFZGVPUXNwWFlBS1krYjhIRlAxdG1VZVEz?=
 =?utf-8?B?L3RoUHJoOE9yRUJKODB6Nm8wcWgwWGhjc3N1N0xmR2xDZkhiWjAxcXN0eXVj?=
 =?utf-8?B?ZTE3OXppNERyZHJhelh3RitlTUdSaDh2bFVQVlBCVFRmb28yZ2M1YmdwRHA4?=
 =?utf-8?B?RlNDUWFUZitCbnl4czZINTB4MUNXQkVEQitsa3F3M210ZjZKdjNBaG9KaUNK?=
 =?utf-8?B?TVl0Ym5Nbk5nQ1VmbTRpOEJOZnZGd3h6ZDNMRlVHbHVpNCtDcGdCekplMGFx?=
 =?utf-8?B?VFZGdGlIUFYrMlZlUUNlY3RTQkE0clpnVERYaE5UejVGdFVBRW15ZGg2dDhK?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991723a1-2135-47e3-bcc1-08dc6f4def4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 10:59:29.7103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKgtl042Sh80j7+sOI1LBKMIyC2gnfH9xr7eoZG+m2NCcyTFVdrq18oGvTC72T6Navsl2qN683XqCAR57eTE40VQ1MHip7oWHvMf93G2WFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7499
X-OriginatorOrg: intel.com

SGksDQoNCkknbSBhYmxlIHRvIHRlc3QgdGhpcyBwYXRjaCBvbiBpNDBlIGludGVyZmFjZSBmcm9t
IEFEUSBwZXJzcGVjdGl2ZS4gR2V0dGluZyAnTm90IHN1cHBvcnRlZCcgbWVzc2FnZSB3aGVuIHRy
aWVkIHRvIGNvbmZpZ3VyZSB0YyBydWxlIHdpdGggY29udHJvbCBmbGFncy4NCg0KW3Jvb3RAQlAt
bm9kZTMtQklORFUgfl0jIHJtbW9kIGk0MGUNCnJtbW9kOiBFUlJPUjogTW9kdWxlIGk0MGUgaXMg
aW4gdXNlIGJ5OiBpcmRtYQ0KW3Jvb3RAQlAtbm9kZTMtQklORFUgfl0jICBtb2Rwcm9iZSBpNDBl
DQpbcm9vdEBCUC1ub2RlMy1CSU5EVSB+XSMgIGV0aHRvb2wgLUsgZW5zODAxZjBucDAgbnR1cGxl
IG9mZg0KW3Jvb3RAQlAtbm9kZTMtQklORFUgfl0jICBldGh0b29sIC1LIGVuczgwMWYwbnAwIGh3
LXRjLW9mZmxvYWQgb24NCltyb290QEJQLW5vZGUzLUJJTkRVIH5dIyAgdGMgcWRpc2MgYWRkIGRl
diBlbnM4MDFmMG5wMCBpbmdyZXNzDQpbcm9vdEBCUC1ub2RlMy1CSU5EVSB+XSMgIHRjIHFkaXNj
IGFkZCBkZXYgZW5zODAxZjBucDAgcm9vdCBtcXByaW8gbnVtX3RjIDIgbWFwIDAgMSBxdWV1ZXMg
MkAwIDhAMiBodyAxIG1vZGUgY2hhbm5lbA0KW3Jvb3RAQlAtbm9kZTMtQklORFUgfl0jIHRjIGZp
bHRlciBhZGQgZGV2IGVuczgwMWYwbnAwIHByb3RvY29sIGlwIHBhcmVudCBmZmZmOiBwcmlvIDEg
Zmxvd2VyIGRzdF9pcCAxOTIuMTY4LjEuMTAgaXBfcHJvdG8gdGNwIGRzdF9wb3J0IDEyMDAwIGlw
X2ZsYWdzIGZyYWcgc2tpcF9zdyBod190YyAxDQpSVE5FVExJTksgYW5zd2VyczogT3BlcmF0aW9u
IG5vdCBzdXBwb3J0ZWQNCldlIGhhdmUgYW4gZXJyb3IgdGFsa2luZyB0byB0aGUga2VybmVsDQpb
cm9vdEBCUC1ub2RlMy1CSU5EVSB+XSMgdGMgZmlsdGVyIGFkZCBkZXYgZW5zODAxZjBucDAgcHJv
dG9jb2wgaXAgcGFyZW50IGZmZmY6IHByaW8gMSBmbG93ZXIgZHN0X2lwIDE5Mi4xNjguMS4xMCBp
cF9wcm90byB0Y3AgZHN0X3BvcnQgMTIwMDAgaXBfZmxhZ3MgZnJhZy9maXJzdGZyYWcgIHNraXBf
c3cgaHdfdGMgMQ0KUlRORVRMSU5LIGFuc3dlcnM6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkDQpX
ZSBoYXZlIGFuIGVycm9yIHRhbGtpbmcgdG8gdGhlIGtlcm5lbA0KW3Jvb3RAQlAtbm9kZTMtQklO
RFUgfl0jIHRjIGZpbHRlciBhZGQgZGV2IGVuczgwMWYwbnAwIHByb3RvY29sIGlwIHBhcmVudCBm
ZmZmOiBwcmlvIDEgZmxvd2VyIGRzdF9pcCAxOTIuMTY4LjEuMTAgaXBfcHJvdG8gdGNwIGRzdF9w
b3J0IDEyMDAwIHNraXBfc3cgaHdfdGMgMQ0KW3Jvb3RAQlAtbm9kZTMtQklORFUgfl0jIHRjIGZp
bHRlciBzaG93IGRldiBlbnM4MDFmMG5wMCByb290DQpmaWx0ZXIgcGFyZW50IGZmZmY6IHByb3Rv
Y29sIGlwIHByZWYgMSBmbG93ZXIgY2hhaW4gMCANCmZpbHRlciBwYXJlbnQgZmZmZjogcHJvdG9j
b2wgaXAgcHJlZiAxIGZsb3dlciBjaGFpbiAwIGhhbmRsZSAweDEgaHdfdGMgMSANCiAgZXRoX3R5
cGUgaXB2NA0KICBpcF9wcm90byB0Y3ANCiAgZHN0X2lwIDE5Mi4xNjguMS4xMA0KICBkc3RfcG9y
dCAxMjAwMA0KICBza2lwX3N3DQogIGluX2h3IGluX2h3X2NvdW50IDENCltyb290QEJQLW5vZGUz
LUJJTkRVIH5dIyB0YyBmaWx0ZXIgYWRkIGRldiBlbnM4MDFmMG5wMCBwcm90b2NvbCBpcCBwYXJl
bnQgZmZmZjogcHJpbyAxIGZsb3dlciBkc3RfaXAgMTkyLjE2OC4xLjEwIGlwX3Byb3RvIHRjcCBk
c3RfcG9ydCAxMjAwMCBpcF9mbGFncyBmcmFnL2ZpcnN0ZnJhZyBod190YyAxDQpbcm9vdEBCUC1u
b2RlMy1CSU5EVSB+XSMgdGMgZmlsdGVyIHNob3cgZGV2IGVuczgwMWYwbnAwIHJvb3QNCmZpbHRl
ciBwYXJlbnQgZmZmZjogcHJvdG9jb2wgaXAgcHJlZiAxIGZsb3dlciBjaGFpbiAwIA0KZmlsdGVy
IHBhcmVudCBmZmZmOiBwcm90b2NvbCBpcCBwcmVmIDEgZmxvd2VyIGNoYWluIDAgaGFuZGxlIDB4
MSBod190YyAxIA0KICBldGhfdHlwZSBpcHY0DQogIGlwX3Byb3RvIHRjcA0KICBkc3RfaXAgMTky
LjE2OC4xLjEwDQogIGRzdF9wb3J0IDEyMDAwDQogIHNraXBfc3cNCiAgaW5faHcgaW5faHdfY291
bnQgMQ0KZmlsdGVyIHBhcmVudCBmZmZmOiBwcm90b2NvbCBpcCBwcmVmIDEgZmxvd2VyIGNoYWlu
IDAgaGFuZGxlIDB4MiBod190YyAxIA0KICBldGhfdHlwZSBpcHY0DQogIGlwX3Byb3RvIHRjcA0K
ICBkc3RfaXAgMTkyLjE2OC4xLjEwDQogIGRzdF9wb3J0IDEyMDAwDQogIGlwX2ZsYWdzIGZyYWcv
Zmlyc3RmcmFnDQogIG5vdF9pbl9odw0KDQpSZWdhcmRzLA0KU3VqYWkgQg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNhbXVkcmFsYSwgU3JpZGhhciA8c3JpZGhhci5z
YW11ZHJhbGFAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIE1heSA2LCAyMDI0IDExOjI1IFBN
DQo+IFRvOiBBc2Jqw7hybiBTbG90aCBUw7hubmVzZW4gPGFzdEBmaWJlcmJ5Lm5ldD47IEJ1dmFu
ZXN3YXJhbiwgU3VqYWkNCj4gPHN1amFpLmJ1dmFuZXN3YXJhbkBpbnRlbC5jb20+DQo+IENjOiBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBFcmlj
IER1bWF6ZXQNCj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwu
b3JnPjsgUGFvbG8NCj4gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgRGF2aWQgUy4gTWlsbGVy
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dF0gaTQw
ZTogZmxvd2VyOiB2YWxpZGF0ZSBjb250cm9sDQo+IGZsYWdzDQo+IA0KPiANCj4gDQo+IE9uIDUv
Ni8yMDI0IDE6NDQgQU0sIEFzYmrDuHJuIFNsb3RoIFTDuG5uZXNlbiB3cm90ZToNCj4gPiBIaSBT
dWphaSwNCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3IgdGVzdGluZy4NCj4gPg0KPiA+IE9uIDUvNi8y
NCA1OjMyIEFNLCBCdXZhbmVzd2FyYW4sIFN1amFpIHdyb3RlOg0KPiA+PiBIVyBvZmZsb2FkIGlz
IG5vdCBzdXBwb3J0ZWQgb24gdGhlIGk0MGUgaW50ZXJmYWNlLiBUaGlzIHBhdGNoIGNhbm5vdA0K
PiA+PiBiZSB0ZXN0ZWQgb24gaTQwZSBpbnRlcmZhY2UuDQo+ID4NCj4gPiBUbyBtZSBpdCBsb29r
cyBsaWtlIGl0J3Mgc3VwcG9ydGVkIChvdGhlcndpc2UgdGhlcmUgaXMgYSBsb3Qgb2YgZGVhZA0K
PiA+IGZsb3dlciBjb2RlIGluIGk0MGVfbWFpbi5jKSwgYWx0aG91Z2ggaXQncyBhIGJpdCBsaW1p
dGVkIGluDQo+ID4gZnVuY3Rpb25hbGl0eSwgYW5kIGlzIGNhbGxlZCAiY2xvdWQgZmlsdGVycyIu
DQo+ID4NCj4gPiBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzIGk0MGVfbmV0ZGV2
X29wcyA9IHsNCj4gPiAgwqDCoMKgwqBbLi4uXQ0KPiA+ICDCoMKgwqDCoC5uZG9fc2V0dXBfdGPC
oMKgwqDCoMKgwqDCoMKgwqDCoCA9IF9faTQwZV9zZXR1cF90YywNCj4gPiAgwqDCoMKgwqBbLi4u
XQ0KPiA+IH07DQo+ID4NCj4gPiBUaGVyZSBpcyBhIHBhdGggZnJvbSBfX2k0MGVfc2V0dXBfdGMo
KSB0byBpNDBlX3BhcnNlX2Nsc19mbG93ZXIoKSwgc28NCj4gPiBpdCBzaG91bGQgYmUgcG9zc2li
bGUgdG8gdGVzdCB0aGlzIHBhdGNoLg0KPiA+DQo+ID4gTW9zdCBvZiB0aGUgZ2F0ZWtlZXBpbmcg
aXMgaW4gaTQwZV9jb25maWd1cmVfY2xzZmxvd2VyKCkuDQo+ID4NCj4gPiBJIHRoaW5rIHlvdSBz
aG91bGQgYmUgYWJsZSB0byBnZXQgcGFzdCB0aGUgZ2F0ZWtlZXBpbmcgd2l0aCB0aGlzOg0KPiA+
DQo+ID4gZXRodG9vbCAtSyAkaWZhY2UgbnR1cGxlIG9mZg0KPiA+IGV0aHRvb2wgLUsgJGlmYWNl
IGh3LXRjLW9mZmxvYWQgb24NCj4gPiB0YyBxZGlzYyBhZGQgZGV2ICRpZmFjZSBpbmdyZXNzDQo+
IA0KPiBPbmUgc3RlcCBpcyBtaXNzaW5nIGJlZm9yZSBhZGRpbmcgdGhlIGZpbHRlci4NCj4gSW4g
b3JkZXIgdG8gdXNlIGh3X3RjIGFjdGlvbiwgcXVldWUgZ3JvdXBzIG5lZWQgdG8gYmUgY3JlYXRl
ZCBhbmQgY2FuIGJlDQo+IGRvbmUgdXNpbmcNCj4gDQo+IHRjIHFkaXNjIGFkZCBkZXYgJGlmYWNl
IHJvb3QgbXFwcmlvIG51bV90YyAyIG1hcCAwIDEgcXVldWVzIDJAMCA4QDIgaHcgMQ0KPiBtb2Rl
IGNoYW5uZWwNCj4gDQo+ID4gdGMgZmlsdGVyIGFkZCBkZXYgJGlmYWNlIHByb3RvY29sIGlwIHBh
cmVudCBmZmZmOiBwcmlvIDEgZmxvd2VyDQo+ID4gZHN0X21hYw0KPiA+IDNjOmZkOmZlOmEwOmQ2
OjcwIGlwX2ZsYWdzIGZyYWcgc2tpcF9zdyBod190YyAxDQo+ID4NCj4gPiBUaGUgYWJvdmUgZmls
dGVyIGlzIGJhc2VkIG9uIHRoZSBmaXJzdCBleGFtcGxlIGluOg0KPiA+ICDCoCBbamtpcnNoZXIv
bmV4dC1xdWV1ZSBQQVRDSCB2NSA2LzZdIGk0MGU6IEVuYWJsZSBjbG91ZCBmaWx0ZXJzIHZpYQ0K
PiA+IHRjLWZsb3dlcg0KPiA+DQo+ID4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2
LzE1MDkwOTY5NjEyNi40ODM3Ny43OTQ2NzYwODg4Mzg3MjE2MDUucw0KPiA+IHRnaXRAYW5hbWRl
di5qZi5pbnRlbC5jb20vDQo+ID4NCg==

