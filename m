Return-Path: <netdev+bounces-281770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPx6JcaK8GloUgEAu9opvQ
	(envelope-from <netdev+bounces-281770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:24:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA71F482875
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0A5330622BA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D9F3E274B;
	Tue, 28 Apr 2026 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLW+Eg5w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0114C70830;
	Tue, 28 Apr 2026 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370982; cv=fail; b=H2nrZnCukOgDZi0bZrmDZwyqR/5NGbcwFGvQ1JuPN6Ac7nOMrcO2/ygzY+4U3MA2RvOZu6llyZ2nHHankcMvwnp+Gi034RH+9LhIsJBsMsY07/AfnNY+UU0eJd9Qs2IEG4ruVCA8dJkSSBm0GVJgHHfTklV8C1mEnopPtGw6yig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370982; c=relaxed/simple;
	bh=4vryTFhIjc82mKkm0bWln6Pkifahwk89Hjgp9GhVX2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2O4OPYHE+SF88j9J5nfi/8+Gx7E+/CO7eC56rUbMtyWRPsQwc8GlbaGGBhhVY6XBM79Z9ivHVb4tIVD6EFlGgr57M3ekJzr1D9RLL1BUNWHq6nLx8nZ/41BMbG+W8ysqpDdlVlp4chXV7xIWyD/ZeSt2AoUhYPad/0l9ltpdgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLW+Eg5w; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777370981; x=1808906981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vryTFhIjc82mKkm0bWln6Pkifahwk89Hjgp9GhVX2M=;
  b=ZLW+Eg5wn8Fhs19hOvkafMUl1vPBFU1FPfb3hoyUQlsUiJWJvzkXXvMJ
   NgOB2MwiaXF8c/6BpqQS+Waq3Bz9GSMgIPbz2xe21PQrPMs6KjChmP8cL
   7Cn/hF7OvcDtF5xqJLnRJRWPe2yslKtsU0XpA4H6eW5EeAAkNdV29QHAl
   wa7KrORIvgibFHjtkrHyH99LfxMsxEkBfOFCqAuONvU9biCXloNHrm11M
   4ra45JZIVziJIcyumfiyQKbNsVZT/3UrN+xn/LQWN1uiLnDALgtd2dvby
   HB/b4NDvkIGu1DIF4Tp2R89A96rsqLc0AoLaMhmMLSDPKJwMEdxKSFxoa
   Q==;
X-CSE-ConnectionGUID: NO24pq/cRnSXcl6nwICS8g==
X-CSE-MsgGUID: 0yezxiiQSRa7bjc3Nvp6EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78258447"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78258447"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:09:40 -0700
X-CSE-ConnectionGUID: iCQxk1pfRlGRrYW/8eWK3A==
X-CSE-MsgGUID: EZDcJEA3RGic6NoyXg1ypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="264300844"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:09:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 03:09:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 03:09:37 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 03:09:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4r+wdq23tXazV3izjV2kCqa3rrNTOK5A+Ae0HUFYTA9p1kKkJxjEW4IwzwgXhw1bGNnQoSy73e1I4eqJyVZ1p6DKeXCRPXYMJZIBzeApkb+7lp1JHGJX9O49sHDl+EnxFc2Hg+2boyI6qKQfI9VYUWaRaMDF3uOTujbEPjgMvrdhTGZVjK0uXnYqfcf3seW7zyZcujIf9q00mPMqs8vy/yYQ2UigJ/o4Lu5RpoUkhO4zkTuUYfQmcnrjigv9y+NgkRR2rH2eSvs0nP/RQxGoaS5femzfHuLhTfT9GKEuYLny+k6cRqbnHS6X+up47S1R5XQ6sM7UcuOPIHp68ID8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vHp5mISxjAtYf3j+t5sIQBwn/lSii0a6UYc+JIwNYI=;
 b=NzLJVecHSLDPfYZga/qzgECHgbCBUGa99Tx9QNjExBZHHRkDV84kYOA33Y1+tYXwEkl0fkI3KXjTENnAosM7p3Oi2FfIrh34wG3GA+DmOaB4w+xIKbxdmQq/nMpkGdoeqGi6IXt62WryuLHa/6jhEGGprXl44LtxBIFuXbPgwxICe4z7bIFO93bfe4n0sHP2ep6GZ0hMvJhoFJoOGSK2BLN2gE/I3j2uQcgJKOtwpuA0LydU2nFxRb3v1Vf0YUK5fE/xLZ6E1TGc8aU9JHLhM9KhlRigMOs2YnT9ISqv+ptwMceF/KPgSYJbcq7mP1U0rw+SJXuQJWX/vbhuSROMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Tue, 28 Apr
 2026 10:09:31 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 10:09:31 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Burra, Phani
 R" <phani.r.burra@intel.com>, "R, Bharath" <bharath.r@intel.com>, "Salin,
 Samuel" <samuel.salin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v7 02/14] libie: add PCI device
 initialization helpers to libie
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v7 02/14] libie: add PCI
 device initialization helpers to libie
Thread-Index: AQHc1ujc28MfH5Z8SkSpCjwBiQLRL7X0QE0w
Date: Tue, 28 Apr 2026 10:09:31 +0000
Message-ID: <IA3PR11MB8986CC82F38D627AD8B0C420E5372@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428082654.44364-1-larysa.zaremba@intel.com>
 <20260428082654.44364-3-larysa.zaremba@intel.com>
In-Reply-To: <20260428082654.44364-3-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW3PR11MB4716:EE_
x-ms-office365-filtering-correlation-id: 6fb024c2-cbb0-42ef-3fa2-08dea50e3db5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info: b+mxuMI5TG9s6O5w419MlW43YIpSlPPQFUi57F5sg0qw1f1NvOR+9zE0N60uspKdHYllZP1P9JWnv2X9TugdOJG5Gnyb0bhL5SVky/PhMH8rDnuMow5Hf/UdFYURqE/bVT6zO0wx+0MKhgDqh3Fgi7Au7RzFpZZwn7yNSxbjYpYKcswKwRWbSZFdN36w5XUKVD3RsbuIvCFQjBSuZczZ5bp2CAH8p+fGXvtaqVAKLy0VDt3sdnzhOlOcjILlDX5PxcF5QSnsEPjSkzMp9n7Eo0HHhtC4lws99JthLZfOYpLv1OGLYXd+INRu2RTMI60auvlsplJdAbRMXXEq4AbT/G1NM5CXxLumKgkk+OX5Uf4Gt+gn/gwMB7u/SPrR81TyhDemRx9k7fQNB61lgl32xwCTqS8goS0ZEreNIOvlfn6+eBysnF7DHE+VbZ/SYfDOK1VskQIqt6MjvnZar2Ugou3OGaEDutnNZfiYZEooqdNjY0YpnkBhsOTSB6RGmxTvdaYIT5f64I+gdopH0aOgS1jVnHtAQV+zXE6/LWqm174ZMeuCGm69e4AkJka/e61935KT0sot4jVY3ii7y4FxiytytwJcIsGBEFH9c5bD5cwTULvIH+CwK+yVypja2zekmHAdoCHw5u0cDcfNHWULZT12cBVfhLlR9XTO8WvJ1rhBbUYgtV/Lh1fGES0w4cyK59+t4cMFFxB4LlZRz5F8CFBqQo5ICeRyC5/5fhSzNPX5fez958qHHX1XyZGHm26o4+C0RS720S1gKio5p0h7Mwebtc3ZW11TDpprUlv3vmU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aWjTErBGGeqjOLfyOl+qTJKCc3WQt02BpwiWW0UmApoxdJUuGY3FW0seUD/7?=
 =?us-ascii?Q?/Wib40Sk6YWRjQh50sqNtXisJiFOipDMS16F2GfWaAE04Z6OSWzn58iihwjI?=
 =?us-ascii?Q?nzuCMCnxNcbcsu1Qys1eFGCkF0NODBxE8DjZHpuF3Klp5Viy0K0ufqhmMWvi?=
 =?us-ascii?Q?6rRfKRPzAQ/6bBkXPMTEt8MRpzv9z2Q6M1iyA/PgivzGieeJym71cMHzQxt/?=
 =?us-ascii?Q?rdGBGGN4JlF4QVLG5mhzf9phrN1Ge6uoTB6Gy2bWBdVVBOMj9/xdebrmiHvm?=
 =?us-ascii?Q?CooYU1aE3SlyzwhBaKvtDpNCA17vgBXxvnCZnHZzi20/I2ml7kVg9FJYJ4Vc?=
 =?us-ascii?Q?sngaxy3BNS1QzeNA6CH7Mu2t04McXZ98czc6fbIrq4/P+z7xV5x5NCRRW9cR?=
 =?us-ascii?Q?pbdTvMuNo/CaDM6oPozaHImIyYybBt8695kjRdvmgKlaQeNFmHtg+wykznhx?=
 =?us-ascii?Q?JmQ+z3aLv2NFwgCQlMmwUWVh/E3Cd4YWQPUfKxWecCH/PmUUyzaqVhO8HBNL?=
 =?us-ascii?Q?ZDkh/lgJTkyYlpO9dOabfIlzVOqxmdglGVkJsdpYgpo26NVrKBkyNV3rkYQt?=
 =?us-ascii?Q?QkrziZPwKuG5AhFAAOi4ty2kTKefdBfYY7K2bEsxDuRTN3HCjYLu+vILCGtm?=
 =?us-ascii?Q?TsZpTmtqanoeTuBglaz6+UassJqejVRIaclnAvXbu5xheeGRLTEC8ldoTEts?=
 =?us-ascii?Q?N6opyWXYXvVOIQ7TkXmG4c4UnkTsCFSy1NQ55PpVV4S6aDaCemrrVYmk83Dy?=
 =?us-ascii?Q?2AnQ/3XXzX11huAcTGOVGufNPvEdz4O+q2WhE9EVZJNClznM3tfOFC5BcnJQ?=
 =?us-ascii?Q?c0eFLPBXm0/G8zcrZF93NfflqDphovmQEZZlJEvS6VgdznYZC5o5Bjxslifa?=
 =?us-ascii?Q?vg0nIt+t5VpVeBAdBPeQTgxi5jA4CxJR5eMu4o9KG3mmScCrJw00GNta4DzI?=
 =?us-ascii?Q?Di/xIhREQ+dPbaqKBFN4oAxcG4e5xbyIV6i2PtpVKOqewsx33VEQMhYBofZM?=
 =?us-ascii?Q?vxl9Qmh9+zLdfuomIao+OskKH0lIX4aNnlW4v4T9/IgBrxTZRyhwUQXBtRW4?=
 =?us-ascii?Q?sLhqJVBEAx15k9GX/TE8CQCv6Qq0d03dJcplQRBjaY/KQrbTomCegPRALX3h?=
 =?us-ascii?Q?gayOciQgHoRNET3DoGTU5EMbqsVK9KqRDJZJm8a/6OeysJDG428x2FsyGFHD?=
 =?us-ascii?Q?WDZcd8B0sRB5q3Ygzvge65KBDpRcMkdfVv1ZHDalFuYEJpnVEatB4lNLMnSf?=
 =?us-ascii?Q?sg1sSVrTP8Xu7gJ8dYAhorz9q9JS7iqOmZw/edOBEG1drqwTiJnQI4ggaDFe?=
 =?us-ascii?Q?Cy74EIA/kK52aqSKDHFzaR8bnP6+V2HYonakyrWIJpjqnnMWUj2MmNrhZOPV?=
 =?us-ascii?Q?ke3Yuge71yzbl/ijWXo4Ei9btqAj+5bEqOX0URv47W0hZDSkTkrQdSCnuyOB?=
 =?us-ascii?Q?4FlmjMBgDLx6ttBbFUV+Ub0tGbyuHQH0eVoUzyrI/1I3bEgJtEtiE/AAZ8xk?=
 =?us-ascii?Q?2TPfU7h43s0BXCYwb58oUzxFQBTaLBYMlQ2pPG9ncZtbbZUx0l41KdYM6AKH?=
 =?us-ascii?Q?QLtF4JSFHmFPWz2F6S/vp5ZUL8ORqTFJjBW98T6HFjqXAt6c3w9SGxeG4Fs3?=
 =?us-ascii?Q?9QgHBVetwOAGs38yNotOU4kP/qeDo48Tz5P1ept383Qk1mw66txHm5PGjVCn?=
 =?us-ascii?Q?rx5gteJhknouQbCApSZhW7Ywj2ImW23+bscf/MuFhHciqDfYTluutUQytRyS?=
 =?us-ascii?Q?AbWrf5XYKyVkh5awjsapOY9kWJvz8e0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h33S/ANhgFEqi9TQ89+gBlD3L7SOV7012gojfPaf/Da95r5BCG2DOMUV2zs+bwWxPn+ZvGn1ehwnCk4kd9NCBmnmPPCJRu14+L/rBbpIlc918InPw9k9VyX50CxfQenEyizEcVqgw4QnzviU0Yn5TVR9iMydBqT6T05z0sBk8xzoSm1KPHsOsEuqVd4g4enak5DbP2OnzEHUdDZ4lZe2JpU5kkeHU5410t04oDSe2C78W5MTUowc3NrR6qcxfcYyDF0XwCOrB3aMd1x+IN8Sy0HpmqOikIPjASKAG3xX95RarT/HlWKdUPdMqWvbyt1cQinE53OosICsv2XD0V/P9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb024c2-cbb0-42ef-3fa2-08dea50e3db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 10:09:31.6030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpzQqkFC6/KggvncF4Lwdgo79T1YCUicnAHCTlvbypll5NQ+vWpEJBtNHDyGDrU5cCRPSWn3bh3+Kqp8H+grYEaYzRMjgnFDQxUAhohh2M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: DA71F482875
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281770-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Tuesday, April 28, 2026 10:27 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Burra, Phani R
> <phani.r.burra@intel.com>; R, Bharath <bharath.r@intel.com>; Salin,
> Samuel <samuel.salin@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v7 02/14] libie: add PCI
> device initialization helpers to libie
>=20
> From: Phani R Burra <phani.r.burra@intel.com>
>=20
> Add support functions for drivers to configure PCI functionality and
> access MMIO space.
>=20
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <bharath.r@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/libie/Kconfig  |   6 +
>  drivers/net/ethernet/intel/libie/Makefile |   4 +
>  drivers/net/ethernet/intel/libie/pci.c    | 208
> ++++++++++++++++++++++
>  include/linux/intel/libie/pci.h           |  56 ++++++
>  4 files changed, 274 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/libie/pci.c
>  create mode 100644 include/linux/intel/libie/pci.h
>=20
> diff --git a/drivers/net/ethernet/intel/libie/Kconfig
> b/drivers/net/ethernet/intel/libie/Kconfig
> index 70831c7e336e..500a95c944a8 100644
> --- a/drivers/net/ethernet/intel/libie/Kconfig
> +++ b/drivers/net/ethernet/intel/libie/Kconfig
> @@ -23,3 +23,9 @@ config LIBIE_FWLOG
>  	  for it. Firmware logging is using admin queue interface to
> communicate
>  	  with the device. Debugfs is a user interface used to config
> logging
>  	  and dump all collected logs.

...

> --
> 2.47.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

