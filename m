Return-Path: <netdev+bounces-243554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35E9CA381F
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 12:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBE063049E7A
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6956633ADB3;
	Thu,  4 Dec 2025 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LuuaF9Az"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720A398F88
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849367; cv=fail; b=kYn/2Kw65zwqQBkW2tKP+OLAcWOjLhrh/NGMeDG2Jwk+LhHeMMUXKBzbQa5T3U+IM42DbFj6mtHv6GqNj9KqlZtDPioJWgDrvk3imxGTUPP2NHn07iLi+7N4C3gzJHK2OhP/Ed+u6Vuj7KXqsTl0SuDPhnWVO5OLWwWPipyVuHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849367; c=relaxed/simple;
	bh=Psyq8p3Xu8WIHO0/nLMxeTf06iDbFrUwgkJaZED6OrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oSRLHgiXSetn5ZzpiRBQCKNxsLD7hKMKz/Gi/OZm71dDc5mF2diByAR8oPNtYuld/l9HCZ4iAz3CwvZFFYz8RwUEj+SSRa+MZmd3lcWqx6GBIDIBf78APc983bqHNReLwJfI0dIVKHM9Mvoe4DfUW7PKJIkkUwPkd3Y7UleF/k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LuuaF9Az; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B48b7DK2052840;
	Thu, 4 Dec 2025 03:55:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=joZ1He0vHSsR9vByh5QTNHGR1bjgeWVzAdVqcfnYvzE=; b=LuuaF9AzadaQ
	5Eye+iDlf2zMmWdGVxyZ4Hcbc8wA5BohS6FDAsPxEhgt+HkDTMIBcYjnSeg3Njws
	iTYJWwLwuJn2KztZp9VkdqNjYTjn1jIXqoXwXopf/MIKR5T/h9S+J65HOJCsJzsD
	6N4VH5GU7j/7JWsLWIkoLz/dW3a+m+n1WWU1UDkv1YT+ihMSMdsqUsij6RrI+EAS
	K6+TWINTRJZ16jc5Wtyi+P4KGM9PIc7LKs0nROBkiLE+kzxtWRxm9Af88t93L6/b
	LeZt23KNHI9nbvYMzms21BUCJYalm/nndLjmDHHW1Dg+8wMbyo76uDBuhEWXoJOA
	im7smdmI3A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4au6xus3gy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 03:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGUK7Vz72U86uiTtgYjxellqn79CRNUzZv3HX8VnqnDv0IG6lzHB43smTSaYC8hj1GzwsvbnRPJsHCclunmqj9k8mBB8tFyVz3cprNJPTaeyRPzowxg8EguEjHSRbivNXwz9Mtwc9WmZMJKJ/2FLiCdTprQHPvfG7qANqlLJ565y6+jwER/mo7Z+1ADbaq1sAFvSAGmD8RYlJMNQs6kIPUL/pej9wsX4SkUEttE2WSpy9zg4LnF7G71B8GIM0zFUbplJljES3XnA9R35vqyDAPI3SlmQk1X/ooTxNEuvTSYdVC71pmVLqunMIGaIEQ4bCazS8oQgdaLF1QDLORJ75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joZ1He0vHSsR9vByh5QTNHGR1bjgeWVzAdVqcfnYvzE=;
 b=FTkKUeBhpv4iEDTsGjSqwAeX7+f0kIVsFrENJ45vcLheDLKBtxBiiNMDz+EqggNGhZc4XOUHjCzGGx9edVc6CyU8ddv7HefLjZXu06O90ZBf1sfLtzqF9irYodAEw/mmSSvD0VxpYLkt/uVGUC5Xl0SVxCrkOeJUAwcnoGxK4Ac+AyHicWs6E7cOEqxXUZ/rcmGRGF9aALGNUT5uPV9Ci2sXskAwXQ/iKCcQGIJfheqPmabvFJoTKzj9MhPMAJGtrwdryRZoJWpcE1FukprbKpLNACgRMDUDpqiwzswfUPcJxZkAXm06HYZsztNNgfx1q44IhpmhADvWtKx7vbOJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by LV3PR15MB6653.namprd15.prod.outlook.com (2603:10b6:408:271::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 11:55:34 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 11:55:34 +0000
Message-ID: <9cfe66c2-9a09-4032-ba65-203a3eeee9fb@meta.com>
Date: Thu, 4 Dec 2025 06:55:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Daniel Jurgens <danielj@nvidia.com>,
        netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
        virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
        yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
        andrew+netdev@lunn.ch, edumazet@google.com
References: <20251203083305-mutt-send-email-mst@kernel.org>
 <20251203160252.516141-1-clm@meta.com>
 <20251204021540-mutt-send-email-mst@kernel.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20251204021540-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:208:fc::22) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|LV3PR15MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d55355-0fac-4fc7-1cc8-08de332c0819
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cHNrUzY1bTB0SHo4blNSSUs1ZitjbFNobGpkSUdxZGhFOHpiV3FYVWlmdkk2?=
 =?utf-8?B?UmlCQzc1cE5MMkZGL2E4cE9KcU5WWVp0TnRUTStYdy9wRGNncWc5OW12NEIz?=
 =?utf-8?B?MjN2WGFibytYeXFDRmt3eHQ3dG1TSmljaFl5OXdTa0cwMDIxdUtSbWc4SFNW?=
 =?utf-8?B?cUEwZUhoejM1UStQVUd3T2R2RW5FMXFvQys2ampJR3dUQ21uY3hBaXhoZStK?=
 =?utf-8?B?Tzl4YnBHQWRraUNWRkVJbzhHVUcxM09ndkwzaUgwUytmUXJMS2FRV2MwejBh?=
 =?utf-8?B?c1RHRzVpUHpPZGhSMTZlZEV6N2hFQmlBRVZROTh2QjFSZ0JhUDFvZ29PT043?=
 =?utf-8?B?SGJQMkFocjFMQkd4YjRQaDBHSTFHdjVWaTVaTVdUZ1JNSFh5SUJsVkd5THdj?=
 =?utf-8?B?SXpMRE9aTXhPMVY1Z2hRR2R3YjVTRjg2ZWYyc0xBbmRTTCtUYWdiaUlybTBx?=
 =?utf-8?B?YWd4RnptTHFWVlJLeE42SU1iMFdCRlJSNEVHbUpvNFJjd2ZOckwyMXpmZXRr?=
 =?utf-8?B?MmcvcVpHOHhzdyswa095cHJ2b0FQTVlNV1NvdDBtYmkyRHgwUzlUSUJxbU9V?=
 =?utf-8?B?dEZYcC9tK2pDc1BFQnEzdVFXWmZPY25BbTQxT09DVURnUFNsOUxNbDEyZzY3?=
 =?utf-8?B?N21qTmtBQVY4NEhJMDY0K3Z5Y3poV1FpdkpFWUtMVTVxQkx0Yk1jbUFHbGp6?=
 =?utf-8?B?blRIY3JiWFlvNnEwQWhjYWI3Z1BHUDNDUGV0YXRZNVZZT2JPbWQ1UWJOWkdN?=
 =?utf-8?B?cmQrMU5RTFN5RUI5djBmS3JuSS9IbUtpVkg5WTZpa3JDK0tuVi9zVmdtTVJN?=
 =?utf-8?B?b0N0UnVqTGRMMnhjK0NldTN5OUMvZzBjbWYrcXB1aXJIZ2JZalVTSE03STI1?=
 =?utf-8?B?ckIyb0hZeXpmRnN4U2dPUUNBZ3JoSy9hRXByMnp5bmlqajFOVmpRcisxSDNV?=
 =?utf-8?B?WVI5N3ArZUVUU3hRbE9Xb2JOMkRGMll0Rkc0SHdMTG5TRC9ucm5BWDZ1c1Fa?=
 =?utf-8?B?QkhDbnRDZEFWTDBwdVJVZ2tXbms5VkYxRTF3ZlVnZDREeTk4dDZKd2ZLbCtU?=
 =?utf-8?B?UGFhQWRLUzlCNTNSOUdTZWhPUVc2V0V6RkVQODFUUEdRZWxnSGFjdGZweG9R?=
 =?utf-8?B?emQrcldwM1EyR3BJMlBFazA2eXdOSEhFNXlpN0NHallKNWJ4U0VteTg4TlAz?=
 =?utf-8?B?ZzN2WVVMOHVZckVhM3c4K2xPb3Vrd1ZxZ2pjai9wVFl1N285NlJBdTNCUmN4?=
 =?utf-8?B?T0ZlaDA1ekg3eDFNakpsV3pWbUpXZnB3MFZiUjNzQW5oM0toOHJkZzl5a3J5?=
 =?utf-8?B?SUNiWDBXMzErZGRJSVRuOEhtUjJGelVRYlFXREloOW1KeUFNRiszYzVMdGJU?=
 =?utf-8?B?ejVMZ0NSbFp0bVRzaG9uNkdWdFRiUEJHVURjVFNBL0xYS1RrK0piSUhXSXFX?=
 =?utf-8?B?aHNpZG9ycEIvaGJmVGNwQ2FpTDlLRDVNYlpHSEdsT0xHVHlMNlBzL01kelcv?=
 =?utf-8?B?Y1drTVlpL0tXRHNtUjFvVjBGNC9XY0FJQnRxNmF5YmtsdGoyWHgzb2ZqbVdL?=
 =?utf-8?B?eXFoSDNZN1JyZUJxUmRPSHZmaDZRNm5rYjQzbTlXbjJ1NnFxdGVSOWJTUGpH?=
 =?utf-8?B?N3NlcVVEc2RpN21pbHdoblJFNFMrU3ZkZWl1U3VUZHJEdmdXTks4cnNKcjhM?=
 =?utf-8?B?RXhneGpNZGdmbU5mcEJsVkdLMGg3QmF4UjdYVlphbExFa0J6NTgxTDFpTXJ2?=
 =?utf-8?B?eDBmS1haMDNzYTl0UnB4Y2RyV04xTER4V0dUM2tMRWFRS284VG01U1Z4a0h6?=
 =?utf-8?B?TFUyTGxXRDhiNk5pTXhreEcrWUw0YTV6NE5LRGZkdGhzSHBOUzQ4T2dOV2tT?=
 =?utf-8?B?V1VlVWpsZXh4TWFGQzFsVVJPdi9GL3BUc3J5ZG9OekdnRkE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NXdzTmhrS0hwdGRURFVKUTVBclllQ1FwOFhHYzdJbUY1N1o5ekZoNjN2YkFj?=
 =?utf-8?B?MEtRbjQwek14ZGo0a291Zkxtb2hRRnE5RnFFWmJtUzZmdWEzOWVHN0RQVFNs?=
 =?utf-8?B?d3NzMWtqbVlaODk5bG5Ra3pFZW5LSUNtV3Exd2pSd0JteDgydFR5S2JaSFV6?=
 =?utf-8?B?TkZVU2o5bEpQZ0ZheDlMc20vS1d5RUhlUEFaR0c4V0p3dTZHZ2phREdJMllU?=
 =?utf-8?B?aVhtNDA1RE9GUEppVzZNWTllZGFJeENGRlZFdVozbkxLcHF2cnVwbVRFYmYy?=
 =?utf-8?B?U3VZeFJZWWh4SUtOcm5MTCtBYlh2MGRwR2pnRi9oN1RUcFI0LzhVaEhpaXp0?=
 =?utf-8?B?aEt6WFgrKzMxQmZGanZ3ZE1GTjdoanZmQlBRZWxPRVliMndBV0hnZ1ozN25G?=
 =?utf-8?B?VGFYY0dtbFpkTlZTRjFsdFBocVkyY29RaFBZTm9WdzkrM2x0Y0tDMmVGYXNQ?=
 =?utf-8?B?UlovNEx6QUZ6Y3o4RmN2QjNYTWdDbVRaUGl0RUJzUEEwRkZyaFlvTkh3cnRG?=
 =?utf-8?B?NkxWZ1BGZEw2a0Q4eUxRWlZGNHNkM2dlbncvemw0Q1dFZTF2d3FEVzBadkha?=
 =?utf-8?B?cnc4TWMydEh2VFJXYnRRVmI1eEpLQ3pFTjBJNEQvbUZ1Y0h6RjJBQW1uQUFW?=
 =?utf-8?B?cmxhRUhRLzl2a3gwU0tMeXNmVStVQVlybTBQWDZVQXpXZXY2QkU1WWE2Z0NT?=
 =?utf-8?B?L29GTmlPbkVFOTFWdFJiK2FySVRVWWt1Y1hPTHlnUExPdWlZN1ozalV4N05i?=
 =?utf-8?B?RFFHTlJQNEtqOFk5U1NLVFJsRVE1YjFFWjk5bmtNNk9jNTc3UjE3bDF4ZHIx?=
 =?utf-8?B?QnJ5RWVHd1JqSUFtNnZ0ZDBxTGp1dGZJVU5lTSsxZ3duMTVEY0srZ1U1bDFj?=
 =?utf-8?B?ZWJZZk1DY1BCS1dJM0J0UmZkM210Z3ZtNGxOMUp1WU9ndWhpQUt4VEE1aUJh?=
 =?utf-8?B?c090d1A1c05QWk5HYVJ1RHArS3Ntak1UR2g3N2hZdlZLSUhsK3loSTFZTFdP?=
 =?utf-8?B?emVYL1I0ZEJVRkFqTUZQL1JQcGNSdnFnSEtzSTdJYlczcHliNXFzMFkraGs3?=
 =?utf-8?B?MEZ1c25nSG51ZmptL2JhbGZNTGhhdmd4ZFBTMFhOaVJNS2JqeUFUL3NyQ3Mw?=
 =?utf-8?B?VFREN1k5MUM1MzAxOTNLS3EyY0lKL3ZTSnVFaUUvdUE3VEE0TGNkMWdkNzIy?=
 =?utf-8?B?dzNpVkk0aTBtMnVjNlpya2MrQzJsMW1kUGl0STBnTnpzTGxrenlOYkhYcHVO?=
 =?utf-8?B?NmV3bFlDeWVzQ2dGVlJkdGcwODE3U2g5VTJubVptbldaWTVEYmduc3BXcDQ0?=
 =?utf-8?B?dXU5dTNEckk3SHgwK1ROUVIvWUdtSEd0RzJ0RWY1VG5kMTFWSG9kdjRvbElW?=
 =?utf-8?B?SGplSWtCZzAzbUlncE1yNklkSFNPSmk0a3FwNXVSeXVodnc2Tjk1UlFzYm5m?=
 =?utf-8?B?L0RiaXJuTWtQby9GczEzbmxFeUZMYjNHWHliUzB5U0ZWQ1B1SnZGVjlYVzBs?=
 =?utf-8?B?amJSTFBnd2hQVi9Va2ladk1qeVNFSHo1WDdSY2xkYVRPYkFtaXUrQ2RPMUE5?=
 =?utf-8?B?ZTRRRXJON3lNNSt4Y0Ziays0QVpqSDVMMll2K3pmSjMyVXI4OEIzV1ZkL0V0?=
 =?utf-8?B?dUltQWdRZWhnbFZnMFlJVnQ5K3gxdlducmFicXdjYUo2M2gzZS9MZEttdWRP?=
 =?utf-8?B?cXU4QmRpV3pJOEloOFJpdkVhN0d0Uzh6SHAxMHg1NWJlUVF1V1gzdWZET2RQ?=
 =?utf-8?B?TjlZdEJmazZFV1VqcGNzSHRPOERhUTJsWU1BZ05zODdwV3JCeGJmWitRZVlW?=
 =?utf-8?B?WS94OVpVNWJ0Zi8zTzJEWFM4aHBDS2toNWV1aFAxUTVqMGx5L0RsUjJ1L21v?=
 =?utf-8?B?cEpoaFIrK3RLRmV4WFZpNjNaZjQycXl1VGFjOVdtTkFCRXRBM1dCalM4UDRv?=
 =?utf-8?B?SVFQSTlLNEFBYVFVSVRYTGV2R3drSlRkVFVNVys0QkY0bEc2QXQ2L1pZdU5y?=
 =?utf-8?B?dVdDYURUVjRaeTNwaDZiUlY2ejRqS2d3eFh0bEtnRGRxb05Fclh4MlhNSjJG?=
 =?utf-8?B?QStCTzFpaEZpdEtNTnVMZXBLY0c3RGFyWnZlVUFpVEh5emtaOUNvMVp5dFc3?=
 =?utf-8?Q?HXSs=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d55355-0fac-4fc7-1cc8-08de332c0819
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 11:55:34.3465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfuQrNEZsNKIiWnOod8cMf5Qh27gIt7cf79DooLfJXaB1NuMef7q+g/mm4fzDb/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6653
X-Proofpoint-ORIG-GUID: nryzYewSHUhmXu1jqJ9-Rg6i-IPZoWQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA5NyBTYWx0ZWRfX06wJgdfZp163
 0aty6+tDv2oYiHiNM9OO8z3+8fqYnamvrL7cmuj4tEqhhnJlkcHLCpK7V0ERKyCfzYQbAEvGMkK
 sSpd+8RlTqckOFaJkn4+0ZzKd7KILIP/nDoVdWSg7tgnyk1igVGHBTQqdbYh7tKW3We5DS75Rrr
 lbTL9divfYGln/96DbaDx9zqhmgfZmIxEVuVvQVY+zr9267kE2d1suvL3oa81kpVZ/6sgXyaiGa
 5xREyDIu8wdBtm/sbPf1EFNu2cVxLQDclPeXC5a37Yc62W1azl6tWlCklLiUxcy8xv9kRYKhI7w
 JtSKYd6PbpBAWphw0zFAjqmsyclzxPAdsTFfk8eh86d0V6ZTWFizzQBamKn1nu1uZijjzUldB7l
 iZoesXkmv1JMTh+YajLAazMpACrQhA==
X-Proofpoint-GUID: nryzYewSHUhmXu1jqJ9-Rg6i-IPZoWQq
X-Authority-Analysis: v=2.4 cv=S7HUAYsP c=1 sm=1 tr=0 ts=693176b9 cx=c_pps
 a=lV9semjb6HF4qJ8WeHToSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9R54UkLUAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=ppgvm6j9Fb_uLWULpUMA:9 a=QEXdDO2ut3YA:10
 a=5hNPEnYuNAgA:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-03_02,2025-10-01_01

On 12/4/25 2:16 AM, Michael S. Tsirkin wrote:
> On Wed, Dec 03, 2025 at 08:02:48AM -0800, Chris Mason wrote:
>> On Wed, 3 Dec 2025 08:33:53 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Tue, Dec 02, 2025 at 03:55:39PM +0000, Simon Horman wrote:
>>>> On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
>>>>
>>>> ...
>>>>
>>>>> @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>>>>>  		mask->tos = l3_mask->tos;
>>>>>  		key->tos = l3_val->tos;
>>>>>  	}
>>>>> +
>>>>> +	if (l3_mask->proto) {
>>>>> +		mask->protocol = l3_mask->proto;
>>>>> +		key->protocol = l3_val->proto;
>>>>> +	}
>>>>>  }
>>>>
>>>> Hi Daniel,
>>>>
>>>> Claude Code with review-prompts flags an issue here,
>>>> which I can't convince myself is not the case.
>>>>
>>>> If parse_ip4() is called for a IP_USER_FLOW, which use ethtool_usrip4_spec,
>>>> as does this function, then all is well.
>>>>
>>>> However, it seems that it may also be called for TCP_V4_FLOW and UDP_V4_FLOW
>>>> flows, in which case accessing .proto will overrun the mask and key which
>>>> are actually struct ethtool_tcpip4_spec.
>>>>
>>>> https://urldefense.com/v3/__https://netdev-ai.bots.linux.dev/ai-review.html?id=51d97b85-5ca3-4cb8-a96a-0d6eab5e7196*patch-10__;Iw!!Bt8RZUm9aw!-hmp4LVEUFF9PPsb1Xhn4ei_DZKbN0luNnoYXWu--dXsNFJUD88TQ4dsL9yTha8Rwi5C$ 
>>>
>>>
>>> Oh I didn't know about this one. Is there any data on how does it work?
>>> Which model/prompt/etc?
>>
>> I'm not actually sure if the netdev usage is written up somewhere?
>>
>> The automation is running claude, but (hopefully) there's nothing specific to
>> claude in the prompts, it's just what I've been developing against.
>>
>> The prompts are:
>>
>> https://github.com/masoncl/review-prompts 
>>
>> Jakub also wired up semcode indexing, which isn't required but does
>> make it easier for claude to find code:
>>
>> https://github.com/facebookexperimental/semcode 
>>
>> I'm still working on docs and easy setup for semcode and the review prompts,
>> but please feel free to send questions.
>>
>> -chris
> 
> Thanks, interesting! And the bot at [ url that meta email mangled, sorry ]
> what does it review?  how do I find it's review of specific patches?

Jakub has it setup to pull the series from patchwork, so you can look
for "AI review found issues" there:

https://patchwork.kernel.org/project/netdevbpf/patch/20251126193539.7791-12-danielj@nvidia.com/

As far as I know, he's running all the netdev patches on patchwork
through it.

If your goal is to quickly see a bunch of the reviews,
BPF is using github CI with the same prompts:

https://github.com/kernel-patches/bpf/actions/workflows/ai-code-review.yml

And those reviews go right to the mailing list (with all the tradeoffs
that brings).  I'm not suggesting netdev should do the same, but lore
can give you the output:

https://lore.kernel.org/bpf/?q=AI+reviewed+your+patch.+Please+fix+the+bug+or+email+reply+why+it%27s+not+a+bug.

-chris


