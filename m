Return-Path: <netdev+bounces-140771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B99D9B7F97
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBF5282143
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C731A2554;
	Thu, 31 Oct 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QTB90Za8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97A136664;
	Thu, 31 Oct 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390657; cv=none; b=QFpT49r4JC9dYyckATFAmWZvfp3cmeUTzFJk/TBXRgBhAESnYI/K6gdgZex0KgagE4a7Aem+HS/t8sT2EbPTBuzA1USG2+F2Po7Fc3XHBlq2vmWQF24Rp3fONXMCw+SEc91XzhKNQZN9kvPdsiS+L/K8bhW56qkMJVdCK7QCmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390657; c=relaxed/simple;
	bh=ZcT0y+KZdcFbpt1THfitWC11MbKyY51f/TXfSmLN4oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWNn2innU//+pyiV7Tzf+yWHEQfOlK7Z6VSmSwIwF2gey7PmNZ/ZIK4BRPTg7Uj8ZaZ+jP4w3TK5+6+TqF5BGHVTmbtHNhETEpUJ7ENLa31wZ+2Sq79Y1AeWcmBQyEfe9Dul8da7qIGHMVsDvBukZiEWsXsy8q1vwpywolBfVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QTB90Za8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V2iodw013375;
	Thu, 31 Oct 2024 16:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zoRlGU
	lv7pH5jMOeFVzeVVtd43SvNnEf5m5bYdeB8YQ=; b=QTB90Za8tK+DTxbANay8CX
	1GtP0oe3/q2iN4ylqKcWMCGsHtB53DVZItvQWnsoAXuPwgG3f39dq5FAAdozIY8R
	sU1oKOS4h6Xn7wJGNfUmOsMyUN825G5wIaDhfbJFdvoGPEbRYoN3uxADiA7qofb2
	REpT21eGl5TvvgWf01jbneT86I+tecH3ajrdDvJsN+oehS86RX+DyULG8omqf/zP
	3BHLOoHewwtMGI+6jKPObQKh+Tw8XPleqDbGfhYPYUazrBo4SBcbo1FdvV+A3FjL
	iHTTVVmDAK+2AzCrZ937d3fdQIY2oy6CG4CKL6bEqMsLJhf4Rz5kz7H2twixToow
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42kkbn6sqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 16:04:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49VFRU9G024546;
	Thu, 31 Oct 2024 16:04:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyjna84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 16:04:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49VG47jA47382932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 16:04:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F353B58058;
	Thu, 31 Oct 2024 16:04:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D00FD58057;
	Thu, 31 Oct 2024 16:04:06 +0000 (GMT)
Received: from [9.41.105.143] (unknown [9.41.105.143])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Oct 2024 16:04:06 +0000 (GMT)
Message-ID: <9accb7aa-d440-40dd-aee9-10b334b0a087@linux.ibm.com>
Date: Thu, 31 Oct 2024 11:04:06 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] vsock/test: fix parameter types in SO_VM_SOCKETS_*
 calls
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
References: <20241029144954.285279-1-kshk@linux.ibm.com>
 <20241029144954.285279-3-kshk@linux.ibm.com>
 <7o2b3ggh7ojcoiyh5dcgu5y6436tqjarvmvavxmbm2id3fggdu@46rhdjnyqdpr>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <7o2b3ggh7ojcoiyh5dcgu5y6436tqjarvmvavxmbm2id3fggdu@46rhdjnyqdpr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T6ZuY1OzBxEJ1jtkDaR2BaDfpwU9lLGy
X-Proofpoint-GUID: T6ZuY1OzBxEJ1jtkDaR2BaDfpwU9lLGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=553
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310121

On 10/31/2024 09:16, Stefano Garzarella wrote:
> On Tue, Oct 29, 2024 at 09:49:54AM -0500, Konstantin Shkolnyy wrote:
>> Change parameters of SO_VM_SOCKETS_* to uint64_t so that they are always
> 
> In include/uapi/linux/vm_sockets.h we talk about "unsigned long long",
> but in the kernel code we use u64. IIUC "unsigned long long" should be 
> u64 on every architecture, at least till we will have some 128-bit cpu, 
> right?

I'm not sure what "unsigned long long" would be on a 128-bit machine.

> What about using `unsigned long long` as documented in the vm_sockets.h?

I use uint64_t because the kernel uses u64. I think, this way the code
isn't vulnerable to potential variability of "unsigned long long".
If we change to "unsigned long long" should we also change the kernel
to "unsigned long long"?


