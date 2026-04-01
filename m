Return-Path: <netdev+bounces-273878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJNpEuCWzGkSUQYAu9opvQ
	(envelope-from <netdev+bounces-273878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:54:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB71374897
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D30B3016EE6
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 03:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14536375F99;
	Wed,  1 Apr 2026 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzEmQrXP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D630F7FB;
	Wed,  1 Apr 2026 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775015643; cv=fail; b=qker/Dpfs99yiJkHO8grUfl3w7BQowz42f0CGZ8gFR+Vbr/DC/F6z68E8FSfk+h0jMp2mlaJGwiypCHn6XptUB46O0Z8rbct8+xLx7NGAg9kHDUZzhBFHJytqJGjn8qapP6NxpfKxHMK9YZJbkzdUNPmRhcHOFRVkjTA3doJQUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775015643; c=relaxed/simple;
	bh=YEqIGpoE6UHxmGR/+xs4keg48vToAUwz0ebgfXpsSAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p1uq3Hg1jhLuyb7QAWkY6D0cX0+iREe2zQqfRvVxrGefYU1v5EH2NL0rLSKHq2fSEaj3EC2H3GHbmWbvWbEWZNz+6w7qfrYVZPBwHs5L8kD+pwEq66J86ShNsOq/MRSO/ex3yvYSUjlPT0ypUOIhrrJmRKxfspBrqZq8FyQHX6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzEmQrXP; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775015642; x=1806551642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YEqIGpoE6UHxmGR/+xs4keg48vToAUwz0ebgfXpsSAU=;
  b=mzEmQrXPgL+6Tu3OPpnzaOVzpw1DEZifOzxir5GNsU/bYR6dh+b9q5b5
   vFmXHXxyQFPaJOuPQKuj8ClkLG8cqQXUgzt6+hW0qKPQ1uy/UZqRPopkW
   2zoRPti1+Z0thalKrzvVveCXh3zquvaRHPDOSDwPeYXw7ddn6EICEpWqy
   25GG8tnWmZyxoUBLBXmgJNDSJ2TGMYX1gHR9IiTJMeEkSvRMx/DTbJXCf
   Lb1jdONw3siam5MeNpAU65DvX+g5oUgH5DWZH2sfA0iixhcWyWwJF/v8m
   E18FbwE3ubYQ1bSxrQJ54P3CY0lWvYMxZHUuaLsgOdpIVLcd0yJUvSDIT
   A==;
X-CSE-ConnectionGUID: +po5SRSvRv6V709mS7xQGw==
X-CSE-MsgGUID: V7P1sPsRS0mDbUVcl8i0oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79931542"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79931542"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 20:54:01 -0700
X-CSE-ConnectionGUID: JSq82E4QQP+H7mAqlUbqjg==
X-CSE-MsgGUID: 1z92HqpLTXqXz3dB0L2K1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223251741"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 20:54:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 20:54:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 20:54:00 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 20:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGzQAqJYngVe58Fcnl4lMJk6VP674ub239kxqPoNG1u7A6saIly5pAySFlpnJO1kTszd3bLEmfAlXAcAA7vyWTa/ZyKxnCqNJC0lICox/0vSVjgJFiKOJ29gtp74sRVl8t3mBAPlcAN/PZj0tvCFPjNNsCofNzfOdmiLD5/cwyubPWcpNGU5ZRx3aAgh2OvsdACcl7kuI2mIw7+4MY9BvuCyd1BkaiftgLCTDW1phgRFarj7+E6EhK3g2ScWdpmEMc6tq71XvxyXbbTciJifML3sLxoNbabeQXzeVbHxSvhgD1zDEPwSK0FEwnNbMNRg/thvWj9Uog9+8xRBvuRR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1DCnLVPt4B2sa63Kd8ZhGRMiHtabrHxj1tXEetI8RE=;
 b=R7PSkB+sg/wrJ/181cxH/YObcOjWf7Lb1nXBKBR3Pxtl24R6ZWUanKo3yMPLSaXWym9nrg6KOJjDlbDUOlh6TAaa/eEFcPL2W9VocPNvyDozxvdpCu8EcVVAy5BdujKjehOvd9ol1k5ZWDq9FjJv7RkzD+pQFiblnjQejIzkp6nZJUiY41XdRvx/oU32U6gJU61ytffSerVDRQY3Ua0oCjfQKKphoNE62kiHgWlJt4L5FbZNwYZn9iy+HBJNiXcBONQYsCgykodcxgNUL5Bcbkl3GzwKHBQY73IJHTJIhSpIiLwSlajzPjqO8VxZbcdXrFPeG5lRNJ7EAaeCqMc+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA4PR11MB9443.namprd11.prod.outlook.com (2603:10b6:208:55e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 1 Apr
 2026 03:53:57 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 03:53:57 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Byungchul Park <byungchul@sk.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel_team@skhynix.com" <kernel_team@skhynix.com>, "harry.yoo@oracle.com"
	<harry.yoo@oracle.com>, "david@redhat.com" <david@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>, "toke@redhat.com"
	<toke@redhat.com>, "asml.silence@gmail.com" <asml.silence@gmail.com>,
	"almasrymina@google.com" <almasrymina@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [RESEND PATCH] ice: access @pp through
 netmem_desc instead of page
Thread-Topic: [Intel-wired-lan] [RESEND PATCH] ice: access @pp through
 netmem_desc instead of page
Thread-Index: AQHcpVGfBIwfT73TokmiNYB4s0sl7rXJy4GA
Date: Wed, 1 Apr 2026 03:53:57 +0000
Message-ID: <LV1PR11MB879056452355C9006143A8629050A@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260224053546.62757-1-byungchul@sk.com>
In-Reply-To: <20260224053546.62757-1-byungchul@sk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA4PR11MB9443:EE_
x-ms-office365-filtering-correlation-id: 0d58f489-6e78-4c06-bf73-08de8fa24d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: PttR8qJdnQnYD1LTs6taH4stmhwW9Jrdrws7qthnW6cC1bGfeG4+VklJz+pj0eGUjfl5f+aiuo29G4Hg0dEmdZH+ohIQr509jF5vnyw/TGMiPef+oU/CEotntnVnGdwpy8sNuS+gePCHjnQBZn6ymQ3H7tg3tuWh8D/K687Z5y5iysi+1++AR9aDPmi9uWKGD/IiKTq+gkss42w1mfRlbkZlgM1rGppRw9yNBTAMqWLGMoah9tV4d5BNZxCfmLv68doDJaY35dypdf7E2Juh4pjr4h8+fU4Lfwa3TWhHbieavIuSbwjeAOmNQKgq4uIVCDzHsNxeyoxBsb+zZ9vY/CY2QGkmJ/0QH0qo3OAWEYuLCQf7W/EQKwv3DfFzwBJbBrpC3p1OSmG4LpXpfFIVxWzykhZRWkvMY0Z3ROi/183gs4HXK0AZiNxOuVvPRnoRIuEvymYI+a3rVPyFUAeYbh8wBXgbuFMf9OhpQA7S6I/g0mU06GunIQxCGPS2iZBHmFEfdV1djnRQ8M56b4JBMXvdRXpRWP+vRghiU/InkeRs5JW6yO/b2JscWfayvckxOr7moRQH+ykTSmxmBHP2lfvOlBg01gE1KtorOyl4auXz6CowFbCRKlALVsd4/Lj1vcEP/xOiP3oBwCwBU29ydWrEc19AdtUHnkcLH5v3cOuja9QSCaCsPy6SDORaAa7YeDXA5Ax5cp7OSXmkV79qzkdqxJgIMU/Rotk5LD9uXq/2kzbHtg8OBR28he+Wcdu2Yn4R1xi5+rIsCG1fj1FJThk7dkoZkrls7qoRfUQKMTQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i322HZXyCew7MkpWIAXM2jASpvylxAQrNtJtyDFr28TXCxvr2OqxZBYjoBzk?=
 =?us-ascii?Q?WEzI2wUWdulcKEl2MvNk0kPJ9zcjmkfFBnTsS7Vu0/QKagqz5Gzfr+7jsizm?=
 =?us-ascii?Q?X9T82SO/r1NaY0q4OJuDYqYHjqJvv0HvE0HJnZt1p1YMV5J2aiAqvOhugZ54?=
 =?us-ascii?Q?NaBHnyzzFXbnRAZsD3mSv9DS3YcovWZMBqGCcecIAccwQqw61o6iYRZzuIOn?=
 =?us-ascii?Q?1T6kB4fjBkEIYfbmbETS2/FFhuVcifGTrCQOcMv2KU5N8MMgcgPXRj62lTmy?=
 =?us-ascii?Q?DfL39CLHUuoL49CcBgfM0usEk5dV9r8MaNaR7i9qtRJxhGkJYmoJVArDiaRd?=
 =?us-ascii?Q?VhNHPitTqMlyJH7xIJyvGsxl6rPliUAXQgASjY4XBnhhS4LOt6FVBy9MVLi4?=
 =?us-ascii?Q?pe+esSCIZePzmaZBPy1T3Pk1RLNJrbDp9gDt//WFLxraYfsHPwgeQq+st6Q/?=
 =?us-ascii?Q?cCk75TnyzKxYgobdQe4wFbhGYYXDu+epSQ2+EOiFHi5Bual8GjcCEd7oNlc+?=
 =?us-ascii?Q?MUfYOwkzsE66ZUj1FNBIShW6cvTLsdy54B1WASrQolODZX3OK20Vffgprm9H?=
 =?us-ascii?Q?Mu/C1M4ZeT/isboaYg4ADNW8HjrNpkPVXgWHzJ2LbC5QiIW+FsStaKBZGGBB?=
 =?us-ascii?Q?9/uXF5btN9wI9QiqMquhT7FJ8Ab4xkDPMt0oZ6IzP7ysrgaSJQ6KTTfig1L1?=
 =?us-ascii?Q?00qjR3g2ivicb5geHvbHXc+loxHOAzN8VTAlHndHifj9imiA5FsqH9maf0ms?=
 =?us-ascii?Q?TzGSesEJcHsOWFFlNMV3DOoxfyMpK5ZAfL+Rk5Oo2WpMVJ3kZhHtoUIolHsN?=
 =?us-ascii?Q?PuqvnzkA2tTqIpD8WvbqJaAajdKfJhajO+OxxKeAvywM2D5xyn5oJZxC509V?=
 =?us-ascii?Q?wsHlwoyWLCIHhhhNkKdWe9Cyn3gXmK2f+40XGxIwUlkWc+x/6KJB+8ZpEtpY?=
 =?us-ascii?Q?twTzIxx9z51y65ozEFiT+gRAaMc+U1Z8O48RqJ5dbLUYxlbohMOrvc8v7IO1?=
 =?us-ascii?Q?NKSO/KmbpSj4Cx2IXq0KYXSKUOau8qkbOfP5FLcqySwXDU1jXnsEkh5Bqf/t?=
 =?us-ascii?Q?BwYM/UVHSNylX2JyRK/JJi3s0dAh1SmSwliKUQRj36RkcisZ0K2nYzxQcItj?=
 =?us-ascii?Q?/JWAP+7wEd+HUf4l10dkWjcT8GmWIL1EDEhbYgO4N+KxNh6H67e2mG/pHCJN?=
 =?us-ascii?Q?yw85ZUNXLGdVdPyEEPMmHhVvpXoZrXXKU+VGL7vzbXu7ttCsZibE9Y5UGSdp?=
 =?us-ascii?Q?K/f91z/FYoWDnwZ2ezxv+s99N+XLhuwvNmpAbPGFAXYJgg7if+oPh4kGIV6k?=
 =?us-ascii?Q?K5n/q1uXlDx09uQ9MK/24cSDjT6mOH8T8VMsGi5C2Sdoi6ECe5rQPfjx/2/b?=
 =?us-ascii?Q?6EeJkPILK0XNHFoarANjfTZ+LcPitleX+F8Aei7j9nwAxkkMTIBSsgteISdL?=
 =?us-ascii?Q?g0ZRd8saHKtralLyh6Bt9TOKA3h3j8+MU2PpzvgzVUmM0NxhULcmtarKFQzd?=
 =?us-ascii?Q?u6lJLS/mtWG7y572ag0TIW5O5yCjWpp/3HXzsAGc2RFhdr7HqwZTdgehDMFv?=
 =?us-ascii?Q?sPSDz4Qto5qHezIUfb8YUn9Bjk2ZczngovUBg6Gb0ShzkakaAbsyobNNtuYO?=
 =?us-ascii?Q?x8K661z6//0FUhuKXzFDcOZfKr128ST+uKPAuZH2qYu2/ptO7B3WpgtsMeld?=
 =?us-ascii?Q?PkBQ/X+lcejwNCcBaAy3wf4Rhapp8n3AFptCOCzyrlUpqKZYoOUpThuZLoPc?=
 =?us-ascii?Q?sCHPL20Ixw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f11ERPcGc5eCWV2+IgEV1dzjRjomnz53Xsv7fttQgnBoENtoNf5w9Zqx84FpBNnXWN++bPQg1zoOH4THtK5DMXtoumGO0yoexFOPKhGG2UmUVxbnmvnN5MJGzdE6lbdxSkQZWNgXCzeMDCm0ipk0bjmlgjg0ql/G35P2ZK6pzMJyoCPQQbIvUtSNCNQ1xTs1vXAVhZ3X7vL8IhiGvzM5UoVmBkUA8yLnaqub7wTClW/BnKeKrjGHdTi1o292I1eL6uxyOI7A7Es/lXNLuZJ4j5MeaMCvdyhUVVsQqNPaRTSAW3EU+kqn8J/r1V+joeynhGCXblVaBWElMVqtkhKzIg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d58f489-6e78-4c06-bf73-08de8fa24d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 03:53:57.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mX/F8zDoXx0z3eBtZ0QebMKS0M9wKAmJCMDCGmfLwfWPa72XW0i7YONGlDKI+MpYh+4aeGms1Pi/cfQfoeYJ9O1Dz37qy1Gb6KcJObv5K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9443
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273878-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,redhat.com,infradead.org,gmail.com,google.com,intel.com,lunn.ch,davemloft.net,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9EB71374897
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of B=
yungchul Park
> Sent: Monday, February 23, 2026 9:36 PM
> To: netdev@vger.kernel.org; kuba@kernel.org
> Cc: linux-kernel@vger.kernel.org; kernel_team@skhynix.com; harry.yoo@orac=
le.com; david@redhat.com; willy@infradead.org; toke@redhat.com; asml.silenc=
e@gmail.com; almasrymina@google.com; Nguyen, > Anthony L <anthony.l.nguyen@=
intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netd=
ev@lunn.ch; davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; in=
tel-wired-
> lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [RESEND PATCH] ice: access @pp through netmem_=
desc instead of page
>=20
> To eliminate the use of struct page in page pool, the page pool users sho=
uld use netmem descriptor and APIs instead.
>=20
> Make ice driver access @pp through netmem_desc instead of page.
>=20
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

