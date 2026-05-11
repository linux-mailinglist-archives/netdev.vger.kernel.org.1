Return-Path: <netdev+bounces-286509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILrgKwaTAWpNewEAu9opvQ
	(envelope-from <netdev+bounces-286509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:27:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822050A184
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A677E307A3B9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F63BAD9F;
	Mon, 11 May 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgHtdobe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EFF265CBE
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487673; cv=fail; b=hbJaR6UfxiT3CGy5YZ0PCQCP1DX08CN8+k5lGlvl02YgZ4J4TAnFfgOzA8gQFIoxyITBatSNs3YR61b5eda6FxP8KODSFpLLgFdqiM9XGig//dGv2DR9XhHWxhD52LgIX4vWDqhAEkU9SeLoo4WzcbQfbfr6Vezqb5zTpa1XMTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487673; c=relaxed/simple;
	bh=0wNtSLAWm/SQoHJCuJg3aud2Pmhp2dHeRl9ZfSitku4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=We8lIIo94/NKehHukBm6qjQRvCxnK0ta+15PJ9F9wIShdwhHm6CBm1cz3KcJyWWL02g4TejM5YjVLwzvg4b8L7SW4u0r12de/y2dBtTa4UJHL5PN+Y/j8dvXQszizxpMY/GMzvKSmXJ/gNXQyGtKWKmk74SLl8kn+YLWx/PNohA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgHtdobe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778487668; x=1810023668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0wNtSLAWm/SQoHJCuJg3aud2Pmhp2dHeRl9ZfSitku4=;
  b=XgHtdobeCaoyYgwrhNvcVPwpzWfvKsuYMsrjzXjALbWXmI3c2KIFT5Lj
   lUAkmVcd1/hcYGddE1OOXn/Pf8gd1b0AG0mNVtLkrLkyFEr7CQoxfvea1
   XRZk67XnoJD1kpVuCONb6F8szKO90GUpgajPESdaXKKU+g/UEZmiHg1fS
   Gvn3usq6fKQyAmuR00ROr4miGVn6Yl3gKnwixVDcqI6ft4lrV1hth3MTT
   gDYBpUon+zSxlgZWhtmvv4EjUPToYn8GjZ+gG7sr8l8p7JzhP5ZpJkMKt
   J2Gyuofm0ln015psiyAASJA0Lh3SHlsjf54qdyPyoDrfv1qom1ceuoZl6
   g==;
X-CSE-ConnectionGUID: xiMuLSxGSQmEo/ulmbPU0w==
X-CSE-MsgGUID: G1StplabR2KK7rQndDbQug==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90745247"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="90745247"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:21:04 -0700
X-CSE-ConnectionGUID: pwZcQhtrSgq0CrRs0qE9Ow==
X-CSE-MsgGUID: XoHAx+2VSkW7guhkA3H5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="236409939"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:21:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:21:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 01:21:03 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZwTaQv/P6ErGZCUhtepbzgkpilXU0eEp6LZQSferqWOFOo8NOstzOQVNi67AodEP9HoQSTUjZv43ckRT8EaR7JEQGtfHayLSoCSAmfUTmMZ+8W9nPKNaqZjOFh+xiC0wDfvR9bFJ0w4WT8PIIr36DlMbdT2MVU2gcClyBNQVerljNJcow+Zt2MtdLUv/C+XOqtxA9Um9NMK65YYRa5M18YTkIDjhybq6jRXLzQw3YwNUl7E5PRr5w25KYnkReUGnPzzNMw/QnhNl88/TE/gP7W4i6/Rg2VaI3Sp/dvHZYRbkTk7EbByNyK50t5UFwkuqV1WX/eCVxBg8FbhDTlMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMgVFcvKJm6zMczKe033US0C2ThIxJiHEaZrSSSm+bw=;
 b=kVcGpymK4p8Fwtr7/b/w9YWYf+aixERa6NsysaTkI+HjBH01woppaM1V/G0iun6Dn5/PjMPd6U7xld8c/0fzQyz+4whSBzy6h8YO6D7RRbt/uwXTMOzJWXf23C+YAV4qlYSbWArJTQiGLglBv1m9/YZL12KEoo1Ur4X0bwaOt99Bi7CBcZzx6M+w7V2eqgX/TB7evOn4My0Tpj6NW5LbKSYBZoI2ph0dcDXKP4+INWdbzxcKdFtA8g9b+w5fZAUHz09Wc8cwltZVIdO0Lw10wHY0EZOLJhd5h07vt30o3PMnACBhqmJKQllJbc/nySSjzYQdQTy+3uPxIjvQI0YLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:21:01 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.20.9891.019; Mon, 11 May 2026
 08:21:00 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 0/5] iavf: five correctness
 fixes
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 0/5] iavf: five correctness
 fixes
Thread-Index: AQHcyxeGrpHC3tvSWUCA25Zqcm+GD7YIp/UA
Date: Mon, 11 May 2026 08:21:00 +0000
Message-ID: <IA3PR11MB8985A33AFFF2E661BED14BAF8F382@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH2PR11MB8816:EE_
x-ms-office365-filtering-correlation-id: ec8ad372-26a8-43f0-832e-08deaf363c3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003|3023799003;
x-microsoft-antispam-message-info: Xm7Igdc0zma33+rLBcqLg4v4tYwxN0Iv1Y+10kV84Xa659QW7YxyuYAw2AW0ERBOwdPO/Pco1LBlq0olGGmkV2FoZzthVQnvqrpMAsLaedw253+z3eicowtUsweKIohrT087O235XcGgbmUkY5hgbvJWChz/Vpw83DjOn+NOCHd1SugtjjCHaJTNVnMzwAc8CoOKWbCZUhytU7GCOq6hcAMbFXKLtXbn18aBun2fu7ozxeU1i2W5r4zX8W+CfmpUCPfMEFz068Yz1pbu5OE3hrib/bS27Pv4mm80u44KgIBQLqbFPMTkEjwF4DExPC9FmZ/2C83WHEaa8pFOkG1GzwoTHkrcj+cBFNNjGio0VVoUuxz/AF7lbEnMJaz3JdJUTlCoYTmoI85gYvtbMOfAF+Yw63MnDlSfjQ3pHqmgKrmCEAMU86uyy9lRWFwfPiyt4PIS68PnVx9gwdxWqys4qCh+32EGkxoZMoBVF2fNIi9s29BoMcTYZT4RDT+kB1woSPrLF3t5hfIpx5mQjfYWE15xUnC1ILXMw/8RO4+84qaoFEJW0B35/E+6YjDEqJzjX/WlF3XfNOCc3GqKF4rooPvtn6+xTW2r18fsPIiOTR033tBkO4unaL4l8CGu+0c0fuZ2Qmgu21gFl9iz970o9hpmZjjf5RvYd79MkG5t2wZCGTvXhhoPPML1pQAv+D4Hn3M0OsCw7xPWDpfKH4vr1ts/nZVSQt0Ct2vlGlssFeGX9fMZTl8HlQDc0gJc+Mfm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t50ijJLxvYqD3rjpC76NlpLQoh7Hn/+8RDGmHoJmKwPiWZOl9oSn3j7p/ynq?=
 =?us-ascii?Q?weQthmBm1CYoy3YfSpocQ+CdUZBtk5cKt4vmTGN2gNBBfhlqwl/aBbEPE+zb?=
 =?us-ascii?Q?SkdMGRs1tlKRix4Tb6dPBurmJFw8sq77IdkUG9mNJicU89xLF+7Ky/nG5niE?=
 =?us-ascii?Q?Df/5+YhvCn2/pAcpEUi9RbJQHLs0V+9ogj6u7thyc5I4LoNiNm+5PkN1d6Eu?=
 =?us-ascii?Q?7Rs/piC2ikgPpyuIIlGdphxTFFBWBvrvBMJetZBr3USKGidPtr9X0Oub9Pgf?=
 =?us-ascii?Q?gZ9faJQCqo1kDXGlYh81DNhlG8cG8ycezJBndyNMXNNTaZbDu461N1mHBEAE?=
 =?us-ascii?Q?6A7/SxWcehIiySRjw4W69NSxq4E803E9rQG2gtVA0DSUZApiFR87eNobj6HS?=
 =?us-ascii?Q?fNIGo9nVcxXVUI0/Gg0jMv4gpJ/KtWfBl4Fhc/OpQ7eYTAFTX0kC1sfNo2ZM?=
 =?us-ascii?Q?vtfP1LFBWEZqwKPxF0mJqZcpnKMRO/oCExyOKI+j9irp/filRdkP+AYjGW3b?=
 =?us-ascii?Q?OxUvM7cX0HbcpaFdP6gpd5z+WPxSadrYZ17K+gl+HW+EzotQC9A1RJS4mkYI?=
 =?us-ascii?Q?DXc56WcSGm1fV99XmT92aG4zREiACvw6g99LVVE+KoP+vbl5zZW8uB51U7OQ?=
 =?us-ascii?Q?AYzCF4C+5fWa9n4Y2+slwEvOf+gOSHOfBcy4cFtMQFtqWqi5XD8qo9PFeYXz?=
 =?us-ascii?Q?mYXzZ1Nh3hzL8s4uRkTM3UuPQwA2ADyOz1lrcyIN+CloP80uITi9MgRj100c?=
 =?us-ascii?Q?qCt2Ye/GJsMx3s3q+JPdGjF43pZMJaivbARIWYiRaaHzswGIFpWBxYaKW4Kj?=
 =?us-ascii?Q?Cn6Vtd6cw3q7EKORJaaYgu04t3q7Fvtb0SgRbGkccVO8QaodlhlNRMR0xgtg?=
 =?us-ascii?Q?kfEvqBHGAF/9eS8WEIApMI/AI5lIC7KWMSchzQrn5wjRSjwduwFamCXYl3eF?=
 =?us-ascii?Q?DzyGcyqUWLVvhoA2eQC7CvKbjffrzrFj2VZHlf+4Iu/hkaJQjqJMeS4OueRX?=
 =?us-ascii?Q?cPI+lJf/QSITI5q6Q5p6PXkESV1sV1Akvgm7RKCuw7ZVqkA1/yMU7ofm7E2l?=
 =?us-ascii?Q?xM+ZfjpGt9UeILP27Bt2OOl0/a+bVT/Cef/VLqHk1NXtEGjiKYloa2Shb6H3?=
 =?us-ascii?Q?KW9nNXYVYyXjhYUaQFUHH7dnuWOzT8LBAoOJJnFic5bFU6vlYTHe41BK9Qzw?=
 =?us-ascii?Q?p/1fy4VQ2BJngtSiqu5WgVIIV5xHdIqr8X84A0Pf9i8zJchKhDrkxK0jeabX?=
 =?us-ascii?Q?O2FPKZ7arkTvuaC3xzXJ+XVq+VWtgMJdlm1G4lEofH65Qk00zCzxSwoxZUpo?=
 =?us-ascii?Q?+z62J++5cEhDNqL5o2voyDOtwjkEvYodfg1nzIIKuZmT6VpXooSvU7kwSrkd?=
 =?us-ascii?Q?QG0EsuRoOeoJ1jyWPb40PkXxkfFRQQfuYjJXjkTz45f/NKMh7DV2uHxkMPyl?=
 =?us-ascii?Q?6Hf8e67XJHysMz4o7m8UhjrbikEYdL4yLsx0d8LZ/11U6kXYL3RN2G28hkIN?=
 =?us-ascii?Q?/McICEYiUZzDtKz4GKKgvqMtfhKddeuG3fwX7jPb9W9vVXzVXy7nfm/YNwrh?=
 =?us-ascii?Q?pPw6L0wy7MSG89LCan72/3aajILfVf6CkILVg0/Dj4EKNbqzY9S496pxjdCj?=
 =?us-ascii?Q?xwotBB/+G/7yffeixRNv6gGiwT5wJBELeEBqPYaLhFQewtnLj6/5AYuocOr7?=
 =?us-ascii?Q?b0loKG9blKYLvoGnxarZJbr2aUkyLb25Ya1mErgixbRn5jOmq0vVxNUWeu7R?=
 =?us-ascii?Q?bN+uOJXR7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L0piS+xZZVqZMj5xE4s+W6b2wjJIeU+0Kx65Bt0zXrOyGcZCqAPwMiqwci0l3AnI5150VefErO+r8OWxkzcpPIAqR18gw/dFtNMKVpqB7s7/4O7kjFYzavpUHpifBNIc5ek2vfQeVSUoLkLm/H7iJXm3X9mHeNHYXGAn5Cty5aVnPKH+zq5yuJegw7fS3rNc87FQb8rQj53C6fkdUdeYACr7jtbLNbbKYnZK4aF/myQtPPK+4r8WJDeI6bp6T2qBm8vNBwlIzyMdajetw4ITc1sux1PnmZi21B6GrqhXD37TNToh5eg8XZqFzIEgvAYML70mOFLLtVMeF843uUDK6A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8ad372-26a8-43f0-832e-08deaf363c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:21:00.7003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EEKSMWdy6LlSe//9vrJPfIxeekVTb8J3lexlYcJRMhzrCZQuWmIOJanU0onXt4YTZ0bj/i3sWEldV4qtaKDwvmLTCE4664zMDXHa0ESTN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1822050A184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286509-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8985.namprd11.prod.outlook.com:mid,osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Aleksandr Loktionov
> Sent: Monday, April 13, 2026 9:31 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net 0/5] iavf: five correctness fix=
es
>=20
> Small batch of iavf bug fixes.  Patches address a NULL-pointer dereferenc=
e crash
> in the hung-tx detector, a spurious free_irq() call in the misc-IRQ error=
 path, a VSI-
> state-corruption race when ethtool changes ring parameters during an acti=
ve
> reset, an inverted TC-boundary comparison that silently steered frames to=
 non-
> existing traffic classes, and an -EINVAL that confused upper layers when =
a TC
> flower filter was looked up after its qdisc had already been torn down.
>=20
> All five are genuine correctness fixes with no functional changes for the=
 common
> path.  Best routed via net.
>=20
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> Avinash Dayanand (1):
>   iavf: fix TC boundary check in iavf_handle_tclass
>=20
> Kiran Patil (2):
>   iavf: fix null pointer dereference in iavf_detect_recover_hung
>   iavf: return 0 when TC flower filter not found after qdisc teardown
>=20
> Piotr Gardocki (1):
>   iavf: fix error path in iavf_request_misc_irq
>=20
> Sylwester Dziedziuch (1):
>   iavf: prevent VSI corruption when ring params changed during reset
>=20
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  5 +++++
>  drivers/net/ethernet/intel/iavf/iavf_main.c    | 14 +++++++++++---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c    |  8 +++++---
>  3 files changed, 21 insertions(+), 6 deletions(-)
>=20
> --
> 2.52.0

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


