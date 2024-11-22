Return-Path: <netdev+bounces-146822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B529D9D61A7
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0756F1607D1
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0C1DF738;
	Fri, 22 Nov 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsy8FPgq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9303172BCE
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291008; cv=fail; b=YLw4jZAz5zPdjxG1M31YliMDP9F5syIlqDgi3Idwrz9cik2FvrficiIzKP53SFW7f0ebln3TBIMapjVqL8zKwQije+GgfXw7VgdIA/tgVVhC9qc1ZEcytFVvwoyRFcVFcTk2R2HmPj2cTFECjSV16uAXbGY8j4c4orNSmpOTqaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291008; c=relaxed/simple;
	bh=v35DTtoQg/gaVHN0H7Kk9j5DMxFZQi6CTlP9kS/BfoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zme+TrRzESv/EWCcOXBnah6M8UBYWo/5MNZEm7oljlaetcqjjM5DzJ+4HLk0wMRj+d3Wy7bGpbviaWHPHWeWg2nGb30bizF2VB06W+rQ8kU6NJ4EKctS8SEe5h7UFP2ZOZ4eFlzTM7kzQzcwJI8pnxXEEGobm+7+0W64GCT8pl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bsy8FPgq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732291007; x=1763827007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v35DTtoQg/gaVHN0H7Kk9j5DMxFZQi6CTlP9kS/BfoU=;
  b=bsy8FPgq5hOureJ22UsnMBpBxZ3Kx4M+PEeM7rO7tZHBkfqBZI3Rl7bL
   ODMKsmjOBUDlAJ0tH+t3h37Pa+8r6p6a0PeWOQZVIgwJ2QzVAoE8RtJq/
   XScbFF1zk6Ki3BjgPLabdtLcMDrOinL7y2S5RC31C7H8m2LTK/OjjhgFt
   bD6tX7dUgC+g6btL8IZlHU02zit9KWH28p0+cIkgMCGgBTN/v9ckmFmC5
   8MSd/A7CoKQ5uXDaXh+GS5X+31RMOOuXkFK5G7XAcBBH4tp2TfVbw68OJ
   eFs0GkXnAIXAA5cgt9qsXmRa7dOV0Cxeh0IrwFwqGiRWw5LBoUhQJtOhN
   Q==;
X-CSE-ConnectionGUID: P7aMrlXmSCi47DF5OIBVDg==
X-CSE-MsgGUID: xsuujZs4SOqbZV7GiI2JkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32311983"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32311983"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:56:47 -0800
X-CSE-ConnectionGUID: KKHyY2u/SP2riIsfJZq4gA==
X-CSE-MsgGUID: mEEfNAEcSPuBk1WtAysOtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95696572"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 07:56:47 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 07:56:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 07:56:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 07:56:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrk4qA6JFBqlJ4bp9w8CgJLiKnI+isdo0MuiiVJPuvCJ/d2mnARAUsZ3pXTrSTADUl3z+Wk3A25RG6oPcf23geF4CxfXXpgcmpV0PIAcrUzZ9umjJcZniGlDDUZNcDB96RL+84gsP11efXSqAbSpRsH+uIT8TGngkzJ23gMRhj6EWvXIfZc2LBH8yqO0rVndrtOU1Rg/nAah5xlKrl5Dk4hb/ZkqwdjaBeXG7MVV2szFon7jllMB86D+mBKF3IkzhaovmIfxSDVyn0sqziXoaGqbSPDcr15QsUF7dBcoXMm536pNmmrnoe8gQdxlkr9FB+a80nOVzKrmCrKY8cvk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHZrqO45C/tnLslP8MYjDI+REb0UnCvMDVwMBUz4C0M=;
 b=acOCzXQ4ajP4HeFhRrJ4zGHtzUvQ1LAL7Lyr4lonAZtCJ6eXdMnsNYmzZqyh4nZLSBlZjYalifTptBLdUekToWeJLTEPj9txDr/EhL18EXPsBiQD54oF1n4uMBMkTeUrfliTjeO14wiUJ7LwxlZ+8p8XTpc2aMM+wLp/5brFhOUWBQdskYZXYF2eMfo3xTWYtvZLWbUY+9cOS1zy4rZ/+fUZcmYL/VB07AmAPAsy02CVoWaappW1TleU+1NqgZGO0on3rgb/ft3P99QCvmF3YaWn2MOsnTjMULQdEVsgntj0mF7cMIA1IVVzQTWlByAxB4YHCjLvISQ7oL9Ng918Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4970.namprd11.prod.outlook.com (2603:10b6:806:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 15:56:40 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8182.018; Fri, 22 Nov 2024
 15:56:38 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-next] ixgbe: Enable XDP support when SRIOV is enabled
Thread-Topic: [PATCH iwl-next] ixgbe: Enable XDP support when SRIOV is enabled
Thread-Index: AQHbPN2sUZJv7DLdfUWCRoKq2ZBitbLDctKQ
Date: Fri, 22 Nov 2024 15:56:38 +0000
Message-ID: <DM4PR11MB61173CA962D7D88040365DA082232@DM4PR11MB6117.namprd11.prod.outlook.com>
References: <20241122121317.2117826-1-martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20241122121317.2117826-1-martyna.szapar-mudlaw@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6117:EE_|SA2PR11MB4970:EE_
x-ms-office365-filtering-correlation-id: 7c562d0c-3cb1-4598-b793-08dd0b0e3fa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZhOU3bBSC7wA0Oz2fIN/m79OCbyu91KhEeaJ1xsfuXAh3PbQMtOuPKFdU4yO?=
 =?us-ascii?Q?jL0DFfKS89pFxnHtFMJ4SGV554Ikoh54MOCQJC3Wy/qzMIXwcSbRcdPFCXc3?=
 =?us-ascii?Q?giulL0MVtcOtnXpAHTjjELKeBrLz0coopIyR0Q1v8ljAmYhmpHQtdApUOrTN?=
 =?us-ascii?Q?zf9/puYKILedFhg97BuPnbS9AyBmwgEoIMRsOXjO1rfJty75xP+dF266ca4z?=
 =?us-ascii?Q?IDnp4R0rzqk6JzsQ9Xju/irlCq0TpiAakW4xae6tI5eGKb3/WoPQkqLcf28w?=
 =?us-ascii?Q?TpUZtU0B1pIuiiGqemEAl+KHoDObr5S73jLRIn2OhFg3u70zWqlisTvNJtNY?=
 =?us-ascii?Q?c8uynWMC9ozbbnfiSRmbeeR27g1lQuSVlxsuDZA1uCV0Hn1M8IyvfGArsmys?=
 =?us-ascii?Q?R3JI9FKID14B00T9ngKBA13uizgrLDNBwVw3MZ1lTaYT5LjSExmQS4LItC9t?=
 =?us-ascii?Q?MxAEIMx70RBH1CwykL2nQydr2Cp3fJC9sIvPvU77R3shOJAJ0/09idnoFTnG?=
 =?us-ascii?Q?Oyfr5fQeYgz7Jphk/iUFoLSCLzb0OoiEWfUsRWMNUBWv2wR3/B4Gr4HdSFWJ?=
 =?us-ascii?Q?fMbXnEffBFJdCwxJ6OkllBsyBusiTFPr+1/WARTcwyQT0gfjh3hCE/HTJ+PR?=
 =?us-ascii?Q?CIBnW0vM/UL8z+aPsG+ijKTs096tkRUVn78JV8CLl4lgmWjzfw0/5LcphFf/?=
 =?us-ascii?Q?DU4duU+LxXYwQWBlOFxKHV2pgWZftGIWo/8dpZP5X3/wIMkG3E2vwwm5utfL?=
 =?us-ascii?Q?M4FwWFFfFvtgXwkxBLMvFI7aM9C5sXYF5GPhsC32CXzaFH3j7Qy4tQN35qZy?=
 =?us-ascii?Q?TjUyXXJegqAZbgjlj1B/5j19BYtsgiVq3jz+bKvLmaGyugCltTnbk1HE/627?=
 =?us-ascii?Q?HEdejWKICceuxMoqG5UpxB1PTQXGcXN0n4rWwaSXMxG0jqOcs+8ZUebZsJZK?=
 =?us-ascii?Q?Ko1HVsBTh/yKsWGPOo5U09lQTlgE8Lw8uOwONXVJgSXTJWdlIFYX7kTsyL7N?=
 =?us-ascii?Q?u/9XMxnElKOBV0PY7g6XawXluBovcUzSn1d6nxP9qCalY61RIv3hCEW7FxOT?=
 =?us-ascii?Q?7/1oFmFjPErsUV97H6dChT6sniYG/VEDpi6Sp5Ds0auvwm+bIiwlEVMfesKz?=
 =?us-ascii?Q?1f13TieW8s9ZN9otlA4jMqlP2Zwis0Ts/wuqrmV73DGNvzrjDR4htYMRsUWX?=
 =?us-ascii?Q?NQDFFFY/lprIQJ/TShA3EFVwD1rnwXzc4clmyuTvY4XD7KutXEYv7+X2Lmpz?=
 =?us-ascii?Q?nxgp+gUvLYIkiLMr+12UzFItjV7E8eAtyBN/0ggXDYLWf6Fj0k//u2S+sDvU?=
 =?us-ascii?Q?vgkC77rcIP0AtU2Fapl/+68G8/t5t3cPzggRaR4D1UlHwaY0SZn9gef+SGeq?=
 =?us-ascii?Q?vH50Y4yIM+num45NUdj02LvyfVn4MDTKgFfCHuRyTZe/tGEFeA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NztTSiBT0Z5HjY6Am6Rm4j2najOWGgzI0XmXT5OIFCc7n0FRe4HUlZyw2ku4?=
 =?us-ascii?Q?9BRm1iJj75xSvFG2E0emxqAp2nJZ6NHzFemDs1M+lRGMVAgbor09DrbzRwdJ?=
 =?us-ascii?Q?7e0x4tqo10yRwm7Y/DVnQymRTQXpdtRpR/JvYD/UJVABtft52wt9/yE6C2vv?=
 =?us-ascii?Q?pKZ7ZxFR99J2BGAnwjxjfGCja9NNu8o9wEYIDBfhyL5F/5v6Uko9Pu5t78Kk?=
 =?us-ascii?Q?XgsalmtKMQ2bX/+ZrKjFhW1wLxSsaIEBVmCYBRun3UVsYpxB2DUBvSReSkbp?=
 =?us-ascii?Q?jyM02sjg0+wnACtBdeLbk0LsiRLEEzCVF22uhdTDdVaOMWmDCNYPvw1m84Wb?=
 =?us-ascii?Q?b22NQTuXkDrwHyMy9zMEfE9OcMzY72+hHzQfa3GMMmEkbTinsNRPxaIWLyvj?=
 =?us-ascii?Q?DE1tj1Mqb6ErIapsWz7LhJcaJiYX8Two60Ia7ynEvyZ3RThdug9ODuGYwP3h?=
 =?us-ascii?Q?Zyd8RDSxABDPHfbhmwfZhEvkinM5hwytJ5PFyXbHfJO3Sj4vOmi3fugxfLmU?=
 =?us-ascii?Q?e7pppaYf5L7jCRyfykA5t2z1OYBDHMPRK2FavPGoPtOidh0dEumfXjixj/q2?=
 =?us-ascii?Q?cL5dd8HThThyth8oct2iSmgMw8l0LFEQb08fV1WR2WBJ9NmVOGyIhto3EjHk?=
 =?us-ascii?Q?AgHjcc0ENdkjJKu4EsVJPxB562jfUNF6qXI8gRMxoHX2DHLQ+JNCVP4AUZ++?=
 =?us-ascii?Q?1w06UcDxE3ZWB6VuLB7e7lvsnS+JIYMUR1FZ92kipoUQ5ml3Lm8M0FZ/e1Zt?=
 =?us-ascii?Q?2264BUxc1mVRClEfaFFNEPj6yR33F1l0K5PrB+to3l5uzWRoKISBwj8A2/v3?=
 =?us-ascii?Q?hAlxCfncJqTr7MEl0TDjXrlmV1U0CqPgxhnQ9I3wFLoLI31LIMC/zPTPH6v/?=
 =?us-ascii?Q?N2s9UEC4Nc1m9INDaCG0nV5fQa9/BigRUgPN9wQOeYD5tsu5BhRCw2eoobRV?=
 =?us-ascii?Q?Uh5XVywHGT49+laKjhJa9I3uL4mdL3dkS398x0QY0nWauPtF/Sfi9XXDKxJu?=
 =?us-ascii?Q?BJPM6EwcS824WGHABxHBIYX5I3QIDCSOC1oFxVPTL+W3nWzpGCG3w9CMijNj?=
 =?us-ascii?Q?Lt5m/qt8teC5LRDXuNB6Si2/0F6Q5rkdcH1sC/ShXrzGj1i29aY8gmUHbEBg?=
 =?us-ascii?Q?eQmodn7FXeFXK8KeyDYhLzjdGCIfjdSSwjCIfV8ucAj/l2tOfnY0pRI42z8I?=
 =?us-ascii?Q?wqeI8+xbnfCAsCKofKT3peORjv3VieeKqTrJeFknWp7317eBQ8MpUdl5a143?=
 =?us-ascii?Q?3oMjvAGubsCOrvwQxHfPSd13C/bX7JgKrkYiC5sqe+aXBbI96LIIakaEQqGq?=
 =?us-ascii?Q?RABxbOoRTTNzeBdl70mU7AsMPTnEUzNtdZTae48FA0v5GNdJO+sIq5DH1jJP?=
 =?us-ascii?Q?gz5shrfPItTK8I4QnyodA3mp4igXnSbkBmeeYw2+xIMoyQujNcTn60O8Hn7x?=
 =?us-ascii?Q?kFoHs+XrQ1teiF+u7k4fQP4laUdkBhov+ANv8wd5Y+T0AGS+V6lNSlfjzTVb?=
 =?us-ascii?Q?oJ4N+pnd7i99/SUhLV3o46cdVjPDKd7G/8AjyKbzJXvXIb8fHWNWoXBlkOWQ?=
 =?us-ascii?Q?zEBHW9tF3o1ED20LgFOIN5SP1FH0Afe+0dR2n4+ogS+irriNJgBrsfomZu31?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c562d0c-3cb1-4598-b793-08dd0b0e3fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 15:56:38.1587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9sadZFuleXBI+gopZHZV05c87/9F+TrtsLt+nRDYGTCBKlPf1Cl/cKK5hyy602FVU6zg3Vt+d5RfzziEiem0bjsa5/thlUla4jSSgFLLZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4970
X-OriginatorOrg: intel.com

>=20
> Remove the check that prevents XDP support when SRIOV is enabled.
> There is no reason to completely forbid the user from using XDP
> with SRIOV.

I think we need some more context here in commit message.
ixgbe HW was really short on HW queues that's why probably this restriction
was introduced in the first place.

Now I believe that driver has an ability to share XDP Tx resources with loc=
king
being involved and that's why you can relax the previous limitation.

Correct?

>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-
> mudlaw@linux.intel.com>
>=20
> ---
>=20
> Added CC netdev
>=20
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 459a539cf8db..a07e28107a42 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -10637,9 +10637,6 @@ static int ixgbe_xdp_setup(struct net_device
> *dev, struct bpf_prog *prog)
>  	bool need_reset;
>  	int num_queues;
>=20
> -	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
> -		return -EINVAL;
> -
>  	if (adapter->flags & IXGBE_FLAG_DCB_ENABLED)
>  		return -EINVAL;
>=20
> --
> 2.36.1
>=20


