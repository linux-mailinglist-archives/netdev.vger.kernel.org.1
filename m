Return-Path: <netdev+bounces-112888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F8493BA0F
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 03:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2FD2821EA
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85154405;
	Thu, 25 Jul 2024 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NUcD6FFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942862901
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721869873; cv=none; b=UYdil3Eja7YufnWP33smL2dtEZeHcwLOisCsLF+D4HyAKxuhmJ5U2mNslomOddq+6d3JFNiBPh0higa5Vz8I+3MIzBu0FlyIiCshKrUE+2fzrsq9SWIlPleerXI4nRpinQm3WSNyr+iCAFtvFRmt0Kk45BVUCalPTYBC0zWf9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721869873; c=relaxed/simple;
	bh=GuQ7uzO9RR6Btq/IZD/s6I0IN1SiKxdRgJmwLTnBYRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSak4f4grQ/JROV4usARM1pHgFvB6GR1q4wglmDtB+5O6Fypeo0xCapJ4MTxp5TMFJ7+Nq9S9EmokcTQEsgAf8wVTCdNqNqGoMpF0I/l6FsZv962KLuTqgVVixnhUMpE9MqRaCQHupBl4pyxC3G9pug+3EPISIN3Vz3iBlwL92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NUcD6FFP; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso402594276.0
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 18:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721869870; x=1722474670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oR9AQB3i04gqZs2o3tjOMuJV4rhvx1XpYbYSgIhEe4=;
        b=NUcD6FFPGay+UJslXR+79/lfsT30LIUKGN93CU65KmTWkPCNv/PSQSp/LX/ZG7pcke
         F1373FPAl7AgQSYqLC6shQeZCzDczw7pcKE8MmacxULFPCPlKJNxq8986inN4Y7mnTMY
         JWWnb+rEvOoa+EpcjUJ9kSeEhMWNWkFIWNyafO4ZHlE5bSGPLUVlcNEDObZ9qPv2t5xo
         qQ/ThGk16yh7q/YcVZ6uXFz3+KQtQnfrE2ZGvz79xbgvhnlBRChGs9cKSrl63yjeAybJ
         9AZhHJya6yk7CXcpgwAO+HFfJCe0enmc/wsZiu4OTZb+Mt/jDGMmP7GCQBzujAsd0I8v
         ubZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721869870; x=1722474670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oR9AQB3i04gqZs2o3tjOMuJV4rhvx1XpYbYSgIhEe4=;
        b=gpZUItcCXID7542Kq5lgrHsjlfe8iYN2AqskOfZbelPb0g8efMdJOtFrf01cWY4ObH
         8Xozf872urYu74Jy1jQ527ubdb91aC6IeTayChoL4opzqwqxvZOXCcz7wttPfvlxWWIp
         Hit63pBBGyjLOxhW6GzXvAutgGPOZLUC8gNzw9z7ooly4Cmpc8DfwUqW3VPy4S57VYQ9
         Gdev31ixSD36hYaUAJ2FppOA70a7HejGW0BMxugpXorOMzSmPXV/vLEuWQuX05SDitqv
         yUT9VigISZAJ9BZkWsQnHegZKEv1yvTT925boBp6J3w4vGb+0PKhak/SaRZJMyGHwxyb
         scjw==
X-Forwarded-Encrypted: i=1; AJvYcCUsI6lqFAM6v5du1mh3nU6+SsZZSSjlc6r4s3adV7w8gJHy/BmBzQt/fsGsHVArsnSYNty+PxObMsfxRMyirjH6Rxq1oNeY
X-Gm-Message-State: AOJu0Yy6HdP3Ib97EFW1Do+G1wB4wCJHLkFH5UAIG57M5sXQ1WG1/E/2
	NTje6H5FFYeFrKrF13RGoABxR7AxOsL9KHPOa2wq2mvtu+OytgVC19Dn32nAMSA=
X-Google-Smtp-Source: AGHT+IEVJyQ8VA+V1M7uNFddb6HC9zV/OM6qoXJXk7zYNFCSyJ198MO4QT2M6myH/7NjT30VXuVb3g==
X-Received: by 2002:a25:c512:0:b0:e08:5ee3:7a13 with SMTP id 3f1490d57ef6-e0b2321a116mr1494680276.15.1721869870402;
        Wed, 24 Jul 2024 18:11:10 -0700 (PDT)
Received: from [10.5.119.35] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8dd342sm1676806d6.6.2024.07.24.18.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 18:11:10 -0700 (PDT)
Message-ID: <d53adec9-10d5-41e2-8065-3826029f6134@bytedance.com>
Date: Wed, 24 Jul 2024 18:11:06 -0700
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
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <668d680cc7cfc_1c18c329414@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/9/24 9:40 AM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Users can pass msg_control as a placeholder to recvmsg, and get some info
>> from the kernel upon returning of it, but it's not available for sendmsg.
>> Recvmsg uses put_cmsg to copy info back to the user, while ____sys_sendmsg
>> creates a kernel copy of msg_control and passes that to the callees,
>> put_cmsg in sendmsg path will write into this kernel buffer.
>>
>> If users want to get info after returning of sendmsg, they typically have
>> to call recvmsg on the ERRMSG_QUEUE of the socket, incurring extra system
> 
> nit: error queue or MSG_ERRQUEUE
> 
>> call overhead. This commit supports copying cmsg from the kernel space to
>> the user space upon returning of sendmsg to mitigate this overhead.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> 
> Overall this approach follows what I had in mind, thanks.
> 
> Looking forward to the discussion with a wider audience at netdevconf
> next week.


After wider exposure to netdev, besides the comments in this email
series, I want to align the next step with you :)

Shall I also make this a config and add conditional compilation in the
hot path？

>> ---
>>   include/linux/socket.h |  6 +++++
>>   include/net/sock.h     |  2 +-
>>   net/core/sock.c        |  6 +++--
>>   net/ipv4/ip_sockglue.c |  2 +-
>>   net/ipv6/datagram.c    |  2 +-
>>   net/socket.c           | 54 ++++++++++++++++++++++++++++++++++++++----
>>   6 files changed, 62 insertions(+), 10 deletions(-)
>>

