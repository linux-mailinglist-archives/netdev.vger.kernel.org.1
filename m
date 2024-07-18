Return-Path: <netdev+bounces-112094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08216934EE3
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8573D2849C9
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2D1428E6;
	Thu, 18 Jul 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g8hacY+n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C61422B8;
	Thu, 18 Jul 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311720; cv=fail; b=qfOAVp1LRr2jupLgdFu8dOMU4dzr2t4HmUmq9i4wTwmTjlzEwcS5VFyBfVe/TPH4NCnfZbVdKyg8pW138cOah/WNUHIouTi9G5TlGOqaxfr1xDoU6PNmqXOIWr9bmH+hwAzCd1OrClrNwIZxm61SyXAybVgX08IliPnxnyyLq2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311720; c=relaxed/simple;
	bh=qFUh2VBekQ9nKYe0HMJQndHDcJ8IBZxnTdDgKXOtLpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lQ6XFfyKqLCLi+uqRSD9R/FSoLovMGzUl7NjK7PCZAwV49PasMVM1+VClosi59S38CpivSTUhL73bOoRGZdHcz5kvPD4qBBbpHIudLrYfzNFUbiZZURb1IFR40xxFQQYeSaff2iI6vNblUuCNPdsLSESXV0NuLZ0MOsSEKkGVns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g8hacY+n; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgyidDbkyThhJuffO6mEElQjUXTRH2eJdstiv6rSiNHPEzdh4vLKV15mmP2KfMQ99ccHRLFNlQY8Ic19AxyLD41VF5ydeNPpBc/VLBEGXp9U9OGZl+uQ5L7gXnKRIQOO+gUGQe8Tq7DRmenO8fYpBlrigMJCs3rOkxyr1O6Ru/wfK2Uw7ir8wNUlICVSJkZsFs6GK8K4pIp1O5eyanF6mc1o5cUCm5z/B3b5TY9fKBvayYP2SVRUGmoC8DBmu5CvbvjPFTSACHs4uXTdWcbFNibWvcwys1/weVnmDPsOaaB9812qOo0LJmIZyd0E5gXG8ircTyilD/mVlMXl1UiWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4n9gI6PZyb+YrN4g7r1XftxbC5saHakX7jfId2LGFY=;
 b=Ah/yNK+2p2DM+vftpfPMAasV0g5ru1a4fWeEiG79zwXgxzV9JejoAqzWtBw53/mWYcxJ8sli1GcA4BGpqen3GzglxnokGuQM6VjKHWMtWmVIIdL7y17nUI9B0BReypaOr39IAfwwSRXou+r2IN7+/hiLzYS+0dsY/fFAv4qHPn4JGTn5qmSFTEIh2xD0N/Dq6PUGH++DPuOUqc9BZ1k9nck/OrEZF5Ohg1CR+1xdY1Za14AIAh/BVcq9kB0WpM0fwT8hJGM2MaZTsQSVQLyHJJlOLoyJjpGAcuJIOoJ5VtKQKiGRlJm0CJ2AgEuQIgeq8H4ekn2B8fStX3LQfd19fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4n9gI6PZyb+YrN4g7r1XftxbC5saHakX7jfId2LGFY=;
 b=g8hacY+nzJwvHN7GK/NBUQL3ZGbqY03e+5lMc/sBL6X3kkKHucFTq2E3K/okp+aP4q3rRycFFNDC4qgIDSOBaz+RjEff3wPDRryHissI5U9zQe31gR4E6vQ3W1rc7RZbMH3mSUp7m6/YksDF6TulIXwx7DFaz2ezV9y/6c87Gc6YIpoUhL6ninyvHdx+l/l5h5vuGTdlCPYMdsCl9dtut6Uku1/j3J89IQ3giELjMq4JdQwMPmsXKc7Vzil2EWudaKOpclYlsIPf+MCFDMoJ5JpL1njplTkOOOV0pgnBRtkSWION3X0rV3EgH/0zQXg6zB/w3Wq99fWJ3Mhw7l8i2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.32; Thu, 18 Jul
 2024 14:08:35 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 14:08:35 +0000
Message-ID: <6e12f5a5-8007-4ddc-a5ad-be556656af71@nvidia.com>
Date: Thu, 18 Jul 2024 15:08:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the
 GLOBAL_CFG to start returning real values
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Brad Griffis <bgriffis@nvidia.com>
References: <20240708075023.14893-1-brgl@bgdev.pl>
 <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com>
 <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
 <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0313.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d44c5a-7e75-4580-d059-08dca7331ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFNFaS9kb3kvYnRJWGZWcnFmd2Q3OCtXZGVSZGZrdWlyOFRCQTlVQ2xQbHRU?=
 =?utf-8?B?amFoaVVpdEovNXBMaG13VEZ2anFDRzVKbFlYTjh6R2N0MTZYaDREalc5UlFF?=
 =?utf-8?B?UkZHZHZrYlB4cktkZlF2TjVialRQaHFSZ2hIOWxZc1diSGViN0U3Umx6MlY4?=
 =?utf-8?B?cXdoOWVOampjUGxZV1dFQUloVXJZREZ5VmVOdWUzUUsxSjNZdVMrN3lhLzZa?=
 =?utf-8?B?TytHSFQzdVJ4anYvaEd3cHF4UWZoUUtsbXl3UFhWY2Z1T1ljVmtFaE1GOTc3?=
 =?utf-8?B?dk9ud2laNjFZRlA5bXl4RkszSkQvWk5LUG50Nmt5NEYxRFd6bitkSFVtNTN0?=
 =?utf-8?B?NmUrMG43dlZ4T09EYVJBWGxhZ3ZkVFUvRHg3UDBlV3NjSkkxMXJPL3NFejlE?=
 =?utf-8?B?ektrRXdZSmQ0L1hMNzdQc1VBbEk0NGlLa0dEOEkwVTJMcFdEazVhMlJIdGJE?=
 =?utf-8?B?NmQvMnV3MzFhQmhtZEhxeFlrNWJ1eSswcENaWVFUT2pJaUZMa2FpWlBiVGJM?=
 =?utf-8?B?SDZBMHJtdGhXWTRSQjJyYWZkZHI1aXlybk9zdEJ2TFBPWmw1eGN3OWxXUXFF?=
 =?utf-8?B?UUdEd0YwQnlLeHBIVlFKZUQ5RVpCTnd2L3hsL05sVGNtbUF2TG1WZmlpUTJC?=
 =?utf-8?B?VUtXL2xYaWc4WjVwZDFYTlNYNEZLNTBlOXNSK1dOR0MxYmpVU1daeGttS3hO?=
 =?utf-8?B?ajE1T0Rrdk52VzNvZVI4cTdNYUJXdnRBckFnbDZUK0JDOUJ4ZkNPSVFLajR0?=
 =?utf-8?B?Z2xlaEpmQldmUGNiaXF3UWsxQ3EwZ1N6MFEwTFhJbHJOUmZSZDhFT2FvSnZZ?=
 =?utf-8?B?VDhWUUp4ZUg1TmFZZ0lFUUlNT2dlck1lMEVCVHo0Q1pPVEZDUkFSY0R2eHBu?=
 =?utf-8?B?TlBadlFxREFtMmtJWTZlVHF0dXMwRmdFMXF6WDBoMUJjcXFlaEZDL21KbFZp?=
 =?utf-8?B?SEY2RUlJV00rMWo1ZTZ2VzJUektVVEpjK2x5MHBKRTFWL1RtSGppb1Nnd2tj?=
 =?utf-8?B?aWlONnlHdlRPK1lDS01XVmNBYzFIWmlKT01lRWp5aitwQ1RqOUxWa2QvQ0Zp?=
 =?utf-8?B?QnNKVm5mTnpxdjJtVnNhUXdPK1FicElSaHJXNEZhZGFQNko1U2t4Y0IvNzZV?=
 =?utf-8?B?OTFEQk1ZZG11RWIxUjc5VC84L2ZLYjdmNDVkMS9OUnhwVC9xTjJndTBRRHoz?=
 =?utf-8?B?L0J0NkE3elJWUE1QTkJJNnc2bjNaY0F6c0JjVy9NY3FQVmozb0dqRDVVR0hG?=
 =?utf-8?B?V2ZUZHo5K3BUbDROUDI3UW5PS1hxeGxmT3dxWklwUy9Xand6ZzZ4UzlGUmgr?=
 =?utf-8?B?T3hqM0xENklMRTZGaW0xd3FHcWtZdWFuZ0paWVM2ZGVWNFNydldiLytDYnl1?=
 =?utf-8?B?T2krZG50Y0tsT2wyNnN6VFJZazREdUZWYVl0RllqZWtPaDJUWWNqMXRxWWhn?=
 =?utf-8?B?MWFyWWZMTnZIZGFuOEJQemNYd2IvMmF3aW00cjBpbEt3cXNlS0FreW5BNmJ1?=
 =?utf-8?B?TnJRODhBWnd0L2wwcTZsYkJWQmc0RExKWW5lcVI5UkdwdG0wWXpJY21ab1hB?=
 =?utf-8?B?WFhIQkhPdDl4b29oMlptTnZTQUhkak5MYkVMYkd6N1JXTVRxUER6Vk1QRUp3?=
 =?utf-8?B?Q0pTNWhwVnNjNERWZmUyYUg1aWFNQzlQSk05Nk9VZCtsaVpJT3RDWUZKQ0F6?=
 =?utf-8?B?VGlZRXZkSUMzYXBDY2pLRXhoU1lXdkJWOE51TndZcGJ2dGFLUTR3a0JZMHhy?=
 =?utf-8?B?VzBHRWVrZUVEZnQrbGdlTEUxbXI2V3hwNU5WaFp6R0ZhWWhZR0QyZjFVV2Zy?=
 =?utf-8?Q?Dao7LI/sZNAE5HMGoEKv+MjIpzrTABlpuRVCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elgyYlBJLzlhNFVPNTdMS1QycnJraGlNWTNKR0FocjlvYS8yaU5TSVUwSVo1?=
 =?utf-8?B?WkRKTlg4M2YzU3M1MnpROVZKYU44cUFDVjBRa0E1MW9HakwxWU1iTjJKYVFj?=
 =?utf-8?B?K0x6QzJaRS9yNWdJYWlwS1JhcXI0aEN6VjNnd0g2bmsrZDhaRE9XaTZ1TEQy?=
 =?utf-8?B?MUc4eGxidU1SK3RJZEJKejVxNjE0dDdLa09jKy9Oc29RaDRqSGZReExQNVR4?=
 =?utf-8?B?Q3p6emhEWnlCZ0kyWGJIYU5hTFhjVkJZaExTclVUL0FObm9NSlBJQVhhV0dk?=
 =?utf-8?B?VWxCeWc4QVk1WHVxK2ttdUM3Z2I1dFM4MDJwUnN2c2p2RzVVeThaaW1QS05l?=
 =?utf-8?B?bU81eUEwclJ1QVlwczNRVFR3S1A4VkxOR2FFZFZEUDRHZnRGeE1ucFA2WFN2?=
 =?utf-8?B?Rnl0RDF6Q3VGZC9zUXl4aXBmaVFyajRDVTB3VGpEZHJ3NFdXQ0RZNGFuMHhx?=
 =?utf-8?B?bi8wV3lBb0xkUW1hWC94ZXNoTFpNV29aNzFzbVBQa1RzamxUdFAwM1dXUUNY?=
 =?utf-8?B?VWRqTVZuOWpMZ2d5WGFRemNJTHRmQmIwb2MwYld6bXhCaWttSjhDSUlDa3l1?=
 =?utf-8?B?d0llc1FqR09vVFJYNGJBUC8razMzTzlTSzVZRGxvbURPYnd1QW53ZnFXdjY0?=
 =?utf-8?B?cHFST3c0bFVONU9NeWx2SzFpbk5JRDlIQStvK0M3eEU1Z3JFK2llZTNWTXFi?=
 =?utf-8?B?YXNBc01tb3hhWHpCc01VYS8rZ1Z6clZZdHdpZ3FoL2hBeHBkeG9nb0pWL21o?=
 =?utf-8?B?TlE3bGdHRUtrOWRkV0I2TldnOUxIejdWSXlDTlA2b0xLN2NpeUpEdjFWazhq?=
 =?utf-8?B?T1N0TFZXSklZWFN4dGFWNEF1Q0JYWVJYTTlKekNaWHErR1pjRWcwbFhBN0t6?=
 =?utf-8?B?M0RLZXFieHB2cUFuUFQrSEt4a1JKeWg3ZUt4ejZmcFVPbGpiTW5tcllLSXdL?=
 =?utf-8?B?UHZnRXlLSFR1ZEJiaGsvZ2NkZlhaRjlvR05ZREluYzJhOElzNFJ2YlNsU3du?=
 =?utf-8?B?TFFodW4xTTR6eTc5QlNjb3M2S0dOUDJYbkpmMnR4dExxT0RxL3YzRmhKYzlO?=
 =?utf-8?B?V2txZ0hIem9NQk5VMFdkbDBUTXF6VUpJMm51Qkg4cnl4V1NwM2lSaTlvU3Zz?=
 =?utf-8?B?OUYwaC9LK3BReUhyNVRXbjNNQ1k5QnRkVEVVK01yUmpLU3ZNZWJpSEpiaENY?=
 =?utf-8?B?d3BQNWtyVktzdUVxVTZKTVgvNXNsNFZkVUpRbkhHdXVValdnUE9mQnRzN01J?=
 =?utf-8?B?eXdFZEVTQjhpd2pNbTdZeFI1T3BXcnZlUEdxZXJhSWZNR2pRdThaL3JuWk85?=
 =?utf-8?B?TUN6NXdkVzlHNVNDRUlJZ0JEbHVrZTYzR1VSbWp6b0R0OXR0cHFreUJTcER4?=
 =?utf-8?B?VFBETWlIWTZhTWFxY2c5Wk0vV2ZBazdoUVprYVRzZVlYdjZNelI2WFZPVUFr?=
 =?utf-8?B?eGlZL2QrYU1xNFUvdVpybnl4dlU5UzZoa0VQUnVzM09TcHZyNm9BaWd6aENG?=
 =?utf-8?B?RWR4L3BHOHIzb3ZkbCtPQUpFb1lma21KWnlGVS9aTXQzOGgrZTBtUm5UWEtO?=
 =?utf-8?B?YVRVc0lMQitqbUNLS0s3dTlIei8rdDdvZEZhNDUyb2xwVFdyazA4V3p2di9y?=
 =?utf-8?B?dmF4RXVjenNHSEtiMlhTTjhhYVRVMVBVbFhDWm9vZWxmOXNvdFB5NUJjWlQr?=
 =?utf-8?B?ejYvc084RzlOMXQrdnFGb3U2UWZWY2UrbFdFUzBQa3FiZjhTZFQyaURqY2cw?=
 =?utf-8?B?M04zOU9KS2N5bDNKRHdPeEtDb1NHVi9qS3U0eTBpbVovYmMyWHAzSzFOVEdF?=
 =?utf-8?B?NGhlRkgyOUhabmt0QlE2RUNScHBrMm1POTNtV2xDR3NXRnFOQytFc2ZaV3pW?=
 =?utf-8?B?QllMT0dMOE1wQW9pNjh2c2N4MGh4d2J1eGUxZzFpUzFUSXoxLzFVbkd3RlNZ?=
 =?utf-8?B?R3FLN1NXNHFWQ1FnNWFJYld6WDEwalREWkFiMUVJaWIzL1lrZnhxSm9CcHhB?=
 =?utf-8?B?d0ZNYUFkNjhUYTR0eWdpbjhxaHJHTFA4RkoyWE8vU05TMmt6QmZEbVlVYXln?=
 =?utf-8?B?eXo1L2Y3OUMxUno0NnJaWXJaY05nOUgyR3lZZVFxWWJRZ3QvTkphZnMyTFBu?=
 =?utf-8?Q?cyRZTT2fzEaUS4jASw4Q6TXnm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d44c5a-7e75-4580-d059-08dca7331ce7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:35.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9dmckSuDbcBnQWPUBe5FoFJppv5zcWEBkDscNmUhAw5HWwYHYAcoPXYvk1jzBXvWb/n0DqWTa6aRThSR5LiYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056


On 18/07/2024 14:29, Bartosz Golaszewski wrote:
> On Thu, Jul 18, 2024 at 3:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Thu, Jul 18, 2024 at 2:23 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>>
>>>
>>> With the current -next and mainline we are seeing the following issue on
>>> our Tegra234 Jetson AGX Orin platform ...
>>>
>>>    Aquantia AQR113C stmmac-0:00: aqr107_fill_interface_modes failed: -110
>>>    tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -110)
>>>
>>>
>>> We have tracked it down to this change and looks like our PHY does not
>>> support 10M ...
>>>
>>> $ ethtool eth0
>>> Settings for eth0:
>>>           Supported ports: [  ]
>>>           Supported link modes:   100baseT/Full
>>>                                   1000baseT/Full
>>>                                   10000baseT/Full
>>>                                   1000baseKX/Full
>>>                                   10000baseKX4/Full
>>>                                   10000baseKR/Full
>>>                                   2500baseT/Full
>>>                                   5000baseT/Full
>>>
>>> The following fixes this for this platform ...
>>>
>>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
>>> index d12e35374231..0b2db486d8bd 100644
>>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>>> @@ -656,7 +656,7 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
>>>           int i, val, ret;
>>>
>>>           ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
>>> -                                       VEND1_GLOBAL_CFG_10M, val, val != 0,
>>> +                                       VEND1_GLOBAL_CFG_100M, val, val != 0,
>>>                                           1000, 100000, false);
>>>           if (ret)
>>>                   return ret;
>>>
>>>
>>> However, I am not sure if this is guaranteed to work for all?
>>
>> Ah cr*p. No, I don't think it is. We should take the first supported
>> mode for a given PHY I think.
>>
> 
> TBH I only observed the issue on AQR115C. I don't have any other model
> to test with. Is it fine to fix it by implementing
> aqr115_fill_interface_modes() that would first wait for this register
> to return non-0 and then call aqr107_fill_interface_modes()?

I am doing a bit more testing. We have seen a few issues with this PHY 
driver and so I am wondering if we also need something similar for the 
AQR113C variant too.

Interestingly, the product brief for these PHYs [0] do show that both 
the AQR113C and AQR115C both support 10M. So I wonder if it is our 
ethernet controller that is not supporting 10M? I will check on this too.

Jon

[0] 
https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-aqrate-gen4-product-brief.pdf


-- 
nvpublic

