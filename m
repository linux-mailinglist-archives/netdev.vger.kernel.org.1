Return-Path: <netdev+bounces-166528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF91A365C7
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8473ADB64
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825F918A924;
	Fri, 14 Feb 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q3R82vOF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44D1714CF;
	Fri, 14 Feb 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558012; cv=none; b=tYhPaliG/rHvc9luFOhl5f//+YfRFimXYQtqUZjALhp5WfOILMD7qIheFGmouoNbG5KmHqoA4/c4JwpMsGfxzPGZcRut0bzFJ0/XTdrOPA/qP+3dU3wYfrZJVNt3r+1c9avLqsFlkl8S0REYQZJudlYJsR4VlnUC2MZ/vzVgq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558012; c=relaxed/simple;
	bh=BelLHttR+MY42mTHdESvUE3T0wJCB1QK0Urq5KpEmRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3PwGQzCRopi02MPTKMbOv6Ny6ZU7iB/Sm5RmG29gKLKhHSmoh98aiuvTemUWZ0RFTJH6DUx71XZ0i1CZWbpV0iFqfH389fMxHs/0kRf6YI39Izo7uWgJtrBjsxANPtGG32/xitpm9MsDlQdmOxU9+Uz079oBBBdMLYfHfdxsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q3R82vOF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EGnqdA026795;
	Fri, 14 Feb 2025 18:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U3R/pi
	OSbP1l5fV7ZSgwxUiRjkRkc+vgLLkomdqLscU=; b=Q3R82vOFrKsvxAfQfxLfjp
	stn409N2/rO3awlSvLkr7jSEV51lA7ZyewM7jBYa0Juq4MWJAQYKsPWzBjLOnZXN
	XjG7OLBX0+hGAfVQpx/HhRJ5rcCnsIBjr07G/m4uD8SutlWd0I2QWbiq5dPs0zme
	VA2i85jVeZ1UJ9Ck5/FWole36ttu0ncN3Munz/2RjXnfe/ZcuQfDVQ0NDwfoY694
	c5pkAv8PPsesL9x7Z+v3m5lLyUPY9CoJqZqs14bpA13m9jUE+4h5hHMQjwfGKUxs
	3rEUvUhMydo2VWJTHSgZ/e2UkAW1lZ8KbwtrozDG+t7r23Wo+qLFDlH7Rh4tCjLw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hpu36e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 18:33:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EICLBF028268;
	Fri, 14 Feb 2025 18:33:25 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyyw54c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 18:33:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EIXLA524642078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 18:33:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A974458059;
	Fri, 14 Feb 2025 18:33:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430F858055;
	Fri, 14 Feb 2025 18:33:21 +0000 (GMT)
Received: from [9.61.91.157] (unknown [9.61.91.157])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 18:33:21 +0000 (GMT)
Message-ID: <ea7a6153-ea25-4ee7-975f-36a87d5f8e97@linux.ibm.com>
Date: Fri, 14 Feb 2025 12:33:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large buffers
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, haren@linux.ibm.com,
        ricklind@us.ibm.com, nick.child@ibm.com, jacob.e.keller@intel.com,
        horms@kernel.org
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
 <20250214162436.241359-2-nnac123@linux.ibm.com>
 <87tt8wflt5.fsf@linux.ibm.com>
Content-Language: en-US
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <87tt8wflt5.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JtPPvCbjNXXh_vwaHEdy3mf2fZgwwOKj
X-Proofpoint-GUID: JtPPvCbjNXXh_vwaHEdy3mf2fZgwwOKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=728 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140127

Hi Dave,

Thanks for reviewing,

On 2/14/25 12:00 PM, Dave Marquardt wrote:
> Nick Child <nnac123@linux.ibm.com> writes:
>
>> +	     (i) += (rowsize) == 16 || (rowsize) == 32 ? (rowsize) : 16	\
> Nit: If you left out the (rowsize) == 16 check here you'd still add 16
> to (i).

I was trying to have this translate into "if invalid rowsize was used 
then default to 16" since

hex_dump_to_buffer has a very similar conditional. But I agree, 
logically it looks strange.

If I send a v3 (I also foolishly forgot the v2 tag in this patch), I 
will change this like to

+	     (i) += (rowsize) == 32 ? 32 : 16	\


