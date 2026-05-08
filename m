Return-Path: <netdev+bounces-285906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLNFANcE/mm7mAAAu9opvQ
	(envelope-from <netdev+bounces-285906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35F4F8EAA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73A233071365
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967453F65E5;
	Fri,  8 May 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADSpTW6y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990B34F48F
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254582; cv=fail; b=B/zqfG1Xs/dsvsAkfBljsRErpwaZ5GqfA/sfh/grxl5X7C+GyDDR93zoLo5VDJ8IxHGJyYcWlrVDp1xpzgnPRuDLy5hRFzlLXTo4fVC/TYz9+IUsXfQ1nGvSB67Eodx/4lGpwro9aXT/ceZhN9lE/YccRBNuLpJy206nVAeeQMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254582; c=relaxed/simple;
	bh=vaLoT++CEBZi4NsyFMfLxYGHQ3F34qrRu69E95EBW7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p7tKOcRMHUuoZtmqiji3tjMPNqXZZBT95rGZ1WO6G9krl6aTnIy1mYRP1AB2KAeDLvvFy0jHPVFIOgGeO0jl6luMbTuYRyOLa3tolSovGUgWQ90awVBU7Cv3Mv0TdUiaAtyrFSwpk6cwQSKimYjSCKbw4HKtQWiODb9n3ZK0rnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADSpTW6y; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778254581; x=1809790581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vaLoT++CEBZi4NsyFMfLxYGHQ3F34qrRu69E95EBW7s=;
  b=ADSpTW6ya5hZGKGeusmEg2HudbYdrAEex11/kj6/BC6LzbRyBmjJjeDr
   uAqqW7VnP20DyWojRcG2zWzhEmjM1MY5KxlZlkoSM+v4zg0Jpm5htfavh
   0/7uxayyp1/RV0eEbwAe1kH1e+HFzUvGwnfW/IYWrQn3TjSKtDcuJQXkE
   AiQzGLNqt2dZ1UeOgckSeAIgsz/hZVDsL2mNAa/k3gUvilTXKGMTF5IwC
   +kb/jgZhBz572C8RU1IcGs/HGgFnMIZg+vShuyvE/SCqNKtIFf9WMkGuF
   x3JAZ5fD6MOsELTxyxZXnJJfH2D3HRRt5NBDqxWi9gwBLWDM287yMEMIW
   w==;
X-CSE-ConnectionGUID: gUTfza2WSTaPtfjE8ToWCg==
X-CSE-MsgGUID: sFGf575zRZ+G89mo8PsATQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90327015"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90327015"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:36:20 -0700
X-CSE-ConnectionGUID: H71niPz3QvC+KD4GZLdB8w==
X-CSE-MsgGUID: j1lP8h5NTuWMYhMRsuEhLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="232455021"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:36:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 08:36:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 08:36:19 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 08:36:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKsNFb/D10RWlkXF8oEsFXqwFnoyeXJNXDo3QnG3g/zjqj8a4Hr2ZI6W5C+0DYtWub78gTALxUg7wsYqNrPpCgKRk5uH0tm+OOfll2Ge5h5x2ublVYt0DsAILAKJUSxUP9X9sKNiX02iswZo8sBKvc4rbe/lxGN5y6t6Mnn+OVPDQxXZqK0c5zARfvuL8wYtmakrMg0czdP23KjLDeeoutrPNNUyAF/vCVQzRiAjhAizOTOpebLZ/2Go7YpzqqQE0vQ2BSXKD4/SAOik8Bf6mhL6wHd2YjZ+2TCNETKGLClapb7UYygIID9amdwYPX9Rc0t9xc8bdix0PhG9z7K/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLbCyM7tJRMi8bfYeufezYgNUcT9OiOQerfhX7LvgQ8=;
 b=kP6tkIjUkqhlEbInLDjztnkxgsU8PWtBYUKl+3EhZq4pFgBQOXD1yeca8CW6puJnUyEVMp8kKCCbUS8dTNLd0CYLsD6XL5/JER1uNafiPu3Mi8ddh9kZ+wxWH9oKYR6/w9GKbBGFWsJ9T/QdxqFn0LPPWkGlbVLTyYEB3+ePejlKRGIvKGHhXbfuACi13p3DSdfP2Y8uU06yl5dWxRPvpj0z29VMWt3lon58pNHjB6vrMf181W3jLtxq5EFv7YdUKoEKLYi9DP2HMt9Men2A8YqBLoUbt1nIH2EUi2jzqfZQacZ3vE3IlRCJLsMJladxgx67v9kDZQypYOtGp/o7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.19; Fri, 8 May 2026 15:36:12 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 15:36:12 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Ostrowska, Karen"
	<karen.ostrowska@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 7/10] ice: emit user-visible
 info message for non-contiguous ETS TC config
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 7/10] ice: emit user-visible
 info message for non-contiguous ETS TC config
Thread-Index: AQHcyL6ocTFrsaBUBEWZ2u5nlUvJnbYEbzTA
Date: Fri, 8 May 2026 15:36:12 +0000
Message-ID: <LV1PR11MB87901AC014684957DCC80C79903D2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-8-aleksandr.loktionov@intel.com>
In-Reply-To: <20260410074921.1254213-8-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS0PR11MB6544:EE_
x-ms-office365-filtering-correlation-id: 02e8d81d-b1be-4a33-0208-08dead17889c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: KVx+ToazaulR0h/EiGRNkBoqGYIO7mxCnj4Nz4z5fxgv0NC5hjtsj/yvpmyDxFw91igTtkq9NUlr2QwX3h9+H4Xnwg7s0+Zyq/EH+KXVqlpW1Wc2xhVM7mDrQNWUHxB1e2/5pvdZzPy5zShQVBUcoPRUdLNPKKXMkQrVTnqzld5fVXf53mwmvNbmCBR+Xt6WNlJeVnx4RUqnmOasxP5e6KLrqQ5K7ncss4PIyLTgWbIAjnS56SyFFdXo7IbgWl4O8+rWrXkNrwvYzYeuILNnXi/XaH6F8fo7JPIMcD/HAYXiM2CRlAM+OvkqNep20oXleud8hfUab5GMDF6K7ZbBuCF3DnOt7dqtHS+0zuENqPmJlhF2hRyXRD+esnqRjevhX6msbqs/znUF+bqq3nIjnZVE8h2M1/0vKcREMeo3R6uTBvSbYBbgCl2UO8uIbEiiAT3QeeP3elITo4g1XyO7uWr+kxgIC7qJ4TqmMaQwcG7mN9Mujrhl2pEvXeh/OUULkBB4ggnHZi9dREtvorgfxPlFnQP/6iXXzMePX8j64UbDaWfDcz3sKn6LpCrIJ4yNpTJ50MktupCDNUIEyj+V7rX6GiMriMvqKPEjB6qehFyJysyhhUX5F7/lGGVmCFI39k8qxJvHeEFa33zUTvj8K061RXL3YC2/t3ANrJUSBO2HKePe3Sb0PwOn22QIy2mhVyogX6vrXvGXOOymbfCLllMJrK18Z+MTkGZn7SfW5MLAaIicoa+FpeJLsZcIYfZJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BuA8JsvmASGEigM3AjXAdqO/UtC2aR5JXRtkyV7IcSCSO7Dk1feZpCuLqqon?=
 =?us-ascii?Q?+z1oRe05tYVNxjes1Pw5mcXARhwFxkGpw+vJFPymfeTEyn76s7zHctbY19Q9?=
 =?us-ascii?Q?KZRxSu9V9+d2nIyr1aL+oh9f/dlCrl/viigcZJjFP2w6Pwj7wwoRntgV6uHP?=
 =?us-ascii?Q?HKfVBDBvhH5IaT9fn09RI5m+xq2gbsox5hGSgFgWYTP8xrb/CFCw05Y+gZ2A?=
 =?us-ascii?Q?5MLvQFhyHFePSONx0jxZ93lW1/tC6dri2GZI6ATOSi5VZaOI0PCxak815lHG?=
 =?us-ascii?Q?+en/a/vBxl+vYIMnIZSmXl8Lfs+wUGQT4SJkfUyrz2kNYZ5pcBF9onNxmDvB?=
 =?us-ascii?Q?H1TfCYprTnAr+WRlzqtKF057sdUytIsjv9L0F7cdStjUlATD/vXi7cK9Tnvl?=
 =?us-ascii?Q?uOvZBKx99/PkSX0okxUhe8/Ln8LTGADr0eRwM8r8wT3vr/pIGUpnm7uyerLz?=
 =?us-ascii?Q?c4z2cejSEUCfynHZAIsRhSHFxRp9qvE9I1LgwpgvHK3q0vJ8FRHDy6srJztI?=
 =?us-ascii?Q?37O2SWlQNqW1NOJUcZmSwpRRE/alnuFNfQ4/25YRMl+Qs7B5P77MFJ4tZjfM?=
 =?us-ascii?Q?zm7AtLXg8FeFyZ5jio1Hv3ZHv49C00yZeMWskq/YGdRJNxbiAF3WHFecAJjK?=
 =?us-ascii?Q?+0CxiwSNx20WVXeRSC+2JQ8v+QYET5j0RuYbQeWRMMA13z7FiVLdK8D170m5?=
 =?us-ascii?Q?kE4hIXxm5W6pBVAEVNyh5/ThsTDkLNG6NuhNbSTpp4Cx0z2Z0zgQ88bvyOfd?=
 =?us-ascii?Q?3U/68UWbLQ7PCA2BnFSwQRrIQkPyBfAnqegqGfmHo8Q08IG+wbiYtFZSfWgH?=
 =?us-ascii?Q?Yyk7XkPuSX3vZl+l1e3rwEB3AD13PKOtmq2S3EgHWNg7sT8kadfHhiTCvNpd?=
 =?us-ascii?Q?L37JQsZkP0556nx+QuaEFtjOXb1jN9TzLXWnBzfyKsR8jbLmAriKrwXvY0Np?=
 =?us-ascii?Q?ldTTK6QlSCBLKsricEVxrnvjVkJty/AqzuU4p5gSyNOC5BPaf8NdkIU56ofj?=
 =?us-ascii?Q?vPK+eNC/TTVvnzFzNQuqMLVrTdi+LbVBPGFCNkprkmPF1e2J0r9eEFapGtmG?=
 =?us-ascii?Q?QOVG+Q1NnPmh2PyMkKoJAs5pWPdJoU+NzMIgabDVLtn0jtjRx+2Cjrem5CQ/?=
 =?us-ascii?Q?dMr5+HekJOk5r40n0MdEwfi3g8a9c6GJfdbN4Cs0/wYounNT3/E7jsSmp3JH?=
 =?us-ascii?Q?14OdjsHIQfCOxDq7aTMJo2yk3TkaDP7XUdgo9esTfE1yspZz7oU3tB+t3Iyy?=
 =?us-ascii?Q?NL7FOlZ7hucsohwGOTALxF+Mv1RbFbQYgbodgOZF682FGFfd2x83R2FPpIQE?=
 =?us-ascii?Q?ysXwOS2n/83EKsDqXwoEG6cpXGnEvGB5qFU9pB5J+xfV5OwtrXxLAvayWBYP?=
 =?us-ascii?Q?7sLsBF+jexSE6pgEoQBfaiNMhzZr7WXCR/WMyMrbH7iSvhr3q+w2hln+JfKp?=
 =?us-ascii?Q?MuNrtXXGPiYvsaHvkbgVBMYWJHULAQ9WEUEGKwSY1Xs9WPBIcbZqIk5KdeKi?=
 =?us-ascii?Q?Wccq3VKb5VVBbe5O8h3ehcL9IzaKKsIQ4exEH2nQxHPPGQYQJ04ZQ3z/ZMsE?=
 =?us-ascii?Q?kkZhrojRRcipADYxlWMBPlPXz3C1vHanjWHNZJPpxtn6OnWvawW+pqsJiBtJ?=
 =?us-ascii?Q?/V6xHYGJYQ1NldRCsbTnALTWMoVutEIoHlaebANK6GWrUwJyNC09C35Pgji1?=
 =?us-ascii?Q?JE3S37ifvtXE5YPJi2XYrY8TeGrzT6GtZTG5m306yuEfgglCVzragZ9CGeRY?=
 =?us-ascii?Q?iqFuKr2fDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D+yqQc2VNG661ACimLk2bkJa+pV5H8185bQ3kd8cgIWD+kUDyF9nY/1qYC/CXqeraOdZzkJsgbd5WnL3TRx4JRBKEY57dB98Xb/ZkDT8gP4VDRU2V4Os1ZTeLttiFV1KD8xIItpW/9Z6enTj6xuZmXFYlUAt4qhiS4NC2oHgArmMdsQsXB4xogDOG2RspLitbQ6pEQ2V3yJqli4C1K+Cippb9lhiXRUcmB9T3I7x+gNB9XSx/qsh8mLv7aTenZDNVs8ORzJYJvD5vRFZOo+PVAVHv1zKLDNUA4ZruOG70YoVVRzcQK2neb0DWqkzcKppx/4pGjO42zQanKIWszYEtw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e8d81d-b1be-4a33-0208-08dead17889c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 15:36:12.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkvbbGVcU+BnlR2yADLTu7yB9pxPUE4H0AI1q84XOHBvVAPdlgV6s4EeT0tfxUS1nxQuJauZe4y2oeOoArBjDJtnHhZLvWS2bGJeeevJz/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 6C35F4F8EAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285906-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Friday, April 10, 2026 12:49 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Ostrowska, Karen <karen.ostrowska@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 7/10] ice: emit user-visible i=
nfo message for non-contiguous ETS TC config
>=20
> When the remote LLDP peer advertises a non-contiguous TC mapping the driv=
er silently falls back to a default single-TC configuration. This leaves th=
e user without any indication of why their DCB configuration=20
> was not honoured.
>=20
> Print an informational message at the entry of
> ice_dcb_noncontig_cfg() so the user knows ETS with non-contiguous TCs is =
not supported and that the driver has fallen back to defaults.
>=20
> Suggested-by: Karen Ostrowska <karen.ostrowska@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

