Return-Path: <netdev+bounces-206418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F8B030CA
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77472189BFDD
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB5228C9D;
	Sun, 13 Jul 2025 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oGg5fm2r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE81A83F9
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752405105; cv=fail; b=AkzYzwqQX3lzEo6cBSXiU4nO2TGUntox9oGtJ3WrMyhrJvtlnCO6zXTnPD+2Pa56g1OQ3uM0HMpa3Px7BAVHDzkTiuaFoEgD3Eni/cJc5QcgnO7WaVM1n3li/fTapIYDEoI3z61B/zs1gIvY5xvgSLsSOexk1liMHL1ybD5uXzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752405105; c=relaxed/simple;
	bh=nnqoAwLCzyr3dUiT4YSnOpXN6I9CkboXWZs31qFPPGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LRgMFp3kTQAWIKjN3DOEJ1z5PjfzaqMNzDk649f1QI4PtgWSaBtIhf8l7J0270yw46eHDbVyGQIwR+U3Kakd2MrPNUj4c7F6byEte9qlmI/fcohWmH0m0Dfo5kWXKEsjESbmAHqJUnOkHrZxT0kadw4p1b62WgbU0vVsZjNt7hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oGg5fm2r; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJioWVw+fMsjmbpWy2tJye3CY9Kl6dmVO/62dLwprJxYwkOrSv3ainNf7teGhKpPB0pO00lj2ad45Ct/ubEa77jyzfAeAl6tMO4qzbGwr+BRs2jLoMrj8krKz0gxXQXFMBBGcyWnRYoemWoOIls4+spAllvI9vEb82FktZvknlo6KqgyrmVljHXVC9Y3IvnzAd38V1SD/zCb5FpLA96wrl+vo1UKhw49MvS6uVikhsoMcudp4b+DfcwGFSPDkvtE9LYUGSzxZXEldEK7s8zApSQSpvZX1CQA+SmZTDI1/8OzVxyXH1oyRX1PPLi+r18c8XIgxE3PkYzxvIFNzXF1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNmvhSaSCvRH1axz6lt2OhIAHNrORoXLiVBEls71VR4=;
 b=ydlB0w4pMUZ5Vy0ESmDGiOGnZGuSYHsw0NxtpL9Qh5QF4UQT2am4oF8xN/dRv4UTEHAM90B97EekxgXB2NBq63zzRVoDOniqw/ZP1cp+90Z4Vl47JJxxlsmJR803zmleZDHt3qez4UbXvqwSQlYPPGCw6Pi3Jd87mQrcQ145ypo6xmLT43bm1C82N4aec7hmTBNRjZiRWd4EGYM0kS08x4ew4Kh5si9YLqPcmKCo/X298IfexWF2Yc+mZ7cCZBqWcfGtCDY9oASphmNVbZysngcP8w8UmDL6jTQ7IkU6WFGOlEruBGPndwhhWHocVQ+KesVqa6ZajkOiX0KoHEk1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNmvhSaSCvRH1axz6lt2OhIAHNrORoXLiVBEls71VR4=;
 b=oGg5fm2rjo+3TWQHNgWaIvbDLbEMFJ0ihWuF/KIhZuyQq0dIYYOEiIDURycg9CckY2KWWWjhDoTL3QWk3RErJw7hRfnvqrQjdeByO5BOTc6wtunt66vwjefWy8wQyCGcuHbDaRwjL7PYJJldpTr9/rjqtPV8CRPmfO00CgJ8JGHh6CD067mnzGJ7PC5zKRb/aW9MiOMpVwWZVhGqDCc30HMnIAbHTQHTVphhZg33xZbXIvqwyK48lf+HKfXul8wOIv3/pkRWbKYLMhRJJhk2NperjLC9KIZEZURm5chto7EE16luI2TA+T8zeA8atQ8oqfxrzHa2CLhpNyre8RHCyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 11:11:39 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 11:11:39 +0000
Message-ID: <f894a965-3fb3-4068-9d1e-95ff62705544@nvidia.com>
Date: Sun, 13 Jul 2025 14:11:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/11] ethtool: rss: support setting input-xfrm
 via Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-10-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250711015303.3688717-10-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 06735ab3-04a9-485a-ec4f-08ddc1fe0a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnpGYVFoWklHTTNUN1lWanUrdHdDUFM5TXBoMVB2cG43WElSVGhtaU1DRkg5?=
 =?utf-8?B?eGdDNXQvaUxFZTZFaWZ3TXFRWVNibnp1dDBCMGhsZzViWHF1MkJadkZrVlli?=
 =?utf-8?B?R3A5cGM0eVYxV2ZYZU9TUmxTTC9yRzF1SStMYVVYZmhObm11UUl3Z2lSUk56?=
 =?utf-8?B?T1l1eU5mQ0daT3h0Q00zMnBZQWpMN1NnZzJZWHJsN0JRSHlSNnhZMlViWEdo?=
 =?utf-8?B?dGZtbEVOUkRjV2Mrb0NrcVJpSHMyMEYvbk94VUtKOGQ1UUpLcmtEd2hVM2sz?=
 =?utf-8?B?c0hZOUszN1I3ZmRNRWdDcWNIMUw0QjZMMWV1bUxPZWYxcWRZdFlmZXUxTjdR?=
 =?utf-8?B?YXAwNENDbG5OSjRBcytBalVOakUrODJYR0hmMFJQdHZwcTJGWkNBdVUya3Ux?=
 =?utf-8?B?NHN6TkJsL0xoMlkzMGtnRVJPR3FmREZ5amxqZFlKcy9aQ1prNE5hdWJUVDQ2?=
 =?utf-8?B?V05LMkxJOEw0b1BJcEU3b0R6WURxcXFjb040T0xtamNPUDZsamdiNWF3WkU0?=
 =?utf-8?B?RXFNU3Vqb2tTY2pKYkJGb0grQm9uOC90R0JSdi9HTlJOZFZnclR2Rml3Mkg4?=
 =?utf-8?B?aUF1WjRxVXhPYjJCZnZ3dXZLVzFXMWZjc0tvZUp6WWd3a1lXZmdjL1lQSkht?=
 =?utf-8?B?NUw2WXZhem1SN3RHdU12V2dqdUkwaUJBS29OWm1SVS93YUpvVVlaZUd2MkRX?=
 =?utf-8?B?d1pPczRjVlZPS2JrV0tQTUlYVDRvbE03ZVBFN0hBU1NlbWRyYUY1NkVqWmJI?=
 =?utf-8?B?WkFwc3p3N1VsQTNSY21ZdjBEWnlDUnJDUFVta1h4dU5FME5RZXZVTDhtOVVI?=
 =?utf-8?B?NnZxV3Q0VjZoUnVzNncxVFlKMVpBYTZHc1hGYmt6NjVQYklDYXlpZUZRUjli?=
 =?utf-8?B?OVhBQXFvcVUxT0RhRVVaK1BtMDhva292MzJsRzNRZmJGbFhaTDJaMWlLT25l?=
 =?utf-8?B?QzNzSkF4alRYTU5oS2NMQWE0eVRPY1NFRnJKT3RmOFRKQXVGbDc2UC9UcDB4?=
 =?utf-8?B?NFdCUVltaSt1MWJRWTRjNmozZGtrWFV4REFPdzdWbzFXZ1IzUjBqYXhHa3U5?=
 =?utf-8?B?RkVyL1RWcEpNNVVaMmh3cjMyaEdyWXRZb1hkNDBqdEE1NnFEL1B2Yjh6MzZr?=
 =?utf-8?B?YktDRWJsQlEzaXo0QlVlc2R1RXJkMUptWHhVZHlQWGRONEZwOWpYNjhXYUZD?=
 =?utf-8?B?bXhyd3pqOE5tYWk0VGpaQm9RU1dpVVRMcU1TUmlSell2VHh2YXVXZXlTdFVQ?=
 =?utf-8?B?QzEyM0xTQWo3WW1BY1RicDJKRC9namQ5YXJOUFpoL0U4TzB1VXBuRzdMT1JP?=
 =?utf-8?B?bXIyQzRQM0RjTE5jeVhRV1B1amxwVXMyWDBWUE9yaUI3Y1d2dlRQblRtRTRr?=
 =?utf-8?B?R0tGRzRQNnM3M3NMSlRXTTBpdU9pakZ2N2VSSmZGd2lvYllaR0VtbFdEUHpt?=
 =?utf-8?B?ei90VXRERElUejhFWnpuT0dqWmdpYm5ibzVwZW1IdmRVeWNsSTRBOHZhcGhu?=
 =?utf-8?B?RlJwcXF0dFJNYUJWVHZWV0NDQjFxd2lLdXJ2NlZWdElYRjhJZ2loWFBCbEpu?=
 =?utf-8?B?R3ZIUGxHaHBEeUZJblJ6d1h6QVQvOUNTbWNBcGNNTzk4dWprOGVMWVVoMGpu?=
 =?utf-8?B?eTVhMDdVckd1RmsyUXQydVE5RXMxck9BZm9rVFVyYXkyZjM3YTNxZThaNGxj?=
 =?utf-8?B?WFlZSDBLSW1DWlYrRGY2T1NLOWtsQ25RWjFSaTU0TUt3amxESmxsKzlwRFlk?=
 =?utf-8?B?SEpZM1ZjWjQzR3o5Q2RjaUlhd2ZmdEdieHdTNVhWL2UxYVJpZVZSaWwvRTl0?=
 =?utf-8?B?MWNzaCs4c0FoRW5oT1B1aEhSQVRHSW03Y3UzWmkxRlQzeEI3bXNRaVVMdEJT?=
 =?utf-8?B?dlB6LzgvUVhHdzk4SW9SeUh4dTVMeGY1dTArNTk2Z3JqNU9uWURRazdWamty?=
 =?utf-8?Q?BrNKqljGCKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clhGTC9BUzIrc1lLdWVZZ3hZNXVNa1o4MWpmbGF3NEVtNEQ4R1draG51NmFr?=
 =?utf-8?B?S3NobWhBUTB6enZjYktiRjU0V3R4blI0Vkg3QjF5NEgzSUlRMnBjenB4bHRi?=
 =?utf-8?B?Y2ZCa3pwMExDdlhYTWI4QnhLbkNWVm1TTEdVTi83L2RBY214cHM2TTdVT1RC?=
 =?utf-8?B?bkVJN3k4UmljUDFwUDBHM3hmeTBBdThvbVl3ZThqTTFuZTY0b1luRW5kdndL?=
 =?utf-8?B?bmRhcGpKWE5ZOHpMU3Y4YmJpamVNTkpmS2JycnZGNG92MldPNUoyZzR6S29y?=
 =?utf-8?B?RHFtdWEvRm1aalhUZkFxOXRNblNqTEJPM2ZwM1QrUUg5bmQ4cVRtaGQwdjk4?=
 =?utf-8?B?MDl1SnVnVldUZHlxTm5iczllVWJDUDRJY09lcWFGdVVqWFBwQlJPNmpYRzdO?=
 =?utf-8?B?M2NOR3ZPSzRMa1lmZzBvVWdmZzBxcVpxRXI0QlFMRWJabnZaQTA5Vjl2bmpZ?=
 =?utf-8?B?Wm9yUnpjVkdlRVY1Z095cUV1bW1JK29rU1NrV3M3UnAvYTBZbStzS2QxQ1B6?=
 =?utf-8?B?dVM5Vkd4RmM5cEcvSEFHNGc1bHVTZ1ZkU2xrdW9VQ2N4aTc5MEFuOXIzbkg0?=
 =?utf-8?B?UldLeGhCOWYraEx0QzBGSFVVckhqN1BWek5UZ0xQZWE3TTc5ajE0MHVmbFNM?=
 =?utf-8?B?UDJFRWpkbi9lcjNtM2VRcnpUS1FHVzRDRTFVVmdaclp4RVd0aEk5RWNNdGJs?=
 =?utf-8?B?NUxEQzVTeDlWUi9OcUpzTmVGdldRdlNLWmhQTVphYStOckZpc0RQYmlGUmdD?=
 =?utf-8?B?TXcxU1pNc1dwZlRad2R3Z3Y3czB4Z0x1S2czQVQveFdzaVNZNllmMEJDTHdx?=
 =?utf-8?B?ZVF4LzRZWXNzR1hsY0pHMm5NbVFTaTJobTZCcDVMb3o1M0dMeWFsZXBMcE1F?=
 =?utf-8?B?MHlTYWxCUGo5QnJacCtJejdzOU9XL2V5VVo1S2NwcFFxMk02RE9Ybjk3TmtU?=
 =?utf-8?B?a1NIVFFWNFpseXdhek16a01jaVZ4OWY0TjAzeWlQNFhZNjh2cmgwMlZqU2pZ?=
 =?utf-8?B?SjRHcTVVc0lEODR3MzRKazg4dEQrS25wNzNhSFloTmNsUU5uZlhRS2MzUkpR?=
 =?utf-8?B?bEtsam8zUUtSNlBXQ3ltcW53QThTaGpPTGZHamxMQ3NPbGp6UnVCakRTYUJk?=
 =?utf-8?B?OWhpalRXdTRwNlE5dUtxMUxCenZTcGltRmpMbTVIOVY1dlJYYndYZ21iTXIy?=
 =?utf-8?B?SmN6b3JXWXA1MGVzWDFuZjFiTzkvYWlrUE5XWDBGR0oxSnhaMlNGajBERDE1?=
 =?utf-8?B?V3ZzQzNLbTBaU1c0M1pZR0YxT1J0VVdhM3RucytrYk1UTjh1SUtqU3hZTVFY?=
 =?utf-8?B?WHV0RTNGVDkzTEJLeWhFeTZOTGh2dmJhdmk1YWhHTHdrV2RGTmJLSUI2OGhN?=
 =?utf-8?B?OFBPQ2RlYStieDY1d0RvTHlLZ05IcWU4WmdnMmljUzVHWGFWdTR1SWp0cjdR?=
 =?utf-8?B?RnpCYUIxS1Q1RGpURkQvVFRqcktCOEVWQ1U3SEM1WHZKNldhN3luUmR3OFdi?=
 =?utf-8?B?bEtmNkRDZVkrMEk0ZVJZYUprY3hzL3k5aXZnMXRJd0RnSWpaRWdTNDZqVDBY?=
 =?utf-8?B?MHNZQzJhZUlyOWZ0aHVRZjFkdlYydk0ranZ2K2RwVWtyL3VWRXVBWWhZQUM5?=
 =?utf-8?B?QmtvczJqT3RiT0xYdzdaZkRCNDBOTW9RNVNuUDBXODh1ellESGtBdHNXaUFh?=
 =?utf-8?B?bForUXlLUFd6a3F1UDJxamU5ZzloamNpN2V4MTJGdzJRQnFVaDZEWjdSL1A1?=
 =?utf-8?B?R0ZPSmxoY1hiNGtyK1JVSkcrRXBGWkZwNXA2M0pkcUJIaVA3TXRFcXY1NFA5?=
 =?utf-8?B?Sk5XRUppVjBJaG0reXpVclV0NlBXaEkyd0RRNzlHUnQvMmgwSm5iREVhV1VL?=
 =?utf-8?B?aU5GRFF6aDhiTW5OeFRGSkJ1UWsvS1FTQnU3ZCs0dDh1YzREYXE3R2QyS2Fj?=
 =?utf-8?B?VWJWbENtQ3NlY0YySUpYTXFjZmR4LzRnYlZ4dURnUElvcFMycUQ2ckxQWjhw?=
 =?utf-8?B?UHgvV0hzMmhMUDFZRnpwcEMzbnRNSnV1cnBsTlR1QmxJaUFDMVpvQkRtTWcw?=
 =?utf-8?B?emtiTTN4OHVrR0FkenJ5akRsSkV4TWxlSGp6S3hoQU14S3o2aktYS2o2TW5W?=
 =?utf-8?Q?zluG8SWF6qG4doXJqK+3WO7wR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06735ab3-04a9-485a-ec4f-08ddc1fe0a4c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 11:11:39.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMeDDq1WSbftw3kgWhjshNiRgVid+XXuqNJp8aBIEkctJ5E7HlO1Gi3K8rPYWvUE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

On 11/07/2025 4:53, Jakub Kicinski wrote:
> Support configuring symmetric hashing via Netlink.
> We have the flow field config prepared as part of SET handling,
> so scan it for conflicts instead of querying the driver again.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  static int
>  ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
>  {
> +	bool indir_reset = false, indir_mod = false, xfrm_sym = false;
>  	struct rss_req_info *request = RSS_REQINFO(req_info);
> -	bool indir_reset = false, indir_mod = false;
>  	struct ethtool_rxfh_context *ctx = NULL;
>  	struct net_device *dev = req_info->dev;
>  	struct ethtool_rxfh_param rxfh = {};
> @@ -667,7 +704,17 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
>  	if (ret)
>  		goto exit_clean_data;
>  
> -	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
> +	rxfh.input_xfrm = data.input_xfrm;
> +	ethnl_update_u8(&rxfh.input_xfrm, tb[ETHTOOL_A_RSS_INPUT_XFRM], &mod);
> +	/* xfrm_input is NO_CHANGE AKA 0xff if per-context not supported */

Can you please explain this comment? Shouldn't we fail in this case?
Nit: xfrm_input -> input_xfrm.

> +	if (!request->rss_context || ops->rxfh_per_ctx_key)
> +		xfrm_sym = !!rxfh.input_xfrm;
> +	if (rxfh.input_xfrm == data.input_xfrm)
> +		rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
> +
> +	ret = rss_check_rxfh_fields_sym(dev, info, &data, xfrm_sym);
> +	if (ret)
> +		goto exit_clean_data;
>  
>  	mutex_lock(&dev->ethtool->rss_lock);
>  	if (request->rss_context) {


