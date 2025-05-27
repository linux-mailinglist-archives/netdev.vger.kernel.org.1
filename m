Return-Path: <netdev+bounces-193557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401D4AC46E8
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 05:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C5A3B3C9E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 03:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA921AF0C1;
	Tue, 27 May 2025 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="jJQC0QwO"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060.outbound.protection.outlook.com [40.107.104.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F7199FBA;
	Tue, 27 May 2025 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748317120; cv=fail; b=ckL9ioaKhtLLhrLtTw2sRnPldQ743KtV3n9UlxUZEJJDpmpAI2IR35evOgOYC1gL3grk6XKIL82cxacF/6/ftf+vdPPzDDyoT0EHGPRaNzeDCIy/4LfH6ZBmpIYfip4WAIy73y2Egaslo2c+pymVxTDwbNxVfxweTLOLB3SMg0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748317120; c=relaxed/simple;
	bh=3zEsQfFrx0fwvgw+QvcJRxJLzM+sLpn8kIauiIWMXHM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H2mDlBE5EeVYl/5VAwTqp+HjJuQTnqejSwSTzCTpTlgOL1QIU1TNU/KylXK+E0VqNEXMKTLssdyPf1I86PZ6XOBbkTYy5pQCLwMPhSn+9kNhqaCgLyZvfv+0LNqznKLHhg2Mo0N7EOSSHYjFZDZ3r+HH8l02qbKrM6zDRdfgvx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=jJQC0QwO; arc=fail smtp.client-ip=40.107.104.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKUp64jat8OmixBPXSqTUJVlkp0vdyPDQcvn9xXG0kwVCOGpOpRI64MV62eeO46XdldHjD5JneKLBf6KbsLivHsZQfyD+4PiZvufe/cX43gSQcyc8B97eFNxWJ6QAZkytW5tO+XkTn3VCIu+aG/GGUGvnIpeUWUsbseW8b7qu/rvR9pj6TMVZYDUONIWQ02shxsiqIt8oK2A/Yn6wZVxAAUbcrLHHsA+KPU2r6kZg78v8ipe17rKch9FBXB8fsGL1YJNMBs3Tkn8u/dVGFJPE5cZcB2jkQzj5YwRLFRyIL2r88hOwCFPnMn8Jz3rJtLNaTnW1d8rp5uCaQrx79TsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zEsQfFrx0fwvgw+QvcJRxJLzM+sLpn8kIauiIWMXHM=;
 b=tdXtKqXPt0McJb8lX+sNPhW38neLN4H8DiPcw3vlt6NLlJdemE/ulh70hLbt4NAXFdAkpdF0vdHJwiXB1blAbjFcV0Ub74pnWLK+BpdUXwIqJ4Vd/qyhQGnemqvXVKwhC9IpudZr1plMu2NVjT2I9IUVr12e0nL1BIKZdSeugt8Jh/MUv+DfMvgCvB3IMQ5Xljd5FQ4vOy5xcC9Iffnd9AAGdtxwhYYnwe5aYYkM+G8dPUvnJkNOK1b8FsuH3GE/WJimOOCE42SrhAgYvbBH5v+lVuRc+goK0LPUfJs7Co++GSwg4wYf/eefxZV6KDSIM3OSh81geLRJqgBtkwHEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zEsQfFrx0fwvgw+QvcJRxJLzM+sLpn8kIauiIWMXHM=;
 b=jJQC0QwOLZy1iCQb9h+awGO6buvIv/Un8+INnpl3WPq78OSyHJt9o53AKD5P0U+88HjpTYYx84oLro5iPTbt86hPKJpySYFmnYaAOYp3eHp1iv2S8xs4UUmKf4J0GVkb/8eD1TNmc1fAdo8kXbUgcTHH+FZFuiSCLfAwqfIOWjZCZ/aWSXNjXn8gGOcW5U4UsC1RWbd5qKXYfralKfHWvGtk/O+qqOTW/uijJmYBNUi0GRZYvWvAngb13B+fKPO8DJkJVSQTar2HRUY11zimiGq2bKMDN4wjkTdoGGASdl0wuFPf6TKieKMASyO8/JLZ8y3wiR1vTTCrNtWIk79Hug==
Received: from DBBP189MB1323.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e1::23)
 by DB9P189MB1811.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:330::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Tue, 27 May
 2025 03:38:34 +0000
Received: from DBBP189MB1323.EURP189.PROD.OUTLOOK.COM
 ([fe80::d290:a7ee:5c91:6034]) by DBBP189MB1323.EURP189.PROD.OUTLOOK.COM
 ([fe80::d290:a7ee:5c91:6034%5]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 03:38:34 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Charalampos Mitrodimas <charmitro@posteo.net>, Jon Maloy
	<jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Wang Liang
	<wangliang74@huawei.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com"
	<syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com>
Subject: RE: [PATCH net] net: tipc: fix refcount warning in tipc_aead_encrypt
Thread-Topic: [PATCH net] net: tipc: fix refcount warning in tipc_aead_encrypt
Thread-Index: AQHbznXZAdAEjqtEYkyJdwjgXG2OBbPl0ogw
Date: Tue, 27 May 2025 03:38:34 +0000
Message-ID:
 <DBBP189MB13234B89CBA74E8127527051C664A@DBBP189MB1323.EURP189.PROD.OUTLOOK.COM>
References: <20250526-net-tipc-warning-v1-1-472f3aa9dd9f@posteo.net>
In-Reply-To: <20250526-net-tipc-warning-v1-1-472f3aa9dd9f@posteo.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1323:EE_|DB9P189MB1811:EE_
x-ms-office365-filtering-correlation-id: 494ee45b-e154-4f77-0305-08dd9ccff52a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bDc2eDlBZmxzUW5HMGFwUWxJSldwQmxhRklEbjVhQUplcDNXWnljNktGWC9W?=
 =?utf-8?B?cDRBeng3UFZkMzRVSUZxN2preFY0L2dVdXJzcThCOW1XSTJNSElzUDJYeWg4?=
 =?utf-8?B?THQ3a1ZQalF3Z2NTMHZUMDg4eHUxSGZNTFVvSVdFY0RlQ2tGdzVBajZJU25B?=
 =?utf-8?B?aHZCV2puUVQzRTNTMVdvcWZqY2JYL2VMczZER0s3SkJ4elVOTzQ4RGhjaDhh?=
 =?utf-8?B?em1kOUxleGVSdGhaMEZGN1VjK0o3TGpYZ21ad0hOUEpXdlp2T0s2b3VqRkxO?=
 =?utf-8?B?S1Y4a29QUksrcGNLUTBMZERpM3RKSzYvRmwwODZSV2Q5aHhXT2ttcTNXcmww?=
 =?utf-8?B?RUd3Y205S3F6V3hOa1ZKYmRVU01CeUx5eDMrczZSdVM0OFpGOHVzY0FpazU0?=
 =?utf-8?B?ZjNKOVAvcldmWGtVeDhLTHo1Y1JRemFLdnNjZjhxQTRlVnJBajNmdnJZRVdl?=
 =?utf-8?B?dHZmMUFRd3I5L1ZHU2paekxCRlIvS0JKdEZvSVkxVVh6SnNWUmRsREJIMjdH?=
 =?utf-8?B?ZitWU1VWYTAwUFVWTlN3NHp5MjRlWnZjMmQ4TjBDK2ducFZjWEdXN3FBR0Qz?=
 =?utf-8?B?dTVtTHE4NGRLcTVlZXk2Y3EyWllBZE05NG1xV3BjWXluOHBieFhMUTU3OUF3?=
 =?utf-8?B?ODcwRzU0WGxqWjVDVStYRCt0bStxQXNhWkQycXlMSVU1MndPeW9Bdmk0aXMw?=
 =?utf-8?B?YXN0MkJXdnZlUlJ4Z1YrVWhrQUJsMkNLTTQxVzBVWm0xcEE1OFByb0xwdW5U?=
 =?utf-8?B?dCtZMFBhd0lSeE5wRmR1T2JhelJkWjNJVk5XTzZ0cFhjN0Iva2hXVExoanVO?=
 =?utf-8?B?d1VKYWZPTEo1NWFLNWpQMW5PQzZIaTk0cmxkZGJ4ditVTjd1dnhuT01OQmlC?=
 =?utf-8?B?dTF0Qm5tMkdXNTdONHdZQVIvUjI4UzdPNGlYRTNZdG44Slc5T2ROMVlFRmJp?=
 =?utf-8?B?Sm1XZWlMNVVHSThCWGlNaWtYcHJGQy9RVkk3YWw2Q1JYMXBIQjNIQXBCNitR?=
 =?utf-8?B?Z1djSUo4emNxaFQ3bVpjTzA4b3RUVmNtbm1WOExBRkNZbHFWSDRlK1dqR2FI?=
 =?utf-8?B?NlM4OHp0WUN5bkh5dG42OERQK2VxeWdYc3dqU0N2VjE3aWpYWHNUSDhwRWpy?=
 =?utf-8?B?K1NNcXpDUi82STZxTWlJV1VrTVBpVnh3aXlxYUc3ZEt2b2VOWEJudVZtbFVE?=
 =?utf-8?B?VXRKTHRxN1BMQWkwM2Vld2EvNmxNTUJRMzZ1K2ZEYTUwUUdJTnl5cXlMbTRq?=
 =?utf-8?B?VFd4SGZMSG9vZGFGYVV5MHBrWmtockVZVW1GMm1MNHpDbXhLRnFxRVFFQm9U?=
 =?utf-8?B?SWFFTFdSUnhZN1NrRVJYQ1dnUVQ2dUdZV3lqYmNwck5ROWhPblNOaHZQbnBp?=
 =?utf-8?B?aTFxMUpVZ0l1UDYvdHl1TFVyOUNNWXIrZ3pnaGd5OE5JYU5sQ3RvV3VWK0U3?=
 =?utf-8?B?L3VTT2RxU0YyUUFncUJnKzROaVRtcEZvU2xtYXMyOVVVYmY2a1MyVTkvZ1Z1?=
 =?utf-8?B?TWpjM1BidWJ2dWhsK3ExUGVBZ1RMWnA3S09ZaWQyL1hvWEUxUXVyTHhYMUJG?=
 =?utf-8?B?dnpCU09Jam9JREZQVjZkYWk4R1hGRStOMTg1L21tZGtJTGZ1ckt3WjVnOXNI?=
 =?utf-8?B?aFdCdjU4Uml0UU5YeWoyMGYzejVBMWFtNkJ4Tk5CaUxxRWdUcUYxWFgrcGtK?=
 =?utf-8?B?ZEpHQmt4dllVZGE4SXRTL0g1Qi9rSVVhQW9ONmNaNXgva0xZM1FCY3JTeWNQ?=
 =?utf-8?B?b01PVjYvSmpDRlBOemFGVjNGRStpS21TQ2w0RlpxVTVPY29zdHg5MTRLTGht?=
 =?utf-8?B?ZzVpcVRzQW5kMFhPYkJieTc1dDhpWE1rZjlGcnAyYWkwd1FEU3RWcnhPWFRZ?=
 =?utf-8?B?eWUrT0xJSlNadUN3MlRoWGpLbWQ3R2xtUGJDSWVBNE5teHVLdUFMUmwzZmla?=
 =?utf-8?Q?Vbl0NPePns4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1323.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bC9JVDF1SS9MYSt4SHZva3R6SWlBeng5SWwyaHhrLytua2JDUS9KTmx1a0Rj?=
 =?utf-8?B?ZGtFOWVNMXMxYUtuOW5pYVA4aytnblBNNXAvWFR0ZlV5TkN3TEFFb2Q3akFX?=
 =?utf-8?B?dmg0L3F0NGpBeUxFN2FZdDl3SDEvclZXV3cwK0VmK3djU2xFdG03d2tBYUJO?=
 =?utf-8?B?VkhWNU1CYmNnejBwZzNpMjEreFVObGFjUlJzY2YwNWU1NUhVVlpzaG9LdGNp?=
 =?utf-8?B?SnRnNzM1YnE0TkpHVFRwVm41QUZJc1FETXRNQmxramRReEJNeGcxa2gwZ1Ri?=
 =?utf-8?B?TWx0N3lnVzNCaFlwc21vYTRFcW5uNGVGUHAyaU0xcHRZNk1Kc1lYTXVNMVV6?=
 =?utf-8?B?d0hqVnU5R3RiT1F6KzRsd2NBVUgzdmwwRnc3Q2hINHVsR01pWWlSR1YvZHBh?=
 =?utf-8?B?KzNrUEhabU8rYnV2VHI0aXpleVFmZGRiSnM1RXhjcHcvdEpMRXF3eTV5SzJN?=
 =?utf-8?B?aVRWajNBMjZ5WnpjVSt2V0VyMFpsTlMxWkNPMFo0OE9rV2tPSlMzUTRjbVpW?=
 =?utf-8?B?N3B1aUV1YTBKMzRRcmdUNnNCdGNzNHFQMmN0R1V6SHJLSGZzV0dPZUlhUUo2?=
 =?utf-8?B?UmxPdkw0eVVFdTQrOFluVHRSSTlvRFJORS93akVHOEVQTm1GZWZGS0JZb1d4?=
 =?utf-8?B?alc0S2xYNy9vMlJtcFh5WW5teWpweU5ISUMrRmtSV0dWNllQeFJVOS9aak45?=
 =?utf-8?B?SzkzM1pmbzE4cUw4SWJWRlQ2eklZRXVSbHZvWHovR0pPZmhnUjZheVEydXRq?=
 =?utf-8?B?YXVwZlZOZ0tpaFlRM0RMK21lU2FrRS9SVWFSVVVKelRsV1FqM2FpVHFXYXFD?=
 =?utf-8?B?THJVRFhaRnA0Q1IrbEpJNDgySXJwMmp0WTVIZXNUSDB0NVRkZitlMEZjWVpk?=
 =?utf-8?B?dS9CY0IxZFkwR2NISWRtaDZEZVBJZ1h0dGQzUUs0VGxwN09PcFFJUm94TUtZ?=
 =?utf-8?B?K1pFdEZ6amZRRDVocUxuYllQS2pzT3lpelgzbE4wUHY5ZlZsSkJJb3ZKUDJz?=
 =?utf-8?B?b2dWWVozMmtiQmFleWNLQnkwREZ4KytpamxEUDZaNmpRL2pZeFpNQWJ2L1VV?=
 =?utf-8?B?OHdrVFErN2N1NENtTlJUcVhVOEIwWDhGaUNIek40YW4vVS9aaUVwZmVHTzc0?=
 =?utf-8?B?TVJHT25GMDFnTkFOUjVFY2RlS0FMbE1sUkkzTnYveXYrZVBKa3BrbDFCTHdD?=
 =?utf-8?B?QThNM2xBdERRdnZQV2hiMThKMEJvYVd2TndhZkx0d0wyMnhpeUQ3TXZSNjlz?=
 =?utf-8?B?RjlsVlE0d0poQVA0MDJ0cHg3SU1Yam85V0lISzZyNzNnL3UxSzc2eVBMeUpr?=
 =?utf-8?B?bUpNMnZ0L2gvWWw1RE52ZXBqdVM5L2I0Y2JXdEhLN1lrN01NdWZkalFvTUtq?=
 =?utf-8?B?aU5QM3gxNS95QS8yOWZQelkzdEM2WEV6aGVKd1dHVlVKeC94RUZSWGF4QnBJ?=
 =?utf-8?B?aFZpcXdjeEoxcjZ1NnVrTDEydTU0TC83bnVudElvMVZGUlRSYXFFVVZHV2ZZ?=
 =?utf-8?B?K2lZNUYraUVST3RmY2VVcU9hYUIvaytXcWlsa1l1MFQ5Nzh2K2RpeWN1TEdU?=
 =?utf-8?B?NWNGdThCOU05ZzFIVWJRUlJERG1WRXBsdi8yWE1kYjlYd3lOd1hyMmpkY2lL?=
 =?utf-8?B?Q0hpZG5FVnl4cHZQeFhoT3NyRUNranYzR0N4SWRjcVNFblBTOGJpQ216dW1Z?=
 =?utf-8?B?SGFHTUFIZVg1NDVQT3creUpnZ2p2aTlhRjlxNUpvUDV2QkhZdmI2NWdmd0Z5?=
 =?utf-8?B?ZzRydEJHbkhpVlFPQ3NsZkhkT1Rab1h3V3ZjM1B2Vjg3amIvMExVaTc5K3oy?=
 =?utf-8?B?c0dYTS9kb3J3SlV4OUZsUjhTNW5KZE1CUm9wMENBd2VYZTQ0eE5XQUExQmdW?=
 =?utf-8?B?MzN2SDVnV1g2NDVKYXZDM2dPbnFnWW9ndVNxNnZjS2dEdFlHQTM5enlta1hm?=
 =?utf-8?B?UWNPbmYwZXhrMms0Q1lGL2dyM01pL3hWMWsrQW9UeWRPUFRiUFhzMFF0ZG53?=
 =?utf-8?B?U1AzdS8wdDFvOVN2dUhTYXpMSW9jek9KMHRuNEhJME44TDdFeS9qR0ZOMTRr?=
 =?utf-8?B?N25YVkdkaUoyN3RXaEx2RUdJR1RKNFJUcTN1WVhrMnppcU5UY3RaOGY2cU8z?=
 =?utf-8?Q?rR5i8E8Riqy1KUHbZt3jRmEmZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1323.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 494ee45b-e154-4f77-0305-08dd9ccff52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 03:38:34.1343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GV9sACfk/iiRHFxredxNAp3t46ksWNznZJKyqI8JaxQxrweG+oFZ5xrd4/I614RUsgnH+2AA75GAuETAEdgT45cZHChAPfJLZW+kZ9oqHa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB1811

PlN1YmplY3Q6IFtQQVRDSCBuZXRdIG5ldDogdGlwYzogZml4IHJlZmNvdW50IHdhcm5pbmcgaW4g
dGlwY19hZWFkX2VuY3J5cHQNCj4NCj5zeXpib3QgcmVwb3J0ZWQgYSByZWZjb3VudCB3YXJuaW5n
IFsxXSBjYXVzZWQgYnkgY2FsbGluZyBnZXRfbmV0KCkgb24gYQ0KPm5ldHdvcmsgbmFtZXNwYWNl
IHRoYXQgaXMgYmVpbmcgZGVzdHJveWVkIChyZWZjb3VudD0wKS4gVGhpcyBoYXBwZW5zIHdoZW4g
YQ0KPlRJUEMgZGlzY292ZXJ5IHRpbWVyIGZpcmVzIGR1cmluZyBuZXR3b3JrIG5hbWVzcGFjZSBj
bGVhbnVwLg0KPg0KPlRoZSByZWNlbnRseSBhZGRlZCBnZXRfbmV0KCkgY2FsbCBpbiBjb21taXQg
ZTI3OTAyNDYxNzEzNCAoIm5ldC90aXBjOg0KPmZpeCBzbGFiLXVzZS1hZnRlci1mcmVlIFJlYWQg
aW4gdGlwY19hZWFkX2VuY3J5cHRfZG9uZSIpIGF0dGVtcHRzIHRvIGhvbGQgYQ0KPnJlZmVyZW5j
ZSB0byB0aGUgbmV0d29yayBuYW1lc3BhY2UuIEhvd2V2ZXIsIGlmIHRoZSBuYW1lc3BhY2UgaXMg
YWxyZWFkeQ0KPmJlaW5nIGRlc3Ryb3llZCwgaXRzIHJlZmNvdW50IG1pZ2h0IGJlIHplcm8sIGxl
YWRpbmcgdG8gdGhlIHVzZS1hZnRlci1mcmVlDQo+d2FybmluZy4NCj4NCj5SZXBsYWNlIGdldF9u
ZXQoKSB3aXRoIG1heWJlX2dldF9uZXQoKSwgd2hpY2ggc2FmZWx5IGNoZWNrcyBpZiB0aGUgcmVm
Y291bnQgaXMNCj5ub24temVybyBiZWZvcmUgaW5jcmVtZW50aW5nIGl0LiBJZiB0aGUgbmFtZXNw
YWNlIGlzIGJlaW5nIGRlc3Ryb3llZCwgcmV0dXJuIC0NCj5FTlhJTyBlYXJseSwgYWZ0ZXIgcmVs
ZWFzaW5nIHRoZSBiZWFyZXIgcmVmZXJlbmNlLg0KPg0KPlsxXToNCj5odHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvNjgzNDJiNTUuYTcwYTAyMjAuMjUzYmMyLjAwOTEuR0FFQGdvb2dsZS5jb20N
Cj4vVC8jbTEyMDE5Y2Y5YWU3N2UxOTU0ZjY2NjkxNDY0MGVmYTM2ZDUyNzA0YTINCj4NCj5SZXBv
cnRlZC1ieTogc3l6Ym90K2YwYzRhNGFiYTc1NzU0OWFlMjZjQHN5emthbGxlci5hcHBzcG90bWFp
bC5jb20NCj5DbG9zZXM6DQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzY4MzQyYjU1LmE3
MGEwMjIwLjI1M2JjMi4wMDkxLkdBRUBnb29nbGUuY29tDQo+L1QvI20xMjAxOWNmOWFlNzdlMTk1
NGY2NjY5MTQ2NDBlZmEzNmQ1MjcwNGEyDQo+Rml4ZXM6IGUyNzkwMjQ2MTcxMyAoIm5ldC90aXBj
OiBmaXggc2xhYi11c2UtYWZ0ZXItZnJlZSBSZWFkIGluDQo+dGlwY19hZWFkX2VuY3J5cHRfZG9u
ZSIpDQo+U2lnbmVkLW9mZi1ieTogQ2hhcmFsYW1wb3MgTWl0cm9kaW1hcyA8Y2hhcm1pdHJvQHBv
c3Rlby5uZXQ+DQo+LS0tDQo+IG5ldC90aXBjL2NyeXB0by5jIHwgNiArKysrKy0NCj4gMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPmRpZmYgLS1naXQg
YS9uZXQvdGlwYy9jcnlwdG8uYyBiL25ldC90aXBjL2NyeXB0by5jIGluZGV4DQo+ODU4NDg5M2I0
Nzg1MTBkYzFkZGRhMzIxZWQwNjA1NGRlMzI3NjA5Yi4uNDk5MTZmOTgzZmU1ZTFkNDg0Nzc5NDUx
DQo+MDRmZTVmYzU4OTI1NzUzMyAxMDA2NDQNCj4tLS0gYS9uZXQvdGlwYy9jcnlwdG8uYw0KPisr
KyBiL25ldC90aXBjL2NyeXB0by5jDQo+QEAgLTgxOCw3ICs4MTgsMTEgQEAgc3RhdGljIGludCB0
aXBjX2FlYWRfZW5jcnlwdChzdHJ1Y3QgdGlwY19hZWFkICphZWFkLA0KPnN0cnVjdCBza19idWZm
ICpza2IsDQo+IAl9DQo+DQo+IAkvKiBHZXQgbmV0IHRvIGF2b2lkIGZyZWVkIHRpcGNfY3J5cHRv
IHdoZW4gZGVsZXRlIG5hbWVzcGFjZSAqLw0KPi0JZ2V0X25ldChhZWFkLT5jcnlwdG8tPm5ldCk7
DQo+KwlpZiAoIW1heWJlX2dldF9uZXQoYWVhZC0+Y3J5cHRvLT5uZXQpKSB7DQo+KwkJdGlwY19i
ZWFyZXJfcHV0KGIpOw0KPisJCXJjID0gLUVOWElPOw0KLUVOT0RFViBzaG91bGQgYmUgdXNlZCBp
bnN0ZWFkIGFzIHdlIGFsc28gdXNlIGl0IGZvciBiZWFyZXIgcmVmIGNvdW50LiBUaHVzLCBjYWxs
ZXIgb2YgdGlwY19hZWFkX2VuY3J5cHQoKSBkb2VzIG5vdCBuZWVkIHRvIGNhcmUgYWJvdXQgaGFu
ZGxpbmcgbmV3IGVycm9yIGNvZGUuDQo+KwkJZ290byBleGl0Ow0KPisJfQ0KPg0KPiAJLyogTm93
LCBkbyBlbmNyeXB0ICovDQo+IAlyYyA9IGNyeXB0b19hZWFkX2VuY3J5cHQocmVxKTsNCg==

