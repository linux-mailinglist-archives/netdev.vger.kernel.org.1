Return-Path: <netdev+bounces-225149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2516B8F931
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ACD3A3A7A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2519223B616;
	Mon, 22 Sep 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZigvFC6y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798CE9463
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530278; cv=none; b=Pfge7DH01nIG0hjVEm07jvtBcumJKCVMxh2KbfFXx0z+A2YKo7nuYILz/GuNK93rdtqh7IuxF1ujyOCB6kfNVpNtSm56ECryoUC/gXrvliS6djopWmLqq1AlVmWNc4jJiUgivXqwKJc4CyrZqmFjU9kEHFC9oXMzZE2Y7P9hQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530278; c=relaxed/simple;
	bh=ANuIRDa/oBvcBLBrhPrywckoT+/jTCxOg2GGK3LyltM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CyLhz0OkGL6yHEiFIcDKjIvp2qq8C3v0uX96DJxHU1eR/6/og1IqjTaqdW1vanyQPcQsdStnqaNUqssowBOtgc64eTKhsiFN71nIHDJqceiAmnCedW5YTUK/LXo5QQGp6LQNkQL0MVrABHCSO/YuVaaJ1fxH9xhMys+VWhDqP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZigvFC6y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758530275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5q2GXRJ54oLFi7klNa5d/CvCPn9FGbasths4DAcw64=;
	b=ZigvFC6y96pdea49QHUHQLyR0Gl68cDZ05OCxJ8irVgJAhge1130G5siX18gegapqw7l4J
	Rv6h2wCjz5DaKvg/zmIw5txg/JHp3HAiN08AflfRaUEi/FMCwQFdi3wHeKw2Ij2cCZKqV6
	gAE3Uk9yyfpeapsxKPh/74st/wThLB4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-BKswhZf_OQKu6VYjHdhctw-1; Mon, 22 Sep 2025 04:37:53 -0400
X-MC-Unique: BKswhZf_OQKu6VYjHdhctw-1
X-Mimecast-MFC-AGG-ID: BKswhZf_OQKu6VYjHdhctw_1758530272
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so1753502f8f.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 01:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530272; x=1759135072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5q2GXRJ54oLFi7klNa5d/CvCPn9FGbasths4DAcw64=;
        b=jePN0CVDBy73V1hsry8bp3Fdiz3Nf6A94py84ttqViPyt8pQlseWglR0wy3Er+96xq
         oWVQRX/zNoSwQDZQjPwqivPkVcPXFLLkO4mCv2d7OmjOqTVPLgw4Q2xcrKEcMFabFeFY
         0N9E/fEiflbelKc80DDrPMXShdUGxghcrLc9LKwTf8hOMsusPMORUkr1f2t8+0XeGfKv
         lhG2YCKoVdLrj+UPrLjT9UGNenVP1qdjz9G4a0VsgkLf+1KW9M4R7KSR9KEcGMIyG6Y7
         CUyY/VWWfCkke//7GS4nOqJYNs2VQK4ohreOBrC8QAJ7TpvxvGs7IfXOp3O4kQL/lEer
         qTjg==
X-Forwarded-Encrypted: i=1; AJvYcCU6+zRJ3YzzIh8/XDCST9cz+ZgRpaqgJQ0/hL4DHO9lUiIEP0V67oOjXNn1e9W+is4bWNBIPxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZK1YRbjcneAKmhAEK5mgkMRzwNfrgwiZcAZIX7oQco1VniL3
	Wf0mbfyvTqTQp6LMy9CjpMPGL5d3XNUGJTeftRduwLu5xKH9VPr3qMhklKPJGd+jhJ8EuzkLF6Y
	GK1NtLGT0q/q8riC6vK+1C3BaPEtyDmSBSt6U1GaeMIM95h5ZQD3DIQym+A==
X-Gm-Gg: ASbGncsECKD8FWE18K85vxFBaXlnGJUgLNLhjm41woeFPcLe9lo0CMR/+GSPpEzX6xf
	FZCXwLFGxcZhIVPCr20HHU4vQX9oDGxsiy4Eu3DJD6h10bOK7AE2i9DIPlgUiGoPEaovVU3YlR6
	BY8GLFS6oBBd5CAFqshtBccYwS0Bg3OrEm2USwW35PxxFkwCTvda2ahWEVBp2T4B6zco7H7aJMu
	l+16DuGeb7FykfmzyYR3zBRMibDPU86iCrWa7UTx5kBAjz6GDf0j+JucCSJO/DHiGI1PaFhxNgI
	FEYCoVUcaAZY8lB/4ub1ksBMn7FDbau+zW4iTXyoRTQX2VssUK3gGixgWQfdoUEe5533x/xHZkP
	SzY8PkWXYFxeQ
X-Received: by 2002:a05:6000:268a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-3ee83cabcdemr7304613f8f.37.1758530272313;
        Mon, 22 Sep 2025 01:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH9nMHmXt1YsZmsaIC9UY/PMJvQS5NHSJoz7nNI/11G2EItqSlzg0PNSyD7483fm2PcPhqqQ==
X-Received: by 2002:a05:6000:268a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-3ee83cabcdemr7304589f8f.37.1758530271841;
        Mon, 22 Sep 2025 01:37:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46138695223sm235220205e9.5.2025.09.22.01.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:37:51 -0700 (PDT)
Message-ID: <3fbe9533-72e9-4667-9cf4-57dd2acf375c@redhat.com>
Date: Mon, 22 Sep 2025 10:37:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250921095802.875191-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250921095802.875191-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/21/25 11:58 AM, Eric Dumazet wrote:
> @@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *sk, int size)
>  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct sk_buff_head *list = &sk->sk_receive_queue;
> +	struct udp_prod_queue *udp_prod_queue;
> +	struct sk_buff *next, *to_drop = NULL;
> +	struct llist_node *ll_list;
>  	unsigned int rmem, rcvbuf;
> -	spinlock_t *busy = NULL;
>  	int size, err = -ENOMEM;
> +	int total_size = 0;
> +	int q_size = 0;
> +	int nb = 0;
>  
>  	rmem = atomic_read(&sk->sk_rmem_alloc);
>  	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
>  	size = skb->truesize;
>  
> +	udp_prod_queue = &udp_sk(sk)->udp_prod_queue[numa_node_id()];
> +
> +	rmem += atomic_read(&udp_prod_queue->rmem_alloc);
> +
>  	/* Immediately drop when the receive queue is full.
>  	 * Cast to unsigned int performs the boundary check for INT_MAX.
>  	 */

Double checking I'm reading the code correctly... AFAICS the rcvbuf size
check is now only per NUMA node, that means that each node can now add
at most sk_rcvbuf bytes to the socket receive queue simultaneously, am I
correct?

What if the user-space process never reads the packets (or is very
slow)? I'm under the impression the max rcvbuf occupation will be
limited only by the memory accounting?!? (and not by sk_rcvbuf)

Side note: I'm wondering if we could avoid the numa queue for connected
sockets? With early demux, and no nft/bridge in between the path from
NIC to socket should be pretty fast and possibly the additional queuing
visible?

Thanks,

Paolo


