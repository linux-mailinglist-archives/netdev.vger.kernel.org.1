Return-Path: <netdev+bounces-257901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN1zJJaJiWmV+gQAu9opvQ
	(envelope-from <netdev+bounces-257901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:15:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A7810C5F5
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8D83300650E
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EB62E7F39;
	Mon,  9 Feb 2026 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrQbO0C0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7122D7B9;
	Mon,  9 Feb 2026 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621331; cv=fail; b=iiy8NS4XJ9DXTt8qhZbpnWwz+h3PpHUPMMpEF9PBohBS9X6zfD0K8XMmeY19QGgvfd6o7tuN8jjIJyojTOxrEjqnOJYGMSDOBhdwxeRUN2JLnbNLC0JiU+TqeBW+NPK4dV6nXUxauvBwma4DBsmQ4bUrBvwQ4qTRbzJw9J0iev0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621331; c=relaxed/simple;
	bh=KYlQCAnDNhlcKxGElFSe+6Qkd8y/foUaLLRk0SWuVAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EwETKCSpxh5av86JfGNI/PJsk95xKrDfZR6EQhegaqbavfgbjbF9LaCdrKsnKB6Gs1qJGwZUvHv6mbnuE06USjC2dKhKMRCwZ0t7R1VQUj0nIONUDlke1Yh2xBUYLjBERZFZ4ZjG480vayCsoPe4MH3jJDoF8KsE3hmFiUDLUrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrQbO0C0; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621331; x=1802157331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KYlQCAnDNhlcKxGElFSe+6Qkd8y/foUaLLRk0SWuVAw=;
  b=SrQbO0C0qFZAFtMD0nHcJrfOYWH+YsPbXm9XRXSRbyP4GLSB0TLFOcSN
   3tghmP27REorRNXzzmaqUMD82k6+QJkHbAwFU3En5zolI44xsRn7BEMVh
   m6x4N2N4cPNXcbEGoEvVdAKAevgL9+eoUR5uNiltiFqOtA4JiIBLF3YJ5
   MJYZ9f3HX3DHuDbbCvculuTTRFsX8g29/zDdGY79jMdxGIvwBgkJLCtG1
   Z+8Nxw1Lr0yhU2GUvVH7Y7Hml9ygzcgpxMp1yet2ApE0ta3LRG92J9aNd
   bdpBrYx2K5KPpp7/qC09JAb21lyiL8Zt7FG3BbvC80OxGjqJqUOSvoMj9
   g==;
X-CSE-ConnectionGUID: rNhzH1ivTlaqj2OXa8jVbw==
X-CSE-MsgGUID: r6zX4K6SSN2v2TLuFScQxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75347540"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75347540"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:15:30 -0800
X-CSE-ConnectionGUID: 5T8FP85xRGWU5feNJyRr7A==
X-CSE-MsgGUID: WLqPkEYORCGl97EKXZAtqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="216001802"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:15:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:15:29 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 8 Feb 2026 23:15:29 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:15:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgkgKnbZCefK9Y/JAzOdBK14e/fLiJ6CNlFzJO4MAvca4GsYnAFKpvWlTX7u3f5krKDAiXR/bG9SIxVUV65v8b6qELTvEZIjpV3Sd7blDhfpI+2v7Qzv3/cnf/GKMRsdWXrID1R5UC4smC/NgeXvzEsKDZHyG9IjUfMfm9Oq0duyw70erl6ox/zM+Kh98xd5YYxWUU+Ye2K+ubRrd6XurDWr1bVR2f/jDf8nSo1Hg5hvV/28BHcmLQj+v9YVWskw+QxZ8xWWPZxnI/KB5t8g1shcg0IqYj/8oR5hY7FGt2BCZOQ2wXk7yVK5qSKcgDIqhwiYraGhETdKl3RHZPlNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsUrZTgY1V7iuWKRjz2x5TfTUTADVIb3U6M3FfOrUcI=;
 b=b+ArnPlXg1WOwzq4VLCDJ1wNoZagf1xCQzNYN40hcK8kudceKYa1NVFfVtNsda1TBtchivftuT30aH2FrAmXCfiSd5KFq9G21WqiM/cc+FOIDduUJGJ0jjJB7ou3o+O1LHPyvlc5BCB2v6hBxop/uQpjGwZF0R/YHk5FJF7D1VRxlz1jxcKBaTQSOxkiFqU0d6nMv6fBE4y5rke9QQ4zBpA4ctJAq2HBRrge8LtMdlAxk5Hzgwt0Ss1LO+7Pw1p9jmyh1PzK0rWnRF1ClO1gxinxASkhGltPA0Dy4kMfKdjNnnX3ERs6KKUc+usJUm7Tko/xSZkdCyk5ALgkU/NvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7629.namprd11.prod.outlook.com (2603:10b6:8:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 07:15:22 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 07:15:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "shaojijie@huawei.com"
	<shaojijie@huawei.com>, "Oros, Petr" <poros@redhat.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] iavf: fix deadlock in reset handling
Thread-Topic: [PATCH net v2] iavf: fix deadlock in reset handling
Thread-Index: AQHcmBvIrBQyI2/Gi0C7Wq7yVNrxn7V591Cw
Date: Mon, 9 Feb 2026 07:15:22 +0000
Message-ID: <IA3PR11MB89866E59AAA33A502D596830E565A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260207102245.812795-1-poros@redhat.com>
In-Reply-To: <20260207102245.812795-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7629:EE_
x-ms-office365-filtering-correlation-id: be377316-dbee-4d63-36f5-08de67aafd7c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?NG4dV3dIDQxKZkab+jWRfYyOWQpcl1JV6wBWKvqLnGoZaueozP5jP0+k3yml?=
 =?us-ascii?Q?wGc48GLKjAYdXWU/XUl8BiusHj8l1AaUJl7mZl7kqLrW4Tv8tsSQ5Xfn9zcZ?=
 =?us-ascii?Q?icr/qh+LWXGxp+FTXjQ51y885ik0UssAMS87Lo7tWhb5SvO3ksW/EwR3DvLo?=
 =?us-ascii?Q?4h8dPcvJ67EC3PocZEO3Ua165aNk41khx6ncZnUFAn9/Xbm1ylR+D0hMwR3X?=
 =?us-ascii?Q?IpjC+C9vrBbIoZ3c3I40l5sy9zkucDsPJ1RE5New+O61NLsRc8fv2Irbbo9b?=
 =?us-ascii?Q?4B6GTcW6MiO6E7HXsM9NhAVHTWKhpqPeSAwE+xUW5nW64aHqRoD+BxgdOz+G?=
 =?us-ascii?Q?D6OFqqCzNnHFxpZu022ZaI5bpDfDDzKKqgMwEWrlu27WXctaylsadO70NYJL?=
 =?us-ascii?Q?wrQqvYODvELlRK4Vsk8BB2rhNrAi+dGFenaAaNpd5aoI9ODe9yn7cGBPEj0q?=
 =?us-ascii?Q?+VyE4QfvyeHXWf1glphMYMnC8HAH2EVnqQgFBLJ4BTRjIbqcTN3Fxb/xqRNQ?=
 =?us-ascii?Q?0G90wZt571y36g4yYQfLZuxNA4SBIDMKSeBPJnbeTBoeQocAU/e2Xz4l0w0k?=
 =?us-ascii?Q?1En86f68rb1COGP/foTv4km2DT1Cu/j+oTmT3cSOccMGxGyE7ZHLhinZIlg5?=
 =?us-ascii?Q?V9uqb81zxAadB84UpKSoHiFvIqtO2jEce8riIUZ16Sc2dZG88d5LVcm/VPix?=
 =?us-ascii?Q?03uAIyduUUx9AXdY926QLXcF5VKGMFNM/Cwv07aWfpBOiq5fR3voELHLEz8f?=
 =?us-ascii?Q?BvRlBvbIDdG1CdqAHm4H83rRkTCwg6JtftRp4CL/rW0SWjRJpAhkgm1Hcdgp?=
 =?us-ascii?Q?yu0ObW9vGLhMvHskxFZie4LYuWSeYBq8lU9reR9dbPtG1C3VCKSfJAj1MUWA?=
 =?us-ascii?Q?kfFWMKxBrBjAa+gA9CuIFnG3ehkeTkt3FKKavBBp/e7/UXlX8aktQcnob+S5?=
 =?us-ascii?Q?1RmnFiQyyL6zk+ILnyeDzkAcsg0hvborfBe8x6Btlm7BS5bHhGDGmP1Lr/cl?=
 =?us-ascii?Q?slYn2ubbdt3hsmxbjmbcDrXNDmsYmPraOlRWSOlP+Nkggp3hntc48sKjocLP?=
 =?us-ascii?Q?Ctkw+UftbZV/W+CEiuXPsHTHmZQi3Q4CHv5gKPWpdhtbpttPULkSLhZllr0S?=
 =?us-ascii?Q?65lLY7G9C2fjgWKb1NMnQv/cEE32yspqgzWnqltRYFjkcanllGkxUFw74+3o?=
 =?us-ascii?Q?S824z6zAG05xXge/vObXatIW9HOZ30WMIf6P6futTFdlC4Szo5CApOWhVY+v?=
 =?us-ascii?Q?5YkS+cVOvfrbKXGXcESuHRKuIwNHnHWA2WD3NUfw+/EO+2/AqZQkqVr31usj?=
 =?us-ascii?Q?NnkM0MYUQg7sfs4yqKx+iOrIV0H/3a59eGyoiMb/x6MrA77jJWedntrwRkgN?=
 =?us-ascii?Q?QkDWGvS/bMBPzc+hrm2E3Z3qTLq0fBuMNCDArh0L16S31LrLvPxE+0iv8ozx?=
 =?us-ascii?Q?X5kTHHZqTQ8TDOkQ4YxgSBuGuo7RxMl8Ojke1wVvlfYLk9MY8O6froa3Gw98?=
 =?us-ascii?Q?cd0p8m3OMM0r+4Sntd5PiluO9BIemmruYQYyVDlC33uzvn+/QPkeOYaRc17E?=
 =?us-ascii?Q?Dd0CvWwBF6oLdW9hFdd12g5TpZZ878HrpQ3sipNImz/YTCP8f8wzjAhxIVe5?=
 =?us-ascii?Q?ZMMiHqACuhBVX4C72l8Kwvc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7/U2UYP6n+cYwVkerbnB9aSptUQKBfznFm8QCqyZ+CKLO1gIaNIjhvjMk9ek?=
 =?us-ascii?Q?Hol5/pnVULdI2B3Bj9g9P13WDTiZefDkB81ZzX5jEJH/45WA0fXJ7eGKd7hK?=
 =?us-ascii?Q?KvLXXS22lDQN6l/uckwG8BBs9H4zSYMBkmXV8jesNqNFdVkv+QwvWQ5aPCky?=
 =?us-ascii?Q?mA12t275a1wp1Qz+jajnXFy8drYjzL6GcQk/+9mEB8SNmbCd7b6+ovqSujEn?=
 =?us-ascii?Q?D14PkA9SSVhWWjBUp4ox8Kq/vCJAadrOOT1PstodPioy+CkdJJAvxhcPdH/s?=
 =?us-ascii?Q?uhJL7OhpAyC+Ryjjf13LTd06XWpry//o6Wkv8TZ05XAKkQy3zmQBhCAIRi3U?=
 =?us-ascii?Q?jQ5iJqbpX9/7hMYZy8fkuB/cwdweebjsn4cv6M+nHSmeBoo5DtnhIxkfGLG5?=
 =?us-ascii?Q?Rsbue+RNLHLKjz/Qe0fZAE8scY66OQDv8j1tewDYZ3DJltvaD5Yk/syr0qW/?=
 =?us-ascii?Q?+G9I8/Nx3kfISWV/t9mrTS7331cehdoF/OUuEJj3UMePGM/irEeY0s/mKg6W?=
 =?us-ascii?Q?P8pr4Qa+2w3KqF4Bt6e90U9c++XRDyPzFPBwCNiiT6f1zIU5OVzDARvHN9e2?=
 =?us-ascii?Q?fPugElW2hBGF7kXm7hApj7qlbFc838w6EV87uwdMVQEoGt0YyNYxZvAvb8vl?=
 =?us-ascii?Q?V+7w6xlV3KSCPSZfUYdRw64Hi0Jmemd8f6k2WEk0AdI2jksGOWqnxihR1d/g?=
 =?us-ascii?Q?ptePQfalbUkcMr3iczTFVdS2oHx7EzUB3nVqsFlf5X7S5XYznSKy+HpuUBoa?=
 =?us-ascii?Q?yyt3IsonK7ux8EES5egjeU86zOzVnikYmzOpDYRh329Jv3rJo8fKvL76BHYx?=
 =?us-ascii?Q?MGIjH5WAWaai9VnMH8Z5hoUeHlUYnJfQmEQSaRlryTRbVTWc9+5plAo+znTR?=
 =?us-ascii?Q?leoFWGWOtq1PRvMtrsGStZ3fou6FHqzgkYcp14DKz50WD2mxhpQoEAM9Pq6a?=
 =?us-ascii?Q?sjESOsAjV6ddX+/qblEXC/qhRQNjIuogBEyHiGbuv1QWPXjG70D4D6K+CpYe?=
 =?us-ascii?Q?joX+oFrhAzSHJ5ugANuLN5vgZxN+w/FjUNQUg09b2RBG8b3kY4karoDbqwGV?=
 =?us-ascii?Q?dieAr8/bkFBwxoqXSn06IPLQpf3fFE8HejTKOBUebypyWbUUJVy6rC0hexv2?=
 =?us-ascii?Q?AJU2YH3P7w8FDAgHLOoteF7iDk9kEeFB1Br1L8ZtrlvzBGurW4YJA6IWA8yu?=
 =?us-ascii?Q?42BeF3DMCnMI+ZALUcD0fF+Mh+jaoeA8Y2uK/AaKLvr8tcGlEUEqdGX+gVic?=
 =?us-ascii?Q?XQ+FugEs4nShJnCDsYwFOzv3SOrlN+9CocP1/6XZH9XJNNxsOcZrHHkRk5ll?=
 =?us-ascii?Q?4DfEaluXHPU9GiVNkf0BzblB16vBeBmWzMSV7z5SqoIILj+j0Z1GYMvrVY11?=
 =?us-ascii?Q?nc2ckhs7C/gYbToGYUq0vp0ozH6mFurcQaX5UxmkEJFHBRtZVidJXW92P0t8?=
 =?us-ascii?Q?QFIX3UEybuC3mC67K3zZp806U0VeIpdb9zoo+Kryc6r1R+00OIO1QNkYRnOm?=
 =?us-ascii?Q?d6j/kQYKpWqo7LEh9DjXLFdv4xn6g8RXBB9usBXH3qiA5zG9lUuBeTZyscns?=
 =?us-ascii?Q?kAqRIyCf5tPxt8UHtNQaN6LfNMcx+lDF/cVymmOsCY0oZWv7X6C16kmcb5IL?=
 =?us-ascii?Q?OhCsyvfy2cjK6/EHTf5FeL/fk6Q9CSo0x/cEPCgmbMUFBGBRgw4rDx540hdH?=
 =?us-ascii?Q?iWosixAdn3VBLBkqN3tvWVDU1SS3zoqFU838kV61bjsX+9fCHx/EeU233Udx?=
 =?us-ascii?Q?6o1wdA2HJScbOcGQaxkeAojQzhbJ39w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be377316-dbee-4d63-36f5-08de67aafd7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 07:15:22.6858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBPdcJkal1b7G1s0+EgohBAgFXrxazOSmjx/HH+K9WL/ndoug6arDMqdvkqXg3EjhcQFHImlQp4SD0/RI9o78IFSBNcsNbvWIMCD/LSGTk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7629
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257901-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,fomichev.me:email,davemloft.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,IA3PR11MB8986.namprd11.prod.outlook.com:mid,osuosl.org:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.942];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F1A7810C5F5
X-Rspamd-Action: no action



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Saturday, February 7, 2026 11:23 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; shaojijie@huawei.com; Oros, Petr
> <poros@redhat.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Stanislav Fomichev <sdf@fomichev.me>; intel-
> wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [PATCH net v2] iavf: fix deadlock in reset handling
>=20
> Three driver callbacks schedule a reset and wait for its completion:
> ndo_change_mtu(), ethtool set_ringparam(), and ethtool set_channels().
>=20
> Waiting for reset in ndo_change_mtu() and set_ringparam() was added by
> commit c2ed2403f12c ("iavf: Wait for reset in callbacks which trigger
> it") to fix a race condition where adding an interface to bonding
> immediately after MTU or ring parameter change failed because the
> interface was still in __RESETTING state. The same commit also added
> waiting in iavf_set_priv_flags(), which was later removed by commit
> 53844673d555 ("iavf: kill "legacy-rx" for good").
>=20
> Waiting in set_channels() was introduced earlier by commit
> 4e5e6b5d9d13
> ("iavf: Fix return of set the new channel count") to ensure the PF has
> enough time to complete the VF reset when changing channel count, and
> to return correct error codes to userspace.
>=20
> Commit ef490bbb2267 ("iavf: Add net_shaper_ops support") added
> net_shaper_ops to iavf, which required reset_task to use _locked NAPI
> variants (napi_enable_locked, napi_disable_locked) that need the
> netdev instance lock.
>=20
> Later, commit 7e4d784f5810 ("net: hold netdev instance lock during
> rtnetlink operations") and commit 2bcf4772e45a ("net: ethtool: try to
> protect all callback with netdev instance lock") started holding the
> netdev instance lock during ndo and ethtool callbacks for drivers with
> net_shaper_ops.
>=20
> Finally, commit 120f28a6f314 ("iavf: get rid of the crit lock")
> replaced the driver's crit_lock with netdev_lock in reset_task, making
> the deadlock manifest: the callback holds netdev_lock and waits for
> reset_task, but reset_task needs the same lock:
>=20
>   Thread 1 (callback)               Thread 2 (reset_task)
>   -------------------               ---------------------
>   netdev_lock()                     [blocked on workqueue]
>   ndo_change_mtu() or ethtool op
>     iavf_schedule_reset()
>     iavf_wait_for_reset()           iavf_reset_task()
>       waiting...                      netdev_lock() <- DEADLOCK
>=20
> Fix this by extracting the reset logic from iavf_reset_task() into a
> new
> iavf_reset_step() function that expects netdev_lock to be already
> held.
> The three callbacks now call iavf_reset_step() directly instead of
> scheduling the work and waiting, performing the reset synchronously in
> the caller's context which already holds netdev_lock. This eliminates
> both the deadlock and the need for iavf_wait_for_reset(), which is
> removed.
>=20
> The workqueue-based iavf_reset_task() becomes a thin wrapper that
> acquires netdev_lock and calls iavf_reset_step(), preserving its use
> for PF-initiated resets.
>=20
> The callbacks may block for several seconds while iavf_reset_step()
> polls hardware registers, but this is acceptable since netdev_lock is
> a per-device mutex and only serializes operations on the same
> interface.
>=20
> Fixes: 120f28a6f314 ("iavf: get rid of the crit lock")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  2 +-
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 21 +++---
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 72 +++++++-----------
> -
>  3 files changed, 33 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index d552f912e8a947..0c3844b3ff1c86 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -625,5 +625,5 @@ void iavf_add_adv_rss_cfg(struct iavf_adapter
> *adapter);  void iavf_del_adv_rss_cfg(struct iavf_adapter *adapter);
> struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
>  					const u8 *macaddr);

...

>  /**
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


