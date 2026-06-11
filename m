Return-Path: <netdev+bounces-298032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GnwBFP6BKmqNrQMAu9opvQ
	(envelope-from <netdev+bounces-298032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:38:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F132867076C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:38:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="V/cgdWdE";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298032-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298032-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA978301B26B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164FB3BE144;
	Thu, 11 Jun 2026 09:37:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C33BE165
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:37:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170667; cv=fail; b=uv44Pi62aKjg3SxHGRHKFBLtC/yEUjCtfieWWhM6PduT324kEqhSWmtusZ2NW2hq5WxcD88N0NcNdddXUogU2ag4aPmGcXSrvNzVx7PAyDgpP1jAjeRKhFOcDbu+BfPLXqwiCfuxVL3w35aNBhJv8IsAfpn0Luw9UZls3gUlj2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170667; c=relaxed/simple;
	bh=DEcI/DI0my631MrFZAWLSdecMx403af7F1pelXnCP7c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QMo3XxZJjBdIssdSLHtqkRsh/lPh8ux3M18CPGuaCa7m4OMoQdjR5xdjsHshLuNo6h9chdJKu/bCwNN+TlS9a3zZHhsrQcHYg71NZemb0wWZE+PbDMLJ4QMpgmB7BgHkbZFCnTlWLTPPTG4S+2k6/FNltyutsmaXLnVUbahMhbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/cgdWdE; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781170665; x=1812706665;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=DEcI/DI0my631MrFZAWLSdecMx403af7F1pelXnCP7c=;
  b=V/cgdWdEcluc+B4pO0c5kOOd1wxHwaajl1fehaALllTjK95K0zHkXtme
   K0FJYfeSpnoXlpM6iHMoTPWpZ90i5EjWUTjeGb+qndCZnJJvCQDPxxbpI
   l1IDMKChu1P6CAVcz23clPZI1/PNOEO5tEGxcq1Bdnw4RnNIOULU1gNYw
   n5ElCFS0U0T/DYs8/y6VpBbeYwpclNcNVqNzNTi8TC/zbOuEDK7THADU+
   epMpx1KAjyVrjSMxq74RhTDV15ShTc+niLoI6CHnqX1IzY8hLxehcaOa6
   1Mp5iIdc/tiCfMOweqXcXPdv91REU2vXgi0cI1n4ddAEUW6NmYk+fnnBy
   g==;
X-CSE-ConnectionGUID: G2sgtQIfTR2aRWA9QO+E/g==
X-CSE-MsgGUID: hl5UkxmmTumaIr9MXTtT+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85877101"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85877101"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:37:45 -0700
X-CSE-ConnectionGUID: qqU4QIMyRYmSUuaABJYJWQ==
X-CSE-MsgGUID: rBAQpOHST7qZYcVS9gg6UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246510274"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:37:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 02:37:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 02:37:44 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 02:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCVA//mPzi7YtEYtpBnZVHYfpaJfib5i4c/+f5KQmZ7FlKy841W6qpflrRwZiZX8CEFX0iuSWyezepTH4qASj5DSb6/vPGX2OpEBEYHr6imp6ntvwTQ5YWBjoe+oY27qjG7VnO7SZ9l2CbgI2XGrBeV+QK5Zjbk4SupP3rceIOeIsMtlJrBUY9qLVMv37q0GR6gh9/aK14LQZ1+Tl/6OdbQgOZSGI7Yg9ZrZvlh44kGGm0rdgvSMdWWWttgWDsvJaBWwkh4m27ezs39WCvx37KGoo7NZCIYYQ9MU/gH59c5PVMCm2tFnUh/s5mZo/+hlOr9rV5yK1Q8TWatH2aMpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86paQpMkJduTOl4+iS07x2QbordQl2F8fOy4vrD+fR4=;
 b=kPHJQT908XMA/b4jZZS9bLC9R4fO6qC4qCFXaN2gqJzGL+x1pK83m2NER6n6hp3tEW/uQJ3PYpyKRvInxMu1RllpG0Oz2TlVED+hlbOsMAROl814MFxo7yVcC46ScBlNtI5FzEhxM5zLef8cfsr09hYL/905AlhGXHFQKLf/5CbMNfSwauXzKLj6FwxBAWzXso0hu6yBk8CeGg5wNUra2D7Rw3MXW332nNQJDhIXwVQbqGHadU+0S4LnmSoZ4De2fs1sE1vM/7vYSHEJzxy9uRwx7Z8cIOTJNzAC8z6HsetaJ3p+8bxAXKpX53reVv1XoDd0fiDwBdm2nWFfpzs17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 09:37:40 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%2]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 09:37:40 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>
CC: "D H, Siddaraju" <siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>
Subject: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQ==
Date: Thu, 11 Jun 2026 09:37:40 +0000
Message-ID: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|MW4PR11MB7102:EE_
x-ms-office365-filtering-correlation-id: 719d3f0c-5dfb-46d3-5a83-08dec79d14d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|11063799006|56012099006|38070700021|18002099003;
x-microsoft-antispam-message-info: hNUeVw57fRCaosUaAQv4aX8M7DFVOfH+yHk1bzhIvgnwHtq2ctm1Iujvhoijdf9ijt0Fo3wLPpg7GmHc11qp7USXjUqSHW7BUwlrnynK1kaKBODJi63DqW8/0dzkg/hKNr4K7MCKjWpq4ArGCxhqJadgQtJuPOme0eVw7JmE4gLASGEuCAVkmiTogN/iI57KMpck2NBLMTwLAJBZ3jOi3HCi0ycaMeMcrRYThHLrqrTb0rV1tDJe2tZHsIr3DTdyn/lXwwRhZT0NgIUOlBaQZSLjxiMr9G9zJPevcHHY26bEEnTQ66QWlJiiQpMfCcVcgwItJtq8+61RihpHGcOI6qyeVvHbtuurYdFyoh+aSkFh2a+jfWB1oV0iDwlykbaCWJelLkQ5HoAbBDFKjDmdHtyc4X3HAuQOwDXwgJ2A+JRV5rMxOGI4W7u/WWuruH4iN8GOamYddgXq4LJvtaHBHybNbcvO76fVidNs8GlQwNhPUxBXGBoVZk+OntOnVawzmMaBFToIwA2BpJmqigWOJ/OFkoWVNLKPKtSwQOZV1Tyy/J1IkPSFSgTcoAwN5iTjpmBanptlh1jrfozYDwPJwaH+f6y3AdU2dL0hgMR0cQ+Mm1SqsAtImLvSog/ola0GSNposG4QwOr24m9tom3+HkL54lQQZlPtsLLVUKieiwpHrJ6EMZY0UgUP1sCT4B7XwAdZapc4fKzo9gDYKEpiGAcNOm1wfDjrT8hxR2i41XbtQDkXB197Fi2fIyrEs6jP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VTdlYmV6OHZGMlhEd1BoakFKaUNHVVU0dDhjTVg1UXBRTlBvSFdMVDBi?=
 =?iso-2022-jp?B?bkxQZlo3cC9FK0NDc3FYTEpJSmhrY0EzeXlzUVBad1BhUGd4blkxVmNZ?=
 =?iso-2022-jp?B?QXFFY0toMU02RmxTS3B5cVJJRHBMcjd1dzlqUmtMS2U3akthTGJlcGhX?=
 =?iso-2022-jp?B?Z0Z0WUlTdjhRME1CTjVkc1pZNFk5UjIwUHoycSszQkJITG04NXNETVo4?=
 =?iso-2022-jp?B?dWdmWmhuVTdBcFo3QWVicnBiVTFkVzNGYmt1UVVjdkRCUm0vNUR3VW5C?=
 =?iso-2022-jp?B?emNqUVZJM1YvVWt2SUQzbTNEZTRzeWxVOVAwSlVQWDRMaE9iRjdWZ01u?=
 =?iso-2022-jp?B?dHZ2WkZsc0F4UU5MemhiRndqRnRnTmRVN2lRMUVaZVRERWxTVnFTMDRn?=
 =?iso-2022-jp?B?anlPdmNKVStTcEVOWWJNY0orYjVET2VDSmozT3FuZS9DeUtHOXRvMHZi?=
 =?iso-2022-jp?B?dGcxb0N0K1RVa25yNmJUSGxhR012cGlLZzV5N0hKZVNkL1huTHNvN05a?=
 =?iso-2022-jp?B?TGV4bUwwZVNOT1ZlMStraitqbjZPNHRua3pERmxadTJUdzAvUVF5VEU0?=
 =?iso-2022-jp?B?NHBFRTlNWUMxQlBKR25IYkxaUkdNNWZPVnByS1B0MVlyenk3UlgvblRr?=
 =?iso-2022-jp?B?eXNMUDBCL0V4dnBNOVQzZjBLTmFCTEZGcFVJMndraVlZT1dZNlkwb1Vq?=
 =?iso-2022-jp?B?UkJ5cFBLN0UzSUxsS0lZTkFmNy9xWlY4emxCMmxEb1c4RjNzTldGcUI4?=
 =?iso-2022-jp?B?clNMRS91anV6cWdCdHNJVEZnTXh5cVBBb1hEQlhkbE9XTzNzd1pkcTBU?=
 =?iso-2022-jp?B?ZXJwa0VxVHMvQ1FzS3lCc2Z4T2tna2NwN05DdmNpMUtOQVgwWHpzN1E0?=
 =?iso-2022-jp?B?b0dPbzhwaDlCMzZJd2VKU0pOcjJDMWc5MzZnTW44Tm9LVmh2T0FBZllW?=
 =?iso-2022-jp?B?WTJULzlBdTZsZU5namdTb1c1OVNnYi85cUxIRU96N1ZDWmlMeTIxdDFQ?=
 =?iso-2022-jp?B?dDhzT1cyQVgvT1F1Zm9aMXFnd1djeGpYcERDRGdPVEoxWnZWNTlxVVNz?=
 =?iso-2022-jp?B?THhjbGFYeUpUY2R0Zzd5MHJvY3NUKzFMdU1CaXltd3BFQmthVGpPNVBI?=
 =?iso-2022-jp?B?TE95TXFrc2QyQUZoYVo4a2pxaFB4b3FoU20ydVpRT3laa0owMFhIeDkr?=
 =?iso-2022-jp?B?dWlpY0EvK3NZUWE4OGROWEROZUVNV09RbTgzazVib3lQcWdaWXVOaVpM?=
 =?iso-2022-jp?B?SHZyODlkWUswS1V3NTVyZnNpOEg4Qm51RGJSMjlqQkI5TS9EYS96U2kv?=
 =?iso-2022-jp?B?amhoT09oUVVhYnVFbVJTb1Jsc1VYYUhqTzJHN3BLS25ZTlJ1L3JvcDhs?=
 =?iso-2022-jp?B?MHdFVU1lYlRSSktkV2ZiSFNpZlcxbFVNQ0p6NGNYK3V0SWwyVnBGcjZG?=
 =?iso-2022-jp?B?QjBCa3JnUFBSRWtvUCtvY2FBNDZKRzdmK0ljZy91NzNXYldNU0RHWWl1?=
 =?iso-2022-jp?B?eWdZbkRGRTcxQmpwVVRQNEU3ayttZ3grT0hCaldGbnN1STd6YnhnZnFa?=
 =?iso-2022-jp?B?emVNWDk4VWNLNkIxaG44Y0NCbmFQdVFma3dBVDhvdTF3bU5sY0hueHVi?=
 =?iso-2022-jp?B?b1dod1p3eVB5K2NCTDZnSWo5dmlGdXdOcEdQZ2VJOUk0K3ZwN3NmMUda?=
 =?iso-2022-jp?B?bUtuMVoxUHNHRTVJUUJlVG1LSXIrRU93MUxBRDVEaEQrNVdhQlNXMVhV?=
 =?iso-2022-jp?B?aUd6T3IrR09ZUW1Vc0ZvZ2E4ZVFZRlVaMVdFdkZYaWQ4alU3akkxZEN0?=
 =?iso-2022-jp?B?KzlBUVJpMnVFZmJGSGk2WmpUUlZZM2pQVVNLc0s3S241Rk9yNG9Ha241?=
 =?iso-2022-jp?B?VFhBT3QvZ25ObktzYk80a1JBZm96MCtqcWg4TFdSUkhxeGs4OHIvNnUx?=
 =?iso-2022-jp?B?ejFYbjF6Tnoxc1BrN2xnaWlFMU4zRUZ2dmYrVVhBOFNQS1lCRDBETWxX?=
 =?iso-2022-jp?B?cU5EZ1BtS24zTEtZTTdSbHdrUFhUeUtHSlUzRVlOSHNVL1VkVnlOVU9E?=
 =?iso-2022-jp?B?RmpGdXlHZEdVUkZPbzlJUjQ0TThxc0Vtalc5NUZ2MGhMMElpeWhwVmJz?=
 =?iso-2022-jp?B?Z1l1WW81ZkoveWpOb3IvL3p0NXdrSzVrc3dJSDNSZG90UkxwUk10ZjJm?=
 =?iso-2022-jp?B?cmNuaCs5S3VCbHFFTWtjNU1tbG9FV1ZRRlF2Zmk1ZlNZNUxwRXYrUmIy?=
 =?iso-2022-jp?B?NFFJVitUZ3Y4OTlUVVhZRm42R1IxOXZGOTVLMnlTbW5rVlNHL1p0ekNw?=
 =?iso-2022-jp?B?VlhBdE9obitQcXFiY00wb2RKd0Jvd0FNUVhEL1FkWWp5aVBBWW5CeEEv?=
 =?iso-2022-jp?B?VmZoaERnYXp6M0VBYXM3bmpVdG1SRUtmSkY2YS84ZHhDSit4dHhlTkhj?=
 =?iso-2022-jp?B?ZlZjd0JsSnZ0NUk4UHh0cWFHL0JML0gzWG91N3BWNlEzd1FmTTN1Qkxv?=
 =?iso-2022-jp?B?UnFHWHFu?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IQkqHgWfoqaMbZJSnHB23yHqwcdIcoKTmObk5XOscZg/5vgnbpji/LmDuD115+t2STNdId+drcyyn1QdhPpAdFlORf/3qmD38oQLybNVSa7H9+4LE9kf1htg7ecVSG54iPx3oJv7RNB8DfCqlerKJk343SMLPzLgZEgYLo2Ln78emhJk2tLyT5CFo8mpb4UVYo3FLLGkJn1fvSvpfSqghupTm7p/SUuKfzIeHUz7QvMG8IJ0BxhQGTZvhToZNnbWalm2Pz+zVBzdrQKcHuteCIAsrrUeNDVhK9F/jjx/hLvEg24jZraPwV75MTKL5xaMsPc9IvW9bUPdvrGdWOrfAQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719d3f0c-5dfb-46d3-5a83-08dec79d14d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 09:37:40.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLuXGaGrVbf+h4JdrG9TzDnA88egg+RK6KE9jwJ1tQ2ndd4FBPuORlQ1hlbxEZp0QHHSROZFkqxLvL3WMX6Srg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298032-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F132867076C

Hi All,

I'm looking for feedback on a potential extension to ethtool for controllin=
g Ethernet PHY link characterization using PRBS generation and error inject=
ion.
PRBS is a port level configuration and ethtool ?phy-test will provide contr=
ol interface at every port-level.

PRBS is an IEEE standard, and almost all Ethernet PHY SerDes comes with PRB=
S generator and receiver to assist physical link characterization.
In addition to PRBS sequence, we want to support provide SW control knobs t=
o insert fixed number of errors, retrieve the bit error count, and clear th=
em as needed.
With this, we are trying to standardize a multi-decade technology PRBS, so =
every Ethernet vendor can get benefited and replace the device specific cus=
tom tools.
From Ethernet designer point-of-view, it helps identify, fine tune, and mak=
e the ethernet communication better and stable.=20
From end-user point of view, it helps gather debug data when something is n=
ot working at expected speeds.

Typical operations include:

ethtool --phy-test eth1 tx-prbs prbs7
ethtool --phy-test eth2 rx-prbs prbs7

ethtool --phy-test eth2 bert start
ethtool --phy-test eth2 bert stop
ethtool --phy-test eth2 stats
ethtool --phy-test eth2 clear-stats

ethtool --phy-test eth1 inject-error 1
ethtool --phy-test eth1 inject-error 1e-3

ethtool --phy-test eth1 tx-prbs off
ethtool --phy-test eth2 rx-prbs off


Approach would be to add a generic ethtool netlink API for PHY/SerDes and a=
llow drivers to implement the operations directly.=20
Conceptually:
       ethtool =1B$B"M=1B(B ethtool netlink =1B$B"M=1B(B driver-specific im=
plementation

The intent would be to provide a common userspace interface while allowing =
implementations in NIC drivers.

Before proceeding further, I would appreciate feedback on:

1. Whether ethtool is considered the appropriate userspace interface for th=
ese functionality
2. Whether similar work has been proposed previously.

Thanks,
Shubham D


