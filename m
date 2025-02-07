Return-Path: <netdev+bounces-164220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16623A2D08F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 23:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A072216C56E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CFD1C700A;
	Fri,  7 Feb 2025 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTWomSfk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A31A01C6
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967683; cv=fail; b=WcCRGZFI7OMBlZoTZ961H/+PDItBU+qV64mZILTBe7Zc16VdMpQhtGrwzDgT+JNAACRhuX6ZmGYag6Xz4yKGLHI+pulrHJUI/CvnFLPHX5x6INSXD8GhduvrweJAQdVuEYArGIdOYS3xLADCXzMIc1uqV0LjuqCdOmFnln1yIrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967683; c=relaxed/simple;
	bh=txTPOn7kTd1iUPS5MMGe6OVUJmyGEKrQ1PsDxQ6QOnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKqmbsA1w+yPhkpSJCyYW42oWpNzdsc25wCvpvorVF8VkYPmEsS7i4VCF/gUquyDj6JmZbQFvwOlVd5I0jrarYyeArJZ6mC6742dpWDbqpQcKMlUvjV13Vk8vsEF8srLkKDdkTxi3RSP6oh0YrHsj0T0Zk45t/YpDU7nksW2CkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTWomSfk; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738967681; x=1770503681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=txTPOn7kTd1iUPS5MMGe6OVUJmyGEKrQ1PsDxQ6QOnU=;
  b=jTWomSfkpaXiGa5cDx4EUbU9pK9FVJpfoSkl/mLMV2PBliIvN2UA9jo+
   SMGskjZvrlza/CGA2J1R8N3FqOGP1RzABeLaN2m14gwDw0EyISHNNOLaj
   adxyRlX68WcHkXtap/JCt+EbuPaTa8W8tkAo9nCHnpRPo6v2YkRm9tsb8
   rrI+wJPvAZev0b2mnjm4UZfbeElbLSGrM3bfKKdZ+u9MaKUVG0RT6d7v4
   SMo+vqKkOABmFw8+ZZac1HpMdJtySiY6CSKWBhJucG/oN7So3k8WZwxRp
   MK9dMCZtVwtCnnhkv1xvvxD3Tfa7gatNtut+udrnDZG39EGife1Dts4GU
   A==;
X-CSE-ConnectionGUID: 0mWMT2vMQ7epzplKpGMv5g==
X-CSE-MsgGUID: iWiCzetERkOc8rrm0ZYGIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38853883"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="38853883"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:34:40 -0800
X-CSE-ConnectionGUID: 9iOy5z0tRdWyEXxzkM47dA==
X-CSE-MsgGUID: 5aTcnpXMSDm9ESQzpzeQFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112535084"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 14:34:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 14:34:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 14:34:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 14:34:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5LqwqR9Blj4XED375z8YcqAa6lcJxy5u4ECCPtkSl+eJoTQ9r6DF8ehJlxdn3CNddTnxzfVGqQim9FfqV5iKtnspGRjZ8sj0SAgQyyBQgMNi6wIlWuWpnukaA513ZWOh/xWRiRWi4oIymvSQulkrY1voF/D0MwUSgSIIB2m8y6/LhWPFYQaEhmJOGfao74k93Vsnph+mxOkaUmH7c9h1J1sdI0hlorQkOR/imTS6vbUDPwV3Yx9fW4lpOCRl8sXS5AqFgK2YFWFsnzeYgzHvFRUp49KATT5/WMvmoDo0M9XfYPUvrTpeR4Pda6dLdAHjDjbwaTQBUGPEzQkZVL+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8qykR5Itn1CcK0kXOksakMNoNZGSaBEqLVgHI0ngSY=;
 b=kVD9s3K+aUltOF8DKV8oNJbF5Bcspmd3J2YUxM+4YiwgbvHdG2JVgMzMOUuFwCTI5kmIOw5H+4wZoowxFjgaHwHyIq6dQcWfCq013b8KVVYphirENjkAB9/omdTObeBwGvhjUKDs58AaOcVVVlJhPpZioxpEQyvUGwbOnHWPu064SXLHAlOnegw2lVpOPVyiU0xrND4R1mRgliRgiMyznfiiPPejfMQxvNo1olVZOGXMx6nsY4EkphC0ofLnAhJopxtn7VqKS+dvXwSllZG6j4o6eRF3oImmerZyyfkIlTWIAX4pzcU8xzbEQHmZVu1OLrUqySDNUxVYjtSynuJYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by LV1PR11MB8843.namprd11.prod.outlook.com (2603:10b6:408:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 22:34:22 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%4]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 22:34:20 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Olech, Milena" <milena.olech@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v5 iwl-next 00/10] idpf: add initial PTP
 support
Thread-Topic: [Intel-wired-lan] [PATCH v5 iwl-next 00/10] idpf: add initial
 PTP support
Thread-Index: AQHbaN1MyCTISmPTs0eUem8CCcmgIbM8XSnA
Date: Fri, 7 Feb 2025 22:34:20 +0000
Message-ID: <MW4PR11MB5911A7A18F6CF163CB582D6ABAF12@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20250117124109.967889-1-milena.olech@intel.com>
In-Reply-To: <20250117124109.967889-1-milena.olech@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|LV1PR11MB8843:EE_
x-ms-office365-filtering-correlation-id: 31ebce01-9986-4e34-7230-08dd47c7908d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?tP/oIxoA1LkxXZ9bLcWiOQSvqUjbYuG/1rJwLNDySSzhRDcvgbFNH74+t8OY?=
 =?us-ascii?Q?H1m2hLBL15irUxrMCW9aVmnvKab5MhJI2RR7PywUiVi3NO6dTa4qu24BuY1l?=
 =?us-ascii?Q?9q0f/pJ4+n+6DqrVdaR5HB8f5Cjd3CSrNyNQDdOgKUQruhDr/0kc1urvcv7c?=
 =?us-ascii?Q?UyDmWobfpDnPqixhrigZDqBvLLBYKH3lXviFaHWcDIdVXDoE3S/f/bEHIWgm?=
 =?us-ascii?Q?sz8Q5fB4RHNilnb+z0j//TrLVbu7w+UV8LULpXhFW9vmkWS0RdpPAfUmkc5d?=
 =?us-ascii?Q?I9Q3uegeM8fVPgk18BXBv6hcEEH4v3UxOi5dxFmqg0Thjut60yq1XVq+Dd/W?=
 =?us-ascii?Q?cQTNkUm+pInNbB522R0yhVXT5LBf0Sm/vRWKyVe8CUuYvOq7ZZwGDKXBKONT?=
 =?us-ascii?Q?YYBsat50ecPdEKCFmxeufWWMlp0KeOL8eBA6dsuM2wOGqM+0Oysyl85+yfp/?=
 =?us-ascii?Q?boDMyZZxtoeL60d9TDaCL46IopxBwPQMaDLeXrvEe8+H0MCtZrfq6Dw0Z4Lp?=
 =?us-ascii?Q?42qzktegN/2ff6l6zP+14e+u6+FvhmqovE1E8sf9a1J9rSXInRWN2KoTYiKL?=
 =?us-ascii?Q?Gj54y/lKzaJff2z3vfaPC3cf4wY6UvA1+hohNo/SOQN06b+Voc6TWilVWzYF?=
 =?us-ascii?Q?N2PVWpaeqU3fw+YWztqaONSwAAjKQszjg3aWLSJORkWo7W33gLdSzF3FLy7+?=
 =?us-ascii?Q?8ZoUGMbW8+vFLANgfuC62e/nGvjXgZZqFTInyKCoAhs5B5Yaq3OKQwJMu9Vc?=
 =?us-ascii?Q?4X8WV10h/P3TzUUvRLh0nmno+71GVP5UT7OPqtNB5wSLWea+odTxBcELF0HX?=
 =?us-ascii?Q?IqePjUbbRkPWaPCOUGXhEfHIFBgc9pT+iFDKt4rel3qmKVMnNL0YKdd92Y/3?=
 =?us-ascii?Q?yXgCwRX10pXxPfwiQ4VpCLVHo3F8tPw5cqiKkhNTt7rg5U9Yu7U2Z/U13c91?=
 =?us-ascii?Q?Bh0vqguJ5zNLC8iW1ReXfwc1a0rAroVNlONhjZcT4vqptK44pQTlscpEe/e3?=
 =?us-ascii?Q?KsZucHOJ7ouTPshcWPu+h+IthdMeoTM+MJCZMqkE1KgfMkuVAJx7xMOx1tpy?=
 =?us-ascii?Q?gdfTadbhhF1E8yK49u45jwxVrN0vH2CxfM/U5ssDatKh3vr6pyMbyYg19usm?=
 =?us-ascii?Q?LUXUMx/yH2xhm4UI0pzLpGbqfcE4NnrWuNguk8iczoajAfGjDQN+Y7F/PDXl?=
 =?us-ascii?Q?Gor7Q9sImNcCSsfI5Mp3W0jqt3Vb6UWO+19SN1QD69zqd8TS1yvGsnxlEQbM?=
 =?us-ascii?Q?S2H0jl4uvEkDL60W9h+VXgS+2qZ/wCgZUbh5Wacz26+5h2XsUtRKZqcPYI2S?=
 =?us-ascii?Q?omCSAdvtrFfDYYuf8hvF8nt9N/RJ4hN0GiRPw8L1SomHG3ZJSO3okbN6S+YG?=
 =?us-ascii?Q?sv9kF5d4AwYglD7cQWx9SyEDOGWoZhNfr36ZdfPwmTVl+GsYoGQdjB+BP3qL?=
 =?us-ascii?Q?FvaMXT+TVBCw/P4pnE7UK8jBi+O5Y+qk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eYz2amRljnmzEwyMPA0g4/6EPczl14MHFohmwMiEWiOKNqKXhLH+/sTDm3Hy?=
 =?us-ascii?Q?BigOyKzO96CLISCKceb12ctmWY9AxfbMOO5xOO9qpiUQAhAJF4dDqdYO66D6?=
 =?us-ascii?Q?EUBIr5yzm03WxCo2DfxxEdHJLn0FUUmAOygI8r1kEM6Db7EK6NyV52luNyoX?=
 =?us-ascii?Q?w5xzTCnJcSTbMHTbNqgCV6qJCUZDjkuydBhd5I/Gi6QPBA+/JNupgG52L6Mz?=
 =?us-ascii?Q?6/xroRvw5D/V+g7USOai9gsVUMZkgSOJbi/ojemFMzJSwsUl0xiF4A7zbdcn?=
 =?us-ascii?Q?XBEZUnLGxUjH//u2ZuJCLV+f5cJtxpIryQP6RgvaTELcsElYCZfpKkijCOF1?=
 =?us-ascii?Q?PhbJI+SQbMrCEOAlh5oB5S0q5J7srum0JsCe03Fq+yegphWA0o8ZAejiJtWg?=
 =?us-ascii?Q?MleenxYrodfJ5v+MGg5ssAH2YXls0FyiQe9lpz6VKIFXO02EvEqoYzlua3Z+?=
 =?us-ascii?Q?mNb5hPiBemO4KGNXXNDwZxywkqV7pN5IT+qBMJTpsD6TH9+bTkh0zyl3knyf?=
 =?us-ascii?Q?MjcaZjST7ioFM6shj3oXFFz8ow+q4K+b742FUpyxVxCWsSdTaOIW8Xw8nMTH?=
 =?us-ascii?Q?6p1O7EAOHAw6UpYVXJX9aaYlPivWdJI/2CQdrE1QcWYO0r+RvJ2MAhgJeG/e?=
 =?us-ascii?Q?+AbzIoOy/Xk88t+vMYRwZLSH0z8RRyjAa8KhnG4Drn4wa16SVSaxrGSAm5QD?=
 =?us-ascii?Q?l8bq72Fi3hEZURV/XVpKIaIdvnWuZ6z4EqoTdWvnI8J7ZoGUvPWLq1oLRk+L?=
 =?us-ascii?Q?g/+naBjbaI6TlLheos3hQNnfucEqecZkBJ/MPMaZPl60udsPCJ0tzdDXR9M/?=
 =?us-ascii?Q?zYiXHUTG696wDfBPH0EdtxAO7GzTBTWWtPvsmld2plV0XlacLcw34AuRXHML?=
 =?us-ascii?Q?PqjtPG2WW0zucaqFAu7PZws1mebq0igzUWRJu8uJlQdjMzXAHNNeXXMc5DCJ?=
 =?us-ascii?Q?T2T/jKdtzEDIgJTeWoL9Ead/P03ajXAg1ushiagqdVmXZH0ISFE9i7u6rMiG?=
 =?us-ascii?Q?W2rM21/DLkcyEnfKPjOYTMPwGJdiPsoqJiqxCc7v/niLwWKlDTqq0Unu77eF?=
 =?us-ascii?Q?8HiWTXDvj8St4IUrBVrwAAHVWOEYBmJGYzJgBPed722AmVPzwT/xQLokgQI/?=
 =?us-ascii?Q?8I9yKKZ/BhW1Ho5dAXHGSULVIjQebENENfDNBrrmYcZVzHY4MOalqqZr9qAO?=
 =?us-ascii?Q?21aBCL+CFguNt/qHCFRlVVurXhY9i7eYg1mr3ZLZ0FMQKkuMiutnWOC8AGTd?=
 =?us-ascii?Q?A+lT5CVkJNs/AJVr/pq0A7SMTF7QwrAntjEIxx5huzNBfJEYJ3FZnRjOPXCt?=
 =?us-ascii?Q?lN7GlaLgLf8wDl7wxCzjTJPaowM+S46B/N7OJJDRlAL+iAxGFEV6dEWuyHGJ?=
 =?us-ascii?Q?iYb0cApLrWJZnAMdufDKzdskaGqz7cXM5Ydu0LqjA6F7F0yMbv2qe0B3IRBV?=
 =?us-ascii?Q?EiKxdkiA9RneD0GnaTxy1lLLyO4pp8eeoW7ejQsHrW+1AvouqTExu1nua4Md?=
 =?us-ascii?Q?tlKk474J3sGNeToW0THw6PPoxQkdghDOmECOL5u+FABV6YTMlIoWL4BDPNqO?=
 =?us-ascii?Q?JuFcpZj0dN2HYdLJMVowd0Qg4fH3B/6xgc+MPS4T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ebce01-9986-4e34-7230-08dd47c7908d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 22:34:20.5322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/w3wueQJymeCipM0Ae0m2TtlKjgkLAA9BnB/RMR7cNp2TOlJce6mdZqD/Hsl7nNXXKlKtSNYYpmHpPq31sAoPpZ3PCbnP1grAvXHN7Mzu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8843
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Milena Olech
> Sent: Friday, January 17, 2025 4:41 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Olech, Milena <milena.olech@intel.com>
> Subject: [Intel-wired-lan] [PATCH v5 iwl-next 00/10] idpf: add initial PT=
P
> support
>=20
> This patch series introduces support for Precision Time Protocol (PTP) to
> Intel(R) Infrastructure Data Path Function (IDPF) driver. PTP feature is
> supported when the PTP capability is negotiated with the Control
> Plane (CP). IDPF creates a PTP clock and sets a set of supported
> functions.
>=20
> During the PTP initialization, IDPF requests a set of PTP capabilities
> and receives a writeback from the CP with the set of supported options.
> These options are:
> - get time of the PTP clock
> - get cross timestamp
> - set the time of the PTP clock
> - adjust the PTP clock
> - Tx timestamping
>=20
> Each feature is considered to have direct access, where the operations
> on PCIe BAR registers are allowed, or the mailbox access, where the
> virtchnl messages are used to perform any PTP action. Mailbox access
> means that PTP requests are sent to the CP through dedicated secondary
> mailbox and the CP reads/writes/modifies desired resource - PTP Clock
> or Tx timestamp registers.
>=20
> Tx timestamp capabilities are negotiated only for vports that have
> UPLINK_VPORT flag set by the CP. Capabilities provide information about
> the number of available Tx timestamp latches, their indexes and size of
> the Tx timestamp value. IDPF requests Tx timestamp by setting the
> TSYN bit and the requested timestamp index in the context descriptor for
> the PTP packets. When the completion tag for that packet is received,
> IDPF schedules a worker to read the Tx timestamp value.
>=20
> Current implementation of the IDPF driver does not allow to get stable
> Tx timestamping, when more than 1 request per 1 second is sent to the
> driver. Debug is in progress, however PTP feature seems to be affected by
> the IDPF transmit flow, as the Tx timestamping relies on the completion
> tag.
>=20
> v4 -> v5: fix spin unlock when Tx timestamp index is requested
> v3 -> v4: change timestamp filters dependent on Tx timestamp cap,
> rewrite function that extends Tx timestamp value, minor fixes
> v2 -> v3: fix minor issues, revert idpf_for_each_vport changes,
> extend idpf_ptp_set_rx_tstamp, split tstamp statistics
> v1 -> v2: add stats for timestamping, use ndo_hwtamp_get/set,
> fix minor spelling issues
>=20
> Milena Olech (10):
>   idpf: add initial PTP support
>   virtchnl: add PTP virtchnl definitions
>   idpf: move virtchnl structures to the header file
>   idpf: negotiate PTP capabilities and get PTP clock
>   idpf: add mailbox access to read PTP clock time
>   idpf: add PTP clock configuration
>   idpf: add Tx timestamp capabilities negotiation
>   idpf: add Tx timestamp flows
>   idpf: add support for Rx timestamping
>   idpf: change the method for mailbox workqueue allocation
>=20
>  drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
>  drivers/net/ethernet/intel/idpf/Makefile      |   3 +
>  drivers/net/ethernet/intel/idpf/idpf.h        |  34 +
>  .../ethernet/intel/idpf/idpf_controlq_api.h   |   3 +
>  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  14 +
>  .../net/ethernet/intel/idpf/idpf_ethtool.c    |  70 +-
>  .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   4 +
>  .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  47 +
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |   9 +-
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 983 ++++++++++++++++++
>  drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 351 +++++++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 169 ++-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  18 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 160 ++-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  84 ++
>  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 677 ++++++++++++
>  drivers/net/ethernet/intel/idpf/virtchnl2.h   | 314 +++++-
>  18 files changed, 2852 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
>  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
>  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
>=20
>=20
> base-commit: e1e8afea623cb80941623188a8190d3ca80a6e08
> --
> 2.31.1

On testing on this [series|patch], the following issue was observed, PTP ha=
rdware receive filter modes does not report all the supported modes from ha=
rdware.
=20
Time stamping parameters for ethX:
Capabilities:
        hardware-transmit
        software-transmit
        hardware-receive
        software-receive
        software-system-clock
        hardware-raw-clock
PTP Hardware Clock: 2
Hardware Transmit Timestamp Modes:
        off
        on
Hardware Receive Filter Modes: none

Thank You=20
Krishneil Singh

