Return-Path: <netdev+bounces-267526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC8VKEA4tGnTiwAAu9opvQ
	(envelope-from <netdev+bounces-267526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25714286CF4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3011C3056B5A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718AE35BDC9;
	Fri, 13 Mar 2026 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc6Lpv73"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8FF2773E5;
	Fri, 13 Mar 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418157; cv=fail; b=DqpOIx8Vxv3gzkoMK2TVuGXWT9dQZRMlLazXjrOi+SNLdzhR9T3mDW352mbX533/VZDLCB29Bo9UN2YrKKEO8IyeSKQx4Qb8zEKQlOYNVzmN3k3tHkgSwEW0xY5RUy2rrfh9tUjzgfKm1Z/YGYJ+sMCGhraCdNzV2WUohEDY1BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418157; c=relaxed/simple;
	bh=NMQO4h11IMLXhx0gC9tYUl8CHmipRAN+h3wtMhdeUmI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GWLjxvJ+eI/oFgpHAq3XafFhOXoi/4t5w3Wr8/+RWE2BR67ZuraShA1kkLQ5xIUkCQODpNO/Ucl1dpdwAos3sJqo90RtwSOxaEr1PiGNdx7L7T2rsnKztPbu89bGl9YlsZM0Laj1BnaSpi/F5NV4VO7UXhIdoNDTx6qHY6S4pak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc6Lpv73; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773418156; x=1804954156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NMQO4h11IMLXhx0gC9tYUl8CHmipRAN+h3wtMhdeUmI=;
  b=Bc6Lpv7308GP6XWMt4Ei3zEm4Xhgn9CHYt+OIBR60UWeZ1Jd/472On4d
   CalDHEatMcgpPDbrkwKO3pUi59CFJDQ8MmC6sBRkP7YPzxDqVTACRtKvu
   iy1TVOI5h0dRtKeONQC2+c+ZJFf0YLUKOTg4scRw/cBR4JXQkIfitDThd
   OxSgIajzJuSH4kwtzRxJLWu3ds1ds2YyTcoOghJZ83aSVMSywxlgHtBY+
   X33hdkj8wUmaPHCiEuP+GNWiheUCzm5g3AVavQ3lutYiMf9GOJNdMVUlr
   bQu1N5NjBub+RISI5PuTwMiN2/7/WIo3F0GNgGAgG+LUI4KP8J8gOJIHg
   w==;
X-CSE-ConnectionGUID: BATTw0FdTkmLghx6dhmzLg==
X-CSE-MsgGUID: l3IHoXvQSL+SKt5UNl+0tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85614810"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85614810"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 09:09:15 -0700
X-CSE-ConnectionGUID: qI9j8bXDQUSkMretGAxH4Q==
X-CSE-MsgGUID: 5KSdVS5rS3qoxpemunvrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="218542193"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 09:09:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 09:09:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 09:09:13 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 09:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWn55Du4kTtdgysIT+omK30Bec6E0oXT36xQ9xpqs9sfgaKOXX7Ua/syajRVy2G7WiXE5MeWihDA6wstVcvJPwJrG01rlozhGVUQX4i3ixM63ZHPc/KSP+LpTj5feiSz8ObXNsW0SDV6cFCDHN+fyQGlm37ejCOJx64REhRvp5DZIZ06HsbXdQN6utOia3NSQ0BPsEme0P/yamNIND/j2doNPZaoFH8xryxJX84MwJXb/1C3iCfz/6fwlFym1PaKMTVjTTZpGokVsJpmXhTHhRzJjNoF8LJt4vSlxe0/0rBS7835fWFm07cUWt3KCQwnN11cNWQiqLDxQUx8oxDPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3Fn6mfJtKwa52D3+mfsPAgA9P2ifbTGHUzbTe3d/yk=;
 b=Xk9IdR0Hla117bcV1MXT22C3h527qPHnbpPTsHMKwpOFZRoSRW9IDBGVrQYBC2vd6IrVWB8pP0kI1GT5yYUp6HOlMhIMDKSpMXik6hYAdnnIAkCthBzReJuOTLptfJuGFZ2IJC1mnYF9xONVhmMlEo4TJkp9DjUSJYeLMwn887IjzOLJPMlg9h7CUSNdA4Y6mW53ZRvILOjwN4A9Ly5vOSzYlnjaD/PzYAATd3QIDHYtAciw2H1KgYEawErEOs1hVJt9tESjQCZLtVzFfpfEfojeLmtaUZj/JOUYa4qUd8X3HkCuQMHBcez6EV1mCNWNYOpcs0+s+vMNpFbBkZ0gYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB8000.namprd11.prod.outlook.com (2603:10b6:8:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 16:09:05 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 16:09:04 +0000
Message-ID: <0ca7f92b-ec4e-469c-ad2b-648d278bcfe9@intel.com>
Date: Fri, 13 Mar 2026 17:08:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] idpf: Replace use of system_unbound_wq with system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Tejun Heo <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, "Frederic
 Weisbecker" <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260313150917.271086-1-marco.crivellari@suse.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260313150917.271086-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0071.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 9463f875-b42b-44ac-ab5f-08de811ad8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: EUxubB73hEwAnl9F9jSXjjF7sJUUf8cqeV6OKyF0d2vHCkzEoLRpC5ImudbELrkVl3aACnVz1xl/40pErKjW38PSOw7MNiQUEs5A2p5Prglc+lzrK/2BgomXONOsn3Juzh5nBK9pSjEUKwHtT8k+JG8sogEoXFIbZbVMUpauzfHPBHwaWgMVT4C/CF3wf9rFN58P1nVVygs1i9uF2qLfOnrgtRkNQdqzCIby4/mR9C9/+RxP4A04igwM7n+D6Cvx6GGBFP6fJMJelUuqodeXe/nDJX41tYDjQ7ukruZXyk1TSsNNRYcf9+y++hC2DwnfrW8aBkPcFeDNgvc0jpkfWxFjWkJTUC6fbrt3FBnqR8XXrbz9CHLCiBxzgtOnWs6O/44oGzpJINm+twkPmzCRJkklaQqID/c1JxASNDS2IW4SxpX7LRoAolRNuvSyqBJwbAPOpqM8dmOxZOyFmTner5cppb5jzILejEYbHiKPatGg4hktFkNzfJnnTtucq6duxfzRGuSxjN1IkmEn9UAs6eaJ228drq9tKAcvhL483OopYg4BGmDMlIo6pWe3lgOz2UCLUAFuW0s6lwWFIPLo3oST8+uQGlwEa+USfo4/FrB1dVU15pkC+UEhKw06/qVBmk5sn1lXtcHU1xYOY2LbTw3fbUT4Xk9EyfrB8pBv5zLpVg4ZCxc6VBFXlBXWIgcvvyzngedLi37eXG0EWz7kqXoztKyGLqDedkCRSHllx5kb0nqrpuGKTq8SxXdLOdK8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpmMmxpazhrVExpa2cydG5ZdWRMRDkyYUlhWDBxWUxzcXBRbWtpcTE5akdu?=
 =?utf-8?B?UGdZQlRYMGx0ZWxPTlJFSVNUcG1kMmxWQ1UrbzVWTWZqY0NFTlVvK2NuN3Ru?=
 =?utf-8?B?b3pUQzR5RUdUeE5YdURKbml0KzI1ZDhlM1VJMHVYZi9DSmJCWFU1K0gzU2Vm?=
 =?utf-8?B?bVpneGFzempicVhGQXlOdThaU3hzQW5WeWo5UllyTlV4MEE5SU11UjRRT3B6?=
 =?utf-8?B?ZFBLcnBsNHZ4NkRlMC9uMUNmd1lZcHdxays5ZkhKTTBGaDF2U0xxYmorL0Ft?=
 =?utf-8?B?dkx2VDgyYlVQWWRBVFNXZ3I2MjZ1VHNocnU2VW1MRnorTUZPaU04STRFcGtD?=
 =?utf-8?B?anpWcERpc05vQ3N4eTNINmdOajhqeldVS2tBVVZYN0dvcGswYUpoVmR5cUtk?=
 =?utf-8?B?eFByYStMTzNNN2E1dUMrVWJuRTVtbDdSZGcxZi9CMnQ0aGhZdk1abzNUWXVT?=
 =?utf-8?B?bTBORGdXay9zRi9VdTBxblBJbWY5SWRwY3hEQTc0aVNjQnBPMnIwSUNkN2Qv?=
 =?utf-8?B?K2RDZ3V2Vi9FN3Y0V1lBZEFoZlNydmk4bGM2cG0ydER4TzFvLzBYdE92RjVX?=
 =?utf-8?B?MmVZZmFkb3hnbXR0ckMzbTVoaHlUa2JRei8reGt6bHpNTFMyTFk1QXRoNnVE?=
 =?utf-8?B?NnNHVHFEbTFGNVdJSFg1RUtaalRGTWNVTXl3OSsvZGM3NWYyMjB1M0ttYkdQ?=
 =?utf-8?B?eWR0WVQ2eWpneUk1UXBBbTRXdnpIMWN0clkvUWFmeTg5ajJyYkxMeU1Xd2Jn?=
 =?utf-8?B?T1Bab0pYcHNFb1lJY3VuWXVvdHY3Z2lnNFgwSEw2dFQ0dDk3ZVF0MXI2YjVP?=
 =?utf-8?B?SnYxZ1UwaGJ3SlpoMlpjNUFBbHc4RVRLbndRUUFvZWR6TWdqNGg3bU9HNGly?=
 =?utf-8?B?U2JyaHhhUnFta0paRWF0QWxXeG9lSTBFSVZ3aGZ6eE1jN2poYWNzMXc1WEx0?=
 =?utf-8?B?dm5KVnRaSlE4SFFwdGsyTmJlS0FWc1RGOVlRZ0dVVkNHYUR0bXpwcDc4Rm01?=
 =?utf-8?B?RWFYWWJiUjZLcE5WbUpTdjRqRjNOcUpsTXdSNHVCblJOaklrWExOdi9kOXJG?=
 =?utf-8?B?a3NqbjZUM1cxUUE1cGZKTnZ5N1NPZmVPS3VYTXRtNFUzeE9hWm5EZi8zWXJR?=
 =?utf-8?B?aG1veElMWjB2TGRRNVdoQkQxQUJMUlhRajd3cFlPTVJxZXo3d2tKOG5RVlh0?=
 =?utf-8?B?T2FVZ1lqTTZ1UGRnaXpJaXJ5SlJNMWpNY2Q2dzZwdEM3bUZLNENGRCtXZHph?=
 =?utf-8?B?NEc3bEV1MmtIZnNlWXdESXd1eFZFSUdZR2xFL0xKckFsb28rTnMvcXJmZ0Nh?=
 =?utf-8?B?VUpuM2RXOVZmaDAwNTd2M2MvT0hzZGdpYW5iWTBKd3BjemQzYmIrbW9NdUQw?=
 =?utf-8?B?RjVHaGQ3bWRDcWRGWmFTUWtxKzVWaURnK3NCSFBzSjNXZTBhMjk1R0pkcVVx?=
 =?utf-8?B?WHIxbkZTa0grZklHOWJJdnhlZkt4ZXd5c0lkYXFlSTE1L1hHNXBraFJqYTdt?=
 =?utf-8?B?ZkdxcVM0ZFBITmo0N1RTNzZERzNoMXZYbUpqNnlWa3BKN0FCc0dNQ0lJMTBT?=
 =?utf-8?B?blpWbHU3a1JnOXFPTWdFS25yUU44TUpJb2F2SDh0TjRqN1VKSEx5UFpFNGxl?=
 =?utf-8?B?b1J2dnBtUmV1SE9aU3lkUlA4N2FINEsrWFQ3VHNySHlleHFFWnozODRsaytl?=
 =?utf-8?B?M3JscFBLdjBHanJqZU8xNkNReVFhN3RNeFgyeVBkcTRtLzFjNGVwcGZTZjNy?=
 =?utf-8?B?aUY2WjlydVd5R3BPbkRsQ1dNZ2pJVWlFVzArcVFtUEhXZ1hHcXE1MkhXMktN?=
 =?utf-8?B?UVVMMUF1aG9EQ1dnK3Y5SGdsVnBBUlIvWDRJNVhMOWJ4eFJtc0huem9CblZQ?=
 =?utf-8?B?QUY4N1A2Q0ZPRW5yNzN6MjNqOGZLemVuRkJ5ZHdoWkVaa3cvV0l6WGNuUWc3?=
 =?utf-8?B?RUM3clQ4SFhSSU45eE1tMFFEczVuVnpWb1RzbTNQZVJLRUlvZnI1YXozN0t4?=
 =?utf-8?B?K2t0RUZyTkpIS3I5Q1hvclFwYjVGQXozbG5nLzVLWEl4UEtQR2xCdXNIa2RD?=
 =?utf-8?B?MFRyVElGWlc5YVcvRlQvNkx2UklVY2JPM2p5QXdJK0VkRUtzOHZTdGt0NDlX?=
 =?utf-8?B?Sk5QYlpYeXdiOGxKM0FGOWRlUWtlY2NqUFhhaVlKMms0a3BpRzY2VUtmYmJw?=
 =?utf-8?B?UnVRRGdHMmJ6Z3lWY295WGhRUEswMjRNU29jNitQWUJ5ejhGMmdqVnRXR1pm?=
 =?utf-8?B?c0kxT09URkhGTlk1eUhjSFpITEJ5bE4veE9rdCtHZEtkME1BaUt2QlRuOFFK?=
 =?utf-8?B?UDRqODBCRFdnbEY2WFY5Nm9WOEtQNjBGUk1UWklvR3ludVoxSFZJemJ6aVlM?=
 =?utf-8?Q?F9O0juFptyc5LwXU=3D?=
X-Exchange-RoutingPolicyChecked: tG1ALlWnm8fyuHewYl/zWaIq7BTpFoAD7qB9/RA3CfYP79KfS3Hx6bjPkTrrNMXt1JhRfG9znIkjWNy0Xg0NM/7X0/B/v4JDJBuNIKXR74Z0g6vB2A264XA9Ra7ObVSASreuzUnNf3YlIvaqtxJl4qolxxB1sDROUiKB79eXX2n1fAQYl4UBhDOOIEg6kk+JhwXtMiJ7RJwyshs3fXZpXGqmcpZR9M+fWTLF5S74mObux/9Rn2m3VGq00zxnmHpaykEQz5V66DS6KAXjz7e85YAwwOhpLmXFZiVPDbFmy9DtmrIx90yV/k/Eh7EFwBPzTwLECUIlRBOGSztlQC+nNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9463f875-b42b-44ac-ab5f-08de811ad8e9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:09:04.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYLIffazyqq5ZU2LbN9GVb3NDO06NKGKnwsIdivxj2MRIZyP17u4gPapwvSPNe+Lfk12Ae3JluOcB4GapTir/JyElYYGQ+IvmcEnCRZzZNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8000
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267526-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linutronix.de,suse.com,intel.com,lunn.ch,davemloft.net,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 25714286CF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 16:09, Marco Crivellari wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>     commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>     commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.

this wording kinda scared me, but after reading linked commits, there is
nothing to worry about, as there are no functional changes in this patch

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> Before that to happen, workqueue users must be converted to the better named
> new workqueues with no intended behaviour changes:
> 
>     system_wq -> system_percpu_wq
>     system_unbound_wq -> system_dfl_wq
> 
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.
> 
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 252259993022..6b84e728d29d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -2022,7 +2022,7 @@ static void idpf_tx_read_tstamp(struct idpf_tx_queue *txq, struct sk_buff *skb)
>   		/* Fetch timestamp from completion descriptor through
>   		 * virtchnl msg to report to stack.
>   		 */
> -		queue_work(system_unbound_wq, txq->tstamp_task);
> +		queue_work(system_dfl_wq, txq->tstamp_task);
>   		break;
>   	}
>   


