Return-Path: <netdev+bounces-106208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7D79153AD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8399D1F24AE4
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8245719DF4F;
	Mon, 24 Jun 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZHqlV6t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82051EA87
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246439; cv=fail; b=hUs206tCmHPDM3CySssnaX4U4sokDOexA1lhR428gdpKEjbBbKwzCyuP5mf8zQf9vNRBon4aMskgvxnTn98cImnOHuP8DNcPUO9eZxjlyngsl527qcDIYQDJWG/H6lJ6qJYQ1yoC41WvU60bkJxwRQLoBi/DZHzmmGJS4d2TWY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246439; c=relaxed/simple;
	bh=+x5b/yz+vgbbSBD5X5Jrh+3sMFv3X8/exsCWohLGK7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FvTk/jlswJu+JTbO2cUW2/GV2Ck03VGQf4YdIVxQXjm2gKqTKkSaB1DZFHNWJv6cYJcQNFW0FP8x6LODxLNWe8Xn/NXy+wD1Ogv8D12HsL4Qy4zFFf82amK9qFFD1TS7v63hzTPkR8VmIY7DCUB8L9YEkp7rKxfXpBg1JMcO/kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZHqlV6t; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719246437; x=1750782437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+x5b/yz+vgbbSBD5X5Jrh+3sMFv3X8/exsCWohLGK7U=;
  b=hZHqlV6tXXEHHJWCYJ+DKAyIs4dtt9TMgLv+YLUxx1Q5pBTGETxE0EQx
   0SNYiTxXhwOvi2XMOiN8OciKBBvVpDm76L3DNyZhu6fKezoM04iujlIze
   ooZuhOgyqGHMnsGzU+WzxzOFXVts+VTMsV1tEuaRE48/kkgYtI99g/wcl
   tK9Cjf8wRCV8n+Wjdwm9ElHsc7vZe0+898iVTABtSyx0zod22jgHCkx6F
   qMUJBW5i6Vl3mX5PjHINTDwNa0B6rIMDKA6mtfSEshaG7q/8k43tzcQSv
   5x/yTAIeObRv6yoxcZ7gO7h+OMxYwASBEdehSdyKgL6Tnwbus4zFGlrGP
   A==;
X-CSE-ConnectionGUID: ckZt68MmRP2W0Gg8zAOKcg==
X-CSE-MsgGUID: uVKCwJXWQpiRCccz229soQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16052099"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16052099"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:26:27 -0700
X-CSE-ConnectionGUID: LmlnaXjoQ5m39+hhzvMGOQ==
X-CSE-MsgGUID: 2Rw5cykSQPKQppdIyNm1XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43461930"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 09:26:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 09:26:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 09:26:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 09:26:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 09:26:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk3LXDfUfQ2OYk/Eb8BtCYN6SQyU0i16HH//rZ+2QiBzdfd5/KP/ijWWEGJy8LJFwyBCNY8aM7iID7lE8cMfup+pT40Oe22t2YAgG+OsiVTkbEfhfb8DUEJfjT0Vvil1C4MSoseOcGfTiItXUMBwneO2CXsnbjFGoVlzE5mH6gGOJZAqYF+xUbRNdxS1i+n29144CnTfYHz+keAnnI+gw12xH4bQGcQuv3jL6gL5V8mSsw7XgiR9ThCv51lqCWXwRv3bzKM7jZhpkg7dIIJ/uBZWtLa/4qMmaDkKqpFyRe2lqsdJ52nfFORxwlXrYeB2XbTHDADZbN9WzZMG5TU0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XRnacuMbv077sUNf7kN1W7wekCt435SC1yXektNRt0=;
 b=Xz8tjDagmbPzc1wow7P+k/trXxvFBIeqPiB14XLX1JlUUK0Ii55NmkCqOETO2tahNyVC0iE/JLvcBezCOTBsiiSe/zcKZoG4uWCpr5YeIAg1EP1LbcPTbJHU4Izvn9ZWnm70cfQEnKzxnpMcbwQdB56XptD4dwC6FQhlalrQoL0ReS9hlOZvo7DoSl3ximAW4udXhF2sO6N7jQr1Zgdz9xjwyqJabEW/0KKfjSSHvuo/YU/l4oVRznZpVC7QgA3ZlifJFcjmXl0vKPYLkz4G4WX0xQiEdom4mleV0dx6ToT6wfhcHSMvGUiu6tQs/pKcB9tQSonJyMkCwIVFfvT2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 16:26:23 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:26:23 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Samal, Anil" <anil.samal@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Czapnik, Lukasz"
	<lukasz.czapnik@intel.com>, "Samal, Anil" <anil.samal@intel.com>, "Pepiak,
 Leszek" <leszek.pepiak@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 2/3] ice: Implement driver
 functionality to dump fec statistics
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 2/3] ice: Implement driver
 functionality to dump fec statistics
Thread-Index: AQHavlrZLt7B8QWEeEKQMnYWur5dTrHXKW3w
Date: Mon, 24 Jun 2024 16:26:23 +0000
Message-ID: <CYYPR11MB84294D39C25D60EF07DE6451BDD42@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240614125935.900102-1-anil.samal@intel.com>
 <20240614125935.900102-3-anil.samal@intel.com>
In-Reply-To: <20240614125935.900102-3-anil.samal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH7PR11MB7571:EE_
x-ms-office365-filtering-correlation-id: 1ead87d5-cc65-499c-d40d-08dc946a6375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?PYkhWLcqXCVLENdznG+zii6Iy0OknEU9xZI6iT+0p+kd3G2UEGrZN8jCZwf6?=
 =?us-ascii?Q?78JgKKdKnbfA3R9UePoubVnArJslxrlXw/r4pevJ2x24V2QJGE9n7qdYRBLc?=
 =?us-ascii?Q?a7frzo7gO85pdZqgv3wdsdL0OpFZarN5GWHsTr0e4/3QdJXFM+ElqEpmsS+3?=
 =?us-ascii?Q?YtJ+NGMrMVs7Wm2xnacYtOqZjy7sgQu+knO/L51XqxI7m53CEJ8lXSz291zM?=
 =?us-ascii?Q?96VSSMnjD+SxMq8kabTb4zyMLeXKClQsDTHtyuWKOrJJ59OMLQQEoU4iOa8v?=
 =?us-ascii?Q?duEbSfMaLt8nGqK510FA2g1OkqmDotn3IWRQxL1MBq3xBAfWDflLUyu/G0g1?=
 =?us-ascii?Q?Lok8fLp5AAVO0wbMKZNFu/p0CvwP5i5lWk0viLkhQACrma6ZZfx3gUkTbTv9?=
 =?us-ascii?Q?K9gezFMUmtnw4vfkNZf0lR2C0+dIjHEomD73b4SIFlN1jael9y3DyOpLpbf9?=
 =?us-ascii?Q?sj8E9iA3eA/A+y4hQd1VfDV2ICFTFTA3ZSCW9N4GpAPl3A2nVQMdzzF3eR80?=
 =?us-ascii?Q?5rlnNaFhGAZiRo09x6+ywz9XahztrroZDXTzIsCiE45ApDptc7K8MvGuIQNQ?=
 =?us-ascii?Q?1fQzL2y+zMq0zRTx8C8I0VZHJ8RWARrsVdr5Fs8/4ANmrHiYsJVqG1oQskKw?=
 =?us-ascii?Q?4WGUnVsUO20tDIEORt42rX0LY9WygBiqXWlOyZ/HfiQBKCXoozLrjzh4TRIT?=
 =?us-ascii?Q?Hz0KCFXAUdzt9bi0j97fV9hj/v7BW5vGFGs4BP68i907hKH8XZOItsaMNz3i?=
 =?us-ascii?Q?btAaUYlG4ZC6CvnmYcZEEdaqHQ3XebyykC5QHVPsWmSP8SlXB2TCGOpYede+?=
 =?us-ascii?Q?Q/yB7Kx/05uhQUeDO27LZJjkyWs8EdC8t6dq0f4Kdo7tDDUEtQKzFSMLgUKH?=
 =?us-ascii?Q?o5TTIm9vcYWPEFfOjgFvoVQoMYOwxgcOwo2umJ1esZIdK7yRcYz6Jj9/WGqo?=
 =?us-ascii?Q?bR+in7fMNfWvP0/ywEPnerqe0K66flgxJwZf1kG6VbTAYzVYEhIGuQ2/T2Aa?=
 =?us-ascii?Q?/10AhWRe4UZGRyAB2f4ND1ao/n+JSIwHD2ZemJDBfK4w/Yxl5s9duiMjjqjH?=
 =?us-ascii?Q?2l3Bd+TY8vdoij4NpsWfzlqjjlbZXogz5bRLlznsLJE+yV6n9mBPbPMPGUQT?=
 =?us-ascii?Q?jEj5jpaQh5BIshMYj+55Y+f789S358Rxy54V8V5lyKpLs2w1TwDsOA1c+64x?=
 =?us-ascii?Q?Bsdjho8IYRA+aL7qpss2NnCMjkrBswXURCcuZgkqgkQoGSzJx46sC4cBYRKO?=
 =?us-ascii?Q?U7ezIqVbIFOltcTKhbNXBANSidhXAPgNGH0elA1Mo9hisKfu8rJiy/8FWQzM?=
 =?us-ascii?Q?uyhiFTrvRR7aIdtfX5DgAjyHtchPu21S4A35ju5ZQLbjVNGSgzFbkg4U52xa?=
 =?us-ascii?Q?6X/ktaE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w7lmf4JtIhFbETZ9M9R90TH13tpgFYF0tkiO/S9BW9brfKt7YDlRpeS08oz3?=
 =?us-ascii?Q?owoHzcOJxdlCfOT7TRAyykF07S/46wi6aDA1hM9vdnUY7n5wPH9b8yo2q1as?=
 =?us-ascii?Q?xOfO2RfrM2/8sujZ1+gduSYfTUW/CokX/dEaAveexhojcCaAlujBG1pj6/F/?=
 =?us-ascii?Q?RYL1hR00NHHc3T8LxxkefEfidwlclldu7Y7hfQTDomip+bGmqGn4eDT9Y3x0?=
 =?us-ascii?Q?jKc7YpklxplTgf00zvE3oaGjlQYVqL17NnIoC92bayem2aFuaYbmgAb3242M?=
 =?us-ascii?Q?FlraEmmyKKM7bdWnLQ3PnK+gTQWHn9jCnVmmoHdriHqgw6/fT2Sd6JB9mLGY?=
 =?us-ascii?Q?aPeY3124IU1bFhzlnM/eiBXZ/7ttoS8ZUTiw2c04Ft3o1GnylSC4d+4Uz8xt?=
 =?us-ascii?Q?wunetKengyU8HJIBdWc7bhzPtSkycjYo455xeHR1MYtL//ZCYEnquJX1uDiv?=
 =?us-ascii?Q?YP8P0M25+GCJM2wDwczXQoaJH4Sxesqk09g5CSyFwHqfGbFt2P/ByWrqkG+l?=
 =?us-ascii?Q?1Tki4AqqMC/Hqo3spTY3bgE1v/d75HoL/+USKqAJ90kjHR3RXQ4bJ0qp4C6u?=
 =?us-ascii?Q?cmvBzOIzgfb3PNk1S5gzq6ILibhUvwa/KCaV24xmQGIHIREf/qvpLCWOL1rI?=
 =?us-ascii?Q?cUqH8IxVBrFNDDf9K5Uxuj7QwrI9/yTuDonNxoWEiRoJ5GIes00LLcLdqewh?=
 =?us-ascii?Q?IdUyWnSewxTryfr2KlKhtl7Wtn3Gq7uJKGYDuVym2MGuR4ZGr/Ny3WN6o/qz?=
 =?us-ascii?Q?HmSYFpu55Szu5B4cC9QRwE5WlKuBgZ7YlskFCW3bunqVu8zbw6JsmhXwhPlu?=
 =?us-ascii?Q?Sq7U15cTV0FfyNHsSA+HdSde1c82FVJm/fX3CT3JmUr6Rbi6zY9CYqJJzU+o?=
 =?us-ascii?Q?tYx1+qNC5RjYjhT8HA40H3glms8Z5UAYIfoMlY8krPyn3C/JwAMYqPVzpYP5?=
 =?us-ascii?Q?MB830re9R+N0MTq7+erwozgI/WwiG8lVPn7gGBwXQGxckUvfgLg2nmnQCPIw?=
 =?us-ascii?Q?MtvOaYcQDSlhNskCx0zmwTH5VD7OQmLO1pMWr0ltcSeJI01JMan5BdOdZuzn?=
 =?us-ascii?Q?LeyPhMN/8IlGXswZmUF/Ndicg4GQStub/XvLc/nqayOEijcYUwgtmcw+vsNz?=
 =?us-ascii?Q?oyidu9Cc1Vg0pvW2TCGbp5Ywz3BXKzv3QiM/ddhzvn5AKwAuiit3Q+IXGWbb?=
 =?us-ascii?Q?EnxOyh+HpBmirpX7PkkdkNnDxyBShg9uB0RDk/rZcCwIjCsxzYXgSLLHjoKs?=
 =?us-ascii?Q?5Gz7/nXIi0wOjzeF4v6bfCbmZisVm0cOrmILTIzKvJt90V6DmA9GPkp4O4my?=
 =?us-ascii?Q?tJ82aH13YM+IcfOH0v3SgQ/GZUfbveS3XNZgBpG3zaY8DF3PcPqzlNIvM6tZ?=
 =?us-ascii?Q?d2t9JpCX6Ks8TZQZA7VyoN256pQOYx+DV1ceEerypivGxoDnA5wQZRnCOALX?=
 =?us-ascii?Q?oxls6h7mVMJhyeRr28BWE07taOBNc8RGd3CSiGffbXWYXZWzmwIs3ZNt/HW6?=
 =?us-ascii?Q?o/ESypK2bg8eh1CDnfuJmObzqolHKXnMtzavfc/KLmkxmY3qrHcLtpJlw61F?=
 =?us-ascii?Q?03dLVpJLgyt9TbND/U9+pm/jP7Yl9heLck3FxFAJACKbveRnpw3sglL0FHfw?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ead87d5-cc65-499c-d40d-08dc946a6375
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 16:26:23.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVNbhaxfEzzxPM6+8+EPJXnK44ykaQS+yNOGs0j+8aAja7072mStVuFPxJJVbrItvzmcTYZFqjnb5KCBjEWrmIie+Xf1m+2CstT6GAsHq9JgBWOF4wCtVsxZhrTXdAAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
nil Samal
> Sent: Friday, June 14, 2024 6:28 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Czapnik, Lukasz <lukasz.czapnik@intel.com>; S=
amal, Anil <anil.samal@intel.com>; Pepiak, Leszek <leszek.pepiak@intel.com>=
; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Simon Horman <horms@kerne=
l.org>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 2/3] ice: Implement driver =
functionality to dump fec statistics
>
> To debug link issues in the field, it is paramount to dump fec corrected/=
uncorrected block counts from firmware.
> Firmware requires PCS quad number and PCS port number to read FEC statist=
ics. Current driver implementation does not maintain above physical propert=
ies of a port.
>
> Add new driver API to derive physical properties of an input port.These p=
roperties include PCS quad number, PCS port number, serdes lane count, prim=
ary serdes lane number.
> Extend ethtool option '--show-fec' to support fec statistics.
> The IEEE standard mandates two sets of counters:
>  - 30.5.1.1.17 aFECCorrectedBlocks
>  - 30.5.1.1.18 aFECUncorrectableBlocks
>
> Standard defines above statistics per lane but current implementation sup=
ports total FEC statistics per port i.e. sum of all lane per port. Find sam=
ple output below
>
> FEC parameters for ens21f0np0:
> Supported/Configured FEC encodings: Auto RS BaseR Active FEC encoding: RS
> Statistics:
>   corrected_blocks: 0
>   uncorrectable_blocks: 0
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anil Samal <anil.samal@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c  |  57 ++++  drivers/net/eth=
ernet/intel/ice/ice_common.h  |  24 ++  drivers/net/ethernet/intel/ice/ice_=
ethtool.c | 308 +++++++++++++++++++  drivers/net/ethernet/intel/ice/ice_eth=
tool.h |  10 +
>  drivers/net/ethernet/intel/ice/ice_type.h    |   8 +
>  5 files changed, 407 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


