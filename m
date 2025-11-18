Return-Path: <netdev+bounces-239607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5757C6A2A3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BFCE4F9AB9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82135E533;
	Tue, 18 Nov 2025 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TV0UDZJk"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BDC35BDC5;
	Tue, 18 Nov 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477578; cv=fail; b=XuCWYafaoSU/pRpA7wHxrVfbgownAm/YHcKKmWDf5Ch5ITWpapDPSaJyAvg42fLARa0IikCN8infGO7fNXHFLT2PPHo9AYD3+jDTPeGFnEu3Qk7aD7YyV4+o1xEw/M9WBkOMf4mF2W+7HmLguZCrAUdUiab486Uhqibcxp/TH/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477578; c=relaxed/simple;
	bh=XPz1f+hnRw3G6uh46yFu1axATj7EYORkIh22pUYJj94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g/M6L8m8YiuXpGp2DmWagKIJVioWZ6BwohAU8PmI3AfU1hKlSlZ0scUCBjWadwUW5g5sPlpKomNExy3msLY7zOUZGMDcuKQrcta2YcpGZBznmaxgZLM+yxXoVtH+/z6K/J7vNHKYaW8oJU9q4AOcbQlE67DUtyhFxIDdwddrNG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TV0UDZJk; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDB1WywxvJiDxsLoUJ5ytGvd8cAurf5CR8WUsZysmSfyY9XWva9TmdgqenL1UF5ClP9bVRr9jVa2eIG3fL/8eBbMMC/6vQ38UKIHgPHAevYgNOvGE5ng1NLDmLWAs8ZPBd6c7TtCz3NQFBTFDiieqxW7dxIwU5Wf4MGhnWtWyUSDAnuIrvcmVX85ORX5HgSpMyXhlJ9iTkqHUpC59rYaKApwpd4U0wqbxQh+hRStCcsY+R/Xy22q7JwEcUR1OSKx+8i87FrmXrfX2LSNq/lLtYKC+FL36THYfsHHzUSqxn+x8Qyd4ho+lTJJCDgHaDyQR2eYVZgaAtvbzTdiYmU2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPz1f+hnRw3G6uh46yFu1axATj7EYORkIh22pUYJj94=;
 b=akRP2NhhUjE+qvpzi7wiTwXp3HfV2jzGMT5ekW7TKAgB9LP6GL3JPNf/3H1EZnInmd71RFnBtilyVp0+Vut8KxcgGYyKnqSoI8En5XRTCyMJBoHpTZ181fBrTWLDqzwXbVwsVOU/NMd043+6mNnuNA4jDuSKLa+SPBKafMkEB8fZzqtL8kJ9FVCJ48YFfs+1B7qqkLnQhnrblKQxQneeHaC2ND5bwp8vgNpam1kGSJ/S1NwEtLeUCBapAN6ZTxxnXf0p1JAb1fCjQT9hlHTYiDT+lKcxsqunjsvX2SIHrOxeiA0BQTlm7oGUluzABN7mz35/ieufRBiJJ4+BO0K9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPz1f+hnRw3G6uh46yFu1axATj7EYORkIh22pUYJj94=;
 b=TV0UDZJkQBE/A3rhrbjfXKBgdsBcluSv0z+sJykHuhdvK0vhwPF382EzBVM2MAO4V4ge6+mWxBy/PGHli9mtqHFL/UC7hfpXquzGiZQMG3MpNOU/erT5WUXKkv4n1LyiSctrHBRSMCHrETdM0JN+Kl4q+ETkufO+lyhqxhYen3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:52:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 14:52:52 +0000
Message-ID: <20dabdca-e3d0-4178-96ce-9421fea1df60@amd.com>
Date: Tue, 18 Nov 2025 14:52:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/22] cxl: Move pci generic code
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Ben Cheatham <benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
 <20251112154103.000025fd@huawei.com>
 <8d0b9a21-c1bd-453f-903b-22aa302b3639@amd.com>
 <3ef9ee39-b568-4f08-ba4f-82be65248cf6@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <3ef9ee39-b568-4f08-ba4f-82be65248cf6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: d2461e40-8969-40ed-2173-08de26b2268a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1JzOXU5azVyL3pKMDBoanlkU092ZnNyc2diR3ZkZEtucUdQSG1zMWZ2c3BL?=
 =?utf-8?B?SjYydyt6RnZzMTZVT29kYjBabEdRUzYzUEdYUUJJcDFCRWNRcTVtOElHNUVB?=
 =?utf-8?B?bVcwbFEvaFhSU0xxTmJiNmRTUDV1aUNJRHc4cU5Scjh2ZHhuU3ZaQ05YWms5?=
 =?utf-8?B?TXZNbmljR2c1M0RxUTN6S1hTTTUvenJOc1g2cHlPN202NkxERHVURFJ0QUdw?=
 =?utf-8?B?WUlhczI2VWNJOVlMNTRMUlp4VlFzOGFjcFFvUGt2WVJXWC9wWFBaRXFKd0Ru?=
 =?utf-8?B?M1lHNThBd2xvRDk5c1FsYUF0Lzh4Q3JvUzIxYThNc25DekNrRlZMYkRNY3NS?=
 =?utf-8?B?QW1XTVRGUGEwY0t4cWR6WDJoT1BYcXJuVDY3NE9Ddm5sSEQ1SlpjOVovYkU1?=
 =?utf-8?B?eTdZQmt3UFJSOXViSW84WkNIMU9XYWFQQzJSdTdLMlFNSWhhUytpQTFoS3Ja?=
 =?utf-8?B?bVI4b2htU2hQK2Fpd1BYeGVIa0NIVFVCeS9WYmNQVmRsT2Fkdk9vWUJac3V0?=
 =?utf-8?B?WXpKQUVTV0tSSlZ1OVU1U2RBa093Q01hbEFVVWIyOVR5TThuSFMwZldpSXBO?=
 =?utf-8?B?bmlPMzlnbHRkandCTVJHdlk1MkhvV0tCMWh5ckFHdDd3ajRKOUc0TkJQU0hH?=
 =?utf-8?B?bDd5all3ejlFTkZXcHlVd1JxbXFJVnlRQzdUQWtaZ2d4MEpjZXJteUZzMXdU?=
 =?utf-8?B?SkVJMDZwZkxoRkVvSWg3UVgwbmtreDk1a3RtUDhTMmNmU2ZaZVQ3TzRjTTZ4?=
 =?utf-8?B?V1BubXMzby9NRjhoWmZlNlRqckt6NHVVOWxhcENSYm53NFpLMjJHKzNVRlhT?=
 =?utf-8?B?eHNTaVVqYnBDOEswT2tpQmg5NHk0YSszWDhJcnZBRE02ZG5wMXRObTZOdUpV?=
 =?utf-8?B?eFAxVGw4eTVoOWJFMkFkQWhLMmJWQ0JwbEJpRTVkajQramlhSlhBamJZQWhN?=
 =?utf-8?B?TkJ6dUgyeWVwZWdtdXZpTlhsOXBWbmxuKzczL3NKc2JVVHZocHI4dFY4bGMx?=
 =?utf-8?B?aFNZaW5JeEMxZDZLVnZqVWJwSWZiTk8rS0VxaHdCQkxKRW5wbzJiQ21wd29Y?=
 =?utf-8?B?eVdHNERucDdFTGtpVGVQeEFYSzkrbTlESGxFR05Oa3hqb1lGSW5UZjRlbTJv?=
 =?utf-8?B?VFlZRThPdGdYdHJxRS91RFVtT1hyeDNlOGQvQlh0cnlQMVBuZC9YZTVzazNo?=
 =?utf-8?B?bXM2dHdHd25xaHRydW44U29nRzRTc3lrMVVPYjdIUFlhMTBkdUtIUEs5VS81?=
 =?utf-8?B?Q29QMEhMQVZvclcyOUprbUpHTkJmNHpzZ0xwd0p0eFRoRWl2MlhRSUtVSnEx?=
 =?utf-8?B?ZmhpdkdmTjlYbnF2SkptOW1oK2pibzdjUUhYcG5lM01VWXpNeitjazdYK2ty?=
 =?utf-8?B?aWhtYzZNUlNKV01UOEVaS25KRkFZakdnTnJHcktvNEdCY3NydGlJaytwb2Fh?=
 =?utf-8?B?ODVFNHl1VWJJWUZlc010blJENWFWWGlnVS9qcmswUFpPdWxDOFo5SmhBVmFR?=
 =?utf-8?B?MHBvQkZwNllzdEkyME84dEk0YkI1bjBsY0h6b2U1REYvOTlRbUs5cGorUkxm?=
 =?utf-8?B?MWsvQ3NzS29wTGFCUTg4NmRLWkxheGV2NGZVWVlCbSt6MXdwS3B5a01oenFx?=
 =?utf-8?B?b3dsS2EyODlSRnc4ejM4YW0zaVNQYlhBakpWN2ZOdFFxNE5CdkdlTnJINmlM?=
 =?utf-8?B?SFA4VVIzUTNMc05VMWxDS0dYYVJYdDZ0WjlDTHUzOVZIbVdheE42bzRqd2hR?=
 =?utf-8?B?TVNPVWlPakd6SHNBdHRRTGJVMnhrT1lFUEJ0eEhDcGZOMjVnTDk0N2tMc0Zw?=
 =?utf-8?B?ZWwyUURqcUt0MitQVnJDdEUrNm9UODh3U216U1lqTUNlWnpzcWJsajhVVkFv?=
 =?utf-8?B?cHp4WFVpdlYzSktQcFExSDU3bzFQOTRGbUtZOHVGVkhCUVBpaktZek05SSsr?=
 =?utf-8?Q?YOiwf6XPotdDgED8Vu8MVQOv8UQosRw9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzBKbUlObHFsOVJtcVovaDRidWpnRVNKbjRjVFBESFdRaERVN1l3VmZQdkZZ?=
 =?utf-8?B?Y3VyaXNVb3pGc2NWV05WYTlndzN0dmo4aENzTVh3RTkrTmNmYS9yVFlucEFp?=
 =?utf-8?B?eDI0UUIwZUs2bDcxRXVOQzFlUVdGUzF6ME9BdTdmenpMbDJ3aU0yOENLYWxw?=
 =?utf-8?B?VVZJcnZFQ0hGN2dGZ1l4UmRRS2RaeUhVUEhqTWUwTWxMNFUrWnVlQzBnaHJm?=
 =?utf-8?B?SjZqeERuSlZDanZSWkhBd29HdExqZ0dQeThNY0Q2ZTJsUUtJRjNpNnVyK3Vh?=
 =?utf-8?B?Sy92empTdUJQck5LMnFRbFJCQStHZXZXSnkyYkwxTk1tS25naEJlRjltK1p5?=
 =?utf-8?B?Y2ZnU28zZWFGUUd0YXdtcWE1Q1dBTnA3d3FrSlhEV1JsdElPaGlPcEYzZHJj?=
 =?utf-8?B?Y3dJWmREdjZ6dUNpSDM0bUpuUFUrK042YkxYVHphSjFWWmZONVJ5TERPMmNz?=
 =?utf-8?B?UzV3SEhRL0pMWjZRQ2psWmhMQUZIYWloa0hCNkxGMk12UzdzR2tIeGlYV1dJ?=
 =?utf-8?B?NDVmdEl5MXNXTWlDaEIwOUd2NGhJZ2tWUFJuQ1VYK0dBZU9MYkUvcWQwQitY?=
 =?utf-8?B?WDh3WnovY0lockVzT2R6T3dPcTZGeFczcWVaVkhaRmpZZnNmOWR0a1RIeFdZ?=
 =?utf-8?B?dGFqS3hMY3FUQllUMFQ1engzT0RJVS9yOGIrY1ZaL1AyOUdMbkxlbHZmUUFj?=
 =?utf-8?B?WHhOOUU0a05iSEdhd1d2RkxNQ2RoaFFjMG9pRTdlc0NNZHQreWZWN0RNUEFi?=
 =?utf-8?B?SEo4a3FoQlJOYmp6U0tkU1BsUFF2M0RGUnltOWxpaWYvTkZLMjFudk9aenhU?=
 =?utf-8?B?L3lVMFlOZDJuZzIwTEtyaitXd2VTUUlyUVlrS1B5UzVsb2ZOc3RkbXFPa3ZO?=
 =?utf-8?B?NjNxRTVKdkRoWXJ6NHpuZi92QnZxNnFqVG9lL2k3VGEzREQ3dFdSYVNER3BT?=
 =?utf-8?B?Zjk0eFB0bGx2eFhlcWd3VVVIeHowR29acFBRZk43Z3FPa1daZjhVRXhoNldE?=
 =?utf-8?B?ejlaeXI2U2dTQlMyT2NTSGxmUUZDUWtWRVREQUVnYldVKzNrNmpCcm9vbHE0?=
 =?utf-8?B?NUpkU0YvbkRuamxMKzBjRDJyVHBqYktZdkhzM2lQWS9mQ3l2djBZd2J4M0dT?=
 =?utf-8?B?dncvYTJBYkhrb2NTaFhIeUtxVjN6UmhXcXZ4UUsvODBFbEI2TjRnUzFMdlIx?=
 =?utf-8?B?aGkrQnI0VGVBb1FYbzUrd3lhdjMzN2pYdUxWbWJUazkzOElIV1FSMXFLUWJI?=
 =?utf-8?B?dU1xQXErOG9xUkc2Ykp0aFFndWkvcWhYcExrYTBEOVVXU0JBMWpjb1VZeDNn?=
 =?utf-8?B?SmFlT1oycnY1VTlLc09qZ1hhTFFtVy8zeHc4UkIxcXhmUWM0a3g5eG4rRkJM?=
 =?utf-8?B?dU5QUE9hT0RheEdXQ2l2bzdGRHhlUTU1bzlwNXZlTHZZU25hN1hSVkhQT0E2?=
 =?utf-8?B?K1ZTbnRKNHlScEZWdDh4MVhJL1NDYkVsK1o2UFJtbmo1eWdhVHpnY3NZMnZB?=
 =?utf-8?B?dEdJcUwwSkdJMEdtWkdWNk5CWVNSM3o5MUxPWGNpMklMN29PTm5CUkhLT0JB?=
 =?utf-8?B?Y1lQekVSVklKQlhuOHp1Yk9WY0lkK0xZOVdkWC9IWUlZNVMvaEZOVWF2Tm5h?=
 =?utf-8?B?V094V1d4VFR3MUt2UlJtbXZ6dm15TkVoU1BnN0I4dXNCN1VJeUN1eitadWFm?=
 =?utf-8?B?SnhqT05HYmpSeE92UnZQaUtTZXJzQ2dnY0kvWkJ3YUFuNTd1MG5IMWlDM0d5?=
 =?utf-8?B?M1ArZFRCY3BsQTg2QWFHYXlWRWZ0V0dnUUJuU0cyNU5qWnR1TXBsQlhpbUlK?=
 =?utf-8?B?dUJPeWxEbmdBdjI2ZWNWTEFxRWxKUzVCOGRvMHR4cjQxeTVxa3pYOXF3S2xz?=
 =?utf-8?B?VWRpekVuTVpVZ21mUVJZNHB2bUZUTUJUYmRrTnhraGNwRHRnZWVXQVFmeXZz?=
 =?utf-8?B?SjErMFQzaUMwU0RxUXY2SldJZU03U2ZiaUpHdkVzcGgveWJINHdDS3BOS3FB?=
 =?utf-8?B?bUVDOHp0aS9BM0FKOGh5VmlwdlJSSis5c0xCQkZOQVVBZFR1ZVVFZjVyVWtT?=
 =?utf-8?B?a1ZFTnExVVYzUXYyN2JYQkdLb3o5SFV5MGJGSHVZRTN4UlNBelgveHlSS0xJ?=
 =?utf-8?Q?p5STt2u43X42H7H5HeoKsHOzH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2461e40-8969-40ed-2173-08de26b2268a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:52:52.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TX86XV3+2NTVFriTFjhgXY+TbC2J/y2SiYvblYvwIVvEEQAYEwyxVY0qu04u2xzyJIJrwIi8wkTjjyGD0NjqSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392


On 11/17/25 15:00, Dave Jiang wrote:
>
> On 11/15/25 1:12 AM, Alejandro Lucero Palau wrote:
>> On 11/12/25 15:41, Jonathan Cameron wrote:
>>> On Mon, 10 Nov 2025 15:36:41 +0000
>>> alejandro.lucero-palau@amd.com wrote:
>>>
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>>>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>>>> initialization.
>>>>
>>>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>>>> exported and shared with CXL Type2 device initialization.
>>>>
>>>> Fix cxl mock tests affected by the code move, deleting a function which
>>>> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
>>>> setup RCH dport component registers from RCRB").
>>> As I replied late to v19, I'd like to understand more about this comment.
>>> If it was not being used, why can't we remove it before this patch?
>>
>> I replied back then, but if you think this is what I should do with no exception, I'll do it.
>>
>> Should it be part of this patchset or something I should send independently?
> Alison is out this week due to a personal matter. I would just send this ahead and be done with it if it's just a function removal cleanup.


I''l do so today freeing this part from v21 which I want to send tomorrow.


Thank you


> DJ
>
>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

