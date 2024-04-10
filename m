Return-Path: <netdev+bounces-86340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E108F89E6A0
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FA7B21A6A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2079E182;
	Wed, 10 Apr 2024 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TFB/DU9R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AJBP86TZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312F6623
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707782; cv=fail; b=emRr9164CPnYTWZigQLm1LhQ64MtjmWYb4LfdAQBpwjgIzb0PLs6HAJQWRH31q6gW/cgyxFZHc+UOUUS+2nvXsGRX/tOygnKmMmNOJIMz/B2qn70SZ7/HIJwcO/R8KWrDAxTG4mlm7AkOQdIHoIhjOL096K5M6f7aD+RJ4fmPTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707782; c=relaxed/simple;
	bh=1HNL3joP6wEJGRnY3hQlMjFMqjkmc/UDdVDKQAzARl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lGP1dayzAnqEPcLD24/3zVEVdcmtjNYz3rb6LmP5Axaw99kv1lOQEqm0IqL3X3fgM6GQM+tiTvCGWHR82D0A5K7zqK9vEjrbO5Y0TOsi2UU5LLPKJvSII+9Hr7fTouSZ90JWVMAFkBo+aJv6hIsHr6L0Zd/a+d0EcvWZyhzSI5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TFB/DU9R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AJBP86TZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439NhY8i002495;
	Wed, 10 Apr 2024 00:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=03NnOM+7QtXoOf7mIESQxvPoP9GOXB99X+eahyGgCFs=;
 b=TFB/DU9RYJcjVu1mlDAo7GnP7fj+VQI9B/r9gfhsDsueGiwACArKqcQoSvligoq8rfRV
 Xp5YvbE6BLCEtViVqv9oH392wpsv/khEbhfqh/1yb4oQrMFvtmHHgtEkDFgyOuH779nq
 DyyrnsBeiiioblfb5rSdDry7hXE0dD6gpGVGCdQ6Iufw1antEvkIAC1BK1EpZ6xV82pm
 icAAHPx9rPx7JuO/94bRRiFnraoWh1c8jBKIp7furYriQMtU6NIdxFMFWvFvzlAQvGkh
 I1VrMY9RPW+usFwxmRRH1qngOlkMzmpjQJBKtmAOjAFr/CSA2RE9K9EDkEs8YFsGafHW 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxve6xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 00:09:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439NegIb032429;
	Wed, 10 Apr 2024 00:09:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu7wfxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 00:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxd0C09o30jW/IrT34Ci+t6VL0wTrs405sgf8hLhoLCAsHEbXkskF52RF6aXbuzz210HooETgq8++Cm+omaUYDCENmsoMZJsxziBAZU/rUfbu/ZIFOFVocTDgo8p8Aku2V1oXy4MGwzVCg45nb4grB2SAqP5TkHkfsOPXcaXPyiWpRTV2/wjjGyMPeYtkt4sy1S5tfiCTOHEyXcOIZqz9MooLrTsIIwcsqWxKX2yyUScPg+BAAVjNkkki38YsUnL93USxFLieL3F2xvVWHya6q3y96ncafdQ9l4O0j0MBtU4kDGZu05F6VUmwVoyU40hQ1TtQtVXeJWsVHk6XTQQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03NnOM+7QtXoOf7mIESQxvPoP9GOXB99X+eahyGgCFs=;
 b=EXEDcHcZ/TGG2cdj5BjSeZUW6ABynJo+5SzWBiL9pTe+IXZYcWBol28ewrNQMn53GiHH6HvDFRg4QE5JZ7mPuSJMaKLG2lqvBGp4kqBkRC26pQfSXY0zR6IJHzzsV5NsmLMURLC8BgxQI17l9CAA/rtVHjUvAHDtPyTEj6ZdOkIRXTPVhbK8HYim7tZhBHQKTiCxS2yFMjdTgb3YT3FqbMkgS9Dxa5qkx5jHoId2/SoS5Q+41rwisfCTzlOX5h9OsMsI7Y7p3Yj6RJUQPQSjWS6G9fNolVYY5PYiaONOPwA6QvOJMfGg3KrRxMgcp/2Ri5H1v0oI8FaTmMOCTnKtUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03NnOM+7QtXoOf7mIESQxvPoP9GOXB99X+eahyGgCFs=;
 b=AJBP86TZmG98cdJDcq8ULdKUxs2Iy62u0hA9GIlI7sWDnyvCUEaGOt0tWfI69I/mfx+dX3/l2c+y3EXGU6WKwBsIdluBkRMpvTlZ0ZWzXcWjpm0D3ERZhAkopuy5vWcOFuCCTyzWUjJWPbfNwroPxqD/C8Byc2vowxqTi5xzCO0=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CY8PR10MB6756.namprd10.prod.outlook.com (2603:10b6:930:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 00:09:27 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::40af:fb74:10b1:1300]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::40af:fb74:10b1:1300%5]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 00:09:27 +0000
Message-ID: <bef45d8e-35b7-42e4-bf6c-768da5b6d8f2@oracle.com>
Date: Tue, 9 Apr 2024 17:09:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 3/3] af_unix: Prepare MSG_OOB deprecation.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20240409225209.58102-1-kuniyu@amazon.com>
 <20240409225209.58102-4-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240409225209.58102-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::20) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CY8PR10MB6756:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2gihOXIzhjv8oJ5KCkl/zz0iA0XSObaoj++GnCqt59oKVPta5OXK+12XlAPw0LK1lqIpI9GVBpgIpRomVrBYYd/2R6IpFoBnm+yvfrdPXruef46KZrpF7M0t0U2G3JxrPj4LKyGnD4i87hynnTB65caAUmcY1ItnBrZrxCaMwxedTek3BjJxj5w3VAAL167hG5ywpq0iXsjV4N5NS2hwLuK43cB+i8sG4A5VfKVeVHbUy6WNMXPXYE37c0LqLW9aatSq9dNmkmfhS7ccvsvb1tAJheYTMNacTdspuPoMH8YGNPyLJg1LHe4HrbP7U+icuT18TyA9chgYMd41DB/h8pg6cUT3d93vlWqDXsOknd3vdb2xh1pncqFL/HbDQV0zE/bhT3kvEfBIfB0yRlwgeGomXx+BPBna6QcBWajlouAPFbciIkktPP7qJV5u2yFJiD75gF2ovTXHrDviA0m0MJ8966fcJzdzbPu2kP7LFuvhkGFaPmlFpOlpEiiM/0ksqxitQEJAJMeJCLGzLcnaNwYD7oLb2rw6q1YM7+ye5VccLvdS/g/C3gLkrL4ILuSO3IsclOfvUgrqo15w0z7ucMPKvPELlcSwd7ubV7UIZaz1f4XKl6/wmHXwHyFolUkWIhk5uEGsUd52t9ol3FF8rBuHOoZibz2iHvKzafOihlA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RS85eFJ1R1YxbEFJTFh0NDRqeGVjV1lvQWRsWDFtbENnaXRJVFJFVEFMdCtJ?=
 =?utf-8?B?TC9HTGREdjhYTXNrUTJUU3RwU3VEbG8zZE5JVTVoVGFDMysrZ1ZaZ3V6Rndt?=
 =?utf-8?B?WjRYaFdaSEcwRzFHaGFyeWdmTjVmbDEweHc2czRNNzRMalNnUWdkTURDVkFw?=
 =?utf-8?B?SzBIYVMwMnFJOWsvNy9EL01XekFuRTlsVTVVVWhmMmoraFZVUEJFL0VZc3Bo?=
 =?utf-8?B?aXFVb1UvdFYzalZDMi9qWHpiN09xWFc0QTF3RU5IU0UxVnpLNjcveStwcnow?=
 =?utf-8?B?Ny90NThqLzN1UGJzdlZjTzhiajVqald0Q09nVFRhdkZKSEE3bXNUWDRpLzJK?=
 =?utf-8?B?dW11ckNsOTdFM0I5bUJxZDB2bnRlKzBxMFliMlpnenNqOVl4UUJqQmswQ3Zr?=
 =?utf-8?B?RDIvM1VSM3FiMTBHeDV5cEhxTlR1aHk1OHVVWVJFdDlVWERJdzkrM056cysr?=
 =?utf-8?B?cjFUVlQ1WjZyMkRNRjFxQmx0VEpRK3UrclNTNXU3TzI2MjFGSGZUVWVackcv?=
 =?utf-8?B?UXUra2MzTGoyaVVtZWIzTzhueDBFeFNrcWJ0Y1NLcWt3VnE5eUJWQWhPTXRK?=
 =?utf-8?B?ZExLUlRjMnlQMVhmQVVVdmpOaXR3aEhnMGFpVE1Sa1R1cllwTm5CRW4xOWt3?=
 =?utf-8?B?ZUs0cHJoKzdjZmVzdm5HdFZBKzFKMm4rRkd5LzJTSWhlQUFWNi8raG5IbmZF?=
 =?utf-8?B?Smx0Vkl6MlpndWwva2c4cDVISy90L29xUmZBaFVXeDBYRUZydzNONHRTMkNJ?=
 =?utf-8?B?SXpBTXo3b01rOW1Ienlwd0N1OGtzSGI3R0tkdzFpVUg5cjlEZHBUeHJlMlRP?=
 =?utf-8?B?MnNQOXZqVmNwUWlINEJDWkRRdmsrb1Y4N0N5ZFU0MWFxSi9wV2U1RVU4NUo4?=
 =?utf-8?B?bEJPV3hyVmp5V2kwSGZpRWszczdvdFFQZzcxYjAyd1pOYWNkZ1JwRVJxbXRp?=
 =?utf-8?B?eklQcHZnSXJlZ24yd0p6WkM5V0lQYk03SDBDTmdPZG5PZGVjWEJlY01MNHFU?=
 =?utf-8?B?dzh2YXRrRFJCRW56U0ZmQ1RWcjZ4WnM5dmpKSGJlY0JiSjA0VTFwKzFERlYz?=
 =?utf-8?B?YnlFOFlnUXVqSUJnUklhaElBZ1JORGl1MHpNbE1pdWloLzdtKytSVUhnazlp?=
 =?utf-8?B?VGZhRmR1RkNwOWd6MUJ2WXlKWmcyeENUeDhMdnBPbElWeVFhZDhHSXFnQk9p?=
 =?utf-8?B?MGJWekoxOWprOWVCUTV4YjhJRXg5MGJaRjZHaVNFVWdjR1dvN2xPZ2VrbW50?=
 =?utf-8?B?VXFnK3pXWTVTSmtPUmFBaTUyN1ZBOU1SNll5UTBWVXRlTXgxZ0tOZUpocWZQ?=
 =?utf-8?B?WVF1cW0zV1JjdmVLakpFMjg0Y3JaWHUrWUxSb0NTaTI4b3FYdHJjQXlxbE8z?=
 =?utf-8?B?cFZ0UHdkcEk4OGQ1bkxoYUpsMW1oVm5nTmNLaUFjWURFRWFDa1UxWHBUVjhG?=
 =?utf-8?B?VUd5UXllTnl1NitKY1pvbVVnRzFXQVdaZHIxdng0TFlwQTIxQmNVMUFId200?=
 =?utf-8?B?NEdPUUI3VGR4QnlFSmxLa0V4b2k2Y0lCb3Vhb3ZPeW5FcU5EdmxxMGZ2R29I?=
 =?utf-8?B?bktjSFAxVzBZcWhUSVNndDd6N2JiUzlrK0FIakVIaG9oK1FQS2RjU3pwaUtu?=
 =?utf-8?B?TC81cE45bVF6N0I3VWJyVGRGdnQyS1BjQTNNV052QnF2VDFFejFhVTYwQThS?=
 =?utf-8?B?aHk4Y0lnaVI4T2Z1Nkd3Y3M0YTQwaTByMkg3SmdqVjdEQWVESllGbVlnZUhx?=
 =?utf-8?B?ZmtuUXVreXkyT3djell5Umhjc0VlNU0zNEwxaXFTdG55cjhpR1AwcW5KaGtX?=
 =?utf-8?B?ZHVxNGYybEE2bHVaOWpPNDJFeVZhVHpFNWp4Y01qQXNMbUJuQ2ltUG1ORkZm?=
 =?utf-8?B?KzVFNDdzM0RsYk9pOHNnV0RXbW1teHRtYWhUcG9oWlk0blJmK1R2aUhidHBh?=
 =?utf-8?B?bUwxV2pEcXRJWHo2ckZ3aGQ5ZVc5RTBEQlRzT21GTEQyUjhSRWJhUmx1Si9O?=
 =?utf-8?B?NFVTTlJKTWxWUXZEblBXcmJrZ054OUVMZVJrU0hJTnR1emhXd2Jac2RzWW8z?=
 =?utf-8?B?MDcwajhPR1VCbTdnNkhQaHpEbi84TnZFaEVVeTl3azY3UnhHQmM5SEtZK3VU?=
 =?utf-8?Q?ZC90Wwy//Tu+AE58zgr7BxMYw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Kvhj4nAq1Dvtd4Wq1TyshXvHzI/QBcPoM7GzOSRVbdfv/UhFBMMcUpWcd5i8ypoOJ117o+JsvFV4Ui/VIJL5ytq2ExTjjsyGagMCTOB6hYO+rDG1ISM8uqICq4R7eppl2GVBeSYg0Wt1vyHznlnWUY1Hnb7nwMp/ZEIuuaZnzTYvnfNNwrza0O5O6F4JnTm+Yrl1wr6kV4LtP9iu1CXmmpsTYr+DOKbxnONvkPiJebmJIiQKqUBpKU8xCDDL14iCxDKFLp5vtbAizqz2AaW0BaNymnSuOu2+hTaO/J2kPtMw5sT/n/X9+nCtACPqhGr2kyfsUTuO/10LxsrlnvFiSL9Z6zbr+BqL5oF/hTZYfuQ8Nfvf9jiYmQ6TKHCpH482AjTK4BzSQuaDc75GOxe5PW9PNfprKV+7oGXz1GCQHwxbRD96HNMsnA8XSLPJ+MkXXqn2YPb+bvKvmoxFGzs3uvx2CL9sMejShr3AHCRR1XlMDQ69+ZeorZ0PFR7zGxZTeFOMh+070DrupGHhTo/1wCMmBVlXIoH8QO/2VzHjbkxuBoH+cnrH00+KcErwK4t0RUqDqWrRP9B1NI4tJ70nZDcBn6Cl2ZTeyLSuFrrXIOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d5fa7c-7782-472b-66dd-08dc58f27c69
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:09:27.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+aO2tiIRME4QBFbFzI5n25LXT0CtJVqQWattUnUdR/4ZcHovaiwGb78ftVGrMgFzx9ONZN+y+bL/8Kgla9bfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090166
X-Proofpoint-ORIG-GUID: fUTEkaoJWcZCoMp03-GMPpFpBCGoFT0D
X-Proofpoint-GUID: fUTEkaoJWcZCoMp03-GMPpFpBCGoFT0D

This feature was added because it was needed by Oracle products. The 
bugs found are corner cases and happen with new feature, at the time all 
tests passed. If you do not feel like fixing these bugs that is fine, 
let me know and I will address them, but removing the feature completely 
should not be an option.

Plus Amazon has it's own closed/proprietary distribution. If this is an 
issue please configure your repo to not include this feature. Many 
distributions choose not to include several features.

Shoaib

On 4/9/24 15:52, Kuniyuki Iwashima wrote:
> Commit 314001f0bf92 ("af_unix: Add OOB support") introduced MSG_OOB
> support for AF_UNIX, and it's about 3 years ago.  Since then, MSG_OOB
> is the playground for syzbot.
> 
> MSG_OOB support is guarded with CONFIG_AF_UNIX_OOB, but it's enabled
> by default and cannot be disabled without editing .config manually
> because of the lack of prompt.
> 
> We recently found 3 wrong behaviours with basic functionality that
> no one have noticed for 3 years, so it seems there is no real user
> and even the author is not using OOB feature.  [0]
> 
> This is a good opportunity to drop MSG_OOB support.
> 
> Let's switch the default config to n and add warning so that someone
> using MSG_OOB in a real workload can notice it before MSG_OOB support
> is removed completely.
> 
> Link: https://urldefense.com/v3/__https://lore.kernel.org/netdev/472044aa-4427-40f0-9b9a-bce75d5c8aac@oracle.com/__;!!ACWV5N9M2RV99hQ!M7skvfZ7iV_Wz5V4lcoDCSabTe02sk-cpFNYB5WNcgszkzbp3hHoasDagxKSqLdcBtgZ_ckaf5-RBE4$  [0]
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Added Fixes tag so that it can be backported to corresponding stable
> kernels.
> ---
>   net/unix/Kconfig   | 4 ++--
>   net/unix/af_unix.c | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/unix/Kconfig b/net/unix/Kconfig
> index 8b5d04210d7c..9d9270fdc1fe 100644
> --- a/net/unix/Kconfig
> +++ b/net/unix/Kconfig
> @@ -17,9 +17,9 @@ config UNIX
>   	  Say Y unless you know what you are doing.
>   
>   config	AF_UNIX_OOB
> -	bool
> +	bool "Unix MSG_OOB support"
>   	depends on UNIX
> -	default y
> +	default n
>   
>   config UNIX_DIAG
>   	tristate "UNIX: socket monitoring interface"
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 9a6ad5974dff..fecca27aa77f 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2253,6 +2253,8 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>   	err = -EOPNOTSUPP;
>   	if (msg->msg_flags & MSG_OOB) {
>   #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +		pr_warn_once("MSG_OOB support will be removed in 2025.\n");
> +
>   		if (len)
>   			len--;
>   		else

