Return-Path: <netdev+bounces-262671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCX4GUKfpWnACAAAu9opvQ
	(envelope-from <netdev+bounces-262671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:31:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C39211DAD78
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29EC331076AD
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4AA332628;
	Mon,  2 Mar 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zmp0qMKo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2BF36DA0E
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461208; cv=fail; b=WFRmSaZPN2Rmk+KaRESYOTqfzzNtxtT2TVBDgw+wF6aJudYCavW4VtfmBNHVC8BDFA8qAttXO9RtJNRa1qJ9VjMgDwP5IlBUvR5BQTeqNUKf8tVOG4F2sKLRWrmYAXnuW9eyvDYLVbE+RLCJ30LN3LKY8wugaAbGBx/90CbeO54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461208; c=relaxed/simple;
	bh=ts/gnweMZEpQGupTHeDD48dkS4Q/iHA+rDGnVa3uJU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tVB0I+1VGTrEBntwHbUAZE94nmT927Dak0WQYa2VbKynYa4j/Hi/XVDomJwYxJlSPGmkjs2h8RoBg7K9ZGkBQ/iu5U7tH/xQC1VlIO/k4dSpa5yndOk0KyR3o7ms0uESpb1yVYh0Gkn3/aevcThVp21X9SBB6u8POJRymZiqmEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zmp0qMKo; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772461207; x=1803997207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ts/gnweMZEpQGupTHeDD48dkS4Q/iHA+rDGnVa3uJU0=;
  b=Zmp0qMKo5ILsepPrFU0hK/LnsXGGcOhS1xtrR6+Sgc+XoUyAg/hYsDek
   I+cUS217dGd5jWu7dQF8MKiDi7YyQiOUE8cgZ0emEqx4isT1zVpWJvbCc
   wr1cxXHInIhUqqnUtwzVzLvxrBXLJhzAkqtypTACz3yLtVrmFeABvAusF
   7XpdI3eiSJmr8YYrpFmIdU+F4WQEnpeyYwywNACdcIa/1igBKnqHR3N+F
   IXSvc55mrDKVKNyg18rGyWsfa4i/sM+hxadUh/KxWoz0rhVrDJXKVWgt3
   Eke+6GvpPjtZ29ovfrX6KvtzLxCX7yB4oz2FX0ouUxjGCdBoqXN+uC1SK
   A==;
X-CSE-ConnectionGUID: x/EjYDzVTs2i88sP6NPlpw==
X-CSE-MsgGUID: Msb/lGW4QGSrayF7l9NrWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="90864483"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="90864483"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 06:20:06 -0800
X-CSE-ConnectionGUID: 0BoysEaFQUG05xJAgBQwrA==
X-CSE-MsgGUID: tZ6OeawuTlCq68W1DnpZIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="220728630"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 06:20:05 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 06:20:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 06:20:05 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 06:20:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6wBuUwXFxFwT8YQjYDW6c6ykP3uRG4K3BfIaysGxkx8MTZkBk7zb6ZYSqycuCegoRfnTX3aHIbRvoXgvfHukYUgLT4kNHAx0ni7THXgsURaztBaatMVWZU89J8zoRt0Pgd9MDX4cx/BfrxdU0Tem0hBWMLV7BOf4Id1hD/W1zO8aSBrxtlrBMSWT46dQRdISddkrW1SuKdh7LqT4mC7s4r153sQhtWfKLI4xedBw12OEwkOVSLzx/XivVmC32+rKQ6QWCzY5/ae4+soj2NabYqzZicSCm7NUYjlybu4390daDj7TfeIL8+uwaIAOs+KDas7IN0GUrzSfLVvmvll5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts/gnweMZEpQGupTHeDD48dkS4Q/iHA+rDGnVa3uJU0=;
 b=mKzAg7/zSKb1sskGskkGWm7U9CLwKahQJg2QrPsFMsoLx8PhclHFntcVBL1u4Aj3/2M909/V/A+EQvpr5cbhb2Ei2/4KC8x80g7XsgCnayuzz6ebcxP4zJxBX/CO3bNYPyTzuEC60mFUiJn8Y6P1laicitDgLtTuF8cZvOn1ezo/z5V2VQv9Agyd/hNoY9gpHGAqx6bNpfwNOGYXoW5d1TlMnmWuIXLS1FCMx2pAx/PesFMDT7emUfMJ+jH5wbpf2fkNX0H23dIobgH4S6EwDY0NwXQR4uibulFNP/RysxXzmxMJp3Yx0+EnXEADJ6qCHKevOQa3DyiA2cNY99rw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by CY8PR11MB7395.namprd11.prod.outlook.com
 (2603:10b6:930:86::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:20:02 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::21b1:45ac:9e09:c86]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::21b1:45ac:9e09:c86%6]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 14:20:02 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: dpll: Fix compilation
 warning
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: dpll: Fix compilation
 warning
Thread-Index: AQHcqjwPb0pnBw2h7EqZWGTSfqUGOrWbSsYg
Date: Mon, 2 Mar 2026 14:20:02 +0000
Message-ID: <DS4PPF7551E6552307CC6CBF78F0D7F8B07E57EA@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260302120044.298362-1-przemyslaw.korba@intel.com>
In-Reply-To: <20260302120044.298362-1-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|CY8PR11MB7395:EE_
x-ms-office365-filtering-correlation-id: 8c59b2f0-d3ef-45fb-11e3-08de7866cb36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: M3HGRDAa3OHZZVr+BdkFKHTJy+nERo8PDibrgGpnNUeRc4BywvLDyQbKgkKZOT94y6zB9CWEDf+jNb7gNF5jP9ps94xUM/xDsoJucT6xGfbRURgpBGxg7wM+u5gC/QQbsIOSeM5604haZbprM4LZUxG+sSgfRAzpgQIno/HUjOvEWNfcvTSnzUSXPQknWJAdZHdHmFzSFULu+6phka4Jxz1CKvo6RGXNGjOMwCZxprrPK2oFc/H3KEPy8bvvkIEuvs7u/m6NrTYw8UlrEMylH0j5FpgKh2AWr6GiBjRsNiTvCXLzHrJflNCPXFcC8crpZPUqRIoImnFCi4Trgc2uA9vslxnO6Qz11hK9AXwiOG7bNqI4tG2eEnyuerd5+lfrKH9Ap+Fua1UJDZ9qUFqj94ukYn91Cv4/ZHWEP6kZJzaURKXbaI1mT+7XKPC9UEUme1CVUZFpymkf7cTDgn7cu/sVdClOkQKOdpUygABlWySlTzD5TYaHVvoyfTAMHTvpBhk5v4ItuoKjUrwp2viXXertBP8SDkkQ/LPB+KY7vknLQ59mFHVCVh3qWQfDikF/BS6wHADoLbjmHrbE8e5yjTTEgF/T/RidE/te6RZSBv7VIBPglsE5taaHMIYyaOBHT8i8ERbNHrDAg4PE7/pGA8AxTGoSECy1My9ZujJXnvoxA4mxvQig2zi00HdmGK8sfc+LKTdtW+bNKb3zx7mgEMzIGmfuZ7RfJsC9stu+3I4z5KVD6hXZ2MV/B8S3zlKWXjIBz+H4oWFB8X98BNjYssWIXqs5S24yNAA7s9HJYKk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU1tclhRc2hkSEh4bTRyZE5KQ2VaUG9EbXI2aXQrWExuMnA3MnRRZmhYd21I?=
 =?utf-8?B?RlZTRzMrcGZaVXlRVzhmNEJVWVFGalphekN0OEc1Ynh5eEpqR2dTVDVhQzRt?=
 =?utf-8?B?SjhXUjlzUEVxbzdWZTlFNkVvR21kQ1ozd2J1ZEJWVm9ORklEbTByZ3VjaWU3?=
 =?utf-8?B?R2krTkcwM01SMnZiekpndEJnSHZZUHB0S01jTHQxQ01EZTk5WHZocS9RTWx3?=
 =?utf-8?B?bFZiOG9VUmFWcTlHNzFaWUZZMDVCcGtxaDRqdEF2TWRPalcvVkMyQ2FRMEtD?=
 =?utf-8?B?NDVMN3ptQUR2RFI1a0NXSWY3TnBwRytITlpreTdhN2lwRzZ3Z2dCVUxLMEt5?=
 =?utf-8?B?R1B1Rjh2R1I4MkVISU9oOFNUZTlkTWlGbmVFc3VGdnBFbW8yUnFLS1M4K2Fq?=
 =?utf-8?B?UVVWejYwYzJNUkJvN1F5c0F2MTJjZytQRmFnQ0tBOWlKTEYzeTZmZVl3dXZF?=
 =?utf-8?B?aExhc0hZQ0s1SFVpTUgxcTR5UVZET0FXYlJwWWNjcG55UkpPcGVGODhZdDkw?=
 =?utf-8?B?TEJwYldQWlorQWc1aFBwUDFjQnZZUHh1SXJhbXlMOXdXS2FJM1l6RFo5Ulk1?=
 =?utf-8?B?QnBUQ3ZpSXhGYVkwNzZGN1VGanpnMUFOdVZRaG93TStEQnI0cHYwdm51dHc0?=
 =?utf-8?B?MTlpVU5UUW9tTlBuMXV1bDRDSXNGMDN3bDNKbjgvNzFLVVFjRkVOb0lsMWJh?=
 =?utf-8?B?NmtWaTR5TjhsVzJMSmxJRm9ZWlRCdTZ1UHdEZzM4VEFaaE8rdHFmOGxETlY1?=
 =?utf-8?B?dVdWa1E4QkJDZkpjeGJ5aU9aUzduSTdQV3ZMdjJMWW14WUlKeXZZM3hJelUx?=
 =?utf-8?B?UUV5ak5VY1NzcDBnUUJCbzI3dEtBVnM0dVNaUjd5aDJHRWZOS1FwdXFIRFNq?=
 =?utf-8?B?SVRHK0ZkQUZuVTJnaEZQVVh4UFd3S1B4cnhBV1FzVkQ0TlM0eUN1S1habXZN?=
 =?utf-8?B?Y0NqQnR2aTB6UGgyZEEzdVZuWTRmOXc1eDM2TGtpYnFBZ29OenFaRjA4TStt?=
 =?utf-8?B?cVNPc1kxWFRhK0hQb3UwaDQvOGhWOS9LQmlHK01HYXh0WktONFRxelNucVFM?=
 =?utf-8?B?TEpkVTVOR2krMEYxUU1GZ2RLM2hLTGQzYk5RY1RWTVFwZmRBaXE5L1ZTVm43?=
 =?utf-8?B?VG1hMTBpbW1JY1F6aXpCVW54RnhQNDAzdTdYUm5lMmZWQzhkSGEvYzNGRDk0?=
 =?utf-8?B?c2JCOXZMSjJVUGJJMW14RmZ3YzBYME1wQXhHeDFDTGNUVUxWS1FReStKcVU0?=
 =?utf-8?B?YStCRDdKNktlamFndThxc0lIZ0RZY1FFY1FCSXlaNUYxSDZObXFnMmxvU0dp?=
 =?utf-8?B?US9yRXR0Qlo5ckdHdG5rZWRET0FJcENsY1E0OWtrSVp0VmR4cDVWMllYck00?=
 =?utf-8?B?YVZUZm5sNCtHN3dGcWVpcE5FcTBrZHhYbG9iSWpMT0JOL2lwN3g1eW14Wnox?=
 =?utf-8?B?cUlWaTdWOTlkVDRRWjRQNm91bEVQQ3dOTk5QaHFkRTM4aVBqRklyUStlMHlQ?=
 =?utf-8?B?RHFmZFB1UWpEeHNEN1ZOSXZKSFc2RUZsY1BLU1Yrd2NaNmo5TURSdkQwc2FT?=
 =?utf-8?B?N1h3ZGVoNk9OUVFhSXFHT0IzOVdxSkh4anhIUlJkN1ZWWFQvNmh2NnFQc0Fr?=
 =?utf-8?B?MUJVZGxuc0pxbnEvZ3NQZ2V2cFhOOG1VeVlmUUFBeW5FSGVxcStZZkxhaWZ5?=
 =?utf-8?B?ZU1rNVlEMjJ5akR4N09tTEVac3M0NWRKTURMZHV1bkMxOWF2QWJzbTZhaVpH?=
 =?utf-8?B?V0JoZ0VjNkNhMHFId08wTm5jS3dVdzVIMCtzbzNPNE1qekdwRGpTWTJFOWFu?=
 =?utf-8?B?elJDMm9NTVFpUkpGK1UyaWszQ0JKU1VGakdrbTUzSnFxNjlKTlorcVdIWHVk?=
 =?utf-8?B?bVg0QWxseDVRb0tFZzFjUjZwdi92K1RFa1BQTW81UGtEU3JGbDZUWkx2VGZB?=
 =?utf-8?B?eXlUcTF4UGFQWmxnQm15cVhGYzZnZU9rVjZSVkxsM0ZqODkrN0FpZWhlODdr?=
 =?utf-8?B?SjdHcS93VGtRbU9UalFpejJOZzF6TlV2WlIxamF4aWppelNDRnBxeGw5Tm1j?=
 =?utf-8?B?S2ZJVFZ4UzVXblNDSFdFd0NwWG96eTI4SndZREF5VnEzYnRxR1Fha0lqVVRL?=
 =?utf-8?B?WXM5TTFxcDVNeXg4Myt6eThERGIxbGphc0o0SEYzTGpnbys4cm9JQ0ppa3R6?=
 =?utf-8?B?MEVyZlVuNWoySmJuOW1EbDcvS3JOOEt5NnNTY3QwUUZUa0RvSjM4VGJFQVhQ?=
 =?utf-8?B?VU5ic3h1c2FIYzVqZGpPKy9EdlpLRitQaEVEY0JFYkdneHdLMFR4cGxtRjlO?=
 =?utf-8?B?Vkp2R3BqTGhDYjAwY2ZHUzRaUVNNeStnaU01enNRcE5aZTBvNzdCUmY5bmMx?=
 =?utf-8?Q?MXHkHyEapexhhl0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zUBfKhlj+pI1VoV3tSv5JHOgH//ro0iI/498KQ2GlWivWplchsxuIHEeoVFPSyvVGMwDt8K2paCKCVTRWah4QqRNsrO1Fy0zT82xxTc4IdV53Dfa0mEktHOSlgBks9lQVeXA8StkvGZecq1CafiKuI7zI5Jq6dFWYr//MWvAwBlTB+UjeUOMRUF8jx84qt/V7V5lTZ/rSIXBCdZo0JV2dbK7pe5Df4TeclgpV6YXKDZu+J4HGD9tqoI3SdV5++hf19HXdPciWhRAHjmNwnqsgaUFSOqk8lj4+DjggN8O5z5IWnYe1MtG04h0dd+qXmwgbjlnT0eU/46G1MQFQL3XnA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c59b2f0-d3ef-45fb-11e3-08de7866cb36
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 14:20:02.4230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPQiyykwSeEQzpkjSYKtYmrS2XZbZhEuJzmFLjdbTISPExBJbvnIBEkrLyWq9PTmQjC/1ylgcSWBUp9AoGTlnt8euYlvm4lowitZzSd5MWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C39211DAD78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgUHJ6
ZW15c2xhdyBLb3JiYQ0KPiBTZW50OiBNb25kYXksIE1hcmNoIDIsIDIwMjYgMTowMCBQTQ0KPiBU
bzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNv
bT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+
OyBLb3JiYSwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dF0gaWNlOiBkcGxsOiBGaXgg
Y29tcGlsYXRpb24NCj4gd2FybmluZw0KPiANCj4gSW50cm9kdWNlZCBieSBjb21taXQgYWQxZGY0
ZjJkNTkxICgiaWNlOiBkcGxsOiBTdXBwb3J0IEU4MjUtQyBTeW5jRQ0KPiBhbmQgZHluYW1pYyBw
aW4gZGlzY292ZXJ5Iik6DQo+IA0KPiBpY2VfZHBsbC5jOiBJbiBmdW5jdGlvbiDigJhpY2VfZHBs
bF9pbml04oCZOg0KPiBpY2VfZHBsbC5jOjM1ODg6NTk6IGVycm9yOiDigJgldeKAmSBkaXJlY3Rp
dmUgb3V0cHV0IG1heSBiZSB0cnVuY2F0ZWQNCj4gd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDEwIGJ5
dGVzIGludG8gYSByZWdpb24gb2Ygc2l6ZSA0IFstDQo+IFdlcnJvcj1mb3JtYXQtdHJ1bmNhdGlv
bj1dIHNucHJpbnRmKHBpbl9uYW1lLCBzaXplb2YocGluX25hbWUpLA0KPiAicmNsayV1IiwgaSk7
DQo+IA0KPiBSZXZpZXdlZC1ieTogUHJ6ZW1layBLaXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxA
aW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcnplbXlzbGF3IEtvcmJhIDxwcnplbXlzbGF3
LmtvcmJhQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX2RwbGwuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9pY2VfZHBsbC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZV9kcGxsLmMNCj4gaW5kZXggZTdkMzdhMmZkMWEyLi4xZDg5MzcyYjQ4NDAgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZHBsbC5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZHBsbC5jDQo+IEBAIC0zNjA1LDcgKzM2
MDUsNyBAQCBzdGF0aWMgaW50DQo+ICBpY2VfZHBsbF9pbml0X2Z3bm9kZV9waW5zKHN0cnVjdCBp
Y2VfcGYgKnBmLCBzdHJ1Y3QgaWNlX2RwbGxfcGluDQo+ICpwaW5zLA0KPiAgCQkJICBpbnQgc3Rh
cnRfaWR4KQ0KPiAgew0KPiAtCWNoYXIgcGluX25hbWVbOF07DQo+ICsJY2hhciBwaW5fbmFtZVsx
Nl07DQo+ICAJaW50IGksIHJldDsNCj4gDQo+ICAJcGYtPmRwbGxzLndxID0gY3JlYXRlX3Npbmds
ZXRocmVhZF93b3JrcXVldWUoImljZV9kcGxsX3dxIik7DQo+IA0KPiBiYXNlLWNvbW1pdDogZDVm
YmM5OTE0MzVlYWM3YTFlYWQ3Y2QyZGRiNWE3NDM1Mjg3MThiYg0KPiAtLQ0KPiAyLjQzLjANCg0K
UmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50
ZWwuY29tPg0K

