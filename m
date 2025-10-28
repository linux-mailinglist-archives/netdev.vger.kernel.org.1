Return-Path: <netdev+bounces-233646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0EC16C5F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 805343526A4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0722BEC20;
	Tue, 28 Oct 2025 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mPA2C/yV"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E729E0F8
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683307; cv=fail; b=TDWgXYW+e8GeRFjRYveggM4BzueGVjieTzyU+KS4s7ohDki2hm6LewPSFL2359EW/NZMmKj806zQXL2+zS/tz0oC6mA/UvZ8xxwn6Gw25Q0c71AShGGMVk6JVBq0IPVZpwknpqvGNZ+jC/IlIZsjDKjKLAE+H71J9TPFQ2LFRCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683307; c=relaxed/simple;
	bh=iYs8v/mZtpcmHggh/IV3ey1sF0rpG6rLXnczUEqc8wI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AQ1MWvekNcl2EGYuXNEDtjxMGEQv6iSGjkTvZBW3QzxBYIe2gtygiwBYKGLfvUn+fGQPz9qo7xqzWO9zcghX8slVWALXkcoW1LduLuwEF6DzlvplEfhf7XWsNM7OSd9jB+0mkuZZhYte1W3bE35iChuPsYAnXx65uExdo2D/vfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mPA2C/yV; arc=fail smtp.client-ip=52.101.46.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNCLeZp+lY0eMaZ+GTAUelgXALYhRktLTGoaQUiaJC9A/JB15mSbnu90py/cdDbcKSERjUq5C1QgOkSXyvdqa2ETrFK61iLWO/qMkL4CnT/phyuusrIqPoHxC9x81hhTQsEw5nqYMb4OpCvvY/LigOab8XPMkj/kGhhjx5FoFTnrJ9lR1h25G6f+77X+vTGOsuulvLOeh/2olLrvh2FDkIDX/eDSu9kgAGhmrXMdiU/KQZP0z96f5T21rW/VhKPFvxymeY/yrFuk+rJPD7TPtoXE7Yu/GTdlVlwnryBHnKYwPWQdUr5xvRqs4WH8PXOxtThs3f/ic/tJkywbz069pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pctws1esQ4ghnexjr+54ItMfmwZDv5dZt549wLb0l0c=;
 b=WW2E2kM8xR3/+6fnCxWUFz/7tZc5MenRMEj22txh2xEWNNkLs/0V+WgLLcf52abc2sIJv5GNqU8pJC4icY79ri4Tu1PEvM095H35Q35PhT/OV+llyCL45xK64y5+XKmd394pGJm+q7ww/wNQEcMaVv1MEZkbyzk9+BkaeERbEd90DIgOd/4Qg7+gq9GrilTbgGYxWIqz6nHK4weXoJ2eOkpZ9DLxPoFzLw47wBIsOyK5cGPemHngY9MSZUey+RUjHa82Kpg3lb+fKTeRzFf6uQWttB6zG+rQdZqt0pizlnoOl8UFD4ASeWS1YyRTqUpuN/Sm3c0sSuYrmTr3DS7xcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pctws1esQ4ghnexjr+54ItMfmwZDv5dZt549wLb0l0c=;
 b=mPA2C/yVBJQIrulxVuD9jsKSpzocJkLJDQexyqsG6OHPrWKh6gWMbvbWulQMgsmTQlPyCA8HDWNnIqHVufBEsM2xyAGNDbe6JIDgsPikxve7ZlNHy09uO9jjaGs+bbKn7s57ppDfWr0DqX8CitAUiFGJ1xrOVIQj7FUwqAvP60nxZF5Vpq9TCDSDI7iBPgC5dDNjtAzwAMVclqu4ghdELZKW0h4j/bZKfLiZYMadouAosvG47yMYidw/yJ+6O0K9NMclqlqlfnuTG8FrZdIqoDQi2NNC692W0XH4tCh2qbPKQhI1EvP65QFbdJ6pfyGWJUtbMn9QDNcW+nB4EfPOjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 20:28:20 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 20:28:20 +0000
Message-ID: <40a43641-adfa-4fbe-902b-a6c436f3ccd6@nvidia.com>
Date: Tue, 28 Oct 2025 22:28:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug
 severity
To: Matthew W Carlis <mattc@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 ashishk@purestorage.com, msaggi@purestorage.com, adailey@purestorage.com
References: <20251028194011.39877-1-mattc@purestorage.com>
 <20251028194011.39877-2-mattc@purestorage.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251028194011.39877-2-mattc@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: cc807877-e524-42d2-8af4-08de16608895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ni9FclIzOVVLd2gwN1BnZFJ0QnRiRDV3U0puYjg3NXBhUEFnR3JwVWpJeExm?=
 =?utf-8?B?a3dSMk5QZ2lMNWxiYWxEMUtGeFBtNjFvZTBnRklJNVdSNWU0ejJ1RVZjOVJQ?=
 =?utf-8?B?ZjJYOC96UFpvaGp0ZjBreFM0a2lrdUhqOXp4Vjc5Y2dYOFA2N1VjaC8wc1k5?=
 =?utf-8?B?U0VLKzltUlUvVXgzTUs5bDEyeHl3c1hBdURpY0lyRDBnZFZvbUdaVEpOajM2?=
 =?utf-8?B?eEVlN0NEL0RCY2FsalR6allkTnY5dlF1UkxYbDNwU3JiM3dkelFtOTZvZFQ0?=
 =?utf-8?B?bUFydDlKZDBRa25idjFocXFZNWRZSlVqOFFzMnRPc0xDQzZsZzVhYlVxTzk1?=
 =?utf-8?B?R3UxaXFTbC9yVkFOMFQweTFlNnNZVWhZSElMYkpvbGxQNmRqQ01QU3NPbWl4?=
 =?utf-8?B?NUkwZGFnb1htYTV1M0c1QXl2UEdid3I4eTIwUy81eE1EY2pwd2xZajhWdGQ2?=
 =?utf-8?B?VUxnMGkrNFRsOElzbTBOaUxPemFTdiswVmUveUordXFPYmNwdjBERE5HbFdS?=
 =?utf-8?B?YWY2TW1sa3pXQWpldXJBVFBvWlBHN2VCZFRPdlJ3dTc3RFdTblNNWVM3bGxk?=
 =?utf-8?B?dXZjS05aV0cwNXFKelFud0psaGJSQlJ0QlV1aFBUM2xEUjZ1SmpMVWsyc3I3?=
 =?utf-8?B?N0ZxeUU2a3BpVGVDeHlOUEEyaE54Umw5cTMwZ0pJaHUxUUtSemVGVGpwQ1NN?=
 =?utf-8?B?ZUFObXZhdTJVamFSSWtzNUNBeWp6UkthVFFJN083TCtNdS82YUJuemlqcm9N?=
 =?utf-8?B?Y0VDdVBJc1c2Q290U2FFTmpPMFNEK0NJTlhZQWQ3RTByV3drK29wTjIwRTI5?=
 =?utf-8?B?YkllUWU0Z1BQMFcvcGxndVFIRlJvR2FjVjQ5Mit4dE1qcVJJTEt1ZUtJTUZ3?=
 =?utf-8?B?cWxnV094SkUrVnlrazI4VWV5Qm5MaVM2c21Dc01OM0JZK21oQjVJbkRMQ0RE?=
 =?utf-8?B?ZG5MaFdJR2RGVFRmV2dmVndrWXdjSi9iL1hxeDUvWkZJSERESFJkWHE0bkxr?=
 =?utf-8?B?ZDRJNTNRM2FtSTdYY1hlTW4zYlNPZXc2Y2x0VFlXdGVxZk5CQXI4N3dBeW1z?=
 =?utf-8?B?eG9wT2E3WXdpTXh2MnoxSSsreC92ZWpLalhKTDRnVVZsZUErRld1YmRYZWFz?=
 =?utf-8?B?QkY1N1ROWkgyaDN2WjczOVFwc0xTM2lTWjZkVW5GZVVnNVFMYTgranJOVTRC?=
 =?utf-8?B?RGhnRUthSlpvdWJPc1ZnRnRwZHhKZUFKazRrb2NidUsvZUdBMDZQWi9KVkVr?=
 =?utf-8?B?S0FUcHdSbkpMcUpDUURhR25uNkNzQ000eTNaYU9sWFlZVjJpbnNFVGpGUHdU?=
 =?utf-8?B?K25nejROU0M3QXFQSmtrRU9ENWt0cDVkOEVIQS82M2hnNWU5bnB6cUlGWEZI?=
 =?utf-8?B?aUpQeDdOZ1Y0S1kyblZBUlg1NzB1RmF4NkNZek9EWEJCN05SSFA1NlpuUitV?=
 =?utf-8?B?NlZESHViN3lCdWZmN2lrUkpNSHQ5VXlsVkV2R25wbWQzQUJsb2tUMFRWRjJX?=
 =?utf-8?B?SjNNb1ZhZkdjYXVPVWpPS0h4VDVYTG9uMEM1TE1Od2xqYnliQWRGbnNFNWZu?=
 =?utf-8?B?YXVJM3lDMG96bWx6YUNURGVFNEgwTGVvdDBFdWdSdXNMeUUxU1VUcDhFaE9G?=
 =?utf-8?B?SVg4dlZsN1hDOGEvOE9kaDJjTVlPRlRsdkZpbjJoSW95VjM4WVNBRG1EdjZB?=
 =?utf-8?B?MWg1eUNLdWlwcjhoN0V4TW9aelZVVmRLSFo1MGh6a3MxODFNaVg0S3FwcDRs?=
 =?utf-8?B?UWpQYitDU3hhWkprdmFSa1ZsR0EzcE5QUVhIejJVVmh0dTBSVUtJSUJBWWJM?=
 =?utf-8?B?YVZYNlQvU1c4ZkpreTFQQStwVnE4N0pxWTZ5M3FnbW5vaGwrSVJzVmdqUkZR?=
 =?utf-8?B?NDE3dVlrbldZTDB4Ri90TW9RUk5BYW84aVRGVTBEUTJYMytXeUw0aDZrY3NO?=
 =?utf-8?Q?usdds8GgkHhxdjB/+sBha40HlfgHQELo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdWSUpaTHQ3Ui9IdG55TkZ1c2x6NUtzWlZLZXdxa09WM1oydUt5SFpGamxB?=
 =?utf-8?B?a3JWK3RBQllHZjZQMEJ2Z25GVUd1Y1E3TGwxZ0VjbUE4dDRBYjI4ek9rbUQx?=
 =?utf-8?B?RGpIWmdSS2JTdzJCYlZzQnp0eVh1ZmZVdXFETEJOVFBmektKRE56RE5RL2lo?=
 =?utf-8?B?Skk1aFdNeWx6aFJtVi8zbWdReHFMZnVBYWowMy95cW5jcVlsMFZLb3dHNmFY?=
 =?utf-8?B?RTBaRW9CK2EyOHlWbFNvcDhRUjFHSXZzdGJ4VTNiMzJ2cmlJek9QdjUrZ3NB?=
 =?utf-8?B?cVc0SlUra0hLcCtIbDNRU0Q1LytGZE8zSUdrT1NRaFdMYXluNzVZcjZoZHVM?=
 =?utf-8?B?RU1NaHd6RWF6emJIMGxzd0JQU01NNXRBdTdWdnRLUXNpVnVxUkZLdG1rTFZp?=
 =?utf-8?B?YktnVUx1VkRQdFdMVUZ1ZGlpRUdpcDhCa3Mvc2hFNlVMMkcwRWhhcS85TjZU?=
 =?utf-8?B?MDlLek14N0Q5Y2FiL3phNFlBVHpldWUwRGlWazVRZzYwRUVZektFdDF3aEZW?=
 =?utf-8?B?YlJjOE1BSHkxUVFjT2VIQzZ1ZktNTEJIdmF3WEFuanZnQnhxYmJqK3pKc3E1?=
 =?utf-8?B?SjUyS1UvWklUcHZLZkFid1d3V1lpYnB2a3NRTWYrWVBjR3BPMlA2dmN3MXgx?=
 =?utf-8?B?NXRaMkNLY0NTdWd2YVNWQWNRTDZmSXBGR1NjNkcrUFhRYmZ3N084cTl0bTZF?=
 =?utf-8?B?dHo0OHZqMTRhMVc0K2RCQ1UzSXZQQ1JYcmVGdGdPSmxVdDRYeDUwVmNZem94?=
 =?utf-8?B?alVhNnVVdDJQUHpiQmN4NmJScjRjZE1BNzlIVTlQNFFDTmNuUm1pREMvVk1F?=
 =?utf-8?B?a01TNXhYbkxWdUEzNGUxZ2FUS2J5UkRicmhaLzBFMVZFNHdER0s0VGhiTHkr?=
 =?utf-8?B?QU9OZlNXVVFwbHlWVUxOZWtBakNwSTRGeW9UZ0dVOGNoZXlRSGlBMnR3NHBo?=
 =?utf-8?B?R1pzKzhWckZGcmNPSXJnRUdGSnB0eG54eW9BNHpTenF1bDNQVUxDT3kwdDZ4?=
 =?utf-8?B?eWJMWHRPdzVzbGZxVVJyWmp3Sm1yb1Q5bGNaUk1GR3diNVFwWGV1SXdMNU00?=
 =?utf-8?B?OHNaWEVoVi9LMjNCSnMwS2puQ1NwcVlCTTg5aTB1Q1RVckxNYTFnbXZRTG9U?=
 =?utf-8?B?OHNwd2t3c202RGJhN2xXM1UrYnZ5c01vTlV3N3lYWHluQStLVUthRjI3UWFB?=
 =?utf-8?B?eXFoOGpCR2ZUd0FvNDNzYml3MDBJc0xRaFp5c3ZIN1c0bTJxd2cyTDRjUFBI?=
 =?utf-8?B?cG1aK1NmazNtREtzYVNWcTR5eFdqRk9meUxPd21KOWVFZTFkYnU0TDAxb2N3?=
 =?utf-8?B?Um1HcVJLd2ZGVEhvY01YbG5aVnVwRVZQeUJteFh1VUJJSGhxWFhrZGRMbTIw?=
 =?utf-8?B?ai9hTStZUHVEVXZET3cwVXhUNkorQ3ZkbkVsU2dGMmUzWHhuLzYyc3RRUHox?=
 =?utf-8?B?NG53WkpoTG1GZmliZmFoRExTU0ZnTGhZcVlvZzBtdHRZeVlkVjZmMVF2bmZ5?=
 =?utf-8?B?NGFPbDM3SmVrQ1Jwb2ttY1lLM1pDK2lXWnhRT3dTcVhJSFlGNlg1WmpjRW5S?=
 =?utf-8?B?TEE3NnhGM1BtV1FBb2pMRjl4bm14WVAzazdzMEZHcW4vZS8rb21XbGI2VWNZ?=
 =?utf-8?B?MDRzS1pqQTdiKzFtWG9xSFg3cjlTUE1vL21BUGl3SUFnYlI2OWpQeFF4NDVz?=
 =?utf-8?B?WDNaWmJuU3NkVVFSZitua25vdCt4cFJNRFZMMnNnR0N2NmJISVgwd1ovQ09x?=
 =?utf-8?B?TE9VMTlkb2ROR3paNHhNbTM5b1Z2dWdsclA5SDR4N3RxSEV4Q3plQW9nWG1G?=
 =?utf-8?B?cWRsRXBxWjlLeWg3TUFuOGVNeFp5QmVNNkZXVnNjbklZSzcrZ2RQdzN3dkVm?=
 =?utf-8?B?MUdWWWZrbWtlNENIMDdrQmFzVGQvemdLOElyV093U0lJUmVSQ3lvM0V4KzFR?=
 =?utf-8?B?NVRrNG1zNThaQ2QyN2JhY28vdTRTblg5YVd6WDdwV1ltWHFqQnZBVVI4bW9a?=
 =?utf-8?B?NHFPT0EvT1NoYlQ3MXZTQVBoYnVGKzZWSllUbGxoczg0b0lyQTJ5d1Q1NUZw?=
 =?utf-8?B?YnRLZHZQOEhJRzF6M3RJZllUek1tSk5uMXdUb0loTjZmOFF1ME5Lb21hMHFF?=
 =?utf-8?Q?5KZokq2dX4qAJav50lSuk1w7y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc807877-e524-42d2-8af4-08de16608895
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:28:20.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5qN81IS/EB/+MMHRJbVCxrPEBkA2ZsM3ZIhFC6rLYUug2LauLK0GNaaJcFpGrZx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

On 28/10/2025 21:40, Matthew W Carlis wrote:
> Whenever a user or automation runs ethtool -m <eth> or an equivalent
> to mlx5 device & there is not any SFP module in that device the
> kernel log is spammed with ""query_mcia_reg failed: status:" which
> is really not that informative to the user who already knows that
> their command failed. 

Assuming the user knows why the command failed is a big assumption, most
users don't. These status errors are indicative of more than one type of
error.
And if he knows, I would expect him to not run the command again?

BTW, we have a bug that returns success in case of an error in module
EEPROM query so the user doesn't even know that the command failed other
than seeing the error message.
We'll push a fix for that in the next few days.

Since the severity is logged at error severity
> the log message cannot be disabled via dyndbg etc...
> 
> Signed-off-by: Matthew W Carlis <mattc@purestorage.com>
> 
>  100.0% drivers/net/ethernet/mellanox/mlx5/core/
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> index aa9f2b0a77d3..e1c93a96e479 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> @@ -310,7 +310,7 @@ static int mlx5_query_module_id(struct mlx5_core_dev *dev, int module_num,
>  
>  	status = MLX5_GET(mcia_reg, out, status);
>  	if (status) {
> -		mlx5_core_err(dev, "query_mcia_reg failed: status: 0x%x\n",
> +		mlx5_core_dbg(dev, "query_mcia_reg failed: status: 0x%x\n",
>  			      status);
>  		return -EIO;
>  	}
> @@ -394,7 +394,7 @@ static int mlx5_query_mcia(struct mlx5_core_dev *dev,
>  
>  	status = MLX5_GET(mcia_reg, out, status);
>  	if (status) {
> -		mlx5_core_err(dev, "query_mcia_reg failed: status: 0x%x\n",
> +		mlx5_core_dbg(dev, "query_mcia_reg failed: status: 0x%x\n",
>  			      status);
>  		return -EIO;
>  	}

Both of these functions are called from mlx5e_get_module_eeprom() which
has its own error print regardless, so this doesn't really prevent the
"spam".

