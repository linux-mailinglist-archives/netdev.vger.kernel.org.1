Return-Path: <netdev+bounces-277168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Fy8NdAv2GmwZQgAu9opvQ
	(envelope-from <netdev+bounces-277168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:01:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F3C3D0690
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3E553012C9D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 23:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044134CFDA;
	Thu,  9 Apr 2026 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSQ3PYrT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SHirOhO8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCDB192590
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775694; cv=none; b=mv/JKnv2xNmpmz/Dxyym93aoB6rRUwnfYTwV7SzQkKorEbpIuTq7YNdGY8D2ujlB8BG2CFtXfB18c+Ih3FWo18V4OXpTaEPiyM/77Lu3Ehc1YHXHFd20DB3n9fMBOq7NpobZG94E+A9pXkr2Gncs7l2xit2F3WKrfhVclPIg2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775694; c=relaxed/simple;
	bh=Vg9fReBGxticuGbs9uMChIxCZtHmWD3IfgUM49x3/tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ6vbW60I7ZSLwf6BxJwgoAQ95R9yyFktlhWUVXKxHLY7jt0hZaC6VXOk9l/Dz9oKIPwzoirtGDMaSlNvWJLUdcwiQG4zxmEuBaLIwkwywCMbWy5LFa5VHOA9rkmVX8PwiezXaKmfZg74jynM06IxA96we0+Oa4GjSJjhzlIrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kSQ3PYrT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SHirOhO8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639Eqqt9115439
	for <netdev@vger.kernel.org>; Thu, 9 Apr 2026 23:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	szDQZJpHeLYiXJmahVnEFVzdttSQHWcNOehxAJzYlsA=; b=kSQ3PYrToYXR4Elg
	ZgKAv0RWyY+mBwFhvaDERk6GTtrsOQ5hF8SYd2zS7wt9VG+crzh2ZJON4g1II51n
	PMJ0aWMdcZCg2GgX77f+0TK7vfq/JqcihWleXwH4z8hoT1iH0uD6OjkjDswZvLzk
	ePoBQJ2ZzsQejtbvfuAmKVWMN7WPE1PgXbkkq2EN5w5Sy+PIB+pi55V48z/DXRwb
	d5/YWesSX0aaSER5qjIn6jLrLrqrQp5inXctoaxiWwce5Raj2Od+o+YogqbMBWQg
	omlipNadM/nAngeZ0zv22FoQG/KlUaLdPT5GMbTPO/gm/mwTsLfTknCBr4ogsG9C
	AKJOuA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8x9hf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 23:01:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso1684647eec.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775775690; x=1776380490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szDQZJpHeLYiXJmahVnEFVzdttSQHWcNOehxAJzYlsA=;
        b=SHirOhO869MtE9ANE486HnCEVgDVm0qZp26iX0q7Fk+abKcV6VY1qaVghhGp+iRNgM
         SpA6bSyYk3D5JjNqbWZX9PdPqPAlPmFh4OeiDNIs6VoJy3cDsdq73n8SrBymhGrm+IQ7
         jAC09UPjojWUmRjLPpDntNHzti6JvqMAAQxdeMU+O59GrVBhoK9xWh9BOLDfTPWAdje3
         54TpfmAh43CCK7kTbktjPXSq+cbAdNgpA3SIyS0b5naomil+v7gXiwbP1AGFMtP8DY/V
         9D69Lu14Om800SEa+aD/eGPAfsLv6+Q1+dug42QBHHBP0ZQ+tv4PJkFtpqCLiQnojMfL
         YMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775775690; x=1776380490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szDQZJpHeLYiXJmahVnEFVzdttSQHWcNOehxAJzYlsA=;
        b=a97/beDIeGTpd33Vwj+KvbgxTVyjMcu+JL22ZqfLTkwO0SuUBzi+hvQ4J+BmjPcRmZ
         izRTn6XCFSvt1VLiZVwtoHZSMgtU3dIW1zIp+s3TLOe5hqBXgAY7tNcfJBWIDoVKskNK
         ZcOkIsEC3CPRCz5G2m3dF0KPqKTt6bXmMd22ILLyjmAjlkm5P00q0kmccSPwq/Encw7v
         wdXRutK1IIHAlEle06+H4Cwy3D9NURPSZyjvh0s7JMVyXekae6AkcSPaI0fzwxQwDdgu
         HBHDFKF/lN1ZmRBVGzZPf82RW09EQDS+ZssPrLoek20q0vldvrRG0Po4UWwL+qOJcNAG
         RdbA==
X-Forwarded-Encrypted: i=1; AJvYcCWcQpvfHhRMfW0OE5oY6m/JM7AAmin3TtSY6NQwOgo27FSXhvKQxvaoh8tl2n+BnjRL1wA6OHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5DLeVU/fNC3iPKpWhBKv7gpdYos/0V8SZOGNUWAMe7b2LG8U
	iVL887rbEXx6LroQ5eqObfNkDrTHlp1XGNHWZBVBJ9MG95LOIMkFgMTgNAgihAtJSQ4vJMzvHhf
	/D+AdtSv6QwCs5Wj/afHA596rpQOhsYFEDrv0OM/Ff9BknTDp5SGRM169HZKZyVio/0B5Kg==
X-Gm-Gg: AeBDievE/MFzD2cG/7kmW8JaGkJcCMsPNmS1YQMVaUs79Zy7M8lxi+Ts60YZkSsTWLm
	7mQsFi3FLCwpFhBzutZvqoZU3w0RbGvT8CuehCt9TAZOBPXh09CtgL4t8v6EQzN4GDkwG2ZKJ05
	2bdabGkayO3t5t0xmgHqWe6S+Tfs3dpHtTWzSrt/yBRDmkg+LaTxut99HzN5naMa/xNl5CLM5Iu
	i9spb+66GChFJ+i4TUh8etnYNF/XE14rDwFJTPchAGBEVjvkH5HQ6gyFK8ZR4mm/3k99bMqd4po
	BCR916p1K0o/6wDFlGwsUIgUYNdeIcWACrCzto8FkLJBoehMdy607RxXo1Y/3eqUZofEmmWvZz4
	wcsUHztDh15yEp5cAp3xzi3GlEhacliWxlnmoH/ATdoZqcIT0x8C66FsFLjbuKsG5gKtFZjjNzh
	viW4XxRP0=
X-Received: by 2002:a05:7300:bc8a:b0:2c6:cdb3:bd67 with SMTP id 5a478bee46e88-2d5897690bbmr529668eec.22.1775775689464;
        Thu, 09 Apr 2026 16:01:29 -0700 (PDT)
X-Received: by 2002:a05:7300:bc8a:b0:2c6:cdb3:bd67 with SMTP id 5a478bee46e88-2d5897690bbmr529629eec.22.1775775688659;
        Thu, 09 Apr 2026 16:01:28 -0700 (PDT)
Received: from [10.226.48.50] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5632a2a06sm1668316eec.30.2026.04.09.16.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 16:01:28 -0700 (PDT)
Message-ID: <413e8508-5f29-4a5a-a583-8360f9e48712@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 17:01:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add clear-error-counter netlink
 command to drm_ras
To: "Tauro, Riana" <riana.tauro@intel.com>, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
        aravind.iddamsetty@linux.intel.com
Cc: anshuman.gupta@intel.com, simona.vetter@ffwll.ch, airlied@gmail.com,
        pratik.bari@intel.com, joshua.santosh.ranjan@intel.com,
        ashwin.kumar.kulkarni@intel.com, shubham.kumar@intel.com,
        ravi.kishore.koppuravuri@intel.com, raag.jadav@intel.com,
        anvesh.bakwad@intel.com, maarten.lankhorst@linux.intel.com,
        Jakub Kicinski <kuba@kernel.org>, Lijo Lazar <lijo.lazar@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20260409073318.2909379-4-riana.tauro@intel.com>
 <20260409073318.2909379-5-riana.tauro@intel.com>
 <e7978696-eff6-4c1f-ab0f-047dccb18b59@intel.com>
Content-Language: en-US
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
In-Reply-To: <e7978696-eff6-4c1f-ab0f-047dccb18b59@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIxMyBTYWx0ZWRfXzntlDEYE1E3t
 A4S+SgDAwQ8FdZ81p78QXk7uco48Au2ysWjdKzB2/Zzwk7omgMMpGsseMjDBqdOnhUwBskbhFj3
 5u8rIGB6EiJgWTEPqJTb1ov8atyA3XjLwe5hW2rkQ2YlPG56f7iSIWRtvhGFly7yleqWR1Vl+Mq
 zT8U6sdK5XZOOqld4XuyhUL/oR0E5wJYT8ZZwVFHA2ZET1kyoTNMu7pTVi8QMYebeVVJLeKzcJX
 xrRvv0WwVHkznRDyolnCn0qZuYfWFCzufBPAtqoXVX8UeuGtEzYl7PKD80Arw1h9Jp6hY4k7/Bk
 b3kWTS96fP5LqkVZDDhlUkUsOWVHXmZShRyN4cu6P9WYOWnxcyxAflXdg6E9CtHLefjg6ukseeT
 iIgHJ+ii9CORG8rWZpzDC7Q53VdUz1LC5MnPpLxRLi9qQjyW8tKP3a9f9OYiiTxaC7IpnrDlwqI
 Wb6eMs+mj1y8ZCNqUag==
X-Proofpoint-GUID: 9aNhGqCVfJ_BDlwpZm1be-bM0DtpEdvO
X-Proofpoint-ORIG-GUID: 9aNhGqCVfJ_BDlwpZm1be-bM0DtpEdvO
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d82fcb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=J1Y8HTJGAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8 a=af6eHWY9oS_2PyDk4DsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090213
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[intel.com,ffwll.ch,gmail.com,linux.intel.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277168-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zachary.mckevitt@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 49F3C3D0690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/9/2026 1:21 AM, Tauro, Riana wrote:
> Hi Zack
> 
> Could you please take a look at this patch if applicable to your 
> usecase. Please let me know if any
> changes are required
> 

 From a quick glance, I think this looks good from our end.

Thanks,
Zack

> @Rodrigo This is already reviewed by Jakub and Raag.
> If there are no opens, can this be merged via drm_misc
> 
> Thanks
> Riana
> 
> On 4/9/2026 1:03 PM, Riana Tauro wrote:
>> Introduce a new 'clear-error-counter' drm_ras command to reset the 
>> counter
>> value for a specific error counter of a given node.
>>
>> The command is a 'do' netlink request with 'node-id' and 'error-id'
>> as parameters with no response payload.
>>
>> Usage:
>>
>> $ sudo ynl --family drm_ras  --do clear-error-counter --json \
>> '{"node-id":1, "error-id":1}'
>> None
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
>> ---
>>   Documentation/gpu/drm-ras.rst            |  8 +++++
>>   Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
>>   drivers/gpu/drm/drm_ras.c                | 43 +++++++++++++++++++++++-
>>   drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
>>   drivers/gpu/drm/drm_ras_nl.h             |  2 ++
>>   include/drm/drm_ras.h                    | 11 ++++++
>>   include/uapi/drm/drm_ras.h               |  1 +
>>   7 files changed, 89 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm- 
>> ras.rst
>> index 70b246a78fc8..4636e68f5678 100644
>> --- a/Documentation/gpu/drm-ras.rst
>> +++ b/Documentation/gpu/drm-ras.rst
>> @@ -52,6 +52,8 @@ User space tools can:
>>     as a parameter.
>>   * Query specific error counter values with the ``get-error-counter`` 
>> command, using both
>>     ``node-id`` and ``error-id`` as parameters.
>> +* Clear specific error counters with the ``clear-error-counter`` 
>> command, using both
>> +  ``node-id`` and ``error-id`` as parameters.
>>   YAML-based Interface
>>   --------------------
>> @@ -101,3 +103,9 @@ Example: Query an error counter for a given node
>>       sudo ynl --family drm_ras --do get-error-counter --json '{"node- 
>> id":0, "error-id":1}'
>>       {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
>> +Example: Clear an error counter for a given node
>> +
>> +.. code-block:: bash
>> +
>> +    sudo ynl --family drm_ras --do clear-error-counter --json 
>> '{"node-id":0, "error-id":1}'
>> +    None
>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/ 
>> netlink/specs/drm_ras.yaml
>> index 79af25dac3c5..e113056f8c01 100644
>> --- a/Documentation/netlink/specs/drm_ras.yaml
>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>> @@ -99,7 +99,7 @@ operations:
>>         flags: [admin-perm]
>>         do:
>>           request:
>> -          attributes:
>> +          attributes: &id-attrs
>>               - node-id
>>               - error-id
>>           reply:
>> @@ -113,3 +113,14 @@ operations:
>>               - node-id
>>           reply:
>>             attributes: *errorinfo
>> +    -
>> +      name: clear-error-counter
>> +      doc: >-
>> +           Clear error counter for a given node.
>> +           The request includes the error-id and node-id of the
>> +           counter to be cleared.
>> +      attribute-set: error-counter-attrs
>> +      flags: [admin-perm]
>> +      do:
>> +        request:
>> +          attributes: *id-attrs
>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>> index b2fa5ab86d87..d6eab29a1394 100644
>> --- a/drivers/gpu/drm/drm_ras.c
>> +++ b/drivers/gpu/drm/drm_ras.c
>> @@ -26,7 +26,7 @@
>>    * efficient lookup by ID. Nodes can be registered or unregistered
>>    * dynamically at runtime.
>>    *
>> - * A Generic Netlink family `drm_ras` exposes two main operations to
>> + * A Generic Netlink family `drm_ras` exposes the below operations to
>>    * userspace:
>>    *
>>    * 1. LIST_NODES: Dump all currently registered RAS nodes.
>> @@ -37,6 +37,10 @@
>>    *    Returns all counters of a node if only Node ID is provided or 
>> specific
>>    *    error counters.
>>    *
>> + * 3. CLEAR_ERROR_COUNTER: Clear error counter of a given node.
>> + *    Userspace must provide Node ID, Error ID.
>> + *    Clears specific error counter of a node if supported.
>> + *
>>    * Node registration:
>>    *
>>    * - drm_ras_node_register(): Registers a new node and assigns
>> @@ -66,6 +70,8 @@
>>    *   operation, fetching all counters from a specific node.
>>    * - drm_ras_nl_get_error_counter_doit(): Implements the 
>> GET_ERROR_COUNTER doit
>>    *   operation, fetching a counter value from a specific node.
>> + * - drm_ras_nl_clear_error_counter_doit(): Implements the 
>> CLEAR_ERROR_COUNTER doit
>> + *   operation, clearing a counter value from a specific node.
>>    */
>>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>> @@ -314,6 +320,41 @@ int drm_ras_nl_get_error_counter_doit(struct 
>> sk_buff *skb,
>>       return doit_reply_value(info, node_id, error_id);
>>   }
>> +/**
>> + * drm_ras_nl_clear_error_counter_doit() - Clear an error counter of 
>> a node
>> + * @skb: Netlink message buffer
>> + * @info: Generic Netlink info containing attributes of the request
>> + *
>> + * Extracts the node ID and error ID from the netlink attributes and
>> + * clears the current value.
>> + *
>> + * Return: 0 on success, or negative errno on failure.
>> + */
>> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>> +                    struct genl_info *info)
>> +{
>> +    struct drm_ras_node *node;
>> +    u32 node_id, error_id;
>> +
>> +    if (!info->attrs ||
>> +        GENL_REQ_ATTR_CHECK(info, 
>> DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
>> +        GENL_REQ_ATTR_CHECK(info, 
>> DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
>> +        return -EINVAL;
>> +
>> +    node_id = nla_get_u32(info- 
>> >attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>> +    error_id = nla_get_u32(info- 
>> >attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>> +
>> +    node = xa_load(&drm_ras_xa, node_id);
>> +    if (!node || !node->clear_error_counter)
>> +        return -ENOENT;
>> +
>> +    if (error_id < node->error_counter_range.first ||
>> +        error_id > node->error_counter_range.last)
>> +        return -EINVAL;
>> +
>> +    return node->clear_error_counter(node, error_id);
>> +}
>> +
>>   /**
>>    * drm_ras_node_register() - Register a new RAS node
>>    * @node: Node structure to register
>> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
>> index 16803d0c4a44..dea1c1b2494e 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.c
>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>> @@ -22,6 +22,12 @@ static const struct nla_policy 
>> drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
>>       [DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>   };
>> +/* DRM_RAS_CMD_CLEAR_ERROR_COUNTER - do */
>> +static const struct nla_policy 
>> drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
>> +    [DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>> +    [DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>> +};
>> +
>>   /* Ops table for drm_ras */
>>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>>       {
>> @@ -43,6 +49,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] 
>> = {
>>           .maxattr    = DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
>>           .flags        = GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>>       },
>> +    {
>> +        .cmd        = DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>> +        .doit        = drm_ras_nl_clear_error_counter_doit,
>> +        .policy        = drm_ras_clear_error_counter_nl_policy,
>> +        .maxattr    = DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>> +        .flags        = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> +    },
>>   };
>>   struct genl_family drm_ras_nl_family __ro_after_init = {
>> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
>> index 06ccd9342773..a398643572a5 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.h
>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>> @@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff 
>> *skb,
>>                         struct genl_info *info);
>>   int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>                       struct netlink_callback *cb);
>> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>> +                    struct genl_info *info);
>>   extern struct genl_family drm_ras_nl_family;
>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>> index 5d50209e51db..f2a787bc4f64 100644
>> --- a/include/drm/drm_ras.h
>> +++ b/include/drm/drm_ras.h
>> @@ -58,6 +58,17 @@ struct drm_ras_node {
>>       int (*query_error_counter)(struct drm_ras_node *node, u32 error_id,
>>                      const char **name, u32 *val);
>> +    /**
>> +     * @clear_error_counter:
>> +     *
>> +     * This callback is used by drm_ras to clear a specific error 
>> counter.
>> +     * Driver should implement this callback to support clearing 
>> error counters
>> +     * of a node.
>> +     *
>> +     * Returns: 0 on success, negative error code on failure.
>> +     */
>> +    int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
>> +
>>       /** @priv: Driver private data */
>>       void *priv;
>>   };
>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>> index 5f40fa5b869d..218a3ee86805 100644
>> --- a/include/uapi/drm/drm_ras.h
>> +++ b/include/uapi/drm/drm_ras.h
>> @@ -41,6 +41,7 @@ enum {
>>   enum {
>>       DRM_RAS_CMD_LIST_NODES = 1,
>>       DRM_RAS_CMD_GET_ERROR_COUNTER,
>> +    DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>>       __DRM_RAS_CMD_MAX,
>>       DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)


