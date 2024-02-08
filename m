Return-Path: <netdev+bounces-70369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A530784E8CD
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 20:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D32B22AF6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 19:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08D43613C;
	Thu,  8 Feb 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X73qdNUf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1336138
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419683; cv=none; b=tiW8CQp0bifBuUVKTUL8LyRi87MTi5KoHsqlwCNrvGc3P6GLgZ2ywHiVzwWOz/XKTqB1bYcx07/9yPWoejhXFUgqReLScRinDJMnbslGZJzupaBzEAO48hnTLcMcpnyPsEA47wpATcOyodDNaveTRqkIUOnqax7gVAxYKS7WoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419683; c=relaxed/simple;
	bh=grlcDKTOZNBRmpu+JlGaVH4C7Vr7MHiRgfEBJxwRXtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agEGwiZyeM2z0+h4cVv+QCLHPCz8P/ju9O+rPzNAhgkJQfhD8OTDlbHPuCw6+oHCrTHejXhqx1hGOAnSaK4lKmMKcxIKTQ/MInQnsAot0too78f5YpIZX8ZCw8DJkdmb8d8PeeW5D3S4QiVrGi8Nu4ZUP234+HeBq3ncOFXnWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X73qdNUf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418HNhVW001717;
	Thu, 8 Feb 2024 19:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=grlcDKTOZNBRmpu+JlGaVH4C7Vr7MHiRgfEBJxwRXtI=;
 b=X73qdNUfdJObibSTIXNupwtJlMNulXPbOcKm8bFxR6z8F02uqkFXrnbjUiaElDiwkKYt
 pzKzA3YA4AOyGaS9eEtZ4CODOCY2nnfwFNDn1mpqyr4U+LpfKOeBE163tCIFv33ewiC4
 EJawhFuS8chW6FHeXEjJrHFO3uSwQ3RuQRM2IYuqV1qXbZtl3ohD9W9UXt5+yz2WrN9p
 XGX9g77jQ5rYfzP97THYFXLeW8Jk1tDeURRl6Fy9DWmQZR/FTD0Km/VjoOoMCoM33OaQ
 /i0zhl0SqaGfCOJgVKA5A2lVBjczCuFbiVc3skDDgL0O9PO9ZvLyQUjQOeyhnQldUBw8 fw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4yw89ct3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 19:14:36 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418I9XBN008708;
	Thu, 8 Feb 2024 19:14:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4yw89csq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 19:14:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418IbpNK008478;
	Thu, 8 Feb 2024 19:14:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221ke82q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 19:14:34 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418JEWOe29164184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 19:14:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D97558058;
	Thu,  8 Feb 2024 19:14:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C31658057;
	Thu,  8 Feb 2024 19:14:31 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 19:14:31 +0000 (GMT)
Message-ID: <87a8344e-8c36-49ee-a67d-07b8e5003ade@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2024 13:14:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] net/bnx2x: Prevent access to a freed page in
 page_pool
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, aelior@marvell.com, davem@davemloft.net,
        manishc@marvell.com, pabeni@redhat.com, skalluru@marvell.com,
        simon.horman@corigine.com, edumazet@google.com,
        VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com
References: <cover.1707414045.git.thinhtr@linux.vnet.ibm.com>
 <90238577e00a7a996767b84769b5e03ef840b13a.1707414045.git.thinhtr@linux.vnet.ibm.com>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Content-Language: en-US
In-Reply-To: <90238577e00a7a996767b84769b5e03ef840b13a.1707414045.git.thinhtr@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MPJ7dTiaUKA1IheSroJAhjoiHpIXCJLD
X-Proofpoint-GUID: RebFejAediUCY6KvOaeOQv0GSu0t4gLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=545 phishscore=0 spamscore=0
 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080101

Fixes: 4cace675d687

