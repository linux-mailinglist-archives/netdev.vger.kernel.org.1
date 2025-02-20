Return-Path: <netdev+bounces-168186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3984EA3DF53
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F2421BF1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA220C024;
	Thu, 20 Feb 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I4TGqc1p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24B1DE4CE;
	Thu, 20 Feb 2025 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066559; cv=none; b=o2w4NSy8rawny6F7nA2WxBPfJQYHjYXJLEGLoPdzpQYvO5XgfL9WRgjCECShpWnmQx1ktDPt5ZSvZSK1lrbvNEffMsZjcQLUyiW/SeNZN6uDZX78WP6c/jSOvr/+/RmXd4qdhaGr8XS3gs5YaafFGTR2U7/K2/Jf8nt4o2SgR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066559; c=relaxed/simple;
	bh=V6m/1Ca2JRnu8XiJY7zpUdN1hDqH6GR6ntTadPy+tZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGblO3KVFd6ZSEjFMw715VRwB+xfCTbYpqiTnhd8U7mxCs2vwHf9+gd18qHaxs1WMK1F8cjrCAelMH091WzuQ6pGZ0BlBMBWCxhUNUNLFQKMXjeuAMq5mfhJ9EU9DfC8/L/l82/tHPL/Fge1OF14WOYoBhICtNGIDqUASoOOgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I4TGqc1p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBXUIB022986;
	Thu, 20 Feb 2025 15:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ksl0G/
	QDcoEObl+CvzHWrQyhDclj53npqYAaunKK+bk=; b=I4TGqc1pPZlkmCYMq9ADuJ
	ixk4ePjO+6E0Qtbx+m2ZmSBMBr+T3+gdrCO2/1DnDbGyNWTTILAwFrIt/+EWsleT
	yKLttUpClBe1nDctGkyUbK6TiBD2FT7WbN4ob4DNtAZUz/JlvNq06+753GsRtQZF
	Lb2zoacKd+2FHO/KtGIzKKiayIb97aYtnD/vtqO/Vc4qzpnrvt2M6kuXL7JjF2NY
	z1yuOOyXlNvRAJUFBHvrHNpMX0hLDVX1JAiyhZJ87er1rOSKUjm3lstarN/pt2jp
	DS8+ync+/8Tgf41T2np0jXGP4P/y/5/fIbu6zUBDAItCinUSLm6pPD1g1ZMikR5A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wu80bsab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:49:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51KFgt11031930;
	Thu, 20 Feb 2025 15:49:07 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wu80bsa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:49:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFE13J002348;
	Thu, 20 Feb 2025 15:49:06 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xar9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:49:06 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KFn44x64618804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 15:49:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCF925805D;
	Thu, 20 Feb 2025 15:49:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A97B58072;
	Thu, 20 Feb 2025 15:49:04 +0000 (GMT)
Received: from [9.61.179.202] (unknown [9.61.179.202])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 15:49:04 +0000 (GMT)
Message-ID: <4c424cb6-3c2e-47a2-aa75-98fb20d805c9@linux.ibm.com>
Date: Thu, 20 Feb 2025 09:49:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] hexdump: Use for_each macro in
 print_hex_dump
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
        david.laight.linux@gmail.com, nick.child@ibm.com, pmladek@suse.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
 <20250219211102.225324-3-nnac123@linux.ibm.com>
 <875xl5y50q.fsf@linux.ibm.com>
Content-Language: en-US
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <875xl5y50q.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: le_LlzZkSOGUMQ03TBj7nXJ5Gm7rZX6F
X-Proofpoint-ORIG-GUID: 5HfbMpQgbY6oVpGLiDEZMzIvZ07Pd-0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=974 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200111

Hi Dave,

Thanks for reviewing.

On 2/19/25 3:54 PM, Dave Marquardt wrote:
> Nick Child <nnac123@linux.ibm.com> writes:
>
>> diff --git a/lib/hexdump.c b/lib/hexdump.c
>> index c3db7c3a7643..181b82dfe40d 100644
>> --- a/lib/hexdump.c
>> +++ b/lib/hexdump.c
>> @@ -263,19 +263,14 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>>   		    const void *buf, size_t len, bool ascii)
>>   {
>> -	for (i = 0; i < len; i += rowsize) {
>> -		linelen = min(remaining, rowsize);
>> -		remaining -= rowsize;
>> -
>> -		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
>> -				   linebuf, sizeof(linebuf), ascii);
>> -
>> +	for_each_line_in_hex_dump(i, rowsize, linebuf, sizeof(linebuf),
>> +				  groupsize, buf, len) {
> Several callers of print_hex_dump pass true for the ascii parameter,
> which gets passed along to hex_dump_to_buffer. But you ignore it in
> for_each_line_in_hex_dump and always use false:
>
> + #define for_each_line_in_hex_dump(i, rowsize, linebuf, linebuflen, groupsize, \
> +				   buf, len) \
> +	for ((i) = 0;							\
> +	     (i) < (len) &&						\
> +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> +				(len) - (i), (rowsize), (groupsize),	\
> +				(linebuf), (linebuflen), false);	\
> +	     (i) += (rowsize) == 32 ? 32 : 16				\
> +	    )
>
> Is this behavior change intended?
>
> -Dave

Yes, for simplicity, I wanted to limit the number of parameters that the 
macro had.

Since the function does not do any printing, the user can do ascii 
conversion on their own

or even easier just ensure a \NULL term and print the string with the %s 
format specifier.


Also, allowing the user to specify the ascii argument makes it more 
difficult for them to

calculate the correct linebuflen.

For example, rowlen == 16, and groupsize == 1 with ascii = true would 
require a linebuflen

of 16 * 4 + 1 (2 chars, 1 space/NULL and 1 ascii per byte  + a extra 
space separating hexdump and ascii).

If ascii == false, linebuflen is very logically 16*3.


- Nick



