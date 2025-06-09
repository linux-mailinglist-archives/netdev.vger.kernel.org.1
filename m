Return-Path: <netdev+bounces-195662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40BAD1B15
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 11:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0573AE47A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672C3251792;
	Mon,  9 Jun 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5Mn2Lc2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF212512F5;
	Mon,  9 Jun 2025 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462824; cv=fail; b=jT5N594vYy27KnDEeCmLgUcGbB6CS/4dvEz94MbGhaJ2Ldmp79BoACQpare0FHOSeZUdxO0iMew299jX5IBkexqQ7+h4yQ/uptdjyVy7rInVMEXu9VBGz3/YIp0jApNWMkHBHjlEYpQuHnik6/muWnyqcOZXAD70bYmRAixJ62o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462824; c=relaxed/simple;
	bh=yAt9PQjWo5toASrBktZxsZaY9Dq5iEr+N95s4uWZdyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tfwhSuCsZ+PWyy4veTalAAIJnNAvWLu0+QcnRM5JL4zzDC/EXomYicgpCl0RoscEQHuE6wGji6Nz0Syd/1IeFUyzAMyJmDqqKbOqD5kB2KUAt312RztHqwSqXkVjNhL+n9cwMjyrppdecw9T2PBbQsIn48rT8QiGREe8zTB6kP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5Mn2Lc2; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749462822; x=1780998822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yAt9PQjWo5toASrBktZxsZaY9Dq5iEr+N95s4uWZdyI=;
  b=j5Mn2Lc2Ak5k+3bUIDqXz3T8kZf9qLOEp8VUu86Ip/JBY/r93PhCVvGV
   O9QFJdl3rUQh8rmKE3wQMJxIYz82IOC+RN3gfS3mEcRSyToUPmY8ycTe5
   1KGo7cJVXaOOab1tFmTP8k9rSJ3ybiBYbLaSJU45YR4/vo3J90vbkjpJx
   Ibols3DnNUcLMc1BIWrAGbnr6JqAdBxbHBv1qSq6DWKQ2wmSCmi8ShMSa
   SJJqBtb1IPmP5wCjY+Z98aTreDFAi+l9S+NsYvYFc3PiHo5hlpaWN+Nli
   22dnEuQ2PmAdlazku4I4eE0ul6rqLCWo4MPKjNDPNy3Fy0Z3Nh4pjItnL
   g==;
X-CSE-ConnectionGUID: lDxXr/4BQ6G7VNdSjBn/sw==
X-CSE-MsgGUID: Da6J3hzESr2tsEeo43qQ9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="69092275"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="69092275"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 02:53:41 -0700
X-CSE-ConnectionGUID: qI0cWgc2QRGuYOyCfHQ0aw==
X-CSE-MsgGUID: TsiU0HnDSmKbK1vH+vxgZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="146345723"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 02:53:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 02:53:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 02:53:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.70)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 02:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJldM992VW7Ja3qxLlqiXG9Ev89a/0rqml7mYyggf4YCLfT9Jq7C03DPT0wT0nJNW9W2hL/o/p2e+goGwMUcLkk1eA27SVxZndF692xrUy76TIdSgRRHE71BKG91eyFZdsmnCd1VFS1HTF8lxaGJ9iNB0cvAc56hd4WO43jyTKRTRJK83gQlQJM7qBDF/NjLG9m5LD7mCC2WbBhK+vAhbeb8Lm9hS6nnGGVSCHaFAUL8LuHlMe7O0zinkAyVTbUakmPE3QspEV+xNUW8q09e+nGf1WKAKDPuOUC2XCBXbCghxrCPPOBAtBfhgpdLpDCjRtiCrL6n/4721HZ5JJFwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4xBkHHl4h30qLRnOpDbHe7pFNgQzmIroRZ7UK1lD+c=;
 b=Grc2DJJ+ur2SPGGsHavHnOKvDsOKqMp9jaEPfPq2ies7AVTC94Z0N2vYXfR2LQEDJYYBu2ZWx70duJ14F/qwjQUusd42AYoDSN3ysUJ1g2B5cK7aXzuqPN59DxzaM5YibA5lNRIIoSYEQ/ZmdtGbiyfW4lJS587xJSYSawV1FLqqKmPSmROLHihQr6o83dSxqkIE8i0vIchmjiVk6ZAECkwMBl34ZAN335RPD9uppuziTJjC4JAUE+LY7x83AF+1MY5oVZDqOYUIt3G+T5aqQzDmQsjCK3SCoECmoQ9tuJ4VjJ4GHBlyBJlf79jfDrBWPqx3IPWOhjg/HWUi1TABrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by CH2PR11MB8868.namprd11.prod.outlook.com (2603:10b6:610:284::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.23; Mon, 9 Jun
 2025 09:53:08 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 09:53:08 +0000
From: "Miao, Jun" <jun.miao@intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
CC: "oneukum@suse.com" <oneukum@suse.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Topic: [PATCH] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Index: AQHb2Q+P+xtcjrqHp0eA51vEw2F9rLP6iROAgAAKjCA=
Date: Mon, 9 Jun 2025 09:53:08 +0000
Message-ID: <PH7PR11MB84552A6D3723B68D5B83E4BE9A6BA@PH7PR11MB8455.namprd11.prod.outlook.com>
References: <20250609072610.2024729-1-jun.miao@intel.com>
 <aEajxQxP_aWhqHHB@82bae11342dd>
In-Reply-To: <aEajxQxP_aWhqHHB@82bae11342dd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8455:EE_|CH2PR11MB8868:EE_
x-ms-office365-filtering-correlation-id: 973b1181-d31a-495b-e370-08dda73b7052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Wd3F9a9GdxBw0zKHHQEVJ75zGL3vXyike+6Slzw74zzXNKWKFxUrCsoETuNu?=
 =?us-ascii?Q?TTXxIU3CNR1c+RPJehasC4BDkHrekP1TTxyK8hphnw5q+MR2meP0TD2vxdPD?=
 =?us-ascii?Q?9e4Iusms7/T14MKqEKEP7HErOerOyJhcHZZm4yfGNJdn6bNqaioa/Rf63lpU?=
 =?us-ascii?Q?38X2wYRwNycJjIZBTKWG82pUVYklU4KzNnD0Nvi/F6TOcTSEs7+OmdTkH7Kn?=
 =?us-ascii?Q?BQRQiS+NoB12vW9TmcxtmwRCH1bolIY5nZTT54fK02VP1Zs4t2LQmSYwSSy0?=
 =?us-ascii?Q?HD9CCxYDNLACyX7GPhn0c12Q2812LMlFgqRfvRAuxFi1YjX93wJ2Z1GXytOh?=
 =?us-ascii?Q?a67h7ZADnyWeiMktJO4DRfwMPlb3gn6Dl74fey0NsYiazGbw+ED0gm1ALteB?=
 =?us-ascii?Q?3VIKD40+svH/2upXhomUAUNuPVEsTaSsJEWX8tuoO/pzXuptvYdfN25NonYM?=
 =?us-ascii?Q?vPMDNSjyNhU725b1ZQ5sHbg8AL3X42WuFgyD+owyrD9u6pSXOcOB2eYhi5ST?=
 =?us-ascii?Q?OSan2UsPehXN5w43ihgf6DHFhDlhDj3z2xwE0IxrwKpv40LK/LstyW5Tr35U?=
 =?us-ascii?Q?9FaPYFwkEI0Jo1VOCXo1BJJYIAvri3UCXMBr0x/TGFw+2qZKmsFb4ggKi6z/?=
 =?us-ascii?Q?9HBk2wkL+dfzRGObsEX/XEWVW7buLyl3pkN4Q64WtdZ5I605lZgtU2H/Jh+r?=
 =?us-ascii?Q?Ylx65f+5rSXHnk3VbYPJJCAPeh/DIff2+o4eOQ89c4PDVLhsZZubqjG8h1zn?=
 =?us-ascii?Q?vXxs1kr6sTt+uHBA5ZosTLFoeMhYsa7gZ4WvSkG7MgDzbTCTv1TrKthK4xX5?=
 =?us-ascii?Q?RQReljLrl7NTzo9eRfj9NhiPP2VTWipxVFxncD7CciD6YXMaVagcrakfq20Y?=
 =?us-ascii?Q?ip6Z7WwltgtNbhKgdt56Jl0mpbqYACdUQkddVr/bktzKm1Cdw9Aa6paFp1zs?=
 =?us-ascii?Q?wVz3S6X56bu/isxniCeyyL2XlMOyl5k+HEimv6VjHrK3P4nFiALqiF8LooqK?=
 =?us-ascii?Q?cXfmB89OOabGX1UrATLG7qjMzfhlfcT1vAPIE16r2xf8jQ3NvM0wRbMiy6Cp?=
 =?us-ascii?Q?FKNqt76buC0hl/UAJcyDD4oIygEKYHXaT0borPdrzZ7jcw5NIiAy8CeBhM+s?=
 =?us-ascii?Q?iPWZD1zEIvk0Yhjn55t7FHGoF8InDz5HtNu7MfSBdacl5UA/HzR73zrt6QZZ?=
 =?us-ascii?Q?3wXTlxt2H/jHTgzDgzhxRN39kKJpG4x/TITB5WfAs7mOFOu1y85tukmdgv6P?=
 =?us-ascii?Q?BtiBHj4DxFIesRKKDt3duCPtkcocqbV9NLCHzNZCIRQrjd62eWhdZzKsfAHb?=
 =?us-ascii?Q?6BaXeKx3aw7x1bl3Y1BCX7G6GB3tC+pLrrY4yBEz9wbjbosepiTb7OGQ94YM?=
 =?us-ascii?Q?cd6neS6Xh2lBzgoaGLsOAx9W0kVNA44ulwt6I2bGDQDWciuMxnywB6K9ijVq?=
 =?us-ascii?Q?fixd4y/qYV/ZVUYZCsEGm3J4pAHzObyTBivGJY8o0WKfllVhiJ0mCi/7v/f4?=
 =?us-ascii?Q?AQ2ot2lElbnrl4U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zJvrmJ00yiULjSdwhooTvCsiCAGIN84Zei/spDq8IuPrgIoaP6xI9pe6IpXG?=
 =?us-ascii?Q?9NMgBm+wsVIUPDMy1zOuWjFQhVRGKM+8bn43oNOBlzyiQvF+iKuyfkWzFuV3?=
 =?us-ascii?Q?Bv3culxYnsEKC+ZAHJz3Qr7tguzncNJkt39eqWPkTDC/TTlCvF/6nShukXM9?=
 =?us-ascii?Q?FV8PBGqLs6LlX9oK8wQHzgsvtfOpCuYykaBvoKWQTdjjljCQDHmQ/8DYyr7g?=
 =?us-ascii?Q?ifoimH/rREyWIBzhkigaG/MYowEGPXXltJ+atzmNgHfkxmayhdc1+SWgPK5U?=
 =?us-ascii?Q?Nt8qQJ29BT5q15YwqbUY3Jxm2LuQ2yRzqDRSiFrGKgulIPms+9G9IsIktuSC?=
 =?us-ascii?Q?szQwZzIxirBqC/MA7sHHvJnm/Adwo/6LPuFqCGnoHsKxkODgBYgKdmhT6Lct?=
 =?us-ascii?Q?e8pRGim4eQWjgjuyJqQGDnNpoGHwij2PsjvUBv2d8EX+gyP/esaqgZwuqc5Z?=
 =?us-ascii?Q?S9X4Vpemm5tixih141t2/eeUmfyAPsYIg8kR7aJkB+asQh5EVJ/NPecAu+Gv?=
 =?us-ascii?Q?fpg4WrB4EKSB9JCz/oNyJPYcdXPcENYaguFz8gGR5Q7SPvgy3YB8kWETj3oF?=
 =?us-ascii?Q?4RdhulfqnvX//9Pqzz6MFAExlnAIosJH+N8TqnbvtavZ6vmsQk1v41Sx1asz?=
 =?us-ascii?Q?WM5RKc7DnGvoj8RNCEBKsM1rEYrT72BwNowvV6+gKQyphCAinW5hvDz61wmw?=
 =?us-ascii?Q?s+PToCSzKj/aRJOWoF5YHL0URtjV4OnayBi7F+/H+n1COcZt6uSqnkX3ct4z?=
 =?us-ascii?Q?fZUL7ieaDQMFokMlL3b2KaaBpZuYoVbbQekFHuOWPtIeyg9PCvEScfkzW82Z?=
 =?us-ascii?Q?vfD5r7/iJuGwUkMykWLjiE5tI8FPNRKopIBpqUjD/VdCYb/B60hQ2mNM4QJ7?=
 =?us-ascii?Q?K0z+DY8t7Jnxp2qw9X5OW6VOmfHtzEf2GnSKYHUgQ6j5f9ozCgiSm8CAUDfY?=
 =?us-ascii?Q?QwnEgCkyUgWhWNm3C66v1sTb9Y4bypavOK7B1tEEuHQ5bK9thtqLVCoAbdEp?=
 =?us-ascii?Q?Wbu4QrY2AfsBE3jXlKRzDpblLCl/hFWerErdvDadXXEKiPC3yk+T3TGbtf2o?=
 =?us-ascii?Q?7qX4zgY73J4ARzf6v9C/dndAADlMxpJjht4h2NHhO76V8duYnC6uWMd5eXoN?=
 =?us-ascii?Q?XJAJs9m3aarSHrqaZKRi6wNSbynBljJ71WBR5RDjxJmV6RXTrOyMFPjQ/OeP?=
 =?us-ascii?Q?uvvL6A2cxEp9EzMFwcjNHe9uAcVBO8iqg7kVmBJfTH5KDbZOYdKbuZ3K54DL?=
 =?us-ascii?Q?lN7j7RRIpHVp5fKiUv4sMcqfHTbGDlxQOA/1kN+WjXMQ6ekIKCI1xp4ejv7m?=
 =?us-ascii?Q?UMT0hIVDgLCM3ZA0VFJnWxUFV/FlmaOo5jt5VXI9DT0IBjGmF7tMAtiaYdCq?=
 =?us-ascii?Q?ewlsct2xYAEqXCu06orDvWyePaa8cbYeXRxuvxqvmgIsSTMYibKUGwzCP3qs?=
 =?us-ascii?Q?nQ4wC39ssAZA4W8+yIiyZo5AzIHDFXwAN6/uUKLTXkPTCIMpSTMbp7m1SN3B?=
 =?us-ascii?Q?c1AO8qEvP9acTgGc9QopffuOUaR3ZQR+FS10iZbXuI9LQzP34azmSsgBt5sp?=
 =?us-ascii?Q?Qicg+YPXp3glAY7IuC6SOb/uHIS1V9znLp6wdTo8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 973b1181-d31a-495b-e370-08dda73b7052
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 09:53:08.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsYUqfTxJsPGn3Um3/HSY+GuVJUdCldxtF+v5smHhviJYjqyqxwh/4JY4I8kweGnzfbgr38dHSGBZSGo9eqTiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8868
X-OriginatorOrg: intel.com

>
>Hi,
>
>On 2025-06-09 at 07:26:10, Jun Miao (jun.miao@intel.com) wrote:
>>  Migrate tasklet APIs to the new bottom half workqueue mechanism. It
>> replaces all occurrences of tasklet usage with the appropriate
>> workqueue  APIs throughout the usbnet driver. This transition ensures
>> compatibility  with the latest design and enhances performance.
>>
>> Signed-off-by: Jun Miao <jun.miao@intel.com>
>> ---
>>  drivers/net/usb/usbnet.c   | 36 ++++++++++++++++++------------------
>>  include/linux/usb/usbnet.h |  2 +-
>>  2 files changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c index
>> c04e715a4c2a..566127b4e0ba 100644
>> --- a/drivers/net/usb/usbnet.c
>> +++ b/drivers/net/usb/usbnet.c
>> @@ -461,7 +461,7 @@ static enum skb_state defer_bh(struct usbnet *dev,
>> struct sk_buff *skb,
>>
>>  	__skb_queue_tail(&dev->done, skb);
>>  	if (dev->done.qlen =3D=3D 1)
>> -		tasklet_schedule(&dev->bh);
>> +		queue_work(system_bh_wq, &dev->bh_work);
>>  	spin_unlock(&dev->done.lock);
>>  	spin_unlock_irqrestore(&list->lock, flags);
>>  	return old_state;
>> @@ -549,7 +549,7 @@ static int rx_submit (struct usbnet *dev, struct urb=
 *urb,
>gfp_t flags)
>>  		default:
>>  			netif_dbg(dev, rx_err, dev->net,
>>  				  "rx submit, %d\n", retval);
>> -			tasklet_schedule (&dev->bh);
>> +			queue_work(system_bh_wq, &dev->bh_work);
>>  			break;
>>  		case 0:
>>  			__usbnet_queue_skb(&dev->rxq, skb, rx_start); @@ -
>709,7 +709,7 @@
>> void usbnet_resume_rx(struct usbnet *dev)
>>  		num++;
>>  	}
>>
>> -	tasklet_schedule(&dev->bh);
>> +	queue_work(system_bh_wq, &dev->bh_work);
>>
>>  	netif_dbg(dev, rx_status, dev->net,
>>  		  "paused rx queue disabled, %d skbs requeued\n", num); @@ -
>778,7
>> +778,7 @@ void usbnet_unlink_rx_urbs(struct usbnet *dev)  {
>>  	if (netif_running(dev->net)) {
>>  		(void) unlink_urbs (dev, &dev->rxq);
>> -		tasklet_schedule(&dev->bh);
>> +		queue_work(system_bh_wq, &dev->bh_work);
>>  	}
>>  }
>>  EXPORT_SYMBOL_GPL(usbnet_unlink_rx_urbs);
>> @@ -861,14 +861,14 @@ int usbnet_stop (struct net_device *net)
>>  	/* deferred work (timer, softirq, task) must also stop */
>>  	dev->flags =3D 0;
>>  	timer_delete_sync(&dev->delay);
>> -	tasklet_kill(&dev->bh);
>> +	disable_work_sync(&dev->bh_work);
>>  	cancel_work_sync(&dev->kevent);
>>
>>  	/* We have cyclic dependencies. Those calls are needed
>>  	 * to break a cycle. We cannot fall into the gaps because
>>  	 * we have a flag
>>  	 */
>> -	tasklet_kill(&dev->bh);
>> +	disable_work_sync(&dev->bh_work);
>>  	timer_delete_sync(&dev->delay);
>>  	cancel_work_sync(&dev->kevent);
>>
>> @@ -955,7 +955,7 @@ int usbnet_open (struct net_device *net)
>>  	clear_bit(EVENT_RX_KILL, &dev->flags);
>>
>>  	// delay posting reads until we're fully open
>> -	tasklet_schedule (&dev->bh);
>> +	queue_work(system_bh_wq, &dev->bh_work);
>>  	if (info->manage_power) {
>>  		retval =3D info->manage_power(dev, 1);
>>  		if (retval < 0) {
>> @@ -1123,7 +1123,7 @@ static void __handle_link_change(struct usbnet *de=
v)
>>  		 */
>>  	} else {
>>  		/* submitting URBs for reading packets */
>> -		tasklet_schedule(&dev->bh);
>> +		queue_work(system_bh_wq, &dev->bh_work);
>>  	}
>>
>>  	/* hard_mtu or rx_urb_size may change during link change */ @@
>> -1198,11 +1198,11 @@ usbnet_deferred_kevent (struct work_struct *work)
>>  		} else {
>>  			clear_bit (EVENT_RX_HALT, &dev->flags);
>>  			if (!usbnet_going_away(dev))
>> -				tasklet_schedule(&dev->bh);
>> +				queue_work(system_bh_wq, &dev->bh_work);
>>  		}
>>  	}
>>
>> -	/* tasklet could resubmit itself forever if memory is tight */
>> +	/* workqueue could resubmit itself forever if memory is tight */
>>  	if (test_bit (EVENT_RX_MEMORY, &dev->flags)) {
>>  		struct urb	*urb =3D NULL;
>>  		int resched =3D 1;
>> @@ -1224,7 +1224,7 @@ usbnet_deferred_kevent (struct work_struct
>> *work)
>>  fail_lowmem:
>>  			if (resched)
>>  				if (!usbnet_going_away(dev))
>> -					tasklet_schedule(&dev->bh);
>> +					queue_work(system_bh_wq, &dev-
>>bh_work);
>>  		}
>>  	}
>>
>> @@ -1325,7 +1325,7 @@ void usbnet_tx_timeout (struct net_device *net,
>unsigned int txqueue)
>>  	struct usbnet		*dev =3D netdev_priv(net);
>>
>>  	unlink_urbs (dev, &dev->txq);
>> -	tasklet_schedule (&dev->bh);
>> +	queue_work(system_bh_wq, &dev->bh_work);
>>  	/* this needs to be handled individually because the generic layer
>>  	 * doesn't know what is sufficient and could not restore private
>>  	 * information if a remedy of an unconditional reset were used.
>> @@ -1547,7 +1547,7 @@ static inline void usb_free_skb(struct sk_buff
>> *skb)
>>
>>
>> /*--------------------------------------------------------------------
>> -----*/
>>
>> -// tasklet (work deferred from completions, in_irq) or timer
>> +// workqueue (work deferred from completions, in_irq) or timer
>>
>>  static void usbnet_bh (struct timer_list *t)  { @@ -1601,16 +1601,16
>> @@ static void usbnet_bh (struct timer_list *t)
>>  					  "rxqlen %d --> %d\n",
>>  					  temp, dev->rxq.qlen);
>>  			if (dev->rxq.qlen < RX_QLEN(dev))
>> -				tasklet_schedule (&dev->bh);
>> +				queue_work(system_bh_wq, &dev->bh_work);
>Correct me if am wrong.
>Just above this code there is - if (rx_alloc_submit(dev, GFP_ATOMIC) =3D=
=3D -
>ENOLINK).
>You can change it to GFP_KERNEL since this is not atomic context now.
>

Thanks,  the usbnet_bh() function only be called by usbnet_bh_workqueue whi=
ch is sleepable.

---Jun Miao=20

>Thanks,
>Sundeep
>>  		}
>>  		if (dev->txq.qlen < TX_QLEN (dev))
>>  			netif_wake_queue (dev->net);
>>  	}
>>  }
>>
>> -static void usbnet_bh_tasklet(struct tasklet_struct *t)
>> +static void usbnet_bh_workqueue(struct work_struct *work)
>>  {
>> -	struct usbnet *dev =3D from_tasklet(dev, t, bh);
>> +	struct usbnet *dev =3D from_work(dev, work, bh_work);
>>
>>  	usbnet_bh(&dev->delay);
>>  }
>> @@ -1742,7 +1742,7 @@ usbnet_probe (struct usb_interface *udev, const
>struct usb_device_id *prod)
>>  	skb_queue_head_init (&dev->txq);
>>  	skb_queue_head_init (&dev->done);
>>  	skb_queue_head_init(&dev->rxq_pause);
>> -	tasklet_setup(&dev->bh, usbnet_bh_tasklet);
>> +	INIT_WORK (&dev->bh_work, usbnet_bh_workqueue);
>>  	INIT_WORK (&dev->kevent, usbnet_deferred_kevent);
>>  	init_usb_anchor(&dev->deferred);
>>  	timer_setup(&dev->delay, usbnet_bh, 0); @@ -1971,7 +1971,7 @@ int
>> usbnet_resume (struct usb_interface *intf)
>>
>>  			if (!(dev->txq.qlen >=3D TX_QLEN(dev)))
>>  				netif_tx_wake_all_queues(dev->net);
>> -			tasklet_schedule (&dev->bh);
>> +			queue_work(system_bh_wq, &dev->bh_work);
>>  		}
>>  	}
>>
>> diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
>> index 0b9f1e598e3a..208682f77179 100644
>> --- a/include/linux/usb/usbnet.h
>> +++ b/include/linux/usb/usbnet.h
>> @@ -58,7 +58,7 @@ struct usbnet {
>>  	unsigned		interrupt_count;
>>  	struct mutex		interrupt_mutex;
>>  	struct usb_anchor	deferred;
>> -	struct tasklet_struct	bh;
>> +	struct work_struct	bh_work;
>>
>>  	struct work_struct	kevent;
>>  	unsigned long		flags;
>> --
>> 2.43.0
>>

