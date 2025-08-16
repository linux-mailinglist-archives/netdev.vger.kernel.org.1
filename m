Return-Path: <netdev+bounces-214318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46ECB28F97
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 18:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7605C1157
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A858C2E2EF1;
	Sat, 16 Aug 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KmbVGsLI"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648D2D7D2E;
	Sat, 16 Aug 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362632; cv=none; b=dswyhq4rWUBzZN/SdSpc6RfyhPSO2AOYIbe2T9NJcWeSVuBGMQ9J+K3eN/qe1hBhqU4Fvky+PdqsBB/l3Ah3jok7xgw2B/1omaXYhR5oK4kjt1ReqLJhhtH5J9k8VNQ0BDPznh2pKHOOSDtoqEhejJDeenHIoudUcynXzcd2zOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362632; c=relaxed/simple;
	bh=QFOx72wU1s8gFiOyW/dyOTG3O6YKCzPz8rY6F1tc7aE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HcbhYBd13nAZkNKLtzSYS/3gRuc8pavlR4Q8rRZOcRLlr0V8UB3vUMnm/cCw7GYAQcOJ01HNKsa2zC/p4UBRfIcnV1kolYC+wcvgd8k4jbLuceOdjP6TU4rpf6gHGv8bPCtzAw/cmUVGx1w/8gkiAzT0zM5bljfAzkR+d+Kc3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KmbVGsLI; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=n6
	E5DnZo146mCizuYkE0gx/bTjkOLCZ8p0grMcu6VhU=; b=KmbVGsLICjQnUFJos6
	1UA5YG8wu3tTkRkmoAMYzhok4M/1h05TDXjViuRnlbANiDH0cYHnB6jcQiB8bMgJ
	gE9DbrqP4lI4oUi8MhXJhHbZ1mwDs+PtGG4Xi3l06Za8hUCplow8nCwk4i14poUk
	dyzy28oe3nOOVGmxTVWempygY=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHeIgRtaBoJbmCBw--.33910S2;
	Sun, 17 Aug 2025 00:42:58 +0800 (CST)
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
Subject: Re: [PATCH v2] net: af_packet: Use hrtimer to do the retire operation
Date: Sun, 17 Aug 2025 00:42:57 +0800
Message-Id: <20250816164257.3908597-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHeIgRtaBoJbmCBw--.33910S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3ArW5Xr1xKr45uF1rury3Jwb_yoWxGFyDpF
	W5JFy7Gwn7Xr429F4xZF4kZFy5u397Ar15Grn3Ww1Fya9xGFyrta129FWYgF47KFsFywnF
	vF48Zr95Awn8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-jjkUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibg+rCmigqMbL2wAAs2

On Sat, 2025-08-16 at 17:33 +0800, Willem wrote:

> > > > -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> > > 
> > > Since the hrtimer API takes ktime, and there is no other user for
> > > retire_blk_tov, remove that too and instead have interval_ktime.
> > > 
> > > >  	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
> > 
> > We cannot simply remove the retire_blk_tov field, because in net/packet/diag.c 
> > retire_blk_tov is being used in function pdiag_put_ring. Since there are still
> > people using it, I personally prefer not to remove this variable for now. If
> > you think it is still necessary, I can remove it later and adjust the logic in
> > diag.c accordingly, using ktime_to_ms to convert the ktime_t format value back
> > to the u32 type needed in the pdiag_put_ring function.
> 
> Yes, let's remove the unnecessary extra field.
>  
> > 

OK, I will delete the 'retire_blk_tov' and add field named 'interval_ktime' instead.
And Accordingly, we also need to modify the logic in diag.c. The related changes are
as follows:
index 6ce1dcc28..c8f43e0c1 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -83,7 +83,7 @@ static int pdiag_put_ring(struct packet_ring_buffer *ring, int ver, int nl_type,
        pdr.pdr_frame_nr = ring->frame_max + 1;

        if (ver > TPACKET_V2) {
-               pdr.pdr_retire_tmo = ring->prb_bdqc.retire_blk_tov;
+               pdr.pdr_retire_tmo = ktime_to_ms(ring->prb_bdqc.interval_ktime);
                pdr.pdr_sizeof_priv = ring->prb_bdqc.blk_sizeof_priv;
                pdr.pdr_features = ring->prb_bdqc.feature_req_word;
        } else {


> > 
> > > > +	hrtimer_set_expires(&pkc->retire_blk_timer,
> > > > +			    ktime_add(ktime_get(), ms_to_ktime(pkc->retire_blk_tov)));
> > > 
> > > More common for HRTIMER_RESTART timers is hrtimer_forward_now.
> > > 
> > > >  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
> > 
> > As I mentioned in my previous response, we cannot use hrtimer_forward_now here
> > because the function _prb_refresh_rx_retire_blk_timer can be called not only
> > when the retire timer expires, but also when the kernel logic for receiving
> > network packets detects that a network packet has filled up a block and calls
> > prb_open_block to use the next block. This can lead to a WARN_ON being triggered
> > in hrtimer_forward_now when it checks if the timer has already been enqueued
> > (WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED)).
> > I encountered this issue when I initially used hrtimer_forward_now. This is the
> > reason why the existing logic for the regular timer uses mod_timer instead of
> > add_timer, as mod_timer is designed to handle such scenarios. A relevant comment
> > in the mod_timer implementation states:
> >  * Note that if there are multiple unserialized concurrent users of the
> >  * same timer, then mod_timer() is the only safe way to modify the timeout,
> >  * since add_timer() cannot modify an already running timer.
> 
> Please add a comment above the call to hrtimer_set_expires and/or in
> the commit message. As this is non-obvious and someone may easily
> later miss that and update.


I will add a comment in PATCH v3 as below:
 static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
-       mod_timer(&pkc->retire_blk_timer,
-                       jiffies + pkc->tov_in_jiffies);
+       /* We cannot use hrtimer_forward_now here because the function
+        * _prb_refresh_rx_retire_blk_timer can be called not only when
+        * the retire timer expires, but also when the kernel logic for
+        * receiving network packets detects that a network packet has
+        * filled up a block and calls prb_open_block to use the next
+        * block. This can lead to a WARN_ON being triggered in
+        * hrtimer_forward_now when it checks if the timer has already
+        * been enqueued.
+        */
+       hrtimer_set_expires(&pkc->retire_blk_timer,
+                           ktime_add(ktime_get(), pkc->interval_ktime));
        pkc->last_kactive_blk_num = pkc->kactive_blk_num;
 }



> 
> So mod_timer can also work as add_timer.
> 
> But for hrtimer, is it safe for an hrtimer_setup call to run while a
> timer is already queued? And same for hrtimer_start.


In the current patch, the hrtimer_setup and hrtimer_start will be called only when
the af_packet-mmap user call setsockopt, and then the following call chain:
  packet_setsockopt
    packet_set_ring
      init_prb_bdqc
        prb_setup_retire_blk_timer
          hrtimer_setup
          hrtimer_start
So once the socket setup, hrtimer_setup and hrtimer_start will never be called again.
However, I also tested calling hrtimer_setup and hrtimer_start within the hrtimer
expiration callback function, and it seems that it does not affect the normal
operation of the timer (the first line of the hrtimer_start comment states that
* hrtimer_start - (re)start an hrtimer, indicating that it can handle this scenario).
As you previously suggested, the hrtimer expiration callback functions typically use
hrtimer_set_expires or hrtimer_forward_now. In addition, repeatedly calling
hrtimer_setup and hrtimer_start within the hrtimer expiration callback function is
also a waste of CPU resources. Therefore, my current patch does not use hrtimer_start
within the hrtimer expiration callback function. I already change it in PATCH v1 as I
mentioned it in Changes in v1:
...
- Use hrtimer_set_expires instead of hrtimer_start_range_ns when retire timer needs update
  as suggested by Willem de Bruijn. Start the hrtimer in prb_setup_retire_blk_timer;
...
The implementation of _prb_refresh_rx_retire_blk_timer in the current patch is as follows:
static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
{
	/* We cannot use hrtimer_forward_now here because the function
	 * _prb_refresh_rx_retire_blk_timer can be called not only when
	 * the retire timer expires, but also when the kernel logic for
	 * receiving network packets detects that a network packet has
	 * filled up a block and calls prb_open_block to use the next
	 * block. This can lead to a WARN_ON being triggered in
	 * hrtimer_forward_now when it checks if the timer has already
	 * been enqueued.
	 */
	hrtimer_set_expires(&pkc->retire_blk_timer,
			    ktime_add(ktime_get(), pkc->interval_ktime));
	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
}


Thanks
Xin Zhao


