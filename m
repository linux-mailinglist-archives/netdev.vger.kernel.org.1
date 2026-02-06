Return-Path: <netdev+bounces-257612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LJWIZgYhmk1JgQAu9opvQ
	(envelope-from <netdev+bounces-257612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:36:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A000C1005FE
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507A2309250B
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00A32ABC1;
	Fri,  6 Feb 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mg8iYmvq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D4328B75;
	Fri,  6 Feb 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395375; cv=fail; b=FrQKulQiPO1th0RNbRjx+2qzZFS5v5T9M7/vTq2CyzVgYbbgz+0lSn7obv40GWG1QXc3b0QoedVdMPBUnaDriLqEW44iE9VZwN4gm/HgYMx9/S+NOZe48lBsnu61O5mV/XoxOT7h4tBpnNMy7O75MgY8EQ+fOD2aZEMmrQx/xPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395375; c=relaxed/simple;
	bh=W15+3Jzm35YLhy5ZDWKdtI43BqR/0/aw5LeAQIjHwi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glZlb7ANF9j4PcxXD943pMXzQD/yGWlXIotjXBkCSx9ANTSTe60ffEMlX/WalAbvqOn6OgbbCqgUlHKFjX6QkG0ywJl/1aKowlwFSqok8j61nCzT/R7faD5jEjG4l7XGPT8JuPYNq8KvU/NRoyUuoBxUVJZ4UTZ2F3kLh7DfIak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mg8iYmvq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770395375; x=1801931375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W15+3Jzm35YLhy5ZDWKdtI43BqR/0/aw5LeAQIjHwi0=;
  b=mg8iYmvq4wuhOtO+rBYxmAL8umcysRGIMC4qlFkxF6DXraVXddWM22Lr
   LTU6Bb8C5PCWUYkZo3PMpiO3Lw3Ul1dAgvFhKAUlrqLwMBhtBuv3KCLdf
   NzrmJyKpTPvbvzeWuGlSYgXsu7tsS+Ra36bI2UzeXWCZzbozbxOIYkJPM
   DCv4V/mCTeECYceYpjJPx5mo5yZaQmHh3owwEnAhFDs50ik+nSjsFc5nm
   0KzMAXOQxor+zxndXCTHD5vgdgq0ZOQm3vZLdVsXs7gZ9rgQtiezGVfzX
   23PbSxdri2qRUVdvEjmlKXklJoBaOSnp9cZ/mdAIyPW85Y7ZILrloOzmo
   g==;
X-CSE-ConnectionGUID: 81I82Py6Sxyvi4bLgRUYTA==
X-CSE-MsgGUID: /4Y1kDoKRUG5p0qQSnmATw==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="75455209"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="75455209"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 08:29:34 -0800
X-CSE-ConnectionGUID: gZRAjQfIRbWtweyCyc2OGw==
X-CSE-MsgGUID: huTN7Y3TSmq2Z5KVsl22ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="215427709"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 08:29:34 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 08:29:33 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 08:29:33 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 08:29:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8X03HTEfXWemmBaeqJa4S4amfCWQW9XYulWL1RXrgIg3BF3G0Z6v9mMH31Hw3ux9KEhmB+R02PXBB3liIjq5PUYmzevZiSa74sJpDWBpuIJ0mc3cRtx7JOX92H98tG8v4gZ4JzLeZrWnvPsxyesZf+qSBpBkhDbLeKJSWAGSrhaoLspn1rEhEflMi2+5uiYGK7NPQoU/rfK7pNHH3sP9luwXMQlvrNKehZdywMKxY32PTTYnV32/1vgllBeLScK2VdzN72BZapgmlvFuXBCuskPoc1eQk60k8WX14J2LKvc77mlEmacvTsbW3fVBT1Ej8bzUk8t97eyQnk773Uidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnzHQHaOgAeMQyHvsk0q3esYd+O6fTq1qeiZH6j3cSM=;
 b=PksyCyd4d/fgOn5D6Ffli8AYVp52czzwppTNKq2xhxzRgEn93L/HLQzPwKzyPPtObxsEtyH89j0lAyGxiUWHfuWR0TbdYp99cDbOWcShaVhbDiy4xzNmkZ3OgvxEujJdADWDoL+gcPcxCprkDVz5XmVF0hfsi7tcAUUnFUT5p96XUlwpWSqFTYTnWVDeRoyJNm3DmlpQS8R69ESM/hEpjXjPWDM4rLtgT748E0Y3hE0z9e6GGIu0JbJ7hBspR1vebW0/qFTR4DfwEbG6bUVPYQHS6yUt/ReOYizbF2TXDWVZNKHUS6fA7GVT8hWISQlFnruATTB4zJtvPmJv7gqh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 16:29:27 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 16:29:27 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 4/5] ice: implement Rx queue
 management ops
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 4/5] ice: implement Rx
 queue management ops
Thread-Index: AQHcZTYsbB7kShXcW0iCwXe5umXll7V2QK9w
Date: Fri, 6 Feb 2026 16:29:27 +0000
Message-ID: <LV1PR11MB8790B36B9B1B635B2FA80EDF9066A@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
 <20251204155133.2437621-5-aleksander.lobakin@intel.com>
In-Reply-To: <20251204155133.2437621-5-aleksander.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|CY5PR11MB6533:EE_
x-ms-office365-filtering-correlation-id: c8b70079-5d96-4a96-7f8c-08de659ce5bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?PlbmQZjHKaVZZ5WbJkagLTJ7hHkwfTiLvSHZ3XK642GTjl0UilYfxJm1tdFz?=
 =?us-ascii?Q?+GP6Rz+8dlTx8V9KSYMu+m8FNBea47Lk7BGp8vPSamdu0liiivU4VV1Ebwtl?=
 =?us-ascii?Q?EIHIlMugRSZ68GGXws9OpqDr0cc4VfCfm/ElicXuS2vUQ0T/AOpAuecU3EPQ?=
 =?us-ascii?Q?pHOCxdpLWbMrg8bYDE4k9L3Xic8vLGjy9GQQhfaSfZArIjDvv/dJhknJkdbv?=
 =?us-ascii?Q?U803gJN8uSXDuqoUCuM4CgpQ+C18gosgTtfncHzFx1BBco9eCAMDyYXjEzJr?=
 =?us-ascii?Q?qs3YaZudT1lA3MntWM0YmBEj4nIS6ptjwcIs7UwRmefrjyLsSgrvYieys2vF?=
 =?us-ascii?Q?sScf8w7CjHzDg3Wa0zyVW+sdnPKia8BDM7g4mM32B2jrCI9xLpxXloChtPpc?=
 =?us-ascii?Q?jUH1wneTIFYH6moLDmOpvYTDFM50T/1iEbaFdGJqC9NJ9Kd4t+nZyJ4bRyga?=
 =?us-ascii?Q?Oh2jGPPfHJbymh8sA/YRi0v0BKEL/dOHPhzRKyBoEYLcVoDruKShTZv9Xuqm?=
 =?us-ascii?Q?0GAAf+mc025YBL+IrM0IUUW0EMYy8f6ML8ovN2m2dLYRpUdFsZGwJ8GDzJUj?=
 =?us-ascii?Q?TpvTBlBnRZrE43h/74y8oQZ9LJMYn4kYJvU7hIiPBIWa1ysTx6FS0IoyPWKs?=
 =?us-ascii?Q?7iv5qbVMVZxLyHXoAiroCZtcXOBKN92i1E6GW48OfWmiXZ1cOudn0zyuFCDb?=
 =?us-ascii?Q?EgOkfD0JYY8aD0vqwk0nn7jJ9JQ0jsTTAtMORJ/tMDvqpyAshpfXhpXLVjdF?=
 =?us-ascii?Q?P81Qzl7koid0VlpeOPKD7zMdt07Bf1IYvfAdz5qwLOek1igJW0h+CZwybhDK?=
 =?us-ascii?Q?5iBhcOQJcahbMHONATjSB1ipl9cXgabEy2ul1N5h3PatxVcTFvFjYAHx/sj+?=
 =?us-ascii?Q?b/aee3yZid/k5C83vy+ZWsqD5UlA0HQWZw8KKCwl/X9ioWbORo7kbSxydSBw?=
 =?us-ascii?Q?fquKo1xDyd0iEbUYLe2OW6TzoxlKdCPx9WFh6QZCqvY+I5TZkeLF0uORleQg?=
 =?us-ascii?Q?ex7bsQxHJbyryCsg2reyXR/yYJ+bUX3xJo3kioo2qSo1sEjMhK1oZQdWLZUN?=
 =?us-ascii?Q?cJ200ep/Lrt+tqC8OG/yWjkeJeIp5xrbM7tWWYQdK2rHzrf+uRrKHLDOUds6?=
 =?us-ascii?Q?Y/V6NmvWIUuHWgHwujA/e7wDXhlQ6ZSePACpcvG0EIAdRefnmt3ydaqfgIYt?=
 =?us-ascii?Q?v9JWMpRcH9OwC3W4YOaAeva1xzeCEZUAJkGMY0ZgfYoLsVgXykJ+eV7NxlTx?=
 =?us-ascii?Q?EnPyse6GqXAHJALVEQaVDrge2+kb1tupkM12QWLDnRMiKg8Z0vahxPuKIKCT?=
 =?us-ascii?Q?V32L9/KrDBHSMrwRThsXOvx4aabzhq9RHT+U5UHjAJRq+AM4EIZ4vqTJMNBM?=
 =?us-ascii?Q?jEqrEOGsxkHizK3uLfG7EclTZ6IHdo7R1BY99zh6hjKImVetTZvzKWVqLuWc?=
 =?us-ascii?Q?f8sUSVJedeuOL3kMV7VF0Y0pt20SAoWsRMtoO271PPRA5bkr5ZVQzExan2to?=
 =?us-ascii?Q?DemG4Dsscq9JPGzXhP4AUykv8/8ouEaY1jslm13lnhTy637cgSPCrzgAeMpR?=
 =?us-ascii?Q?N9zFQtbfIpqxPHrlwe5coWQhIym8TRbiL905aIWpMzfF81NkK9l9DkUV78PW?=
 =?us-ascii?Q?1WzgmHrvZqV/BV3DhoEg2o4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L742bxkC2atciSsLcrRC+H+7pb4FnPv4q1ICqKLql7ARqUYHCuGLDpHdus/L?=
 =?us-ascii?Q?3nzMDs05CJgkss57CpI8J8hLscutRyNUei5QKCjeLvJP47UJ12WN+fnibhzJ?=
 =?us-ascii?Q?1WNY8BDo4DSfPBVFk/tntlGSpKVooEDIZ6NIohRXxHTp29tRLOkzle1GqOC4?=
 =?us-ascii?Q?TE7esZWTAJ5+UXkv3+QmKQXMDYbUmEoBXOxG+I4wnHc3m5D4WByd1InpeOX0?=
 =?us-ascii?Q?QN4+VmwhlxPf+RzyjUmLM7oo5nEtD5KNcturA/bK4K7jdAIDn2KWGPMVTMXG?=
 =?us-ascii?Q?aNovEQVoJz3IJl/7595C1WmS175q4erLbFtpUxgcHqHxpGtgIjCQwZFJ9Tir?=
 =?us-ascii?Q?R/61Hlligw4v1ENNeBy2CxrC6z6HswdtbtZrESVWp5JhBrr1y1K3jqpEPI0Y?=
 =?us-ascii?Q?kY8//umGnn84tSS4hakWbvr7fAuG1aLP65vNnzDPE713prUROFIN/sFPAJEq?=
 =?us-ascii?Q?JK6ol4DTnfZ/rw+v5qxZSSAynbyePSjyOlO7vrEbIIX96WrOo62xlIRANipw?=
 =?us-ascii?Q?SNoThDM8OAS48XBl5VZ5S98SCD2WIyaY76ZlIWRPRAhLL3sIBG44xBkl/EYN?=
 =?us-ascii?Q?oAgiuTpylCboufFECEbKwnFBfTwVb/rayh/Df+igvnB6WCWiQWkZjICsYFu3?=
 =?us-ascii?Q?jFKE5kQGqJyyKsQ/bi8+OJO5JVJXgHIXsHnfmwxejMpSy39LD9th6n8gmhO1?=
 =?us-ascii?Q?Y9eMj01tCY3Klr6ssmmjnfrY19OF6NRDMR6rDXVLaJhZHgfDP0zwbS7t6O/U?=
 =?us-ascii?Q?3XAUKdhAGa32NqwgY+eHNGI2XqVhld7X/+gM9+wnWtJIJ9N2zOS+yFR0UXbw?=
 =?us-ascii?Q?JLf5uRWSIVJpK/HYf6ArU/Jc8++k7wI/Mfg4S+64ytzDGnBGGst5VmicXRAo?=
 =?us-ascii?Q?oiAR87YbV2A7U3bsO+6wIUPMG4I7OKAKsyY0WROtOkrGhsGzQghIGsGyMa+j?=
 =?us-ascii?Q?RhQPLbky8cMdHH7nVv7l63AThJDAnXkguJHVAfBFU5CBzBoG70k0HggnY9Um?=
 =?us-ascii?Q?46U/4IGvW1yNP9y1QHkL9vjCXiJ1SQXpr7+y0yCUnoNr3s4pdNsS7vALgLa3?=
 =?us-ascii?Q?+zWRSpJXIs9nIZUJ1jo7JWg3Rua3nOxqvXAaehH0HPy6bapyWmmCn4JMYR1b?=
 =?us-ascii?Q?FTH1cH9UqoNAocOhNBTSoeRKeqdce4Ifj8mDR5rmxsGfgwBtSRsyC5/ImIOV?=
 =?us-ascii?Q?BYlIWSWY/NhuGTqi7Swdm/Xq0LYvoxGpxjovcPR57I6Wau/G8XhoEIw4ElrP?=
 =?us-ascii?Q?93vmwcecYJGvNJfQkcvtSLCxHTtc0fHPaZ2alm8I4uB3bweO5hOefx/J0o+4?=
 =?us-ascii?Q?SnKugGF/gBKMZU3VFqUVDRCFG1jUBukAJXa4HBpzsXWk8wGp+t0kdIr+mL7G?=
 =?us-ascii?Q?doWqViqdrFcakIxyMLHO1ZrjbyoFEXmj6n0uP/Lf0aeMkQn6uR25F12Yej4p?=
 =?us-ascii?Q?rE/Hr7ysCArmKw6K3WDLuPDwLe36SnwlFpYZeFWLxG39iA1/oTufq04KooKJ?=
 =?us-ascii?Q?35XK9J9BdkDlSaZ0RBqBKm5DXcRqnpJ66QFyswkkc1uwHOyZKwtiPtzQvDK6?=
 =?us-ascii?Q?UKf7WAjp26ZKHz7LgjEGNebztx+ssWYs4OkYmAK8PQ9kfUazEXHgBGslUTCj?=
 =?us-ascii?Q?5ESBmJboUXvm5QWLkvC9IEbwpLu5HOcikbHQFFxw5Y7qqjh5RwRQ4U32/Kxx?=
 =?us-ascii?Q?Ue4fGHr4N4a9WVAWAGIRlLZktEQrsdQpDzHqE9yXhhcQk3xr6k1DF1IIRqwl?=
 =?us-ascii?Q?3vWHgZ1YFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b70079-5d96-4a96-7f8c-08de659ce5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 16:29:27.6414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1sB471AN1JrYC+hWWyuu4uWLFmxM8RLrGV7pScDmKhXODdGjdk4PblGSlGRyth51s3AItfqlxy/Z71r7WmAPQLT9oLFGetgc3fZcVpStX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257612-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,LV1PR11MB8790.namprd11.prod.outlook.com:mid,lunn.ch:email,intel.com:email,intel.com:dkim,davemloft.net:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.939];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A000C1005FE
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
lexander Lobakin
> Sent: Thursday, December 4, 2025 7:52 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Nguyen, Anthony L=
 <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@inte=
l.com>; Andrew Lunn <andrew+netdev@lunn.ch>;=20
> David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>=
; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon =
Horman <horms@kernel.org>; Keller, Jacob E=20
> <jacob.e.keller@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@int=
el.com>; NXNE CNSE OSDT ITP Upstreaming <nxne.cnse.osdt.itp.upstreaming@int=
el.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 4/5] ice: implement Rx queu=
e management ops
>=20
> Now ice is ready to get queue_mgmt_ops support. It already has API to dis=
able/reconfig/enable one particular queue (for XSk). Reuse as much of its c=
ode as possible to implement Rx queue management
> callbacks and vice versa -- ice_queue_mem_{alloc,free}() can be reused du=
ring ifup/ifdown to elide code duplication.
> With this, ice passes the io_uring zcrx selftests, meaning the Rx part of=
 netmem/MP support is done.
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.h    |   5 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_base.c   | 192 ++++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_main.c   |   2 +-
>  drivers/net/ethernet/intel/ice/ice_sf_eth.c |   2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c   |  26 ++-
>  6 files changed, 163 insertions(+), 66 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>


