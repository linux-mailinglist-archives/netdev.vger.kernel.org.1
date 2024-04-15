Return-Path: <netdev+bounces-87787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A794B8A4A5B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C93928166B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3637142;
	Mon, 15 Apr 2024 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD3tzoNv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40353715E
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169770; cv=none; b=Gd7WtjOdPwZ2bgX0NuOTg1sVWu0YaAAWPLtExRTLOLxtyOqEf3/g7rcyEPB2i4UsyXk8RFbQKuYD0BZ9GX2jBgHwerMNc2EU0c9rMsYJnKokIrDKwNfyE1vKyYHKDv0/xFhkD0LBc7d4G8MjuTmW1O7frVMuD+DL4lakXdK9Q0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169770; c=relaxed/simple;
	bh=g11QqmbkDPrU2HyfPuX2M8pembz+Hi35FyACwPLnOIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY0VWisgDX5X/N+6OftNq3BFU59ApmCGK1OI/dyOLILyfuYYUwb9nvs0PLPdMXQC4IqdVy1OfQ7tUwKy8mtcT6QO1Tmp3nZDO5UcN00mii3TvQ5juLxKK/NwZ49GvPQ9ozUprbnioMzoCw2iLuBt/fsjVMtA/OAUz8LyceZhor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BD3tzoNv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713169767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+tf9SnOnHLqT5q4tQiv3UN0FjYFcbXUVL6l2rl/L1I=;
	b=BD3tzoNvd295fcZLGPFPbvxQUCala3L1emE8H0UvfbilSEvD+CvD7PReWUqt62z6/menG7
	VCp9dhS+c0ra4yoPvAvC1+OpQjYUsRNi9AhHa2HSq2i1wtPhGykz50rW1ZkQl3mW7On21a
	BOc8sq7W+fYYG0zgxyuZKZNRFdssCws=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-iF06_n8IPXuPw6nZnY9Z7g-1; Mon, 15 Apr 2024 04:28:56 -0400
X-MC-Unique: iF06_n8IPXuPw6nZnY9Z7g-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d883dab079so27467411fa.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 01:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713169734; x=1713774534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+tf9SnOnHLqT5q4tQiv3UN0FjYFcbXUVL6l2rl/L1I=;
        b=Bl1GGgFqnRORnh+EHNsBw1U+fyav2GIoxjBWP0PLzVxxQj1khyhbZZ/oz4pbQLgg3/
         /EJAF3/pBFAfZIi/f7pTioLQqkSHc1xUl+l+zS0+P0pWQ8lrGbXihfGW2K3se5kPDPMI
         YtN3ytYDcEiHcQn9EI3SArA9WHelWWVHy26D2eldc0iYFvucAjZng49LvfiYlopva7lo
         LOguv2BBukhv+Y5rJKEfXPX+4/XMmwRgFdyuQZ2MeikIwHPMXG1SWz0wz5KB89syBdMP
         G+xJgD7tG7krQMxLbe9H94VFFseWAYuf4XvpaQYeCvvCuS5EK/qVChM+pzeogXuD9xUA
         0QWA==
X-Forwarded-Encrypted: i=1; AJvYcCUEToioZp7NJDrTEMyNJq7ZVRqDPJth3VSrqXHbGWeOxJzhjnRgHgnaPr3ZbOI2uJYPlc/PdqnWrepEFy4kRXtEMaCcmsdu
X-Gm-Message-State: AOJu0YyFMlSH1pIlqEi7ccv7gGp3QzJVhNQhWLB0XNv8QRFz5sY0xLMF
	m/qoNe5tJrBglSw+jmCxBahQrASq9zH3ukWBfw3c5V5G/J9jmRp8mPTNs/j1M/T2XRjj1uDxaLS
	UWfvwNkP2C5TnRBQkfIGE1R2VsOts81tnRS4+dqsaMj+0Uw0Nlf2eUg==
X-Received: by 2002:a2e:3815:0:b0:2da:5f41:10c8 with SMTP id f21-20020a2e3815000000b002da5f4110c8mr2451686lja.3.1713169734451;
        Mon, 15 Apr 2024 01:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnaWhO8kV0NnEt1Tu69gzDj2un/ADxh/1SZoIktVoFWj49rCxo2t6ZtkoKKWd6uKza2mxtGw==
X-Received: by 2002:a2e:3815:0:b0:2da:5f41:10c8 with SMTP id f21-20020a2e3815000000b002da5f4110c8mr2451674lja.3.1713169733820;
        Mon, 15 Apr 2024 01:28:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:a95b:a91:79d:72cd:ca48])
        by smtp.gmail.com with ESMTPSA id gw7-20020a05600c850700b004146e58cc35sm18790311wmb.46.2024.04.15.01.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:28:53 -0700 (PDT)
Date: Mon, 15 Apr 2024 04:28:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lei Chen <lei.chen@smartx.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] tun: limit printing rate when illegal packet
 received by tun dev
Message-ID: <20240415042840-mutt-send-email-mst@kernel.org>
References: <20240415020247.2207781-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415020247.2207781-1-lei.chen@smartx.com>

On Sun, Apr 14, 2024 at 10:02:46PM -0400, Lei Chen wrote:
> vhost_worker will call tun call backs to receive packets. If too many
> illegal packets arrives, tun_do_read will keep dumping packet contents.
> When console is enabled, it will costs much more cpu time to dump
> packet and soft lockup will be detected.
> 
> net_ratelimit mechanism can be used to limit the dumping rate.
> 
> PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
>  #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
>  #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
>  #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
>  #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
>  #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
>     [exception RIP: io_serial_in+20]
>     RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
>     RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
>     RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
>     RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
>     R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
>     R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
>  #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
>  #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
>  #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
>  #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
>  #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
>  #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
>  #12 [ffffa65531497b68] printk at ffffffff89318306
>  #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
>  #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
>  #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
>  #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
>  #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
>  #18 [ffffa65531497f10] kthread at ffffffff892d2e72
>  #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f
> 
> Fixes: ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")
> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes from v4:
> https://lore.kernel.org/all/20240414081806.2173098-1-lei.chen@smartx.com/
>  1. Adjust code indentation
> 
> Changes from v3:
> https://lore.kernel.org/all/20240412065841.2148691-1-lei.chen@smartx.com/
>  1. Change patch target from net tun to tun.
>  2. Move change log below the seperator "---".
>  3. Remove escaped parentheses in the Fixes string.
> 
> Changes from v2:
> https://lore.kernel.org/netdev/20240410042245.2044516-1-lei.chen@smartx.com/
>  1. Add net-dev to patch subject-prefix.
>  2. Add fix tag.
> 
> Changes from v1:
> https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.com/
>  1. Use net_ratelimit instead of raw __ratelimit.
>  2. Use netdev_err instead of pr_err to print more info abort net dev.
>  3. Adjust git commit message to make git am happy.
>  drivers/net/tun.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
>  drivers/net/tun.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 0b3f21cba552..92da8c03d960 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2125,14 +2125,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  					    tun_is_little_endian(tun), true,
>  					    vlan_hlen)) {
>  			struct skb_shared_info *sinfo = skb_shinfo(skb);
> -			pr_err("unexpected GSO type: "
> -			       "0x%x, gso_size %d, hdr_len %d\n",
> -			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> -			       tun16_to_cpu(tun, gso.hdr_len));
> -			print_hex_dump(KERN_ERR, "tun: ",
> -				       DUMP_PREFIX_NONE,
> -				       16, 1, skb->head,
> -				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +
> +			if (net_ratelimit()) {
> +				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
> +					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> +					   tun16_to_cpu(tun, gso.hdr_len));
> +				print_hex_dump(KERN_ERR, "tun: ",
> +					       DUMP_PREFIX_NONE,
> +					       16, 1, skb->head,
> +					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +			}
>  			WARN_ON_ONCE(1);
>  			return -EINVAL;
>  		}
> -- 
> 2.44.0
> 


