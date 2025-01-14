Return-Path: <netdev+bounces-157995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DC3A100F7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 07:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C97161C1D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C271C3BEB;
	Tue, 14 Jan 2025 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9/646NB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD83232
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736837406; cv=fail; b=pNxKArPVNE4z5qBS4mWDyPeMemIow9MP1Vf0Wh3HfT/09SrDkIKEP1A0AIJvGQw4BdfkvAb/C24R9TYbHP6ED/KCuY5u2nENRLSEE6oHpeqqQdS7F3XlCYjft/WoVdn2WX2A8cFuvdkgXtb/UMKh1vTw5tn/IXZlFy+w00EbUb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736837406; c=relaxed/simple;
	bh=u8xy5qXZvGqZ/dtO9ME393tPkyGpo57qWT5aby2Ungg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fIfkJ+WsKJHrGjcGK60DiaNyv4w9rAXTuirGOMNL00343RoNfKV7tE+771Tcdw7EqAojUNNIoOcN/8TT7ELnkjKJRwTo4FTemwkSF0MALmyhCqd1QwEUkPYOHGKEBpCkw8C7ZUjcxQCvBgdcFf5LzOVJP6HOI2GCPT1Pn2L8Gns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9/646NB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736837405; x=1768373405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u8xy5qXZvGqZ/dtO9ME393tPkyGpo57qWT5aby2Ungg=;
  b=C9/646NB8TAQRmwnzd8li9cVuizUIcGTVqkMNTOal35nTxGPSH2tLvAx
   oeu5pc9AECM0AAqt9DW0uNCmYcgwWZyiD24DM/E9ef8jVWNBpTCm/kVwQ
   kGFt2ZjKYul9tuIRZw5TDg7mdWdqxIiY3e/yd08ekWhUoJgqjyEZ0oKm7
   NJdYKI0d2TyTmrS0NRQvxc3uJ7wr9bPlBNsxmb3sA/D2ZxiYZwFSvqUve
   U5OF9R0xsSHRUppMObsK17wZhDAI8lD7ygwjyXHdrNGeI63hLffPty6Js
   AyAJRElxonQ18Mu8/l3zmyMrTquLCEe09bnfV8+2IREE/9nPjLyczjR9y
   g==;
X-CSE-ConnectionGUID: 27UB27wvT66FSCysGQtlKw==
X-CSE-MsgGUID: /ul51M+nSyK4qk/YEHL0uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47786185"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="47786185"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 22:50:04 -0800
X-CSE-ConnectionGUID: GncqrkgnTkyOw59WiTAXGw==
X-CSE-MsgGUID: pezAlNQmRmSjBfRcWoZt3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109343473"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 22:50:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 22:50:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 22:50:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 22:50:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPm7Wk0Etj59lsJc4/ef/aFcz2QiC5SoL1d/AgY36YYUG6Z4gE4Art8juJEQLPura2c69F97/nIRZ5YERbeq8qtsx0PYLJ3g79LhZRc86q0aH0d+0zZt8Q0Fy8Pxcpw6O2+0q5hRCa9wRnRalLDXRCAtva5Smk4/Hi+bVrBQ+mbGoYGIEmqrgHqO9TGQIcNSPn1xJJCq46hZp3m9YPuph6GmzMRl8qiZ+1Em8+jprurEaV1WyH5+aaWbQywDDyFaOoWuLRXdYmmZJKhX48ol+aCCiMdaTpfwuDg0fjxms49Ed9RxuZPUFv8bxlo9WODtn2UA2kImp+mhY/2NYZd/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdCxi5Sg35c85gpU+bdyTSZOlffu/e63T1IBmVCKGYw=;
 b=jgeGn/LiNMzjKknFFREfKWxZzefjuh0WcBErzuQWMfj0hJ5Pf+Um3NTTmiImHnIUA101gS8S+yYh7qDfp2VMVQR86ymjWfB75YtGRZeE7qGNQXobOf5g18UMAvEnceOpZJ0DLxvF/nHVNarFz5oPgN1+hmqBa8eaDxR5acpazOQSFPnVV00QfInAAr/CCrgJTcj5dmvCTUwOEONoeNJUjQnGGJ5Xrnb7V2EVWffVTQWkoKAteO8gGSDLiJVJjdaNkvvzVmyOxeAha7ZPSaWWlURKkt+MqlbtK44o4bogcig+1xrNcz+YNdFi4tKU4wkuOp8YZrdOTv5Ymcpp6QF65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 06:50:01 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%6]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 06:50:01 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: Tarun K Singh <tarun.k.singh@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1 4/4] idpf: add lock class key
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1 4/4] idpf: add lock class
 key
Thread-Index: AQHbL8ykrsfytZfRwES0C9x1fQ99b7MWQUfQ
Date: Tue, 14 Jan 2025 06:50:01 +0000
Message-ID: <MW4PR11MB591191D5190FE6B66553DA0CBA182@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20241105184859.741473-1-tarun.k.singh@intel.com>
 <20241105184859.741473-5-tarun.k.singh@intel.com>
In-Reply-To: <20241105184859.741473-5-tarun.k.singh@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|SA1PR11MB7062:EE_
x-ms-office365-filtering-correlation-id: cbc2ed2f-4c5a-40fa-44d2-08dd3467ab04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?zFqoyAaqOv9IKJ8u7ifkre+arpcYDr/gwzQoZgtbxZpYII4dDLtXbvM/ZIxC?=
 =?us-ascii?Q?yRZkx5ON+UVdVKfXO+ObZbH/MJQuwHSBreq2oVo4tApmybDJ0MkOVGXohGre?=
 =?us-ascii?Q?imYQcFKf1amwXJO+rx/FjNwq7Exl0ECLG2BP+9mP/4egXQkiT0/Ecl0MEWic?=
 =?us-ascii?Q?D8gjFudnr+IMX+HKSOBFxVuFtbid4qe6OeU/sr1lZZWFxxMPEwG+xXEPgqPd?=
 =?us-ascii?Q?8+WtCH/wgKi4eytSVBQJGQVcAoW1oIAWfJDlRpqGbxk5IYgePAeVqE6hFebv?=
 =?us-ascii?Q?QRYtiN8r8PsoLbkhvXJl3CJibra6rPeeiiSkCrokHRPEHv7ycmb+7F85cBvv?=
 =?us-ascii?Q?C2a0adlLjd54VitPBkZcYdYQR5r4uxAj5PtYJVLdXkOM//QepaIHQQeSTjcA?=
 =?us-ascii?Q?8MFeDxVqbb6wk+XR+YDPjZWV6r7ZurjDp8K+zooLIoXMSCy/pwNT7eNTINOQ?=
 =?us-ascii?Q?yAaS+pMn54e81P79p0qCfkxjfBdH1vzW6c8t4D8tkY6sZq6LZfNpjogXFnNT?=
 =?us-ascii?Q?fPvIxUaBNjETj4Hb/mOw7CFeAzlO6sAODtOqwskg7QYBkRdcDZDfX62tg4L2?=
 =?us-ascii?Q?2HzLVMfQJOPBd8r4Ts8fPkuBHh0oopNwmw6nbXOGmgkNyLppeOuHg+EAzWgv?=
 =?us-ascii?Q?4xzfiGuZKrzyX65bt4Nmo+5jmIMB9Z0Gll8+neYydFdzpxC2eSM1qntkBZWK?=
 =?us-ascii?Q?vWVWOQeQU8sfH1tvj9OCok2M0R67nyDOsj+7hd1covBANEdUUzGdMHUFXRNv?=
 =?us-ascii?Q?YuNSjygzRbJdHpuNQX1Z7lxW0iYzvijpIw5unBVo3rTHaIZeaKWfsBkTR9eV?=
 =?us-ascii?Q?xUvnBLODN33MkxBYY05v84DUsFNFTI4QaeUBSVrA6eRc4ir+NKBibyo9bXnQ?=
 =?us-ascii?Q?9iEQvlyk+vazc8xiTob8bSMzo6ff6maC6vj99dT/nKpSVzBNYP5Le9aX4ebN?=
 =?us-ascii?Q?qgTso4wgLPqVgT0i0HglUr0jrswdZPf60iogue5qT8R8zujkvIa8IYFGPg+R?=
 =?us-ascii?Q?oKvNBkn38w8Cc54OqCXhhiJ3VXFEummq4zoCM0g5NCqWGbt910vYtyUCOw8d?=
 =?us-ascii?Q?do8156xIyFBXvfiQWVSiNAWQYo9peXnx5TUeVXcr5+aM16frhlPvt92Oya0d?=
 =?us-ascii?Q?n3E6Gd+iKGbvtL2tC8Ze90tGPgcsrH1T7p5V6eMcH+JGvyFWWLQjZZqx7JIc?=
 =?us-ascii?Q?5S7TGipJh9L35MBWWvjpoVdxMF6Rn3BzhYpFgI3Vn+Fw32mvhvuW4eCegbGH?=
 =?us-ascii?Q?FoNb63+GTFvCb6K/cE+1U8ScSROOUa6106/JHYqZWmqVdcMlXJw6wKhFO1l+?=
 =?us-ascii?Q?zRcxNPqjEjmS8dVc80eXEbftaKf7iN0+B0HvMr/gUG1c/bILKP7ShsPzpoTO?=
 =?us-ascii?Q?ki3CNiftJeVzJ5ZXpfaTSQAntZrf5NlIa1D8/oCYm32VC9uSozKhuIuP8AXO?=
 =?us-ascii?Q?VtG9Wi+wmNnazyQe/zwerxaImtcZMmDA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FQHUdNxGUFipJE6PToihBN7qCl9QbWkeZf068o+sDE5c2Vd9npqzBKmxdAo/?=
 =?us-ascii?Q?F1mQDQe+ujOajIyNHR1MMyDtQE0KYu9yd+bh/QKGETFKFBwjrdKDYq19upeH?=
 =?us-ascii?Q?cQvV2Jii5unF0D6BZj+xa+eGn/cz+ej2L1SE0VL+aydu+7/YwQcWO8dEmhH9?=
 =?us-ascii?Q?mH7g62VHoEceQoOltYB5nfzIFM08PydkXHYMOhgyCt2yBlkQAJmAYxRU8M1C?=
 =?us-ascii?Q?57NMQFWmL+h5Ru1iZjbl/0XP1nfc622+CnxEWHe3kSYBUBLix1F9f12Q7n1q?=
 =?us-ascii?Q?HVEznZ0H+oEMSK7XSd47dyYz+VFda9zgQYeDgQIQxYt2+gBEQIK/9WSm3QIs?=
 =?us-ascii?Q?6SPTg6peOkcJgBjmfvDNXI4SlAXzHQg4XyMcitn0GblYY7Yc7yUNIn+mT9EM?=
 =?us-ascii?Q?d26nPeCkVc7RikuH9KypCy032ZZZSGNC7dea2DLyR/bB/xHYZyBlXQnJQZtY?=
 =?us-ascii?Q?CoTskZ2jre4XxWya53ojrsHSi6/ZW/5LczytFieOlLyWY/HWdEHgQKK72W/F?=
 =?us-ascii?Q?sXWMDBW6pgyB5Kcd9eenRNFsdilHOaS9w0YLXUnMYaxspchahXrarFWc5m0G?=
 =?us-ascii?Q?OqqQ8ZZiNKSD8arNdVueo+A45ns2RRRvL3rz5aSF5LqayZQu0LmFzs1Z6LUH?=
 =?us-ascii?Q?u4/pP9VUZ+l/+BLmHydSIwg/DgUllrqtpaqL9bfQuHZuse9FFtezgLiRqG5W?=
 =?us-ascii?Q?sSfefWtlSZb3SGFwQio2u5h6GIbxFxJRZ+UvwcUa6gbCABRQgGERxE0s7dcF?=
 =?us-ascii?Q?HPcLnLPZ2wyLp1HjgQw3xB8VsHtlhwLRqAFp3bwatjqKZwZnv5kUkBucC1v4?=
 =?us-ascii?Q?tMmDrJioc3tEKFLE1nWfBONpyhJv9uSKe9pVpuejB9YN2rNIHuG+Pc+Q+jGf?=
 =?us-ascii?Q?sC5woKniwnHITjURERyfEiIg4z5zTzlzNg37jqUK+MsZbU8lxE0q02+L/CtR?=
 =?us-ascii?Q?RzXtc7w/Gdf3zur0Qg8mRyJbgASJD3f7HS3gpEPQwT4k7IJaIZrMeZtplG4G?=
 =?us-ascii?Q?BgKd4y8+FrKWj85OocRm0XYi9wepTKVnzd0fodmDWELvH3eDQ9RrlnCoKLLv?=
 =?us-ascii?Q?ega3hB7qvvTBX42ppqL6zM1AFsj5Vda749/RZejofOeUD3JbtE3/VnQGEhVR?=
 =?us-ascii?Q?iDJpRj5lHpzS9wyUt9zEGJNY8PJbkceZwbACJCFuGPxzevO6ArgtYVKONg1D?=
 =?us-ascii?Q?qiD9lEsGwlV8X05dBLQuVel4RCnUWs40MLEDlzOTwKCThg2FA1S/nbOEou20?=
 =?us-ascii?Q?EV70Nbe/GaFXzSuk5SHnE9mhlyHPtW4Zi9BBU5M2yykn6OvYk9mKJmXW6oKb?=
 =?us-ascii?Q?f0nFfSIsvDVgXpaYbiieNj7ulWteLPVLZ6GuNXBmEzoviJe7lwBhVu5yt51m?=
 =?us-ascii?Q?b34VNWS6k4qUtf/FvN7udn9nT4TAk5b2UhnqeFPrOhAHEfO+YL0q5M+Z3gBl?=
 =?us-ascii?Q?0p7w9GVI6BgJ5qybfWBs1QQKKBvBz/GM2JDqvqmLlvPa6C+Fs3MrtrpqpABy?=
 =?us-ascii?Q?67H4tBG7Gw+c485O4GJV5qdjSt32Zunno8fKq8agmwLq1KZNc9KTChcYXawJ?=
 =?us-ascii?Q?1qqre+dVFKxVUu4bbYxOM15I2YhAzfDn+NvbdAMw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc2ed2f-4c5a-40fa-44d2-08dd3467ab04
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 06:50:01.1882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jw5UusnKMZTjx3QqbzDSJr4MfOaOubmtDIf9USft3Bvo8SHvxxWaRXK1Yt1Cvu60gNUEUUEnrrT/eiiqNBfVhpjg5WiOi3SpZNubV8PWnOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tarun K Singh
> Sent: Tuesday, November 5, 2024 10:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v1 4/4] idpf: add lock class ke=
y
>=20
> From: Ahmed Zaki <ahmed.zaki@intel.com>
>=20
> Add lock class key changes to prevent lockdep from complaining
> when PF reset the VFs.
>=20
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Tarun K Singh <tarun.k.singh@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_main.c | 32 +++++++++++++--------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c
> b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 04bbc048c829..082026c2a7ab 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c


Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>



