Return-Path: <netdev+bounces-80383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB17D87E912
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 13:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B358B21662
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E88F376F5;
	Mon, 18 Mar 2024 12:03:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D1364DA
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710763407; cv=none; b=WmeHqRQvduHkeYZ1ky+cSWNUIdcWzYOH6/aLJ+FNt5yuIYAlKi61+c9cE3LNcnguy4HEVI9CopIjMdsHt9wenwmh+JkPk/GKgkJ2kEVXxFngXxMwhTTRga7imk00d480e/73jpPBK0B1MbQmLh5YSkVXUyXVrWI5K2Bl4yTFlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710763407; c=relaxed/simple;
	bh=YIWns66mHslONjfe+kYLk4NUcFAdc5dK6RESNp0N0Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeXLSIIIRaxpJnlzdb984fVC5J0BV3rvYSHv1nFjUdwKRNm4Ww4vVq60HwwpafLJQY6dtcB97ZzPd9EUtrII+avLHEtJIczqeQojOzFeTEzVrfr4beCv0ibIl1SPow78kG5Ukh5YQxspk+hje1OnubpyF8tad6Np+DWSkmsqcfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rmBhz-0008AE-P6; Mon, 18 Mar 2024 13:03:15 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rmBhz-0074F7-7L; Mon, 18 Mar 2024 13:03:15 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rmBhz-005Ufm-0T;
	Mon, 18 Mar 2024 13:03:15 +0100
Date: Mon, 18 Mar 2024 13:03:15 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: netdev@vger.kernel.org
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
Message-ID: <ZfgtgwEM69VPJGs7@pengutronix.de>
References: <20240315100159.3898944-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315100159.3898944-1-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Apologies, I have sent the wrong mail. Here is the mail I really wanted
to send, with answers to some of the questions Paolo raised the last
time I sent it.

-----------------------------------8<------------------------------

From 566bb198546423c024cdebc50d0aade7ed638a40 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 23 Oct 2023 14:13:46 +0200
Subject: [PATCH v2] net: Do not break out of sk_stream_wait_memory() with TIF_NOTIFY_SIGNAL

It can happen that a socket sends the remaining data at close() time.
With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
current task. This flag has been set in io_req_normal_work_add() by
calling task_work_add().

It seems signal_pending() is too broad, so this patch replaces it with
task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.

A discussion of this issue can be found at
https://lore.kernel.org/20231010141932.GD3114228@pengutronix.de

Suggested-by: Jens Axboe <axboe@kernel.dk>
Fixes: 12db8b690010c ("entry: Add support for TIF_NOTIFY_SIGNAL")
Link: https://lore.kernel.org/r/20231023121346.4098160-1-s.hauer@pengutronix.de
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Changes since v1:
- only replace signal_pending() with task_sigpending() where we need it,
  in sk_stream_wait_memory()

I'd like to pick up the discussion on this patch as it is still needed for our
usecase. Paolo Abeni raised some concerns about this patch for which I didn't have
good answers. I am referencing them here again with an attempts to answer them.
Jens, maybe you also have a few words here.

Paolo raised some concerns in
https://lore.kernel.org/all/e1e15554bfa5cfc8048d6074eedbc83c4d912c98.camel@redhat.com/:

> To be more explicit: why this will not cause user-space driven
> connect() from missing relevant events?

Note I dropped the hunk in sk_stream_wait_connect() and
sk_stream_wait_close() in this version.
Userspace driven signals are still catched with task_sigpending() which
tests for TIF_SIGPENDING. signal_pending() will additionally check for
TIF_NOTIFY_SIGNAL which is exclusively used by task_work_add() to add
work to a task.

> Why this is needed only here and not in all the many others event loops waiting
> for signals?

There might be other cases too, but this one particularly bites us. I guess in
other places the work can be picked up again after being interrupted by a signal,
but here it can't.

> Why can't the issue be addressed in any place more closely tied to the
> scenario, e.g. io_uring or ktls?

At least I don't have an idea how this could be done. All components seem
to do the right thing on their own, but the pieces do not seem to fit
together for this particular case.

Jens, please correct me if I am wrong or if you have something to add, this whole
thing is outside my comfort zone, but I'd be very happy if we could solve this
issue somehow.

Thanks,
  Sascha

 net/core/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index b16dfa568a2d5..55d90251205a6 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -134,7 +134,7 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 			goto do_error;
 		if (!*timeo_p)
 			goto do_eagain;
-		if (signal_pending(current))
+		if (task_sigpending(current))
 			goto do_interrupted;
 		sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 		if (sk_stream_memory_free(sk) && !vm_wait)
-- 
2.39.2


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

