Return-Path: <netdev+bounces-106683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A5917416
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D599AB22996
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAD814A0A3;
	Tue, 25 Jun 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXIC93Is"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC508F48
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353121; cv=fail; b=Uf/pDPbz7/cpVZgKQlVVccfCyKJUzPmj9VMOGuj+2Uir4BkM5bCIYBKBhLMVF0RlMmF6tPdV4wsG0eDFylsM/kjN/RfuO3/BDLQ+WCIvR3cOIM74nFnttun7bBWUiqxXB52BOVkHU6yk6FwClATcdfRSaShLaaK20oSqxXCMKp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353121; c=relaxed/simple;
	bh=wjCkWmKywBnZADwwdkK454DPNOp8jGu+5Wj3zmzgifA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OH50839ANF4+4QokkjLjZRfmMDHfnPzVkzE9QD71LWO6Bg1FDpNW9Y6mfbHD7gwAbt99Ulg9DnssWvGuCNTdSaLDL7rVLLxVEaCrJP/1CS1/j03BXYaOViX11AHa8hrL9zDL/uXDCP6AW1Ng5K7Es7gWRT8vtH0z/zMXIwoXpYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXIC93Is; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719353115; x=1750889115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wjCkWmKywBnZADwwdkK454DPNOp8jGu+5Wj3zmzgifA=;
  b=IXIC93IsQceODrlF3DNYQAi4R2ELhA0d5yl1QrOhBDMpZDRhXRk2ULA7
   bgkEolPiYaPk1T/N5C/1rna2czWnGhP+skaeen9UoTVkGU6NgVkMTTv7F
   Y75Xvqd9KuXhLLFqE0H+4XRf9H/SZnKDvnNBK97/6Ex954acSX2Fh93qE
   4FlBqRPSmvRIwCP5AeCLctUX0NV9Vmvdklchub7IT+VGEqsyXvicqOj3W
   hV5uAHT5j3QpPV3KXJ9CDcqAtIvMQjLBRfBqkPwYxjPw/WC7VX1IY6DvU
   ZSJV4536QeKyz/Fb/LR7oLYEUx1EJqD17fS+jOd1ZKGVEXCPeosKeuK50
   g==;
X-CSE-ConnectionGUID: zTa0EeNSQvSvB06k9ESixQ==
X-CSE-MsgGUID: 6+I7PkzvTX+TXEIQTe4Rfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27540700"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27540700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 15:05:15 -0700
X-CSE-ConnectionGUID: 9svlsJk6SOGNW7/tRMJ9Eg==
X-CSE-MsgGUID: YG6bTJVGQxOshzznxPtQ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="81326422"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 15:05:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 15:05:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 15:05:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 15:05:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnM3NylaS6velpJXv8t0WtgUEEZUdRgWJAMm0uBebITqZcDUC0xwfiND5/F1TsFOOrf5/MKw/2qdWzHN8KSugPjs2ZHnRbs/bIkNq8BS/+ImRYb0qvPbFTeULeFR+OL58NdCo4VDM6kWm9v7MGopTcvrWCLa20PaKWprJL2NWL9I74h1D80Bqw8oOnMOLgn/wTqZEmSgPlXWghsxT5TqFomXW31Jvz3UdnqxgmBFd1G6foMxy+s74FozR223tXhYLqNnH75jgHQgcYmX/M71X40VpRGeBK5C03swq2KddseBOxy/5HBjvsCeKnPPx8/zNgCfL6K3H3V/BEH6XBsyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjCkWmKywBnZADwwdkK454DPNOp8jGu+5Wj3zmzgifA=;
 b=XlTnK6UYsBKiAHzndH4L0anpMeKBIdwtDNBcRQNS2yVpEDjqMU0s+KHduH5xRUy2Pg2ZSw4f9k0BMe2+y5yr76z0aCakOq02vR8fBAy0Kx7QaQSCmMfZZKvQB7cA9kmC/xebqzYRbNxX9zyvETyod4jD+4Qv5Inq7IdeRQkeKOeQEb08uf05an4y2a6eqyBQT13TwrMSujqbl1Mrly2MmwEA/WC+C4xAqogkxgd1EdYz0w/uXQwyG1crhKVmxvu0/QYioyj0RZXc90JoAn6YZF08W0ZJ4MANJWdcsSMdK7bX9x/YDQFoftwGPtuDSucjKx6yisGtVetEJn/IY8dAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 22:05:13 +0000
Received: from CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be]) by CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 22:05:13 +0000
From: "Singhai, Anjali" <anjali.singhai@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Boris Pismenny <borisp@nvidia.com>, "gal@nvidia.com"
	<gal@nvidia.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>,
	"rrameshbabu@nvidia.com" <rrameshbabu@nvidia.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Acharya, Arun Kumar"
	<arun.kumar.acharya@intel.com>
Subject: RE: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Thread-Topic: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
Thread-Index: AdrB1/ByhY5vhdaNSxq8hQ6vCeqC9QATE02AAEx36mAAOVNNgACLXLKg
Date: Tue, 25 Jun 2024 22:05:13 +0000
Message-ID: <CO1PR11MB499345FE6E5A2056D03DE66293D52@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <CO1PR11MB49939CBC31BC13472404094793CE2@CO1PR11MB4993.namprd11.prod.outlook.com>
	<66729953651ba_2751bc294fa@willemb.c.googlers.com.notmuch>
	<CO1PR11MB49939F947A63E4A5F8C5246A93C82@CO1PR11MB4993.namprd11.prod.outlook.com>
 <20240621173043.4afac43f@kernel.org>
In-Reply-To: <20240621173043.4afac43f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4993:EE_|LV8PR11MB8698:EE_
x-ms-office365-filtering-correlation-id: 0c200886-d75e-4e8d-e769-08dc9562e39c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?VWt3Y25TSzY2NGFndmNhZHBKRGNpR05IbCtPWUNoNVJDbXFSMXdHaUdWQ3J6?=
 =?utf-8?B?S3VSU0V5WlhEUk1IelR2bjBwSFc5eXVsbFg5YUZCUVM3Um94cWVnSUdTL1pm?=
 =?utf-8?B?K05mZ0M4azF6U1pmRUxtUzFGbWNadFBXNzU3bWQrSzJsRU1mT3Q4bkl0SzR0?=
 =?utf-8?B?MzBHNklzNUt3WG81ZWN2Z28yWE0zV0hzUUF4U2FDZWJmQ3hkc0xWWEZSVkRz?=
 =?utf-8?B?MkVHWW11QXJvMkV3M3V2T3h4V2xWb1I3NW5ITlNJZk81SXdHdk5lRmUxbVdY?=
 =?utf-8?B?RXdWNTQ3YlEwTzRaaWJnNVhpd1gzUTRCYWo3Y0dvcGgxVEZ6WWpHUUYxWFFX?=
 =?utf-8?B?MXVaZzBJOTJuejIwNjl6ZlVJQmwyaU1mdGY4akJPZVhqekp3QkdzVzZ5SVdF?=
 =?utf-8?B?WXRSKzV1RWRtL0ZSQ2pSOGNBenJkRC9va3IzeUhpME5pSDJWVm5SbWtpampH?=
 =?utf-8?B?L3I0MjJnL3I2TDErVG96QmQvbE1zU2psU3dQdmhCSCtYdGhVS1FDMzVXL1ZT?=
 =?utf-8?B?Rmh0VktBUjl5Y1ZISWlXL1JYbW14S2hFQVVaYm9nK1phK1g5WURreTl0bzVn?=
 =?utf-8?B?cXFoS2hRUk9UMFlQdU93VHJ6K3E1SmlLYmhBOWRFMVcyUllMOFQwWnFDVmd4?=
 =?utf-8?B?eStoWE9wenJCbFoyQk5oc25pVEJMYTh6SnJwVVVGejRwR3BqQTBqclJxL1BO?=
 =?utf-8?B?SjRGYXgrM0UxeDluZnErS3hJeU1pOWpDdm5RT0h4TE1XSGhjNlBWTFFPZFhl?=
 =?utf-8?B?SHZJR01pa0Uyc1k1bDJOcWsrUG0yMTJVWS9tTU1icTJ4VmsrbHZoa205Qlh5?=
 =?utf-8?B?WlpyOE5naXRLMTlUUGJnZXh3N25YLzlxWVBaN1dnelNDencvRng5SitOZnFl?=
 =?utf-8?B?TUYxbCs4U1d6M0Z5Y2VRdk1FSFVaclBzRXNXeGhGV1o2ajV0WVdzS3B4UGd2?=
 =?utf-8?B?bTZKb21WN3RZd1VsRzBHZzZMM2JFU29Gd0xHUkF6M29iUENiTUMremVvOU9M?=
 =?utf-8?B?YjRWOUdQamNkVVdDc0tRL044eW5QTmV3dXhOUVcvaitwdHlVV3gxTS9JYTk2?=
 =?utf-8?B?c1IrVDVoc01NZ1Bud3dPejdQVlFYVFl4TnJVN29qb3hyTnFBWFAvd1BkM2E0?=
 =?utf-8?B?SFJzaEU5VXNielJabVZNTzN4cldETTdRclU4NnVLYzVKM2RXNmJGTkFKYURh?=
 =?utf-8?B?dGFCdGp4Vk9KNFFZbVFzNHhIeGsrbEZxZWc1VDNYR3NQNU1PV2dGK2tKbmlI?=
 =?utf-8?B?M2ZwMWtSS0Z6QVFwc3Npb0NsY3JYVm54S2Y5VlJ0Vk5BODZyaHp6bzU3b0hN?=
 =?utf-8?B?U3BPNm9MdS9UL1FYcUlYaVY3cnk2cWhsNFdycTQwOHdCYk50MERPdndIaDFq?=
 =?utf-8?B?aTQvNS9YdjQ5a2dxMXVReXdmbE1xNkc0SE94Q1plYnlwVVlyalJ2MXVMbldz?=
 =?utf-8?B?eVRFTU80RWtWemttVFVkbXNjNlVUUHZmZU0xb2ZCcWhkZ2VBd1U4bUIwMGVw?=
 =?utf-8?B?aThSNVNpMVN6dVN0WG9tbkZxL2JTSFV0VjN1QjRVU1FSR2JhNkNLb3FIMFk0?=
 =?utf-8?B?MmYvSUtXMEdyZWdDZ0FMNmNEREdEeGZFQTQ2dW1IRHNOZ2Y5bmNkTWtvb1RT?=
 =?utf-8?B?Tm9HSnZYWGg2MHBEaVZEbjhSOWZtNmViS2FIdGJjOVM1MXpCT0M3ZWhDZE1o?=
 =?utf-8?B?U3o2OWlOeUg5U1M0NVk5MGIrT2k5RzZiUkFkdVBBcDJaYVlTTG9DOHdrQm11?=
 =?utf-8?Q?nrstjlljogNJgqZsM6Ua07gghSL7zQALCaIF4w+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4993.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzRaU3c3WTI2eVVVNVdlNVRnbGRlNW1LTXZnVm5jZUs5cFp2S2VmZ3ExM2FU?=
 =?utf-8?B?RlcySm1JQmRUOEM1bnhIUERKVHRQK3IzOWZyNUhnK0NnSVNBVXZmcDZvVUZF?=
 =?utf-8?B?RmVUOW0zdHJOU3k0aUdKMm8zaHdrcmlMNm9MaERMdkFtUllzS3EwUXJERFNP?=
 =?utf-8?B?dytqeE13cFdtcStpU3hPR2FkTjh6KzRYMUlhcHU5VTB5WnBjRmxpZWo3Vk5p?=
 =?utf-8?B?aEUxazc3dzRpOGFhcndMZVpvTE50RmUxdFUzWER5Z0tOWWJUSnRJYmlEaDQr?=
 =?utf-8?B?TlM0Tm9selBtd2hYeUlJS0ZtdzY5cXUxdThpakpKbWNGdFkxdysxZFZyaWVw?=
 =?utf-8?B?ZFplU0d4UmgvRWY2SU90RjFLM20wK0E2UTk3OUJ5U2FnRkJZK29FTDJkb2M5?=
 =?utf-8?B?bGx1Z1kzcld0NnJKd3F5Y2xMbndQWFNVTjBlQSt1YzMwaDNVeUJSdjVZZVJt?=
 =?utf-8?B?Rlk3WjFYK05HclRDQUpMc3gwR1VnWXBsTk51bTJ3QldlSTdnbnZEZmZNYWs2?=
 =?utf-8?B?NFF4UTF3T0ZvV3VKNmlkUURSOWtEM1VXNVhjZkJ6bGx2VTRZZW5RQWlvbVNT?=
 =?utf-8?B?d3d2UjRqQmJlL3p5Ym1PdEsvZjRPbFdyM0tJZXdidHA2NFRHM05xekRGbnRh?=
 =?utf-8?B?MlloMDdFTzZQQWNaSWY2OGVZU042OUl3YU1pMEpaMW8rOG4vVHdnK1NsSHAr?=
 =?utf-8?B?RlBvMFZsanRvNlpsSUhtU01IR29CdVVEQlR0cVducGlvRVd1Tkh4U29pZXk2?=
 =?utf-8?B?NTFPZk9xU3NtSzJrOGgwVVc3N0ZQQ1BVOTBhTjAzS1NMYVRqV1pqUUgwRUIv?=
 =?utf-8?B?ZmNmQnZNUXBUSG1BdlB2MWsyYWR4ZnY4M3hnL0RTa20wQ2NuZmpMYjM3TWpI?=
 =?utf-8?B?RVB5MVlLWXRQMHNkUTZYV0lkZE5SMjkwVDRHb2RGOWVJc2drbmp6aE5kamRi?=
 =?utf-8?B?bHZzZWlTYWlRTzV3cC9Bak40UGttMWtNS0d4dlR4TzFROTBtY1B1TkQ2cWNX?=
 =?utf-8?B?dklRMkc2eHdheE93NWJXYmY5Qzd2dEZhSTBGR3BKM0J2Z21lck92YjFVTU8z?=
 =?utf-8?B?R3VhQTJrT1BINHBMbG4yeGd1KysrbGFJTlBmUFhBYmJEanI0MW53M3pWVE5F?=
 =?utf-8?B?djRTQjNGem94VjdzT0xOL0xYdTVwbXhoci9CcXBUY0VHbGR4b05xb3VZVWdv?=
 =?utf-8?B?S0NvZEI3b1ZrcXBDWnI3a3cwUjg3Tm1ZWThnd3RaenNrZzRneFF1cGs2RkJw?=
 =?utf-8?B?MFlZbllUSStjK1hsa3Vwdi85U2RpcEFKK3JCSkQrcjRtN3dDYjZHYW90OC90?=
 =?utf-8?B?bS91MWxGUlE2M0hQVlpHRFJxRWgxNVZOZzFMWVFNbkpTK2hPcE9SY2NsSEd4?=
 =?utf-8?B?SHZmamR0WGUvQ21SZ0lJZUdnN3dQdkhXUlJUN2puVTlWMnBDV3VBSGphbkxP?=
 =?utf-8?B?U2JaYndDTUpjZUxua1FDekN2WWtaQ0VyOHNSVHpHQkZmUVpqQkFTU1BOWnc4?=
 =?utf-8?B?MEZwKy9uT0JqT3Q0TExQOGtGdTdoMTgwek1nM0RReWJXYmR3SmxzUCtRazQ1?=
 =?utf-8?B?N2puZCsrTks3VEFWMi9CR1REMjE3RDNRRmcvUW8wd25jQVdXeEJBQzV3Vjk2?=
 =?utf-8?B?QzJocXB4RllxV1kxMlpQcG1raXdSNWhBWmFzVnQxTm5ZSUkwM2xxUWJ2L1Bw?=
 =?utf-8?B?aHRvMzkwMTk1cEFydElNYlFsYWRzK0dVdmJJRDR0WnoyRko4SVp5QmxQWGFq?=
 =?utf-8?B?QVhqQmlhRGRtSG04c3VkUnZLcFpzSk9Na2ltYU51V21qc0NybDcvcnVTZDVU?=
 =?utf-8?B?WmlESHlZK1ArOHNkQk14UW4rb2ExK3V2RTBvdmhSaEdhVnFBY2w0am0vdk11?=
 =?utf-8?B?WWlkR2gvL2JzbDBOdjhhWFRuZUdZOFBKTzhEYS9LNEFRdkp1VFhzN1k2Vm5v?=
 =?utf-8?B?Z2pOeXF1c1B0Z2thbEFUS1JUSjFRVFpYNEoyTXRvRVl6UnFoRVNTYVRQUURP?=
 =?utf-8?B?WGduZkRnWU0yYmxWQU42RlBQRzlZeVBUSDhuVUFKUGxGa2k1MkpIeCttbVpS?=
 =?utf-8?B?WnBqSzdZdUtlOWNNbm1iNXJjTGFQRGF5VnVsZUhCU25LRkNwZDJlTEJnN3VL?=
 =?utf-8?Q?kxewyprt4ussuarzN2RT2KjRt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c200886-d75e-4e8d-e769-08dc9562e39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 22:05:13.7519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeWnsLR4EvmoCz7qbVeIGN39k46NR4+H1mTxq8wwb72+786s5gd+2rADDIDF/jBMTvPADsppDPKc0vozh8WNJ2A7mXaDXKAYF3Vaewkh++4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698
X-OriginatorOrg: intel.com

DQpPbiBUaHUsIDIwIEp1biAyMDI0IDIxOjMyOjE0ICswMDAwIFNpbmdoYWksIEFuamFsaSB3cm90
ZToNCj4gPiA+ID4gMS4gV2h5IGRvIHdlIG5lZWQgwqBuZG9fb3Agc2V0X2NvbmZpZygpIGF0IGRl
dmljZSBsZXZlbCB3aGljaCBpcyBzZXR0aW5nIG9ubHkgb25lIHZlcnNpb24sIGluc3RlYWQgdGhl
IGRlc2NyaXB0aW9uIGFib3ZlIHRoZSBwc3BfZGV2IHN0cnVjdCB3aGljaCBoYWQgYSBtYXNrIGZv
ciBlbmFibGVkIHZlcnNpb25zIGF0IGHCoCBkZXZpY2UgbGV2ZWwgaXMgYmV0dGVyIGFuZCBkZXZp
Y2UgbGV0cyB0aGUgc3RhY2sga25vdyBhdCBwc3BfZGV2IGNyZWF0ZSB0aW1lIHdoYXQgYWxsIHZl
cnNpb25zIGl0IGlzIGNhcGFibGUgb2YuICBMYXRlciBvbiwgdmVyc2lvbiBpcyBuZWdvdGlhdGVk
IHdpdGggdGhlIHBlZXIgYW5kIHNldCBwZXIgc2Vzc2lvbi4NCj4gPiA+ID4gRXZlbiB0aGUgTWVs
bGFub3ggZHJpdmVyIGRvZXMgbm90IGltcGxlbWVudCB0aGlzIHNldF9jb25maWcgbmRvX29wLiAN
Cj4gPiA+IMKgPg0KPiA+IENhbiB5b3Ugb3IgS3ViYSBjb21tZW50IG9uIHRoaXM/DQoNCj4gRm9y
IG5vdyB0aGUgb25seSBhY3Rpb24gdGhlIGRyaXZlciBjYW4gcGVyZm9ybSBpcyB0byBkaXNhYmxl
IFBTUCBSeA0KPiBoYW5kbGluZzoNCg0KPiBodHRwczovL2dpdGh1Yi5jb20va3ViYS1tb28vbGlu
dXgvYmxvYi9wc3AvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX2Fj
Y2VsL3BzcC5jI0wxOA0KDQpPa2F5LCBjYW4gbW92ZSBpbnRvIGtlcm5lbCBhcyB0aGUgZGV2aWNl
IGFscmVhZHkgZmlsbHMgaXRzIGNhcGFiaWxpdGllcywgYnV0IGl0IGRvZXNuJ3QgbWF0dGVyIGZv
ciBub3csIHdpbGwgZG8gdGhlIHNhbWUuDQoNCj4gPiA+ID4gPiAyLiBXaGVyZSBpcyB0aGUgYXNz
b2NpYXRpb25faW5kZXgvaGFuZGxlIHJldHVybmVkIHRvIHRoZSBzdGFjayB0byBiZSB1c2VkIHdp
dGggdGhlIHBhY2tldCBvbiBUWCBieSB0aGUgZHJpdmVyIGFuZCBkZXZpY2U/ICggaWYgYW4gU0FE
QiBpcyBpbiB1c2Ugb24gVHggc2lkZSBpbiB0aGUgZGV2aWNlKSwgd2hhdCB3ZSB1bmRlcnN0YW5k
IGZyb20gTWVsbGFub3ggZHJpdmVyIGlzLCBpdHMgbm90IGRvaW5nIGFuIFNBREIgaW4gVFggaW4g
SFcsIGJ1dCBwYXNzaW5nIHRoZSBrZXkgZGlyZWN0bHkgaW50byB0aGUgVHggZGVzY3JpcHRvcj8g
SXMgdGhhdCByaWdodCwgYnV0IG90aGVyIGRldmljZXMgbWF5IG5vdCBzdXBwb3J0IHRoaXMgYW5k
IHdpbGwgaGF2ZSBhbiBTQURCIG9uIFRYIGFuZCB0aGlzIGFsbG93ZWQgYXMgcGVyIFBTUCBwcm90
b2NvbC4gT2YgY291cnNlIG9uIFJYIHRoZXJlIGlzIG5vIFNBREIgZm9yIGFueSBkZXZpY2UuDQo+
ID4gPiA+IEluIG91ciBkZXZpY2Ugd2UgaGF2ZSAyIG9wdGlvbnMsIA0KPiA+ID4gPiAgICAgICAg
ICAgICAxLiBVc2luZyBTQURCIG9uIFRYIGFuZCBqdXN0IHBhc3NpbmcgU0FfSW5kZXggaW4gdGhl
IGRlc2NyaXB0b3IgKHRyYWRlIG9mZiBiZXR3ZWVuIHBlcmZvcm1hbmNlIGFuZCBtZW1vcnkuIA0K
PiA+ID4gPiAgICAgICAgICAgICBBcyAgcGFzc2luZyBrZXkgaW4gZGVzY3JpcHRvciBtYWtlcyBm
b3IgYSBtdWNoIGxhcmdlciBUWCBkZXNjcmlwdG9yIHdoaWNoIHdpbGwgaGF2ZSBwZXJmIHBlbmFs
dHkuKQ0KPiA+ID4gPiAgICAgICAgICAgIDIuIFBhc3Npbmcga2V5IGluIHRoZSBkZXNjcmlwdG9y
Lg0KPiA+ID4gPiAgICAgICAgICAgICBGb3IgdXMgd2UgbmVlZCBib3RoIHRoZXNlIG9wdGlvbnMs
IHNvIHBsZWFzZSBhbGxvdyBmb3IgZW5oYW5jZW1lbnRzLg0KPiA+ID4gPiAgDQo+ID4gQ2FuIHlv
dSBvciBLdWJhIGNvbW1lbnQgb24gdGhpcz8gVGhpcyBpcyBjcml0aWNhbCwgYWxzbyBpbiB0aGUg
ZmFzdCBwYXRoLCBza2IgbmVlZHMgdG8gY2FycnkgdGhlIFNBX2luZGV4L2hhbmRsZSAobGlrZSB0
aGUgdGxzIGNhc2UpIGluc3RlYWQgb2YgdGhlIGtleSBvciBib3RoIHNvIHRoYXQgZWl0aGVyIG1l
dGhvZCBjYW4gYmUgdXNlZCBieSB0aGUgZGV2aWNlIGRyaXZlci9kZXZpY2UuDQoNCj4gVGhlIElE
IHNob3VsZCBnbyBpbnRvIHRoZSBkcml2ZXIgc3RhdGUgb2YgdGhlIGFzc29jaWF0aW9uLCBzcGVj
aWZ5IGhvdyBtdWNoIHNwYWNlIHlvdSBuZWVkIGJ5IHNldHRpbmcgdGhpczoNCmh0dHBzOi8vZ2l0
aHViLmNvbS9rdWJhLW1vby9saW51eC9ibG9iL3BzcC9pbmNsdWRlL25ldC9wc3AvdHlwZXMuaCNM
MTEwQzYtTDExMEMxOQ0KVGhlbiB5b3UgY2FuIGFjY2VzcyBpdCB2aWEgcHNwX2Fzc29jX2Rydl9k
YXRhKCkNCg0KSXMgdGhpcyBhbHJlYWR5IHBvc3RlZCBhcyBuZXcgcGF0Y2ggc2VyaWVzIG9uIG5l
dGRldiBtYWlsaW5nIGxpc3QsIG1heWJlIEkgbWlzc2VkIGl0LiBUaGlzIHdvcmtzIGZvciB1cywg
d2lsbCBmb2xsb3cgdGhlIHNhbWUuDQoNCj4gQUZBSUNUIFdpbGxlbSBhbnN3ZXJlZCBhbGwgdGhl
IG90aGVyIHBvaW50cy4NCg0KV2Ugc3RpbGwgaGF2ZSB0d28gbW9yZSB0aGF0IGFyZSBub3QgYWRk
cmVzc2VkDQoxLiBNYXN0ZXIga2V5IHJvdGF0aW9uLCB0aGlzIG5lZWRzIHRvIGJlIG5vdCBqdXN0
IGZyb20gdG9wIGJ1dCBhbHNvIGZyb20gZGV2aWNlIHNpZGUgYmVjYXVzZSBvZiB0aGUgbWFzdGVy
IGtleSBzaGFyaW5nIGluIHNvbWUgY2FzZXMgYW5kIGEgY29tbW9uIFNQSSBzcGFjZSB0aGF0IGNh
biByb2xsIG92ZXIuIFNvIG5lZWQgdG8gaGF2ZSBhbiBldmVudCBtZWNoYW5pc20gZnJvbSBkZXZp
Y2UgZHJpdmVyIGJhY2sgdG8ga2VybmVsIGZvciBrZXkgcm90YXRpb24uIFBsZWFzZSBhZGQgdGhp
cy4NCg0KMi4gSGVhZGVyIGFkZGl0aW9ucyBpbiB0aGUgZHJpdmVyLCBmb3Igbm93IHdlIGNhbiBk
byB0aGlzLCBidXQgaWRlYWxseSBpdCBzaG91bGQgbW92ZSB0byB0aGUgc3RhY2ssIHNvIHRoYXQg
aXQgY2FuIGJlIGNvbW1vbiBmb3IgYWxsIGRldmljZXMuDQoNCkFuamFsaQ0KDQo=

