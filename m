Return-Path: <netdev+bounces-217886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C443B3A46F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385E5987B96
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DBF2397BF;
	Thu, 28 Aug 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5MP45w6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383123817E;
	Thu, 28 Aug 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395011; cv=none; b=Tze1c2fluyqpL+Eg/alsRAIjIqai6hmbdiXlIEAq4vg9z480dycMIFcXYtQgmyPb4lqkkfCR3PtzME5jFmNuIH06/VXHbcHG/q1PfVdMikSLNNNTrjtccOfjazOrNhnrs46uT6KGetnjblzaf59I/Ds3VpXIHaEBRJv2aNEvGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395011; c=relaxed/simple;
	bh=LAjHcbnNbm+VyQgdiBTbZgI7j+nIqmKuZksO/PduWXk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MP0p/BH4wvB5coMI6pZTiO/dRt782Xn1bleJOnCrUrvfoG1VHyDZz7fkN546EDOnDU7m4CIHdmKnmdUv6K8H/R4lUzlbppnn8cuOoHZbV2I0vdyxLNVsBpUQk4qXHkehq36y79wEOS+pRIpzmeQm4Qtvc7c7/wIOCRth8sBkCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5MP45w6; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54393096381so756062e0c.2;
        Thu, 28 Aug 2025 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756395008; x=1756999808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbCW5ruVZKbISbmbZ8Vx2LKcE5+fXG2+P8+u/w4w0/M=;
        b=Q5MP45w6mkzDtS2Tg7tkf7+jI+emZ/29uHl3wPfnztktHxCbNBS0xm0r/hhTdG7XPZ
         E348KJ7szG3KBryJteWKYvGFE6bHE6FC0qrD8BKW2pqNnqWb+VLjjF9sQdX4LeuXWxld
         F9IxwC6WBcFgwFxCeryKnp5QH+2JsstARkFFE4pODLsjN0JI0+WmmLbyjyvgA0oGkewg
         3Yv2sGCLfZlcab2tVr70GLJkHpwlGrJUzoEh4+EIFG6prHpoc4CIDEByj7C5mVLM1KHz
         +ecRGbPLV4f4FByuGASEHfA31Qdlkd8hkRZtOWQuVN28UsxJzURYAffFiBaH+vxLDGM4
         Ow4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756395008; x=1756999808;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sbCW5ruVZKbISbmbZ8Vx2LKcE5+fXG2+P8+u/w4w0/M=;
        b=ofIJJFKUmFIx9DEye55aMFiHx7mV+gxjv5le442rqt0IPqrj8HGb2ANB/VgX4vxp7x
         UXsWFTn1yzNnrQBIKvsYiK6zZlMkpCEbm+0NUu3ET3irIeyXlS7ETLOM92zzuqWOr1IM
         ETdXhsZ8cVnWowH0q23lc95aKpb/uplFOCfRGVco+kH2A+byqJa6R/wF70OMQ8+BXvsI
         s/TZoi3fBDQ0O1MKrBIQBP9I2c801Dgc89slBHLp/vz6CCpazZZgs3/bhvJBVo9PFOsK
         3CTFKVEmHxveyu5AJM6kPD3ZMrvLNhbYTvXE1YN13NClAuH5SZYH4Azr1dlgNkG3eQCl
         WU/g==
X-Forwarded-Encrypted: i=1; AJvYcCWdwy1rgr0Ux5T6PgJ+05W2+ucfOY1RoiTcLMBKnxoJ/+C5Nzp7psKnRYQw5suC2YSVy2kjzoXy@vger.kernel.org, AJvYcCWi3oiUAEBTfGXrFnL+abUXa3vCwarexZwF0UcAeK6C3tp4W/KaWjwMbOKPshM3ixCY9hxFxgMVn3ZdUac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTf5TXwPM1MWIMiWsSwcq6np+TkNomFWAhvzo6zWoV/sOrUPjZ
	dfumjixLqBQTIFEKR7rv8DGbSREY2n/OMTvHhudVOcg84ddb5S2YAdmi
X-Gm-Gg: ASbGnctKyMdTYpvGkbexq/jWgDrdsXoRfXbvO8SR8yvg8wBZOyz4+jL5Xkb1W90z0OP
	2U3JFAgbFM3nRVKkiXF/9E2NkCqJuulcFBzmbR7fA17+fXHQa8TBpAUSY2DSVWveFkjQ88i0JQq
	hYJdlutv4s4TfWUqQp7BbdfgvR637VkDNDeMQKzW/YksBPh1bZ8hrYCF3NuTxgJRSd6uRSJvsOF
	nBZnEDNA6rzY25VCLiVfm10+fqu1BouGfFMucjvGENchMpVRKBqOZUyC2iiv/KloG11K/LGdGxs
	w8cLO7FuB7sYHEGwlieKXhWbauAF5KL3+zkQl/TcGvr5uDwiSIs2C6/xceb4MBD/mXFQySw9QP4
	Ut/X7ztVXaOBH/cfAJ5xWROTAurXDnVUQW+Mte5yEvHXnH2VGO3iiL7ydAo/iX6Rhi+VOXL3hnQ
	9WMQ==
X-Google-Smtp-Source: AGHT+IFqoFd5R0Ton8hfUU3hj2OJqhdRo2zKwH5ZrwE8TG2YxFbcJl35+M01rS+V6cMuhWZAaOgv3A==
X-Received: by 2002:a05:6122:8707:b0:542:59a2:731a with SMTP id 71dfb90a1353d-54259a279demr5358509e0c.16.1756395007798;
        Thu, 28 Aug 2025 08:30:07 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-5448cff511fsm767e0c.21.2025.08.28.08.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 08:30:07 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:30:06 -0400
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
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.33a7282981e76@gmail.com>
In-Reply-To: <20250828063140.2747329-1-jackzxcui1989@163.com>
References: <20250828063140.2747329-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v8] net: af_packet: Use hrtimer to do the retire
 operation
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
> On Thu, 2025-08-28 at 5:53 +0800, Willem wrote:
> 
> > > Changes in v8:
> > > - Delete delete_blk_timer field, as suggested by Willem de Bruijn,
> > >   hrtimer_cancel will check and wait until the timer callback return and ensure
> > >   enter enter callback again;
> > > - Simplify the logic related to setting timeout, as suggestd by Willem de Bruijn.
> > >   Currently timer callback just restarts itself unconditionally, so delete the
> > >  'out:' label, do not forward hrtimer in prb_open_block, call hrtimer_forward_now
> > >   directly and always return HRTIMER_RESTART. The only special case is when
> > >   prb_open_block is called from tpacket_rcv. That would set the timeout further
> > >   into the future than the already queued timer. An earlier timeout is not
> > >   problematic. No need to add complexity to avoid that.
> > 
> > This simplifies the timer logic tremendously. I like this direction a lot.
> 
> Thanks. :)
> 
> > 
> > >  static void prb_setup_retire_blk_timer(struct packet_sock *po)
> > > @@ -603,9 +592,10 @@ static void prb_setup_retire_blk_timer(struct packet_sock *po)
> > >  	struct tpacket_kbdq_core *pkc;
> > > 
> > >  	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> > > -	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> > > -		    0);
> > > -	pkc->retire_blk_timer.expires = jiffies;
> > > +	hrtimer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> > > +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> > > +	hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> > > +		      HRTIMER_MODE_REL_SOFT);
> > 
> > Since this is only called from init_prb_bdqc, we can further remove
> > this whole function and move the two hrtimer calls to the parent.
> 
> Okay, I will move hrtimer_setup and hrtimer_start into init_prb_bdqc in PATCH v9.
> 
> I do not move the prb_shutdown_retire_blk_timer into packet_set_ring either, because
> in packet_set_ring, there is no existing pointer for tpacket_kbdq_core. If move the
> logic of prb_shutdown_retire_blk_timer into packet_set_ring, we need to add the
> tpacket_kbdq_core pointer conversion logic in packet_set_ring, I think it is not
> necessary.

Agreed.
> 
> > >  }
> > > 
> > >  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> > > @@ -672,11 +662,10 @@ static void init_prb_bdqc(struct packet_sock *po,
> > >  	p1->last_kactive_blk_num = 0;
> > >  	po->stats.stats3.tp_freeze_q_cnt = 0;
> > >  	if (req_u->req3.tp_retire_blk_tov)
> > > -		p1->retire_blk_tov = req_u->req3.tp_retire_blk_tov;
> > > +		p1->interval_ktime = ms_to_ktime(req_u->req3.tp_retire_blk_tov);
> > >  	else
> > > -		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
> > > -						req_u->req3.tp_block_size);
> > > -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> > > +		p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(po,
> > > +						req_u->req3.tp_block_size));
> > >  	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
> > >  	rwlock_init(&p1->blk_fill_in_prog_lock);
> > > 
> > > @@ -686,16 +675,6 @@ static void init_prb_bdqc(struct packet_sock *po,
> > >  	prb_open_block(p1, pbd);
> > >  }
> > > 
> > > -/*  Do NOT update the last_blk_num first.
> > > - *  Assumes sk_buff_head lock is held.
> > > - */
> > > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > > -{
> > > -	mod_timer(&pkc->retire_blk_timer,
> > > -			jiffies + pkc->tov_in_jiffies);
> > > -	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
> > 
> > last_kactive_blk_num is now only updated on prb_open_block. It still
> > needs to be updated on each timer callback? To see whether the active
> > block did not change since the last callback.
> 
> Since prb_open_block is executed once during the initialization, after initialization,
> both last_kactive_blk_num and kactive_blk_num have the same value, which is 0. After
> initialization, if the value of kactive_blk_num remains unchanged, it is meaningless
> to assign the value of kactive_blk_num to last_kactive_blk_num. I searched through
> all the places in the code that can modify kactive_blk_num, and found that there is
> only one place, which is in prb_close_block. This means that after executing
> prb_close_block, we need to update last_kactive_blk_num at the corresponding places
> where it should be updated. Since I did not modify this logic under the tpacket_rcv
> scenario, I only need to check the logic in the hrtimer callback.
> 
> Upon inspection, I did find an issue. When tpacket_rcv calls __packet_lookup_frame_in_block,
> it subsequently calls prb_retire_current_block, which in turn calls prb_close_block,
> resulting in an update to kactive_blk_num. After executing prb_retire_current_block,
> function __packet_lookup_frame_in_block calls prb_dispatch_next_block, it may not
> execute prb_open_block. If prb_open_block is not executed, this will lead to an
> inconsistency between last_kactive_blk_num and kactive_blk_num. At this point, the
> hrtimer callback will check whether pkc->last_kactive_blk_num == pkc->kactive_blk_num,
> which will evaluate to false, thus causing the current logic to differ from the original
> logic. However, at this time, it is still necessary to update last_kactive_blk_num.
> 
> On the other hand, I also carefully checked the original implementation of
> prb_retire_rx_blk_timer_expired and found that in the original hrtimer callback,
> last_kactive_blk_num is updated in all cases. Therefore, I need to perform this update
> before exiting the sk_receive_queue lock.
> 
> In addition, in PATCH v9, I will also remove the refresh_timer label and change the only
> instance where goto is used, to an if-else implementation, so that the 'refresh_timer:'
> label is no longer needed.
> 
> The new implementation of prb_retire_rx_blk_timer_expired:
> 
> static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
> {
> 	struct packet_sock *po =
> 		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
> 	struct tpacket_kbdq_core *pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> 	unsigned int frozen;
> 	struct tpacket_block_desc *pbd;
> 
> 	spin_lock(&po->sk.sk_receive_queue.lock);
> 
> 	frozen = prb_queue_frozen(pkc);
> 	pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
> 
> 	/* We only need to plug the race when the block is partially filled.
> 	 * tpacket_rcv:
> 	 *		lock(); increment BLOCK_NUM_PKTS; unlock()
> 	 *		copy_bits() is in progress ...
> 	 *		timer fires on other cpu:
> 	 *		we can't retire the current block because copy_bits
> 	 *		is in progress.
> 	 *
> 	 */
> 	if (BLOCK_NUM_PKTS(pbd)) {
> 		/* Waiting for skb_copy_bits to finish... */
> 		write_lock(&pkc->blk_fill_in_prog_lock);
> 		write_unlock(&pkc->blk_fill_in_prog_lock);
> 	}
> 
> 	if (pkc->last_kactive_blk_num == pkc->kactive_blk_num) {
> 		if (!frozen) {
> 			if (BLOCK_NUM_PKTS(pbd)) {
> 				/* Not an empty block. Need retire the block. */
> 				prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
> 				prb_dispatch_next_block(pkc, po);
> 			}
> 		} else {
> 			/* Case 1. Queue was frozen because user-space was
> 			 *	   lagging behind.
> 			 */
> 			if (!prb_curr_blk_in_use(pbd)) {
> 			       /* Case 2. queue was frozen,user-space caught up,
> 				* now the link went idle && the timer fired.
> 				* We don't have a block to close.So we open this
> 				* block and restart the timer.
> 				* opening a block thaws the queue,restarts timer
> 				* Thawing/timer-refresh is a side effect.
> 				*/
> 				prb_open_block(pkc, pbd);
> 			}
> 		}
> 	}
> 
> 	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
> 	hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
> 	spin_unlock(&po->sk.sk_receive_queue.lock);
> 	return HRTIMER_RESTART;
> }

Ack.

