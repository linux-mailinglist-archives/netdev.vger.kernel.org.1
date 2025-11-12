Return-Path: <netdev+bounces-237803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26034C50628
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 04:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E719318861C9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE16C223339;
	Wed, 12 Nov 2025 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P3+0k3uA"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C551494DB
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762916526; cv=fail; b=Skh7czBU0HvMUA8IyCztRwy1t9twHcB2p4uJ6THQyx/i83A0dumA96Vhvl7ZKXOeZF/3h9vbWkT+STTk6MjNVot8Zn990kep6pHZefSsfOrhEH7dJgnEKdCxbkh9KwWFd6/PyT0wFQgaDQPwlM80/R1I0rD3hx9qXSErje2n52Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762916526; c=relaxed/simple;
	bh=KJNS7upXb578t1WcCwZrVQ60yI0GW35VRyw9p0qiwJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BZYOapUjkX8lVxuVjbxRRzCeTnlxkMn0s4a1Zd7ug0ANBmEkr6KGKca99AgZr9rokTBAw8kL0/gz7moMutsYaen92kkS7WP4oqhVgGc1GNp/RdqQjvhRBqI6BEOskcC/JlG5gUFNojcdK1nfZ0uqgNRx4smDdlraRbcyFKm6Y1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P3+0k3uA; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4w/mdlCQuP/9XS+zxpgji7W96zJepevoAFdzL8tkb74bqkrdpjAShpk4C8oj7+Mtgts6VoICyKfFC0QXZCWKh9RpyQO+uUlUUUMXNC68us8GXcXPoKm0u6R0+ch9RcxvRzojfEzEdwYrvUD34fO+znE9amkXsYs5pGdXDI4x93nJfEqiZRbPzM7poykE6s9RDmIXDS6TUe3Be33DUsFz2DD273OLBcKfikw4lB4+p43vn1x/E+kFpVc9DmYjFMgezZIXVb+LQGwOLHkTOQb7M3c7GouVPdlpPH2VaiMAxLnnW5chzZeO+lR+mxsL6p3rNHm1O6g1zR0VUdgM+7NDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpXNEJ9qCe95wjRP/do6xYQLdvmV5/qZt8X/RdZIYi4=;
 b=bY0kum+ao9ycWuScbytCVvg9PlkCSgIlJWW7GmsGeJTuQZMJGScb23C3aPec/NI6OGEqOT1aA/1rmfKm7SIlrKj3q7KiAlD5zpuhCRMOHh53By2HVB8IgVvSaIOVEfi0PV0v01nWTq1Lfv6zSLNIUwKkdTPGxqVmsgHjmYETglbfE3OIwhoTIllSRb5BlQdXiGVddVLcM52M6fkE3zmpDq9MMpBtY3uFBGHptfrI+NSRscG400ttmpK4MI67pXJsRm5KH6A2GOJh/mb5IqflTe633ZU73IbETlDhJFs8/mF2g1KCDXinNpFY1Q8fQT64FaCje2p4/Co7nP65FsRp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpXNEJ9qCe95wjRP/do6xYQLdvmV5/qZt8X/RdZIYi4=;
 b=P3+0k3uAqBsJ61r+I64qnm7vjg6A0RE2I4HX6cYyhSZ2egr6/K0TqNn5Gr9s/dYp7o/iICKwqiG1BH1/4ruPMMpc3eJD/ltRltd/g//WWQMOjcOCLNi93hEdB51ZHQbYuNsU4nt/paA0zvpxG2DpnLLhEr8Uj2Ip2BLbdApACpVqsTG/IWjA8Nb+21rkCCzyOGzhH4LbyoDYYmYny+hhQZgfRtXMEhNc/OhpPHkQz57s4B2BGf/3kHuxs/pkloflKsZVyC+hkCB++prUPdzasKct032+/txRERvx91XSFQYWqu6WtZjV9JLFeRllXUg8mrlz3/MObZrs59wSVlYbVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 12 Nov
 2025 03:02:01 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 03:02:01 +0000
Message-ID: <443232ac-2e4f-4893-a956-cf9185bc3ac1@nvidia.com>
Date: Tue, 11 Nov 2025 21:01:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter
 caps
To: Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, virtualization@lists.linux.dev,
 parav@nvidia.com, shshitrit@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251107041523.1928-1-danielj@nvidia.com>
 <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
 <CACGkMEt2SEWY-hUKv2=PwLZr+NNGSobr4i-XQ_qDtGk+tNw8Gw@mail.gmail.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <CACGkMEt2SEWY-hUKv2=PwLZr+NNGSobr4i-XQ_qDtGk+tNw8Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0109.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::11) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: f29e13c5-1e9c-4f9e-65e1-08de2197d967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dll1Y0JHK0RacTFpZWZRR1NBanJnaDFuVENyRWNDOTdKVnVpcE4zZ3o4WHky?=
 =?utf-8?B?WUk5eUJPL2poUENlTnhPdFdGUUtYdTJXOVllc2lDRGhFTnBrc3RYdFhqMDFw?=
 =?utf-8?B?dGpyNTBvcUpEYjNGRHVEQ2dldkRsMWtoRVY2a3dzZkpmQzlvbStRN0QxMWpj?=
 =?utf-8?B?OWREbHQ1dFZDRFZKTmJnSUNTbDFJMWZSdlZrWTd2TTFDS0ZjelZhOG11QUtO?=
 =?utf-8?B?TE9DMjhrSTdaYkJER0d5Y21vMUl3TGR3dS9kQ2N1TTdEK3djY1JyeGVZdkV0?=
 =?utf-8?B?RVNWTUdOb3MzMEFSV3ByUnl4eVIxbG52SnFVQjZqbk40VVFGTkFpd21OVnd2?=
 =?utf-8?B?VWlWQ3JZdGdOK0V2bGo5TnRTb2pxbU85aTJYK3dXMEQyZFNQdkpHQ3doRjl5?=
 =?utf-8?B?WExsa00wbHlDSnlLL0xMTitBZFUwRzdFb0VrS3k5NzFWL0FSckZFRkU4VHFV?=
 =?utf-8?B?Tjc0VktXeTNGZGdzdWJNVHBROEdXSHh0NExPQ1VrMGxJTnJKN1piYU1ZSEMy?=
 =?utf-8?B?YUZnSGtPZ3M1VmNyYmVQa1pYU29hSHlhSGNjbVplcGRDMUJHMDgwRFU3elhN?=
 =?utf-8?B?N051M1RYK25BeSs3MWZRVXJQZlIrOW14aWJ2bFdNYjlINlA0TDhsdXpEcysz?=
 =?utf-8?B?RytvYXJ3bU4yL2w1bUJPMEdaZVRlQUZ0bFVQRlF6blg0NDNBOWs2TGdQNS9i?=
 =?utf-8?B?R0dKNUtPUlFvdVdOdmVzUGNreWsvbGRMb0o0VVQ0akUvTmJqNEFNMmtnbTJy?=
 =?utf-8?B?OGVEZ3U1WmIxOU5ucG5POXIrUjR5N1B2RUEyWDJiWEhpU2xWMFNlQWEzL1V4?=
 =?utf-8?B?S28rV25MaHk0MTFwYmJOT0ZZWU5Hb1p6bjdQcFlzcGY1VmVYOSs0OEFGTUZI?=
 =?utf-8?B?ay9JN09ENlBtTGlZSWtxaVlDQzVGTmcwM1czZVAyaXRGZUJCd1N6aWVxTjY1?=
 =?utf-8?B?dE1ZcXBpbWpGQVd4R3Z5aytXT3ZCbE41R0EzUCs2VEdjTFhPUzNIYnQvaWx1?=
 =?utf-8?B?d3BBMXBtaSt5Ulh3anZvcnYwMExrN0xBVUNpdjB2RFhWMkp0VGEwNnlwd0Rn?=
 =?utf-8?B?SEViVlRDUU1rc2pkN3F0c0IrcjQ3MERpYThQQnNWZVphTVJRT1pTSDhGcisv?=
 =?utf-8?B?WUEyME84c1g4bjJkNVU5Q0RHS2dlMG0rWkxlRU1kZ250c01YR0pqbms3NHFq?=
 =?utf-8?B?aE1PSnFsVVZoQnAweVMzR2FqeU9MNy9zSTZaeHBUc0YrcU5XOVN5cllCWndU?=
 =?utf-8?B?NHpEdDcraFMzVXhwY2hDbnBJcEJITkN0anJoZjBCNG9uV2FGKzY3VVVwOU9O?=
 =?utf-8?B?VGYyUU80aFBKaXN4aEFKV3Z6c3YrZGRwdC9jMnpVWjFrSVcvZS9MeEpKT2RZ?=
 =?utf-8?B?c2xNOUdqaURQUjlpSlowOUFSYTgxVUZyREVCVGtFMTJnWUZnRU9WOERqOUo4?=
 =?utf-8?B?ZFhSYlYxdjE5aERPNFEwQ1pROUpwd3h5SjNuWTRnRzYwSzVBNkZLTDB3Q1Ba?=
 =?utf-8?B?WWM0TTdzaXVoYkpyOERuYlA2QU1UMW5FYTVKbE9ybnAzWi9PYytkWlh1YWk5?=
 =?utf-8?B?SzU2dVZrMmN1eGNiMkVFM21rd2Z2SEhtemorcE5VWElJQ0kvZmZpQk4weUFs?=
 =?utf-8?B?UTNZTEVrSjVMUTVubEtmQitlSDJnTFkwQVEzT3VseUFxaFNVUVAyYXlSZUxF?=
 =?utf-8?B?dm9WYThINnVieWZQYXcyY2hSYURzV0xzUmF2cmFiSmVYbTg3UVVYaE9FbEFF?=
 =?utf-8?B?N2Vxb2wxakxDUFhreTQxeHlrRlY1Y0p2NEFYVkJkRHozZlpVMnNKLzhNUnNW?=
 =?utf-8?B?WWdRU2RvRS9ocXpPWHVPSFpWMHVNQk44ZHRNU0RHekI2dEpTQ05xR0pNT1Ix?=
 =?utf-8?B?Umk4QmZjV1FqYWF1NTRlUmtHRTZ6eUV5c3ZzM0VCNW9sblliY2RXbUlwaFBM?=
 =?utf-8?Q?wKwUwHubPrIJBjWB0U2RUgwXOapZozcy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFVXZUw4YmRnYVFoRzNNRGd1VWhwaDJGNXl5Sm05WjRJTWppVWdycVR0Ukdj?=
 =?utf-8?B?OXBpeHlPVlpJRjZTY0V2V3F1TmdWWjVuVGFXUzl4L0M1VVB2K0RPOVZiMnF3?=
 =?utf-8?B?eVhWaDJOVzJhb0lWeHhVMUp5QTlQRnFpcW9Zdi90clVZTWNKSC9NQkdzZ3Q0?=
 =?utf-8?B?LzNPbExrYzVvM1FudDdCUWVpQS9Qa1BQTGh2VVhNVTkzMTVoaTVNWWxvbyt2?=
 =?utf-8?B?eFRhSUJFOEZyZlFNK0RuSUtKYzhjTVh2bTFHcjg4Mm9MT3ZPQ0hLeDc5UVkx?=
 =?utf-8?B?N3pDcG9BTjl5NmNoeTZuNi9JQWh2QVhmRVlROFFwWFhUYmJ0WjRPWnhiTERT?=
 =?utf-8?B?OUVRYkZNTzFSSVdrc05wV3NwUjB5M3dkQzdYcTJnUWpiSGxYczZyL0xYcWtv?=
 =?utf-8?B?OGdmMzdiNXVoYitXNU5nRmtaeHY1cU5QRmc2MDVId2k5azlXQVZMc0tuOHMx?=
 =?utf-8?B?YWRrMXo1TjdCYTY2VEk5a3E0dXVHTUNXZFZjYTk4MlN5YVV3WnFpbTNlRSsz?=
 =?utf-8?B?TUwvVkQ0NThNSzF0eUI4MUdzVWpsOTcrMzBlVklwY0xzOWJuMHI2NDR0cjNa?=
 =?utf-8?B?cmlMT2taTmJHQmM5bWNaa0NTYUVoYVlkUGpuWXpQYjhlc2x0aHZwWWhrS3F2?=
 =?utf-8?B?MGlDcnQ1UlgvR1AvL1lvTnk5QXNYWVVOdWVwWWcwWFdrbktvWmhhMnZZV2Uy?=
 =?utf-8?B?Yk94a2VnNTJqOGRUZ0QzVTJWY09CQm16YUVYcUI5TElpVmFScTkxNytuQVJp?=
 =?utf-8?B?TE9tcWxSVHZiNWpmMkhWd0hkTFhYQTNEYXB0VDZiWVEyQ3I4bkFDbjBJQ0V0?=
 =?utf-8?B?RjBzUFYvTW02VG1qeDY5UUp1MUtqSFZRaUtuYzgvZFZ0cFZNOU03VEMvWUxo?=
 =?utf-8?B?M3VvK091M0JxQzFFZ3VwREVMVGh2VnZYb01GblM2T3UzZFJLR0kvdkpGMUtt?=
 =?utf-8?B?TWRDdW5BdUNCNlNpRWsxMUpGMG15a3dybUVJaGZmejVjeFk5NHFpaVJiQ1B2?=
 =?utf-8?B?bGJDZDcwNjR2d2tmeHkzcWcwaEpIbElTOG9pYjRQcExTYU16QkJkZngvSnMw?=
 =?utf-8?B?ZkZVcDVKWWZNMENEa1I1TUNCL0NlTE1pTVg0cVJPMldsdGtuVEtRUVJUdks1?=
 =?utf-8?B?RHI0NllpZ1NHR2I5UXFtL1phUG5jT1JrbWZXRDRnMDZiNkhWTzhlVFBsbFpW?=
 =?utf-8?B?MTdqc25ORHZPZGV5K0c2ekhCSXZTVytxVzRNdVphdHlQRWx5NjlESmxvc3FS?=
 =?utf-8?B?cW9taFMyVkVGeWZZZmZqZUZxNElNbitGVURxVGxVTUxZdmdZM1lLNjdybXpv?=
 =?utf-8?B?cjF1c2p6TnI3RmFHbk9zMTVCZUFwS2tSRFppYnp2ZUNFaFp6NHBtYTZpUEZB?=
 =?utf-8?B?bnpYU3p2U012SmcrYkhEaEhoam5EUGU3V0FodVJPSWd4Zm1VWTFHZXBEM3hp?=
 =?utf-8?B?UlBTRVFGMlRmdGM2SUNnUE5lSzh2WXZidEQ0QmFHUkR3MVZ0YTdzV3FQZVV5?=
 =?utf-8?B?UDNwa2FoVmcwaC92Y3haUUN6M0J6RUZiTGZLVTlLWUJiOFg1clBtRlF3RHQ1?=
 =?utf-8?B?WDlKbHdLM2VESTR1Z08rOHQzNVdhVllFUkFHRGNjRGsxRzBHQ1JiL1JkbEVj?=
 =?utf-8?B?WW0vYjlzbGNKVGhTYlFqbVJRYmRZKzYyK1Z3RXc0eU9yVUkyRldLL3lxK3RR?=
 =?utf-8?B?aXhSRmprcG1KdHZnK1JsUHBMbUhWUlNaRkJpTjZFQ0E1ZU1UeHE3VzhNbG9G?=
 =?utf-8?B?d2FscXE4dkVSOVN5emJxbGFsVm8xeWkzNjdnaHBJYWtDMUdndTF2RWhLM05V?=
 =?utf-8?B?cHozMk9YdmJNZTBEZm12QXNsUWNkQThsZk5USEdpVGhxNVk1Szl3TGE5NUVI?=
 =?utf-8?B?aFFya1ZHYjh0ajRhZXVWOHhVdnpaOTczcndBT0VzMVZrYngwUkI0amxvUDQy?=
 =?utf-8?B?UUo2NDRmMnhHUE91M21wb2RhMTAyUDNQQmJta1dVYVg0SHY2cGpVQUMrTUZO?=
 =?utf-8?B?RlhaNUJwM2hUd3lXbUlxMU1LWTZtTDRHck9JSm5uREVyL3kxTzR3RElQeWNK?=
 =?utf-8?B?cmNUMHJCemlrYlRUUFlxUFp6enV6YjVNblEraXRWZU4xQStCNWZxQkFlRFUz?=
 =?utf-8?Q?lt/YHAqrfWhpVL4kq5HGy8cE9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29e13c5-1e9c-4f9e-65e1-08de2197d967
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 03:02:01.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MAF5HkTtBWdkLTx+LQsvF9jAvkn/rVLH4hyKQtn+onrbnsdCL6tKywOvnaj/3bddEZWhbr0ITQYLP+Vf2kZ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

On 11/11/25 7:00 PM, Jason Wang wrote:
> On Tue, Nov 11, 2025 at 6:42 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
>>> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>       }
>>>       vi->guest_offloads_capable = vi->guest_offloads;
>>>
>>> +     /* Initialize flow filters. Not supported is an acceptable and common
>>> +      * return code
>>> +      */
>>> +     err = virtnet_ff_init(&vi->ff, vi->vdev);
>>> +     if (err && err != -EOPNOTSUPP) {
>>> +             rtnl_unlock();
>>> +             goto free_unregister_netdev;
>>
>> I'm sorry for not noticing the following earlier, but it looks like that
>> the code could error out on ENOMEM even if the feature is not really
>> supported,  when `cap_id_list` allocation fails, which in turn looks a
>> bit bad, as the allocated chunk is not that small (32K if I read
>> correctly).
>>
>> @Jason, @Micheal: WDYT?
> 
> I agree. I think virtnet_ff_init() should be only called when the
> feature is negotiated.
> 
> Thanks
> 

Are you suggesting we wait to call init until get/set_rxnfc is called? I
don't like that idea. Probe is the right time to do feature discovery.


>>
>> /P
>>
> 


