Return-Path: <netdev+bounces-275724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL6YMlYX1GkLrAcAu9opvQ
	(envelope-from <netdev+bounces-275724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:28:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C83A7317
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C85F3000FFE
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90129ACC5;
	Mon,  6 Apr 2026 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTl02WzF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3069280CD2
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506971; cv=fail; b=PBXM5PLytl+LGxS+lIlLH3wCH2wlDM/E5RrBq+/KFNNboKTL2CD3j750napM6cLKTY3ASpROG2+P0i9EGdTFxYS6D1takFTz66wm97xZ2jbADvn3AftHZytvLIJmS1E1IdrXLmM9GZY63auQuzva2WD3ukEZ1gjYO+eWP3HsorQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506971; c=relaxed/simple;
	bh=jlmp0OOx4Lh3vPPYdTYz74QVuYHbOQBQC31w1EKvkz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PMSgO4Btys556rnDTlPExmijaTrma9VAYv83ID3xJ5DnITwykCVEW2sZCuf+lUxXHR+hVcUGxDo5UaA7/Yo0RIihuT8cFVebdxD3udmoHe0ByE0HLTeTZnNRnETzSrJeGFdtUeFWmxZt83aXvCFWN5sF0gvpCvm4U13TK0ESGfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTl02WzF; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775506970; x=1807042970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jlmp0OOx4Lh3vPPYdTYz74QVuYHbOQBQC31w1EKvkz4=;
  b=fTl02WzFIS4GjnXfhY6gXprEoCSlwwLUGN6khYQLJIfmrUoUzYn0N0Mk
   kAlE7OByGBr0lHNhH8expGKb1yyYIEzjT+K0n6oaisjO2+N9LzW0FyJgP
   SDraDTIe6ZKu/qQaaF1U4IibIbCwe80819wcGTw8xG5Is9OxaWw1R4/aH
   SoWB+5Y6V3M6obC7e9kOnm1rJuzmW2CDFyW0CvUjsOKdepefWxbiBXaRS
   3qKMRkeSZsVHpDzeGDrGo3FKpkTHTHQz0JnQCxkV/ckArbpdiG4mLtYsj
   FnCbMT7D5hra39Sm2hyW/qRvKQ8nPVb+qAgcz7aRuk8V5PSj9Jo9fpIkP
   Q==;
X-CSE-ConnectionGUID: PIXfGgtDRQG1D3F8lAUvpA==
X-CSE-MsgGUID: vyOOQZzGSbiJ4mwgNX9c9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="99087532"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="99087532"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 13:22:49 -0700
X-CSE-ConnectionGUID: IBLo0L7nRFCw0lIs0xIZ1Q==
X-CSE-MsgGUID: GHVPCWQpTvOU2NZ92c56Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="229628458"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 13:22:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 13:22:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 13:22:48 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 13:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id8Zlr2yrlF9uDmc5HUuVgcEHO6rkKwsnQPRonVeIfsTLu8/IrcuGGuTUinoP2suu/c8xxAXnkuMfHUzaUMEctdJP7ie8LLnUjtOaM+CmxrnLj7gLxWQaDJ61YdG4sANODQbJnoP2i3ZDtMRgQP+78YyO33JZZ9TP3jIjGrlF7r+1j52pzp3ADlle7rS76nlcq5P3ZRMv2AO+0VTC6jEOWXoSXBusv4rKGffkdaYPCd1EZMthVSyHletLj4VbYZEewVyyF4xbwp5YhTxpDyab3VNm6g78SlSCb4grijEtZgBLYTmOyW61B2cAx23JNFuQAHPxU303q5SJkkKJAgsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ndGdS+HFWcyY/Z5CjkpTVsvtUfPP1EvybKx4si+CX8=;
 b=m09O01iz3n5kf2ciuCgb9F4MJAywD6rUUWwP5+kiRhpPYifAelJ+ANvOJSXuNBieqim1HsVEE6iCLEBfLJLUy1gYIpfB47k4w1EML952e4N+HsPFzn96mVrXLpWxKRO+aaiEpu1iLOsPRSEqzNi1QJ6GZmHKFX8xLb7HpoSLFRi1VSul0HEgiUGi/k5Dq3xyBMiRxaPLw/JolXFYATOo/sxnq1cGfkRoqjz/CW7c1aY98nungXhjXieXZ3GD3cNJZrzGSgnbR5IOP1TI15JGf5f0QWxnNw8yCgaSRtJlDEAVP3JmDUgLn64yv5gfAUuqIpzD1rDPORqV9skUqPIDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9648.namprd11.prod.outlook.com (2603:10b6:8:38d::21)
 by CY5PR11MB6188.namprd11.prod.outlook.com (2603:10b6:930:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 20:22:40 +0000
Received: from DS3PR11MB9648.namprd11.prod.outlook.com
 ([fe80::aa2:1afb:9972:6ba8]) by DS3PR11MB9648.namprd11.prod.outlook.com
 ([fe80::aa2:1afb:9972:6ba8%4]) with mapi id 15.20.9745.034; Mon, 6 Apr 2026
 20:22:40 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Hagvi, Yochai"
	<yochai.hagvi@intel.com>
Subject: RE: [PATCH iwl-net 8/10] ice: set ETS TLV willing bit in default MIB
 sent to firmware
Thread-Topic: [PATCH iwl-net 8/10] ice: set ETS TLV willing bit in default MIB
 sent to firmware
Thread-Index: AQHcwyycFOvvyoDPX0S4IDkEEnHsHLXSfeFw
Date: Mon, 6 Apr 2026 20:22:40 +0000
Message-ID: <DS3PR11MB9648C6B216AA4DBD2C3E0E29DD5DA@DS3PR11MB9648.namprd11.prod.outlook.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
 <20260403054029.3789616-9-aleksandr.loktionov@intel.com>
In-Reply-To: <20260403054029.3789616-9-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9648:EE_|CY5PR11MB6188:EE_
x-ms-office365-filtering-correlation-id: 848ec26c-8679-47b5-b716-08de941a408c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: DA3msqXdVeCvIt8h+5Gvf8jYiVgUnkPHi/+3xECtT26ul0xzNbr9wzZX++P+NNZ9p9BWKn3DJbwdK8ocjZ3wvNYNDXWDbiM3yCy3wmc6CJ7PcWCaqt8KT/rdUDUVrLDKBi4Ha6bC5Qg8tvXKqavnyt9BynlssqhiDPh3k9YuArjpvrZH34NMFrrIzXnypuVonawtH7WBj9hNvtd7FJvF53gzz8mTja4x9PKeBF80wJ26gwqRrg1Lv4OXhv1FGE6fRZtocZfNY2eU9EGGWwHuzIV+ICG1HUOIcp1j2RgfKW6Ifyw5cPHUcaNqWU7vGtZuKrkymsQ8RtIPHyZqoE/cutxU5oj+S4ew6d38XulPvrT9ax73bQfAbLUgs12WHlnzEZ1WcSv6axVqvt/NTIAyvQG8sIM6h++yPYC1Ci9lO/ECFYyu46HCvi6b57qU0KmI+7PZNZtePnAT1m1UAk11v8jS8bp132DwRPI7XClXBfrAsuRcPDxAmBc5cxF96/G11OZvVAgKsuyILcPUeTVhaPepcdS7SDzoRc+RYwWumBF7/gNS4N/xjgSiPO0mY3o4TYJir8Qjqn+8IIH6tEXfWhocbFz4Kwj3ibtVnrw3zkmY3AhDEBiytyc0J8HB0WW7HDE5WZpOTiHqK8PPjV+Y9dbSbpHchibTZfAQgS4izyuJRM5A/+m+eYIVbmUsoAKtYMN49sy2qbUhRYzXVGiqADUPpWsg23PmlJ9JpnajFv0kTGQqc+87iMBULmji0o9ZBNWv/0xRELyM9Zju+IweuuIjxnE4rcX+gDwFgqbtdtM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR11MB9648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QD3P7n8TVbZ9PxGhcXwRM5kyfmT4a/y65OJEOqyUuyPzsfbaWvm/CQ0xMyuq?=
 =?us-ascii?Q?7Ocm1VcCYaD1lkvfvtFX05EAvbhu70HXm6CcxwlveC50cvoFRs27e2C/CBOh?=
 =?us-ascii?Q?JlqYBJYNI7BgV5ZV7tJSMq4jxJruEk1/SVzeUxWC1gVQXfCvWx48nsgsyhy0?=
 =?us-ascii?Q?zfmsMrlZ10ChH41xLNmIQLCBcCtGr1WVdDA7IHOGcJXDsTgIMWy0velzhbSa?=
 =?us-ascii?Q?DXrtwtMyDMUoKbmYocRFExTUn93WLTlBAlE2APCw5EQ49GubJ0SH6UoQOF3F?=
 =?us-ascii?Q?5pa9wct6m0A1CJNJl5M2Ky1rqh3zVqRVW4OK6iD5ZCCGbZc93IoDYAaHkWAQ?=
 =?us-ascii?Q?fWWwJjHidrGfoldI7vgs2KtUt7JM9sIwNtQuJlP3m9pOLRI8VgYfTf3mGSOJ?=
 =?us-ascii?Q?mcz2735qIO4PRXcQIzS4q6BQwgcxqHCq4Et0MEIBulD/4n6UXR3ZmySKKmg1?=
 =?us-ascii?Q?7VvoZ5AjQyyX88QPoSY6BfrK4tXl9oHJRRaPc60nGUA3UVHjIesRodD6Q6wz?=
 =?us-ascii?Q?TT64/mJ8YqARVERZChH+qt5S/CQfl6NrtWXhJRgV834IALDM6OttTYNCj3PH?=
 =?us-ascii?Q?hziXk0PJU07uauNUFqamJwo4eT/3qiM8vq8KlY8TOsqZqaERB82HlIA3hHuj?=
 =?us-ascii?Q?L3StPXfEAc1gNqRoP4jetyPZZvHMo/JfqL7rR7Yq+1h6QPa/U6I9W/KWaDkN?=
 =?us-ascii?Q?tS+pAyilyPF2vxhn8JUUZhkvgSo2YHjlofC+Ql+G64VITbVc9HSVewn6s8Zi?=
 =?us-ascii?Q?hZ/XQMekKLdt0q+LpkqJFYiKNEAT1cqRXhRx0WojRJaWsvAclB9k5tMFZ8Fd?=
 =?us-ascii?Q?IqidAdvAquDwhMdVDBuu3c7035Ka077G635MG4i4qEVTfJuwBaGJVdCw+Imc?=
 =?us-ascii?Q?FE4LBDpxb/lpZWi4rbw+LOT7a6PC1JweTEevKDDdpC78XXt2zqMyxNI+nQ4P?=
 =?us-ascii?Q?vVBmHfsoty6H2K+JC0+9VYV+Air+hXHw44gd6DX/RG7/OB05lrPDHr4ulZ1z?=
 =?us-ascii?Q?Huk2OLj6iJ6Iow+GZtN+O26MA4Kk5Ywv43MPRcruLfhMS4s5iX0QclqGxi5I?=
 =?us-ascii?Q?A1DxYqIP815GEKO2NmztscqAXzlF46bH8RVxGhdA8NA+fzM2nc6jwNQ54bpP?=
 =?us-ascii?Q?p3f0Wn4hFVpk6/j7MsTDn2NgRHD5TKFfts/iZRAXxRd0vakfr8e15W2yBPAI?=
 =?us-ascii?Q?lppIo+N6BpBySRSsPBLmvxxkBrQmQohenc4WLE4Ij/q5HCNKdLHchu+DTRLV?=
 =?us-ascii?Q?tfKEPVCDo5Zix06IYTHJ+BvbshMq39yDF6Qi3Y9WiRcEhbak7+Xdu0pREZSw?=
 =?us-ascii?Q?MAGny9OZeHfrextTImtANz/3OqGCzn/npHi9RoTq/odRKpxXJKFVMoaL7uFu?=
 =?us-ascii?Q?cxMivAFaBg41kQBc8x8aEJgIqvOwHh3ScZmFlVfOhCwnXLRvyPjVtVpPb+PP?=
 =?us-ascii?Q?GWSkjYfwkeJVMFX97mrzWzYsf9jWdkYLlHUchQRxZ/PeBoH9aXPIRRouakam?=
 =?us-ascii?Q?WbEtDkdLuX2lFk+fBduUZSHeEbLLMaMiXHp1Aq7mGaA3+eJQcIej+U/el0Pg?=
 =?us-ascii?Q?vPmkq03KMkHpI3cORrI30mu/8IQVzN7xB+D4u9LEuI79v8dwiihtbbkgTsdG?=
 =?us-ascii?Q?dK63QydwYd7j/dKxmH+8SEGXsV8bTuamdqzKvMEe9KC/bPi21YfZEMCZqxNI?=
 =?us-ascii?Q?YtZ25CqaSj0+J2y0nChkf4GamqXaHRkJRCU7QFWGR6e+R1ylI2HQXvGHEkYf?=
 =?us-ascii?Q?px8K4N15XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q6y3tlUnFFBsbB5viftiNrM4M+inBBcXG6PLPrsxn9tjbhkvQvMdWTIpFDh5IUZNKekCgr6Fv2mvSZI8N5wb/Qfthuh7AnckJKwT8RzfHDLZ3Ra6ZQyg1ECxdu8Lw7L73hwZLXJGTkvbRjrf2pqwX6k4noKiTwqMHK0GgbFkmYFHK/NCwUfLrenrC8u1TBcJLecRywA2FC/zS0vey//Rdt3HRtYyEHVOTbFLh0HH4U6sZzhkBgKPgDeH7fm40QhaMWTjHBnmFH8AugJLkFLiwBUKNU8F15pQDgD6AwHHzBwKnJt9Xyb2etRgKzbzYDMEqK2DWlwqpVZfJzzDvGPzPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848ec26c-8679-47b5-b716-08de941a408c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 20:22:40.6161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivvMD5ruwlgISMXeeP3XMWfdo/KnBwZYvwkXq3yKGBnVJYjshzT7JS18Zj7zAGh/Q3D2IBFvmTl0JWiC5GHbWWEAHRNpDQa+klq/ZKNLlYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275724-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,DS3PR11MB9648.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david.m.ertman@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 481C83A7317
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Sent: Thursday, April 2, 2026 10:40 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Hagvi, Yochai <yochai.hagvi@intel.com>
> Subject: [PATCH iwl-net 8/10] ice: set ETS TLV willing bit in default MIB=
 sent to
> firmware
>=20
> When the FW LLDP agent is active the driver sends an initial
> DCB configuration via set_local_mib. Currently the ETS TLV
> willing bit is clear, which prevents LLDP negotiation and
> renders the FW LLDP mode non-functional.

ice_set_dflt_mib() is only ever called in one place - ice_link_event().
That call is surrounded by a check that calls ice_is_dcb_active().  With th=
e
FW agent active, that check will always return true.  This prevents the=20
ice_set_local_mib() from ever being called when FW is active.

It doesn't seem like this change is necessary.

>=20
> Add ICE_IEEE_ETS_IS_WILLING to document intent and use it to
> set the willing bit so the FW can negotiate DCB settings with
> the peer. This only affects the default configuration; SW LLDP
> mode overrides it immediately afterwards.
>=20
> Fixes: 7d9c9b791f9e ("ice: Implement LFC workaround")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yochai Hagvi <yochai.hagvi@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb.h  | 1 +
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.h
> b/drivers/net/ethernet/intel/ice/ice_dcb.h
> index be34650..91d6682 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb.h
> @@ -52,6 +52,7 @@
>  #define ICE_IEEE_ETS_CBS_M		BIT(ICE_IEEE_ETS_CBS_S)
>  #define ICE_IEEE_ETS_WILLING_S		7
>  #define ICE_IEEE_ETS_WILLING_M		BIT(ICE_IEEE_ETS_WILLING_S)
> +#define ICE_IEEE_ETS_IS_WILLING		BIT(ICE_IEEE_ETS_WILLING_S)
>  #define ICE_IEEE_ETS_PRIO_0_S		0
>  #define ICE_IEEE_ETS_PRIO_0_M		(0x7 <<
> ICE_IEEE_ETS_PRIO_0_S)
>  #define ICE_IEEE_ETS_PRIO_1_S		4
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index e7308e3..75a48e5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -971,7 +971,7 @@ static void ice_set_dflt_mib(struct ice_pf *pf)
>  	tlv->ouisubtype =3D htonl(ouisubtype);
>=20
>  	buf =3D tlv->tlvinfo;
> -	buf[0] =3D 0;
> +	buf[0] =3D ICE_IEEE_ETS_IS_WILLING;
>=20
>  	/* ETS CFG all UPs map to TC 0. Next 4 (1 - 4) Octets =3D 0.
>  	 * Octets 5 - 12 are BW values, set octet 5 to 100% BW.
> --
> 2.52.0
>=20


