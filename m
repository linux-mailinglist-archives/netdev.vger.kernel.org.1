Return-Path: <netdev+bounces-78212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1F8745A8
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 02:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF8D286BEF
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 01:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9A4C6C;
	Thu,  7 Mar 2024 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlxLxUno"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEEA17FF
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775238; cv=fail; b=p0IZ9QRY3cWOqJwHdiaEi2Pe4VuxOlkATtQy0Yj49h2c18HpWnJ2+TZgl5oVL1uBHsAFZrxQXFY6tTGdwatY6TZKePAdK8ir/y63lAx14wUZ2DlPQpP1a4c2hAA764pjzVYDtzQcR/+qGoXi5oDwaRqR2Lu7l+XoeyN4cROt/L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775238; c=relaxed/simple;
	bh=iu0aJQbix5g+0IWdeAi83dJXLqx5shcdx9d6JUdI+LI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MoO0TvZHbMjY7TB43752avq8Sob2MVKMEQ19R86N+UUN0lUukcjw7IAuZcviePuy8auLMjDlsd7kOhH0CMrR4LR+ofrq5pDUFOfTlrh4QFSKlO2LJyBMdM2xraMkKLiVSJxh8G/DDxbhvgWajBdpb+9vujvEhb9WQwuCIXTVmnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlxLxUno; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709775237; x=1741311237;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iu0aJQbix5g+0IWdeAi83dJXLqx5shcdx9d6JUdI+LI=;
  b=ZlxLxUnoKzfORZoQvj55AwiiRzr61lZ+/SS8ftfW4cRcvK1U99AB7Tb0
   8bf/Hr8ifeXo9HWF6AcQ9fQwn7B+sbHSRqfU+pTNryw0icSfq+iqCr/bk
   96BV0plf+Vnm3Uxnz1tW8r9sKNyBCR3BP1+Kxz8/+fxiw0txU//ZRsbfd
   GCKOxkyRWOfzSEaFyKpYLGzobbw0fEhgJfSUi4cSXO9h8+orln68P7wYP
   C9gtWK58DANfD/lb3VnbVTS6cyofL3kWr5tZIgNZ228hguk7huLTjVibf
   04OInJgtDQicMlvPj/cNbPxfIAVFrCSfvQipa8+h57ymyD8/KKVK0HqTv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4282697"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4282697"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 17:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="10373462"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 17:33:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 17:33:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 17:33:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 17:33:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYrsWAkaoTwP50lxsL1uKvTW64p5U/U74ipSUsjctrUrdOLqg5pmhfdCehnGCCVZW42RYexghk/cf6z+3C4PKBnulueAJgy69oleIebPkWhWIR1pnPNeSe/3f4upobOU2sLSNqAbzjuG0kBmp/rgpYfSVM89QKCLxBmAX1JOKJKHsPMDvLERoSsbho0/bDtK213npTr6HWhgHslIb2GKw1RgV+BCkUnCl/sxKpuLQ5GRjTYrx2GUGumWWepmov4SI0bbsZtT6c3Skb7r71XuLZfkiYK7qq8nDUA6PC0b8uJ8zB2dfLaXqQudq97aPNrGIo/zcTpv+ycYMucyKnhJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hASSBpnIPFlPeAI1gqNCVYJkOEsO9CBwpEkQqZfU08o=;
 b=Yb8mvgTIxzpLt0uz0YyNPCJhzwwye8QrWocn4BsNFhnagAW9ILJGmNI+otBaG4cZtbNxUgcCUpn8He9yn6poAveCdXo8VPXMu/0/mraAe1olAFDCAK18J94dwNZolT/KMZ3ibrKr0KQcNbYI/rl5YlqsaFCb5TkZgBchx8+/NYtlzMGuG8940Yruq0QS4bNtdNX2QHkyJ4ZABzSwxEJ15jl6LrV+/5P1y1UBsH28qDzPyS2Z6V2l/2Z7II3eYBPPXZeCoUKGnDzlk/KJKWMrnm5Vq+OFhm45u2iDsP8BnPtJoRLOnmOEwzl4YgvgbhvaSl7oPj7hbp3ADk5N1EvAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Thu, 7 Mar
 2024 01:33:53 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50%3]) with mapi id 15.20.7386.005; Thu, 7 Mar 2024
 01:33:53 +0000
Message-ID: <02751cec-c273-4120-adad-6ea16a86532b@intel.com>
Date: Wed, 6 Mar 2024 17:33:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v1] ice: fix bug with suspend and rebuild
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Robert
 Elliott" <elliott@hpe.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>
References: <20240304230845.14934-1-jesse.brandeburg@intel.com>
 <ZeidykgnELeMx6xm@boxer> <ZeigQdj9K6CZocbL@boxer>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 xsFNBE6J+2cBEACty2+nfMyjkmi/BxhDinCezJoRM8PkvXlIGZL7SXAn7yxYNc28FvOvVpmx
 DbgPYDSLly/Rks4WNnVgAQA+nGxgg+tqk8DpPROUmkxQO7EL5TkszjBusUvL98crsMJVzoE2
 RNTJZh3ClK8k7r5dEePM1LM4Hq1bNTwE6pzyHJ1QuHodzR1ifDL7+3pYwt5wowZjQr4uJXFA
 5g5Xze8z0cnac+NpgIUqUdpEZ+3XmI92hIg2fUSRPUTgm+xEBijBv2OlTjZpzVfH8HlXeGCT
 E98Vuofvn2pgTZyJWJ6o0I9JUlxO+MMtMPuwL7Br0JqZQvvf80EFxbXnk+QSudg0sZAAec0g
 TSGWb7513siAqvAhxGjIf0cs2hEzRXbd4cVMZKPV2uai5g2LUsnS8m+zx/fzCC+KefKcxN8r
 Fs+9jNj2TOwmqahJqRBwxQZujNC96pkCQYzZtuz5BA7IMxC12TtnbvtUL6ef7GZVMv6b+rpe
 RmWnLIfGJItWefcse66l1wPQPi6tXmzBN6MaEDyVL6umiZTy7dnltaXsFZPPLapuk0qRoQtC
 aIjjk5VaK16t6pPUCRDW1um2anxOYBJCXzHrnzKf09hBgjbO2Tk5uKRQHpTEsm+38lIbSQ2r
 YUfOckMug/QHW05t+XVC2UuyAdjBamdvno7fhLaSTsqdEngqMQARAQABzTBKZXNzZSBDLiBC
 cmFuZGVidXJnIDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT7CwXgEEwECACIFAk6J+2cC
 GwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEKaiMWVzwKZycZ4QAIayWIWvnV2PiZ0E
 Kt7NMvSB3r3wx/X4TNmfTruURh24zrHcdrg6J8zSlXKt0fzxvvX7HYWgAEXD9BoVdPjh7TDy
 du9aMhFCFOfPHarz8DdGbT8UpGuX8bMZyd16/7nMqoGisK+OnmJubPxID2lDmXDRbxROahNF
 0ZJVXd+mw44FefzyJigJnfXtwyDuIit6ludKAs2iW3z298PuL13wiiG8rg5hTdWANxcC6wEh
 sycdt1JcKO6y5wcDwBr/yDPsUKaQPZTxRyiBK6NmQEN4BXbcG90VSgziJDPuYQb9ZOv2d0lX
 yidkXe/U9SpTSEcC6/Z8KinBl/5X/roENz5gW0H27m52Ht1Yx6SRpA3kwdpkzd0r5dKLCOVQ
 IwrAec5oLZRQqrSVp9+6PH7Z7YVQzN52nsgioQT8Ke2yht2ehsaJ97k718XhIWACyJqqmo/k
 wkj+5aUAi3ZXVOw3TGOpsfuz50Ods8CtGDHsUFwKlH10wXxOFdTa4PG+G4LTZ5ptkdFzm2rb
 9GJF2CSUS3ZMbBAQ/PZf1WpGUXBpOJMyD2AbWJQKTNn4yYMskMbnr4sGxitj6NHI4unlyd28
 1FmaRbR98v66sXYVVSP1ERFS/521OwMvWkPNuPMpqZ1ir9Nq/kw4t+urpVKF7RR87yuT46Gx
 /h2NVEXa750f7pf2LfPLzsFNBE6J+2cBEACfkrEDSsQkIlZzFgAN/7g0VmjHDrxxQSmvuPmZ
 L9pI6B/nNtclaUBu+q3rKUYBJhOfMobsafKOV8jYkENqOXvOvpb21t8HJ0FgqpMs+VE98gkp
 BM+Nitd+ePRJNScB8DKFmTT97QLBB8AdTWGy1tCSncoqhIz15X4ALplQkIoCuxdKPEuTeiyV
 mJFwvS0pB/GdN8hQEddRIo3E61dtLmSCH0iw6Zd8m9UHoZdZLWjfG+3EyeQ2TK0AFU9GpxVY
 nJ8mDacZlpcq4mjbr4w0G2IyjGyO6iLHKdYe3lU5Hs7lxZGbtnGQbGKL9VimV4IkKsXmTE+4
 /Mi+hWNxFBbZ7f7DUO3B7mZOicxxf2dK+vioHUr9TkWFwXARPwQGlGc3nGPQBhfaso+Q0q+b
 ftLhcdVDJjfNXvptWK3HbXQDsnkZ61nOEvjHDjpLQyzToKTSRoDNvnou2d26l5Nr7MHsqgxd
 xRKIau5xOAqO87AWHnbof3JW6eO8EDSmAYNWsmBBWFO7bfcJLyouiPSkDpsUniLh6ZAHyljd
 tYLPWatBqzvj28tTnA++Jp1bKDpby92GXQE2jZJ+5JCT+iW6dGQwrB9oMILx4V0WAvFsZT4t
 bq1MdS1n0qZD3t4ogYVqmYJyiB5ubTngI+s+VhDw3KbdhURJkQQ8dmojVfJZmeEH3u/eawAR
 AQABwsFfBBgBAgAJBQJOiftnAhsMAAoJEKaiMWVzwKZyTWQP/AlWAnsKIQgzP234ivevPc8d
 MOrOFslJrIutYqIW0V+B6teIcr73lejBl1fWtxn0mGPiTdNg/tJ48uN8K38yDzpxxmDDaKJa
 GGW6VPRezSpreqFjoEIz5NtJOo2dl7iK/6y7bAdlAeQj2Dvwj7Y1lB/JIbw8yoDg5Xl8D2db
 I8hchtsSXs8bxReEP1BGGsg4uyceOUexa1vAIGy80JDobbcjRaAo7xdwCXQjfEoC5UJVGd8g
 k21zDAUw3Eh47qO216txWwvOi+fq9o0UnOOAJ0xTRnQt1r5rMxEa8nLlChgfOSAdvBfaKAkn
 lIeWKK9LuETsiLpbofrey42d3wUUXggHYleYr9gR/7kQze78OATUHcud00B6EnmGDTOpbykp
 fby8AwgfbmcGz3LzgoZM7W9fnAkfVRuBOF5ge48kZecjHGxE69VB9180Aq6Bo2QVBlp3Le0j
 97DvMAwMgzyvfHHBPV0B9uzfxyBcxc9bRHXk0IiVIjm2e4gR+5WdsgXFd867ezQr3EiIe+6U
 +k7ZSjyrj7tsJOk1tKAvQKvMlxfRecw/yJDcKwwBHgEXVEnKgbu/Ci+ikbqsLCBWbOWs6eYq
 6m1nRM6nj0pgRDHIOQIxdWEysPWgmY2xxHb4yUq5YWa5+xu59zXdG72FqGqN8+Mkdw+M9m4D
 /fnLfll98Nhx
In-Reply-To: <ZeigQdj9K6CZocbL@boxer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:302:1::34) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|IA0PR11MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: a52c5e02-64af-4e8d-7803-08dc3e46a5b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuWeZOsQI3wlNf77wdTug00vkMBmpU8Q/Dfs5zqDqM4JdsXkzGwRdoryFtmWUP33+eMmeuQC8qiEBHgJAoyOzB9r6rqmWD81PIZt4jEkfG81Ju70n6t3J/LWWwaoIw7ftFFaVCAgIVtP1NI+MsHIaBSal6rePFRbK/9EpQWf0buCErzOjP+hUX4dXeb09EuO8PKtkrYzf/jF84vYZY05e56DIoLomrr9yYlDLw/JoMGsygq3kJg+gWY5OKT3Pbqyy8U87zgdQBO4eY5WhgM6B3LGpWX7Np2sSGQOu+fo3ACdCwUsgvzKDUVtKtZFITWDu0KtY4MC3iXcNSsSP6LMow9LISdrSGKp6CZnHPKy1HVFExnUYKku2a0e+vGJqLxNwW+Q9xeNMSni1op2/CimeZITOvfntk95IamhV5pA6UQUp9dv5bxcazpG8wOfHe5jf4eI6KhvkqoImO2BYBGEZSmhw8xNk84GJwPO1gct13Dnvju0zojNVk7en4N/smrK1AuYsdUfm/uaQ4Kr5ySS4dwgLCsssu1hUe8Bt3klomQWVH1LuByl2C0eTx+BpcHH5ThC9x1u3Dle4qv/TJbnBPaR1heaIYzbQY3gDJm1/eNnBn9ig6pXET68wFqbOr+JWlFZ0fRN3uNY5KdMxaDwyQPOE3cPYnL20kUvBQANvio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZjNFNSNzIvVk41c0VBdTQzOEU2ckZoSktrN1hpR3BhWTZ1dkNXd2pLUHdH?=
 =?utf-8?B?eG9hSTk0VDV5ZWlXOWFlRHRzZUtzcVRkNnhlNkdUdStOcFNucC9GK1IwUnJa?=
 =?utf-8?B?Y25PSWZIZGtFR3E0R25XT1NKdE5ZbU9TbDMvSnJZWUh1R05LdGVMN3ZZSCti?=
 =?utf-8?B?WHpxcTBqZElMYjJjWVYrTXRzV21ZMFlRZy9PVlg0d01sMEp3T2QzVHdzRlZW?=
 =?utf-8?B?WHk4M21vZ2p5UjA0QU9iZkt2Mko5RjZiVGRpMWFjTXBXMlNmQ1JFWGxNUC9s?=
 =?utf-8?B?cWdHK3JmWnI2cjVTTHlBbjJ0UmUvT0RzVUJKS1poVWd2RDFmcnpQOXc0Nnkv?=
 =?utf-8?B?cTJpb1d5QWwxMitwMnlrTkgwVmhXclNudThRUEx0cFZQTWpPTEVGNkxHMDNQ?=
 =?utf-8?B?dDBvOFJ0bTFCVjQzV1I1QjhucTFGZ2ozNXBQd2dXK1lLSDlRMzBRamN6YitL?=
 =?utf-8?B?eC9EWkVYVUJuaTBqTzNsZlM4SytsZ2hObzRxQVZJRmg4ZG1vNzM4TnAvNE0z?=
 =?utf-8?B?TW9mRUw2dEVtZFYwT215VHlvQkg1YjF6VE1raUdoZFNuZjB6cWpER0lWYkNB?=
 =?utf-8?B?MERrUmdMaklDdWd3cVpmM1A1dGpyUkMxc2FEOW5iWE9XUnd0YWo4N3NhS2Rl?=
 =?utf-8?B?MkVxcS8zbXVJUlFEdU83Y0hrUUV3ME9WTDJzalBGSUkwS3J0R1NZSDhpTUdF?=
 =?utf-8?B?ckJBdGsvMFYwTkZ6a2g2dmJOeloyaE1FM0tsT01QUXVlVE5OR2xUd055NE5F?=
 =?utf-8?B?cWhsamJ3NEczbFg2U0s0U3VXV2w0VWN4YWE3R2J2UTFxUldKVEtPYnJ4dHpQ?=
 =?utf-8?B?L3E5dVRXM1FWekE2WlBOVmQvbHd0QXh4cW9mZUZ4OUxrU2JBdXRRdmd0K2N5?=
 =?utf-8?B?eDlmT2s0L0NNQ2doZEZJcmgyVEI3bGtMUXVQM0tkSCtZaEsrTjhkMTdsL04w?=
 =?utf-8?B?NlJJbFdlMTE3eE5lMHgvekl0anUvU3dDRkR5cGErKzhmSGVsN0RjYk1YTmU2?=
 =?utf-8?B?dlZlRk5LTlV4eExBZ0FTVzQ5OXNuOGpqckpFL254RHZ6akVCRE5aK3dyMUQw?=
 =?utf-8?B?VjZQWnNPNjByYWtMZGlHTXYzdmZ1ZGlMSURtMzgxdVFabTdBcklRbktJRjQ0?=
 =?utf-8?B?a2dyMzg3RTFKazlyVmt5STJJcjBSNTFBd2g3aWxia1NqYzRJQ1lrcklubnpT?=
 =?utf-8?B?aWdvK1IxUUsvVkhUWEY4czZ5SlF2Qnc3dkszaExrSTJEV0NYOG1ITlY5d0Ey?=
 =?utf-8?B?WnBiR1FjZEtVSW95aUMwRy9WdGJZRmptdXlON3o5aG8zWE1adVdyb2ovY1pO?=
 =?utf-8?B?UUpNT2tONldsNlpNcDVZZnRpb3BIbGtZamcrRTYyYjRsalB5ZHB5RWxPWjV2?=
 =?utf-8?B?bjV0VzdJaXoyQitJSHdNb28zYmpxV2lJOU93c0xqU3FDcUV6TzBMeTdSMW41?=
 =?utf-8?B?UVMwM1l2S2R4S3orQm9JaDFpSElzMHFaTVVNQU1DL1pHYnBlQktMSWduYWpj?=
 =?utf-8?B?K3d0T09KQzdmSWpTQ3BFNUp5MlpnRDZrN3o2ZkUxNXV0a3BsR3ozZkNQQmU2?=
 =?utf-8?B?bWpHOFp6Q29RUnY2eHJMcG1YeTRXcEhiYUZCbkN3ZVdoOEFyWU1USGU1bU1s?=
 =?utf-8?B?bVlKK2NVeW5NSlBxa0ZJZWtNa1pFUDBtQkwxUGV4aWUvQURJMDRPeWhheGh2?=
 =?utf-8?B?SC9NRG9TT3VrU3ZOejNXd0JxQkRyTlNtRXhqYjlNV3VkSjVSSERrMWhmUnhT?=
 =?utf-8?B?WDNtb0NzTGtIcVZUOFI0Yi9BdFMrQXlHaTRLamI5MXEvSEFFWlh4RFVHeUFk?=
 =?utf-8?B?QmZ1UUd1RkxKZWZWazltRUdvMmUzeEY0TXlRY3ZyaFF4d0RvenpPZWplOW9k?=
 =?utf-8?B?OTdZek9CdDFTTG5meDZMSE9GZ2ZDSVlhV1FTN05td2xwUURQVGppNXJqS2dM?=
 =?utf-8?B?UTFmSjNZYnROc2xDdUNXZVg1Mkc4NXZWbG54eUxRWW1LZHhIdEVVWHQrbGdh?=
 =?utf-8?B?bmNxMlh2ZmtaUEZZTU5DeWNMSm5DNVY5NlNkSTBpTGJLY2U4STZTODQ2RTl4?=
 =?utf-8?B?SXIydVhFaGs3NXY4QnNsNkVZdDJISW1tRGNNY1F3T3Q4a1AwVVd3RjhUMG9I?=
 =?utf-8?B?QUdjcnowd3VRUTY1VVZOa1FBTmtHbW9NeE1FSVhSSU9lT2JoQkhxM1dOZ0F5?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a52c5e02-64af-4e8d-7803-08dc3e46a5b8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 01:33:52.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUnEDtvPuMjOqt4nCmmqeV3Jh2xGQ/s0CAzXIUTwseZbi6AMBK/jXFNCIUnhjJHD4nfT1RqLDxdPwoq0Rjr8/Tgr58e5cS/IYeXcP4IYSB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com

On 3/6/2024 8:56 AM, Maciej Fijalkowski wrote:
>>> Fixes: b3e7b3a6ee92 ("ice: prevent NULL pointer deref during reload")
>>> Reported-by: Robert Elliott <elliott@hpe.com>
>>> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>
>> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>
>> Well, that refactor of config path introduced lots of issues. Could
>> validation folks include a short list of tests they tried out against
>> tested patch?
> 
> Sorry, I got confused and now I saw the same thing Simon pointed out.

Thanks, NP! this thread is for v1, and v2 is already posted with the 
refactor just moving the CONFIG_FOO in patch 1, and then the real final 
version of the fix in v2 patch two which switches all the intel drivers 
over to the new macros.

> 
>>
>>> ---
>>>   drivers/net/ethernet/intel/ice/ice_lib.c | 16 ++++++++--------
>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>>> index 097bf8fd6bf0..0f5a92a6b1e6 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>>> @@ -3238,7 +3238,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>>>   {
>>>   	struct ice_vsi_cfg_params params = {};
>>>   	struct ice_coalesce_stored *coalesce;
> 
> struct ice_coalesce_stored *coalesce __free(kfree);

Yes, but not in a "fix" patch for -net. I figure this is more of a 
refactor kind of thing, so will not include it in this change.

> 
> ?
> 
> and drop explicit kfree()s altogether?
> 



