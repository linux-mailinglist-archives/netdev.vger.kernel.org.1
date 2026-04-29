Return-Path: <netdev+bounces-282310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MLbCDLJ8Wn+kQEAu9opvQ
	(envelope-from <netdev+bounces-282310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:02:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA4E4917A7
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97145301105C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4E22B594;
	Wed, 29 Apr 2026 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLWGvI3+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43913635E;
	Wed, 29 Apr 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453329; cv=fail; b=jmec5xJms9gcfMYAtww/VHqXhxxUkw/HyeAGImclMNHSf8SqeTZY1DY33fWHQY/XvsQcpkf9tJSFzK4lzX9btPlcRsOc4/g8Bv6r4t5A2H7MJFvUwsjFPSlb6O5vbUp/jNJkkG9KHfc2R5Uk/fNSqcO1JN7qfvVmscLEqynmxeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453329; c=relaxed/simple;
	bh=nMarTOXCsp7aDNihnPFRFLPXTnH4a+yg18qUp/WZPCU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L+uidDWB0Ay369pBvaA8CSLBQpd03xerdR2GKvjvBMpnpU0Kkuo9riIRzAMVdaZhqcrHt7mBmqeB2/HO+pmerTQ1srij+9tlvfShKZte5sdHSyOAyFTGjxIjQnaIk8EphaJhi9YhO/8SFBmv7L6AYzmyCSqNKef0/aD0i/QEcrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLWGvI3+; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777453327; x=1808989327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nMarTOXCsp7aDNihnPFRFLPXTnH4a+yg18qUp/WZPCU=;
  b=HLWGvI3+0YXHufM/Wge+pK3IcpPqyyjXII1rzyqyTTiq2ih7U+pWqlDk
   PuR/OVTKknEeD3xVcMcRBPk4CGVu5sU8nf7f432BMvzMUHi21XkOzIbVr
   GYd2LtO1iUrM159xkfYviJEN3xxLRddrOxbv0PvD+Kry/ptGaZE3T1z/S
   Px2zUoK6jAhKEXVYFIbwIfOJVPcq4JUi9IYEHXb3YAGRXCqf/dLfUKerp
   bkNUtVUpwNTTjTUqvy6n4Gfl2xe/zDVLn7Q2HFJ1Ee0cVbsh6FWetnqa9
   G8uUKvBg6ZOJH62On7AXmerQULyHgBbgCmA6rSH3gvYIs5z3VpDM++l9a
   g==;
X-CSE-ConnectionGUID: N9ZtJGj1SQejwYYgeoxNaw==
X-CSE-MsgGUID: 1DZGEWJDSOaQLwa+Q3KnKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="103832439"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="103832439"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:02:06 -0700
X-CSE-ConnectionGUID: V4+L/8U6SOavoALdVLyiTg==
X-CSE-MsgGUID: vuMzaUW+TvCdrg7EqX8rpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="229860861"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:02:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 02:02:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 02:02:05 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 02:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRRpOfbbWnKrWwFYG9D0qYOVEIdx98aUApplXWCm42C4F9Gkq78/vWN33lwkLHaPbqEJW1es/BUasa/naMJX6kKdNgu8RBFQNGUwFWu+QAdvAvtzAvackgPNQwqqcDvDnU9G6mMmHOQs1GAb9lzOeL5EFxDfc5C4cBrNtLtvRsfivpp1ev1W1iTIP6DZwAL8H5G/Vj/vZ4lU7x9b3+TjtLdrfqdWDx4a5zhyyxpyA2YnloF9iFfnjV3JAyKVt9x1/4ztWPxXvLlVZixIXWoCr7BGgYdHuzIaNIPhLXjdTAKbWYIeur6oEug1hQ5A1DmDCtuRypesi/itNIxWtbV9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he/nndZb+X0VzGUs2nnmmES0s3fvRZL10jYQAQ+VG6I=;
 b=T43AP+2R9iQoWUhnnZcx/3gr2qCbpM9JacNe/dj/GfI/htFncguc30N/bD78Muy4GGoAgyEkskmBFZ3kFFpV0EqxSNZJ/7zhkh181nhq537WJt45JHddSO3SKNBfrsOf5eOqqnzaMr8HyP6gErqeERmJE828KzKZiW+mgc6UuGxFu3ZFmO5eeXgPjiV4Krg6RMygLfUWCLJCXyVxldsIJrb1mUy4PWSJwHNo7fOiX58ZkB6jqwHD4bRnqbygpTnrhFbf5Vl5WR8iJ0PkjFYl06Qbw4qhSmxgfrpOO+oUlVT9WPsThbKTtizQZZFY716YcIXeiCB7+PUn75fX2P222g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 09:01:59 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 09:01:59 +0000
Message-ID: <b0a706e1-2494-40b4-836f-f5d32c6b0fef@intel.com>
Date: Wed, 29 Apr 2026 11:01:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net/intel: Replace manual array size
 calculation with ARRAY_SIZE
To: Dan Carpenter <error27@gmail.com>
CC: Jakub Raczynski <j.raczynski@samsung.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <CGME20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931@eucas1p1.samsung.com>
 <20260428103653.3539239-1-j.raczynski@samsung.com>
 <ef61b770-ebf4-406a-90a0-8a49aba02aee@intel.com>
 <afDL02Z4QV6G0UxF@stanley.mountain>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <afDL02Z4QV6G0UxF@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0245.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 99dae4f0-e241-45ca-36d9-08dea5cdf865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: puf1aZfzvL00BqbfFmXZ2io5ujlXKMjN4xjWA4D1T1RzpXeKsjxBxzv2gn3mik1glvo95cDwYtyTNpNv5WgVEwL3Le08odp11wHhoAhIHmVeFHFMIsj+oGk5+E+onERNYFRM+UEOh0zbqov4OW5OlRQvLFdxIiAk1TLmae8xf5sK3x8bPoIwChs7GF4QQppwqXv912m9K2yDIIZwXYSQ76cVs9D1ygd9rUQp6L3yIXI1aCHR3nmZX4/c6hioTJNXSWLk/9LMImtqezYFVjfFvglgbuxavTA+EB4wrU83JlgkbQdR0iIyu56oD+pBfJSTPPsi/gFKv50mMt8CdLcVhycCveMxvr5iQkzU5ITP1nEWl3K1RwCcQZWfOMoUMJca4KEEPGEqb91JFlPzgoSKhKwOEzIVZ2U16EaoTZonZXJMRaPpiYKftQrzzlXdwHLypIGt4LOEIijOgd68QxDzpersVVI/2oeivIT3giiW3AQjEWWYLyx/BGr61yXk9041TJnRXFWITcOex0p0wGk+3fBSI/t6Wg/Hd2a101xc+F+Epr3IAHWYCdeJ68CF1WyVvWAJzrJ+nNj/2l74LQb1nbpv+PbRSLIfS7ud6ZiLRvUEiyXdEXc7xa2TKpdsbEzdW6GyYoH7+/6BhTQf49EPbruli8IXco+sV5/uB9a172JlLDPZObINwi00PMvUFJQQRaqivocmY6DmdZBWekHEcs0OxSho2+I7s/z34x2Nqws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bytNbGZOMG1tb0hsdDdMZXZJSEN6Z2ZZbzFVY3VMQStCcWsrY0hISTAvMzh5?=
 =?utf-8?B?N1RtdlBDWVNoaDJXTXFhekNhWmxDYUtWMWNMOTNuendOd0RKckhPME5GMlBx?=
 =?utf-8?B?dFNrb1BheFg2UTZuQnNuZHVsbzdMblJQdEg3VVZaekZjaHd1R3JxWVRySnJ5?=
 =?utf-8?B?R3d6Y3hFT0dNbFYzVk1EUEJGVTJXQnFOOTY0eUhFSXB1ZFo3YldEZS9XVXVT?=
 =?utf-8?B?VjdxcmFyK2xwU2t2QS9TZmFGRVJJRDlnb3FoOWxXeHhqQlFyZk1sZ3ozZ3Rl?=
 =?utf-8?B?ZjFyaC9HOFJKdzYxQkl2OW9tdFRTSEpOWllpaFBydjdaK1VtUDNNTzNYM1NE?=
 =?utf-8?B?dStvVzZPbkVNc1ZPcng4OXJDa0ZqSjE1ajBrYXR0ME9nQzgwd25SdnVBQU53?=
 =?utf-8?B?TUtwSk5HOEtjRE80N25GM2F5d0t4MUY4YVl5dVlZRUFQdzhqQlo3Y3d6aDR3?=
 =?utf-8?B?M25yRmh6ci8zNVRqaTdVOTM1RHByVUJQN0RRVUNrSVFjOHJZdHBpNm4zbnBU?=
 =?utf-8?B?TmlES1BzMVQrZU00RWZNdTVSWTFHODExTXhjVjMrL1QzSmpZZEFFeWhua1Q3?=
 =?utf-8?B?MkJmL0QxYnBQQ3dqTG9QR2J5cktiUU1NZDltRXRPVURFc2x5OCsrbXNXREVX?=
 =?utf-8?B?YWlKNi8vYjBUMlhabnlJMElEQzJFUk90NnZ0VndqYmdTVC9sR240dVVTVmp4?=
 =?utf-8?B?ZmRaaU1Pb3hxRGNlSzNRTHNxVmdHbTBkUFR2Z3hMc1RxZFRDUFVkblROU09h?=
 =?utf-8?B?MmE1SFEyQVIyVzRPcjFYcXpHTG5kK2I0T0YwdFljVlBzaHIwY3NWYXQyMmdI?=
 =?utf-8?B?eUwycXIwU3dwUkdEVXFCYmlqTGhjMHBSUGFUR2hRWjJzdFUrNlcvdDVRUGZL?=
 =?utf-8?B?bjNERkJzLytkMDZJQ0xJZGtrSWhFTnVxdWx0Ym9pMTY2a3hBOHBRK2lON291?=
 =?utf-8?B?M0srTDl3R2dEVzk0cXFhdjFPQjFUeHQyRWdSUnhKdzllZzV3R3R1eDdKR0N3?=
 =?utf-8?B?RVJVeFZwVUtCeC84WUZ2T2RmR216RVNpYk1NT2MyaUxSVEJwSFZ4eSs4QW9P?=
 =?utf-8?B?ZmI1QXZ1M1V5YTlOSU5ybVB6SzNpUjB0WkJHY0FxUFdBZW9oY3lqa2d0WjVn?=
 =?utf-8?B?QVVKbHR6VkxWR2V1a1B2K1JGRFNYWjcyMGVOZUZiYS9YRVRRWWkrcmJYTUps?=
 =?utf-8?B?S2hnN2FWeC82S2pPaVpubW9qVjB6ZzFqNjVNZTJ2UFQwWWdVSmlrT1VkMTQ4?=
 =?utf-8?B?N1VyWjUzSHo5c3N0b0FyaExqRHMrSW4rVDd1SXpjWUw1WTBpc1FuUVREaGNN?=
 =?utf-8?B?WDBVcDVUUDg1Q25KUFZkbGlIK2xHMDlHN0VRSDNFQ0hnbnU0bzUxQmxOaGE5?=
 =?utf-8?B?Y0RnOXgyVWcxK2JEWENJcENSRzI3QlNVSXVjWktvVjZFU1Q3WWhqdHJReUVJ?=
 =?utf-8?B?Vi9zQUl5d3pmNFNaMmt5S2hDd21nWWt3LzdMK0xJNlMwSmtmbmtCR2lkbE5Y?=
 =?utf-8?B?Vk5PMFdHaHhqbEQwRktraXhSYW5ZN1ZoeVh3SWlMTmlTWVdIREc1QkhuOGkz?=
 =?utf-8?B?OUM4VG0xMUJXWjZlV2x4SXZRUWhsWDFzaTk1R3hKdGJNTGxIUyt3d2ludCt6?=
 =?utf-8?B?RXBWVzV2Y2VuN2NNRG9lcUROQWZRN01sNnRJNlNjeDRDSHdQTjIwZ09OYytV?=
 =?utf-8?B?d2J2Sy9TRG9rbU9JL2N1ZmJjaVRxYkJ3Y1huQ3N2eVJmS2lEdVNXOUhaUlRr?=
 =?utf-8?B?alByRkhUM3o1T2wxRDhUblFya1pOS1RPalN6OFN2Snlzb0xqUkJnTHN5bDl0?=
 =?utf-8?B?RGV2Y0ZMTFZTcWhTTmplZUVTUzZBcTh4V2dJV2MxZFZXVVBMU1R4djBWdTlQ?=
 =?utf-8?B?UkFoUzRMemNEMExtVDR3Ri9EWkdQTVdEcDlXcmdodDRJcHptejdTdjlDcFM3?=
 =?utf-8?B?OHhvVmJxWUdlVnF5NXMwWWF6QnZHY3lQK2ZpZFRXbDZ2cFN4VFJ0ajNJYUxo?=
 =?utf-8?B?TDRyRDQrSGU2QVZFNG11ZEdxcS9pZ2EzS3BsSTAxSlU1bXpLNWswTE5WNlBT?=
 =?utf-8?B?M0VuYkJucFhFSTA2a0U3L1JZd0R1MmYzRkFzckdobysrbkpXbWo3Y1N0VzA4?=
 =?utf-8?B?by8xVE1HV3dUUnVLSEdra1BINUhUbGh2WkltZ1JrcXNqa1JyUWJmYUMyZWV0?=
 =?utf-8?B?KzlkSjlQajFGTGpHMFJhOEMxZWZCcjNQNEw4eE1WWkR3VCtWS1hIMkRCM25K?=
 =?utf-8?B?MlVUMHk5OEFVK01lNWc1TFF6RXNIZEtNTGxrQ2p6UzkxTW9kcWJpd3p5b0RZ?=
 =?utf-8?B?RThGcWk4MUMyZHcwWUJGYlZwbGp3ekJYN3ZMREZOVCsxM3ZyaWZmSlAzejB0?=
 =?utf-8?Q?rBCTPp7G7/uLbJKA=3D?=
X-Exchange-RoutingPolicyChecked: hrPnE0tAutWRdx3m7AaTORYewZce5pCGUNJHRZl6yejb6HC9p9a9RbeqVpFffn54nrwoplbxqBRZ3wehQvq1uxcEEkYyNtScPfuuHeCOhcniDJerOdjGbqNO2Cy7RmA9Kln3yb2R7QGBSygOi4j6r6tCAuMB5bk6Wvpx2YNVyWRcpmdKulOr77pGHQv7azCYu+kSbrgifrICZellYrluIdjMIA9kJgFKnXvmdN7ICJTqLwKyyfCFWYPHGl6EPNcH8wYstsuAc1ysA8lfjaKVdQ5q00cGGdh/8aifLd8EPF/zLch5Mo6kGrBG+7NaxYcmcq98grcrlNxGzGhwKte/rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dae4f0-e241-45ca-36d9-08dea5cdf865
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:01:58.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FitR0FUtWEvQl5O+ZgTCa6M7hVTRHxIPnO16Wq3qvWWdiCSQZuH/t1iCt8EOWDMj5tUOK2KRio2ocHaO43ioJ0JBnX0WA4fsj4iaKVLqljY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: DBA4E4917A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282310-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/28/26 17:01, Dan Carpenter wrote:
> On Tue, Apr 28, 2026 at 04:06:48PM +0200, Przemek Kitszel wrote:
>> On 4/28/26 12:36, Jakub Raczynski wrote:
>>> There are still places in the code where manual calculation of array size
>>> exist, but it is good to enforce usage of single macro through the whole
>>> code as it makes code bit more readable.
>>> While at it, beautify condition surrounding it by reversing check and remove
>>> unnecessary casting.
>>>
>>> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
>>> Reviewed-by: Dan Carpenter <error27@gmail.com>
>>
>> thank you,
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>
>> (next time use "iwl-next" in the title, no need to repost just for that)
>>
> 
> Which sub directories go through iwl-next?  I was trying to update
> my script

Thank you for all the patches so far you have provided and willingness 
to continue.

F:	Documentation/networking/device_drivers/ethernet/intel/
F:	drivers/net/ethernet/intel/
F:	drivers/net/ethernet/intel/*/
F:	include/linux/avf/virtchnl.h
F:	include/linux/net/intel/*/

Perhaps instead of you managing your script, and everybody else doing
the same, there could be some extension added to MAINTAINERS file to
encode the prefix?

In our case, the prefix itself is a message for net maintainers:
iwl or iwl-next means the patch will go first via our tree, and be sent
later as a PR for net/net-next.

Without the prefix it requires guessing what was the submitter intent.
Most patches that go through IWL receive additional round of testing on
real HW too, thanks to our VAL.
Patches that go straight to net are just merged faster.
As intel ethernet maintainer, I want our code tested more, instead of
merged faster (in most cases).

> 
>>>
>>>    drivers/net/ethernet/intel/i40e/i40e_adminq.h | 2 +-
>>>    drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
> 
> but look at these file names. There is no "iwl" anywhere in
> the names!  :(
> 
> regards,
> dan carpenter
> 


