Return-Path: <netdev+bounces-293186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDGYLifTGWodzQgAu9opvQ
	(envelope-from <netdev+bounces-293186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:55:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0AF606E7C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2C1B3091EDD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E237C902;
	Fri, 29 May 2026 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3KEknps"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684E381AEA
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076886; cv=fail; b=LOkF+IU+Cz3ZYETvNrv4HO+Pd3rna66QAVQVIBbzdjozFxuFMOhIaT2nWQMx3D2DTytl51+GeUrYGOxcUS9cNNyc/qi+HbfXbBcHWLm1SLtF77za5HjEY0m+NImXTO5wNXl+4x915VN1AbGS8/KJQ08Kpt0Xsbm4fJvFJ9gIF/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076886; c=relaxed/simple;
	bh=6LnOC8Kv3kkT9fhPJgpkrnuOqMbr+OLoUFSTz3ZpM5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gttPFteyNAGd3pvYl6zduGOnGWbawiUClsiEJskA7g9upDQMjgiwjEwp62c/o5EXVhrARLFFi8EaXLpu54BkkR4hwFAj+zjMqseYC1qXgg8r5oz+dGRjnXEywkrDZeUpH9k7G+prm5iugv406HDJv5reF14GTIhJWbkeajdE7tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3KEknps; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780076885; x=1811612885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6LnOC8Kv3kkT9fhPJgpkrnuOqMbr+OLoUFSTz3ZpM5w=;
  b=Y3KEknpsUuIuqPt9Dwqnvvo/XYwbAWE4lrUQMBawbLa6iosQLHiK75aa
   H5X3lRKsxIXc6uPqK+Y7VTqPbtiWYra6Z+fwqZ8aF7c5CXC9S6fa2mSjZ
   WNiurIz4Tx+qk93Bl83DcENYHq9iF3tWYui6dRrR1+wjsAY3Xc76JN2R5
   MLdSlBMRPp+2ObZUZNJ3ge8RftRcY+s7pF9V4YM8LkhqEKvLtRsURbAyv
   2Zi87De9Sdi1I3WHq8l8/7DmeOSg7GwBLrikqhlqlUT0e90qI1VepDafL
   sLhLJbg6YaX9BieVd9enKt1T4tTlNJ5eSN9b5AUvJbbugLBGtvrsvTjOx
   g==;
X-CSE-ConnectionGUID: gSNtxDAKQMWBkzrFXQiuIg==
X-CSE-MsgGUID: OhnL+p0ATjm7wEnxtTxhKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="83511249"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="83511249"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:48:04 -0700
X-CSE-ConnectionGUID: YqJHYXuQQWCIoE2lEBalZg==
X-CSE-MsgGUID: 78dB7Xu3TvGjRDa0qTZ8SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="247199451"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:48:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:48:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 10:48:02 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbBLSp5oCcR4p4X+yD9Fk0kd0KP422TP7jZSTCGof8T4LYlKjk52DFOP8/EaD3rmhmF7ZFlNj8+xtnHDo4EznpSeq1gdcOvZhihQKSdLCyxkVR+/1/CxJ/iX5XlRfs3zCmjcWMhCBit7kfyyyy9Qe/816NTueP1iVPCFL5eX/p1467GN+tkO3lxLXBnYxX/LkmxDcWwBv9rkW2yqw9FwBxqG0lCXb2SJ3t0h3waWDaGWxqApi5ltbBmRuesfUDuqseyg2IkrEBsXMv0AJ9ME6Nugv5hG5aCthN98QLqaOu3UkTgvp1vnGGmLpvSuUq3EkJUQKtdx+OOdbdLs609mFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rUtK7O3uwuH9lUqs0VwbOumysyKBpkCvggbQiS/+0A=;
 b=mlwhDupbd+Ug1EmO/Lh5XCziNnWT6yoozz72I9XWcxO1GV/yU6gx89He+eE5nls9okrDaM/jWECQQyQy+iWuvBjz4JbsXzWW6f8AsZXQIJOCOX8LGbdPIj0T5DsyuQEezmb4VSovg22TPlWdLfAPh8r25zPg6iiE9sq6EbkZwShmrqm9zqbLY00AZgPUaucQLvmfHM/BSSrw2tyCJti0UyFEtlFd2/kqpMO65OsXv5/JUFXN50cMX+RK5cuLIPMpXAWrQT6N+mxC9bjA6HJoSWWHvbN4o2Yip8fqgZGwmuJ3EDuTPYx5Fk2GwuzyEaamU0Rdhh1TaAQCjV0dxsCU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SAWPR11MB9760.namprd11.prod.outlook.com (2603:10b6:806:4c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 17:47:54 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 17:47:54 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 09/10] ice: re-introduce
 ice_dealloc_flow_entry() helper
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 09/10] ice: re-introduce
 ice_dealloc_flow_entry() helper
Thread-Index: AQHc6SCANTSAwMqbCEmVbCFZLEnGbrYlVCzw
Date: Fri, 29 May 2026 17:47:53 +0000
Message-ID: <LV1PR11MB87901B9554E1D3870CDAFC1590162@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
 <20260521115000.4637-10-marcin.szycik@linux.intel.com>
In-Reply-To: <20260521115000.4637-10-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SAWPR11MB9760:EE_
x-ms-office365-filtering-correlation-id: f9150b84-4fdd-49bd-a8c9-08debdaa6930
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: uMtycReWG6SNgh65AmnKaBAfnlIBy9G0CkBwP7JV09S+ncV7Ygk7A3Hmtf0WG4CqsfAP1UBYngOI34OfWNOMgOvELR8MSKGMDRcTXTZJSvl6/zXjY0tSP31vWlhsd39VacJYyvQcMVvcFVqxV37hAKWX2KzCHigG7mxrJyK3XoyC2vLknNwKKm6wNw4D89tcG9thcjeP96saOAhShsQBpcedTI9NqqGspVG5nK/6bB1BseRtobmqBd0jWgjfEEFfHVW8NmGFz619nPtWwhUTyu+Iu/5jWV5DUe2e/rBzG4a+2QYU6qNZla5qO3ybvKaHUMc9Vu8SvoIbsnl0XDahoD24Cxy/EUWB5rhngc7jN2MiMIYTkY1CXZLdGdG3CVx94IQBCigChjU9ZMboZ/VQsSeq97ba7BEBXn392ryjjLjsE3u+Khl09OBOspwf+ZQzwz88z3LGVOQWLG1QvbrEh30xTRcJ6jzlJrCadpup6ripka6/L5HHnS7LrkgwzMOhF8Rb4F3JY/FFC8si1Y+AnSk2XNTfSOqH/FClc9iDVOALv+/Q7u/LVZ6ocBlwzy+LvdQAbW9hkOLnbPtOvS58bUn3VwuPYqK/KVz0ZvhSOAoBxAKhX7iaV6XufYyB7NrDlqmPnLWxe3wVw2d3tagdvVf4lwQ+bZeLmXIEeSyWIB2C0NZTQuGfpfAWUT/zoNF9Wc0bUGz2mWIis44xUgn6XQ6mm5TgdJwTHTAao2wVBbZxwrukDccPB6vEUMjIR5JZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tW3KjPb55htiqN9xGSKJC584gVC+pK3X0OstEpxge9sN3ETl9l8eF3OwSBOG?=
 =?us-ascii?Q?NNeMWKDo+mYFj55gs3npk72/XqD4fAIzHEFG4joQ5ihr4GtAYBc9OSERGB8I?=
 =?us-ascii?Q?2PfOIge+w1znIJ1DccKGDMEB6fOefF8KWbE7duDd2F/IYuXh58qfD1MbsBEt?=
 =?us-ascii?Q?I9OOLeFSVZNEjGafGpDaS+zvThtUTA0J6rZQqvBqLdiNpxPs1HlfQcaWp2dG?=
 =?us-ascii?Q?sCWX0zJ/SFac5npPb7EVh5tma1R06YDdgi557UDY27Zaiz9pq1DLonl0zO6g?=
 =?us-ascii?Q?EJaFOPxDw/zZZ6ORmO2h2/mQkpuzX0UqdghxI5ZMSF6x+m9pF81a4mXJbxxN?=
 =?us-ascii?Q?bjYuA+foa6nN1y6gG+jdoQgBcr3jwDt79LxR133fqRwqtCofpTIK9I0Usnwy?=
 =?us-ascii?Q?gvAFkQQs+30qS9cRKlpV8e+15uWuJE5kV4M2Q42Wj0z/BpxXkDNG6oDksuVo?=
 =?us-ascii?Q?AEISsr6ClACB9bc7XmXDNKrBhtrNLrFT2bo8E1tHPlRYMOIzWFPcpORo5jUc?=
 =?us-ascii?Q?EgsrpriMQnN04aNgEw0kIMoL8y2ZYqhOeMuUBvrTu8dgsN/Zzts4ak/nWHX/?=
 =?us-ascii?Q?VO1FmT5fbicyWjSH7ZFtx6llGAtHo5dlNsc4mg6/WuhlM5CkwN4Yqi3V+HGu?=
 =?us-ascii?Q?mausTbjDlNWnTDjpVdPxjwQQ9khPgxzsA0NLcQjgvvHDygWTxsQCKS07/nN3?=
 =?us-ascii?Q?4Dk7dSho2Josaol5ISLe1X4tJMbVRGo+hmyk8ITX1mjRvgnsp8lP40yuUq+y?=
 =?us-ascii?Q?I/KVM53noapNTftZVcQg0YvBZlAr9Uu/2X+ux0DuVbwxYEqGVBNcy+OtprbN?=
 =?us-ascii?Q?+JW+eRO9IlUFbvwalUybGrqjveLf+5jBy5OnKkDwwC1u4gPM4kZkST+NReae?=
 =?us-ascii?Q?ynfsFyIAsxPD+GcTqnWwEu5zBwUK9nNz1249STv6kwg/503Q9wwDtMqOTzVo?=
 =?us-ascii?Q?3ZnRNft8XQ+mlXqSR8YGWFBQy1UyzxkK0eGNefdSkpdrT5NkxN1A2TFnvGqF?=
 =?us-ascii?Q?7MfyQPcdNj372G2k8FubrmNjGsSVr5YIVvc0rDgXyAsjEkR1mYlHPG8aWUb5?=
 =?us-ascii?Q?575brq3n7guj7hxYHZ/Tvhp/rdtSHVjwtBYoNserc7NecqpXCKdvpVNg8/ou?=
 =?us-ascii?Q?yNieKKdP7jnlugji9Wwu2ryc7DEwLZVw6/2WmrHduPjNjVuVjttscMXPVHJS?=
 =?us-ascii?Q?XE1is2M1x0j14e1FuepjX312rD7XJjUuJB/i53tVT/gp0J0IoLJBmnTixar8?=
 =?us-ascii?Q?GgW4zsGdqTWKKxgjolEQwVFGsPvSVjPhDB4f9ywQqTRpadNmLegiaRjMHW92?=
 =?us-ascii?Q?0+PbK24oye/V87+FbwNCM0FR98z39C4vuHFuL78CJhqgPzNOy4rrfF8ooSGJ?=
 =?us-ascii?Q?Yc0GYvbu0nLQeZgNU98huQek93vM6ZEH+EbYMlBM7LpztQjNQDKSQRtU9Fyu?=
 =?us-ascii?Q?wJ2RYeQ2M5lR/PRv0S9PUuiGkcMrLWbToMlz7e0T2w/5/8W8yPs+e2YWXvi/?=
 =?us-ascii?Q?Kbf77Al/OqXyIt5/XiyMndKqzZd9RwvBuRVAW9sxEycPd1n81XYD3MVkFaAp?=
 =?us-ascii?Q?arzkSYhtLE3p2PfPbTWoDRKah8sVEcsaLf3KWfbv21oxWigYatlP1jo7QY5t?=
 =?us-ascii?Q?zVKmA6GEMQcgGF27zhvff+rB+tsSBq452qEiz+7+wKtpjhMgpPuKA/sTvO0u?=
 =?us-ascii?Q?4KtmJ6VZxv3eHYSNnopjmi0I1AuTGZQnTf35BoDdlfYt9xJc5R+XQoENgc3Q?=
 =?us-ascii?Q?c1F4Uugp/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WFgGbwr+HBrWzf7Ska5OrAwgJmPyjFBVRzzGpQxvqRXJJnXoNxVg0S2wAr4xsbHqjioQB1o21EX8BHvEHictPjafc3UhoQYvP+pqOtSMEjM2qdzeU6mollQ7g0ZeiwzTuQGFM+wOIt5OaUW5kPuJEGEu0QiHis4gJe2VVSjTFckJx4gW1UYtfQMGEmB02yuCdDfHXqnejWM0/jUMP6vGX98iMVt6kfBML55z+UbCGh/vezwcNfY7M6WWf3ipk8SSenQK2bYHnhQOpO0OdWzWjrx6c9UImfTjV6qyfSM9Cd+66gfPLxVIAERJkkiFWCBzoEWGdqCaOf06YAfc1YzA5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9150b84-4fdd-49bd-a8c9-08debdaa6930
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 17:47:53.9670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+/eRr7IOrmPs4B9ChQ0BHODbKQnquzpdVbrVx+OHoLEWSuoy9QZIWbpTSjXXOCMIqrvoR9SfQCwSa4Z+FUq7U5vJZmWowKJpBQ2KAPdAKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9760
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293186-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,osuosl.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3C0AF606E7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Thursday, May 21, 2026 4:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Marci=
n Szycik <marcin.szycik@linux.intel.com>; Loktionov,=20
> Aleksandr <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw <przemysla=
w.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 09/10] ice: re-introduce ic=
e_dealloc_flow_entry() helper
>=20
> It was removed in commit ad667d626825 ("ice: remove null checks before
> devm_kfree() calls"). Now it's useful again.
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v3:
> * ice_flow_acl_add_scen_entry_sync(), ice_flow_add_entry(): call
>   ice_flow_acl_free_act_cntr() in unroll
> v2:
> * Add this patch
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c | 61 +++++++++++++++--------
>  1 file changed, 39 insertions(+), 22 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

