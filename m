Return-Path: <netdev+bounces-229079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1292EBD802C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9C174E1DED
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824B2609DC;
	Tue, 14 Oct 2025 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHqt02q9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4C25F7B9
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428312; cv=fail; b=TlI/KCcOsUZfgcWNPJDZXw4+ijbst0gZo/qkYrEV4LRvlfev5fje8aj/fSq54KOtlVSPNkKc4Xs4zHj3xETenRbcpjTUrVQsmj9tz/2BcmugiMLfKY31wgdHr6vTQVO5qHAtdGpXIKIxrM50FVkFQSNjnZPoXeANc0gC2v/1EAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428312; c=relaxed/simple;
	bh=CLSVXdgpATQhDwNb9R3DRpbRB1Iokc9cQC0if0ozv6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rRgaC7yj7fCJiFU0Yrh/CMU2gZ1euHG+UHf6hZNm+4fIvU9CEiXnMsP/lLl4ov0Dge+XPijvcU8PkYjLaYvj8FLVzTM+DnCK5Y2S4WMlA114ksHleR0AR6WNqhi2ZMAVFFQXxPyokyedrcscexZdhDeMDGs9Dh2P1wXuQsVSmMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHqt02q9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760428311; x=1791964311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CLSVXdgpATQhDwNb9R3DRpbRB1Iokc9cQC0if0ozv6A=;
  b=IHqt02q9fvlsTdi/nZrmd8+Q4C2Dg0JeuiCCcfDNQkZnjS10NCMzAIcP
   pKqm9fzKC9jf56yrOLiTUOO6p9Y/VoVvWKP/FbelSQicvxYst2dHDGBpv
   PJLKdnFOSLh8hibvK+dvHvMMaZU2L77WeJ1IGqPcc/foLxRLlfAPT6PPx
   WmV6XxeOjcdQR6k87jM0E7feiz7bVD3D0aEXBwzqflOjonMm0nD4mavaa
   IzTxxLHhhS1030K/Gf5h2nBoBN1JURexzCAUjNQWmBa5XLSdVFx4gwyv3
   4Ce5FyL8fgGBNwJtiuP5EU8Yf5pX2Qh/4Ijcr2Glb/LAtHhn1aj2HARoE
   w==;
X-CSE-ConnectionGUID: C8MlA2mEROeJWWOuyXrg6A==
X-CSE-MsgGUID: 7CMoaMpmTKKMNx9yvNcSXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="66236018"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="66236018"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:51:47 -0700
X-CSE-ConnectionGUID: k2j3Q5YVSuSPqMQRMHDWiQ==
X-CSE-MsgGUID: P5xdBU0PTb6apLTyc/jWQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="181494834"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:51:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 00:51:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 00:51:45 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 00:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NY94f/hwNhUiTiVQz/9CXzjkL8R+MG5oNGPg2lGSxCLjZeF39lQfGIYeFqIL8EcPvpCaopCvQqJ88z3R3atiomx11Mg5esAoQUtqm7zm/6+TJAUfTOiNWeqFP+YeOgyAW/yTHteq7bd34LWA14cFEL8I6iWN5J89jT+3wHxQ8HNX8R8GwdG9q6pPpSmM9Py2zmtECzNxUH/Re1+JBVxxLngpCm0ZlL/pqicijBVbWF/DEsdn92KSI6UmMN3v0yfIcVLYBUtlTqwHHAV4cnFUq6PVxSgitOGzobhW0O5V44jPNl9UfNrQHBHD2qB7xha4eBlMiPDcme+QsuWDV5fpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLSVXdgpATQhDwNb9R3DRpbRB1Iokc9cQC0if0ozv6A=;
 b=EtYnjCUnEjd6P3ELECujtNlx0yJ7fV2iKq6KToZn71do1CY1R0zCxPr8WoB83Gaq24Rwfz3oPjmrHfSnvq3EHX9z0621eSymWysZF4rgdAgDAKLSCMRfHubheFcCKx4EratONaLs3zeBef1eoLcGs9zV0YaCEd4f3BhPwLub4sN4MaA1YAHroATRaW+iRSZ7ni8ceCUlz45uWLUenuUJTqzZKu5HgM/AU2E1SFDf/yzy62tOg9iYLhaMq56B2AgQsYHfLD5LUubMGG5HakOSoe4YQyJbQU8y8J4UeQxrVyE+IWT2RP8bNLpQj4uNfW/UwtktRR5JDwir5yjoJpbuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 07:51:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 07:51:43 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v8 9/9] idpf: generalize
 mailbox API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v8 9/9] idpf: generalize
 mailbox API
Thread-Index: AQHcPJaUMHKkzt/iokKzM+CxZSEc8bTBRYDA
Date: Tue, 14 Oct 2025 07:51:43 +0000
Message-ID: <IA3PR11MB898640AA3C0CCEFF69B44213E5EBA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251013231341.1139603-1-joshua.a.hay@intel.com>
 <20251013231341.1139603-10-joshua.a.hay@intel.com>
In-Reply-To: <20251013231341.1139603-10-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8253:EE_
x-ms-office365-filtering-correlation-id: ac499f89-cb5c-4f40-c935-08de0af68450
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?aO0i2wXcGFfBaoTefuz85E0gxQXUj9ggwRrrTYTi2ObQSVyHCyJy3Ol87f+y?=
 =?us-ascii?Q?RWEqTDq+L6Z7vAGiK7hozsu9yCQgJ8boW0EYMcNxvw2TPjN2fugPG/zB2ef9?=
 =?us-ascii?Q?7PcSYcm0WOankpbpD/S3Cn60YIiHyBO23gIdF/gaxyNSfmlYfXPUQMwhu9zJ?=
 =?us-ascii?Q?gA1l0p1lSp2vP+7Q3izmcOWv55alXcYcl7W0jEP1KGRlxy7wZpZzTfjtkUss?=
 =?us-ascii?Q?KbvPZYimUq8D68ba9xnbFHsAppmi5ZZQVSbVakjhEqPKI9sf3Juh+0fsow9n?=
 =?us-ascii?Q?DrfcNjxIUcjgIx3Ze46/Gl2A6OzD8lmdrQthxYfBRmPxmOe6LuGQYxdbng7r?=
 =?us-ascii?Q?nyIAQ0Iy0rbeMG7Dh5syXeF22yQc1oyrBzvAFAjMwhLdCyf7nVE3xFMnFjvr?=
 =?us-ascii?Q?y9/tyId0ewdcgS1MnTL1J4jQkTGdQSP1CYl4r33o6863PW2iZsK8rTA0qgJF?=
 =?us-ascii?Q?clLI6BnLX5sYyaqaQrxaJdA2/MKfFCHhCdeP2vsVjJdi+bVgdPHf+LzxmnnX?=
 =?us-ascii?Q?p4LiGEzHqMkY1dy8/ptbBFlbQ3EsN9fWzInzFd3aDM5PjGUrVTcPu16dHZn/?=
 =?us-ascii?Q?TbqZX/cF6PVMGTGbYxUBnblB1IqXQn70bfpCdbO+heMiOuWy528V0YjBL4kW?=
 =?us-ascii?Q?Zt4AK2sLT8qZ2WToUryb9Q+Ueow8YOCeYJhyouae/jWoGVEXlZznyy3nRmuG?=
 =?us-ascii?Q?J6h5IsbghS2rKWIJvdkiBbUV4wUQ+3F8lDTC4ND7VSus8LnfuJmSCzphrQio?=
 =?us-ascii?Q?dWLnr5thDMVl+GfREfP/YEPcAITlSLmld6mFYSuS7Am6HXNGSZcEvMUfuPUn?=
 =?us-ascii?Q?TTQKH7Whk4jMiPJCL/7xbYTml/35QbP0kY9M+H7YQuwfC+ElVx5IEQWNkD2r?=
 =?us-ascii?Q?DpHuCltuFjt8eWlb4Gch2cMr7a+0MmQvwJ9dxprl9h9JfL31vD1mIBqXeR5e?=
 =?us-ascii?Q?2qZZXvxdPT24BuRmQmhjLWkdjxJhKzv50x7Loaa5xuzS8eQ9mDy6Wua3RAqh?=
 =?us-ascii?Q?1pL/AvFxPRoy7p/KNxaSqqUv+ELRXPi98RJDE6ozyzzrs6MdGOPUee2QM4x0?=
 =?us-ascii?Q?aRyZh+ikmUmqbKaXiKIT/6HEbR2YLwGwTV1RGWXdYuk9TOUEN3LGoHiWxEQx?=
 =?us-ascii?Q?GKKCun/uT18ya1zcD7yEvdaBX6WnN9CoC9BbK1KTqCUsDTLSP706jUv75n67?=
 =?us-ascii?Q?X59w52xP1TdAhQcXT68RcuodkMRlxDDBN3t327g/UHCzjp5Jk4VLb4n34x+l?=
 =?us-ascii?Q?YWOrmGsYiRynq+Rsp8LrcNg2REPAPMRqeqE23HeiqWEvKn86+dNrzJLiQDiB?=
 =?us-ascii?Q?YEQt4+jX7bttlJ3DgpRSvHCPFwZnX8I4aAb+8FEt5bmrNBm31xIB05i6YzAQ?=
 =?us-ascii?Q?cXOcnkIeFlLGkmxixefqKVjY8w6cbIagK08uXiCSZCSKdMKt3dbPSIqhuk+G?=
 =?us-ascii?Q?yhwKTgiQOVQhAONQMshWtKxjrX8wRlQNQq/082Jon6gBmWv1TIL6wwO937Gr?=
 =?us-ascii?Q?37JlU7tc/tvO2+gkXCYbPUFmCfZvUZi2bqmJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2JhgjNnGeBhZMOswTvT8JOg+bds+LHyAgRpUWMsHacwsXfW5M/LTDLDQMg2H?=
 =?us-ascii?Q?rJtdVy2jZaI+OLt9y7AZ1iph2bPm1ejWDfIPvaB59w63G30f8ng692KxBVWe?=
 =?us-ascii?Q?GXGhwUkxTzpitMafrLrf8rCpNjIZ3GY4ey3ZQV4ojoQdiRUzCjDcXIeLcm6E?=
 =?us-ascii?Q?/CBwxBoxpiQkUOfGl2zDgSgtK12ds9WlQX3nibcAQIoRysIKEks2jmDVIfss?=
 =?us-ascii?Q?v5lf4vTl6tZbVH/5+/zUUnlkdv9NQbeY1FBcyaZryQFEmdpJVdceznJrpEWB?=
 =?us-ascii?Q?hYSRqrwuOCHaVEqYcLB5w93lMjiAWF43vntJ8BAAlc3Rz9GS/lVX0cuQLCpH?=
 =?us-ascii?Q?nxh5UPiL8W1AVUZvYqJ67TxStnnHmFIwuP7IqkbEVJc1kX09eGLNj2kgoJGb?=
 =?us-ascii?Q?mR5Q54IK3E1+ev4lpCx1wp6zDpDmY+ZE2yDFX7DkMX91z5pHxk5YOTRGKtyL?=
 =?us-ascii?Q?gSeks6Gvjiy0nBUJgl1ibPuPlW6IJJGoW07BNnPDBl7h8cbnYJdu9kyEQv2l?=
 =?us-ascii?Q?O3mZqsV37Afx5C5I1jpnemfJhkRE/1dKyeWYjA/raoU/VseXXqOwCTUq1/y/?=
 =?us-ascii?Q?TkYkg/q/7DiqLbrCo76k62l5mkVTcfaqEIPW/WMMRDUB6V/qDGuEAG1KYDvX?=
 =?us-ascii?Q?ZfbuPBL6S6f4ij/LOIQWosR61TH+vPHkfWpq/LFpQv2mRVYmt7HMyURG2uLf?=
 =?us-ascii?Q?my/gSE39Itsgaex5Qw8al2EjW2L6vTuBimS4RsxyoL9mYiA9wU3axLSslvxN?=
 =?us-ascii?Q?PNwv/RxsqpzuZnH2pG4EdV/TldrhVWe0XD3ke4gak/C7PnV8v4lWmbMAIib3?=
 =?us-ascii?Q?5h1t7Pp9gD8f8LPdhozSnZ3yvFJ5Klcs3kjissDVRYISQmKaxcWkMqVEm3QY?=
 =?us-ascii?Q?hkfE3evWALZG881PeHKJvvuRRVeoERCiPdPwaby8Z+T8hZwM/hR0zjzb4tzZ?=
 =?us-ascii?Q?TPKpcosSQGglKxAQcGDYdOwZXGc5xFPxGXrW4rucVFAfA6Kdea162Qf/6Y1e?=
 =?us-ascii?Q?4P1pzp2Xeg3/wtn8PuFUtnN329gVv9qikfLrXIeKd8m7c/DisjjCUc1VrERb?=
 =?us-ascii?Q?0weWN/UDwaolAPPoBD4CjIwJIPb6ZSvVXXtrnEGnyRp1IqXGLNstUKOubc3Z?=
 =?us-ascii?Q?1nyb2ryoI5CAo+QWTdebtlgCWYndh3yRzVq386j5LDB1Ttt8PxI0PdiOaBT7?=
 =?us-ascii?Q?bKYpislUnbv3n1IEXbH3BiD1PbRNqe8b9+F/gf62W97RpjQsNYuCa8uHT9/e?=
 =?us-ascii?Q?HsO+eKuIibDJPSc4k2EZbU9ZPUwOCb7usx0NinrO6w07JkPi3UcMwChMF4oR?=
 =?us-ascii?Q?BVlYoLo9W01iFpvgooOxHTZY9Wca2hUkVcf1a9h9qqVF1BR1bYY8nP41/WWE?=
 =?us-ascii?Q?YkEF1s2XxgROcjWwTw3NgODEwPV7Q5qSa5sQaqvOkroHs9HU62pulCht4BAa?=
 =?us-ascii?Q?Xekr8pcblDIkNdpxSrSyaZ1F3LV0EQgG3zPvQf1mB7Qbuh7CPOS8fmAfpu21?=
 =?us-ascii?Q?8yQkQlHTeCWT59aS8fDikC5bIYKAYJrpUY3uN8+E641EVFSp28VeVQYfTZo1?=
 =?us-ascii?Q?R92P/1UrUR6aECjmDVliq+2U1PefQDstLBBaePcbixG92x9bRSKslTfh4qkh?=
 =?us-ascii?Q?zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac499f89-cb5c-4f40-c935-08de0af68450
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 07:51:43.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKo5Omp/3woBVnSVl13JI+LxsM0TKoM2d4BIXIRrm9wV8qnTrfegn9Y+HRxmM78e9k7kFexi3LXEFU7YrZdpNduPSPSzIJk2dgkQdcVJ0d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Joshua Hay
> Sent: Tuesday, October 14, 2025 1:14 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v8 9/9] idpf: generalize
> mailbox API
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Add a control queue parameter to all mailbox APIs in order to make use
> of those APIs for non-default mailbox as well.
>=20
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---
...
> --
> 2.39.2

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


