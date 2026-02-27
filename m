Return-Path: <netdev+bounces-261804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKE6KGZroWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:01:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D431B5B08
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E91C33035D4E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2F936EAAA;
	Fri, 27 Feb 2026 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6WCMR2k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6A35A3AE
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186134; cv=fail; b=LXbON6EaqTQChToJjH9z2elLMw1vivqJ3g9s9tNr6Fy9Ci6tJ5a4qY5jAoMHwgg19bl++uAZB1A9AJ9/b/BXe05ZKV/gPrym5qM13ixSd6bnmVeP21NTT+PwZUPA7GB0kdIe5NtjDfWgCQ0fNYQC1RDh9Cm59nqtoXMYp4LP7lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186134; c=relaxed/simple;
	bh=86NmHDZ9biD6Ygt1mq8l212umu6O7uOUBLWggwpkpMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYUs2tuQ/pi3MCvU+SEpBf6bwA9tBw/7YyY5f5mgkvaQalRT0vdGeg+66Y3QrXABoaZttoYhNYJ/u4OKY3bqMOZ+fOxdgtJSXmgz+ZZjUoTVRsoq2up+a+azqjFOJmMRDbSTkRg9+2dZ3210598qiWb/h0Tvcy22n3RLxUsNUuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6WCMR2k; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772186132; x=1803722132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=86NmHDZ9biD6Ygt1mq8l212umu6O7uOUBLWggwpkpMY=;
  b=D6WCMR2kffeOS+QP76ykz9eV7wI5M0xMU3Z3AsLd+EQfzvbs7rj/ogLV
   iazcle9cXr4ZOyfvza/gAK+MNvGRDM+UBdE+M2j4+1b9tfADlrIISDPY3
   6w6XvBTlE7X4Qs8baHafKMroxXBPvPPVCXPCc7vZIyVmTLjKM23xcVE4o
   8U56mDFVfnyHy+0f6hK0o80EBsp8c1dYuAfqC2hxgMSNZI5vWdIyNem60
   oEXc7d9bYetI1qOB4DVFk3sMAuns2tMkYk2+9FLU+E3SsgOUfLxBlNbzh
   y+X15dELP+vZWMbRva98VQucvoUWVa3L6JCzt1nXXCrKEAGxXLPxaaH/5
   g==;
X-CSE-ConnectionGUID: 7fNT2UgzRwa1nV6m1vvYVw==
X-CSE-MsgGUID: 7JpYFdlRRz6z8g5bO5/7jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="90842656"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="90842656"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:55:32 -0800
X-CSE-ConnectionGUID: jo15Wa6xQlW11oi7g/FuIg==
X-CSE-MsgGUID: 4bb1f/CgS6+HZvM+lUvswg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216863578"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:55:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:55:31 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 01:55:31 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:55:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Euvtu5JejplIKx+W3RsYL7DThvOUN/8nD76MiTSSHxmJ8JNSh4Atz8UkbHwUi1SlhFOR0n1W64LREse172GouRKyLc+fk0utayV6Iu/t0IgWPtsupzFzPTwfsa+gknKlsvXUKTTJVwjauv//jrKBYI3Gyl/1DLO6bXwM/h08Uwj6ss7Ew2mVk675qVIwaxn4nYOfZDLJv12lVkGx4BWJXxYajatVZxCCRsUUisP1au8myFRroqEHU+QYpMIzTUFB7Qdu7etI7v7t38hNZ2TRsCs6MVgJqdJ1E7IbM+AU5nBT0GJFy6nO65qmRYWuTlYcZ5VeAKtR9iyq4YwncOkwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86NmHDZ9biD6Ygt1mq8l212umu6O7uOUBLWggwpkpMY=;
 b=F227tNBe6lBhaanghumfQj20iOwgPpe7pjVt6hdHOTHtXLTiNTY1gskX3Xt/1T0GCt5LzwFAh7aj7lEvrQWzUu1AYhljq92WZBYh4G4XiPlLzUqnqblEuDhTfzmpvQQfLz1lZ5vkl5GXYAFPnkrKlftyyBchU1RlRJhB4m3bzurTai/IKHaWicmJia9YmfR2+ii4EWhq/M22u8NoJEJOtvxNMfrFGoCCWGL0NgMhAzmEZeSRxvhftPMS1S6GqesOZEjc2TC/VfjxXitKq7xWSHUHRLOCKiSG5dFA95cUNbuetZmXgLvtWZYG6t91eY7DctDqrb1zWdLege1gRkD0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 09:55:27 +0000
Received: from CY5PR11MB6258.namprd11.prod.outlook.com
 ([fe80::3aeb:4e49:6de6:9ee]) by CY5PR11MB6258.namprd11.prod.outlook.com
 ([fe80::3aeb:4e49:6de6:9ee%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 09:55:27 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Takashi Kozu <takkozu@amazon.com>, "horms@kernel.org" <horms@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>, "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"enjuk@amazon.com" <enjuk@amazon.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 2/3] igb: expose RSS key via
 ethtool get_rxfh
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 2/3] igb: expose RSS key
 via ethtool get_rxfh
Thread-Index: AQHclQxpJN2NrEH3J0G5+CZO7nSsUrWWakJQ
Date: Fri, 27 Feb 2026 09:55:27 +0000
Message-ID: <CY5PR11MB6258EB0F88693482A34D93088B73A@CY5PR11MB6258.namprd11.prod.outlook.com>
References: <20260203125417.37285-5-takkozu@amazon.com>
 <20260203125417.37285-7-takkozu@amazon.com>
In-Reply-To: <20260203125417.37285-7-takkozu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6258:EE_|IA0PR11MB8333:EE_
x-ms-office365-filtering-correlation-id: d5b1c34a-f1e2-4385-2c9c-08de75e655d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: /UDhOkY9hhTMBjtz0iVIHIA2zcrYu/bwFBzYQOpyLbhBJ/enJyDKOF3wtNILJusECs+XOFVW6OsWqFpOEb+8e7rc3jGaxNcqFhsPhgJEYa6NdpTAPbafM0eWwS6NDGD6TPuYBntu8rABC1+zubz4R0U7TkGOY0KZPV3a5LFVjWDSZD1g2nB6kdh4+iWu5ZMTXVudlZbF57z47yOSgMksikhcUGPIDE4KWOLHAugq7FY20znF9Qm18Rb8HMH0yFKn7v81W+U6O4yI7sqT7RylZwUGAXoGWNwx5IOIbyT9WaaBZJHe8vjKozx/Lq7aadaMrO6qAA8e1JO2Pql9q+kDnf+/Qoe7Tj2T2jBJ2v4M4mC9CRPFSDbPPn5rsHjjj6ubydyla8u1fEwNHPj5SDhzab5db1vIHd4fcMskUM6xVeR0FcSsMMNrL+KSWLkBLr7gAiBuFo8YRhHu0tRwdy68VMYhb3Q0ed+8ig3knJddWHoLuF3O8jINbW51e0IYN2944E53ONHDZytRPC2nUzZdZzIQbVZVSLQLsmqZcsUg6OgnSKCzmzSMuasTi3J14wIZDzAVmG2/bK+OEAsMc9ddc4wD36aYVBORPyQaDj5ApyiIHD5KjXcb2DGq74J4lTo1EH6re0FAXEqKDqcKk+hmpmaka54Ug43RlANAWGg0hogNzl3+ta7iFj+Qgc4Mr0JZHv2meVM0ArQ7eKhW/l5bBHT7Pt7+bs9eMA9kk36oMYHDQVAQ7MnV02f+7sZGF+W/otKbDBmats0mnEDmFc3xjQBPAUYiELk/IPM4XzbF+jw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6258.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nv+AcDhWxWs4fUAcohG846jBWRFQKesjuroQ78HkCMJl+tIugxCmyLRtHaTU?=
 =?us-ascii?Q?RIgsrGBYeApyi577jctlqqlsgHsWNItY5Q17i00gqG7P+mS5qfuDd2id2ukg?=
 =?us-ascii?Q?H22BgS2izNLcY2FCbWpCEhIo7+ZFgCMX6zD29I8Qhn/Dw293k35b7ZFVTQt0?=
 =?us-ascii?Q?6UZtAC7ak0UAdSVGilZv3crqnMPmj68MFuoR/s9ZaZyAXKyFuAQ59T+/Lzg5?=
 =?us-ascii?Q?9oPmg0H32t7Wd5cbBVlqvGxQIi2Ru0MwpJe/nncQ5NCIL1tY4Ik9WI2ucSxy?=
 =?us-ascii?Q?s5g728UJdkwdNhtz1igM0yIAUkLvVs5OtjH/JZ+yFFOx9qmlBPfpqYOJ4AR/?=
 =?us-ascii?Q?57y7uY55vAsfeZ2IPItOYEbZPsYNJ6sUFTPhRHXkyujUoxETlOvgKdA73cGZ?=
 =?us-ascii?Q?XvGIO4gnyF0kxMJc9pJb8vWi5h8YrVEeQ0IrzWOFEiVXj0JlO/wSMDCxflDf?=
 =?us-ascii?Q?AtV6WWqoMND8nbgy6E/gsmu8xQd5WVmNsKj2YGDak4xsLJnE5QKHBQT1w6v8?=
 =?us-ascii?Q?4+BSphG2/apQrZfsitemnFs1ql1ovMbY4r6cZPezXRQ51LHcmzS37O8gTZ6X?=
 =?us-ascii?Q?QhQBWPZ8JJlWagZtgwe3olvVOCfwAkvXNGO4TtsWghAzoZGDul5AWeU0xSHK?=
 =?us-ascii?Q?UYfJa6Jef1TwC7y3pvg66+67NFsuQpIDyZJcn6h/8ZCga8SaTVE3rnT8GdaY?=
 =?us-ascii?Q?/BwNcqifyTXP+Dl1n9FGA1VZ8kgXo7xdLmYCKoXGbtOcUsBSf7QxOmFXZJQp?=
 =?us-ascii?Q?WCiIEBie4CbswkeQajl4hu9TkwWFnSi56Qt4uk6L+9STJuUeBPmYmZ9Z+QZs?=
 =?us-ascii?Q?gPFzsoePVa+RdPrvmaxHUz8VesbLBxNBoEN/qBnOdEji1hmH7hbGCX9sIi9N?=
 =?us-ascii?Q?hemSYeJiSoDSs3OgEOeqO4GLP/GF8a/AZtzCbmVkiT68yHH6SJ0POiAxAoyt?=
 =?us-ascii?Q?nfkLfGtXOZ6f15OWyIu7tftmMfOhliUxirPOaXRh4K2pcuq9VKORer/hYcrR?=
 =?us-ascii?Q?uDlo5r6Np23MJwYuDCIICgLxqups7o0PZZkbKAuHiv6ux/guIc1JbeyPd83O?=
 =?us-ascii?Q?KctKKAtDWNuKFb7Oy2nNaF+T+EpOenhgezozmupPESmcHLmrq91eNdxgdMy6?=
 =?us-ascii?Q?VOAkxumqHnIoAv9xAg8xVm2F4/xf8D+zffhpn+OWsew7MqH+zrfHD8jvVKwl?=
 =?us-ascii?Q?7kK3OSfGt48LK/nGzVfb5x5zXqA6AZg9CulHKKfqrewT+VkmqLlTZNvAfKGL?=
 =?us-ascii?Q?h3KrIvHRaprmwGu1BEAL66xwoj2YoGvm676h3nNwoIvjEojGdD8TrPtWvF5l?=
 =?us-ascii?Q?xZ1Ra1aiXdvAw3KZ5R124zCFun9XsErW2ZIK8yrKiXqBRl+n0MM3pleMod4U?=
 =?us-ascii?Q?2wQ11U8C1I0E0y2LxTr8BDGhwUQuIMaS/VNqDsq0GxFo0BdYUHqg6VT0/5iP?=
 =?us-ascii?Q?3j618XwtuiFBRvvkT+r3afBT2a5TSQnRhzEdawmHuEvshncDPCde5cLwrwwv?=
 =?us-ascii?Q?bPPsz0yRnPRYQ22bEe+Z3EyB/bktokb3Zy9HboUH1TEgsfWb0nMs8bxJ/3Cu?=
 =?us-ascii?Q?ttc6rNN7q17LDDejabXx8eeqc+xYt8RiTAwFlgH3gEabssqZ3UxcehoS8ZYX?=
 =?us-ascii?Q?btVY00r522ohxb5qfBkqzihneF0U+3uzSN7VnCyq861QDNxZ+WhehjWoAaSv?=
 =?us-ascii?Q?VhFVR033KC6majxd1VtZ32r+PDhNoRvhHlGlR2TV4XqOw5ZJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6258.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b1c34a-f1e2-4385-2c9c-08de75e655d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:55:27.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C58CVj5g+YsH9kCqbCwJQ1epT8tT0yCsJwsxz8ni8nW4MQyFkLYGfeAqdDEBmUtFfjhQeQ0RqrWhiHaMZ8oDgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261804-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[piotr.kwapulinski.intel.com:query timed out,horms.kernel.org:query timed out,przemyslaw.kitszel.intel.com:query timed out,pmenzel.molgen.mpg.de:query timed out,intel-wired-lan-bounces.osuosl.org:query timed out,takkozu.amazon.com:query timed out,sx.rinitha.intel.com:query timed out,enjuk.amazon.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 50D431B5B08
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of T=
akashi Kozu
> Sent: 03 February 2026 18:24
> To: horms@kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@li=
sts.osuosl.org; netdev@vger.kernel.org; Loktionov, Aleksandr <aleksandr.lok=
tionov@intel.com>; pmenzel@molgen.mpg.de; Kwapulinski, Piotr <piotr.kwapuli=
nski@intel.com>; enjuk@amazon.com; Takashi Kozu <takkozu@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 2/3] igb: expose RSS key vi=
a ethtool get_rxfh
>
> Implement igb_get_rxfh_key_size() and extend
igb_get_rxfh() to return the RSS key to userspace.
>
> This can be tested using `ethtool -x <dev>`.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> ---
> drivers/net/ethernet/intel/igb/igb_ethtool.c | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

