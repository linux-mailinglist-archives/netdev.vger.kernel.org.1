Return-Path: <netdev+bounces-234998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30569C2B0C6
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3438D4F31CD
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0792FD7DF;
	Mon,  3 Nov 2025 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRD5jh5f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969542FD7D9
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165656; cv=fail; b=D2BkhradcXNuvZphV7tGvhZuXEtfV6NjVpBk7jLPD4huGeKVXkX9ovljLTPRRg9kqaExE2O9DEUXq6fEjAlL4eV9EbkVLAWs6CHg4nJMrtxp+tR820MwY1XsUEBNA+3dc6X9dMLwQLOF8IeztmlcljkNB0nfZnvCiiJ1cNAhGMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165656; c=relaxed/simple;
	bh=3apeY7BZNBJOWygmx3FOQgmK51b2EpcutP/PFv6MYJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SuWN21ArXYtT7Rx0ClR8gLChKROctQiXBIfF7RzBsumI6jEbVcktVGuautWzjf6/J/ovJGtIEGXilA98RjCOUB/opKkPCgUxVVBghSp2Y3z2k7ThIe41KnL+eVhWXgWOxZErQrNwR+2dmi//Du/qPl9ASCpDJ3hXmvC6NBn4Up4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRD5jh5f; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762165655; x=1793701655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3apeY7BZNBJOWygmx3FOQgmK51b2EpcutP/PFv6MYJQ=;
  b=YRD5jh5f8lUaefKaOjC9aXYR5vkG1VKxy54m3qoPoYrHH4dEdJX7REY/
   rxT3px5+MHYcD0FHaFU7RNjvQo2E2dzs1R1jQjAiJn4va9kJARcFKIha0
   aPEfXYDfbtlh+fi4NNAWQ7LqsCWh79MRBd818LOtajKT8SoZPTiduoOMG
   jbH8cryPl644Lgs/d+wfO14oRTvNuV7hV1f0eG242OJUFDDHMdCjI8kGa
   fzSrwkvVLB+O9NOiEDWJTmjeWp6EqcjTyJiNCHrLehbfNS0nLQAlhC/JE
   /4IOfR7pOd3X2HBmEhbyHD4aLYqyvf0JIkV1zuO/sJCtq31r4awXqEH7M
   w==;
X-CSE-ConnectionGUID: iGPH3UtARp6tJu1w2F+IKw==
X-CSE-MsgGUID: hQyigLgeTrGYyVfYDg6UPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64154822"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="64154822"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:27:34 -0800
X-CSE-ConnectionGUID: 9K3X+2SSQMqeMGhsCGgDQA==
X-CSE-MsgGUID: 1eBqXBCBQ1exmCXvV+idkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="217467097"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:27:34 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 02:27:33 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 02:27:33 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 02:27:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebHfh1+exYHZPTjcArhdjnPE9aTGEtpV2R80SvDGwPh1Je/+gKcMzmjrXKMuJzOBe5dx4gCnDGzx3IIYcfVhrfaeJMLDpw/bJUbbpmps93Zppy9L/v279iQoctnFrKBuXYZkAyJKmLWhhAYENNCW5Xi7/gNQL0n9PaHTOJaRxqoPY6/gER8fv7TGaMjdi4gxq5d1frwf9P9r656fM0h7GOKi01qMUWdtmTl7elWPRXrJ9f7poWmCsOKM1AC3sKFYA52mT84IitgUnFm7E8sMoFSAE5xWKinD6PnGUJ6CSlACFJ9yCWNTqV68sxyX3GaZuwCESLLw12ZovsQoZx9fcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m/iixuoHjnE49XKPg0+RKANEMu0nsT/q+UTnih94W4=;
 b=DxbqYqvC8S9SI+CSUD48BnunEHFrWA4AFhZmIweMyjN72lV12EvjnalUSygw1o6diJ1ECUe6VebKhrhuzZfhLPxkdP3vEX4Cfa4n0qq0qVbn/Gl4B2Z2G6dpF6SHEfjhAtGHwQfEe9KVMMOlFYj/btojWCO4hiRFwiEgk96+2aOjipotXSMF8LO/GGQQhT/2rJ01DAyI0IvPgiD894PlE1lAL4S9qVrelHH71iNhePHepUfeTaKYy9SGPj6m0aS8FyCBCgvvH4y/nFKz24c2h25vgYjxnzH93aL2TCdl6juulYQDETdz8/CJKZoKxmYHHNSaKEmw1vpIMxixY+bvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:27:25 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 10:27:25 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next] iavf: clarify VLAN add/delete
 log messages and lower log level
Thread-Topic: [Intel-wired-lan] [PATCH net-next] iavf: clarify VLAN add/delete
 log messages and lower log level
Thread-Index: AQHcTKJNwtULo5S94kOW4ptUcd9fy7Tgv0nQ
Date: Mon, 3 Nov 2025 10:27:25 +0000
Message-ID: <IA3PR11MB8986091622A216F32EC801B5E5C7A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251103090344.452909-2-alok.a.tiwari@oracle.com>
In-Reply-To: <20251103090344.452909-2-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB7666:EE_
x-ms-office365-filtering-correlation-id: a9d5a7e4-9865-4d7d-2f5a-08de1ac39516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?0hDbfXalawhpIJVMJ51h4zOWgwQITDvqG9YfMrGQzrNvPTc5kd3d4hUxMdzw?=
 =?us-ascii?Q?J7rW0Zg4/XBc8V5G8gahNSg6Eumfo5N8wsTBtqO1hVwA0ZU6oRZI9rwYi1q/?=
 =?us-ascii?Q?OttTh3FDvw8tPZHaU/NmMhgEi6jCUZFQc7K57wvGU+KySt5fNKHPemG6q1Fp?=
 =?us-ascii?Q?tJEKCvdrIIkQY4NlO5AyQeNZTWq4xKZAbZ5OvnDCbqPKG2rUOLIrcjNXvn23?=
 =?us-ascii?Q?24Mi/7rkyF+sIUEJ5jh+ZQGHQKhSzMG7TS1xMmxnHOOb+2HGqmifI8qgKSwh?=
 =?us-ascii?Q?JCHcdQbrObpQ5EwCKdo/UshqWwY/3yE26b5N391ud+yXmYC/QcDAkqlIbN0J?=
 =?us-ascii?Q?r8E6tDv5+Ri32zNu44qkWzzQ2DwKEfvuRwgJGYbg0ZnfQMHgsiBinaBZymQ1?=
 =?us-ascii?Q?PPRpk2epAC5BsRVxxm+DDu1HxGt1IXKbcnIhR6uFwuaGrg+TwX5r8vM0dK4W?=
 =?us-ascii?Q?a+F25bTtTfbgbf7FqhtxmriIxyl3kxX79LX743O0YROnaxQoVL5jNBVUQ1o0?=
 =?us-ascii?Q?o+xm9JoLdTYD3DtFCfWTzAMxOIlA4xJf/kGYjxCUMXDQ+HkRVyWKxTdwTUuW?=
 =?us-ascii?Q?ASb4h9SbLLs2kSa1jyQI7uHwfJZ2dErSqZdPbvsaXn1pByrothjDwu8X7j22?=
 =?us-ascii?Q?K/xy/ccFAgL0dIMv2pEKWaAFowlnmYZbTIMXZi3Xb30ZwllHTBUf2TiR0KpU?=
 =?us-ascii?Q?7RWrp3XKmRLnXRJ9wJMhWKZO9gyZQU9LIpg45sERQcvmBkZGiE8T1yd8/Opx?=
 =?us-ascii?Q?S/oam7wBoNwMMpFNMj7yzWh/9cCWdJtG2mhB2racn+yAlHCizSTEw/hz8ZYW?=
 =?us-ascii?Q?Y1RlOCAjfldBwl4jEmfKFtuNECGq4N+yP9E4kIAtQ7sneuPWxQHecdeUFrvt?=
 =?us-ascii?Q?tICBz8JcbYU/QvESvUUHQvWRBRXY6Q2K+rKU5GhCjMfD96MdhpztKwtJEE52?=
 =?us-ascii?Q?jXfl3deYGv2SO5bbw/Xd4RzyVgxnLdGYDgHhcblRrSaty8z/eYtGmb9RLp7d?=
 =?us-ascii?Q?X4+qGwbeo2RL+lPVFTXz0C9RwuG7QPk2fTAll3LslSio+xmiQiFfp2XpQZJY?=
 =?us-ascii?Q?uTtcWzJyhWQqMjHx+ZQhQjTnGFC6ofVVSVW36PorUXyPWcloZVMyD2oyIZoF?=
 =?us-ascii?Q?Xv3ONCtViMUmsslgJ6DmpJ5vPR11S5nZvvu5RvaNPzs2ED/QWiMZA2ZhzXUn?=
 =?us-ascii?Q?tlvJn8mVrziBVEX7gD7kG08XOJ5j3VBTlwXwntoNK0oZR1tlyds1Ttd/QXiP?=
 =?us-ascii?Q?Wmt+Z3jZkNxgrf1ldkFBBuYli9biPreLPV8LjO6syc3QiVn2lTE3KYOOV8RN?=
 =?us-ascii?Q?PvilJKUCXnnsvDlvGlDK+MfEAm2I3tR014Dq/gWfDqk9+pY5P57oGTbitvdE?=
 =?us-ascii?Q?pNuKE8qXFlgpB3TphYU4Z2UStFzOChw1y+Wa2dToLEOlEDG2CW3YhqrR5aXe?=
 =?us-ascii?Q?50vxgSZh+vx54QRVM7/aLZyiUEkLddDCn7LnkqzIZYFeWeM//vsrdaBHUExk?=
 =?us-ascii?Q?LAtKSbWI3Qsobwao9j4DZZJbgS9SH42VGBx9E299Vkqe5LYtQXUqXlMGQQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hz8ojaSeqbqX4NLe1klLcsTAGD+/zijvJZy1Nqi0PFbPwh5P38CrwUjDT1O4?=
 =?us-ascii?Q?SXr4UouK9cUo66BQe9EuNOTAbYE6LfdlFoEbbdTplvKHEhXvVySDVIceh0BE?=
 =?us-ascii?Q?DjLocFbXcssuq6DQ/1cw0xBIHgJG75470HZ6oPypr0JmhgHp0wuSVrvm8XSI?=
 =?us-ascii?Q?rLw1MbRsTO51gn6aq1Sge2bo6jSoufmuILzSSzbRFkLnZ1hYCMGygm+LP5PQ?=
 =?us-ascii?Q?GhvQ7LFurMgEi+E1aOBfIqQonCIWBbXwTssRbFcMLFmgSypM9jeE5UyQLz7i?=
 =?us-ascii?Q?2HEibTOqHhudixVf4VNQFp0+RZZob5i5MI/tOMxxYWlnqAXrsnlhV8KYI3xZ?=
 =?us-ascii?Q?ytPJjbYQNgt4OovTTcktXGgnPHSYWoScqLVD9l8LNJneHE8FdFnkuKgeT0TO?=
 =?us-ascii?Q?KnsavzEQUcYlXCybnVbTEgXlRW29DE6eVhE5luh0nvxcjOQ8dDZOtFzacbrZ?=
 =?us-ascii?Q?TNSyhaYBmVMTKF6sGTLOAepN9rdZHTWRSHLhC14ClD4Cvv0Hbp0KQaCWOwhV?=
 =?us-ascii?Q?Rw+aFd78i9EZktg7/4U9WO7RgkbwdyRmvOSyt8xCtvglSh8iLjfN5K7amyio?=
 =?us-ascii?Q?ooPbGDLegfxokRLVwltqjctZpd/nL5b+mY2On6P6tdx+3WGF2Tjzer+Vm6xq?=
 =?us-ascii?Q?BCYC5GKvIu67NixMnffehJc1Guc7ChE0RpYGCtkcXYaoinDiIpN63zxN2Dx1?=
 =?us-ascii?Q?vdUX06/wtFLDQ0M6OfHua9Rs7QRpuzHaVUIb1Whi3D30AKNTHGw4FMHVXpLz?=
 =?us-ascii?Q?b2Ad+wm5c+8L5ZqWbncEyFWPvkhZ6ZhV/E/ym2xcIkaPrA350mFiep2ztNUr?=
 =?us-ascii?Q?NwfaR6OymBBpBtq29eneNm3sOtEBqWBJFXmLMeddCNcoF2ugpCD+LSIj8e6+?=
 =?us-ascii?Q?U7mNLt4uwS23bch1t8myAGsE9B5mnw0nwdO6X7tUKSaF+CE1S/F+rs5lDdtn?=
 =?us-ascii?Q?MROEd1JMS9l6rammPUQlSJgsQ1zrJz/C8vm9lTVOd3BFscnQiqeE6WvQgB+7?=
 =?us-ascii?Q?xk6dcfuUhmbH/S8VqvCARXPQcyfNto86sUZUqMEWSPM+ucON3U/T6cy8sdiG?=
 =?us-ascii?Q?OICJs5moVaJyiG4mUAKk+Ct8/oompElyA9QStsf5aSGX0TPQ25RB7xjBnKwZ?=
 =?us-ascii?Q?79gzv2S9vYMjmcWIhdhod/xdOS+4QZ3j+H5hL2PD8llWBC/Kz/zMkb1pLEfQ?=
 =?us-ascii?Q?L4KVlB3YP9zRNmN204sj8XcRyPXtoxM4I4LuzUsrzhpRO4iZaxlg+OjcBClE?=
 =?us-ascii?Q?Md5QOXQvV0VTIRI/I9bJho26CtqfrebDPFnnQZaXTtF6hfR8EZDBLbAi4bwa?=
 =?us-ascii?Q?87vm75P0Qb8eFqO3imWMU1GQkPMZkHCt+Y3c0BLOX1TLrtg/nW3+HZqwZztJ?=
 =?us-ascii?Q?K11sZABWUtwNFqPEP/g0Vn4O+uor8+d67WpfPGAVD9dzMsq076jh6p+sy2FU?=
 =?us-ascii?Q?8PxirXbhXd/K2Iln0qL0nI+VWNM6YcYaUJcVrRYMAGQMTF6OuulOMG8JViIJ?=
 =?us-ascii?Q?3WbZx8l431qiw+Yj3T18AHjICcTCb4DIP2eQ+3cmpXoNQ0f+N8FoD8Cj76vU?=
 =?us-ascii?Q?FPFCoU9jX/74TnDatFYoHDDJQ0jIKaWLIR4nmJwuSRTw2AHCezndmFprh/Am?=
 =?us-ascii?Q?sQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d5a7e4-9865-4d7d-2f5a-08de1ac39516
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 10:27:25.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wLvB/WFUmuKZYdVGCGYYgru3MLDdE2fyKMUaQiAwnSFPeh6SA0ZhmH6pOSR16QHmKrZdWmwtQJXFheekjqbn+JdwJLSub1ermfTKwtqiog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alok Tiwari
> Sent: Monday, November 3, 2025 10:03 AM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; andrew+netdev@lunn.ch; kuba@kernel.org;
> davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> horms@kernel.org; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org
> Cc: alok.a.tiwarilinux@gmail.com; alok.a.tiwari@oracle.com
> Subject: [Intel-wired-lan] [PATCH net-next] iavf: clarify VLAN
> add/delete log messages and lower log level
>=20
> The current dev_warn messages for too many VLAN changes are confusing
> and one place incorrectly reference "add" instead of "delete" VLANs
> due to copy-paste errors.
>=20
> - Use dev_info instead of dev_warn to lower the log level.
> - Rephrase the message to: "Too many VLAN [add|delete] changes
> requested,
>   splitting into multiple messages to PF".
>=20
> Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> https://lore.kernel.org/all/47f8c95c-bac4-471f-8e58-
> 9155c6e58cb5@intel.com/
> ---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 34a422a4a29c..3593c0b45cf7 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -793,7 +793,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
>=20
>  		len =3D virtchnl_struct_size(vvfl, vlan_id, count);
>  		if (len > IAVF_MAX_AQ_BUF_SIZE) {
> -			dev_warn(&adapter->pdev->dev, "Too many add VLAN
> changes in one request\n");
> +			dev_info(&adapter->pdev->dev, "Too many VLAN add
> changes requested,\n"
> +				"splitting into multiple messages to
> PF\n");
>  			while (len > IAVF_MAX_AQ_BUF_SIZE)
>  				len =3D virtchnl_struct_size(vvfl, vlan_id,
>  							   --count);
> @@ -838,7 +839,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
>=20
>  		len =3D virtchnl_struct_size(vvfl_v2, filters, count);
>  		if (len > IAVF_MAX_AQ_BUF_SIZE) {
> -			dev_warn(&adapter->pdev->dev, "Too many add VLAN
> changes in one request\n");
> +			dev_info(&adapter->pdev->dev, "Too many VLAN add
> changes requested,\n"
> +				"splitting into multiple messages to
> PF\n");
Kernel style prefers single-line messages unless absolutely necessary. Mult=
i-line dev_info() is unusual for simple info.

dev_info() is acceptable for non-critical conditions, but consider netdev_i=
nfo() for network-related messages (common in drivers).

...

