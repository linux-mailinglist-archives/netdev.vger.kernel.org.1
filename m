Return-Path: <netdev+bounces-109947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B688A92A6EC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EAC1C203AA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC8145323;
	Mon,  8 Jul 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a97l8YdB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5D78C73
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455159; cv=fail; b=PHC+6RxTPs1lxKlYyM7EE9kapBv9A31J9k+sg5+gsdeoOrCq0pmtLswLH2IYeTzciI9E1DQsZ9d/6xWPQgcHNs5g68tddn/qKUYdurTd3XqgcKFWJdmTxTcJGdJkQRXSeP6pcNT0D7tWEU9+d9YVua0eooykj8FJaO0O35jZRUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455159; c=relaxed/simple;
	bh=BnimpSq84A2onGRcJ5VenXGeS9TIMwzzOvt0zmY1OME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i3eS4iwI2cxW0SnFd+kHog98dgp2MWZCf4Rn7yZ0SQduIZ7ASkGRnwQI37D99HhM+/m6gUD4sVQ0ZnKqXc8K9LlB0j6O8LbVtyReoeQivMp7D5K4Eh4e6+mWWgVGcEv0/stOZ+QhYpSNEnW+Si/UTV5ot6qkJhJY2Q76egs7iiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a97l8YdB; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjzkX2TOcLaB5JKA8XpRYyeGfeg8ulmVA3avXCkaTPioRHYO7f3CwR9vNzR5F3cyGBle3+N7fFQW+2OC+slaejwTtudAD8Up1xBnUq4slvMSazURRV+mcL2FUy2CrwPkQTHVcUNxYgUdoDYSRjkNdSRLe2+vOjhqSvd7htcv9q4ak3lyW508MZFM4ODOYgKOLpzyZZNuifi7HDpvw+rn+StUQG0uZmqoOgGtIf4dKBcC9RYFU5mLnqfnATUcbjHajvE0nmXI03kwmigRtvbBy/6FqJ1aNcSVV5Xh8gT7dDURf62CrnI1R9B2Sk5ed0XxeYPVpSa28ULCuXRBe8mayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEOJ2vC8gN8OMqMizTq4Y8cgD1BsKVzrG05oeMfBiro=;
 b=UzzryLPVTsxR60+YUfs4IUY5xN6r/VhIu4j3OsbIQfMb0xVWdGFuvvTHWlZ2NjVtEe/omNYOTPeCGRrGqvaU866WuRleQarR0QrxH0U43ozeUN+W/BfKHTQsZGWDA3yf57rhDfCRUY+rpflyqpCL3nxD/0Y18z0VejN5VTam8IgBrxt7Z2Lmtlf8Zarhz6YEwHAnTs5wCVWKhC/4Gl5BUY81uOroy5Y4EOLwAcCAT5sxuwPQxBGZjztxRQZBrNLQtVwG44SlFUe8RZbXeJ7lpJGfKZy+sgA4iw1PtWNC+m25VQwzpv/a9AkW5iM4NHTOK39PCWRvbRhobWhQzBX4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEOJ2vC8gN8OMqMizTq4Y8cgD1BsKVzrG05oeMfBiro=;
 b=a97l8YdB4hA2oA0qwl3vv6NgypMTCeC3QDfced5NuBgaV4eDblO3xae25H5947MzQEEjflOhRzOUvlp9IdUzThwhk4HzmsbMvh3XBOI1EPHTIeeg2JpcfViESmrTCBnXl1MajjQYPZLYsu8LAp4fQ9pfioqLxmA3o3evq4AZmIz1h8W7Js5witSLOLmksMufi/UdtfQj1eG2spD/e8+7xgapWEXVZvCTf4cEg63IPWUCeOeDQH8C/xpkRzmNStwVBUuC8b4my7PLXjUhL73yIq0E1HPS4tmZ+MxprN/zLDeMlPriRQGQhHOdJHyRWWmRLXCzZTm4+IttpINIT0+pFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 16:12:33 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:12:33 +0000
Date: Mon, 8 Jul 2024 19:12:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Moshe Shemesh <moshe@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tariqt@nvidia.com, Dan Merillat <git@dan.merillat.org>
Subject: Re: [PATCH] qsfp: Better handling of Page 03h netlink read failure
Message-ID: <ZowP36I9jcRmUDkg@shredder.mtl.com>
References: <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
 <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
 <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
 <56384f82-6ce7-49c8-a20e-ffdf119804ae@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56384f82-6ce7-49c8-a20e-ffdf119804ae@ans.pl>
X-ClientProxiedBy: LO4P123CA0268.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::21) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 802ece34-7641-4ece-f3b1-08dc9f68c637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2dKTHpXakVMRm5Xb094Qm5nQlhJTXJkckpOTkhDNDEvdU1ENzdUYTVXQkVl?=
 =?utf-8?B?RTgxQ3NheWhDbGZDQ0h0aXJ5aWxIbU55dW1sZDdaLzhDbG9lK2NGaUtwUVI3?=
 =?utf-8?B?OEhwK2FzSk5MUWI2YUtRQnpndy9SYTMwKzd4b3ZzcW1pN0FtVytNTEZDQ0tD?=
 =?utf-8?B?bE1TMWRQS3NrVWNCa01wVGZNOEpvZERyRTZzc3VQemgxNjRWaWYrRjdqcW1B?=
 =?utf-8?B?ZFBWRzhES0V1MHBqQVMyT25kTHg1eWxQQnJmYjZqVHZtYk5oVUNyaEh2eG53?=
 =?utf-8?B?cnlKZzJuREQrTVJGRTRGN2xMQW5QY1o4Z25xWm93alM0RHkvM0REcmtmSEF1?=
 =?utf-8?B?YXAzb0duM2JteHM5cXBsYUtaQ3BiZlRPQU4xTFNCUnZMQmw3NS9ZYmNudS9C?=
 =?utf-8?B?ZDZIcHRFSUpUZ3ZzK0d4Y1VVUSt2eCtJeFNEdEtpenJ3cHNRWG1UVXREa1Z2?=
 =?utf-8?B?K2d5Vlp2bko3ZG52MkV0bUdzejQydDczRGFyNkc2K3daQ0RxRXo3N2x0clY4?=
 =?utf-8?B?MzVPa0VVWWh4TXlTczdEWTlVc2xGc1lSRkN2TTd3YnRmWldqR2FUSEx5U0tZ?=
 =?utf-8?B?ZWpkME9od2ZSQnYyUlh5VkdrUW1mS3FXMzI4T1M4cFRvemFJOTQwOHZkV1pB?=
 =?utf-8?B?cXF2YnNBajRjVi9nVWQrNkEvWmtYVjZvVWhycHRYTjRCMDNCUk0zQzJFT21Z?=
 =?utf-8?B?Q2lrZnU3U2R3bzB6SG1ZY2U5WnE4SEptakVOZUt4cDhIdkxqYkFOMjdPckpt?=
 =?utf-8?B?RFhDSGNmVnp5aFFCVDFGa3ZjVHVWNXpQNWRrVVVsT3g4K1BjMyt3T1JtTVNu?=
 =?utf-8?B?OElKNUpaSWpPdy9nREl2Tk43Uml2YUtmTHJGUmhEUXlJdDhWbk03aStsVHQ3?=
 =?utf-8?B?TVU2N1JvM0ZsMHBkMy9uaTBRdTZXTTZjd3JHR0dFSEt0LzhrT1orYUhiZUor?=
 =?utf-8?B?TzN2Q1o2cHFhYXdzMnFjMkxORFRtOUw1a20wd3gwNU81SHB2U3pzVndTVTVL?=
 =?utf-8?B?NjY1b0RFZndaeXFidFZCbEZpbHY5b2JpZWphNFZCZEdiZ3diSGFmL2pSb3BC?=
 =?utf-8?B?ZDZsemlhVlcwTnlpckp0UjhzUGVRc3BWU1lOWmlxc0xseTY1TEhrc3pGcm0w?=
 =?utf-8?B?cEhtamVDb29EUkxkZGhkNjFKdTdmTDR5NFd0UXhaZ0pWNGx6ZUVQbUYyTGNh?=
 =?utf-8?B?Z2RnSnFZbjA3ckF0dW1YelFRRzNaRWhXRDdMQ0ZDMFJkYm5YUDYva0UvVDlL?=
 =?utf-8?B?eklSRWRvSFg0dGFmdWFldng3RWIrUkxBUm5vTnhHU3pUK2Z1d2M0Q3NJeWVP?=
 =?utf-8?B?RExZRmtkanNPRjBaS21DdU9VazNTWnBROHRSN3l5YlpNUk0waTBFc0J5bFJo?=
 =?utf-8?B?Ui9HTUpJeE1iSS9lRmg5OS9hQityN2NCbFRCZVlEVHNaSTdrZ2ZadEk3dzRt?=
 =?utf-8?B?M0IwWlIrcW1PK3hIVy9EeU1xUkpPS0dTZUZ0a0RaZ0hXaTgxNGFnUi9UUWl3?=
 =?utf-8?B?Q3pUajBFQXQ3bWFCZHAwU2xLNUp3NEl1NkEyV3ZoRXBIVDFwVER2bWhMMEFM?=
 =?utf-8?B?ak5SUWp5YkhDVVpEZE10YWNXL1JIdGhTbkNxYWF0b05ZaEFqMzd2TElUYUFR?=
 =?utf-8?B?YThQb0Y5amlFZVZxRTQ2bW15bWl4VHk1NGFOb2tvYTQ3b25ad2gwQ0Y1NmZR?=
 =?utf-8?B?dFI2bzVyNW95VWlObzI2ZDFvNWozaERqSDJkZFg3aHZmemk5NjZpWEhUa1hP?=
 =?utf-8?B?cmlINnZjeW1aeWVQcXpyWXYwUGZhTXAySUdSaXpHV0lOM29sajUrdUo4Y0V4?=
 =?utf-8?B?M2tCVXFYYXY4cVd3eXljUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkowWG1JVTB0QVNma2ZHb2hMZFlLVTdkZ3ZZaUZjLzZSNWtqZ0d5Qy9YSTY2?=
 =?utf-8?B?dXZtME9HY2pKN0NLbUxjVlFvTk5qOE0rRW5uZGdRUEVOS2ZUckFPRENXU2Jn?=
 =?utf-8?B?YkVORlVGOTJtRldWK3BNSVowczBhbFpUekRwSWZOck95T1lEeGFRU0RwQzdl?=
 =?utf-8?B?VlFISWVDZ2ZkMTdMRExoKzFwUkNGQ2UvbTJCTjJFYlBqWitTb3U1Q0k3RmM2?=
 =?utf-8?B?WmxTZWUyVFZmazBRdjJ2bkdDUUJzbUVrMFN1dzVPdzBNbG5vYWNyZHA3UmZt?=
 =?utf-8?B?MWRlWEZQc2FGRGxyQ2s1RmxROTdWTG5ldmlIYnMvZktwM29BaE5qYzBRdlNU?=
 =?utf-8?B?RStQUFpaT2d6b3N2aFIySWtSMmpsR2VINUpPZWN3UmRtTlFueFo4cDFkNU1Y?=
 =?utf-8?B?QmplMVZ3TjZVbXpEbHFtdnZuMjV3MmZYVWJ4YTRic1NXaXpodEN6TUlmZHNZ?=
 =?utf-8?B?ODMvakY4dzRSR2lUTjZqVjdHWHlaVTdkekJKZVZKbVczZVJKcU1DUUNYczlE?=
 =?utf-8?B?bWZDWXBWbGFFdVllQWtKbitjRWYzbTlrdU8rREJVV3JXczFMZS95b2xRZjV0?=
 =?utf-8?B?ZDY5WmNFcE56S0RTcVROL0xGKzhnZ3BBcmMzQURVTlBOWFBYWjUzNEYwM2tY?=
 =?utf-8?B?cmcxUHJ6ZW9CTWE2S1Z3b2VabWk0UlJHdDBJcXMrRkk0R20yWGNuNE01NXFL?=
 =?utf-8?B?clJxVW9SRVJGeVh0eS9HREREem4wYUJmQXp5R0p2OU92NWhDYmJsMzNWUDUx?=
 =?utf-8?B?bHVPUUlvMUIxU2ZRMDRzTkFjZ25kWUZHcEFhRDJoUXdId3NnVTNNcElWK0Ey?=
 =?utf-8?B?UENuRE1Ka0hPeWZXdGJwcWY2bEwzWS9hWVhpanU0U1RqdVlWd2dva0tmdWpJ?=
 =?utf-8?B?aExITFFZYllFRXBxS0g5MlpycDk1LzVmNXNQOWtJZzFIWklGVDVHWldaTklV?=
 =?utf-8?B?YlVHYnF0N3JYemVWUDlEbml6M3Q3NXFUQjRDVGRqcktwU05KSlhpQitsaUNa?=
 =?utf-8?B?cjQrRHdLdmZxcXNBRWIweTQxYmpFZ3ZTbG9Ta0Q2d01UZkNKaVIxVW1XT1F5?=
 =?utf-8?B?NU1KVDNZUkhmblVYb3pVT3lmUWVnUERIejZsdzlNMkN2SmJ1MDJnZzcwclpM?=
 =?utf-8?B?MkUyeTQzUUEwclNDU0p4dmROOUZZVVgvak8vd3c5TzlRa0JiR1QrckpwbkJW?=
 =?utf-8?B?SXJsamtxa2FHZmFTNHQzM1ZRUGtkZ21HTVp3REhTT3lDVDNnblhyOWhXTEoy?=
 =?utf-8?B?V3E0aUYyWkhESlQrVjZTdlkxcEJZQU9rUWpDTDZrTDlpVW9UbXUwajhTeE5w?=
 =?utf-8?B?bGRoWHVTZ1lKN2ZpOEszTzZjS2p0UUx2ZUlsMnozS2UxQ2c4MUIraTVDSmV3?=
 =?utf-8?B?MFpFeG50aUwrSlpnYVRuV204UTY0LzFuQXRIU0RzZit5Z1RoZ2JaSDNxS3NJ?=
 =?utf-8?B?Y3NKQWw3b1VSTDVuOXZaS3l3OHlYbjluVWRxc2RVdFZ5UU1OQTNoNmFyWTV1?=
 =?utf-8?B?VEw2VEg4MnlDUXRtZXRqNVZTaTFvR1IzelI0a2VubGJyMUtMYjUzNXFhbVNj?=
 =?utf-8?B?S1d1SVpNcGZIYVJEZkFLVlpxcENIL1NnMSs5cE1TTUcxZ0VOWFhWSEFlMTRR?=
 =?utf-8?B?a29hZVprK2JqalN2eUdqMlJXa0pTR0x1RnQxQkp0RHdiTXRlK3lWOFgwSUpj?=
 =?utf-8?B?WGV6dVYrMXVkNnM3S3VZeGk5UnA1RHl4bEM2M2VGN3Bha1hvUkdGVjltRkhl?=
 =?utf-8?B?Y21KWk96anQwWnNhdXl2eU9NVEdLK2pjQUFDQzNYWUFRN3BBTzIwRmhNOEVQ?=
 =?utf-8?B?ejNYeVVEcDl4RXpsMFVUNXJzbDNiT0lHWGJoMjJxcmpDTUdlSHZJTEo1RWFV?=
 =?utf-8?B?OHN6QmFNdDhNMksyT1lZS1pYZVBXakxhVlExQ09wYlFydHU5OWkwQWlaTk9Y?=
 =?utf-8?B?blowWEV2VGd3dmxnQ0hlKzhQaEluWmF0UHJiVS9jejl0YnM4WVp3MHlubjk3?=
 =?utf-8?B?SmpZNkxLejc4YUZnOVA5N3dXR3BhM0JKRmNLYS95emxCeStocWZnQVN2dFR0?=
 =?utf-8?B?MjdLcFVON3dpc1ViV1YrNGVBLzJacEVpL0dBbEpwOVpBdUg1b3lEcmRBNXlo?=
 =?utf-8?Q?gXRK3h0V9gkVMX/YVQvaWOag5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802ece34-7641-4ece-f3b1-08dc9f68c637
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:12:33.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1xl5ntvVUxsM4UOG+yKGY9+x4EskaGkgPfIfu/uu5mb4yf+1NF2re7BOpZFxuaqH2eXQw+CW38EuFZ6/uznXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

Hi, thanks for the patch. Some comments below (mainly about the
process).

Subject prefix should be "[PATCH ethtool]" instead of "[PATCH]"

Best to post as a separate thread instead of as a reply to a thread.
Looks weird in lore (https://lore.kernel.org/netdev/) otherwise.

On Sun, Jul 07, 2024 at 08:41:38PM -0700, Krzysztof Olędzki wrote:
> Page 03h may not be available due to a bug in a driver.
> This is a non-fatal error and sff8636_dom_parse() handles this
> correctly, allowing it to provide the remaining information.

In addition to the problem, need to describe what the patch is doing in
imperative mood. Something like:

"
When dumping the EEPROM contents of a QSFP transceiver module, ethtool
will only ask the kernel to retrieve Upper Page 03h if the module
advertised it as supported.

However, some kernel drivers like mlx4 are currently unable to provide
the page, resulting in the kernel returning an error. Since Upper Page
03h is optional, do not treat the error as fatal. Instead, print an
error message and allow ethtool to continue and parse / print the
contents of the other pages.

Before:

 # ethtool -m eth3
 <OUTPUT BEFORE>

After:

 # ethtool -m eth3
 <OUTPUT AFTER>

Fixes: 25b64c66f58d ("ethtool: Add netlink handler for getmodule (-m)")
Signed-off-by: Krzysztof Olędzki <ole@ans.pl>
"

> 
> Also, add an error message to clarify otherwise cryptic
> "netlink error: Invalid argument" message.
> ---
>  qsfp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/qsfp.c b/qsfp.c
> index a2921fb..208eddc 100644
> --- a/qsfp.c
> +++ b/qsfp.c
> @@ -1038,8 +1038,16 @@ sff8636_memory_map_init_pages(struct cmd_context *ctx,
>  
>  	sff8636_request_init(&request, 0x3, SFF8636_PAGE_SIZE);
>  	ret = nl_get_eeprom_page(ctx, &request);
> -	if (ret < 0)
> -		return ret;
> +	if (ret < 0) {
> +		/* Page 03h is not available due to a bug in the driver.
> +		 * This is a non-fatal error and sff8636_dom_parse()
> +		 * handles this correctly.
> +		 */
> +

Unnecessary blank line

> +		fprintf(stderr, "Failed to read Upper Page 03h, driver error?\n");
> +		return 0;
> +	}
> +
>  	map->page_03h = request.data - SFF8636_PAGE_SIZE;
>  
>  	return 0;
> -- 
> 2.45.2
> 

