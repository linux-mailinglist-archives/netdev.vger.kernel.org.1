Return-Path: <netdev+bounces-224345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF79B83EAC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F571C201D7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80710279DA1;
	Thu, 18 Sep 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C7YbpQkg"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08340320F;
	Thu, 18 Sep 2025 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189113; cv=fail; b=db55EfgFiyShEOaSh68B6SihAQiQdhu6vMlSB57b7YUuATmEe9G4AjgpLdnofHVD0KN+sQToGM/td8VmkeCdtpaDJB6sP5xHyTK9k6ngb7IWNW8p3jJKgLgN/aaL7caz7+SoofBE7Hj6wN3TOgpYIGCzvltZSXo0LlAg+xbFG6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189113; c=relaxed/simple;
	bh=o8hhSuwNVwP4uCP95S/x/qv9TtXhRRf+h15KNEi3iiw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HIdQU29u6qEstlQK3lj2dS92Cx8if4wYzcydZo4147zddyNuj4OaClUKkMIbA3k/x4nq8lgmBsguQvXPt3XsbFxWvTRjCDGaPxKsK5xxkB/GIfAuI3+0JJTs1fxLCJ1n2YVHjNNnDlNO8o8pCiSwFetkEpZPiKByWrU4/wg0izo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C7YbpQkg; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvyxUiXA+hziBjUdvTG/V7nzaph58Q+ReQFObbSLH2G7bs1TnBd8QcgHcvEC+LwkxQvmi/U0FM8YSPSEtJUwvFvL70cafj9uZ2YDvaQz2c7I5dYPu6SzC27x2FW/SN/q5isKUAz7FtVUy2upcMrPcVUKcvdCJBFl9/DeFXBbg5lgMA/a6DKpXDEwRYgm74UgHNx4bO6DZ9uOJR9WI0FTV9yUYiqGFjDxin38PRjevBC8yu6iX38NbwyTD1GqpJBSvKXfu3CERAtfm6Y6g4Xrd+XrgqZAhcBaNK/7xZ8DG6mSNav/ZLhF2xz3Szl2VvcMYWik2e0zdlZf9LJEZB22hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX3y8dchIGtabxpqVAlUBQ5pKTCy5aIpB6I6YXGpWJU=;
 b=aXySn7sXDEuyidMiE0lSjOXcYDmP4oR0WJ6zXB/u6VH+DSpCmbMh5NCY20ZkABrXc+2E8mTIIVWFnCRW2foOvtJHgBXFLQZoM6wLbqQQtGWVeICbAu8vKiW1Fe3qdS5R9yQZQGAlUSR1WfLmampxD/mu43T2YYNykf6aQ+oiPKnRXXM4eYLbLw+soHAvtCGiFXmFdrPLrl2eZmVhR+udZWgYh+inKucGz88uGc5uK0VykNxccXrwcKaO3h8/TU+1+yOb6mcexzin4CEYx8tUe9l2kz6FCAZerEILSIxdNjspG7F5o6x+UZU31hhU+uC+ex1DFBurWMQpd1486Whjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX3y8dchIGtabxpqVAlUBQ5pKTCy5aIpB6I6YXGpWJU=;
 b=C7YbpQkgkULH06j+m5atJGfw0RaUGUK+UlwyuG8NYsUhik0vgIMdFsEUUl2cCcRJJBTY/+MYRSFcPUGM88kXMDDd0PLOaBLAbY/C7x2NTrV0i1JZT73ysIrZ+KAT2jg0vQf6xfW6pWXOb2FdR3GCCLxqnHLY1iy9thlNE9mD2Njs3CiwXkokiuCK7iGXhxGY4V+Q9ikvvVMR1lk2pxWmeet4fnzqY70gSJJRN0cI3waUwVEUlyHvu245aLi+wC1BFYumcGKBIUE+NP5UZTb7fbLYzloVvHHIh5LtZUIDLhBDT/8RhivsnzVQrnlWA46gBQCzsHoTLuRTVx+EnD+XVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:51:47 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 09:51:47 +0000
Message-ID: <c7ac9e7d-2311-46cb-8c34-aba2f010c2c0@nvidia.com>
Date: Thu, 18 Sep 2025 12:51:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250918084823.372000-1-dtatulea@nvidia.com>
 <20250918091341.n6_OgbOW@linutronix.de>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20250918091341.n6_OgbOW@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 480b7928-11d3-4669-3fa4-08ddf698fb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3lRRXRreEtyMXcvQnVsR0lnNlgxd1ZjS1BxeTNLb0tEVUhJckZOdi95Nzh5?=
 =?utf-8?B?dzJtUmpmRVpTRDBXZ1JlUjcvRjNITi8zL1N0V01QSUhhb09WRjFmOUdMWkFp?=
 =?utf-8?B?YWlnRFZrSklIMHpvdExhNkdUaHlxdENwK1J0OFlpV2x3eEx0YzRrUXEwUE5Q?=
 =?utf-8?B?ZmhaMmc3NTNEdjFFU2htamc2bzZYcFAvNmVFRDVqMVNDT2VRNUNQMmlMYVVT?=
 =?utf-8?B?YTNYVTFXQWc1bE50NThHSHZKV2pGZW9rYzdPNllqSlZpc0VVdlY2amtJMlY0?=
 =?utf-8?B?Q0FvalBGd1NOVzZya0NyaHZSc0E5MjZ3dURIZTF2UFZFcTREQzhYTGdJUFpk?=
 =?utf-8?B?cXN6emx1MmhBL1Uya2pyNFRDblhycU5EQTZyYTB5NjNLUHVnWUtPZjJlL0JE?=
 =?utf-8?B?QStJakYxR1lLdktHazJXdUNMdzR4ZVBab0FBSzNiZGNpNEtUeCszRHpMQmt5?=
 =?utf-8?B?MjdxUWNYZTI3dUNzVzFGQy9veDdTbEhCNjBmdm1iU2txclVsYWtYT1NPeURC?=
 =?utf-8?B?WjVBWWdydFBBNmtiQ040bUNjelVYSGVIQTF4N0J4RDNVek9GQU9oUWFHamRH?=
 =?utf-8?B?K0Q0ZzJrZVdsRzJkamF5YWxyWVlzTzZZYUdTTk9jRHA2VXRnWU85Y0o4YXFO?=
 =?utf-8?B?eGFYWXJabWZJVmszRmxGQUtON3NhY3JBbDNwWTVQdERLYkErRDY2N3pWT0NK?=
 =?utf-8?B?ZkFoYkxOM3gyQy9NR1ZnYUJxKzVOTHlPUk44bWN1WkZSM21QZ2RzN1IvS2tY?=
 =?utf-8?B?UUNUU3RNVjlZRDRLSXFDZW1OZ1A4RWNCcFRqcUlFc2RJaG45MEZsRVhLR1Qv?=
 =?utf-8?B?d1NPYUlpaWQ3OFZ3WkZGK3RLblk3V2poS1pGaFF6c2JtS2lnS3pvT2dOR1py?=
 =?utf-8?B?eVpvNTY1SG1jdVV0QW5pcE93L2hsZEZiWVBSb3JnLzdtTVVzamJBR0VSMEZz?=
 =?utf-8?B?azR4ZXU2UjFRU1ZvWVp5L1MxdzdlOCtIMk9CQmtjOVJDZnl3VW1rR0ZXaE9E?=
 =?utf-8?B?ODRpYVFFN09samxCRHpaM1c2MGJ1OWFtTnhZSU0yR2t4Vi9XZ0N2ZXluVGlF?=
 =?utf-8?B?ZHJWNVVFK0pna2t6a2xxY2NhVTkvNlNUSmQxRUEyMnREU25XRGRhQmIvcCtP?=
 =?utf-8?B?clFPRVA2aVg4STBJTmN0UmZUbkdGZlFjN0hEdGVnczY0bGhkeXcxUURrUURt?=
 =?utf-8?B?TTZ2N3FWK3lPaUdyM0FLNkFGdmg0VTZDcXprWm9pMHpwWStTWk1MQWZOSng2?=
 =?utf-8?B?ZGxwTW5rSXJ2ODBSOWdWdDVHYjV0bGRWS2hQdU8vT0RHQS8wYWx2S2l1RTBZ?=
 =?utf-8?B?VHQ5OUNqNDN3VVdINnlPQWRDU29XNVo5S1JkRmpLeTFQeFhmVWRsMXBnNENM?=
 =?utf-8?B?T0l4Q1NsRFpVNEIwTnV6Um8wOFYwcTNhOHg5SnVvQTVUVTdsWWVpQThoOGsr?=
 =?utf-8?B?d1lyTFFKREUwK3BWOXN1NVZ4ZkhXaTB6bmpNVldWVmZHM2ZnUGEvMXpnUjlu?=
 =?utf-8?B?dXJhWVJ1MUFBS1FvbHp5WkVKdFJ0Mmwvc0ErV2N3NjJOdm53N3NKaDJ5WHpS?=
 =?utf-8?B?alhPQnNjVTJCY3Q1UFRKaGgvS1dNRE1JUUg1RzFsUWhwT1RWdHZXK3N5TllB?=
 =?utf-8?B?YTN1WkJlZzhpV1E3WEhqdm12N1AvbGpPS1JCN3oyZ1U1ZHIzaFgwVnpCZ3M0?=
 =?utf-8?B?MlVCczBPSTU5aXNtam5jV3Jod3hlUWNKcklMQVNqZ1QxRVIzMVQzRERLWW9J?=
 =?utf-8?B?TjZEU01wRGFyMWtucUg5WEFWMmJQQlV2RjVacVc3NTY2a0doOVFWc1F4Qzkr?=
 =?utf-8?B?dUQyVGRKK05xdUpNdU1ScmllWCtVODh2YktDa0NXN0gwQTFpMm9VekJsQ296?=
 =?utf-8?B?K2MyOUNad2s3UU1nZVpOWU5CWUhQbHJWMTBuOGU2WElXVXA0aXRyK0FtWGov?=
 =?utf-8?Q?rPEP74bVZ4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGs0Qy9hLzUrejFueHhvSkFubkQ1ME8zZ1BBNXdUcFh0MDh2RklYOVM5VnFn?=
 =?utf-8?B?bXRUeTQvbzhYTlZLRGVRcXBobWZWakwzS2pQQTlOME5GS1R4VHRZbXVUUDZ3?=
 =?utf-8?B?bTN5STZ1K2pmc2MrRWVjSVRVektscFpZdlZSM2twK2JCenpVbzRBNGh3Tm9Y?=
 =?utf-8?B?TG1QUjRZU0RDUk02QmRvRXpRcWlJSjkzemZlL1BEeWNLazhIQndMNFZOYnRo?=
 =?utf-8?B?ZUVKVDdDMzEySUZRSXUzMEo5YjAzdkRQRDVyRnNYbzZlSkhYYTE5cGlhWisx?=
 =?utf-8?B?VDhlTktOTUpDcTgwSUdVM1FEcHRISmxuVkxUc3pSZmFVS0lZb1gyYWFCVXBV?=
 =?utf-8?B?OVJqNTFSUE1rVGVlUzNSajYyNVBhZVpJQnAveUtFRzVBMjlUdnpkUXYvWkUy?=
 =?utf-8?B?QmYzczJqVHRndjU2VTJBTzhGb1pUVTRON2U0NHRNMklPSmdhWHVPTnNPeTY2?=
 =?utf-8?B?TEE3RWNEUmN2ZEtFNFlzNmZNZEtwVG1TNHBySi85VVFKQWRjL3hjdU5taEZY?=
 =?utf-8?B?bkN5TnJiUkx5em9aSHRsb0F1T003MkR6QXpQWnQ2L2VCZ1gvN0VNemlJci91?=
 =?utf-8?B?M1JGbFNjaVl3UUdFL2dTd2NVUnFFRFNVMnUzVXhCSGxpMlpRbzJvYTlnOENB?=
 =?utf-8?B?RVFhOHFNS3g0VTFtU1ZQZTNSbDZ6MkhyNDBGZlIvcEZEc2dvRmt4RFg0ZkdC?=
 =?utf-8?B?OHZQb3lBR2R1azhQQWRCMC9Yc3RJZGxWL25qZE1qbDh3Ymt6YWg0TXJuK2lG?=
 =?utf-8?B?bGc3Wk1pek13a2NYZUoyc2dPWmxxS3ROK1k4MTNuQlVIc0g0bWdyU1gzdVFX?=
 =?utf-8?B?cWlFUkRuU3c1Y3BoTkV2RkdlY1Nrc2xaREVTWTRWOVJlcURTUTYxZlp2aXJN?=
 =?utf-8?B?ZThDeWxscGtKOWVKOXk1b0dvWFV3ZnZwMW9OcjNsdzU5YWd3bGZxcWVORlM0?=
 =?utf-8?B?Nnk4aHJMSkU0cWtDZzVSZnFlK1gweTFWbDFUNXR0K3diRzIwVzF0N212TC9h?=
 =?utf-8?B?SzIveGREdFlNRUdTa0hmeGZUWm5DSUNVWjk0NXhWOHFxMTBuK25JYTZjalZt?=
 =?utf-8?B?cHZkMDU0TWVnL0djQ3dNOWlKZFluUFBVbHVNUWJidTBkWi9TRTFlbVFRTjZ3?=
 =?utf-8?B?NkNCaFpTWER1dXNCZXo0YW4xQ0lCK3RrME9WUldrNFlyNGcxSzFpTGNzZVYy?=
 =?utf-8?B?REZpaE5UUHdPSFBiSWxhSEk3TXQ3a3BiTFdSMDR3MEpTZ090Rk04L0VMTytT?=
 =?utf-8?B?YjE3Q2pCcUJmTHpMV09EMzE5d00rSjUrRi82L1lzemFScHcrSFh2OG1Na3E0?=
 =?utf-8?B?V2NDOG1EYU13QXlDTlUrUEhTaHhQdTNvbjhEZ1JUb1RETWlEd1VsQmhlY3FM?=
 =?utf-8?B?UkVyM2g0ME5hbkZDZHM4R2YxTURBRC85REI3OUZrd3lEdXdBRHBLK2dINkRm?=
 =?utf-8?B?amNsZDRHd1VtWGlZenhkdUpCTm9yUHpRTStjL0w1emFUalM3UnVDdkFiMXFp?=
 =?utf-8?B?aml1UUYwSUUxaXpmYTVtTXc3OG1ZMit6RzluWkRRSitlUW0zSkR4Z0ViUnFa?=
 =?utf-8?B?VTV5RXdscmF3NndpbFo4bkMxbFI5czVHajlkUlhuVEtVcFphSC9veXFYUVRa?=
 =?utf-8?B?cEtYYVpNRlNGNkYvZjltTWJDVndHcW80c2twVVR2dlpxOUVGdnZzOFdrc1o2?=
 =?utf-8?B?dkZxTUNNMFRYUnJQRnprTGN3QnhVZGNISW83cVFFN2JodnhaRENKN3BxT1RH?=
 =?utf-8?B?WXI3N3o0TjNwbFdIUEJSYWFWQ1VxVkdBczMzbmE0M2RRa1hHQ2pSY0l4bzhx?=
 =?utf-8?B?eTlsRzR4TUg4RFNPYjQwV2QvTSsxbnZDNmlJSkxET1lveU1VSGJYQVc0aGMw?=
 =?utf-8?B?NlU0UUQ5RnVVR24yVDVSblJVdEcxQjNKNFFJV29qYjhJUzJ4S1ZhN0w5d2VZ?=
 =?utf-8?B?Sk5HRlBBNzBqaHQwZXI5UlRJcTBwZnJIcXh2Q3FQYTRrWnh0RXdkSTZjSlVI?=
 =?utf-8?B?QkxkMU5RQ0lRSjVhT3daeWxld3p1ekdqWXBxSlRQVkoyTk40RzZFb0hmbHdy?=
 =?utf-8?B?MC9ZcUZ1dmtacmJEYTBvbFd2UnRwVVUzcVFFNjk3a1NMUEhuNzJVNm9RQUtC?=
 =?utf-8?Q?M2CbKStARePXpGyaIvaA5BZeF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480b7928-11d3-4669-3fa4-08ddf698fb5b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:51:47.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld90TcZhdOEMfKfK5HkYeiIR1mogxpZiMADzovlQ5spQ4/dXZQqFxxsrABG0fx99Hj3RGHUTOOXgErGjdNIr0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164



On 18.09.25 12:13, Sebastian Andrzej Siewior wrote:
> On 2025-09-18 11:48:21 [+0300], Dragos Tatulea wrote:
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index ba70569bd4b0..404064d893d6 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -768,6 +795,18 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
>>  		return false;
>>  	}
>>  
>> +#ifdef CONFIG_DEBUG_PAGE_POOL_CACHE_RELEASE
>> +	if (unlikely(!page_pool_napi_local(pool))) {
> 
> if you do IS_ENABLED(CONFIG_DEBUG_PAGE_POOL_CACHE_RELEASE) you could
> avoid the ifdef.
>
Ack. Makes sense. 
> A quick question, where is this allow_direct argument supposed to come
> from? I just noticed that mlx5 does
>    page_pool_put_unrefed_netmem(, true);
> 
> which then does not consider page_pool_napi_local(). But your proposed
> change here will complain as it should.
>

Good point and an oversight on my behalf. It will indeed complain during
rq teardown. If there is agreement on the approach proposed here then the
mlx5 driver will be changed to set the flag to false during teardown.
We used to do that but removed it for simplicity.

Thanks,
Dragos

