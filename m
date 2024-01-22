Return-Path: <netdev+bounces-64724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0932E836CEA
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5C41F24F2D
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 17:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C843FB0A;
	Mon, 22 Jan 2024 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCcNF2zd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8003FB09
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940532; cv=none; b=ZxzyRDl1NSMokcSHb0UFCf2N/LriluZITL3Pg1+2TWgth5UMGxjPkqMNql96lsMYFKJDBFJ0u5bYn42Gm1wJiKRL2CWyFKmDlhLW03UtnpwJ4gBMYWU6evRLqtAKaqprsNIaMX/s3IacwJFJSPJkGUd8TmK11/5m+RSVqjQoH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940532; c=relaxed/simple;
	bh=BlfR+5Bba9pkw37d9fBukYIRk6Ve0fZjaUObc6KETvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGogAsTU2OIMxkKY96qKFXA+o3Gloncc1xV2ZsxRLJojRnEvJ9FBYHd8Ewh/RZc071HO0xvEFGeEncevslzIAt6HILkK583KMdhLTmrd7uIJN4x/MKr84FqELochLYr4U+N3OmBsdsaYXdhsJm5YL3i59LKmSqrrFBY1VLhV2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCcNF2zd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705940529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCjgU5cUmnQSby0Ldb5Z3fPfkJILeWuQyCkntvhbSuE=;
	b=hCcNF2zdNH9JzamYEZr5gZLxc0bpfbqYYiJb1OCWoyUnNoXvShbJnWvNuQGAHF8yHdFLcO
	0azCyb/5PhJ1MiJrbH4uD4byWA7GT50BZvNoodiaiOc2QL5p1nPIL1g/1gqHjvs9MhnE5S
	+UASjVMt7IN89y+5JqD0Jptai0M3cNo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-YVaTLpeTNlWNahRZWTus_Q-1; Mon, 22 Jan 2024 11:22:07 -0500
X-MC-Unique: YVaTLpeTNlWNahRZWTus_Q-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd36b9fdafso3188015b6e.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 08:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705940526; x=1706545326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCjgU5cUmnQSby0Ldb5Z3fPfkJILeWuQyCkntvhbSuE=;
        b=SJn0yVs35c96fierCjAVbsPAaLa7/n+eFt2n+ERGCUgo02IPWDK5xS3Dbqaqm1vA4P
         Vau38Rjweqn5jdnirSxOm7L07TUtXYogVfRO/KMfVO7FkNYIcVAATE1sYL9VuaL+IcSp
         WVRAYSUiV6b0+dNUHPfJUZjvlFcRwEgrvUeg9UTgwUiU4MXwzbCH+kdy/VmfUJZYcPzX
         5PMmv55UsQhpD0YY+ASOEisxVddB23y3f3A/c73SJINyk5haIbxiKbWQfcVDaFZGu3VF
         QcDu78KEHNILyFoGPZLCeF9sD8SMMxb+B/IwNTRK/9MYyLT3ajV1vp1nSoYXsJDfvYNt
         0hVw==
X-Gm-Message-State: AOJu0YyqUPBK3DBrzE9giJF4odzQk7St3FZI968r2C+YNrRiSFlpHnn8
	u0JE1/uX0lCxhxQ1J1hk76q45OXC9vsvpn3xXoRLYWyMIhrmplsLWg4ygFlBqGmLIVSTJhG2Jf0
	O5BvHzuVxuYzzsdT3QNN7gCX+8Cle971j6G0TQj6c8ePsPPotW3p7zg==
X-Received: by 2002:a05:6870:d0d:b0:210:a3a9:af01 with SMTP id mk13-20020a0568700d0d00b00210a3a9af01mr127845oab.88.1705940526561;
        Mon, 22 Jan 2024 08:22:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV2QRCVvlrOlYJ97HPbRDvqgoszYvLmrgFp7dnp5V0fH+7X4IUvNDYIjk8blWmVmzTF2VSFQ==
X-Received: by 2002:a05:6870:d0d:b0:210:a3a9:af01 with SMTP id mk13-20020a0568700d0d00b00210a3a9af01mr127839oab.88.1705940526298;
        Mon, 22 Jan 2024 08:22:06 -0800 (PST)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id gu27-20020a056870ab1b00b00206516474f3sm2191302oab.38.2024.01.22.08.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 08:22:04 -0800 (PST)
Message-ID: <aca034dd-5c57-a382-16a4-2f79521f1567@redhat.com>
Date: Mon, 22 Jan 2024 11:22:03 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC net-next] tcp: add support for read with offset when using
 MSG_PEEK
Content-Language: en-US
To: Stefano Brivio <sbrivio@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, lvivier@redhat.com, dgibson@redhat.com
References: <20240111230057.305672-1-jmaloy@redhat.com>
 <df3045c3ec7a4b3c417699ff4950d3d977a0a944.camel@redhat.com>
 <595d89f1-15b1-537d-f876-0ac4627db535@redhat.com>
 <20240121231615.13029448@elisabeth>
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <20240121231615.13029448@elisabeth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-01-21 17:16, Stefano Brivio wrote:
> On Thu, 18 Jan 2024 17:22:52 -0500
> Jon Maloy <jmaloy@redhat.com> wrote:
>
>> On 2024-01-16 05:49, Paolo Abeni wrote:
>>> On Thu, 2024-01-11 at 18:00 -0500, jmaloy@redhat.com wrote:
>>>> From: Jon Maloy <jmaloy@redhat.com>
>>>>
>>>> When reading received messages from a socket with MSG_PEEK, we may want
>>>> to read the contents with an offset, like we can do with pread/preadv()
>>>> when reading files. Currently, it is not possible to do that.
>> [...]
>>>> +				err = -EINVAL;
>>>> +				goto out;
>>>> +			}
>>>> +			peek_offset = msg->msg_iter.__iov[0].iov_len;
>>>> +			msg->msg_iter.__iov = &msg->msg_iter.__iov[1];
>>>> +			msg->msg_iter.nr_segs -= 1;
>>>> +			msg->msg_iter.count -= peek_offset;
>>>> +			len -= peek_offset;
>>>> +			*seq += peek_offset;
>>>> +		}
>>> IMHO this does not look like the correct interface to expose such
>>> functionality. Doing the same with a different protocol should cause a
>>> SIGSEG or the like, right?
>> I would expect doing the same thing with a different protocol to cause
>> an EFAULT, as it should. But I haven't tried it.
> So, out of curiosity, I actually tried: the current behaviour is
> recvmsg() failing with EFAULT, only as data is received (!), for TCP
> and UDP with AF_INET, and for AF_UNIX (both datagram and stream).
>
> EFAULT, however, is not in the list of "shall fail", nor "may fail"
> conditions described by POSIX.1-2008, so there isn't really anything
> that mandates it API-wise.
>
> Likewise, POSIX doesn't require any signal to be delivered (and no
> signals are delivered on Linux in any case: note that iov_base is not
> dereferenced).
>
> For TCP sockets only, passing a NULL buffer is already supported by
> recv() with MSG_TRUNC (same here, Linux extension). This change would
> finally make recvmsg() consistent with that TCP-specific bit.
>
>> This is a change to TCP only, at least until somebody decides to
>> implement it elsewhere (why not?)
> Side note, I can't really think of a reasonable use case for UDP -- it
> doesn't quite fit with the notion of message boundaries.
>
> Even letting alone the fact that passt(1) and pasta(1) don't need this
> for UDP (no acknowledgement means no need to keep unacknowledged data
> anywhere), if another application wants to do something conceptually
> similar, we should probably target recvmmsg().
>
>>> What about using/implementing SO_PEEK_OFF support instead?
>> I looked at SO_PEEK_OFF, and it honestly looks both awkward and limited.
> I think it's rather intended to skip headers with fixed size or
> suchlike.
>
>> We would have to make frequent calls to setsockopt(), something that
>> would beat much of the purpose of this feature.
> ...right, we would need to reset the SO_PEEK_OFF value at every
> recvmsg(), which is probably even worse than the current overhead.
>
>> I stand by my opinion here.
>> This feature is simple, non-intrusive, totally backwards compatible and
>> implies no changes to the API or BPI.
> My thoughts as well, plus the advantage for our user-mode networking
> case is quite remarkable given how simple the change is.

After pondering more upon this, and also some team internal discussions, 
I have decided to give it a try with SO_PEEK_OFF, just to see to see the 
outcome, both at kernel level and in user space.
So please wait with any possible application of this , if that ever 
happens with RFCs.

///jon
>
>> I would love to hear other opinions on this, though.
>>
>> Regards
>> /jon
>>
>>> Cheers,
>>>
>>> Paolo


