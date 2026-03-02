Return-Path: <netdev+bounces-262764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHraLYHLpWl3GwAAu9opvQ
	(envelope-from <netdev+bounces-262764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:40:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A0A1DDF20
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FC0A3046DA6
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FCC421F07;
	Mon,  2 Mar 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0k/JpdG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6B317158;
	Mon,  2 Mar 2026 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473152; cv=fail; b=Vvp+5dq2jv5jqdjIxL3caYvDh9F6iPAjqWINsh+Cz2wbMJT8hEOJZirb0PS/sG3KVcT7F8/DAVtY/s8ZfRstfy8eQqiMtkaqFSWghyC8wA0+Tzsk5cLZb3s0CbeeEj4kF3uxnIoITb3xWxNiQ9NFBc+gn7DtRDzOoSyUeJee0yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473152; c=relaxed/simple;
	bh=bW2t8RqflZ4tLUwqBTi5uBfYtzGjD3cIbYv6ijzTClY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mufed2XlQz6eePFIG8AnQkqqQ5Isi5+ZaVhlOmLpJVF+B0f0qmFi4x3dGACdQFOCRRzCY4dr4WIwxTT1xJNv/yHsuYB4kxuWmK1JBMWip8utkP5O746KVrw+k0686DeLTK1TuEX8ccdsv6GIZd703sCz3wlEOri+wiTqjGSVqCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0k/JpdG; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772473150; x=1804009150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bW2t8RqflZ4tLUwqBTi5uBfYtzGjD3cIbYv6ijzTClY=;
  b=e0k/JpdGWJgqISpMx5Oqy2RqHQNacJaKskT8pmjgzAH2pyk79fgLnxKK
   Y6xqCGdSIE1dKERMFgIoKgF9d++Gh4ux/nQhqB/PyJ8S17eOF0582TTK6
   BZ1CRqN+U33uN/cPd+aldBtpxlrBp4lTWhKYpBulzMVUU+Iftufm9lnjs
   mU51rUnqr01rObcPwXQ2FxhXyK29Wf+EvXcuhXDeZUepneSG/D7WA0uBT
   KGKWc17RWN+8/ftJfErEWifNP4elrtpOkVEEnBc9ChmNjqq8CoLxgi2+U
   7AAnjarDLbz5IQNtFuQ82Snj+BAAsDe95BcyR4WO1shrOsG6t4okEAECa
   Q==;
X-CSE-ConnectionGUID: nkph3JPVSAuYJll8t9uYpw==
X-CSE-MsgGUID: eywjz8ZXQmOawomi7tYMLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="61060898"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="61060898"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 09:39:09 -0800
X-CSE-ConnectionGUID: l9zQ+g7qTAu9NMqoW5nGlQ==
X-CSE-MsgGUID: QS0F/vtnRe+l1kiBbhoNpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217642111"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 09:39:09 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 09:39:08 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 09:39:08 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 09:39:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmK20CVEh2zmOZj1MUX8LaLKkp65Mib/FJZHxTwLc2aF9NZOmdKqSlRHX+MW2obPAbGQzZF1Vnu10HPiHYlQl3PP8g6Ere15mO/wZX06SPVtOgLmWJUdvhO31V0BuH3oD2WB4Sd3HAfSx/ZXDlzwsaV8JT9kNSS0Zjtjhsf/EuRI54SYkbrS8iU0d8vV2LcsdCIvayPZKgd9hWJMHFhmFDROnuHPhrcsirzGOo7E5ZBgdC8YAJNFzK6Zu1w6gUgUjI4skZxbtlQS32ye9Mjb/jaxacJ9D4G9/546Sb+PWhFZAhPq81eSo6dSlHoW/GfZ2A9cF6VqMq3sTeh50DMG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbknvpZmYdn1U+axNtCIvQms2laX/IH8DzUQt3qSeac=;
 b=ofTYJJIN01elCFRYa8vbu47yvgihDZU/2AlvK/TXSq2ySSMNXeRSQHbd4wTGTwnbupvE9dHVmqR7s8MNFXp41qGHC6a1KxLuiQCTJPI3mMtmDdI1muwkUjtS4aMp9Wst39b2Mgz/wmngq4czF9rDVsUtD+PRGahZWzzNCqJeXHsIb6ioaMtKyICTfyGIs6YZJZuk5ZBiSP4X7MpAhyd/i7M36N3W3ZiBKYJv6sm9GsnFjS0mHMKbB3F0AlP4j6CmguoCLb/Ov2xgOx4Zu8vxTDEfgFwnkn7gMneDMQKGOLipWZympTN49eu3JA3Zk4MpLdd1er6WhwL6DzKvHflyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF6806D69E4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::831) by MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Mon, 2 Mar
 2026 17:39:06 +0000
Received: from SJ5PPF6806D69E4.namprd11.prod.outlook.com
 ([fe80::16a5:1a74:21d8:8e3d]) by SJ5PPF6806D69E4.namprd11.prod.outlook.com
 ([fe80::16a5:1a74:21d8:8e3d%4]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 17:39:05 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Slepecki, Jakub" <jakub.slepecki@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "Slepecki, Jakub"
	<jakub.slepecki@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 5/7] ice: add functions to
 query for vsi's pvids
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 5/7] ice: add functions to
 query for vsi's pvids
Thread-Index: AQHcle1Gmlar2l5FnE+VR48JAPiMoLWbqvfA
Date: Mon, 2 Mar 2026 17:39:05 +0000
Message-ID: <SJ5PPF6806D69E43B66FA095F3B8BD8A4778F7EA@SJ5PPF6806D69E4.namprd11.prod.outlook.com>
References: <20260204154418.1285309-1-jakub.slepecki@intel.com>
 <20260204154418.1285309-6-jakub.slepecki@intel.com>
In-Reply-To: <20260204154418.1285309-6-jakub.slepecki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF6806D69E4:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: 6c481cc4-24e3-43fc-0a7e-08de78829a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: T1Yd7i1ks2nmuS23OoRrhxhUStReTKIfC05MFkHwPLJv6bNI0WL233TY5Ts4qENigIsvUFrcJWcdwrFWsS/SCiyfExqBo/ttws298hPfdIh7hKWKvrdj4C/TCz+XoleqnzY1LSyI3PMB7KwY9z2C2IqRNzI2LN9MBewd1V1yk+yXda2+SmkB9uVd2lplcx6Ga3OPJeUC2ZRlnUA4DOC+wQTsx52EPzFtUN/7Zvdy4FlLKXg/GmchFq5eouAuOPRYMU93D9w0OANPzrUK7w3T4Gp25P3T/HQcmsa36vy5hrPeamxnGHnIlrAbmxCM6qw9k6R57/+W3poYoZxsz4QdLKuooVdEX4vMVSjIxVvc3pvXehwgxNMOY9Z5/s+x1uVtCjdtvGtoJIBYSpyrHPBQ0POCnp9jQQjYFKflNGP5itJOuoV7cK9Ze425bFr6wZwjFRHWS5cosdrC5ZmHGsm9ivOd+v/WXYWFiq5lVCLh3S0FUVYLqdNfbaAKU6e+gZXfAxrto6QHw2M6nZjJ2QoZ+O1r8x0W8wDtyBZ4mU/KOdzkNyDaabdddf7LYt3xvOnnbT/h4W8VXxP2ybTri9Uh4gsvX702sJ+prs20CNNkUZiXA/Cx5K2FGGw1Xp7G86A/+Us3X1l1E/Vi2j8EyPK4tUv4V5xyCjS2cziTBYxhivet+9MoW/4XsEGUfxvnjIarvoajCTw054E6XOYY/4vj1+bdftMWIgL5Wb8bCQ9HPLj/wHTmZy7Vjthtk8bik6o8sJf/MJoANb/ebLnl0ZSSuCfkymiVThJWdET1oyw7upM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF6806D69E4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x8raeHOhSxP1EA9faHJ1LYZvhu7HV/ZEADfQ8ykm46gG1RljamAHrYs/jxYR?=
 =?us-ascii?Q?U+3KkcylSe2dQKTmfpg/OyHuLAKWEyuCzbWOLECHTIdgku38OliRi7GDeNKQ?=
 =?us-ascii?Q?4v4aW+M23hAJJsAzFIUrSG/F3HkxefEBxR4v/7JD9HhWKB+n3cy6Uz2cNAJ5?=
 =?us-ascii?Q?xd43pNIJSSPgp4pXQngUL1CNhdEhIZr9zaoqF0XlsW2bxB1UV1DWLZhVIOJx?=
 =?us-ascii?Q?SHMurBuuPhSqX573V6M/ma+75d9lvojPrj/J2MaHQyfpfv1OMbfQ4TvUlh14?=
 =?us-ascii?Q?j2k8187Cc2QSOCuXHBfwEuspBVNEodSqmY/WDnxoEE8Bv+xO81rTiHRxEPTA?=
 =?us-ascii?Q?5/OqKC4HUdV/9Igmjm4iuAKEDBdyhVXY/PCErwNgIlSMR7e8hXoKQ+ia1zmv?=
 =?us-ascii?Q?vw9Ho4zm8OrceophK762vmZkn+u4Eb46kvUVpezAWPzk7V48vrXFooDdBDHb?=
 =?us-ascii?Q?+oWQZi2JJF7XmeyyQyQ8aWwDIdlywFGhDhQmlQqN1Ulquo2sfvh/gfQxsq4Y?=
 =?us-ascii?Q?wtmeUlt4iAsymrDjaPoSVrDWu1gWPzi/T7xE5u9i1z0S/Iavw1ym02umSLyd?=
 =?us-ascii?Q?olZxc/T8WICumT2X4SI9AYtZhggODK0K9Jsr6SBFG+eLpzQC2xgHefgGM98I?=
 =?us-ascii?Q?FQS2ru90bzKE/LsTizXVHmvf+vJ0hepESnRFomZinHSk5A4qYQpkhm6fHWbv?=
 =?us-ascii?Q?4OfeoYvUC0Gwwb1SxynSR+dbwYZbf6ddXSVLqWjkVeoiTIUO7pyzdflMT0mC?=
 =?us-ascii?Q?MvRhXtsE12oLO++DI5Q7BFd3BejmgmXo+i5RLqlDMKu3CHtIt69iByJwSAki?=
 =?us-ascii?Q?Fmy7AkV0BqameUyfbfCOSXoEorhax1ghzG0cFGlsQR45EqhWm3AhyBLC5Qdw?=
 =?us-ascii?Q?ZIDbS71nJlG4lc2ar1UBSCrWxfXiCga3qoeRBW9pjsVsUYwbq89XKMtFkby0?=
 =?us-ascii?Q?UG1er6v1feUSg5kw4Qoqhxplb1AMccb8LPyLJM0jBBW/75l2YUZIj49mtHTw?=
 =?us-ascii?Q?GJkgjmExMxgJGBd0eZnOwEA0hAwDfaHTn8XZ6U62H3r5NyWWsuTUC3CCrHqs?=
 =?us-ascii?Q?W7K7NSb23uf/HoiN2p6Ixy0EgoJu4L4jL+HGZ8RihrCX+Wx/qGV7b+Uu/yCe?=
 =?us-ascii?Q?8zZE5LUMIw3OWqB/OqaHWxjrSoWzEhEE2T7s0KsFkMD4NRHCYKQAuToVa5q/?=
 =?us-ascii?Q?MvEn3SO01aAfjo8/fctQwQ/VIGHKhyZKiFRJe5Nk+9RqoOuv3TSmJ0xdrPL3?=
 =?us-ascii?Q?S5M+A2O8T+8wd/tI3nyGdg1FX8KA4j8Pe4eRRAS75Pu/aYqm+BltpI+vWFbb?=
 =?us-ascii?Q?dh8VUM0+MJ6TbLN5FFcRNYZB6obq4ybYO04SWpVEs1DJBbvmQjrEGgBQk1Dw?=
 =?us-ascii?Q?qc1VRtSOKQQ96xBf7uDj9jbmYksi04ryGPhcIf8ANYKOFBvjNybZtAbksr3g?=
 =?us-ascii?Q?pACdxv2Zy1W9NSLgNcoAcTPLW+y4RbY1SSgeSrKby9hBfkkMay/T0MRmOx52?=
 =?us-ascii?Q?ryWJyvea8149PDJlpsd0iX1zzpmn+NYWXnIBEo13jpd6e4/VTIAPDvlJiWby?=
 =?us-ascii?Q?hhL1b4d2siEuR/9fMEno5GT2W0LxSoimUvLdbTgKRhLD4LRvh8ZCnvg+smRm?=
 =?us-ascii?Q?hri7zF4UMQAJwn2i1iSbYqCKfS4+Qv+2qMAXc0IOMjttfu228Ml1k1JsBkf6?=
 =?us-ascii?Q?gN5gqxM9Kp276/OWShGckH95LUwTArQm7o/qYKEz/5XIpZGuj4Opk0sFUWgN?=
 =?us-ascii?Q?bXreeB6Heg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF6806D69E4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c481cc4-24e3-43fc-0a7e-08de78829a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 17:39:05.9132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F02EizaNixjDiSjeXryhJDUxN7nZcmu1WEC+1mzK6o4MQzERm2RqMA9elk7pzUJVwgGu/LpBjzKVblEW3l7LCUwKPWWYaP3EXOyIBEZIcSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 33A0A1DDF20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262764-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,SJ5PPF6806D69E4.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
akub
> Slepecki
> Sent: Wednesday, February 4, 2026 4:44 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; Kitszel, Przemy=
slaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; michal.swiatkowski@linux.intel.com; Slepeck=
i,
> Jakub <jakub.slepecki@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 5/7] ice: add functions to =
query for
> vsi's pvids
>=20
> PVID information is set across two structs and several members depending
> primarily on DVM support and VSI type.  Add function that guess whether P=
VID is
> set and where and allow to access raw VLAN ID set.  This is intended to b=
e used
> later on to decide what MAC{,VLAN} filters to set for a VSI.
>=20
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
>=20
> ---
> No changes iv v4.
> No changes in v3.
> No changes in v2.
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 56 ++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_lib.h |  2 +
>  2 files changed, 58 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 041278caf8e3..ff4763cea2e5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -4136,3 +4136,59 @@ void ice_vsi_update_l2tsel(struct ice_vsi *vsi, en=
um
> ice_l2tsel l2tsel)


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


