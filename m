Return-Path: <netdev+bounces-258636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bYbhGzxLj2nnPgEAu9opvQ
	(envelope-from <netdev+bounces-258636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:03:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B36137CAA
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA9A430072AA
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A149247295;
	Fri, 13 Feb 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+p/PcaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E763230270
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998578; cv=fail; b=aNZkxg6HD2nSarSGti7irB+EWqM/1TJJxpq8zzb3WocKjd9kwusBZwGP/yZ3VDWHJqjQRdTeg0EGZjBuFf5GsLdUImcnpznTssUkswy4QJVgFkn0e2Lg9HwKCfbrjsZoFm0Vgaz0+u4HmWdpSYHjxnrWiA+Iwn4sYPKs9DEJiuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998578; c=relaxed/simple;
	bh=5Y/9UJe/fd8PoVcfOZJDt2yogoL0pFCyuWs5ZMWmTsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EImgVVtENjSTox+LCJ2O0vrB1cX48by9lrAGuXUECHIA/5QS3C4sf72ecAU6GyqX4LEjJwnbViNahJRNgc3oZd5iy+2FbFobiQM/dZLm7UEJYlzPMS75HRGRVTw4HoQOdAmmqppJEQY/3g9Pd+bSIktwwoKLqPgXHNf65voBf70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+p/PcaQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770998577; x=1802534577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Y/9UJe/fd8PoVcfOZJDt2yogoL0pFCyuWs5ZMWmTsM=;
  b=Y+p/PcaQDAGLXpzySsVLP4IJEC+RW43L9r2eSJNdNlnHKfNjvZGc+cxh
   Ic9aY3rXkxnz4WTGLy0Aamb0ssmJv8ciDbyqtiRPjIxESLGlH+XyxO6GF
   vGuCPL7bVhvcyMpxch2HdvRfCCqJgfHkUuMIrgwCclKJwltQh7Mb64+zW
   6D+JkNXlPhz6zFDtGsn/Y5cRnmSxArolP4ouVCuMrQLSQqSdwpZ+LpE+I
   3dBCDRDHnIjWZmjmwaYBm8Jz5ieVvzeBGJUBby0iqAOauPc+HHpj/8Sk5
   s1xYVVgU8y+AA74fyymGvlJdLQhUhqE1ROoIPiKUIwi24gGSU9NJ8OpOV
   w==;
X-CSE-ConnectionGUID: kfgDMYkZSiCR5yV66ewEQQ==
X-CSE-MsgGUID: 5mIpXLypRk+OQAwn5awHdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72087258"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="72087258"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 08:02:56 -0800
X-CSE-ConnectionGUID: Pmx1D46vQ7S2G/miw3oWIg==
X-CSE-MsgGUID: mJeRZmsAS2GyLH2gn5Dohg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="211648689"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 08:02:56 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 08:02:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 08:02:55 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 08:02:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vq4KcnUzxy3yAJ3f97VavguZHe7sHAYdlBMwQ2lT3PSH5rHnJDhp8Q/u6MxKF8iPUR2TLQ+pXrmDIJuD5DvcnnFTVwenafzT/U+daTWtKqn6Mb2tC6O4hrWARJAL5WHRIWRXEmsqjbrOQOI5Zn9jwNqVZKBzzZabqjh6Y5ycZmMtvL8+jgqM76G+F3J14LMWE1LWvg5yb+eIBQrL2WbVYSXdd+Ym/DgUJTAJ9a37I11M8SFrYkxs94GcqUfGmZmTIZyrvMFhMGjRWSyX2BD0UMW+hVLNQ8z3LkJD0IBTej8nrQdxe48QsCBFbWIXT9je5XuiXclAH7E9D1YEld51YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOnSPWwHNrFku2qjNajSGD+5uP6cbi+omXeRNR0exxg=;
 b=iwpTKmOllv//jXqqrsHLtHihmtaQjsLQ68/UJcLUxxBIWzsqR/ieLczz6qBJXqqfaWKgplEvfm7RY2UtVN8uHSby4gLzK6FP15ZAVqZvRzJ3h8nEH+QB1jgIrCCDOtE4T1NqLomtYQOfm3uOD5bJBxBHN89w1+gNhXn8W0VfcrBX7bYZEzqyQ/RRfbc9ea9xxskOwsQxN6ldSh8jYH7M1sIXN8J/0FhkdqCiG3sVjDanyP2nCJ28TJ6GkJxQVohSofovx5Iel/Qenl7zY1AwI8BZh0zRYPOvjXCX9Bldhc5yXRyUcjVG2aAdfUmRkCttaiuEnYtJbQd46xV3RbNEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB9486.namprd11.prod.outlook.com (2603:10b6:806:47f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 16:02:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 16:02:53 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [iwl-next,v3] ixgbe: fix unaligned u32 access in
 ixgbe_update_flash_X550()
Thread-Topic: [iwl-next,v3] ixgbe: fix unaligned u32 access in
 ixgbe_update_flash_X550()
Thread-Index: AQHcnPtoNyc9XcGmuEO09Vs+ex3fYLWAyiWQ
Date: Fri, 13 Feb 2026 16:02:53 +0000
Message-ID: <IA3PR11MB89860CF09BBD00129F59A4FFE561A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
 <20260213151344.2513857-1-horms@kernel.org>
In-Reply-To: <20260213151344.2513857-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB9486:EE_
x-ms-office365-filtering-correlation-id: 00303878-a985-49f1-c00b-08de6b1958a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?gH6a2xpZG/TjofeYKD5vnQmauNsfD5Q2qqI7H8kbVjWBl7E0hOBktGH4/t3C?=
 =?us-ascii?Q?O7Q8Z6gv8011rYGHhM0mxazu20U51G5DXcN75RuGNbHyygXtwnWsRF9A17IE?=
 =?us-ascii?Q?WSwPGAfVpIz6VXwQRR8d/DrGFNKQ7tcRFQ0iSP7EuCGJrmFTgKI0mhbtG4Qr?=
 =?us-ascii?Q?XGmpNYDNTXbFm5xIbRqxOa7a9GWNiCWXLKJaHfoJuFbuABLPRJq+tPD15Oxd?=
 =?us-ascii?Q?kDBm3vN5D8Z4ZKTfosOKDMU2PNnm7Sz5X5XxHECzNPQ4YEvr92SPMsmdAm/j?=
 =?us-ascii?Q?1c/UYIcoLbhDaKx2i4PvhN/ZEc/Hgub5a8jQNZPoR71cIlcZ48LQQ8z91Qkn?=
 =?us-ascii?Q?a2NbI6HcocmNU3IBaI//FlQLCxWo5duqNMDoW7Cv3HN2ScjjzvrdG2EnNzzH?=
 =?us-ascii?Q?vGaHzFviE1kb7NSwzsH2bKW5xeEumdj1CLSSibfxwzuaqbSq3CEtxecV1MF3?=
 =?us-ascii?Q?BfPzm4iS3t9n3Gueo4vOGXbgSLdUbIs/CKZBxOo9UJz4CvpSzgQwsf/uSVSg?=
 =?us-ascii?Q?rzGPLO63Q2Se3S0NbF8N8GhoD8irG6rkXkdzO+yCoz5EsU+2t3tw9KZ/mS79?=
 =?us-ascii?Q?JNbW3BbYzLGKD6dVQxZR7G3vuQrrlboMQR5Yb+2hD/JSI17YAPVtw4ljqkUO?=
 =?us-ascii?Q?0WhnTsA6bJANydEgTuDHtNVYQtc6qO5Atgqtl16WVLmsG+jWRAj1y3JKJaz2?=
 =?us-ascii?Q?yS1Gqv1pm9ZCAPHSVZAMaRlIxwErf3pxQi/5Wf7vLAAAMtQ2MIidHrQeD45L?=
 =?us-ascii?Q?seoUvd7yRmpgOH2VN8KVJbQkZL57/k+5r5GjZaOdwpy0M+nNnlgYjz2dgjnH?=
 =?us-ascii?Q?7zzseE7NBnZNjKv+bQDFhTBbRqtmVHwicG1RkeWWvub2qpSeihEex5D24jQV?=
 =?us-ascii?Q?gE5RlMus2Rx8kQPyUVVi9QaYDMFN6bsd7PC4MNxtlJWF3uNPDWoh8CvnyHPx?=
 =?us-ascii?Q?av5uHWJl0FN2GBu40bCB8k6I7tAbOaSBSUqQ76zP4V9uO+151ITUoiFUQ6Jh?=
 =?us-ascii?Q?ov0PdlmikXe42igOQC3CnosjgjOPo46H8vyVjRongzBmmPWDKn1tDROuyXNS?=
 =?us-ascii?Q?/fkbnYylJSMvy67sZkyPb24SnSnrKXkkT6fZdvx1qLzuxZ67eCqUEnUvthO9?=
 =?us-ascii?Q?//vuGip5Mou8z/+KwiX65Jq87pkDvVU+/WiNHj8DoMAv38O20MgrOcBtE+Kq?=
 =?us-ascii?Q?8VvtWGjs4FnVqS/dK4+V0PwbL6weCpGd1GbbP/dTyBMM5SfyaHZ9J7y4VZlO?=
 =?us-ascii?Q?vEjrrJjz/9eZMAj/O+fG2XMbqSwx7/Y5XQJzNC3W4H3/E+6vA3wzXQAod/9z?=
 =?us-ascii?Q?HEAeW7eMrWsMcfXzsIAb4oc0OAh56HKzJk/jmzFWKAGydSTkqu3KfNyQfWK4?=
 =?us-ascii?Q?lekptUKV1rvFKPPsOTmb0Zv5ub4Aif+LUqaGtqLq1V8nYOapXXdvzTgk4V4G?=
 =?us-ascii?Q?ldu31xdlxpzNUr0x/tfQCApXK8qM7QBgk/70KdKKKHdXTCq1gsfVW0RwQrgE?=
 =?us-ascii?Q?Gaik5/H8nT6NdXccjZDCQAW4OFxy3c/TUJCACVPtZM9NWxAF9rtWXajU6ib3?=
 =?us-ascii?Q?8SeN2QNCFuPFpGbRU/5D2KnozHvsp4MDYLdEeOzL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UtZ3bGtxQyqVxoARNPT3sfNvaplM9MQ3v1QIQpyyKD974cPQefcMpJlHHM+U?=
 =?us-ascii?Q?9wQISV1tBHQfqW+2lGcIUcCz3xJNT1i/xfYrD/acfggZNYWjarGFzJVtZfbH?=
 =?us-ascii?Q?e75WClnvEts5Ezqld61KzSNzYFFfXgiFtgibV7mHuikG3W8k8zXJSDCQU80d?=
 =?us-ascii?Q?AxbdpzkIN3rbZ1JwMzCgBeuaJypp/FFC9zGoD8X32dCLYpGyH9JH4uLGIPKZ?=
 =?us-ascii?Q?3e+ELSIx6U25+wl5mHvq9dDGx2YOcfUvwGzcorCSkfX2uTu7JUZQZQWxbb6h?=
 =?us-ascii?Q?UR3QpVoxaaKnYdO+LF2D59gkL3MRlG6qM65JAbUpWik83rh8H9MHgn48k0yB?=
 =?us-ascii?Q?FEXrTlVG0BwgoBteqOM5noO40DpwwbpMvOu2TGn+PpkxUEjRoMNG40nakjIX?=
 =?us-ascii?Q?78bx21hpagE66X4G22R66+Q/DXiPFbP3x0X6/8mhYWeC621Ie5NQMGZXJrmE?=
 =?us-ascii?Q?gzTJXy3+PNLXhEeao0Qe9beuMCVDIK0/fPExDO0WnAtWGwMPJEF+34yeJDSb?=
 =?us-ascii?Q?r6KO2rk0ZZF3IsWp9QTg7znOlxf8psCUNkcxuwNLF/Cr57s6O+/GujtDyilU?=
 =?us-ascii?Q?djQEyURqHcbZyythqlhzQcgA1n5f+b/X2ZP1QvZil3Tit6oMSm9D1PmTqyLu?=
 =?us-ascii?Q?iF8HKTGZX+oo+7npfaYn+U1mkykB0//T4GOtGM0fZxAyf4nIZvD2bQZKYri9?=
 =?us-ascii?Q?WsFy7SoRy26XR79uAZn7f77GwhO13yQSBiaNFTtrTGtqvOI2Ao2ereo5jwK8?=
 =?us-ascii?Q?Br7ChwJ/8FfQACXf7rCHqApBClfyIsEFgFDLDNethl5TYedwKWStFirf/8IR?=
 =?us-ascii?Q?CP2MQL+UTvkNVOo9O4n1zVCK83zpG+Q7KH1AWSIFATsmpLEq8tQJOW+CGr7R?=
 =?us-ascii?Q?yFqKuYsIpFQBeu892nHfjAgOIbQPKgkhs1+imT6nBNfoJhJ37P+rL/j+JxZY?=
 =?us-ascii?Q?yfvWkPoyGACOaL4jcFAorIpShYhAPwMgJ287sOMe8Cr2ry6IZXp/ASZyo83n?=
 =?us-ascii?Q?PAe9Lq51QpP53eVFqe+cMrVYX/dhCVvpNzMv3OHulz+hCZYFYcPbFryYQR8l?=
 =?us-ascii?Q?iW1BAwEdkmyhFobpfHaPn8hDjfdn5ltJsuO7qxQWr1Ciq/qYKY0NXbs9dx83?=
 =?us-ascii?Q?HbjJuI/+K6AHTZyzALg6mf8tv4VCb1xGvwv+FBHFIzN3c+prc5fK+5xqIBO6?=
 =?us-ascii?Q?XaC/0/ShkxmTqU79pgl3o+u1h/TNruu4IhHiZzT2dlO4rsbamKsLsVOvTHXA?=
 =?us-ascii?Q?oD4bMVwQ0/7JOumgoKFox5510N46EHoX4asIqq2STnB1gqgPgD3JhzZyc6F3?=
 =?us-ascii?Q?lfgyXnd0pzEOGplLL0M8Zo0khTkWaHyWmTWl7lO6X4dfjn6hHzxnhSRUsEyX?=
 =?us-ascii?Q?laiEU1Wi52cU/NHSr2s1MXTDVAKNQgl0FnaUQwa9+fvn2lQkKszZviaRgftj?=
 =?us-ascii?Q?l09mUvLk/Vy9iiEkqap0VQ9FtawJ2fRczJIb92rYXQz6+sGY0mb6jtv0ymn8?=
 =?us-ascii?Q?mD3xA0ApQQiQOLttkAhqVGqaln/5JXfynlgmFpYqvuW6B5Afs4Rw/pvRdDsk?=
 =?us-ascii?Q?6XQPtN74sjxTlMdfxcRlsCXi5sBdYQIA4+ua1feToY+tfkVx/sEQP8xVRaHQ?=
 =?us-ascii?Q?GLg5J3r6bh6mP5YgDBH4ZYm3Ex43k5rj5iRhZMiC8R8Kyq2PtCTTCB4TeEl/?=
 =?us-ascii?Q?zPTXOo4k3qJjRjd/VtEHzmQdGqsHwkm2NGjIWXSf+jFiGoVxzMFWOcXOwPp7?=
 =?us-ascii?Q?JadYTfcGMQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00303878-a985-49f1-c00b-08de6b1958a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 16:02:53.8889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwLF0EMSlea2wHpb0C0ILP3rrSPKOu1rLy9yyZnci52uPRTA2F0T/yZVKwCSuPrjbH6D/YILd13nl1rlwdZ1m4gj4pD/ScPzl3kR+JPqiOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9486
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258636-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linux.dev:server fail];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,linux.dev:url,osuosl.org:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A5B36137CAA
X-Rspamd-Action: no action



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, February 13, 2026 4:14 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Simon Horman <horms@kernel.org>; intel-wired-lan@lists.osuosl.org;
> Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pmenzel@molgen.mpg.de;
> netdev@vger.kernel.org
> Subject: Re: [iwl-next,v3] ixgbe: fix unaligned u32 access in
> ixgbe_update_flash_X550()
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-
> local.html
> ---
> ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
>=20
> This commit adds a u32 member to union ixgbe_hic_hdr2 to ensure 4-byte
> alignment on the stack, preventing unaligned 32-bit accesses when
> ixgbe_host_interface_command() treats the buffer as a u32 array.
>=20
> > ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
> >
> > ixgbe_host_interface_command() treats its buffer as a u32 array. The
> > local buffer we pass in was a union of byte-sized fields, which
> gives
> > it 1-byte alignment on the stack. On strict-align architectures this
> > can cause unaligned 32-bit accesses.
> >
> > Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte
> > aligned, and pass the u32 member when calling
> > ixgbe_host_interface_command().
> >
> > No functional change on x86; prevents unaligned accesses on
> > architectures that enforce natural alignment.
> >
> > Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
>=20
> Does this Fixes tag point to the correct commit? The alignment issue
> appears to have been introduced by commit 6a14ee0cfb19 ("ixgbe: Add
> X550 support function pointers") from 2014-12-05, which introduced
> both the union ixgbe_hic_hdr2 without a u32 member for proper
> alignment and the
> ixgbe_update_flash_X550() function that passes this buffer to
> ixgbe_host_interface_command().

Commit is correct, please configure your AI to look all the history of the =
patch, where I explained that it was a 0 day issue.

With the best regards
Alex

>=20
> Commit 49425dfc7451 from 2016-04-01 only added support for the
> x550em_a MAC type and did not introduce the alignment bug.
>=20
> Should the Fixes tag be:
> Fixes: 6a14ee0cfb19 ("ixgbe: Add X550 support function pointers")
>=20
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > index 61f2ef67defd..eb5bf3b6bbb5 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > @@ -2798,6 +2798,7 @@ struct ixgbe_hic_hdr2_rsp {  };
> >
> >  union ixgbe_hic_hdr2 {
> > +	u32 buf[1];
> >  	struct ixgbe_hic_hdr2_req req;
> >  	struct ixgbe_hic_hdr2_rsp rsp;
> >  };
>=20
> [ ... ]

