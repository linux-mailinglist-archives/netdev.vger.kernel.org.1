Return-Path: <netdev+bounces-73429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A285C5A8
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE74B216D3
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206E814A4E6;
	Tue, 20 Feb 2024 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ea38OUfV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF85612D7
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460477; cv=none; b=EQV0hgpPm26rPQKvzbvUzrT0IQUhHiEbwQluIaH/iY1wdG/I1Sm2DDSNrB3p+AQkHk+g2HtyjdBT73BZvvN1fA+qdEWSVjR93SrUFvUHz974WdpjDe/c6bxnOZYqXkKxW+Q5eiuSVkQL87Wy7cOypDLTrXpjaVu80AQnk5xx2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460477; c=relaxed/simple;
	bh=aYqirJuk3/oNKJ9jINFWFYkH12+4Uputni2Z6nHnq90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5MDvlHnhuNNzQQi7dOazXudUsjxo1tfJWxm20ae/nlfZnNjvd/fiyLWYEK+YWGAXeQ45RTJg1OkVZD803ZPJXXLod/zE0763C57vlE76PP6rM0FBm7/TNAo4frOqyuvPO+2iDuSUNmOyWbt4H8x1k2oyJl9v5vJtAb5Ep+vpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ea38OUfV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708460474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICmwr65NRqTlCTHFYnuzpiNSz/h6WXrVEn5nJo2+eY4=;
	b=Ea38OUfVZx7KD30FGxOiJToae9FXlActGaQpeJerD6kzt2LcM0pa/6nQ3H/q2MH4/VRDdC
	u3F8gg17wlXBB4BuWFkKNOggI3sPaTbhtiE99sAy053se6+GYKcYvs2Lw11Lwpa6S7k/Dn
	DBButF4xf/8vY1fDsXG4lMGlw+Yj5Fw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-VVQhla_2Pu-b01me8tZM7A-1; Tue, 20 Feb 2024 15:21:12 -0500
X-MC-Unique: VVQhla_2Pu-b01me8tZM7A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7873b392eb3so740519585a.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 12:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460471; x=1709065271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICmwr65NRqTlCTHFYnuzpiNSz/h6WXrVEn5nJo2+eY4=;
        b=DBsibPIVpNP+kWdOW/zkBTf7LHd7jzIwYYaNBtFlaIlV/9xLL4gVnMGR9F9eU3+ZLb
         QFrnpajmsro+Tco3ooPeoJs8xLrOejBqFP6zA7WN5Dj09zwb67+UVgfC3vAiIh2sWMZ4
         N/tz+l49RT4VbRbnbT4TP9+b6L63MeYnkG3Z8LPMbSrs/HUnWrDqmnY4V9uAnuLCh1Wp
         oxa9hXsDYfrZWZ7DETz9SrkfOSzETxKdqLlWNzZbsHL3C1Xu4IpFrprGZ8wDhZSEx/5o
         x/21M0WbK2yGN+T5+CGrtFCDjhGxqg6bZ21NN0ZzPjkY9rIpnWIEWRaQIG1dj79Pd903
         zNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTWbywzzFPOKl4/JJNFgAq8xIrGlwwUrAZ4//oF++t98BfDGwljuYT41uq759rYyV4DbzMAGcxiPQmB4anjuy/gO1cvDj0
X-Gm-Message-State: AOJu0Yy3d6ofF/x2oY9ekE5+5AJ/bfhF1YiXVfwRn0nQaNuf8+grsoAR
	R01MzNLEzDfn4tdLRGD93GLFfnK65GG9qnPkCuxnikFdaDx0Q9kGdkrRggpzIH3blxQ/3qDkRz8
	uSAFRVnxJQUi0MFSHhj0gw3bBZrCWw1GUX9bEKqN/kkDTR9hf9YiCzw==
X-Received: by 2002:a05:620a:13c3:b0:785:c3b7:4e84 with SMTP id g3-20020a05620a13c300b00785c3b74e84mr25284987qkl.35.1708460471657;
        Tue, 20 Feb 2024 12:21:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVlP+JssKBxpt/2WYuoAH3yoYXcCwPlZTAb4meAPQZ8QJecK6xRhnESO+H1+kR4LI3cZ1/RA==
X-Received: by 2002:a05:620a:13c3:b0:785:c3b7:4e84 with SMTP id g3-20020a05620a13c300b00785c3b74e84mr25284962qkl.35.1708460471385;
        Tue, 20 Feb 2024 12:21:11 -0800 (PST)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id j27-20020a05620a0a5b00b0078719b3b55bsm3676203qka.14.2024.02.20.12.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 12:21:10 -0800 (PST)
Message-ID: <5f421a00-bdf1-8cae-bc18-24312b22c0eb@redhat.com>
Date: Tue, 20 Feb 2024 15:21:09 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next] net: reorganize "struct sock" fields
Content-Language: en-US
To: patchwork-bot+netdevbpf@kernel.org, Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, ncardwell@google.com,
 namangulati@google.com, lixiaoyan@google.com, weiwan@google.com
References: <20240216162006.2342759-1-edumazet@google.com>
 <170842742563.6347.16360782364826312051.git-patchwork-notify@kernel.org>
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <170842742563.6347.16360782364826312051.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-02-20 06:10, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Fri, 16 Feb 2024 16:20:06 +0000 you wrote:
>> Last major reorg happened in commit 9115e8cd2a0c ("net: reorganize
>> struct sock for better data locality")
>>
>> Since then, many changes have been done.
>>
>> Before SO_PEEK_OFF support is added to TCP, we need
>> to move sk_peek_off to a better location.
>>
>> [...]
> Here is the summary with links:
>    - [net-next] net: reorganize "struct sock" fields
>      https://git.kernel.org/netdev/net-next/c/5d4cc87414c5
>
> You are awesome, thank you!

Paolo,
Do I need to do any changes to my SO_PEEK_OFF patch?
In an earlier mail in our discussion thread you seemed to imply that, 
but I don't see that any changes are needed.

Regards
///jon


