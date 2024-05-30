Return-Path: <netdev+bounces-99525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDAC8D51F4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E831F225DF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A747B2E417;
	Thu, 30 May 2024 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iz7cUIEB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC49C8DE;
	Thu, 30 May 2024 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094752; cv=fail; b=sGDxdqay70AHGyybJRKEC4ag0PFmUGBQTwlTJR0XVNva45vdDuWnfOPMKQnXwkiMQM59pR6zLQgHdIeDlnQkQ7PnAwkNa1WWLUZ04PDAHfJDhFmeo1YrVteBZhQEwEfQDH2ff6HLhFJSN/1LsC+fAwOAlUhq3mSKPKvEzdRCoYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094752; c=relaxed/simple;
	bh=jwKxG4MQ9itkydGJgEpqPSNxspWeCTVyFjdx0JL7t5s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uyb5pY2E0yk7VM0GwQM441CUR2vLHzFRJkIL3TW2A8YEs+gtAEy+TvabQLwLIRJ7jqGwxYoN7kC+mu2yDUOitgLGEJQfAlaxbik0pL9FtqJcbfiOtrSnstSRKYMu3VQswbxpsqOSCw8BwEpN9k83bwe8s+RKNo3UmkdLsDRNOMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz7cUIEB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717094752; x=1748630752;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jwKxG4MQ9itkydGJgEpqPSNxspWeCTVyFjdx0JL7t5s=;
  b=Iz7cUIEBZ1bor0RV5bMQM70Lo0DEU/UsyT3TiTb9RzFpTnY9+WbrAAvV
   QQG9RsPArmdV3fbE31ehuT6A17kAdM/hyHC9zT8CFIi5BcU0pN1KS0Hw0
   kvieyIk/NAtjF499c3KqW/L6/xCk9cRQCLubYEaf8JXv3vwzqphVJxgRo
   zWzZ+3AUdzjEk9esq9dGJkv52+AdzIQLWorTTiAJ/3rH9fO/mrYFSMdoJ
   soz+FGbg+MwmQrjyMpf6nx57piI/TqBFEbE/W1LJ6yT6n8bd8kwoGTiFm
   hEoKYp/52Tw7nbiMcJK0raNig3cHczPxV7HeiktFTgJ9fcSBpfPj2FEPQ
   w==;
X-CSE-ConnectionGUID: XwBnUmcTSGakxIcsE2JqRg==
X-CSE-MsgGUID: ut3M7NbLS4qjZ+ksNZSbrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17404699"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="17404699"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:45:51 -0700
X-CSE-ConnectionGUID: ixKaBHKbS7m+SWcCvgZZFg==
X-CSE-MsgGUID: HWgmhc5mQpSu0b8ZpHnpzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36405074"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 11:45:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:45:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 11:45:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpofdL8SwgctLjaoaQxG9qs8GRzsexcNA/6rqnxJFUtHogXnQ8RdUgF4pumU8eYPXI6UtvCTwMXfLy+SKa8uDokMyEXWc86TEDIzGK70aGHxjU2YDvzrLLvpjw9nYskB3E5iatm78AueJIwdYvTNOHxZP7W3p06bXB78BdPzqywC+RY2hKhqxuUcCIF6/zzX0m7kb+QQExOZ9+2VvBOTI+izpKKTT7D7pWuXJHPn6DeLLrW4ZQiuCJ/Ns9Tfg+BnDQMkbiOoBzoW0wn3TCvTuRp/PJHXwAZhCkzdaO5Tu9CJzhpCZVxgKYm4TVef5+V1p7Nii1f9b2CxJusVXkaBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dwsL+uaYtI8Ei8PfXXBHsYGP1WH+9tHhGj9ovmVrn8=;
 b=VVHDzc9mqVYd+Bmum4jbO9MmqP6ypztmpyAtB9/nij/e4jkYbQ5bJ23ZOmWoYA1bQlvzCwW37CphRkdbyeX3EM0Ua2dgYm6BbSQBfQS0ck7pQUCsLi+ikQbvkHATHA1qD+Cp/vWCmV/TicO+VxJupJW0hS0P4ldAb21MRBk92gca0St+KInsqEjZF9w+EMxMe9ZNsuyagScUnTVTpH8LX8ceJAS/gMCia04cL+NvA4B0JsKB9fERtZBah/EYYOL2taHQZSzPZfk0wa4sXAWaM5bTe+nuIc1tU815DBeUlAyjUH7mQ+PWr5WD578+2Y74FhzQkd0Mt41Q82asinnSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.33; Thu, 30 May
 2024 18:45:46 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:45:46 +0000
Message-ID: <6151a649-cfda-48c9-b6b9-e3710969634b@intel.com>
Date: Thu, 30 May 2024 11:45:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: iot2050: Add IEP interrupts for SR1.0
 devices
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jan
 Kiszka" <jan.kiszka@siemens.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
 <20240529-iep-v1-3-7273c07592d3@siemens.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240529-iep-v1-3-7273c07592d3@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abeb93d-8985-4a29-5519-08dc80d8b7de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE5sUldKTEJMdXc3NUwvWWttaUN3aDFwYW1OWWpGbUh5cWNFYnVXVlAzVXlo?=
 =?utf-8?B?eUY1SHo2SDZFSzBQNHhzYnMvWmlQZmVIUW9qb09LSDk5akVabmRRVURlRFVG?=
 =?utf-8?B?cGx0bWoyVFBIb3lManlXQmhDS0dGVklmSmZZcW9reVpPOUhLb1FZWEFKdWdL?=
 =?utf-8?B?Q1RiUi9BcFJmZHNjVkE2QXZIVEZkMnNWMnlEZlpZY3VzRlBKRERLblFCTm92?=
 =?utf-8?B?MDN5bkdBWXA2OXJ5MHZHVGlHdVB1Z0N6TDdtYlRrYTY0UDQ3ajJHd0ttUWRL?=
 =?utf-8?B?NEZkbzFnT0ZoMHUwWHBicXlhSlJIYUFFUXo0TFhHaUZWNGxQRFhCYnZ6cUlL?=
 =?utf-8?B?NnRZRFlWbmk0N0VaS3BQSi8vUy9GWnJmbllBRkh1cE1LRm9uYTZjY2JSQzg2?=
 =?utf-8?B?VEZWaXFoc2EreUV2NWpIa0JubkppRnBQYTltN01aVnBOalFBQjczdHg4dkli?=
 =?utf-8?B?aFQraUZ1enBhdEl3R254UU5HdGlkcWNraS9jK0F0Rk1EdUlCVEFtVkhJb2pH?=
 =?utf-8?B?NXp2NUd1UkErNmxsYTd2TjBhVEh3ZWx4VGpzYW5hejgraHdyc1VCR3U5YzFX?=
 =?utf-8?B?Qzl1TGY0TW1DME1WTWIxaEFNb3lFUWJSQW9QRk5iMXFvRXoxeWcvL0dpTysr?=
 =?utf-8?B?UzhVckRjWDlLdFZXbStUNE5DZ2NVSjFzYTNoWmM5UTRWVkwrV29yRWoxLzF4?=
 =?utf-8?B?aml3YWV1MWJmd21UakFVQkNKUmZOZllLWXRDMlp2MGptK3VzMlA5OXExNzk0?=
 =?utf-8?B?QmczQlVCNU5BVlhLMzRyUlI5U1puNzd0VEgxQ1J6QlpGTEI3V21OQUoyZmR3?=
 =?utf-8?B?VkFZOXJtSGxoNHhrb2lYRUc5OUlsLzgvc2cyNTA0d2ZXWDFXRElGU3hvWlVv?=
 =?utf-8?B?SDRhaDk4ajdyNGhEY1RtNmxFNmhNKytVS3RYU3J3amcwNmNsM0UxanpEakdw?=
 =?utf-8?B?MlcxZzZMVFFkWTRJa0dTZERXaVVreDBISjhsNU9pVzR2MVd4ZE5SQWRkd2RQ?=
 =?utf-8?B?dkxvNU5GTHozazdiazQwTjNOTVFaQnowUHU2Rk5hcXExN1R2bFRpRHQwRGR6?=
 =?utf-8?B?aExlV2xRQmtYR0J6dGpjcUxwazNhbGY0ZWVhSFJrbU9MSS9BUlFYdnFFMDlp?=
 =?utf-8?B?RnJYcWYxeDNFQS9aRUR2TWsxeFlLWENFRnZmVkpVVFg4WXdFeVFoa1lVZ0FK?=
 =?utf-8?B?c3I0cUVxUGdQT0RjNlJZQStjcTA2c3Jxc0RPTmpvR2pYeVMvNXhTQlhvclUx?=
 =?utf-8?B?WjA4T0Y0d2d1YTM5SWZJT0tqSTRqVm1zUXhYUVhEYWw0MURTdEFQKzlnZ2FO?=
 =?utf-8?B?YkVxcUVQR2RxaWNPalQ2WG13OXE5UDllOEJ5bTV2cEY2SlpxclZiUDFINllS?=
 =?utf-8?B?eUJYK1ZDRTNCUXl4QWZ6SGNLS0V0SVhNemc0Zll1UHhRN0MwUXZIdDQ2b0hM?=
 =?utf-8?B?dk8wRW4yWlZXTHdDTTl2QnBZZkU3dk9NZ3hJVUk5UVNZNitKbks0UHhLK3BN?=
 =?utf-8?B?bTR0QW5DT3FXdER3d1VOMW9uMDhhYjlJQVNTaWtReHp3aXplM1JDUmRZZWpF?=
 =?utf-8?B?SUxSak5NWTNoVHdzNE5Ma01tKzJvMmV0UXhta0ZYd2Z1S1FTenFZdU9qaCtM?=
 =?utf-8?B?a0N0ZktiSTloT0Y4MHZKTnlZcDROdm9kbjN2bUpCTG5CTUdNejhCOVdrM1Jp?=
 =?utf-8?B?OEVyN0s3MUhnR2dWTHZJdkQxUjNiZ3ZLUjZpS2JKZGtaMjdvQlNMUDc4WWtS?=
 =?utf-8?Q?7V2JRp6CMWfwvPPqJLLEm9zvW3wfa/1yAng5Pzq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUNyWXBkOVlHcVBxRUE2eTN3Y0Q5bjl4YndJL3VHTERZcFY2VmZNZXdDN3dM?=
 =?utf-8?B?QkdGeFhKQVl0VWhPOVp1ZDgyUGpsRjBZMjlSRG5EbGZDbWF5VnJxcTZZaDl0?=
 =?utf-8?B?anE4U0VsRnVqWWpsNVk0enE5Ui9LQ0hHNitXZjVSWEZIVUxSRUkyb1lWdWF5?=
 =?utf-8?B?Y0tmczBXMXVIS3lNK1pKTWJnYlhnTDRoTStJOG5heFNZaGNWSUlRT0hMTUNi?=
 =?utf-8?B?MTVvcGNYdlc1cytWZW12ZVhJWGZBaTVPM1FzMVVqMFNsQlh0eUtkZ012R2M1?=
 =?utf-8?B?RlNkUDRZb2pKeWRNUFNWT2RaeFRoWjRFRGNiZE4yelh2cFZQbi9BbjZJeXVr?=
 =?utf-8?B?MHBhdWVJZ05PNmlKSkw0RGFpY2hibktqSmFYRHM3OVZHSmU1bGNObmYyWi93?=
 =?utf-8?B?NFhFZ0Q4cVUyVkRWejZIa0EvcVJYZHYveno2MzQzaHJaaFo1WEtYVDJrTllK?=
 =?utf-8?B?UnZnYWxRTFNGazdnQkQvY2ZLSUpJNStXK1FzWG43TlBBZHhGb3pBck9Xb2kv?=
 =?utf-8?B?bE0rVTk2aHBoaEZKb3JOUHo5cFYrRDVkcHdkT1JBaXBFQlNpNVRjM3Z4ZG94?=
 =?utf-8?B?TnI2N0oxUnlKdlZlWUdtVnpSOHpVZC91ZUU4WkVqdCtiWjdtRHdzcWkxU2tY?=
 =?utf-8?B?NWNML3Y0SnptSi9HZWdSd3h3aFAwY2FNc3NFSHFQOVk5WTlDaWxWYlg4MVdX?=
 =?utf-8?B?NXlPcDV3dlJ6RzEvRk1rSTQ0WFRENjVXSWczN0tVbE9PYTZWaXlac1U3WEkw?=
 =?utf-8?B?WGNhc0RSMHRQR0hDMkxuTnk0M3pUQ1B1bmtMMVlPRzMxQmcwREdVWnp6dXda?=
 =?utf-8?B?Tkp5UmduNDlZM015S0dPOTV2NVdNU1U0bk9yYWdjelpWWENMOTB2UVZ5WExs?=
 =?utf-8?B?OEoydE1qL3hjaW1NQVprbFVLZzFwa1o0N3pIK0RneDZ3eXJVcUp6UHA5WURD?=
 =?utf-8?B?SE9WOXJJeXdET0FIV0NmdXZuOWpjSVpIS2NMMnd4RGU3RnVNbEJwSXFjU1c0?=
 =?utf-8?B?L1NmNHIxcitWbVhlZ2VwUXlpYmppZko0eTNtWFBtR2VQRnY4T2J2cmdtRzA1?=
 =?utf-8?B?czN2bC9KSUd1QkZhd3p3K3U1WTdham5NWUpldHhZdmJTYW5wanZTRnozRndD?=
 =?utf-8?B?YXNnZzRIdUkxZy8zRVhIc0RMM253ZmloN1ozVXp4dnBpQjk1NG45am5hNStG?=
 =?utf-8?B?ZGM2c0dBUlBkaTlZNENOV204YndYLzN2SE90azNPVmhFcjc3U01yaUJuazND?=
 =?utf-8?B?RlUvbURaaHd5cjZRdUZhZUZtK0xGNlNHYUVaVTRubk1ZRXVLSUdzNEdkbWVI?=
 =?utf-8?B?dTJ3b3NkSHBZcklpRUdIdzFxK2grY2IrcHN6N3Y4TUdFV2RIdlhmWnJ6cGIz?=
 =?utf-8?B?dG4xMEpnY1FVM0RZSWFsMTNYNU9YUzUwTDY3bEdKd0REeGJ0bEVpT1ovY1VM?=
 =?utf-8?B?RnNZSFF5SVFRY0xodXd0RXN4c0dyNjYveDZON2FISDUzRjFycnNjWGk4TWxn?=
 =?utf-8?B?T2Q4a3ptWDhtc3hSeU0zOFV2ZU5jNDZKNVFpUUxLQlFCcmhvcEZOeWVGZTkx?=
 =?utf-8?B?anRLOFk5Tzd1L05vcFJKVTJLem8zYVRiT1EwWk1pdTQvVlJHZGk1VFVXNGlt?=
 =?utf-8?B?MUJrRlZ1UkdCbnNUSEhCcGF0U0pTejM5ZlZBMUpqbDRKR3BrcGdmRHJMK216?=
 =?utf-8?B?Ykh3ZkFoaEE5di9XQnJ5SHJBOTZnSEozN0hJcGlxMXBUd2dLUEVWeGp4ZzB2?=
 =?utf-8?B?dFZGb1V5SzN6dnNnWnEyRVJuZGNOZDFzREJDVHZNZWoxSDNaN0lHUUdDMzVh?=
 =?utf-8?B?VTJxcGhVQmJMcDZkV2oyZUFWM2VvWDVadDhoeGNpdUJWbGsveHVZMHRUZWl3?=
 =?utf-8?B?dkY0NkhtdHkyL3VJN3NMWXRwZnk3elI1bUNVcm5EcEhwZys5UHBZeEgrNzZS?=
 =?utf-8?B?UFhzcDFTV0JqZHdSeUxSMWxNQ1pwRzdUd1NabThNUDkycmh5VXFQUDAxN0Z4?=
 =?utf-8?B?TURDK1NGV2YxZFNTdUp1OTRZQmRaRkdQVVQ1UDAwcytIVUtrVUIrNU02eWFN?=
 =?utf-8?B?eTdsNVRheThFTStRSnd4QWhnN0lyM0dicXFlaDhTOXNueGhCLzRReS96ZEdn?=
 =?utf-8?B?R3dpOGNlYWdYdnFmMW15Mmt4eDAvNzJMOXRSZXhJWTlnRjVTQkllbFdXS3No?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abeb93d-8985-4a29-5519-08dc80d8b7de
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:45:46.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: id9Web4fZ7YZ8olTEay9M6ETYkBl2ZXjtDmRiN2tJ4u7Y8BvZEgs501euY6ESluoM7a4QZDMcbOiUQxZXddRQBi2sOf7ZBjZ5hVeuon87k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-OriginatorOrg: intel.com



On 5/29/2024 9:05 AM, Diogo Ivo wrote:
> Add the interrupts needed for PTP Hardware Clock support via IEP
> in SR1.0 devices.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> index ef7897763ef8..0a29ed172215 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> @@ -73,3 +73,15 @@ &icssg0_eth {
>  		    "rx0", "rx1",
>  		    "rxmgm0", "rxmgm1";
>  };
> +
> +&icssg0_iep0 {
> +	interrupt-parent = <&icssg0_intc>;
> +	interrupts = <7 7 7>;
> +	interrupt-names = "iep_cap_cmp";
> +};
> +
> +&icssg0_iep1 {
> +	interrupt-parent = <&icssg0_intc>;
> +	interrupts = <56 8 8>;
> +	interrupt-names = "iep_cap_cmp";
> +};
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

