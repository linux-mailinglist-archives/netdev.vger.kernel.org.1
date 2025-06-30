Return-Path: <netdev+bounces-202322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DECAED4F1
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3406C3B037A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 06:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8E91FFC55;
	Mon, 30 Jun 2025 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STlh4usE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA11A257D
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266303; cv=none; b=Gz42V7a6cYSK0dECQp9NWnxFfMtUtFtIbmW7dTgjeATyd7KzaSuW18WHte35hO/Jua6s8nhYkQpZeP1fyLb6VDc0yKz8GIvSgH5izte2jV3WBkwq3/JoWeIXIxJTTQ8VxDQrKozXOl+cIH5Nzynjjnpp/3SVO2dxlO+tp7FgbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266303; c=relaxed/simple;
	bh=1j/BOe6+uj6Rz+5EFQPn/l2EbhGasamVZqKuVWNilXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN8GOGc7y7UTUmx+0GG5qp4Oo0jBTDnAbq2k6ijuDaYKbOQX9xavFFAApOBgkrgAb2jNieqpF/aM6pd1WzdCbC3ihBv3SzXf3Oml6XkYaOf65hTC4iNkw+A/fdDERulvppnqsUPCOdcja3TrQvWAZV5VNuszFtzHWV10stJmsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STlh4usE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751266300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14L4bSmzMK+Na24jtHZlikcuCB46GClv+lCWBOsYn3k=;
	b=STlh4usEn47VbIwrXtqexLmFRyhToawRfvFoMaSRPz04+hGRzeWqLOZn8iYJkbMt+japC6
	ZXmnsYJ7j6OhFRQmqHMqmqvKNRNTiv9M1vg0g7cx3O5l/7aDcaex1sHiK77MzR92zL6swb
	5cH04OnT0X0exCR2U4sv8BNpOFYBem8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-p89xTbqPPCqVM0lGh4-hzQ-1; Mon, 30 Jun 2025 02:51:39 -0400
X-MC-Unique: p89xTbqPPCqVM0lGh4-hzQ-1
X-Mimecast-MFC-AGG-ID: p89xTbqPPCqVM0lGh4-hzQ_1751266298
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4535ad64d30so14174405e9.3
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 23:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751266298; x=1751871098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14L4bSmzMK+Na24jtHZlikcuCB46GClv+lCWBOsYn3k=;
        b=sYdB2cdALwlSxux1NWwR5+eQ3Vdigd7RDqnSdF/CpNtBR22yV0HMsnDR8hrOCFi28y
         5UsxZXjGtgprgczV1/mTq+w4wKvbSLgFJwsjT2ILHlPCuYHs/6fj0YHWBHwrP39GKeE0
         XO1GIosLEl7shJUAwNEIOnpT6m5/CEkEzPbjgf9LO0XPcWarihvXiTn4n6hqh+0OwPbf
         F/JjeDMKN+MJTK5FlceHurGLjkeEHfq3BO6ZZ3clmXL23FY7g+37BsfW1p5y7alC+9G8
         bLxCkxqlUcgnsIw4xoTS8VA9zyLG2SBNjg6dnc2JQFSzbCcLnnFNq8RGeFUVRfEOWREj
         Gvsw==
X-Forwarded-Encrypted: i=1; AJvYcCW81w3lha4nsxLCzF7V1kbN2ytx8M8n8CugNmS9eX8zI854xV6VrCYXnbQSdqckT/uUjXgAsvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSylx9q2EA/5WohmEHQBjsGM0kg4m1Y5VskuSK29kz+AjpAOq
	jlURXDQBfdaUOBYLXX8q8FBWiywgrSPlGoCFbbgWmhFNfkeIrAKdmHUBgj7KUrjadJaMpKlClUs
	9yNvKR8Eq0SnTo4MfgntthxMgO6v4ScKJoHFYSmlAOhHD5FMaqxqffuBlGg==
X-Gm-Gg: ASbGnctH5N6N90uPvMEfiUY2LALjoKtDGpT90mdJ/asG6bV4vxZNd6XsE7EUoc9A4iG
	4kwBJf9FCUuwmXwoMkvMzdpblJn450c2prmNNhik3ao3XRURDr4tlQOJkFObXy30xLZDTnVslDW
	gfJ6EAD20yIXFDUD0uBIR7L2C4oU+MelyMkaXECgh66lh6+qxY7R/MY4wF2ztcxdvJQNTWCIETv
	3HD8uwCNXj8K5KNdu75A4wNcLYOGxl5MYPJ7Sze2MCNNHH9i8MhkrVbqNvuEHPCTvpt1Q92xjmX
	JNMWuWjpsAFnP4twGJF+xC2GJrnPPBCz1KzCOAq8nUSpHquZDEJNQBKaftlStVnv2DzZFQ==
X-Received: by 2002:a05:600c:3e8e:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-4538ee5ce0cmr113844425e9.8.1751266298034;
        Sun, 29 Jun 2025 23:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8OzcnlTDoCi5GaakFcUjFo98VZ0Lu6zkZMiLKUwkNiF4+gQI+xZELrNOEu2y/m9jGEUvL0Q==
X-Received: by 2002:a05:600c:3e8e:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-4538ee5ce0cmr113844085e9.8.1751266297611;
        Sun, 29 Jun 2025 23:51:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3aba76e40c0sm5286272f8f.59.2025.06.29.23.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 23:51:37 -0700 (PDT)
Message-ID: <83640113-ae18-4d5a-945a-44eef600d42e@redhat.com>
Date: Mon, 30 Jun 2025 08:51:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: syztest
To: Arnaud Lecomte <contact@arnaud-lcm.com>,
 syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
Cc: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org,
 jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 tonylu@linux.alibaba.com, wenjia@linux.ibm.com
References: <67eaf9b8.050a0220.3c3d88.004a.GAE@google.com>
 <20250629132933.33599-1-contact@arnaud-lcm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250629132933.33599-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/25 3:29 PM, Arnaud Lecomte wrote:
> #syz test
> 
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -123,11 +123,14 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  					  struct request_sock *req_unhash,
>  					  bool *own_req)
>  {
> +        read_lock_bh(&((struct sock *)sk)->sk_callback_lock);
>  	struct smc_sock *smc;
>  	struct sock *child;
> -
>  	smc = smc_clcsock_user_data(sk);
>  
> +	if (!smc)
> +		goto drop;
> +
>  	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
>  				sk->sk_max_ack_backlog)
>  		goto drop;
> @@ -148,9 +151,11 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
>  			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
>  	}
> +	read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
>  	return child;
>  
>  drop:
> +	read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
>  	dst_release(dst);
>  	tcp_listendrop(sk);
>  	return NULL;
> @@ -2613,7 +2618,7 @@ int smc_listen(struct socket *sock, int backlog)
>  	int rc;
>  
>  	smc = smc_sk(sk);
> -	lock_sock(sk);
> +	lock_sock(sock->sk);
>  
>  	rc = -EINVAL;
>  	if ((sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) ||

Please stop cc-ing netdev and other kernel ML with this tests. You
should keep just the syzkaller related MLs and a very restricted list of
individuals (i.e. no maintainers).

Thanks,

Paolo


