Return-Path: <netdev+bounces-213047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A763EB22E86
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76307AF22F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189E2F8BF8;
	Tue, 12 Aug 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gm1htpT5"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0082F83CE;
	Tue, 12 Aug 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018312; cv=none; b=NO2/8TF1ZTPpda6PSHmlTtp/dcKKVxR+UfucZqghffIXy9IX+L7QkDVKnnV8OwiIcp9RmNV2REMTSpJALLd5OQe9Z40rHOlyLclPEJmC2rTiEYtadaNPXk0Jcc5vWKpHW3nWieg/nI9/UvA0QQJgW+RLICM5rOe7u3xPT3wrZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018312; c=relaxed/simple;
	bh=NQTEZl9pZAXnSXVryxNtdsNz0W9aBjYzDb0D4HpaHIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nTMxz10QNE+vdAzUArHZU/iUgQyphEPndY+O1brrbs+YLopzTjC81xJRJz4nz9GJF2IqI7CAkCEZyF7TYnVPQCwr3UqtABxWoRP9ajsKzQeBq866OtOt2dx6pEQxBxZHeO6QulE/LYXpl8nzsKJD1C/O7ElMD/zrZ+jDBiq1z98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gm1htpT5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=60
	GzXJ/pzzYqeT1Unc8iYznrFO7L2shobSHFgzePkIM=; b=Gm1htpT5ydBtG43C55
	mprn8ZogaNRK/p16ppEdbHENIrAj8ZDJ4pP8896XxNHeSubJ7TIvbyTwo90Y47u1
	zMs7eurBXKZDwx+RZalBPFWG3QktW1QNgY40GrfuXBS1l1ZRbTSNiYOyERDuf9om
	8VuBr+/6/viFBF/1/zRLaAPI8=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBnKQUedJtoVOYKBA--.44003S2;
	Wed, 13 Aug 2025 01:04:31 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: af_packet: Use hrtimer to do the retire operation
Date: Wed, 13 Aug 2025 01:04:30 +0800
Message-Id: <20250812170430.290604-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnKQUedJtoVOYKBA--.44003S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1rXrW3ZrW7Aw45urWUtwb_yoW8KF45pa
	y5W347GwsrZF12gr4UAw48ZFyrK3WDArn8Gws3Grsayas5GFyrtayj9FZ0qFWxtF4q9F4x
	Ar4rZr98Cwn0q3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK-erUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbioxWmCmiaBhczAwACsL

On Mon, 2025-08-11 at 22:48 +0800, Willem wrote:

> > @@ -603,9 +603,10 @@ static void prb_setup_retire_blk_timer(struct packet_sock *po)
> >  	struct tpacket_kbdq_core *pkc;
> > 
> >  	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> > -	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> > -		    0);
> > -	pkc->retire_blk_timer.expires = jiffies;
> > +	hrtimer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> > +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> > +	if (pkc->tov_in_msecs == 0)
> > +		pkc->tov_in_msecs = jiffies_to_msecs(1);

> why is this bounds check needed now, while it was not needed when
> converting to jiffies?
> 
> init_prb_bdqc will compute a retire_blk_tov if it is passed as zero,
> by calling prb_calc_retire_blk_tmo.

Dear Willem,

I am very grateful for your suggestion. I will delete this bounds check in the v1
PATCH.


> >  static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> >  {
> > -	mod_timer(&pkc->retire_blk_timer,
> > -			jiffies + pkc->tov_in_jiffies);
> > +	hrtimer_start_range_ns(&pkc->retire_blk_timer,
> > +			       ms_to_ktime(pkc->tov_in_msecs), 0, HRTIMER_MODE_REL_SOFT);

> Just hrtimer_start if leaving the slack (delta_ns) as 0.
> 
> More importantly, this scheduled the timer, while the caller also
> returns HRTIMER_RESTART. Should this just call hrtimer_set_expires or
> hrtimer_forward.

I will use hrtimer_set_expires here while using hrtimer_start in 
prb_setup_retire_blk_timer to start the timer.
Previously I used hrtimer_forward here, then encountered 
WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED warning in the hrtimer_forward
function. This warning occurred because the tpacket_rcv function eventually calls
prb_open_block, which might call _prb_refresh_rx_retire_blk_timer at the same time
prb_retire_rx_blk_timer_expired might also call _prb_refresh_rx_retire_blk_timer,
leading to the warning.


> >  refresh_timer:
> >  	_prb_refresh_rx_retire_blk_timer(pkc);
> > +	ret = HRTIMER_RESTART;
> 
> reinitializing a variable that was already set to the same value?
> > 
> >  out:
> >  	spin_unlock(&po->sk.sk_receive_queue.lock);
> > +	return ret;
> 
> just return HRTIMER_RESTART directly.
> >  }

I will modify the patch based on these suggestions and upload it later.


Thanks
Xin Zhao


