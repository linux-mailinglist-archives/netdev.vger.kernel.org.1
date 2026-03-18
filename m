Return-Path: <netdev+bounces-269012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAd3OUakummyZwIAu9opvQ
	(envelope-from <netdev+bounces-269012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:10:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B182BBF63
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA608303353F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDAE3D6674;
	Wed, 18 Mar 2026 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gV1ZJ4uC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A683CAE72
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839194; cv=fail; b=Y3kRHdX178IY/jU56yXlZSxkED1F9fqX+ejp3TEokXIpY2eQI+QWe5fhajXo7fXpFUCvPIR+WtG7Z5lnyMWac0gl5d1nfc3UDescpb+xcxt47BdZwfqzoOSVK+zqM7pJSZkNSB2sodrfWOiNFyuf5qPmUhB4c6Dq6J56Z85DHYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839194; c=relaxed/simple;
	bh=086OD4ATFGr/Ki98hSi/pIK9EorbmGclyXPugi12R0U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwDTVJHjI6kBKaKP2z37B65tXE5MoSiZbKak2CAKoHONCc+H9qckxUd+7dIKXYgk4zYGjwYUrka6eqTzU92mr6mxBEKTpr7mLevYuJUx9vw/yu9x1EBQFZcKZlYqV8McoOqbq9DjyyJOboYFa/h5wnQR+kEGlLveHfkNEPeUcdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gV1ZJ4uC; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773839194; x=1805375194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=086OD4ATFGr/Ki98hSi/pIK9EorbmGclyXPugi12R0U=;
  b=gV1ZJ4uCBAH7e88xUKAW+FmtWjbxMd+D0Lw0DdQgYhwwEoiuecRTRrYs
   NMJHG8V5aVz5QaMcXPye0aHiKFhiXMJlpPD+uYixnL+CUpVhQ58whF3EN
   nadKriGIxSpSl+ywy/uDO+PG+gfnKZRmnBW4QUssiBsNvxAQMaGLbwPOd
   ClXyG3Q0NhDQkZN+TMrfhPc/rNjAZspJE1Cr+1fYuz8dIRjv8x5Fnf8HZ
   jVrqXkS4B6YGiT1MFH+I1TqhxNBApWgA9e1ipXGCo35bxasBRsNVF5261
   m2TwnguYvYGZeXM34Ola1CcSpBcU3D8faDrmSycg278JglIjcpPAZttxV
   g==;
X-CSE-ConnectionGUID: LMpQtx/4SfapesQgZUg2ZA==
X-CSE-MsgGUID: +oyDrxkORsKtTkoypkKqMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="62454799"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="62454799"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:06:32 -0700
X-CSE-ConnectionGUID: 02iAsLwdSbCLMLdtDHjz5g==
X-CSE-MsgGUID: OMHu4ZkCQv2f2hP5EJJoXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="218197020"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:06:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:06:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 06:06:29 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:06:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4BMAwvTurSkphr6IBPDgcjea+bk4cEFFAELlQflbXAl30uK+kZn9Tw6vnFZ0eICIO6NN2KaqjhPXKa9JlNh56fPkLIwB2fTLNH9rxKj4wQLLe9GPwZJHLYWsFqkTmS5HGdOBGJktlVzwzaVdHbA3msdgVoAxESMSUgyqx4C5ZAShNfyCPLqLuOoK92YiCfMEeHWdVZMoATy4JUrCirgPn1ppExXQOyBhLhJy4TtN9jb7wZcKYUF7ER4TvxutcInPmyQHb8+G3msL7NGSBktUDamUNZj0cz73CVKN6EbReYHiuWfz4q4JcViJkKvAr6fgEI/J5ufrI0ud+vZUpu+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYXJ/vnU+0iBS8v4C5KHG7iGzgWkv+UwPHa6SwKNRy0=;
 b=W6rpS1TzbNld9i59plbPbPDIOduacF0vPqqU78BVZMpAVuM06TBvd169I22uJeBDhsKxZogVCI3P+pAPcA9Y0S3fKZvVrZ9fYlj5CDMvF7ClZ9TuID2iRIBUBKCXzaYjYOhhLXG0wQ24iyjcwqxEwtzNUYhYOM4syoonGb/y5TeuZvoCOERivTaGWJgUEww8P3FzkLkcMDrj66qfsliBmqya8Qd+T3Zb/lvl0Jnen1pSBBaN78I9QxkJFN9Xl9lXh7by2Wu/+dp7EYLO1ltb7ga2sV1xI2sDlt2RrvvRXteauUEwVd2B8me1lm1fGje/rG/iC4IbKE494KgyOZIDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20)
 by DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 13:06:23 +0000
Received: from CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee]) by CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 13:06:23 +0000
Message-ID: <3ae6f24e-0c72-4fcf-9bc9-3591fd9340d5@intel.com>
Date: Wed, 18 Mar 2026 06:06:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 0/3] idpf: virtchnl locking and async fixes
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <aleksandr.loktionov@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <clrkwllms@kernel.org>, <rostedt@goodmis.org>,
	<linux-rt-devel@lists.linux.dev>, <sgzhang@google.com>, <boolli@google.com>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
 <20260317090054.DuPZ6O0O@linutronix.de>
 <7247024b-fc8d-4a75-ba15-a10399db03bc@intel.com>
 <20260317143850.BLrnAox8@linutronix.de>
 <f77ad6b1-1fff-4f3c-a411-5115bb66e31d@intel.com>
 <20260318072436.4JmVdDfK@linutronix.de>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20260318072436.4JmVdDfK@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:303:6a::31) To CH0PR11MB8168.namprd11.prod.outlook.com
 (2603:10b6:610:186::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8168:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf0a24c-0c23-4a04-a031-08de84ef2792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: t1Xz3WqQMGoJFHfb4FeJFjoNfmhfsFeafrGzTcZ+NAkF5Jrw/2O8e74kPosupGgXLR10bf3LRptqXRf7vYgTZ6qV0wYJw021YQoReddc+LGcJVSHVgSDu6qFsIeccfAAXUa32v24wkXgyo8anCOuDuzTMoZMg35HTEcKgycJg8j7cI+V5LlUIwj3sA/d2H1ELCMYm7i/m6/GyWwu8F8ihXm/o/sg4MuQ9rQHfadlHOP4/htg8F+1q6dBnen2yCHoFBzQ/RHvMCT5WWBmeA0RN0xYQfx/DJaGC3ap0X2L+iKz2YefYsSZDr78qk9c9kPdgwATtIJIB/4x9ca6+A+IwhgAOGEutsqd8C6o0/lllwO3R5PZpUqIL8ht8a05AITsbUikxLEEhL/8mJZA4AJbQ+diLEV7uEPSGDeAccE/FHf/Di48JwD/PqO9DN40aA5/UTe3AT0j2tUu8595cZdsT5gXJpnYhhnD65sNWUicXp1HOBAYSQ1dkUX5bX9H16FCKCZr1TexmNdrfC7slZx9v9C6TbKcgUDucyS7J7c/9UsWjPFdGXL/sJu0jwv4HtMOfNiTRbIk3i+9bHmi0OectCv5R9ZvH97/0BSnXPrOtw5yxJaQKGb05qhTUZ8tkQT2oWTIvbvb+zgvL5XOi5ZRZNiktzD9GCwTKGNFjnnQ6rttEgkQmkMeWMQzQJieJXQWjeNXSE4kGgcIQZEAsmEHRy58OWzFA5pw9r9GaPFTs8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8168.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzlsL2dWeFZQSjNZcU9VYlpmRDdCbFBUM0Q3ZEhGaUVGQmI0NWJyNGo4TGYr?=
 =?utf-8?B?b01OR3IyYzlnb0IzSE95UEphTGJsSGlVRmFndytnUFQwalJXd2VPckVlQURj?=
 =?utf-8?B?MCsrSWNLcnNOSk9EeWtEL1pNdU5vTTJqc1BMRmdPZlhLcWdUT2Q4eEh0Zkw2?=
 =?utf-8?B?UGhOb0tNbjk1RTNlSXVLWGcxOUU2aWhCeEhNeml1VXIrQUViRjVwU0lsenk5?=
 =?utf-8?B?UzlzOExuM1NqbDNDa3FZYXlRNjJGZHYzZUo0VGlZc2t1cjJUb3VtVkpYMXF6?=
 =?utf-8?B?cGt2NHFEOGh3M3o0bmJoVWRGQVN0VitBWS9HeHBmZlRZUHN5ZCtMYk9hZE9V?=
 =?utf-8?B?Z20zeFF3MjN0ZW8ycHYxS0tMZFdJUkJVZ25hL0MwWU5LWHlyWVpMK0N4ZjRP?=
 =?utf-8?B?QVMxcXFMRnpSM0JSR2xHb2FoNDNzWmpVb29qVzI1K01QMXVKR2VRRDUvazlT?=
 =?utf-8?B?VEhoY3FmNVpSUEZ1Nzk5YUFrUWxrVk42aE1ISHRaQi9LeDNxNUgyS3JYVVZL?=
 =?utf-8?B?YVkrVWhDZm1MNFYvU3N4KzBDOUN6cE56OFgzSnUrUmF2b3NCNzYxWFpzNkpH?=
 =?utf-8?B?aWllNzArY2Vvdk15SHF1dUhXbEFRMGg2Y1RkSGlZOG9VU0JTeDUxNEhZTlBJ?=
 =?utf-8?B?cUxTZDNDL0Q5ZGFrWUhPWGpuMDFUMXpJV0dZL3V5bnpLWUVDcUNSRDZnOFhC?=
 =?utf-8?B?ZU5mZEE1Z1JCdEhTeW9EK2ZHVDdvT254ZldQOGozaU53LzA4MGxZczlEZHc0?=
 =?utf-8?B?QXJWQndzVFBweGU5OGl1bE5vMGN3KzNUcXZSVFVDRlhSZGF0REd1YzlOWEJF?=
 =?utf-8?B?YUhtS1NZSWl2Wld1czFRbHFQR2lzT2cySzNTSHdueUJzTTdzbnJSZzRweUNO?=
 =?utf-8?B?bVljcklJWjRKNTNGL3ZyWVlGNnViZTBvUmNJMEJrUnJLckMyamxiWHR0MUFY?=
 =?utf-8?B?cE5FTFZUQXhhRk1yVjliZjdhYjB4TjVaNGxlc1ZOMGVLYnczanNSelNWcDNn?=
 =?utf-8?B?RTFwTmIya0VJQUo3OU9Mb2hFd0sxVGFTQ1AzZGZ4aUNLOVM3RlM1M2V1TUFQ?=
 =?utf-8?B?MElxc0t2MTlTV1BZMlZEYlcvU204bEtITmNWbzBPb0tBSGt3YTF2OXoveFgx?=
 =?utf-8?B?V011QVA1RVRreWJ1Nzhuam04U0ZJV0VSTnBMV3VFaVdScmRkNkJGVHkzR3JZ?=
 =?utf-8?B?S2poNUdoTVFkbjB3V1NpOC9oZ0ZuRC9CUDU5MDZGVzY2YlRHeHVVVDljRDVr?=
 =?utf-8?B?WDFuNUJJOXpPcjhJbkUwVjFQQkJ3alVMWkVXQlpTYkgxNFcyM0VCZlVEaHEx?=
 =?utf-8?B?bEErYkRubUo0MUlpVGtLQWM1WkNGOU9EcTI2a2VRVXVpK2VqeW8rS245NUN3?=
 =?utf-8?B?bE43V3g2Ri9sWlFITjBMK2lTSkNXQVRza09zTXRHR1F6ZzVONU1FWmw2QU5w?=
 =?utf-8?B?NDhvbFVoTEhwcnRtNUNNOGVqbEJkT1NETWx2RnZlWHFmN2pnMUMvcE85QUJ5?=
 =?utf-8?B?T3Z2MVNjTWxpVFdJQmVBcmV4UTJtRWdoOWpwV2lwSlZRRUFqUjBZRXpWVzZK?=
 =?utf-8?B?a2l2WG9WRjZONHZxZ29OWlN2dFJKUTFVbklORGc2eXd5Vzh3dStsOEUvWlBR?=
 =?utf-8?B?WFFpV2tuQ2hHWElIVEhsSVFDQVd5SEtXSG5JOVVja0REV2RpR1cyN0g0U04x?=
 =?utf-8?B?T2Y4ZklKQy9sKzd2dk5SREovam5YOHFYNFUzTkIzUnZvMTV6dkJ4L1g0TUFB?=
 =?utf-8?B?WFo1NkRtQ2hPWlpCRXg1QnZWRmV2NzR4QzVZemNNd2paZlBWR1M5VFUyK1Yr?=
 =?utf-8?B?WlBEbU11UHdFTE9JSFNycjRRbzBZb1Joc2JRaFF6ZklDTnQ5WFNtdjIwUWtX?=
 =?utf-8?B?clc3amJKUlEvaEwvMjhZUnhUcVg1YzRNUXJ0Sk8vY1dyNFlJVVFNQkM1elhZ?=
 =?utf-8?B?UVNGRXlhVlY0SGNvZVJadWsxam43NU5ycjB5elJlTU5BMjkwUnhoN1dLTjJq?=
 =?utf-8?B?Q0hwV3lXYzhJVGJXbGVwSmd5cGp6MFJtMWNjU1lqbnVhZGUzMmZrK08vUG9a?=
 =?utf-8?B?VnAzc2RxbmtiWkRjaFFITTY5cVZUZFFLZEJ3TjlHQUJBNjVsQTRWZlloMnVU?=
 =?utf-8?B?TFJUN2JtZmhqWnF4WStDN1lOeVpzYWQ4aXQ0djQ2SGlDNEVwTHMxdmp4by96?=
 =?utf-8?B?MGlUZTAyUkhkeVlRZzRpcUhHcjgvZnpwM1JCeEFZeE4xSmJQK1ppZ0ZucXB6?=
 =?utf-8?B?L0hQUGgzU2VKa1creXR1bUh0QitSYXMzQzNtK1JBR3YxNC9lK21kMlIwaVY4?=
 =?utf-8?B?bzd3eXZWb2RzLzdSZ3J4d2JsV3RucVUvRjNYd1d2Vmw2UEVndlBkdz09?=
X-Exchange-RoutingPolicyChecked: tp0iAOlgnDhkYuHRc366Dd8DjKWv8qMPeZmhMBubOyIujfnZ5T4Tz8E3mIXTa6o6N5L4GpcKocrgoQW3G9M8SLHUeCq/Z3ed1mXT0HvNQBqNlsv/neFSyR1qqCiKBSaIEtrhvNsh0R2aUFDQlaSG+RelaZuyM2KBihjkvkbakQO5tEwS5Cbi4qGL5+vI7Y1dh3vgUiiV9Q3nurBdIufSEanOsS/V/daZB2QRDqcNBAREJpoB1zMm+WCOZUP9C1/2ZYxx/PixW/trQSpepKKDriwVt2EMDh96Dh7lYV47GNh4sVDPBqgmHMPKBTWRN/bpYQaWuktw/eKNwmUM5I5+YA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf0a24c-0c23-4a04-a031-08de84ef2792
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8168.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:06:23.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGU0cHwvEUSCKBd0S5WC9BwkXg9cjW3UdDLcl9cdYE4XaI8Rf8zLbL8OkEWLBSWrAKyKudxArIEw3Yky7jMHqreEUB4srt7NW32ZUWmTBzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-269012-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 56B182BBF63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/18/2026 12:24 AM, Sebastian Andrzej Siewior wrote:
> On 2026-03-17 12:30:39 [-0700], Tantilov, Emil S wrote:
>>> What would break if you make that lock a spinlock_t?
>>
>> Right. Scope and risk - these fixes are specifically for the async
>> handler and I did not want to touch the global locking that will
>> impact the entire VC handling. We do have series in flight for -next
>> that refactor that code, while moving it to libie:
>> https://lore.kernel.org/netdev/20251117134912.18566-10-larysa.zaremba@intel.com/
> 
> Now I understood. You fiddle with the completion's lock. That is
> something that should not have been done.
> 
>> ... that also remove the raw spinlock. With that being said, I can look
>> into converting the lock to spinlock_t if that is the preferred approach.
> 
> The preferred approach is that, if you pick raw_spinlock_t for locking,
> you are aware of all the consequences and you have a solid reason for
> it. The comment in the file says
> | For now, this API is only used from within a workqueue context;
> | - * raw_spin_lock() is enough.
> 
> that is not it.

Understood. I will convert it in v2.

Thanks for the feedback!
Emil

