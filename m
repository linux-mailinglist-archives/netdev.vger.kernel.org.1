Return-Path: <netdev+bounces-148435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A58E49E1A46
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDAB44B7D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22081E0B80;
	Tue,  3 Dec 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uflgpnjr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401161E0B73
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220264; cv=none; b=UMyXjOLxmyLfGfDm9TxOPKYc8VmBBa2+rB6GGr3MsMQeB5bKoDuH0fCHeSumqURIwEnlwO0n4Z+eA/EEdfYa+yxOR6nhmEXwTF9S4pqsofWa0MceqUgFWV0ZoKhQzRL14W80KXa050KqVO+h7Qd5vMtNWo+6D3FJuBTh2ksfxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220264; c=relaxed/simple;
	bh=HQ44SPqVqENJTbQrYY2kZjK603Ln//DhUNKAfXJorFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NB5+IYCzcyBNhNSeotmvuuFvcM/q3hynn4rsPaoylqXpYJ73PQPVS1h3TulL7ZlY8Rmwz+xxdzYND7kA2kYXbkgHhXCksIDk675COkcfv9op1DBET5sNh1z+MeyPhKtSweBdG60ivwtPdJNnWAZLxdK6RvsygDMJoxEt6w/uLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uflgpnjr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733220262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Yz/wh2DDx3kpOempfoxxI4Bvmg2kZ7VVay1dulTJk=;
	b=Uflgpnjr2EI17bH3TFgQx3OaKrSpMfeVr+1GQp2onAL3Z2LM7xGPyyrClUrMRJ5+bjtI+M
	rE5qQym3FsHVTJrwT4o9QDau03G8jVSEJld03G5qQAx52hZVkxVrxJBJz6pwtDE1ToKork
	6+fB9HvyrZFknmHGlTnfuHdcaA4pGI8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-gzX-rSj1OnK7HFZZkK-G8g-1; Tue, 03 Dec 2024 05:04:20 -0500
X-MC-Unique: gzX-rSj1OnK7HFZZkK-G8g-1
X-Mimecast-MFC-AGG-ID: gzX-rSj1OnK7HFZZkK-G8g
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d87f4c26a7so66206636d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 02:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220259; x=1733825059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6Yz/wh2DDx3kpOempfoxxI4Bvmg2kZ7VVay1dulTJk=;
        b=UPBtracQfZ840doRoC53kMmBTPGG+6OY06W9yV5LB/p1asjyd/JJe/GZ+E2TQBn3oP
         SJZhhZGmkoutgQRwznCaBNxqTrDDZk596VAmfPokQaHLVPGm9BrY7dedIMn904vqun0s
         eGYzc/zfV1V4kgP3RIwFxGuCMDd7/Qo2KlN+QpcgIcV5SRncz2KGCkxMdedBcCK8IG7d
         GPKPHtj+wKiF0fmdJuKnIPhUXcb8w7DqdbO2jwBzEwzg24eIoyPIw5PQex+ZdG2yAAQb
         Dr7YTVXJE7z+I7vzCmV1fNBbwCPRhDHE8HiD+1petN0oiGgw8yrHf+2snvMlaI0xexVX
         QwJw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8Thjvo7X/+0Qce8Ef9u4g3i+6jmBGC8d26RXGtuY6iZK+YW+I7FTWpkesbGvRExUjJ3kKow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKpxc/Lrrtu1QRIzdy/iUEQqd36LzmWLrVnFr2fLoIXFaGI842
	9QUyoxS70UDYDdr5R62SLJmSUTkbExTwjAvJqbVMaRfEg1pdCrC/dM1Lag7X56/s/J4PmL2MCND
	SGbK11LkauYz8LJBRGrbQP7CSRnmf0CTPmTRGZTW3tytvj4sIiA8NKQ==
X-Gm-Gg: ASbGncvYM8DhFV4PcvBRiP5XmzM3MmFufRibsSfLVtSIpjrC2MA1yIbeZ6voPLWSi3x
	eVRK7OCtmgogn9YohjqP94BrPBaUgT6eSRMiwZcO0UflFtnAfkjivWrqbRtzyrDIWcYxzqUq9N1
	4zEFomtwcP8UlKzmW92aFvKIwabhomxzgNNXStJQSh2J0emStpRxavVZr62uweuMBT+M+KVDoDl
	mdzkzeNnZwzIqVxuhwgnEZTPrYQtj1ANIq1330EAf2uabpahkFvE2rxFSFnWGEPHoD4G+f/0t3R
X-Received: by 2002:ad4:5dc2:0:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6d8b7389459mr32032246d6.25.1733220259673;
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1K5nqkk2YWvJZ36M/30xTQ0u4uphAR9Xza3eEbd6ZgDvKckxS8QXJ6vo2298noBcWsm6LJA==
X-Received: by 2002:ad4:5dc2:0:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6d8b7389459mr32032066d6.25.1733220259408;
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849c35efsm496606685a.118.2024.12.03.02.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
Message-ID: <62cd6d62-b233-4906-af4a-72127fc4c0f4@redhat.com>
Date: Tue, 3 Dec 2024 11:04:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net/smc: set SOCK_NOSPACE when send_remaining but
 no sndbuf_space left
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
 <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/28/24 13:14, Guangguan Wang wrote:
> When application sending data more than sndbuf_space, there have chances
> application will sleep in epoll_wait, and will never be wakeup again. This
> is caused by a race between smc_poll and smc_cdc_tx_handler.
> 
> application                                      tasklet
> smc_tx_sendmsg(len > sndbuf_space)   |
> epoll_wait for EPOLL_OUT,timeout=0   |
>   smc_poll                           |
>     if (!smc->conn.sndbuf_space)     |
>                                      |  smc_cdc_tx_handler
>                                      |    atomic_add sndbuf_space
>                                      |    smc_tx_sndbuf_nonfull
>                                      |      if (!test_bit SOCK_NOSPACE)
>                                      |        do not sk_write_space;
>       set_bit SOCK_NOSPACE;          |
>     return mask=0;                   |
> 
> Application will sleep in epoll_wait as smc_poll returns 0. And
> smc_cdc_tx_handler will not call sk_write_space because the SOCK_NOSPACE
> has not be set. If there is no inflight cdc msg, sk_write_space will not be
> called any more, and application will sleep in epoll_wait forever.
> So set SOCK_NOSPACE when send_remaining but no sndbuf_space left in
> smc_tx_sendmsg, to ensure call sk_write_space in smc_cdc_tx_handler
> even when the above race happens.

I think it should be preferable to address the mentioned race the same
way as tcp_poll(). i.e. checking again smc->conn.sndbuf_space after
setting the NOSPACE bit with appropriate barrier, see:

https://elixir.bootlin.com/linux/v6.12.1/source/net/ipv4/tcp.c#L590

that will avoid additional, possibly unneeded atomic operation in the tx
path (the application could do the next sendmsg()/poll() call after that
the send buf has been freed) and will avoid some code duplication.

Cheers,

Paolo


