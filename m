Return-Path: <netdev+bounces-112575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED3939FC8
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5C72836D6
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E47D14F9E5;
	Tue, 23 Jul 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7jvqgZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40E8287A
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733953; cv=fail; b=FVCb9dPW+yqVrsG+mSHS1Ds2G6fe11gfRV1X/8OHYS0FtuR5CBVZJsK3assj9bBVzR034Kn6272XQhf9dWXHFy1B0AtKr/PQzpFqm8dhonskNuSwl0CIVEftMQPRqu7+QlUCS6m8b7zzRaFfyWk/PlEWbhesbrVQ/kJHX/w+LiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733953; c=relaxed/simple;
	bh=MfhtwqcssqjFgHV9FRKfQ+YosKzHAD7fi+El3ltb4k0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlU90DC82eRnPn9NQf392w0t7ODog8c+Ws4pHBz+4rcMd/7FAyQZ/jvKOtQ9Laly+ltfBH51UQweovudFxGdf4Y+vcjd9KnFBXl0svAGMhGJNpgse4P2j+Scqp8ETMP/DgcDO/f/le1khMZmf/ltUO7zSmAt+2cJ0f/kse9SkAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7jvqgZ0; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721733952; x=1753269952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MfhtwqcssqjFgHV9FRKfQ+YosKzHAD7fi+El3ltb4k0=;
  b=Y7jvqgZ0ffslacDNrkcIMb8+4wnhcDfD3Es6l1sBKdN0oP/TbUpjLwrb
   NMi70iSHKsOJ6/ILy51h3pYbuMUnz/eKHLSVFrJepapXjByUUVRdADVPT
   e1cXHyKIuJwPnyo1pFyGAMgYuBpc5ENNLrG9IcNL3Wa9xELtm5ivqI0ql
   IXRYIfSV1btvpcygIZzI8VpaWmvz9rpiz95mnLAz3QytLLkG3DMIkM4xJ
   iIIm5DG0eGoFrPUKy/YdnNRVlQQh9zRRJRqz76MAim7IUg/cSmfGH9LTI
   mDB2YuSjIfLkErxk3c/whURCqoFK6ccWtJ9VdJb3FffOQ09fVwsfLppY8
   w==;
X-CSE-ConnectionGUID: mhaKGG6+QaWB82K80Y8CoA==
X-CSE-MsgGUID: fmIgCKhFT0agadGSzdO+4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29941626"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="29941626"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 04:25:52 -0700
X-CSE-ConnectionGUID: zO1eKFgMRUeI1HAu19bDdQ==
X-CSE-MsgGUID: HmDSVTKPTpeodELcGEjmNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52219304"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 04:25:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:25:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 04:25:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 04:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxAI5fBexjOq2HYQ4Wytoud9BGPZtovwFMHwWN7F4dNFaux34I/d3+sWVVCfnftWoXj8pngkEzOew0GgU1z/F9FVrYsk1TYFgCciVtOIrgh0ZaMrJ6+8dvV9JsXM178rXQQ+rvVFrXlypY6XJU285fg1OopZN7ZtXVd814UB6I8hkzq0z38lJXDwzFbeJhPKt6NdHsUyryTGzHOWoMkU2BzbxUULwsNkrzm1gxHlHYMpokYDoj2TUJ17eHb9Q4f7bv2AOMdA36zGGBDVQsTw7mpgkKXaO0WjOT0hMd/fbx3fJSITnuhl1yzpLWYmcEmTtw+psVpVcGvsF9OQW+VR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=911vOb+AUnJ2n8ShCgRFikcAbMEQcfdeftgtVCcRq74=;
 b=xjJAl98pfJPvrDRWgxCUOpPE2f8gi5Z4eluLHqntr7W4HB9nGiB7eOX7njrvEpjYqVLsXv+0n3PM/s0mMcYtGDemXQR4h8PotWQf53NYR63L9292RNerDra+Dyj1HEfhaXYN6AzLNFRPF7E3ni66DoLBDBo7/KqT9aY+5jADl42dbzuf6U9YSqCAJYGqpvxlCk9p+KeWD9gIcF4taBlqcmUwNz6kRjcxm+HqJX3jJw5bAvNjEf6v/T/u+UXYbSILR0abDaN/PQ3j0j0qOOfYZwlIduzVcaOCkTLPuEh18gaTAfao0zLGWwwp7mG9/vVQud1nXoC+TLl3gA998ouURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 11:25:48 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 11:25:48 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "shayd@nvidia.com" <shayd@nvidia.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@nvidia.com" <jiri@nvidia.com>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>, "pio.raczynski@gmail.com"
	<pio.raczynski@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v5 14/15] ice: basic support for VLAN
 in subfunctions
Thread-Topic: [Intel-wired-lan] [iwl-next v5 14/15] ice: basic support for
 VLAN in subfunctions
Thread-Index: AQHauAPDcWfaLdhs0kCG+scU78xqlrIEdgAw
Date: Tue, 23 Jul 2024 11:25:48 +0000
Message-ID: <SJ0PR11MB5865AA8B7EE9F17716E218818FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-15-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240606112503.1939759-15-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DS0PR11MB8052:EE_
x-ms-office365-filtering-correlation-id: d8a15c3f-079b-48cf-91de-08dcab0a33d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ximp+YjwlGOM8DV+iAAL3bJuUCaJU11rTMKeZhR9HIbdN9GFU2T3FHBbZRN8?=
 =?us-ascii?Q?Q9zGwV2Si1NXYafWKq4fHoEEW3sFgzwmLPOkXTXbuhtEqJDVWpMEGgyqbmAv?=
 =?us-ascii?Q?jtinWuO7u1GiDcjtJF9bWoAYHFi7xrKIuCUvY/Mff6X0Wx4rkCF9fbd+PsoH?=
 =?us-ascii?Q?GII4HJkKYeYOncebD+NaM0YX2BWqVPhGwaXKD+RhtgVpLV38c3fhiCzCxS53?=
 =?us-ascii?Q?ZuwfK9FbOecXdEqQLDAJCKzHAmzGBDob2EXsSJoxdtQualejOy9mmwz1YtZF?=
 =?us-ascii?Q?/djkdz6AB2jR++1iWWEpxNXtlS8UUqC/eiHABHF06PBr80RuWqydaysLYTYM?=
 =?us-ascii?Q?041D4sVpiMKDZjl+cQuE3OHCL3d/bFqW5m0BkuRRq3MQpwFrx1cK1wxt8AK7?=
 =?us-ascii?Q?IGDgjbsgx+RuXsV9QBIPwZUDRdQfiRGfOb2o6f7PTUCQsGD1Bp+l+Fw+FTEK?=
 =?us-ascii?Q?DlJFwu8E0JmvMinqQPFjunnRnjeCphorD95X12T3dzRv4/laKbzWXOlbv4JP?=
 =?us-ascii?Q?O0+G2jrHZyRkhF7Bk4LwT1y8ZIH/Gcn3bVHrL6JbVAdbBBIFuidFgHz+lO4a?=
 =?us-ascii?Q?AV2cVrAMHz7wTvMPX+hjx7NF+jBi2LvZCWUE34b9e6dsz/Yq0fHKfCYMq1l7?=
 =?us-ascii?Q?Ve0PTy9YwoPr60iGyWfRxiYnpV2H2xEGLGmaV2c2Sz7hveGySDTu8zMOOuwv?=
 =?us-ascii?Q?wwel0Up6vwhP0FJxJ9o6w4VDfe6FDxS08dta3mMSTKPH6u5Bwx9EfzAbEGqP?=
 =?us-ascii?Q?Iv8BuHn9m7dJfeRC4fQHopadQlSLfxvWR1m7wxza9rKqgsyMO8ZLEkxqSf1X?=
 =?us-ascii?Q?8ZzKcFu9YuTGOl0dG1R2eS1WDEe0Q7aLiHOSj3e0+A1ugfKBBs0v2soT+8Zn?=
 =?us-ascii?Q?nsg7n+7uI491+Cy1dU7l0swbHiT8gpkC6M+i6UV+iNzye2yKaNBaAR9vSmmP?=
 =?us-ascii?Q?urZrMzm08p3Y1XtKNgh30q36jj6uOkMwsG+s6P2uRRestUffeao+QKiwenTY?=
 =?us-ascii?Q?FOasy3SQBQIDOMKp+mN7lmU+YtFN53DbDam9W8n+gDBc7MWKYXQnuT20Ml6A?=
 =?us-ascii?Q?CNz8eqRZWGbIgnMUKcweS9EpjGIGawOw5pYF+1wdm6ktBRdxJnby3KW4baYU?=
 =?us-ascii?Q?cGkQFfKOEDZN9pocuxOftCIeM2HgydhDoh/RVbuYFI3wcqACnkr7Te2zdxdz?=
 =?us-ascii?Q?O+3fotMWVtXhwx5aV88MI2+g+zkGSD8Q7zjRyHLW7wvPzJeURWxb1A5z3ikx?=
 =?us-ascii?Q?NaGoSN3gUi9liGVpPWIzh5S4rbjw/68R9blMciWJLVvSOZD3DR/4Ti6Ac5lT?=
 =?us-ascii?Q?JdAGQ2016pl4xZB5RKwLwMDV6zsq9CR+t7maNOxDoqHLqcTKmMrPqj3ZcLOp?=
 =?us-ascii?Q?whkg2WmNq6gMB4ezCUNVW4sBGhPZpCxcCrTGQPN2gF3gy9Pusg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9vhNaFaFi9GeidhtX78F9TfRAJfMUHQGP/7mm07Kf6nv/sAXeTxAfvXa7Z70?=
 =?us-ascii?Q?DEp+MviC07j5UG/hzUtLby75AVHyc+V2r8Xy1w7vsbUtChMf36aMa3ZamTBc?=
 =?us-ascii?Q?oUTBPBSe7dLVpsCaynoN9iLlXx8IIxTBCXqWgMyC8PEvpptVywb7TSfZIFna?=
 =?us-ascii?Q?MLCM97bRjNOUbQAjlNyUy2HV3hLPHlWG3DkNGHH91GCmuJg4pYDE9TV5HJBR?=
 =?us-ascii?Q?Lf/pJzeY32KB/cWzbSce5e8dpR6GasfQs4Yau9t9Y1JEjXw5vRs5wP4vM1f/?=
 =?us-ascii?Q?erbbZMlfxeNVQmAq5zPj68qRvo/t+yBZ6z317Y6/o9vdglPGKIDuIpBumXi2?=
 =?us-ascii?Q?k/heD+fxhSpQwcy5QpyqFDt+mlC22A0OKVKaIJr3cw84ndGPzBaUeU0oVH88?=
 =?us-ascii?Q?V8XbBY263zXB0OPUj3heta2TwVVwQQX08LIrUllUo4mZfIlIfp4KIt6Frxie?=
 =?us-ascii?Q?tuo1otfQzEFEw6zJGua4ztGpKQmpJCiG18iLUT5xdSJhK+Qx/gr1TzX5WoDq?=
 =?us-ascii?Q?6SoVWiUmJ/h9ra1YceaX9z7RAan1P696JfoCe8IhlUNO9KCEczAVwJews5Vd?=
 =?us-ascii?Q?ITawmiWsiFXT2HkWWj0YjWSUpZrUTBCo0knrbamP6/ZRXUoGjxs3/ddGK4tk?=
 =?us-ascii?Q?v8L3wfAiGUoOD5lN2nbV5/FAKA66MkuX1i8tk2nAJamBq6/RqjUTp+uGn7uz?=
 =?us-ascii?Q?Rhr/v640t3SUEOl/LvpSQTGkjHuF9bsmFJGs0synsH6p3fqX0vJdvd/37/h6?=
 =?us-ascii?Q?dIGUKLTfGBhwP30eM8YkzYUTUYEChFPMxnxLXQimRjNSPHKkacu/q4vsFzdN?=
 =?us-ascii?Q?G4hKd5w3ZDpekB3ckHKbk9mEzWeOmpm/mDOVRhru66TDktZVrbnEaFlMBknO?=
 =?us-ascii?Q?tkGNY3s8L44uO6OKATyMntlHl+E9XkCrm6XJPBFJHk/jDeMbuyvjiFQ9j/bF?=
 =?us-ascii?Q?+H1l0vAFQCoof5S4ZRYSHzdPwYaZX4b7lEfeXiLGrgH9xZ+7z1qBFw9VTQj9?=
 =?us-ascii?Q?31ZnsRBmqUpmeubq7GfzSJVfShNgNh+xdgRPXumSl94QAdfFHJTojjjgIKRK?=
 =?us-ascii?Q?D5E42c4rutvJJ2iADknOD7EajpPlC82g+19vFalinbvlEwOxMoT0iIyMbhma?=
 =?us-ascii?Q?J6EgB3cVGz2JzpibLl1SHzpZe3HvQ0lWGcML75mgXnUIrpO+B2d32i0Bysrl?=
 =?us-ascii?Q?YlW/x9pZKexZAfYFqGSquPYojBrP5h67Y9ltZVa7V9+nvAHVT2w0fzsu7PpD?=
 =?us-ascii?Q?gvEMn/zBubdnFkcv77h7BV9Yz5+ccWzqduEErU5MU+7WZKRcaoHj7aL9RwUM?=
 =?us-ascii?Q?mYjgxfEohMLYC6QYbQjfGAMDY12HqxsWtAbhMM4E7aB986TPOlCDVkxR5DXn?=
 =?us-ascii?Q?0YQLxg7yVZpp1JDJJdviYL7wNkv72UY52qr/i3xSPBZNtJudv7g9NpzltpIO?=
 =?us-ascii?Q?lQY3LPF7uyBDH7JIcFAuAgqo2LAvumCkUpdGEA5rptvM7fKTncbmzYlXMJyU?=
 =?us-ascii?Q?Hknv4U2X6l1iuzrqsz6coQiSHmmMn2sj6hAm6uAc5tLl+nteP6NUSIWMb+fk?=
 =?us-ascii?Q?pjm2RYiqV4qixtoTnpnLY+1YqKPid+AW/qSZ3Crt3KfkhTZKGZWYuWtncdwF?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a15c3f-079b-48cf-91de-08dcab0a33d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 11:25:48.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDLVaJ77Ntd3cM3x0E4rwcuho6fSHgKZKQwDIHRkrzI1M9EGgl5zmBwOqTyjzhckModpC6bHGsy7W9KUU7NplJXQJyQo3QRgAU7sEVviQCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Swiatkowski
> Sent: Thursday, June 6, 2024 1:25 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: shayd@nvidia.com; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> horms@kernel.org; Samudrala, Sridhar <sridhar.samudrala@intel.com>;
> Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; netdev@vger.kernel.or=
g;
> jiri@nvidia.com; kalesh-anakkur.purayil@broadcom.com; Kubiak, Michal
> <michal.kubiak@intel.com>; pio.raczynski@gmail.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>;
> Drewek, Wojciech <wojciech.drewek@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v5 14/15] ice: basic support for VLA=
N in
> subfunctions
>=20
> Implement add / delete vlan for subfunction type VSI.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |  1 +
>  .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  | 21 +++++++++++++++++++
> .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  | 13 ++++++++++++
> .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |  4 ++++
>  4 files changed, 39 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
>=20
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 81acb590eac6..3307d551f431 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -34,6 +34,7 @@ ice-y :=3D ice_main.o	\


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



