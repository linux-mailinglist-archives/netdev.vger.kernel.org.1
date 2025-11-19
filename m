Return-Path: <netdev+bounces-239831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5AEC6CD87
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 403372BAC5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 05:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2372D23A8;
	Wed, 19 Nov 2025 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F/m9rz3G"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AD25BF18
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531853; cv=fail; b=OnzqhEGoAbVWCWzpz9NZxBujQuGfV5ptdL/G4twLEqQTEg35qHbGBoaS22tWQElvFRS/tunc6FiaWkbst9/z45TStIIRdR5MiQ7sdQXXT65u4HxcQraSzQ6F4+ItM++XfthRSQUfvUoRh6gupL5KbTSr28153dHWMgCdcZRc3hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531853; c=relaxed/simple;
	bh=p2f/ZziVjitrpWN93NIE/V7x8uhTvSTrjLkwYVq2o8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ljycD3gxbuO/+r5gPKet1XMIpbYjqQGfcMT1KYd7g8HaGfIF5b0BZd++fzvNiJfdhl1KCvVkkTrTpDFKcsOYOjTEc9oE5zNJPSOXF0SyvmSiVMcRlqwW5oGB1xbKsNrRQZesx7C6fdYQWT+8grttr/SU2l8dBcYNjMsXH/2K6Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F/m9rz3G; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWbHkGYnMDMYTxKg1r5mtlnRo9YqKJ5WWCvGvxXfqrhGNfIcQYHQPRd4t13cCHSUOtV+Mnfh05s63zYvqm6Fen4e55nETvUP2YK3dPn3q6fa4jqRMyFXhIyT18eVkhiUAwS20Rz0bHlFSEI/9Wc6X3qV9u7PFr/3PyXRknAmP1Rt69eTaYDJKMskOse4aeAw7V7Jh+ZZdXEPGwyiSQSFhoXzscZeRecSE8bOUSVqvschTPfUYxwqUKeN/F3L7VvUouTcDXgtIBtTPxLEWNR7U2zXHLx14XHOcgedMUQvs60YxU1kVGMSvYyUhUAGUSMiky4iNVKx/qNOXaIAy3oFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UYI9dtpHNlLQYsvsysx7hGwN5MgUpV3sYTMABD4YQQ=;
 b=WFW11SzYE2Dqrb/aNiDLnbEc0DvIklA1osNTmVqPOg1GgF+TROOw4jvdlVHCRoiV5YzuEIj28HUqWJFcj3RQaf4q+c1oHhYmFYu1QTIUXJbJdN0FT8G7XF72+3SwK5QmyovkyWZfZ9k7tfACpdd4u69vzs9MoBMJS17a9PQC9ZOuDe9z+Pv/Zt82pX21kJGcDQIKvl/lpTVhOB+hWOcZxRh1rmghgFpyXM0OD6L571qQc+doT+m7+3pzGoTH5+23Am8i8HFJgR9EQ+WVeDxX+FH9JZUSdjZDQfC5N5/Re/BoydMbWftSwG3MhiR9x3vzi6HLxFMxxQK23l6iPMmv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UYI9dtpHNlLQYsvsysx7hGwN5MgUpV3sYTMABD4YQQ=;
 b=F/m9rz3Gbi6lXKkzfq8LVkaFUveB+YLjIBbgiEthZQ65W8eWuKuDQL9OCe42nNdqTvQmiiKZSKTkyGDQvAA9kMwLmheYCnY418hp90ZF+yM6XVKfVHXS1abzPHeEPEeoO81NVQQ35qgM28EI3LEfKd8xCspCB3TjwX6UsTEnkSaVRIGH1PRcxgp/uMLNeLXieVlTQ0QpgyQkYJOQBYYtvlEUtWBBu6lyd3WklEaguayYDgveTkiWb9WT/u0regwnbONEH61slN5kI6fBI8YB8AkwW34zkIqj70KhxIl0GaYBoPcSaKKO0Ei822ERl29upZQRgWisFwBhGpD4o/jVog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA0PPF6483BC7EA.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 05:57:28 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 05:57:27 +0000
Message-ID: <d9f0b452-5cdb-402d-ba7b-17df3f624561@nvidia.com>
Date: Tue, 18 Nov 2025 23:57:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/12] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-6-danielj@nvidia.com>
 <20251118165659-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118165659-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:806:24::12) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA0PPF6483BC7EA:EE_
X-MS-Office365-Filtering-Correlation-Id: eb589fa1-1e75-45c0-ca20-08de273084a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGpzYld5dXk0UXJmSnE0K0M0WmYzdFZyTXRiUXk0NUpnYjRoUXkvSnpsajY3?=
 =?utf-8?B?RHBYck56N2hwUlZ0QWN4c2RiZ3N2akI4U01odmgvcVY4cFh4ZFhwaG9aY21p?=
 =?utf-8?B?YVV1eFR2aXNCWEpRNGpDZzhRcUN5SHQxK1orcXp6alFOMUEzTVNpOGlBakxW?=
 =?utf-8?B?M1dIRUp0SlVqTjY1N2NnZkswcXZYcHNYdWsralBSNVR1TjFQYjJLdUFtTy9I?=
 =?utf-8?B?Ynp4OXh5ajhRaytQS0tmRVJkQjZLZVBKYlBmSjBJSVBrSXlhQmg5YmN1dkRH?=
 =?utf-8?B?Rm1RWDVrT2V6SWsrbkZtQXR6MUJVUGJ3ZmJCdFBYcUlFSGF2RWw2U0FGWXZu?=
 =?utf-8?B?TmZWMjZjVFB1WjZlRVRkd2t0eUF1Tm83M2JaK3lzQU1HVUo4eWNoamErYUhn?=
 =?utf-8?B?cEV5ck5ZYVJESXNuempSNS93UWJMWW9VTmtyYWozdHNMZFhhczk0WUpscnl3?=
 =?utf-8?B?QnVkWGZmMGxMQ3lGNVJZWUd5MTYyMUt2S2xkbjJPOWFvUUJ1U3JzeTFWRXY5?=
 =?utf-8?B?U3dBeThXcXlmZ0JkSDllUFVUSHFuZmd0N0U4Unp3aFgvR0VkaDB3TENtRVR5?=
 =?utf-8?B?Vis5dnR4VXZaSFNNWHJUbUVSd1pRMWE4K05vdVd5RUVIZU5yekd5TWYwL21G?=
 =?utf-8?B?U3RRajFvbDhudnl6OVp3STAySFplRTY0by9TN01GaU9hNGNHMFFKbldhM3BL?=
 =?utf-8?B?YlhBWkh3T0hMbHRsNjFtY2R1c3lWaDNnbDd6RGhlUnJFMDcrV3hVMTlyUUpx?=
 =?utf-8?B?Q2gvM1dZd0xSZzkwTmJ0MGh0SStYeUpud2J0Y21Fd2dxeDRiRnpmTE9OWEp3?=
 =?utf-8?B?OHdMbW43TGhZaG9LR1RTSUZ0WkYwOGFSWWV1OC9yWnd1NVVSMUJYTThXSjUy?=
 =?utf-8?B?b3FhcUdtTUF5UlZybUFYeE0xRUEzSk5hdUw1VWVYMHBFUlg0Wjl6QXhnS3FR?=
 =?utf-8?B?SjJydFM0WVczak1hbjg1SDhRcXVuMlZjMENJNUtoK1Y5S0VoZDdYZGF1ODJF?=
 =?utf-8?B?ZFR6Sko5LzZQaTZ6bkUyUXdjcjg1MTRyZzNWTHJFdmR0eWpDenY2anpkekVh?=
 =?utf-8?B?dTdTQzR0anVCeUx5OCtpUGR4bC9IeE4yVm0rVHhqakZxZ2pzeGxQbDJBakdi?=
 =?utf-8?B?VDhsSFBsOFZ2SmNjazBEQjNlTTI0ZU1yQWlXWVd6dXhVeFQ2TFZFMnJPRVpH?=
 =?utf-8?B?cTN4YkxMd1dma3VINlNTeEhxYmxhREl6NkFNMG41SWZGeW80djN2U054UHFO?=
 =?utf-8?B?R0hLNDFqZ3NrTys2ZXhkWEcxME9uUFFLMy9KdVVpazloeEkwSzJXV0FkMGcy?=
 =?utf-8?B?ZWR2Q0lNQnh6U29KN3pBZGtsV0dHNDh3T2hNbE43ZkN2eE04c3FzVE52WS9H?=
 =?utf-8?B?OFJ3VTVQMElzWldKVlpicWMreUZNeFdhTmNGbnZyQ1Z1QVhhUmoxWGFsMWJi?=
 =?utf-8?B?TFBaUjV3MW9QRWViNUpnWkxoV241QjlFTnBiSENycDgwenhodUJJT25DVlhB?=
 =?utf-8?B?Snd3MUJUMzQ0eURVMHVZUmNnSnZYeUQwOWZRKzBxRElrbzBhdlRiRU42L0E4?=
 =?utf-8?B?M081c3doVHluNStGQjB2b0tFbHd6YkI3a0pLdmIrMnhMYUZwMkJPRXBxNVJr?=
 =?utf-8?B?dCtLb1cvcXc4aHQzYnJNSGpkcDExYlVzK2ptMGZLNWFSMVA3cXVSS0x6NXND?=
 =?utf-8?B?aFVFYld3MGZpTkd4T2hjNUlnclJvNFJUUERxR2tQWFNFdG5pd05JQ2gvUWFK?=
 =?utf-8?B?TExJOVkyTVJ1YVJ5c3FIakc4NkRjTkprYUxNTEM2NTRrazUvNVBndUpzbGRP?=
 =?utf-8?B?RWllU3VqVmszTENmUkxJbmlNL0xWWmtnWWxUMUw1L2tTVlFhbVBaM1l4OWxH?=
 =?utf-8?B?VGwzZUpzZngvd2xLK0ZQMCtocDZ1a3pLSkdUZjZVdkZScDZuK2ZleHdlN09k?=
 =?utf-8?Q?HYwsgWR1QXS/Tw6LfW5bfEnxdpaeS22N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0ROczJ4b0o5Q2hON2c3MC90bXd3eE9SYUtnRVRmTkt2eWRVR05zcTdrSFlF?=
 =?utf-8?B?ZkM2KzBKWWU4M3JBQmJQZlVhVFppS2ZIQWx5RjBJcmtGc1BGQ1VqdE9OQVZw?=
 =?utf-8?B?YkFIaTN6RG9DVW52YStHdWN4YWdaSVhiVlhGSUs0SFB2KzF1UUxmQTNRUWw1?=
 =?utf-8?B?K0MyYWZsZmMvS3hnVU56djBENm9pbmJkS1pMSnI1b2g5a2FIUGFCWTUzRFJu?=
 =?utf-8?B?RlgxK2hHdDhNSTRsWmJHSW5GZEhQVHNiNkVCSjQzQW1EclNiQitFZnplOURC?=
 =?utf-8?B?SzRUSllBdmxRRHNzcmhNZHFaUmUyZytBc2lOdFRRd1hXWnlNNGMxL053ZHZ1?=
 =?utf-8?B?dDdBQVhMd2JMRTMzUDdVWXU4ZXd0TTlERXhENTdVRmw4VTVuNFk1eGo3WTFm?=
 =?utf-8?B?V3FEUE5Nb05OcEI2UHNKSkJEOUN3TDc4RHV5VFdpbnVaMnRLNmxvSEJ6MW9I?=
 =?utf-8?B?dHdTbkd4NEpMNkNZeXNHek9kSU1DQ0hvWGp5V1dYMDF5a3IzR2dnNndIamJC?=
 =?utf-8?B?OWg0RWhKYTVEUExldHpranZta2huNDVIQVFMbjFDckFOMHpiMjlyd0ZrSlBC?=
 =?utf-8?B?YU1meHJzeFkrQ0xjSG5DbVpVU2Z5cHFtekl4VjlWVXMzVFBuZlFWdjFLUmNI?=
 =?utf-8?B?WXFITlZHVlpGTXhYbjk1TTczNmN3MDlCak54Mko3OVJSUTlkcTgxVEQ0VEdr?=
 =?utf-8?B?T2ZIbUFXSWR1dW1qUFRVdGtEOG1EUXpWNUx1Rm5QcDRZd0E0Q2pkK0k0UElF?=
 =?utf-8?B?dnlRdm5ZV0NNMjNqcmdwT3ZpMnB4dTE2bEQzY1NMOVo4Qm9lNmRNWFlDMjdl?=
 =?utf-8?B?cEpZZ095bEtzQzZRajdZNmJCRHF0d0VnSXZkcHJpVjlsMUhVcGhubHhvejlU?=
 =?utf-8?B?ZzVhdHQyaWtTb1JGdHZpbUVtcVBnazFBcmFUejlzcU9hLzZyQXN2ckFERXc4?=
 =?utf-8?B?VGpBZXRsMHdNc2NkOCszK0t1dnVLNDRVTDk2dG10bERtdVYvWHVPL2FMLzV2?=
 =?utf-8?B?SWZQd0VPamgybE5MSGFiU0NZcFhoREVJaW1BMWw2bktFMmVjRHJab015R2tM?=
 =?utf-8?B?bmZ4Nnd1UGM3c0dndVk0ZlQrNFFKeGZYY21qZzIwZUhUNzJyeFRleHpaS0ts?=
 =?utf-8?B?bXVuTE5hN0hWOFk0M3Y0QnlYSnp1YjBTZk9zK3E1RU9UQ3FDQ05mZXlTOWI4?=
 =?utf-8?B?ZVZZMFNHZGNPV3Q0aVJlQWt3RTBUaHQzTTdLa2hpNFhjelh6RVphVG92VjhE?=
 =?utf-8?B?WXRLS2VvTitvVmhVUzdqYStIVGh2NENBdkFtRnNNcG9QemU5RnJFZXB0OERj?=
 =?utf-8?B?NG1jdkk5UnYxb0llbm51RVpKWGtTWU44S1N0WHNkWmhVS29ySk1QMjBaMHgx?=
 =?utf-8?B?Y2FLYzlKcEhYYUErb2dnNGJLQzdjcWs5eGNSU3NNbjVXZUM1VVJDbG5KdCs3?=
 =?utf-8?B?Mm1WaFQ0WVNnaHVYUkt4c2RpbnpKRVhmbW5neTUyeUQzK3ViSXA4aWtCSjE0?=
 =?utf-8?B?cFp6a01rVVVOVUxyTDRsZDM1NFJLSkE4MGlmdUxJY3FOYmJBdCt4V2RGL3dS?=
 =?utf-8?B?OGRRYmdDcTgzcUtwajJTZzZ5b3NXN2FoRTRPUUNvNzRFc2xoRFQ3S0FVOWRZ?=
 =?utf-8?B?cCtKYnRqWGlpRGl1a1dSdVk5UGR3VENTb08yVUxQUjY5d2kyRjhNQjVGZ2FS?=
 =?utf-8?B?S2s1UlUzODYxZS9tWlJZaWFUelUxTUp6VitFVldiaXlFVzZFcG4yUnloOVZS?=
 =?utf-8?B?N1crYTYyenZnMzRSdU5KSGlVTHpmT2tNdDJueklhcm1wSU15R011UXFYMkhB?=
 =?utf-8?B?cW8xKy8wc2JQSm50UFpnZzI3M3hEYk80SkpWQWhGRDBtOEFjNTdnZlUvMzA2?=
 =?utf-8?B?dkEyZFFReTdDVkFSYk1vdHF6bGhpS3dGSXRNdjVYalZjbVZYNWJUMTJ2M01J?=
 =?utf-8?B?bk9PY1M5Uy9mM01Lc01HNlQ0b0VRQzl2U3k3U2ZpbjBlK0hIOXhYd0phMGJl?=
 =?utf-8?B?U2ZjZEl1YmhPR1J4QXhoeWpsS2dsSmlURFdEd0U0dkFlbDg4blRjdmIvNmNM?=
 =?utf-8?B?RDAzVEIvdDVTSndQU2M0WTNIMG1OOG1CUUYrcmRKRkIvcDN3N1BrUCtjRTl4?=
 =?utf-8?Q?KckSp+0bbl1FYf4Wm+z5Z8CAf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb589fa1-1e75-45c0-ca20-08de273084a9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 05:57:27.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ell3UgMvXkdkxCG2XCvFrhj9QmaTovmcJlmoFQfkyyFSIgmLW7ITQxypile9AMwiFe/RZAvUdC3I6eXvyJcF+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6483BC7EA

On 11/18/25 4:06 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:55AM -0600, Daniel Jurgens wrote:
>> When probing a virtnet device, attempt to read the flow filter

>> +	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
>> +	sel = (void *)&ff->ff_mask->selectors[0];
> 
> why the cast? discards type checks for no good reason I can see.
> 

Jakub and Simon both requested I change the type of ff_mask->selectors
to u8 [], to eliminate sparse warnings about array of flexible
structures. So a cast is needed here.

> And &...[0] is unnecessarily funky. Just plain ff->ff_mask->selectors
> will do.
> 

Done

> 
>> +
>> +	for (i = 0; i < ff->ff_mask->count; i++) {
>> +		if (sel->length > MAX_SEL_LEN) {
>> +			err = -EINVAL;
>> +			goto err_ff_action;
>> +		}
>> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
>> +		if (real_ff_mask_size > ff_mask_size) {
>> +			err = -EINVAL;
>> +			goto err_ff_action;
>> +		}
>> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> 
> I guess the MAX_SEL_LEN check guarantees the allocation
> is big enough? Let's add a BUG_ON just in case.

Added BUG_ON in both error cases.

> 


>>  
>>  #ifndef _LINUX_VIRTIO_ADMIN_H
>>  #define _LINUX_VIRTIO_ADMIN_H
> 
> 
> Why do it? Let net pull this header itself.

Done

> 
> 
>> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
>> new file mode 100644
>> index 000000000000..bd7a194a9959
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_net_ff.h
> 
> 
> you should document in commit log that you are adding
> these types to UAPI, and which spec they are from.

Done

> 
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>> + *
>> + * Header file for virtio_net flow filters
>> + */
>> +#ifndef _LINUX_VIRTIO_NET_FF_H
>> +#define _LINUX_VIRTIO_NET_FF_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/kernel.h>
>> +
>> +#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
>> +#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>> +#define VIRTIO_NET_FF_ACTION_CAP 0x802
>> +
>> +/**
>> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>> + * @groups_limit: maximum number of flow filter groups supported by the device
>> + * @classifiers_limit: maximum number of classifiers supported by the device
>> + * @rules_limit: maximum number of rules supported device-wide across all groups
>> + * @rules_per_group_limit: maximum number of rules allowed in a single group
>> + * @last_rule_priority: priority value associated with the lowest-priority rule
>> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
>> + *
>> + * The limits are reported by the device and describe resource capacities for
>> + * flow filters. Multi-byte fields are little-endian.
>> + */
>> +struct virtio_net_ff_cap_data {
>> +	__le32 groups_limit;
>> +	__le32 classifiers_limit;
>> +	__le32 rules_limit;
>> +	__le32 rules_per_group_limit;
>> +	__u8 last_rule_priority;
>> +	__u8 selectors_per_classifier_limit;
> 
> 
> Ouch this is a problem. There is a 2 byte padding here.
> 
> This is a spec bug but I don't know if it is too late to fix.
> 
> Parav what do you think?
> 
> 
> 
> 
>> +};
>> +
>> +/**
>> + * struct virtio_net_ff_selector - Selector mask descriptor
>> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
>> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @length: size in bytes of @mask
>> + * @reserved1: must be set to 0 by the driver and ignored by the device
>> + * @mask: variable-length mask payload for @type, length given by @length
>> + *
>> + * A selector describes a header mask that a classifier can apply. The format
>> + * of @mask depends on @type.
>> + */
>> +struct virtio_net_ff_selector {
>> +	__u8 type;
>> +	__u8 flags;
>> +	__u8 reserved[2];
>> +	__u8 length;
>> +	__u8 reserved1[3];
>> +	__u8 mask[];
>> +};
>> +
>> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
>> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
>> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
>> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
>> +
>> +/**
>> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
>> + * @count: number of entries in @selectors
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @selectors: array of supported selector descriptors
>> + */
>> +struct virtio_net_ff_cap_mask_data {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 selectors[];
>> +};
>> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
>> +
>> +#define VIRTIO_NET_FF_ACTION_DROP 1
>> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
>> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
>> +/**
>> + * struct virtio_net_ff_actions - Supported flow actions
>> + * @count: number of supported actions in @actions
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
>> + */
>> +struct virtio_net_ff_actions {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 actions[];
>> +};
>> +#endif
>> -- 
>> 2.50.1
> 


