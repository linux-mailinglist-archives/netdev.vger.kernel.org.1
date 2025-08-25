Return-Path: <netdev+bounces-216645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF29CB34BA6
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9D01B20BD3
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46D284686;
	Mon, 25 Aug 2025 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="OYSoEgCs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFA221723
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153322; cv=fail; b=Q3rQc+dIEQphIfq9tROh1V2Afpn0EgKzyGQRUvvhVjXzNol/VQvqWjNTgcJxCRwQoXE8yXnBdSBoW1FpF2ig1Qfw6oZ2Z3gAN2dEgTj9cVI9Ip0DsjCzOQ8ZbU4Ywzni51lk7rytWa0WWbUnFE/LY9EBTux3ETtkX7hOuy0fOAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153322; c=relaxed/simple;
	bh=CtW6lNtK/jv00RUDJZpc+Km7PkBWeVZEzg3xrL79dvQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DVcOXYFgTO1HEd8R2uq7rLoxb5Rz97i/2anwVC2xSkPmTSkKzyI0FDUOjoXcCKEZ48jyhPcBMCy3ELzXEZpsBAdUBfrhi5QGd2ouXv8m6ttK1lb04CU9SrJzCEKICrBDi4ndMDD7xcsoWSyxwvstABYAjBtDsR1ogCVr4Y5Snao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=OYSoEgCs; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756153320; x=1787689320;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CtW6lNtK/jv00RUDJZpc+Km7PkBWeVZEzg3xrL79dvQ=;
  b=OYSoEgCs1ZrEdcuJaLg+Sxbhp8bIalPpI0p5Jlqn+xXH0ilFyEgdQDv1
   xkOWWkm5ATRAhkM/1aHTlzTdgNDjXBDLuUgYgeX3h2YLx6Ts4t1xZqBfN
   njJwCkXt5XoQ5+ii+tNdwHlEt0dXyK/7to3mec79ZaCOiCto5MO9yt55B
   k=;
X-CSE-ConnectionGUID: rXCgmHmEQnOEL9JWh4pmbw==
X-CSE-MsgGUID: e9o/jXtVQUK5/XGazZq8LQ==
X-Talos-CUID: 9a23:wrJBuW9QWMeqbDwlwUSVv1QkMc8gUnjw9XH3DmvpK1lpFKWQQ0DFrQ==
X-Talos-MUID: 9a23:2vo+hgRC4/TJQ4WSRXTh1TYlNvd03Z2TKx1KoboPqfudZQhJbmI=
Received: from mail-canadacentralazon11022075.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.107.193.75])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:21:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCFZ+leqBRqxtPPyINBTqhYnbPtHJOl4za2PXkXbmjz/A132s0eh8QntGSHBE83Eu2rVmBOUhIlCkS0oa73AmCvjVro99TZ7CyVOBBfvevAOYaEfSInPvBHfIUua1WWtJRAAh4pK3mgvB7FFDFYg5bOzfca8J/2w1B3uw6YU76R1BFZqnCscg7aUReW8LXczvfZsn7RcHT0JR2a2CBxYlve8A5VyWg8gKRbborQWOkQ/xBuUL/1LfPnESyjqQyw78LFUGA0l+9RJHQjktGqFNYnNIkvJ6PGySlGRHj2P0Ew/HvXFTmfOYJsVwboCIFLcs9DzNSB8MUN/u1MCjybwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju2JMVwRAj9QxAU0CL0xJuURHjZwLLETehisVFU6htc=;
 b=phSqdVrW6F8hxw9wXsCrVszz4d2s5jqTbBiwvu9BAV+IFBy5hmb/SXczky+mRWRWN/MMSN6YfwPnYmvs+LKEAJ5UufKRD0YdAOUSnA8c1W+HErtTfTH9fU/VGDLVjwqe5Bt+K2TCzMzH3EejuzEWuYkqYqJX54maKeQTqBm7SS4rrfsnMXmare+Av2zsWpD1vWTxQTHbdWqnivPhrBu/xnzoyTA9c0OBzWtxVi8LZFPFhYXeLYePgG/AmS6ybRQ7AdleH3F4Rmrb5GAhz2lOExrQOvaqcMumMhTd/GznMUlgzUjf7/da1yW4BTQ+Miqeio2iDv9Wjt2+xmiaIIS/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQBPR0101MB9246.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 20:21:55 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 20:21:55 +0000
Message-ID: <6441ae17-1b7d-4a8d-96d0-f526f410346c@uwaterloo.ca>
Date: Mon, 25 Aug 2025 16:21:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/2] Add support to do threaded napi busy poll
From: Martin Karsten <mkarsten@uwaterloo.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250824215418.257588-1-skhawaja@google.com>
 <8407a1e5-c6ad-47da-9b41-978730cd5420@uwaterloo.ca>
 <CAAywjhT-CEvHUSpjyXQkpkGRN0iX7qMc1p=QOn-iCNQxdycr2A@mail.gmail.com>
 <d2b52ee5-d7a7-4a97-ba9a-6c99e1470d9b@uwaterloo.ca>
 <CAAywjhStweQXMcc5LoDssLaXYpHRp7Pend2R-h_N16Q_Xa++yQ@mail.gmail.com>
 <fe42bbef-047c-49da-b9ff-a7806820ae0e@uwaterloo.ca>
Content-Language: en-CA, de-DE
In-Reply-To: <fe42bbef-047c-49da-b9ff-a7806820ae0e@uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0322.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::24) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQBPR0101MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ce8909-c0a3-4590-3619-08dde41508aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blFFMERpMERiYUhuTGVMbTB6VHFZNHFCQWJOejJrbVFXc25wZU1sN0NBMnpJ?=
 =?utf-8?B?cStoL1lVOUwxY2FURVVZempmdS9GYVkvWnFRTjREaHBrK1NNQVFmdUJsUTQ0?=
 =?utf-8?B?MXk2dzRScUNPSVdFbm40NG5oQTBsU01SVlpnQ0NPbnJCV21kSXBiNUl4UFVB?=
 =?utf-8?B?MG43SUcrSzFpWUtTSzUwc1FmUU9tM1ZKVzJrRFZaK09uVlV4ZldaRGc1bnRw?=
 =?utf-8?B?Y3VNdVo2bk5pc0x4NS9BOTkrSHBYS3QrOC9HQlVwRWoyZGxlWndPVkNJQTZD?=
 =?utf-8?B?QnRDU2wrUmhjZk14MVB1d21SS2x5bEsrVzJSeHQ5YnZGekFzcGc1VHRMN25l?=
 =?utf-8?B?MnNleDFkR20xVmtMZW9RQy8xd2FvR0JTKzhBQ2xNbFNNS0N2aGFHeWtTT0pt?=
 =?utf-8?B?Uk1lTzU5ZGcrWWhYb0g3d3drZGlpczcxMWRyNmxvWjJaUWJPeHZpUFBqc3lR?=
 =?utf-8?B?dEc0alF1cWpNd0svUDRwc2MydkRybThGNnV6V1MvNjl3ZTNPU284RnRqM3ZK?=
 =?utf-8?B?ZmVXVnoxRElDeEJzcjhhczB6NE5VcmFMNkFzeDY5SFgvaURyQVlxZHJpUk0r?=
 =?utf-8?B?bzFmY1VndkRDdURlOURUYmVzSEJZcnVuZXh3WExuS3pjU3RYRGEyWU42NjVQ?=
 =?utf-8?B?QjlhN1d6OGw2UGRIQS9aNWkwRHNtL1A3RjVxUzl6Q3gwNjI5dUVtQ1NXYW5O?=
 =?utf-8?B?SStHdTY3ckJ2Q3hOdmNRUWlZYmlqYnpIcjN3R0xxdzQ2OWQ3YXFxVUlCbFNa?=
 =?utf-8?B?V0Z3KzRVZjFSSTcwcjQvR2x1UGxYSnZ5Z29aZDNqWHdqamNkMXY1eUNlVjMw?=
 =?utf-8?B?UUg2cUV0Q3hsY3A2Rk9NdWZyTzBUbGJlWEN2RytCZlBKbkFyQXNQcFlNOE8z?=
 =?utf-8?B?Rk1HMVgxeWpqTzVzcUlucEsraVNkNUtqMTNqc1cxL0VRVWtTWVZtbTNKSmFR?=
 =?utf-8?B?SzlLYUR6OFFiK1ZzNFBkMnRzalpkYjRqOCtRRXpRUE12aVRYZVdwV3o3dzlD?=
 =?utf-8?B?aUtPQTdYT3VFWUFzUEx5aU5JMldzV25XcnJRZS9nUlB0RWVzNW1kelUzYVNJ?=
 =?utf-8?B?UWV0YjRZU0RnUUhiSkZKdnlwRzRsY0N6OGlGQnZMaVZWTkdtSmNVY2NTN0Z4?=
 =?utf-8?B?S2lwVFVWTENnNHQ2K2NKR3NocUJIUEs5OWRtdjhaLzh4WGhqQ1FaeVBEOGNP?=
 =?utf-8?B?WlB3SWcrLzZHc2ppZTRmTXBadi9zZ1pUYWVwRUtwakpzeGZuOWNydEFEb081?=
 =?utf-8?B?eEJCTGptRU5LSVA1OFJDYVh6eTQrZjdZb0pNc1I3YWpIR0wxZGFlL25wT04v?=
 =?utf-8?B?N0prd04vSXJqQ1UwdlQvNmJFdzZIdHUvSlI3SUcyc3NIREFOQjBYaDVQL1dx?=
 =?utf-8?B?K0Z5TE42SjNvNGcrSVIwTWpxcE40aFlOYThBb0ZTbml1QXpraGtxZ3dCczZ2?=
 =?utf-8?B?YTlCRFBCYys3UkRzVXpzTkpydU1EZFpzbzBTWXo5SDdTY0RwbWt6enRabktu?=
 =?utf-8?B?dkhMejl5eFJRRko1QXE3RThaUG94anNDem1SMjdWR1k5c2RlcGpSakVCMVF1?=
 =?utf-8?B?ZzRRSXlqeDJ3L1prTzJOLzlUZjFXd0haVlVPMTVudW9hUzJ6MmJUbTdFUDVw?=
 =?utf-8?B?RW5UU0xLQWVWNTJrbFNRQXZYUTR1OStta0wyWXU5RzB6WHFzVXIxS0dvMi83?=
 =?utf-8?B?ejRBUW1tdHB1dFhPU21IS1hhZDNtbytmWFpib3NkTS9JdFJkQ1hzVmJpNWVo?=
 =?utf-8?B?U1JacERrY1RodVpvRUlLNC9CRUtoRDdHekdjbkVmRnJjdnE1djB5ajRRQ1ZJ?=
 =?utf-8?B?eThPdkZWVVcvMUY1M0xkd0FMVW5wbm1TaHJ3ekxnVHJ2U3lVbnZiLzhHVVMr?=
 =?utf-8?B?V0tWclZRNG5TcFkvWkRud2Y0S2ZzRGVLRzlmdGt2N1Y5eWswN1E0eUgyWWdL?=
 =?utf-8?Q?N3lfY1x4Keg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVZFQVBOMDg0dGlxREduTXB1eTVMNlRGRXNUeEUvQkJFWlNzQ3lFQkpjVXVP?=
 =?utf-8?B?QllrUTJ6QzMvZDNEVGdQbmFGdXpDU09HbWM5QkdtcE80RzVHaFlmYUVtWFh4?=
 =?utf-8?B?MS9PUzZrVjZzOUx0QUFpaTFncmJXMit4QzBWdml5MFczL3Z6aUtzTy9QNEh1?=
 =?utf-8?B?bXgrZGUxeUIybktvaHVGMnc0bzZQK0Vtc2JVbFhNQmpKK2wrQnF5ajdGSG0y?=
 =?utf-8?B?TEdrUmtSNzNjSkxyNDlHWXRvdExHS1dUb2xiWDNqSnJPbmcycTJwVXdOWUZ6?=
 =?utf-8?B?cDRzZGVpM21sZCt5MXR2SEJ0ZnRNbnBZMi9KNGxPZFNtc2tNTWh6MkE2QThL?=
 =?utf-8?B?N0psUEVNeVpYWWJ2bTFOWTVBSlR4UGJDT3N3OHZjckUwUnRIclVvbnJWNzF4?=
 =?utf-8?B?bWZMODgrb3BpNGdmVnV3TzJiSWdCblNKbnNMRG9kbldnazJwTlNtR29XbWJR?=
 =?utf-8?B?ZCthczNRUlIvbGVMRXJWNWdNaEtQSE1RR0xsUGhVZVlCOXFPNFRWVk5OeWpW?=
 =?utf-8?B?OE9OaVRKZU0vSnJNazhVcmhtekJhOXdWNjNxL1pKNlhnV2Y3SjZVM2hrSjZV?=
 =?utf-8?B?YUFGSTRONVE4R1J0RFJaeXZKY29HbG1Oem5JSWdjUjZPc0x5TFZrMm5BbGg3?=
 =?utf-8?B?dGp0Q1FXN3pBZFFVK3B0bTlENzBQbjVZWjd5YW12K1N5azdJY2lmdGE2Mnlw?=
 =?utf-8?B?OHdSRCtWZktWY2lBTm4rVmNrRVpEay92ZWFXSWhsZTRFUjlzRDdGSVlBbmpz?=
 =?utf-8?B?WDNzOGlMZXJqa01jV3pVZ3huSVZDVnY5eUpOMGxyRnpmcWdWVHlVUkltNXpC?=
 =?utf-8?B?QWIyQWQ4UExZYnJ4M3ZDMlo4ZTJHbjNrTzFONWVOZlFUWXV3S0tqMFlld2Nt?=
 =?utf-8?B?KzlqZGRNSDNLZEVDSStDcks2YkdkdzlXcXhxckt1bHl6bXd5QUFhWUljbDkx?=
 =?utf-8?B?OUdXUStPa3oyemV0ekxCWHBHRURBU1Y2SEJqZmU4MWI2ZUlMMWdGQ0wyeXE4?=
 =?utf-8?B?OXoxYXdkUmRJa09TMm9Nazg4ajM2WDBBckd6cnFEeUR6R1RleERnTmhzNTgz?=
 =?utf-8?B?eUY4ekdGNENrSk5QY1ZJbUQ0VTRJYXcxUnk0VGdxeW5vS0UxQzlDS29vSnhj?=
 =?utf-8?B?QmJDUURZSGh1V25CZWM2QWxzckNMR1lFbE5Gc29oS3ZoZFd1QlkrWEc3RU91?=
 =?utf-8?B?WGlQMU9mNHEvbWo3WXVtV083RUdicjVRUlFzTng1L3FsNEdaTmQ1a2ZCSmZT?=
 =?utf-8?B?N1dqeTl2RjJCbnQ2NVd4aE5JY3MweEFFYmk1M2VHNWhZYXhEVy9OZXlYTkxM?=
 =?utf-8?B?T0M3RkcrM3ZNcEt3LzZ4TlR1MHk5N1picGFmeUNiREQ2Ly9xOVhGL3ZCV1pp?=
 =?utf-8?B?M2hQNVNiK1ZjOHpLMlMzWkdYcHhzWWQvY3NsWGM4REZuVE0xbzJyVTZSS1c4?=
 =?utf-8?B?UHpJWG42VFJuNkVOYmQzRUpWUkNPc1pDS2kxUzdBMis5dm9BMHYxQy8xZFBs?=
 =?utf-8?B?MGRVVFdTZitpajVMSlZwYmVoRUNGc0p2UkNmd29ieWpUcWFjVEZ5RElsVTVO?=
 =?utf-8?B?RHlGOEp6RERqMTRwbDA4VG9paDF5azlSVXBZK0JLc0NtSVBRaDZjTDhKZ3pU?=
 =?utf-8?B?U2hVT3hOU0wxNGtkb3hDTFlhYlpSTlpLWDBqaldKTWxrOXdjU1VOcEVmU3li?=
 =?utf-8?B?VzdZeDh2TmlGcForT3J6azRDTmpYVGNFOWp5RXczdWc3TEE1OFYyTjUvUEts?=
 =?utf-8?B?U0NuSHRDK2E2OEpwUkFReXowN0srNUN5cGx3SWxOK3ZHRlhSNGwrSUhqNE9G?=
 =?utf-8?B?c2dtYk5pclVRMFFJRjVxbG9zbFU2Um1RemJMRk1vNDRXQ1J2M0xKTE5jT0sy?=
 =?utf-8?B?clZ6OEhaK0d1cnBJYjgxUHp3a2NwZ1h6Y2h6eUNwdC9BNXFqN0ljc2VrcXEv?=
 =?utf-8?B?ZXJ4ZkxMTXJJZ1RqNGlBcmVlK1NjN2x5aHVUbG5sQndKQ0YyekhIeURuazVV?=
 =?utf-8?B?TDNJaW5HWjlQS0pIemJqeTJ5VnR3eVdxZ0t1SGRxTXRyYlhOQ01pWi9TYStE?=
 =?utf-8?B?K1RKa1NEUExyYmlFbWpYN3hyR2lWOGhGK2tjK0FjUU1zWnJ2TitGRzErNGdC?=
 =?utf-8?Q?2PADWmo8aD4kETngFsTbNsJLd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wCJM071z2GRdeko9ean3E/mxlYVg5kjsLOR1L8eTjVNu4Ytc249MSMw+c9LO1d6gqnADkGMIry+v9qCoYTICarVs2drLGAY9R9QHGefBhTZhE7ZO7V5NRLjvaRxqTgLd6ZXoXsineulrZtyGu2bYDlGUzG7zxz9xVrAIuYGjFhj35NmdfAVOnRYT9uyXz1M4HUcBhccFISEEActeGjbv3YsBSYhR0cPUARI83CSXzB19MYgxnlt9mI9k1EtwISMRz5DBUWs0MLDYqfAZqW2ofTFNjhIWonGEQ0fgVrVVHPc1N5s2zY781ncgk0kDW6zoOpGJJ/bnvOCocRNFOkfCmsHrEywN5PyyJmUk1ROs8DtmiLFevG+q0r06U2vBWd1gmvfoZxXhV1EVrjiKtVKryX3GsgcKc2UpLtPLz3tXVe61JTlZ1zHlWUzlYOBWsrykTRljyvjla/wewTLn6Q0lHzkDTF+qH1S20OOdLzgtEWefK9XSWp5m4SWDsUQ5CaicFz1rzbRRjjGvYrTqjcqO+X/uYqae3vTOc0+6UN0XehZUM0nAdPpoNHLw6igJ3Hmb744tJvXqFTLy5wZJ24h7Ttd3a+AtIdPIfo66SoJYX8349dUCYBqGnIkOeyx3pkQz
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ce8909-c0a3-4590-3619-08dde41508aa
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 20:21:54.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tc74U3mCfxub0K23ayWg5BxTvaCcOfN7O+5RvxBFqnClm3jRnDXKPN7rm+6vqDl5TB93n/MGgsnGOcVdsmxUaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9246

[snip]

>>>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | 
>>>>>> NAPI threaded |
>>>>>> |---|---|---|---|---|
>>>>>> | 12 Kpkt/s + 0us delay | | | | |
>>>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>>>>> | 32 Kpkt/s + 30us delay | | | | |
>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>>>>> | 125 Kpkt/s + 6us delay | | | | |
>>>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>>>>> | 12 Kpkt/s + 78us delay | | | | |
>>>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>>>>> | 25 Kpkt/s + 38us delay | | | | |
>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>>>>>
>>>>>>     ## Observations
>>>>>
>>>>> Hi Samiullah,
>>>>>
>>>> Thanks for the review
>>>>> I believe you are comparing apples and oranges with these experiments.
>>>>> Because threaded busy poll uses two cores at each end (at 100%), you
>>>> The SO_BUSYPOLL(separate) column is actually running in a separate
>>>> thread and using two cores. So this is actually comparing apples to
>>>> apples.
>>>
>>> I am not referring to SO_BUSYPOLL, but to the column labelled
>>> "interrupts". This is single-core, yes?
>>>
>>>>> should compare with 2 pairs of xsk_rr processes using interrupt mode,
>>>>> but each running at half the rate. I am quite certain you would 
>>>>> then see
>>>>> the same latency as in the baseline experiment - at much reduced cpu
>>>>> utilization.
>>>>>
>>>>> Threaded busy poll reduces p99 latency by just 100 nsec, while
>>>> The table in the experiments show much larger differences in latency.
>>>
>>> Yes, because all but the first experiment add processing delay to
>>> simulate 100% load and thus most likely show queuing effects.
>>>
>>> Since "interrupts" uses just one core and "NAPI threaded" uses two, a
>>> fair comparison would be for "interrupts" to run two pairs of xsk_rr at
>>> half the rate each. Then the load would be well below 100%, no queueing,
>>> and latency would probably go back to the values measured in the "0us
>>> delay" experiments. At least that's what I would expect.
>> Two set of xsk_rr will go to two different NIC queues with two
>> different interrupts (I think). That would be comparing apples to
>> oranges, as all the other columns use a single NIC queue. Having
>> (Forcing user to have) two xsk sockets to deliver packets at a certain
>> rate is a completely different use case.
> 
> I don't think a NIC queue is a more critical resource than a CPU core?
> 
> And the rest depends on the actual application that would be using the 
> service. The restriction to xsk_rr and its particulars is because that's 
> the benchmark you provided.
>>> Reproduction is getting a bit difficult, because you haven't updated the
>>> xsk_rr RFC and judging from the compilation error, maybe not built/run
>>> these experiments for a while now? It would be nice to have a working
>>> reproducible setup.
>> Oh. Let me check the xsk_rr and see whether it is outdated. I will
>> send out another RFC for it if it's outdated.
>>>
>>>>> busy-spinning two cores, at each end - not more not less. I 
>>>>> continue to
>>>>> believe that this trade-off and these limited benefits need to be
>>>>> clearly and explicitly spelled out in the cover letter.
>>>> Yes, if you just look at the first row of the table then there is
>>>> virtually no difference.
>>> I'm not sure what you mean by this. I compare "interrupts" with "NAPI
>>> threaded" for the case "12 Kpkt/s + 0us delay" and I have explained why
>>> I believe the other experiments are not meaningful.
>> Yes that is exactly what I am disagreeing with. I don't think other
>> rows are "not meaningful". The xsk_rr is trying to "simulate the
>> application processing" by adding a cpu delay and the table clearly
>> shows the comparison between various mechanisms and how they perform
>> with in load.
> 
> But these experiments only look at cases with almost exactly 100% load. 
> As I mentioned in a previous round, this is highly unlikely for a 
> latency-critical service and thus it seems contrived. Once you go to 
> 100% load and see queueing effects, you also need to look left and right 
> to investigate other load and system settings.

Let me try another way: The delay and rate parameters create a 
two-dimensional configuration space, but you only cherry-pick setups 
that result in near-100% load, which make "NAPI threaded" look 
particularly good. It would be easy to provide a more comprehensive 
evaluation.

And if there's a good reason to avoid using multiple NIC queues, it 
would be good to know that as well.

As I mentioned before, I am not debating that "NAPI threaded" provides 
some performance improvements. I am just asking to present the full picture.

Thanks,
Martin


