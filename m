Return-Path: <netdev+bounces-210927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E252EB1588F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 07:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A16418A2C91
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD01B0F0A;
	Wed, 30 Jul 2025 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2kUY3d/Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876A199BC;
	Wed, 30 Jul 2025 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753854604; cv=fail; b=aNLQ1Q1yjjfYYB6/SQD61b68G8TgK71CzEIdJRa3TxrzuB69JBT5QI9rIYvrvu+rV8auzoCzYGP1AhoxiVqgGOiuepRNjXbOpe3ESSftdORPh4ZBTJscR2RTlShkAi61SPt4CaiZ4SZy/eY3yO+12DFDf9CiZV8og2EMDv+eOss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753854604; c=relaxed/simple;
	bh=qlxvHlFkfvz/Bxhhy69hF1ceThtX6yudsiW2IFTNKVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=awMNi2UOX6eqz3s+i6xsrp+7uSRF0vcWN1XTlawnsWwXOi6walvfkwsW4r0UKEvgra2AqhBum6179UPerrCZLHxkdnnVVtndD1rQQw7Rmb7dMLhsqqv+4Gsp016i9rZr6dG6v1t93qlI5iLFiZZuU02l1gmZfqAev24+NCmy02M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2kUY3d/Z; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEXWOtt7E1vmbY9VeDbPQRfkX7jvcA9zN/4gCTYNapALxcy5eilAukPhAv5mEETqY9LVNgSh23AIL2yQVhOrnUfl19jilPDorBnwzCmsKTlUyNTk1bM90YdaBzwyC+PUgieQ9nXL2+jBOpQTZO3jjmQqKr+xgyrHi2p0j2k5ISxSUhI3f+HJ8GLDteRzL4nQJCkeMGXc0poWz06k1bXcp2T/L3Q9ZKaSfvtCY//O7ywN9YRUYCMIg1Jb4eY3AFakrqEVZ7qIsKbyeLAOod8jFnn8tOQ3UWMelnRJzSKblh8CAAL4e54EGEZjEgeslufdmdeo3SOTtx9/H7wJLVuepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcA0c7BErIYg87sEk1voHUnmzYgYNRH6dBHQKD62zDY=;
 b=QDWShhpSO/usNPIuP3tTJ5gD0OuFPq/OvxCNAwAtYYHykzoVA+8IwicSP6CDYWzXAvj4CgR1L6ngJUeKfgrffO+8YoGXgsAlQ+b6NZzRw8WrqlJpwNaTZlN6ixA1wopizckCc0CSOjoC7Idg8dN1TKMw7kWUezmprr1MquhEys5UogyWKbkFa+SzSCcMZSdMHX1Hy8/gaotDKSk4Tk4HpdR+FnxC3L643h8Cf6tKkTF3sjZWVp2Ul83zVg2tNKXpXjRyy5GdkQRLyP2DyZiLCMz18a0H68G9beHC32mZ5nqg5a8UH/oPnGQWIf9kpOTGBt3FK56Eie64Q8DOG3aO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcA0c7BErIYg87sEk1voHUnmzYgYNRH6dBHQKD62zDY=;
 b=2kUY3d/ZYToigVKMY0mD03s3NsUAJ6Nbi/lR6r8zQ6/xcPZDEOA/1u2teTyfg62Xln8dPtOXQCKK+JGSwViPlbg+YebsI5Bs8prD6ZIjiiyL9df4ZFH0CbksGnANTh5cGk8ppgH+OFcRQLtWX5BkiycbC1oE3xZk5GrN/1NRLvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 05:49:59 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 05:49:59 +0000
Message-ID: <e7c66c71-197c-4c1e-8a57-5cd95f96b7cc@amd.com>
Date: Wed, 30 Jul 2025 11:19:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net] net: taprio: Validate offload support using
 NETIF_F_HW_TC in hw_features
To: edumazet@google.com
Cc: vineeth.karumanchi@amd.com, git@amd.com, vinicius.gomes@intel.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729061034.3400624-1-vineeth.karumanchi@amd.com>
 <CANn89iLhSq4cq4sddOKuKkKsHGVCO7ocMiQ-16VVDyHjCixwgQ@mail.gmail.com>
 <4ede2cb4-76de-411d-99e4-70a29f97edca@amd.com>
 <CANn89i+FkSb-SNxUu_s9RzjM1qKG4uv5KZau2hhFDEPYXo-=Nw@mail.gmail.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <CANn89i+FkSb-SNxUu_s9RzjM1qKG4uv5KZau2hhFDEPYXo-=Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::8) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ed812c-02d9-4522-28a9-08ddcf2ceb51
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVVHcmgzd2RMRmtBdm12OXU3TkxLeHU0a29oczJuSm9mQ1BzY3ZPYTdtZ3Rm?=
 =?utf-8?B?S3NOZlg2dXJ2a2oxdmJDeFQ4NFB1R0hFWi9YbFdwMEFwM1Z2VnhiZUhFUTls?=
 =?utf-8?B?RlF1QTE5ZmpSamxZckFjaHo5Z0s5Qy9uZkh3dkFxWEZCbFJtTEYyQ1J3clJp?=
 =?utf-8?B?ZTJuY0phYUMzQ3ZVQjBKMmpIS2JUTXZvWiszN2c1OEJoWC8zNmhFYldyZVhK?=
 =?utf-8?B?aVlQOXdQb0hjbnRKSzZMdXUrai9xcVRXQWhoTmMwRU04M0cvVmZJdmVJbkhC?=
 =?utf-8?B?ZHk5dEhITk9nWHJ1TnZaS1VuUDNLY2E2L3ZUODV0cVlmNTc0YkYrTXdqa01W?=
 =?utf-8?B?ZXhVOHIwOVBQc0JRblVYVFVtdWpodWswR21BeHlZRFQ1NksrZFJTODJERXd6?=
 =?utf-8?B?ZTJ3Z3FkbTVXS3dkT2ZzRnhBNnlzMkRHWmZ2MVcxMGgwUmU0amlkeCtYSVh2?=
 =?utf-8?B?NmUrSjBrbW1aUWFVcUJKdldzNDMrbDduTDRhbGlrM3Y1UGR5ZGZ3OVpKay9v?=
 =?utf-8?B?dEZxVUdPYWwyOU9KaUNGZGZpT3Z4YmFjQUtCWktZSkVuKy9ONGZxdlpjbytB?=
 =?utf-8?B?ODNMUUIyNkV6MElqNld5S0hlSHRIdERRTTN2ZW1yS2hDcDdkVW1weUxwT05H?=
 =?utf-8?B?Y2VVajJ3VVNmdFUxcDJxNDlKYjVlNThONmxQYWpjS05RRG9UK0dzVDgzc0JQ?=
 =?utf-8?B?YXh5RjE1UFJmdmR3NUxHSGE5WGk1ZnlQb1VCbzhyVHN0aEk1MFkycXBZZ1Bw?=
 =?utf-8?B?NVhZdnNtSHBPcDRlbUlaUmZvSjczTFRabHVJUGdOemNReWdPSGtZb0I0czRt?=
 =?utf-8?B?eUhVYnFsbkYraGFQTnNwYjJiUnFoUU96ZUlXd0hsbnl1cWxFU0xhbUpjUHJn?=
 =?utf-8?B?dW43dTFpZTFLZjMxZzdSSnZjOTYrbjQzaDJXR3hHMmN3bTA3Q3lscnBoT0Ur?=
 =?utf-8?B?ZWJxM2tJSlVOaTFDWnBtTWNFOXBKaWk4enFKZDZESkF6UkFOWHRjdnNMbk4w?=
 =?utf-8?B?a3hmbG1WYUZyUkd5VXJsZjE1akwrTlpxMkwxcjZXRG9pL2h6SXdHN0dQTUVN?=
 =?utf-8?B?S0tJYURwazg0K1FMSU1kYkJVUUhtQ1FicmVjcVp3U0RhcW1iTk1taFZEM2R6?=
 =?utf-8?B?alJlVmNvcFE4WnVhbThSTWg4Z3E1R1B3a2ZGZjdqWkd6ZGR3bENHUWU3Rmxp?=
 =?utf-8?B?WjVXbHcrUTlpWFpJOHhwMHV5aTVpSUZ1UWdxdzJ6U0FqZ3lYdzUrUmc4K1h6?=
 =?utf-8?B?VC9TcnEvN1pKNlBqeDBnYWJSWTJWU21ZUkVFemg1ek4zeml6Nm5FNlB0RVVp?=
 =?utf-8?B?SEpxalU4TWpDUTRXbnpGN0p2Y1pBL29yejFaMzRienR5VTYzS2s1UkZJaWFZ?=
 =?utf-8?B?WTViMTJxNGZYcVBoQ0ZCMjZJcjFIQnFVYnd3YnVRaVI5cG43TFpOS1RkR29o?=
 =?utf-8?B?bUNkcjU1NXI5QlVWekdZUHJlTGZTZDZUYVJuRHFXYWdkODJvRVdKNlNnY2NF?=
 =?utf-8?B?Wmova0hPZUk2aVgvWVY0b0FQa29BR3NHdFFVNSs3eXk4Sllkblp5SG9JSjA4?=
 =?utf-8?B?RkZBZ3RhclVubHZYd09EcklieGVVanp4ZVppK2hsNU5obzhJTVVhVG94akVl?=
 =?utf-8?B?N3Y0cFM0OEpyL3FzTFpNTHhHWjlSVWhBRFRaSDRETVNHc3ozRERCM3NCcG9a?=
 =?utf-8?B?aHZFd3VhWW5WanA4L3c4ekoyNys0TzRlcGFQSUhyU25pY051TUZiZ1FPeCtV?=
 =?utf-8?B?WEJROEpRczJvMTBOaWkvRHFmRUQ4SlBmdzZQSWFWWEg5NHFOTk11c0daczRV?=
 =?utf-8?B?eVZiZmlPMURlUUo3ekZHVDg0Nk4wMXgwVDgySjdlc2l4dlRXeDAzSXljemNs?=
 =?utf-8?B?c1VXVWVmUzVvTU1mYWVOMWI2b1UvVHR4Y1loNlFiMGMrdmZxcUFNNml3aVZG?=
 =?utf-8?Q?Z2EAnBpNsHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTdDSUc5L3FTU2gwREVJRW93UEpUdnh2N2dHZWZMdzFaRHdiZ2VvTW9aNU5U?=
 =?utf-8?B?NGJnL0dNQUhNeEtjK2JqS2l3TUxIWDJTWGthSmFGcnhvc0t0cW1aLzRUMEdW?=
 =?utf-8?B?SGprVzl5dUlFdnI5WnpXVEswNGtkemRoa3JiOER6UUgvZm9JTWFMZjlvd1FG?=
 =?utf-8?B?dWJCQTYyaVFzUXBZZ3JsbWZJRjJBeTJQSzgyaHJnanl5anppTHd6MkZHRzh4?=
 =?utf-8?B?L3dmajFXUUJmRFJ3UnA0endIRFNMN0MwMjJaOEFLb1ZsM0FxUFVhVkg4My83?=
 =?utf-8?B?YjRaSlI0Y1hXUlVmdGp1ZEoyalgvV0h3elhoNzR5RlBUNGhOUXpacUx1SEJk?=
 =?utf-8?B?VjZGZVVFbEZhQnd5WXBpeG5KbTZ2MmVQYkx5cG0yVjhYM0tRK3JPL3UvUjRh?=
 =?utf-8?B?L2N1U0h1aStyUkxSQUZ4aU1QSDVXTzNxQXB4QzFuVG1jRWJ5NXJFWlk4OHpJ?=
 =?utf-8?B?SDJRejlKTEtvZ0V1M1FqOU5tSlB0bmFVazQ1M3FXNlhWd2xzdVY0NzVPTWhw?=
 =?utf-8?B?M2tFV0ZKN2hVTi93amcyMGhvWVZqZWVKVWR1bVpTeFM5b3VTcFNFU3hNeWFL?=
 =?utf-8?B?NDNhem5obWI0YVJtSVkyc3NScExRc25XNmM0ZVhtRDNyK0FtTzk1ZDVDRTFq?=
 =?utf-8?B?aERjV0NCSDN6V21JYjdyY2NQcUhXSml3dEN4bW5qVzkzaXo5Vy9qdmhQUUl1?=
 =?utf-8?B?OWF2b3J0R3F2Q1drTEpveHRWdUJmRVh6VVBNNnBmUysvZzFabkZrS213Undi?=
 =?utf-8?B?ZnJuZ29aU0tQa1oyazBuM1gzTkdlb2M3M0xRY1ZaZVl6ejkwWTVURkZ3Vjlr?=
 =?utf-8?B?MzhKS2hoeDlFcGlqT3A3OHF0SUhOVTgrQjQ1WEpCa1RWT1BUY1RPL25DZHNi?=
 =?utf-8?B?d3E3Y2xJUG8zb0pGbVgwYjhsM3A1aTMwSEd2TlMxcCt0eEI1MEpkVVpxNzhU?=
 =?utf-8?B?b1JRYjVwb0QxdmxuaEhwU3lVOXhjNXV5NDBHb2JvNk1hbGhwbVdGbEJDcC85?=
 =?utf-8?B?SUU5K2U5UU5QM3VFWGNqTGJWN2xTOU1BakNncGZvRHV5a1d1dC9KUHNDbWM4?=
 =?utf-8?B?THRKZXErYXNZVlZ5d1NJYk4vNkVVRjFWdloxRzZOYUVGSkdzaStuaTlsQzh6?=
 =?utf-8?B?eUNkZWxSMXFlU1ZDaURiU0FUSDc0MUVoVlp6Z0E5K01rbC9na3RSYTAvQjJn?=
 =?utf-8?B?dDJNS29pdm5qdml6TkdXV01mOE9idE0wUkZqTjlMMnUzVmVIcXVKRGQ5VlVD?=
 =?utf-8?B?Tm1WNy9qOFVmc0pyTVl3VFRDMERPL01YbktYZ0Juc3VJUERLajdxTVdReXFU?=
 =?utf-8?B?bnBzZEZpRE55WnVWaDZLb1RhVGlncXNwN3NEWWxobDlUN3ZFNzlIb3FqYndG?=
 =?utf-8?B?TS96V2FVZER1dDVWNHlyRVh0dWVDMzQzM2pGUzVndjZMeUJjKzRRc0x4VUR4?=
 =?utf-8?B?Z2g3WllPWFIrNUdVL2UrUDMvYkNLTnM3Mndpd284dWJrYU4xQXFhT0tEdUs5?=
 =?utf-8?B?aVRkakk0YURXTUFta1ZmTUNpRDBrS1JzaWNKZlFsam9EcGNQZDRKa2xEc1Ex?=
 =?utf-8?B?bW9qNXZOOTZBTGpwb0dsUmxES3RTeEgzZU1NcDkyWEUyNDZJY0hCZWNCTjNj?=
 =?utf-8?B?dS9TTzF3MENLKzZiVk1RZU5oaE5ZTUpRaEpmSmFVa3kwZUNabzBxa1BxbjdU?=
 =?utf-8?B?VzVHVExENTFkNEM4QWNXTldQR2F1aXFqRDJHN2gvQU9VNjVmS1BBV21BRHNv?=
 =?utf-8?B?ZGU0aWhQYVpNMWEyL0NIQkdkcTJiZzIxck5wTTQ2SEpGQk9YVHZKN2JtMEpw?=
 =?utf-8?B?aWJuMElZTW1KUnQwYnRsLzdhSnppOHE2enhwYXpNbTR1NHo1dGNubC9uUTh6?=
 =?utf-8?B?TmtGdlZ0VG0wR2ZheWFPekNPeFhYWDBiZEpvby9XMkRtRy9POE5NeVp1aGdv?=
 =?utf-8?B?NGZiOFgrMjdURnA3a3BNcFNJb1R1ZEI3cUJSc1NrWU5yUXlJU2ZXcnpHOS91?=
 =?utf-8?B?M3VNSEM2a2lNU0ZwVWlvUXhuTzhsNVcyYW1rc2J3Y0JWaTU1Rm4wZEZHd1FQ?=
 =?utf-8?B?QngvbGhaaUo0ZU5nc21ValJWeE5WUEtUdnN4Vk5tTFo0L3ljZXdMdjNmcDJj?=
 =?utf-8?Q?E91YCbOB+9U1FLkUJ/dmtK8NB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ed812c-02d9-4522-28a9-08ddcf2ceb51
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 05:49:59.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r09wu7yDL8GcsXb1hUZ2ilsWm7ySJ0TshKOuOKvJSKto9wduDhb5oFICBTb+xuH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630

Hi Eric,

On 7/29/2025 7:06 PM, Eric Dumazet wrote:
<...>
>>>> Note: Some drivers already set NETIF_F_HW_TC alongside .ndo_setup_tc.
>>>> Follow-up patches will be submitted to update remaining drivers if this
>>>> approach is accepted.
>>> Hi Vineeth
>>>
>>> Could you give more details ? "Some IP versions of a driver" and "Some
>>> drivers" are rather vague.
>> At present, I’m only familiar with the GEM IP, which supports TSN Qbv in
>> its later versions. The GEM implementations found in Zynq and ZynqMP
>> devices do not support TSN Qbv, whereas the updated versions integrated
>> into Versal devices do offer TSN Qbv support.
> Is this an out-of-tree driver ? I do not find macb_taprio_setup_replace()
> 
> I think most drivers should return -EOPNOTSUPP in this case.
> 


These are the patches of taprio implementation in macb.

https://lore.kernel.org/netdev/20250722154111.1871292-4-vineeth.karumanchi@amd.com/

https://lore.kernel.org/netdev/20250722154111.1871292-6-vineeth.karumanchi@amd.com/
Here’s a clearer and more polished version of your message:

  I initially considered adding the check in macb driver, but since it's 
a generic validation, I believe the ideal place for it would be within 
the TC framework.

But, I'm okay with adding the check in macb driver.

Thanks
-- 
🙏 vineeth


