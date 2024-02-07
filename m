Return-Path: <netdev+bounces-69946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D56B84D1E4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3078C1C22700
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F184A40;
	Wed,  7 Feb 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzFkqoIi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956D583CCB
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332437; cv=fail; b=KbQYFBhxDbuSroz5u+QEJkBmcbQcg0Y7u6Irxel1KE5DxpTJNE0NPg2XAK7I3rl2Cih1hUHd8PfQtKxCEdehn3+spSH0060bJhmzTrKwtJt4tGtIZWvxEPYIpRT2bD3JIa86vRtN8ZA0luc4/it4pWVdgmfe3PnpNH3Q6J7DK5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332437; c=relaxed/simple;
	bh=hkcd9H8G87KxV/QuB9A+t0DdI6UsMpf7NcjchBPP/k4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L1fw/4u0MNqFkIN08IoV5g8t4ImivqKQRgoem9Uuo+Zhr40ukPYsJylmWvda9cgfRE3YjN/yDLua1Uds21Z3/5+VUSKfNql0LjDvX7GZe9YtlRQnWYfILa8HWZ8IMOBBhuxczJxnrreZ2Wt07DCDDmPN3q5FRLQ2sf7byX1DDWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzFkqoIi; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707332428; x=1738868428;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hkcd9H8G87KxV/QuB9A+t0DdI6UsMpf7NcjchBPP/k4=;
  b=DzFkqoIivlAAJttWkVqOgBdrtLszUXI2c7+7FSmYZSjTtt+xTn5TQuhA
   V167ww0wxXOLxyOsu34M0UPjGnBsri+UzWonyy8OlElii6xmwXBtTxk46
   ReKMeuYrQq4yt4b3bdO5YjyEqDtQ7b0GVjjCzN4bTBc4CoquxajXRFUDu
   KsXjEaGFU92Ly9VNtGwoau93KmbduY4YKhjDwYaihOd2wyRY/Zz4CS+qT
   5WGBT1OZMN5SPLpz4P57gO6dEa2BvasY27tcOKmbXf6LNf27tzd7JXA+/
   z0T8oHjD5JSRDgG5Ke74hVub/HyCE6O6l+u1s0h7LwgYwcwz/BEavhQ0O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="18573435"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="18573435"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 11:00:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1405924"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 11:00:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 11:00:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 11:00:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 11:00:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 11:00:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccEJiv5/Py9xv4dijG3W28UYqntn1ljOQ6LPyRLJtUpXa9Qf7/wo4w2C7Z0Cl8kEkNs2gfmyluhD3EyobJRyYg5dTmdJQnsDan1zr7oX3xxJan6LBOH6LgOSOmZSHKyCgDhfizNuEi4seGAE0SFgZmdEBPTVFnOMdWuHjgAVz+z04/mU3XMX7SOrS+9WLsFs8xkT1yLRMst9iJjVLvZaxGpuMMsxW+CyOaMUoxF10VOriVfSsZ5fZ5i6Z8nOOiGMKDPxqCHJv1NcMq9XH1ovUgZ7zVLUiViSzGh/ixnQSo+ngOD2xv8O7IZxehtng664lQf6rv2vb5504LKwYjIr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2lKx9hkIPZyB2lv0F5c6O+spaKHOQilzGerOw+sJvk=;
 b=XWKRPO2gpd368AAA7mFMFiD53R73kgABA1gyYudP5OLYy2e3CxozR96337A4uU99p5H9I/WffuW+F5dT6pyUxVv+xuiOe3lG+9GzkPoxJ6XwkSI18icCEGjX0uQqcc4rSPdPYCBCWMq2JeyZKbub9KC7b/gIEvJ5mT29tmJoaho5evZ5g8NErxkAK6k4c+G6zF4oqVjt8BbY+VZKBQOX0NrejDdpkzIGU8tZ8vADYRb5jq0OMbsc7jSiTE6TX+oH6FjLy1Fh8R+PZB7seIqpYz/HVQE2yZD8lwo7rG8z1PWm5J4gql2CHSf4RUvygBV/c0dpzWG+IOxXHrbmMF5Waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4809.namprd11.prod.outlook.com (2603:10b6:806:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 19:00:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 19:00:17 +0000
Date: Wed, 7 Feb 2024 20:00:06 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Pavel Vazharov <pavel@x3me.net>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
Message-ID: <ZcPTNpzGyqQI+DXw@boxer>
References: <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
 <20240126203916.1e5c2eee@kernel.org>
 <CAJEV1igqV-Yb3YvZEiMOBCGyZXRQ2KTS=yq483+xOVFehvgDAw@mail.gmail.com>
 <CAJEV1ij=K5Xi5LtpH7SHXLxve+JqMWhimdF50Ddy99G0E9dj_Q@mail.gmail.com>
 <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
 <87wmrqzyc9.fsf@toke.dk>
 <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk>
 <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0391.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: c45c7f3d-cb18-47fb-5dfd-08dc280f05e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsJxHo97GTWZWAATKav5OVoNpKYIfwentkvuxCu2ACJ4A+bC0nrKj/9lPbWnOGb1gTzwnSooqHVc21RANp2sVDhdiBYUM7MGxKCQ4wo0L932NkGJD9hMO/FvlH0zQzpLrzOFzNhWdImDQN1XRzvaFMX4lPZY5bxtMUlwaOMEdC3+bgj6NMhTtHeRkpaF9GAPROoACNWg7jaPVj9me4DIS7EUF95nOI+DaCONPEvw5CC9VSDSySXS3l4yjn3PsDISjzFxtix/IIk8e87X5YKJiNS2TVObtPkMH0tAaK10Z2fd4JaYY3s34FgaaCZIT83hs+kNgs4WajP37jmxjf09Le8BqC26WtWHgwuiGqYcZLVnvkx931QQeKB+2yeNK6mEZtixY1wqKSyw3lmnqsQuO0fpnEtVOqLHPgAhIu4s/vxNTSJgDwPt7vChF90IdDyxbR8SPPGQ03/YEs4mev+I/4HwBYg4v8ayN4HVQ7CzA7BVN4nUVGG9QLc4/isw+JfXEdk9a7qSMUTknrPBO5RzU8AP/UT+uHLmUESafCS1NFJ4uXjhmwKK3ORXkKxYeRGMYKzggeGx6COHeLDmVFnk3b/NrR/dSMfcoc/+Ebc4CiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(39860400002)(346002)(376002)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(2906002)(38100700002)(82960400001)(54906003)(41300700001)(33716001)(86362001)(26005)(66556008)(66476007)(66946007)(6916009)(53546011)(316002)(66574015)(44832011)(8676002)(8936002)(4326008)(9686003)(19627235002)(6506007)(6512007)(478600001)(6666004)(5660300002)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXl4TWtEVkRrTW0yZnNNWVgrcHBEQWoyWkVnZjlLdlErSkJ6UlA2TVNQWHk1?=
 =?utf-8?B?L3R6ajB5NjVQL0l6NlFNOFV1UUp2UlU3bFRCQjcySGgxamlzbEdqSVBuVE0v?=
 =?utf-8?B?eWdFbDA3SitFL21nVkhFbkJKdDd6YXRSTWVaZmVaME9tUTJtWDV4b1RiTjJK?=
 =?utf-8?B?cXc4Q0tkcDFNeksrZXI4bmtJZ2xwVFIyQndjYldleW9pSEQ2cnRTTnNoL3JW?=
 =?utf-8?B?MVdnaUx4V0hGWWM5YjNhZGwvTEJ1R09OdlNCOHhPRmJzZ09OQ2ljK3hSNC9x?=
 =?utf-8?B?dVNwZUtacS9OV2YyVFdzK2dJSUpNbWp5NFdia0lCYlNmc1NIeXFsNDd3YlM2?=
 =?utf-8?B?NlJ1ZDRpa2YvcjhJbzBpVGJyb0p3NXJrSExSaXY1SmJHOE9JbzR2K3BZVW44?=
 =?utf-8?B?d0pJcHB0UDdoUTA5K3lKMUx2TWRDTlhEdEZzSGQ1UVNubEZBWURpblVqN3Rw?=
 =?utf-8?B?cHZzTjg5UDhiNVpXcE5TZWZ6cjhHeEJEQm1PTERvdHptMm1pUEZMVm5ZYVBD?=
 =?utf-8?B?cWlMQndweGxnR1FodXY2ZVMrTS9QbUxaa2tmU0luWVluKy9sS3BRa3IrWXh4?=
 =?utf-8?B?ZVVmRUgrK0N5RFlkT2NDYmV1c045Q1pOTi9pOW9pVHNQWlJ2Wmxabng5V3J1?=
 =?utf-8?B?RkJzZkp5K1pBMkYvb0E4d3ZDdmpNeTJjYWV0cU9tZHpLU1huY3hRcVFNb2VT?=
 =?utf-8?B?bXR5bldjUkliMDR4bFlDV2dxT3FRQUdzQlorTEpoUWpaSVJwNnpkNW1wSXBO?=
 =?utf-8?B?OU00S0h1RFNQVlI3OVl3Qm5PU2FjOWxOTCtvS2NoN2JmQlpaSFpqNWJIZ0Zo?=
 =?utf-8?B?bUFYYnlHb3FrUE1xbzcxWmxQWnhtV3ZTZVNjdHNiOGY4dW44R2Y1UnA3OE1T?=
 =?utf-8?B?M3RGL3ZvOWNWd2NkaDJmU3hLNytIZWtmclNxdHlTdm1EaFNTY3BNbE5ULy84?=
 =?utf-8?B?K1djRDRMRXlPaWRmUHN2VzBucWlFNDhmT1JETWZpTFpud2RwdWNybHE3ZGcv?=
 =?utf-8?B?NGNGWFc5N3pkSXMzOEVoSHFKNHZiRVM1b0RPdWMrL0NjQkFmNGl2OTlwaTY4?=
 =?utf-8?B?KzUyTEZ3SjE2NkJhQmwzNWNnWXpyZXRMbU5YZzNLSUJ1R3BSaXliazFRQkYx?=
 =?utf-8?B?SU9JeDZNTjZYa1Y3am5HYjBVSUo2cHF5TlgwNEpsTytDOUo0S25XT1pxKzM4?=
 =?utf-8?B?VVN0RDVkKzhpQXg4Qllza2xIbk04NEwwampjK0ppZzJQQitDUXZ0ME44YS94?=
 =?utf-8?B?cWs3TFVMRFlyTnZLUzNqdnFLcU5rWUxheWdzeXcvMWRETjRZQkxZQjA3Sk5w?=
 =?utf-8?B?bWVHQkY2QlVNY3ZZL2JsWHA5bTMxRkZYZzIxbkorVlNiZFRkNkdlbXlnV0xJ?=
 =?utf-8?B?L0RMMlBoSDVzeWtFVCtqd0hRektpNFQ2dWl2WWpnbVFFTW4yL3FyYzNBM1Z1?=
 =?utf-8?B?OEVnN3Z1Wjc4MHVnRGtGK3BCUG8rTXlKdXMxaE5UWkFSRXl6QjF5bVdQaGh3?=
 =?utf-8?B?azZ3aWtCaDkvV05VcW5zSWkxTHl4dVMycFVuSHFXTk5jQWFXQmduVUo1OXFY?=
 =?utf-8?B?TDFtZkw2YUZzU0Z2WEYxbXBqM3ArZGhkOG9wOUZ4UzNHZ0NGUVQ5Nkl5cHIx?=
 =?utf-8?B?cE03ekUyZHpQVWNQWDdweHFVeW83dHpzWTlrY1ZjYS9xZ2drekp2UE5ZUjJV?=
 =?utf-8?B?RTVxMzc0eTJ3L0o0My9QZlJlWDZnSy9LL05jY2s4MGZXZFdrTXQ2NXE2Smpk?=
 =?utf-8?B?MW05SDhDS0VKQ2Y3MzFSRUhQM3VVRm5XRk92aVNscUl5anE0anJnN3FtbExr?=
 =?utf-8?B?V0Z6TENDbzg4SitDY2M2M2NNL0V3NVE5L05XR00waHZNZGd3UXBiMmdtSjlW?=
 =?utf-8?B?a0RhZ3ZpSGdqVFRYK3Buc1NPVjRGa2loL3F0VW5BbHk3SGxnbUowOGUzWmRI?=
 =?utf-8?B?N2oyV2VBWEpiWG5WM3lXWFFEcG9JNVFRWkZmV3NyckV3YUxybkRCMVV3c2FS?=
 =?utf-8?B?N3dsd2xNRnNYTTM5bWJUakJMNWQzUTN6WS96bHBXQW9ZMTFEZjViaTgraE9r?=
 =?utf-8?B?bU1oNXdxc1lmR3g2ZWtwL2l3cStVRzdiRE5DV2VJZGJjaXp2QUFUKytWVkR2?=
 =?utf-8?B?OXRaZmFpUnZESTBIaXJHbFZpMkY0V1ROVTBQNGxNREp6QUo0V05LQUtzUThw?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c45c7f3d-cb18-47fb-5dfd-08dc280f05e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 19:00:16.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkrEyVzY0+d3QRQeazsgHCfhm4IvsLEOpUh6M4yfP7GHznGpbzSWVe6RurtgjgAaosS4sfBXYgWXvPpa7nvoeejTu8MgNIUCHdqxdl/hb74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
X-OriginatorOrg: intel.com

On Wed, Feb 07, 2024 at 05:49:47PM +0200, Pavel Vazharov wrote:
> On Mon, Feb 5, 2024 at 9:07 AM Magnus Karlsson
> <magnus.karlsson@gmail.com> wrote:
> >
> > On Tue, 30 Jan 2024 at 15:54, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> > >
> > > Pavel Vazharov <pavel@x3me.net> writes:
> > >
> > > > On Tue, Jan 30, 2024 at 4:32 PM Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> > > >>
> > > >> Pavel Vazharov <pavel@x3me.net> writes:
> > > >>
> > > >> >> On Sat, Jan 27, 2024 at 7:08 AM Pavel Vazharov <pavel@x3me.net> wrote:
> > > >> >>>
> > > >> >>> On Sat, Jan 27, 2024 at 6:39 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >> >>> >
> > > >> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> > > >> >>> > > > Well, it will be up to your application to ensure that it is not. The
> > > >> >>> > > > XDP program will run before the stack sees the LACP management traffic,
> > > >> >>> > > > so you will have to take some measure to ensure that any such management
> > > >> >>> > > > traffic gets routed to the stack instead of to the DPDK application. My
> > > >> >>> > > > immediate guess would be that this is the cause of those warnings?
> > > >> >>> > >
> > > >> >>> > > Thank you for the response.
> > > >> >>> > > I already checked the XDP program.
> > > >> >>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic to the application.
> > > >> >>> > > Everything else is passed to the Linux kernel.
> > > >> >>> > > However, I'll check it again. Just to be sure.
> > > >> >>> >
> > > >> >>> > What device driver are you using, if you don't mind sharing?
> > > >> >>> > The pass thru code path may be much less well tested in AF_XDP
> > > >> >>> > drivers.
> > > >> >>> These are the kernel version and the drivers for the 3 ports in the
> > > >> >>> above bonding.
> > > >> >>> ~# uname -a
> > > >> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
> > > >> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
> > > >> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > >> >>>        ...
> > > >> >>>         Kernel driver in use: ixgbe
> > > >> >>> --
> > > >> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > >> >>>         ...
> > > >> >>>         Kernel driver in use: ixgbe
> > > >> >>> --
> > > >> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > >> >>>         ...
> > > >> >>>         Kernel driver in use: ixgbe
> > > >> >>>
> > > >> >>> I think they should be well supported, right?
> > > >> >>> So far, it seems that the present usage scenario should work and the
> > > >> >>> problem is somewhere in my code.
> > > >> >>> I'll double check it again and try to simplify everything in order to
> > > >> >>> pinpoint the problem.
> > > >> > I've managed to pinpoint that forcing the copying of the packets
> > > >> > between the kernel and the user space
> > > >> > (XDP_COPY) fixes the issue with the malformed LACPDUs and the not
> > > >> > working bonding.
> > > >>
> > > >> (+Magnus)
> > > >>
> > > >> Right, okay, that seems to suggest a bug in the internal kernel copying
> > > >> that happens on XDP_PASS in zero-copy mode. Which would be a driver bug;
> > > >> any chance you could test with a different driver and see if the same
> > > >> issue appears there?
> > > >>
> > > >> -Toke
> > > > No, sorry.
> > > > We have only servers with Intel 82599ES with ixgbe drivers.
> > > > And one lab machine with Intel 82540EM with igb driver but we can't
> > > > set up bonding there
> > > > and the problem is not reproducible there.
> > >
> > > Right, okay. Another thing that may be of some use is to try to capture
> > > the packets on the physical devices using tcpdump. That should (I think)
> > > show you the LACDPU packets as they come in, before they hit the bonding
> > > device, but after they are copied from the XDP frame. If it's a packet
> > > corruption issue, that should be visible in the captured packet; you can
> > > compare with an xdpdump capture to see if there are any differences...
> >
> > Pavel,
> >
> > Sounds like an issue with the driver in zero-copy mode as it works
> > fine in copy mode. Maciej and I will take a look at it.
> >
> > > -Toke
> > >
> 
> First I want to apologize for not responding for such a long time.
> I had different tasks the previous week and this week went back to this issue.
> I had to modify the code of the af_xdp driver inside the DPDK so that it loads
> the XDP program in a way which is compatible with the xdp-dispatcher.
> Finally, I was able to run our application with the XDP sockets and the xdpdump
> at the same time.
> 
> Back to the issue.
> I just want to say again that we are not binding the XDP sockets to
> the bonding device.
> We are binding the sockets to the queues of the physical interfaces
> "below" the bonding device.
> My further observation this time is that when the issue happens and
> the remote device reports
> the LACP error there is no incoming LACP traffic on the corresponding
> local port,
> as seen by the xdump.
> The tcpdump at the same time sees only outgoing LACP packets and
> nothing incoming.
> For example:
> Remote device
>                           Local Server
> TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/12 <---> eth0
> TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/13 <---> eth2
> TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/14 <---> eth4
> And when the remote device reports "received an abnormal LACPDU"
> for PortName=XGigabitEthernet0/0/14 I can see via xdpdump that there
> is no incoming LACP traffic

Hey Pavel,

can you also look at /proc/interrupts at eth4 and what ethtool -S shows
there?

> on eth4 but there is incoming LACP traffic on eth0 and eth2.
> At the same time, according to the dmesg the kernel sees all of the
> interfaces as
> "link status definitely up, 10000 Mbps full duplex".
> The issue goes aways if I stop the application even without removing
> the XDP programs
> from the interfaces - the running xdpdump starts showing the incoming
> LACP traffic immediately.
> The issue also goes away if I do "ip link set down eth4 && ip link set up eth4".

and the setup is what when doing the link flap? XDP progs are loaded to
each of the 3 interfaces of bond?

> However, I'm not sure what happens with the bound XDP sockets in this case
> because I haven't tested further.

can you also try to bind xsk sockets before attaching XDP progs?

> 
> It seems to me that something racy happens when the interfaces go down
> and back up
> (visible in the dmesg) when the XDP sockets are bound to their queues.
> I mean, I'm not sure why the interfaces go down and up but setting
> only the XDP programs
> on the interfaces doesn't cause this behavior. So, I assume it's
> caused by the binding of the XDP sockets.

hmm i'm lost here, above you said you got no incoming traffic on eth4 even
without xsk sockets being bound?

> It could be that the issue is not related to the XDP sockets but just
> to the down/up actions of the interfaces.
> On the other hand, I'm not sure why the issue is easily reproducible
> when the zero copy mode is enabled
> (4 out of 5 tests reproduced the issue).
> However, when the zero copy is disabled this issue doesn't happen
> (I tried 10 times in a row and it doesn't happen).

any chances that you could rule out the bond of the picture of this issue?
on my side i'll try to play with multiple xsk sockets within same netdev
served by ixgbe and see if i observe something broken. I recently fixed
i40e Tx disable timeout issue, so maybe ixgbe has something off in down/up
actions as you state as well.

