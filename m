Return-Path: <netdev+bounces-175905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5B7A67F39
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F4317800C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B9E205AD2;
	Tue, 18 Mar 2025 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e01gNm3a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6DF9DA
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335530; cv=fail; b=tsfCVHJSO3moPWQu6cwX1Q9M166GwFCRpsYNq6M7p4GeA7zZ9FyO52HERKnYV2jPIna9Jt6ffSFpbP1Cv3RbXqw7oVuKOc++4fPA/56TPjWLl/gIvl5y0pxUQRdfz9Ed2m/ARyf0EAEy5UKPNkUSbVDAmp/nQixgRwW9B/PB2S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335530; c=relaxed/simple;
	bh=LWgwwNjvrmpRL0LS44xexKDWuwCFSu0ioAb6+bgl0f4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DE55q/VZm3ycGp7taiafuvdSZFt9Hyki8bD2rhuneiW9mp8U+IWrd118JlWH3GnvfYzmwS2Rg0fkY57K7GkrQDH9vlvlk+OAdQy9fo9fAcqU6gSXYCtE18lfbP2S5xUp+lwf2K3UIKq/YnDClri6mW/T51T6bw9b4HhfnL9UMC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e01gNm3a; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742335529; x=1773871529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LWgwwNjvrmpRL0LS44xexKDWuwCFSu0ioAb6+bgl0f4=;
  b=e01gNm3a6kPHSBKyaU1fIwvbmXqsthbpDY4NxeBE90UHZpeVnv6VnHBU
   UlAuskIo7M+JZKD14GW5S3djS4cwtZEVyjKIzBaufn3n7wzFBm2Y9yBW1
   uOMeHvPWr7BTm/h9/oZgH5EEDovedisv7w01z2Cu9AWNaWZRFnodoklca
   4/nngaf/vsJbAFxDGNN4d0DgCZ3HQmn4d7vTknsiqa0kgb0i0yxqGbRPo
   7qdqSCoNon6uL0pz6l5TsMsVcr3RW0l6hU6YkoEdapImg+Ui/cEsKfcbN
   ew8OTrrngGigbsChn/U6lp6EaMQE0vQAvZnnlafDna7ivjpTnP9n+3V3N
   g==;
X-CSE-ConnectionGUID: oG1NXd41Ty6FwN5ly5OdtA==
X-CSE-MsgGUID: 2AcZW5IgQFWZYiFm9LJ/fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43235672"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="43235672"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:05:28 -0700
X-CSE-ConnectionGUID: KTK96JkvTx6hjYe7vsKJbg==
X-CSE-MsgGUID: bjvULAxITOqSaJvF+KYPhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="159547616"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:05:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 18 Mar 2025 15:05:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Mar 2025 15:05:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 15:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3B+Y7b3zSxSHqqFPZjMc3ozjKML+B0VZHxCQqw3FGlTTz0KV4Kqq3hJhW6jmsj0V2ZiakK6rcR7LF9lpCuwkFf7B+A2M/yLsyTTZrK2H7Us3o3Gt9f7HLMLWAPrA2QXeVscTep/DeJ15i9ZO4waGKYPP0Lm6j/WYZce3eibgzKW0DjofiIf77vN52rB0ioH3zcgnJ4h/2HQO/0g7W/PyTcmuPkCZaYYhPoFk5bXccNUqV/w6BCNIgUTP4z1cnhsAa533Dybve22BkSntnm5Z8Qi4iu6Qp6UE5yp/ChLhcKskwD/4ZJ+wZ91mFD0enH/qQE6qdXDZZQw8zHlEmKMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sS+ynj7ilN+3/r58myLKcCbWUo8WAIFhS/B6NA4zek=;
 b=a3J/0kYdHzpo1HR+lSXHdFF7COxhs/n8TX92A+SdMWwLeWI96Dg+Wfq/+2bUy7Eaao/0Rzvi7HzGfccCHbO/7LiU+hzyRMz1lmi26KnNwoTB9U/FKfIvUhvfd1rMf9Kp1mwCNep2eHAabv+J5pjokXbioL3SbER5EfT3Nr3aM2sewHi7j6xzv55HPEQ5qg/hEanvsd1l/i2ogxpI09yc3xi8ZkOUldgxLxaWw/iIddC4kbxDq5CBbbbHx2at9O+3oOy3ZZFYCW6v1/+f+pYcjWDs9XxaQsYxCUloZ6XdbwjiulMP874pTmuTfmxHVX4c6/hIg0VIMVafeR+QMr8mSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 22:05:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 22:05:23 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "Dumazet, Eric"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"dakr@kernel.org" <dakr@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>,
	"Knitter, Konrad" <konrad.knitter@intel.com>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>
Subject: RE: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink
 instance for PFs on same chip
Thread-Topic: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink
 instance for PFs on same chip
Thread-Index: AQHbmAPpzfoItpIqX0GHVOB42/z0m7N5cs1A
Date: Tue, 18 Mar 2025 22:05:23 +0000
Message-ID: <CO1PR11MB5089BDFAF1B498FE9FDDA3FCD6DE2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-3-jiri@resnulli.us>
In-Reply-To: <20250318124706.94156-3-jiri@resnulli.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5184:EE_
x-ms-office365-filtering-correlation-id: 8839f2d0-9f91-4578-51e8-08dd6668fb18
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Oo1n4B68Q45hT+/y7OV6hhpdoUZGB9bsvcuD/CvccH/GlQNF4Z1WM4Pg/Ij4?=
 =?us-ascii?Q?pBmfuFdr5hpRL40KPCwkxOB96ry9BJqw1X2LKAbStBL/PLl95zGEiiP79oUS?=
 =?us-ascii?Q?r/6Y915SSmmhbQFVv7W5RmsDnfC6gsgGXeqOBod9OcYYb0fbR5rOJN9mHFB5?=
 =?us-ascii?Q?swmIuKz2hCHUPagt9vkXrbIX+FKPYBdYTOGGbTxIfVdpRH/ufXb1fB4rIv9h?=
 =?us-ascii?Q?FcVB1tFcXoLxWwOn7+CGeJPZmuhQ6FX8a7XIObzm/JLDQPseieJPxprZPBB7?=
 =?us-ascii?Q?npHaW3L7Ez3ocxNtJ7y1xzr1uUv+mfH2OgZNWPgjdHUmwIGM6VQABzTzAAlA?=
 =?us-ascii?Q?CVG3BdacNzdZ+32DtjUn6ykMDjcdlAiDb71T+cI0UzHQhmjcoOKmlGXfIwoT?=
 =?us-ascii?Q?laK7jeQ8u86QJi/JCCnHT7Cl+2IgcfNbK/uUj8g08S3rWPTOb/k5dI4BG2Tp?=
 =?us-ascii?Q?3gxT1OgvozRfY+VfMWRlZzXNkVyOnzO15+wlDcXzNdHkX7uex57wfSVvEDQi?=
 =?us-ascii?Q?qAk8eVCxBPOG2bE9VYTkh3z92a1U8J08eTyPRld2W7ewgQZuCKdKu/n18qK9?=
 =?us-ascii?Q?n14Mk5MQGASOxYBzC5VscQGM81nXoRz/v2vhLsxqWQVVTnLKeYGFqUpBcyL8?=
 =?us-ascii?Q?ks2FnSYy53NWGxb1czWVfdesC0nstD2tvLsIAXzP5FGW3qtfLB8KhbwNzxWX?=
 =?us-ascii?Q?Wa0DrzSUGJ5OXW+OW43752lT+SC65ltvwNlx3eupjLxNA6y/fJf4OVLr3bwD?=
 =?us-ascii?Q?fgBVit9mHvV055j9ZZa6hF8pPJ/Dj/8AzkacyalDfGuk+nLeSpa+IDq2mG70?=
 =?us-ascii?Q?4sHTszqlt8aBRaVZTHvXwCrhC4z4yJLQH9OQQnl7HZSf0jabO+dX33TfWXL+?=
 =?us-ascii?Q?cktcs0/xgQ+Gvjvh2p08OPb501e73/f+ASsy//qw50/PRsIGSfxggazWRAtj?=
 =?us-ascii?Q?wSMAi0HsxvwKK3D4RBBNxToUO5wwzrpVqCP2oxiIfB6okB+tn7LDx2jyiCUn?=
 =?us-ascii?Q?Lj5sNssBPEZBoeLsPQsUaab1b30wLPTTzCRbNLmcDJfpQoP7nhAVILbv1oV/?=
 =?us-ascii?Q?xRMUc4C25uq1mmeZYJeXvJceVqOShHJEvTVwsMzvuXlQOWHp6FY+zLruUOpx?=
 =?us-ascii?Q?5fl4nNF1MzB+mrh/IpFNcM2r0kqfiI0iaBlhO+7eaALMJSELSP8094NPxS7y?=
 =?us-ascii?Q?ZA8ON2ruqOOqPsXs9jK5ieiVWQ64mgI30N/yMveDpvArMn6Uww1bQ/P78ofz?=
 =?us-ascii?Q?0Ajg1Qp+PHgfx+wYunO25a33IYdSqkQ/VMD7FWMpV2sk7LXx9i25rKP5FC+w?=
 =?us-ascii?Q?dLm1c1D6lYm0iPkMvvs46LP/qJ5MQ5cJUCOkeIWVR9NtBYp8ri/0uAuQ6KZn?=
 =?us-ascii?Q?bV/+vyEzvaeQ6OIqEOuk6y8m+cecgVWk3GaMFh/2hS6YcFVs53LIbieBeYKf?=
 =?us-ascii?Q?upW0WorbyFEmQAwZcllEEZjYC8v915Mn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k7yuO+slOPTyfUbuFU1CVENl9n5joYgn2a/hVjgeOzafes5mh/boUi1PX07O?=
 =?us-ascii?Q?czdKkbfHn+4jk3KGw2ye/wDQpr/5yZvaSos4iyw6dUaerQIxSOTZFQErGmjQ?=
 =?us-ascii?Q?xiS2YBysEoQZBDU/iWW1wPvDQIjFpihTo/8RM1JHbMtTMiTCbT1LJoM7x6es?=
 =?us-ascii?Q?JjA9vNL2Op5yQr07eUOmLcn0d3wPYpTR2TguA/2nNJeJXg/A915pZLH5Ml0E?=
 =?us-ascii?Q?CFb5RaAnjkm09pK7/lWHNGvgCA0uXK/HAtadj9u0XkCWZId52maQlPRHDMkP?=
 =?us-ascii?Q?RB+PAzAOkZ/itjx6GM3S7cIqjI2Ff9eNEThITbx+2meBCkM3uznzpFdsVMWC?=
 =?us-ascii?Q?m/mpKxWnsgSBGxZZDErrqJOl9lyRP3dR+3edwcWODVnEBPIDFamCP9f+kdBM?=
 =?us-ascii?Q?wbBX8hmsSaSJ//xXCfm9wRm+YR1xx606KO5d98J7Pi5Z3+RepHY+i0D54cJ7?=
 =?us-ascii?Q?s2TVwXfiIXDPkY3LIDbViM5uxoM6rHDn1qotSkahe9Cf5tB+b1IDqwGAH/nq?=
 =?us-ascii?Q?KD2LFqx2T6Kpyl51g5Gg0i/Io5hnHGblHMLV02YkCRMlZW5UykdOPDKHo0Hs?=
 =?us-ascii?Q?2xKg1BSzOWXqNXuhdxJJM2O35b7yPYS21f6B7loYK4ewMnIsVyewQFDNs3D1?=
 =?us-ascii?Q?k9j1+NVeONx4aD5Ss5FIIHgV8l6ciIGO4VESsbVJYBPXTf+88LDa4THiaG6M?=
 =?us-ascii?Q?YR1guIa7JO9ceJfk5PA8wbBwkePNqh+b/3HAkbV+8rOXy4fveejwPinDlASO?=
 =?us-ascii?Q?zhA5pDEsgBTqMQMiNok11i3oiBz7gFBjV5vb0wjz+N7Qemf5pKeqauREFkK0?=
 =?us-ascii?Q?nau2oYc1zjY5xmAAmYsDwW3SF7sy7NoEhlwZdSHwt74HRCNFXRvaZ0MlHT0I?=
 =?us-ascii?Q?JHAHWX1L0Ck0G/8621iD2lH9x8ZE9stIMcN11ItW9cTjRMZ/MDPutaIe0E3x?=
 =?us-ascii?Q?pQg8PssqFDN4lXc1H01eGG0u1F7DlC8VRC/5k2LFXafHjjljvpzFpmYCf6mc?=
 =?us-ascii?Q?Bl2ycjx/Nw/ajM46RgnszyT2dQ/UEzxh/uDGGH7fVAaNad2Oplopzzft9/K5?=
 =?us-ascii?Q?9bvgpu/CN301/htalLxGSUonm2ySMYAED0NvTrG00QSXOLNmguMJZtJewtmH?=
 =?us-ascii?Q?g/NjVYB1EYmp4UZQwRDZrHAqQtQGi7W1a8hFsi92zhkxQONfmcR8cNPZjPlR?=
 =?us-ascii?Q?tNiW5VTg8/PQjiLeCjdJXSXGk1TQ+WvkwpgttFysofFD/+llV6RU31gbCe/L?=
 =?us-ascii?Q?MrAQpsRxkpC/FcHjCjfjLLlU4W1FnGQ8aInU9gFnTUHAItzK8zk6EHRDgIAB?=
 =?us-ascii?Q?ZpEjMJ3anj69K3YNGN8cjVHA/yKJOaDfbQB0a1tChvVXT4zMWfltI2shErOI?=
 =?us-ascii?Q?AqTlXTDbV/rDAarfDcBZUhaltevlfwTXq7VkyoaF1+syD8IR9lskW+qEYsTF?=
 =?us-ascii?Q?+z6mjt8UnDnlbYYNCo9OsAQglS441xAiXsBe+30uQ8z4R1P8dEQNlEBCmA3y?=
 =?us-ascii?Q?iysp/czDgkJiv4Eae4iPUCE+64gI1RIdXZH9Bz1kkOjAFCdaqNx/65hlO+bm?=
 =?us-ascii?Q?JlPLMxQaWTIOXv0wwnXxweWc9cekt1yc4Sbe5PjZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8839f2d0-9f91-4578-51e8-08dd6668fb18
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 22:05:23.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dch3mDet50l2VslXEC3K8w8mUtdvTyhUP05v16di43aP8ZRomGz6er/whlPEFfn2HFc0MzgWISST4v1Zz5RpP+aNCebJdTeHelnf+FAZdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Tuesday, March 18, 2025 5:47 AM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; Dumazet, Eric <edumazet@google.com>;
> kuba@kernel.org; pabeni@redhat.com; saeedm@nvidia.com; leon@kernel.org;
> tariqt@nvidia.com; andrew+netdev@lunn.ch; dakr@kernel.org;
> rafael@kernel.org; gregkh@linuxfoundation.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; cratiu@nvidia.com; Keller, Jacob E
> <jacob.e.keller@intel.com>; Knitter, Konrad <konrad.knitter@intel.com>;
> cjubran@nvidia.com
> Subject: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink inst=
ance for
> PFs on same chip
>=20
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Multiple PFS may reside on the same physical chip, running a single
> firmware. Some of the resources and configurations may be shared among
> these PFs. Currently, there is not good object to pin the configuration
> knobs on.
>=20
> Introduce a shared devlink, instantiated upon probe of the first PF,
> removed during remove of the last PF. Back this shared devlink instance
> by faux device, as there is no PCI device related to it.
>=20
> Make the PF devlink instances nested in this shared devlink instance.
>=20
> Example:
>=20
> $ devlink dev
> pci/0000:08:00.0:
>   nested_devlink:
>     auxiliary/mlx5_core.eth.0
> faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
>   nested_devlink:
>     pci/0000:08:00.0
>     pci/0000:08:00.1
> auxiliary/mlx5_core.eth.0
> pci/0000:08:00.1:
>   nested_devlink:
>     auxiliary/mlx5_core.eth.1
> auxiliary/mlx5_core.eth.1
>=20
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/Makefile  |   4 +-
>  .../net/ethernet/mellanox/mlx5/core/main.c    |  18 +++
>  .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 150 ++++++++++++++++++
>  .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  10 ++
>  include/linux/mlx5/driver.h                   |   5 +
>  5 files changed, 185 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> index 568bbe5f83f5..510850b6e6e2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> @@ -16,8 +16,8 @@ mlx5_core-y :=3D	main.o cmd.o debugfs.o fw.o eq.o uar.o
> pagealloc.o \
>  		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
>  		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o
> events.o wq.o lib/gid.o \
>  		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o
> diag/fs_tracepoint.o \
> -		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o
> diag/reporter_vnic.o \
> -		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
> +		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o
> diag/rsc_dump.o \
> +		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o
> fs_pool.o
>=20
>  #
>  # Netdev basic
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 710633d5fdbe..e1217a8bf4db 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -74,6 +74,7 @@
>  #include "mlx5_irq.h"
>  #include "hwmon.h"
>  #include "lag/lag.h"
> +#include "sh_devlink.h"
>=20
>  MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>  MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX
> series) core driver");
> @@ -1554,10 +1555,17 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>  	int err;
>=20
>  	devl_lock(devlink);
> +	if (dev->shd) {
> +		err =3D devl_nested_devlink_set(priv_to_devlink(dev->shd),
> +					      devlink);
> +		if (err)
> +			goto unlock;
> +	}
>  	devl_register(devlink);
>  	err =3D mlx5_init_one_devl_locked(dev);
>  	if (err)
>  		devl_unregister(devlink);
> +unlock:
>  	devl_unlock(devlink);
>  	return err;
>  }
> @@ -1998,6 +2006,13 @@ static int probe_one(struct pci_dev *pdev, const s=
truct
> pci_device_id *id)
>  		goto pci_init_err;
>  	}
>=20
> +	err =3D mlx5_shd_init(dev);
> +	if (err) {
> +		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
> +			      err);
> +		goto shd_init_err;
> +	}
> +
>  	err =3D mlx5_init_one(dev);
>  	if (err) {
>  		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
> @@ -2009,6 +2024,8 @@ static int probe_one(struct pci_dev *pdev, const st=
ruct
> pci_device_id *id)
>  	return 0;
>=20
>  err_init_one:
> +	mlx5_shd_uninit(dev);
> +shd_init_err:
>  	mlx5_pci_close(dev);
>  pci_init_err:
>  	mlx5_mdev_uninit(dev);
> @@ -2030,6 +2047,7 @@ static void remove_one(struct pci_dev *pdev)
>  	mlx5_drain_health_wq(dev);
>  	mlx5_sriov_disable(pdev, false);
>  	mlx5_uninit_one(dev);
> +	mlx5_shd_uninit(dev);
>  	mlx5_pci_close(dev);
>  	mlx5_mdev_uninit(dev);
>  	mlx5_adev_idx_free(dev->priv.adev_idx);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> new file mode 100644
> index 000000000000..671a3442525b
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reser=
ved. */
> +
> +#include <linux/device/faux.h>
> +#include <linux/mlx5/driver.h>
> +#include <linux/mlx5/vport.h>
> +
> +#include "sh_devlink.h"
> +
> +static LIST_HEAD(shd_list);
> +static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
> +
> +/* This structure represents a shared devlink instance,
> + * there is one created for PF group of the same chip.
> + */
> +struct mlx5_shd {
> +	/* Node in shd list */
> +	struct list_head list;
> +	/* Serial number of the chip */
> +	const char *sn;
> +	/* List of per-PF dev instances. */
> +	struct list_head dev_list;
> +	/* Related faux device */
> +	struct faux_device *faux_dev;
> +};
> +

For ice, the equivalent of this would essentially replace ice_adapter I ima=
gine.

> +static const struct devlink_ops mlx5_shd_ops =3D {
> +};
> +
> +static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
> +{
> +	struct devlink *devlink;
> +	struct mlx5_shd *shd;
> +
> +	devlink =3D devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd),
> &faux_dev->dev);
> +	if (!devlink)
> +		return -ENOMEM;
> +	shd =3D devlink_priv(devlink);
> +	faux_device_set_drvdata(faux_dev, shd);
> +
> +	devl_lock(devlink);
> +	devl_register(devlink);
> +	devl_unlock(devlink);
> +	return 0;
> +}
> +
> +static void mlx5_shd_faux_remove(struct faux_device *faux_dev)
> +{
> +	struct mlx5_shd *shd =3D faux_device_get_drvdata(faux_dev);
> +	struct devlink *devlink =3D priv_to_devlink(shd);
> +
> +	devl_lock(devlink);
> +	devl_unregister(devlink);
> +	devl_unlock(devlink);
> +	devlink_free(devlink);
> +}
> +
> +static const struct faux_device_ops mlx5_shd_faux_ops =3D {
> +	.probe =3D mlx5_shd_faux_probe,
> +	.remove =3D mlx5_shd_faux_remove,
> +};
> +
> +static struct mlx5_shd *mlx5_shd_create(const char *sn)
> +{
> +	struct faux_device *faux_dev;
> +	struct mlx5_shd *shd;
> +
> +	faux_dev =3D faux_device_create(THIS_MODULE, sn, NULL,
> &mlx5_shd_faux_ops);
> +	if (!faux_dev)
> +		return NULL;
> +	shd =3D faux_device_get_drvdata(faux_dev);
> +	if (!shd)
> +		return NULL;
> +	list_add_tail(&shd->list, &shd_list);
> +	shd->sn =3D sn;
> +	INIT_LIST_HEAD(&shd->dev_list);
> +	shd->faux_dev =3D faux_dev;
> +	return shd;
> +}
> +
> +static void mlx5_shd_destroy(struct mlx5_shd *shd)
> +{
> +	list_del(&shd->list);
> +	kfree(shd->sn);
> +	faux_device_destroy(shd->faux_dev);
> +}
> +
> +int mlx5_shd_init(struct mlx5_core_dev *dev)
> +{
> +	u8 *vpd_data __free(kfree) =3D NULL;
> +	struct pci_dev *pdev =3D dev->pdev;
> +	unsigned int vpd_size, kw_len;
> +	struct mlx5_shd *shd;
> +	const char *sn;
> +	char *end;
> +	int start;
> +	int err;
> +
> +	if (!mlx5_core_is_pf(dev))
> +		return 0;
> +
> +	vpd_data =3D pci_vpd_alloc(pdev, &vpd_size);
> +	if (IS_ERR(vpd_data)) {
> +		err =3D PTR_ERR(vpd_data);
> +		return err =3D=3D -ENODEV ? 0 : err;
> +	}
> +	start =3D pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
> &kw_len);
> +	if (start < 0) {
> +		/* Fall-back to SN for older devices. */
> +		start =3D pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> +
> PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
> +		if (start < 0)
> +			return -ENOENT;
> +	}
> +	sn =3D kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
> +	if (!sn)
> +		return -ENOMEM;
> +	end =3D strchrnul(sn, ' ');
> +	*end =3D '\0';
> +
> +	guard(mutex)(&shd_mutex);
> +	list_for_each_entry(shd, &shd_list, list) {
> +		if (!strcmp(shd->sn, sn)) {
> +			kfree(sn);
> +			goto found;
> +		}
> +	}
> +	shd =3D mlx5_shd_create(sn);
> +	if (!shd) {
> +		kfree(sn);
> +		return -ENOMEM;
> +	}

How is the faux device kept in memory? I guess its reference counted somewh=
ere? But I don't see that reference being incremented in the list_for_each.

> +found:
> +	list_add_tail(&dev->shd_list, &shd->dev_list);
> +	dev->shd =3D shd;
> +	return 0;
> +}
> +
> +void mlx5_shd_uninit(struct mlx5_core_dev *dev)
> +{
> +	struct mlx5_shd *shd =3D dev->shd;
> +
> +	if (!dev->shd)
> +		return;
> +
> +	guard(mutex)(&shd_mutex);
> +	list_del(&dev->shd_list);
> +	if (list_empty(&shd->dev_list))
> +		mlx5_shd_destroy(shd);
> +}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
> new file mode 100644
> index 000000000000..67df03e3c72e
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reser=
ved. */
> +
> +#ifndef __MLX5_SH_DEVLINK_H__
> +#define __MLX5_SH_DEVLINK_H__
> +
> +int mlx5_shd_init(struct mlx5_core_dev *dev);
> +void mlx5_shd_uninit(struct mlx5_core_dev *dev);
> +
> +#endif /* __MLX5_SH_DEVLINK_H__ */
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index 46bd7550adf8..78f1f034568f 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -721,6 +721,8 @@ enum mlx5_wc_state {
>  	MLX5_WC_STATE_SUPPORTED,
>  };
>=20
> +struct mlx5_shd;
> +
>  struct mlx5_core_dev {
>  	struct device *device;
>  	enum mlx5_coredev_type coredev_type;
> @@ -783,6 +785,9 @@ struct mlx5_core_dev {
>  	enum mlx5_wc_state wc_state;
>  	/* sync write combining state */
>  	struct mutex wc_state_lock;
> +	/* node in shared devlink list */
> +	struct list_head shd_list;
> +	struct mlx5_shd *shd;
>  };
>=20
>  struct mlx5_db {
> --
> 2.48.1


