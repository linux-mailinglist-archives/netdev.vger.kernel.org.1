Return-Path: <netdev+bounces-177548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C8A70873
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F4616ECD1
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0A25F78D;
	Tue, 25 Mar 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="GGrJrXlU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8A25EFAC
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924924; cv=fail; b=jCVrrW+xA6nOVVqVVs59UgscyP8wmPcFYhokiiBTxt1LfkCcchLh5qyXrPT/UT0GJVr4pY2H2K33D+qM5mvSUjjJOE3+KvNiQ42HO1xs6Bk9m+SU6n6w0gHGLntMtCvsfg2Tw5dlQ6zF47GpzTgeE67RATVpGwzdicsXIFBS94w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924924; c=relaxed/simple;
	bh=cC3U+jM84vMU80rNBqVCtBex3jVWxFE0TagD/ZxrxwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJ4klEOLIE3iOazHghDOMa9bRgncM0GX1ConVS+8bVFZAwm0qqyv/77IMLDp3b+gutJ5O70nmi8i5Ts8mTowjv7RAhaoOMxGWxtHm8UkQZkWTLF/C5x71t/3v3opEC/OYTX4bdIC09RezE5n8kfar/ywonAbAyfKoaQ6ximwVpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=GGrJrXlU; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1742924922; x=1774460922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cC3U+jM84vMU80rNBqVCtBex3jVWxFE0TagD/ZxrxwA=;
  b=GGrJrXlU4PsNnGdHChJAsBjvV8i5IXDkBjTHq0hWV4FDNDdCCnc8Lae5
   /PE3oxymPWuGdpOTnBeUjJVuhIa27Xj6RqTrX37G6JX5NQeLlcQlvdfq8
   MUFEfvLXShFC9BUycBb0Yvas6p3tnDSMTrADeIZKvUvRlNdrGv2gLGiSf
   A=;
X-CSE-ConnectionGUID: hTYH0xJASXmZF6pX8/Th9g==
X-CSE-MsgGUID: bzql0QOLQFWt0/Y6/wbaVw==
X-Talos-CUID: =?us-ascii?q?9a23=3A4oNvd2hM8Q70nZE5b86gVPLC5TJuckHs7C/AAWa?=
 =?us-ascii?q?DOWNbZuONeQ/XxKM1nJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A690T6Q3LStYv6R3Q1l+xcbuHYjUj6ba3DBg0trE?=
 =?us-ascii?q?/lfaYbWtBZXCChj2JXdpy?=
Received: from mail-canadaeastazlp17010006.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.6])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 13:47:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDD4cHIRY340YHBjlvaztdHFXOu6FUAL9MfgVFGJi50OL99hAs+r0e3eNwo8c1HbTYjMa8SE5TtaXwNAL2jpr2SU0USLuku+e+iOF3nrv0KrlH6ge9122T1zSjO1mlAvqIPSwh8FZEZWV+YWGLBRRt1v/SCm40uUlYWTRq1yBmjCBBO2SGfDMm3Hby01PyYZFc+b648oPw4gq3c9P65hMfiD6Qrjh/2AtaHYLR+9MNCeWrxwcZzC7g1IdJaxLYxq3m2rXHLuJ0NsXXSG7q+z8E2/EylSKPTNCsr3I0v8pTPr5L7vcyWR4ZUPsqj6pUJbk/CfZrTe3BS2jdGtm8dpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgt1kW6imxsahghe1sP0jNhQvqUdUNPg1scWv/IwnwI=;
 b=xxfHzF1n/S1nlV0i3Ozw1tc+OhFjGMZrcvZvd8UkP9PUbLUpgHaF2IeNTOjB/q5r/iKAvRqQ/jh30+RVoVov+/+s9ioQdCJm2LKyaaa7yPmDHRMxh8zSCeN+7tcJ5L91C2ZGM3TO8Fc8TOsdLuAplc6MjnMKsBtq3FL72wys9mv/h9CO8Bv9A3yVB88LzL3GwD72bciHcpdL/dX1SG1ADX+W8td32+R8P7aPfMrvU15hicpctxJhZD9Ejbw4mVuCVSIr9G7ECYGoiYLNcy6+6FNvcEKuJqqBCxfqdGlln9mQ7RKLCBNMvlF6RAlyzzU4mbqWAJzuDJCTIDligtshdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB6357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:74::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:47:31 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 17:47:31 +0000
Message-ID: <b35fe4bf-25d7-41cd-90c9-f68e1819cded@uwaterloo.ca>
Date: Tue, 25 Mar 2025 13:47:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 jdamato@fastly.com, netdev@vger.kernel.org
References: <20250321021521.849856-1-skhawaja@google.com>
 <451afb5a-3fed-43d4-93cc-1008dd6c028f@uwaterloo.ca>
 <CAAywjhSGp6CaHXsO5EDANPHA=wpOO2C=4819+75fLoSuFL2dHA@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhSGp6CaHXsO5EDANPHA=wpOO2C=4819+75fLoSuFL2dHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::27) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 593cb5e0-763c-4e39-8bc0-08dd6bc51e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MER5S256ai91K0VteVA4RllSaEFsSmxEMVpnN1hPbEVCYWJoZk9LNEgyWGx2?=
 =?utf-8?B?dk03M041TThqY2dYRk9aOG90dVFVWFZEbXJjKytnQzZVR0JBV09pajdwUnNO?=
 =?utf-8?B?Vk9wMnhvTFVzM0VkbEUvYUhSZHkrVkEwT1JWYnp3MjdYS2pLcjUxaDN5L0E4?=
 =?utf-8?B?SWNteDFWUHM0MGRUbHNFNUwyTGFPSHlYTnVOWjdQZmVvSFNUTnVDeGVFendI?=
 =?utf-8?B?U21iZm9GdUQxNS9OVkJGNWN3M2tHOFBTK08wd3oxb2E5djdiR0NZakM0RWhN?=
 =?utf-8?B?Q3FxVm1rSkpObGEwMUFJb0ZmQklXaUc1bjhjaW5neHp6QXV1VFRNVGRhYkFK?=
 =?utf-8?B?RlNlbmVEMHQ0K3MzeWI0cXpkNU1lK3o0QjRFbElQOFZZalBKS2QvLy9lNm0x?=
 =?utf-8?B?NUR0SzE4NGkyQ280ajczMlZGcGxFb3lYb2laU3FBSUdWc1N0L0VjSjFJRS9h?=
 =?utf-8?B?VWRDYWY0OU5HZStqS1RQOTc3SnpQRU81OHVwZ0d1ejBpQlNXdG9oTjRrQ0pH?=
 =?utf-8?B?Z0lJcENEOUZrejVwQTVlaDhhZmJOV2cwRFRiY1NMMHN3M2pkYlVHRmpnZkNs?=
 =?utf-8?B?NUNkZ3lXTm9SRVg5eU01NFRmcG0xSE5JUjFFd3hkK25mL3AyTmtBNHdwb25W?=
 =?utf-8?B?UmZXRGorMkFvN0RuYXFpeG5EelF2ZkFtcE5zZmJ1N2djNHp5OE9ORHJhbk90?=
 =?utf-8?B?VjFjaWhHRTMrVTYyQkxSMGxVMmp5NktNb1BvME5SUHU2YzdLUWxVdHhHMnA1?=
 =?utf-8?B?WHVkYjhUckpvdkV2WkVFWldWVjJlaVFRaEdUeGlLNDVHY0RGd0I3MDZoUnBx?=
 =?utf-8?B?aDNlV2t3Snp6TE5rRVAxMXBrbjZqQ29Md3M1Z0xPdGhHWEVGTDd5RFZmdDRW?=
 =?utf-8?B?aVlGQ2UrL0FrV3FJdHRSa3h0SjA4MjRTa1Z1aTQ0UEp3U2QwWDg3N0ZGWHZn?=
 =?utf-8?B?bnZYZTJUM1oweWVuL3A1c0R1dFJxQ3g4ZGw4SE0yazhyVFhxREZ6aGV5NFpx?=
 =?utf-8?B?Sk5kMkVXaUlzeUdMdFNISjcxQ0doV1AxWmtYWGZNaDdrZEltdWJOZDZJN0t2?=
 =?utf-8?B?cUs2RVR0RzJTSS8xbzlVKzNQTUdtQWFSS0p3YStqOS9OejZhNklSRkw3NWZT?=
 =?utf-8?B?N2lWVEpTUHBTaFBvRWVDeG1XMVYxNlgvZ000aGZ5RUh3b1NwbzNjdUJVa2FD?=
 =?utf-8?B?NDlNM3Rucnh6VzdJd0RjaERGUklhVy80MFVORVkwUDRyY01hRzdjYm9kcyty?=
 =?utf-8?B?ODd0OVVURnVadkgvV1VNR0puSmExU1k1R3hXSlZLeDJEaFI4a29jTHpQKzNk?=
 =?utf-8?B?OW90eU04YWdibDlKMHp4S0hPV0dsS3NPMFlXVGtXR1cza2lwUGlNS2NqWlgr?=
 =?utf-8?B?T081Wkt1L1hENUw5ZWV1OWVLZ0xVUkpOYWppV1J2RUtiR1RPNGJGWmtjQ1Fw?=
 =?utf-8?B?VnI2U3lvN25zNC8wNnBvTzNJZk96WVNSUDMyODhqWEVuNG5kZHpQZ0o2bWlK?=
 =?utf-8?B?eXVwMXVXdWNRUXhGMDd6MVNFVzB1STQ0NUMwQno4eG9PVjF0QmxOTFh3TktE?=
 =?utf-8?B?b3pic1hSdlM5Rk1qTGRaSnh0RzZNU1Z6dWZabjNVNkhzLzJiNW16SEs2a2do?=
 =?utf-8?B?SjQ0N0dUeEhrVXlFdTduRmNuZkdmV0pwc29RT0tVdDN4TG9USEtYN2dDMXc2?=
 =?utf-8?B?YVJpbVVxcWE5U1RwWE10anlBZldIUThrRVJtWFpLRENUVzJ1WmtPMVo3RTdn?=
 =?utf-8?B?Vkl3L3ExN0JyVXo4OVJXd2Z6NW5vZVJLZGVZQ0FFQUh6bkdWeVV6NWF3OGlJ?=
 =?utf-8?B?dWxVaEVqM0lyTmlvemFGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFBjdkszSlNwTTY5TkRaM2paQ01lM05FS3V1aFRQRnJKbnBmLzFqYi9PQ1R1?=
 =?utf-8?B?VjdRL2xrTGVxMzcxdjJNTUpMQi9aU1czcXdIRFJxS0N3ekdXQVlYWE9OV0E1?=
 =?utf-8?B?blN6VGlyR0dxZFFyYTN2TjhmMUJVWWNYQ2dDM0F6d2JhK2ZBS3dHamJ0V3hC?=
 =?utf-8?B?dy9EUmxMYzJjcTFneWdvVGxlZUZYM3d6MFZLM1NlUGw2K1FqK2pyWDFVaXI3?=
 =?utf-8?B?Z29ibUUzK2JDLzJibXJuS1ZRQlBkenZIc0tZZVNtZ0txQXg1T3NqQ05WbGtv?=
 =?utf-8?B?cWF1MllSS3ZnRFdvblc5N0R3RUVxVzU5U09VSC85czdWc1ozcHZzTWJMSGlu?=
 =?utf-8?B?dWZ2clNuRkR2Q0ZsYnk0WjYvWHZEeEJCeThqWmtwSm1DYXQyM2lEYlJLYXV3?=
 =?utf-8?B?bTloZTdhMWtvTXlGYjVlemZ3SytkazU5WWxNTklIWnVhbDBNN1BkQjJzRTg0?=
 =?utf-8?B?aTdiQnJrVTBXK1BJMjlrdWNGMkIrdUljTWNMeTFZWWhZbFZ2eHRoajhJSG1Y?=
 =?utf-8?B?eHdxYk5XQmd3OVg0ajFxYi82U3hxSjBoTTB0a3lDdmlwMGhHVXVrcUdEVDNE?=
 =?utf-8?B?VFdqQTB1eDduTlJMdzBNc0t0UytMbkp6SENzNnF5UEI0UUM1S0t1RGJhV21t?=
 =?utf-8?B?OUJVRFg2blA4M0R1b0NKWkhjRDg3akF6dzhScC9CNmZXYlRjZmh4b25EN0hh?=
 =?utf-8?B?bk1ValZ3OERUNmE3U2JrcXhtV1c4a2lzVVFkZkhjajNyU3dtK0V0UHBIZnRH?=
 =?utf-8?B?dE84dXdUdTNBUkhIVUpjRkJSRGNhcmJ3VnczVllWS0JsMzlhTXIwbDdWL0Fa?=
 =?utf-8?B?N0hIQTFBWER5UmYxTlpmdng4NldUSDdQeFUrM3N0ZDg3cTNPYWxldDlNZHpp?=
 =?utf-8?B?aEMxT2pES2Zzd0FhcVFCWWNmSHp3RXBKT2ozcUMzLzVCWnVXRVNLSjM1K3Zh?=
 =?utf-8?B?WDdYLy9RWUNKaDBZcU0xcjBJRUNHY0JBQUpVWEpXMlJPK3dlSEN6aEVqaVhL?=
 =?utf-8?B?UC9qWGZ5dGJleEtzcERKdjdtNmk5ODNYbXVCNWVINjBMNWJiQlBzUTBqWHZz?=
 =?utf-8?B?akxsa09CQ3pxMTFpY1gvakpkQnZpTng1TWNWaDBaMytmQVVlaWRYaWM1bFJF?=
 =?utf-8?B?L3pnWDVkZStRMCt6OWkvN09iSlJJRnhzSEJPQ1BnTDVpWkNTYUwrZ3dZWW84?=
 =?utf-8?B?VWREbC9DWDgzUVFsU3FwTHJoNEQvdXJuMFA1czJDTkVjWGFPYWRMZEZIV2pu?=
 =?utf-8?B?Y1hYVy9YamIzRVd2aG9QZTlGOW9vN2NFdzdiOG9RN04rWlg2L3FpQTNwVUVZ?=
 =?utf-8?B?V3Btb2dYV01SRm5IUVdydlAwL0hnd2thUWpzVzB2a0F1MTM0SjFxNU1RMWtO?=
 =?utf-8?B?VVNkYm92ektsa1NEQXRxRTlEaGdESUF3cnI5U29HNUVqeFUzQmNKKzRvU2Zu?=
 =?utf-8?B?NHk1aGxJVGZETm9xR1NsSC9xZkdSRkRUOTVrZUNhM0ZaRHluWTQwUWN2YmM2?=
 =?utf-8?B?UU4zbC9hM2pKTU5XbjMvN1JDTFlQdkpML2d1VTBERFFEQU9UdUcvUjVWelJG?=
 =?utf-8?B?bXlnMG1IcGhPU0VKRHk3TXRYRGNOU2drUldaci9WNkw4TXRuL2MwTUlqKzZW?=
 =?utf-8?B?dHVDcCs2dXV3YURDbTZlYmtnNDFYc3U5eTlmUDM0bDBMWU9RWXJGM1RVNU55?=
 =?utf-8?B?elgzUWgvWE95em5wZUZqRVdJOGx2clQ2OThiS05vRmRzYk1rTGF5d3RudUZX?=
 =?utf-8?B?c1lTOE04bTJzYXk5TG1VT3FkRStldTBDZ2RDdlFQRkZsaE9QNU1PSyttRm02?=
 =?utf-8?B?Z0w1NVJQMCtmNzVaRlh3eEs1d3VPcDk0MWJHdzFueGtoRW90SzE3UmpwMEdI?=
 =?utf-8?B?bUJwbDBqZFhlRHVGUW5PYW5jK082YXNheUJYa0hHWVpleFlyS0tyMnBzWWE4?=
 =?utf-8?B?TE83NXo1bldlYkxrLzEyOGdUUHJzOThtWktabTBRTVI5U1AwUVlDakNCTkp0?=
 =?utf-8?B?eVVMejZZZHhuK1pVTEFvMjg2TUFjOU4vQjBBb2JTcVZaNGV0alFRZ09kSEwz?=
 =?utf-8?B?YUIya0hjc1A2QUUwL0svVjY0REV3NEt3N2ZtRzFZSTRTWUttNTJkVWFudnVz?=
 =?utf-8?B?TTcxYU5FR0VPbE5uMVk4Y1ZxY1JmV0twQ2c3YWx0eW9DZ2w2SUZ3ZDJvb1hu?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jmdiz8wXQgsIksKCUHdyiTx1LcM4bnTiJiYaBMe1vvrkp+rVSHBfJID6EhACyVuxBBaBDj5ODndE+JT2YT6yQLOY8oqZBjZDnY/o5PMOdYTVSzUn7/OYeYr/XpvGPMh7fDskWdidCSpC83O7//4eS0aW+lgRmM6sdPch5/TYIU9jaFC6zGtRgoXjSW2dzzKoMcZEp92h4msz7U2o1vQHjthSU0JnpgbzRsLNDMwTmfd/Yst2hHUYYPyt2FqXZ9kgnwpqa2JtW/y26wNd3e1YPi5EqjmgXFZmjzdOESqb8c4J2hBCoA8kuKxgYRBmFZeNVIJ7fIfBa+/ft9mE0iWQ5IZ6V9ODD11Gkjhl3a6vsQDfXtXjEk99XGCvoqFSQU0XmMzXsqe8VIxVObgPLim2YTLuPSFdoIKoXffkGVlNOoSFhqVi57Z8SlFGOm9oSRi/4m4fNRKDQaYyAMIeXQAWPufrZoJCNB1JqgA3cCZz/u9BcQO69sobm3D78dXr0P5qAVc/a96d05KRjxsqXXj7HNVVRTtGZ5K0PTZKk8YN3sGGXR9ZUlZmRqHHgs9dNWTVw0GoFyKNLLkeHaA6y4Pe7ssKT05xpgpt4fPVmBwGuAnnBFOC+VaX42GZVPk10Uw0
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 593cb5e0-763c-4e39-8bc0-08dd6bc51e19
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 17:47:31.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TwaE6i4ewZpnLcwodexNG8srKudEzYckjYH+DuuJsdB+S9C4sAuGn0QtuzKlrV3VLfOZ+KJXnkGSDP+BXGY7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6357

On 2025-03-25 12:40, Samiullah Khawaja wrote:
> On Sun, Mar 23, 2025 at 7:38 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-03-20 22:15, Samiullah Khawaja wrote:
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
>>
>> Thanks very much for sending the benchmark program and these specific
>> experiments. I am able to build the tool and run the experiments in
>> principle. While I don't have a complete picture yet, one observation
>> seems already clear, so I want to report back on it.
> Thanks for reproducing this Martin. Really appreciate you reviewing
> this and your interest in this.
>>
>>> We use this tool with following napi polling configurations,
>>>
>>> - Interrupts only
>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>     packet).
>>> - SO_BUSYPOLL (separate thread and separate core)
>>> - Threaded NAPI busypoll
>>
>> The configurations that you describe as SO_BUSYPOLL here are not using
>> the best busy-polling configuration. The best busy-polling strictly
>> alternates between application processing and network polling. No
>> asynchronous processing due to hardware irq delivery or softirq
>> processing should happen.
>>
>> A high-level check is making sure that no softirq processing is reported
>> for the relevant cores (see, e.g., "%soft" in sar -P <cores> -u ALL 1).
>> In addition, interrupts can be counted in /proc/stat or /proc/interrupts.
>>
>> Unfortunately it is not always straightforward to enter this pattern. In
>> this particular case, it seems that two pieces are missing:
>>
>> 1) Because the XPD socket is created with XDP_COPY, it is never marked
>> with its corresponding napi_id. Without the socket being marked with a
>> valid napi_id, sk_busy_loop (called from __xsk_recvmsg) never invokes
>> napi_busy_loop. Instead the gro_flush_timeout/napi_defer_hard_irqs
>> softirq loop controls packet delivery.
> Nice catch. It seems a recent change broke the busy polling for AF_XDP
> and there was a fix for the XDP_ZEROCOPY but the XDP_COPY remained
> broken and seems in my experiments I didn't pick that up. During my
> experimentation I confirmed that all experiment modes are invoking the
> busypoll and not going through softirqs. I confirmed this through perf
> traces. I sent out a fix for XDP_COPY busy polling here in the link
> below. I will resent this for the net since the original commit has
> already landed in 6.13.
> https://lore.kernel.org/netdev/CAAywjhSEjaSgt7fCoiqJiMufGOi=oxa164_vTfk+3P43H60qwQ@mail.gmail.com/T/#t
>>
>> I found code at the end of xsk_bind in xsk.c that is conditional on xs->zc:
>>
>>          if (xs->zc && qid < dev->real_num_rx_queues) {
>>                  struct netdev_rx_queue *rxq;
>>
>>                  rxq = __netif_get_rx_queue(dev, qid);
>>                  if (rxq->napi)
>>                          __sk_mark_napi_id_once(sk, rxq->napi->napi_id);
>>          }
>>
>> I am not an expert on XDP sockets, so I don't know why that is or what
>> would be an acceptable workaround/fix, but when I simply remove the
>> check for xs->zc, the socket is being marked and napi_busy_loop is being
>> called. But maybe there's a better way to accomplish this.
> +1
>>
>> 2) SO_PREFER_BUSY_POLL needs to be set on the XDP socket to make sure
>> that busy polling stays in control after napi_busy_loop, regardless of
>> how many packets were found. Without this setting, the gro_flush_timeout
>> timer is not extended in busy_poll_stop.
>>
>> With these two changes, both SO_BUSYPOLL alternatives perform noticeably
>> better in my experiments and come closer to Threaded NAPI busypoll, so I
>> was wondering if you could try that in your environment? While this
>> might not change the big picture, I think it's important to fully
>> understand and document the trade-offs.
> I agree. In my experiments the SO_BUSYPOLL works properly, please see
> the commit I mentioned above. But I will experiment with
> SO_PREFER_BUSY_POLL to see whether it makes any significant change.

I'd like to clarify: Your original experiments cannot have used 
busypoll, because it was broken for XDP_COPY. Did you rerun the 
experiments with the XDP_COPY fix but without SO_PREFER_BUSY_POLL and 
see the same latency numbers as before? Also, can you provide more 
details about the perf tracing that you used to see that busypoll is 
invoked, but softirq is not?

Thanks,
Martin


