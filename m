Return-Path: <netdev+bounces-306697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J3veMBJoUWqVEAMAu9opvQ
	(envelope-from <netdev+bounces-306697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:45:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBEC73F169
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:45:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="HrZ/+QAT";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306697-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306697-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8505830037E8
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1169E36DA13;
	Fri, 10 Jul 2026 21:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B232ED27
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 21:45:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719952; cv=fail; b=ro2XFtPoL6Lw+yfcaSNzd5HvTA0HSHwnSfd9ru8mC5vnEymRVUmR+l3oIy6P0A3LkZ31aD855i7VHkuVcmGDOXMnM+ZNdifgo5G4iFX2XWhJMkADWtMqBJCjmWUK99COh/wl+kYAx2gyr97LMpJCdJ9buduXeR41nD2dZw1UcZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719952; c=relaxed/simple;
	bh=o75B03VBlmoO19zbf6CNwJCBK2onvAXjS5Obr8UD+no=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CWhLYVSQoJE/LiB3VSmdrqLU3g78pvv76DK1VUKsr79lRfLJGkRsF1G9r5R7IGF8l6NbtL3ykheoNpUKfkZ+PQcwVhLiwGywNLsSXUi94argqDHVbM5MtS8Y/Q+d0AUdgVh2VKPeTo13r2x9ZtEy152yYNHVR4KZyxnz0GtWDWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrZ/+QAT; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783719950; x=1815255950;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=o75B03VBlmoO19zbf6CNwJCBK2onvAXjS5Obr8UD+no=;
  b=HrZ/+QATSHr5TwpGeIuEypa32KBfzJnC9I6vDhEF9ACRQZ6luZT0k49t
   29oseTG1QOg0Aj1fSIjoem3eWCxdUO9dLQe7+9tQZuAIS51W3cxwxO7KQ
   CqXscBEh/P8FNHhzV5FnEMt5L1d28IxcpMzi4uoWiXOqsib/YnaS9CDAx
   xZX8RlmQL09jsj7fFfU105ibHRCAgfMRFew/3U18/EqE0FvPKZwxKa8Gn
   C0kXVRSBjAOkl5jGuA7msoQnpojAuNEfvtggJCSVKYH2Fr3tiDX+sLOLE
   oJqYkMVLbVyYW50voCfUNtO9XuJcemuOcOaq4mUief44xKagkqpryWpQ6
   A==;
X-CSE-ConnectionGUID: PfS60RrSRLazgjsjMOJ8vw==
X-CSE-MsgGUID: de5/+1pcSBGlKUqslyk7Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88333630"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88333630"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 14:45:49 -0700
X-CSE-ConnectionGUID: f0uajbInTE+6C1erZx5mkA==
X-CSE-MsgGUID: WHso5LgnQs6XydOp9X62Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259882669"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 14:45:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 14:45:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 14:45:48 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 14:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5fPKSyV3IzHcvrSeePHD/NBrGJd8rQ2M9d2nEZn+wK/+niBNyC4zqnQ5FF6xDkU2A7rk03zpxI+hG/NrnoetN5ur9HGY4UjSzxQNyBsMyk2X6sKyN7rNUY4QBTYL+wgolnfNUQhWu0tKP+oWJcyr/xk5qmm0s4wtY9Xvh10JJf9Cds2aL8V34VHpJ4Wa2xcMmJFTygwwE3kbl30Z3NfD9GxJ1BhNjjijfD3/SVMP2JHmtXBaz7EPDj7ojVkdLHMUn5dnHU+hIYxuTzu3MxvmV3yQ2vpMxUfUZE3uiBM7ymqFZDWUyWSDD3mSYCSB6Qsrg+4OSmgK+5GjobHrM6c6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgG/7twvllv1x+iwCvqvVMe+0WY0DFNRlovcW7jR8S4=;
 b=s8/ig68Tb66JCGq4uFUIgGVQvTXSgS69Z9a4w8LSwrxHEG/sfAS+pBAxUyDJt0Gd/HjrMLA28peZKMWa75RsAJNfJn0e/wCTT3hQyhoda5iy/rLfWcn53Vr366/Lr2HfFgdPJJ+o1hL/EwEYRuQiKQPEHaPo1IFX1W/MZais2ecArM+VHyUJut4GjYlisikHKs29wAPe8OyIXCUEl+/7qqFyyqNI2MaptaYcl8zoyN+D8cH6HdL4oMK7HyXupIYLZSMZGEmx9vmPKgsKusV8ryUeu/srYHXIqxGx/uGRO8KFr7PbadtA9O3O7rH6MIAHBMzVXmbIba8dE5R/Bmzyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7)
 by MW4PR11MB8265.namprd11.prod.outlook.com (2603:10b6:303:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 21:45:43 +0000
Received: from SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0]) by SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0%4]) with mapi id 15.21.0159.018; Fri, 10 Jul 2026
 21:45:43 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>, "Das, Shubham"
	<shubham.das@intel.com>, "Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>, "Brandeburg,
 Jesse" <jbrandeburg@cloudflare.com>
Subject: Ethtool is missing C2C link modes
Thread-Topic: Ethtool is missing C2C link modes
Thread-Index: Ad0QtH9BbirxMb3HQge7zku6IKXccw==
Date: Fri, 10 Jul 2026 21:45:43 +0000
Message-ID: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6900:EE_|MW4PR11MB8265:EE_
x-ms-office365-filtering-correlation-id: c8a7017a-ace6-4c8d-98df-08dedecc97c5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|6133799003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: KlTNffsuATPwDYvr1AtokI1B5ooFw+IP/IzlGR79eG5nn4RGd5mgKsbtQ7HhsFxEmI6iLaG8XjTsF12UWxU6v/TojfCMUYCun4Nxehr8YI8F1B2k5yOO68dYwaTsiaxDfRmyQkpOjxAxM6Fuq4646uBrnEpvGgIqk5/nlaor+B81ecx0c67Yz5cquBWmEMSeSb3Rs127LzMAWAZjTp48jhvwL0kgzF1b6Qf4dtWM5fxVeDsegVRY2ekk2om82MZROIAE4cMFbUqttnMsJKw9oEsA68fv72q2GRi2TOmtOXjNSt5we4RJVnymOxOw40voDA/zGL9jGNzLDWf+kyW1SRDS9pTxe+dZc3Hm1trhNgI6GLmLvx59YN1Oo8QJSd93WBVcEYcJpCPl1RfPSi0CzeReJY4Cl8ITy1Nz5tnO4AqcxmaQjfnM+VaVOURNHGCqkEX7z1+uBzWerISNI3KWAO1/ti98fsoj7k09CODGonj5QQmV8J33qb3SWiCub7rtnRTlRms9SoNqxY5YknT88H3R2IEDphJ8eCZOW30wctcZ0x2rs5cfPoKlRT4fl65gdMYyF4jzMukOCucWctlsJ0sWE0O43agRlA864QEUrscFGRTpYPMphCz4XLPxDIZkyCgYWWxzCdaOUhZLf6pzhEIRLUsXqIpcKVppw8XDrIFx7zsq4+8GVTcdfq5CCqlRR+MBvAdRmGQAneysWHmt10jyVBuJa9OCB+XoAv6u37s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p7KpTXNAT1WsFXnp/9SujZL+UJ8vAooTfrNV9khhPuheQ/2MO0a7P3+Fy8nW?=
 =?us-ascii?Q?eGr2ecdqB6IPPD8TLgRR+99uxkWPl88x/WWtI5vj5UqOe4zx2gZEXHfC3tt7?=
 =?us-ascii?Q?zPCexrVeRypEQ+/J1ZaS3FzNLtqFnYHq8T0DqjO5dajCKAgFQ4H9SK3s3ueH?=
 =?us-ascii?Q?u4aCIUae4ft/Byv8gB20u0O9+VwlTnNLFxC/32jYq0KqlotgExeNau0k646Q?=
 =?us-ascii?Q?+nvYWRmnwOdGnfesKfoxhMu9U59tqgAc3qOxe9OjsrzQF9gh9OrmqpqaREUc?=
 =?us-ascii?Q?vyR3w6Tve7kaCfTMrTb1EZZJhPRJzZ4X7N5fcVCeNP4BaAuzShqyRWDm4gNY?=
 =?us-ascii?Q?7X4egVpU5sXbwhu3T5ccHkoqTm0iqAuHYMtrJg0e6FqyoRSGVViqLoLhjNKb?=
 =?us-ascii?Q?eT2AXK9aP1NcdT7AmXQCN260MSoUsHVrS/ElWfHdQNlRmiNKjPSoTAKVVfxc?=
 =?us-ascii?Q?8zpa206VAMFOd64ASjN/IZcBQM6yaWJzl1AFYNkxJmfg0JbKNuHi4984KZmd?=
 =?us-ascii?Q?E3ffNkiyU6jvCfXIXijHXID+aKTULVMOUAGI1zpsWeXrIBHY275SnT6Zk3DN?=
 =?us-ascii?Q?V6b568L7SdXl3pd1fajAbdWvaX2gwqjvlzNfa0RCLH31Z+l442gyJikZzfDZ?=
 =?us-ascii?Q?3gAFbr2FfbYDUxDCQ/1I/FzhAJn+hQvpmBGspy0E835/YXD16Gqi1cXVbKV/?=
 =?us-ascii?Q?wfCZR2kgS32nWuBNOZa9Xe884ffe8roNXFK6f2SUT8F78dq/TL7yVt0f1BnG?=
 =?us-ascii?Q?KgJlvHakoy4sZ/ss+hlw2YXdhMquvImZ3/mwTYeco4Hdgrrr7VvaLbSp/NK0?=
 =?us-ascii?Q?8avUEZZGgYEv7lfZnQDjhSgZgULRW7IK4A+rx1xsD6TWURUAnqqKq5ZY43mj?=
 =?us-ascii?Q?u0vFefnha6ga7gjwpdBpL/11OTA754dOREPmnCT00vj6NQ00bMTyYzDwxXvL?=
 =?us-ascii?Q?yCbwSzcSPDajkll8S++Gl7PxahExFvFKqyuWUm3XjRNd5EkxWTs75wu65K/7?=
 =?us-ascii?Q?Xy0YWuAjRztqPVFL3y7cyS3oPJQ3fN0viGFSq0/77obfaLGT1J2M0d1DXB6O?=
 =?us-ascii?Q?mLE+ULOdx4DP780gH/v9lEnQe3ICEDb6xrLpWVRbgJHzXysdZqELvi6u1znr?=
 =?us-ascii?Q?2Aipn2YHotUjV6oMtDVQ6C9dbNoL2U6XbAYqUVO7Fl115eDwPX5cPvogKyWG?=
 =?us-ascii?Q?TL5hFDa73xzvIPJCoY2KgP3j7aFk1ur0E6qv94pKl1LxzBDFMHQMNOjSQbja?=
 =?us-ascii?Q?HUDTnfiPsKoYqtEfjBA+a9nkK5OLO81HQd8LIkpxeqaRSB9dl3mlmCHGg34f?=
 =?us-ascii?Q?HLtj9mfVw/pchqCUDyy8Z9anC9i0g0jIolh3P5JkHnbgw10NoD3UG4JI1qRv?=
 =?us-ascii?Q?UIzcyODMW+TNHys72vYw+2ahPVpd6ip7VhVdiuRodgbXQkgfu0V9gOMOaDAC?=
 =?us-ascii?Q?8YI1MmnDhbfhbcj96gHvXPUk8OutN6zNyoQJB7UnKxRirJnS+EY/IJHm1pxT?=
 =?us-ascii?Q?oDXXeJJ9EsRaqAPPzlnhesAAryZBJXeaKAjNnD+uWHUVRCtnKeJTyPLvEBOh?=
 =?us-ascii?Q?T3XoB8qARNYc51od4mGfAn2bpwcSOjyrPLAG1elKAV8opbv8YV5aktcnmod7?=
 =?us-ascii?Q?8ljJC7ZGEY3XCxaIT4mTP9d8W4jKpx0nhS7k0gVIgPdtScjupaBHzASBnE7s?=
 =?us-ascii?Q?dk2RlQ9bWaCz/8lXfLyNowylsxkiDvOFh0o5AuOYFPXFj5vT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ROUK5bfvRlXsRcZbKsWk6BFRY9mMBIIer/iZdF3588ynN4DGaFAwqS4pcOzWmRLEZhT4X1zRC4/bopnceRJju6iU6Z8a/kXRRzlrPyY8pXEMZgPW/Kz+8oYkP5pI7Yy3OsbFIwy4M41hngyQmr/J+VvrmIUR4Ng/W9D/tkE4NdkUUb6WGR8F4kgWSlnChGIZTP+MqYrnO/BJsV6O4krAtLljdP3LMWogJruyeyFoNusaC+kjp51n/44Ivdp85CGgqQltBHm+6nuMwjoJzoXTiDTvCD8ZKN5aVIkKWxXzNcqGxmUTNdzsoMcI92DdtcY8R3tQx0WmEALix0BHwdPg3g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a7017a-ace6-4c8d-98df-08dedecc97c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 21:45:43.4108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcSfswPJZSncgJvdQaYUYJ/YG1mJq6OMZ/4EpBqkpd9Q1/UPc405w0JK3jQh9I/SbJ+lwftk+INL5jwCyUbFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8265
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306697-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mkubecek@suse.cz,m:netdev@vger.kernel.org,m:balaji.chintalapalle@intel.com,m:shubham.das@intel.com,m:vijay.srinivasan@intel.com,m:sridhar.samudrala@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:singhai.anjali55@gmail.com,m:jbrandeburg@cloudflare.com,m:singhaianjali55@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,cloudflare.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EBEC73F169

Hello Linux Ethernet team, Maxime, Andrew & Michal,

The IEEE AUI chip-to-chip (C2C) is the accepted standard for connecting
chips that handle subfunctions within the OSI physical layer. Just to
pick, the C2C is widely used when connecting Ethernet SoCs with retimers
and PCS SerDes terminated external-phys to offload PHY sublayer functions.

With the existing ethtool link modes, we were not able to fit these C2C
interfaces on any others (we fitted **SGMII interfaces to baseT link modes)
and we see this as a gap. If you acknowledge this, we plan to send an
RFC patch to define below listed C2C link modes to ethtool.

	10G_SFI_C2C		SFF-8418
	25G_AUI_C2C		IEEE 802.3 Annex 109A
	CAUI4 C2C		IEEE 802.3 Annex 83D
	LAUI2-C2C		IEEE 802.3 Annex 135B
	50GAUI-1 C2C		IEEE 802.3 Annex 135F
	200GAUI-4 C2C		IEEE 802.3 Annex 120D
	100GAUI-1 C2C		IEEE 802.3ck Annex 120F
	200GAUI-2 C2C		IEEE 802.3ck Clause 162
	400GAUI-4 C2C		IEEE 802.3ck Clause 163

- Thank you,
Siddaraju D H



