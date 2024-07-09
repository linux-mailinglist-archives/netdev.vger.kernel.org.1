Return-Path: <netdev+bounces-110134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C880392B12F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D22C2823B7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5125E13AD3F;
	Tue,  9 Jul 2024 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEBRdNmW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0D142E78
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510455; cv=fail; b=aQqYAPBRMeR33QbuWuSbkiRCPp9qEynQtmFUydYJx6Xvkdw9pH9Aeu1pCTkCADZxKYQsXVE0OtXwGRctSYyDDwgY6e7/4qWrosZ8bUX/b10TgTtkTR2RnIVzOaWWlhW3J9/7T/9dPTXo6K48A6L4BHO1KduEXousYsjhaqhZVPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510455; c=relaxed/simple;
	bh=4mGVPBwAZH2gF0ZUiZmPrTbzU8CxX2OK3NdkUZdirHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CI/G4z9ZYnwcWXrGaY7AkZFzoT2fyMb8MwrMk+u14E+XFJPSlRlVZuiDu4rOFlVmkLn72zube6PYpU9pKqC+/KCdiyXXMRvGPfJ6qMXeJ8qfr2bJzVbIEOr5uHJijITVAMBkMIfo8GV1Q5bjFCl5CPOOFLl0UC9pJHyUXPMMgjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEBRdNmW; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720510453; x=1752046453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4mGVPBwAZH2gF0ZUiZmPrTbzU8CxX2OK3NdkUZdirHU=;
  b=cEBRdNmWJxd3qmmPlULvTDPiBw3BhQOW87HcOs4Uk09Wy/lZzTrID4nr
   pMqcXhMoN38ScUtfHQMSH+JjryL/74ahVXTV0vasUPy66f68JhRReGCpQ
   w79RyP5ibQ1vibihg5Zjc8vgZ7lsCwrvFwpH9jG4TuV2OC5N0uyRA8KhW
   LaZbojpXwZjAJnPBZMqrVAjUm4GZS1kDcPeJyJutRZKYdfHIDb8TjQhFV
   kOKLBXXqB7i4453/iJO9umJ6nNfVZpQhcr71ORb6Po/lXCHubgvGckgpd
   yYlXoAtiPyT+Ycr0j3ij8qVDvjSGW9GfcCZyjQYuN7jCTnnlH81rOtM3Y
   A==;
X-CSE-ConnectionGUID: 6/81/TJCSJaQinssrtHKZA==
X-CSE-MsgGUID: 7+/sDl8GQXiMxL+FZYQoLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="12446930"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="12446930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 00:34:13 -0700
X-CSE-ConnectionGUID: Rf+E7rGTQB2Kdi6QDtcfiA==
X-CSE-MsgGUID: ezAxXkPCS9SvDDUcPYVL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47743389"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 00:34:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:34:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:34:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 00:34:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 00:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSr4+n+0K7uMs0flPvsXmpVP0A9z6Fr64CFOD2vo0+czdCucspU/B/LMno/LQLxhOMA0bnHTTCKJvZ9oQ2RnMhmSEZ7Rkc4xxCGqn3JmLoWqQ20T1HdMjI6zH8qb1ppJVe4B8mGb+ZMGm1H5FIdCu5yw50ROJlLuWZ7bGZzZcTL8RLsjIfHz94ggKq626ri/j/LsS0Mt+w1/Vuwm7ltkx+8VYSwgfiLYXuPftTwSnfkQ8ZO2C59GKSFHhGAjPpDVlA/4FljCBU3kpBXt5k8qYWECpRf0SINbr3sfZoPMpvYPHHzYd4mWKUpBYt/BU5sac8QLCJDRqoCsQ8wqm4KteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8tbxqP/sRsrUJKwq/iTV1SzkXA0FaoQNRbYQd6Bi00=;
 b=adbkufLqnLDIR1sPmJc4sEHrNfaJnvv2qcmZqwkbl62lTaSzuS8ugMlV717qSEL7wWgVl2aoz8KZ6piJKYZHq31DrFUKpOE9fWcubotUajkkdeEUnldsYN433dixyRobGA9G1GHEtemkA9z1h0Fj5lbAn6vaFtoluC/zB4z1Yu02hP7zwBYy/P4vZ5RLRURQO7wUGF4uSrA7QZRFeG6mAht2EQdBbaKYdwmiGquyB7gwYh8dc5Wq31u70laJs/AbNwJ9IzzG7BxWeohF6i9Mo23MlUNYfme38kOwUgKtP67cSuNfRpyEYQE8NF1nPY5t6S6sJMELlm9lAdE4p7DTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 07:34:09 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:34:09 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 5/7] ice: Optimize switch
 recipe creation
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 5/7] ice: Optimize switch
 recipe creation
Thread-Index: AQHayKILYNUhqRULu0Gp/uozJBvr9LHuE0bA
Date: Tue, 9 Jul 2024 07:34:09 +0000
Message-ID: <PH0PR11MB50130565F138EB2D296B18F296DB2@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
 <20240627145547.32621-6-marcin.szycik@linux.intel.com>
In-Reply-To: <20240627145547.32621-6-marcin.szycik@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|CY8PR11MB7108:EE_
x-ms-office365-filtering-correlation-id: 4f6e5c47-89f4-4064-22a3-08dc9fe98574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?y+VazQH2jxJtDLX5btZa/uCMqVmyoSq3fvoVLuwf419lEjDyGlOlZ6Hyq2y+?=
 =?us-ascii?Q?e8q1M7UaS27Rwh7S1d2OWQY1nsF2yGIZRpBNR9+6EW2AXB6hjO+d7mn92Qjx?=
 =?us-ascii?Q?f47F2wk5Fxe8VYq1si6QwZ/f1fpZ2N8Go9d8WitGf+RzkEhUykAZxjVmtruN?=
 =?us-ascii?Q?9aiZuB8oBcsOgLnYX0T10OjJ23suLFc1lklp3JyKuiSqx4ykKF7YWV8c/L9i?=
 =?us-ascii?Q?uMQoXEnXEABk6KibhdFeIc6l22X8di1Mbg+pmIwsPxQlT0gLMNUJmCYNh1D0?=
 =?us-ascii?Q?JXlEl6QmIxl0Xo46yztC+W1YBOSBwKZSgIs09dbMgC1eFBVN2uOvX6H8Dptk?=
 =?us-ascii?Q?TaMubS8iylmdTQxEdrhpY4vmHofVdF8BDo89MJCjmaeuN0uc7o++NV4MZsR2?=
 =?us-ascii?Q?8pmmUWXt0jvJAdH/A6iPoiAtGZByyYMVMVNO+sL3pQWUggucCqeyytvqpQ1L?=
 =?us-ascii?Q?2Z3TexM2hAK10IKoytZryOekUovX/07IjHw6ifOoU4DMlvxAB6JZ7wKjjWDv?=
 =?us-ascii?Q?zy3i06tKqFJzPni3xMJZBMJ8WbpVDuOdI1sTOdn242wnTiSWOH9mPLYfwQSN?=
 =?us-ascii?Q?SnkJ8GFh1X8rVstjWU4f63vx/PeOim484H9Id0sNuKExy2iRfA0gzn/X1F3u?=
 =?us-ascii?Q?Xe1oa2//Y05LzeMay78NLYKrAmq2S7Bx4GkSO6/oJLdcFnkwusbIpg0iZs3j?=
 =?us-ascii?Q?uJ7iM+bRJf5+sDSXzE6y9UHyPdtTyPWQJKqAjvwtZAJ9pdg/rjq12uSTakas?=
 =?us-ascii?Q?3O1BT5jsDkvOKLbpBdhpKsCsT0xMGkc6gLKyTj6U/nESbhgJNEF5Ef33f29s?=
 =?us-ascii?Q?UPzfX6j0/7+YiJCmDwCOQL0LZfvnOo9llfc7P7VJzmGLAhJ3+s5AYGfjyzLc?=
 =?us-ascii?Q?FrESJKxjx3RypMg6lB6Nkt3q23pV1BeakKXtBtFV5XrE7zGH9M5Qt6QnRawh?=
 =?us-ascii?Q?QONs3gL4u/nWNBiY61ap8K1G9sGD9G28lFywovndFbC7nPwie7UXMXZYRwal?=
 =?us-ascii?Q?gaFEvDi0I24zcEjDJzmewuUhBYJ+QoraO5BbDwjUTLBZGbAsrhG2yZbGj4oI?=
 =?us-ascii?Q?/dUa5PTlSfNlDRhpB0Wicey4RIWfBpr6aWEkQ9bynBIqjPnlpa2UrFSiYoeh?=
 =?us-ascii?Q?yv4mojxlf+hyquaFfun0D0qz662N67dsTWuqiISf82Mlh7gHEASR+fX/5iiP?=
 =?us-ascii?Q?K0Iv465J4T8euGY6VwchL9mXnmHvZMuiRr3FTYFNyAPJTOsYdq2aClyhDPD8?=
 =?us-ascii?Q?WmxPz3AJLYhPfmX/WI92POjAVz0wngaJIPix8CN3inBojg1RowJ/zCH/tnm4?=
 =?us-ascii?Q?tuolJZGUcMzfSsPMVXX4w0kpFlTKG73lUBQtPq1h0sNbq9w0cFpKo3w65Ef+?=
 =?us-ascii?Q?AIoT0Kj9bvZDGE9WUiYSbDCb+jKJuTuOmkXt8PDiYzqqHVIRZQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7DI0a7AYzahzobEiSRSHd/gF3I43wIJ2KT/QRBckvqma7Axi5qfZTR1wqGfg?=
 =?us-ascii?Q?ow5YA9JuP72mCjJRfVJ9DCnXUVnvKpv2cd6a2DzIDoOjLDTWPLztTbJTtGgQ?=
 =?us-ascii?Q?266p4Atcvrql+hPRLjUOXfIlVZOzbprlywUVDAOAAdSmalFbhkOtWhuFYJia?=
 =?us-ascii?Q?FCS1vd+evbNamoSDKmA0HSbY6zoj5efR26LzWefaEuNADSK8nhzHx3oLVF2U?=
 =?us-ascii?Q?LiUryiCiUOrA5U/sZtMW65VCyhMyU8iLKb00iMVro0tS/yDisM+q8dIOH1sn?=
 =?us-ascii?Q?zbtZGmtYPRLtZQf0/OyM/kvt6C43o0azHqesG6xLDnJ/rudsiQ4QmCU27len?=
 =?us-ascii?Q?NhDOnrBMSzgK0BdW7fFla12GjcSxjc3JZi5vfI0nqp4/lQ9x4xLhCTJDKuS5?=
 =?us-ascii?Q?fIqgkAC/Kb3tSGm8dUK1+ieBt+7cTgcvFW2xtzVUL5qVyb0sfMaDZXq2McSN?=
 =?us-ascii?Q?IyTCBIcGEwjTcMJwiWTDRNOMJQ4yAIYuGG3Nh8b1DQN0y50+UujGakqzw8w4?=
 =?us-ascii?Q?VJQN6X5nUCc+B2iKpLAKAXeJIF/5VOWxoCPk27NjAuvR1r5R+vVaCPOxgyhG?=
 =?us-ascii?Q?kIE6+QMbrQPA79nx6bR73CHzq+Ii5LpsKys0EgaMPYG/x2FcEDA6reMVFxL5?=
 =?us-ascii?Q?rJAbe+mOrfs0OrWNHfiATVbLnkgAaEBdTbwdI1tnzhWnBot43oRimZUoe9rd?=
 =?us-ascii?Q?2oOLUyUVqY+bJo70k8jeNkio3jilPC7+Wk8gDCsWbEisYEDVHKDumjVn+zc9?=
 =?us-ascii?Q?VQw0LQ7kDiUrvfjixvdEmSP+oGeZUw5dNX7fW5KxIe5LVaQ3iazvw/mcfWbr?=
 =?us-ascii?Q?bz58VDbwdt8VrekQBI8MV1ZCXeOqffuZb4f7jfqaYGZXYqOPZW8Zb8R790q1?=
 =?us-ascii?Q?HslJmm16smCh44OCYsPx8PtXQhOpHIxb5O1gjcFvkaVFZmpOa3xygb2ZtRsJ?=
 =?us-ascii?Q?2B12pmQ2OQk8fkjTeekM/rXBC9Q1RVWVHLAqmnUl/EbEUh6q+dy9wqPQKq+2?=
 =?us-ascii?Q?GPhrT0xWk09dTgM7fLU/DY3vSnOUX+Vizs4x908OtdwDlsZy/UTUvR2HR9Lm?=
 =?us-ascii?Q?F/0JSnukFRNeiWfon6ti65EnGhB0fZXk7KTIKICCsfbg9j7LD1hPibOZ31Rq?=
 =?us-ascii?Q?b7bzmjlofzcX3efkM1zAkmSuPh5Nhu2XP2CtHF2cQ4nVG7DZMoYfq8Ti1TQK?=
 =?us-ascii?Q?8zC6onsxVrJC9+Lx7Kmoq8gLRWcB4+k86zMTl+xh6vvBoZJDssfOnGt1nlTU?=
 =?us-ascii?Q?oqPEPKf7jziB7b9xiof9EEO5qD5f2/aNlEWBBtB+tiJHWcebkyDB8ze3kMbo?=
 =?us-ascii?Q?PoI8fainFSfwieySLVFci5dGNq4btzAxDnPV0BBGamZ84Vf4py830a84b7cM?=
 =?us-ascii?Q?fuVnhxsfvjWgszK2ViSZTYkkGCsvevAChyxYZtmrUvekSzugeXowK+isMxsR?=
 =?us-ascii?Q?W0m/5kDKTBdSSGehuL9Oi6kE7gfiu26XxtkdTHk6MY3RtZQBdBQUajOZFu6c?=
 =?us-ascii?Q?z6weNJbSCr3HY7tqgXRwWJPSS5hmYBgai58+nUYltf3t3Onp/q5KeUp22hVv?=
 =?us-ascii?Q?xyVcj+7dSsXx9kS/WYTUpryWaQWNztWF8O71oo/7byDPUIe73E8SoSybWa4Z?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6e5c47-89f4-4064-22a3-08dc9fe98574
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 07:34:09.4330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZS8Pz5IaeMtHaJgAvcX7pTUSLZjhRsFKxnlApF1qHOg5g/XZ+9gOuYL/PaQyppFIwbQvsoFt1KRpU4QEz2steR57t4C/M1zdD9yE10Luvio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Marcin Szycik
> Sent: Thursday, June 27, 2024 8:26 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; michal.swiatkowski@linux.intel.com
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 5/7] ice: Optimize switch r=
ecipe
> creation
>=20
> Currently when creating switch recipes, switch ID is always added as the =
first
> word in every recipe. There are only 5 words in a recipe, so one word is
> always wasted. This is also true for the last recipe, which stores result
> indexes (in case of chain recipes). Therefore the maximum usable length o=
f a
> chain recipe is 4 * 4 =3D 16 words. 4 words in a recipe, 4 recipes that c=
an be
> chained (using a 5th one for result indexes).
>=20
> Current max size chained recipe:
> 0: smmmm
> 1: smmmm
> 2: smmmm
> 3: smmmm
> 4: srrrr
>=20
> Where:
> s - switch ID
> m - regular match (e.g. ipv4 src addr, udp dst port, etc.) r - result ind=
ex
>=20
> Switch ID does not actually need to be present in every recipe, only in o=
ne of
> them (in case of chained recipe). This frees up to 8 extra words:
> 3 from recipes in the middle (because first recipe still needs to have sw=
itch
> ID), and 5 from one extra recipe (because now the last recipe also does n=
ot
> have switch ID, so it can chain 1 more recipe).
>=20
> Max size chained recipe after changes:
> 0: smmmm
> 1: Mmmmm
> 2: Mmmmm
> 3: Mmmmm
> 4: MMMMM
> 5: Rrrrr
>=20
> Extra usable words available after this change are highlighted with capit=
al
> letters.
>=20
> Changing how switch ID is added is not straightforward, because it's not =
a
> regular lookup. Its FV index and mask can't be determined based on protoc=
ol
> + offset pair read from package and instead need to be added manually.
>=20
> Additionally, change how result indexes are added. Currently they are alw=
ays
> inserted in a new recipe at the end. Example for 13 words, (with above
> optimization, switch ID being one of the words):
> 0: smmmm
> 1: mmmmm
> 2: mmmxx
> 3: rrrxx
>=20
> Where:
> x - unused word
>=20
> In this and some other cases, the result indexes can be moved just after =
last
> matches because there are unused words, saving one recipe. Example for 13
> words after both optimizations:
> 0: smmmm
> 1: mmmmm
> 2: mmmrr
>=20
> Note how one less result index is needed in this case, because the last r=
ecipe
> does not need to "link" to itself.
>=20
> There are cases when adding an additional recipe for result indexes canno=
t
> be avoided. In that cases result indexes are all put in the last recipe.
> Example for 14 words after both optimizations:
> 0: smmmm
> 1: mmmmm
> 2: mmmmx
> 3: rrrxx
>=20
> With these two changes, recipes/rules are more space efficient, allowing
> more to be created in total.
>=20
> Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>  .../ethernet/intel/ice/ice_protocol_type.h    |  22 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 525 +++++++-----------
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   2 +
>  3 files changed, 212 insertions(+), 337 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

