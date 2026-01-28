Return-Path: <netdev+bounces-254399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAVNHaRNemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:55:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED816A7509
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 119D3309F1DC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729B36EAA7;
	Wed, 28 Jan 2026 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rqf8E0Mo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5736EAAE;
	Wed, 28 Jan 2026 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622536; cv=fail; b=MvCg7PujBaNGilQdHHzFxPX6SYujuJhi3rPs19ec8mI9Kt7KinNVJ/hqJNrBd0cY7G5Cl2J5wCwxfderfW4HtjosONT1zkUYDANIYsXPyOiNQGJW8EoYVFOir3tW8+zL4YxAWeKAlUJkTB042l3CwOmxRO6hrR7dQ1snvAwXqWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622536; c=relaxed/simple;
	bh=SfStgqTlP6NCjHCGWi4wY3D3kp1+jKtEX1OpJE66kWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s4Siiwx9+Lqi1TTyBEyriWyrGIs88pI86XZNS2X/L6rUDaJJ0iqJLH92BaEQS2bmNmHP+v4gtz7kMY8QlOPpontkAL/yD8fz5hGFiyzlbnESeQl2Wlg7Kn06PehwIf/VGH6Yv4/q9RPblljQ9DBBqmG+lGbYi824fiTmHGpHAWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rqf8E0Mo; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769622535; x=1801158535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SfStgqTlP6NCjHCGWi4wY3D3kp1+jKtEX1OpJE66kWo=;
  b=Rqf8E0MoYrwXaSfHfV/E6HuWa6hRn8vozYNOi4GiXqIyULFmhs8OSJPH
   uk1AvVAGm3KOcl48Jymb0GZ9ZM14VWql4Un0rGry2AeArxoLwg2pLaem9
   A5/3Z2uYEnkv0LpYpQnB39btQIoT1YB5a6dRzfMkYK0LOSGucrhsCpwjO
   C3IUXTcop5dKMefiQE04rZXuOCF9Ulx0349w66SlcCErB3DE+bFtNKxEQ
   sjNFi6yKLK9+Y1icoNxyeOiIJgA/SLNszgB3DWIy/FhK+4UoE61LofuUE
   o0yTh7Tm85cxox0nI55zX6F+KUOembLh9nSpcVx3y2F2Huvu5hXxasMT1
   Q==;
X-CSE-ConnectionGUID: KUjqP3xwREqdN5Rbim+75Q==
X-CSE-MsgGUID: e+CvGZuLSmqd8xv+f2KPLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70898130"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70898130"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:48:55 -0800
X-CSE-ConnectionGUID: gwc6KGnWQ8yE7yxbPw08Vg==
X-CSE-MsgGUID: wamHfJsYQdqZeK8M+M/Rrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213197133"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:48:54 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:48:53 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 09:48:53 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:48:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZg6wNzW5AzRiU803L2fStbJchMO/w+M5xAzB5rhnqeSuby7TsVCi/+sPXDWt0Z0hmj5cY7KWzM24FSEdxGwKZLHyCxL/xIU8gtAUIoDHT1p3BUzYhNCKgolb2w+38lySJGe5vAIvUlWBIQoZz7qsQma1o66/UitT2CMW67ipFt540lNrV0tfBLpgUUk0q7WFz87JJt7qVkEPWqBBpz7mW+X2BZbzI7qHhPjNM6gxvkvoL38oMeKP9CLvDx4Rdm+sTrRa5Xj4YtXuS5YRnSQ2c32aeA+/Aewox27piukQ74CAcwnOl3wYOQbBTyT6OczboTCZAp4jN03iLGywWBfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfStgqTlP6NCjHCGWi4wY3D3kp1+jKtEX1OpJE66kWo=;
 b=blz1TVaWaEvU5FIcZO0eNNcrfB+VoRx3+VHAT/AujtuAoPkGe1AkxbLlyloRIibLObvBCy6UrW79gheZkPR/hz8Rp+lF7CpyyL/RkZ2P4GdPXiNcTGVk+R2t9kuchPPyyEVJAFBZc+we89SDM+ZysZ9TfdWGb06T3NUITXkm8FnPKzW3lHEop+vhF9QTRmWDLz1TD+DxbDCUqIRgizSsPFLNIDaupGppN9G//iG3mwy3yjh1TvcWtz+MvOtVlN+WSndejJffZEzBF80TVrOVH50bQyKiAmsLsiIjPSmjgCBXuyYsaR+OUamaPTKCHPWCIKv5UbUCF3bJb/nKF2MUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA3PR11MB9160.namprd11.prod.outlook.com (2603:10b6:208:57a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 28 Jan
 2026 17:48:50 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 17:48:50 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>
Subject: RE: [Intel-wired-lan] [PATCH v2 18/25] docs: kdoc_re: Change
 NestedMath args replacement to \0
Thread-Topic: [Intel-wired-lan] [PATCH v2 18/25] docs: kdoc_re: Change
 NestedMath args replacement to \0
Thread-Index: AQHckHZbrFZ212APmU2vf2CbxJys0rVn28FA
Date: Wed, 28 Jan 2026 17:48:50 +0000
Message-ID: <IA3PR11MB8986B208F98E659DD598FD4CE591A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <323b4c67ae7fd241670ef0b5ff6eeb10d968415e.1769617841.git.mchehab+huawei@kernel.org>
In-Reply-To: <323b4c67ae7fd241670ef0b5ff6eeb10d968415e.1769617841.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA3PR11MB9160:EE_
x-ms-office365-filtering-correlation-id: 6028c278-e563-4165-e039-08de5e957edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dVArajBFZ1AyUElCS3ZvakZCTXc3SVZmU3lTUE13MzBGdkVWdWswNW8wNkVq?=
 =?utf-8?B?NzdWRVFaNThtVVMyOVlOdVcvNnRQaWx5ajc1NktmNmlaREFFWk1YeWFVS2pP?=
 =?utf-8?B?ak5WUC9YMVFJRk1pWE5BOXB1WUh1SVh3bGdSUC9pUnhEWjJyUi83bzhCU0V3?=
 =?utf-8?B?djlKQkI0eEY4MWs3ZENyd2lJUThYK1FvUHBhQ3JjVWJLUkRmZThoWUJWOXVi?=
 =?utf-8?B?TEFUUGdtNUN0c2JHNlNaMUpkVjE0UVRSMHJCY1RXdWpNRDdjNzJlOTlNZ0tz?=
 =?utf-8?B?Nm8rTzhURFdTYkQ2cHg5RFl5c0VyaTRqV1FaL00xSTRLMnRjb0dGbzhiVExN?=
 =?utf-8?B?U25IanVRZWNPWTEySHNhTkRYYUZhYUd2dHdPaGFpbjNwNWZZSUJCMldzNHVZ?=
 =?utf-8?B?ZEFuS05wN05EMU9sajB3RTNISW9GeVhyeis4OEZWQ2F0Q0ZWaW1sWnArKytL?=
 =?utf-8?B?VU1tMkEycGtaMWxwZDRyU29YVW1kejFXeEkxNmg2dlVjRElIaTdVOFZXY0lK?=
 =?utf-8?B?aUF1eFg3OThQQktBRGNLZDhQNXliL2tVVmt3eEdWcnFtRzV6WCtEU0VyWE1V?=
 =?utf-8?B?SG5DNG9jM0hGRlVHdUg0cWJOdmdSd1VSZW0vRlRaWUlmdmtSTnVFdlN2Sllk?=
 =?utf-8?B?UHpuMCtJYUlDdmIzaXhIVkVValliTHh1Nnozb2taWG43N29wR2UvOWpmcU1r?=
 =?utf-8?B?akN1YzgxbnpFZnpYNHpmR1Z1ZGpWV2lsd05TbFBjTEwvZFd1OW5KMW9ndGh2?=
 =?utf-8?B?RHZJb1hBMnZ5VktEWm9rdlhJZEF6Z090SGxLTVpNUEJMZmNPcXV3bjZrV1U4?=
 =?utf-8?B?V3IvVU96aCtnTlZXQjhkN2R3cU1mTHhTS1QyckE2RE0zMzFVVVppdlJoZVBU?=
 =?utf-8?B?M2NQSTZ6YW5vNjVMamtVaUYvQjlLYWpGWFRlbXNZRmtvSERBTzJHWCtqR3di?=
 =?utf-8?B?R0xzRjdpeUVNWWhqM3ZoLzU5V00yTEdCN25nb25CTXpibUU1Z2hYYmlRL25w?=
 =?utf-8?B?YWJ1eXN0c0poYjg5QzZ6N2sweGs4c3dzYzA5Z1ZNUmF1QStpTTlSdVRlOHFE?=
 =?utf-8?B?TUJadUJDWUU3L2ZzZDFOUjhMS2dEVGc3QUxCTmxvNUhCazBVcWhNazRGNkhu?=
 =?utf-8?B?QkU0SUQxYXJNTjBhVUFwRmdLamtDMXFEa2hRVy91akxSUzJVN2F1b2hoRC9F?=
 =?utf-8?B?YlE2c3hHUkdqU2dralVVczhMLzROdUl0SEV1QktjVEM5UkpXZ3VwejJMS09v?=
 =?utf-8?B?bDY4S2wzUWhxRzVTTE5OYUdPREU1OFdyY2J5eGpzZzFReDJuR0d2OU9xdkJm?=
 =?utf-8?B?LzVVRUFvSmg5UEpybWlpN05nU0Z6REYyOFRtb0N5aEZrL0VNUlB0R2EybWhN?=
 =?utf-8?B?Z1JHVmJyUnFFV2c2bW1XbVduUkNIL3VWdy81Y1U2bU81T3dtM0JuSGxnbHFR?=
 =?utf-8?B?bnk4UjFQSkMxSGtXODZWMEgwV1ZvZ1htNFd4d1FFRXZYeGdMK2Jxa0VxQ1Zv?=
 =?utf-8?B?RGFSc203M3BJVFNSR2s3TUdud3NjSGY0QklkbHIzeFU2OXVOeDFpRFBkcWRp?=
 =?utf-8?B?ZVdLdHFmNTJXOUlMeFFjalEzdTl5anEzbFNUeWsvNjNtS2ZBL0ZHVWZPVmlU?=
 =?utf-8?B?NTJXMHJ0QklVdHlCVGVVNFBaYVg4cHBCQm9Ob1FHVzkzL3Z0eWE4UHhRVkdt?=
 =?utf-8?B?cGtTdWNNZ0xmY2MybFZvV1FvYi83N0gvOU9lK2NWZUJRMlV1S1Qwd2JRYUpQ?=
 =?utf-8?B?WU9jMHlseUpKd3NSd24wOUZISk5DQS9SaSs2SUdwazRxcytKdGlOWTNnVFJa?=
 =?utf-8?B?VDErakJnNUxTT2tqSHBUTUVrR1RRbmpXRCtjRy9qcW1zN2NqaFovRFowZGRm?=
 =?utf-8?B?dWlOVVZycng0bTQrY1hndloyNTZlQzE5dmt2MmtqdGNWTzFHeEZXNVZoa0Mw?=
 =?utf-8?B?QklrLzR1U2pIVk9DQTIvaEIyS3owUDVraE5PY2Q4ZlMxcmNERU95b0J2cDhZ?=
 =?utf-8?B?TnlhdzhWYUgzQXhIeTJOeGJYc2QyNW91RWVFaVFEN1hCNHVyQzE3cDhVcXQw?=
 =?utf-8?B?dVQzeFFsamJ2TEczck5ncXkvMjg3V09FRTF2U1UzR3FzV05GYythQXMvNlRS?=
 =?utf-8?B?WUpzTXBwTk84bnhiRlU3c3g1dUJOV3BHRnpWaXB1TVBTOGcwRE1vNXVYZk5q?=
 =?utf-8?Q?xKQpIomR1Rsnzht+f1JH1Hk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3NicjNHcU5MdHRkV016S1dXTURrWkJ5Y2QyaGpxaVV0VGI1ZlhDcEszM2Fr?=
 =?utf-8?B?d3pjOEdTVGoyRU14aTNQTWhiUy9GSnZOL3QvZXE0aWxESGV5R2hUTmZPTnRS?=
 =?utf-8?B?VjZwVys3eWhlZkxTUDlnV082aldHRndLKy95YVVsbVUybjlSblBtbit3a0NW?=
 =?utf-8?B?QTdRbU5rTnVhRlJPTWJDMDZCY05UN3ZSL1ZoMUVXb3ptNFBGdEV1bDlsTVE4?=
 =?utf-8?B?b1pqSU9iK3h2UHVIM056eStWMTFHVEFTNHVwTTIzanoyc0hmQ0F5V2JNamta?=
 =?utf-8?B?dVQvQjRjZ3dkQVB0QVcxSUdVeFZsNlV6NUhjTmMxaWRNTUJESW5QektKNCts?=
 =?utf-8?B?ZGZLemx6QVdickxqQ2xnQkg5NlhXT2ZGc3BTL0lFT0VpakIveHFPei9PUXNU?=
 =?utf-8?B?M1piSlU3aWJwTTc3NmJxWU1HTTEyNERkS0dnc1VvK09lZUZ6c29DRys0VUZm?=
 =?utf-8?B?YTBseW0xQ21vUjJjcDhYaWx3MGxnL3pMaUtDQjZhUzBvczVZQ0pkVlJqUUNi?=
 =?utf-8?B?UWFIeXJiZ1Mxc0dvMTdrSTFuNkhZOG5ycXU4L3J6NFZwbkRpWTdzYVA5NEcr?=
 =?utf-8?B?MjBtM3RveEhicFlFdEljVnZLb1E5QTE3OXVKanIvSjFvVTlWTTVSTkE0Y1l2?=
 =?utf-8?B?a1NGRTRqRm5EcC9WNjYrR2twaVhKNUJTclJvSzRzODBNclkyREloWmFuTElk?=
 =?utf-8?B?aVFTVE9vMkRIMm1OdWZaelpnL3l6ZG1EL0o2SUhhbktpTGtlM2pDdTJlaDZJ?=
 =?utf-8?B?NysvSk1ITTA1NDVuS0pHN29qZDVQTzgxaUJYanhKUDFYemJqbHZEaTREWVFz?=
 =?utf-8?B?Sy9FWXBJeUVTdW1McUFPc0NjeHBQajZjVUlnRkNwcU9mSDliU3A1ZjkvdmpZ?=
 =?utf-8?B?VGRJeUpOVzFpZm91WngzR3J6a2E1T2tsV0k2QnBQMGdJN0Rwc3pnbVZtZkY3?=
 =?utf-8?B?dUxLZG9QNjdaUVNBRTZwZXdGaUo1bkFhZkFXSm5QZ0xxeC9zdlpOSEpxYk1Q?=
 =?utf-8?B?Q1JRTWFkNGNMS2FlUTdEMVNDUko5L1RmUFUrZ2tKV0l0eXVGR2F2dFkxNjhP?=
 =?utf-8?B?OTRpc2wzYnpxakFwQUZtZkVocWpEcFEyZEJKRUU3ZDlDbW14L1FHTDBKT056?=
 =?utf-8?B?bTNHckxWRkVCZ04rYnJSbFVYYSt6K2YwemNwV0J0UmJWMmZjR01FTVNiTUNB?=
 =?utf-8?B?MXR0Q3pvU1hSaFMzQmZvcllwdk5VM1doZVlYQmxoWUV0Q1NYc0diYXJCQlJI?=
 =?utf-8?B?QXZIREZoYVdsT1l2NkRzYUQzdndSRTlvTzcrVEZlaERIaXZXenJzWEQzckR2?=
 =?utf-8?B?M2RUUFN3bCsxeWFScWVydGtrdHJuWVZMTEtOYnJUMTNjTHFMWm1rbmJzRVNG?=
 =?utf-8?B?d21NMjFhbUxWMUZMY0Z1d0JHUytVMk81ZVViTGRUVjBEMWEyd3c3QXZWYmFR?=
 =?utf-8?B?R1JQcm1xcGVRTDZJVFU4QnR4S1E0cUtqbEpPdmk0SWVYaFBTM0pYbXErUFNp?=
 =?utf-8?B?cVo5N2o4MUkyTkpQOVZTTDlxWkVSd0h0MXkyYkJ4RlI3UlB1aGNrck05RkEz?=
 =?utf-8?B?S0lGdTdkaEFiSG9JYTZZUVNPREJNK0xIZHlXU3ZyTURoOVNwdFZrVHk1QVdW?=
 =?utf-8?B?ZWh5THQvODJDM00rQTk2OWczQUwxcUt1eTMvanpXNHoxYWZpUW1XTjg5N2Nw?=
 =?utf-8?B?eDBOSy83UUV4OVJwVUNHd2g1THFqSlJlQUNFTzNJUE1aTWNVOGxyWHFYZDJC?=
 =?utf-8?B?VW9SVzZPSFFVbVlydHRNVjZoR1ZXdGNVZ0NubDdCY2paQ1JRSXo1cmJqMmdi?=
 =?utf-8?B?b3JsSEtXME03MUc0emdrb3llTGI3SURxcExpWFRoci9kS0VjWWVVTS9LYldN?=
 =?utf-8?B?K2tSZURER3ZoM1dZWWtMdmVhdnpveWk1TFJXOEJkcTBYZW9CWmlLV0d4aTZS?=
 =?utf-8?B?UG1yZFRjeU9NSnFuV0VFVUFoOWxSUU9iQ3Z1MnlqRW15aFVKT2dWTFhhODhk?=
 =?utf-8?B?bmN1WEdnWk1jTkJOdmpJMUhabmZwSDFkTXNrWDFsQVdJWFVVWUs5NndNSjNs?=
 =?utf-8?B?RFV2KzliRmZaSUx2UGp3MkI2RHpCUHpaMlBYQW9PS3VwL3JjQkdIT1RtYmxW?=
 =?utf-8?B?Ky9XT291K1NoTEprT2JEbk5XRkU1dzlWcGNyUmlpL1YxWkRxeEU4SkN2R3VQ?=
 =?utf-8?B?L0p3dFdYU054dnljL1ovemlEcEFobklWbDdhR0ZIZXpER1NVdlZFVmVZQi9F?=
 =?utf-8?B?NUE1S0NsTCtuWjNKai9lWUVyczNxUHc2Z2YwZlBqNGFVV1ZWTVJscGNSZG45?=
 =?utf-8?B?ZkNYQzVjdHhRZXNiNDNqTEpNVVpWRDZOMGRTUVNRbHkrUGJvR1FMUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6028c278-e563-4165-e039-08de5e957edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 17:48:50.4571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdppXquyFuFGNzyQ+2jeHdDnf4+Juw8+XCUiyGrTAx3v3xObkSxx0RqhHUcWD36tUUQ8AijSksyTHMjZfVZZxqQvn6zVyMWHUAI80/RpBH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9160
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ED816A7509
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyOCwgMjAyNiA1
OjUwIFBNDQo+IFRvOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgTGludXggRG9j
IE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBNYXVy
byBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+Ow0KPiBicGZAdmdl
ci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFBldGVyIFpp
amxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPjsgU3RlcGhlbg0KPiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+
DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCB2MiAxOC8yNV0gZG9jczoga2Rv
Y19yZTogQ2hhbmdlDQo+IE5lc3RlZE1hdGggYXJncyByZXBsYWNlbWVudCB0byBcMA0KPiANCj4g
RnV0dXJlIHBhdGNoZXMgd2lsbCBhbGxvdyBwYXJzaW5nIGVhY2ggYXJndW1lbnQgaW5zdGVhZCBv
ZiB0aGUgaG9sZQ0KPiBzZXQuIFByZXBhcmUgZm9yIGl0IGJ5IGNoYW5naW5nIHRoZSByZXBsYWNl
IGFsbCBhcmdzIGZyb20NCj4gXDEgdG8gXDAuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZXMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVh
d2VpQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcGFy
c2VyLnB5IHwgMiArLQ0KPiAgdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcmUucHkgICAgIHwg
OSArKysrKy0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3Bh
cnNlci5weQ0KPiBiL3Rvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3BhcnNlci5weQ0KPiBpbmRl
eCBkYjE0MDM2MzEwNGEuLjRkNTJhMDBhY2ZhZCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbGliL3B5
dGhvbi9rZG9jL2tkb2NfcGFyc2VyLnB5DQo+ICsrKyBiL3Rvb2xzL2xpYi9weXRob24va2RvYy9r
ZG9jX3BhcnNlci5weQ0KPiBAQCAtMTYwLDcgKzE2MCw3IEBAIHN0cnVjdF94Zm9ybXMgPSBbDQo+
ICAjIGlzIGFsbG93ZWQuDQo+ICAjDQo+ICBzdHJ1Y3RfbmVzdGVkX3ByZWZpeGVzID0gWw0KPiAt
ICAgIChyZS5jb21waWxlKHInXGJTVFJVQ1RfR1JPVVBcKCcpLCByJ1wxJyksDQo+ICsgICAgKHJl
LmNvbXBpbGUocidcYlNUUlVDVF9HUk9VUFwoJyksIHInXDAnKSwNCj4gIF0NCj4gDQo+ICAjDQo+
IGRpZmYgLS1naXQgYS90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19yZS5weQ0KPiBiL3Rvb2xz
L2xpYi9weXRob24va2RvYy9rZG9jX3JlLnB5DQo+IGluZGV4IGI2ZTExZWUwYmUyMS4uMjhjYTUw
MzJmNDBjIDEwMDY0NA0KPiAtLS0gYS90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19yZS5weQ0K
PiArKysgYi90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19yZS5weQ0KPiBAQCAtMjcxLDggKzI3
MSw5IEBAIGNsYXNzIE5lc3RlZE1hdGNoOg0KPiAgICAgICAgICBJdCBtYXRjaGVzIGEgcmVnZXgg
dGhhdCBpdCBpcyBmb2xsb3dlZCBieSBhIGRlbGltaXRlciwNCj4gICAgICAgICAgcmVwbGFjaW5n
IG9jY3VycmVuY2VzIG9ubHkgaWYgYWxsIGRlbGltaXRlcnMgYXJlIHBhaXJlZC4NCj4gDQo+IC0g
ICAgICAgIGlmIHInXDEnIGlzIHVzZWQsIGl0IHdvcmtzIGp1c3QgbGlrZSByZTogaXQgcGxhY2Vz
IHRoZXJlIHRoZQ0KPiAtICAgICAgICBtYXRjaGVkIHBhaXJlZCBkYXRhIHdpdGggdGhlIGRlbGlt
aXRlciBzdHJpcHBlZC4NCj4gKyAgICAgICAgaWYgcidcMCcgaXMgdXNlZCwgaXQgd29ya3Mgb24g
YSBzaW1pbGFyIHdheSBvZiB1c2luZw0KPiByZS5ncm91cCgwKToNCj4gKyAgICAgICAgaXQgcGxh
Y2VzIHRoZSBlbnRpcmUgYXJncyBvZiB0aGUgbWF0Y2hlZCBwYWlyZWQgZGF0YSwgd2l0aA0KPiB0
aGUNCj4gKyAgICAgICAgZGVsaW1pdGVyIHN0cmlwcGVkLg0KPiANCj4gICAgICAgICAgSWYgY291
bnQgaXMgZGlmZmVyZW50IHRoYW4gemVybywgaXQgd2lsbCByZXBsYWNlIGF0IG1vc3QNCj4gY291
bnQNCj4gICAgICAgICAgaXRlbXMuDQo+IEBAIC0yODgsOSArMjg5LDkgQEAgY2xhc3MgTmVzdGVk
TWF0Y2g6DQo+ICAgICAgICAgICAgICAjIFZhbHVlLCBpZ25vcmluZyBzdGFydC9lbmQgZGVsaW1p
dGVycw0KPiAgICAgICAgICAgICAgdmFsdWUgPSBsaW5lW2VuZDpwb3MgLSAxXQ0KPiANCj4gLSAg
ICAgICAgICAgICMgcmVwbGFjZXMgXDEgYXQgdGhlIHN1YiBzdHJpbmcsIGlmIFwxIGlzIHVzZWQg
dGhlcmUNCj4gKyAgICAgICAgICAgICMgcmVwbGFjZXMgXDAgYXQgdGhlIHN1YiBzdHJpbmcsIGlm
IFwwIGlzIHVzZWQgdGhlcmUNCj4gICAgICAgICAgICAgIG5ld19zdWIgPSBzdWINCj4gLSAgICAg
ICAgICAgIG5ld19zdWIgPSBuZXdfc3ViLnJlcGxhY2UocidcMScsIHZhbHVlKQ0KPiArICAgICAg
ICAgICAgbmV3X3N1YiA9IG5ld19zdWIucmVwbGFjZShyJ1wwJywgdmFsdWUpDQo+IA0KPiAgICAg
ICAgICAgICAgb3V0ICs9IG5ld19zdWINCj4gDQo+IC0tDQo+IDIuNTIuMA0KUmV2aWV3ZWQtYnk6
IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

