Return-Path: <netdev+bounces-252300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I0DKtwLcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:37:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53666182
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33147723FF6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E23F0751;
	Thu, 22 Jan 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0n3aYuC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6023F23AD;
	Thu, 22 Jan 2026 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081151; cv=fail; b=DUylj2XFsWpfNG2vzaWCYy6haF0gQgrgUo6ArH6DQ4X894exqhDtT8HYblhiBT3NY+Ps4Vu8RsAVtifLZ2IG4Xrt/rx0DJTG2ECyFuJQk7h6ZTECTpHWRCC8SHHrJByQaxL/VlorH5KYzBnlllFdzyPuGiYXcUgmcKQUJxCtqVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081151; c=relaxed/simple;
	bh=KumVct7jFruFkrplJS215S7A86w+gg5i2p08GzHQrMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJzT2Bs8FNOla55/1cDyJfWNIlWr/rgprUZ/y2dEo6Bj938zaOy5Q7iwMom3XVgPZe+btjel+h1nL/6NRLcQgH1kOBEzyZ44UKmAeBNnVCFtl0J34Tzm9x3qFFEsPHC4PIMiodaoT1e0me+L0BGEnLBIvWMef7acnwUHvumBgoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0n3aYuC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769081149; x=1800617149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KumVct7jFruFkrplJS215S7A86w+gg5i2p08GzHQrMw=;
  b=J0n3aYuC8UiXzn/PfIPVrVy6HU1rT5sVVRcfnUwcGJPmQ6X/vrEHBqM9
   80EKJk3FCLo43u9AuuFfTB5gXVJ+BkouCDqVF4y9bqU4M7VfFGss8astc
   a9PxXvGe5HSEEdF8b304chPaEBGWHC1im4LIN+BsH7MLQ27fgoAv1UPgn
   Jot7TDRdekpk+HVNCDRdVcY+8zGxR+/VFypefUjTZsJNG2v7FDVNb+o8Q
   szLy1wO5WAbltF2kh7plcfBPar8D3o207ge0Mh20Qig/U0pvKU5KzOKo+
   eKv3g11XPkBsyZby5TtF9Flxww08BJ7H6Ds++dN46+B4sIWAKtrleyTZO
   g==;
X-CSE-ConnectionGUID: OqQ2H2kJTUaWwp1IccHFTA==
X-CSE-MsgGUID: oGL4XBJdR/6Y6nl20zuk4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74173358"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="74173358"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 03:25:47 -0800
X-CSE-ConnectionGUID: H9kZeWH4TuSY3S9tiPNOZg==
X-CSE-MsgGUID: 2CBg7gi9TQWo4TYcoZBgFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211154068"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 03:25:47 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 03:25:46 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 03:25:46 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 03:25:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xanZUwRXEpMoLVtpOJir4UMgOLaOTA63p92DbOE10IrdfoemxKC+T9hadGdFUokqeEuGF4Ru2h4ecGAH3oXO1BW2mMs2cTKpdxa6LaLUIajsPak+IeolS+0a83CMMJkLvzNJ1gruaQoTkce/Qk9npmAbb72d+TMumT/KStsscoVx8F2X/DJfc36Rsm5fxYeL+joIw7gcAtVJyD4/I++dKmL3ILb6vffScjVsNqKZr/C732/bN26ZEzRZOv8vLi3HkI6Td0vxLXakEctuducznlXO94EEfSM1ocOsLsanKBBDDBM0WBaCIKTVzqhuz1jEJ2p2kFgN4RAA/WjpiR1h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z56lFm14xjQC1QYtOFMswHrHVXVfmrPb34d0mVnH9o=;
 b=h30nXpTjQRj7vQUIcbCpoEzUkNFTwHtEWNXpv/NMOLC95wQtDkGrFBgmcN/4Cobs9G5JZvuGWPgJP2MArKd9v+tT+WwyNNeDrw7B/tN8sr727fE/dk3bcnfkS0bA18nz1d2MGGphWlpeVoxNiBQayhk0Lw2cv9WzmsMTsImEnGXDSf3Z+tI57FZ9ZRFURch/BR6T9L10gW7oqNM0BvzS1n7e9gu6MsEruMxmqpRWBQwJGd3sKlYLPkB7cUOVnYcsSFY+zljTYLD0PUuzDFxLS9MzULSdQMqxKoj0ay5RjEnT1/gDGl/fhLrKatTWOVW/Sjy0KPL4Vb7vVNRnDDaGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB8158.namprd11.prod.outlook.com (2603:10b6:8:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 11:25:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 11:25:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Zilin Guan <zilin@seu.edu.cn>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jianhao.xu@seu.edu.cn"
	<jianhao.xu@seu.edu.cn>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: Fix memory leak in
 ice_set_ringparam()
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: Fix memory leak in
 ice_set_ringparam()
Thread-Index: AQHci0+/2RA4nWngfUiv7sfyJXR/Q7VeDPmw
Date: Thu, 22 Jan 2026 11:25:44 +0000
Message-ID: <IA3PR11MB8986F163A397EEB8421FF320E597A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260122032644.183754-1-zilin@seu.edu.cn>
In-Reply-To: <20260122032644.183754-1-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB8158:EE_
x-ms-office365-filtering-correlation-id: 2d9c7d17-77fd-4bdf-f252-08de59a8fb82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vPeb5bkbE0JLl8YLV5oZDZWFZqlzUbnvfLKKYkUy25cFUSL/14df4HlA7GkI?=
 =?us-ascii?Q?XPbGWkRaBxScFzDQdeguEtQivaPCZm8xGwv6kxvAxX0dnYv0S4nQjkCz/hCi?=
 =?us-ascii?Q?es5/pSHVxar8NS4PvoDmPeR/FPC1EN/EjW8etoM05zRj7S3K6vwHz9FF7fva?=
 =?us-ascii?Q?l0GlSt+rX9nCALKW02lSSqW8ZNVoMURl6Io7HFoLJ6RWDtnWiUpwq1d68rHN?=
 =?us-ascii?Q?KTd0J9Igw+7NJTQfoIoY3zse0rgrI3oQmTJ4YhYKAv8HcaKsz8wwAvZ23iv4?=
 =?us-ascii?Q?4TZez3JiTSinI0nBD+lQvwXGa5p+OafbsRZvNqWh0pc2Bx/vgHZM4eVIDXN2?=
 =?us-ascii?Q?e9fMSIgfguq7T9yC7VO9oojiTWJBZ8ifzLcsSsb28bdVK0LZi93zHYq4gnuq?=
 =?us-ascii?Q?AEIiNWJxVLPPXMZugTO/fFzeopWqSInEYIugaD+IcFNp/YayOCE0Mjipjxko?=
 =?us-ascii?Q?FS8y6ULcQETJREgdaYC6YwB1tRKbQUId15rzCAwxUuVJz0x91OGG+c6X8A6c?=
 =?us-ascii?Q?jpEsTP16Ij8Wty2OKC1LmJ4/K0/RodLouamGoWImN9c6wFtDV69y+x5RnZw9?=
 =?us-ascii?Q?yigBrdmzbVVI7NoIl8Kiz5M2Y6OoZf+rz7OegBGesNrA6slg5JrUKBgKC4UN?=
 =?us-ascii?Q?gGWh3QHBXy7oWczSHrVJWr8HGb0naCZ+HdbogB0ko/sJ4xJ5cg0M439tSz+5?=
 =?us-ascii?Q?4BvZ/7K/SytYoewpzvsSyp6o6MH9Ayz/DraxPeHwL0Gzr3580kRX2U/R/gJ/?=
 =?us-ascii?Q?MHQrftlMawMSgQTeJAoRWs+zs6O8J5ye6tEyJvdROYCS40wKWxzmNbuoaZ4u?=
 =?us-ascii?Q?afsKUf23Cou0UZavrbr8pu9rh9XuoAfXo5cmQHottQgSwSpvkfutr0oVLsec?=
 =?us-ascii?Q?Rs7E/sJ9UPfvQDjuPAM1dRrrtCSmIju6Q6yTFb8xGEMFW7Ag2BmjOfvjeAvO?=
 =?us-ascii?Q?9vT4ss/KJVC4oXQaB6ypKkbAMFmdsJ2cpI8SHfytfSiI5CLV6zg3ZSDBeMbY?=
 =?us-ascii?Q?LkSXzOx7TsLNr5eEHEsuhidYKjlQdftkSxIRqJMRZ60RiMAIjoCTDifu/464?=
 =?us-ascii?Q?nvsOGxHBVHfmxQXQ3LmV5id+ptTn7cx4JP2YsQYMVPzzugqWA4CD3Sd484SA?=
 =?us-ascii?Q?Tk701UskSWFw6tUMIK8Ji/aHZWhGgefBX/94bVm4Qi67elU+vY1v/2MUphj8?=
 =?us-ascii?Q?19qlKnl0hDUJfbk0Yn5G//iR2L4DHg8AWgscIYErojdeQXhpWd/Sv2FAZoO3?=
 =?us-ascii?Q?T81FLC34X88/5rGCAxdVi6cjoCY+k0ef8R4zszJo++KplN2SsjVWJNL1IoSi?=
 =?us-ascii?Q?asyVvjopST5u3maML/rZf2oIGewrKAc0rntt2MfX9kNbrB3RGWgcd0tfq5ES?=
 =?us-ascii?Q?w3S9zJv4zoc3s/DznEl41eyZ4ZErl60Hg01yl8VGTcs62OpkBLnVbIV3WzoF?=
 =?us-ascii?Q?LDDbHBOWJiqstEC/iHP/bsOQ3bD/Lix73Qcpt0BsoiAmuPIbDvJtKknrlDX4?=
 =?us-ascii?Q?l0UHb2bQmk/kgP6su7tjeRd/QhJhYKAa51k/Iu7dggrrE8+lOPk804qT7Sa2?=
 =?us-ascii?Q?ielE3Nfkf/dwReC6JpUCb0RxwktDxFNt3i4FnoOtRMEQPPipIsX9OhbrqIoU?=
 =?us-ascii?Q?9R6I0p6uNLJ6N4yEbyV6n+U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pk0N8eSDmYI9WWNHaxH1wPJ4DPuhMWZehLIOj7NizfvKx042egZ5RpZNBMHa?=
 =?us-ascii?Q?Wvh0ctJ/COb6zcahOuIzy1Jy9aN1N6ezMuSjskC+1xV7bV2GNXZk+lRKGxIi?=
 =?us-ascii?Q?BVqmqatb7SWNIZi47Vo4/IVV2nb9NYZoHy8PLBjCJeJ4qy6gGgJfQrW5rdB9?=
 =?us-ascii?Q?EY0sUEd/O54aIVKVYRWw/oIg+jkh/J+CXGPVzYbMHoOF0qlpfzgXlokIl7U3?=
 =?us-ascii?Q?03ZlkENNck5nEEdYHGoxx2TNmMGPV+pC+AvProYADTRiEBrLTkSx1dtzzFzw?=
 =?us-ascii?Q?ftH7CWrnC3z/kXYSTHTjNseI0lG2IDcLy5hnQVwOTIllQTZpsSycaYZCbjRe?=
 =?us-ascii?Q?EIS+Z90Af46Ux+iKibdeQxLtcPqF3O5QyGVUxrKC28A+WDZFnN3BMDo2IkxI?=
 =?us-ascii?Q?M+uNB4ZHHPvUC7hvT+hEG3wZlKlGPO/LflAVfHS8rvTnx+SQrvY5+A9AjQTF?=
 =?us-ascii?Q?dZhTb3Ax4vQlCxHytDvSZPqgaaw0r08Y494ewSFkhp0T3B5zZnbAtYJkH4Mm?=
 =?us-ascii?Q?wsCSlz++bWYINKgU5afBCYxs1/jU1R1S0aS3FzCcf7QH/suvdbj06kEuTpsR?=
 =?us-ascii?Q?AX2pWyH6tUVG/Nazp1wAQvSk7KT6yMNb+i5t5u0R0u30EWGvUwb/sVkSQNrJ?=
 =?us-ascii?Q?HloTyWtA8zj1CC6IReJBDYjw7IVKioH6IOP7liRLphL8TiFzzd3injB+rGts?=
 =?us-ascii?Q?1g/swEyKXJz+OwhmABUxe5cf6D0osbyjRGNIOyNfXMBDHfsGtMFT5xS6W8K2?=
 =?us-ascii?Q?IRD1VMJlx7EIo+K6zRFT3sXkZnnTCEyEzxgAmSPFzgAPOfYuyj5477tXoeCn?=
 =?us-ascii?Q?TEVsOe7CmmbB7lR3IszO2QVB9GeOQN5GCalaKdCytM37RSiavnhyOy7Xh9Hg?=
 =?us-ascii?Q?u9FEEj3WwEz3KikmNNtjszVJTVJQ00cpNmzsnuZpezrvMjP2Mlikaf4ePEvJ?=
 =?us-ascii?Q?5le7vYFfAKOz+aNlV4m4VLoeBjApgM1rjQ7iQnpOI9qL6jXxrTUP+5diOEVa?=
 =?us-ascii?Q?Yge3rcN182dZuWU5eqWF0hvaWS6iBB2i5DWj54aX1KuRm4Fx/7SN9JjENPgs?=
 =?us-ascii?Q?fyDSs0/g6yLkwJzwnL3T/DJNfHvN0z9IOFPRMz37gKG909YMdjKHophQHI33?=
 =?us-ascii?Q?AWrkeQzdYhGUw52JVc8HQ9cmWCwl9b3al9PEi3Sa8ODO/dpn2Ncm0UOVyzbM?=
 =?us-ascii?Q?Z84/9Y3yb5qsB6hz22MVZltuBoxErH2m3EAOBF6Gshftq34cFoaeAiZJnJ6y?=
 =?us-ascii?Q?RTMMK6bUjOZaratGEOwPk8ERRLdxC+HKywbIspAUgnBlCJ3vtvRrwJTW/V0+?=
 =?us-ascii?Q?pp9Z7hhq3eXw8eEgIINT9qm7Hs4nSDdUd1d+nxD3v2JzU1KLcDBoeRjz7B0g?=
 =?us-ascii?Q?s2G90vaAumKy36idX0DerhUnkgmLJXkdryQeTztJPfr84mjyfkmR3MybaOrJ?=
 =?us-ascii?Q?213PgogDfLHurMim7knoi5PGDA+KWOVF84cdB4Yzq3d3J31IA/NYizLa2OKq?=
 =?us-ascii?Q?ud6e2pv2fr1qViC2/RTm2/2NtUcbz1UZsw/nbUIBks7ZedN743FatRo2nQ9z?=
 =?us-ascii?Q?B3ioUbCZpfuSoQ1KbSUWOUPIESqN62/RFQ33xD5za+LCn7n9k0Ut5PMYUiV6?=
 =?us-ascii?Q?9vbelR5RS2ijbYb4um4VIZpyiEMk9AHw1mlVXd5fl8EQhUAGDmcI21YMrABD?=
 =?us-ascii?Q?ZbKI1aKUeAfp4TrQQ2jQZgqS0gcLUV7SqUQhCa08e/mPovs1Og+79yuSCNU1?=
 =?us-ascii?Q?GcSH3T0CeTt0RBihPdZk5HMpOOecygg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9c7d17-77fd-4bdf-f252-08de59a8fb82
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 11:25:44.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /SXkk2jDhJUPLM5kF1GeYFd/TGAAepvyDTrLCYy8Eo+vEw/feHuKZOrVPV0iJF/2BHMDwQaNDzP0Dd5C6oYGYff/lk579RUxjyl+bqt7b3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8158
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-252300-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,osuosl.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,seu.edu.cn:email,lunn.ch:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7C53666182
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Zilin Guan
> Sent: Thursday, January 22, 2026 4:27 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> jianhao.xu@seu.edu.cn; Zilin Guan <zilin@seu.edu.cn>
> Subject: [Intel-wired-lan] [PATCH net] ice: Fix memory leak in
> ice_set_ringparam()
>=20
> In ice_set_ringparam, tx_rings and xdp_rings are allocated before
> rx_rings. If the allocation of rx_rings fails, the code jumps to the
> done label leaking both tx_rings and xdp_rings. Furthermore, if the
> setup of an individual Rx ring fails during the loop, the code jumps
> to the free_tx label which releases tx_rings but leaks xdp_rings.
>=20
> Fix this by introducing a free_xdp label and updating the error paths
> to ensure both xdp_rings and tx_rings are properly freed if rx_rings
> allocation or setup fails.
>=20
> Compile tested only. Issue found using a prototype static analysis
> tool and code review.
>=20
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 969d4f8f9c02..1643b118144a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3318,7 +3318,7 @@ ice_set_ringparam(struct net_device *netdev,
> struct ethtool_ringparam *ring,
>  	rx_rings =3D kcalloc(vsi->num_rxq, sizeof(*rx_rings),
> GFP_KERNEL);
>  	if (!rx_rings) {
>  		err =3D -ENOMEM;
> -		goto done;
> +		goto free_xdp;
>  	}
>=20
>  	ice_for_each_rxq(vsi, i) {
> @@ -3345,7 +3345,7 @@ ice_set_ringparam(struct net_device *netdev,
> struct ethtool_ringparam *ring,
>  			}
>  			kfree(rx_rings);
>  			err =3D -ENOMEM;
> -			goto free_tx;
> +			goto free_xdp;
>  		}
>  	}
>=20
> @@ -3398,6 +3398,13 @@ ice_set_ringparam(struct net_device *netdev,
> struct ethtool_ringparam *ring,
>  	}
>  	goto done;
>=20
> +free_xdp:
> +	if (xdp_rings) {
> +		ice_for_each_xdp_txq(vsi, i)
> +			ice_free_tx_ring(&xdp_rings[i]);
> +		kfree(xdp_rings);
> +	}
> +
>  free_tx:
>  	/* error cleanup if the Rx allocations failed after getting Tx
> */
>  	if (tx_rings) {
> --
> 2.34.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

