Return-Path: <netdev+bounces-293674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKSYHpNgHWojZwkAu9opvQ
	(envelope-from <netdev+bounces-293674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:36:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D261D971
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C2630F8B59
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE039B49D;
	Mon,  1 Jun 2026 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0gwPxHe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AE38B12C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308578; cv=fail; b=rIxMMAZRTabqHpbUg8PCQFqDsJlkXeCp7YvEgydvmfaahhuJbkZIDvScGgicN/xgRJQLBis0BEeBEtQsn3MiaEmvNbWz0cwEwqatzvu7Q1/zeJ+SryQAsed6k4A4szp+vqYxTE07LXBoeOchmWLiJ3hV1NJDuKz0PUuyIFJOlEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308578; c=relaxed/simple;
	bh=oCvltp2r0yJqfg8+paTzKCrTw8dOnAaxGfGm9A6V3yQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ciCIwzI7huJ4t1X8NZCJUtImVxaMTAFwEj4KB+u7dAL/Ns68G7Zw/pmuv/HGeOHV9NRFMTAKwsP9y4Cq09mXO7blmajhbT6jVFdGyW/H+HhRzJRcEvzG8UBlD2inoGGfEKTdJsg8wET+3KAgq80L3X75wcIgxANJ9zSza9IXD5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0gwPxHe; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780308569; x=1811844569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oCvltp2r0yJqfg8+paTzKCrTw8dOnAaxGfGm9A6V3yQ=;
  b=J0gwPxHekDF17PQIWnjurM8pKwRgZfIvfHq1Ci+/w7jwNne0VzB/nDx4
   EsWIhs6pK+DIi6X4vowVQfiJLn63fCC7/kqcLfi3ZigZ9/kzzvxh4fnce
   fH6tDv0tsCL2SN4vI8pwch3hmHAHfToIf8z27sMl6fe1QMJaBG79Rx1nS
   Fp0RnwctgtkGTJ8mMf8g/REUVifTR26TQnHu+DivKXMJsmXdNZWBN4BDp
   qrkAQXTpvQNBelu6k8lcRy5HrC7wRRuWZsRI6L+mLkxDUBaCuBBsYy/Hs
   56EhjdgsvcyTWOx+w9y/aiWyCrNDZWAIUcYtmNiTd0Euxk8OrsN5/7SGU
   Q==;
X-CSE-ConnectionGUID: 2IQ6i1xnQ7eh4MIkhJBhAQ==
X-CSE-MsgGUID: bspo3nuVSRig8ja+MxJgPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84952314"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="84952314"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 03:09:28 -0700
X-CSE-ConnectionGUID: BUQY0sDJTYKsBpIxiCBt3A==
X-CSE-MsgGUID: Wp5eJ1RZSrimkLO4Aw7pWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="247815110"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 03:09:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 03:09:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 03:09:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 03:09:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLcj6nURzAOoUOa4tnUGxRT78+e+VTWzFw1qzITHvw8a0vlHoUIDRSplBwYTEybBlbxE7MBYSr/yJrRvUJo2sVdZ6NMZAfPjt0BEkT+X+/ZZbBGhw3EqNCl7/RcfuEDTkMU29hT3N1pl2w1whVdBdyf4Pyc6U9kvQUpfe6Yy2xIkFDvwkCk/hz1NVfxf4CWR8j/0uCvkZBLSmTsFX4iLqjJmtRO9WFdDlT/cFHt4bE6bHiaVXqSSt5FsbJSTMCdUGQYngTfoQea1v+NXryKkEUyeMmQe20riTajf38Ym6rK1TZ7632RnnzMw3uTuSSGxafdkcs/ggZE+dV3N5zFsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8KR38ajSNSo6zIGSA0cVmLPaJMS/ghp+uJ9qaQherw=;
 b=ThfUqBcoHw756RGz8Srh86A925bHU4KksRLKIh0Y7uRRvv/ZwRrk1FvXduLgPDnb8J4f00P4GkLEa0ttufOdNmr8m8LY+bIBfz+6Ob1oQOdBot0MdVLLo1jmgoFlA59PF+Yz6jI0B7Uz0U37kyYOF3HLeD+55QCsMhmqaKUbhEB7UJY50jkoSGclW6FcdtqGMe9U7x4snPyINPn5gbYS2WB51xs98BABynThVEgKZHLun3LAkf8lI5x9j7wZI4T0jKbaxx3CWCYrXkAu1NTkdidIan2c2UR2YFHH4dsRCpDRnUfNLzZCH74D2zVv76ru7cB4naWMStgGIu1E7ItFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LVXPR11MB9732.namprd11.prod.outlook.com (2603:10b6:408:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 10:09:24 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 10:09:24 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "Keller, Jacob E" <jacob.e.keller@intel.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, Ingo Molnar <mingo@kernel.org>, Joe Damato
	<joe@dama.to>, Breno Leitao <leitao@debian.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: RE: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce
 callbacks for AER recovery
Thread-Topic: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce
 callbacks for AER recovery
Thread-Index: AQHc8Ze5MGzF2VeuykKv6d+uDATdtrYpec4g
Date: Mon, 1 Jun 2026 10:09:24 +0000
Message-ID: <IA3PR11MB8986350DE4363EB91F97F1ECE5152@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
 <20260601072221.2952-5-jiawenwu@trustnetic.com>
In-Reply-To: <20260601072221.2952-5-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LVXPR11MB9732:EE_
x-ms-office365-filtering-correlation-id: 10b5796a-1e78-401d-42bb-08debfc5db5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: mlO0ltEg61pcp8GC32eW+1ChU5ESnnxr2XeMfu94eWls1+xfAm+bh3FwusdmqjPqlyzXTX6szVHr+EbrBqnERpIqJC2oKQwtlKOgrI2juiA7i3IP36nIaln4eEoQTyylzuo6zV52R6FHbPC42oxuT1ivW9WNTbsQ8B3DRyG1fatCmmap0v6lB2L0xLaHIGAfKhWTir2BOoWymeNFtICTWDJaNZ+MfmDNO4DQQ1S5v5i+L9Bx/Fwb2mYhKuAmCGhuFquVbdPvYIo8nd62doy/xw/w0w7gE81jj1WBjCg3cKNX6JfMfx7iMKhYjZiDG9Y4pAIJ3dkasTHdaldxp+YWSrGSXFmrRY/jD2nkdFKBkhdTmPMh+p8KSCcYzS0Q57SuYZ+3CbuW23fxgNhpvmI3BBvrlECl5qf5173c4exSViB37Z7Yu6Qym/DsntF9QOgeoy78VegTUi5Tpro3sBcmeDnBd9Co92tYhjAAxQVhEzX4BDQioo8WoEgBW9N2X5suDm9jRTRuPcgRx9mX0FJEYIq4K29feKwUH8ZpLtqr+kDyyzjj1g7HvHHjQ/R/HhYLNRz5TpO5iO4vjJA5OX7kFRqQzHPsac5m7LGTXicgg6LX77DnOEErbbBNpEhrg0eh8R6wzu5xgvA2TgeWMC50Rr8Z/D60FjtSPyjcy623TwX3NnKT7iww2LmfgC1YzPneDBXadCK3kEQ2KSfZh23qojZhDj+X3lgDyviaJ1/etraPc+14HzhmAMuY6UX6L+IL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NPVR/XoXvJG9et97Kf1af0qhLVq+3PC5I7zRzEG9yRMQYzBM3ruJRZ1PaD?=
 =?iso-8859-1?Q?b0R1+rY6wqz6CiFU5ppdY+BGoI6rSlB1whEjIyuc2f5q45zzjeD4kwlLP6?=
 =?iso-8859-1?Q?BX/WvgEqPmIIwTRDpxExOgNDIeb669QXtARWETITB4aJZW40leV1Pm9qL3?=
 =?iso-8859-1?Q?vpuW/ZHzCQbSsaEakSLbiq53nFRuOww0oAcj2x0JRDZjn0H7AVyrouEIrM?=
 =?iso-8859-1?Q?zDxO1ZN3sCebc55NQEZNJOKEFy1uXPIYngOkryoyQt3TCPLKveE1/m8sLE?=
 =?iso-8859-1?Q?Py2shtvLefQKy0lkCnvFpsPZT3lT457zoUR9r1yD+WIBI/ep6HRvws0XOX?=
 =?iso-8859-1?Q?qlSCDJD0y7rIo0s/odM3fEms+En7+Wg/ucseEtFLMC86GVWnhfeuyK6wx7?=
 =?iso-8859-1?Q?gXom1U/ECQkpyIU7ZpBdzXH+G9QIvukfwHZo31FE/C7OZnp8JGYC9gzgZ/?=
 =?iso-8859-1?Q?3nGVBxjzWjn2pMmTg3FUxkfdQRDeGK7QK2fD42W7lXcsAc37ma+AZUCp80?=
 =?iso-8859-1?Q?MfuMlr7lKhawWq7BJuSjNeknQDn3VTYteraxp0AXsMfRpiOfL7LAtl0qbK?=
 =?iso-8859-1?Q?5yVr4v6x9oMJQ2RDzqYe/bTPD5X6FPNkfj91ywi6QcUUNeFdG2hT/BMzvv?=
 =?iso-8859-1?Q?/qFvv4uUpOH6olocpeoYRgTga3dR5BWNExjLfDTxw7yJ2GJGBRxtbtVDkQ?=
 =?iso-8859-1?Q?NxUOkfhuoFePXMjB87wlRxT1x6J+gxmUsDwfHsbNt2HsMfOaFARupAEh3X?=
 =?iso-8859-1?Q?0eYXg2V1/WP7RJ7FBZWCOfkDndzhqhjkFQKSganWAlguosN4OlkvqgWSjG?=
 =?iso-8859-1?Q?3wwwOVLQSHmzulpOHnrdiQaSHpeKEPVZm0Zs3XavN0E0uRyPz0bRR3G+nt?=
 =?iso-8859-1?Q?6QC+9PBEbcXJyVujLDWRVwWyF2S2VRZaVJgfjbfqD2e/QC4uxhsasBxOwj?=
 =?iso-8859-1?Q?IC8ZCjAv7yv7f0QX/4W1r1PCJ+//yjRadBvKtHfOdK4niO4Dqg4q/s0tz/?=
 =?iso-8859-1?Q?dOKXxrR6fBzF2Fj8TItLqeCVvejVIuULpJ8VTuqH64QqtvoIn6uB401oUG?=
 =?iso-8859-1?Q?bQjcZQeHYbPkI+km/ERg+teLdolziKmwN2oBZewMelcqd59+yaFlD6DClK?=
 =?iso-8859-1?Q?ipdP/xbLoTa8tw0R1agZUCV0ppHC5a4JGevtJ+dw4HxwJhlNHjhr7cIhsh?=
 =?iso-8859-1?Q?BeNWtEpSbZ/MJnGLdGgMQMFe3yk6WBveLH46WsOvCpA6wDIxTYth6KizPW?=
 =?iso-8859-1?Q?ROEYGw0HXPg06xAPRNRLabdjmFkCjacMsQpCZY0k+r5bdM37DDKnzHsi4h?=
 =?iso-8859-1?Q?6KNxW7Jp4OtsT5cOKUhwZkKXlRcMkpBoVCb7EPGpmU8son1KD+pnYijELA?=
 =?iso-8859-1?Q?Bmwf7XqL+WxIZ++RxzQdTmk7VB0jS8LK6rNEnKqiDJVwrTwoey7GtvXck5?=
 =?iso-8859-1?Q?WHOT16mq1Ch41OdpNlahOwgPTgIUGWjxzK3KF/1Rr5gaowmJj3G12r7bMT?=
 =?iso-8859-1?Q?bJ2QamGb94j5VaaT2DOj38P0tFBjcnK7ttvwkNF+DiAuybPicRW/tHCYpv?=
 =?iso-8859-1?Q?zVP161etdak6S7nzO9CDZEn09OjR7XMTVEo2/PxcTMF5Qvgwgb3dQEdC0W?=
 =?iso-8859-1?Q?BAHWCDshwiMSTRolJb6GYP0umPUwqjWnnelstTUWAUw31J6NkdJgDCtR1o?=
 =?iso-8859-1?Q?SYXoDKY5pvZMKatpeXLD2CxlHRlnuBsvaQBGHD+YkEDYs36aQebKIz4eeM?=
 =?iso-8859-1?Q?HpN0U4MYrnicHS89BeGV9Ump60sT+IHL57tsWYBagXXgQx+HL3BKCKUqzn?=
 =?iso-8859-1?Q?Wx7p5zuls2jk9bkMc1vDh2rvWv9o4z8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i0Zhhqln55y6SFe3tNIwwqoKI+qiTIQAVgvkJObeKm3kOlqzvmziHSaIV0MtPocLbbU0vucjBlwGmcdRpsGhHx9sQRchQ/ut0WB0H2adEf5Lpa3dpkmR9TgHsHV2iv5s2Fi/ZkQJeESc+DfnoxvKeSUixoO31wKU+SmhkZFIXcU1Nc/86MNjaoDLHNHztwbww2/UlLS9fakP9ZdyqeNOZDDoILBMWrtM8K4MPtCMu0OwxN8qFVBwNs83KB27aNN04L7YaOGEH9xM6Uys1gEfn2bMvh7h8DGJPAWQ/cu6S2nqm197pvn5IakscNK9yZmwyWjxGBh68xENIQ/PJWTTDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b5796a-1e78-401d-42bb-08debfc5db5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 10:09:24.2467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2q0NnL5qWBi3QeAhikYE4Bw7hGQI3+rhiaNOOL2pYP1rO1l7sGG44TOEoGY44cWwXxlqDJ9wld8yui5btMe//FiT2i0243rYMUSCKw8ob4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9732
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293674-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D03D261D971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Monday, June 1, 2026 9:22 AM
> To: netdev@vger.kernel.org
> Cc: Mengyuan Lou <mengyuanlou@net-swift.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Simon Horman <horms@kernel.org>;
> Kees Cook <kees@kernel.org>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Ingo Molnar <mingo@kernel.org>; Joe Damato
> <joe@dama.to>; Breno Leitao <leitao@debian.org>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com>; Johannes Berg
> <johannes@sipsolutions.net>; Fabio Baltieri
> <fabio.baltieri@gmail.com>; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce
> callbacks for AER recovery
>=20
> Introduce device-specific soft quiesce callbacks for ngbe and txgbe to
> provide a lightweight shutdown path during PCI error recovery. It
> avoids MMIO-dependent operations in PCI error status, for the later
> implementation of PCIe error callback function in libwx.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 23 +++++++++++++++++++
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 ++++++++++++++++++
>  3 files changed, 46 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index a8b4e84787f4..1b25a52188f7 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1409,6 +1409,7 @@ struct wx {
>  	void (*configure_fdir)(struct wx *wx);
>  	int (*setup_tc)(struct net_device *netdev, u8 tc);
>  	void (*do_reset)(struct net_device *netdev, bool reinit);
> +	void (*soft_quiesce)(struct wx *wx);
>  	int (*ptp_setup_sdp)(struct wx *wx);
>  	void (*set_num_queues)(struct wx *wx);
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 3dc8342dd3a7..2484d3177034 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -47,6 +47,28 @@ static const struct pci_device_id ngbe_pci_tbl[] =3D
> {
>  	{ }
>  };
>=20
> +static void ngbe_soft_quiesce(struct wx *wx) {
> +	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> +		return;
> +
> +	wx_ptp_stop(wx);
> +	phylink_stop(wx->phylink);
> +	pci_clear_master(wx->pdev);
> +	wx_napi_disable_all(wx);
> +
> +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	timer_delete_sync(&wx->service_timer);
Can you exlplain how do you handle service_task work item that was ALREADY =
QUEUED before
timer_delete_sync()? Because they are NOT cancelled here.

> +
> +	wx_clean_all_tx_rings(wx);
> +	wx_clean_all_rx_rings(wx);
> +
> +	wx_free_irq(wx);
> +	wx_free_isb_resources(wx);
> +	wx_free_resources(wx);
> +	phylink_disconnect_phy(wx->phylink);
> +}

...

>  /**
>   *  txgbe_init_type_code - Initialize the shared code
>   *  @wx: pointer to hardware structure
> @@ -412,6 +433,7 @@ static int txgbe_sw_init(struct wx *wx)
>=20
>  	wx->setup_tc =3D txgbe_setup_tc;
>  	wx->do_reset =3D txgbe_do_reset;
> +	wx->soft_quiesce =3D txgbe_soft_quiesce;
>  	set_bit(0, &wx->fwd_bitmask);
>=20
>  	switch (wx->mac.type) {
> --
> 2.51.0


