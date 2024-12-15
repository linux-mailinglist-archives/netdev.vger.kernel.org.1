Return-Path: <netdev+bounces-151973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8D9F21A7
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 02:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F47A0770
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9D51114;
	Sun, 15 Dec 2024 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuPkwkkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9215C0;
	Sun, 15 Dec 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734225113; cv=none; b=LoyRX0jE+k0xKbFQeMlFpli/cvo0z/F4llTcXb7GFOH+S7kW2VLOJTVHmS84blJRJekS1UIpIcHKlsLb48lAL+IibhLT6ZGJvHTNmgRs5MYUFS0IirENs/OEOPREkrK86gBOuKbkh0WoO9BJ/J/IqAObzdbxqfDZiZ/gQW7wMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734225113; c=relaxed/simple;
	bh=khCqCaUc7oPetWqqbrC/i+ycLVPFmXVJZBJuN/aEe1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxwzhXjXc3G74YY+aIHwQQ7WWkK7cvhQx9aqfuUEOHrOPcGfwV7M14EDoJGCKY7wiQzlqU30NffpfPigHlQni7ZnJEoprWnehq4evmCuSIpZIrv84Q9sZHU/49rPeNpcv/9ae7vQ22pVlsT53Ay1FxfugJNXXl2la9EnpAkZ5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuPkwkkQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso5114374a12.3;
        Sat, 14 Dec 2024 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734225110; x=1734829910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePr7W0HpWMgM/Wa9tyqQLlVZGdwlWt2cF0juskGKjm8=;
        b=EuPkwkkQUEl+BaT5S7fI5vY++pO6FVsRcqPd00bwzYnig4F84zdsNvCfYbPU6wIx4b
         mlg0IquEFyN63r7GjEHcuuUUCtbY9sAXiydGyPdQqQ1YD+eJG/AycL5+x6pS7WgDT51a
         RzkDKfcHXLNWE5W60ja7Kd5c2VkUQJO3dllKfVTuCcNdhKl8UK0ntg3G2itpX5ULpCal
         aSLBMGuwRIPeYnZRbX8lxz6G5KvsALHRX6ktQWs3wZ/0Dj0UCMJERyt3OA2sfwkBHn7K
         vD9A94eyeHmyle6P4+nz/hmxJ7oBnESgGVBiaOtZlfdRPMyRQnvXoHg5CfZh5YCI4mvb
         RQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734225110; x=1734829910;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePr7W0HpWMgM/Wa9tyqQLlVZGdwlWt2cF0juskGKjm8=;
        b=AU8Y+zXDRZBF+ST+wzdVsbGiw5m8VP/Nv4N6qdSypTVCjeaGJB2f2CTuyIj4Un9rX/
         zKSnmu/1/BHxjGhAQ56zJlXYRhcBK3x5fJepmUvZEIdqByUsbO6Sbz3UhHPDnpEei70V
         fb4VCEaToD1Mj5slCms+ag82+pgbOfeQe8qu81VsGymgrZcTmCg40r94mHlYYrQGIK9g
         9pJ7rmEPco25+qcCZkiGye1btQ8K9mUjtsv3RZgt6eJ6GTgE4zI5ThzQmyArPJgPT1J6
         +lqy7apiDL/bqUWw9a/EGb/ag68PTATruyJHzAfmeumeuLyQjoNxbvQyAT543xMp8q9K
         1/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9lbRUSMe0V9azgkXE3UYdU7Oql2qOMv5c92mnBoZNbbnOofj1UV8Y2CRIthbVWcVe1XluvfJt@vger.kernel.org, AJvYcCW6dc40CoerTMAXMwFR9loQNiuiMWE6v+wLCxCFlgYY9xdVI7oYb6JhJYZtuaHXj8OThgidIbAD8VjZXSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykZk1bk9rcrkSjXFoSt4FZyvmvS7/p/3iBwvKTgOXhMOVZNsiV
	t8LrN9mFDItoj3+8x0DVGHoQDeXtENCyS0CzRkD0+rQNY45+4t6cL52pWGJL
X-Gm-Gg: ASbGnct4h839jnUiyxPy+2jtyeiZcJwQPt0Np0vls5N41vZiddX/XlTRNWGnla+1DAZ
	LHDqXB+i1co/w9CcZmp2NdDd+8+tmDC226hsEo1jBq1EbI0YQ+ghli97MG5gEHFjZLzOM3AST4A
	IhjO8/Qn3qbDTu3Yr/dYwSAlo6rt7TmQ0UodGLpFRGXhVH4UQ09BO1rdbRPz374KG8DsvJn+4O2
	pQbf+Cj8tdLMpElfSaeaCC61FUzR0stp0jKKBggNbe/A+mKMCwrKkiorLcfxi271qjTu/RYBUIZ
	A0xa57gaK8NTIh6kgVFkx0oNH3RvTw==
X-Google-Smtp-Source: AGHT+IEAn7LtWVSIVsfFE1cdKyQqoWU9OPakAoN511OSpdYKyqPyboeqi5jT0efMGPRR5G3f712RLw==
X-Received: by 2002:a05:6402:5253:b0:5d2:719c:8bf3 with SMTP id 4fb4d7f45d1cf-5d63c306a21mr5945659a12.9.1734225110061;
        Sat, 14 Dec 2024 17:11:50 -0800 (PST)
Received: from ?IPV6:2a01:e11:5400:7400:2afd:8633:4d49:50ca? ([2a01:e11:5400:7400:2afd:8633:4d49:50ca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae12a7sm1506423a12.50.2024.12.14.17.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 17:11:48 -0800 (PST)
Message-ID: <4c8a6841-06d1-4bc0-8470-380448006036@gmail.com>
Date: Sun, 15 Dec 2024 02:11:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qed: fix uninit pointer read in
 qed_mcp_nvm_info_populate()
To: Simon Horman <horms@kernel.org>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20241211134041.65860-2-gianf.trad@gmail.com>
 <20241212170400.GC73795@kernel.org>
 <cdbe92eb-0d35-457b-b661-d7aaf4026984@gmail.com>
 <20241213133120.GB561418@kernel.org>
From: Gianfranco Trad <gianf.trad@gmail.com>
Content-Language: en-US, it
In-Reply-To: <20241213133120.GB561418@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/24 14:31, Simon Horman wrote:
> On Fri, Dec 13, 2024 at 01:13:12PM +0100, Gianfranco Trad wrote:
>> On 12/12/24 18:04, Simon Horman wrote:
>>> On Wed, Dec 11, 2024 at 02:40:42PM +0100, Gianfranco Trad wrote:
>>>> Coverity reports an uninit pointer read in qed_mcp_nvm_info_populate().
>>>> If qed_mcp_bist_nvm_get_num_images() returns -EOPNOTSUPP, this leads to
>>>> jump to label out with nvm_info.image_att being uninit while assigning it
>>>> to p_hwfn->nvm_info.image_att.
>>>> Add check on rc against -EOPNOTSUPP to avoid such uninit pointer read.
>>>>
>>>> Closes: https://scan5.scan.coverity.com/#/project-view/63204/10063?selectedIssue=1636666
>>>> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
>>>> ---
>>>> Note:
>>>> - Fixes: tag should be "7a0ea70da56e net/qed: allow old cards not supporting "num_images" to work" ?
>>>>    drivers/net/ethernet/qlogic/qed/qed_mcp.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
>>>> index b45efc272fdb..127943b39f61 100644
>>>> --- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
>>>> +++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
>>>> @@ -3387,7 +3387,7 @@ int qed_mcp_nvm_info_populate(struct qed_hwfn *p_hwfn)
>>>>    	}
>>>>    out:
>>>>    	/* Update hwfn's nvm_info */
>>>> -	if (nvm_info.num_images) {
>>>> +	if (nvm_info.num_images && rc != -EOPNOTSUPP) {
>>>>    		p_hwfn->nvm_info.num_images = nvm_info.num_images;
>>>>    		kfree(p_hwfn->nvm_info.image_att);
>>>>    		p_hwfn->nvm_info.image_att = nvm_info.image_att;
>>>
>>
>> Hi Simon,
>>
>>> Are you sure that nvm_info.num_images can be non-zero if rc == -EOPNOTSUPP?
>>>
>>
>> In the coverity report, the static analyzer is able to take the true branch
>> on nvm_info.num_images. I didn't physically reproduce this logical state as
>> I don't possess the matching hardware.
>>
>>> The cited commit state:
>>>
>>>       Commit 43645ce03e00 ("qed: Populate nvm image attribute shadow.")
>>>       added support for populating flash image attributes, notably
>>>       "num_images". However, some cards were not able to return this
>>>       information. In such cases, the driver would return EINVAL, causing the
>>>       driver to exit.
>>>
>>>       Add check to return EOPNOTSUPP instead of EINVAL when the card is not
>>>       able to return these information. The caller function already handles
>>>       EOPNOTSUPP without error.
>>>
>>> So I would expect that nvm_info.num_images is 0.
>>>
>>> If not, perhaps an alternate fix is to make that so, either by setting
>>> it in qed_mcp_bist_nvm_get_num_images, or where the return value of
>>> qed_mcp_bist_nvm_get_num_images is checked (just before the goto out).
>>>
>>
>> Makes sense, so something like this I suppose:
>>
>> --- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
>> +++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
>> @@ -3301,8 +3301,10 @@ int qed_mcp_bist_nvm_get_num_images(struct qed_hwfn
>> *p_hwfn,
>>    	if (rc)
>>    		return rc;
>>
>> -	if (((rsp & FW_MSG_CODE_MASK) == FW_MSG_CODE_UNSUPPORTED))
>> +	if (((rsp & FW_MSG_CODE_MASK) == FW_MSG_CODE_UNSUPPORTED)) {
>> +		*num_images = 0;
>>    		rc = -EOPNOTSUPP;
>> +	}
>>
>> Or the second option you stated.
> 
> Yes, that is what I was thinking.
> But as it is a side effect, and thus hidden slightly,
> on reflection perhaps the second option is better. IDK.
> 

Got it. Will send a v2 accordingly.

Thanks for your time,
--Gian

>>> And, in any case I think some testing is in order.
>>
>> I strongly agree. Let me know if I can help more with this.
>>
>> Thanks for your time,
>> --Gian
>>


