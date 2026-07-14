Return-Path: <netdev+bounces-307619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jMGuDbrKVmryBAEAu9opvQ
	(envelope-from <netdev+bounces-307619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:48:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D1475981C
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:48:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ANFnmMKI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307619-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307619-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66BCF3045A9D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF27437134;
	Tue, 14 Jul 2026 23:47:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F4433E71;
	Tue, 14 Jul 2026 23:47:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072870; cv=fail; b=ZixWqDT9FB5RhF82HIBVN6+SYEIunGF7L3Aj7SiwQIf2nBs1ahAyXsihGLp7YOL/AjwOzhNKYxUFt6qV3Ks2vUrR9SAWRcO1/kgt64ovK40IfoozvfLcvZNp98V/eUpubQgH24E22SqpqKtfxMiSFAc3kedJN7VO6PefwOSJ/84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072870; c=relaxed/simple;
	bh=Y2aeSuF6KTVqnA0laZjS+UgVQuIgHx0Rrp/ThVZ4Dxc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WhnYxfRiG90RqdzgKWGA9DazlcLoGDFOLM5WrXrc8sFW/Glgg9BDgTuxO/X3fZHguqYOYOSLV2tmKGtS9nT4NNQfEBx3esHb2brrPy7NYfk2hUu4m1uHlwsCDpcyg+3gSPGWr8zaLf62m3br1Y9iBxWRTuqErT5FSgCy3kInr5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANFnmMKI; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784072869; x=1815608869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y2aeSuF6KTVqnA0laZjS+UgVQuIgHx0Rrp/ThVZ4Dxc=;
  b=ANFnmMKIlU3REtDRiRz940ZjTu1nV7SPz9wc1UbPJwykwcwAvXW7FQ3G
   t5Pwb5lyQP9EbCfHXzEgQ65JGmpxyd5cGE/o0xwXRV+y6/4muedUrqIk4
   eT6jc6DZnjk80uyy0IZlYrZU3T+CWrYyy+kwQml3zUXSLN1ET2NXLEkeO
   hZ7AuzRbz4iA0c/2yvdv0a+8Get9KAjTZXwHpg3KTf3JQHS4d4N+xgvbi
   265CQvOdUD7XYTRQOlFyChW/lRjAlYSvaRe/S0dbmgODYkN6s7lzeRL2L
   r9M22vk0E3+76kB+n9eALZfJGwR02MHWzozeQbeYWnoRghIbNAW49z9Hr
   A==;
X-CSE-ConnectionGUID: qfAFtujuRM+Ls6XmFtxZWQ==
X-CSE-MsgGUID: 5+miGMEHSpyf+DOl+1DI9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95304583"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95304583"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 16:47:48 -0700
X-CSE-ConnectionGUID: N+kp2gBQT2OjBp2JpE9WHA==
X-CSE-MsgGUID: V5gXjt1nRIitZGivxxrp9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="259835264"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 16:47:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 16:47:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 16:47:46 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 16:47:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRXImdPLHde0vSq0VxeWcsJiSq9Cok2ohhGeP6csOJYtAkDoraOB3D3Ye/5zmprmkvO5+5uLKzXRHsZhM/KY5AIEv0sXJrq1YL+QHn9WcvZAIr20hgX534sYCrGDDgDZWrhmgZbdPfu935zGhdk5kjyzH6o0AEbva6xxm4jfslDNDNr6/YwV6QgCf2L8+QmLQwS/cSl7ILx22g7epXE7EIJr3iyansXpI1EBXeGoHSx9zfHSX+L5QpESjyAix+sY+eNsocILu7E7A0yQQiutqh5DeFj1+25/VyRTQ/cSOO7qaCNDRL9b/Mq7vpfGR2XtonpWCwgg0ktbEAvspQEAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7xOawGjQ0VFU8+2ds7H0TZGqXq8xHfRBZLhEZQJpsM=;
 b=Isfwba7XGiAmMnCHlexOFiWNVNVjntKXCtvHWaAjeztwa5DcWnGEH2uxQt9pOOCCLhrX8yTwYcn9OKJbpoaSD1atbGP4nxA7qW6ktUlNjdB7tDJIsXpmrLmB0sOMJ2pTBXtxpPX6IvEUA8QlJEM/yj82M1tEaE7Elv0lUnSGgicYD9hc8SQgprIoYLdlJUjAOxQaN8hfir71iL7NZmuSgZ4KMPnkBKfvACRXntLvTi3DtYZp3nhySJytx6UQKrrzxRn6s9Mx/wY5IuwcGI8e+BVmljHcJL9ZPgr1my25OaJprXeM0ya7GnlM6AJJcqF7Tnw/ht4wZRLz0KQ8Sovh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by DM3PPFE50071912.namprd11.prod.outlook.com (2603:10b6:f:fc00::f57) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 23:47:42 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%7]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 23:47:42 +0000
Message-ID: <bc89cccb-3f22-42c9-9f96-382586d12fcf@intel.com>
Date: Tue, 14 Jul 2026 16:47:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl] ice: acquire NVM lock around each flash read
To: Robert Malz <robert.malz@canonical.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260703103245.374800-1-robert.malz@canonical.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260703103245.374800-1-robert.malz@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|DM3PPFE50071912:EE_
X-MS-Office365-Filtering-Correlation-Id: 987d5a91-09d0-47b2-96e1-08dee2024bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|921020|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0/9RXMaDttgsD87+tk85Fu8zrgOqC95/XfE4I9XFhgkm/vJkH65wI1G+oYMzgLyTZ2b93LBt/02x6TPzI7XsQjeBOSaLmliSC3JbbpsQydo7nsgS0fTWiiJD8FIMppxXJGUJlaAwkxvbDFx8Oo3gOMVqGtS1jsxy+EwbE8ZUQ3lrFBuruNJJFxTi25D8hBc6ZFzLhBiD4/dQuUOQ6L17bv/TquDmnl7tzwR1XVit4sWLpeCIo2IWknrASvm5JZJKaqcn9YlxLWfrKOMkhexSy9/Ou1H949dpmG251aJIOZKZwFUuhN+pseWh90HlPPH70RqQhgieA7nN/Oyn+pQAWu5hFWbcP/bAM8iNuQhNFGEZRNzx3pT28mZUumKbdKvpV67ywbx1Q588ctK0U1u7Y7TZXI+TrO+r+nuKecWsKtSAPRE40kRFtgDQCIcUmzEU2bokj0+XvBVrvtKdCg2cOfzm0Dyq7xCMGSrR+w2pIEjMZbdgimKbUXm/yB8STivp5dXG0f+wanRmyAwDOxzRNt8xWSO6JYDJRse7OIuNXabP3ZLeKmG4CR9RPDT7Tk74pxCZxFz9lyBvmQW6Yy32y7lAHrIFlR66GjKpV3GKK/6R/xPOvcpEHoFsfVCSTKR864VVl3aZm3o6VewPE+C/JXA4hqSoRnHoSxnPtJs4443FFYKx1eggcIJfg/SdfSce7SHqTmz760Y3ueaNGNIJkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(921020)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3VhbDJYVGR6N21ZbWxWVFJLZGI4NkIramtmdUl3cjJ5M1VicFd4MU5tQmlH?=
 =?utf-8?B?R25qRkxabk1USk9kTzQ5VGZGRjZmenpDblhiTTExNzJZSzZhM0FZQ0dLaTJa?=
 =?utf-8?B?VXB4ampvMCs5aWJMMVhRdnpQblBCeVZtQ05tM3Z1bTZZVElFU3Uzd1VXNXE5?=
 =?utf-8?B?YVF4Sm82MmlWbzBDZ3hZQVkvMjdmMm4xN2piRUpWTHJLSzgzM0FXK0ZDMW9q?=
 =?utf-8?B?T1NwZXRiVGg0QndiWk13ME1KVW1SYk5abUMvWWJUaE95VFJOTkM1Wm90enE5?=
 =?utf-8?B?a3BSbDFXVVRFNzJrTTdzV2FUMHk4NkthRkEyZStGQWxwb0h5dDhpRmxiZ0xO?=
 =?utf-8?B?cTFmV0hwSnBlazVjc3RHWUllcjdVTlpqR1ppR21jc0Q1NWUrV0tMZ2tVSHhL?=
 =?utf-8?B?VHdWemJjeFNEaDcrTGxDckxJTDJCSzF1R2I2VTVHeGVJL21vZVgrTDBGTWxm?=
 =?utf-8?B?QThBVlFXc0RrbEhUcUxsR2pwUDgyVlAxOWJFZHZVYm1Va3JZUTRYcm53bDIw?=
 =?utf-8?B?bkViU1VXaTY1aUR2N2o5N0hQTDJzYUIxdHMzNVl6WjVKMllEdXV2TEtuVW5n?=
 =?utf-8?B?MmxxZWhjYVFETVh3dmYxQnVOdVJ6eHd5S2xnUkRMcDFtWmRjNG1nTi9jKzB4?=
 =?utf-8?B?enFiYlZTYXZBRWh2QkVTQnExM1JaWVJ1VHdtZU9KNmNYdVNhdjQwbktsYnBx?=
 =?utf-8?B?TzVyaUhFUXB2T01wYXJtUEZIK1NSNzZMeDdrNWZSdjhBL0dsREEzOE45MXZz?=
 =?utf-8?B?RTN3c3UxMFV4SThKUm1qMmhJNEgrUVh0ZXZEeGJRZnh6a2U4Rkc0VTFtSWp1?=
 =?utf-8?B?NWhPc0oyYUdWazNhZXJYM2tUVC9LeXVsZjJZTERreUY2bGF3SVAxcEVwYVNE?=
 =?utf-8?B?bGMvOTJGSktZSCtZK2xkV3JRdjV1U280ZTNlbE1FNFZxbVNOcWJtVGtyQWpZ?=
 =?utf-8?B?VEc1Yy9XTWNkcGYwSzYzd3BGakVJZDdKZkVKdlVDd2k0cXZ4WkE2RVdwMUNX?=
 =?utf-8?B?S3hHQnVvcnJiQjFSMXQzaDU0MFAwL1FSOUR1ZjJIamdTREpaV0dTaDE3MTdj?=
 =?utf-8?B?WW5rYUdpS1hzVkF0UzJHUUVnNDFhK0V4WEovektOTUpobHdhNkFtTDVKbGxO?=
 =?utf-8?B?bm9yUURLeDV4K1Z2ZGZUZVdZV2h0anpJWUlzVGlKK2dvM3dWOHpIZkZ3UFZV?=
 =?utf-8?B?NWVDV2F4WTNCSWJia3UyeVFtc3piQUZiajkzTXRBQi92d2dKWDU0TVAweFcy?=
 =?utf-8?B?WDRuSEJ5UEEyR2JQc2hKZGlPSncwRnNyQ29hSGlhUUxKdVJ3SVVVODEzRkUy?=
 =?utf-8?B?MHZ0R1Ayc2Robmc3WTJGUllCT2FOK3hvZFhNWHA5QXNhUHJXbGs3MW14K2RR?=
 =?utf-8?B?K2tOdlA2NHFFWUlNYktTWWR1d2kzOFEyZFpYek5SMDlTZUk0QS9DZTE4d0Vr?=
 =?utf-8?B?bzN6TFBwT2hGNVdhbFd2MVlVT29FaGN2Q0VhN1VVbWJYTy83Y2pqL01EQi9v?=
 =?utf-8?B?ZDBDOFJ5ZWVyemM5STVLcndLL2dvbER0QTNlcWo5RTBPRUZENk1rTEs3elN5?=
 =?utf-8?B?OHB6STNUbVF2Q3RWMFRHUGZEb3BDRGtZM1prYmRTWFRCeG1zT3JUSHBvWno2?=
 =?utf-8?B?WkhuUk5VV3J2V21zVTVyZml3bmFoeFlESUVvaHpJeWlDdEZaTHpQSDBRSEZZ?=
 =?utf-8?B?d1N3eVFpa2ZFNVhQLzV5SkRmSzdDenh4aWtPYTlaSUpDSDM3MHJ2WWpsSEtu?=
 =?utf-8?B?aEpBQ1RtV3FkS0RzVVRpMkgrWHBSZE9NM3lYeUJnbW1XbGMyeGU3VzBDak5L?=
 =?utf-8?B?N0E0eVZLdWhKS1ZUcmhpbWhKWmtpSytoUkladm1PS0d2UDZCWjM4K0pjckRt?=
 =?utf-8?B?ZjNBcUNOZDh6K0l2cnhTTnd5YVhoNkdUVTMrUzhpazlsMGFEMFRmSmNTL3B4?=
 =?utf-8?B?cTYvQm11UXpNN2xuenpPa2ZmTFd3SHBnY3NVWFhielF2bU9hTGVvVHJOclZE?=
 =?utf-8?B?bExqcVNMR0IzRXZDRVhYeEk2UDhRN1hkcHZxWGd6SG9CWERUVnZpU3owUmdK?=
 =?utf-8?B?blJrS1hqaksrMG90VUFkSlNOeFhqR0QvTWJhYWZWU0hETkl0QWhZZ0JsNkZT?=
 =?utf-8?B?dEs3YWRsWVg3T001RnVwYkJsOUFpN0NoVjdpbU5Sd0FMLzZzZmt0R0Fmb2Ra?=
 =?utf-8?B?Wi9CRlAxeWc1T1RlVHZDcGJzVFpTSTVtcHk5bWJOUnk3UHplZmpSTjBKL25u?=
 =?utf-8?B?d1lsMHR2aUdTdStndlVES2tTTUlBckhqRzBTcndnM2ducXdWN2xFdEZGUkR6?=
 =?utf-8?B?bUFJUEhwSytqSnkxTW9oS2R2aUFzNnhmcW9QVXZZYWhia3N6aG9CMHNqRlEz?=
 =?utf-8?Q?VkVy42XCvdAmoTCM=3D?=
X-Exchange-RoutingPolicyChecked: NXeMqRo/VB8Ugjf9tk8FDcpXjEqzQFYzNLnjGeMeK9vMFG6qZmwrY75CMuIEBa3UXcKdU09dD4ZFjzbQ3oau+MF/Dmz1r9gxEQnGe1x1LWyHPuPNqIcUnrw3h9Zpx2cIJOB5zXP3SEbIqVx11+bWgXz1SRUiHYjvKZ1/RYuOOTYNVlhWMC3+CWX1aBmeLCQmC9EprhDVijT6Dwe2qxrXHV6jfGK785YZoGSgMg+2UFQ+eVHNZSFdimRVF/0p6guA4V5aF3WcfniCMxNePWMgiFwbNc5lHwCfkIcvDkGxtMe5ETrzk6Mtc55JTXmMZq24EGsDex9yW46K3/3UdK5fZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 987d5a91-09d0-47b2-96e1-08dee2024bb2
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 23:47:42.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4SGX/KuoRw7iBZgYyyE7ty5XCk1Iu2iSyZoVs40LQGfbcolPlaa11Qw+Mspy+WDniaDX1Lub1nPmC9cUD+TgIZPBnxu6+edf8yUMN4OIyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE50071912
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307619-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:robert.malz@canonical.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:aleksander.lobakin@intel.com,m:jacob.e.keller@intel.com,m:jbrandeb@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,intel.com:mid,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1D1475981C



On 7/3/2026 3:32 AM, Robert Malz wrote:

...

> @@ -92,12 +98,28 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
>   
>   		last_cmd = !(bytes_read + read_size < inlen);
>   
> +		status = ice_acquire_nvm(hw, ICE_RES_READ);
> +		if (status)
> +			break;
> +
>   		status = ice_aq_read_nvm(hw, ICE_AQC_NVM_START_POINT,
>   					 offset, read_size,
>   					 data + bytes_read, last_cmd,
>   					 read_shadow_ram, NULL);

Sashiko says:

If this chunk has last_cmd = false, doesn't releasing the NVM lock 
immediately
after ice_aq_read_nvm() allow other entities to acquire the lock and issue
their own NVM commands in the middle of our open read sequence?
Also, if ice_acquire_nvm() fails on the next loop iteration, the loop breaks
and we never send a command with last_cmd = true. Will this permanently leak
the sequence state in the firmware?

[TN] I'm seeing conflicting documentation on whether this bit matters 
for the read command. I'm working on getting clarification. If it does 
matter, we'll likely need to adjust this.

> -		if (status)
> +		if (status) {
> +			/* ice_release_nvm() issues an AQ command that would
> +			 * overwrite sq_last_status, which some callers
> +			 * inspect after a failed read. Preserve the read's
> +			 * AQ error across the release.
> +			 */
> +			aq_err = hw->adminq.sq_last_status;
> +
> +			ice_release_nvm(hw);
> +			hw->adminq.sq_last_status = aq_err;

Does restoring hw->adminq.sq_last_status here without holding the Admin 
Queue
lock risk overwriting the status of a concurrent AdminQ command?
If another thread acquires the lock and sends a command immediately after
ice_release_nvm(hw), this lockless write could corrupt its error status.

[TN] I don't believe the AQ lock will work as desired we can't guarantee 
that we will have the lock directly following the release in order to 
restore the AQ error. Similar to the NVM lock issue, I think this is a 
small window but wanted to bring this here in case others had 
thoughts/comments on this.

Thanks,
Tony

>   			break;
> +		}
> +
> +		ice_release_nvm(hw);
>   
>   		bytes_read += read_size;
>   		offset += read_size;



