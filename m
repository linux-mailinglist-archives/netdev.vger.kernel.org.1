Return-Path: <netdev+bounces-202319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341BAED44C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D5D3A1BE7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711131D7999;
	Mon, 30 Jun 2025 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="MiHtPDjU"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022127.outbound.protection.outlook.com [40.107.75.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3A1D516F;
	Mon, 30 Jun 2025 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264113; cv=fail; b=nZaA+YCyhl9kDIoVzBKzbw7WW1hcawFYn50Rb3cs8yjASbrunJ3d2LII1OFZeklR/uE439Ukbien9KwynLsXha4y3tgQAnqmvcPMvAE2MmMfsnerj0SYtOmIVjCiWgmTHcCUtdU+2vgV0Jeqk+mMBXGmu0wxTWkWSu7b5JOOfVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264113; c=relaxed/simple;
	bh=zAGTLenlhiVSIRv9vq8mf+CPwId+7rgrp2RHFVxDBCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f6haCLQ3z0I1QEdfXp0ioJ5XjqlxCwYw44lB0HOl4PpJlMSCon71O3WuXOSbj2azhzBbBmUQU0xYNj6wWLKmhSoli7QW2s+YL1tp5cqzPqLy9Cuj34GL48UySJ59dvjHx9WcriJIqiNSmZ0g43z2315LhebkJ/QevaCT3RyTPiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=MiHtPDjU; arc=fail smtp.client-ip=40.107.75.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwtDjNLogTYOa+AnCvyp1MrngAKhMBfSwszfSm3C3udlvklmFuDeO04bIVe2cU8jVHBzQY6g6wjtPLFTtneIFfuS20HfUSlYbVTHumyUkXIdpoI5ZiB8krx2iWROD5ejKsnIwWzUDIpC/p+o07t5e9sVWZmB1yPE47KAxeUFI1yBNMw0JW+JK/84rynAUJgRwsePPiCTYy10o++St/2/oaYFqlkSiZqP5b0rnQdXGF/YeO6xf6qNcTP+PMJhJOmwjXA96m/bITCaa4VJujbG6e7FCW4CWkDWPdPHtsyMcHEKYM2v7SfHkqcxyLfCK2pKyBJDaQU23G1+v+UNKS2S8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JDlewWK3t8BapMAXMmTRHQbwpnQrWR+b4r7O+MGXwM=;
 b=LJKTnQhYPrGlRhpxzKAIU0hI3CdclIiGCuUvzjgTgI1vhOQH5UO1+JXWk5deUV/U6NHV+1I7PnlihrnRxh8KHB1DePsdw47cij8P4TIGjWiNcVluH4nBYNaLhbj1GOHZbl0F9pLgFGMnUgO9oXNCDCebFJNyAY75YW35wwqwWHwBbBVvmhEU/a8YjanSTn8ZX3/nLreZAepuiijxX31AeMbEBDevToioto/90WoLVnRZbEy0HoY3IPswHWOSKH5fRh3nC/V9nZq25YCm856axosHpR0RqxqxZc0gyWmZWyv3qxn4VSc1ZWCjJyAGPmSy10QOQdl5h4Wxz0dbCHKrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JDlewWK3t8BapMAXMmTRHQbwpnQrWR+b4r7O+MGXwM=;
 b=MiHtPDjU8QYE6BUkIK7WopDl8GtTEvveXsmZ/VVVvW6WffqKCOOr2Xq/mvysOHbcwPM9g7mbj8hWOZkJhpB0qgY1nbYqG156rTH5ur8moISxJhFvORjk7a8E/Nl2dfg1SBSR6LpMW7BBrKZBHx+Cya/PY31BTCiIAoUBHmYwfltm1rpaFfZPj9ARQL64/XfhD+HwUeCrxRfL2f2Kkr9sZ4K77BhmeJrnfmiWE+sjqU+ifqlRBC1LzI920hyQ7Q7EhIUu7Eokrhh/gVnslDxUdg5Fa2gwGBAIiU/ZUSuUDapecm+OIo5PYJCNUgS3LxBKWqJ98C68Bzd/f2vmsSwNYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SI6PR03MB8609.apcprd03.prod.outlook.com (2603:1096:4:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 06:15:05 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 06:15:03 +0000
Message-ID: <45469157-ff75-4c4f-953e-09ec6b399071@amlogic.com>
Date: Mon, 30 Jun 2025 14:14:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
 <1306a61f39fd92565d1e292517154aa3009dbd11.camel@iki.fi>
 <1842c694-045e-4014-9521-e95718f32037@amlogic.com>
 <CABBYNZJYeYdggm7WEoz4iPM5UAp3F-BOTrL2yTcTfSrgSnQ2ww@mail.gmail.com>
 <312a1cc3-bf55-443e-baad-fd35fede40c8@amlogic.com>
 <CABBYNZJu-LY1kBQCa6cMJyxMQ2PU8PGT-B_qgy56quZAFSjChg@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJu-LY1kBQCa6cMJyxMQ2PU8PGT-B_qgy56quZAFSjChg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SI6PR03MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e48f96e-3b13-4347-be69-08ddb79d73b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG8yUTNaQjZKQUhzTU83ZHFZZnRuWEszZ3IvTjVRRko2MXhNVlE2aE8ydDhP?=
 =?utf-8?B?RmV2enhyQVQ4a0N0emFvaEQ2eEM0dUFMNFBFL3VNWmhxSjZ0QlJuaDhlTm5N?=
 =?utf-8?B?TUZpMCtHdmI0OTM3eGhVakZkMVpXa25Ld05lUE1IUkxiamswNE9BbnZjTlpX?=
 =?utf-8?B?b3poemZ5Zkg2bHVmWjRNM2NwM1pncWtkR29yenBobWh3RjE5NEh6RGh0cGo1?=
 =?utf-8?B?ZktpckJJYTk4eTk0NFZ5cVozYnJ3UVdMN0J0dE55TzFpZXlGYVhKbmlrRy9r?=
 =?utf-8?B?RmJxVUlwMFBGWHBhSXVVaGNuM21WWWp4MUFmUFRyaHZqQ0o4N05RVWxTcUZa?=
 =?utf-8?B?TjlhWTJMeFFjSXpWaEk0dlFucjVObzNOSzlzdm1ENzQweDBKM2tBVkZMdzJK?=
 =?utf-8?B?YUVHeUVCbEFZem15ekV1U1RkM3pXWThJZ3V5QWxTbUJONGNSVFVpY3BCSUs4?=
 =?utf-8?B?UlNZbGlLdkZCTE5neG1Qdy8wdXFyNURmTlZHc0F4S3ZHV01ycWZqZHhMeFI3?=
 =?utf-8?B?bmlwWWhuN1F3MjJGWmxOYlozNkJnUC9veVY5M21EeDNGK3lpS1RvRUptVCtE?=
 =?utf-8?B?STBrVW1OQzQxMlU3K1VUUkJWNGZXUDVaaCtybWRURlZhYlhVcGtsbzZDWC9T?=
 =?utf-8?B?RUNGNEtXWE9BTTJSc2hvOThXc2MybXo5M0hzcmVQeTUrK3FjYWpWNGpjSEN2?=
 =?utf-8?B?OHNzNzZraGJ3MC9UOFJkOUJHNnVzQytzWjFNcFJkRFlHK21uVlB3VmkyZGhX?=
 =?utf-8?B?UGRvS2wwaWlHYkRlRFF3cGhMZzllVEJhcEVyeCtvVFZWcmVOMEJZN0FQK3VI?=
 =?utf-8?B?NStjYWZ6M0Z2cVA1Qkd1S3UzTk9DczE1WEdvcmxSeHk5ajgwWWkzV001ZHp6?=
 =?utf-8?B?RnZocGs0Q1hIVm9RZnh3K1NJbmFnMXhReHBhV0dVMEVuVmozS0VVaFRqYUxv?=
 =?utf-8?B?TjRjY2lGNGZ2aXNTOHFZSXNTby9Pb1VkV3pxdzhIWVZmMkRxQ2c1UVNYZ3lh?=
 =?utf-8?B?ZnZKbHBSMXFkWUkvcGFmVlJUWXQ2RThLL1hxb2dGOUUxRVEvK252Nksvd3A4?=
 =?utf-8?B?NjhQQzRhTzRWTEFBTHFZWXFHZnFzM1BodTcrQU9sVGhHRkVBaUhrRnpZUVNK?=
 =?utf-8?B?SXRwb1BZWTJyZ0NIUFBwRzR3dlM1eGxidDVjcEZvU0NDQnVyUjhWMUMwMTB3?=
 =?utf-8?B?UlBuOGNoV0UxNzc0dkFHQnFaUHI5ZHZMODZ6NEVUNkpRaHFsZUc1OXJFMXdJ?=
 =?utf-8?B?SlVrQjVZV1J6YlMzOWxTN0gyNSs1dXlibHp6SnBjUjlrNStGbjB5QmxTcEdZ?=
 =?utf-8?B?U2RjRFNCUTFFUUJPUU9qOHlUUk53d09SZVNQSFhOVzJEWEhYVnpSMklNT1Rs?=
 =?utf-8?B?ekhGa3hIdlZ3d0NDeExqczh5VW4xZlVWakk3S1YxTlBFVytETzg3Mkdpci92?=
 =?utf-8?B?c0MyWmtRckJyM0RqR09QdVVzR01vckpUQkdkRndHMmtxOUQ4MHlYZVZEZElZ?=
 =?utf-8?B?WWY5Y2I5NCt1cThTNU9rMGplUlFWb09QUUhXZXh6cDN3eSttUGI4MmZ2bVhX?=
 =?utf-8?B?K21yUVl0cVFyaGQwS3Y1aWs4K3JHUXZHUEY0TXBQbVBzYW03MmlWQzJzaDNR?=
 =?utf-8?B?S1NkOXMrOXRraXpVcDNiK3hneWdKRTIyTzdKc0Y1enBOYVFiczYxNlRtbUtK?=
 =?utf-8?B?a3VuempIbTdlczNWait3cFNxVzc5V0xmaVFTME00Y05CcCtSWElvUGxzSTQr?=
 =?utf-8?B?KzBtc3g2cFdJbytEMXF6LzJxWjdpeFp0MXBBWnZYeTVFQWhKWDd1dnBseHRr?=
 =?utf-8?B?a2xwWTN0UlRYUjR1aUwySVNoT0dkYktmTlRqT3lwSm5hYzFIamJoN080anNN?=
 =?utf-8?B?K2VFMWowMUZ2ZkhjTGxNQUhTT2lVRFZpSENLUThIaER6UkhvZVRNMTdJb3Jl?=
 =?utf-8?Q?TaMP6hrscT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVhakV3bmI5VjdLMWRWVGR4MTVNaGhCbWg3ZzhKdzFBUzJPaXVyTWgwekJN?=
 =?utf-8?B?VWxqemNnZVJ0V0NBb2VGdDRUdHB0OFpFMzdFLy8waGl1QU12a3N4enZNM1Fh?=
 =?utf-8?B?Q29TS0gzcC9iYVBNWktaamJQcllHeDdzTWlYR21RSklTNTZQZDIxVmtPZ1Iy?=
 =?utf-8?B?UFVJSEpUV2EwOVJUQ3YrRXRHM1FUVkdmelFCejhXVHlKcFBUNmUxaDZYSDha?=
 =?utf-8?B?SnFYOVYvajJqbFlDVjg2V3ZRdDRDcURNeCtUdUdSME0zb0NMNnlBTWZmWDlq?=
 =?utf-8?B?dzZYQ0h1bTlFcmNRY1BHK1BnTWlKYnNEdDh6NERRbHNKNlA2R3FjUkcxL1ZQ?=
 =?utf-8?B?c1VadTFxYk1kMEc3QmlsQXN5aXd1a2ZTNThKcmhyK3pIS2pXeG5mM2piMWFm?=
 =?utf-8?B?WmtUYkIwaEY4N0VveUNSSnRWdEVYNzZCZlp6OTJaVUFpMVRYZmN5alIxM3Ev?=
 =?utf-8?B?TEtrcUZaaDBpSTRXTlhpZFFhc2JrNk5WOFJRT01mZE4xRHo1c1FRWUc4cE9E?=
 =?utf-8?B?TDdoNzRCMSsrRW5MNDVaUWVrcjZsUWhDUGNqVzhvY2V0R2VSSjh2S0FqRE1Y?=
 =?utf-8?B?T3lCVDVReEgyUnBXbjFRVXR4eXBYcGpSdzQ3R2kwR0IwazZwZzNqUm5rSDFW?=
 =?utf-8?B?MVREdWc4ZXc1clJKeDNQTm10NHh6OU1mMURuc1JpSXo4Y1dsYmhCczd3RHhj?=
 =?utf-8?B?d3hXT3dsRllkVkF3U1JNVHlNOHhoNkcwa0p1Z0gwdzAvb20zS3JFYy90T3Bi?=
 =?utf-8?B?cnBWdGVuR1Q1YzNlS1hiallVNjNCd3JhcnhwbWxtMU5uMVkvTG9UakFuY1ZZ?=
 =?utf-8?B?SW9YbEF5Y0VPT2lJRkpOL1NyL1JVb3doV0t4aCtUeWw2SFRUSkpsL1BDZWZ3?=
 =?utf-8?B?VE93RTlrYTlJQndwSWZwUUJ3NHFuY0preU5IM21veHZDUTdzQUx4Mit5em0x?=
 =?utf-8?B?L3RHcmVGbUg5M1hJdlovdXByM25MNVpqNkdqWkpXMUt1bXJtOWxvN2x1K1k0?=
 =?utf-8?B?NlI2VU10Y2NheXZ4bVZLamZYdEZoeGRweG84NzJrYmhxeGR3d0FLTmxINEtJ?=
 =?utf-8?B?cUxuMm4ybEVpSW9KUzhlZDV5d0VJQ3huNUJMVWQvMW91S2VmOCtVZTFUcW5y?=
 =?utf-8?B?dS9DYlZOeEpNUnJuUkpaSUM0bG82RVBBbVJ3YjdlREVPWmQ1blBWWElLTGRa?=
 =?utf-8?B?SUtCSkdGTVhFeFRHeXRyKzBGaSs1RUhmRjZWaG9DQjN5MDRVc2dKR1NuK3Nj?=
 =?utf-8?B?T1ovVy81cUdGejU2MG5jTDljZU1mTjBFMXJsOSswQk5raDZGQ3RwUURWZEpH?=
 =?utf-8?B?YXd6TGZRQU1oenJJbjF5RFN2Uisxb3gzN1hRRlRKQzAwWmpKRnFKMlFYVC9W?=
 =?utf-8?B?S2lyWllieHowMW85d0dmcXRiekI3bnB3K0VES3F3MGlJNklNMisxaWoxMDQr?=
 =?utf-8?B?NDg5djU4RUFlY3o5ckIrR1RDWmlURXNHQWVzZnBaUkhvSGt0cTJPZndQTnJD?=
 =?utf-8?B?QVlxZVIrWEZNd2JSdTFHQTVsVTkrZ0dCU0FvSDV6QWlOUjl4TTVGK2c0TFVh?=
 =?utf-8?B?dHJrOUxVS0FQZzZHSDlHN2JZbDFRRjlDZ1VwNmMzZ0pNd05WUjJ1M090YnA4?=
 =?utf-8?B?RG9rMmRtZ09lSnlULzBSclRXUjFTK0ZZZjAzNlZ0NFlRcGIrSWdWeGliVE9t?=
 =?utf-8?B?VDNUbUJUdm5tRUJSUWlSSTZVMGdHMG9XQUZhNnowV3FKYUFreUEzVERlc2hD?=
 =?utf-8?B?TEVHLzg0djBxUmNNOHFqaFJxRmRYRXZRd01VY1g5dlVEOTVrc3Npb1NpMUhL?=
 =?utf-8?B?OHRNWmZzU0FaMkxDQjVWRCtKWHU0azdSbEFSa1d3d1VXR09KZnB5Wi9vS1hF?=
 =?utf-8?B?TFdxRWZ6MzBvUi9JK05OaTFVbmIrdmlqRjZ0cGhiaHBnZWUrQzFRbkh0Um0r?=
 =?utf-8?B?YlNxM0pQODB0NzZQbms0ckNoTllNUVN2R3JWVndUQVNvVnlMS2t2K0hub2po?=
 =?utf-8?B?dkFYWHRGSEFFcW9FZVowQmkxdWJoL2VOais2THVuR0srTUpqWXhuVzE3aVI1?=
 =?utf-8?B?ZC9DaFllRjVRSWpxVTFleUJ0ZDNPUm1IQ0s3YlhNK05oWTdPMTZhMUJYd05m?=
 =?utf-8?Q?X4xIDRRKitE/DB//D6/BhWvIA?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e48f96e-3b13-4347-be69-08ddb79d73b5
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:15:03.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkDi5DjGfCeSjSi7u99GIhJtAfRPT2uf6+Mu+s54ol88JNjTFRV526rf9ZEe3bwwCkVNnC2hGbd5sjdnwIEPhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8609

Hi,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Fri, Jun 27, 2025 at 7:31 AM Yang Li <yang.li@amlogic.com> wrote:
>> Hi Luiz,
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi Yang,
>>>
>>> On Thu, Jun 26, 2025 at 1:54 AM Yang Li <yang.li@amlogic.com> wrote:
>>>> Hi Pauli,
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> Hi,
>>>>>
>>>>> ke, 2025-06-25 kello 16:42 +0800, Yang Li via B4 Relay kirjoitti:
>>>>>> From: Yang Li <yang.li@amlogic.com>
>>>>>>
>>>>>> When the BIS source stops, the controller sends an LE BIG Sync Lost
>>>>>> event (subevent 0x1E). Currently, this event is not handled, causing
>>>>>> the BIS stream to remain active in BlueZ and preventing recovery.
>>>>>>
>>>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - Matching the BIG handle is required when looking up a BIG connection.
>>>>>> - Use ev->reason to determine the cause of disconnection.
>>>>>> - Call hci_conn_del after hci_disconnect_cfm to remove the connection entry
>>>>>> - Delete the big connection
>>>>>> - Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com
>>>>>> ---
>>>>>>     include/net/bluetooth/hci.h |  6 ++++++
>>>>>>     net/bluetooth/hci_event.c   | 31 +++++++++++++++++++++++++++++++
>>>>>>     2 files changed, 37 insertions(+)
>>>>>>
>>>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>>>>> index 82cbd54443ac..48389a64accb 100644
>>>>>> --- a/include/net/bluetooth/hci.h
>>>>>> +++ b/include/net/bluetooth/hci.h
>>>>>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>>>>>>          __le16  bis[];
>>>>>>     } __packed;
>>>>>>
>>>>>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
>>>>>> +struct hci_evt_le_big_sync_lost {
>>>>>> +     __u8    handle;
>>>>>> +     __u8    reason;
>>>>>> +} __packed;
>>>>>> +
>>>>>>     #define HCI_EVT_LE_BIG_INFO_ADV_REPORT       0x22
>>>>>>     struct hci_evt_le_big_info_adv_report {
>>>>>>          __le16  sync_handle;
>>>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>>>>> index 66052d6aaa1d..d0b9c8dca891 100644
>>>>>> --- a/net/bluetooth/hci_event.c
>>>>>> +++ b/net/bluetooth/hci_event.c
>>>>>> @@ -7026,6 +7026,32 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>>>>>          hci_dev_unlock(hdev);
>>>>>>     }
>>>>>>
>>>>>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>>>>>> +                                         struct sk_buff *skb)
>>>>>> +{
>>>>>> +     struct hci_evt_le_big_sync_lost *ev = data;
>>>>>> +     struct hci_conn *bis, *conn;
>>>>>> +
>>>>>> +     bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
>>>>>> +
>>>>>> +     hci_dev_lock(hdev);
>>>>>> +
>>>>>> +     list_for_each_entry(bis, &hdev->conn_hash.list, list) {
>>>>> This should check bis->type == BIS_LINK too.
>>>> Will do.
>>>>>> +             if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags) &&
>>>>>> +                 (bis->iso_qos.bcast.big == ev->handle)) {
>>>>>> +                     hci_disconn_cfm(bis, ev->reason);
>>>>>> +                     hci_conn_del(bis);
>>>>>> +
>>>>>> +                     /* Delete the big connection */
>>>>>> +                     conn = hci_conn_hash_lookup_pa_sync_handle(hdev, bis->sync_handle);
>>>>>> +                     if (conn)
>>>>>> +                             hci_conn_del(conn);
>>>>> Problems:
>>>>>
>>>>> - use after free
>>>>>
>>>>> - hci_conn_del() cannot be used inside list_for_each_entry()
>>>>>      of the connection list
>>>>>
>>>>> - also list_for_each_entry_safe() allows deleting only the iteration
>>>>>      cursor, so some restructuring above is needed
>>>> Following your suggestion, I updated the hci_le_big_sync_lost_evt function.
>>>>
>>>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>>>> +                                           struct sk_buff *skb)
>>>> +{
>>>> +       struct hci_evt_le_big_sync_lost *ev = data;
>>>> +       struct hci_conn *bis, *conn, *n;
>>>> +
>>>> +       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
>>>> +
>>>> +       hci_dev_lock(hdev);
>>>> +
>>>> +       /* Delete the pa sync connection */
>>>> +       bis = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
>>>> +       if (bis) {
>>>> +               conn = hci_conn_hash_lookup_pa_sync_handle(hdev,
>>>> bis->sync_handle);
>>>> +               if (conn)
>>>> +                       hci_conn_del(conn);
>>>> +       }
>>>> +
>>>> +       /* Delete each bis connection */
>>>> +       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list) {
>>>> +               if (bis->type == BIS_LINK &&
>>>> +                   bis->iso_qos.bcast.big == ev->handle &&
>>>> +                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)) {
>>>> +                       hci_disconn_cfm(bis, ev->reason);
>>>> +                       hci_conn_del(bis);
>>>> +               }
>>>> +       }
>>> Id follow the logic in hci_le_create_big_complete_evt, so you do something like:
>>>
>>>       while ((conn = hci_conn_hash_lookup_big_state(hdev, ev->handle,
>>>                                 BT_CONNECTED)))...
>>>
>>> That way we don't operate on the list cursor, that said we may need to
>>> add the role as parameter to hci_conn_hash_lookup_big_state, because
>>> the BIG id domain is role specific so we can have clashes if there are
>>> Broadcast Sources using the same BIG id the above would return them as
>>> well and even if we check for the role inside the while loop will keep
>>> returning it forever.
>> I updated the patch according to your suggestion; however, during testing, it resulted in a system panic.
> What is the backtrace?
>
>> hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
>>
>>           list_for_each_entry_rcu(c, &h->list, list) {
>>                   if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
>> +                       c->role != HCI_ROLE_SLAVE ||
>>                       c->state != state)
>>                           continue;
> It needs to be passed as an argument not just change the role
> internally otherwise it will break the existing users of it.

After testing, I found that the dst addr of the two BIS connections 
under BIG sync is the address of the BIS source, so I added separate 
checks for MASTER and SLAVE roles.

[  268.202466][1 T1962  d.] lookup big: 00000000736585c7, addr 
21:97:07:b1:9f:66, type 131, handle 0x0100, state 1, role 1
[  268.203806][1 T1962  d.] lookup big: 0000000041894659, addr 
21:97:07:b1:9f:66, type 131, handle 0x0101, state 1, role 1

I updated as below,

-hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  
__u16 state)
+hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,
+                                                 __u16 state, __u8 role)
  {
         struct hci_conn_hash *h = &hdev->conn_hash;
         struct hci_conn  *c;
@@ -1335,10 +1336,18 @@ hci_conn_hash_lookup_big_state(struct hci_dev 
*hdev, __u8 handle,  __u16 state)
         rcu_read_lock();

         list_for_each_entry_rcu(c, &h->list, list) {
-               if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
-                       c->role != HCI_ROLE_SLAVE ||
-                   c->state != state)
-                       continue;
+               if (role == HCI_ROLE_MASTER) {
+                       if (c->type != BIS_LINK || bacmp(&c->dst, 
BDADDR_ANY) ||
+                               c->state != state || c->role != role)
+                               continue;
+               } else {
+                       if (c->type != BIS_LINK ||
+                               c->state != state ||
+                               c->role != role)
+                               continue;
+               }

>
>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>> +                                           struct sk_buff *skb)
>> +{
>> +       struct hci_evt_le_big_sync_lost *ev = data;
>> +       struct hci_conn *bis, *conn;
>> +
>> +       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
>> +
>> +       hci_dev_lock(hdev);
>> +
>> +       /* Delete the pa sync connection */
>> +       bis = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
>> +       if (bis) {
>> +               conn = hci_conn_hash_lookup_pa_sync_handle(hdev, bis->sync_handle);
>> +               if (conn)
>> +                       hci_conn_del(conn);
>> +       }
>> +
>> +       /* Delete each bis connection */
>> +       while ((bis = hci_conn_hash_lookup_big_state(hdev, ev->handle,
>> +                                                       BT_CONNECTED))) {
>> +               clear_bit(HCI_CONN_BIG_SYNC, &bis->flags);
>> +               hci_disconn_cfm(bis, ev->reason);
>> +               hci_conn_del(bis);
>> +       }
>> +
>> +       hci_dev_unlock(hdev);
>> +}
>>
>> However, during testing, I encountered some issues:
>>
>> 1. The current BIS connections all have the state BT_OPEN (2).
> Hmm, that doesn't sound right, if the BIG Sync has been completed the
> BIS connection shall be moved to BT_CONNECTED. Looks like we are not
> marking it as connected:
>
> hci_le_big_sync_established_evt (Broadcast Sink):
>
>          set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
>         hci_iso_setup_path(bis);
>
> hci_le_create_big_complete_evt (Broadcast Source):
>
>          conn->state = BT_CONNECTED;
>          set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
>          hci_debugfs_create_conn(conn);
>          hci_conn_add_sysfs(conn);
>          hci_iso_setup_path(conn);

Yes, in addition, state = BT_CONNECTED also needs to be set in 
hci_cc_le_setup_iso_path.

I will update the patch again.

@@ -3890,7 +3890,7 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev 
*hdev, void *data,
                 hci_conn_del(conn);
                 goto unlock;
         }
-
+     conn->state = BT_CONNECTED;

>> [  131.813237][1 T1967  d.] list conn 00000000fd2e0fb2, handle 0x0010,
>> state 1 #LE link
>> [  131.813439][1 T1967  d.] list conn 00000000553bfedc, handle 0x0f01,
>> state 2  #PA link
>> [  131.814301][1 T1967  d.] list conn 0000000074213ccb, handle 0x0100,
>> state 2 #bis1 link
>> [  131.815167][1 T1967  d.] list conn 00000000ee6adb18, handle 0x0101,
>> state 2 #bis2 link
>>
>> 2. hci_conn_hash_lookup_big_state() fails to find the corresponding BIS
>> connection even when the state is set to OPEN.
>>
>> Therefore, I’m considering reverting to the original patch, but adding a
>> role check as an additional condition.
>> What do you think?
>>
>> +       /* Delete each bis connection */
>> +       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list) {
>> +               if (bis->type == BIS_LINK &&
>> +                   bis->role == HCI_ROLE_SLAVE &&
>> +                   bis->iso_qos.bcast.big == ev->handle &&
>> +                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)) {
>> +                       hci_disconn_cfm(bis, ev->reason);
>> +                       hci_conn_del(bis);
>> +               }
>> +       }
>>
>>>> +
>>>> +       hci_dev_unlock(hdev);
>>>> +}
>>>>
>>>>>> +             }
>>>>>> +     }
>>>>>> +
>>>>>> +     hci_dev_unlock(hdev);
>>>>>> +}
>>>>>> +
>>>>>>     static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>>>>>>                                             struct sk_buff *skb)
>>>>>>     {
>>>>>> @@ -7149,6 +7175,11 @@ static const struct hci_le_ev {
>>>>>>                       hci_le_big_sync_established_evt,
>>>>>>                       sizeof(struct hci_evt_le_big_sync_estabilished),
>>>>>>                       HCI_MAX_EVENT_SIZE),
>>>>>> +     /* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
>>>>>> +     HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
>>>>>> +                  hci_le_big_sync_lost_evt,
>>>>>> +                  sizeof(struct hci_evt_le_big_sync_lost),
>>>>>> +                  HCI_MAX_EVENT_SIZE),
>>>>>>          /* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>>>>>>          HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>>>>>>                       hci_le_big_info_adv_report_evt,
>>>>>>
>>>>>> ---
>>>>>> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
>>>>>> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
>>>>>>
>>>>>> Best regards,
>>>>> --
>>>>> Pauli Virtanen
>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz

