Return-Path: <netdev+bounces-271353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBx2EOZRw2mtqAQAu9opvQ
	(envelope-from <netdev+bounces-271353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:09:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4579031F103
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56F5330193AF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4054D27A907;
	Wed, 25 Mar 2026 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f69VS9kW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F617BA2
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408160; cv=fail; b=phN6oit211/uAJjp2I0gHPlH2y1of8JqRKBZCBA8wJJJOZ9P2jgiNT05l/8/wOxsoz2l16vQErdJLXOyGPJf90uQVBNXCqdenc68eRH8inKyG42Bj5Z0dj6g8yOuVfNJbWCQmj9T+ONCBA7uY5MT1ztkMAjqaBH6ME0u4xs4x1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408160; c=relaxed/simple;
	bh=PQv5z9DC3GCd4plAfj5I65ZJY5kmSpZPCEwmRsC6yPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R2sbEP6FAnCqIR79Xg4EaCqh+xZ2PVRGzxDrC4r1iXebgaLsMiZC0DmfYAG9nI1VHZNjL5NuQufZz2ulgyxKZmY+Iy6A0b7gtGH0pJPJjplk0qCl9i/k+6QE2COynvfkK/K6zfLCUimqOqXtwwVsrS6wzmbFqkPtsXXjc7bPAy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f69VS9kW; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774408157; x=1805944157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PQv5z9DC3GCd4plAfj5I65ZJY5kmSpZPCEwmRsC6yPg=;
  b=f69VS9kWV4vIX5PZ8AUHlWxgMqxNsCq/1XjcMSxQ5LPBlwOW7y0Ov2AP
   2BztqsNYLr2t5FXQ09/UjNtWbshv0YHE7f0ZO8RYSORwCBTxZjebrBsy4
   cUOKF0reBG5d1JKsXh8eh3KSzzzE30eUGSguZS5dlyxz723hhVfBjFHFI
   6OGM2VT3Ugvzg6MXZs01FdZ4Pi0JdyE9T9fHi3y5nd62u5UCC0ziP7IQJ
   n84NLcFDPDf6sF/80+qOA9VpYH8SjHicwTsgSNTXbUkPIAUNMFYYZkRsN
   gXMDMlc+2Q8QJaq11X8NFvJZj7bzNAZ7OiRk9P+DlsmpksdQUyjMyd8Oq
   Q==;
X-CSE-ConnectionGUID: +q0S2X7wS22HeHGMU8x3pQ==
X-CSE-MsgGUID: 674edGmoQ/KBpb5/ftO9TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75325259"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75325259"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 20:09:17 -0700
X-CSE-ConnectionGUID: 15P/KME1QAmzt38nOpv1rQ==
X-CSE-MsgGUID: 38qRSd3hQsqe+P9PH/ScqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="262474055"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 20:09:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 20:09:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 20:09:16 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 20:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJMZVrmsc0J/evcUGnFs0WHsAKjVQhFuJXTAkGZ2kAs+HLDEoQFMWAGfQdobg+IF++GIz1hv2wM2FBnY8Ixp5tBEUPgJA6f35J3mGzfzkl11W3YoF1rF4iHEJKsY499wBnCRRhZKANldIxTpmn1sy3ZAD+U2h5fr1DFGZ8E+6oTBqD82rX8/EzCJPtvofAC/2yKORzvmB9DdRvvegmwUjYfZRTSU+nRsfzZZNiz8ZejROk6QUay+U50L56VJQkYacr/XFUp/OF75KuYx52z+d6JJsuPWSyyd535hJtaQJfLMYUqoYt/qHTCM7RInPPdDR7F4aVYUHZYZlVqqCi2QpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQv5z9DC3GCd4plAfj5I65ZJY5kmSpZPCEwmRsC6yPg=;
 b=MT8nI0MJkJ4+H9RauMeb+7SzswXcJgbK+KNXN0Bql+C69Qs9RDd6PG5AJKuTAH1+//MU2KP/LBW4MvtcHxbg3PW5SAOXBac7xXsdLdhBhby7akm7mgiiiiSM0wkf3svTcswxwkvS5xQ+H04TZQuxAPrLEqlJbScn6otodsYeny9SYpUiUsqW/7Te13nL8a+QBbXuvWrXjsxFjUroInbf0jNmmZWgeBslNQ1Xqjkt/hguPc0fLYGKF50P69QV9Vbt0e8YV+J5VKdcAQjPRDtwcK1RCEffHL3MN+IAefsRgtT1K9IdqhJMwCv7yfW/3kVa9nPSOITO4NytOucfhV9fGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 03:09:08 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 03:09:07 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix 'adjust' timer
 programming for E830 devices
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix 'adjust' timer
 programming for E830 devices
Thread-Index: AQHccANRKpIegMH340SdYfMe8nk2kLW92/xw
Date: Wed, 25 Mar 2026 03:09:07 +0000
Message-ID: <IA1PR11MB6241FF33741DEDB72E7CD7BE8B49A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20251218094428.1762860-1-grzegorz.nitka@intel.com>
In-Reply-To: <20251218094428.1762860-1-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH7PR11MB7549:EE_
x-ms-office365-filtering-correlation-id: d7c1f2c5-3814-4f8a-ecad-08de8a1be114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|7053199007|56012099003;
x-microsoft-antispam-message-info: xAYRo83wu4KbuLvaX5YvBJ8DY03LnAyzSN/5+VggzVEdzeyUS1ajtV0v1rFcYKDJBl4IzzkoZImgVvDfB79fn6cKwOebKutUt+iSRt7+1Vyvep6LuC+KSp+QikoQqCX5jYHR8cnFItUN6BWycy6bI1sSeqDPFlK5owgCwYQERdY2hsSx4wAlVK0Zy1DIJLomW+qF38l1uJqWjEiaf6J0Bupt7aHKb4hjFNuUe20jmktx83+F7Ts+CQy97BoukhEVO+H6TgxT64Fov9yOYBhCmIVBATTuVKIBPTXLT2XG1kF/H4ufi4hz7O5udo4Rtr8gHCupoi/wlI/27yv8cC96/cxZ/ovIhCEHdzzUugP5LbSLxvfm3+vCgMz37fD2sbH5QQDSvKGUI+AhTApem2OSOu8Q6U95BkFb3GoMPh9E59N4HnPTcImXvRm9R3pRfmR3FrezJ+1c2KiVbXb/6VlQNGOey0kfWMU4qJ3FifxIN4qaZs3oXO4GWoYXaTg1K6RtgTXx4c/ZbTmVCweb7wLz1B2xv+ZThMibZQoAkOmTdrChFJVvYkUTmPJazUnC608dJA0CaFcmJ137aVI/vR5LG/vYnwrJokyeGbUgQcp470bk0WJpfHUaqNAqBXTENu7ysDwRvdTyRHMiI01bqljrXkY2/EG3SnalCVAcVxs8kc70d7gWZFnJPe7Fls4EJeqQdNc8E1JQxq09KpKj26GLPGtm1P0yShVusuZ0/rG8R/8f7M0iG2/CBu+lSvpfBPaB8Ea0SFS/7m5jflM1DBAbgGrK+JY2L9Eg3zrW0u11j6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0RtOUhYQTRtcXQ1UjdMZk1pb3VrbHN2V0M5MWs0WDdvWXdIclAwWEpJdFZH?=
 =?utf-8?B?R3lsRVQvOUJzUTh0cEtzVS9XSTdhVlZMRXZ5d0dsWUhGaTZnRzNyV0lVaUp1?=
 =?utf-8?B?MWF0a25uK2I2Z2dTTy9DZVJhWUhTL3BWZ05XdllGK1FXYTNiR0RMMktMU3VK?=
 =?utf-8?B?a1dKWkxVOFdyK1lZK29BMk9KYU5QeitoSzI5Wjdid1Z6WjZOMU5FMVR1ZlEr?=
 =?utf-8?B?amdtc244ejZPM0lLUTJsVW9xcUNPL3hSeTRnVkY3ekhqODlrWGY0SWVuV2ZK?=
 =?utf-8?B?eTE3djM3UkdCQ3dlRlFBampXKzZ6YW9GTFMvZ3F2d1BzcDdBd2RGeURaTmVj?=
 =?utf-8?B?ZzhTQW9MK29obnA4ZkxDdVQveEMyWkhzL3F5Q1FIdzkrUm9KUVFaVWNWWWMx?=
 =?utf-8?B?ekswUzZKNkpqbFRvZzBJSm8xOUFNMmpqUU5idS9HSWF1OGxtdkwrSUpNOFVx?=
 =?utf-8?B?SjlCbktRcDNPdjE5TTZ4SzI5clVXVnhtZ2RwR2pES2FBdHRvRFVXOHlUV1pp?=
 =?utf-8?B?aGhWdm9yTnNmZDN6cHNZOEYyM1Y1T1hPdTA1dXFWTmkzaHI4Z2lrOTl6eURZ?=
 =?utf-8?B?NVJINGNDS1M4RlVhRXdwSE5ieDMveFZUdGt5Z2syMEJpVURJWSt5dXF4UnB5?=
 =?utf-8?B?TUE5TzV2ZG5wK2FONnM5ZFJvNTJTbGhBa2xjRFdCN1MxOTVKVS82dEwwNlRF?=
 =?utf-8?B?MENPNGRKMUEzd0ZkTi81MGdiYzNxVURySWpLZmE0cnQ4TzRGNXFzSVhEL3NK?=
 =?utf-8?B?blZTbi80MUFZNzJRaTBMSnVYaDJML3NMczBXMVdMU1JaWDU5Qnp0SFl6VmtZ?=
 =?utf-8?B?dC9meDJnWDJKdGs0Rmo1Zks2RGdpTjVtZnhNeDNzRHNFMkVpWG5zOHRXTEVS?=
 =?utf-8?B?eHBhNzhyTGhtcWozd0RiTTh5UlFlM21yNWR4WERmUzMwRDl5Ync5YVdBWEw5?=
 =?utf-8?B?bFYwdXh2OER1cDFlOTBROVlpOU53cnFLZWc1RzZkTSszU2ViSFZXcjJQZG5l?=
 =?utf-8?B?bXBEdWQyK2tLN0drVGw1ckZtK0hxcWNzdVEvdDhPSllWMW50MGx5ZWRxQ1ky?=
 =?utf-8?B?WHhVL2MxeERWeG1PeU9vb0RZNmp1VWF3YW9GL2dtdGtGVDdaL1ROelQ5YW1B?=
 =?utf-8?B?bW56Z2pnQnpGZFVSd2dUTFBvSEVaOXE0L3Q1TTRiakt5Q2ZsTUVhOUVTY05V?=
 =?utf-8?B?aXh5LzF5aE9wZlZ3SHgzd0hyaGRFT1Nud3dNNG00ckhsakZvL1RDNzRidkhO?=
 =?utf-8?B?VHBlS3pBb1JWelo3T2dJOWdSaXd2djd3T1Z3SElHUHZjQUp0R2tFT2tuR3Nk?=
 =?utf-8?B?Q0V6cTVCQ0hxYUV0OXZULzFwd05pQXYrbmd5clZBdUZqUWFGdXk4bUVHUEN5?=
 =?utf-8?B?WUd3SmNyUVNtTUhETzNRVUYzZ3hmYUxsQjVrME5mQzkzbkxObU9PSlp0NVc0?=
 =?utf-8?B?ZngzM29YZTRCaDNJTFJXNTJsWXdmTHgzbXJGT2pwNjgvRzJmRTVOalhQTDZ2?=
 =?utf-8?B?OVVsaE9lcDJtVDgyNEs2aVhpZzBCMDlUY1pvK0R6NWQ4RW1ZdFltMk9nWTNj?=
 =?utf-8?B?RmtMRHFNZGljNDlORGhCNjFMNXdrSHFWTnQ2S09wcExDYjBjbUxKc0ZVQ0Nm?=
 =?utf-8?B?VS96Z0JOMjRqZjdsNEV6YWtaQnlUWHROMXl4T1VxZmlVeFdQMmI4WmhzVjBt?=
 =?utf-8?B?bU9yYzl2STVRVUdYbVFMVU1rY1JCaDZHQUprZXFOYUp4YmllVWVoVFFxNHhk?=
 =?utf-8?B?dmpJRnFIVDRZaFpxQnFWSUNpN2RiQVdaa2JxQ3k3cDFrUlZMVjBDUUlUZGQ3?=
 =?utf-8?B?SkZqdkZ5ck05WFl1N3pzTk43QUxGRXhBNHRpQ3g3dnlUVTE3c3haQmNRTFdz?=
 =?utf-8?B?RVpyS1kwSzAzSWZKYTF1Uk83Z2NmV2xGQWNWR0RrdUtJczU1QmlzZkJWdmI3?=
 =?utf-8?B?eFU0WVV2anJ6TUIxNUx6RStZb0hBT3BkeTBQRXZrMllSYzNuSVgxdCttY21t?=
 =?utf-8?B?cmVxUHdpMVpqZDV2cWoyYlZVdThFVmd5ZHl4Z1hjMW40TzJwZHJHUyt0ejA4?=
 =?utf-8?B?NGQ0a3dCcFlhTllGK0dyb0Uwck92cVlSMkNSV1lKcWRPUTdjMWppdUtaSmQx?=
 =?utf-8?B?ai96WGlGajh6cmdITUhDRjRjdlBhb3JWV0tCK1AyOWVEQkRPT0RZQUY5Y0Q3?=
 =?utf-8?B?V1ZzN2Q3OHNXdjROem9uRmdJak5Zek9ua0I2TlhrbUdCUlNVekpkVmdzTmFv?=
 =?utf-8?B?d0VlMEI0SGlvVWFuQzBObnJaK1IydXlzOTJ1VG1TMytRYTJyQTVBVHZvcGtL?=
 =?utf-8?Q?de4BSQukkmt6NJXK1k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HWYUo6yZYLQp1wblUiM4jgqZ+VTGuUQmBeVP7aQKCo689t9YjP0+8eP49MJBXDRQs2GpvoO7kMzNIhVAjBVFOVvUUwgzPG272vjQqwEMslxvgYzUNAI7JkJdApxM3Feb9jQpX/8BWamaORUEGmFuG+DAt3afJUpqveZitvdBMMJEqRonfGp9ojs13bnE086vrmaGTJLQBnZxFLem5qSrKNDYSDYabZSUBE20vKn3zFfaOsolESYfkyeNvlItWtui7YTBTHKP/wuUwHPrAiWMGeql87RSeagY5Ba/6Xzth58OcWlCAVyYigyquEmmRwhqL5PCbyBW9sRisil8791jCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c1f2c5-3814-4f8a-ecad-08de8a1be114
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 03:09:07.7717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgnOTlteLDqDfOZFnedYRpYV0AtUBXG6m72X4viEhcm15NatJYC7+ZxXDFg0RoP+mxjwtb64vn5l3uJGZrAX0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271353-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4579031F103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBHcnplZ29yeiBO
aXRrYQ0KPiBTZW50OiAxOCBEZWNlbWJlciAyMDI1IDE1OjE0DQo+IFRvOiBpbnRlbC13aXJlZC1s
YW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5k
ci5sb2t0aW9ub3ZAaW50ZWwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTmd1eWVuLCBB
bnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xh
dyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVk
LWxhbl0gW1BBVENIIGl3bC1uZXRdIGljZTogZml4ICdhZGp1c3QnIHRpbWVyIHByb2dyYW1taW5n
IGZvciBFODMwIGRldmljZXMNCj4NCj4gRml4IGluY29ycmVjdCAnYWRqdXN0IHRoZSB0aW1lcicg
cHJvZ3JhbW1pbmcgc2VxdWVuY2UgZm9yIEU4MzAgZGV2aWNlcyBzZXJpZXMuIE9ubHkgc2hhZG93
IHJlZ2lzdGVycyBHTFRTWU5fU0hBREogd2VyZSBwcm9ncmFtbWVkIGluIHRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uLiBBY2NvcmRpbmcgdG8gdGhlIHNwZWNpZmljYXRpb24gWzFdLCB3cml0ZSB0
byBjb21tYW5kIEdMVFNZTl9DTUQgcmVnaXN0ZXIgaXMgYWxzbyByZXF1aXJlZCB3aXRoIENNRCBm
aWVsZCBzZXQgdG8gIkFkanVzdCB0aGUgVGltZSIgdmFsdWUsIGZvciB0aGUgdGltZXIgYWRqdXN0
bWVudCB0byB0YWtlIHRoZSBlZmZlY3QuDQo+DQo+IFRoZSBmbG93IHdhcyBicm9rZW4gZm9yIHRo
ZSBhZGp1c3RtZW50IGxlc3MgdGhhbiBTMzJfTUFYL01JTiByYW5nZSAoYXJvdW5kICsvLSAyIHNl
Y29uZHMpLiBGb3IgYmlnZ2VyIGFkanVzdG1lbnQsIG5vbi1hdG9taWMgcHJvZ3JhbW1pbmcgZmxv
dyBpcyB1c2VkLCBpbnZvbHZpbmcgc2V0IHRpbWVyIHByb2dyYW1taW5nLiBOb24tYXRvbWljIGZs
b3cgaXMgaW1wbGVtZW50ZWQgY29ycmVjdGx5Lg0KPg0KPiBUZXN0aW5nIGhpbnRzOg0KPiBSdW4g
Y29tbWFuZDoNCj4JcGhjX2N0bCAvZGV2L3B0cFggZ2V0IGFkaiAyIGdldA0KPiBFeHBlY3RlZCBy
ZXN1bHQ6DQo+CVJldHVybmVkIHRpbXN0YW1wcyBkaWZmZXIgYXQgbGVhc3QgYnkgMiBzZWNvbmRz
DQo+DQo+IFsxXSBJbnRlbMKuIEV0aGVybmV0IENvbnRyb2xsZXIgRTgzMCBEYXRhc2hlZXQgcmV2
IDEuMywgY2hhcHRlciA5LjcuNS40IGh0dHBzOi8vY2RyZHYyLmludGVsLmNvbS92MS9kbC9nZXRD
b250ZW50Lzc4NzM1Mz9leHBsaWNpdFZlcnNpb249dHJ1ZQ0KPg0KPiBGaXhlczogZjAwMzA3NTIy
Nzg2ICgiaWNlOiBJbXBsZW1lbnQgUFRQIHN1cHBvcnQgZm9yIEU4MzAgZGV2aWNlcyIpDQo+IFJl
dmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVs
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogR3J6ZWdvcnogTml0a2EgPGdyemVnb3J6Lm5pdGthQGlu
dGVsLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRw
X2h3LmMgfCA2ICsrKy0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPg0KDQpUZXN0ZWQtYnk6IFJpbml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5j
b20+IChBIENvbnRpbmdlbnQgd29ya2VyIGF0IEludGVsKQ0K

