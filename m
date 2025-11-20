Return-Path: <netdev+bounces-240406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6F7C74757
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A2964EF3EA
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A1345CB1;
	Thu, 20 Nov 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gJBAhP1K"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6634402C;
	Thu, 20 Nov 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646752; cv=fail; b=tzHeGWUaDfpApYtinYQQUvxBzwSTyD158t/JPMY0h8Al9angezN4lBvyckc/bT/Y5TpZaJNdZOJkUe0Kq8gXBtzQjMKWo7+5wgKLKAZ8uXZQq/R2q6K85Xp3xi1puEou36e0F/IBPrkB/MtDgsSuQ2AsixFpxyfV8KfUqaXc+vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646752; c=relaxed/simple;
	bh=hTWY8cVxK80xrdrRyzhKZdekRl7Rzftp/PSdSpOM1TE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cBeUHT/mGhVINgkW/C3d7tQ37FEKPR08VH/xq6rRd8th7beuKOYgvfyTHTdIrymaBTbNxnJnatAwmSecy3jhdJuzONaZBvoFA8i6G3dxS4eMWqJJc9VljzAM65g27niWUUw4qzSd1v76JSabs73lMAwLX0WRsKVV8647VAh6Gyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gJBAhP1K; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKA4Cxi2861888;
	Thu, 20 Nov 2025 05:50:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=+vkCvKcLG9W9qtEUFHhS9aICCEuV6Jstz/slUMGmdns=; b=gJBAhP1KLmyB
	9NgbmHA5GepxRyFwTpcG5YMTVo7stlQeQtXwN2enYElFTGy3a3bZZhsMNAfEcRGV
	l5b7h7RRs8Hf5kqWNo103yuH+Y7PvdSYK9NOEBxvvBIEUG+/vQ5Jw0C6gelxOc9T
	4kLrLv2qJZDydgddnE2P2YCAGsb76pD9v80wBLmaYHKK4gFeNezsvxng0uUYWRyT
	ccOi6iGJESr7jMpD98GWvHkIlyPu1fBfGBHSeiURnvYtAVmH/khbyFtYkgdE513S
	b9aT788Z2+EU5FSR+dP23XySMBkVFg3oEzfzTpeqHR98ylaYs8ijnY0vpIk/g/pu
	yp64Li1c/A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4aj0wk99d3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 05:50:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhYSJXuRXQ6gQKYtn7+pyN/A22Ak1rHT0sc6kuhg+QmKwqCybbNx90OA8zeIruzHZqGc1eXb6FUl3xKEcyRV85sKt+7DKW1hUDQfg0loiZ02zj/AFd/LnJTnX2jV2vPFudxT4hDodQ4vzK1ty+4lvk59yIlTySOXEYNGL2fitGb7J6thtrJlEjAXDi9HF3j1V/I9+EyKZE5kooHEd+spehYQmX2h+URAg2WauvLtKe1HLXxBmszkTfWLNTeJJx3J7yNe7d7CsB5uOaarKUbqgddDkRfZIUDzXlOMH9kFa/IRDPD5uRTietu4kqYt811ZPOi5Fgctke4SSTcd4GVcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vkCvKcLG9W9qtEUFHhS9aICCEuV6Jstz/slUMGmdns=;
 b=rMc0MKCEO4pyumzokrsMfMYi7ataBZxSTGf2Oog5PGMfZ3StRcUQWilSxS264xOS4Bwiz6utjGowy73aqWibedrXbFbE2P7khFXbQToLSGnkUZ2rrz97+0CXd6oPE3VkI2MhbceZDb/ACkUk1xpjiopHbxtp1ssFDuZhV+ScSOv1IQzjFt6v1Kpf5CwiExJC1MIPRL+P5X7huSnyZqkCdSnE34g1pQCw/Tckgkh1yEtJr11rq7HhvqFg/SoOSX/YJziRzzSuEESaH2T6jUXnpC93hthqPhQqIJdhO5i6ksR823uUhoHCUlBuNhXKnE57jMThlpLZa6UAPiS4XfNrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW4PR15MB4443.namprd15.prod.outlook.com (2603:10b6:303:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:50:52 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 13:50:52 +0000
Message-ID: <15a1abe5-2b04-4f67-810d-9a9ab9e2dd6f@meta.com>
Date: Thu, 20 Nov 2025 08:50:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/44] ipv6: __ip6_append_data() don't abuse max_t() casts
To: David Laight <david.laight.linux@gmail.com>, bot+bpf-ci@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, dsahern@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251119224140.8616-10-david.laight.linux@gmail.com>
 <ddcd920ff99e0f97ed2c92cf650872d76a4b7404ea87a104e6ab061ee3005cf9@mail.kernel.org>
 <20251120111623.44ebfae7@pumpkin>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20251120111623.44ebfae7@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:208:32d::19) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW4PR15MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 4601abf8-ab02-4401-7fc1-08de283bd19d
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UmhDUGV4VkE1alcwd3Fqb2tQSHRBUkJiUkVpL1dMRmpVQlFRV1ZHakxkUytZ?=
 =?utf-8?B?U1ZuMERoOFZjMjlSYnF5dzJnQTZaYTI5T2JWZ0hacllROUhvQ0JoNU5VKzll?=
 =?utf-8?B?WjZqT2xjUCtuUk94cjRieXUrSk1weWxuTUNSL2F5Wng5V0UzbTNqUkF6Nks4?=
 =?utf-8?B?WXZWSU9kZkx2YUlWL1NDdVI1Q1FON0lEeEFrWWowQjd5dHl0Q3pEbVk5aXJm?=
 =?utf-8?B?THlxRFBmVVVwTEdJcWJpZTdpRjNhdXA2R1ZvdU9jL1lWbE9YUEJacjBDbnk3?=
 =?utf-8?B?anpUNU9oc3E2VmIxYnl5MWZYK2pEMG94RGNlczRERDFCd2ZlMFp2SFkwNDhH?=
 =?utf-8?B?LzNPV282MkduK0UrOTV2dnlBb25aU1U4RFhVaEp4VkRDK3k4VmhYbDA4cmtp?=
 =?utf-8?B?S0g1S0RVWm00RjcwTjh0SUtzaHo4Q1FOaUxKcUpRS092WE1tZndpRGUrTWR2?=
 =?utf-8?B?Zi9hVStoMm8yQnpvS2w5MkJMcjNxRTFOUkdIMEJjNjkydlFQNkp5RGZsaFhR?=
 =?utf-8?B?U1I1NkUrSDVueWFXVjZtbmI0a0lERndZVmk0cHA3cXZmbFlnSXljYjlINzFr?=
 =?utf-8?B?dHJSSWljc2gzZG01dzE4eDEwOFFqd0RaU1d4V2RZdXNqL2JkOUhRTHdiUXhW?=
 =?utf-8?B?bjZuZlJUTzFBQlFFR2V2TWdLUjY5WnE2bG5yRHl1Yk1LSHBuekFaSWNOMDRm?=
 =?utf-8?B?ZU0rR0lXeHFkOXVoeGlvdk5xUzZuVUw3Zk1IY01hblFBVzVZRkJHb245ajFl?=
 =?utf-8?B?cFpiZEp2SmlKK3plOFBNZ3pXdkxRVEhFYWJxemtGNllrM0JueHdpYnArN0pL?=
 =?utf-8?B?RDZNQnVxSUc1M2VjSUF3czF2a0NIMU9hSzA0ODJ1akYyNGxJSUZENmpVUEpC?=
 =?utf-8?B?NmFlMFRrVGl6dTZxSng5YkpqazNYRGlVcXY1R3AwYjZ0dGdSZEFQc29SSnFp?=
 =?utf-8?B?b1RPRXd4MXEvZlRuYk5yZjVjWStwckNabVcwVDVnYTc3K0hMTGxZNUxxbGFE?=
 =?utf-8?B?dWRoWmpLazRUZ2FPdE5yM0FVZ01yeU5SK2EzTStuTHVEUnowQTBPNGlJYlZJ?=
 =?utf-8?B?SXBtMC9UVmZxK1FwVW1GMTlTaFRvT25tUkZtbExtc0hkSmNWdm1iM1VkdEFO?=
 =?utf-8?B?VzRIRlhFMXhkbUlzRm5NT2xyZ3E0LzFLTE4wU0VIR25SOHdOdjhDUVhPMWMr?=
 =?utf-8?B?bnQ2b3N5YmQ4UXJHRURrWkUzeFFLQXBPeDBneG1uUEEzVXA4dFdkZjZoYzNq?=
 =?utf-8?B?NG5VcXQvTi9MTUM0SUQ4Y1EyMW9nTVRraEtiTUExUVVpVHh6SmZRcGtpS3Vk?=
 =?utf-8?B?TmxDYW5rTk9xN3FNdjIyYTNtZkhKTm4xdE1xSmZweEROaEhsWkpSWE9XTHF3?=
 =?utf-8?B?dlYvU3pUQmc1Q29CM1VteElxdnJXTnNQdHBzSWora3Q0V2V2VlVyUXZObnV5?=
 =?utf-8?B?VGhIMSt5NHhLSkFFcDhQbW5hQ0dkWEIvdzQwZEdXZmpEMFpnaHJzZG1kQVJ1?=
 =?utf-8?B?cXZGM2FVakNtTlp1Q2F1TzI3WkV5RXVBYitwWFpMQW1tY0M2TjZWNjdKck1l?=
 =?utf-8?B?MGtOTkc2bXFmczA3c1RReHBydVhoR0gzZkMrQXdpbk1QejltSVd2YlFiZzBq?=
 =?utf-8?B?OW9NR2trb0dTclpqM05INU9oc0psWG5MVHhIVjROd2tzM0JlK3dteUpVTFBD?=
 =?utf-8?B?WFRTbmg3LzhFYWh6K1pCeGxyQU1qMVhabXZyZnNkcUFoWGhWeGx5aHRaa1Fn?=
 =?utf-8?B?K1BxNm1MZXgrcmF5bnZUM0E3UzJsemF5eGJiR2Y4QTZQVVhncDlBWkkyanJW?=
 =?utf-8?B?MklrZldtT3Z0K2JqRE9rS0pkeWpRekhMeGxFNUdNR0dMK1BhdlhIUEx5V2NY?=
 =?utf-8?B?a3F6K0Q5ZzVKa0dqU2RiQzNqTjFBM0F0SnJqNG5hUzVFYnRDRkVQQ1VPamF0?=
 =?utf-8?Q?n88gLthK4tW8VQ+sycH6EKN9E76K+Ohp?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?czBZME0xUWhud0JWZVFLV0JTdEcwVDRQT0hiQnpTMmJFVUozQ09zdjVsdWVC?=
 =?utf-8?B?cWE5blJYOXBQcHc1ZlpkOTE5MkFYOGF3bjJBbUpTMnBuSzdjZVdJU1J6b3dq?=
 =?utf-8?B?UzBFU0o5eXRXMTFuZVNFMjA3YUY4NGVEZjAxK2RjaTZtSTVoN202VDVDaWV1?=
 =?utf-8?B?V2Jra3N4Y2p5OVNJWTQ0c0VISys3S1l0TWttSkZyeGJ0eWx4WUtyeFh3T05K?=
 =?utf-8?B?dUNoNitKay8zNkJFWDdPd2pCUncvRDNiOVdXbnZFdUF5L1pMS0xyTXUwK1NP?=
 =?utf-8?B?ZTFWRWxmd01EQUgyWW9zUHBTelVnenVscFhyKzl1ZnA4ays2eFNwdzNpUzY4?=
 =?utf-8?B?dmpyM2tLdThidTU0YVI0T21SYnpZS1lPejc0akU3YlQwejJaYWZ5SHZXdFBy?=
 =?utf-8?B?MFZEeUhBQ2ZQWnI0Z25rZG1sRzYzZ2hFN1NsSmV3VTdzYVR4RXZoeFRTcjBS?=
 =?utf-8?B?VXFDcC83eUxUWTdxdmpZeFBMVE83S2F2L1FVYnVneGt1YTExeXhLdzRUbld6?=
 =?utf-8?B?QzBFbjV3bVE3c2ZuTTBhRkFPbEV3TFkrdmxlNzlNWnBJUGhGT0dJeDFvMkZT?=
 =?utf-8?B?VnVnbmhlSDdNdGtSRVJXeGgyU3R3aHNoTzhGSjExbWNncVoya1JtWFBmbFh6?=
 =?utf-8?B?eU4wMlpVNldRM1VsZTBUSTYxbENuUkZQaFl2MzVsSmVQVjkrM0RpZTQ1UUhZ?=
 =?utf-8?B?blN2Z1A3WFlxd0lmMFVkS3piMDdoS3paN1hwa1NCcVVMM3hBamI4R2JkNldB?=
 =?utf-8?B?Z3ZncWlHL1RVZ1hHRTZGc1Z1VW4zODBlMXoxdGhSWDRITlpjeGdFQ1Jsb2xy?=
 =?utf-8?B?NW11a1FPR3p1R1VMQnBFM1Z0ZEgwZTlUTjZXOWhLOTU5VGltTUZ5ZE9NcVBR?=
 =?utf-8?B?QTRqSjlpbE9Heno3R0dxU1lDUE53OW9mdTVkYkx3dmVzc04zVFNvZjRXY0pO?=
 =?utf-8?B?Y1NpdVBuUXFxRDA4dTE2Y1JuQ3I4OG5vR3FKR3FLTkNmaWFwWE1keEYwd2lm?=
 =?utf-8?B?MHpRU3k2NnpSbllaTkZKZUoveVZKUE9ITndTajdDOHd0UnpYa1pzSXpzUG5M?=
 =?utf-8?B?dk9uTC9haWFTZmNFQzhwUVY2NzgrVmM2YS83WVR3Y3dLM2QyQ1VOaStVdGc3?=
 =?utf-8?B?bGpmeG11alFLcjFYcFdxQTF2UU5aSWxwOUNwemEzSGhjOWxlMDNIcTdpTno1?=
 =?utf-8?B?dzBDM1BpUGorRjNvNXJTWENRYlBJeUl3NnBqRno1bEphbmZTTFM4aUhpUHdP?=
 =?utf-8?B?ckV6MVJEUnZZSWs1aFduTmd2TWJITlBkZm5MdWtaelpkZnJrM3RLZEVaSXJp?=
 =?utf-8?B?SW01SXlPc0ZZVXZCNEZtWEs1cnRBa205MXFFTHRXWGo3VFJDdnM4blFDTzlZ?=
 =?utf-8?B?TDE2eHRhZ2dsTWUzNnhQaW5qOEV0WVlHOTRzQzVoanFUL1FIM2Ewc3d4Mkt5?=
 =?utf-8?B?UFdTajZ2ZTJnenAyNXQ3aGNLV0Z6RlZidHZsSm83V2ZzRHgyM1pwaDl6OFln?=
 =?utf-8?B?MGFkaENnay93WlN2TlpEMmltTTZxN1l3RVpwQTRhSjBtbUEvL0tNMWl4MUJN?=
 =?utf-8?B?TTBMRWhXZU03MXlhU2QwbGtWUmgxYTRlV0hNenM3azk1elpzeDFmSWlEVmtE?=
 =?utf-8?B?VFJRcHVWeUlvbm5yTEpsTHRiVUM1N01SYUs1ZmFzRTkxVkRPRnpUK25Mbld1?=
 =?utf-8?B?SUZ0RmNCUVVDWWM3OEFCemtleWMyRGV5bUMrVDVNV25HUDBqOWhKOWdORm9z?=
 =?utf-8?B?MDRwRDZDa3dESTVJZkV2MEV2Z3E5K2l4dVFmN1UxZThjTDNxcm52N2VLSlcz?=
 =?utf-8?B?bXdjbHF4M3ZLY3NaYzFXaXdRTk4ybFdjMktaODZsMVZmcThRaWhhZkVvbFRM?=
 =?utf-8?B?UWtoNDAwTkxNTmFRYUN5S3ZiTGVwZEx3bmcwdWNCbDlOS0tFZnN5YnliTVp2?=
 =?utf-8?B?Smk3ZzQyekNEKzczZHBtRUdiN3kxUURrd2tpS0xVeE5FS1pkQVRRb3lTQlBX?=
 =?utf-8?B?TkVvV2tSdmViUDAydnozUjZ3QWs5SGJTQkZjYnh0Y21KYzU0eFJqTkRnOXpp?=
 =?utf-8?B?UFpsc1J3cWpYUGc0M0JydFlDUnIyb2Q5U3JGZGc2LzNTNFl4V0Z6bDJlUnpu?=
 =?utf-8?Q?tv9I=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4601abf8-ab02-4401-7fc1-08de283bd19d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:50:52.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPNjsUM7hOF6EM24LffynP2lUhgH+ZIvUYb6iZRgliVGioIGVpp79/wkDOmGK2ao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4443
X-Authority-Analysis: v=2.4 cv=avK/yCZV c=1 sm=1 tr=0 ts=691f1cbf cx=c_pps
 a=pKtxidU6TXaQx3FGc3VI+g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=mV3VBRlEExYSzgC-poAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uBU6vS5fSRJOApAyMXip9t1mPUTyTG90
X-Proofpoint-GUID: uBU6vS5fSRJOApAyMXip9t1mPUTyTG90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA4OSBTYWx0ZWRfX1gzBBx/kf9ym
 7dLauiyCPqFkxvPD2yMqCIf5rwU9PIb4tlmt44fAst63uBvnEHChnqeC/6vHMHHsiVQlBOwFLHn
 UbBp+Y+I4XBNY1KFNcNm0zsogtRm7Hfxm+haoKNotZ0c5PEvGvQ4vMGK56LWw3bGSpcZ9LkAor9
 wl3Z8evlbb5DXksmdBooSfRGIapaisId8p/y2hTH8hp76gqbXZr9F287BSyW9Ri3UyN92zEMAuL
 IaUvzg1SgdoCegtp0Wm0u26nVy3tYZ6ePp3yjKXeTdSZ+FFw/q5Np1XwquqFh4ZFpJky0KVUFAP
 bAu374YmzthNjltGW02Jq6noICGbijMkAEap0M/Ts9/LszwcmbolTmWpeDp2GELr47TaphB5umU
 Eo1lzTxeBBGYebPBQNP6Ltoz9d1pZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_05,2025-11-20_01,2025-10-01_01

On 11/20/25 6:16 AM, David Laight wrote:
> On Thu, 20 Nov 2025 00:32:34 +0000 (UTC)
> bot+bpf-ci@kernel.org wrote:
> 
>>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>>> index f904739e9..6fecf2f2c 100644
>>> --- a/net/ipv6/ip6_output.c
>>> +++ b/net/ipv6/ip6_output.c
>>> @@ -1440,7 +1440,7 @@ static int __ip6_append_data(struct sock *sk,
>>>  	struct sk_buff *skb, *skb_prev = NULL;
>>>  	struct inet_cork *cork = &cork_full->base;
>>>  	struct flowi6 *fl6 = &cork_full->fl.u.ip6;
>>> -	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, pmtu;
>>> +	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu;  
>>
>> [ ... ]
>>
>>> @@ -1504,9 +1504,10 @@ static int __ip6_append_data(struct sock *sk,
>>>  		maxnonfragsize = mtu;
>>>
>>>  	if (cork->length + length > maxnonfragsize - headersize) {
>>> +		int pmtu;
>>>  emsgsize:
>>> -		pmtu = max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
>>> -		ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
>>> +		pmtu = mtu - headersize + (int)sizeof(struct ipv6hdr);
>>> +		ipv6_local_error(sk, EMSGSIZE, fl6, max(pmtu, 0));
>>>  		return -EMSGSIZE;
>>>  	}  
>>
>> Can the variable pmtu be used uninitialized here?
> 
> If your AI bot doesn't understand code don't run it.

I ran this locally three more times and this false positive didn't
reproduce, but I'll see if the CI has enough logs to figure out where it
got confused.

Regardless, I'm doing periodic checks for patterns of false positives
and fine tuning the prompts.

-chris

