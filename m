Return-Path: <netdev+bounces-134554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DFE99A0B7
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227B62804DF
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C7210C01;
	Fri, 11 Oct 2024 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvGDqYCI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146392101AF
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641004; cv=fail; b=ef9AqzYAw60hTOyb45lyb6OcazvZ6T9Zp7LW8E5nkxxT8He22H9t1/XAozJyIQlqthbRRa3hGtH6d24CMp8Jri5X9alaSioola3D9z4jlbKLr06gzlL8naqWyq2FoSGDy+3TIHhQVCHsRBY23iwsRKK53fiyT5ewX9igUzcLm0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641004; c=relaxed/simple;
	bh=7aEWMNm22tiP1ILqgWMmxsPCHHsd8bU//sPSmFBrZpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7m2m2EKXy7K9YV1H/92ybwpCuWHfWmhHzbg6u9/tGygWPKQAbJ+BiBPtjVc/YCg29bARHj699wPGci2W8YT4e4GQAcjclZSSpAOPq4dY+kxe4guUXjaKIeJ7nuUqbxlSADT3DR71mK/YXV9c58cLUpBKCMnSMSVI4TCTKbhAx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvGDqYCI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728641003; x=1760177003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7aEWMNm22tiP1ILqgWMmxsPCHHsd8bU//sPSmFBrZpM=;
  b=FvGDqYCIT4lZVeWfzkikGaGk5U2VS7Idz+VcYvcJwGExs3AD3Q1d1Ltr
   z5IMn75Jk7Rv4Aypaagljrmlx4urhkR12AEUurIYq1EfBW/Cgq4z/5Raa
   KgRTaacmro0fkoD7zFbGWvOFFHUsEbw6xkbG4p7dcqzDoWwaVxICnUUD7
   N0UD6f6RAzUoWg3vImkfqzj1wL6KwLkR2u3XhiwvD96G/BXzoGH7xvpNZ
   pEkVXPGF7JBNWG0izdIifoiz3UvkXpteZ1ECRdaL2A2f+dLTmRsHl4bkE
   oI9mNNpkZlRtN1I70WLKUitMtZ/KyJuYrk9FUrN8r3gb7Mc+nZSYQB6Dv
   Q==;
X-CSE-ConnectionGUID: CKHWtoTBScmNgfjuK8fqeQ==
X-CSE-MsgGUID: FUkWUOLiQG+MR0xD90x3xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27845697"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27845697"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:03:23 -0700
X-CSE-ConnectionGUID: RqEQ2AtVSS6DsEvszIOdOg==
X-CSE-MsgGUID: jS12//XmR3em7NXyfM2mkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81383438"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 03:03:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 03:03:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 03:03:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 03:03:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 03:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEN5Z1kSJqvP7j527WA77WO5pwXi+sO4w5pgTAk9OyIitNBg2dzZq2BV9qyAP63W1SmwDoDKvAVP/zK9MlpMpzdfqxjNCK9aAlMvg9pR+LkTLFcbY7a3U3OFTqKqG/IwqPGXHjWDp1grBIvqTUWGwivCa/6cgfAW67/Sep9rgZ3dxbaFdJIirg1NMRLyez4RKgCV6PBQ4Sl59cDE3nWh2lQSpJQ1+cHJe7XpO7Zq2h4RWbNUJzA3h4vza0MvA36yh6+jNKoG0+s35O/HHvkb3r2ZjLnD6lQxQp4hEveClhqUnV7avfktVd+enP2jwDVBrXfAhm98tWDKKgo7138tfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnpdRkxv9tTaGxXhdjYM/RwjP8iDvM/YbzHqf21cniI=;
 b=vJMm0vZ9/4E6DJXRZy3bu73sKlJG5XUkr6nEbtLKjoBuJOiCQrDAMsj3yblR8mn30wZTKR9oav4mpcDRwg/iSnIInrSiaJgyiRE3i61JFweRlxNBegCzT61xGJJULrSERGAl6naFHnE/OfaJ0vzk3xhjUyUoiTgPETJ3CbbNKPB4P+nwTM/WcZDwzptUdunrqY3rkhP5X12MfyimLP4Sk2TDuzjF3+IuvJtbeWr8g5Y+c+VuN4DhrwC+4QPgyI4LG1FOQ5o7Szz/4pvt5hfR7Ua2JVWlJzv4qpHosJ5n8pwOt35Wtosd3u6gcfWb12sY9nbFWTEtjqWnH5xMAucMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 10:03:19 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 10:03:19 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 1/4] ice: c827: move wait for
 FW to ice_init_hw()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 1/4] ice: c827: move wait for
 FW to ice_init_hw()
Thread-Index: AQHbFMHDgPNWY4Qg+UKhQCB+3wYmM7KBXtIA
Date: Fri, 11 Oct 2024 10:03:19 +0000
Message-ID: <CYYPR11MB8429E22D8C3206F3EC44F46CBD792@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
 <20241002115304.15127-7-przemyslaw.kitszel@intel.com>
In-Reply-To: <20241002115304.15127-7-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5078:EE_
x-ms-office365-filtering-correlation-id: 1b74e0f2-79d4-411c-43bd-08dce9dbeea9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?26v3KqyNQzG+SkVcAAYofypzrUFUd0ghjZMXjk9NEMIGU0NiRGVZN+83oJlI?=
 =?us-ascii?Q?vUUI6diR+uKzyOpXkJIFo2V9ytiJFVWdWeYGX1wic7ujOcBHrwe13To9CSO0?=
 =?us-ascii?Q?oPvov6Phl5UL6Y6tL64tIN6nQvai0K9Ss0H2/HmadB8cNFJ1kIaGpDzln2aR?=
 =?us-ascii?Q?WU8kmVSJ3r13iDq7aDqHSMCTWie8xl7RylmwUn0rIeqZNx2BlRnxfyqC4bzj?=
 =?us-ascii?Q?t6YQUjLATuN61NX38R9TxI+yDzrz3xBOaXAppY1UnpviD+dAJct2O+g57uAS?=
 =?us-ascii?Q?NfGjxbu+aPiabpPAvej4fioLVlKpPEHWmDIisbq/Mt1cGKkxNcVpQitkyDfu?=
 =?us-ascii?Q?UtEBWq6yvmyPR7ZaTfVRHmsPAjF/3FCwY88S3aOOIJzG9RgX3wKoCZ7WsXjm?=
 =?us-ascii?Q?4miAvUJKYTQC0BPZl0HR70gQQyKfnXDam0X2ksGllUCwz5KL45eoHGPhqscU?=
 =?us-ascii?Q?yJzzMRbKwtd0i78gh1WNQFIk+y7yAKiMHKBY0YCJF5zwiBIeZidGQg8/9Rfo?=
 =?us-ascii?Q?UGTwylKB7WYz0Nm8uduhO8hyQaPzFGzPym02B29a46bmWZkiS4jsgCoa9IjJ?=
 =?us-ascii?Q?QJTjsKC70yZGB0488TuVJBVBv7JaxlDB41ah8WEmChLyIHBoc1vTilwOqW5q?=
 =?us-ascii?Q?k6t9dpGl7DwaiaPe0oZyWhXOhpomZgwdFwVCFiqi3xKbExFNb9jIujUslBrn?=
 =?us-ascii?Q?cQPVCNEXYf00x0GQ/colIBBhkHs4cDAmknDh29mULDo8T4yVZJj+S4lIjz0y?=
 =?us-ascii?Q?lemDqu/mkkqEEMw1AXYDwJFuxgTXL36JXcpDqlPMJFdm50omO+XUbJ66dNUg?=
 =?us-ascii?Q?zW6n+U/sQuN0bp8yxFFh2lNd941vLRrpHPerOQXOcBUiPCDU1wy68Oq1BQtO?=
 =?us-ascii?Q?wZHBkA+PfLDAIvQkXmH/ndj4V0ex5D7ivJEV3mSdoYLEbhq/dE6PSUJReLWX?=
 =?us-ascii?Q?VNo+L5s5ANtJvrnSf+TA55PtFvgvCcxMdoQGASsGQmUKDDy8iPeV25MseH7Y?=
 =?us-ascii?Q?ZUZLDEYXmSfK++GtVhlO6wPXgIvTaGbREQnhBEemCuBFCUWVPJG+MhzYDmsl?=
 =?us-ascii?Q?tR9CSVIGoiyCQQUyBSR2vgNApwjVc7QkhXn7FWAzY2q5Meu5JOi3qMN1nPmg?=
 =?us-ascii?Q?zh1FvfN6+eOI935Sju3kO/DFUJyUw0UMwKGVB3nqD+hKQm6OKFwoNJKh+9hG?=
 =?us-ascii?Q?NT0fi9z4MpVy1uxnHX7g6hGJ/CjFFF+0vRo3/UwglnOCKcagJe+apT8xJ+zc?=
 =?us-ascii?Q?qu8+x5ugwuX6lRl6aHw9lHx5cB+iqF/ryQjWRfad0hzJlLoxcl31hmDVtZv8?=
 =?us-ascii?Q?kO+QA5NipSYyqOqT0JKsRkjgNZAeKCL/uu48JigrkwYV0A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gvA4D6uNiXkBDVoPMECWFIlMlRY29vZWG98u3MRnY8zARhUL6Kq78PpS+57V?=
 =?us-ascii?Q?ViwKVPtCQIHZW2Huv2vzHVb99XPPSeHdTk7IPtCAVkEyw+Pxsq0y+tMCdpBS?=
 =?us-ascii?Q?CMQOWd+nnQ/g05NjqgwYNbgUafoq0gAr4H/CYQxxChu7ZGe/lAYOKD5D9jCp?=
 =?us-ascii?Q?1c3K6f5fChAgdXDr1HgzjdBM5ZhYSKirLr0qliO9bn+gIST/X5t60UDudnne?=
 =?us-ascii?Q?40dUrM3/X/1AASJKCFq6M1lF9hz1LhKK/88c2ioY8Sjhvj/QGFS2Jyhr2JLq?=
 =?us-ascii?Q?NYSZXDJDhg1vr+naGiS13vaLbDlhZNhAmOg7so0uD6MTrmZ4I45xLaZBjNt/?=
 =?us-ascii?Q?CC5C+y3oOLTNnkFJ7fpveFLftC08USDD96TB3SSzD3lZJTyC5nI0gRN3c1iT?=
 =?us-ascii?Q?TPZGz9X7pPUVhyHVcmM9G2NnnpD5IosusarJgk+XzCjfQEOuWYhs59ghjPmB?=
 =?us-ascii?Q?+kcKG4gpO+YZETepcvOnFOhAcoYzaDn6tejzkwg9j+LRlnE5kra8Gi1Ijhe0?=
 =?us-ascii?Q?JzaHmnlAFYswuxxmeMepxsk8DUAT6+S0M9npiRhKzQVIy0lwpwTPsxb7I4P5?=
 =?us-ascii?Q?aNFApjqXfWnEN/kpdXOJzZGZi9wVMCGgs5JvZOpZIhwK4Oy9jzB5c5rk79Jo?=
 =?us-ascii?Q?z3cPUKRC5IR4XDwLYqSxtbVpj7NhxhMKMSzi/bF9oZRX/v5TK/sKyzSC/+0F?=
 =?us-ascii?Q?5ZHXOPFlO9cAuHMqNJ+LMhfvXQdiRRkXeYYNuI7ll/iqoTq2r5dJjkEOh3yW?=
 =?us-ascii?Q?FRLTttwsjMccDm4psa6dDOi1EiNLun86mvZAhEqqfdF2qqmeiwpTUxCcL62I?=
 =?us-ascii?Q?mVedo2ygQjx6yUoIayQZU6JuTG4lD8KrL70bwNKUxs+HS88IqTFAL0dxbZfv?=
 =?us-ascii?Q?JJv0RR3z2WgAIjb6d2mStqVW5LqmqYzdjYmxUCPFaz4yYTjskgwBCaXJVqp9?=
 =?us-ascii?Q?UZhGQe5Dd3eTpH3PMNscYpayoLJUG4iT4MhrIFEI0SIuMv5oCsrcJ202FwiM?=
 =?us-ascii?Q?M1SQdjsHKwLmI2xsvyman+tsejedajTD2Z6JMu3snBxqYCY42Tbw+h57sBp4?=
 =?us-ascii?Q?ECxesKkpkIt/idicUt6w6FDucfKIh8a/Aa9iSXBSMiPoO9vmKHvIDHTWxaNd?=
 =?us-ascii?Q?hiFguOXrZydwKjQRJqIC6fRNCBdXTMondxmcFm8seXG1v/o02PsSO11+RY3Q?=
 =?us-ascii?Q?tbclLB8xFun0dDIx3ZLAmIAreY4TNQ1fO3UiAbJS0wPrL2XdogDoc7OB4/Ie?=
 =?us-ascii?Q?xX5CG3ynE/p694GZ85eeTSV9iscU4eMJYbnCNnVD2nTwJkCCMYDt0nZHalT0?=
 =?us-ascii?Q?GrFnw+3bPl86b0Ya42xjNL0hGSQRAJ6CIRznE+GyqNK5RkXRj+k2qxOxJTBC?=
 =?us-ascii?Q?y0eR0n4+yOvdKaCOpfavyMcbU8jnA8Hap0mvywmaP/ro9vBgPSweHNjsAZ3i?=
 =?us-ascii?Q?JkB4Zdfy9pWizoqV/JhD01nSE5bo8H5GuryOXxed3g9bLDRdXDKe7aa2cBS7?=
 =?us-ascii?Q?HrhDrcIa/g7gAqU4c2RsAVa8lzdsh2yJ4JDxJkwDOJ/TxxWeV1XUYtK2N9d4?=
 =?us-ascii?Q?pqjnFZtR7nzMfdKVdnXwrc63Fttooh8lx91DdJ8Kvb8k9CwM/rTckUa+/2Nd?=
 =?us-ascii?Q?rg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b74e0f2-79d4-411c-43bd-08dce9dbeea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 10:03:19.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40hpDqR8wPJwm1026/oYI9L4E0S8T4c8RGi7l6AP1CSIEaFl19jEw62uXGP7KxPmb1+NJPAp6myOsffNn9Tb1SZ6GbFyUQCaBHMgLr0DB4hoFFpwjKraSXQfLhIxfOlD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5078
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
> Sent: Wednesday, October 2, 2024 5:20 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Marcin Szycik <marcin.szycik@linux.intel.com>; Kitszel, Przemysl=
aw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 1/4] ice: c827: move wait for =
FW to ice_init_hw()
>
> Move call to ice_wait_for_fw() from ice_init_dev() into ice_init_hw(), wh=
ere it fits better. This requires also to move ice_wait_for_fw() to ice_com=
mon.c.
>
> ice_is_pf_c827() is now used only in ice_common.c, so it could be static.
>
> CC: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.h |   1 -
>  drivers/net/ethernet/intel/ice/ice_common.c | 110 +++++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_main.c   |  37 -------
>  3 files changed, 75 insertions(+), 73 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

