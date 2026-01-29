Return-Path: <netdev+bounces-254537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKjkERfbemlE/AEAu9opvQ
	(envelope-from <netdev+bounces-254537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:59:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF5AB8A8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0BFF3007891
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D7E3644BD;
	Thu, 29 Jan 2026 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOVMU9SV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8702745C;
	Thu, 29 Jan 2026 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769659156; cv=fail; b=WZFiLwWML/po9o8/cYmQo93Qc1bdaQhVyWPYm8MWJLMvZPgBUuEckzPCb5fnKb3rbJEwakzuCEidaRCdchU7e+o/df+yDUP18/yFXd8zjxhoSKNkv/ZwbH3LfdpbvRbxTcLE/3zKhw4vWReNhcFPyNedcyLAs4BfnZfSc0Lt7ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769659156; c=relaxed/simple;
	bh=2Uy3Dr0CecBMB6MpTExC1OcHptknWF2QEX1TUZTfejM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PFA9k6CvF3yprfuz9uv5h3gfikFhG99Fwn+cN/smwyYgsjrlL2ZDGcJFfz4eiB/ivP9NZNDul9GYf5++93sDI/h1sMo/X6fqS3KcJ0+78PP3Yw+OipPQ4TI3RGlYQlSTmQZDXVDgjJwf6FBfQA9Q3qNXKPF9HqnlAne7Qy4Qx/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOVMU9SV; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769659155; x=1801195155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Uy3Dr0CecBMB6MpTExC1OcHptknWF2QEX1TUZTfejM=;
  b=OOVMU9SV+So1LQFzpGr6KIYCqya0HMDf93X3ttn1kA7j6wHZQXvweFBw
   W2Nss7/k2Gh8uKSzinl2qcvsgaTsJnmpSd0yqOk+fQ5eMCIdQ1Z29C9rc
   I4k+ZxDUVdsGjYvQi/ekL7OwVGd/hDW3MH/UbWbO+p+R3LPp4jxQoeKqr
   /E7VfSOOHfcZQ9SnWESr4wmwhT4H9OHP1EdCbiQeVr34Ip7yvd9NsC2lK
   PiCNaDOFAotrkvUQwHPxWYWWejPftEa1YcPgtOwLNOXTHBpJTjr+skhbe
   3XUjzLrG4KCZGuGmP4UntdxRoSWHD324wIQxerTjTlMDIi9XAZ67fWXdO
   Q==;
X-CSE-ConnectionGUID: DiyvaDg3R9qLCt6xzTx0Ug==
X-CSE-MsgGUID: XiYutu2vRIun5hQk+l/+sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81615821"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="81615821"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 19:59:14 -0800
X-CSE-ConnectionGUID: WyQbdQ/BTK6AkE2kKyZKPg==
X-CSE-MsgGUID: /pQ6fY+NQ1OsI2CwcTeQoA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 19:59:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 19:59:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 19:59:13 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 19:59:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3G8P+9fn+oUgym+pCJuzfeS0JgjFgL2DLEzLirSrwAolo4Hu+66OJfhTISpUd56wvAb4YND4/hxpcKhMX1an+wqgS1R63q+4IsveYeSRUZ+t9KjeVt3TVE6SzrAXlNrcSDu1387OKhXiso2OAuRj9NyxOImcgWigmAyw/C3i/+Xo9Xn4CsbPrHiwOqdwzE/Je1tmWJxzLMsLB7dsYetzWODVaHNmriPR0FBMcSp8grjJMmC6RSxJcKYUC5E9BBcyBuqyDHjvygpHmE7Tdj3FsuY2h1Za594zA0xioqByoqrYSAxu8/1w2I9o/0t9DhfhROOHrURdxh4uOBkUKLNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Uy3Dr0CecBMB6MpTExC1OcHptknWF2QEX1TUZTfejM=;
 b=SA9MnqL7PzOtlB+fTvvoZbxxUyHIA5dL/yLSqRmLCscMturtnEpl6fgkQdHs2/sqDPXVVxRzdDj5YNcoMPwULQT0xZjiaDYxM49rlLFmKstXHNqJXw4FqTG+Nvlh4v1f0pBoNAOfi+57/9T66xW00kcegOnAzo0gGlpQgHlRGepBcIucNUqZdie+9RXbrWSJHDCl4PCdCw0fSm7nXbdv5PdPkKnHgsKeAZbyxGS+5dCRC10RhYeNvJHCZQ2U5UT2C9JZcO3j8rNTdmmzj8+pX0VxSclXLSmNLedns6jSqEhTH9ARSdBnoOIxI8AfZ0VTgYmy6HUd4CFYgzwavxLU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 03:59:02 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 03:59:02 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Fodor, Zoltan" <zoltan.fodor@intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Grinberg, Vitaly" <vgrinber@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6] ice: add support for
 unmanaged DPLL on E830 NIC
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6] ice: add support for
 unmanaged DPLL on E830 NIC
Thread-Index: AQHcig5UfWk7pTU58kW4ITuog/pNS7Vokk9g
Date: Thu, 29 Jan 2026 03:59:01 +0000
Message-ID: <PH0PR11MB75229EA31240F5EBC09E9429A09EA@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260120130433.23511-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20260120130433.23511-1-arkadiusz.kubalewski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|MW5PR11MB5764:EE_
x-ms-office365-filtering-correlation-id: 05fd65e4-0d4a-4a7b-14ab-08de5eeabd16
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?NlNjZDRBMm9wNlNxa2Y1Z2R5WjJOSVFQeWhIaGJOUWlYMjZVejQvcWtXK0d0?=
 =?utf-8?B?Z2pkMjUzRXB4Z3NUSFZFUXJ1eFBOYmJydEFsYWxwd29iNFdIQ0I3Sml0am9L?=
 =?utf-8?B?NENYZFFITGNHWXR5b3FSdjBuc3FGcEkvamh5Y2FSTDc2bDk0bUNGMzVtaDVE?=
 =?utf-8?B?ZkplVU1OVTk4WVdsb3hnTFVpdXZRSzUwTVlTZ01BQlhteFRYUVZDRUFQWFIx?=
 =?utf-8?B?SkJJZFZ0a0ZZTDlIRG54MjVqYnU2L1BYS1ZCMGJla2pHOE4rWXFwRzh2czh5?=
 =?utf-8?B?K3U2eTFnSi9tMmFId0V4dzJqSE55UGFXS0FyUEFHTjJhckx0MDY3dTloenJo?=
 =?utf-8?B?eXNhQmxQcENUM0MrbVZEY1VHY0xBdUI2MVRsM0NuUHJ0WEdDanlGSk1NSjJ0?=
 =?utf-8?B?M1pBU2xHVjk0cERmUXFrNUFsclJjV0RzVUVsOXVMb3V6MGM5S1ArN3RINVJx?=
 =?utf-8?B?TG04N2pvU3gyUkhHOFlzbTJ3NlRyNFNQaDRqSTE3WmZYT09xVmdOV2txSXJk?=
 =?utf-8?B?YWRTQjI2RU9wdlVtR2pTaWtWUXl6bGZWdXdxcXIwNDZOSHFBeUh1K3oxRndj?=
 =?utf-8?B?NGZJa2p3M3BFS0UzTVFHQk5lLy9KbFNCOFVNekVsdDdHWmxlT0U2QzdPWGts?=
 =?utf-8?B?cEI2VDI4TU9pS2FuV3BqY2EyZWRkVG5kYVpVK015Tk9lL0VGNFd6bEZBYm1L?=
 =?utf-8?B?RUJQYkFGbW4wUk8zV003NTlvTkg1OXB4ZFdPTFE1TkI3YTJ1aTJMREpUT3g1?=
 =?utf-8?B?aCtjL2p3bkRtUGY1SDRlVWlVZzJ4dHcwQWYzRVlnelIvd1QyOVNqaFlWVVg0?=
 =?utf-8?B?UFFxc1Vic2c1L3VGL3VFN1VHaGxKaW1wVFVFbmdaaDRNWE5yMXNMV3gzeVhE?=
 =?utf-8?B?N0xQOUYxRE95YVdiYkNENEhEOEJSWkZFdG1BWTk5VmZCVWtLVGp5UFJrOEZu?=
 =?utf-8?B?dktDK3NmdGxZVk9CYytiYjV3dmR3ajMvdGlnOUtUc1NMNTc0QjBiYmlkK045?=
 =?utf-8?B?OWxST0paT2xhY01yN05WTUY1eE84ZXJVN0dnYStyd1lQSnRDL2pKT0RIRWRX?=
 =?utf-8?B?enNIMG9uUFROOFdtY3E3ZmYwUjBJbWtBbzVZNk1nOTRQQzRlR2NvUTFHcFEw?=
 =?utf-8?B?UnltcnByNERTV2dYZmkyZVN1Zml1SWJqVVkyZGpONUZyajI5TlNITjFtcGFx?=
 =?utf-8?B?L1B2dkQ2NXFDcjB6clQrYkx4T0hRYVdTR1RPcmFhakpUQkxkMWcraC9zVWNW?=
 =?utf-8?B?WnVlSTFRbkNxUk9kWUJ1UGppNzFETXY0N1NpVWxTVHl1YVh6Z29KMHVxYmtw?=
 =?utf-8?B?T1A5azVtRHBpNDg5WmoxZXFaa0RDbzhIcy9YcmFiNFV4QjZiSnUyNTVpOWtz?=
 =?utf-8?B?SjZ4RjZpWFJkdEhhemduR2pQN1ErYjZlVElVOE5HWnM2ZkU4OFh3Smp5anhh?=
 =?utf-8?B?VnladlFGdndDNE5lOE1pUHU0Z3J6Z2h2M0d0TGIvTmYzZHorTjlVK1VXcHpR?=
 =?utf-8?B?NUgvUUlMZStyWklTbFgwb2pGcjlOSXhXWHZmT2tzZjVMaFhNZEJMaUNWSXd0?=
 =?utf-8?B?Wlh0bnNoYjI0QXd4TExscFMrKy9WSGpRUHIzOTRUMEJSOXVuMm5XNWVpT3hu?=
 =?utf-8?B?SGxES1JnVXplaElSNGhhYnJONmRzdXpsZ2FKaERjTXZKMThNa2tJbTdyYmp1?=
 =?utf-8?B?NFMrZ2g1clVueXZ3WWdKRDRWL0UvYUVvTEx3K1JyZkE3TnExcFJFSFI4dnpS?=
 =?utf-8?B?bzVIa0dsenFVYnIzOGQ0TGRBYzlpVE1DNVhMN3o1dGVIUTI2Tm8yVHlWN3Fm?=
 =?utf-8?B?TDJ2L1V2Sm5zeFlJNkFUL09JT2J0QWtydlpvVENkM3BVOGo4L1hIL2g5MWNM?=
 =?utf-8?B?dkt2TDVLVVUwOUhweEhwZzBOSERDc0dzVHk3cXg1ay9paUtPbGJmV2tXcVNw?=
 =?utf-8?B?cGZ6N2lwNlBiZXhOQ2xuQUhGOUJTUk43WTJNVlU3WlluMzA0NWk0OEVFK2xx?=
 =?utf-8?B?Kzlvblg3b1BZMXJVS2h0QnRnZDFsUGhyc1F2QTVBYWRlWVZ0cUMreEd5bmpR?=
 =?utf-8?B?cFJJeFo5ZUZPMmM4aEQzdHBNOWFiRm4xRERtZEJOakdqRndHc2hFMkdRS1Vh?=
 =?utf-8?B?aUhUelY1NDdlM1R2TDZlb3RxcmFWR3FNQVRvMVpnQThjb3hzTGlPQmQrNXE5?=
 =?utf-8?Q?srjhZnnlDweIcAXZQtV4+GY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUFYaE53VlhueHRJNFhjOVpTTDRXN3pZcHhzaUxQbFBhTkVPUlpFMk9uaTlN?=
 =?utf-8?B?TDFvMFdDM2pBeFZKYU1NUG1kd0pSSjZVV3dwK2VlaHliR2NUUVJtaGIwTFE4?=
 =?utf-8?B?WGhpUjJsSkJKSXRScWRhZk5JbW82T1dRU1ljSDJkRCtSVXdad0xHZ0d1TzBF?=
 =?utf-8?B?aXFKaHkrOXFPU01YUHJFQ0VtSndkMy8vdTVTSzZoQXY3YjdyS3RkeUpENEhz?=
 =?utf-8?B?Uy9QakVjd1ZxSU1uT2Nnby8wR3pVQ1luMWE2d1lvR1oyZERvdnRPd0NaVDFB?=
 =?utf-8?B?T3p1WmczVUJPc3VxbEV4MzQwSlhDeitoeXNpdm5QRXQ4ZFdoT1ZDOFUzR0tR?=
 =?utf-8?B?RFB5eUdVOHRSYnZ2clVZU2E3aittaWRKWUxzS01IempuN21DNDFSMEUrTUdh?=
 =?utf-8?B?RTBpMWdCOXRWUWM4cFM2UXFxT2NkelFEVUxLeE05Vm1FdHgzVE9RRWZITkEx?=
 =?utf-8?B?bmx5cmc2NEMrUWtOUXA4RlZoYXYvUWIrS0hxWjFiT0toL3UzWFdHTEFhTE9i?=
 =?utf-8?B?WWkzRCtMTWdMaDJwNGYxOW1vUW5aakZnckltVmhTRmZVMUk2NkZqR2hUOW93?=
 =?utf-8?B?d2owTmJ3a1RKSlA2Lyt5b3o5TnFuM3BEVFN2MWpjS0JmdkY2R0thUWx4ZEpt?=
 =?utf-8?B?djdEYnRkOWtxUXJBUE8wQ2RiRmpFQkR2WkM0ZnpRRFVraEVpQXlFN1ZDY0lJ?=
 =?utf-8?B?bm9Lckd3YkE2Z1BYL0M3T3lYcFdrSjNENlY0QVdITHRrQ3k1L2VPSmxYQmVt?=
 =?utf-8?B?c2VBOHM2TitjMzE4b1o4RjhlZVByNFE1VmhXeVNXamQreThXanE4Qnd3K1Jk?=
 =?utf-8?B?SmNFM0tGcWJVTDYvd05LRTlKY1BaN0NBMDBudlRkbnBKTHhCZ2xGcllYSlZE?=
 =?utf-8?B?TmlFekxJRlFxTlhYUExVajhTek5JUHRPaHZPQU9uV1FkKzloTzY1UFFrMjBp?=
 =?utf-8?B?VmNQM0k5dDVCNDRDZHdlc0xwWW1FZWc2bWlGanV5eGthclZFeFFBKzAvSFVw?=
 =?utf-8?B?ZUp6cS9qcjlJTmNFSTFlTk9iTXNKMkRSUnZtQWlXakRDcmFCNzlXRjFIOFQ5?=
 =?utf-8?B?V0hra2QvenNRQXY0ZEFEUUxJckQ1MzNMZUxabmJvcm1objgzQmtVUXJFa0ZO?=
 =?utf-8?B?VWZPZnhhSTJKeXM3WkdFZWxwUk5kMDRsS3g4U0Jqa1BtdTEwNGQ5RllBby9a?=
 =?utf-8?B?OXh2OS9wbTZrTFVpay95TDM2bFlJMkwrNGY0dGpsWXFPSWpTdStnS0wvTU9j?=
 =?utf-8?B?MU9nSHdnUWxrK1RJbS9rZ2hrVDhtSW43YngrSG8rMUM1YTVJYk5kSzFHdjFW?=
 =?utf-8?B?cFJ4ZHJSdzNscURWYkV0eDRyVTVvRHVMVTBjSHBuUlhJTzFoYm93YVQrdVU5?=
 =?utf-8?B?YkpHMVBMZWRWR21TSGFQdXF6M243aGxaVUY1d2huYmF4UmxQd2M2Vk9NMWJX?=
 =?utf-8?B?RDRETjhuSGI5VlNCZVlzSmhMa0NwWko4a3dhcjVaWFJxMWxMOUdra3BQYjBr?=
 =?utf-8?B?Z0Y0THJzYkFFR3A1Qzh2Rmp0QnRtRnhuZmN2RlhMeDNEK3RHa3Z5dnlxK3Iw?=
 =?utf-8?B?bllqTDhPZUFuU0dBQUEzcDNMeTRqc21RcWowZGtBREdqcDFyME9nem5GcWhu?=
 =?utf-8?B?ZGZtZlI0eFZuaWwzNGY5cXFRY0JURTcrMnQyUFFRZmx1MUdXRVVLR0FJa0FF?=
 =?utf-8?B?SW1FeHE0dzZEdUlFeElCMy90OGc3TllQNGZycEg5eGVkNllIY2s3V3A2dWdV?=
 =?utf-8?B?ZytDdm9JZU5DWFl1bVJ2Q3dLM2Q4c0hjNFVLQ253RE85ejRXTkE3eE5iODRN?=
 =?utf-8?B?U2kxUW12M3U2U0xYOWViR2IxQnk0djJhQkZsRnZjK3I1WUFZditNdFdvYTFP?=
 =?utf-8?B?TlZKb1J2T3ZWdTNuVnFWaWt2Y2J0QVhVbkc2aTczTUhPc1gySVRKMFlzam1U?=
 =?utf-8?B?TWZnSmwzV2FNMHFTLy9WWkM2Ump3SGpZdUNkRzJYdDhuSWhBNlg2UDNGZTBa?=
 =?utf-8?B?cUVTQmxiTTRlZGJsRjdtUkN0ZXhzRE5SZkRhdUNwZ2U4a0wvSjJLemJQU3VO?=
 =?utf-8?B?Wkp2SndPT21wM1BKOGVGVElYYi9lK1U1blVZT1c2ZGloMWhhY01YU3JCUUF5?=
 =?utf-8?B?L2Y2ZHp1QTVMZ2Z1ZlF0eHgrVHZsTzJqYk5DWm15TFFYaDJpT2pKZU9uMksz?=
 =?utf-8?B?ZVZEQWRVMEpYeE9OVC9UZ2VlellVS3o4ZjAxU09mWDBoalJPVWlMcEQ2K2tZ?=
 =?utf-8?B?OTl2bjVsRWJUbmx2MUVjdXBNSVBxZElvdGQxWUVidnZhajVub2JZS0RSckh5?=
 =?utf-8?B?UDRVZDhUWEowZVdCdUh3VVowY1FvRGd6Z0Iwb01EUkZrV21BcWRRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fd65e4-0d4a-4a7b-14ab-08de5eeabd16
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 03:59:02.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngu/wx/DIvos/zmgtwsrPVYbTwXC2DHPnupeI7SMipmsz+l092Fr0hnQIBl9/E+lPoBGRZrrXVvBrV7BDgk/91tHWPC/lKU/e/LVFsikRtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5764
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254537-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,mpg.de:email,osuosl.org:email,PH0PR11MB7522.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunithax.d.mekala@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DFBF5AB8A8
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBBcmthZGl1c3og
S3ViYWxld3NraQ0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIwLCAyMDI2IDU6MDUgQU0NCj4g
VG86IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBwbWVuemVsQG1vbGdl
bi5tcGcuZGU7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEt1YmFsZXdza2ksIEFya2FkaXVzeiA8
YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPjsgTG9rdGlvbm92LCA+IEFsZWtzYW5kciA8
YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9u
eS5sLm5ndXllbkBpbnRlbC5jb20+OyBGb2RvciwgWm9sdGFuIDx6b2x0YW4uZm9kb3JAaW50ZWwu
Y29tPjsgaG9ybXNAa2VybmVsLm9yZzsgS2l0c3plbCwgUHJ6ZW15c2xhdyA+IDxwcnplbXlzbGF3
LmtpdHN6ZWxAaW50ZWwuY29tPjsgR3JpbmJlcmcsIFZpdGFseSA8dmdyaW5iZXJAcmVkaGF0LmNv
bT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXh0IHY2XSBpY2U6
IGFkZCBzdXBwb3J0IGZvciB1bm1hbmFnZWQgRFBMTCBvbiBFODMwIE5JQw0KPg0KPiBIYXJkd2Fy
ZSB2YXJpYW50cyBvZiBFODMwIG1heSBzdXBwb3J0IGFuIHVubWFuYWdlZCBEUExMIHdoZXJlIHRo
ZQ0KPiBjb25maWd1cmF0aW9uIGlzIGhhcmRjb2RlZCB3aXRoaW4gdGhlIGhhcmR3YXJlIGFuZCBm
aXJtd2FyZSwgbWVhbmluZw0KPiB1c2VycyBjYW5ub3QgbW9kaWZ5IHNldHRpbmdzLiBIb3dldmVy
LCB1c2VycyBhcmUgYWJsZSB0byBjaGVjayB0aGUgRFBMTA0KPiBsb2NrIHN0YXR1cyBhbmQgb2J0
YWluIGNvbmZpZ3VyYXRpb24gaW5mb3JtYXRpb24gdGhyb3VnaCB0aGUgTGludXggRFBMTA0KPiBh
bmQgZGV2bGluayBoZWFsdGggc3Vic3lzdGVtLg0KPg0KPiBBdmFpbGFiaWxpdHkgb2YgJ2xvc3Mg
b2YgbG9jaycgaGVhbHRoIHN0YXR1cyBjb2RlIGRldGVybWluZXMgaWYgc3VjaA0KPiBzdXBwb3J0
IGlzIGF2YWlsYWJsZSwgaWYgdHJ1ZSwgcmVnaXN0ZXIgc2luZ2xlIERQTEwgZGV2aWNlIHdpdGgg
MSBpbnB1dA0KPiBhbmQgMSBvdXRwdXQgYW5kIHByb3ZpZGUgaGFyZGNvZGVkL3JlYWQgb25seSBw
cm9wZXJ0aWVzIG9mIGEgcGluIGFuZA0KPiBEUExMIGRldmljZS4gVXNlciBpcyBvbmx5IGFsbG93
ZWQgdG8gY2hlY2sgRFBMTCBkZXZpY2Ugc3RhdHVzIGFuZCByZWNlaXZlDQo+IG5vdGlmaWNhdGlv
bnMgb24gRFBMTCBsb2NrIHN0YXR1cyBjaGFuZ2UuDQo+DQo+IFdoZW4gcHJlc2VudCwgdGhlIERQ
TEwgZGV2aWNlIGxvY2tzIHRvIGFuIGV4dGVybmFsIHNpZ25hbCBwcm92aWRlZA0KPiB0aHJvdWdo
IHRoZSBQQ0llL09DUCBwaW4uIFRoZSBleHBlY3RlZCBpbnB1dCBzaWduYWwgaXMgMVBQUw0KPiAo
MSBQdWxzZSBQZXIgU2Vjb25kKSBlbWJlZGRlZCBvbiBhIDEwTUh6IHJlZmVyZW5jZSBjbG9jay4N
Cj4gVGhlIERQTEwgcHJvZHVjZXMgb3V0cHV0Og0KPiAtIGZvciBNQUMgKE1lZGlhIEFjY2VzcyBD
b250cm9sKSAmIFBIWSAoUGh5c2ljYWwgTGF5ZXIpIGNsb2NrcywNCj4gLSAxUFBTIGZvciBzeW5j
aHJvbml6YXRpb24gb2Ygb25ib2FyZCBQSEMgKFByZWNpc2lvbiBIYXJkd2FyZSBDbG9jaykgdGlt
ZXIuDQo+DQo+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9r
dGlvbm92QGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1v
bGdlbi5tcGcuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEdyemVnb3J6IE5pdGthIDxncnplZ29yei5u
aXRrYUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFya2FkaXVzeiBLdWJhbGV3c2tpIDxh
cmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+DQo+IC0tLQ0KPiB2NjoNCj4gLSBjaGFuZ2Ug
ZHBsbCB0eXBlIEVFQyAtPiBQUFMsIHRoaXMgZHBsbCBzZXJ2ZXMgYm90aCBmdW5jdGlvbmFsaXNp
dGVzIGJ1dCBQUFMNCj4gIGlzIHN1cGVyc2V0IG9mIEVFQyB0eXBlDQo+IC0gdXNlIERQTExfTU9E
RV9NQU5VQUwgaW5zdGVhZCBvZiBBVVRPTUFUSUMsIHdoaWNoIGlzIGNvcnJlY3QgZm9yIHRoZSBp
bnB1dA0KPiAgIHBpbnMgdGhhdCBkb2Vzbid0IGhhdmUgY2FwYWJpbGl0eSB0byBzZXQgdGhlIHBy
aW9yaXR5DQo+IHY1Og0KPiAtIHJlYmFzZWQgKGJhc2VsaW5lIGRvZXMgbm90IGluY2x1ZGUgZGVw
ZW5kZW50IGU4MjVDIHBhdGNoZXMgbm93KQ0KPiAtIGFkZGVkIGhlYWx0aCBzdGF0dXMgbm90aWZp
Y2F0aW9uICh0aHJ1IGRldmxpbmsgYW5kIERQTEwgc3Vic3lzdGVtKQ0KPiB2NDoNCj4gLSBhZGQg
Y29ycmVjdCBzdHJjdXR1cmUgZm9yIHJlYWRpbmcgc3VwcG9ydGVkIGhlYWx0aCBzdGF0dXMgY29k
ZXMgYW5kDQo+ICB1c2UgaXQgdG8gcGFyc2UgdGhlIG91dGNvbWUgb2YgMHhGRjIxIEFRIGNvbW1h
bmQuDQo+IC0tLQ0KPiAgLi4uL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2ludGVsL2ljZS5yc3Qg
ICAgIHwgIDgzICsrKysrDQo+ICAuLi4vbmV0L2V0aGVybmV0L2ludGVsL2ljZS9kZXZsaW5rL2hl
YWx0aC5jICAgfCAgIDQgKw0KPiAgLi4uL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkbWlu
cV9jbWQuaCAgIHwgIDEyICsNCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vf
Y29tbW9uLmMgICB8IDEzNSArKysrKysrKw0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWNlL2ljZV9jb21tb24uaCAgIHwgICA4ICsNCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2ljZS9pY2VfZHBsbC5jICAgICB8IDMxMCArKysrKysrKysrKysrKysrLS0NCj4gIGRyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZHBsbC5oICAgICB8ICAxMSArDQo+ICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYyAgICAgfCAgMTQgKy0NCj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmMgICB8ICA0NiArKysNCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmggICB8ICAgMSArDQo+ICAx
MCBmaWxlcyBjaGFuZ2VkLCA2MDIgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQoNClRl
c3RlZC1ieTogU3VuaXRoYSBNZWthbGEgPHN1bml0aGF4LmQubWVrYWxhQGludGVsLmNvbT4gKEEg
Q29udGluZ2VudCB3b3JrZXIgYXQgSW50ZWwpDQo=

