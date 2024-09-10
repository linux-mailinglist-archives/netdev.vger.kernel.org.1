Return-Path: <netdev+bounces-127052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC1E973DA5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C51F28A54
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4019EEC8;
	Tue, 10 Sep 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dkyBe9J6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uWRIObpI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FFE1755C
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986965; cv=fail; b=h6yrdEVKr39BZ1BWr1IFEwvxRIEW3PCLxdT/oWgdyunLQq80tdEMbBzA1DdVNotMZri9Qp/G7yfIGarf2wgQfpCqyK7imzPSIWRVq9EaNjVXvT2L77VrQabX8SzGOYua/5DRWSLXLpjkZJT2z8gkK2R2B9d3RtHIWS7/Ghpuy9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986965; c=relaxed/simple;
	bh=kySwWzmJvFc5CFUDD+zrzXPmClxKVjqI/QsRo+/Mvaw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BgyItmWE8Ec7I2dmo2rK+E+68ZsPaJ7XrxhcoGUPV2gg0lzeEYVQcoY/XnioQDW4IjecsRQmTdRgr+t96JtwN7X4R+4euqL8xpQV/EQaHDWk27YWNXICffURxlHNdeqixhZa+4GUKAyGWcicEr+c2brLjawHtMDlVs8cM5J8Njo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dkyBe9J6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uWRIObpI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AFtVvb024023;
	Tue, 10 Sep 2024 16:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=vMpkJ+7UB6fANU6XvgA7iDjdMJJPxk8eGz81EyVO2H0=; b=
	dkyBe9J6I0A++BN2XapMR5LfvnWlBU3wnUSFHY3qZtE0VfPxL0q3IkkiUuQu/6hZ
	O3SXCx1B4HGQHcjgRTLfgMWQDCFFFLFKA3ElpoCCZYQJBDUOsK/OL59ZuRaZx0oY
	yukK5/FoDNVK4SsYufj+2fNdtKAXG5LoIbK1huqQAuBS0Pe9V44CNZQtQijRDKRs
	qLoCd+MCFN/dw0MbmjDzLV0HTeGQPt1ijfs0Bs6pGIzFz4TmkTpN9b8EKmezgz24
	7Yj+KU93dC2qSkgexc6Ds5Uo6ygOwl4p1U/Btjmy78fO0ttcYcq5pQ1TC/51XriE
	JS5+1+RBsjCj2KpZPXCgeA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbunwdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 16:49:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48AGJFZE031611;
	Tue, 10 Sep 2024 16:49:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd99b25c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 16:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQpnvdHPJ4vAo+lzMSoAKimLwsnksxam8cftvbJg8l/aWppmVk+2/50pKPIlb3pNFLus+VwB/JfhjAa5HNc2PaDmSMb/adBF96CmLhbtshgn0aXypcgiuzO9FEgRg/Lmt6YqbKvHoX0WzA8bOGbz2IjDTRSJIXlV6ZrSJ7zkqE2YFCjIRDQzftBS+WugVn2opvs+eS12qM4XKPt+XP9hIRJT8wIkZLQ30ohMxTRNnUqDEkVkq69UsSrACWoF5+24xAzwZxi+OoMyJ/jOrKBn1WwvMOsWWJuRM7f3160Klw1KX2byddTStJ02cMNfAMu0aeq3TYi71oaWjBJqi2EBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMpkJ+7UB6fANU6XvgA7iDjdMJJPxk8eGz81EyVO2H0=;
 b=jxK3ZK7nlSQy0d/Q6PByazKRt/za0SwzzI3Ur0ZbE8fjPpbnJXUBJUPkgfDy/b9tr3jUUk+jdI6HoBg2D723Axl7X3TjE+Vwpl7Y/S1mgAHqjjp4StZO09tR7RfLZrdv+KHVFOQrUJS0Zp87JHe5+LPyZlDq5Ck6hKxnPkHvtwhNlWbPUj2ODQXOxU8LZkTdpc7w75mgcn4Jwc5vdqenXvrItg5gUmigKtO7qzdJdHG2O93ZkAOAjHsSM/JMUX+DKWrN9ZTG5K9ZDEB1R482UdXcDFL5b9hSldtUj2g0JIAXQPU6Z6d4iRNfTMYoH2ZVP9sfefKxo5Pnk/MA+zHUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMpkJ+7UB6fANU6XvgA7iDjdMJJPxk8eGz81EyVO2H0=;
 b=uWRIObpI6NejSOpkEV69qo6xcea4Whzv3GF6mOWKc1NZ+nTr4E3zbVY+zziPBm+XVxw0IBz2H6eKjL+po9Pr3EGtB0/9ZAUm43OZqusX2Poy8S5+C9KuW5LW2HQKGipG0g3pxUt46oDLia9HRtr/9QWanchhRB3I3HULACJACoo=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by IA1PR10MB6687.namprd10.prod.outlook.com (2603:10b6:208:419::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Tue, 10 Sep
 2024 16:49:03 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Tue, 10 Sep 2024
 16:49:03 +0000
Message-ID: <c9cdf55a-3d06-4e91-85bb-ec7e4f4ea92c@oracle.com>
Date: Tue, 10 Sep 2024 09:49:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Remove zero length skb's when enqueuing new OOB
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kuniyu@amazon.com, netdev@vger.kernel.org
References: <20240910002854.264192-1-Rao.Shoaib@oracle.com>
 <20240910134451.GD572255@kernel.org>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <20240910134451.GD572255@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::21) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|IA1PR10MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec0c56c-5b7c-47d2-aed0-08dcd1b879f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2ZhRUlVWUdDL0RWWmVOaURXRnRoK3V6ZlZ2a1ZIck9EUnJEKytkMlJGWk9Y?=
 =?utf-8?B?cnZSR09TMkU2aEt0cFRaMnBhNk1rK0JDQ3dURjBnK21PL3QrZ1Nid2F2OS9D?=
 =?utf-8?B?WmNOcGppdWR1dWZFK3U0NDE5bHN2dnlTS2FEQzJndi9MTzB0cStTMHFub0lr?=
 =?utf-8?B?OTgzRVkxVndoQWxPZ1VsdVhsTlVKTFVEZmN6RE44VjNqU1BxSXpzTy95c3hP?=
 =?utf-8?B?b0QySTZubXlwQVJNWEV6cmd2THp4d2ZMZEVMUjIyVjZIclJrb0U4QmlEdVNs?=
 =?utf-8?B?L1pOSUdyc1RsWStsUWJMQU1NekdHYWY0akdNN0dBRWgwVXRWbC9DQVhSZDdB?=
 =?utf-8?B?VGhFZTVQZW5rZDJIQWtaSGdHU2tySm0xVExoR3ZLUnMrNmx3cDhzcTB6ckVD?=
 =?utf-8?B?Uk5nZVJBYVBLenpkVTIyc2xNaVU0UG4vUTRqSUVsZXJEcXlJdzhDOVBINEpU?=
 =?utf-8?B?QmM5dm91STFMOGtHMEZMckJnMFpBVTJQODBhT1ovaU84T3JRS3htZklHMVVk?=
 =?utf-8?B?QVN3MEkxLzRrR0tnOWsxbWVYc3h5MVlNeUJFeXR4eUNJRiszWnI4MDY3c2ZT?=
 =?utf-8?B?bnJTdU83dWs5RFRYbm96c053SkF2Y2RZVE9EaTlleVh0dnIyY0lwcHY5aWM1?=
 =?utf-8?B?R1Yzekp2cHdBcnJRemQ3N01kdnNTdTg2ZEtkMDd3YkJZcEtKSkJ2MjJic0ps?=
 =?utf-8?B?WmczRS9XVHViQU9Jd0lPTzVzTlRsTU51aFVwZEV4ZllyT0x4ajBNTVlNVVlD?=
 =?utf-8?B?VWI0RkIxeGNuei9tT013MnU4ZWRRT0FhSDZOMWU5TzN6eWJjZnpqRmFzcVp4?=
 =?utf-8?B?QXQzcnhTQTZRZXVnWjBzV1ozaVV1KzJhQ3hMTXhGTU5CeENzamZDSTR2Y09m?=
 =?utf-8?B?d0ttcDFsMVNlTFd4dEZMYmV1OCtEZkUyRktEcnBLRUc2bTR0cmpJNytGZFkr?=
 =?utf-8?B?TkF3WU1ETXkrV2paaEtsdmFHclNjR1Z1cHNJRXd0M1J5QXlhV3pvdHl1Q2Yv?=
 =?utf-8?B?bDQzdHhRZ2J1QThBdzgySUwyanhmN0MweGJMb3JRem44R3k5V1cxZkg4ZEZK?=
 =?utf-8?B?Vkp0c21wNFVJSDRoalFiZ3M2dm5Dbk1OVnRGaGsxUmVKK1E5eXNyV0VsQktt?=
 =?utf-8?B?NERMSVF2c1p4Zkk5Uk5NemV5cDFvdFkwYzAyR2dTNFE3NVVERGtzNHgzRnJq?=
 =?utf-8?B?VVZwVEpOZXZhMEY1dElIRWFCZU5JenZOcDNzRkNrcGh0cktCM21tazExNEFB?=
 =?utf-8?B?Y3crSStxODY4NWZWSmdZTUR3R1k4aHp6R1Z4WFd1aHE4b1pjQUdiTGwxMjVU?=
 =?utf-8?B?YjdtMk5wTXdNSUZWSXUvZU1Xc3NFelcxL3gvQXNmUlFsSTFVcnBvdzNoL2pn?=
 =?utf-8?B?UjNIbjJSRW1IV2V4Y3V2VjQ4dW1IS3VYM0s3SjkvK05UYS9yNGNxcEZNWmtt?=
 =?utf-8?B?TWVwQUxDOUJ2OXA0eFJXZlQ2L2d1TXhUNlVLTk1xOEtoKzJ3Zk5RM1Z6VDNX?=
 =?utf-8?B?STJLdUxRaWxpemkybW81UWZaT2NKcFppMkFWSHJDcWhQWkdPUFVBVU95U3ly?=
 =?utf-8?B?SDJvOU52b1RPTC9ieDBOWWVORllwNlMyTTBmdzdFZXY4ZUFheTBmdUNJS1RI?=
 =?utf-8?B?ZDFPU25RdVhnTmMrRDd3UE5LaGpwdjRYQVQzdEN3L3dvdXpYd21qcDd5RFZ3?=
 =?utf-8?B?eHRCcURKK3hYdW9SVGxSWDk1a1hLVGJpWkx0SEtrVlFIU3RHV2tLY1NLc21K?=
 =?utf-8?B?R05IUGxEYmZlTnNwdnArZnhWUDNsZ3dpNTAwcmRFMTZUTHBaQ1hqU0pQekhi?=
 =?utf-8?B?eit1TzRRdm91Mnk4cDBHdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0hjWjlibC9qNEZTLzROOXVPMTM3VHAvY1FJYTl6aXNweWlTVXVpNUJVYWVR?=
 =?utf-8?B?dkVWVUlvMit2TWZJOWk2cEhPTDliQ3lndXBvSTl0dUJBZTZ3OXZsKzRlR2VW?=
 =?utf-8?B?NjRBL05PMzdvZ1BqMGxaVVAzK1ljcDZsYmlXbGIzZld4ZEdDQjBQcXU5SXJi?=
 =?utf-8?B?djVGMWZRN0RZRndhYUMyNU5FQnJ0cUNQdWh4NjlsbVdEdTBTc1dHQTMzU3lk?=
 =?utf-8?B?Zy8yekNJNGJWbzF4S2xNbkZNd25Cd2d3d2VRQmF6T3AwalUyTHRxMVJ5TVFU?=
 =?utf-8?B?bzZzY2oxaEU5bXBIT2c0N3ZZR0RwaFQwQ2ZoQ1FsMEFCcUhTN0Q1SktTem5m?=
 =?utf-8?B?YVFRUFVOc2NsSnB3bk5jK1Jub0FYaGhWaEYwQ3I0eER4T3hzdHN2dFJIZlNw?=
 =?utf-8?B?bkVEL0I0NUFtQVpQUmlQZm5RZzZ6eWlFNTRsZ3dsaWJ2V1ZKZUhPS1ZOWmcx?=
 =?utf-8?B?OFU4VkV1WHZFbk9XTHYzTW1EaTVsd1pGYzRpeDF3TVZpRTFBdzl4SWxTVGFO?=
 =?utf-8?B?N0hwZ0tyZHVLeENLM0YwNWNJUWsyQkswSy9PWEpyMDNZaXBJcHo4WmdhZWdQ?=
 =?utf-8?B?d0xXQUR1WFhjOGhDaEwvWTZJTmNleWdPSDA0NVZGbjRFa3d0VUgyWFBmMFRj?=
 =?utf-8?B?RGZnWEtvVHh0VEpnRDB1TXJvUm91OWtQbFpuWjVVUDAxUklMM0xOOGczYUhL?=
 =?utf-8?B?bEpndll6eTk5NWVWdnpaTUFzRCtGUlRsVzBxSTNETlhEc2gwcTBSL0R4Mndw?=
 =?utf-8?B?Z1dkc3RhODdYOFg1b2hHdFRoVnRuUG91OTlnTXRTUm9JSXBBYUhQaDdVT04x?=
 =?utf-8?B?b2VEcTNvTHJGMndrTWZCMGpyeGJPQnp0Z0Qrcko2VlJpZUIwWUNsSnlXcDgz?=
 =?utf-8?B?WnBQa1g5UkpOUmh5NHhyakt4WFVqTzU3UXEvcXMvMjJjVTh5QVNYSlpTRk5s?=
 =?utf-8?B?TllBT1A4ek9UL1BGc2dib0VSSlE0VHY4d1pqSW1QenQ5VWVIeHdiZDJSbG5a?=
 =?utf-8?B?dHo3Y0hkemltL1ZSQlVnUmZiUm9kOFJvQWN5S3VIOXVMTmFCVXkxeDBqcXpD?=
 =?utf-8?B?enV5VjdFdzVIMzFMcWZPL0RveFkwMWRRTlUxQzlwY1RST0JnYmlEM1hRWGJ1?=
 =?utf-8?B?NW5pTWJaN0p5RXRtWUQxWm9FbWd6NXRnVlpFVVZyWldsWExLai9JZklaeGNj?=
 =?utf-8?B?RkFDN0w1K2k1QytGRUkva3pOWXVzTW9Kcmg2d280TnQ3eGtraWo2QVdkVUJV?=
 =?utf-8?B?cEdyMThMU1JVRS8xR29LS0QrV2N6d216V2wxd0RCK0RES09OYlFMbVl0QXNO?=
 =?utf-8?B?L2loTkJtODVWU2tFWFl4S2ZyMDVUb0RBUG1MMkxnbHB6dnVwZGtnaHRNQmRO?=
 =?utf-8?B?RzdaUEw5UWg5b2MzTVNHQ2luWmVhTTl3OXdMSTMrOG9LVy85cFhTMkhpZjlK?=
 =?utf-8?B?ckszRGFPcVBkTlhNN2E0WS9NYUl5VFFyNmNxVG5EQURnUHNZZGpSaG5MWTQ5?=
 =?utf-8?B?NGkvd0VWU1VqS3JPVDVTNnJmampqQjFITlJCdkZKZ2RWY05QRUVKc1duWTM4?=
 =?utf-8?B?V3JpckVxUWUxZ0w0TUdHZmdwekZuNDh5ZmxESFhRMC9ZKzJuZWo2bHNlcE9F?=
 =?utf-8?B?bGU0Tk9CZm5CbGVET3NmcVJhSHdNYjJkRnNaTE9wSy9Udm9MT0haVmxhcEh1?=
 =?utf-8?B?SWNleG1ScUZIN2N3UnNiL1U4Z1drNmtJd3UrSlkyWGZFWWFUNlNsOHdhSmpa?=
 =?utf-8?B?TGJaclJoSy9lVlBjdE94VnF3VnQycytpRVphOURGYkZKdHJrVzRyTUlFU2J6?=
 =?utf-8?B?MlBUMzRkVmdGOGhkeUpHY21rd0hnQSt2UlVGRFFRQzVrMnQrN0djVHMzOTBH?=
 =?utf-8?B?NFNLNVgrK2cvNlp2YU1zOUVnSExzK3VaZnRCcTZqYmpkQndYQjlkWG1Uc1NJ?=
 =?utf-8?B?Q2RDOVJwMDlTY2s4Y3oxUEU5TVp1STJ1WndVMzA5VWQ3YmZGaEoxV3NUeG5W?=
 =?utf-8?B?aGhTMWErbjd3RlYwdlpRQlA4bWlCNnlKK0M5Y0ZscVdYRTdic2NZaVZIQVNK?=
 =?utf-8?B?ZUMzTzdlTWZLNVFjdEhoWDZXS21USlo2ZStLV2RLcCtiN2JNSnhxOWlCeS9r?=
 =?utf-8?Q?n5p5cLXf2qGzcD3Atb6ps5syE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G7o0LpvFQtFA1G9XanUSL6zy5uj4ppuFXfUkyKyyU25AJjXSF4nj4ci/Nh32E67nTC2zEFTfEbUl+8lfRztZEtFUuB8WIvyFTzgicm9KK2936FHJM0Bc6TU3Iv55GvQ8DTbxq8ZzoJfF7IjkC7DElXmb8PyV/Liaj2Ttb1H+6zjKb7IzkWUbaNq+zMyfhBTy25RTQNZRSj+SBKPCgIqp5QxRzzhui6fVbR9873fVVn1Mqrh/FZEr0Wv8Ziwvc+hCydD8vlkQKBcobkj5g4+bTCbocLauw3LhewMj6WIvSEU5IlRfyB0Q1CHy9jxQPRFpP+pw3KnvsVa88IKYNyP7eRHptqg03jQU9mg8dcj+SxjJiEyUYuMpLwZzkijiD5/J5p5F7jJCiFPbL9152FPo5KJXiUYKgpAYpgCq10odDahM5XWCPP5uHk5/bLuFUoPK3xAs4zRGN/2CAlueyf9vcwjLj1+lCnpOwGG65Qs9R4WyqWVE70ZamLkTdVJEyod44o1oUAEdvfewE9q5IbC1dgFHzpjnBD3eCN0EprOhWpKIcpmC5CMFU5QYNisKffcOiBMQ0G8HhjkMTy8IExbBqhKvEgoE6hoKOwA64bKWi4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec0c56c-5b7c-47d2-aed0-08dcd1b879f6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 16:49:03.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOeOWL9f4tqkLEBZC++LBmkwQZvt79ls8XH92UHoRxjicWSXPt0guhTSVTLRlWmH6kO51JxDkgIaDfpMAUZEhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_05,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409100125
X-Proofpoint-GUID: Ypvi4W_g-uLlsUXQsi8J-hzgm5GO_W6U
X-Proofpoint-ORIG-GUID: Ypvi4W_g-uLlsUXQsi8J-hzgm5GO_W6U



On 9/10/2024 6:44 AM, Simon Horman wrote:
> On Mon, Sep 09, 2024 at 05:28:54PM -0700, Rao Shoaib wrote:
>> 13:03 Recent tests show that AF_UNIX socket code does not handle
>> the following sequence properly
>>
>> Send OOB
>> Read OOB
>> Send OOB
>> Read (Without OOB flag)
>>
>> The last read returns the OOB byte, which is incorrect.
>> A following read with OOB flag returns EFAULT, which is also incorrect.
>>
>> In AF_UNIX, OOB byte is stored in a single skb, a pointer to the
>> skb is stored in the linux socket (oob_skb) and the skb is linked
>> in the socket's receive queue. Obviously, there are two refcnts on
>> the skb.
>>
>> If the byte is read as an OOB, there will be no remaining data and
>> regular read frees the skb in managge_oob() and moves to the next skb.
>> The bug was that the next skb could be an OOB byte, but the code did
>> not check that which resulted in a regular read, receiving the OOB byte.
>>
>> This patch adds code check the next skb obtained when a zero
>> length skb is freed.
>>
>> The patch also adds code to check and remove an skb in front
>> of about to be added OOB if it is a zero length skb.
>>
>> The cause of the last EFAULT was that the OOB byte had already been read
>> by the regular read but oob_skb was not cleared. This resulted in
>> __skb_datagram_iter() receiving a zero length skb to copy a byte from.
>> So EFAULT was returned.
>>
>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> 
> Hi Rao,
> 
> This is not a proper review, I will leave that to Iwashima-san and others.
> 
> But I would like to note that as a fix for net it needs to be annotated as
> such.
> 
> 	Subject: [PATCH net v1] ...
> 
> Unfortunately while the patch applies to net it does not apply to net-next.
> But without the above annotation the CI did not know to apply the patch to
> net. So the CI can't process this patch.
> 
> I suggest posting a v2, targeted at net, after waiting for a review from
> Iwashima-san and others.
> 

Thanks for pointing out. It may not be necessary for me to post a v2 as 
another fix has been accepted but let's see.

Shoaib

