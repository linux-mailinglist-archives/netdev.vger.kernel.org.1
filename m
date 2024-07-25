Return-Path: <netdev+bounces-112903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F393BBAE
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 06:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EE41F22595
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 04:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9E4690;
	Thu, 25 Jul 2024 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MDfcJQ/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D60EAC0
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 04:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881131; cv=none; b=dzJF5B97/1AQ0AS/9a0dm1ypIlIxp0DOrvNX9oTBAzdKTnY54/17MBifdUEsi57h2KqMjY3PIzskSB4YAIHzJJZNF4IGyJ4AZXaQj8jy/e7ncT2oGoj/wRqXRejVHbhIy1yAnR+8Vz81xi3EolMsxrF3dNLhR7VEOwyBfBUPc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881131; c=relaxed/simple;
	bh=VDORdj41wiIp4FXbLXuy7E+y/xO0OgZhQH8rbCKYm1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXFIw+q71nKITj0TOpXR751PfPFtA4M3RZQrNQZa7TX4mPKUELf+OZPLeTIE8skUTXFNVG7CcwHbRLqqxAhD3GEKB9gyfjyPLipBHr/ea0JIwH8JxfUVQqlJpa+YDy1JnspHGd8qtBy+iPEdc4rLzDyM2RUV2fwR73iddk5hreA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MDfcJQ/E; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so440386276.2
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 21:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721881129; x=1722485929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xX0YfWVeuh/rUzkRWu1vXG87bxH6PBcVEHhEEi118rE=;
        b=MDfcJQ/EuuxjUr9R6W5235bMGciTa6Q480+Pa+ZmFcUKCx5t1xAyEY5Hd+6x580czN
         CGaHLfSl5Gh5zqIk/O6H4IAApazGGydbHo1B98nfzt4VLROJd8l+6NjZ4SCul2gx4VfL
         /pxIxrfcV2/fsmNv4EktNc3BXO+pFFmJnUQAyZgDs8a8zYFpyn5qz1UsOFsz8WIRHbWy
         3MspqBmYZwa4C62G+n8Hz1uk+cS3pHkc5z85RWb/nl4XotHSPttvb7LrvcPeoXUALv9d
         Vxee5tIh7jTUWI+Dy8IkpSk5wl4xzNjdeFc836E+x5i1B150UzHY9W4gbWENkDHGgGJX
         xyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881129; x=1722485929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xX0YfWVeuh/rUzkRWu1vXG87bxH6PBcVEHhEEi118rE=;
        b=QtKZtImp3ZPoTZWpNmCtGcWdZWBfurVZAxDJujFqqDAlDoGzj+Z7sOceQcqEHZqbZW
         hchOomvYGqXhEAKOrZDJSabdziq4zKorNWQJ3PlJGKp+r6684JGpqr1GehrdLkZ0T4DQ
         Iz6UbgkrshLRO/PAwH5/hKSqzoBMY9mSDHSeA7iADLwMRZL3UI/3sOAtXF7FRw4Mc65u
         sqLrrKKJEdBVzEsPqQvE+PAgFwg5+fRkuDv4HxEAjN9DdrZomwANqXJMF4MH42kU2AfD
         jzuKn2k4CwyrZ/bhaKb1imRb6zdavTHQLhdI6bnE2Zbxr0nUqHfrixqx965hwB3oSZyM
         PwIg==
X-Forwarded-Encrypted: i=1; AJvYcCWO3OOMnjI5E1lAsuXn5UEi3PAbOBpY5fsTGeBqoUeCy3gK8rxRbG4q1srIz0K4ODZ8WkY6mScMvo7kgyAjnCx79XX/hB5O
X-Gm-Message-State: AOJu0YyJdbBGUmzBpP1l2vhAGyLcUt+WHLGr7ZYIWLf5O+AC66VXBz0l
	jj3SQr4rI/zd3KiUBDKHKqWPGeifwOHXU4z10S64wannEZFZsNaZgVhxUQuhtRM=
X-Google-Smtp-Source: AGHT+IHC1VllVLUxRmR51+Mg/+0Nwr6WLuafHazzT6E8amZPTgcwher4mPd+dveMwIfzxl27VA2MOw==
X-Received: by 2002:a05:6902:278a:b0:e05:fc91:8940 with SMTP id 3f1490d57ef6-e0b2ca7c96fmr657628276.22.1721881128690;
        Wed, 24 Jul 2024 21:18:48 -0700 (PDT)
Received: from [10.5.119.35] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8ddd7esm3077956d6.15.2024.07.24.21.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 21:18:48 -0700 (PDT)
Message-ID: <eb8da70b-359c-410a-b029-8bad5ba04389@bytedance.com>
Date: Wed, 24 Jul 2024 21:18:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
 <668d680cc7cfc_1c18c329414@willemb.c.googlers.com.notmuch>
 <d53adec9-10d5-41e2-8065-3826029f6134@bytedance.com>
 <66a1c1bee3fc4_85f9929439@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <66a1c1bee3fc4_85f9929439@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/24 8:08 PM, Willem de Bruijn wrote:
> Zijian Zhang wrote:
>> On 7/9/24 9:40 AM, Willem de Bruijn wrote:
>>> zijianzhang@ wrote:
>>>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>>>
>>>> Users can pass msg_control as a placeholder to recvmsg, and get some info
>>>> from the kernel upon returning of it, but it's not available for sendmsg.
>>>> Recvmsg uses put_cmsg to copy info back to the user, while ____sys_sendmsg
>>>> creates a kernel copy of msg_control and passes that to the callees,
>>>> put_cmsg in sendmsg path will write into this kernel buffer.
>>>>
>>>> If users want to get info after returning of sendmsg, they typically have
>>>> to call recvmsg on the ERRMSG_QUEUE of the socket, incurring extra system
>>>
>>> nit: error queue or MSG_ERRQUEUE
>>>
>>>> call overhead. This commit supports copying cmsg from the kernel space to
>>>> the user space upon returning of sendmsg to mitigate this overhead.
>>>>
>>>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>>>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
>>>
>>> Overall this approach follows what I had in mind, thanks.
>>>
>>> Looking forward to the discussion with a wider audience at netdevconf
>>> next week.
>>
>>
>> After wider exposure to netdev, besides the comments in this email
>> series, I want to align the next step with you :)
>>
>> Shall I also make this a config and add conditional compilation in the
>> hot path？
> 
> At netdev there appeared to be some support for your original approach
> of the application passing a user address as CMSG_DATA and the kernel
> writing directly there.
> 
> That has the benefit of no modifications to net/socket.c and lower
> overhead.
> 
> But there evidently hasn't been much other feedback on either approach.
> Since this is an ABI change, SubmittingPatches suggests "User-space
> API changes should also be copied to linux-api@vger.kernel.org." That
> might give you more opinions, and is probably a good idea for
> something this invasive.
> 
> If you choose to go with the current approach, a static_branch in
> ____sys_sendmsg would make the branch a noop in the common case.
> Could be enabled on first setsockopt SO_ZEROCOPY. And never
> disabled: no need for refcounting it.
> 
> Either way, no need for a CONFIG. Distros ship with defaults, so that
> is what matters. And you would not want this default off.
> 

Agree, the ABI change should be the main concern. I think I will go with
the current method firstly, and the original one as backup.

Thanks for the quick reply and clarification!

