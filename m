Return-Path: <netdev+bounces-197485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C324AD8C3A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88C6189B4B0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E94C6E;
	Fri, 13 Jun 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsGoHrUk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969C746E;
	Fri, 13 Jun 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818049; cv=fail; b=shV18fV578+Oot9i3qBkMJavJsDa1pDk6XgnO2TlRq4d2hV8vVPLVwo5pqBAdTkF4vqBoaNRuqLh/MRTihbYSHEToKzIoElTeLWRf3YHlwdNjsEaLuxUsatAEnPDa46cDP6eWLBA/N3/8qA6cDSH+FOlLZ7yemZm7/9pAmjbsyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818049; c=relaxed/simple;
	bh=mjlkkdjQMGb983S9q4oWMbNKobmjArTIMfv1JwoRGUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dnShNb8pthlHpqLDkw1NYRQxOxyfHQWUKpbOKK43N0zWXmnyTKUuU17d14YBqGgIEkYVh11V5vUXS80E4/To5dN3PbeF29Onmc2aVdd8666Q0KDVTJaTeOWz+FUOhGmkTf4ZBDoOuYFgC7e56KeB9MD8YbRqyWnC+yKdqJgyVgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsGoHrUk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749818047; x=1781354047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mjlkkdjQMGb983S9q4oWMbNKobmjArTIMfv1JwoRGUY=;
  b=WsGoHrUkzVXRQmjPrtmB1FyMEouilr1iAJPT6QkEKtZnmok+IbMMt9ZO
   Xy+4rj5CgquYGfRO9/rxmaUZGhUgxswjnHfT5YD5E+YztsUvGwkzYNRfw
   1vTddnnXogF7PZ9BsGmRSy2tCektdrSsuPMjx4ME1GEy0tZ7QnUwQLQmJ
   N+ZSn+YG8W5vuoP5tNKB4TF2lORueZVV0gr47BJgNbH0xmCPOpyS02mEg
   mPdyupzi6vxosgEBdzl7+yXDag21uXUZIqI8Ym0pG0i+2ZlAqrFqAoAEu
   vhMGs60yeR8a7reEjkCFlQBTUa4yGAX/ilx+z1PeYA22qXh1cUIBMCeCS
   w==;
X-CSE-ConnectionGUID: INKP1LdHTn6XqDFS1Oqa7Q==
X-CSE-MsgGUID: xc8q7Q76Q/SXXbs7uqGkpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="62642826"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="62642826"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:34:07 -0700
X-CSE-ConnectionGUID: 2yvJXGX7Tjyy9TfrM73Vcg==
X-CSE-MsgGUID: qLXA1Lr3TJe2SEdsjYaUmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="147667853"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:34:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 05:34:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 05:34:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 05:34:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ST7Am7IlSH9sd7avpAOlc5gCheU2dGvyL4nnuSNaS34cz7uyDfO9wyKlnzWhsV1jAOg6+YnwjoBP65JK+d3KADLTVPqYnSGFzezDz/7LXrdiEuQnKuaoav1LzC+3G+8zNtsdm5Q6+ZgJUkqj1qdS5I9ULW70fzWgBSF4DhjlEdompdnKjqtrY/9LufEr2lr9PLTDgyyS1RPk3r1wH5gnubPKLzBI8xhu2Ie/jAovNNLnJZ1rM/VRZ4KEj/0xpJD9Oxnv9gyTiDAGzBLTjd0lYmQIY/P8Hnn7tiYo3AjfthAXEySOfFSycWc2/tJLPCQKH/x3HXbuC+lewKeraF6iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcSIe6qwR7LeyqFGmGqBm353GyC88tGugGTdhxhru/U=;
 b=xSemyw2alnJ9KiDNcHGII9C48SF/BlQGrLFVh9AWEiTBAUDGjFFQSXC6bJf/ncU7wcdDkVqNSBXALgBX1N3d1PHHWARHTXmfGJMkzmClMKitowgrmXpw3HGGrjXq6IAnLVkH8WGHg6TUnggC6shMv4kKqgUeoG6pydk1RW2ABdT/skn9TVPCeFSDMc3HBxHlBIpcsZGnhfrV8D/8ZVdAtrmOVcxcImiivOyT4KGvIWtCc3rXDpLJDZ7LxMVKSucaAMt36375oWmXgcAFW5bKtrGK7njtpexsW5JxnB8Xrgd3ZXDaVrPViDIehU3X4c8JyzP5MHTVSOGgN1TLw3h83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Fri, 13 Jun
 2025 12:33:48 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f%6]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 12:33:48 +0000
From: "Miao, Jun" <jun.miao@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "oneukum@suse.com" <oneukum@suse.com>, "sbhatta@marvell.com"
	<sbhatta@marvell.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Topic: [PATCH V2] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Index: AQHb2hdKe/v0Au74n0CvjnSXYkGt7rQAVy+AgACy4DA=
Date: Fri, 13 Jun 2025 12:33:48 +0000
Message-ID: <PH7PR11MB8455B3BF518454A5DC0763899A77A@PH7PR11MB8455.namprd11.prod.outlook.com>
References: <20250610145403.2289375-1-jun.miao@intel.com>
 <20250612185131.2dc7218a@kernel.org>
In-Reply-To: <20250612185131.2dc7218a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8455:EE_|PH7PR11MB7605:EE_
x-ms-office365-filtering-correlation-id: 20009330-752a-443f-219e-08ddaa768bac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IsvHagto7Nes3HHFzPqnJm5sUHO6uSNqpvQmvjXRzjbzQt2xuGw3wQwV05HP?=
 =?us-ascii?Q?dJytXDbKJsxY0Yx1+uyw9BZLsDbZjXuaLEeB+6BEZT3mF/M5Op84y6jZ2nJA?=
 =?us-ascii?Q?vtm/V8Iel08SbN4UAUGHSHbndMzqXVcSvdCFobjWu7LI8ZSZ7LlHwD62LXJN?=
 =?us-ascii?Q?2t+FSAuH6hZYrPaMTGo9p9Jf9TEe75ueqAk2jc0Ut9bCMY3PUBkflrzRnHvI?=
 =?us-ascii?Q?1WG7lSz+ZNPjVB4KLxv3MjLkuvBxChmcRzSljeebs+dYg0brvMM77RjNXT53?=
 =?us-ascii?Q?sRTr8+QlfBnww9clDmRol1ipEi+vV/1pjHi0S3tuUn594wcRDJa2W+M1uRHf?=
 =?us-ascii?Q?SgeBb0MquwbufkqCf0m5QSjnvdBms4BAjIBku98xz0tnac0gbjLOdtDh5b8q?=
 =?us-ascii?Q?93TEmvUvMR4S9CNIcS3b1xc6ENUyENhrnNShTmQorstuGZs57gfPF2d9q+iv?=
 =?us-ascii?Q?xbtTuVj1apQlBgRFSdF4FsS5joa2T2p4cU9fXVwmTI3EX8RtU1ShT5B8BV6m?=
 =?us-ascii?Q?zo0Wukssg8KATalEo7RqolggfqjMb3RLJpCN12B8f6L0WWLUG0z8CFwXbltR?=
 =?us-ascii?Q?IAJnl0sUCf6Ra6jzRH6V2QlLarM40fjp3OuaLkj24oMLBtx9OKA445njDh4T?=
 =?us-ascii?Q?XhJVDMCrXKWl2LCU4rKBQIQtmw+IE/Pj8lUKUr1oDtSEhC6FeCI1xnazSSaQ?=
 =?us-ascii?Q?/mSXCGS/XUYLb4A8VG4CQade3BkkCBKnXtudbDuR4Q8VW6g6BAxjWXJlHVCl?=
 =?us-ascii?Q?5+4o5pP/9qWfx6gPyvXMmHbJeVtPcjDRTxGmuH8gtHnSQC+xCcndLQ8c40u8?=
 =?us-ascii?Q?1etSSzA8GLloDtB1WYiBEIwm5HPC+Or7YvSN8t99MQ4gFhR2hFOjTYpie0nw?=
 =?us-ascii?Q?aAixpfieYUZL5zLYxUMNLX5bN6mmCpwp9BqU2hgcRgSd02Yr52aVXHEMVUj+?=
 =?us-ascii?Q?E0r9kuunSFcoA40WvHyacIAd1xFTNxhjLb++yRqcSw1XN9jaUkw/b99oFE8o?=
 =?us-ascii?Q?Qf4Zd1z7a8ztdhRLYrvc3p3dNifomcqcEZgJThrwOvs6EDRcyyXGHM5gERvD?=
 =?us-ascii?Q?xA7MgrlRcylTvelEbN/m56odmhg7M028WNKM/aJuR6KygwoB1DxnB2gsQmwH?=
 =?us-ascii?Q?5kUT5dUIOAvgvarBRvbK4/32rOJlRWm6Cb+KwwjSqbm6oGvsAascJCEbBTrh?=
 =?us-ascii?Q?4xo3oC1HF6ROPETsPLkhpnm23bmUWgzQW+CK3IrxSsirf+XpM2eS1JZ3WNDi?=
 =?us-ascii?Q?g7sXEWgr8ebPlWo2Aru8R5hCSR6wXpDYtFf+N/ZSZYMk/Ix+N1zWgnFsbO9r?=
 =?us-ascii?Q?9GYqWTPO8hLY/gM7BZGrh83dAkj5EayQzDKaGOonbF1MqcxaeOw8kR9M8Fun?=
 =?us-ascii?Q?f1gs3VWKWr+AWWWfUzHBSPzre1sqOak7P78eiyz8+XMpVi6oNFd5rRJQMIii?=
 =?us-ascii?Q?AZN3+ZSiwifTdknisnpIWyPO96ryVtxVIJmuGAuLLnTznM0FtxAl8A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mXdekfLIHCfnvmA2+IaqeNPAgSIIb6QYikysTmxLpIH8xNYyz0sAEpgVbkLK?=
 =?us-ascii?Q?EsdemtON1Mpp23V2LDs3/nHsmTz5xUKsCGBVL28NuCjaxosZsCpwFXaRicLF?=
 =?us-ascii?Q?D4mrSQeim7FNPwM8398vUswtvSxFlSo5QgLeA3nMYjwhCEnry6j/4ickBPge?=
 =?us-ascii?Q?0fXCa4imGY1U/ws7yqWi5+geS4VaihyaF8RBZzsKh6YjrDhOfiDWwfmvJLVg?=
 =?us-ascii?Q?OYJGcpPfw8e7irz82ZM1IArg2/IF+PWkhmkm4q7czoMOzj1pgdOh38lkSswZ?=
 =?us-ascii?Q?LES2OK2ugCHB0O8nM2qhSa2UaBJtoiqzuidhfz0YXfIuEn+yPyM+bYs+9CmR?=
 =?us-ascii?Q?DZkd4CuEPwkfv8rqa2x1MXtj0eMtjZguzen6CHbQtjKwCUCEfYT7gi0KEoIY?=
 =?us-ascii?Q?2R49b4xP2dwpUcq0HXTZTHSE6E3wZmyxn1A/StTEPM3iOisZFetJc6HRBqkD?=
 =?us-ascii?Q?wn749pPWV0yV637YuT0MQIRQB2qsXlKDMHeIKU4pjWdSrCI/wMDWMXt1X1hU?=
 =?us-ascii?Q?xWdLzlwH6M2CJX9R7a2Zy3UoEDM/hdMvzHD6vJ8Qv2LNDK5E6IosoIWKfx33?=
 =?us-ascii?Q?Vo5Rbzpvq6MezkpMzCOgxy8SE1C23EOLOWdxLOUb/EVKdJUItzEeudVBxRiG?=
 =?us-ascii?Q?GkwDE3xzB/9eWe2DxtR0Eucg8s2NFF46hgQUpQlV4Wt5FLr5Q4LmLAn0/5JQ?=
 =?us-ascii?Q?pkao/6Nu6ZyK/5llNItkf+FCIqoN8ma+EIB+bsjYnl5MTDOewpbnaniVTw/q?=
 =?us-ascii?Q?SeVFeCMIAoCRUqyE1JdN88bJayPRGvriKro0uvspWGLZVx1avVmKwnH3c4+a?=
 =?us-ascii?Q?hYlYin4gho60zgKKm4//KitOATTRLr+Lv+tj4edI39weEXdN1Ddt9xFqXoYN?=
 =?us-ascii?Q?lzbZdeLgWCo7AxL7Tn5nrz2Q8cDF8791TwNa9xDrR0iHAEKW0oA4PjnNcFfB?=
 =?us-ascii?Q?ulvGroMUtnACn8Rzn7mesB5gs6rev26QC0p2VhlQ9xj+NrCTKGt1wI36QiLT?=
 =?us-ascii?Q?WHS4Ro6oRVIdt3z0WnqVgvd7wegdCaHwslE6ivRXwp8y/YRSfsh8X5gzPLbs?=
 =?us-ascii?Q?OCS7mpNQ/5n1eJaa7YOvT2E6haGnwya2QvZBTGsKKSmKEmqVRG9G4VEoYtgM?=
 =?us-ascii?Q?ZUvUfmia5Likp0Cq2zUwFbVcjpcV/T8b49ovIeefHabmrHDdSLENAQ+Upegj?=
 =?us-ascii?Q?7LKVo8U9r4g4Sm/DRHK/wPsMwO4ZNOUPfp3PJkLMmwNvtZM+1LXTReLbwbG7?=
 =?us-ascii?Q?1/p7mievCgVuQ7inKtHU/nC5jahf2+syjQ+7tWQA/UDBI2xSRTVLl2S7FN7z?=
 =?us-ascii?Q?hFXVqPucoxdQ2RSi1wBmqWOvgipK3tWoFNCN9Luu9pf3h/HqIftrMyxU4Y6h?=
 =?us-ascii?Q?gi0va/1jBMw9EXBPgVWXi3T3NH1UR7WdKcaI0SWjqx2GVhPZde2Bq9/W/lr1?=
 =?us-ascii?Q?oOKH8cQzD3pnhlt29Cogi1yn3KKNNyocJPPBO23vB4EfdMWQJWetuudXxyWW?=
 =?us-ascii?Q?p7UCImZv24UJhrRfczeQM4op1RW3X/cL5WO/ZgxlAJFJoCqF/bEAPPRsk2Ba?=
 =?us-ascii?Q?gagyuYZVFMVV+Bvamdf5dW/mfqJGSpF53FnsNr+/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20009330-752a-443f-219e-08ddaa768bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 12:33:48.2071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2DIfKnvaaGTIHOP4jsUajB4ZHPRhc3WQsPRGXwdgX2DM3K6bL5bOslfYk2ZTLG8SDTvYiXf9P7heNnzAPAphw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com

>
>On Tue, 10 Jun 2025 22:54:03 +0800 Jun Miao wrote:
>> -			if (rx_alloc_submit(dev, GFP_ATOMIC) =3D=3D -ENOLINK)
>> +			if (rx_alloc_submit(dev, GFP_NOIO) =3D=3D -ENOLINK)
>
>Sorry, I think Subbaraya mislead you. v1 was fine.
>If we want to change the flags (which Im not sure is correct) it should be=
 a
>separate commit. Could you repost v1? There is no need to attribute review=
ers
No problem, repost v1 again without Suggested-by tags.
Separate commit can be in other patch when changing the flags.

Thanks
Jun Miao

>with Suggested-by tags. They can send their review tags if they so wish.
>--
>pw-bot: cr

