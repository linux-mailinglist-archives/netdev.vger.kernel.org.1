Return-Path: <netdev+bounces-261072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHKVCWBan2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:24:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0E719D292
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCC8F3040FA0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697330BBA9;
	Wed, 25 Feb 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/QGmR+D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC5306B21
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051036; cv=none; b=uz1P9W7dNw+cxTKd+KfekvQ6+3Tz8pdUkARLlOa5Ab98neepi9lDPdqCt4oCc+dpwmFqCztE5i9rzjFSmnikr65eEqkrkp9bIb+GiOQWwkKMLeNT59M+bWJvtkusS3GA2LLzTgBAaOVfAyXj+UYfMLEMmTbLvK5SBeMMeMxRO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051036; c=relaxed/simple;
	bh=wPACCCOK6OkuVBu6e8BT4Sp6f1WmW9u00X1g3PRY4U4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ddnv61FJZPfOqtSnoXzXoVXHFzjqQBAFLpZZegvfxRYd9dwb9LWR730kOCUqQZ05c8jc6qskTJt8jikw28MPKGFZl7++1PmD7NtHHhgCUMavBgVamOGS8ZseVDBimJnXd2hG8kmSdqWAu+i5ecy2RU8h4S5bUwM5ZNdYIm5jQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/QGmR+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7F6C19421;
	Wed, 25 Feb 2026 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772051036;
	bh=wPACCCOK6OkuVBu6e8BT4Sp6f1WmW9u00X1g3PRY4U4=;
	h=Date:From:To:Cc:Subject:From;
	b=N/QGmR+DQDFm2CTSKlD+thvEgX/yM0Ko13XdUsQeKSJ9iTLXEWtbavczpPFsm5YUL
	 xr2RuiD2TN66yOf6Bc7H11WOC+3pJHNQGB92W9OXsMhQQo8uHn7pcK3KniF6knQWfM
	 l+X185lLeEhcOaP+wgMGtAsBwfbYkPD6fRUca5flZLze5oxcFdC9X9C9s8Suof7Ct2
	 vL1fD5tahwOalzew5kW9V0avK0n2rkkNJm1P8AgQaReC6K29BKHfzHk5adMH2Bmbql
	 2B1Wh/xSQJPpL1z5EH7QdmxZ5Wm6Az4bF60lkL9tKzWLfuKW/PncMwodm4tp8XDyHL
	 JvvnY1npVz6Jg==
Date: Wed, 25 Feb 2026 12:23:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Subject: TCP OOM drops with the stricter rcvbuf checking
Message-ID: <20260225122355.585fd57b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261072-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF0E719D292
X-Rspamd-Action: no action

Hi Eric!

Even with commit f017c1f768b6 ("tcp: use skb->len instead of
skb->truesize in tcp_can_ingest()") we see a huge increase in
rcvq drops. Some uwsgi trigger a ton of drops over loopback,
prior kernel had 0.000003958 drops per second, with the
changes up to f017c1f768b6 it's 0.826685681 drops / sec
(for the most impacted workload)

After much digging I see that the worst workload hits the drops
with sockets in the following state:

 ifindex: 1 
 rcvbuf: 131072
 window_clamp: 129024
 scaling_ratio: 252
 rx_bytes: 2673351
 inq: 59392 (rcvq: skb_cnt:1 [truesize:64384,eaten:4096:frags:2|no-fraglist])
 sk_rmem_alloc: 64384
 incoming skb: len:67584
 deficit: -896

(I wasted quite a bit of time mislead by deficit being the skb
overhead :|)

I _think_ what happens is simpler, because we round up the window
we advertise:

  window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));

so we effectively grant extra window space to the sender which we
then don't honor. This matters less for real NICs which have lower
scaling_ratio as the lie hides in the skb->len vs skb->truesize
relaxation that f017c1f768b6 made. But over loopback with scaling
ratio >250 we can't hide 800B of overshoot, even on a 64kB skb.

I'm not entirely sure how to fix this. Of course we can give:

  1 << tcp_sk(sk)->rx_opt.rcv_wscale;

of slack in tcp_can_ingest() (or maybe just a fixed value like 16kB?)

But aligning the window down instead of up feels much cleaner to me.
IDK if this can regress anything:

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118..9f7ed76a97aa 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3383,7 +3383,8 @@ u32 __tcp_select_window(struct sock *sk)
                 * Import case: prevent zero window announcement if
                 * 1<<rcv_wscale > mss.
                 */
-               window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
+               if (window < (1 << tp->rx_opt.rcv_wscale))
+                       window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
        } else {
                window = tp->rcv_wnd;
                /* Get the largest window that is a nice multiple of mss.

(possibly we could avoid the branch with some ALU magic)

Does this make sense?

