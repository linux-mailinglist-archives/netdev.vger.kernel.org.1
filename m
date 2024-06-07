Return-Path: <netdev+bounces-101880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 970059005E6
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B34283273
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDAD195999;
	Fri,  7 Jun 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNsp2S+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976D19413B;
	Fri,  7 Jun 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769279; cv=none; b=SA/CRH2eDnNDgHcDT9BVTFfLCUlAWXS8LYNH3h1qQy6yN5hEE3zaeCPWu7WcUvj8MF6gzBeTbV244Bjcs4vIc6ReVdf7ojzMdHsX4XAGNzPsCve3hwG4C2DyynUGc45dBhv3rXrbVKJcZ+Uz98xxFD11wUj2qgb4Vbhjg48IAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769279; c=relaxed/simple;
	bh=Q0qVcx6Lh/xX9m1Yek3cdXKhexjuZvDuIwtmNW3N5x0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=A6u9ohqKxF1J5iWlwC+c4dRG2uJshdXcKPXGA4UT4OGDjGUhCVBvKeBD0unJ3AzKhdSychb3uHn94hiEYg0GJOZ24pw704M/R4UFustgAP5c4vxWoJKihKjy+iD+81nV7pq2UsOorEipl4R1rJfU1+Vyi7+CQPGrLXNpEahEjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNsp2S+e; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79524f6693dso155515185a.0;
        Fri, 07 Jun 2024 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717769277; x=1718374077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76G98oggkba1Pa7jOw98g00tlzrNcJsAPnhQ44HuPIY=;
        b=SNsp2S+erFabSAzT+GGWiMueNXYfLFxCTHtn8U8mSf7xkbQXGzJqfTEX+9/E6ho95u
         AXKJN9Bc6HjvtbkMdLC/E/2HtKAirh0UrgcNq4tdsiNxiHW5WjvsWAd96uvlsvMVd3jj
         RDuvdSlLt+jmOsHFaxduPAWP4J8KslHxab17s58rm9d4CHwvup+DTNcKLuYC4aNaNT9J
         JC9/5qPKFvSEuoMG8wmRqWzb3fzFqxM5xCBhdfrcjXeTdhZOYh83aobBZ8wZbn8YJ5FG
         r/91CSCdHFgncXIWVmE96fSumLlCWlVkfe5B8bZ8Ik4bH0xho0WgCHS6kdQyobQNnrAn
         QnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769277; x=1718374077;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=76G98oggkba1Pa7jOw98g00tlzrNcJsAPnhQ44HuPIY=;
        b=uT/ALK57+V88fg/8KBb4bdiCsoDYAB7iNHHFz/JIs4f1dYYTjdUvMrxsd16alWgm9g
         fytePJsJ8vw538Z1RsH5i9NI4ehTUrLUKviHg9T9cD4PS7jRITvF/aloyicH/bIPFAGy
         mwt1mvqCuR8ESf+uXs/hoexoK7wCDKgB2ToPyCPMUAnvwe9nKWLujED5wBTIhjUGpcmM
         zwUQjKxxSM9dSl5MwOsn9kemNJMBRLBg8vug9jXiQ1bPYy+xd1zaQGjPiWsC2JWjEfpl
         MfZr0+H2XdyaY3pHSRB1zogMDC18Jhu2+IY3vizc66b/HFUpJ8pP7jlvQ6hCNgJfCHzP
         rTrg==
X-Forwarded-Encrypted: i=1; AJvYcCWsxnK6YLlVbUzv82ACZzm1chNM+/watTntkRKnWten+qM1qZ2uqiiGokpJN7eiHDGTWbgwyavx3mATHQKuTAmRUzAEmTKWlCh3Xx0oSskmsJ8ckSsnsXE7cOsft/GVPUI8+Kmp
X-Gm-Message-State: AOJu0Yw9ZzsexVXxjhRAg3bT3JPZr366q232bWdp6Kljlb6LmjMkmZHj
	zLsBfbx4DnY8D5FAEcmvRjWU2U6pOeVhupgOpS2mdCT9yyyQypZc
X-Google-Smtp-Source: AGHT+IEx6jdJ6+Tq5s1qSCTBn11J1LjVDiMbsh0HZyTk5UwkDByBNXCQgJJ/nUreX4OfIFYG+w3vaQ==
X-Received: by 2002:a05:620a:21dd:b0:794:eb25:708b with SMTP id af79cd13be357-7953c4d1ac8mr211497585a.75.1717769276592;
        Fri, 07 Jun 2024 07:07:56 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79543f02d1bsm61637785a.34.2024.06.07.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:55 -0700 (PDT)
Date: Fri, 07 Jun 2024 10:07:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: joshwash@google.com, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 stable@kernel.org, 
 Joshua Washington <joshwash@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Andrei Vagin <avagin@gmail.com>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Shailend Chand <shailend@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Rushil Gupta <rushilg@google.com>, 
 Bailey Forrest <bcf@google.com>, 
 Catherine Sullivan <csully@google.com>, 
 open list <linux-kernel@vger.kernel.org>
Message-ID: <6663143b90996_2f27b2949@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240607060958.2789886-1-joshwash@google.com>
References: <20240606192139.1872461-1-joshwash@google.com>
 <20240607060958.2789886-1-joshwash@google.com>
Subject: Re: [PATCH net v2] gve: ignore nonrelevant GSO type bits when
 processing TSO headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

joshwash@ wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> TSO currently fails when the skb's gso_type field has more than one bit
> set.
> 
> TSO packets can be passed from userspace using PF_PACKET, TUNTAP and a
> few others, using virtio_net_hdr (e.g., PACKET_VNET_HDR). This includes
> virtualization, such as QEMU, a real use-case.
> 
> The gso_type and gso_size fields as passed from userspace in
> virtio_net_hdr are not trusted blindly by the kernel. It adds gso_type
> |= SKB_GSO_DODGY to force the packet to enter the software GSO stack
> for verification.
> 
> This issue might similarly come up when the CWR bit is set in the TCP
> header for congestion control, causing the SKB_GSO_TCP_ECN gso_type bit
> to be set.
> 
> Fixes: a57e5de476be ("gve: DQO: Add TX path")
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Andrei Vagin <avagin@gmail.com>

I did not mean to ask for a revision. When you send a v2, please do include
a changelog

> ---
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 21 +++++---------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> index fe1b26a4d736..a76b407a981b 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -551,32 +551,21 @@ static int gve_prep_tso(struct sk_buff *skb)
>  	 * - Hypervisor enforces a limit of 9K MTU
>  	 * - Kernel will not produce a TSO larger than 64k
>  	 */
> -

Accidental removal?

>  	if (unlikely(skb_shinfo(skb)->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
>  		return -1;
>  
> +	if (!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
> +		return -EINVAL;
> +


