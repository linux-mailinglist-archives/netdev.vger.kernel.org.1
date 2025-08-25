Return-Path: <netdev+bounces-216568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02898B34913
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3751416CBA1
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F6B2750E6;
	Mon, 25 Aug 2025 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="RZQSFoOV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1C3090CE
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143668; cv=fail; b=jI5U88j0Qa6JSw8Z/wpfhGCmlQavZ7ZmYWhA7ULkQuroB5S/hJkcCfdME3IV90hLkWenSurg+nqXrmTcjQVEF0iXwRa3xaqASbykjRRyNQMKzHwkj69gQmM1NPmuuBQk1nqjAM65A5LqWIWWaVBGiMSm9Re3YR1lx7V9zXd71Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143668; c=relaxed/simple;
	bh=6vpM5jr1GlJWH8mgxlnx+q5BruMC6yXWTeLWYEJMD0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tw5ZveW+VOk8QmPDmzndhX1N4nPEgXWgb8ExIVrb/UplCH6Zrs7M6vjCx7kgMasMTUZDHtOx8TOxjumCEEubbwK75kIUzSG3d0Ef8sTH7hlzVYGDbF1ILwh8n7DY2yzV3JE7/OrgFtyQ6m4dr9T4WHTGFxHmsLZTbH0L4gTmuXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=RZQSFoOV; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756143665; x=1787679665;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6vpM5jr1GlJWH8mgxlnx+q5BruMC6yXWTeLWYEJMD0U=;
  b=RZQSFoOVS3c+zTiWFvfmL/8XpMHlgkYqzqRXmdNpUZAvEDZywt6yiV8V
   Df+ZQuqaazjdCmpvGO5PMv7YwMdgnb4G2zUK3xd3sSCrtKBltNprjySJ1
   Se5auKysEFEo69ds7Ar2MZl1eN4SmYKGTVHiv1tsk+U70VNVaZuv3Ju31
   o=;
X-CSE-ConnectionGUID: khNsa5B8QEiGwLPCw1boPg==
X-CSE-MsgGUID: PbayCwSISa+8jw2bDT1s7Q==
X-Talos-CUID: 9a23:oLHzjW7vWZEBi7Sv/dss904yAcl4WC3k4Xb/PGuAInkwQrqtRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AgCtwzA8juMwEWfY3Mapr6tKQf/9i6rWFF3ssqpx?=
 =?us-ascii?q?F68ubbyZcB26G0w3iFw=3D=3D?=
Received: from mail-yqbcan01on2111.outbound.protection.outlook.com (HELO CAN01-YQB-obe.outbound.protection.outlook.com) ([40.107.116.111])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:40:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhbHduamHqi6/d03AbQiA85PEcv6U5iICTv2oyzRat7uC30a2mK8Ek2EvZQa1APi0FcV0KUARLuu/KDjnTk8murQuyNcdT3q89zPBvQF/kUjjhZt4pazhRBWbqhpnT0ntAlWyszXdbVluQfIKj7tQk+b+Oa7a0QY/vCuAdWW4x0mRdxcIO+9ZoVrfmH0AV5fqDeq5Im4N85QuqnUaDWRbXj+GUlHz5ilx4HUXvpwuWJptsILApsxcysV2xihUqo1AwopevCk9LSaR8BRLUSTl7mmohjyHRTepXjz31kixNN6h/vVDRTM7+pszJoBZ9/wv5ooTq5xhLT5/UjDSN26bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsHekGSVGD+H9aBKiVTJaAGrdI2iEOCPYFNeiwuVRD8=;
 b=Er5tz9Yg+Oy7qoU+PaX/+etQJ+L4FjvpEL6jHofT7MRFHhUX0Xv/2hMUdDs7A1qX15dWD5IQImqUw6wCGlASrfGC2LXT6DabZGku6T6CDFrF3zwLtaWFYSxx0RtX7ah3sm7d9Cgz9VzIoRC17MWnw/fscnD0hSXpJt4I6iKpwCs3BHnMA5GNXp9TFsLm66tdFWpH+TObguLgLWev3kLcxauoQplRIrglEnqVqWE8GR9S5z5hruzHOJ+bT6veNao66P9K7X45/nfUFyaEZug40JsMV2rZxjeTHrpfhw7GhgjBhnpfmTBZVQ6jbvi4cQhbHB2sr44GKo9u8usfZVd88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT4PR01MB9704.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:40:55 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 17:40:55 +0000
Message-ID: <d2b52ee5-d7a7-4a97-ba9a-6c99e1470d9b@uwaterloo.ca>
Date: Mon, 25 Aug 2025 13:40:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/2] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250824215418.257588-1-skhawaja@google.com>
 <8407a1e5-c6ad-47da-9b41-978730cd5420@uwaterloo.ca>
 <CAAywjhT-CEvHUSpjyXQkpkGRN0iX7qMc1p=QOn-iCNQxdycr2A@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhT-CEvHUSpjyXQkpkGRN0iX7qMc1p=QOn-iCNQxdycr2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::27) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT4PR01MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: a9666b2d-26d8-46ff-6b09-08dde3fe8b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekU2QkMvWng0WXg0cDdXVEM5YTV2OVBoYlpJa1pEMXpweWN1RzA5VHJXTCth?=
 =?utf-8?B?SWFLU0RaeUp6Z0N3Z2RPcFdrTWlsVmRpVVRkdW1od2RrN04vUjFLK1pYVDVq?=
 =?utf-8?B?VnRDN2ZOWklEWE9xSTY2bCtabU9pT0k2MWhjSENmRXpUSHJFb2VDMW84bkpV?=
 =?utf-8?B?bm9UYmljR3hEWlBtUGpxOTF2YS9NazRWdFZxSnE5U0ZqNForMVVxVE16R3ZD?=
 =?utf-8?B?WUpJaGRCREFkS1kybHo0MXYvNG5oblZQMEE0TGl6NjNub2dKb1lPcGhlRm81?=
 =?utf-8?B?Wm9HRVBNMytaMXpBQlZHNkZMbzVvdTlCaEw0bXVNWkhuQ2hVczdBWVFjMWJk?=
 =?utf-8?B?SXFaZThKcGF1UlNXQWYzK2o4T0JpeW9RRG81eXhtRmp4aDA5b2ZsVGJsRzBy?=
 =?utf-8?B?MmdFME16N3AxSzVNTUtwaGNVdEJtRSttcmlJa3Y2VDVRajdEMnRNN1ZvM3lB?=
 =?utf-8?B?RHVvL21vTG1ZYVNRSDJrUmlyUU1TVjlTcWlWQXJYMDZ4Yjh2YnBWcEVsb3M5?=
 =?utf-8?B?L0t0SlVPcGdtZExpZnYxc2NieFNxak8rMm5JbWVJK0pkRCtSZE5QeFlSalBp?=
 =?utf-8?B?MzhsVUVjekwzMXJYTDArREkrUTRxWk5pQWJ0Y0hDR2tYNHFvOGw1ZGpQS3l3?=
 =?utf-8?B?cFhHaDl5YU1DbUtNMlZIaWlqWFU2NVp3TmNQRmdxVlZuQmNKR2RCL3d4K2NC?=
 =?utf-8?B?ZzZ6enFhV042WWVNREl5eEZVSzRPZ3hvWmxmK0lidUdGblBGclFyQjVDeTZF?=
 =?utf-8?B?SitCcVJJN1JiLytyL1JTRFB6NkxTVG84SElpN0ZCendOVTJ2OEJWUnZ3ZnhY?=
 =?utf-8?B?bXRqNlpScXZIWmZvOUN3NHYwcUliZHBuSXlEY3JaK2VKQlVVb1l2SU00czR2?=
 =?utf-8?B?VDAwQXRvd3Y1OXI2cTVjZjJSVVYxVmxpdDZ3U0g3YTkvZGNCUUErNkNzYWJ4?=
 =?utf-8?B?ajI0RURKQzFzT3h0eDM1RVJjYWhzanh1OW15cWNEOUUvZ1ZJUGJ1SHM0aG03?=
 =?utf-8?B?dWR5eXFNQnRQNzRsSldMc3pZcTFEOVhLVWtydlRsekNYd2I4b3lza3ZOdngr?=
 =?utf-8?B?dlZYbFpqME5kcXVxOHZaV21NempDTEkxY3I5SjNIRkpLd0ErRWhXMXgrSXZo?=
 =?utf-8?B?WkhGYlZibk1XSHVkWWVhUExuM0RrYnhlWVI1enREdXdvL2dWWFI3N1lxRkFL?=
 =?utf-8?B?QTE5dlJLbk9OekRPYkNDRHFidmUzNXFBSEcrbHV4cHk4VGpxcTV3akZLOHR1?=
 =?utf-8?B?cUNvRksrb05tZGZDemp4VERxK1ExN1JOelg3YXE1K0UwZWgxVVN2di9qTkVL?=
 =?utf-8?B?Q1pLYllNMXJHRDdtOVBnMDVhMGNJQTk3VUNEbE4zbm0yekI2NjlWb0YyM3c3?=
 =?utf-8?B?eHA0YkhEY0xYdm1ubXd6dmFDaDJUNmJQZmg0Mk85ZExnaUZxdlRGWGFITjI1?=
 =?utf-8?B?Y2tlbFpRM1dpV2huc3hyM05tbTlxYlFzRDhBM3FnS2FNSWxMRjRkTG45Yk5Y?=
 =?utf-8?B?V2NIcjhKa2RCbGpDMnR5YjY2N0RWOVU2RVFsN3kzSW9ubllKZG1iQlBvZzU4?=
 =?utf-8?B?ZFNNY2pWL0h3M3lBS1pLSllxOStXcEkwNVVWai9yTHNZQ1pGeHZuM2gwWm1P?=
 =?utf-8?B?MFdGOTI0YVJJVXNnY2lNYXhsNGNSRng5eStUYnloQ01BaUZuT0c5REU5S1FX?=
 =?utf-8?B?WmhzMEtVNmttS3Q5YytodkwzZ3dZK3l6QW9CUThLUVlkRnEwaUI5V2NpeHJH?=
 =?utf-8?B?cGxpRnBEeW12QytPenY4anpzbzFmc1JwTXJ5RnhGc2lKYWpYTU9sM0ZoN24x?=
 =?utf-8?B?Q1JzNHAyeGJDTnV6Z2duWUwyOS91YnI0c0R5ZWkxNFRIVWpmZ3NPN3NvYTE4?=
 =?utf-8?B?OXVJM1VOUTZkNTJVNENYNVpFMkNrQWR6N2ZzT0ZUbU5VUHVNTXU5dHM1MHFC?=
 =?utf-8?Q?mjXEPd/h/Vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTFxbG82Yi9TSmRaRThkQU1HYVB4WHFpbGFVL3FSeGdDcHlVQ0dneEQrWDFW?=
 =?utf-8?B?UDFBNC80RkRtem5DdzRlLzBzTjRESnA2NERaY05GS0FZYlkzR0F5MjdEbXl1?=
 =?utf-8?B?T2k3RVhGMmdDS1QvZm5tZjNRM0E5RDJUamFnMzkvQXdldEZqbmJPdDlPeGR0?=
 =?utf-8?B?NXVsczFMYnlUdXFZcTAvaUV6YVlqNlQ0emllZHdoK2o2RHlDQ0tmRkswc1Ax?=
 =?utf-8?B?ZnQvU3ZWNzlGWVZVcWhXVW40ZkNkWnI4Y2FvL3NBNktDRzBQZTNIM0loU2h3?=
 =?utf-8?B?R2FCbW9OWk9CbEkyM2VXTXFXTWt1c1VVQklYTjNVYk5DR2lucjZUTkhvZjlD?=
 =?utf-8?B?MHdvODVFVEM2OTNVMlJBNU55TlJvUU5VR2VEMzVHdTJaZldmSkJwL0hrZ2Nv?=
 =?utf-8?B?bXpLb2ViS3YzYU1JMC9Sb05tZ0sxZXlZaVE3QUtUNUVyaEloQWNqeHpnQW9z?=
 =?utf-8?B?MXpqZWo1K3ZtbmJPRGxadndXL0JxYlFEdnFpMjdTa2J1ZkNQdlRZaWZjYUJk?=
 =?utf-8?B?dExsWldkU3dSTS81YTUwaUZpc3NmQXdjVWNvaDM3cUh4TXIrSUVtQWM1ekkw?=
 =?utf-8?B?Zm42eVRBcHRvVnduSDRVR2NERnFTbTk2SEVPV2M3M241d3RRR0R3NzBndFNX?=
 =?utf-8?B?Z3U2MTlucjVHWnF2QWJqa1UrVWliQWNtQzg3ZUU3OUJYcE1ycTF1TGR3clpQ?=
 =?utf-8?B?NWtHUlg5T1BIanBCSjBHRHZ6WlBCS2JVUkpUWnhQejdoV3ZXakhTdTlXTTc0?=
 =?utf-8?B?QWo2MDFRdExOdzMvemlHQlIzV2o3NFYzNnRsUFc5TjNPV1MybWRaQTF2VUhy?=
 =?utf-8?B?K0FrOWkxT0lKMVRmMnU2d0NXbzFrSVEwSzJoUGJZcDMxODZ4a0lIOVdUSk1Q?=
 =?utf-8?B?aWpFM0NSNHBna2lKaGF5ZmcxZE5nejJQdkg3ZklEclhNblJPRzFJbmdWV2l6?=
 =?utf-8?B?c3RDRmlmTUJEb0NpVkVIU1N3UGpHTk00QzdPSVNyM2tFVGhlazc5WmdlcHNz?=
 =?utf-8?B?am85VEZ0YTVFOUF3ai83UFgyTDhUNHF3SnBXdnNmd1liT1E4SFZ3eG9RWFhZ?=
 =?utf-8?B?N2lzZkxicDUrNnBEc09oVWczd055Wmw4QXFvMDFETXEvMWlxcGNxSVVZcmVW?=
 =?utf-8?B?RDFIa0VFa1Rndlo5MXB5em9CeURqS3hjbW9ZUkVuNkMwaHBkT0NnMlA3dHY5?=
 =?utf-8?B?aXFLTEJHamNPN3RqeHhBejJFUGRzZGs5QnE5ZjlrZHBES0JqMzBGTVIxS05l?=
 =?utf-8?B?N3d1RWlMRnh5bi82bld1dGgzQnhCVXJQcG9qVXc0Z2FSQXcxNUtuZmVra1JM?=
 =?utf-8?B?bFdOdGhPN1lGdXpaOGFnWk03b0ErdlZaUFQvS0xTSElVdkhVeUJxS2Qxcmdn?=
 =?utf-8?B?UFdxOXNHUmQ1NUFCMEZCd3JLbC9DUTU0ckhrZDBCU1ZDdTg1cm5aMU9TWWFN?=
 =?utf-8?B?ZENLMUtqUUhTeDB0YmloTk0wOHYvUnFnWUV4WE5VRW80cFNNSEllOUtJS0pu?=
 =?utf-8?B?dnVJZEptOUhZcHFhRWxKODJ4UUFtanJ6M1JHQlY5MDVsOW90b21rSHpObGZw?=
 =?utf-8?B?QWpXNTB0eWhnNUJmNThZRHNFc3F0aHFmblFxWlpBUGNqN0R2RHBsQXlVT1d6?=
 =?utf-8?B?eC95SXIzN2F0WTZpdnVmekVjdEEzclAxSTN0eEw1SHhrTk5uWWR0Ym1zZ1Nq?=
 =?utf-8?B?WlZnRnl0cjJ6UTl6MUZNT1ZVOURqOTU1Qmx0eGxNNmtkUUlUQk04M3dhQXRm?=
 =?utf-8?B?UWRMai82a1hKWmtxbHBablNDeVMyb0hNMWdoWTlxaE44Tm5WaWVrQjNlN2hs?=
 =?utf-8?B?TU02NjFpMi81azd5K3Z0Z2pySUUyMHlRcFpWZ3pEWDFoKzZZQ29GQlZiaDcw?=
 =?utf-8?B?QmMySjR6OVhPcFMzLzFLWTEwN2tHOG1Ta01RS05ITzJ4Z0pPcXBJdnZTWGYw?=
 =?utf-8?B?V1hYNmlGZzFnMmlsNlIybm9TL0FrV01FYTU0TEFsK1JYZStLWkp3OFBEMnR0?=
 =?utf-8?B?UjRJOWtUS2duNkt1Y1luVTJkN1BOSlVEZllJTDNUS29BcFByQWdJMGEvNGlX?=
 =?utf-8?B?ODFLR0VNcVlNRlh5ZDlEd1MySmcyVUpqWkEvVWJCd0krWVBPbnIrMHhlQmR1?=
 =?utf-8?Q?Qm9ZZhF15HupzbLOe7GQLWxH8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xQLXqp0BUqJ7q3JLKNZN/Pmci5HdtoFEO0UjZhY8CMLuqIOb4jEFqFUXQsDZPz0/USmqx2Ghm07cNqwXLzdjrxNQzSyhMYfod67mue+0RgsBozhk/ue4q5zbPTXJm8KL2lQ644UeOFRVcsJNQxibd9Xsp0HP0oMfW5VqulUQUtWMjjn0zLtHBJUH4fPFIWshvPZhJSKnGE5syn18aiCsuZc/NclJ0tMFmqZ28as8Rj6rI/SAeGqoQA+fOPac6WwavdhF+ks5U7oamaCAyYhpYPsexrnNe4DHnfpJCGZCSd7grD9hhTsKSa+zcOS5y1LTpMNQes++7XXvZ9yfw+Lo87hlr1t7NnNlKk8ZOdFs5fW6ifLmPATKqg6GCEit2u1Aze1dw8omDScnoaHdLtdbtVAOmsukLOFF9EVA+a3aXgGTr/8NFAC6QI7REgA29xHxiQXS24gX2yGZpmip5vP0dDNRYpQg1QRTegx5/ZH83q/GEIcThkLIAY+wu7j0DxQoJPROBPjKNhcRgW0wNztwd5lG6FRait3WMqF6D80WnhDiGIp41kGjxVQ0un66WgMMtp0vy+h2nbpTo9lV+t78jZrpKhFlWsh+pf6ao/wuJiwwA/pvs7Nk/YNOO7K/sAO6
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: a9666b2d-26d8-46ff-6b09-08dde3fe8b44
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:40:55.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDTpuIfJtob6CzbIOzla6t6GVU5VTnQHi36++OJ+SWGdpw5gpbWri6DaRRqJgL63wPNh2WprpP+Ooyzj50TXxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9704

On 2025-08-25 13:20, Samiullah Khawaja wrote:
> On Sun, Aug 24, 2025 at 5:03 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-08-24 17:54, Samiullah Khawaja wrote:
>>> Extend the already existing support of threaded napi poll to do continuous
>>> busy polling.
>>>
>>> This is used for doing continuous polling of napi to fetch descriptors
>>> from backing RX/TX queues for low latency applications. Allow enabling
>>> of threaded busypoll using netlink so this can be enabled on a set of
>>> dedicated napis for low latency applications.
>>>
>>> Once enabled user can fetch the PID of the kthread doing NAPI polling
>>> and set affinity, priority and scheduler for it depending on the
>>> low-latency requirements.
>>>
>>> Currently threaded napi is only enabled at device level using sysfs. Add
>>> support to enable/disable threaded mode for a napi individually. This
>>> can be done using the netlink interface. Extend `napi-set` op in netlink
>>> spec that allows setting the `threaded` attribute of a napi.
>>>
>>> Extend the threaded attribute in napi struct to add an option to enable
>>> continuous busy polling. Extend the netlink and sysfs interface to allow
>>> enabling/disabling threaded busypolling at device or individual napi
>>> level.
>>>
>>> We use this for our AF_XDP based hard low-latency usecase with usecs
>>> level latency requirement. For our usecase we want low jitter and stable
>>> latency at P99.
>>>
>>> Following is an analysis and comparison of available (and compatible)
>>> busy poll interfaces for a low latency usecase with stable P99. Please
>>> note that the throughput and cpu efficiency is a non-goal.
>>>
>>> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
>>> description of the tool and how it tries to simulate the real workload
>>> is following,
>>>
>>> - It sends UDP packets between 2 machines.
>>> - The client machine sends packets at a fixed frequency. To maintain the
>>>     frequency of the packet being sent, we use open-loop sampling. That is
>>>     the packets are sent in a separate thread.
>>> - The server replies to the packet inline by reading the pkt from the
>>>     recv ring and replies using the tx ring.
>>> - To simulate the application processing time, we use a configurable
>>>     delay in usecs on the client side after a reply is received from the
>>>     server.
>>>
>>> The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.
>>>
>>> We use this tool with following napi polling configurations,
>>>
>>> - Interrupts only
>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>     packet).
>>> - SO_BUSYPOLL (separate thread and separate core)
> This one uses separate thread and core for polling the napi.

That's not what I am referring to below.

[snip]

>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
>>> |---|---|---|---|---|
>>> | 12 Kpkt/s + 0us delay | | | | |
>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>> | 32 Kpkt/s + 30us delay | | | | |
>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>> | 125 Kpkt/s + 6us delay | | | | |
>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>> | 12 Kpkt/s + 78us delay | | | | |
>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>> | 25 Kpkt/s + 38us delay | | | | |
>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>>
>>>    ## Observations
>>
>> Hi Samiullah,
>>
> Thanks for the review
>> I believe you are comparing apples and oranges with these experiments.
>> Because threaded busy poll uses two cores at each end (at 100%), you
> The SO_BUSYPOLL(separate) column is actually running in a separate
> thread and using two cores. So this is actually comparing apples to
> apples.

I am not referring to SO_BUSYPOLL, but to the column labelled 
"interrupts". This is single-core, yes?

>> should compare with 2 pairs of xsk_rr processes using interrupt mode,
>> but each running at half the rate. I am quite certain you would then see
>> the same latency as in the baseline experiment - at much reduced cpu
>> utilization.
>>
>> Threaded busy poll reduces p99 latency by just 100 nsec, while
> The table in the experiments show much larger differences in latency.

Yes, because all but the first experiment add processing delay to 
simulate 100% load and thus most likely show queuing effects.

Since "interrupts" uses just one core and "NAPI threaded" uses two, a 
fair comparison would be for "interrupts" to run two pairs of xsk_rr at 
half the rate each. Then the load would be well below 100%, no queueing, 
and latency would probably go back to the values measured in the "0us 
delay" experiments. At least that's what I would expect.

Reproduction is getting a bit difficult, because you haven't updated the 
xsk_rr RFC and judging from the compilation error, maybe not built/run 
these experiments for a while now? It would be nice to have a working 
reproducible setup.

>> busy-spinning two cores, at each end - not more not less. I continue to
>> believe that this trade-off and these limited benefits need to be
>> clearly and explicitly spelled out in the cover letter.
> Yes, if you just look at the first row of the table then there is
> virtually no difference.
I'm not sure what you mean by this. I compare "interrupts" with "NAPI 
threaded" for the case "12 Kpkt/s + 0us delay" and I have explained why 
I believe the other experiments are not meaningful.

Thanks,
Martin


