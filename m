Return-Path: <netdev+bounces-202962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF51AEFF0A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE1B481FF3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191727CB16;
	Tue,  1 Jul 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YwQcdwlX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF627C863;
	Tue,  1 Jul 2025 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385748; cv=fail; b=fwnDbqrdbf7gWryAPv053PvFrjk3KU+xR0K49YTowciZkk/19Q2/FtNzZYAvMNm5DaB1ZSDNUUZR/jbwYJo0niFn0MV2ra8nGIyf9SGDGiFcvWZEU1AQa7wg7dM2aiC/fd1OI+f4LltGsdqiS2vZPWaJb779i/Oc2vtqRTuikkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385748; c=relaxed/simple;
	bh=tPESlRljyzlcmE0IfyheCvCw4hA92fkUf+zccj+i7YE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d03vqQuz2JsIb0C05qaO8KcE9BCw71lUtlkDhCSXOngbzhn7VaRMjh/MRB5LBDFcWbrP4MfY3nBnEtqhzXHcfBRuVLfnxJI9ND9UEqtNjmKm7S8pvptnPa0wH/qr4AVgR+8jo+0I6WS0qpjVkpWqrOMCGuE31rpOqLdM1vpkdOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YwQcdwlX; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v83GEUtSbKj0ZGl/bTPc/DAh1GvO3KCZgJMkDOrRAJWfP3Ot2Z1odHO9EWV8dxE+/pUxUyzFdI7BMHTk9/9iJBdOLXgcZEdezy5nf/UJO0M4gmRbkmxMaE0mwCQDfwtrRZhPLo7xqWjLZTtRAu5DodjqgDDb3SDCX5LIMo9CVbcrZNvrAt0TRD3aGvM8EcI/dYklwkFS4X5IiRERQBuur0EQeFThGAEr2CEiR1TGTySlcH40bdtVZzmeu9zN1TDjZ80+t5P6gVy0vCe2Pi3pzCVodxNGirC+5NB5cCMktdO44ismmeEFKbor2au8O8RwgxWlm4WnYqDBhuRXDJGm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arCOLD9ND0Wswb2RcrNYWGl5R8sfxfmA53ttr4e9qS4=;
 b=UOFjI8c4gEM+q9x9ZAPPs9kIiCLGy3EeQSnpkbtHpI2A1yrgi9qeeIz0fDW1g2n624K4y+aOnSxgbrNwAZrloYvLVayzDC+UIXu5SQzjYLjQ1FJJIpjptUFG4rOLdBPIWXtOfAKCTCUKxvtx0Uy1MH/C5jdg7+UTZ1hWLNadcX5ge5ojvfZ9CX0j0w1mq16geacgaA1lJhIGyR8NGqeJvRsNhIfe5AHY5A0qlRDHMgEwHlAAi9nMlE1jneZafDTY4ViJ25ss9yJ3czd0eMtmSmjyflmQ1RJgUINiukyTO3iEP26xapUJtapWScFYeo+TjafBvvpcBGBMi3cABnYOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arCOLD9ND0Wswb2RcrNYWGl5R8sfxfmA53ttr4e9qS4=;
 b=YwQcdwlXuT++d4ASIMozNtplhymTZmJtBcJY9/cfyE8UfG7CMtqGdg3Kj1YTvTWyO1YJRV94T5fUaT3PbEsHDQ3dYNY+bZnRC6u1rTSbGlASMeMq6gEWgmihJZelz2zJmSWCJ/S6jCzi2ujUkDUaexP20pwEKD32FAjXkbtttho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Tue, 1 Jul
 2025 16:02:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 16:02:23 +0000
Message-ID: <a548d317-887f-4b95-a911-4178eee92f0f@amd.com>
Date: Tue, 1 Jul 2025 17:02:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
 <30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6aa71f-d4e5-4c6f-7420-08ddb8b8aa79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTZ1a0ZsZEYxS0M1dXZTWUNYb1AyT3c3b1dNNGVuOTRTa2pqcWl1aVdIN2xP?=
 =?utf-8?B?dXZCNEtmMkVYbFdSVlFPb0FkNUR5TzZwN2JDZEdMTVBVbkhsNGlva2VCSit2?=
 =?utf-8?B?V25rR1Vzb0tCVWVlcEpaNDBKUVpsMkpIaSs3blBCTnlTZ3Q4b2hFSzVhdXNa?=
 =?utf-8?B?dFpxc05rdWs3V2N2NG1BbVUrZzBOL2JrWkk3ZThLZnM5ZlBPRm5zbWZCTVRT?=
 =?utf-8?B?MmFid09tTllZcWZBTEh5OXdJWVRJRkZvUEdGMHpibzRjNEZHbUpsZnpQQnpV?=
 =?utf-8?B?YkxJb3VWV0REZk1jbHdWbjY0NFVXWEZQSG84bjZWWkpGZUx6NHJoRTJSaldD?=
 =?utf-8?B?N0s1Qi9TQldhQWxnSXRsMHpOZU5pRk5CejhkNXc4cEY3TTlsNjRPcVV3V1VU?=
 =?utf-8?B?T1NydUhDSG83SXBvU3JnVDlQS1B2RUFhd3Vxd2ZnRFZvbGJtS3dkRzNqWFJa?=
 =?utf-8?B?VFV2OURmYVJyZDVNL3ZJK29RcXkrVzIydmMrL1djcEpKTWppcjBPZThyZ29F?=
 =?utf-8?B?OVRqeVA5endpcVNDTGZwTTNxd1FmT2NCL3NtNys0UDNsQ29Xa2pLUXhSdC94?=
 =?utf-8?B?dlIvUisrbnJ1MjVKc1Rpdm9EWStrLzByN1VWUFd0QnVDNWpZeGo3UDAxMUw5?=
 =?utf-8?B?aXR2aGV4cWZWQUhwQTZXUXkzeVI5Z0dkNXA1Y2FMK0xPZFkzZ0ZWZTVrS28w?=
 =?utf-8?B?VWFpbGsxR29BdFBmbktFV3hRQlBTUmp3U3F3dUpTZWlrSTBmVkxZbDlNNGF4?=
 =?utf-8?B?Um1vWjFwMXJQOFBuc3ZkMVYrM05wNnlKcTV0ZnlsSlJxdnk5T21Nb01ZUUFJ?=
 =?utf-8?B?TkRwb3FKcW4yaUNEK1ZDSFZWb1NjQTlibDFQcVFtUFBJc0ViZnZtSzd4bWR2?=
 =?utf-8?B?RkxkeVJZWCtpN1lBRDZ0SThNWXozaTZoeXFFeFRRUDVhMDEvN1BlRDFBNkoy?=
 =?utf-8?B?WW5pM0tIa3RlS29tMERVaXQramh6RTBlVnQ3OWcydDdsalhmUmRXL2dWbkJS?=
 =?utf-8?B?SVd5RTVBQ09NdUVIMEE2WTJEMmtRRzNuTy9VZXpZcnlnc0JVTUtUWXdHT29E?=
 =?utf-8?B?aWdlM0kweUlDYzVIcWQ1d1lLSzg4blhPUmhwYThDUzR0eHRMdnRiUXN5YTNr?=
 =?utf-8?B?SXZESzJua1JTZnBRUzBjV01sU1FzRkF0Um1hTnErcXFOdGV2bzJYb0dTVkVE?=
 =?utf-8?B?UnU2eFI4NGJKYTEwMGFKcUxUNnJzMHBHTmxXdWJqeVNYNVRpdVl4Q3RwbmV4?=
 =?utf-8?B?SUxQSmZZRWJVWjRqa3dTTlBqWURSR2RxNjFSTC9CS1I0MTJSU281MWlkdkZp?=
 =?utf-8?B?MTRlZ0pUTzVoOHRHUGFRdEp5emlYQkR1Sng3NGlUaWlZNHdPdmkwR01HQXY3?=
 =?utf-8?B?ZUc1d3czWDZhUDkvNkhNd1lNVFdOQkU5V1QwZXdCUG5IL2dSWkZJUWxpOTk1?=
 =?utf-8?B?Ym5ycmRwOE9SVU5hTVdmamkxNUpqNnREQ3JRelFhdXhyMHpkUWk0R2lBZW9v?=
 =?utf-8?B?TUFyV2FRd2hnTms4R21NODl0WjRkcjNKSzQ5NEdtcHRsMXd6VmFQRnpwcjc2?=
 =?utf-8?B?MVJucW5lUVo2bG40TjBTUDBubVo4b003WCtZV2ZYRWVzMnkzUW5jYy9ub2dV?=
 =?utf-8?B?UVZVOWtDcitOTTF1NEVWWXNQVUJLYzFPOTN6bDBJQm1sRmNhVi9LN3VpRXJK?=
 =?utf-8?B?c3dvLzdCUk9PUFRuVFVXVVR2V3JkMHNpOGZ3OVJZQ0NMb2UxRFV2WG12b1Rw?=
 =?utf-8?B?Z0VxbU80T2U1bzlGbmt4ZUVqSUhrTVBWODc5UTNLMTliZjRacTNIdDd4bTBj?=
 =?utf-8?B?ci9pM3g0N0RpK3crcm85aGtZWU1lU2VjSGtXejJBZkU0THdYaTk3R2xlbHg4?=
 =?utf-8?B?L0xNSWttc0l6eVNLRkxFUnFNNFNUZVhRcWtsZlpoY1dBWGU5VFNqMy84Qllz?=
 =?utf-8?B?VzcvSENHcDUvOCtPQWpMTUZrQkFFV1VNV0tyMUZYUlRLN3Fhc0FTem5VRHlU?=
 =?utf-8?B?eWdwQ1VlOHZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akxwOFJsM29pUVVmNUllQTg5cWlHNEtuSHN0TTUySkZYRzFFMitwQUFxRXlE?=
 =?utf-8?B?bHlyNUl5NzNWZTNYSFl0YlgrTkd2em9vM2RjUHNROE9CNUVvUGJwSjR0Zndq?=
 =?utf-8?B?cEFuZFNySmIrNHRRUU9VSWRmR0Z3UnVXZG9PcTBZN0w0TkprYWh5RWtxV1FH?=
 =?utf-8?B?VHg5UXd2WGwwWUl3OU1qUHRCZGhNc2FmdnlZQnZMaTZEUWJzN1QzenZXVkpR?=
 =?utf-8?B?L3o4YVA5MjRBNEdIKzd0MjhFem9FYXZHNkhlMzNVb3JKVS90UDU5SXdqekJP?=
 =?utf-8?B?YzZoVlVRUDdjRXRMSXhvbStoMWhsZU80MFA5bnBWL3lqVG1mcE1QN1pzT3c0?=
 =?utf-8?B?UFNWUkh5SzJtZ3gvWU9CZmlONzlDK0lLL2JWNURjbk12TFJpOWE1dEw3Tkov?=
 =?utf-8?B?U0RGR1l3K0dMN2FyZm5Ga2tnc21FVFFLejIzQWxlRUlJTWxrR3N2cUtVL1pE?=
 =?utf-8?B?WmpvbGs3ZWpUdzVaOXpSVW03VlpBaFRiSnF2VFFRd0s3bFJCWmlqWmNTc2M2?=
 =?utf-8?B?dTlWdjhVN1ZldDlUV01oU0NQR1Yzc0pZRkVkY2wzV0NuQ2lJY1FQZGZwQ3cr?=
 =?utf-8?B?RUU5MEpwZGJjVzlBRmpZZmlQLy80ckVLcTBhS2ZrazZlcmQ4SFJUSCtNdzZa?=
 =?utf-8?B?QjVZUE9xRFhuL0JsOXNhYURjdTRYM0Zuc0ZndXNzYWhCOVo2UWRyeERUMERC?=
 =?utf-8?B?YnJhamhUdnlhVkpTeCtMbkIyQ0dRTCtpSElsNDN0RFQwYTl3ZzY3MGRIYXB5?=
 =?utf-8?B?Sk9xa3ZNaFRyL1dqQ3BvNGsxY1R1Y3k1MHdkbmM2YXJvak4xM3NHM3ByOThk?=
 =?utf-8?B?UFRlVlNZN0xtRm9GcC9WQVBaNU0xRUpQWFJ2b29pVThRd3d1Wm1HUzBhZEps?=
 =?utf-8?B?aXhsenJLVVZGUUE5MmYzbEpINmlQZERzQnVtUzVLNE8rdG1NRDZNRWppZEov?=
 =?utf-8?B?QWFGKzFUMmZGdWFxb0hJY1lCMStBdFdZRkxmem1VZUxIWG4vNTg0dGo0TC9l?=
 =?utf-8?B?cmIvcEZaUHpaMDNjS21MejNxQVpVZ25CVFNjTWVNYnpTcEVreTZVVHJaa0hB?=
 =?utf-8?B?RGtZbmx5NUJGcWNXOTVMZzV2RVpSRVFGSWN3S3RHRGIwdmtNQ2Q5S1MyTExK?=
 =?utf-8?B?dmdOaC93VmxqM0NtMFRLdEljakFEMmF3c3hLUW1sWElOSjdOZjA0YVJWRjZn?=
 =?utf-8?B?bE5OOE5wZVRsNUNUVzRDZmt1T3BmQ1JxbUVGSVFsbGE3Y2pHRGNPMDQ5Rkc4?=
 =?utf-8?B?ai8zK2cwWElrUjMyUUhncjVKZHBjcGNMMkhJMnVHQWpwSEhidUErL1h4RnRk?=
 =?utf-8?B?VDJDY3U1UWhqcDNwVmVLTmdHcjFVdlo3eXFFOXo2SEQ1R3plS29MbkNNWGJk?=
 =?utf-8?B?MkdicUx2QitLbUtZY2ZXbjdQNW4rSkIvZk11aUJUNlpMOStqZjZSaDRvNjhE?=
 =?utf-8?B?SXdldGo1Znc5djM5VUhDRllOc3Fqb0lSNk15Z0svQ2pKdkZvdE5TenNRUXBl?=
 =?utf-8?B?eFBlNFpZQlBGQkEvOWRIbjlDYmFJdGJ6MEczemltSDgybEZORlNWT3k5cnFv?=
 =?utf-8?B?NThXemxKSEdxL3RUK2UrdzdWQ2VMMlY2dHQycGVnOVNISkV0cGVyMTc0S25u?=
 =?utf-8?B?eHc5ZFNydG9NQmtUWk43bXpPeVFtcUtvUkpyQlBSOEpsY01mYzMwMisyeWtI?=
 =?utf-8?B?dFYyejV1LzJBRGdRUXYzY2cvTmVwTlB4b3l1R2Zid2twUTFaNmpxeWRjLysv?=
 =?utf-8?B?ODdyZTlsQlFXSTNlMllodDhGcWdLWVpYbHdpNmNJVm43Zys2UVRkMkRHZHAx?=
 =?utf-8?B?RlZFZlUxUzBHbnRPMFVOTnUxeTEzR2hnYitCS25xVUNGRW1XbEpENlJXVXhx?=
 =?utf-8?B?R2F2RS9YYmFOdE9xNUJzWmhUQitEdEIrOFVibFlVeTYzazc3MlJGS3FTWmNU?=
 =?utf-8?B?QUJzblJVdWhwZXF4a1pSajU2Vkt0UndqNk1QUktqRXY2Y1lsUGU3Q2RtcW9a?=
 =?utf-8?B?VDU5Mnowa1VFTGtYNjBOREh4ZklKUDVTQnRVOXkrUFMzNVZmZGI0TloxWFA2?=
 =?utf-8?B?Rm8wc0JEOERUOEJPalVYbkYvSC9WWXhLYUJncFVrdGpxby8yVHh6bStmU1Za?=
 =?utf-8?Q?O7UUyB2p43LrpEVBistSwAMj8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6aa71f-d4e5-4c6f-7420-08ddb8b8aa79
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 16:02:23.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64YfEUkXhEphQo9Kd0VVz3cQfO8B016IiiMAi98+HgbTdd18fr48zEM93D+2utnrMnviWHn6dicnoKVZq5s3FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125


On 6/27/25 19:17, Dave Jiang wrote:
>
> On 6/24/25 7:13 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> The first step for a CXL accelerator driver that wants to establish new
>> CXL.mem regions is to register a 'struct cxl_memdev'. That kicks off
>> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
>> topology up to the root.
>>
>> If the port driver has not attached yet the expectation is that the
>> driver waits until that link is established. The common cxl_pci driver
>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>> until the root driver attaches. An accelerator may want to instead defer
>> probing until CXL resources can be acquired.
>>
>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when a
>> accelerator driver probing should be deferred vs failed. Provide that
>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>> probe status of the memdev.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c | 42 +++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/port.c   |  2 +-
>>   drivers/cxl/mem.c         |  7 +++++--
>>   include/cxl/cxl.h         |  2 ++
>>   4 files changed, 50 insertions(+), 3 deletions(-)
>>
<snip>


> Can you please explain how the accelerator driver init path is different in this instance that it requires cxl_mem driver to defer probing? Currently with a type3, the cxl_acpi driver will setup the CXL root, hostbridges and PCI root ports. At that point the memdev driver will enumerate the rest of the ports and attempt to establish the hierarchy. However if cxl_acpi is not done, the mem probe will fail. But, the cxl_acpi probe will trigger a re-probe sequence at the end when it is done. At that point, the mem probe should discover all the necessary ports if things are correct. If the accelerator init path is different, can we introduce some documentation to explain the difference?
>
> Also, it seems as long as port topology is not found, it will always go to deferred probing. At what point do we conclude that things may be missing/broken and we need to fail?
>
> DJ
>
>
>

Hi Dave,


The patch commit comes from Dan's original one, so I'm afraid I can not 
explain it better myself.


I added this patch again after Dan suggesting with cxl_acquire_endpoint 
the initialization by a Type2 can obtain some protection against cxl_mem 
or cxl_acpi being removed. I added later protection or handling against 
this by the sfc driver after initialization. So this is the main reason 
for this patch at least to me.


Regarding the goal from the original patch, being honest, I can not see 
the cxl_acpi problem, although I'm not saying it does not exist. But it 
is quite confusing to me and as I said in another patch regarding probe 
deferral, supporting that option would add complexity to the current sfc 
driver probing. If there exists another workaround for avoiding it, that 
would be the way I prefer to follow.


Adding documentation about all this would definitely help, even without 
the Type2 case.


