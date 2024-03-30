Return-Path: <netdev+bounces-83674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3EF8934A4
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF451C238C5
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE015FD13;
	Sun, 31 Mar 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKS5psrv"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335A15FA7F
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903434; cv=pass; b=ti8UvwxFjsa4paZNNVFyXcOo7qAsAJAxZPN5JE759ZxAhRxSvv/usBYVU/bI38rDo+tQ7G7NqKsOqa/jh7TiS8VgcRST+Arjq57+Lduhj6yTJWMyzAG9hP4Wh43y2weu4JxNLIozC4pn7KRzmh6sfw9jVKOC5aedfnntpWJU6Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903434; c=relaxed/simple;
	bh=+aOsqWyoskE37ffBGxozTaxmzQ63Pdv0Yuac/lns4Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiN16RkvlsDni5WrUlZfIhXhcPTizDGl2+QoupIV0XD4jV64uWdmyrX6XvP1Jqk32VxFuqXBgYm+6hFqnZJm4bSbsYam5HFzbgDwz2C0Vp4RZNvqHk8LyDsDI6PZ0r141b9Pa+NbX+/8GTVevcYpG4FAn8DbHDCX0S4JNzodfcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKS5psrv; arc=none smtp.client-ip=209.85.218.47; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 1C882208D7;
	Sun, 31 Mar 2024 18:43:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XDXGny6a_0qF; Sun, 31 Mar 2024 18:43:49 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 59D60208CD;
	Sun, 31 Mar 2024 18:43:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 59D60208CD
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 4CDB2800061;
	Sun, 31 Mar 2024 18:43:49 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:49 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:04 +0000
X-sender: <netdev+bounces-83506-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoACpCmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 15674
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83506-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com F0B3C207E4
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711810056; cv=none; b=kpAEiarcQT9ZKL8zkBLI3bYHdb4UPNfUSuRr4q5ma2mf07ZDZjRjXhRQJQky2xU727WA0yLZk9W/er4E+2pzlftO5YJIw4VIQ+8nDheAfoS8bn/aMkkEuoNvbL+LArXVTphehXDK+CCACtKLIsPGIKhiMVxc5IXUd34HVTp2sU0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711810056; c=relaxed/simple;
	bh=+aOsqWyoskE37ffBGxozTaxmzQ63Pdv0Yuac/lns4Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StC5t7/L7/eIQs48jhztrltYYbv+kq+2SmywsOf71ocSV2VJxZooWd/CgH+F5BrFmP6CQJSNyo/TzOTsU/wDwbGCXLA8c1GVDKBHnmf5aOJ2FEN6N6mBAq9GBQdRXSi7lVyxnBu/ZhTLF+trMrJ3iamkkJQUxuSQOUsup0zEdWk=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKS5psrv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711810053; x=1712414853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W300fuzuiZ6ceqhX7gLlM/xiZgFGQPmf5CCO5UJDT4A=;
        b=LKS5psrvu6VD0Vy0XmHvxU0tYBUza3aPlkENTlN44rTuVpkyOncR8vrDXgjLSGlSpo
         XyAEgQdi/zAIR7UBOlfQHv5Zg9dzD/CzkQnJC2CFsXlOalF+wmXa9eV5TiLN4dN7Y5JK
         axAd4w5J13IiCHjE+24O5/JOx2fvBJ9sXbZcK5bUfoC6Ay6nrX/MZg/snlEYMkFR2Cui
         Tei7L41jRdqGT2/YqISJnNFxa3zXWoeh4rpC26AOg7yBtTJKrNmDBEe5r3DRGbnO6ML8
         a5t0b1NGuhHzOV8skLpRyduyl6WcZrpGQRh+qpGHBrL0KObbIUtC5jmwvMyM9wNprAaZ
         am5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711810053; x=1712414853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W300fuzuiZ6ceqhX7gLlM/xiZgFGQPmf5CCO5UJDT4A=;
        b=NKu9Pp1a2ghx9ZbVk4kKftIAAM96OGtyMIjGJKqW5z7KxSgOFohsohE+BucPu5yrNw
         j6BiHl0gXHQMLOsFlLueGKIuxaAFSY8EgWQZ0a91fxpNKmyzPdMBzYPVAQJhM2n6ZMa3
         OBWd8Gbjk0jio2VpKKPWFoD+nTHtGvkawh0TYncvCRVbZlwtpVyo88nqZKvIXIf/CD86
         /2YY4dY73sqZIDbutxAzbn1zz0qnmO72w9L5yPcggOVeJC4fM/aZDD7ysrwYG9TrAPbK
         9kc4j4B6WWVYteCVH1KllRDbk5wvLTBx7j5ksCnr9+P5JBX+/oG9JhLgWi37SsxxJl15
         nUUA==
X-Forwarded-Encrypted: i=1; AJvYcCUwDoCdjn83mi0iRy83jwpIgWSwWC7lLmDoo/ick0NAKQlLj7aRcSKoL97J10QHNZNxSGUup496fgTUOOIGHfWSZcAbmUhd
X-Gm-Message-State: AOJu0Yy3BZK2J29DwON/qSNa6FW0BV0kmRo8309Kv4rLOiajrtsj4Z8p
	IArCs7mzn03uCBEiV01/CaHEXOSCbDgS7KSWlZKx1GUz5A7yhYBI+ibLMWnemXcKaovN1UH9P4n
	PuU+xt6DOsO2PfFDZht63el4Fye8IB5IyUKg=
X-Google-Smtp-Source: AGHT+IH1b7DfIUMD1an/uRfFG6fdu7nOA43JkZRFapeDTcDyRfEm7vuGo96xJl8uCvqM11MV+heUKrQV3A3Ar9V9uCk=
X-Received: by 2002:a17:907:1c90:b0:a4e:2220:f748 with SMTP id
 nb16-20020a1709071c9000b00a4e2220f748mr3821844ejc.40.1711810052521; Sat, 30
 Mar 2024 07:47:32 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com> <20240329154225.349288-7-edumazet@google.com>
In-Reply-To: <20240329154225.349288-7-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 30 Mar 2024 22:46:55 +0800
Message-ID: <CAL+tcoBa1g1Ps5V_P1TqVtGWD482AvSy=wgvvUMT3RCHH+x2=Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/8] net: rps: change input_queue_tail_incr_save()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello Eric,

On Fri, Mar 29, 2024 at 11:43=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> input_queue_tail_incr_save() is incrementing the sd queue_tail
> and save it in the flow last_qtail.
>
> Two issues here :
>
> - no lock protects the write on last_qtail, we should use appropriate
>   annotations.
>
> - We can perform this write after releasing the per-cpu backlog lock,
>   to decrease this lock hold duration (move away the cache line miss)
>
> Also move input_queue_head_incr() and rps helpers to include/net/rps.h,
> while adding rps_ prefix to better reflect their role.
>
> v2: Fixed a build issue (Jakub and kernel build bots)
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/netdevice.h | 15 ---------------
>  include/net/rps.h         | 23 +++++++++++++++++++++++
>  net/core/dev.c            | 20 ++++++++++++--------
>  3 files changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1c31cd2691d32064613836141fbdeeebc831b21f..14f19cc2616452d7e6afbbaa5=
2f8ad3e61a419e9 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3249,21 +3249,6 @@ struct softnet_data {
>         call_single_data_t      defer_csd;
>  };
>
> -static inline void input_queue_head_incr(struct softnet_data *sd)
> -{
> -#ifdef CONFIG_RPS
> -       sd->input_queue_head++;
> -#endif
> -}
> -
> -static inline void input_queue_tail_incr_save(struct softnet_data *sd,
> -                                             unsigned int *qtail)
> -{
> -#ifdef CONFIG_RPS
> -       *qtail =3D ++sd->input_queue_tail;
> -#endif
> -}
> -
>  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
>
>  static inline int dev_recursion_level(void)
> diff --git a/include/net/rps.h b/include/net/rps.h
> index 7660243e905b92651a41292e04caf72c5f12f26e..10ca25731c1ef766715fe7ee4=
15ad0b71ec643a8 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -122,4 +122,27 @@ static inline void sock_rps_record_flow(const struct=
 sock *sk)
>  #endif
>  }
>
> +static inline u32 rps_input_queue_tail_incr(struct softnet_data *sd)
> +{
> +#ifdef CONFIG_RPS
> +       return ++sd->input_queue_tail;
> +#else
> +       return 0;
> +#endif
> +}
> +
> +static inline void rps_input_queue_tail_save(u32 *dest, u32 tail)
> +{
> +#ifdef CONFIG_RPS
> +       WRITE_ONCE(*dest, tail);
> +#endif
> +}

I wonder if we should also call this new helper to WRITE_ONCE
last_qtail in the set_rps_cpu()?

Thanks,
Jason

> +
> +static inline void rps_input_queue_head_incr(struct softnet_data *sd)
> +{
> +#ifdef CONFIG_RPS
> +       sd->input_queue_head++;
> +#endif
> +}
> +
>  #endif /* _NET_RPS_H */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0a8ccb0451c30a39f8f8b45d26b7e5548b8bfba4..79073bbc9a644049cacf84333=
10f4641745049e9 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4611,7 +4611,7 @@ static int get_rps_cpu(struct net_device *dev, stru=
ct sk_buff *skb,
>                 if (unlikely(tcpu !=3D next_cpu) &&
>                     (tcpu >=3D nr_cpu_ids || !cpu_online(tcpu) ||
>                      ((int)(per_cpu(softnet_data, tcpu).input_queue_head =
-
> -                     rflow->last_qtail)) >=3D 0)) {
> +                     READ_ONCE(rflow->last_qtail))) >=3D 0)) {
>                         tcpu =3D next_cpu;
>                         rflow =3D set_rps_cpu(dev, skb, rflow, next_cpu);
>                 }
> @@ -4666,7 +4666,7 @@ bool rps_may_expire_flow(struct net_device *dev, u1=
6 rxq_index,
>                 cpu =3D READ_ONCE(rflow->cpu);
>                 if (rflow->filter =3D=3D filter_id && cpu < nr_cpu_ids &&
>                     ((int)(per_cpu(softnet_data, cpu).input_queue_head -
> -                          rflow->last_qtail) <
> +                          READ_ONCE(rflow->last_qtail)) <
>                      (int)(10 * flow_table->mask)))
>                         expire =3D false;
>         }
> @@ -4801,6 +4801,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, =
int cpu,
>         unsigned long flags;
>         unsigned int qlen;
>         int max_backlog;
> +       u32 tail;
>
>         reason =3D SKB_DROP_REASON_DEV_READY;
>         if (!netif_running(skb->dev))
> @@ -4825,8 +4826,11 @@ static int enqueue_to_backlog(struct sk_buff *skb,=
 int cpu,
>                                 napi_schedule_rps(sd);
>                 }
>                 __skb_queue_tail(&sd->input_pkt_queue, skb);
> -               input_queue_tail_incr_save(sd, qtail);
> +               tail =3D rps_input_queue_tail_incr(sd);
>                 backlog_unlock_irq_restore(sd, &flags);
> +
> +               /* save the tail outside of the critical section */
> +               rps_input_queue_tail_save(qtail, tail);
>                 return NET_RX_SUCCESS;
>         }
>
> @@ -5904,7 +5908,7 @@ static void flush_backlog(struct work_struct *work)
>                 if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
>                         __skb_unlink(skb, &sd->input_pkt_queue);
>                         dev_kfree_skb_irq(skb);
> -                       input_queue_head_incr(sd);
> +                       rps_input_queue_head_incr(sd);
>                 }
>         }
>         backlog_unlock_irq_enable(sd);
> @@ -5913,7 +5917,7 @@ static void flush_backlog(struct work_struct *work)
>                 if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
>                         __skb_unlink(skb, &sd->process_queue);
>                         kfree_skb(skb);
> -                       input_queue_head_incr(sd);
> +                       rps_input_queue_head_incr(sd);
>                 }
>         }
>         local_bh_enable();
> @@ -6041,7 +6045,7 @@ static int process_backlog(struct napi_struct *napi=
, int quota)
>                         rcu_read_lock();
>                         __netif_receive_skb(skb);
>                         rcu_read_unlock();
> -                       input_queue_head_incr(sd);
> +                       rps_input_queue_head_incr(sd);
>                         if (++work >=3D quota)
>                                 return work;
>
> @@ -11455,11 +11459,11 @@ static int dev_cpu_dead(unsigned int oldcpu)
>         /* Process offline CPU's input_pkt_queue */
>         while ((skb =3D __skb_dequeue(&oldsd->process_queue))) {
>                 netif_rx(skb);
> -               input_queue_head_incr(oldsd);
> +               rps_input_queue_head_incr(oldsd);
>         }
>         while ((skb =3D skb_dequeue(&oldsd->input_pkt_queue))) {
>                 netif_rx(skb);
> -               input_queue_head_incr(oldsd);
> +               rps_input_queue_head_incr(oldsd);
>         }
>
>         return 0;
> --
> 2.44.0.478.gd926399ef9-goog
>
>


