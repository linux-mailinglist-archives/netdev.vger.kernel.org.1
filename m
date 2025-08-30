Return-Path: <netdev+bounces-218427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340CEB3C660
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BB9A02F5D
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCFD1A9FAC;
	Sat, 30 Aug 2025 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="96ujRSOj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE53192598
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514466; cv=fail; b=QW82QtbOCEt4xlASdq5yiDGA08UGCd76lQ2Id+xgg3JCQfsmlD7IzVSFitlGH7kHMrGXpLTZCyNYdr8d7fdrWJlRgMwiFugRRqBNJ+/Sgx8Lrkg+BM5+GsYuG8dDp5y94ENGj2jEQOSOb5r0KoRM0aPQszfcMgndKvgH9D4kKHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514466; c=relaxed/simple;
	bh=j4ZGFSjb0F5vKgp0g4yEk2ZVKYwssBIDsYyv4cIjqJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lG6RIlv47wBqGeqb1u4D+w1h25UnVBeXt/aEwiUgVHagWjYpcW2xcYlQ3sY6Jyw21Jf1AJ3ccIAJIzgh/FKs4eCof0zZfJyt2lQSYHSsNQqu/FvIWJXH0l831V/AxBntt2PTPpBdDwn08iQuijRwyMcucKl7khojJYTmA9vPYuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=96ujRSOj; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756514463; x=1788050463;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j4ZGFSjb0F5vKgp0g4yEk2ZVKYwssBIDsYyv4cIjqJE=;
  b=96ujRSOjMwCPd8gdiMZJQxieeF7ztfH9txwOcKYkQWs6xw7pXHX7dudP
   h243KgmGYN/t5WJ0o8VfZrS0R+M3ntB0/FmslBtclgjN2StQ0nAyG5G/s
   WFohXhBFFqUyYe9KrAC+xODtngBU5qGv8Ry8vy53oyVqOzwsqSspgWpV4
   Y=;
X-CSE-ConnectionGUID: PXdxk3J/S+2xN2/s+l0iVA==
X-CSE-MsgGUID: IU7nav2ySAK1HiOfado+Fw==
X-Talos-CUID: 9a23:ET12k2EVRCNv76fHqmJfxEIEGZsHNUaelmf2eQijSmIxSYO8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A9j4psg0wGWlWpgooawptEID62zUjwpnxDkkTy4Q?=
 =?us-ascii?q?9kurdFS1XNT6Ri3eZXdpy?=
Received: from mail-yt3can01on2138.outbound.protection.outlook.com (HELO CAN01-YT3-obe.outbound.protection.outlook.com) ([40.107.115.138])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 20:41:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dE9wXjbBGSBIGHj5Kb/vxiaAHQP2V0biOwZpmhw7zqutLuRsPNpqqcs18Q1oQDRK+QOgK6nIKAWdATziDgBX8XQNR4WxnmMjStf6JEBGBQ4QMi7pfViyu7iGw7TENvW9HI+WWWQQcB07vSnx37g1XBOMq4xJ17f1nh+ISvOD3gF46sfLkmcvas9Lzxbuj4eshzPlzQFzibYeIuwmqvLt3TTuDmMMT+ut8H5aPgHDDiFFXGQYdy1DfMjA61+AdeM2rl9k2DADBFMgnpRQAeI+DBxZcFiJLRVYeswTzLICWAreKoBzkNrUAjZBLRn5VFTXb2bbl7cToe7wraHOhFZO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGJZ4ECy1Uzm4Mp5pqrfUFz6uhb6fGV9JB54x7DKTu4=;
 b=et/J6eQxyGJZsgz82LH5d0GCItn9iDQ/T5xxcrShrR/0bM8OKKpiSlOc9tCXucD14iNLb7XaI8y0KoINLT9eZoM+eqOQ80ZXpvrtZVUpFQiJlG+HMJebzSxnwa7/c5oDbcuEAV19zGCJs8JfA+jZg4AGWyxHCnwHNuusuo6fVSDZZx+zDgHmzbr76537v8WXfmppXeZND09WFo8R4jqJJ5e31kzFUlXde0aD3jhXh2iy71h/nAq9AjcTPhWZfDNOUfjX/XqeKJt0c8P8pwrGTSkEfeiM4+JlaiivcBKSR5VqEDDlANtYC9MKuWjeWKkC2AE3u9/oGSx/4NDVRp+Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQBPR0101MB6619.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Sat, 30 Aug
 2025 00:41:00 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 00:41:00 +0000
Message-ID: <a5166a4a-0c9d-420b-a06e-e4754a555a7e@uwaterloo.ca>
Date: Fri, 29 Aug 2025 20:40:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250829011607.396650-1-skhawaja@google.com>
 <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
 <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
 <63ff1034-4fd0-46ee-ae6e-1ca2efc18b1c@uwaterloo.ca>
 <CAAywjhR_VcKZUVrHK-NFTtanQfS66Y8DhQDVMue7kPbRaspJnw@mail.gmail.com>
 <101a40d8-cd59-4cb5-8fba-a7568d4f9bb1@uwaterloo.ca>
 <CAAywjhRbk_mH16GViYqOh4mphBzQWPb+DGHAycMY4JYmkaLR=Q@mail.gmail.com>
 <f62085ff-ab39-4452-8862-7352901f1d86@uwaterloo.ca>
 <CAAywjhQa6uzBwtR5M3Y1D8zJ9P3mBW+BU7j2AzSiX4+d-77tMg@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhQa6uzBwtR5M3Y1D8zJ9P3mBW+BU7j2AzSiX4+d-77tMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQBPR0101MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 113931d7-45b2-4b84-6312-08dde75de3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlVpQTk5czVFamJIWFU2YkRDVUdYdEJvSmFra2YrNXA1N1dlVWlxcXV4ZHB4?=
 =?utf-8?B?WFJ0SWNSQnZhak9yQTlpdGpGdVVQbnJjcjdNMlFZQzdzbk1yUUl3WXNzcVNi?=
 =?utf-8?B?ZHRDUGhmdFdKT1NnUUpTQmVVcDRid2pYMmdzN0lOL2FHZ2FjK1JPOWxqZy9Z?=
 =?utf-8?B?QUxvU01XS1hUcWNaZkd6aGd4RXJ6ckFoek1CSTZSTlJ2RzJncXhCV3puZHJh?=
 =?utf-8?B?Z0VDT1RjaGFzdml5U1FjVjVUamorV1l0aloyZklsRW9EekVHaUVNTGZHRm9z?=
 =?utf-8?B?UkUzTGFIQ29WdjUyUnhKQmJUUWdoemx3SjZvVkgwaFlYMnVaU3BwRTQxV293?=
 =?utf-8?B?S0k3N2xMN0RlQlJaTjkyV3laK2l5Z2JyMDVCQlBhcFBJMFBHREdyN2JtaHNq?=
 =?utf-8?B?T09HamVEcWxNaWU2MjA5blM1ek5Sc016eTVuSXdDcmhYSHZPMUVLMU5mUVRS?=
 =?utf-8?B?Kzh6OTlGS0RIL0x6c3IwWm0wL2c4WDVZU3ErSllyL3JMRlVaTEtvKzMvWWxq?=
 =?utf-8?B?MDNEeUlDN29MUm9icURWdzdsVmlEbS9FdmdaY3pRdGJERFRuRzNzeXJYTk40?=
 =?utf-8?B?cTh4SW9ZUitOLzlEcXpGc3FpQW1ZWjg5aGZXVlBMU09naUdSdnZkTnVvdno5?=
 =?utf-8?B?d1FBQzQ3emVSblp1Tm1CWkRGUlBFQlhseEE5dlZwajlEN2pvVUpNc3g0UkRF?=
 =?utf-8?B?aFc5Z1NSNjZSUTlyRE1WREF0WVlGays1c2FldlNieXpKemVkZW5Fb0h6M1RW?=
 =?utf-8?B?THl0K0JSc01OamdBQTB4allLd0taUGJtai9aeUk0L1BteGJUS1BVS2M3dy9C?=
 =?utf-8?B?TlVWZWZ1SnExZm9rc29uZjZVbjJoaWdpVnNlcWlheWxlRVl5RjBkNlM1QURi?=
 =?utf-8?B?emlmblVQWWlOSWpHQzcrVHNZZjBYVHBERnFHY0F3anBBd3N3L1U1K0gzckR3?=
 =?utf-8?B?aVBhWlJVcStVQ0FCNnFORjJqUWQwM0k3NFBGa3VzMWhpcTc5N0JGZ3pia0t5?=
 =?utf-8?B?WXUyd2hHNUlmV3pXNXdML0plNTYrdEtXM3hSWmVodnJEd3NkUkEyZytPL01w?=
 =?utf-8?B?N01LbFJtRWFPejY3KzkwSmdiUkVmQmNHWXVXaFhqd3A1KzE3NXdtQnhEZUhj?=
 =?utf-8?B?NTdUTXhjMnNSZGExQWlBQUVXRmpzUHlSQW5TbVBIM2MybXYwbWFTZjdIQi83?=
 =?utf-8?B?NmhGdGxTUnRZOWVYZFlSWmVlbldEWkJESXJLc1M5NzNrRk01TFUrZlUwempy?=
 =?utf-8?B?UWdtTlZobCtLY0dxd3NVTGVRdkM4THFPWURhTW1CQjFJT2x6T3hQQzZ6RWVH?=
 =?utf-8?B?SndNOUx1cFg3ak5VQzJiKzY0TFlRZis3d2VSdnZDa0wyNmtRckxrVmJ6bW9B?=
 =?utf-8?B?MGc4a2dTL2RGck1XQ01CaUEya0dzSkJCeDZoaXNCQ1N0MmIwOFlqaEVxS2t1?=
 =?utf-8?B?WmoyZTdVdUoxTGFoVlZ5MDVFZFJucnJKM0FLNVBhNTZlZ1VqMEdOaVAwTGN3?=
 =?utf-8?B?SjZtUTRiYUpJNEtFTGNKNTcrNFNGaWVRWE9HTjluZDhTRzJzd2pNS0hxN3RZ?=
 =?utf-8?B?UGs4WWhmaFRHYll1aDk4WFFJRnoyYXNjSlpCVTYvaGhqZzJ4VHNHOTRKdDJH?=
 =?utf-8?B?a0MyL2FYZWM1M0RDOHZERnpHUWlsZGRXMFp5ZW1PMUVRR05Hd0VtSG9ZbkdR?=
 =?utf-8?B?S3o4U1lJbGREZG9xYWEwK1pReFJCRkpDZjVzWmEySTJFYm9iUDVXSnRSUENy?=
 =?utf-8?B?TVZGVlRmS3FqS2pJdldUOStNeDlPS1plZ2VrWVlhZVk2U1NCb3RwQzhWR0lO?=
 =?utf-8?B?VEVlSCt6cE5PVmNSUE5helhvREJFd0VIdXRDMXFLSEtDNHZrL0Q2ZjhLcmx3?=
 =?utf-8?B?L05yR3crUndwc0ltdU83RGdtRlp3MTZ6a1kxTldqT0pIcmVWT3d3ckVCWWdV?=
 =?utf-8?Q?xaI7bq8pJzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVhwR1dIOXJIWFM4bHJqZlV1NzAvQ29KanF0QVpUR2dzb3JpOVF0OFYxZUlI?=
 =?utf-8?B?c0ZkWVhUZ3BDeWd4NXdOQUEvOEFZSFEzUEZoTE5DNjJUb0F3TTFWbzdpczVn?=
 =?utf-8?B?cU9uK2tob0ZmT1M5VzVPYnh1ODA1MzQrZFdsN0QvcHdMM0dVV1huVlJlYTdy?=
 =?utf-8?B?aWJ1ZGgvY1l5Ri9wZHN2RHVkdFpGSGVRcTZjb0F3bTVXbHJLbnJ5Q3VOSXhr?=
 =?utf-8?B?VGxLWEovYzBBT3E4dkRRY3RFSU5PSFRUV1NSUEplQ2x2TUZxK0FQY0lCNy9U?=
 =?utf-8?B?bCtIQmNEMTYxNUVxWG9GeUVDTEYrSkQ5UEhwRTRwRjEvOU9DNHM5UldLdVdm?=
 =?utf-8?B?Q0Zra3FWRVhnTExGdG5hSThjeW93SDJhNFRiTm03TTllaitZYkZ5UUJ1WHg5?=
 =?utf-8?B?dmdJYXNwQ0RHQVl2c3p0eTgwOG1KMU9iemxncTFBYXNwT1ZZMkhOaUY4a2Fo?=
 =?utf-8?B?Zi9BeXR0cWNveFlCSW5BMFRWbmFaV051QU9LYjFBVW12dHpoQXNNSStTOFVM?=
 =?utf-8?B?VzBiQlFkaUYwWk1FclpSb0JMVzNSOFM1Z21ZZVhaYmwrNEtadllaWDliaXRG?=
 =?utf-8?B?QXd3Z3ROLzlqOE93VHhkcDhoUkU0cFgyemJyUStTUS8rSGoreHRNWXFrdjR6?=
 =?utf-8?B?YXd6dG9Ja0hObHdWbUVJRlM2N2FtUUpBRmgwTzg3Ujh4MFhRSm1uMWUwVVZK?=
 =?utf-8?B?ZkV4WlhHelpmVStTRFhwTTFYYVNHcWxJS1VVSXhqMDZoSnZoTGhVV3k0U24y?=
 =?utf-8?B?WFl0a09tR0lycWY1ZWhsK0RMRnlPQ2VFMG1RTFRuaWJHdWRiM2d2U24yWmVn?=
 =?utf-8?B?Vk5TMW5SUlFyZkY1S3V2NktTV3V6cTNZNFdicmR6NUNhOCs1Z2JtOXZxOERw?=
 =?utf-8?B?UkZlNWhRdjkyRXI5YnAyK3VDRUt0OHZpeVZRQUExTmpNZlFLT0x0d005ZWl6?=
 =?utf-8?B?ZHJHTC9rR2JTRHVEVE1wdERJelJ4VnRLdW9RdVZVbDJ1VnV0Zk1TV0tGSm9F?=
 =?utf-8?B?MjlBelNEN1loaWZ5NHM1RFMrQTFsa3VZNkRDLzhxWDdxNGRnL09ZRWp0TmlF?=
 =?utf-8?B?ODlnQzMvWERyZHF1VjB6cE0vakNqRGNQeERKQko0RFJFVWpqSm43VzZndmpK?=
 =?utf-8?B?Y2ZrSGp3Ulc5K29rU05NMTVCVWlvL0htWVJ3VVp4TU4wa0VLOGlrMGFuVDZy?=
 =?utf-8?B?NFZYd3BMaTJ6eFZ2RHovNGd6eE9KaDB1bStRRG1LWTFCcG5xbDQ2TjRVMkUy?=
 =?utf-8?B?OUV6WXloNmVpUVIzOHNZR1IreU9PUlhkblFWOGRwRTdCTStxWE5SQkR4Vytv?=
 =?utf-8?B?NS9UVzJOd1hyS0JNUDZRK3NnZDQybTgzUVJibnRMVXlKampmcllTd3BqQWpM?=
 =?utf-8?B?b3Vic0tva0kzeGkwSThYTzRWQ21YelpncE9kTjNXOXBzeG14VUphRSt6NFJ0?=
 =?utf-8?B?L2RmZENsWGkxRXZ6eUNLZjBPbzUxR3Z1WXIveklkRVVvaTUvUGhmZFpvSUR6?=
 =?utf-8?B?ZDQyZDVMV1NncXBjZTg3cGxQZzJ2a0lGNzR1ZUE4eDdtZXF0N1p2RnJob0hv?=
 =?utf-8?B?cXlEVUwxck1EMytBYTI1N2VwbGJzMGJrUGpIVmRCTzJXdzZ6M0ZRYk8rR1I0?=
 =?utf-8?B?Nlo1L2VQc1JmODF5aHlGWC9GOFl6Wm45bTIyTU1qenRoSUtBTVQ4azRtakxO?=
 =?utf-8?B?WTBEZUduT29QZlpqQkU4eUJCeWpwZE5WRUlJM3FvQkF1b2hpeVM3Ymh4N3lU?=
 =?utf-8?B?VWt1R05iRUN5b0tMcUFLNll6SlJtbjBZS2F4RFY1Nnpyd0JkQjVNT0ViZjBM?=
 =?utf-8?B?dWxyc05CRFFteHVNU0xVZHRGRndJRHBkSWs3STVZN2h5OWVMQVBVd1lpTFI2?=
 =?utf-8?B?c296dnVsdk5FRW9hRTJjdldYVUNYSzIwUHRBazZUZUNMNE42NzVwcFh6Rngz?=
 =?utf-8?B?dmErU0QrUDZJU1QwOTRTdU9pOHpZNnhjZlRaQ0NPdEVnK2ljVVVCVzVTM3Ji?=
 =?utf-8?B?SnpZdHNnRE1ENnBPVnBWd200cnZ0NlNMeVpkNHZnaUw5YTMzcG1QcEdOem4y?=
 =?utf-8?B?blBCZ2JvdWZ3N0ZxdnpuVys2SnRPWlhXMVpSUGNwdUJBSThxYkRDdXp5ZjBo?=
 =?utf-8?Q?Lf2UT+sTNJBju+/qyQ04jfX5C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mCib4X+7FkOjjBuu0KUEkC9pqmtF2xEylQJo09pNHQYqln2DcZyu8AjAejhbxyJMHR5xL4unl7oFe54aQYEJrPtUsf1hvSywN3ZKbS+wShCkdp7fCOOxsBQqmMlNig7WvkNX0oHh03p86MsurP913F3XK5pauq+wRP0uqe8Ca2S4BJ20SACMcwwgmrVjfTv1rV43NpAWeqIiLtz5pR5fqcuV1bZr4UcC0U4qZ6P0sJgk9hOtevPtNwGf6eQULRt+iK4lU1HAiE6PhLQSVI2zZ69EVH3giwMxj5xDxfv5JItJxjP4OB6Ven/lWcih10vXlxu2Me6Afv5SXbXZTCd+AeUhakv0N8QhM9GjY0oS66gOacqlyP/yG+bntvu8g8+guWLWMdjBiMaooXqDWqb2k6R/jvBLsZd8pEw+RrU1DSoEeWZ4yqS2oxQOwlOOISnRV6qZrO40aKytdKxzsg+mZZietzFmjQMgYbRl6pZ6DOkFLYRKyOA34PxY4OTK1nbcUESvcWr3277BM4d8i4Bpyot6jyA9JdBCyglBnieHc+GAfO1dRfVU6XtGmzOIxFqMnrSEraYLMjU4YZmVKBRs4XaUxj2nXRCUGA/n+9lLDpxHzMOM4WexsusYktXihHsf
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 113931d7-45b2-4b84-6312-08dde75de3ed
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 00:41:00.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFce8yFcbNVa/cpAj6xSvsfljBp3ZUbXfHcUIp8Jexq2yNUgltNE2aPUq853h/fhq/9cLJkIY/J8jnU0jU4DQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6619

On 2025-08-29 20:21, Samiullah Khawaja wrote:
> On Fri, Aug 29, 2025 at 4:37 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-08-29 19:31, Samiullah Khawaja wrote:
>>> On Fri, Aug 29, 2025 at 3:56 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>>
>>>> On 2025-08-29 18:25, Samiullah Khawaja wrote:
>>>>> On Fri, Aug 29, 2025 at 3:19 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>>>>
>>>>>> On 2025-08-29 14:08, Martin Karsten wrote:
>>>>>>> On 2025-08-29 13:50, Samiullah Khawaja wrote:
>>>>>>>> On Thu, Aug 28, 2025 at 8:15 PM Martin Karsten <mkarsten@uwaterloo.ca>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
>>>>>>>>>> Extend the already existing support of threaded napi poll to do
>>>>>>>>>> continuous
>>>>>>>>>> busy polling.
>>>>>>>>>>
>>>>>>>>>> This is used for doing continuous polling of napi to fetch descriptors
>>>>>>>>>> from backing RX/TX queues for low latency applications. Allow enabling
>>>>>>>>>> of threaded busypoll using netlink so this can be enabled on a set of
>>>>>>>>>> dedicated napis for low latency applications.
>>>>>>>>>>
>>>>>>>>>> Once enabled user can fetch the PID of the kthread doing NAPI polling
>>>>>>>>>> and set affinity, priority and scheduler for it depending on the
>>>>>>>>>> low-latency requirements.
>>>>>>>>>>
>>>>>>>>>> Extend the netlink interface to allow enabling/disabling threaded
>>>>>>>>>> busypolling at individual napi level.
>>>>>>>>>>
>>>>>>>>>> We use this for our AF_XDP based hard low-latency usecase with usecs
>>>>>>>>>> level latency requirement. For our usecase we want low jitter and
>>>>>>>>>> stable
>>>>>>>>>> latency at P99.
>>>>>>>>>>
>>>>>>>>>> Following is an analysis and comparison of available (and compatible)
>>>>>>>>>> busy poll interfaces for a low latency usecase with stable P99. This
>>>>>>>>>> can
>>>>>>>>>> be suitable for applications that want very low latency at the expense
>>>>>>>>>> of cpu usage and efficiency.
>>>>>>>>>>
>>>>>>>>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
>>>>>>>>>> backing a socket, but the missing piece is a mechanism to busy poll a
>>>>>>>>>> NAPI instance in a dedicated thread while ignoring available events or
>>>>>>>>>> packets, regardless of the userspace API. Most existing mechanisms are
>>>>>>>>>> designed to work in a pattern where you poll until new packets or
>>>>>>>>>> events
>>>>>>>>>> are received, after which userspace is expected to handle them.
>>>>>>>>>>
>>>>>>>>>> As a result, one has to hack together a solution using a mechanism
>>>>>>>>>> intended to receive packets or events, not to simply NAPI poll. NAPI
>>>>>>>>>> threaded busy polling, on the other hand, provides this capability
>>>>>>>>>> natively, independent of any userspace API. This makes it really
>>>>>>>>>> easy to
>>>>>>>>>> setup and manage.
>>>>>>>>>>
>>>>>>>>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
>>>>>>>>>> description of the tool and how it tries to simulate the real workload
>>>>>>>>>> is following,
>>>>>>>>>>
>>>>>>>>>> - It sends UDP packets between 2 machines.
>>>>>>>>>> - The client machine sends packets at a fixed frequency. To maintain
>>>>>>>>>> the
>>>>>>>>>>        frequency of the packet being sent, we use open-loop sampling.
>>>>>>>>>> That is
>>>>>>>>>>        the packets are sent in a separate thread.
>>>>>>>>>> - The server replies to the packet inline by reading the pkt from the
>>>>>>>>>>        recv ring and replies using the tx ring.
>>>>>>>>>> - To simulate the application processing time, we use a configurable
>>>>>>>>>>        delay in usecs on the client side after a reply is received from
>>>>>>>>>> the
>>>>>>>>>>        server.
>>>>>>>>>>
>>>>>>>>>> The xsk_rr tool is posted separately as an RFC for tools/testing/
>>>>>>>>>> selftest.
>>>>>>>>>>
>>>>>>>>>> We use this tool with following napi polling configurations,
>>>>>>>>>>
>>>>>>>>>> - Interrupts only
>>>>>>>>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>>>>>>>>        packet).
>>>>>>>>>> - SO_BUSYPOLL (separate thread and separate core)
>>>>>>>>>> - Threaded NAPI busypoll
>>>>>>>>>>
>>>>>>>>>> System is configured using following script in all 4 cases,
>>>>>>>>>>
>>>>>>>>>> ```
>>>>>>>>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
>>>>>>>>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
>>>>>>>>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
>>>>>>>>>>
>>>>>>>>>> sudo ethtool -L eth0 rx 1 tx 1
>>>>>>>>>> sudo ethtool -G eth0 rx 1024
>>>>>>>>>>
>>>>>>>>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
>>>>>>>>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
>>>>>>>>>>
>>>>>>>>>>       # pin IRQs on CPU 2
>>>>>>>>>> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
>>>>>>>>>>                                   print arr[0]}' < /proc/interrupts)"
>>>>>>>>>> for irq in "${IRQS}"; \
>>>>>>>>>>           do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
>>>>>>>>>>
>>>>>>>>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
>>>>>>>>>>
>>>>>>>>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
>>>>>>>>>>                           do echo $i; echo 1,2,3,4,5,6 > $i; done
>>>>>>>>>>
>>>>>>>>>> if [[ -z "$1" ]]; then
>>>>>>>>>>        echo 400 | sudo tee /proc/sys/net/core/busy_read
>>>>>>>>>>        echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>>>>>>        echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>>>>>> fi
>>>>>>>>>>
>>>>>>>>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-
>>>>>>>>>> usecs 0
>>>>>>>>>>
>>>>>>>>>> if [[ "$1" == "enable_threaded" ]]; then
>>>>>>>>>>        echo 0 | sudo tee /proc/sys/net/core/busy_poll
>>>>>>>>>>        echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>>>>>>>        echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>>>>>>        echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>>>>>>        echo 2 | sudo tee /sys/class/net/eth0/threaded
>>>>>>>>>>        NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>>>>>>>>>>        sudo chrt -f  -p 50 $NAPI_T
>>>>>>>>>>
>>>>>>>>>>        # pin threaded poll thread to CPU 2
>>>>>>>>>>        sudo taskset -pc 2 $NAPI_T
>>>>>>>>>> fi
>>>>>>>>>>
>>>>>>>>>> if [[ "$1" == "enable_interrupt" ]]; then
>>>>>>>>>>        echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>>>>>>>        echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>>>>>>        echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>>>>>> fi
>>>>>>>>>> ```
>>>>>>>>>
>>>>>>>>> The experiment script above does not work, because the sysfs parameter
>>>>>>>>> does not exist anymore in this version.
>>>>>>>>>
>>>>>>>>>> To enable various configurations, script can be run as following,
>>>>>>>>>>
>>>>>>>>>> - Interrupt Only
>>>>>>>>>>        ```
>>>>>>>>>>        <script> enable_interrupt
>>>>>>>>>>        ```
>>>>>>>>>>
>>>>>>>>>> - SO_BUSYPOLL (no arguments to script)
>>>>>>>>>>        ```
>>>>>>>>>>        <script>
>>>>>>>>>>        ```
>>>>>>>>>>
>>>>>>>>>> - NAPI threaded busypoll
>>>>>>>>>>        ```
>>>>>>>>>>        <script> enable_threaded
>>>>>>>>>>        ```
>>>>>>>>>>
>>>>>>>>>> If using idpf, the script needs to be run again after launching the
>>>>>>>>>> workload just to make sure that the configurations are not reverted. As
>>>>>>>>>> idpf reverts some configurations on software reset when AF_XDP program
>>>>>>>>>> is attached.
>>>>>>>>>>
>>>>>>>>>> Once configured, the workload is run with various configurations using
>>>>>>>>>> following commands. Set period (1/frequency) and delay in usecs to
>>>>>>>>>> produce results for packet frequency and application processing delay.
>>>>>>>>>>
>>>>>>>>>>       ## Interrupt Only and SO_BUSYPOLL (inline)
>>>>>>>>>>
>>>>>>>>>> - Server
>>>>>>>>>> ```
>>>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>>>           -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -
>>>>>>>>>> h -v
>>>>>>>>>> ```
>>>>>>>>>>
>>>>>>>>>> - Client
>>>>>>>>>> ```
>>>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>>>           -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>>>>>>           -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
>>>>>>>>>> ```
>>>>>>>>>>
>>>>>>>>>>       ## SO_BUSYPOLL(done in separate core using recvfrom)
>>> Defines this test case clearly here.
>>>>>>>>>>
>>>>>>>>>> Argument -t spawns a seprate thread and continuously calls recvfrom.
>>> This defines the -t argument and clearly states that it spawns the
>>> separate thread.
>>>>>>>>>>
>>>>>>>>>> - Server
>>>>>>>>>> ```
>>>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>>>           -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>>>>>>>           -h -v -t
>>>>>>>>>> ```
>>>>>>>>>>
>>>>>>>>>> - Client
>>>>>>>>>> ```
>>>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>>>           -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>>>>>>           -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
>>>>>>>>>> ```
>>>>
>>>> see below
>>>>>>>>>>       ## NAPI Threaded Busy Poll
>>> Section for NAPI Threaded Busy Poll scenario
>>>>>>>>>>
>>>>>>>>>> Argument -n skips the recvfrom call as there is no recv kick needed.
>>> States -n argument and defines it.
>>>>>>>>>>
>>>>>>>>>> - Server
>>>>>>>>>> ```
>>>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>>>           -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>>>>>>>           -h -v -n
>>>>>>>>>> ```
>>>>>>>>>>
>>>>>>>>>> - Client
>>>>>>>>>> ```
>>>>>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>>>>>           -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>>>>>>           -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
>>>>>>>>>> ```
>>>>
>>>> see below
>>>>>>>>> I believe there's a bug when disabling busy-polled napi threading after
>>>>>>>>> an experiment. My system hangs and needs a hard reset.
>>>>>>>>>
>>>>>>>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) |
>>>>>>>>>> NAPI threaded |
>>>>>>>>>> |---|---|---|---|---|
>>>>>>>>>> | 12 Kpkt/s + 0us delay | | | | |
>>>>>>>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>>>>>>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>>>>>>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>>>>>>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>>>>>>>>> | 32 Kpkt/s + 30us delay | | | | |
>>>>>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>>>>>>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>>>>>>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>>>>>>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>>>>>>>>> | 125 Kpkt/s + 6us delay | | | | |
>>>>>>>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>>>>>>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>>>>>>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>>>>>>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>>>>>>>>> | 12 Kpkt/s + 78us delay | | | | |
>>>>>>>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>>>>>>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>>>>>>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>>>>>>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>>>>>>>>> | 25 Kpkt/s + 38us delay | | | | |
>>>>>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>>>>>>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>>>>>>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>>>>>>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>>>>>>>>
>>>>>>>>> On my system, routing the irq to same core where xsk_rr runs results in
>>>>>>>>> lower latency than routing the irq to a different core. To me that makes
>>>>>>>>> sense in a low-rate latency-sensitive scenario where interrupts are not
>>>>>>>>> causing much trouble, but the resulting locality might be beneficial. I
>>>>>>>>> think you should test this as well.
>>>>>>>>>
>>>>>>>>> The experiments reported above (except for the first one) are
>>>>>>>>> cherry-picking parameter combinations that result in a near-100% load
>>>>>>>>> and ignore anything else. Near-100% load is a highly unlikely scenario
>>>>>>>>> for a latency-sensitive workload.
>>>>>>>>>
>>>>>>>>> When combining the above two paragraphs, I believe other interesting
>>>>>>>>> setups are missing from the experiments, such as comparing to two pairs
>>>>>>>>> of xsk_rr under high load (as mentioned in my previous emails).
>>>>>>>> This is to support an existing real workload. We cannot easily modify
>>>>>>>> its threading model. The two xsk_rr model would be a different
>>>>>>>> workload.
>>>>>>>
>>>>>>> That's fine, but:
>>>>>>>
>>>>>>> - In principle I don't think it's a good justification for a kernel
>>>>>>> change that an application cannot be rewritten.
>>>>>>>
>>>>>>> - I believe it is your responsibility to more comprehensively document
>>>>>>> the impact of your proposed changes beyond your one particular workload.>
>>>>>> A few more observations from my tests for the "SO_BUSYPOLL(separate)" case:
>>>>>>
>>>>>> - Using -t for the client reduces latency compared to -T.
>>>>> That is understandable and also it is part of the data I presented. -t
>>>>> means running the SO_BUSY_POLL in a separate thread. Removing -T would
>>>>> invalidate the workload by making the rate unpredictable.
>>>>
>>>> That's another problem with your cover letter then. The experiment as
>>>> described should match the data presented. See above.
>>> The experiments are described clearly. I have pointed out the areas in
>>> the cover letter where these are documented. Where is the mismatch?
>>
>> Ah, I missed the -t at the end, sorry, my bad.
>>
>>>>>> - Using poll instead of recvfrom in xsk_rr in rx_polling_run() also
>>>>>> reduces latency.
>>>>
>>>> Any thoughts on this one?
>>> I think we discussed this already in the previous iteration, with
>>> Stanislav, and how it will suffer the same way SO_BUSYPOLL suffers. As
>>> I have already stated, for my workload every microsecond matters and
>>> the CPU efficiency is not an issue.
>>
>> Discussing is one thing. Testing is another. In my setup I observe a
>> noticeable difference between using recvfrom and poll.
> I experimented with it and it seems to improve a little bit in some
> cases (maybe 200nsecs) but performs really badly with a low packet
> rate as expected. As discussed in the last iteration and also in the
> cover letter, this is because it only polls when there are no events.
> 
> count: 1249 p5: 17200
> count: 12436 p50: 21100
> count: 21106 p95: 21700
> count: 21994 p99: 21700
> rate: 24995
> outstanding packets: 5
> 
> Like I stated in the cover letter and documentation, one can try to
> hack together something using APIs designed to recv packets or events
> but it's better to have a native mechanism supported by OS that is
> designed to poll underlying NAPIs if that is what user wants.
I see, thanks for checking. I got sidetracked and was looking at yet 
another setup (0 period, 0 delay). The timing of xsk_rr with "work" and 
I/O being interleaved seems like a special case (not to mention the 100% 
load). Anyway, I am sure you will post again and I will make my 
statement about a comprehensive evaluation again. ;-)

Best,
Martin


