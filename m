Return-Path: <netdev+bounces-96872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A418C8172
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF1F1C20DF0
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2A9171C8;
	Fri, 17 May 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzWzZfd7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C517BA5
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715931021; cv=fail; b=gvdxoyhEE1k5P0m+0bmfWdwclNX/GS7IePPvMah0PSTppD61BbjfzePBBm6Z3QHofsyMfnCb9F8CZt+X97wlutb2GG83rk0ZcYLs/bWlEo8qh67jE+c12Rjvz+Yjuxw3TMnZqkAGwPScV6u6UNsdsEe+RYJCDgVoiqeeJoOp1tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715931021; c=relaxed/simple;
	bh=F+qjI//1UAxYpt3jV8ZmX2n1WzNf05N6C0e8aYy0hDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sv1rpS5gJh2oBgAgwfRYZsADnRYtaMuyOsWwdnb+aw2ZPC+gy6BHxnk3BQd5swUymOy1MzD7eb4yNIA1GnyRiDjUNurNoPChTDDvNnkDXhfxHf1tFQ9zr1k+7VgAYADZknQQVdsjKQYHL+DhdcsWT09Xg3CE/UPcb+R3d1nndyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzWzZfd7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715931019; x=1747467019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F+qjI//1UAxYpt3jV8ZmX2n1WzNf05N6C0e8aYy0hDQ=;
  b=OzWzZfd7uCGJBVQZHv0y/q1TjQ/PTfX2eWChsy2OE49n0LcEpFZsYNVL
   IiqfPWcIFviG5H6UcI6I/o7bK+hm4ixHaX4OpOBp+caaFDN/WylGawgh9
   FYXqstwfk++FN/Wn4u5bfqzGwp+ZW7fZ6eEqxxiIYIiieevhmKXfxtjO3
   jOg7+EFY8I/3bGqptCBsmtMV6AZTIHQH/ED2HOJai7uissp+GIc0HCTbC
   jb95DZb0uacNHuf0S7L6NwkM1lALf9MjCWK7vjp3jntBeNtpWibXTD9Ny
   R/6sp0DoNeg05100vzeaxriDWGd0NeBHdaKIMlp5+UySqu3Ckis7eiO5R
   Q==;
X-CSE-ConnectionGUID: QTTmPv85RFWfc/eE6WDfGg==
X-CSE-MsgGUID: tpSKIskoQeSOihpWrdA61Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11960486"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11960486"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 00:30:19 -0700
X-CSE-ConnectionGUID: 4E3RyGtmQYODTQM/25eANw==
X-CSE-MsgGUID: 8ERarNKFSPCGSeifMVQ94g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31844033"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 00:30:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 00:30:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 00:30:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 00:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Adg/gntJdU5M4Na1uNXGdRo0Va3rCk7W3Mw+5WKryk8fFnwcL/v4nIvNQnR9V8hb1n2nagUnHMUby9iLn+yS+6DNlNkUCJSVYK+5lwrBWiCmwSntHewIH0rtrSe0admTElOOa0HjLLiZn0Bx1EIQ7YFaPYplNTG0OPK94tkI1Cu+IvD7qCnLUMqmOl0ZvC076FU9Y6NJn/S14D4RMkMWLGzQxuk1t+S8zwdrRHrdS9Tj0+2+5uInQEnBCn/CQ5fQ0//8s3PcXfQm2NyDmEvH1RHtI+zMlx4EsVgTca+Wa/g9EYQkWr6H+Z1qDrfbgHvAIM+AkP4RuxrSfDMTMtdpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lEl3ufromSVVKSKImHqw5hP/ZDb3Z1nYjg6FK5FSK0=;
 b=TepkJOow2BGM6tYVZ6fjw3pmMyzLZr5FcXv1LS1++eLBHCHD1Wu76oWr/bB52V5n8Ih6encHUmy93Y8ClarGPivOGVKiS3lt0vs/FufF++1Bib4UdOvrfXZio/5G79/2qXSYsyZUg1LVYdw5zy7KX6SA26SXkca9EDNwyR8piP2bR5RHDybQG4wkc4kDVSzkLwgm5DQTaxzB6j3Vc+Is0WPPK1b7V/xHxRk00rFXtLmHkslfoSWXkVdX8EwHIIGYLdRAQeKBS5n8s7wT4tlq2TEkkNihuoP73T+Ku85mbfs5MbUVnsu8w/+jx4KYJww/9SZRm3Ff3lRHTRZoij6XUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by CO1PR11MB5156.namprd11.prod.outlook.com (2603:10b6:303:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 07:30:16 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7544.041; Fri, 17 May 2024
 07:30:16 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v10 iwl-next 02/12] ice: Introduce
 helper to get tmr_cmd_reg values
Thread-Topic: [Intel-wired-lan] [PATCH v10 iwl-next 02/12] ice: Introduce
 helper to get tmr_cmd_reg values
Thread-Index: AQHalkysxeHokuyXFkGc711Jchu9lbGbKyWA
Date: Fri, 17 May 2024 07:30:16 +0000
Message-ID: <CYYPR11MB84290C992003B4E12B0DAC7DBDEE2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240424133542.113933-16-karol.kolacinski@intel.com>
 <20240424133542.113933-17-karol.kolacinski@intel.com>
In-Reply-To: <20240424133542.113933-17-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|CO1PR11MB5156:EE_
x-ms-office365-filtering-correlation-id: ab6c716c-9dfe-4a89-6730-08dc7643329d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Q1l5ZDrpIEQ3qNiMau2RDH7+tIqvOxLcUz34rfZ5AT92wgvWz8044RYcV4jV?=
 =?us-ascii?Q?v6saKzXl/MTpshQ/Ty03PrlhEpHHinWK116FncfQKr+8/ZzA576U3m7vCThz?=
 =?us-ascii?Q?rzD+gNy/4cbjA9J/prx3t787qttY41Ft+4yexbywyL+BFmmsUpW7CQym2noo?=
 =?us-ascii?Q?SVlp/Y1lcmbX4TpmacGbW/Wdmg8f4vJtEe28CXqCXAgROTzLINS2B233hOrT?=
 =?us-ascii?Q?f1ieFTqyYTKN1I2w4WhTsdpD5//gRKlhvumBZw2ctBMUMytbdDIW/KJbjjVw?=
 =?us-ascii?Q?ur6g/18JbtEEOLLwzYEWfPl7akFfWU+TLubCv9o1yUifRqRpyRiPZyRmahnJ?=
 =?us-ascii?Q?b2MmbSRJAOZ3qjDKe07ZbCNwxZO7uXdgcOX4fwUxOspQldwIzieFYKe8MK5P?=
 =?us-ascii?Q?K0TJ+WeRWrQS3Y0AjTdfy+SkHBvpn1BW9Y4UxdKgivgUYKAIwDLELSbiCb5S?=
 =?us-ascii?Q?kMJAADZyUwmBlr3uAbHq/qRmyuYq0KBTfQz5sRxstSBxWyWlYxKChVatQ4Sc?=
 =?us-ascii?Q?xtrEDzD9E+oShUpzAXUMUnpGVfT2GX4XTK+hVHSuPI6LMfGXUO2Ety7p9VFn?=
 =?us-ascii?Q?2proAwoU4Ydj2kxf2ju9snSLewa5ZMEFIjYeJIgxRkf1P5CFUeBN0QfVdyNv?=
 =?us-ascii?Q?K8wISmE12IGBVNkzkOrTFpblBeFjO/YPp4beqef3HwM477iRpXBrXIcpe/cD?=
 =?us-ascii?Q?7YZUryTnfza0MEvZd/OmeRYCzSOEAZGpaPkiBqiQzOvSMRzlYLiihD+PxzOw?=
 =?us-ascii?Q?6rFT52+qAUOjJylIzURpVfoZ9izGY8SSBVy9QZSpKpuAwKNfxx/ghUteS+W7?=
 =?us-ascii?Q?u+uzkuaewS/QcijyZzfY1Mpt0FiGRzSn8fgQEMbzDO7kzw5I6pJ3lwM2y1Jv?=
 =?us-ascii?Q?5hR2RHMrAx+qgabKsUgm2n0Ty53vuqQQ+opcuSCx/FX1MpdXalIvN4p43idv?=
 =?us-ascii?Q?umIdQHpcF0kNK8/roHT88nF8lprr+QIM8wnkAOHHKSAVh3C3PnN6K1HPse1v?=
 =?us-ascii?Q?QZ2IMqBuBUpc40/YKO5BGZdRGZoUBKa2wBzbtuuy3OJ3clJGYwqDSyVPLn/y?=
 =?us-ascii?Q?GooTKFJQ1AeCaOR1GDIjcwtmQzBkXYeWd7gHLb2e0UK5BBTcWp9W3wsfNumh?=
 =?us-ascii?Q?oPeJUo942r9JxepACcXKKZbD2POoCFM9CJk5MMAwbboJvkqur56k/BVNT2dm?=
 =?us-ascii?Q?y00h9hGiuft7WSM453B+e+l/xtP5gi1nuDWpifClAtb4+yeRwdCq4JuxHcd2?=
 =?us-ascii?Q?AaVgAasw7Q3Cy4u6YPTqk9SGmaMkfcR9bkA/pnHAZmUANWqIhMNIJFGqQDxR?=
 =?us-ascii?Q?1ivrim4FCc0zX0bsMnvAj7fU1Vxonc+ILBkVHTPni3ouDA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P7XfsUNfIR2eVGoZMIMgwcK8vFNon85uSxDefkZlOJ3RW0EzTZsyyw5SaYkf?=
 =?us-ascii?Q?Mchxff66MMP6cnKbR69WKtSfO7ika81pteGNY/YxF39D6B9sYLu2xgSL4ful?=
 =?us-ascii?Q?4OOE43gfjq8Oc5Us0w3/FfqKJgFv92M4gaXdmq/KR/Z5wn1CdohIZw3yhMvZ?=
 =?us-ascii?Q?UnxQTNip99iCf0glz5tF/svqZNkV8kSMMfqJlzQkAS24CQZX0BrIq/mh3DvL?=
 =?us-ascii?Q?61jbG9//QJazaWYzFvHxHqtK225d+HyfKA8cumnUCPahajW1ACY50pdxR5SF?=
 =?us-ascii?Q?4K1I0Hw0sVbe+8ZW/ZhynMRnbAi+yesn1FFwZgJYnWE0hdAwn+gcPIbX9IM+?=
 =?us-ascii?Q?zOPY5aDlBvm9qTLfm/YBH7GVbIB4SuyroX72Vxn3yek2mm2ANlx3F0pJj8GG?=
 =?us-ascii?Q?9+UECwyJv/fp9nFHQrRLFSJzesL1aeK+HTLxug2Ln5Ht6pSmpaYxZu0F4pbt?=
 =?us-ascii?Q?h5jD8GxKNiyTpk8E6IicM6JLiiNfmrggbHYR2v8nCQQw3XVj51k9kPzHg6hC?=
 =?us-ascii?Q?AZZI98BHtPVgJWqq6sgQnunhmpf1bK20H/ec8S3PoQG1+I5DJ6+9Ogk5wgzw?=
 =?us-ascii?Q?bd3hyXzH2mWnP7/hHedx/n6+/YSEs08JqfR9mR26yAWB64O7z4BBIJ5+ugrs?=
 =?us-ascii?Q?68z20lJZBHyAke8dWcRfK78ndiPM/5XApLdIFoGtCr4rx+V+LIuKMBqQgf4U?=
 =?us-ascii?Q?yGI6ChTfQuIfb+ZWtnBsWarNXH8DcW/yQqMMyo+BMmH/Lex0JgslufZE2gc7?=
 =?us-ascii?Q?hNdlIGhfssDc+AyOZMgUEpcyhNDOBoyQa3JkH6q8lbb+RKi3n68EeSvnfFzy?=
 =?us-ascii?Q?MFiiNpu0j3pO1i43KKEfvgVaU6/RIcbCFp1+/QtoJS9+eiZuFo+jP5PiDQAp?=
 =?us-ascii?Q?68kVoRGGqV+eq1g8byieMlJ3yysB5pO4426Hn8DGvobwuSroTq2PwOjTdg+w?=
 =?us-ascii?Q?zVgDu0Nr6reECNI1qMg4QyGq3aVmBpcHcYcW7MmoXySnOc7DDQrJeDU+K2tn?=
 =?us-ascii?Q?PEsUWl70tnUzSbzdherxq+IWjNiqJj1YmhB49dBORtN5BJT6j5HNRvXK2EXF?=
 =?us-ascii?Q?9GRiACQPRyjLX0ZHHFqDN8Yg/BBu3NeFUGcM1HjTBoDMhWfmmztaWykHvNyu?=
 =?us-ascii?Q?91F50esDCxj+OhSfqYi0+W/rIMxNjIcg+9RiSrdA2BQqAVSUt4gtrf6ab85C?=
 =?us-ascii?Q?5tPJJEIHe9txM7fYhbxKK0IvCHnJkkLMal6lzWtrMIhyM9xZ8ZWRKKFy3CjT?=
 =?us-ascii?Q?mErgOMqA9yS43s4kiWV3jBnEbpAH6BS47fswR/gDH97N4lsDEAQDgWGy+KeA?=
 =?us-ascii?Q?1WRvHKYUvbXahua3vdi6oH5ZJGC+vNgWcbahk2pxO3EgW3KKT1RY870X016j?=
 =?us-ascii?Q?yuRY1fwR1CAkszzt/Gl8m9Sf0YDCrsW9Omt9ZzmY/5IPaUTBd5yBjZ+zk3nR?=
 =?us-ascii?Q?JV8iKz+IyTaktGq2cIK7/85EsN4yesOez24k1MRPYKdjMm29XhVyM0Y4nDPT?=
 =?us-ascii?Q?zWZVZCZXifJSFYpBy6EYR9CuCkRbeRxOPjKli/Y/CgYyjCgNACg73W+ACtSM?=
 =?us-ascii?Q?9Y2i3ZwYImX1RyCoYN0Qa1M0xPWvnSD+Jo0R3+Ue/OPwJm430PYLmLy8t1IZ?=
 =?us-ascii?Q?Mw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6c716c-9dfe-4a89-6730-08dc7643329d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 07:30:16.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eByHpc6mZ8upcfNa2xLB3zZ4+75jTItyQirU00/F2waZTlh0Ch57KDc8mREy/nydV5D7XA/RmwDpvIqcUaPoHCuJ4Im+X9kFvoF2wL9bElhZyHpgmNw4QglfCxjbNshV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5156
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Wednesday, April 24, 2024 7:00 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Kolacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>; Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH v10 iwl-next 02/12] ice: Introduce help=
er to get tmr_cmd_reg values
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Multiple places in the driver code need to convert enum ice_ptp_tmr_cmd v=
alues into register bits for both the main timer and the PHY port timers. T=
he main MAC register has one bit scheme for timer commands, while the PHY c=
ommands use a different scheme.
>
> The E810 and E830 devices use the same scheme for port commands as used f=
or the main timer. However, E822 and ETH56G hardware has a separate scheme =
used by the PHY.
>
> Introduce helper functions to convert the timer command enumeration into =
the register values, reducing some code duplication, and making it easier t=
o later refactor the individual port write commands.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V4 -> V5: Changed operation sequence to shift tmr_idx instead of cmd_val
>
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 140 ++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   2 +-
>  2 files changed, 89 insertions(+), 53 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


