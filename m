Return-Path: <netdev+bounces-249727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E0D1CBB2
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 398F5303DD2E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68157343D7B;
	Wed, 14 Jan 2026 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0jTaUUp"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70036C0BE
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373421; cv=fail; b=dEQj1zOMGH40nzKNyb6FO+zMnkAsn94SubgpAxcf3lfaMTEaiiSEuBHM6D0siy+XPvRQ8TboCjXSyl3BtcKaouH1RgxYc84XVKuvdwHDQAMFaEJbFde1lKkkAZ3+UDyT05akz0SxZMSoAgg+MtJLSKKwVKt3rSGh7jP4I2nEW4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373421; c=relaxed/simple;
	bh=yrny40VEHJCTA81oRJhYVQFnaAKiymnYM+e2ZHRYaKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rzQIJeECuTizox8oEzMLz944a65LrT39XnzLEd1lD9ox8is/zOENNxv9QmEkESKzAZj9ckQph30CFkyS0J6iILyxt/HtvgAaOjH7Tx/bDSBmofE0dqiTrlYu2I+4yreTj84Y1vIbCZ74yrJ+uTdxaCwl3nQAZmsawlFWfPFKTUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0jTaUUp; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mg4IeHK+WmWWdeDCIgoALLWlYMh5/XWGvLK6Rp89OcwHs3Nz2GtYO900G2aX2BSLJyt6vjd8WI+/fGQ+OyOSPsZdp+tg4kmbdGnhrkBp3/fxBR+fk/Q0qHh8budpQ1ZoePZswt1ousN0OGPVG6F9x91lT+73VxYG0lm3yZrY1g9dmsyupefKVIJPlFa4ABuPOTsDiN2Uk/nJ2RJW0NiGRu159t5GIKlbZSVZH3FlVcASWQtb8Y9OzoX2pfheitwGS3wcxyrabTzk3yZyYDaXldIY0kEp2JvvXs4Ibw89WRe8NScoNL6vqbzjck7s+dvnHCe7mf7DSNhSMIpoIqpvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N+0jQgnU8T9VNwWnwmVwYcBMD2LRmXKGkYmNrwmIYk=;
 b=xKFP7Wi1UFOhJD8f7QRVvKqLfsvJ+HzAmr6OIx5rbFe9jG1ewHIoUdwM1JdQNSIymeww0I04LYswUAlq+l3MXNLxcoG7RJUWeCykS+LtgCoIcONMgsqU8/bz8CEqQzsiyAGxVxlRRWHsJPIsv0xCPOtgz9b1NXfre4uMtk04p82kBXfT9SLMnpOU0/m8D5/PdTfOic1A5ayErK+rR4nNOXcODyiG6jI91m8jJtQ9XeGgX06mAQlQQ4jmpHG96iF7Q1cGX8WjpLfSh7SFO0dDPvUlOzFx4EFSqEGCS0UdrKIb0jadPhWqceT6wbwRJtmT2+8oD27b5n+8G5QCUsYOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N+0jQgnU8T9VNwWnwmVwYcBMD2LRmXKGkYmNrwmIYk=;
 b=c0jTaUUp4DYE0Rfvq8Hygtwi6GjsSarooKYJrlWnIM3NhD+FLhlsnouUdshX4urVsBVnYs8UwPlKZM1W1JtLBTTH9DPx1VWKKOEnqV5GYolCwwC206GwfD3Gu3ThQ46u8Ha/BSaIZxAR8O6JKiSktVvmEa+ZvJ8OI8Io2F3bQUIIIjwkvNnc0nAXadl00n6JzpuR4Xjq8CdRWk91O8uDCggeqTFShOSkO1f70lFAy6mhTUBP8C6M34KrXEpp0IaH0okdGmpdc51Rsk3CEcwBwkC3GsKhJMd1r3iJ5jGN/tixN/CFQ/PnFLzj1bm4vjcIIl6uJvYFuQY3YIymCQga/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 06:50:06 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 06:50:06 +0000
Message-ID: <e4f56293-34f4-4f1f-a3a2-456c46f25071@nvidia.com>
Date: Wed, 14 Jan 2026 08:50:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ethtool: Clarify len/n_stats fields in/out
 semantics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260112115708.244752-1-gal@nvidia.com>
 <20260113190652.121a12a6@kernel.org>
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20260113190652.121a12a6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c45f6b9-a318-457f-fafc-08de533926b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YldhQ2dkVy9aRzFlN2IxUjhleW1udlNuQUZWNE9PWVkyUmxaOGlFWEFPQTB0?=
 =?utf-8?B?dDFydGQwN2Ruc2tDb3o5TjcxUlVGQWRLZ2ZRN2M5T1gwV0NJdFQxdXgyQjk0?=
 =?utf-8?B?N3FKTXNxamVTa2FNYzNzVW9Bd1dVRkIvRUJpU09FbEtzVlhLamNPSXBHY1Aw?=
 =?utf-8?B?VEM1cnd5aEd1RzA1cjVvbWpNcUFUMU9UY0lza2Z3YU1sUGIxWm1NZk5jRE1K?=
 =?utf-8?B?NTJId3dOZUpqakpBamFFNVVGNVB6cjdlQXowazNURzhjdlBseVBQT29UN0s2?=
 =?utf-8?B?MU0rNm1YN204MzRHNzNuQ2hPcTBzdENqTmcvZ0tTZXUveW5lR1RkdE5IV2lI?=
 =?utf-8?B?NDJuSnpOeEZFejFtejBaWVFDWmh2NjFBeDBZN3RPbGV0K1llWE1qbDlMU0RQ?=
 =?utf-8?B?ZWlvYmFWQ3pOaThhK1JnaUo1aTZxVldNblEzQ1ZiWS9ZanNlT0xBOFJVeFlM?=
 =?utf-8?B?bVRROEtmRDFVNGRGQmIvRFlzS0VwWUlMRU8zTGsvaVBMVHhma2ZUS3pKQXRt?=
 =?utf-8?B?cFpNUStaS3pBZ1lueXZSZXpydVZ3K2ROT3NTL3c4em5rK3dMOXBLV0J1VjB0?=
 =?utf-8?B?My9XODdkTEdvbXFqWlh2UFl5alB5Z2ZURm1JM3ArUjRmK2NndTNBek8vTDFQ?=
 =?utf-8?B?TG1KZkJQaEJEQVNVaHRuVEtteUJSejR5ZytPamZYc05vdGlVak9pVlRpQUZF?=
 =?utf-8?B?VnR6SjhNSkk5QVhrcHI0KzNYT1RhbUlyODhURkpsRFd2ZldxYk8weUs1bFBk?=
 =?utf-8?B?bE12U0djb0xLOEFQTnRIeXo5THhmcGNINUtkdDlNMUE1bS9qOE4rTWk4WGRi?=
 =?utf-8?B?dW1oL1owN3ZsR2lTTW9teVRBeXhOdUxYWE5nYWExeE9EdWQ2K3UrWkQ0Q0J1?=
 =?utf-8?B?UHp2Q1RjRkx5dVNWT1BBTmNCd3ozc2d2ckQxY0NKRjVFZm9hcldBSkpaelVu?=
 =?utf-8?B?SHVrUjRpVnhDaXAwUy9IWlVtdkJYN3ZNYU1CVWJxVG1uUk5yYitXNEtJekVX?=
 =?utf-8?B?R0lIWk9hZWdSNlJETDI1dkx0QUpqTGlRcDdtOHpVcVUrL3owRjNDdHhycEtx?=
 =?utf-8?B?MnlrVUN6dGJiMVRzbjRLRUhjVG1mbEdWNmxnaHZaRjY5Y1FJYmZGZWZNc1gz?=
 =?utf-8?B?dm1MMDduSFZweXhaSmtkYWtOWmtWR084YXpGUEp5NmdXY1dhdlkyRCs2akVJ?=
 =?utf-8?B?eVhtcmJxNk1sSVk2SFdSdTFPM3hia2dVMHkybVhtcTFiV3Z4WlBkVUJINVdZ?=
 =?utf-8?B?aXUvOTQwdVNNRkN1TXJLakMvVThSL3kvaEx1SmVlRzVCS0JQTUJtejRnWXNQ?=
 =?utf-8?B?a3IzUWtFZUxvQTY5K25VUjBIN3crUHdHNWkzM0xDYWdGWHVaY2hIWktZVENG?=
 =?utf-8?B?UWJKM1pmeERYbDdhUm0xYzBVMjZ2OGc4NjJkUUF0VDBjcVIxZUV5QzM4Y0JS?=
 =?utf-8?B?VnluK2dHb0lFazUxUm53RjJpN055SnlMWTBRNlMza2J1Wm9GNjNMemFMZjVz?=
 =?utf-8?B?Z0ZQVkdTSFR4Wk1sbUJsTGorcnQyUlArMUZaRzBmcWRySTJYemVCdmRvSVBY?=
 =?utf-8?B?UXpNRTZGNjVjZnUyYy9BUkNrWU9LMjZQN0c1OHRmbU1VTVQzamFwUGJFWEMv?=
 =?utf-8?B?eGw4aGNhV0pHVnBzdEV2TnBFVWo1RUhUYVloUzl0eGw0b0toRHJ6emI2VWFm?=
 =?utf-8?B?dXQ4SW41QWtmUE5yT3RnMzU0V3FtODVlQ3FQQ01OQ2pod2M1aFdCQzNzU2VZ?=
 =?utf-8?B?d0FuQ25mdlAwWkhnTmZkbno4eUNVb1NqUEFVQXpnSEM0T2d0Q201cGwvUDBP?=
 =?utf-8?B?eGg2cVR3K1FrbDlMOGwvSGd5OGVESVJHcHJPdERSUzVId2tqTjBvcXc0b0ds?=
 =?utf-8?B?dVJCbkJxZng1cWFUejlnTXNiREEwL0JzZVNDOXozWVZDZzZ4WGVRclhRNVpB?=
 =?utf-8?Q?eK1kdy9EJYTBFfEr8Xzg0lBX9aLZF6lO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHF0YjlSWGsyeUFwSFA0bmEzYXUrTjdKbGNNbDJrS3F0WjFsTlhZdllzRVQ5?=
 =?utf-8?B?L1E4RmhkUnk5eTlwc0J6ekwxbDlIS1VpSFBFWTI1Y1dKNFcrUUVydEVWN1k0?=
 =?utf-8?B?dmlMZFFaR2YyTXliQ0hUMTVVc2ZvaDdlaTVlRzRLRUpVOGxqUnN5Yk5nZndK?=
 =?utf-8?B?SmRIOXNKQnovVjQwbnNHNVZWdTVWMUtTNzlCNlMwVmtFc0RSSUdlQ2RERGFS?=
 =?utf-8?B?dmlIUm81elk2djIrbG0xbktCK2ZTVHM1Qno3clplNFc5SkQ3cWwwV1lwbWoz?=
 =?utf-8?B?R2w1a1cwTnFwdjlFUW9KSWVpR3FMTUpXM28wV0RCSDVrU3ZMTU41ZU13SXZC?=
 =?utf-8?B?OTdrYVY4Y05pWm5tdTdrK2JEOXJobEtLRFN5eXZ6NG1ZdHFJaVB4b2l1aCsz?=
 =?utf-8?B?b2ZyK3JpSjNVeHpFanpIMnlOZy9BOEV1NFA1a01ReDFKRWNuaHhTdDJkaUxq?=
 =?utf-8?B?QTNyUC9SMEh3NDBvc0Q4T0NNbXVsK1RqZVVHR2FJUUEwc3FKY3EyLzZSbTdS?=
 =?utf-8?B?amQ3amErRFJlSHRJVDhzaWtWRDgxMXB5ZmxESTdRSkRBdFV5dUlpTDExSmsy?=
 =?utf-8?B?RUU3OFN1ZWhYVkdzcFlFT3lycGczYnd4OUlELzR5RXlBekgvYWJXWGRSbmpV?=
 =?utf-8?B?c3I5WUpvNUliRU5BTkJIMlY3c1gzN1g5ZkVwS3hDemtIblROdzlGRzFob1ZT?=
 =?utf-8?B?RjJCU3VtYnR5ZFkrUEMxYzN1VXFmSDRob1p0OGJhQXMrMldoRWNrSkx1dlly?=
 =?utf-8?B?aEVFN1lKQllIT0ErL3pHOFY0K3U4Q2YwYThFY3RiZHdXcEROU05odDBTSklj?=
 =?utf-8?B?NXREVWZwQmFQWS9aVWNrZTdqdGoyd2F2YjN5T0NSdlVSWHBiYUpsNmpGUWZK?=
 =?utf-8?B?UVpSaDRWY0ZsNi9jM0pBeU1sV2czOCtkcVJGR0xrcmVFWVNSUnZvT3AxMDA0?=
 =?utf-8?B?TndkWjVycyt3SW1XM3BEaE9iL3FybTYrM1FoQVBhN1FxWFA0NU8xbW9jM0w3?=
 =?utf-8?B?NEhSaUgzekJWWnNQdHZ3VVA2SGJKWCtheGVSYWVuSGJMVDd3d0FodC94U3VT?=
 =?utf-8?B?dEdWblplSDg4dUwxWEVpVUx4WG1BZjNoOEJZZDc3WW9VVFJPYUhYWnN5RThG?=
 =?utf-8?B?NnhFSzlqRHpESzZsQ2laMmt0RU1uZFJVTkVGZ2t6OTZSeDZNTmdobXloVnJz?=
 =?utf-8?B?azlacUhUaUczOEFqUzhuSmowcEhCNjJ5MkJObU1KK0t4c3hiTWNwWUdrckJD?=
 =?utf-8?B?WjZJcUFpSUJOZXBzWnRFRUdaN3RENVM4N29qVjlhbkFkcUZUMUMya3pEcjR2?=
 =?utf-8?B?bm1NS3BpR29BZkJrWmF2QmNtZTY0bGE0NlRyVGt3NjlYRG53TjAvS2wvVlBE?=
 =?utf-8?B?d1VzOUxNWVZWOEtRcFN0SldxaENvalQySTdPd1kwOGczbTZ5eEdkMlRrM3JP?=
 =?utf-8?B?SEtmQUtUbG0xbGNQMWFYbnlHeWhkRGdGRHJsc3N1QWpmcW9yRCtsUnZZRnA0?=
 =?utf-8?B?bXh6czNLeWxLdzQ0QnJJdG16WXE2SWI3QThiSm9GNDhuTHhNL3A0L3JGaTdE?=
 =?utf-8?B?dkViR0swVVMxT2traXQrMG5HVDRGeGFjclIvTkREUWVCbU5JMnBqNlhlSXJj?=
 =?utf-8?B?SG1QMTY5cWhCWVdMTW1SQm9MTHBiVHZ4UWNoUmxzekQ2VC9yNE1PMVIvUFha?=
 =?utf-8?B?cDJEa0V0czZaZ3pnNkFkQXpjbVNOcThGbWZ5TTF2UGQvNG1HOW5oVWFUK1RD?=
 =?utf-8?B?VDZaSFA4bURWZ0czbzVrcGRtNVJMdXU5ZElkaFRGZmdUeU9ra1NaRFdTc0dq?=
 =?utf-8?B?RTFPelRVakNwT1pTT09DS0JDZDZCNnF6ZHkrY1JjYkxLNkZNUUhkMFpOMnJs?=
 =?utf-8?B?UEh0M1NEYlEweHJZMUxCeVFnaXh2a2V1UjNQSjZ3RlhiUDBRaS9qSGxwSTYy?=
 =?utf-8?B?ZVpidVpFakFjUTB0K1pqUzFobzhSQks0V3h4UVkvUW5VR2NoN3djMWIrZ0Fr?=
 =?utf-8?B?eENSN2xscXRpWUFGMWtjTWNEeExlSnJSTGRmQWpOMVl1L2pEQmFZM3J4T0dR?=
 =?utf-8?B?NGxZeUNmbDFvSGFiYjlEOG1DZ1ZkeThMMVZFNUp3ZVBjVHBHcFNqWjlZNllL?=
 =?utf-8?B?YnVHT2gycXNNZXM2YWI2WDN3U0xLY3p6YnFjNEFaelZyeE51MVU2YkxjUDNa?=
 =?utf-8?B?VUNVemxNWGJMejhIN29NM05oemcyeEo4ckpYK0ZyRWtHekwzWVVNcmJGemJw?=
 =?utf-8?B?RGVoTWY4cExuMnVCcWxpOUVHMDNUUzkrMzE5NTVxZndLT0dWK05sdndMOVE4?=
 =?utf-8?Q?NzRycZnWBg7/MjrPw9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c45f6b9-a318-457f-fafc-08de533926b8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 06:50:06.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEm4JbqsCqmfEBJ5UxMDqnErcLYl3TFFmJFK5dPiDe56CW44UztycYHM4cO4ML4w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098

On 14/01/2026 5:06, Jakub Kicinski wrote:
> On Mon, 12 Jan 2026 13:57:08 +0200 Gal Pressman wrote:
>> --- a/include/uapi/linux/ethtool.h
>> +++ b/include/uapi/linux/ethtool.h
>> @@ -1101,6 +1101,13 @@ enum ethtool_module_fw_flash_status {
>>   * Users must use %ETHTOOL_GSSET_INFO to find the number of strings in
>>   * the string set.  They must allocate a buffer of the appropriate
>>   * size immediately following this structure.
>> + *
>> + * Setting @len on input is optional (though preferred), but must be zeroed
>> + * otherwise.
>> + * When set, @len will return the requested count if it matches the actual
>> + * count; otherwise, it will be zero.
>> + * This prevents issues when the number of strings is different than the
>> + * userspace allocation.
> 
> Thanks the new text looks good, but we should also remove the 
> "On return, the " from the field kdoc?

I think it makes sense to keep.

The new text clarifies the in behavior, but the out behavior remains.

