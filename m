Return-Path: <netdev+bounces-59487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E7181B082
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 09:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C5A1F2364D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31771171A4;
	Thu, 21 Dec 2023 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="WuZ9+WMP"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03A17989
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1703147801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qwBeQpyRyJ5/M8fXdCU0FeKDVWyTbs52D0JEP2x1r60=;
	b=WuZ9+WMPFdpsFu52dmee2AnYWGiC7LQGsnGcv+H6O7QjW6d2yB0fF7bNeibEm7nrpdpp7c
	Vgpojn7FT/TRi6xtldUwEYSLPDo02PYuOef1SGXhOjgAIuw3F+fZYy12jcPQCatfgCnBtl
	BmVKMPJdjx65GGVfkKuMNOpGJWESc7A=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Catalin Marinas <catalin.marinas@arm.com>
Cc: Jinho Ju <wnwlsgh98@gmail.com>, netdev@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Fwd: Fwd: memory leak in batadv_iv_ogm_aggregate_new
Date: Thu, 21 Dec 2023 09:36:38 +0100
Message-ID: <3458658.QJadu78ljV@ripper>
In-Reply-To:
 <CAF0rt231R2FW9NP_f5HOoSQsCaK3XSZfZxbhTkKvqM0n7orbOg@mail.gmail.com>
References:
 <CAF0rt23md=LtOu5_u4zTvZbE-cDwoJOvg7NRCqX-P=ZuQbidAA@mail.gmail.com>
 <CAF0rt20CDXotBSY=wrW3oWQOQmmpDmtUpP9UaL4QK7hnuDt_0Q@mail.gmail.com>
 <CAF0rt231R2FW9NP_f5HOoSQsCaK3XSZfZxbhTkKvqM0n7orbOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1877647.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1877647.CQOukoFCf9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Fwd: Fwd: memory leak in batadv_iv_ogm_aggregate_new
Date: Thu, 21 Dec 2023 09:36:38 +0100
Message-ID: <3458658.QJadu78ljV@ripper>
MIME-Version: 1.0

On Thursday, 21 December 2023 06:52:01 CET Jinho Ju wrote:
> Resending to everyone on the mailing list as per previous mail, adding some
> things that were missing.
> 
> Regarding the cause of the L2-related crash being detected by syzkaller,

What crash? I can't see it in your mail [1]

> I
> can't say for sure - what I can say for sure at this point is that a
> memleak occurring in L2 was detected by my personal syzkaller.

Nothing tells you that the actual leak happened in layer 2. You only know that 
packets were generated in batman-adv and mac80211_hwsim. But nothing tells you 
what actually lost track of the skbuff (if that even happens).

> Moving away from syzkaller for a moment and shifting the focus to memleak,
> we have to assume that the conditions for this to occur are that they
> reference the same network stack and are found in modules in L2,

What do you mean with "reference the same network stack"?

And no, nothing tells you that the culprit is actually something related to 
network layer 2.

> but it
> seems that when batman-adv is freed and returned while accessing and
> processing a skb in veth (L3),

veth is layer 2.

> memleak occurs because it is trying to
> reference the same skb, the veth freed skb.

This doesn't make a lot of sense. batman-adv is not referencing the skb 
anymore after it was submitted to the underlying device. And if it would 
reference anything then it would not be a memleak.


There are a lot of possibilities:

* kmemleak cannot not handling transient queue state correctly while the 
  namespace is destroyed (because it doesn't have a consistent memory state 
  while it scans)
* removing of the network namespace (used by the reproducers) might leak skbs 
  which are currently passed around between the queues
* there is an actual memory leak somewhere while the queued packets are processed
* ...

The first two option seem plausible to me because you can see "memory leaks" 
in for other things which regularly (and often) transmit packets in this 
namespace. In you log, this would hwsim which transmits beacons regularly (and 
often).

I would guess that you see something similar when you use pktgen.

It would now be interesting if you still see the memory leak if you mark all 
unfreed objects as grey and redo the scan:


   echo clear > /sys/kernel/debug/kmemleak
   echo scan > /sys/kernel/debug/kmemleak

If you would still see it then we could rule out the first option. If not, 
then it is a false positive.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/GLS6TCIPHIMWF2G6PVDEEK6UDVFB6UD2/
--nextPart1877647.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmWD+RcACgkQXYcKB8Em
e0aoVxAAuhHv87k2P9ZTaWNGYewiXth1hgk2kl7s6+40pdIAKlszI11W8/KhIW3t
LI1OqwOlgCRkpTrOKLTkeBNQIA+bYI88aXE51YpK63CAQ5okf4WJj+/VAXonUI8Z
pgj5LcgCkEf9x7qtef+U6wtDHSD0ebe24C3Qrx2VIiA1Kf68jashgPkP89rwWFCd
E7BDOm0idc2w8RTHzrYdCNnGMl2zhQa/0WmIb7HFJlbOWq6hh0nZZ7eHF2vIlJQQ
B/HSHa8mSkSOvv4Rs2AEP9wyJi0dK07w+o3pNCuyfNd5gaEQMB9pTSHtYlBV/a5Y
xOhmyymOpNzn6UkK2hvsCYib4uP8p/7FXxNLffBAkhsJ7/zQAz5QARRCEp1xUOc0
3mt1c/3GaC7magQPelNJUrYQK50PrYeyoibthNjcy6WFJ8alhbIvxgb0WBI9UD16
7uRZVbbx0NDPrF8W5RnBTH9UPYYEqr1rHZ13q+E857RQmmZXq59U2jsdMUje6GRu
uyVDD3WPOR/3TozyvVbqAyEwjCzehaFn/vb/NOKOUIW+bqAVEzIPATsUr4Fy813z
+0XaV+Yb4n0PBGv1gWyG7ZK6P/tesGEs+kFN7X6vfMDNzi9ZX4pmAYt9sbQmozE/
DtmwGd+wjxSMAKx/53edluuMjRYaqvEgi1qZ0bbuijOPQrnXYVw=
=MRIv
-----END PGP SIGNATURE-----

--nextPart1877647.CQOukoFCf9--




