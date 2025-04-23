Return-Path: <netdev+bounces-185247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B1A997D8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4833B7061
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E89728CF7F;
	Wed, 23 Apr 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="PKAKN3DT"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021078.outbound.protection.outlook.com [40.93.194.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD71263F54;
	Wed, 23 Apr 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432769; cv=fail; b=q6sC07ZlzdEbMAjD3KxkHJNJyrsL1YSfSWVqJ8cxOqQj72RQxwlwc6aMKWQzBwsVPMmJoQNne0galke97K4NZbFZTXx28AhBv1kE9Hkn4sOZ1gJknvEEXxmGGjWhmM/h1Ytqf5bl8g/eZqRQmfpRkY9Se1QNQOs8UCxQj9kguEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432769; c=relaxed/simple;
	bh=MYy8Uu3Rvi9FL8HgU34IBlS5G71CezaQN6kSMKWUeLk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KBsiP/G1TJIPkcaHDMDBPMXK11w4HqyDcq/9D2wx1nR6Kn0BhBUfpbc0hnLVz8lT+lQDnBe+A4lLaZaHuWPHyLbxmaSyH7lTyffDpD3TsYHM65YCIO9zTbmpG8wp0Z7p2g0V05cF9VH9IpIRqqkPWtXtz95w8Pf/th5eb9N9r68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=PKAKN3DT reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.194.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPBjJtoWHr826BH+fIgFB8P5psfS7VjI0bHbu83spiI7oKEywrCvJIaf5ejGwcvnGKX1RtAY+R/jZ6twKRZvSzjrIQXUKU6V+FRHNC9vbJvhjXaETy1Pz88BG2jHExV+ngJcaodCU/ivjcYyxDavwOYfHTvcrpYO4sFYx4ioU5xVotyqF5IJbFHZQsHXur6efvH1jsINMn8IJgteY0FRhhhHL7yv59tWhZWremKYy+JrvmuzvXqJPZ2NNxQK+QrVSuEamkFhpjaZ58aLrbfEge8Ew1QydscDK2U4VSHmapaZfa/dku+l/kw27o+YffpDvFuQAhpC0ldL4lun2oFF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cav5FalcQ8Bg4/S7XMQ62vanvufq7dIcyPJkvcjAd80=;
 b=sI8uMCC/dETwsD4pevUfaoRh43YnUbupS3tNrHa9JfQgmsArXql3WVutayHvpTuHj3Jbn+MSW4R2ofsbh6eN+H1oFfOQpUHa5bZBECwOKsl2ghGhciZzymuN10tYjBUxemFTWpXDUi1KHbHNdZYJTSegCHYfOyrWnstaIFLMYn+sFUctBTYh+XrDb4Zoqxbe5A04c5+uDBtKS66QIwmTioYVoLB7Vkp3SmoGB1FmYrN6rYx6ZiSb+VBWhUecrvcwJN47m+GPJmwC5FR8qmUQWEBPliZQ1HG8zM7ZDstszaQuHGIsH6tgVL95GYYQz/wyamRIqLd0dHplp1fCvyJGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cav5FalcQ8Bg4/S7XMQ62vanvufq7dIcyPJkvcjAd80=;
 b=PKAKN3DTOm478r4WXl3cWd8EmOjL1o5DzMjPg20BwRymZgdCZJmxAHsVypsnAu00gKdJvPbjOS4bLxOp7OHfYYs+ycUkL4ZzfyLlDPy5Ne+TYrQA04l6ER3DL3oz+2T/HcvNiP9H0mceE/PkmEQiAhs4QxxUkBAMHT01UZ80F1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH3PR01MB8715.prod.exchangelabs.com (2603:10b6:610:20c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.36; Wed, 23 Apr 2025 18:26:02 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 18:26:02 +0000
Message-ID: <b254a359-0ca8-463b-b666-e34ba357bd09@amperemail.onmicrosoft.com>
Date: Wed, 23 Apr 2025 14:25:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
 <20250418221438.368203-5-admiyo@os.amperecomputing.com>
 <7b5ed6452d077e65005010c81eaeb3124d1e9feb.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <7b5ed6452d077e65005010c81eaeb3124d1e9feb.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH3PR01MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb3fa5a-771b-4347-b8b0-08dd82944d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk5rT1NSbHlWR2xXQlVMdXJ3ZUg4NDBRTWgwNHRYWWVVblFvZmxyKy9BUE1l?=
 =?utf-8?B?ZENwaDBXeXk0NUtKVzdpdzUzbCtjbXhIWmVDeTJZRDEwOGV3QnE3cGlwdU91?=
 =?utf-8?B?QTlaMTlRMThxQTc5RXBvaDArb09hY2lDMHZJMlhZa3dJV1lxNzFQL2tFUlI4?=
 =?utf-8?B?WWRQUWo2aGMxbC9aN3RkUU5JclBUVzJOWDlzRWZ2MDJFK2pmRS80YS9JeWgv?=
 =?utf-8?B?NU5WQ2VxazVidkdJdjNpcDJlWGhJU0htNGJ2aUFhRGVLRkZBV1BBbk5wQS9P?=
 =?utf-8?B?RVhWazBFZVNrQzQyNEl6YytBR28zcFdLV0R2SlkxRE5LNEV0eThaMWRWeURS?=
 =?utf-8?B?aE5KamFVZEJpK2M1L2VzbTc1MkErUDlQa1ExRnNIdXlvbXJCbFZjZVFjcEZo?=
 =?utf-8?B?eGR5Y1cwcnFzWG5TbGF3UmVTblZxTU03ajI0dW9QbDBvTDhTVmNzNTV4WkYr?=
 =?utf-8?B?WU9VUlNBQ3dzbDhlcWhGVmdBdFpDaFBtM3hSd3duTzJQcXdiZ2cxOEtMYlZQ?=
 =?utf-8?B?QnJVZFNNdXFDbHJJVlJ5NHlGUVhUVjdMKzk4b0xMa01uaVdSekxFVnUxcGlP?=
 =?utf-8?B?bk1aTzlPdkh6QVZwTEJEREszTkZmM0NLa3k3SWZkK3BYV2IrWlFSblFYQUhq?=
 =?utf-8?B?Zjk5NG0xQ253RUtFNmUzai9aU01HLzk0T3dBNFRmM0o1SkRwTEhuNThZTHgv?=
 =?utf-8?B?ekw2MGdYTjhZcEh6SDlFdEgzRUdhTjNhblhvNFJUMGxaQkV6UEw5YWNuSUhC?=
 =?utf-8?B?dHdORFJOeE8yV0d5bjBwL1dYcVFpc29YR1c2OHNHRG50WUV2WDJUZFpkSmdC?=
 =?utf-8?B?K3hkYTg1TzQzODBZSFRjaEtUWnVPSnp6K0ptNm9vZ2d2ZlNlUjl2TG5keWFo?=
 =?utf-8?B?blVwMU8vN0F3NlQ1Y0VLNjB2My9pYVFRcENkZnFNZHNESmVrdUhWdUU0OXF5?=
 =?utf-8?B?RG92bXh1ak05NmlJVmNxczlwTkdyTDRKSXBhMW5nVit3VXpwbm5JRzdEc3dp?=
 =?utf-8?B?cXlEbHcwRUVZaWNFWEk2c3NsWit2Qjg3QzN2UFA2MWlWOUJMNXp0QUlpM1NK?=
 =?utf-8?B?OGpzajROR1ZuZmV1RndpV2szaGNZa3pIbkVHMUVSc3gzdE9EZytvYWtHcytY?=
 =?utf-8?B?YU5tZDJlRjF1NEVqZ1BlbDVURXFZdElvL0hvY0dFdno0MDFBYXNvSXRTRHVJ?=
 =?utf-8?B?T0c2L2tMSTRCRll6TEVsYmFKeUM3YTNtQlVGV05qdmhlQVZFbnJ3OFlNTGRr?=
 =?utf-8?B?b0pFemk1TTR6VGZnMTIvY2REOWVEWWNHRm1Bc0VPU0w1MDBRTndvLzhpcERN?=
 =?utf-8?B?NHpBRXkrVWdNa2ZVbEdNbFhDUk95ak4vZ3ZFSitWVEFabWFGTFlmS2tnYmkw?=
 =?utf-8?B?VG1UVkRZaTRYZEsweEIyMHQ1T2hqOCs0bmV0aHV4K1Rva004UHdudXZaOEI1?=
 =?utf-8?B?SW02V3N3elJHSGNNcVdONjYydjFCdThKc0tCamF0UVp1K1BmYWhTOWRaVGZ3?=
 =?utf-8?B?cDlUQ09MSVZldFFJWkJiaTdkRG04VHlVWUxpakhzcW1rL2ZENFVZaVZpVUlL?=
 =?utf-8?B?OFkxTWViQ2pLYWZBRTdxZzR0NGNLVkthelVyWlVIdGM1QmhHNlhBRHE5RW1k?=
 =?utf-8?B?K3FwUWFNUTRSZW1obHpsVUI0M2xycVRmZWlFWHdhSjR2ZW9yak5EaC9zZGIy?=
 =?utf-8?B?aVlJbUR3ekVaRjNNZURNTVdzM002ZHB1N0tZL0pjUlFQS1lSNll2K0NGdVZC?=
 =?utf-8?B?SjVKcjZ3OGEvT2t3Z09xSWdVRk1GVmVHWXZqNyt6aWpKSnhEckloTVJQWThS?=
 =?utf-8?B?dUFSL0RMZVdtNnJmMFZKSHdSY3NLNU5nNlE2S3duS1pHZ0gxZlNyQjBXcmVx?=
 =?utf-8?B?RzI5dkhMOExwVEx2WWJBOGtKUzJ0emVXUStLSHFyY1ZoYUZubGFvWTd5V0k3?=
 =?utf-8?Q?kJSD0ZioznI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1R5MXNsT2dHek1NcGFyZTlaUU1NWDNlMWVvdjZiNk9vOE9heEpFeDA5M1ZJ?=
 =?utf-8?B?eVpVVmdyVmdnb25wdU1oRmRnK1V0a01XQVdiWlRsaHFPN3NkNURNUnZmZVVx?=
 =?utf-8?B?MmxoK1UyamN3OUZLbjJkd25PN2hjcWVFeXYySmR1aXc1b2F0UmhKR2g3VnVG?=
 =?utf-8?B?MDRiTGhFdXUzUThvS09hSi9VcVZFN2FFSGdlZVhWUitTN1N1QmVpOWJ0MUxB?=
 =?utf-8?B?VWtaV1RJVlJvT3dWNU42WVJMWkc1aVFGQnZEZjgzK0gxZVpRWHNJbU44dk5n?=
 =?utf-8?B?blZ0T29VQUtubUR3S2xSUXlLSU00eEUzVXV2cHJVUEtod0sybE5rUzBLYVpq?=
 =?utf-8?B?V0p2QzFpVk9ZajdOUVh4eFJ4anRVb3F1Z0NMd0R3V1lEWjB3bUpOYUhpOUN1?=
 =?utf-8?B?aVJSVk1OSVJXYzROZ1FnN2UvNWxxYm5wa2Y2SEh2eFhORnJRRUc5YVhiMEFu?=
 =?utf-8?B?Mzk2N3hmUjFsemNrMTM2SmFOWklySmFyT1lHaWE0a0tWUGJsL29uMmNyNS80?=
 =?utf-8?B?d0t6cFhSQ3p2UlN6SVpDS0h4U3Z3Y3YzdXhlTUIvd1VBak0zaFFUZzBiNEtM?=
 =?utf-8?B?aFZqNHZQT2dscldCWk13M2szdGl6MW9hSjZkd0hReHFZNjE3RDIrOGo2U2lX?=
 =?utf-8?B?VENmZytyWVdEOUtPODZiQnFLNDZvb0xtQjZnQkNZRWRvbkN6ZDlBcThPbVhZ?=
 =?utf-8?B?WDFhV3B2RmVtVkpheHhROEtVaTFoZDlhd2ppd3VCOGJQdm9tMG9OdGN3RGNr?=
 =?utf-8?B?ZTFsazlLazJuNE80ZmRtTHZkNXBmN0s4eGp2L0g5c28wamw4dmxlS3pvUlND?=
 =?utf-8?B?OTJBczVoYVFRYzBzbE03NkF6Rk0rdE9TaHM0UG0zWXRHeEs5SlFEN1RlL3cz?=
 =?utf-8?B?SkUzdWJJV0dpNzNDMmVydTRHVzE0ZGIvazg1ZUpRQ3BTOXJBbFplb2FOV3Vr?=
 =?utf-8?B?emZDK0pCaC9VK2wybzFYYytBaWhhSlNUSEF1YktOcDhtZGVOZ1BiVmtjTWJQ?=
 =?utf-8?B?OEdwV1ZoeEMxUVJXandSdjRyQktIejdoSmRpc0NCVDVuTGJ6Nmh2MG8zbHV2?=
 =?utf-8?B?S2hzenpxT2RtcjJuWFBHaS9maERUMVhKU2kvRFJzaVdoM25hQWhWditJMkpX?=
 =?utf-8?B?cHJudDNLYlBDRDJxZFdKUWNJM1RXb2FuQlJHZjR6cmZrSDc4VnNWRnJJSW9z?=
 =?utf-8?B?OTFWK0p2SFExTXhHWXdTUHJzdmpiU0FmVXZmTmtZOGFVcGJrRVJ1RWZRRUdt?=
 =?utf-8?B?Y2o5bk1UeHVFang5Ty9WOVg4d2RPVTJOclI5d0Y5VTVVU1dJSWZRWitBeUdk?=
 =?utf-8?B?a3ZSaWpGRUIvQ1FLK2lNZTVzTTNCOEM5dnA2ZjZBNkNKVVNsTGNtVW1RK2FM?=
 =?utf-8?B?ZVFCQXorRjRDSHRvTmFyNDczSkRRcDRJVVpOTUdNVkUxQlM0bG96MXpIN240?=
 =?utf-8?B?eGt1akNuMjU3dXdLckFSRTRqTGhzQTg0T1U1QkdWSXUvNE5kQjh2WHZOeG5T?=
 =?utf-8?B?clMyRUlidzlEVlV3QlV1KzBxVDFyUGM5ZU1BcVR5bkhGNHp4OXVJRWdid0I2?=
 =?utf-8?B?eFdBY1lTWHFkWHhOdEs3Y21ZSEhXd3ZUVkNuMGtJek5lREtPdkg0c09hU0lM?=
 =?utf-8?B?R1J3VTdhY2puNXZKeFRxZnpDRnExUGFhZ2hVQ3R5REEyV0xpYWJKelRhOHdu?=
 =?utf-8?B?QzZtdE9LNnBaL1RnTXE3ZTF3NWFKUjR3SEVBalpReUV2a3J6WCtCM3ZNcjFp?=
 =?utf-8?B?WFpQT2xCZ0JwNmkvT3E4V3N0d1dMdklKaHBtS1lGbFdzam44ZWxQZnJaRVNJ?=
 =?utf-8?B?djlXdHFDTUZFTmRoSkZTYjhHWjI2TW84MmlvRWc2aHA3aFJ0MFhNbE12NFNy?=
 =?utf-8?B?OXZUMkVsOHI1aVJRRDQ5NWlOR1ZOUkdJZFpLTHFJQllDSXh0UVJqTXU2ejQx?=
 =?utf-8?B?UjNrWEJ5NVNMUEg5enVRYjFzZ3ZXMCtGb1pKRkt0NFJvYmprd2p1Wm44czBF?=
 =?utf-8?B?Y1drQk5XZVhVWHZpUEtkWjVkL1VoczR0RFdIbEtraU5rVi82S1puZlZCVkVX?=
 =?utf-8?B?d0dnQ1VZWUN3a0VMNVlzV0hXZUlUNHpuMG1ZSlZJWjBXdWdmOW9PL3RxY2VF?=
 =?utf-8?B?OEY5dzVyUVVvRmdGYWdoT1JBTHZiUmZNWitXS3BwNjBPc3VIRWlLVG9DZzBQ?=
 =?utf-8?B?NnZSaUlXeWFUelN0cENPcXJqNkIrSnpEendBeW1oMktzSjNxczdkNGJ2V2V1?=
 =?utf-8?Q?5jrB5xvmAv8mMpDixJl00sY0fB8ybB1MldigCNwl5Y=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb3fa5a-771b-4347-b8b0-08dd82944d85
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 18:26:02.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdxQYA7pCDaarnKu/1B+QrAkPxfnbhq7AnwGdNrYPrbLgIXoPSKD7Qvj+cKaKQ4da6U8DyZFEGRx0Mlxe1/ZiVS6XtvZjGy/RC6vTpnNVgRaAs3mP8RHDPtnsXC7MLVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8715


On 4/22/25 10:15, Jeremy Kerr wrote:
> > +       spin_lock_irqsave(&mpnd->lock, flags);
> > +       rc = skb_cow_head(skb, sizeof(struct mctp_pcc_hdr));
> > +       if (rc)
> > +               return rc;
> This will return with mpdn->lock still held.
> And should this return the raw rc value? Or NETDEV_TX_OK?

I based my code off the other drivers in the same directory:

         rc = skb_cow_head(skb, sizeof(struct mctp_i2c_hdr));
         if (rc)
                 return rc;


         rc = skb_cow_head(skb, sizeof(struct mctp_i3c_internal_hdr));
         if (rc)
                 return rc;

However, I just noticed the USB one, that went in last release, does 
this (using a goto)

err_drop:
         dev_dstats_tx_dropped(dev);
         kfree_skb(skb);
         return NETDEV_TX_OK;

Seems strange to returning NETDEV_TX_OK for what is essentially a memory 
allocation failure?  However, I am going to assume that this most recent 
one represents the current wisdom, and will follow suit.










