Return-Path: <netdev+bounces-111949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90629343BE
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 23:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674311F22533
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 21:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4E184124;
	Wed, 17 Jul 2024 21:19:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C631CD26
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251175; cv=none; b=L9xFkTh5kBcjplwzewWL7yaF9uFtdc9VgzqW8YBqRTzQnzigzdkFxLE7UIiqLr030UHRwV4nDduyYBdwKuYZudktT2GGWK24Hk5+ReL0CmpXFhrz0GIbzHTVG+dszQ5+oFlyXVt4LRpBrhxQU2qODene8CD1qPxw1NF8k+OdBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251175; c=relaxed/simple;
	bh=pUN3nKoYA3md5TzyWx376WYFHr3VCEnbeW3txshK1rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfKQVkFGm772vulTmmunCYFDYNIE5k04CVWQJa4uZwgEcQusSD672zhhiGdzOlhd2JLDVPIZui/m+YkV9WNhjnlr+YgmPv91783uvRTA6yaBAJpAdIZZg5nIKbojHkexddQI0SzACmAwgbWGjoCroAcDuiYFbkQyz8ulOynuUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-426659ff58bso100325e9.2
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 14:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251172; x=1721855972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVmOD3PzaV2I7aZUPK+aeE5lGzA2HAjY+dmcoGXY1q0=;
        b=jYVV/Vhmgx2jJp+9ZeBZX5qcFwY9aWk+sobBalS3Xfbw0TVOkQHwNQ3eYikg+3uBGN
         w+k2AqPzK+yEyqwXYlPwp0Vtvjj99FjOoNJUP5H5g1mPg7Qwig3qTO3I5PerjhyTNEx9
         ojmuh8AqwHisF65tM1scaay5gEu5rRDCkpoHkMw4DU7LGVianBJD7j/g0j5ambH5DJjo
         7KYOd7cyzR5izgBuLhX+oAexwcBSNH5WuxSzjjEPalF0mElwpViA862btrN/PhgnCjX6
         3Ao3PQULIZapvht35uRLIB/9cF6JYdLH3sng8UhF5B5odwoc4vItIK8JH7PWeQXD37KS
         JC3g==
X-Forwarded-Encrypted: i=1; AJvYcCUH/pi+hW6DUKdfAY73t5JejOzUVSVRbp4/Mt2nblRrnig1Dw6rS6ZWUYT+YvwLne1OhAMGVvSyttjvoO+0xlDpLOlWSw6h
X-Gm-Message-State: AOJu0YyrRc1gOk1tZ5YZFBrNfEirAYGz4R1BLBVPihZLOshDXGSXTgsb
	cbO+fbH6Fl3ZZvj35BVwGofKhYgYYZ3ztSrWvxyt1RTycY40WBEz7GBvSw==
X-Google-Smtp-Source: AGHT+IFWlVCU0sNu8zdrx75sjTk2lonC9SCGflpxGKwDKTyKRA5khCz98MGqDjxfJPMpLF6KD/UupA==
X-Received: by 2002:a05:600c:314f:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427c2d2003dmr12909895e9.5.1721251171670;
        Wed, 17 Jul 2024 14:19:31 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3684d3c6940sm343564f8f.70.2024.07.17.14.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:19:31 -0700 (PDT)
Message-ID: <9b8b57ca-83ae-43a4-84c6-33017dc81a32@grimberg.me>
Date: Thu, 18 Jul 2024 00:19:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: reduce callback lock contention
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-7-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240716073616.84417-7-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/07/2024 10:36, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> We have heavily queued tx and rx flows, so callbacks might happen
> at the same time. As the callbacks influence the state machine we
> really should remove contention here to not impact I/O performance.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a758fbb3f9bb..9634c16d7bc0 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1153,28 +1153,28 @@ static void nvme_tcp_data_ready(struct sock *sk)
>   
>   	trace_sk_data_ready(sk);
>   
> -	read_lock_bh(&sk->sk_callback_lock);
> -	queue = sk->sk_user_data;
> +	rcu_read_lock();
> +	queue = rcu_dereference_sk_user_data(sk);
>   	if (likely(queue && queue->rd_enabled) &&
>   	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   		queue->data_ready_cnt++;
>   	}
> -	read_unlock_bh(&sk->sk_callback_lock);
> +	rcu_read_unlock();

Umm, this looks dangerous...

Please give a concrete (numeric) justification for this change, and 
preferably a big fat comment
on why it is safe to do (for either .data_ready or .write_space).

Is there any precedence of another tcp ulp that does this? I'd like to 
have the netdev folks
review this change. CC'ing netdev.

>   }
>   
>   static void nvme_tcp_write_space(struct sock *sk)
>   {
>   	struct nvme_tcp_queue *queue;
>   
> -	read_lock_bh(&sk->sk_callback_lock);
> -	queue = sk->sk_user_data;
> +	rcu_read_lock();
> +	queue = rcu_dereference_sk_user_data(sk);
>   	if (likely(queue && sk_stream_is_writeable(sk))) {
>   		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   		queue->write_space_cnt++;
>   	}
> -	read_unlock_bh(&sk->sk_callback_lock);
> +	rcu_read_unlock();
>   }
>   
>   static void nvme_tcp_state_change(struct sock *sk)
> @@ -2076,6 +2076,7 @@ static void nvme_tcp_restore_sock_ops(struct nvme_tcp_queue *queue)
>   	sock->sk->sk_state_change = queue->state_change;
>   	sock->sk->sk_write_space  = queue->write_space;
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
> +	synchronize_rcu();
>   }
>   
>   static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
> @@ -2115,6 +2116,7 @@ static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
>   	queue->sock->sk->sk_ll_usec = 1;
>   #endif
>   	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
> +	synchronize_rcu();
>   }
>   
>   static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)


