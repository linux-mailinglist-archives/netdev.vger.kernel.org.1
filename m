Return-Path: <netdev+bounces-281725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIc7NhZ28GkMTwEAu9opvQ
	(envelope-from <netdev+bounces-281725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:55:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 403FE480ACC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 690B631EC98C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137713D47A6;
	Tue, 28 Apr 2026 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boNQBXoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE433D75B5
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365278; cv=fail; b=arax3U2hLJnRTg4+HQ36O1bjTNe4XQ64wad28aXZnnEmNjpcPxPJv4p9TUTzoVw7o0XE1U3z6wADKENjG9+1JDe525HTiSfOiW8FFWli74tRbnb7dxEhdHXduVAWJWQcsE8h4qg3myPWzX0qpuYidSO3HXW9a+78ifqHH3HETR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365278; c=relaxed/simple;
	bh=kStV6PrHGw1TcoUMh5r6YcOsSfBevvp+zgDvmZEJDqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SU+aKPJqQLYNP1SRi3lETMxPOf4v8CpFx9k3qEHAnKqtXZVi7kef8DYafSf0XMSTv5SbLCQWKDVuftdA3JKsaqVJltE7ic+sS521auQEbxqAEb1BHRSpyvJ3UAedVDALJ4QroyWSgUBmAN0gXk292eju/n1FgsyRxzhrHpGHBMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boNQBXoJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777365277; x=1808901277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kStV6PrHGw1TcoUMh5r6YcOsSfBevvp+zgDvmZEJDqM=;
  b=boNQBXoJR5Ys06W96be+pdQ/c2sEHghI7GvEubE56hCli6VxC5mYz3HR
   AYNMtAkf7z1frmqihwhi3b/p3C1n79NCWwuYIUIgj7+BVkAjwsgAGB+ik
   pA7RNOj9Vc1GOFBGOpFRrFE4ZV4TY5QzRLeZLzSQ4SRfjHTrKOuYlGUFl
   g/oiLR4LAldjm4V+g1JrEAV3YpR8k6ix4j3V2QqWyPkIO3LLJc63oyqGU
   yqS1yD8TWry7kQl9a/cUswWGXMTChoYFv49xdN+QEfI4p1z1Kw93IkxyE
   A7zUbCdBn7kzkryi6VgEoMEBW0ASUVAX1yCRD4K5zXYfREs44tYHgCWeK
   g==;
X-CSE-ConnectionGUID: DXJ1N9wITUmz8rJzPif6Jg==
X-CSE-MsgGUID: 7bhvcFl6QwWZzwhCq0CKsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77432053"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77432053"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:34:36 -0700
X-CSE-ConnectionGUID: Fw9PWAhQSk6+NAYXRh+Ggg==
X-CSE-MsgGUID: XsA5sNrOSTWNpiwKQTKqWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233024216"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:34:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:34:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 01:34:35 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A19sWG6v4GRyZwZiPPMZGh5nEDpqY4HHfD521u2eCdy2x3CMgNx/d/Nc345rEkA9E+4XAdPl+GeDycbN5kVSLZDjh1xqJrVNJ81MZUekCC7gOospzdwAb3Jyl8QpjYEg3sxt638B0CZTpyr9ugU0gnFTb8A3eAq/2seEFZCJw3AyBbcxAbjkP5XsvSYKBcVYb+dqnLqaYAV1LQwiSERy/5A4zGszTFCYx17F9pLbTmp3tN2uiLRq9PAmIg9dpM582bylgs6BE52hwID7sCSfKaWRyzcjTyA1U0OU8W0PRlq60n191D+mJCuBfSKcYOK6YkztPuwveUE2kzGqhRKpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yPqSPU+zpFri7zEIzZCIcKbfJIhVUAE3DZ1yimFiJk=;
 b=XDaw7a1rYMLR9MV7OsgPMRxrOZMuL5GFulhZhE6d8tw2KzjaoVk+92dbAfYZVYMDFIpXcDwgQ+nTQUMMtgkdNyP65lfZi/4O5i/VkeXVK7aLtTehOFHUc3e8Pg8luwE7eOKrBepVKN6jPEE4LMVqWDysvhDnw5nB/t5aH6W25toYvN7i+9gFhvDztD0ZkKm/opbWFkns0g+2igXxL2L6ZlXg/NsAEC/TnZ752Ex4fYGavpIBRz22uNUpxEoz+X357wlxSq2qp1r7W4DfpAqDq8Suxa9MpUXfVrvMESXDS43A/KeSU9gOpU+gqOULBtrM/e0ZIH0s/bfiX5r6vIUUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Tue, 28 Apr
 2026 08:34:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 08:34:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jramaseu@redhat.com"
	<jramaseu@redhat.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of
 IP/IPV6
Thread-Topic: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of
 IP/IPV6
Thread-Index: AQHc1uN1hU7Zw/f0VUOSnLwRTMNKvrX0HC4g
Date: Tue, 28 Apr 2026 08:34:32 +0000
Message-ID: <IA3PR11MB8986F4B08B9F49914B0B0A9EE5372@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
 <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB4966:EE_
x-ms-office365-filtering-correlation-id: a5ca929a-f9a3-4e04-6c86-08dea500f900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: ada3lwfqMSjRY8Gu8PZOPTp5Acbsn+BrDTi8ZIYcfgqrzbvHZarfNiYQR5FxzcOfS+vJtMCQH8kUpBpZsUFdLo6nQ6p/BrHMKarKtdHbCeIIB19A7mmmR8ktsfam3A1Fh3lP3wva0BFY7zlETUUCfqJEs96dw0tIaf+wWIIA/4pC7ROCrpnj4kjAvMEbp2wuRHLQfX+2Ntg/zgwm3WPb0iyG+eXbuoeJD32tmHnok+ojA6/kQ+0irTAGD/0KW+uMAGq2hM3036Z4KXYSciDyi3TQ6CawuENXFY7y1VtwPah2Qgdi4OsttGDuEmB113fFvH66FSf1G3BNuW4cHVD1VzZzy7BCD7GcYnXMwOqO1nDXBA0ogfUQo+KlzkFberggLnGhtLdNx/rB+V9/AalBLfVkD3U5ABPZhrrDmY2j5e5DtFo8XL7XpaACjMdDcsyOvivlRByvjQnHCZSomAlSUwNUJekLW+jc2kOt/J9Mcfn5B7jasZ5NKRTv22p4smCPHRD/IFDpo/Juvv0nbex4TYzWVPZvMGtd6fqGvqJQ9d+2F953mQXOCxtcgKU1lbnkutmQAhP1USzYI9wZqmHaJl66H9jJtkOT/Kpo2vPINl/CH4h3pmzUJmx2boy5WX6ddKHBjoD85Ma65jyzT269Engx+2IPwhF+MnFdvgnJLMNuoQpIEg8/gD6cjeYIBeT7AR+CejCDgTkyVJ3+s3WgaCyE2h1cQCKZVhtqwfNnyZpykEiCMK70Q47QVqnhihzNoAoM3F9fMwgV3HnPuZh6ZC0RgFUKNGQ0U+ooc5o+Zc4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XgcXseEDSWvvEvKrpuezQFI+apd9h1ebLV0pKoGSBI0iqx1UUpfR7308V2pW?=
 =?us-ascii?Q?uzbERLwlaffDZZl63sdsBW5Ge+W2Jm2pYE8b8nRrjNbcmiW97/C1Ev0FQR6Y?=
 =?us-ascii?Q?pE0D1nmkNjjsrzV428ty8CkJbBKmrXpZalK0EmpfjPlELn0my0q2WT+Vs4DL?=
 =?us-ascii?Q?ZfbJ8mmpHC7x2MuYL8bMX+CDmhOPIugTl9B7at4t1Ow8cqVBr4C2X+yW76//?=
 =?us-ascii?Q?+To7MYQ1ZNJi6U9V/w0u65sLWle6+IDjKk6mZiz79pRcgINUGncVKJK4bvW3?=
 =?us-ascii?Q?0ABHpyO3W41Q7kLkN/7uCIwxTMvsHBLDqaQIDWzJctwdWL+ZVQNjFamAmG5i?=
 =?us-ascii?Q?iSAK38v2qRVoFYMGK2mxEnTiC6tt4tpbwsxPsrWVhQzVh5e0BCDB/P1M+p3w?=
 =?us-ascii?Q?ZsoinifeYUiUNGr6MCCkb82pW14V0owV/G+5ZWnjDR0VDPwlRh+sO76CMxLZ?=
 =?us-ascii?Q?BLYI/H2IwsMsbypcYxQp7Ak1VipuL9CJj2CpKd4MBwX2fn6RloefoMhCAHQL?=
 =?us-ascii?Q?f79IV+VQ9xfSKrOxpuJAckpsz/SD+E5QSECIZlPj4j3EAFdRFpKyL4EzNp3h?=
 =?us-ascii?Q?Cp36DNeZFiz/zH/3ozp+9kDQ7512Op1MEK7k/HmGnuNzALLh3OWbR2rxvghp?=
 =?us-ascii?Q?NPj/0NBWxfGbBJ5dnea1mRtqzWNhkZzb1mlWnyIF4g2bcK497q23oLHa4eiI?=
 =?us-ascii?Q?195gPb7pniW9gQgtDeEMSeKkKgxJ54Q9NtcRwq+9yaa1Vt5AEsADrOiKru/D?=
 =?us-ascii?Q?jKdnWQ0N5c5GnhqXAROnzstd9wWZ3T75hz3lphJbQsswbPRhHMu0cztzEge5?=
 =?us-ascii?Q?TJMl4VExpqySHIZFujbvbWuFiUl2ct14rShDld8YENnv+o6VQCr02SuDeiQi?=
 =?us-ascii?Q?8GNcBveyUtxzlcZ+WJbsjoWOqsdADA6mB2RDddv8AhtbxUOyYwfeZQ8Rt0DN?=
 =?us-ascii?Q?UoEwGVOCr17XSgmcrskOkhVJCj8HAsBqXbVz6Qb2RS9z1HtEluvEgRUHX95u?=
 =?us-ascii?Q?GJHsZwPpAQbgcVpo5dcxyUuhRl/+3VjmSJj/muqHTO9vVOOjvHrUnMYtIgsx?=
 =?us-ascii?Q?hDrhqonnaUmIGJzspgeQjad8NiT3DWCuYF3PZex/VD45k3bN+qyTfphn2XU5?=
 =?us-ascii?Q?nFLK3yif9WlOQAqTjcYh/g8ld5812f2UOdrPlk3803sebb7eBuixBlZWVA7O?=
 =?us-ascii?Q?nI/YTvBhShB2W+Ndtmh46N6bjauHoUlymXkxHUK+wZz4U36MwsP+LWfXjbjP?=
 =?us-ascii?Q?OoCUAhW/dqPSzN7FVWVxpLSSd46MttprMSooJX09oIze8ZaT6mxXmaL/3llp?=
 =?us-ascii?Q?t3LqjZlO9BuuNXZytKVJoNe0cnvwOAYL3iQfvPaUTrAW7r2G34LSL63xPtJj?=
 =?us-ascii?Q?Ur+NPNzxIEuWiCnIXKJAMvaXcChT/VKwc+Fr2+qimE4ANsY3blsRumX5jLXR?=
 =?us-ascii?Q?chRMXhrstsog2RmxMTx/QQrJ+vRejHfFt0HwY5PRYRI5rlCIux7d/rDXEDLn?=
 =?us-ascii?Q?Q+RUXROZd6mRzAya964mYROX2eFtfV8PVFyBAnv0GsS1MOwyAWmI9t2oSNAD?=
 =?us-ascii?Q?8aQSCGkEvpjrso+9DoReJltmhHFnGDPOxK3vYh1e+PQRB+EX1iYi9X3Evueh?=
 =?us-ascii?Q?XrsWZ6dqWVyoJVJnFug1QeywJY7mw4H7Iu3ySMDb0e9kP6wUiU9XAZ5WZo68?=
 =?us-ascii?Q?nHgF2DCB2vvlUHcKV7M80l6koLp3YlM/KZ0Aay9jZcxfX/Z9ATezexNiY2lV?=
 =?us-ascii?Q?hMDpMezQMoiICMtlqN5tGxL4NrszPUU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L9z5dtgILs5qk5ZLaC0BnwybFQVcdnHpsYdVVxABY1XLw/Vs2cy2sNq8IOyj3xHFno9pfTUDzK9v/Jw6mWCD70N0diBdw1V0igD0O++PxrYQWvIl17MvpT9rUFNdlOejoo1MH/e+l9JQcW+4Y6Oj98i0+Im7LlvxXRoIZpV92TFFiKWxsK1SjkthShRCNjsA3cEyFvJmUICOpZyOF3i0Q6wPezQnh7GkcJbOZjdq6Sk8lGyTN00/4owNHS/yG4wGqQujcRXFv3u8LRCxz4aP72zqSGTel3Y6b7priG2fxgShqsrPBp8t/4WGTqewaX00EspYPJZ+gI10zJQi0bpCQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ca929a-f9a3-4e04-6c86-08dea500f900
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 08:34:32.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nEh8xjf5SDmxlnEGK2hsJzmOZl2r/eVnhsvuk9ztKJ35gl9Idov1vMax6WILC6InI0cGsuPBx3O+KF1j53+KBT/eP8lehbIF4sClqIL4ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4966
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 403FE480ACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281725-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,IA3PR11MB8986.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Tuesday, April 28, 2026 9:07 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jramaseu@redhat.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of
> IP/IPV6
>=20
> The hardware is capable of calculating checksum for IPV6 packets with
> extension header. To not drop such packets switch from IP/IPV6
> checksum to HW_CSUM.
I'd recommend "To not drop" -> "To avoid dropping"

>=20
> HW_CSUM is also used in previous generation (i40e).
>=20
> Previously HW_CSUM was used to indicate that hardware supports general
> checksum. Drop it assuming that if the hardware supports it, it is
> used.
>=20
> Disabling offload for E830 in case of TSO isn't needed anymore as the
> check for TSO is done in Tx path just before preparation of the
> special GCS descriptor.
>=20
> The commit from Fixes didn't introduce a bug, it just shown that the
> driver is doing sth wrong with the checksum features.
>=20


Except commit message nits
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> Suggested-by: Jakub Ramaseuski <jramaseu@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6
> header contains extension")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 15550216fbf0..0f2f949af536 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3500,9 +3500,8 @@ void ice_set_netdev_features(struct net_device
> *netdev)
>  			NETIF_F_RXHASH;
>=20
>  	csumo_features =3D NETIF_F_RXCSUM	  |
> -			 NETIF_F_IP_CSUM  |
>  			 NETIF_F_SCTP_CRC |
> -			 NETIF_F_IPV6_CSUM;
> +			 NETIF_F_HW_CSUM;
>=20
>  	vlano_features =3D NETIF_F_HW_VLAN_CTAG_FILTER |
>  			 NETIF_F_HW_VLAN_CTAG_TX     |
> @@ -3564,12 +3563,6 @@ void ice_set_netdev_features(struct net_device
> *netdev)
>  	/* Allow core to manage IRQs affinity */
>  	netif_set_affinity_auto(netdev);
>=20
> -	/* Mutual exclusivity for TSO and GCS is enforced by the set
> features
> -	 * ndo callback.
> -	 */
> -	if (ice_is_feature_supported(pf, ICE_F_GCS))
> -		netdev->hw_features |=3D NETIF_F_HW_CSUM;
> -
>  	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);  }
>=20
> @@ -6489,18 +6482,6 @@ ice_set_features(struct net_device *netdev,
> netdev_features_t features)
>  	if (changed & NETIF_F_LOOPBACK)
>  		ret =3D ice_set_loopback(vsi, !!(features &
> NETIF_F_LOOPBACK));
>=20
> -	/* Due to E830 hardware limitations, TSO (NETIF_F_ALL_TSO) with
> GCS
> -	 * (NETIF_F_HW_CSUM) is not supported.
> -	 */
> -	if (ice_is_feature_supported(pf, ICE_F_GCS) &&
> -	    ((features & NETIF_F_HW_CSUM) && (features &
> NETIF_F_ALL_TSO))) {
> -		if (netdev->features & NETIF_F_HW_CSUM)
> -			dev_err(ice_pf_to_dev(pf), "To enable TSO, you
> must first disable HW checksum.\n");
> -		else
> -			dev_err(ice_pf_to_dev(pf), "To enable HW
> checksum, you must first disable TSO.\n");
> -		return -EIO;
> -	}
> -
>  	return ret;
>  }
>=20
> --
> 2.49.0


