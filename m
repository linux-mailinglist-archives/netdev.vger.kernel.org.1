Return-Path: <netdev+bounces-218588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307DAB3D646
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 03:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E803B507A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 01:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805E1EF09D;
	Mon,  1 Sep 2025 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPKzP/Su"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE6143C69;
	Mon,  1 Sep 2025 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756689711; cv=none; b=kgib0YVVIwoQIse22J4nhlrVYEWqT7ahmjo/qOisXRRHjXNsUMJ+xsqK7HrJpAYgOrDNe1Uls0lFl/qrays+utqkpHUSBEE6/gUuhm9gZ+E10JwYmRJKWKMZ8UjwLozH6L8txAGquO96RNSU/ocFc2ZKw9DkEOO9b1nxuXrweiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756689711; c=relaxed/simple;
	bh=h0pmgnhdCd38gozXQmWVT2pF9iro8pteHNFN2rN3hP8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=f+lUmUQqF4JzzfU/919ZECSvEWJIOlf+TVtXiJikOjON63TtB2koUMjlCIw6fuczvsmHxuYhipjkzHHFVxfquQzdwBUqr4jb94uWih78OFjfj5zjZukFAQY7GDT4JbVAw0BL4n9EFZHxudVKlKHgEvpA4O/6Rn13XBVSafiJ6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPKzP/Su; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70ddadde2e9so31954096d6.0;
        Sun, 31 Aug 2025 18:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756689708; x=1757294508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/79m2zmAzN1722AGuL1tMJ91+uoyl2xeWqASy06r/U=;
        b=FPKzP/SumWi//5OiZFWuhpxPbJgzFVIYv5nE2cK5RnlzywefHalo0Jy6i/WWtGW1Sr
         Pj0o7qpSrx9Wvzp0t2FZtRxkpNHel5E5MVkDU5jK8jcQyqjPHl3ck9Few9iEFsZVO/16
         Wus8OBOkPRG1TIHbSPoAEo71eWM7sZkk0NNwBFM4Yu7T1FHYchQparmn8jiC3sA8B9TV
         rwLz8b/me02uBjhmU5t0ec0UBA69R9Mn57XN1+ZE/Zi2dKGaOaGwq+aZMOZBGrD5mvbe
         O7VUVgw9Yz4XGrmnJj+wwmtwjJpUTD1R0IoI0f0T7LqnRm0i3LU4XbpmAToxbAHcXxiB
         YOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756689708; x=1757294508;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/79m2zmAzN1722AGuL1tMJ91+uoyl2xeWqASy06r/U=;
        b=HbjFyvWzI/p1DKDMmLxJQ5a/I8N29wd1q4tZIENWdhiNWnkPTkCVA0PjC1MHJRwn2D
         KJfzcJj3Cg4Wt5ZXPEReVSHC0rZLMgCWipHyjt9DBN4OVPQPW3O2ba64tlSIHdXEwI5G
         YNtU+ks7DBKN9lOgHQePkTHSAdvZl73Zpzy8A9WXjMOpHboydJPZoj3mC3jVI0sSnnvw
         +R+uvmlf4NYDIaE96tp0gNFwYbzZRf6R8jJa76GJTRRFvSbo2YUMdzNQ0jCsnLbJlby8
         AfJ6QtGHoz6geOq+8LglKSzVkEK54YeBbcpPm2gP7wAIv4cPM/VDAYC7em2v1vwtlRRp
         5nAg==
X-Forwarded-Encrypted: i=1; AJvYcCUNprfM36UQ1CxKmGkoz9QjJHRq2dxe1Tsvi/Rv+zIIkaVJTtb033UKwfSMj9tDEtsVsPoDeMFg@vger.kernel.org, AJvYcCUgIQgni+1zKSN0sg4FyJ19YbNmXYl5J0vKOD0BA47BXpYU1OChzOdAOZfSIrl52cRN/Cs06UwyHvCSUwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvt3ldVtH4Svv2U1ZBwpPH3x24obbO3l864IdC7vBlbZU+QeRB
	oaxEXBKSoU1C1L7AX8DUZ7xdjJuR93OgAsPN4Ue1LXx8GiDr442waI/1
X-Gm-Gg: ASbGnctxKBGYKdOdaMJ8iH6cI+2NMvJxY4E69shAIDYV1aF8ufoJGkH/X2pIQi10izO
	hGluxKpCpdGBrpEoaE79Uc4a5pjjR3APK92qazZ2mlWo4TIAVDvpS972Y/++lMyqsm9G1eOpoAQ
	nB77F3HEd4cl+cAvBdb4F3rNMIh3EEo65M3dYG8lFvtpBKmWPTQiPBvA9VO/UHe8eFO9uB4jTlZ
	LXCydx9nKquGcwNXfYIlOWJ6vnRumpEDce9ho9ty8r1dhvMvE9If5bGmNi0Ds25HvKdZnOU+AP6
	LwoIoU/XQn0VIdlpZ6xeCSXcnHGbgW+YHHujxVpGasZbOtEcFpTrYKRNojVoi2WDCk1ePrANy0b
	dpnUlMET+MAv6NeC+g1tWtQ3bBJQzbGQcXQFcXtLQ9AW7EU8AczjQnAr1nZkq530jfkgM4T59Wl
	eHOQ==
X-Google-Smtp-Source: AGHT+IEznatcpWOwwZlphQ8FIMDlnIxqqlNxL5waZP6lGRf521vFNjOouylE+58cZRpzSNYbQKAJmA==
X-Received: by 2002:a05:6214:23c7:b0:70b:a189:a571 with SMTP id 6a1803df08f44-70fac7a01ccmr80190556d6.25.1756689707641;
        Sun, 31 Aug 2025 18:21:47 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70fb28983fasm31466076d6.54.2025.08.31.18.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 18:21:47 -0700 (PDT)
Date: Sun, 31 Aug 2025 21:21:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Xin Zhao <jackzxcui1989@163.com>
Message-ID: <willemdebruijn.kernel.32fdbcb96baeb@gmail.com>
In-Reply-To: <20250831100822.1238795-3-jackzxcui1989@163.com>
References: <20250831100822.1238795-1-jackzxcui1989@163.com>
 <20250831100822.1238795-3-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Use hrtimer instead of timer
> to help compensate for the shortcomings in real-time performance.
> In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
> enough, with fluctuations reaching over 8ms (on a system with HZ=250).
> This is unacceptable in some high real-time systems that require timely
> processing of network packets. By replacing it with hrtimer, if a timeout
> of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> 3 ms.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

Tiny style point that is probably not worth respinning for.

Otherwise

Reviewed-by: Willem de Bruijn <willemb@google.com>



> ---
> Changes in v8:
> - Simplify the logic related to setting timeout.
> 
> Changes in v7:
> - Only update the hrtimer expire time within the hrtimer callback.
> 
> Changes in v1:
> - Do not add another config for the current changes.
> 
> ---
>  net/packet/af_packet.c | 79 +++++++++---------------------------------
>  net/packet/diag.c      |  2 +-
>  net/packet/internal.h  |  6 ++--
>  3 files changed, 20 insertions(+), 67 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index d4eb4a4fe..3e3bb4216 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -203,8 +203,7 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *,
>  static int prb_queue_frozen(struct tpacket_kbdq_core *);
>  static void prb_open_block(struct tpacket_kbdq_core *,
>  		struct tpacket_block_desc *);
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *);
> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *);
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *);
>  static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hdr *);
>  static void prb_clear_rxhash(struct tpacket_kbdq_core *,
>  		struct tpacket3_hdr *);
> @@ -579,33 +578,13 @@ static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
>  	return proto;
>  }
>  
> -static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> -{
> -	timer_delete_sync(&pkc->retire_blk_timer);
> -}
> -
>  static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
>  		struct sk_buff_head *rb_queue)
>  {
>  	struct tpacket_kbdq_core *pkc;
>  
>  	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> -
> -	spin_lock_bh(&rb_queue->lock);
> -	pkc->delete_blk_timer = 1;
> -	spin_unlock_bh(&rb_queue->lock);
> -
> -	prb_del_retire_blk_timer(pkc);
> -}
> -
> -static void prb_setup_retire_blk_timer(struct packet_sock *po)
> -{
> -	struct tpacket_kbdq_core *pkc;
> -
> -	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> -	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> -		    0);
> -	pkc->retire_blk_timer.expires = jiffies;
> +	hrtimer_cancel(&pkc->retire_blk_timer);
>  }
>  
>  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> @@ -671,29 +650,22 @@ static void init_prb_bdqc(struct packet_sock *po,
>  	p1->version = po->tp_version;
>  	po->stats.stats3.tp_freeze_q_cnt = 0;
>  	if (req_u->req3.tp_retire_blk_tov)
> -		p1->retire_blk_tov = req_u->req3.tp_retire_blk_tov;
> +		p1->interval_ktime = ms_to_ktime(req_u->req3.tp_retire_blk_tov);
>  	else
> -		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
> -						req_u->req3.tp_block_size);
> -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> +		p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(po,
> +						req_u->req3.tp_block_size));

req_u is not aligned with the line above.

