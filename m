Return-Path: <netdev+bounces-204917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FABAFC864
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7871BC4537
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AB422F74D;
	Tue,  8 Jul 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBqSpZki"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537928C86E
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970463; cv=fail; b=cC/vWxFiwDzhfig5HU6b5vPiibQZJt4se9SDuJjMm1kk+Lh+v3ScS5SNXJrzuDc+HG3GcVAarG6GgE9zumPvmoTKsvjzrlxFgXK377RkVv2YPzQTLbWimrhswQ+jSkihmD0AguPaQY8ScKhRNtVmM6Frhr7ySuxgS56ML/OYJqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970463; c=relaxed/simple;
	bh=nmb5Z23CWA/iKqDBzMiBepfw93InBWHbVmBibEgJG3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QGF1ytFNIB864O7dwvJAxtkgETEQMq4f0IT8o+Tu+XnOJNGSjPzeHxqQuCqr7m7yGzyEuOM0BmjD6nbwLZyhweLPy/qKVTkzFB8vvKCegWpafFeRzKsP2aw8DDmtb0FSmsFhaIrfEhHT9T6QE1GBM06CKqiPFBSTizVdiyi0BOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBqSpZki; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751970462; x=1783506462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nmb5Z23CWA/iKqDBzMiBepfw93InBWHbVmBibEgJG3M=;
  b=aBqSpZkivOiwVae3cAzvMbuPJDJMSZpXmA/u1tqhhH1bFDVnBFqdLRHC
   ++d0FQj6w5UWgNrdAi8ogdUdbaR3aWQgloV80EyDDN3HAo1VrNmtlRLx2
   uLD3SJZ8OykS9lBi45LRNcoXyZWKueTTgZjnmG9kvMDgJb8cJbZckCdeP
   ngAGTmMNQoXkJ0YwBxH6NrIhs2YMDF7/dyfPJedliRp1FEm+tvn8V3Afh
   Z8gp3F4hO/RdtO/qImO5PtaJYNLNEmc+iGB1C8Nq6nNc2ZlLqgXuM8+vz
   L5bCW/KTWVe3iAZJdDUfhnXbrmukYkRUPXjnlmvwYmMZd4Yl9AZ5Q1bMp
   A==;
X-CSE-ConnectionGUID: eHLtp7zNQ0qDr2uAD8cYPA==
X-CSE-MsgGUID: BKwUqO+mSoCyQ8paJHH3TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65555058"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="65555058"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:27:40 -0700
X-CSE-ConnectionGUID: IOkjwcR5Q0afFWLCQ75qDA==
X-CSE-MsgGUID: LxhznAwCQwq/BZS+V5mNcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="159507888"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:27:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 03:27:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 03:27:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 03:27:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwZIXM2N4816PETunf+xp/BQWTYrflmDwNrJKuWKZdZ/f5uqdZGQvXwiAOPqsxF7F5K0xTW4E3Onp4hThEHe+7BJib3hYcdw+7forMdP7CrOiZSmHYaXviGKq5tKdmSdlMG8UzEMJJeJNJudFl5oB83vSMT1do0cia+fIGcTmBKJ1EV3D2E6era+JuueWnfZ26mPoSFMj14kQGi/5eJH4/IVLGdN6GsXOreXifJWNfP/sCix0MVUJ5NKkkuVikel+RSUb2lSuhqUQvSxvs9YXQ556A4ZCsHHNP+QD8n/0Jglr8V+EB8D7lgl8aClIldj5NoWzrJfhmw1Rl4V8xIh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmb5Z23CWA/iKqDBzMiBepfw93InBWHbVmBibEgJG3M=;
 b=w3sVHfOSKcMG/SxsQk6aI/NoqihBr9a0rfWdeFmFmTObP5eSN/OqmJTQvx9jBnCvL2j+WSScEd/gt4n0HmTob4EgKvCHQAmzI9RWuugd4tPSve4skEVXoG8Sr1a6kWKzlRGciEeoazGRGrPrNDOCN1aAdCRPV9qmaOALzq67XZA4QqvVvJQAxiLkyfANpi1ejO27xPVY05mVPJnNiLbZtKQ6zZHgiDXv0fQ4IBs8r0kIqvBSyEDaP06HYsz1kpvW09MpGtoHMZcrNXciOFEcyKKd49Zcx5YdfZLhrpq1Xq3Un7fG0+I+Qoy8IrNFp8zbEPh/qp6eIenG/kIWpt2Seg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 10:26:57 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%7]) with mapi id 15.20.8769.022; Tue, 8 Jul 2025
 10:26:57 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jacek Kowalski <jacek@jacekk.info>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 5/5] ixgbe: drop unnecessary
 constant casts to u16
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 5/5] ixgbe: drop
 unnecessary constant casts to u16
Thread-Index: AQHb7+D2qyRrvu30L0WGM3O1IcuR1LQn6o7AgAAMxwCAAA3VUA==
Date: Tue, 8 Jul 2025 10:26:57 +0000
Message-ID: <IA3PR11MB898618236CA2EA46C0A861B7E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <33f2005d-4c06-4ed4-b49e-6863ad72c4c0@jacekk.info>
 <IA3PR11MB8986B9D474298EEEFA3C57E5E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
 <b3273f0c-c708-488e-88c0-853e4e8e5ed5@jacekk.info>
In-Reply-To: <b3273f0c-c708-488e-88c0-853e4e8e5ed5@jacekk.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6451:EE_
x-ms-office365-filtering-correlation-id: 5ee0626c-5795-454c-9ee8-08ddbe09f765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?WHdYM3pJRktyeHNnMHV2YnJvMGJtbnV4NUtVbVpDckV1TnJYTUVWY0tKak5E?=
 =?utf-8?B?cEtrZ3FJT1ZpYzZrbStIeW9ZQThpZTVQWmh2NnpKWGdJNnBBSGhmclB4blJu?=
 =?utf-8?B?cTJOd0JaRXRJV21mOXFjdUoreWsxelZFeE1vQWVrc3QvV1MxK0RHS3Arcjh1?=
 =?utf-8?B?NllrOTRjV0V2ZnBvYWp4cEdYQkFZNmpGSUFHVzlNVGIrdE8xYVJFazVRM1RK?=
 =?utf-8?B?eXpXUWVwekJaa2JXUk1ubUJqaXBPazBVSTcxbVBUVWtxb01nditad2tCL2NY?=
 =?utf-8?B?aVJFQS94ZGdLMkxUa2NyQmpsTEZXTVNLWUlZb0ZkQjZDTlJDYXRyWU1Ub2Ir?=
 =?utf-8?B?T29VbW5HN2xtM1hGS3FXRGNxNnNIT2x4c3pGOWh0UjZBVWJJdExQZWxiL2hC?=
 =?utf-8?B?WlJ3QThGTUV1WmRHamhTKy9JQkp6YjUzdTZRRnVvZEUyenEyU0ova1VnUVFy?=
 =?utf-8?B?YlN0M016UEJrU1FDaWhmVXVYaXdmWlhLSHlMSmNWd1ZZbUV2T3V3QURsVUFw?=
 =?utf-8?B?dU5sQ2NTN0Q3M0owTG9pZkhNMGlZZXhTYUVUcHdUdUFvTjR5VXVoZk9FZGM4?=
 =?utf-8?B?ZlUxc05mSE96c0kxRVFKSkJkc1VGRVlrRU50QWdRQ0djYys0TnNpNlRwSlBu?=
 =?utf-8?B?VlJQMXQzdHJCQU5POCtBdDlnczIvb3hwZGF3bEtRZjFBWU9ieEtsS090R2o5?=
 =?utf-8?B?eGFMWVMrYXl0NnJlcU81NFR2ZHdIU3EyMFJyRysrTGZJT3BpTlJ4dVNlaGov?=
 =?utf-8?B?Q3owT1V3UGJIS1N4L0p0aS9kSlFWSDJGTmxYeFd1M1JHMVRuRGdCVWxrV0ZD?=
 =?utf-8?B?dEczZDBYYWxrajBkeXZXUXpQNDJaY2lFYklCc3VHYmJnNzJBVGdrWGdzZXcw?=
 =?utf-8?B?TDExV2NWQ2NzZm5lQ25mWTNyU0lDV3Q5SkFIVEhvRGNtbi92ZHhXVEpvNEd1?=
 =?utf-8?B?ZmM5ZnJQanZjUm9zcVdQUklMTnYvaVhiZEdIWU5SUlM3Z1RaRWVyS0xmbXBE?=
 =?utf-8?B?ZWR6L1FLd1RCK21teVFjZFFjTHVqVGZIdXpRNEdpL29hQi9FU21sT3g3c05J?=
 =?utf-8?B?ZUJFMS9nMzhMM21PREpWR2JSYWE1SERWbk9qS1ljMzNJYVAveVdJZktuNVQy?=
 =?utf-8?B?dGR3ckxmRGdnMGVWZ2ZaY3A1TndoUnE2UGM5S3V2aDRTaXZBSW5ldDJIRG8z?=
 =?utf-8?B?TjhtU2hQU01ycSsxZ2NxN0N5NHhIWUdMSFhuZ0pHZ1VVVEFJMVd4cE5NZ0lj?=
 =?utf-8?B?cUN3WmRUU25naURjZkZOQVJBTis5YjdGNlN6OXYyVmhuNjJ5WitTcjRhb1RJ?=
 =?utf-8?B?NW1LWm5lU3BRUm5ic0J5aG5RWmJNdmRydE9LYXFLbDFrdEt3WUgxMmk0b1Rk?=
 =?utf-8?B?R1ZsaVlhK3ozUTFMZjRnRndTbkxJSThoN3FzUmJaRGFSQzZOcWhOcTdJMUFo?=
 =?utf-8?B?TUJ0WU02V3E2dGdnM0J3Zkw0Z04xRkxQZTg5MVAyVWgxbS9xaGRvUHdOcnVo?=
 =?utf-8?B?Y2pOcGRyKzllVkJ5T0dsN2h2NkcwcWNVMkp1TnVaSCtxNlNtNjM4QXJMbGJr?=
 =?utf-8?B?TEdKa2prQjErdVJGOVI3RHJHZDkrcFRrTUhhWDgvdGlxay80d2U1RzRzRnpj?=
 =?utf-8?B?cWJFaURXa3RCd0RPWmlIQnZhSHpqYXF3cUdSOTQxdTdacklvVTVzNDdleTVN?=
 =?utf-8?B?VXMwbXA2dS9ySitTQ09OZGpncGNKMUV6MFNMTzdwRTJhTVhiYTVTSFV3VUtS?=
 =?utf-8?B?cncwTzU1c3RMSG1LVFdWTFJoQm10Nm1Hcmh6bVJIZkZqbElkYjdhdjNCeG5C?=
 =?utf-8?B?VWlRUXFNWlFpdnVmSzY5L2tHelVLUjlYTzlwRTZTdWloRHhuVzZxNjBadW9n?=
 =?utf-8?B?Z2k4cHNNZDAyeEtQMkNwTWJPSmtSNEVCRENrNHVPTWVISzArQnNUcnRqcVNz?=
 =?utf-8?Q?sZfsQmNBMFwflZnOObY3wO7JrLv5wwFc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWoxNXJQNEJzanBqZTFEMlhESFBHVXpBZFNFcktadzRpUjBqYTZiNEV6MCtp?=
 =?utf-8?B?T3ozQ0FYVXJOelRhNGZMNjI1c0MrS0N1NEZJUXVFVDNnRnl0dElRV1Q5elRk?=
 =?utf-8?B?YUhBN2J2S2d3clMrTmg0WEI4NHFMVm5GYTI2TXdSNXFyblNhcXJhbTR6QzNw?=
 =?utf-8?B?WFMwSXM2QWtsMndYdlg5K1g4czBxK2Y0WXBndWNnZkI5QS9kTm9HcmIva0dQ?=
 =?utf-8?B?c1RLaUtuQmlJYS82aEdZYVZpR0dIYzViU3g3K1NEVjgvVjhzYUtrVk0rZ0pY?=
 =?utf-8?B?YmFqQUJsNy8yZFVQNzdiNWxQNlB5d2N3Q2hLM3FibzY2ckhENHA4STBaQ05K?=
 =?utf-8?B?MUhjTDIySmJpLy9CWWprckN5SUh3VzgrdVhlcnpUQXpwUVMvRUZpZkZuZVFy?=
 =?utf-8?B?U3JFWkZrVFoyVEFDb1Jvd0Y0bmZFaGtURWVXMnBibUFEVCt2dnkwYXdwYSs3?=
 =?utf-8?B?T2VuclEycWZqQVZEaTB3eXNUa2dsODkxRkl3SFRzdk5ySUF4dFpxQWdSL0Fo?=
 =?utf-8?B?RUxFcFd5Y2txby9YQ3E2SjZ5SENWWTA4bTdTRUdQTHB2ZkpjckowNWNvMXZa?=
 =?utf-8?B?dWpBMW5vWTFFQVRMcXphSWpabEl6dUhLc20yUEh2U3N0SitRLzFSaUlIMG9L?=
 =?utf-8?B?RlFVVERCRUM0UFhRbjZrT2syWk5MQXQ3aEhVZ2tOcEd2N0hhNWQ4WVdBSVMx?=
 =?utf-8?B?a0svcXVhbnJqRmU2YTRlam1jZER4U0NIU1VQejZWNjZiMEhzQUVvTksrdmM2?=
 =?utf-8?B?TkdmZWVwVnA2V2xwclFvU3VESlF0QkJOTFN0bDAzcmhTOXl0RFEvQ253UWMy?=
 =?utf-8?B?aitwRDZJeGxUbE0yZXpZTUhDUm9ob1BxMXFOV1lqSEpHcVVJazhvdW5CTzds?=
 =?utf-8?B?d0o0RDZUbUhaUVBuTEF6WHJMdkltaEgwSXp6S3NxUnhMS3JVSVprekVxVDdL?=
 =?utf-8?B?TUF2ejkxL0lWc1BUcWtMUkNReE1VNzVkd0o0cFIvbzRKb29jdEZRZmpwelBJ?=
 =?utf-8?B?bm1jTXI3RWcyc21sZC91cm9QWE1HRDJHVmNNM3pwckxxYVBkN1YwSmNBa2Rr?=
 =?utf-8?B?aFE4R2QxYWVuNUQzMW5DbmRhRzNrQWNFdGV3dk8vbElqRzAxNnA5L3Q2QUlo?=
 =?utf-8?B?ejdGUWJqUHR2VDVDdTVtbHk3YVU1MUVTVkR4SkJTeC80QkR1N2tsR1MvdTQ3?=
 =?utf-8?B?V2lmc0dwR1NtU05mQ1B2SGxEY0kvMkRXNkF6eE1QKzZ6dWpPNnAwZGhGQWll?=
 =?utf-8?B?NHlOT3hvNnlQTEpDaTNSNVJZdVlGMTFCZGI1bVlFS2htY05Ia1NkaCtwbUNv?=
 =?utf-8?B?MFlxQmJFcXk2RXVyWWNBckl3a0lTMU1LMEVtTkZsVElTVGtYdDdFalp1WFp3?=
 =?utf-8?B?ZmpITS9leHM1cTlvdWFuSERNbEJkVHVVWFE1cEhTcldGVkUwUStKTEduUWNZ?=
 =?utf-8?B?b0NCRStHcGcrODZyUWVndGdac3pWdzk4b3pZM3hBbTZQV0FVai9aZGNJSnNt?=
 =?utf-8?B?NHlMeUJ1UzdBRVhZQ2xRajFTaFZjOXozT0xBTXhvdXNVMjRDRk1NcVFUOGs5?=
 =?utf-8?B?ZVJPazBPVVpDd1NUNG1KOE9CRkJYd0dWK1BEMVRTak5saVJwclhTZFFna2M4?=
 =?utf-8?B?N0FmV1VOMHZaSm9NZEhEMS9zdU9WbHFXb2JTSVQ5clZUaWtuSlN6WVg4VllY?=
 =?utf-8?B?bGhQMVcxQXkyVVdmRzQ2RDR6RTcreXNNQ0ZYaDZUdHdOVXJWZXlvV2tWd0ky?=
 =?utf-8?B?SlE5a211dlRXWTNjd3Fsd01kSUtDejlrQjJnTldiU2UwVnQ4NVRBSTVXRDYv?=
 =?utf-8?B?TmhDdjlmdkhOTklzL1gzM1BOOVh0Z0VSL1JSTVN4dW1BQmwwYnlMK0ZGQkNr?=
 =?utf-8?B?NkhYUDAyK2p2U3pMK0o0K3ZpWXppTVAwQm5WTnM3c2hRdGV1eU5VVTJXa2ZP?=
 =?utf-8?B?SjdpL29Uam1YWXhpYTV5SWlRTGEvWlFuTDBWS2ZVd3pNQ0h4dWZlOHZjWVpI?=
 =?utf-8?B?M0lqWnVGRWNiOVlWNllDWUd2RUREM2d0NG9NNGNLMWoveXNzMzFtTHM2UTFO?=
 =?utf-8?B?bE80MzcvbHJ6c0RJR0FKbFZKTEFCakRoNnh1dWVJVmppbmNkeDBmcUtuSHdC?=
 =?utf-8?B?S1cyM2pQRHZyWjJmakZhTTAxZTYrUXVaMGZlU0h5aXVycENGajhGVnJEUS9o?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee0626c-5795-454c-9ee8-08ddbe09f765
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 10:26:57.0665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yy2S0ZHAxogt5VdMmAzIKk6JTxtIvFb3qlCJVo0YkBZzAri2tk/71nGqetcbQ1dr38VLcfdRrGxYcE8sOPNpSMJ6HxaQSqOGTK2MiSqJtrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6451
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjZWsgS293YWxza2kg
PGphY2VrQGphY2Vray5pbmZvPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDgsIDIwMjUgMTE6MzUg
QU0NCj4gVG86IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVs
LmNvbT47IE5ndXllbiwNCj4gQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47
IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBB
bmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsNCj4gRGF2aWQgUy4gTWlsbGVyIDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29t
PjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJl
bmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gQ2M6IGlu
dGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjIgNS81XSBp
eGdiZTogZHJvcA0KPiB1bm5lY2Vzc2FyeSBjb25zdGFudCBjYXN0cyB0byB1MTYNCj4gDQo+ID4+
IC0JY2hlY2tzdW0gPSAodTE2KUlYR0JFX0VFUFJPTV9TVU0gLSBjaGVja3N1bTsNCj4gPj4gKwlj
aGVja3N1bSA9IElYR0JFX0VFUFJPTV9TVU0gLSBjaGVja3N1bTsNCj4gPj4NCj4gPiBDYW4ndCBs
ZWFkIHRvIGRpZmZlcmVudCByZXN1bHRzLCBlc3BlY2lhbGx5IHdoZW46DQo+ID4gY2hlY2tzdW0g
PiBJWEdCRV9FRVBST01fU1VNIOKGkiB0aGUgcmVzdWx0IGJlY29tZXMgbmVnYXRpdmUgaW4gaW50
LA0KPiBhbmQgbmFycm93aW5nIHRvIHUxNiBjYXVzZXMgdW5leHBlY3RlZCB3cmFwYXJvdW5kPw0K
PiA+DQo+ID4gV2l0aCB0aGlzIHBhdGNoIHlvdSBhcmUgY2hhbmdpbmcgdGhlIHNlbWFudGljcyBv
ZiB0aGUgY29kZSAtIGZyb20NCj4gZXhwbGljaXQgMTZiaXQgYXJpdGhtZXRpYyB0byBmdWxsIGlu
dCBpbXBsaWNpdCBwcm9tb3Rpb24gd2hpY2ggY2FuIGJlDQo+IGVycm9yLXByb25lIG9yIGNvbXBp
bGVyLWRlcGVuZGVudCAvKiBmb3IgZGlmZmVyZW50IHRhcmdldHMgKi8uDQo+IA0KPiANCj4gQXMg
ZmFyIGFzIEkgdW5kZXJzdGFuZCB0aGUgQyBsYW5ndWFnZSBkb2VzIHRoaXMgYnkgZGVzaWduIC0g
aW4gdGhlDQo+IHRlcm1zIG9mIEMgc3BlY2lmaWNhdGlvbjoNCj4gDQo+ID4gSWYgYW4gaW50IGNh
biByZXByZXNlbnQgYWxsIHZhbHVlcyBvZiB0aGUgb3JpZ2luYWwgdHlwZSAoLi4uKSwgdGhlDQo+
IHZhbHVlIGlzIGNvbnZlcnRlZCB0byBhbiBpbnQ7IG90aGVyd2lzZSwgaXQgaXMgY29udmVydGVk
IHRvIGFuDQo+IHVuc2lnbmVkIGludC4gVGhlc2UgYXJlIGNhbGxlZCB0aGUgaW50ZWdlciBwcm9t
b3Rpb25zLiAoc2VlIG5vdGUpDQo+ID4NCj4gPiAobm90ZSkgVGhlIGludGVnZXIgcHJvbW90aW9u
cyBhcmUgYXBwbGllZCBvbmx5OiBhcyBwYXJ0IG9mIHRoZSB1c3VhbA0KPiBhcml0aG1ldGljIGNv
bnZlcnNpb25zLCAoLi4uKQ0KPiANCj4gDQo+IEFuZCBzdWJ0cmFjdGlvbiBzZW1hbnRpY3MgYXJl
Og0KPiANCj4gPiBJZiBib3RoIG9wZXJhbmRzIGhhdmUgYXJpdGhtZXRpYyB0eXBlLCB0aGUgdXN1
YWwgYXJpdGhtZXRpYw0KPiBjb252ZXJzaW9ucyBhcmUgcGVyZm9ybWVkIG9uIHRoZW0uDQo+IA0K
PiANCj4gDQo+IFNvIHRoZXJlIGlzIG5vICoxNiBiaXQgYXJpdGhtZXRpYyogLSBpdCBpcyBhbHdh
eXMgZG9uZSBvbiBpbnRlZ2Vycw0KPiAodXN1YWxseSAzMiBiaXRzKS4NCj4gDQo+IE9yIGhhdmUg
SSBtaXNzZWQgc29tZXRoaW5nPw0KPiANCj4gDQo+IEFkZGl0aW9uYWxseSBJJ3ZlIGNoZWNrZWQg
QU1ENjQsIEFSTSBhbmQgTUlQUyBhc3NlbWJseSBvdXRwdXQgZnJvbSBHQ0MNCj4gYW5kIGNsYW5n
IG9uIGh0dHBzOi8vZ29kYm9sdC5vcmcvei9HUHNNeHJXZmUgLSBib3RoIG9mIHRoZSBmb2xsb3dp
bmcNCj4gc25pcHBldHMgY29tcGlsZSB0byBleGFjdGx5IHRoZSBzYW1lIGFzc2VtYmx5Og0KPiAN
Cj4gI2RlZmluZSBOVk1fU1VNIDB4QkFCQQ0KPiBpbnQgdGVzdChpbnQgbnVtKSB7DQo+ICAgICB2
b2xhdGlsZSB1bnNpZ25lZCBzaG9ydCB0ZXN0ID0gMHhGRkZGOw0KPiAgICAgdW5zaWduZWQgc2hv
cnQgY2hlY2tzdW0gPSBOVk1fU1VNIC0gdGVzdDsNCj4gICAgIHJldHVybiBjaGVja3N1bTsNCj4g
fQ0KPiANCj4gdnMuOg0KPiANCj4gI2RlZmluZSBOVk1fU1VNIDB4QkFCQQ0KPiBpbnQgdGVzdChp
bnQgbnVtKSB7DQo+ICAgICB2b2xhdGlsZSB1bnNpZ25lZCBzaG9ydCB0ZXN0ID0gMHhGRkZGOw0K
PiAgICAgdW5zaWduZWQgc2hvcnQgY2hlY2tzdW0gPSAoKHVuc2lnbmVkIHNob3J0KU5WTV9TVU0p
IC0gdGVzdDsNCj4gICAgIHJldHVybiBjaGVja3N1bTsNCj4gfQ0KPiANCj4gLS0NCj4gQmVzdCBy
ZWdhcmRzLA0KPiAgIEphY2VrIEtvd2Fsc2tpDQoNClRoYW5rIHlvdSBmb3IgdGhlIHRlc3RzLCBJ
J3ZlIGNvcHkgcGFzdGVkIGludG8gR29kYm9sdCBhbmQnIHZlcmlmaWVkIGEgZG9lc24ndCBvZiB0
YXJnZXRzLCB0aGUgY29kZSBpcyBpZGVudGljYWwgZ290IGdjYy4NClNvLCB0aGUgY2hhbmdlIGxv
b2tzIHNjYXJ5IGZvciB0aGUgZmlyc3QgZ2xhbmNlLCBidXQgR0NDIGFjdHVhbGx5IGhhbmRsZXMg
aXQgdGhlIHNhbWUgd2F5Lg0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxl
a3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQoNCg==

