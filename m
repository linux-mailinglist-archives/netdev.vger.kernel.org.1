Return-Path: <netdev+bounces-302560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uAPzEMhKQmq84AkAu9opvQ
	(envelope-from <netdev+bounces-302560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:36:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73C6D8FA9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:36:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=U3CfT4TM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302560-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302560-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F937304649D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039463BB125;
	Mon, 29 Jun 2026 10:34:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300033B961;
	Mon, 29 Jun 2026 10:34:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782729286; cv=fail; b=sYTYF6TuNTMIQYWPhRnaSZlqh278x373pZTYw6l5p00PDyU7GakEpAfEzfEWMVyERN5OnAA8JKFteI4pcpuuXVfLHlYdUvXRWDf6TCBuK0zVMNkoSKcMuLWJOPtzp0r3HUPkGIGMtPI2ZJOX9eUPYhzqDFxzT49TfKQGEbe7uNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782729286; c=relaxed/simple;
	bh=1hUKJPZ3wrt/2WHZxwQbSJFhKREr64MeXGKiOmiTz14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TQediiS7TxGNBl/JS4m5Pe0zRHGIa2gvn0Sbe202o9OWksKSAAz6oj2ymVKdQg1eXLJcuQERAY4vCJPJezSwj4BNF6wBMAmZRHCWsi+gzrMJ/vPHrly/95vMM4b2jWUQyJfv7LaSgx9KJM82/ZLYa6tzsycGL7vNBlK7ycb+eho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3CfT4TM; arc=fail smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782729284; x=1814265284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1hUKJPZ3wrt/2WHZxwQbSJFhKREr64MeXGKiOmiTz14=;
  b=U3CfT4TMJYGRM2jyL4FKWa1qZHxEywGPw9KP17vmUMF0azKSGauswcU0
   KACYkN9TM8gyCwCvQY2vyBaBNWXARD6UzW7fWm3WyfbFb1Y20QAMB84Z/
   9G3HkK9a0XA/kiwBUCsRXLVg1jfAAPImMzFkwj8d1ePEq6OjIlIDnfQa/
   /xzGZzLd4Uihw/2YqPks1sOa86SUDTzs2oFr97xjZ6s07wh6aCsZFJVId
   cEbLX/LM3L1w6V1pe0i4+qpWzmYjCVlAaE/CzxXQ4DmVEQS7ylaClK3Jw
   fm4cTqYaHUv0Y4Zn8U+3wWzYEibpy9Mw6w0Dn8myybdz3WiIAVdLHzAGZ
   g==;
X-CSE-ConnectionGUID: i5ZewX3aRB26BTa6/0oV7w==
X-CSE-MsgGUID: PkER9TJcT8KKHFX1JfbqKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="82408722"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="82408722"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 03:34:43 -0700
X-CSE-ConnectionGUID: m6RcUW2ASp+iHr9zDT+FXA==
X-CSE-MsgGUID: CSg4nbW5TguL5qrRtzNCjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="256329668"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 03:34:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 03:34:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 03:34:43 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 03:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqYoX7uvVm2zj6tlrbp71fi6YypykkNdC9ht2Os2cqowmOsJS3KFPnjcx9hGLsry81bbUqNGIpjaXZxCEJZr+Im0YYQXm1mNGiXUl3d4ASPUY8n0eSr84x5sBVlFoI3GxQ09krUlZkv6qqj7WZNSyKyi/TmbaqzrKx8VRf2P61l7pULKiEZuoH4bT/Y5isKMJ4EXhuYcYAzzOXrSjuuflaTDlkcxboG250XSYoNd63fRUHlUbXlcuTq+eLA+27QVxAXGOXBOQa6zGtW9Uv3zYORHO8ScRaTxwgOmgH/t9HUjYmmAGELcxjZz63Zvbpz/KoZhY9pd8FvVra2qxWsJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hUKJPZ3wrt/2WHZxwQbSJFhKREr64MeXGKiOmiTz14=;
 b=eFzOxyMdlmW+I135Ifr6ji9p3W+nzRU9nAyHZKJkxR2kcUhoIHTDc490DGRgang2N2i/O0OIuJzrR9pL6VPzzbun17Lx+j+BalwmGYkWIfmUEFPIFyzViZH1XTHTVIErspANWF1+potPY24I5qMcexxpnYEDKwR5tlGiXNoDOdbkuSXnjQMoBwaARyyPQTLShiJjjE60ZTrqU5oeuw/YXBjMUuPUWSLTtukLI8t+D8vHspEBbzRqewRYjJl0lT3zWr1aLPmOLY02EnJiqBr1qN4SULLLOUBwi/ix6bxsiiU4s37YYhGfLdpFDvgE51gGd8TbI4ElPvdmooExBeFAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 DS4PPF990BCE628.namprd11.prod.outlook.com (2603:10b6:f:fc02::3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:34:41 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:34:39 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: Clement Lecigne <clecigne@google.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"horms@kernel.org" <horms@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: RE: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
Thread-Topic: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
Thread-Index: AQHdB5g//BG4FJZxUkm9iTE2eLsKA7ZVVQ7Q
Date: Mon, 29 Jun 2026 10:34:39 +0000
Message-ID: <DM4SPRMB00455DAA85BD5AEE9784C6EB82E82@DM4SPRMB0045.namprd11.prod.outlook.com>
References: <20260629072300.1664622-1-clecigne@google.com>
In-Reply-To: <20260629072300.1664622-1-clecigne@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4SPRMB0045:EE_|DS4PPF990BCE628:EE_
x-ms-office365-filtering-correlation-id: ccc76841-4ad4-4bf9-20b6-08ded5ca064b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|6133799003|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: vfkfwDGhL193crkYUCEHD0nT1bHkg1zwSx1e3+F71M+91a3lYmSLJp9VXyA/B/jAPac8MauPUy3APc6eakcCFG1gM82Xd0xg8PUvhQzXee0oWOK68xk5gr28Ye3zeraVbg2NqKU3RkoWpb3wQqhzOPUGsFh2B+/6nN3p9hFxRkQ95fBZLMiGJ6HiBR31YIzELnDn1C4DYMFDxTkuxC0MXkH3apExLQJdOcsb/XjLJv+s6/Lk/vZvkDNpZk6KDS11eo26YuEt3dSBCjgr684kzIF4HR7O/Tkda8nwnFBBo0GXbWflexxZhVo0pm2bcuHOLKhppaBkebRHIHz0E8jQaomL8qLYgk99Uz8wIVKnZrTeXDULPUO8NSloDhXG4MLebpVu3cZ6a1yivBXid9LMIcZRxspxcYNU/r4MiCNzCA5cJQ7N7clhsvq9jqwPOzh133XAcBWfiRb6ykZy7xAeWrJRTgAkTi/Mh73iijfs85jlAL4mq01aU3o02atf3HLXDoydzvtXMh3RniSahV2neSPHwfG+t6rQZRcpLinmSMk+TCpxmrPID/s8dpVyXX+XOF6n3SeIEdWeI06CX9VVEHY4mx5iuP6lZzBrlmcSA1Mk0IGXMd7oYjLB9QPAsDQtu1gp5yVZn7QU+j+n/Ifz0PooQoV8lGEoFzzM3Nv4xLUnoa9+gzQzKW1cLgnCwwbffSRO7y5U3Y/CcTQf91h3HMKx0d4SgpXABZaoO8lHQuA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDh4WDVCUXU1OVoxWXVENXc5VXMwVlorR3AzZXV6TlJ5U0hEem5MSVdicTVP?=
 =?utf-8?B?c051U3BJMlBSZUd5b24rQlBXT2xVRTdLenRKa0hSYkw0ODlXNStzdHJiNnBB?=
 =?utf-8?B?Yy9JNEFJOHNQNU1XaWpwR29QTXhYYWEyV0VlRmFSVnVBSG1MS1AwSGJLZFM1?=
 =?utf-8?B?cUR3bmpFZWt0US9rVEJGeHFJYTlJd3grK1cyVXVIVEFTeXVGeXN5enJiTW5X?=
 =?utf-8?B?L3NFRml5ZkxwaWkxVlFlL09aa3BZRDhxNWM0Vi9oVGxqaVIrVkJBQnNmTFZF?=
 =?utf-8?B?QVZ6Y0pzdnBPaHJ1cldmRGZHZXpHMEVpdXNvOW1uQWVPdkJhM091Ty9QbnRT?=
 =?utf-8?B?cGhnVXdSNkNVWXBwU3NmemZiQnM0MW9WTUZiRHhjSnlCb1E1czFvdmdkN2Qw?=
 =?utf-8?B?TG5rUG9YUG9nOSs0Mk1EZjU1YitIT2xlcUFBZ2tDekxLWERsZEs0d2k0OGNP?=
 =?utf-8?B?cytNUGtMd3FNWTVJN3V6TVlhdnBOdlNtNnllVWtBem9LdjlzYS8zSEFtN21D?=
 =?utf-8?B?Z28zUWp1bUtxa0Z6TVppY1ZWeittaHJVRjNxMUhmWE9NbUdqYllxcncrTHBO?=
 =?utf-8?B?R0hJUWZhU1RxT2J6ZVRXZGFhYzBSM0ZVdGd4ZzBvMWxEQmFWQUFCWmxsUVdC?=
 =?utf-8?B?RGJFQWR0WFpVaUFJYTh6cFcyUFljVDVnYkNucENmVlpmTlRFK1o0SGhBZzRH?=
 =?utf-8?B?Yzc1eTRjbk1KQjdkb0tFaHQwMkpqZGk4UXp3NmRQbG51ZCt6UTVWbVA5OTh0?=
 =?utf-8?B?REhZSHpFL2Q1L25hSzM2eXJ5QVRhdEtDemRQcHBFQVBUaUZ0a05Pd3E4UVd2?=
 =?utf-8?B?SlVMTmNkekY5MHFzTlk3bHRobloremwxamorVzlhUXFxQndaczVPRHRwOWhO?=
 =?utf-8?B?ejFJMHUxOWFiVktQRjJEWWUyYXdUaGpTNVVyaXB1Q3dGWUZLbGVmZUdya28v?=
 =?utf-8?B?N2RQQ1ZKM1REQTY3T2ljTGk2c2dXaXNUaGlNbVhvWUNtTzNGcGx2enZpWUxH?=
 =?utf-8?B?TytvMVlQV3BzV0J4UXArdWZaMmZ6eWVyU3cvSUFPUWo3L0FhVU9BTEIraDZ4?=
 =?utf-8?B?ZXpXWDB5MmxLejE4Wkw5OXhJWENUQkQ1cnRDMCtWbkkvaG1BcWVSWXJxY2NZ?=
 =?utf-8?B?NTFHQUVXVkFEUStjakdERmN1d0Z6RCtyTnBLQjhhZlFFa2Y1Z3M0U3BNaWhZ?=
 =?utf-8?B?YTMzMGNoSHAyNjZ4T1JNU2JseDVITnBjSFQ2UHlDb1BHa05zSDNpbFJXMlVu?=
 =?utf-8?B?dndjSENSYnJ5SGZLSXRmdWJGcGpCemI1bmJnNVdBWitoMGJUa2NtUDZDcGUx?=
 =?utf-8?B?RmtQRjlHRXBrTXVwYzAxbVhJS2FrMzQzTDZORDk5UlVLUHFqYW5HcVQ5cGd1?=
 =?utf-8?B?WmdEb3YxOTFwSGRKQXRITHpESFpVcVJzYjNLL25paFdrcFdlaytVS1VRdmYr?=
 =?utf-8?B?djdGRWpOZWVmcHg4endBb1JQVFRiWHFJd2tLaVhzbzdJRENrZllHak1pN29v?=
 =?utf-8?B?ZWswSXZHemRDL1dmVkRtOHExM1NSZTlWQ0p5TzhEZDZuY1FOaUVFbWJMQldj?=
 =?utf-8?B?TXFBSGJiV1RDTTVaNThTajFsMUpCM3VmN0c4V0NjdlQvVWI3WlYwdUwwQ2lS?=
 =?utf-8?B?cDA5VjJ3R1ZIU3YvWDZnL3lqMy90a0xDcUhZVHVSZ3JpeUQ5U1ZkUnVhVUpz?=
 =?utf-8?B?bURvTlZLWnlkVjNMWHRRcEZKSEpkYWZQellUY0ZCSGUveVg1eFlULzJwcHVl?=
 =?utf-8?B?L0RMU2x4T0cwMnN4WEpnSXBBTTMrdEtVcEZJV3NmVUw3Q2pPTU8vUXRtRkZF?=
 =?utf-8?B?SXhZV2JYT24veVB4UDQ3T3hvU2RXSkR1eFZKZVZLZjJzZ0Vqd0NFQndjT3Q1?=
 =?utf-8?B?eTk1ZXdnazlSVFNaV29USDVzbjI4cnNTY3JzU2hwdTJLaUc5aUljS1FScWR3?=
 =?utf-8?B?SkdsaklhOUI3SUlZb2JrTDNkUjF3aWFKaEJOVDJ0MDJHOWI4ZWd2SWVpL3dP?=
 =?utf-8?B?bUUrNEhrSHh4SkZ0Ti9HRXgwRXZhek9wVWwxZ1ZCSEF5cHJIQldFbWhOaVg5?=
 =?utf-8?B?bC84TXdWTzNyTS9pTDViY3dxSmtEVVh2OGh1cVZiWUhORmN5WUcxVGdaUGtv?=
 =?utf-8?B?SHY5TXREd3FBMWRndGRqRmtHbWJPL3NNVWF0RjdhSjJUV211VmtXbFlPbGRF?=
 =?utf-8?B?T0hQb2lRVVl5aUExRDgwcm1raG5XemRXTkdhWjlzdE5pazBKOUNHOW1kbzJM?=
 =?utf-8?B?UTlHWE9MZThTTVJscWJubzZVM2p5UzRlTExNRTVTYjVyaE1SZkREYXp6emo1?=
 =?utf-8?B?YWllZUFFR0Fra1VyZ0E2Nlg4NUpObkdvTlI0anQrOTZZb25mNlVEQmkzbjFn?=
 =?utf-8?Q?RC3p6uwjRHi2F3gA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KeJzHbYLz2DIF/Wz2VvB4tFU9lxO9L4SD1KnvQ1zfXFOB3csdIk4UgNBxFR/G/wZi0c052iPljKJM7hDcASkf5sC1MB42sDd/V4hTa8UgxBGGspiBumQhVyVzerN8ZkoakDmhMPunjuhLlB1xKKC0Jznca+WyadHYOt9HhY1Qo6eMMGmGN+eZvgYQ/5mjyMZI6oHu59j2mzhSKO3egnRplEJoV9tnbru2CM6yt1s9Eq+5iKe/fi+z0C6afqzRFhhKXmUuu2VxudiKx6soprWoqwDtdMiri1KF7Pgt+UJ6UkzVTAj/hgrncOI6eMnnivd+KsiNSGK7DRmvbJ+B19skg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc76841-4ad4-4bf9-20b6-08ded5ca064b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 10:34:39.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NHjy5NH4jLR0U+1C/U563iaH+Fd3Kbel9xEZu++svDUfuyFkKiVmnrBaB3Lb6N5HhldNly1He4p5HcyxJPPNDMitNZGYKv5EbaTOw2oQqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF990BCE628
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302560-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:clecigne@google.com,m:aleksander.lobakin@intel.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:sdf@fomichev.me,m:horms@kernel.org,m:john.fastabend@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,DM4SPRMB0045.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,intel.com:from_mime];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,fomichev.me,gmail.com,iogearbox.net];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D73C6D8FA9

PiANCj4gRnJvbTogQ2zDqW1lbnQgTGVjaWduZSA8Y2xlY2lnbmVAZ29vZ2xlLmNvbT4NCj4gDQo+
IENvbW1pdCA1NjBkOTU4YzZjNjggKCJ4c2s6IGFkZCBnZW5lcmljIFhTayAmeGRwX2J1ZmYgLT4g
c2tiIGNvbnZlcnNpb24iKQ0KPiBpbnRyb2R1Y2VkIGEgdnVsbmVyYWJpbGl0eSBpbiB0aGUgaGFu
ZGxpbmcgb2YgWERQX1BBU1MgZm9yIEFGX1hEUCB6ZXJvLWNvcHkNCj4gZnJhbWVzLg0KPiANCj4g
Tm90ZTogQ3VycmVudGx5LCB0aGlzIHNwZWNpZmljIEFGX1hEUCB6ZXJvLWNvcHkgY29udmVyc2lv
biBwYXRoIGlzIG9ubHkNCj4gcmVhY2hhYmxlIGZyb20gdGhlIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2ljZSBhbmQNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZiBkcml2ZXJz
Lg0KPiANCj4gV2hlbiBidWlsZGluZyBhbiBza2IsIHhkcF9idWlsZF9za2JfZnJvbV96YygpIHVz
ZXMgdGhlIGNodW5rIHNpemUNCj4gKHhkcC0+ZnJhbWVfc3opIGZvciB0aGUgYWxsb2NhdGlvbi4g
SG93ZXZlciwgbmFwaV9idWlsZF9za2IoKSBhdXRvbWF0aWNhbGx5DQo+IHJlc2VydmVzIHNwYWNl
IGF0IHRoZSBlbmQgb2YgdGhlIGFsbG9jYXRpb24gZm9yIHRoZSBza2Jfc2hhcmVkX2luZm8NCj4g
c3RydWN0dXJlLg0KPiANCj4gTW9zdCBoaWdoIHBlcmZvcm1hbmNlIFVNRU0gYXBwbGljYXRpb25z
IHVzZSA0SyBjaHVua3MsIHdoZXJlIHRoZQ0KPiBjb3JydXB0aW9uIGNhbm5vdCBoYXBwZW4uIEhv
d2V2ZXIsIGlmIHRoZSBVTUVNIGlzIGNvbmZpZ3VyZWQgd2l0aCAyS0INCj4gY2h1bmtzIChhIHZl
cnkgY29tbW9uIGNvbmZpZ3VyYXRpb24gdG8gbWF4aW1pemUgcGFja2V0IGRlbnNpdHkgaW4gbWVt
b3J5KSwNCj4gYSBzdGFuZGFyZCAxNTAwIE1UVSBwYWNrZXQgd2lsbCB0cmlnZ2VyIHRoZSBjb3Jy
dXB0aW9uIGJlY2F1c2UgdGhlIHJlcXVpcmVkDQo+IHNwYWNlIGV4Y2VlZHMgdGhlIDIwNDggYnl0
ZSBjaHVuayBzaXplOg0KPiANCj4gSGVhZHJvb20gKDI1NikgKyBQYWNrZXQgKDE1MTQpICsgc2ti
X3NoYXJlZF9pbmZvICgzMjApID0gMjA5MCBieXRlcw0KPiANCj4gQmVjYXVzZSAyMDkwIGJ5dGVz
ID4gMjA0OCBieXRlcyBhbmQgX19za2JfcHV0KCkgZG9lcyBub3QgcGVyZm9ybSBib3VuZHMNCj4g
Y2hlY2tpbmcsIHRoZSBtZW1jcHkoKSB3cml0ZXMgcGFzdCB0aGUgYXZhaWxhYmxlIGxpbmVhciBk
YXRhIGFyZWEgYW5kDQo+IGNvcnJ1cHRzIHRoZSBza2Jfc2hhcmVkX2luZm8gc3RydWN0dXJlLiBU
aGlzIGNhbiBsZWFkIHRvIGFyYml0cmFyeSBjb2RlDQo+IGV4ZWN1dGlvbiBpZiBwb2ludGVycyBs
aWtlIGRlc3RydWN0b3JfYXJnIGFyZSBvdmVyd3JpdHRlbi4NCj4gDQo+IEFkZGl0aW9uYWxseSwg
aW4geGRwX2NvcHlfZnJhZ3NfZnJvbV96YygpLCB0aGUgYWxsb2NhdGlvbiBzaXplIGlzIHNldA0K
PiBzdHJpY3RseSB0byB0aGUgZnJhZ21lbnQgc2l6ZSAobGVuKSwgYnV0IHRoZSBzdWJzZXF1ZW50
IG1lbWNweSgpIHVzZXMNCj4gTEFSR0VTVF9BTElHTihsZW4pLiBUaGlzIG1pc21hdGNoIHJlc3Vs
dHMgaW4gYW4gb3V0LW9mLWJvdW5kcyB3cml0ZSBvZg0KPiB1cCB0byA3IGJ5dGVzLCB3aGljaCB0
cmlnZ2VycyBLQVNBTiB3YXJuaW5ncyBhbmQgaXMgdW5zYWZlIGRlc3BpdGUgdHlwaWNhbA0KPiBw
YWdlIHBvb2wgYWxsb2NhdG9yIHBhZGRpbmcuDQo+IA0KPiBGaXggdGhlIHNrYiBhbGxvY2F0aW9u
IGluIHhkcF9idWlsZF9za2JfZnJvbV96YygpIGJ5IGR5bmFtaWNhbGx5DQo+IGNhbGN1bGF0aW5n
IHRoZSBleGFjdCB0cnVlc2l6ZSByZXF1aXJlZCB1c2luZyBTS0JfSEVBRF9BTElHTigpIHRvDQo+
IHByb3Blcmx5IGFjY291bnQgZm9yIHRoZSBoZWFkcm9vbSwgdGhlIExBUkdFU1RfQUxJR04obGVu
KSwgYW5kIHRoZQ0KPiBza2Jfc2hhcmVkX2luZm8gb3ZlcmhlYWQuDQo+IA0KPiBGaXggdGhlIG91
dC1vZi1ib3VuZHMgd3JpdGUgaW4geGRwX2NvcHlfZnJhZ3NfZnJvbV96YygpIGJ5IHJvdW5kaW5n
IHVwDQo+IHRoZSBhbGxvY2F0aW9uIHJlcXVlc3QgdXNpbmcgTEFSR0VTVF9BTElHTihsZW4pIHRv
IG1hdGNoIHRoZSBjb3B5DQo+IG9wZXJhdGlvbi4NCj4gDQo+IEZpeGVzOiA1NjBkOTU4YzZjNjgg
KCJ4c2s6IGFkZCBnZW5lcmljIFhTayAmeGRwX2J1ZmYgLT4gc2tiIGNvbnZlcnNpb24iKQ0KPiBD
QzogQWxleGFuZGVyIExvYmFraW4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+DQo+IEND
OiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENs
w6ltZW50IExlY2lnbmUgPGNsZWNpZ25lQGdvb2dsZS5jb20+DQoNCkhpIENsZW1lbnQsDQoNCkRv
IHlvdSBoYXZlIGEgcmVwcm9kdWNlciBmb3IgbWVudGlvbmVkIGlzc3VlIG9yIGlzIGl0IG9ubHkg
YSBmaXggZnJvbQ0KdGhlb3JldGljYWwgUE9WPw0KDQpUbyBiZSBjbGVhciwgd2Ugd2VyZSBhZGRy
ZXNzaW5nIGhlYWRyb29tIGlzc3VlcyBpbiB0aGlzIHNlcmllczoNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2JwZi8yMDI2MDQwMjE1NDk1OC41NjIxNzktMS1tYWNpZWouZmlqYWxrb3dza2lAaW50
ZWwuY29tLw0KDQpzbyBJIHdhbnRlZCB0byBhc2sgaWYgeW91IGFyZSBhYmxlIHRvIGhhdmUgdGhp
cyBtYWxmb3JtZWQgc2V0dXAgZm9yDQoyayBjaHVuayBzaXplLiBUaGF0IHNlcmllcyBzaG91bGQg
bm90IGFsbG93IGZvciB0aGF0Lg0KDQpJIHRoaW5rIHRoaXMgaXMgdGhlIHNlY29uZCB0aW1lIHNv
bWVvbmUgaXMgdHJ5aW5nIHRvIGZpeCB0aGlzIGFyZWEgb2YgY29kZSwNCnNvIGl0IGlzIG5vdCBh
IG5hY2sgb3Igc29tZXRoaW5nLCBsZXQgdXMgZml4IHRoaXMsIGJ1dCBJIHdhbnRlZCB0byBoYXZl
DQp1cyBvbiB0aGUgc2FtZSBwYWdlLg0KDQpUaGFua3MsDQpNYWNpZWoNCg0KPiAtLS0NCj4gQ2hh
bmdlcyBzaW5jZSB2MjoNCj4gIC0gVXNlZCBMQVJHRVNUX0FMSUdOIHRvIGNhbGN1bGF0ZSB0aGUg
bGVuIHRvIGFjY291bnQgZm9yIHRoZSBhbGlnbmVkDQo+IG1lbWNweS4NCj4gIC0gRml4ZWQgdGhl
IGNvbW1pdCBtZXNzYWdlIHRvIGluY2x1ZGUgdGhlIGlkcGYgZHJpdmVyLg0KPiANCj4gQ2hhbmdl
cyBzaW5jZSB2MToNCj4gIC0gVXNlZCBTS0JfSEVBRF9BTElHTiB0byBwcm9wZXJseSBjYWxjdWxh
dGUgdGhlIHJlcXVpcmVkIGFsbG9jYXRpb24gc2l6ZQ0KPiAgICBpbmNsdWRpbmcgdGhlIHNrYl9z
aGFyZWRfaW5mbyBvdmVyaGVhZC4NCj4gIC0gUmUtb3JkZXJlZCB2YXJpYWJsZSBkZWNsYXJhdGlv
bnMuDQo+IA0KPiAtLS0NCj4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL3hkcC5jIGIvbmV0L2NvcmUv
eGRwLmMNCj4gaW5kZXggOTg5MGEzMDU4NGJhLi43ZTM5ZjE3YWQ0MDcgMTAwNjQ0DQo+IC0tLSBh
L25ldC9jb3JlL3hkcC5jDQo+ICsrKyBiL25ldC9jb3JlL3hkcC5jDQo+IEBAIC02OTgsOCArNjk4
LDggQEAgc3RhdGljIG5vaW5saW5lIGJvb2wgeGRwX2NvcHlfZnJhZ3NfZnJvbV96YyhzdHJ1Y3QN
Cj4gc2tfYnVmZiAqc2tiLA0KPiANCj4gIAlmb3IgKHUzMiBpID0gMDsgaSA8IG5yX2ZyYWdzOyBp
KyspIHsNCj4gIAkJY29uc3Qgc2tiX2ZyYWdfdCAqZnJhZyA9ICZ4aW5mby0+ZnJhZ3NbaV07DQo+
IC0JCXUzMiBsZW4gPSBza2JfZnJhZ19zaXplKGZyYWcpOw0KPiAtCQl1MzIgb2Zmc2V0LCB0cnVl
c2l6ZSA9IGxlbjsNCj4gKwkJdTMyIG9mZnNldCwgbGVuID0gc2tiX2ZyYWdfc2l6ZShmcmFnKTsN
Cj4gKwkJdTMyIHRydWVzaXplID0gTEFSR0VTVF9BTElHTihsZW4pOw0KPiAgCQlzdHJ1Y3QgcGFn
ZSAqcGFnZTsNCj4gDQo+ICAJCXBhZ2UgPSBwYWdlX3Bvb2xfZGV2X2FsbG9jKHBwLCAmb2Zmc2V0
LCAmdHJ1ZXNpemUpOw0KPiBAQCAtNzM4LDkgKzczOCwxMCBAQCBzdGF0aWMgbm9pbmxpbmUgYm9v
bCB4ZHBfY29weV9mcmFnc19mcm9tX3pjKHN0cnVjdA0KPiBza19idWZmICpza2IsDQo+ICAgKi8N
Cj4gIHN0cnVjdCBza19idWZmICp4ZHBfYnVpbGRfc2tiX2Zyb21femMoc3RydWN0IHhkcF9idWZm
ICp4ZHApDQo+ICB7DQo+ICsJdTMyIGhlYWRyb29tID0geGRwLT5kYXRhX21ldGEgLSB4ZHAtPmRh
dGFfaGFyZF9zdGFydDsNCj4gIAljb25zdCBzdHJ1Y3QgeGRwX3J4cV9pbmZvICpyeHEgPSB4ZHAt
PnJ4cTsNCj4gLQl1MzIgbGVuID0geGRwLT5kYXRhX2VuZCAtIHhkcC0+ZGF0YV9tZXRhOw0KPiAt
CXUzMiB0cnVlc2l6ZSA9IHhkcC0+ZnJhbWVfc3o7DQo+ICsJdTMyIGxlbiA9IExBUkdFU1RfQUxJ
R04oeGRwLT5kYXRhX2VuZCAtIHhkcC0+ZGF0YV9tZXRhKTsNCj4gKwl1MzIgdHJ1ZXNpemUgPSBT
S0JfSEVBRF9BTElHTihoZWFkcm9vbSArIGxlbik7DQo+ICAJc3RydWN0IHNrX2J1ZmYgKnNrYiA9
IE5VTEw7DQo+ICAJc3RydWN0IHBhZ2VfcG9vbCAqcHA7DQo+ICAJaW50IG1ldGFsZW47DQo+IEBA
IC03NjIsNyArNzYzLDcgQEAgc3RydWN0IHNrX2J1ZmYgKnhkcF9idWlsZF9za2JfZnJvbV96Yyhz
dHJ1Y3QNCj4geGRwX2J1ZmYgKnhkcCkNCj4gIAl9DQo+IA0KPiAgCXNrYl9tYXJrX2Zvcl9yZWN5
Y2xlKHNrYik7DQo+IC0Jc2tiX3Jlc2VydmUoc2tiLCB4ZHAtPmRhdGFfbWV0YSAtIHhkcC0+ZGF0
YV9oYXJkX3N0YXJ0KTsNCj4gKwlza2JfcmVzZXJ2ZShza2IsIGhlYWRyb29tKTsNCj4gDQo+ICAJ
bWVtY3B5KF9fc2tiX3B1dChza2IsIGxlbiksIHhkcC0+ZGF0YV9tZXRhLA0KPiBMQVJHRVNUX0FM
SUdOKGxlbikpOw0KPiANCg0K

