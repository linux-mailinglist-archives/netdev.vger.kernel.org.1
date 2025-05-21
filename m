Return-Path: <netdev+bounces-192179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB9ABEC70
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71244E10CD
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9802B234966;
	Wed, 21 May 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr/XYvRJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18122B8C3
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747810073; cv=fail; b=q8xhmtDG09kZ9+tD6kWn9f3jrSOjQDGeDmsoxQsEEiU7p9zVnjR3dQo4py+wMbFobtLCYB0kOWy8xAJ1iF5bkjlq4x8pYgyyKAHb9YvNUw+rxnPZajOlKqQgQJbonnmNR6gaiihX6i4AOi58kpsvUM0vbPKZ910eC4dNg9pSCd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747810073; c=relaxed/simple;
	bh=LGTYNc/8kgJyJJyKXNhagMVHZmwW04LVkChxdRlR/pc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K9Cyn6oOGKKJ6k40oIp5J1PZFUj8Rx+PPUyuLrERgB6uQzANNuTXDqrxbhDhRer5Km5hPPBQc/LLKBivkradL40U7YAMB7CX9sx+z5ak8m5u3+MDJDq5lnwkAr2quH5s8HR3G8mF5Tha5SUXOvWbzykYNEIRRfUbeQ7fWM71CQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr/XYvRJ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747810072; x=1779346072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LGTYNc/8kgJyJJyKXNhagMVHZmwW04LVkChxdRlR/pc=;
  b=Mr/XYvRJEqOW7HhJXY/e14mIsjJY7F2WzkQfIGEZYC60jESqq+zMKjrG
   uCCVENSUPTZJ6hmpJ++ws/K5eEWMBBos11H0D9f98G9lft/dF4cYTvans
   JSVdpff9wkLx3Jo47CcNJiniiT5jEJNmf7lROENXev5ZShplwXs8gEk9P
   gxP0FMR4rTMbm4Ir9dVf4BCT7wZxqDWyXH5aaiVIsRJYvqpZUVQmIGc+M
   B3HYuOpl2W8sItHE1TsCTMGVYykd6kHQKDDbW7+5V+74rYKqSQHdXzsUJ
   IG9BbRFBPVprLxDYtc645cZGnDLOGp1r24bgtyrU047KxtPM+lgPhu397
   Q==;
X-CSE-ConnectionGUID: 590mgl3MQI+5Z9wU2ZHeqA==
X-CSE-MsgGUID: 1Sf4QBXjTOCElWqJESSv+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60001634"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="60001634"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 23:47:51 -0700
X-CSE-ConnectionGUID: qZ9d2jhwTTe3AAKTh/ROdg==
X-CSE-MsgGUID: wUCMOMmvQGuuVi5w4C3TXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="144912823"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 23:47:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 23:47:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 23:47:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 23:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEohcFdtekJ+U1IxxO2W79zaR5xWs/ZwJZsSdh/c3Mf9Lp7iDxXeiA5bhd1sy5lvELXdsEwd8VrXk1yZ+qLyHE6/xEezmzupJuQKpiA+Ce1AquHQexPqSyhw0otYWcPXYQm1iOSZkgV2y3qGbPfG7NgG/QAPAXL572mGsB2XMtwXOEVPGkbz2TyKzXa8WNSQHmBLjxU9gjFyDof2os1TQtoaoMGNARD2/Ia/Yk9m/V7HaqdanI3QLOEas2bp+/9mTH9vUsGGYZ3QhrFzdL+IhKKRmt+XymYIPIpUHKUHgKQS1VqcBF0MZy3NI3FTTRCl8G/ktSp3MrXEB0s4yHGqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+osmKzbGM9w8gRn1Y+q3vLcTBlPZIoih51oPtxSXFRI=;
 b=jtF+WjWXIqndFVdzdKF7U6+4H9RPAcd7HNAAkHm3amVg2fZcuoQiY/iSpi/xC6W+mnuV6uyyvU6yscqlPsZlx7ig8iCAqbhU1a9Am0IJwUY732JYPPpxBvd9yCdhjvXFGcQvspl0cUuqFCnXvBsW14ss6qddN00CHxmngfvgJwQTqUy52GQ3j3xbXZiGY6a7d1TQhwlURFXxHtr8EAOkVu56TtB+KoRbyx+EiBE/dyvM74ZpRBHw+h803jgl/e9qyJR+UtdQXUhXEVdLd38EaynGly9x4LB5uT4ipLC8/j/LqBC7owikwhfSD5ywR1PnpD0g/rNDwjvytVN2BNdLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DM6PR11MB4529.namprd11.prod.outlook.com (2603:10b6:5:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:47:21 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 06:47:20 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v3 2/8] ixgbe: use libie adminq
 descriptors
Thread-Topic: [Intel-wired-lan] [iwl-next v3 2/8] ixgbe: use libie adminq
 descriptors
Thread-Index: AQHbtah/eHTdEtJ2uE+H1KKLk9lMILPcyOHA
Date: Wed, 21 May 2025 06:47:20 +0000
Message-ID: <IA1PR11MB6241001EC6DCA263453FE1288B9EA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250425060809.3966772-1-michal.swiatkowski@linux.intel.com>
 <20250425060809.3966772-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250425060809.3966772-3-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DM6PR11MB4529:EE_
x-ms-office365-filtering-correlation-id: b7366924-68fb-46a8-dae2-08dd983355ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wHVeKPP46xP1SuqmqSwkHu8Z5Xd6YQBAq2Y4y8zQp7n0JBRrByBTLztfCTsj?=
 =?us-ascii?Q?5rpM02/ROTVYBYXMh+fWr5cEhC/ZOfIu7bKmznAVMFZWQRLryDSTrUpK0P5m?=
 =?us-ascii?Q?h+nYPNawVGWTYCxiF5GbMKL4+dvkMFAbINSuabV39OktUSY5E4816zfktXvL?=
 =?us-ascii?Q?kt1IsYzByu0uQjbRg20OXz8MJPdaDmhrmHZSVh6pfRS1r7R1AbaV3GEx8ve0?=
 =?us-ascii?Q?FtBLAnqRgOgmXSXN8/QlFYW7HJzlFX99mvWm0SUYpTjxzjQkh47se8rSlXOG?=
 =?us-ascii?Q?JgMdQhvD9URcebhP5Wp/eFcvs/enirDVI7Flkqo4fqzVsQc/cw1LyURg4zNX?=
 =?us-ascii?Q?L9ieBB0WZ+jWODdkogl9eewcPnr+g9UX1QxU5qqp1kfVwwYag20sbapukgXA?=
 =?us-ascii?Q?Y9mlbPhQNQTNdOsGtToPdfAGS2270WANATb04YxBv7otNGgCpKpX0lutKa2i?=
 =?us-ascii?Q?u/ynfY8yBjxMc4eEQmYCeGqQC47hVt01Lo7uGKMgu+cvKE5v+MDckmOEL8nh?=
 =?us-ascii?Q?bOuSIFeTElP/MVeWxYY04zGqUN1W6Gkj1PRDKoCKMo8w7GXXkYsWghZuc/8V?=
 =?us-ascii?Q?XTw8sXGQyedDLsRwxGvXiNTOySDi8rjxszkF7zWtGegW2DyNEu4WK0VDG77/?=
 =?us-ascii?Q?GNaefCCIZ9URXUKbyef5OLLo+Ftyel+kBFgKD02wIfEfWnmfBW+RypFigvco?=
 =?us-ascii?Q?N3hAsRKxwYWVTmesiLuuUjDqr68oA9YWNDqO6Jcy67HbKF2u5ahNFNwauEpM?=
 =?us-ascii?Q?LuJkOHEPFFEfMSCUD3Fe1LgyRVqpaP2uLn0sSJxKqdWGzgi2CLKzOsJx/7VM?=
 =?us-ascii?Q?hBgplw9NpiyK16x5YZ8mNyEl+vM0k10EDZ2Blsx7BQGnDOQXOAtUlnCzq9k/?=
 =?us-ascii?Q?ikjH8CbhXsIDnLVt5QNRcE02E7YrILRgjHF85aUGZEc8ifC9DwuDGKNki+M9?=
 =?us-ascii?Q?3dUfAp3lulBFhgt+rZJa0ViF0FtsvWei8t7tMOnNxcIJ1pxPxNvj+HhlyujO?=
 =?us-ascii?Q?00zNDsuy0yNC4VG6fnFGLzUaxF8pDtp4bW5R13vlvtAy5W8jX2DOxkaKt0In?=
 =?us-ascii?Q?2LBwHV8jrF4KF8oam84qVSOcK7wmBR6PDtBXc+M1M9SxENUt0Vgmw5HM4fDC?=
 =?us-ascii?Q?1gNtQ9glXkqokDpnCm+W0HHKq+NBWBw6dNZGA3ngU0Mrm9IO4Ge7zcEcCgDs?=
 =?us-ascii?Q?klqJvKTfK/cs1TQqSDsFjp9aIA6uAvlfwT29BtQENF/ejOdugu+H3NSZMCiM?=
 =?us-ascii?Q?7oNZZMXmopyNAJxsJVTHnZDBf/hmEfXPua0GZMgzPxGSST8VRLomTYVr4T90?=
 =?us-ascii?Q?4aTuJ6PeyZtNvFS6LUwz3PdMFuMsqrF/UOrfbl9nD5eRG9fonfsPAhFG/xPD?=
 =?us-ascii?Q?Wrlr/usjKV7E06Hc4gEFZGYPEOuhCeZHqLQYA0jLJa5gtL7ze9nfbstLCvN2?=
 =?us-ascii?Q?PAGqfPA0OXFnmcz8TxafblNQosM7alzJflGXDVTQTg718DlMicZFnYeNrv2V?=
 =?us-ascii?Q?jBNZpWOhWcFjt4I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZnI9Rgw3jUYeCcaGGJ2hZqrrgva1U2lz01GJQGvLWK0rNsqEsJuKHmcnlZTu?=
 =?us-ascii?Q?L/Y/zPrXoM2ZmA5zTl8tHtp0gEaGKU7xOrS6U4teBG9USius3C2zTXIE+RdN?=
 =?us-ascii?Q?NB92uT7sQdqRfd0I7/NVMBqTcJlTATTee/bAPqHCJvxL4UAO2hBe5lBrz0HG?=
 =?us-ascii?Q?P7hP5JDKH3nPSjz4F32BW4g97VkDFXq2idf5dKW8q6iTYIrC2urZ2xPQPolX?=
 =?us-ascii?Q?2roMm6ov9/xIGDo6aU5DN8yE4qBNXt3GhE8ZryDRtJrk1Scf1Cp0CmXSM8qg?=
 =?us-ascii?Q?0RdrKVvuflvbxXioSTIsS6jYUtOmqG1E0dBUnZPAeHAO9K5JfNboRbPk3XSj?=
 =?us-ascii?Q?98PQYIIuVOKEhT6tpKE2epKdoKZbdZi+zf8XxPl0VlfSO62L9J5y5bodonZg?=
 =?us-ascii?Q?Z6CaR4fY+H5LdU2vzHbgGYRxXeWL2cwwnFb1z+x2po7e1kSShEH8ssnBwB85?=
 =?us-ascii?Q?7MQj4CyV+W3UY6Pcacx9Cpu/dE3mxM84fXb8lDFKRYUA0AnXMsEqoXo/fdU6?=
 =?us-ascii?Q?lPUL9QUO4I0yiTAshQ2QLCczXaU4mWE4pfs+B/IB4IoJSoI6lSxy9CIt4IRN?=
 =?us-ascii?Q?jLa+B8g/0HLIknMKUB4XT4A/I8ns1v9PzTBVRicahq0rdrCdJyh1w7FmrgN9?=
 =?us-ascii?Q?9b6doKdaPoN/RllkFyTJibExV0sltWNa9usu/hkb5UngK5q+M2l2skjCgIsu?=
 =?us-ascii?Q?jwt+WjGTIXcfuZWZcQEc7ytroM4lAnTlJOgeMUuINPSOqeAiSYyx30rOwQY+?=
 =?us-ascii?Q?rIDd0j3++Do3VoDa3Lj+rXe0swskK7ammbEqMrGsqt4+HyTqZdQqzJKLF+8D?=
 =?us-ascii?Q?gNmusddatjDpPiy/Mc1r7JtebInDcB7o1YKXA1O88CmsydgXwM1faN80m0pc?=
 =?us-ascii?Q?QANtA3lVnqtuaFz9rw4LLXA/Jbw3oLkWSeifpGAsvLGf4jrDJ1IDGjmn98rk?=
 =?us-ascii?Q?RWaPKLCiZlPdVOORc7MptVzaT56k5zGZQdAg5pFypcXLdANJz2fiXxfxeLWn?=
 =?us-ascii?Q?GZDNgGVgutk0U4KkKZccCRSaLY9PiyER8ffmj98+tuCr6/tv/P4MmIJAiaqq?=
 =?us-ascii?Q?xAxHfRGngoC7nXYL6mnoA8DjTaIt8ioY7eo+KU++KY0jlwYQHKpvPF2SDLno?=
 =?us-ascii?Q?KomPs5l83hmIh6pP2XI5IEaDnECTmopUl5FJCCAJ167ZEvBmJnZ8UhF0W/s0?=
 =?us-ascii?Q?UHdgr9+ozrOLeby1jFRwoAobo3XCGzvsTbhh1VMdlMxl+rJslO7QTusOPI1M?=
 =?us-ascii?Q?sinW07H98TLwt9KQpyHZd5oXU6QooJE7NGkt6bZns9TnB9H1g+5yNedLp22m?=
 =?us-ascii?Q?vm/h4dtL3o6eF4nSw0UmjnvA3qJrk6MiJTKugv11tFlYBjaO2LGuUiROnfHX?=
 =?us-ascii?Q?lUeZ2ANxiV9b/MEBg+IJFU8uo86PObqi8ig2z4yE2i7HVXM4E6WRi8TNogty?=
 =?us-ascii?Q?m/paLib38xzsNNMsDiVmk+fee0ae41s8/Lq/JcIm4fzTTSE2vRbFhoaK8z0s?=
 =?us-ascii?Q?K5HNriswGFfGHeilDtLsaJHImijCrDOuAxprOG+uzf57F1P44qW3nHNYlFlN?=
 =?us-ascii?Q?s+BHZzoYiRuz8IvEjF2U9Bz7nOzMdpcY5HKil5FV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7366924-68fb-46a8-dae2-08dd983355ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 06:47:20.8290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aT5LFkBO3o3qRGhmpIyWJNYSAAkdS3p79ypp1iUM2SX/USxTNLblGBlfIMSXC5IF/CBl+PxuoH+sxzLvQXC5iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4529
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: 25 April 2025 11:38
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander <aleksander.lobakin@intel=
.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Kwapulinski, Pio=
tr <piotr.kwapulinski@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov=
@intel.com>; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Zaremba, Lar=
ysa <larysa.zaremba@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.c=
om>
> Subject: [Intel-wired-lan] [iwl-next v3 2/8] ixgbe: use libie adminq desc=
riptors
>
> Use libie_aq_desc instead of ixgbe_aci_desc. Do needed changes to allow c=
lean build.
>
> Move additional caps used in ixgbe to libie.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  12 +-
> .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 226 +--------------
> include/linux/net/intel/libie/adminq.h        |  16 ++
> .../net/ethernet/intel/ixgbe/devlink/region.c |   4 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 272 +++++++++---------
> .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |   4 +-
> 6 files changed, 167 insertions(+), 367 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)


