Return-Path: <netdev+bounces-216325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB17B331C3
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A5A201445
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808582DA740;
	Sun, 24 Aug 2025 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ1KTwn/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3CE2D77FA;
	Sun, 24 Aug 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756058895; cv=none; b=pT8VqP3vQ2PhDQwi2yUopZgLbwQbppeVeyA3gHNureoIW1JJ3a1u+QSz4Fy5DCe2nq4jiFhDxknHHUEmzyMSzCEPat0heVdL+6rSsCPGjTNQ/AaBNC9/MkL12PxyAi+be44ffaReqPzNVhDsOfD6cjyB//Tcec4mWZrw1VkM0D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756058895; c=relaxed/simple;
	bh=7Zt9ZzYdlZ6gWy6Ksa2jjVpN90wx2FES5ReAzaXwbo0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sjpvpq1a23S/kfN8ZMYGBRu7yUqFknG0rRe/RIcFOuRDtgG3/lROdDHoPgfbzuoDqP+Y87cX9yu4tjqC7LG8+8eAme6dl8ICO3KmIX5AV7FkXrdCooAsmw4CNG6glt3VwPJwESLWUHYphXhWjRGBJVi8aTBQqSHLbW1cLv5aVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ1KTwn/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e8706856e0so438323385a.3;
        Sun, 24 Aug 2025 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756058892; x=1756663692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlI3KIm2UeefPqPbQkgdyg5Lx3vWYhTIo5ApIMN9r90=;
        b=VJ1KTwn/hvAGd/Ra7mS4KpoVmfM0lsMlqyV/RryufoHU5GYTGK39ZeBSwbo6qjY0c/
         tc5+LTczoDt07enzl5bQqRBQJkliNoqyac0zHufSbnQXngEjQZcx3bxtCRlF7icsffle
         uLfWCzOmICSYHEy1mZcyeNhNk7sq8d6ZqgGrIpKyAFXE1zyt5f66eT6tYZWd2c4uGgo3
         vcpg6ftXQh+PVnztw4WtEDtp46I+MLqE/VD3YTagpzw6QktyXhK/7w0LNw16wpsb68mv
         CyKAaF82gYPQi4DsurVqHW+Mzxz+6tu2Fs7D1S+d9rr3bE8Q7tNfV7cLjj4xJLUmjcmZ
         3Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756058892; x=1756663692;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HlI3KIm2UeefPqPbQkgdyg5Lx3vWYhTIo5ApIMN9r90=;
        b=AS/uBMIQCpDwxs9ztoxLmnLJxPQIQAtr6XgWxNPmIwv0ej9SuZyo4xqL7U9g6m7SK3
         EoODTYtghmxGhWnoXpeAUMH+tTVthFtXTRu085LjrGD04SSG3nf1BF5K4pruhx4tKpBJ
         rHJ3oPcD25O+Jwcqaz4EfvCY8ae+B7JAlrknzLLcOq+H+9ZowisxCPzRzmVv0SyUvvmq
         gjdnqg7L9NvZ3jU46wgdvMvZ2frMeM+UaJKiR2Lgr+xUIGvMNQzDxGRXVEFdQ6Mlsavl
         VHdWQCQzqM/D5HiLvUJLscCfGE80sgZN1zhF6d6GT+SRt+NmtlWqcBZdn0ETcCDWkhSm
         fJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCUT6Vt28ALRslm2afKFm0xkeKE5rwJAz9sjFr2wyWU20Pqyllh0lwUFW/4JCCqRMfzl/VxEOht1rbCaEF8=@vger.kernel.org, AJvYcCW1Ji++XnqxIlQMnMWGSMrZ5MEBc+jg6VMbKXIjt4TMLHh89kgdCdPEKqy8uv0dJl3HvGz1zrIo@vger.kernel.org
X-Gm-Message-State: AOJu0YxthIRUCHjEVRrDNzTvnmVccVdxs9qPQr4Iow/3sl7QWCfzWyhK
	s4HgvhSV0FElXvEhDmjVvwu/CI8+w8wpscod+xzh4CA/vm5yrFf0e2qm
X-Gm-Gg: ASbGncsuGgGO/zZeu8sicWsaM7j7LC7if3iGz9MPCzUlEqSEPltezwQzkY7n0DoD6BW
	5UFiv9OQP92H7sJ7KqBhhrdCdCm9HmiO4rKH6Pp2NKJqTDMeNVTWh54CZ45wcZb4vFJtm8hYKYO
	LiIYbT1a9BgEPJ6SnrK2z/Qkj4DveEkuJpHBuszy/KdrsIGec1rzllCf7y1WbuWd/RUNtp5C8nj
	WuuLE+wypkmSh3H4gxPJ3HmdjCpIIISHwhe580Os2beB8jVSMTlSD/DT0vi2+PUTF2rvZfjsnvi
	5qDeTlMViDMDtsX7Db/Dtca/W3lab23Var4kfgR4iAHOJr765hQvvwJtSV36lRD/YN7s4PTK2uv
	Oq/9ty3KcfqIXkzNmj2hQl3j0eCKfZW6O9swv9aQ2ustvbNgl4HwF4oY6XVLPceUcch6ZDA==
X-Google-Smtp-Source: AGHT+IEAcjDy9MgKZpfisCdDHjjXpv73c+OyNZHrXaEVAxKPDqXcdnVFjhmVQqAeX5U4DOh03u63eg==
X-Received: by 2002:a05:620a:1727:b0:7ea:2db:6a59 with SMTP id af79cd13be357-7ea110bb163mr993829185a.62.1756058891590;
        Sun, 24 Aug 2025 11:08:11 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7ebee9d94dbsm328926685a.31.2025.08.24.11.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 11:08:10 -0700 (PDT)
Date: Sun, 24 Aug 2025 14:08:10 -0400
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
Message-ID: <willemdebruijn.kernel.3b3e4091c4da@gmail.com>
In-Reply-To: <20250822132051.266787-1-jackzxcui1989@163.com>
References: <20250822132051.266787-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v7] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xin Zhao wrote:
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Use hrtimer instead of timer=

> to help compensate for the shortcomings in real-time performance.
> In HZ=3D100 or HZ=3D250 system, the update of TP_STATUS_USER is not rea=
l-time
> enough, with fluctuations reaching over 8ms (on a system with HZ=3D250)=
.
> This is unacceptable in some high real-time systems that require timely=

> processing of network packets. By replacing it with hrtimer, if a timeo=
ut
> of 2ms is set, the update of TP_STATUS_USER can be stabilized to within=

> 3 ms.
> =

> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> =

> ---
> Changes in v7:
> - Only update the hrtimer expire time within the hrtimer callback.
>   When the callback return, without sk_buff_head lock protection, __run=
_hrtimer will
>   enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer expi=
res while
>   enqueuing a timer may cause chaos in the hrtimer red-black tree.
>   The setting expire time is monotonic, so if we do not update the expi=
re time to the
>   retire_blk_timer when it is not in callback, it will not cause proble=
m if we skip
>   the timeout event and update it when find out that expire_ktime is bi=
gger than the
>   expire time of retire_blk_timer.
> - Use hrtimer_set_expires here instead of hrtimer_forward_now.
>   The end time for retiring each block is not fixed because when networ=
k packets are
>   received quickly, blocks are retired rapidly, and the new block retir=
e time needs
>   to be recalculated. However, hrtimer_forward_now increments the previ=
ous timeout
>   by an interval, which is not correct.
> - The expire time is monotonic, so if we do not update the expire time =
to the
>   retire_blk_timer when it is not in callback, it will not cause proble=
m if we skip
>   the timeout event and update it when find out that expire_ktime is bi=
gger than the
>   expire time of retire_blk_timer.
> - Adding the 'bool callback' parameter back is intended to more accurat=
ely determine
>   whether we are inside the hrtimer callback when executing
>   _prb_refresh_rx_retire_blk_timer. This ensures that we only update th=
e hrtimer's
>   timeout value within the hrtimer callback.

This is getting more complex than needed.

Essentially the lifecycle is that packet_set_ring calls hrtimer_setup
and hrtimer_del_sync.

Inbetween, while the ring is configured, the timer is either

- scheduled from tpacket_rcv and !is_scheduled
    -> call hrtimer_start
- scheduled from tpacket_rcv and is_scheduled
    -> call hrtimer_set_expires
- rescheduled from the timer callback
    -> call hrtimer_set_expires and return HRTIMER_RESTART

The only complication is that the is_scheduled check can race with the
HRTIMER_RESTART restart, as that happens outside the sk_receive_queue
critical section.

One option that I suggested before is to convert pkc->delete_blk_timer
to pkc->blk_timer_scheduled to record whether the timer is scheduled
without relying on hrtimer_is_queued. Set it on first open_block and
clear it from the callback when returning HR_NORESTART.

> Changes in v6:
> - Use hrtimer_is_queued instead to check whether it is within the callb=
ack function.
>   So do not need to add 'bool callback' parameter to _prb_refresh_rx_re=
tire_blk_timer
>   as suggested by Willem de Bruijn;
> - Do not need local_irq_save and local_irq_restore to protect the race =
of the timer
>   callback running in softirq context or the open_block from tpacket_rc=
v in process
>   context
>   as suggested by Willem de Bruijn;
> - Link to v6: https://lore.kernel.org/all/20250820092925.2115372-1-jack=
zxcui1989@163.com/
> =

> Changes in v5:
> - Remove the unnecessary comments at the top of the _prb_refresh_rx_ret=
ire_blk_timer,
>   branch is self-explanatory enough
>   as suggested by Willem de Bruijn;
> - Indentation of _prb_refresh_rx_retire_blk_timer, align with first arg=
ument on
>   previous line
>   as suggested by Willem de Bruijn;
> - Do not call hrtimer_start within the hrtimer callback
>   as suggested by Willem de Bruijn
>   So add 'bool callback' parameter to _prb_refresh_rx_retire_blk_timer =
to indicate
>   whether it is within the callback function. Use hrtimer_forward_now i=
nstead of
>   hrtimer_start when it is in the callback function and is doing prb_op=
en_block.
> - Link to v5: https://lore.kernel.org/all/20250819091447.1199980-1-jack=
zxcui1989@163.com/
> =

> Changes in v4:
> - Add 'bool start' to distinguish whether the call to _prb_refresh_rx_r=
etire_blk_timer
>   is for prb_open_block. When it is for prb_open_block, execute hrtimer=
_start to
>   (re)start the hrtimer; otherwise, use hrtimer_forward_now to set the =
expiration
>   time as it is more commonly used compared to hrtimer_set_expires.
>   as suggested by Willem de Bruijn;
> - Delete the comments to explain why hrtimer_set_expires(not hrtimer_fo=
rward_now)
>   is used, as we do not use hrtimer_set_expires any more;
> - Link to v4: https://lore.kernel.org/all/20250818050233.155344-1-jackz=
xcui1989@163.com/
> =

> Changes in v3:
> - return HRTIMER_NORESTART when pkc->delete_blk_timer is true
>   as suggested by Willem de Bruijn;
> - Drop the retire_blk_tov field of tpacket_kbdq_core, add interval_ktim=
e instead
>   as suggested by Willem de Bruijn;
> - Add comments to explain why hrtimer_set_expires(not hrtimer_forward_n=
ow) is used in
>   _prb_refresh_rx_retire_blk_timer
>   as suggested by Willem de Bruijn;
> - Link to v3: https://lore.kernel.org/all/20250816170130.3969354-1-jack=
zxcui1989@163.com/
> =

> Changes in v2:
> - Drop the tov_in_msecs field of tpacket_kbdq_core added by the patch
>   as suggested by Willem de Bruijn;
> - Link to v2: https://lore.kernel.org/all/20250815044141.1374446-1-jack=
zxcui1989@163.com/
> =

> Changes in v1:
> - Do not add another config for the current changes
>   as suggested by Eric Dumazet;
> - Mention the beneficial cases 'HZ=3D100 or HZ=3D250' in the changelog
>   as suggested by Eric Dumazet;
> - Add some performance details to the changelog
>   as suggested by Ferenc Fejes;
> - Delete the 'pkc->tov_in_msecs =3D=3D 0' bounds check which is not nec=
essary
>   as suggested by Willem de Bruijn;
> - Use hrtimer_set_expires instead of hrtimer_start_range_ns when retire=
 timer needs update
>   as suggested by Willem de Bruijn. Start the hrtimer in prb_setup_reti=
re_blk_timer;
> - Just return HRTIMER_RESTART directly as all cases return the same val=
ue
>   as suggested by Willem de Bruijn;
> - Link to v1: https://lore.kernel.org/all/20250813165201.1492779-1-jack=
zxcui1989@163.com/
> - Link to v0: https://lore.kernel.org/all/20250806055210.1530081-1-jack=
zxcui1989@163.com/
> ---
>  net/packet/af_packet.c | 93 +++++++++++++++++++++++++++++-------------=

>  net/packet/diag.c      |  2 +-
>  net/packet/internal.h  |  6 +--
>  3 files changed, 69 insertions(+), 32 deletions(-)
> =

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a7017d7f0..654ae65ea 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -197,14 +197,14 @@ static void *packet_previous_frame(struct packet_=
sock *po,
>  static void packet_increment_head(struct packet_ring_buffer *buff);
>  static int prb_curr_blk_in_use(struct tpacket_block_desc *);
>  static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
> -			struct packet_sock *);
> +			struct packet_sock *, bool);
>  static void prb_retire_current_block(struct tpacket_kbdq_core *,
>  		struct packet_sock *, unsigned int status);
>  static int prb_queue_frozen(struct tpacket_kbdq_core *);
>  static void prb_open_block(struct tpacket_kbdq_core *,
> -		struct tpacket_block_desc *);
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *);
> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core =
*);
> +		struct tpacket_block_desc *, bool);
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrt=
imer *);
> +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core =
*, bool);
>  static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket=
3_hdr *);
>  static void prb_clear_rxhash(struct tpacket_kbdq_core *,
>  		struct tpacket3_hdr *);
> @@ -581,7 +581,7 @@ static __be16 vlan_get_protocol_dgram(const struct =
sk_buff *skb)
>  =

>  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
> -	timer_delete_sync(&pkc->retire_blk_timer);
> +	hrtimer_cancel(&pkc->retire_blk_timer);
>  }
>  =

>  static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
> @@ -603,9 +603,10 @@ static void prb_setup_retire_blk_timer(struct pack=
et_sock *po)
>  	struct tpacket_kbdq_core *pkc;
>  =

>  	pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
> -	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> -		    0);
> -	pkc->retire_blk_timer.expires =3D jiffies;
> +	hrtimer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired=
,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> +	hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> +		      HRTIMER_MODE_REL_SOFT);
>  }
>  =

>  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> @@ -672,27 +673,52 @@ static void init_prb_bdqc(struct packet_sock *po,=

>  	p1->last_kactive_blk_num =3D 0;
>  	po->stats.stats3.tp_freeze_q_cnt =3D 0;
>  	if (req_u->req3.tp_retire_blk_tov)
> -		p1->retire_blk_tov =3D req_u->req3.tp_retire_blk_tov;
> +		p1->interval_ktime =3D ms_to_ktime(req_u->req3.tp_retire_blk_tov);
>  	else
> -		p1->retire_blk_tov =3D prb_calc_retire_blk_tmo(po,
> -						req_u->req3.tp_block_size);
> -	p1->tov_in_jiffies =3D msecs_to_jiffies(p1->retire_blk_tov);
> +		p1->interval_ktime =3D ms_to_ktime(prb_calc_retire_blk_tmo(po,
> +						req_u->req3.tp_block_size));
>  	p1->blk_sizeof_priv =3D req_u->req3.tp_sizeof_priv;
>  	rwlock_init(&p1->blk_fill_in_prog_lock);
>  =

>  	p1->max_frame_len =3D p1->kblk_size - BLK_PLUS_PRIV(p1->blk_sizeof_pr=
iv);
>  	prb_init_ft_ops(p1, req_u);
>  	prb_setup_retire_blk_timer(po);
> -	prb_open_block(p1, pbd);
> +	prb_open_block(p1, pbd, false);
>  }
>  =

>  /*  Do NOT update the last_blk_num first.
>   *  Assumes sk_buff_head lock is held.
>   */
> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core =
*pkc)
> -{
> -	mod_timer(&pkc->retire_blk_timer,
> -			jiffies + pkc->tov_in_jiffies);
> +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core =
*pkc,
> +					     bool callback)
> +{
> +	if (likely(ktime_to_ns(pkc->expire_ktime))) {
> +		pkc->expire_ktime =3D ktime_add_safe(ktime_get(), pkc->interval_ktim=
e);
> +		if (callback) {
> +			/* Three tips:
> +			 * 1) Only update the hrtimer expire time within the callback.
> +			 * When the callback return, without sk_buff_head lock protection,
> +			 * __run_hrtimer will enqueue the timer if return HRTIMER_RESTART.
> +			 * Setting the hrtimer expires while enqueuing a timer may cause
> +			 * chaos in the hrtimer red-black tree.
> +			 * 2) Use hrtimer_set_expires here instead of hrtimer_forward_now,
> +			 * because the end time for retiring each block is not fixed
> +			 * because when network packets are received quickly, blocks are
> +			 * retired rapidly, and the new block retire time needs to be
> +			 * recalculated. However, hrtimer_forward_now increments the
> +			 * previous timeout by an interval, which is not correct.
> +			 * 3=EF=BC=89The expire time is monotonic, so if we do not update t=
he
> +			 * expire time to the retire_blk_timer when it is not in callback,
> +			 * it will not cause problem if we skip the timeout event and
> +			 * update it when find out that expire_ktime is bigger than the
> +			 * expire time of retire_blk_timer.
> +			 */
> +			hrtimer_set_expires(&pkc->retire_blk_timer, pkc->expire_ktime);
> +		}
> +	} else {
> +		/* Just after prb_setup_retire_blk_timer. */
> +		pkc->expire_ktime =3D hrtimer_get_expires(&pkc->retire_blk_timer);
> +	}
>  	pkc->last_kactive_blk_num =3D pkc->kactive_blk_num;
>  }
>  =

> @@ -719,8 +745,9 @@ static void _prb_refresh_rx_retire_blk_timer(struct=
 tpacket_kbdq_core *pkc)
>   * prb_calc_retire_blk_tmo() calculates the tmo.
>   *
>   */
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrt=
imer *t)
>  {
> +	enum hrtimer_restart ret =3D HRTIMER_RESTART;
>  	struct packet_sock *po =3D
>  		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
>  	struct tpacket_kbdq_core *pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
> @@ -732,8 +759,17 @@ static void prb_retire_rx_blk_timer_expired(struct=
 timer_list *t)
>  	frozen =3D prb_queue_frozen(pkc);
>  	pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
>  =

> -	if (unlikely(pkc->delete_blk_timer))
> +	if (unlikely(pkc->delete_blk_timer)) {
> +		ret =3D HRTIMER_NORESTART;
>  		goto out;
> +	}
> +
> +	/* See comments in _prb_refresh_rx_retire_blk_timer. */
> +	if (ktime_compare(pkc->expire_ktime,
> +			  hrtimer_get_expires(&pkc->retire_blk_timer)) > 0) {
> +		hrtimer_set_expires(&pkc->retire_blk_timer, pkc->expire_ktime);
> +		goto out;
> +	}
>  =

>  	/* We only need to plug the race when the block is partially filled.
>  	 * tpacket_rcv:
> @@ -757,7 +793,7 @@ static void prb_retire_rx_blk_timer_expired(struct =
timer_list *t)
>  				goto refresh_timer;
>  			}
>  			prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
> -			if (!prb_dispatch_next_block(pkc, po))
> +			if (!prb_dispatch_next_block(pkc, po, true))
>  				goto refresh_timer;
>  			else
>  				goto out;
> @@ -779,17 +815,18 @@ static void prb_retire_rx_blk_timer_expired(struc=
t timer_list *t)
>  				* opening a block thaws the queue,restarts timer
>  				* Thawing/timer-refresh is a side effect.
>  				*/
> -				prb_open_block(pkc, pbd);
> +				prb_open_block(pkc, pbd, true);
>  				goto out;
>  			}
>  		}
>  	}
>  =

>  refresh_timer:
> -	_prb_refresh_rx_retire_blk_timer(pkc);
> +	_prb_refresh_rx_retire_blk_timer(pkc, true);
>  =

>  out:
>  	spin_unlock(&po->sk.sk_receive_queue.lock);
> +	return ret;
>  }
>  =

>  static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
> @@ -890,7 +927,7 @@ static void prb_thaw_queue(struct tpacket_kbdq_core=
 *pkc)
>   *
>   */
>  static void prb_open_block(struct tpacket_kbdq_core *pkc1,
> -	struct tpacket_block_desc *pbd1)
> +	struct tpacket_block_desc *pbd1, bool callback)
>  {
>  	struct timespec64 ts;
>  	struct tpacket_hdr_v1 *h1 =3D &pbd1->hdr.bh1;
> @@ -921,7 +958,7 @@ static void prb_open_block(struct tpacket_kbdq_core=
 *pkc1,
>  	pkc1->pkblk_end =3D pkc1->pkblk_start + pkc1->kblk_size;
>  =

>  	prb_thaw_queue(pkc1);
> -	_prb_refresh_rx_retire_blk_timer(pkc1);
> +	_prb_refresh_rx_retire_blk_timer(pkc1, callback);
>  =

>  	smp_wmb();
>  }
> @@ -965,7 +1002,7 @@ static void prb_freeze_queue(struct tpacket_kbdq_c=
ore *pkc,
>   * So, caller must check the return value.
>   */
>  static void *prb_dispatch_next_block(struct tpacket_kbdq_core *pkc,
> -		struct packet_sock *po)
> +		struct packet_sock *po, bool callback)
>  {
>  	struct tpacket_block_desc *pbd;
>  =

> @@ -985,7 +1022,7 @@ static void *prb_dispatch_next_block(struct tpacke=
t_kbdq_core *pkc,
>  	 * open this block and return the offset where the first packet
>  	 * needs to get stored.
>  	 */
> -	prb_open_block(pkc, pbd);
> +	prb_open_block(pkc, pbd, callback);
>  	return (void *)pkc->nxt_offset;
>  }
>  =

> @@ -1124,7 +1161,7 @@ static void *__packet_lookup_frame_in_block(struc=
t packet_sock *po,
>  			 * opening a block also thaws the queue.
>  			 * Thawing is a side effect.
>  			 */
> -			prb_open_block(pkc, pbd);
> +			prb_open_block(pkc, pbd, false);
>  		}
>  	}
>  =

> @@ -1143,7 +1180,7 @@ static void *__packet_lookup_frame_in_block(struc=
t packet_sock *po,
>  	prb_retire_current_block(pkc, po, 0);
>  =

>  	/* Now, try to dispatch the next block */
> -	curr =3D (char *)prb_dispatch_next_block(pkc, po);
> +	curr =3D (char *)prb_dispatch_next_block(pkc, po, false);
>  	if (curr) {
>  		pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
>  		prb_fill_curr_block(curr, pkc, pbd, len);
> diff --git a/net/packet/diag.c b/net/packet/diag.c
> index 6ce1dcc28..c8f43e0c1 100644
> --- a/net/packet/diag.c
> +++ b/net/packet/diag.c
> @@ -83,7 +83,7 @@ static int pdiag_put_ring(struct packet_ring_buffer *=
ring, int ver, int nl_type,
>  	pdr.pdr_frame_nr =3D ring->frame_max + 1;
>  =

>  	if (ver > TPACKET_V2) {
> -		pdr.pdr_retire_tmo =3D ring->prb_bdqc.retire_blk_tov;
> +		pdr.pdr_retire_tmo =3D ktime_to_ms(ring->prb_bdqc.interval_ktime);
>  		pdr.pdr_sizeof_priv =3D ring->prb_bdqc.blk_sizeof_priv;
>  		pdr.pdr_features =3D ring->prb_bdqc.feature_req_word;
>  	} else {
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index 1e743d031..f2df563c7 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -45,12 +45,12 @@ struct tpacket_kbdq_core {
>  	/* Default is set to 8ms */
>  #define DEFAULT_PRB_RETIRE_TOV	(8)
>  =

> -	unsigned short  retire_blk_tov;
> +	ktime_t		interval_ktime;
>  	unsigned short  version;
> -	unsigned long	tov_in_jiffies;
>  =

>  	/* timer to retire an outstanding block */
> -	struct timer_list retire_blk_timer;
> +	struct hrtimer  retire_blk_timer;
> +	ktime_t		expire_ktime;
>  };
>  =

>  struct pgv {
> -- =

> 2.34.1
> =




