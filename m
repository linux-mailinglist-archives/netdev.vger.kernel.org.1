Return-Path: <netdev+bounces-105249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D59103E4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F401F21A09
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABAA1AC451;
	Thu, 20 Jun 2024 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="LdNdEYPh"
X-Original-To: netdev@vger.kernel.org
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1FC1AC424
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886243; cv=fail; b=mQVLgMJvK4YyK4TxjSaQoBo05n3l61Hy+5Nvm6GeamG7CJCzoiP2gtEtcSNL8U4MDIq8FLdWbhfwI5O8aKP3lJ2gf5F3p2EMAOZfo3hNWOPjTmuYeIFZKbgfh62EImi4QQRGxmQEr7sn6inx+BVMq3YPxo9+j5qDp9IVI6JwnP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886243; c=relaxed/simple;
	bh=dYQ8c40brY8P1cnuVvGfvMzzVVZR8lVQzDZOZTE2mDI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f9DPIThf3kvcdYMN6hEobgeO/MALnuR+KXgtKUudnhBBNyqCdESbvKzIGzufFdUj/pS77kfRsjnmVSi8+DG6uGnVY5GPlqZFPKoT+83IXyRUdyhjIl7O6WH1/+X2ss5IN/FhoVG6GF325DeJlenGkbW1WrRgHrcNwynrasgAQsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=LdNdEYPh; arc=fail smtp.client-ip=18.185.115.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.174_.trendmicro.com (unknown [172.21.9.50])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 53431100DCEA0
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:01:12 +0000 (UTC)
Received: from 104.47.7.174_.trendmicro.com (unknown [172.21.162.72])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 7D4DF10000E29;
	Thu, 20 Jun 2024 12:01:05 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1718884863.902000
X-TM-MAIL-UUID: 714caa17-c701-4c7a-bd3e-e4c2496fef40
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.174])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id DC744100382E9;
	Thu, 20 Jun 2024 12:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqRmnrbGKPV2e+Bkw+TTxXOCh3AMdpEWlS8y7JZmezcrYypGxgxFBI4TMmRS0Vvd6ZAQvLVQ3UbRwd1mcbB2F/wd513BAYYjiSDUrWpCT9b1INuJKc3et2MRRtHSQs69ROmk3W2mMhzgp99A4NFjw/+aMlh+KtcRCjSf+1Pg9m16f0kr3IbvD9Sl5AU1Ma2hWQtb//7+K3xrHDtJEqZgt8cekDDYgXbM8I+l9czmJM/mjYBnZlL8xqt/LWEfYZpDyUaMmwx0pNcaBAEg/P2QO9/gEFTyJcjgIWhNk2Y9ItTRrpq1wkFtb2/8Tms7+nAK0L9SEVDZNzhmCj+BEPt/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s47X0+fSe7HjivAUDR0hjkSq4uofUyg89sDvRsIVF/s=;
 b=D7GQ0V3ZoVsOPdw/plEA02Ypd1oZ0X/bBYa/9k5D20tZ/gS8N11cQmqN2puh4QQC+bzifwNzsqkbqrRWm6ezJiJ3YsKgas8aWellE2FWTpDjoirYNlYRNyYHDxh4HbSEW53FaZMbBygIQsctbypK5JuihNCVUU4xPnMyHQBMb6xzMSPigtYSUw1nomPwim4hGYviSQtXA10VbepV6IF2Iw2wWjt3AL/rC76IMOUNm4SBQPJcvA+RLa/dsJEysiyodyQZu8CR/6uqH8P7noFo85W1JJBh4jSMHJK+D6932feVKY7R56YQdBaumnVyL2jcin4v9WevadU2pQhvB9PC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <647cfef4-bcf1-4156-b6ae-b2e089778096@opensynergy.com>
Date: Thu, 20 Jun 2024 14:01:01 +0200
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 5/7] virtio_rtc: Add PTP clocks
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <20231218073849.35294-6-peter.hilber@opensynergy.com>
 <e0935a7cc42ad34e71c17f3b5ada4a16a8d1f539.camel@infradead.org>
Content-Language: en-US
In-Reply-To: <e0935a7cc42ad34e71c17f3b5ada4a16a8d1f539.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::17) To BE1P281MB1906.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:3d::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB1906:EE_|FR3P281MB2798:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d02d69-742c-43c7-b28f-08dc9120a81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVZpK2wwZFJVVlVwYU9TaW5ITHBETUZ1aHhQVnFYQ0dsWktGTllBc2Z5RG9N?=
 =?utf-8?B?K0t0cVZhVk8xTkZPZUdqT1VjQlQ2Z2NZYkhZNGhsc0JLVkVUcVNjVlFYcXlt?=
 =?utf-8?B?dkRwZWZ5WUdoTnhmSVVoNDlUKzZ3UWVZWUx5bjBwempCdkhQTnorclpzblhh?=
 =?utf-8?B?d1p1MnMyN1Q3cFdzclRLVTJKaE92U2phTUtlNTFiUytMbU5MQ01NNHZQUTJS?=
 =?utf-8?B?eVR6RGJiWFFxZ1hFdlJqNTlwaGExR0VRdnZOYkpOQkRIejRnMUh1K1N5Nnli?=
 =?utf-8?B?RW51T2d6UmVSVmxJMjJ4d05SWU1GeTVSQ2FMS0tRa2duZURVcXIyeVRKZ3Rn?=
 =?utf-8?B?amQzcUl5bEVoRnVNeGZjbjBtZTcrbHUydmJZY3FZbWx6a21FOVJSbjhIczlD?=
 =?utf-8?B?cUJNcUFVSjU2MjlYMzdGN3VjemFWVmFKenJaQ3NyL3FEa0pyQ3dCdER1d1Iz?=
 =?utf-8?B?ZjJOSW9HYlBjc1pmS3ZuR0lMODZtTitJdFdMdjkrbHBPM0VvOEtoRXNTOC9F?=
 =?utf-8?B?dndIWEhWVW5GL0hvZ09XZ2tVbyt2dk5COWswekdQdEV3TWtaT2ZxQ0R6VUt3?=
 =?utf-8?B?enRFQkx4MlQrNVV6YlhPWUtzYzVqV3VsK3NjM21lbG9jWGd0UWxZelZhUXMy?=
 =?utf-8?B?dWhFN0hNN2JJdkQrNjdVOU5SejhFaU9BU3N5S2xlL3lyY3YyNUdPL1lVQTRF?=
 =?utf-8?B?R0hWOWhPYmxBWE94bUlYeHFOK2p6cVhrQUhiTDVHT3FLYTlaUi9YWHNIanpP?=
 =?utf-8?B?amJxN0FvNjVEb053c3dYS0FlVEtORk95OEhkOUdYZkd3K1B5YlhSTUZIWkNH?=
 =?utf-8?B?d05uYmtqQTdyY21LNFZvbGJRbTNORnY4eHROaHpkdmtNYWJ2QXFhN083MlFx?=
 =?utf-8?B?L1pYSG9EVW1jTmo4MTFCa2FMVENGQmxVcHF3bkozN09ZK0hEaWc0ZU5pMDA0?=
 =?utf-8?B?NnNwM1ErbWIwTXhjN0pTU2taamtVaWhUM3FseENXNXB6d2FLd3duckNVbnBt?=
 =?utf-8?B?UE0wcGpoSnNXNzN0MFBvZG94TU1idkw0YlhVZkZldkVKUldXdzBHeXROY2NU?=
 =?utf-8?B?enhLSEVqclZ0OFZKRGJBVUxkdzQ5eFlWYWJiVlRhdXB5aFIyVmFIUDZxb0ty?=
 =?utf-8?B?RVhCMEdydWgrVjhEbXMwNDJ3cFVLNWlwS2Eza2Fzd2JIMUs0QmdXV00vVWUr?=
 =?utf-8?B?dGZTRzFoU2tFbFEyVnBIWDJRaUtLcllkVndFNXVJYTU5bHl1b2dFa2ZKeFc3?=
 =?utf-8?B?YzA3c3d6bWJ0Kzlvc3J5NkdBS2VPdUFzc04wN2Z1Z2FOSkJoaUZRTkxiU0F3?=
 =?utf-8?B?bllUNldwQThtTHRPWmVHQlY1Zms5d3FwVVVLK3R0emM3YjF3UlZXT3cvQno1?=
 =?utf-8?B?UVhBZ05DanNVS0VHdWUyYkNhYTVsaWkwQlp0Qi81Wk1HNTFRbzUrYUxuMjRW?=
 =?utf-8?B?NzZ2WWkwVHk5VGVOZUh1K2hMa0pYc3ljQm5DK1pVL1czSHllbFdCYmV3bWJN?=
 =?utf-8?B?MGhPM0F5ZDRqSVNkRWRkdHdxZ3lMeHAxQk5jS21XelFHOGRmcGEzQW85elJt?=
 =?utf-8?B?WjlKTzdaUFQ0cTNwTTI1VzJ5M0tFVjB1eGk2RHkzUTEwUDBPejRNNVc4U084?=
 =?utf-8?B?MTkzcEtpT3ZvNm9rQXJmMDNveDZvTTJuK3FhQjVOMjNIOWc4Umowaml4dDhz?=
 =?utf-8?Q?ovNZXu8Z1FkIN4IrzPCi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1906.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlN0b2g2OG5iOFJNZGVNdUxRcExXVzJQQTBPRjVoczUrRkExNGQ4UXl4M0xF?=
 =?utf-8?B?UXo3WUlways4dVZJWjREVHhxYU9TNUV4czdDSlp6dytMZGE2bTArbXZ6VXhN?=
 =?utf-8?B?dGlKVU1BbWtGR2JEaHNvZ0g1Ni9NVktvMytTOG1Dc0hKWDNPVC91b1BITGNP?=
 =?utf-8?B?Qmt3aGFkSFE2aFZQc1pLK3JzMVNBUkpnNVFFdTBmUCtkQmFUc3JFODVlNFU5?=
 =?utf-8?B?MXUybGFSQnkycGVlQjV1ZVhkL2o1dWFyYU9OSGxSZVJkMnRTdjdid3FzYUoz?=
 =?utf-8?B?Y3lWR3VHbGZ4cktSR0l1UG9EWk4za1FBcXZpMnZybGpya29weGxVc1BVQkhZ?=
 =?utf-8?B?bHkxN0k4bFFsRFJJV1k1K3BGenZFZGp1NW9Veks3N21zMFdEZEZDbTFGRVlo?=
 =?utf-8?B?bUFod1BKajdqbWQ1eWZrTHV4WDJFRnNSMXMvVHMrQkJob0tJTDN5aE1ZSUlQ?=
 =?utf-8?B?eE9iaE9OV1FPc2ZCUk9jekF6NWRKN3VkQktLaW1BaXIvWHpIZmNqUXlmb2lL?=
 =?utf-8?B?Q0FJbHBWSnlTMitGM0RLUGtOai8zM2JSTU1zQmlrWno1TklOVXlUb3l2SlFU?=
 =?utf-8?B?eXJhNmcxUEdRM3ZKeEl2SkwyeXRqZHBtUHEzV0dGVFZpZ05UcnpnSGpFTmQw?=
 =?utf-8?B?N2xrekJoc3FzZDYxR1hlUTYwQ1FYSXlJeFRtT3BsanlvWGhOMWZYT3FXcHBL?=
 =?utf-8?B?S0JxOUhqVy85NzNPVGdId3BNRE14WThSVE5FN05vajFoTjYyb3ExcUZzRDBG?=
 =?utf-8?B?aDhzTGZyUlMzMzNRL0Uyb25SU0pBdkJFREo3b25acGRpVDF4TVNKMUtrQW5H?=
 =?utf-8?B?YndhdjQ0UzdDSWdVa0dEcUo4UjcxVVpyblI3aGlXMXora0lYY0RPTG5qa09X?=
 =?utf-8?B?OXJVNjU0TlExcUJ5U3o0aXlESE1TeTJub1c3RTYyeEFPbm4zVEdtblRVNzV0?=
 =?utf-8?B?S3N3bjFldUFXaG44RkthSVlWK2JRbVpSTGdRK0ROZ1JocDM3ekRoSE15VkNx?=
 =?utf-8?B?MkwweS9Wb0FESTJjK3hDSGJyc2dUU3laVUg3TURSbTlEM3cwYmxyREplekt0?=
 =?utf-8?B?Z3JJci9nK2ZoT1JHcHphdmE1QUNLcnlHZEk4eXRBNllhSzFJVU9XSTAwbzhu?=
 =?utf-8?B?Z0I4L1VBQmVDenV2QThhQVhKeVFzY21HclJpZ3BoR2M2a3VtL0thYWw0bUZM?=
 =?utf-8?B?RE9ZajJHWENLcEFlVklFdTF2V01DZDRveUdPS2lPWllvcHJ3V0RJQitNckxE?=
 =?utf-8?B?SGJVSzQ5OVVyb0FEWWlDeU8rQ20rUWJzRW1EV0tXRTNXc1p1WWRZbmQrSDBh?=
 =?utf-8?B?T20xdGlobXFIbk5KYkNPNWQ1OWhVVkhDVk5YQnJWSldxclVwTjFlbW5tR3Bn?=
 =?utf-8?B?aHora2U3WkJHUVVjMXFReFNQYkV5SmRJenRPWjJvZ3ZTQndJTDJLZk1rajE2?=
 =?utf-8?B?TFdJVThBaEdZbmpKdmVoQmlBQlRadVAwUEJxdlRET1lYWFpRZCtUSDBGbStD?=
 =?utf-8?B?QUNFZUwxQU5zNnhXYkR6bURocTB6dGxzYlVjY1NvdE04MHFXTkZlR0RBVUow?=
 =?utf-8?B?cTFsdU9zN2U2YWloUzl1a05SWWczM01PUzhaNWtpT1BPN0FMRHByZjNoZFEw?=
 =?utf-8?B?N05wU1ZVVnlSQ2k4OVdhNER0VkRJZERMSTQxdENnQ3k5bWJROU9DVWg1Y3Y3?=
 =?utf-8?B?aDQ0QzlzNlQzZlNOUlZEcnlMdHovWnlCa3Y4L2JDaUpHVHpaOWE1eVpHck01?=
 =?utf-8?B?U2hWU3V4bFEzZnhRSVVIT01KbjZ4cGpXcWg1VmtDbVNvcnJHMzZ4SDc1Vkdr?=
 =?utf-8?B?Tit3ZGRtKytDbGcyWkNwV3Z6UktReEFqNVNOd09oM1A4cnFRcStuMGVHdkhj?=
 =?utf-8?B?WEc2c3FlK2cwV3k2SC9ZS3JwNnB6Rk5KMFUxRlViT0lWbzVnRVZwQmFacTJL?=
 =?utf-8?B?NVpnbHROVVoxSkR0WEJHaFNtMlZ6bjN0M0VrYVAxNHBrdEZTanhVTkRwdGFZ?=
 =?utf-8?B?UnZZanllYm5KZlE3Wk5vZWtTTU5QR2FRbTdBc1dHbXdCK1VtWjd0NWJxSHJB?=
 =?utf-8?B?TmI3My92Tkk1RlFGU0xPL3ZESStKbHg4V2lQdXNJQVFncU41cG03RC9mOWJ0?=
 =?utf-8?B?eTJETzdUd3pOYmJuSzYzejZyUkpjcmp4THRJL2psc09Pdmp3RDBadmZ1VWU2?=
 =?utf-8?Q?bzzIPKOGphECamk9BpKtxuvaWvyhjWXJ/1uvz9GwQhsj?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d02d69-742c-43c7-b28f-08dc9120a81b
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1906.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 12:01:02.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGv6yWeTgMjORodVHfkvcExgVaFyUVbzPK45vbYI/tkS1T+4QTfjKmb11LzqdwWO7NNUvami9WONKYn7s82cJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2798
X-TM-AS-ERS: 104.47.7.174-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1026-28464.007
X-TMASE-Result: 10--13.616700-4.000000
X-TMASE-MatchedRID: 1GZI+iG+Mtf5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xLmW9rYbVvp1J/T
	ZXlvSm1gfyAq8UHkGKVQLud/xEUaYtpgSVqv58hZybaMhlRNDfDn0oaU6WM++12TMSYoqccgzWg
	4ANw5W7AtPt+NTi5kUe2nTRTG/zl+JR2IjGwE8Ff6a0NEvI0IWhLkfOHvRgPiD25MJwZSrJTyOk
	fTAk4hYnLmCj+bquxDUyV+BSI3dH4SG9fFHG6GrJGPSO6O5JCaA20dQxCGeLo+Jg7sQdznaPoY8
	j1fcWGrDjdBvGLFPTOqidLUiUZwVn3ehwM//IdIqolsh7l9ctCjg0lrtKMWymtT/CJNcwXFCtR6
	vnsndImN4P4XksxlVzv5gdvtdpzVWjsaYI4lh3VfbzE2lTRTc1y0sKK4iJ9cDi2wCPzLaSBDxHj
	vuloxNaUVD4+2HcXr
X-TMASE-XGENCLOUD: d21e5e63-e4ee-47f3-9835-5206d243aec7-0-0-200-0
X-TM-Deliver-Signature: 27E6D8F9B18DA87B68EB745D6EE0B9A4
X-TM-Addin-Auth: ZBLxCRJ+TEGTQXTg7ctOS2FT+AudRW1nFnppqQZNy56htp1asf4Y027eJl5
	vNGSXFEMYPFM6eoQ3KT13j9mI/GitW243CspvfBeym3Qqd6oWzOwsnbE3EOvUCBH4zMrOaE99qx
	GoO9SDGf8yDLcJGfn+y3iRAky6bKFaVbaAKFINp9i8ot5jJURQksoILktNr60mxLZsN/eRquISi
	fv0L9lcXyvnxo4h34XKry+S+yUjF1cJf9LaoPkEGO9bXc6Za/mrD5h7O82vaZaL7YBsEKc8WPrL
	LnHuHfa8xXT3D/A=.07X4nssfjZqm9Wz3DpGZEk7jzMxnPWqcL+hAEeTTgfXSG931ftTyS9Jdjr
	2qQFdDnQSyw7L6AJkJap8Ii3WFK3Mqy8y6gOly7sQQ/NJDfV3tgEQ4QdnimoE5lWTaX8tJiPoH6
	IcPjmcmvjtoOsAFLYZFxCjZSKdOYsPK+aIr1XA5ALJPsSLohfk2OyT/LiKtTFdiZXaF8iP+/yme
	6Ubz1HLfH8ujK7Luzx6fKpHMKEqlD4Xh3KUZWVHkpufss1XP/qfbKDXOccFh1MB6LJMPttm7M+W
	2Jgh/0wEDYTPxxHJjJdAhGQFI5OvW3N35aL45/OBBDjGpegKyyNT34mjH0A==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1718884865;
	bh=dYQ8c40brY8P1cnuVvGfvMzzVVZR8lVQzDZOZTE2mDI=; l=2040;
	h=Date:From:To;
	b=LdNdEYPh6ket7UodAG5jrQ2KtlgYq8TqI8SfoJwl2ZGnBitd1MPCJNveLIkyb3yLg
	 LhQgo7PZtXHZLfTjg9TO+zumgk11tN8I06tXZF4IR6x+37AGTR3uB3KoeegG0xBZYI
	 7Rp1f9Ij9RaOnZqsqXTuZA2+/myv90epHyn6FZUpsPVtcBTeSYBa4A0ZxbnLduTCTo
	 NYxATFFBEuYXsfPlH04fpzYOPMzyY94dHwQzq/rB5c0XD/bQO/Ol2L517V4fzQuhxo
	 1mo0ILUL1QMWaWasOQ800yGjLMX19UBUott+9pfbi2oUIHb2JOswQENHpg2O5vHJXe
	 EcxRLdqPLkjoQ==

On 15.06.24 10:01, David Woodhouse wrote:
> On Mon, 2023-12-18 at 08:38 +0100, Peter Hilber wrote:
>>
>> +       ret = viortc_hw_xtstamp_params(&hw_counter, &cs_id);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ktime_get_snapshot(&history_begin);
>> +       if (history_begin.cs_id != cs_id)
>> +               return -EOPNOTSUPP;
> 
> I think you have to call ktime_get_snapshot() anyway to get a snapshot
> from before your crosststamp? But I still don't much like the fact that
> you need to use it to work out which cs_id is being used.

The actual cs_id check is in get_device_system_crosststamp(), where it was
added recently [1]. So this additional check is just verifying that the
history_begin is usable.

> 
> Shouldn't get_device_system_crosststamp() pass that to its get_time_fn
> as a hint?

This is unneeded in this case, since get_device_system_crosststamp() does
the check already (but the driver is free to pass it through the
get_time_fn parameter ctx).

> 
> On x86, you are likely to find that history_begin.cs_id is the KVM
> clock, so this will return -EOPNOTSUPP and userspace will have to fall
> back to PTP_SYS_OFFSET. I note the KVM PTP clock actually *converts* a
> TSC-based crosststamp to kvmclock µs for itself, so that it can report 
> *cs_id = CSID_X86_KVM_CLK. Not sure how I feel about that though. I'm
> inclined to suggest that it shouldn't, as anyone who wants accurate
> timekeeping shouldn't be using the KVM clock anyway.
> 
> But we should at least be relatively consistent about it.

ATM, the driver does indeed not have TSC support (for cross-timestamping)
enabled at all, so would always use fallback. If *not* using the KVM clock,
I think TSC can just be enabled by adding architecture-specific code
similar to virtio_rtc_arm.c.

I am not familiar with the KVM clock, but maybe it would be sufficient to
allow CSID_X86_KVM_CLK as well?

Thanks for the comments,

Peter

[1] https://git.kernel.org/torvalds/c/4b7f521229ef

