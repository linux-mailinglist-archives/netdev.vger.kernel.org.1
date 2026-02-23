Return-Path: <netdev+bounces-260130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG+MHtGLnGl8JQQAu9opvQ
	(envelope-from <netdev+bounces-260130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:18:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E317A95D
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11EC1306A804
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B47330662;
	Mon, 23 Feb 2026 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7Kn65SP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1571C8604;
	Mon, 23 Feb 2026 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867019; cv=fail; b=mKqdAiYFuh5E78Sh5dlEM5aItW+Dav4bjNKhucVDv4OyGxTV6SrP+TtiWMGEcPQZrdAlmUYuFU56P2J9WlfGEu+MgbAe+rHLj9yCtsmvyUlBe2BH2HpqE9l4ZJh8hj10L2EP2gK8qEnZ9MkAH1FyfX6rE+EqeUjfkiyXTZF+JJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867019; c=relaxed/simple;
	bh=RFo/f9FL6F/1FYsRyqeoVpZZ3W0FuEvSjKJ8nWocIPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DVW5BxBEFgG3Sk3LjtOYDwKQ5ZJNpAGdtFpu1pQf2R+GaBtJ3fNej2kBBOH34PAf8WWMkCPVxDO/ZgxK5fSeHKSmwJX2zNjloKJR0OChchtWhX7u5ih+9Dbo9ayYDgNO3mXVMUXsY7Ct1oAp+fFcFdSJcEtcaWli4oP8adzp7CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7Kn65SP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771867017; x=1803403017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RFo/f9FL6F/1FYsRyqeoVpZZ3W0FuEvSjKJ8nWocIPI=;
  b=a7Kn65SPaA3k7IgE3JTu8sSqV2beZapK3nx0pXdJ2YOo/lNhsB+U8ska
   cHMqEZG/9pL4055Jk9/SjFVIjcuHRyHIFJbPiqw7/n6ciBQMVMvH9NGck
   DxdMMWiybMG32EBR+mv8dlb+NPovoSQCMUJ8mQitqX16DJtZrVMzPDWIO
   dNR5hUmAMrFLpMbdD0yUW8Rjk6GeI6XW1yI2YcwI7sdAst/O/yRJbbdt9
   BwsA7OUlf4YO1IQ3xQVHRSVVENFLaTHZCeOHv9mr3AEX1oIqSPKoTX0Ux
   QMIwfcGw8w6Ve3k9vaLeliC9jjuLZX+eponQMJWOGNFIqMiriiYO1qjyX
   w==;
X-CSE-ConnectionGUID: Lf1+qX1UTma03hXtU/u00A==
X-CSE-MsgGUID: kEa+SFTqTbCmHTT+lfFVjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83579411"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="83579411"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:16:56 -0800
X-CSE-ConnectionGUID: IHKq2VSZSleMv7DRsGCjpA==
X-CSE-MsgGUID: rFF/UUYEQsKx+lYOupCKdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214852557"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:16:56 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:16:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 09:16:55 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:16:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEkaVIK6siqPXtLdEWSoqNP19O6ACp9cS5zrPsl28IA6p4Y1BL9Xf7AefWaEfJT3mZObIYMyvuvFQnyF0nmGxbBAZ1Se4SEZOj8mV6kNK7/2aiZWw63P49XYbE29mAXlF5ANtiJJIi5VFz+8GXcwvCqNYkPND124SJcx2yxx1eQAzJbizACvdIz2lGwn2/Ue+9ev5vL/6Mpsx91UfH0LMQ2E9A7LsKjWHLhC4EzdgjasKbqC4vuPoJW0GQVuu9RR2RDUluO32QV/KBGlEnD0PMLx5q7WR4w6Nf0mYzrzldh9qv7AdNV0UdFFt3k6hBGuYGT2K7qO5F+TUcakNBKD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFo/f9FL6F/1FYsRyqeoVpZZ3W0FuEvSjKJ8nWocIPI=;
 b=oOIegVlcoJ/S6rRFZTjtur84iH0RNsIbJlWaSwJknVm8qBYyN6Hl+ZJdioEPRso9003qBFeXW2TVscdHCWfGcUesRL6N3Nzp6rq18PChom4a5uEzHAlXTT3NL30mKhVYhTqZ0Z7CYLzZnZg1eIM5NItwfgdySQGTlsxUpYqcdJhECHhKZKL1ObGx7boV5xIRNNVJgR5wXWUOeR4MlI5CXpwfMu9vr3/NbYhzBG644XUlg6ClLdTu/o3fNFBcxLW5hmxTiM3Npc69ykrgHozWVzlhfbJbDH6SCZ91JPt3bAUdTC9+s93R4xdnYhnNp9JfCWs/aXwq7SZgBNhLjpw/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 17:16:51 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 17:16:49 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, "Wochtman, Natalia"
	<natalia.wochtman@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 10/15] idpf: make mbx_task
 queueing and cancelling more consistent
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 10/15] idpf: make mbx_task
 queueing and cancelling more consistent
Thread-Index: AQHcV8kR5KG3oqMbJkOytpGDc7Y1iLWRIBnw
Date: Mon, 23 Feb 2026 17:16:49 +0000
Message-ID: <SJ1PR11MB6297A54B319C5EDE06795DF29B77A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-11-larysa.zaremba@intel.com>
In-Reply-To: <20251117134912.18566-11-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SA1PR11MB6688:EE_
x-ms-office365-filtering-correlation-id: 5fc13465-2e96-4f72-d831-08de72ff5492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?CyMt0CKbTTGYZnNyxI0mRAtGSXp7hfB3nXPy/XOAzSoQEG8yOSWqJrdQJVDO?=
 =?us-ascii?Q?d7yeII9J+1oOcmRopc/s8VZWjqh2OHnG+Y51imkdtquxT3lTLmXyIoupL4KE?=
 =?us-ascii?Q?nBXudxE1ZaUeUIIph2wU3ddgVCFgVvl2LEpTEJCGy+qM7IECfamosKF5YiyR?=
 =?us-ascii?Q?1GSvNe3bNHpc3nRELHoiwTX/94/gR15Cnelqqtxq2mMviT0iDm675imhZztk?=
 =?us-ascii?Q?A87gm2lQqe52krUB4wq40S1jun3+GAm8lN/Csw+3VBrbPmpcuHWNaiQXwo2x?=
 =?us-ascii?Q?Ov2MO1kdpOET0YFfNGzY26ZpqQ9UegrWAHd5hGm4AfNgVI8EUHep4Ha/QXHd?=
 =?us-ascii?Q?i1bm2jnLs5gCdBRWWWXeqSZMPxyrVzRV5m1OTF3ya9AmKhOBt5pNODalx7Gp?=
 =?us-ascii?Q?cxflXELoAytM7b4gwpHXVgTIh1oxzaZ6+ZJpoGqu3rqnmQxdQJiSU4kAncNW?=
 =?us-ascii?Q?JhTtyUoU+66J+Bbh2ZKHCX1xINuiBidsN+h+gR/xIMG2wYYYrOKag72uCFKo?=
 =?us-ascii?Q?iXKKj6M65qooSDItTi1VPnlzlLow2qEQtvMFGdniP/2nwe8rcGXtObLusSL/?=
 =?us-ascii?Q?f1RSgGyJSE62ejIEtPjxGO/znD/vzx0JnjrHH75sZCyP6VJy+noN4YJUc4hG?=
 =?us-ascii?Q?2615ev0mzVhFO/YoS6/Tc8PcKEb7mpbtwLs93aAz/9hodal0dO8eFEwyV/PH?=
 =?us-ascii?Q?80YyuulxazSn8Ud4fVWLnk9zRMm33F00A5EPPvSisfekE+lX7nXVG3dOw1yq?=
 =?us-ascii?Q?cAqLD+jEkvDtCR0RW4SQ0VImJf2zu1IXKOG7P+zoWZrEMaVbK3kJPX558oc3?=
 =?us-ascii?Q?PCLVMba2W+M3VdYLZ0zKkZo4y+zHengL9080/tEmPiEr2JdCnholgMuD/wNB?=
 =?us-ascii?Q?Q+mjLoAPcPYyc7QQ/RLKi3lph4pdseWqLW10I+odgPy1etIuXFwLQf9vkMSA?=
 =?us-ascii?Q?epX87EiPrJkncqu3xEv2QJ38wiVtLzZ5oErklIrX3KU/QS3MtTMI/p5RYHQC?=
 =?us-ascii?Q?t+XOPMue777sjEgyFji/R1r9DoawpxHjLSOqQIZcTXDZmrg+o6exd6MCoK0G?=
 =?us-ascii?Q?IkjHIXeDcPDtP3yWNwEA2uuuBwB8TVE/gy/pMwSg2i4TLzOfSvRzAfyOSchW?=
 =?us-ascii?Q?RPYRAcQMijy5nhUFvT30VlwUpWQRs296FvYWvXo8JhGPaSquYCXnTf1GWL30?=
 =?us-ascii?Q?0G9v3DUS4kKC37JdRwg00Ua6hAE05w62iMKjZdkcpQ6Ijb9yABqHgM/wsfRT?=
 =?us-ascii?Q?XdWtvb7JtntPvFICQnTGRO51l/s/qkjvrjwC5Q5CadLlLTBFOntorfxSCeqz?=
 =?us-ascii?Q?IgA76mUtoRNrog3I8z/FooLuRZ+LKoF7PdDCsdh2Ph/j0StWoA5kdZbk1zrT?=
 =?us-ascii?Q?lLIm+JrrcXKosS1j19lxO9mzP1QKYpTsXBm/vUF7AHgJ9OH8MSWnNnoXApds?=
 =?us-ascii?Q?FX7UHT45ibX3ntNz1EBZC3c4ChZMNRwqyEMa6vKCwpWuxgeFTuPaf4ul8jdY?=
 =?us-ascii?Q?HdXomKEk2VYd0WovRgdNnnsPvXENfmYWfpmD/oUb5Z/VitmlO6xfR6u7jj6i?=
 =?us-ascii?Q?PQgMHJivt1rUxu/lNVxJti7TcbTAe+0z9xNQaDyu/NmMpldUDwcUjT50Ifbh?=
 =?us-ascii?Q?/3VWV9VIrFF6TFdoqySXkV4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RWcH04uUMYxqKdy3wR5w+npI0AG7Vbn1KNrvmvDBDpEVyBqiVIogl7VinuY3?=
 =?us-ascii?Q?kAFvdiNmWqF5pc25SQSE0pvj41ZsQqr9fR64oGsIG3KAyKlWLukkPfkf15k7?=
 =?us-ascii?Q?t5SkEu9XBtP5Bv0uySg5jn63IytIVjgTK+sQK1nuD1qo4K51jsoy8F6WZE/m?=
 =?us-ascii?Q?CKUtT16lwkFV+m+XSBHyG/AwLVBWr6RHhFKcnalxPcwRwIETlBwqgKInE76x?=
 =?us-ascii?Q?/igHeaoxjyw1kptw0CRXyO9aLqe+2/UahiD+z0swAImofjx3lh0qx26I019Y?=
 =?us-ascii?Q?ZMSzORgTNcP9U7va6KcShjlp6Gr3Mm8cwfSo10dG2hTnvxZQSsS6f0KpEUhS?=
 =?us-ascii?Q?iMuNBJSui2lg0FIo7tCEMOR4LyulmClD8yD+fRzMkQLApX8z5zrUMSzs23Q4?=
 =?us-ascii?Q?TSXeT/Oj1H2rXW5MNG2kHvqtVPV0I3xdodZbq6HFTHM/5AIgZCP3r5rl05G8?=
 =?us-ascii?Q?swdHkF0p80hqZ+oufvactgoFAKq99I1GfBtSKyH/NlTGYFuCCanyk2lxLWp9?=
 =?us-ascii?Q?QMgTBu0JRHD2HbdOoy8/plQEDjIB7ExyMBCrshD2sdrQs7socXnlRWPWuLLW?=
 =?us-ascii?Q?dCmiZdEQMwaPT6NpotVjWUcFrU+5Cn10XHtIeeTQmAXx+e8ynRCnnDekHP9t?=
 =?us-ascii?Q?pkxLjXI8Sn/DjsBgON/o3NzdgYEuVAGD7mJEvx4+hfsiOD3gjR72xzF7RFO0?=
 =?us-ascii?Q?80uHyO5xcc7CB/39toJCpD3l1sKauueEh2HsgcgGDZDaUPgnPMfmJrmHGu4D?=
 =?us-ascii?Q?P0PFr3JTgQIPvP6t8rm1ykKKzmUYtyc26G3B6Zxw+rXDZ9d3uIw2AnAKQA0h?=
 =?us-ascii?Q?y+3Jt6KZCVx8jiVOjPlblLgsPusztJM9vTi7s5sw9vyUhW9oABAsJnbsHQTR?=
 =?us-ascii?Q?Qinyk6lTDrqtyXFTYDf8NTPmYbbPFC/uPU3lrOe3zP3ebC84K9AVh84Uy8pJ?=
 =?us-ascii?Q?4AdONV6qWi9U4kBLGKQ4+pYtUrstQqsSXSBGR/aMpQJfxUvXJNI1gtVrpEXO?=
 =?us-ascii?Q?Dlo9C5sccffT2e4Iz5ZlRpueG5uHEtCygNrLlVfpNyc6fRj3seDcQCYkRuLm?=
 =?us-ascii?Q?f0jQvUI+KdRoGw/gAThSUN+M/iwf19AivAnh9wVsQs2pVmvAR1C4u4H/7gw/?=
 =?us-ascii?Q?dBm6/9K63USUdLmzuHrphg6ahFVa3Pxv4cZtNxJctCe5tHBgXKUhlmVCD1OS?=
 =?us-ascii?Q?ptWqJU5kOvcZ0DLObCi4rRNHz0Bfa6o9QFQAB0U4Zorq12RhMMw6XUT1Y0P5?=
 =?us-ascii?Q?HFRQOUE1Ei503nEHpe+6RVUP2heE2rc50xHRxBXyZJ6RJ3CZMX+n/eIOFB/W?=
 =?us-ascii?Q?2Q+b7F2y47/tR26eCwDONGNWznsExo0g43ePFVcNu91TvVCbfRvSUt6Rs/VM?=
 =?us-ascii?Q?9DFO7MgAJuJCFWMy7N+zBzx0gXWnonSM+oPDrPbvByMHXVK+l+iXuzXlxkpV?=
 =?us-ascii?Q?wQr9M7CHIb/ZvOXjJKgX5Qz6OwBk/0xP7lkpFlNXqe/kSerVz3RwaRkRBOfH?=
 =?us-ascii?Q?JJNjPt/Q4c+4vLQHpGJhEX886N+h5AwAH28nokG8+CvT5vtpLpBp3a7vC+Na?=
 =?us-ascii?Q?+p2WFuzK7wwzqqMoA6L2MFUkNXO3MRszrcQYoWlqFyO6l1yz+4rpEA279bl5?=
 =?us-ascii?Q?GQoNB9ycUg40sj0h4o7lR6rUmTph5QlVjHd6y72dnNWuesF3qaVvE0cAKK4B?=
 =?us-ascii?Q?6GkxXj7VH/U0ieIneA56mBikzNxYHAngI8R0ZUqg/R5hHcP/iMgZa/2k/Xoo?=
 =?us-ascii?Q?iYw14lJteg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc13465-2e96-4f72-d831-08de72ff5492
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 17:16:49.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVl34+0N1qTsCVQtBMVsG/HNlYRJ3iev/ouKi80+cswOP7YbuY3aYjDhd6ngbZ39cvhtwNJeyAPjxy7wq+fnbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260130-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F33E317A95D
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Larysa Zaremba
> Sent: Monday, November 17, 2025 5:49 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala, Sridha=
r
> <sridhar.samudrala@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.c=
om>;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>;
> Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 10/15] idpf: make mbx_task
> queueing and cancelling more consistent
>=20
> As a consequence of refactoring idpf code to use libeth APIs,
> idpf_vc_xn_shutdown was merged with and replaced by
> idpf_deinit_dflt_mbx.
> This does not affect the Tx path, as it checked for a presence of an xn m=
anager
> anyway. Rx processing is handled by the mbx_task that is not always cance=
lled
> before calling the new consolidated mailbox deinit function.
> Moreover, in the reset path idpf_intr_rel() reschedules it after the dein=
it is
> done. This leads to mbx_task referencing the freed mailbox and causing
> KASAN warnings.
>=20
> To remedy this, in the init path, do the first queueing of mbx_task in
> idpf_init_dflt_mbx(), in deinit and reset, always cancel the task in
> idpf_deinit_dflt_mbx() and in every flow first call idpf_mb_intr_rel_irq(=
).
>=20
> Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
> 2.47.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>

