Return-Path: <netdev+bounces-271656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCSVKQQUxGmfwAQAu9opvQ
	(envelope-from <netdev+bounces-271656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:57:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E253297BF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1D4C30F4FE7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2103F9F58;
	Wed, 25 Mar 2026 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eik3K0GF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E743FA5D8;
	Wed, 25 Mar 2026 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456507; cv=fail; b=W4KMMM+i4D0Azqfy+m52xos/SRyx1CHQX0EAcS89v5XMgO9Vw2FdYocLpKbzU+MGoAvK/SHzB5m/VnxHqmPG79ZpUY6s5t/xocROKlRI1ghhNJ/TIKpkABGJy9Gnl0jeSone126yD7huXUxEMc5J01l+Q2Q3DYFu0bnPv83/WKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456507; c=relaxed/simple;
	bh=3FBgZSg3YnU4UV1NMs8AyA5q2d3EvvPl7c/u21YGpE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RlNYDgg8r7hTYWJ+HYhr4EBgE/7Tc6LOKOh0AsUgAbfMumh03JCdjAD0kkJ6nXMGDsOcMC53RflNBPEOlOXyLhg/rqXFxg1EMKsBx7LkCg/kDylENvlSycNivgK3yQYPVxcAtv1Y8XKskeaPyu/Uv/kH0+cuekzDuIU1V3oLKng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eik3K0GF; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774456499; x=1805992499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3FBgZSg3YnU4UV1NMs8AyA5q2d3EvvPl7c/u21YGpE0=;
  b=Eik3K0GFFQ+QvqYdAkxWghAbVyfiPn+MVCE+eQ5vUjctX3lhAGbdmNyb
   vHeTOtehDNsQjqTTjMOWjV7etiXEViZA39DRpMP20UFrGeMZaUlhloc0T
   wCH2LGqbaU5NDU6RWKjYyNy7uDWPmysqc9vP5AdUePWQ9t0ouIbitNM/k
   OY1UxhfxTVPI8AVrHDnK2D/VF1+OR2kKL8KRRNd6OlnmmstPhGCIWVtxl
   jpRpOe3ES5qrKZhiuiLS86gPBYRqSC7YAmJPIXge5u24qmKPSgDWWGIId
   Om2qINCOn4BNxTdbs8C4t4/rmjrzQhFwq82L79kulEb/xkqgj+r3Ux3iL
   Q==;
X-CSE-ConnectionGUID: iRk1Gzj2Q4WTpYbsknl9uw==
X-CSE-MsgGUID: PrJyHeHbT/aLecjOnKInIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="78097977"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="78097977"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 09:34:57 -0700
X-CSE-ConnectionGUID: DJZRrcGVRg+gxsec3H/yGA==
X-CSE-MsgGUID: xaejUSEnS0GPrp10uzVilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="248224250"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 09:34:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 09:34:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 09:34:56 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 09:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGk7TdRAHNKqOEdq+NG2y5geDq+QFLuws2Sac/rCuam8pWCchZ2ucCgsox6Paq4lhjdo2Fuhb67qyXUlj+SOG5wYwT40Z8wUm2d5DHEWDq2XMljw36YSh7bd0WcNegEjPSzF5K5T2bzu9xpRW3bKwCR4FKtIjkgzJXw8orpQEf/XHI07LUk6MSiIUOIuD3I2vGa66KHwaELfN0gqHMjGnvPy69rAwt/t3OAgQmoujG7/XR7XBeP2Yu5YUgMvt4l9pzcgPJSegwWT5ygrf57MKwbNz29IZeQzUkUoK7rzCL6davdxHHsADLyCcff1K7kMPK3hKSMHKFa9iBn1mG3lqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FBgZSg3YnU4UV1NMs8AyA5q2d3EvvPl7c/u21YGpE0=;
 b=Q7MKWszxmpVXlqBRRQGv/pJ2Qd9t4/luDYmygT297PDOcVtQvC98+LuYhQ1+Ju9m2MrkFFM6upZrXXKU4ZSqYiObegg32qSuPeYJNBU66j+0ZhjRM9gqKiZyAWUdxAG09qTJD58hRT0r1hNgS0VgghNn2D52Hn0tL7v/N8QEwN7MYUzP0t6iqMCnPBOwef+JVjPSMVwbsdKxWhPiDv99BBjpCK+yU/rxXRPjaLdXIKyBmxJ7VMB0pRSVfQMI1kZBnu9OS+z3WZZWNAmFqc6Ju8u8ihk7ZZHRm5BPTt5vdQpXPdl2BT7/DxY0UVMhBZAZ3gHn2HpflFuu7gC4ZNEJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6240.namprd11.prod.outlook.com (2603:10b6:8:a6::6) by
 SA1PR11MB9682.namprd11.prod.outlook.com (2603:10b6:806:4df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 16:34:49 +0000
Received: from DM4PR11MB6240.namprd11.prod.outlook.com
 ([fe80::a89f:ee6c:3596:df18]) by DM4PR11MB6240.namprd11.prod.outlook.com
 ([fe80::a89f:ee6c:3596:df18%5]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 16:34:49 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "horms@kernel.org"
	<horms@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH v2 net-next 4/8] dpll: zl3073x: allow SyncE_Ref pin state
 change
Thread-Topic: [PATCH v2 net-next 4/8] dpll: zl3073x: allow SyncE_Ref pin state
 change
Thread-Index: AQHcuYJbWVi9tDY17EyKL8UG+cT2WrW9xkKAgAGu1uA=
Date: Wed, 25 Mar 2026 16:34:49 +0000
Message-ID: <DM4PR11MB62405A243BA954489B18DA609249A@DM4PR11MB6240.namprd11.prod.outlook.com>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
 <20260321222627.1193603-5-grzegorz.nitka@intel.com>
 <95f100a5-ee80-4944-81b4-1f5edf0ca8cf@redhat.com>
In-Reply-To: <95f100a5-ee80-4944-81b4-1f5edf0ca8cf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6240:EE_|SA1PR11MB9682:EE_
x-ms-office365-filtering-correlation-id: 58244f5b-69ce-447e-349d-08de8a8c6f0f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: LIILk+59sF9FCpIyTMWtTih4MZgHHeFqAx9lgb5xS6KlMoVZQVKRU1t3JRDahU63AfYp1w5UzMu1ADFQ4jxEjB0yZ1O8w3zITXJWqaqlEdvZYYlQkTyDCSV8RebeuBQghPumg07B3Ov0IVpQdZal4RJIq1WnrwcvvEtBnlcdyGStXyVSUhZtFSKEDhXITfA4Uhch9WmC37VIvZM1YYgkoqrANHpcx7N2rVWY7u9LlBOeCbfHa1syKsdW5P3qlykcYkOeK1j6Gx0UjpJS6Bd0kFCiozVLj78TXNTPqK5yS9JnzbEqkdCPsWIZcyYjzwoELigXP3VZXuU78e/CT6w9gURFpSVAX3CwGuf8qM83tPHUqvvWn+nqZrHYN8t4BGAUVOjHeAtw+k8UkinPqfMTcrc6qSZTtsfH7JJk0Y9686hUZPf24MMs1U/WBX7mLdbNprhZirzRGBSJoN2p13lNBW/bLnF2o5RIjMf5UH+/hOUp7i/sfwt/M52rqk+AdSYl+1I1eU+QoF1U2lO/XAtjDcC5iEIxNDM7vpBMm2txIcuORbfGr0DYr0Ic4sahBiAz7yU6GbeS5/pHRbiJK6YkXhaaVreFI9imLghBoDBUlrXXrBM4k6FdS1gQxFlInwqfHmbIGP/OMCqfL8jzhkpfJ37EgbWkRkLFWW8M4aIMlFugXmpZbEhXe5fVLor9zGjj/E6X9r/x1m5IKOLQgev2GWacyS9Q71euYyzGKahnO4iWMaq0JC7SwYvXtirHEZF2VOAOUeSMzsfAmL5pxcpwP4vfnMbf6jNuvkR7fi+CxiU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVBRK0Z6Wk9nYktQMXlMb1ozeGZ5MCtVYm1pckFRTVR2THB4eGpobkdueXVn?=
 =?utf-8?B?RXNzOW9COFJZb2V4QVFsRVc1MlVWaVdSU1AwcVp0NGZWRXBnZG93TEpxV3NC?=
 =?utf-8?B?Q3V1eU1sa0ZoV2Y0OEtHWlFwVHVnSDB0NExUbk45SWtjTGlIV2liNy9YWmd6?=
 =?utf-8?B?RzhKREsxUnlZcFpTKzI0WUhNQXVmaFJpUWc1dDNoVTlIRHVPTGVGSHUxTlR3?=
 =?utf-8?B?bnJUVFcydXQ1YzlzZmpVSFE3Nkc4aW0zZHBuYXFGNDJHY0tDQitVVDFJSGhx?=
 =?utf-8?B?YXpEVkE1M0YvbmxlUUQva0JYcXNTQjdEN05wK2tkZmwrVE4reG83S0RJMVFH?=
 =?utf-8?B?UE91UlFuV0RndTVoOEk3dk5QdXh1b0xaMFdtMmVJWUlkaU5uVy9WNERxazh6?=
 =?utf-8?B?d01hckVzdk1EMUd3MWtTOFRLeGRSZzhVZlIvS1FCclc1VTk3SE85REZYYXcr?=
 =?utf-8?B?MEZaSmdORHZPMHdkU3VFd3RjUUVya0RrdVBsZWxhYXIzM0d0djRRaTJaZ095?=
 =?utf-8?B?U1J6TTNkMHEyM3J4eEhLcEZhckIxbWNwS2syNEdSRVV0aW1MR1hDUXo1enVQ?=
 =?utf-8?B?Y21pbW4xNzFwajVpcXFEUUYrbFN6K2JUZllycWJVdUUwUXF6MjY1d28vVUtM?=
 =?utf-8?B?eFRVTTZReURIcWV3d1dVOElyV1hzOGlwbGszQ09haGprNXNVVytObVNCbTVa?=
 =?utf-8?B?WUQzMWlwVDUrNmtMLy9ZeWhCUGxkZkJrTTBtQVloMXRwRmNxdDd6Z0JHRzR2?=
 =?utf-8?B?REtuQlp4OElqWDFHQTBZdmNoT09sRlF5VllSMGNmd3NYUVoyRXgwME5qRDdP?=
 =?utf-8?B?cGJJdmZWYVFXM1p0NFFrRWNuTHRRMU5jNWpWRVVZT0ROS1BMaE12N1VBYkFO?=
 =?utf-8?B?Q2tFbEpkR3Biakplc0lnSWp2LzVxNUYrelFDMUZlaHJoYndQTklQMjEvOXpw?=
 =?utf-8?B?Z2YzMUZCOG4vdzdFZGtSc015Z2kvN3NpVTh0Z3FheVBmVzZLaUIxWUhHOFI5?=
 =?utf-8?B?TnJ3TXhndUNYNkJ4eFc0QlFKbjU4ZlNUYUFIQVFnTSt4UUdML3psaW0wQTdJ?=
 =?utf-8?B?Rkx6WTg1clBZekRUelhRSHpabnlMSnBUd25uUjZFaFd6MlB0b1NZYll1YnhP?=
 =?utf-8?B?RFNrYlVVai9JZFlCNU81MFB1L2RKUVV5cWl2NHVhMkJTNjVQa3NHY0wrcURj?=
 =?utf-8?B?S01kMTY3VmtyWjc3ak0rZkI1YmlZNjB1Y3hpWHZxTC9Jci9zQWdVWHFlV3g2?=
 =?utf-8?B?TjRBUWhiSklDRjBjbGYzWVVnOHFabXBqT0U1KzNpTkJsTVk5SHJ3Y1o4b0dk?=
 =?utf-8?B?V2hqMW84aGZpM0dOaFkyMXJiMkhZcXZEZlJtSlZXb3VGT0s0MmxyanhycGZr?=
 =?utf-8?B?cTVDYXlqVEE1ZE51aGJyV0dEdkR4SDR0cHpZSGlBcVk1R2dyeEpTS1g3b0Rs?=
 =?utf-8?B?ZGZvWnpKajRJOFJEdnZWVmtyZmprQmhJV0wxZHloV3pQa0cveGlYOGpINHJI?=
 =?utf-8?B?VXhkdFpQZEJOcWdITnZzb2RaRnZESmd0VWswci9CYU8vS2lVeGhpZXBJZUVa?=
 =?utf-8?B?bm43bkt2anJZV1ltNFhLQytDcFZ2NDJqTldVQWxJK20zK0FTclVtQUVIUkhu?=
 =?utf-8?B?YmpFTnB6SU9aU1JNNmQwNzZyMzc4WnZad1VmeFJJN1l0dy9SalR0TVUzQzlR?=
 =?utf-8?B?QUh2bHNzbUR1L0hRNlZRM0dNaWVOMlVMSFBRQ3h3a2h6Ymc4czlrMU9MeDZE?=
 =?utf-8?B?ZC9CUm5qRnRsc3ovVFdxc3lHSVE4T1hhS3B5VjlBM0kyNG1LKzVmWVhlZUdT?=
 =?utf-8?B?TE44MndVMzhRekR0OXl3Z1R3TlF4dVozbTV1Rzk3UmxzRTBJUE9nY3d5aXha?=
 =?utf-8?B?NlhFZURvOGdnMWFNWmVwRS85SFNPTXFJK0s2TC9hUTFOM3hqZWxKQjlrL0tU?=
 =?utf-8?B?MzI2ZUVLTVdqRXhpb09Zb2hhdEF5QmlpQlY0bmg3djg2b3NEM29DSkJPRm5H?=
 =?utf-8?B?M3liSzRQSEh3aXVuZ2RrVmpsVGlHd0tvczZCYmxnTDBZeDQvZmg2R2NsNUhQ?=
 =?utf-8?B?REdVekkzSkVLcE1xSllJNTN2Nis2dzJkUUY3VXJUZXNVVTE5a3Bja3hZT2o1?=
 =?utf-8?B?RHhDUWJiWGxva21oamErS1lQaWxXSFgrOVNrSVhWTlNFa0pMR2E5Y1J2eFJj?=
 =?utf-8?B?U3pnb1lBTlQrWkwvbVB1QVRTcWI0azFyZW55SEhSMzFjVkMwWURPOUNyM3RY?=
 =?utf-8?B?eVliZEo4cHZhTHBuSWFDMHg2MUJHTzJvZW1DWXJOcGVWSUY5S01LY1VvM2tK?=
 =?utf-8?B?eEl5cnZUc1oxd25EWW5tVVdxYW9wYkVQUEVoZXQ1d3ZGV29URURyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lrzQd/KlGR7b+6dBs4UF228GFnkrkh9GvoA7RmAQv00n1rEAoMZ1m9H6tI7jVuO04NdAzKrL8m+SSnBmHtK2IeAqKEGO8rY+2CgyTUyhQet5M6rhlTy/zls/F2+kRtqPd92kS5ERz9uTnTn/Jn4tXl+/tpj1mR192OIhKnU1OIMUuwqxqi2n9p2nxeOym97dtXo4ekvB4soq9uju3kn4ggk0pj1l+4lm3KeN2rvCdug90XVD2nDaLBpQCPoaDQ6A5Ne5X2NJEiTrV+xdx47j6qX37MGJiTLVBdt4/4ieNE3d7imu8OddUVWP4nZ8NqiIN6zK6zCXf+hbRNBZgJJfTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58244f5b-69ce-447e-349d-08de8a8c6f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 16:34:49.6175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERm7K7Lvvp3QuB6QK/FrqB40PMLHU+QHTWB29PU4OLZhUU26yExduHfEaEFLMCTTGiu8x7FZarBSz5bYTMFs1wToXRuG7NWVFZzJ6sLUVTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9682
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A6E253297BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJdmFuIFZlY2VyYSA8aXZlY2Vy
YUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyNCwgMjAyNiAzOjQ0IFBNDQo+
IFRvOiBOaXRrYSwgR3J6ZWdvcnogPGdyemVnb3J6Lm5pdGthQGludGVsLmNvbT47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGludGVs
LXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBPcm9zLCBQZXRyDQo+IDxwb3Jvc0ByZWRoYXQu
Y29tPjsgcmljaGFyZGNvY2hyYW5AZ21haWwuY29tOw0KPiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7
IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBO
Z3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBQcmF0aG9z
aC5TYXRpc2hAbWljcm9jaGlwLmNvbTsNCj4gamlyaUByZXNudWxsaS51czsgS3ViYWxld3NraSwg
QXJrYWRpdXN6IDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+Ow0KPiB2YWRpbS5mZWRv
cmVua29AbGludXguZGV2OyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsNCj4gaG9ybXNAa2VybmVs
Lm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgTG9rdGlvbm92LCBBbGVrc2FuZHINCj4gPGFs
ZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIG5l
dC1uZXh0IDQvOF0gZHBsbDogemwzMDczeDogYWxsb3cgU3luY0VfUmVmIHBpbiBzdGF0ZQ0KPiBj
aGFuZ2UNCj4gDQo+IE9uIDMvMjEvMjYgMTE6MjYgUE0sIEdyemVnb3J6IE5pdGthIHdyb3RlOg0K
PiA+IFRoZSBTeW5jRV9SZWYgcGluIG1heSBvcGVyYXRlIGFzIGVpdGhlciBhbiBhY3RpdmUgb3Ig
aW5hY3RpdmUgcmVmZXJlbmNlDQo+ID4gZGVwZW5kaW5nIG9uIGJvYXJkIGRlc2lnbiBhbmQgc3lz
dGVtIGNvbmZpZ3VyYXRpb24uIFNvbWUgcGxhdGZvcm1zDQo+IG5lZWQNCj4gPiB0byBkaXNhYmxl
IHRoZSBTeW5jRSByZWZlcmVuY2UgZHluYW1pY2FsbHkgKGUuZy4sIHdoZW4gc2VsZWN0aW5nIGEN
Cj4gPiBkaWZmZXJlbnQgcmVjb3ZlcmVkIGNsb2NrIGlucHV0KS4gVGhlIGhhcmR3YXJlIHN1cHBv
cnRzIHRvZ2dsaW5nIHRoaXMNCj4gPiBwaW4sIHRoZXJlZm9yZSBhZHZlcnRpc2UgdGhlIFNUQVRF
X0NBTl9DSEFOR0UgY2FwYWJpbGl0eS4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBBcmthZGl1c3og
S3ViYWxld3NraSA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPg0KPiA+IFJldmlld2Vk
LWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBHcnplZ29yeiBOaXRrYSA8Z3J6ZWdvcnoubml0a2FAaW50ZWwu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9kcGxsL3psMzA3M3gvcHJvcC5jIHwgOSArKysr
KysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2RwbGwvemwzMDczeC9wcm9wLmMgYi9kcml2ZXJzL2RwbGwvemwz
MDczeC9wcm9wLmMNCj4gPiBpbmRleCBhYzlkNDFkMGY5NzguLmFjZDcwNjFhNzQxYSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2RwbGwvemwzMDczeC9wcm9wLmMNCj4gPiArKysgYi9kcml2ZXJz
L2RwbGwvemwzMDczeC9wcm9wLmMNCj4gPiBAQCAtMjE1LDYgKzIxNSwxNSBAQCBzdHJ1Y3Qgemwz
MDczeF9waW5fcHJvcHMNCj4gKnpsMzA3M3hfcGluX3Byb3BzX2dldChzdHJ1Y3QgemwzMDczeF9k
ZXYgKnpsZGV2LA0KPiA+DQo+ID4gICAJCXByb3BzLT5kcGxsX3Byb3BzLnR5cGUgPSBEUExMX1BJ
Tl9UWVBFX0dOU1M7DQo+ID4NCj4gPiArCSAgICAgICAvKg0KPiA+ICsJCSogVGhlIFN5bmNFX1Jl
ZiBwaW4gc3VwcG9ydHMgZW5hYmxpbmcvZGlzYWJsaW5nIGR5bmFtaWNhbGx5Lg0KPiA+ICsJCSog
U29tZSBwbGF0Zm9ybXMgbWF5IGNob29zZSB0byBleHBvc2UgdGhpcyB0aHJvdWdoDQo+IGZpcm13
YXJlDQo+ID4gKwkJKiBjb25maWd1cmF0aW9uIGxhdGVyLiBGb3Igbm93LCBhZHZlcnRpc2UgdGhp
cyBjYXBhYmlsaXR5DQo+ID4gKwkJKiB1bml2ZXJzYWxseSBzaW5jZSB0aGUgaGFyZHdhcmUgYWxs
b3dzIHN0YXRlIHRvZ2dsaW5nLg0KPiA+ICsJCSovDQo+ID4gKwkJcHJvcHMtPmRwbGxfcHJvcHMu
Y2FwYWJpbGl0aWVzIHw9DQo+ID4gKwkJCURQTExfUElOX0NBUEFCSUxJVElFU19TVEFURV9DQU5f
Q0hBTkdFOw0KPiA+ICsNCj4gPiAgIAkJLyogVGhlIG91dHB1dCBwaW4gcGhhc2UgYWRqdXN0bWVu
dCBncmFudWxhcml0eSBlcXVhbHMgaGFsZiBvZg0KPiA+ICAgCQkgKiB0aGUgc3ludGggZnJlcXVl
bmN5IGNvdW50Lg0KPiA+ICAgCQkgKi8NCj4gDQo+IEknbSB3b25kZXJpbmcgYWJvdXQgdGhlIHB1
cnBvc2Ugb2YgdGhpcyBmbGFnLCBvciByYXRoZXIgdGhlIG5lZWQgdG8gc2V0DQo+IGl0IG1hbnVh
bGx5IGZyb20gdGhlIGRyaXZlci4gU3VyZWx5LCB0aGUgZXhpc3RlbmNlIG9mIHRoZQ0KPiBzdGF0
ZV9vbl9kcGxsX3NldCgpIG9yIHN0YXRlX29uX3Bpbl9zZXQoKSBjYWxsYmFjayBjbGVhcmx5IGlu
ZGljYXRlcw0KPiB0aGlzIGNhcGFiaWxpdHkuDQo+IA0KPiBXb3VsZG4ndCBpdCBiZSBzaW1wbGVy
IGZvciB0aGUgY29yZSB0byBzZXQgaXQgZGlyZWN0bHkgYmFzZWQgb24gdGhpcz8NCj4gDQo+IEl2
YW4NCg0KSGkgSXZhbiwgdGhhbmtzIGZvciB5b3VyIHJldmlldyENClllYWgsIEkgZG9uJ3QgbGlr
ZSB0aGUgd2F5IEkgaW1wbGVtZW50ZWQgaXQsIGJ1dCBpdCB3YXMgdGhlIHNpbXBsZXN0IHdheS4N
Ckl0IHdhcyBtb3JlIGFib3V0IHRvIGludHJvZHVjZSB3aGF0J3MgbmVlZGVkIHRvIGFjaGlldmUg
dGhpcyBwYXRjaHNldCBnb2FsLg0KDQpBY2NvcmRpbmcgdG8geW91ciBzdWdnZXN0aW9uLCBJIGdh
dmUgaXQgYSB0cnkgd2l0aCBzdWNoIGEgc2ltcGxlIGNoYW5nZSANCm9uIHBpbiByZWdpc3RyYXRp
b24gKG9mIGNvdXJzZSB3ZSBuZWVkIHRoYXQgYWxzbyBmb3IgcGluX29uX3Bpbik6DQpAQCAtODk2
LDYgKzg5Niw5IEBAIGRwbGxfcGluX3JlZ2lzdGVyKHN0cnVjdCBkcGxsX2RldmljZSAqZHBsbCwg
c3RydWN0IGRwbGxfcGluICpwaW4sDQogICAgICAgIH0NCg0KICAgICAgICByZXQgPSBfX2RwbGxf
cGluX3JlZ2lzdGVyKGRwbGwsIHBpbiwgb3BzLCBwcml2LCBOVUxMKTsNCisNCisgICAgICAgaWYg
KCFyZXQgJiYgb3BzLT5zdGF0ZV9vbl9kcGxsX3NldCkNCisgICAgICAgICAgICAgICBwaW4tPnBy
b3AuY2FwYWJpbGl0aWVzIHw9IERQTExfUElOX0NBUEFCSUxJVElFU19TVEFURV9DQU5fQ0hBTkdF
Ow0KDQphbmQgaXQgb2YgY291cnNlIHdvcmtzLg0KDQpNeSBjb25jZXJuIGlzIHRoYXQgaXQncyBh
IGtpbmQgb2YgaW1wbGljaXQgcHJvcGVydHkvY2FwYWJpbGl0eSBlbmFibGVtZW50Lg0KV2lsbCB3
YWl0IG9uIG1vcmUgZmVlZGJhY2sgb24gdGhpcy4NCg0KR3J6ZWdvcnoNCg0K

