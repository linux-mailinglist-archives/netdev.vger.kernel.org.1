Return-Path: <netdev+bounces-184559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E699A96324
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27E37A372B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373525C70B;
	Tue, 22 Apr 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oe8orJQU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC025C71D
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311865; cv=fail; b=Rx6BdmMzvTC5zAxAxG62F2kGiRB2X6tpUM0zmHQ/58NxNACDtqXaYgJGLRAzif01c7FyeGUZPvg6+nMx2aN0pVC9AYD6TbwbZEyl7n6q/226kkU/kdiuQiJVunCKQkNHc1qzs++R600nkoWaNhzCmxcjPJgvCE0cvLF3caAPxqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311865; c=relaxed/simple;
	bh=3C7YKn+FCZCocrsIcCPv3Twu8Xipk3ePNUuQ7hZylBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AeXNqh8tG2iq8LZE+vCi5O+CPFR8GSvd0Coq1zhXJudirg4fDl/VrtGwEHZdf6MrCoT4RAryeSPohRmLI3g8iLvnMsL48YwF3lGvaaJBBdlmD6mREJtP0980rFguh9El/4xcXs+zAWhf+BW+ChB96IKiEXiTvGHnJkB2aajOXRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oe8orJQU; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysZHXT7t0ijYIMlDWtKlclOFLvlqHujTqAyK9zW9HKhztYFGRXh1oxD5zxfH6OvrME2sswiJZuEeQwLGo3Few/wxy5TCmjGWWUB70dOZgZp5GTi/2YNfpmFzUfDRqT98xmQ81bv6232uHsVh3Fv0nTWM4dwNxogtr5u+I2kVaNnvqP01L0Vu5hGnxriaYvc8Us9Vzp9RP3QZotRl3MqfT2LRm3jfp/yV/voWnd/3yX+VQKcufodVDN9vJjsW6EtAHK8jLfUliERvUCF/uFmHTqkbU+WrRrCzDmi+0ZsLVUnuNPbQqaw2OES6MTwXCKYwq+mQZWfi+no1ujbXpSUGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE1z3+EFhPlgqS0QpuKvrtaN1rlt3SMlgNKDkxQCelE=;
 b=MKvPVya02biWF1ZZ2nX5sBMgbszAFlghoKGbadC8LikNjrnd6x55uboSd2L97narg7jtwDhL+MtOobitcYhsioAuybqkzaz4ksR7f5m28A1Q6HWpWdXhWPrNLsqQsaOVG1xxuK6FTYYhpm7ip4ADIQOPfPoHMdtqkMFOmD7kF0H+3nuCqzVohhV1Pl61eTo/USMj40iMKpjPbvRwQ/rqFBPrglzjnjICB5xqVRv4/BrlccGB6yXrRFlyjOpy9puglZxH/9y6jk6xp4uIvKjIE/Q0mzxE80efVVj6NX14lv+NeQxOqKpnxTIvBlY9JN7lDaY3ONs0agbcJ9Iq6tuiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE1z3+EFhPlgqS0QpuKvrtaN1rlt3SMlgNKDkxQCelE=;
 b=oe8orJQUfqJtDtCcTFkt9YQUE11fr+UygiSaPizIcIX/RcxnrRvVfP9b4C4CI9/HDmxPWM1HMz1FBNfago4bSOTYVoRq1f72V5MfcchweRz5d6nStrPAxPLwsT1Kik0kEWrOEZ0ZOZ7WpYYfcJqDy4ZGUeKkPEx4455RXJ3tuFZnQnXYENeV2sMZ9BAO1xrpGuKAI2eQ0NtbqdqJ15RR+StlKZ+pNEq2jcxR/AkGDPbMpCE2H5JTpULuJ11onwtrGvIcyWEJ4l4XFGuEM09EHufnwLR0/d3ko65nJ4Gqp8eO6m529ZJypUmXQLcO6z7gV72W8REUrU04mcTR6Wj98A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 08:50:59 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 08:50:59 +0000
Message-ID: <31146ec3-f581-423e-ab54-2d734d3ac42e@nvidia.com>
Date: Tue, 22 Apr 2025 11:50:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [?bug] Can't get switchdev mode work on ConnectX-4 Card
To: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <8b96e37c-842b-4afb-9c61-f71674874be5@mails.ucas.ac.cn>
 <091ec8be-34f6-4324-9e79-d2fbc102fd6b@nvidia.com>
 <90e40d18-ad31-4408-95e8-0cbe4fb12786@mails.ucas.ac.cn>
 <39f1ff89-787a-489d-8ff5-9b90897afd28@nvidia.com>
 <131a4587-40d1-4cee-8f5f-52d9f6920034@mails.ucas.ac.cn>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <131a4587-40d1-4cee-8f5f-52d9f6920034@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 8918ea03-ecd9-411c-0d6f-08dd817acdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTNwR0RUZG8xcmtOb0RKaWpwUGtnc3dGc3E3Rm1nVHZCRExhQlZzM0ZtWUti?=
 =?utf-8?B?QW9ldGxhaFRmMkZBQWtqM1kxdVFLZzFEWTczK20xZzQrSUpOTHdXWXZKN2c5?=
 =?utf-8?B?RnJ3TmJpYU9WNHpmV3ZyaHJGcGRYc2NWTFpzNDJYTEFXR0EwUmhDWG9jS0Ew?=
 =?utf-8?B?bmdHdTNrUWdFUy9PbUp5Z2ljZ2F4T3hYS1JQVDloTHh0bGxrWW1KZnVad2tW?=
 =?utf-8?B?SDE5STNLRlFZb2FwUVdCYU9HSmE5a3ppS0d5Rm51WDZZSGxiSEU4eEg3NFpk?=
 =?utf-8?B?SWhFOWpEa0tkQzF1R01HeTIvU0ZwQ2lLVTgvaFR5SEtwcW54dWFySVVheW55?=
 =?utf-8?B?d2FyQ3NDZDFwNFBycXBMVGQyYkdkVXhDMStCOXdMS3pOOTd2ekgyblZrV3JY?=
 =?utf-8?B?OGpCQmhZakE5dXBnV2kwblpGUEJJS3psdENXL214djdiODFVankrVUI1blNC?=
 =?utf-8?B?OGtGcU1QTEgxTmJzL2I1MHB1QUxsN3F6RTZPUDdiRDY0MmtHVzk0dWNyZWtV?=
 =?utf-8?B?T0ZFTE5EdTgxYzdTMzN5cnJuYVJwY3k3UXB5YVVhY3dhTXpBMXF4RkFLSnNj?=
 =?utf-8?B?Tjc0K2pmeE9TMDhYeVR3SzFXbjhENnlad3ZDSEtTYXNFM2RXNm5SR0F2SU80?=
 =?utf-8?B?ZzI4VzVHR242WXFDcXBzWWdHT29ORzgyYTF1Z3hGMGxhUFl1a1htaVA5YzZC?=
 =?utf-8?B?VHVTS1hSWUtBZWl1Szd5K3ZTUmxCNVMvUkpEMWdmb0R4d0ZGRTE1N3p4NUI4?=
 =?utf-8?B?TGFaTVdvSHp1K3A0OVhaeGdUYzRDUzNtMEhNcUprNlZOM3gxdDNIOGZuUzBF?=
 =?utf-8?B?WnhFKzAvZWl2Yk84L3h3UnoxZ2RJQmtKc01icnZxcnAvMC9uckFhYSs1S2lE?=
 =?utf-8?B?dklUeWFLVEh0cTVnNW5lek1wQUNjRzdEQmd6Qkc3Q1lad2lRb01BZEVPOCts?=
 =?utf-8?B?cVord1ptVytKb0lrc0xpbE55UGhhMDRLMGpER0N0UlpoRVNodFNWVkFQbjFT?=
 =?utf-8?B?YTVNVW5iRkxFc3NPeXNRdGlBMUQzNFdFNldVSVVCNHVDQlU3R0lHYjg0ZDRv?=
 =?utf-8?B?WjRkUzdqWXVyY1NMMWV5YTUzdTNVMXIxTjhUU1pMR2dQeWF4bG9hajJtalBY?=
 =?utf-8?B?OTRpUk1oaG94WWhuODRHQWIyM1JKcmtwU0hCVzRMN1dxczNScStVS2I3eTBp?=
 =?utf-8?B?NGJsNGR2UXFjRUhCNnp2SHJPZ3pBTVY2eVJnZTBENVphbEsvYnpkRUM0Mm1o?=
 =?utf-8?B?WDlLM1g3YWVTaExRZHRuYmxxU2QvTGRqWFhMWDRNMGtSclZkcm45ZExUbFR0?=
 =?utf-8?B?N2U1cUpOWWI1RmN4NE5MWTMrMEN2QUtyR1RHQmFab29FZnhhOHppTHcrYXBv?=
 =?utf-8?B?NzR2Q0JaSGorcFVQeXJNWWhvSjNjTTZsRnRTaTQrUTZ6b2ZnZkJRRC8zb0RV?=
 =?utf-8?B?SjF1UHBJQXA3eFQ2R0hYYldIbitBZGhZSk4rQnM5dVhEOUpjQy8vWk9pb0Fq?=
 =?utf-8?B?YUREczMrTXJQSVJRWEtNMU1JbkM2WDFBdzAxckFZaDBBWU9BZjVrR2txZjJa?=
 =?utf-8?B?Z0JWNXFxZHRRSkU3d2JJMDJ5T2JTUXdrdkFacGRjb2VaR0xFeHZMV2NTUTJs?=
 =?utf-8?B?azhVakNMZklzTXJjN2x3dzN2Y3ZIbXBCZWJRY1VEOU1DYS8yakpxSVlmYmM5?=
 =?utf-8?B?VGxpOVdYK0NMRTZCelMxaENla2YyYkhuTUhqRXFKRHJXRnlmNlVzQ3JQa3Ax?=
 =?utf-8?B?N1NNY1E1U0Z5MVJuMDZUamxSSm45R2d4aHhIMlppZElQRTc0amRVbFEvMjdh?=
 =?utf-8?B?TTdWUWdIYm9FQjdsbVQ4RmtuRFovSVdrUy84eVBlbFh5clVSeTRKRmtHZFg0?=
 =?utf-8?B?YVp3d3N6ZGpNSFBzWldlUm1iV3ZxbFp4MDV5eE5TdVg1c0Y0YnV2S0ZLa3Jy?=
 =?utf-8?Q?CfkAFsM8ysU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dldDS2oxWml2NjRDYndMdFpCZGZlUks1T1VHaVdhN2dSNzJ0OUd5eGlPVE9B?=
 =?utf-8?B?MlFSYldRSms0WGZCL2E4NEl3OFZwVE5QZG1WVHVPVGpOMjFCd090a2FUTlNn?=
 =?utf-8?B?NHQ1M0pCUFRMaW8xbjFwR0orbXA2Z1ViN3hxWitDWFBxUGkyMUlFc3VSQzFw?=
 =?utf-8?B?NERiSjBTeEpPMVBKV0sweWpqSkZGNFBzWjRwZktrUm1UbytFZ0hzOHpWMXJT?=
 =?utf-8?B?cTZGNnQ3bStOOC9uK2tibm9mb1M2TXJ3VklCYTVNN2FiSkw2bzJ5Ty9BeHpm?=
 =?utf-8?B?SGNFMCtTRGd4N3AyV09JRkF0VzFjVFJwdkNHV21YQnAySFVGY0lSN084RTNK?=
 =?utf-8?B?cU1wNjhaME1rbDRmeWVnbTBFV053Q1BuUDhSTVg2ZDRiWVh6WWJ4Y0pEQkls?=
 =?utf-8?B?eERqeVdNVFc1TjhhbkpDNkY4VXNMakt0UFQvYzhWNFB0WWNpL2Z5d0FGSExH?=
 =?utf-8?B?dVl2c00zVjF6blg1dnBKRmNBNmthTENNNmtKd2RXc2tCYnJ2YjllbTY0SCtk?=
 =?utf-8?B?SlJzbDd0N1NyNnBVZVd6ZzgwdzNOaU5BbkxSNnM2S3ExSVFnanlaMklJMDhR?=
 =?utf-8?B?Y0RIYWcvQUtsQ1lyUDlwWmIvTFFJK3E5NTYrWmE1ZnQ1aDFYMTRYaVZjSGF0?=
 =?utf-8?B?Z01TanFDakV1YnlxT3dkUXB3ZzZuTkV3ZFBteU5RaUJmR3pDM0tmL3Vpa056?=
 =?utf-8?B?Z1RqWlY1Mng5VFVOWDIycXVwcGZZV3dRSWQwcHg2WlNpRVFNeG1tVUdYM1l3?=
 =?utf-8?B?ekgrUGhWMi8wd01RbjhWVjExdDhpWGhYODEvVlBMbUVRNXJ5eGhyUWpaclNE?=
 =?utf-8?B?dUNkSkVxck4xS3M2cGR6R2hzdzJXR01ZUWYwOGJqMExMTGxCcFRSNzRKRlcv?=
 =?utf-8?B?dlc2Nk4vdFQyZWxWYWxLSzRqT0d6S0pYK1RBQi9QMUMxVEwyT2FxSkxCRGxO?=
 =?utf-8?B?UjdzUXU4Zi9CQjMwamd0N3hETkdIdjlsc2dXODZ1dmdLRHZGM0NheUg0bXhC?=
 =?utf-8?B?RTM4cExMUGJHTTQxL290Zyt6ZlNnTmhZcXdUNVJyUEU0aDJoSWFxVDl5OCt3?=
 =?utf-8?B?M0daWFpmbGpZUVptT2ZmVGZxRklqOVhERTlsaDNHM25qVS9Gc20xM0d2VXM2?=
 =?utf-8?B?TUYrakNrakdscXJxZ21YbmZBOTdnNVJhd28wWUJWVDhOc0xvL0l6OFNTMkFC?=
 =?utf-8?B?VlBseDNIU0pCQmJXSWpxNnJFcWFCNGs0eXFkOEQ5ei9ZdkVMdXFTNmJvY2Nv?=
 =?utf-8?B?V283V2dRSnpRT2pZV05aVCtaalpvWmc3cEszYWE1ZEd6dkx2NWRrbXZjQWgx?=
 =?utf-8?B?MmxOV2dqd0pMOURzRG5HbWFJMDBSRGUxaVFrY3Jja01aYWcrVUNOQ0NGODVF?=
 =?utf-8?B?ZGlNK1o2alJNZmJua2prQVp0NW1xdVBJYlhhVlZ2dDJQWTExTVYyM1RQa0pO?=
 =?utf-8?B?cVhCbWJ4WXVZTjhUai9scnRrMEN5MURnVHNwSy9ITkg1NVFaampLcG12L2Zq?=
 =?utf-8?B?bS8waW1RRmZ0WXFBQm5makg5MEFCUlZEZUNuMEhJSnNYZFFQMFRUZWROOG54?=
 =?utf-8?B?VGozcmpzZVBBdWRpaVJFaXh1a0FmY3p2QXE4YjlMYllVUXlqRHlIcTlrZDlL?=
 =?utf-8?B?OXRiZU1LWTh4aVVkSm1iUDRJTkdQOFBsWVpsQXd2d09mb1M4anF6aytVeFFV?=
 =?utf-8?B?OE5wRG9jeTk3T1BWVVJ3WHh0TGZzbGdiRjAraHFtZzNDY0RBdXVZTFVqWUxU?=
 =?utf-8?B?UTFYb2ZYSDFXNTNGTUJGMS9FQmxsZXJYR1ZIelNKRGtJUlZqSnFXVklQRkhS?=
 =?utf-8?B?QmNaWHQxUW9SaEVHN2IzTWRZdTd0bWNlMWZEdzJNYUVkSWFkSVRLTWNaVEhW?=
 =?utf-8?B?WDBpQUd1TFNpRWZQMTBmYjRLWXYya0JLczl6VHN4Qi9raDNGSk03dzNCNnQ0?=
 =?utf-8?B?ZlMzeWFDdFp2TDFPT05zT2JPckNDcnFNZkNYdWlJYmJPK3gzUEh2aVdTYTRR?=
 =?utf-8?B?SkNGMHNNVVFlRE9yMmY0WWNWRWlDUDR0KzNSV25kbHFRSlNIaThuTDI0cUd3?=
 =?utf-8?B?VG13ZUd6cWRoNnZBVCsrVEk0UkMyWWFBNzdNaHhUM0xDb3NMdWg3VnVCSmdq?=
 =?utf-8?Q?HWPMxWPNKQ3tROvoHumKYjBJ8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8918ea03-ecd9-411c-0d6f-08dd817acdd8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 08:50:59.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4Kl2NZqL9DHFdUq4a7u/OOaGHlmnKSRH5zP3BCUMAvF/n124nJaEkjBP2AlmLRo2ojGlNBgYy4KVCnCrbw8eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833



On 22/04/2025 11:45, Qiyu Yan wrote:
> 在 2025/4/22 16:14, Mark Bloch 写道:
>> so you want to do QinQ (not sure cx4-lx supports qinq)
>> or just different vlans based on the traffic?
>> I don't think cx4-lx supports vlan push offloads.
> Just want to grant access to different vlans through a single VF, the command with ip
>  $ ip link set <interface> vf X vlan Y
> filters and tags a single vlan. I am wondering if there is a suggested way to "pass-though" multiple vlans to a VM that I can create vlan interface in.

Usually you don't want the VF to be aware what vlans are used, on egress in the FDB you push vlan
and on ingress in the FDB you pop vlan. The VF gets the traffic without any vlans.

With the TC command I wrote you can match on mac (or ip, tcp, udp etc) and push/pop vlan as you want
and with as many different vlan as you want.

> 
> Maybe this patch is for this: https://patchwork.ozlabs.org/project/netdev/cover/20170827110618.20599-1-saeedm@mellanox.com/ but it is not merged yet...

This patch is from 2017, it's not relevant.

mark

> 
> Or I have to put the VF in promiscuous mode/pass-though multiple VFs?
> 
> Qiyu
> 


