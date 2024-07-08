Return-Path: <netdev+bounces-109952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E44692A74D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338AE281612
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6B1459F1;
	Mon,  8 Jul 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NJWdmkMd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6077F2F
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456141; cv=fail; b=LCmQdiK+F8OmOfr5NButv+4CXjdN+V16nTlVN4q7BAw3bcaBuP1hAIhZFdCmfx6We++NMPyTb5AB243N+F+gbDe7EtAl5x756M44pW8wCSfgf0T2PvdW+JSXt7Eb85uHD70Napq3pCNy99ypOMiuN3eGGFRw3hcsIN6m3h9wQmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456141; c=relaxed/simple;
	bh=q67Mgs98vMibwyO6opKT+Ah/lRbGhhFqWYEChcEjNvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fdK6ICPUeTP+ecusQCxWavUGxs9116L50JkvL8ODNF9aBXyMcOcw3RGhyPn+sTYPwVGVy7duc41pw4Ca9KSHtSWgFfju8wiKwy+8D2rU/ltaTZlf9hsVOvelpe2X2mAFP1pmusUL3fG8LLryj+rVBkuU+Utj2nCuLf/fLeeM/Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NJWdmkMd; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9bk4S6M28zhj4zjSXGfReGRnB2fkmDeTs/O5ygADYxLkbevDnUfZMCJj0BpVWRVFrwMyFDV5bnMGaHV1XGXgyXtaJbPvMUorXRTmK7zYkwG4H7WJpor+qH9FLAPOTqBs/MRwptzR5iu36hKr5g4Aydz2Ekp5qIUqFckpKYtscruHmBWm9Hb/5A3QUyEcUxSMPpljUYY1mWoPQjPH3Lo8reN76WqqoXhN0HhaQzcI+OSxd2GQMvpXOMULVi4ScqbWT9i5irGr7eeUnz4FzIzvsDZlYUMwhStQryz7jNZDjnCysK+mJKplLkJo9Fxi/a+kUI24b143xSZ2h4JeVtWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLugdhgpGOinaqRvjKYw6Ly1YPjRfo1f3NKCWs1KZ50=;
 b=nlFfMaJ2b9qw+p6ZyG+BlQ0gCHtcCn/5y1wakqdFoxaE+o+9qVblhXJQrsbOSb2TZOcxZdzSxKbhfuySAjErkjw+awLHxMeIZmIPfwUVTISqVH2RIfxmLIuTLRuD2ZIC0Ea6LUn0BCkEDpaQP9+I4fBCfReaxu8CB3wdUEjRvh35kPpOBbvFxk288xqFbbLZGuCG4GkHXaVM6xAbJfhCwMrUvNG4QKXw7twe7/ZupX97MLmVn8iwyHW962qIhYZbaZ5N1h5XMlNzyFtvcC0c9gxZtS4NTTIq58WtNlAbzkmkVwCGXaMIjJ9ozTQ0k2Nz0bvMgXGEGK/d/5ETzUCGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLugdhgpGOinaqRvjKYw6Ly1YPjRfo1f3NKCWs1KZ50=;
 b=NJWdmkMdkF7sxwJeU8egeA6usSbSWI+8o/rHlnToGDsBsZqejmitKVe4wxMRPpsmPs3cjMRv0ggvLVwVYEswamMeAhNKjqtCFTidb0uPWfgIzAjYJk8CLEQqWAKG76wwFQBpz6UrfgELePTTnToWMuS2Q1HyHYw1lzZbvNx2VFK0ltSeqJV31nU70GjoprByLVsIyYBPoEz4DtRvDGY3at5btq/zeoTJoDWDX7hX/4lOPYNzVp5K28s5PFiZbBy7GKkadpDIRMD7NBCL5IBgb5t2J3kJlSgmHnTTzxZPg15IsXncnFtej/zqhbkbwf9V9aZEBCE26XW62suz9Z47rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:28:55 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:28:55 +0000
Date: Mon, 8 Jul 2024 19:28:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Moshe Shemesh <moshe@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tariqt@nvidia.com, Dan Merillat <git@dan.merillat.org>
Subject: Re: [PATCH] net/mlx4: Add support for EEPROM high pages query for
 QSFP/QSFP+/QSFP28
Message-ID: <ZowTsiQdTyLJkdc4@shredder.mtl.com>
References: <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
 <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
 <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
 <c11f42c6-7d65-4292-840b-64f13740379c@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c11f42c6-7d65-4292-840b-64f13740379c@ans.pl>
X-ClientProxiedBy: LO2P265CA0223.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::19) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 499161a3-1717-4ae1-1a84-08dc9f6b0fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3gyTHZvTFl0SmhGY1RtbGVyVEdxTnlpSzNRSnpqRElIbGg0M2VKSVlmeTlM?=
 =?utf-8?B?alZnUmdOL3ZiVlFPbXY0Y0JRbThmR2VFSldneW1KL3p3Ym1VUUNKcGNWN3JE?=
 =?utf-8?B?TnNCejZ4WFB0ZmdBM0oxQTJLZDlZZFNkc1FTaElVS3kxOXk4a25tVzBYY2Fr?=
 =?utf-8?B?Y3gxWksxdVFUK2FmNWtzaXd0aGo5RWtaNmJYdFFpVXhyV2dITFM2MUgwZ3pn?=
 =?utf-8?B?NVpOd3NqRDJxeWRGbklhY0hkOFI1TFdJR3crZmJRdnRwZUcxTHNwdW5PdmNT?=
 =?utf-8?B?VjgyK2NkVXRjTVRRZ3h4cWd0cXdDalp4d1FIS0dydXFnbysxaHNibkdDMUpQ?=
 =?utf-8?B?U1F4ZEpLT2xaM3ZwU3JYa0NISDJoaU9sYlNEV3lhZmQxZWtEOXd6RUUyc0U2?=
 =?utf-8?B?VjV3NENiZmNVZzNhU0czdStXbmxpSmZ1MmdoQ0RPS0lVNzhwQ0lyTlF6MTl0?=
 =?utf-8?B?V1ZodXJjNTBVeWZBNXpuOWVkSW5UOFNha2VWcDN1Sm9kVkRwbGN0T0JpRkxS?=
 =?utf-8?B?aXBQYk1UK2RsWTk1WXoxbkczVFhvZ243SFFzZ0tBcmR5L3dPRTQralJ3Ympx?=
 =?utf-8?B?L1M0c04zemZMWmRnWlpmYWdzbzdtaU1iS3V5aTgya0RvYjcwcUJVbEhIbzVK?=
 =?utf-8?B?UDVzN0ZYVG5mVHlwVFZBVEVBeFNtYi9OU2VaSkliRTU5NUxEaWdFZUZ5M3Bk?=
 =?utf-8?B?aEM2UmRTR3hWcGoyTERPOTA2K3Y1ejlObmJ2YVYxR3lGOUFuWWVSNWl2eDY1?=
 =?utf-8?B?UHh1cVhsSzdxcUptWnlZbEoxejVycE05c1Q4em5JUFB1djk0YXNQVVc5dGNj?=
 =?utf-8?B?WnZKVENrTXVqT3pXa0pqLzdsMk5sUVZsQmg3M0YxWUtPbmpDK0ZJSUNMS29W?=
 =?utf-8?B?ZWFPQ1RBREZiUjY3Wjc4cElySC9xNDdodXUxVlJ1ZlNHSXlwUDViWHRGQW1k?=
 =?utf-8?B?UEtKaENVS2pkOFVJWk8yWkorZ0JtNzJ0VVlsN3M2VjJ6VkdBdThnU0xYQm9z?=
 =?utf-8?B?a05aSXVsTDlydEE1VjJXZ0taVTduSHFLNWJ5eXpvZFJESlk5NjduOFhtYnFj?=
 =?utf-8?B?ajVPcTdPUnZlR040ck1hNHVJNjk2ektGbVdXeS9ncEdkbmZsVmNTd3FiVTVu?=
 =?utf-8?B?V2ZxUzhEU1NXc1lXSHJRSDhreURBOXdqeFp0MEdXQVVkdWw4d3psSEFaUnpQ?=
 =?utf-8?B?Ui9Za1h0UWZRWEV6L284M2x1a0JrZkhBN3ErVkFTVFpsL1FiWlZLVXlRRml5?=
 =?utf-8?B?ekYvY01uczBXMVUxL1BnTXFmZVRVL2Q3cWtiMlNGSGtHNktGblRqbWdVS0hr?=
 =?utf-8?B?RlgyZXY2bmtPV0h1MnJkMDBSK3VYREY3ZmNWWkpsUXBvZnJFQ0xsRVBrckRY?=
 =?utf-8?B?N25pTVRpR05CaGl2TXd4citVNis2c0pwcmFpbEduU25nN2p3SzhoNHVCaTZK?=
 =?utf-8?B?WS92TVhtWWVLZUUyYklMRk1UQkVEZnZoWm1CTmdFOEo1R3dWNDArc1EwcEtn?=
 =?utf-8?B?aEpRcHkrM2lqY0hqMko2cDZIRkhBMTNsWmYxUTlrdC9KdUIwMXpHY0g2ZThS?=
 =?utf-8?B?dHowQzBBNlhxRkkwWWdWYjVKeVRJOTNnQktxbTR2ckNxL1NRRTRYR01BN2dB?=
 =?utf-8?B?QUYwTnJJemREZnpqeENXa09adjZvbGgvbVhKSzFyUzRSODlRdXRpOXNGNHA5?=
 =?utf-8?B?Wjloblc2UlJocm5qZ2k5eUovaUowZ0UrMXNDVDBOWW4rWW1sMFFWUGJGRkF3?=
 =?utf-8?B?M3BxVVFIMVcxNkV5V0NvN2ZweksyTE0xS09LNFFqZG1LMjFDVEVnM1hhd0JP?=
 =?utf-8?Q?/5oP/XtoZasHQx5bPR4Wgzt69KMd3W7XdC1dk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2o1QmtvY05OYWE4bWhOSFlubDZUNTVlTDdDaFIrY0VIRHF6R3RYVitjN0la?=
 =?utf-8?B?N3NEaVRkRXUwQVg5SVNwU0xyWVhPL1NUNW1DOXVmL2hQemp2bG53YXpKRldQ?=
 =?utf-8?B?QWY1d2FLVUhKcHB0QSs0dFZkenlXd2dKUktya3RQaTA5bG12OXNnT0lGWnYw?=
 =?utf-8?B?Y1dYamxwYjFVTWpDL3hUUXdPeTgvYUEwME5NR1ZQMWR6bWI1NFo1MWRaakJo?=
 =?utf-8?B?QVdnZDZiR3piNVhlTlRXV1hZNnJJSS92b0VGRFpvbWl1QlU0UnNKV3YwaGFY?=
 =?utf-8?B?cExkYkI0OGZTclBKTWhPU0Q0OVY1MXFQK0I1L3VQSjVyOGE3cmJBcHBIZTRp?=
 =?utf-8?B?bk1MZjhIVWx4L1U1anN5cyt5aTZjRHZYcnZTQ3hPRVhmSXFhTTBtSE9FRVJI?=
 =?utf-8?B?Rjk1bHNLUW1CTHhWYnRwTElSMlFlYzZ1TGtudjVPL1ltQ2p3WHFOSmhLdjF5?=
 =?utf-8?B?QldIOHloTTVRTlNJeEZ6SzZoMlhqbERhUTZYK3VEc0F2OEZ5azdIeFFvTkJG?=
 =?utf-8?B?ejhNVm1LQjhtOEVyV2hOcUEwbFFHRW1qRTFUbFF4bkgzT1pZb0txRkV4ZEJQ?=
 =?utf-8?B?alpkR1h3ekU0ejFoTkFoa2NwYW9nN2gvNVd6WExMSVNXK1lyMWN1bUhDZ3c0?=
 =?utf-8?B?YUljSHVyUVd1dlVEaERad2JyWklaSnIvN3d5RFFLVUt2eWdFQUJvenBXT0l1?=
 =?utf-8?B?c21RaDRSSXNIcHB1QzBFRFhkSU9NMmFSZUMwRXZnSzRra2JteVRaYlFITENi?=
 =?utf-8?B?Q2lMUTE5WDhuMkpDNVh2UXRmejhva2dsZXNGdlZYRDR1UGdZdkdlR1hDcjlN?=
 =?utf-8?B?L0RSZ3ptK3FLWG95cFdRa3kwYjlXeFp2cVdjNDM5cHc3NEpvajQzUlAzVXF6?=
 =?utf-8?B?cVZveGRNK0MwdW1HenRPdnZMWUFCRkNHUjQ1OXpGWHkrM0ZrWStPclJIMzA0?=
 =?utf-8?B?UjB3OG5LVVV0QXZIa0lnUGR5M3lTc2ZZSHFrK3JwVVBENGpldlBZc2JkOXlU?=
 =?utf-8?B?WCswdkFXQ2hqTkpybGVUWWM0KzhlTGxGL09Xa1hZaThTNVN0RkpsMXU1a3F6?=
 =?utf-8?B?RFRRV0prbVdHTXhySzBsOXdsaXpHUys4c0pUVWs3SWpySG1rbFNHTnRRbEpZ?=
 =?utf-8?B?VjA4cmdaWnd4RVpJTWFJdzlsR2VuR3JkbGRyM3RvbzNZMnpZMTM4TS84YjUw?=
 =?utf-8?B?Z1BVdGlBUHZiTEtlMUl1aEtqdEdTWkxiMnpYSXhvUDIzaDN0bEU4dy9wUzZE?=
 =?utf-8?B?TnhtQWQrWDFkYVlNZllYeWY1VFp0K3RZbk5heEdwRlZla1VxRUUwWXZVdk8y?=
 =?utf-8?B?Q3RNUGVYWWRvRDFteHlseHdkV2RpWXN6eDZFN1R1WFJoNGtUWWNGLzdOT0Fx?=
 =?utf-8?B?YTlaVGZHOTNjbWtKSGdidExQbjI3OGlvNHhRSU1UMWxxSGYzRGs5NCttR3I1?=
 =?utf-8?B?SXkveGsydzYwMWh2WEk2aE9aMGNQVHpUM3VFVWwwNWk2Vkc4TElSZFdiWGRa?=
 =?utf-8?B?Ujh1WG90QXRYTVlEYTl0TFRnUE1qZHg4OHh4aUJnb0VsbFlnQU5lMHlTZU42?=
 =?utf-8?B?bXdLZHVBbUFxejdXOUdlY3c2b2tBdFZwa255SFdHNk05VmRKMndiZkdPbndT?=
 =?utf-8?B?L1FOQS8rUXVvR3hhV3VzS3MxY05LMzdKMG1sVzMwamlDMzNXSFNvZHplaElL?=
 =?utf-8?B?M1FKTVlCdHlRQ2NXcTd6Szh0VWh2YWRINnJRVzJLQ2tjTW8rOUl1SnZRVVV5?=
 =?utf-8?B?d0x1SmdWYkRiRWg2QjRlMEEvMVh3VVM4M2VicUNaTE5IVnF3SWlyL0ZNbkg5?=
 =?utf-8?B?YzZxNlZ0UmcrcFJ1YkVpRGVyQzdURHV3dElwT0dTSGVEYW1DNk1ySjgyY0VG?=
 =?utf-8?B?UFpCSG5lUkxHQ1M1TGFFTisvUUNZTFJFNmtLRlA0Ni9ZVnVZL3p5cm5hc0FW?=
 =?utf-8?B?YmVzZ3JDQnV2c0hBSnFlemVCRGlRbFoxZXVlSmUxUFhpZ1JMU1BHTXQyQjBS?=
 =?utf-8?B?SkxiNExoMmY1WnhYcEVjcXdYWlZuMHpwbUtXQzBKemRzZS9jeTVhMlQ2T1pa?=
 =?utf-8?B?MU1OcXpYSmh2Q1lzZjZBa0drbmprbjhGd29EdWh1VFp2Uml2dFJmL3pXbFJG?=
 =?utf-8?Q?JTBp6TfpdgoqNxxkjdK0XToCk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499161a3-1717-4ae1-1a84-08dc9f6b0fb9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:28:55.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xv00rsa43mGiEhJ9Sy+oX1aRluNm1cW/TDvjGjwPhK5VP1qbE86IcAttI8IlmK8oIt/wPKaiTCTFG0FiF+YVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022

Hi, similar comments as on the other patch. Subject prefix should be
"[PATCH net-next]" instead of "[PATCH]". Need to copy maintainers
according to the output of "scripts/get_maintainer.pl". Missing SoB
(scripts/checkpatch.pl should flag it). I suggest reading the following
before submitting v2:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html
https://docs.kernel.org/process/maintainer-netdev.html

On Sun, Jul 07, 2024 at 08:41:31PM -0700, Krzysztof Olędzki wrote:
> Enable reading additional EEPROM information from high pages such as
> thresholds and alarms on QSFP/QSFP+/QSFP28 modules.
> 
> The fix is similar to a708fb7b1f8dcc7a8ed949839958cd5d812dd939 but given

Need to include the subject of the commit:

"This is similar to commit a708fb7b1f8d ("net/mlx5e: ethtool, Add
support for EEPROM high pages query") [...]"

> all the required logic already exists in mlx4_qsfp_eeprom_params_set()
> only s/_LEN/MAX_LEN/ is needed.
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Code LGTM

Thanks

