Return-Path: <netdev+bounces-298992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2bOvH/SQLWo/hgQAu9opvQ
	(envelope-from <netdev+bounces-298992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:18:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87D67F237
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:18:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ky4Yk4jK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298992-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298992-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D175300C24F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D5132B10D;
	Sat, 13 Jun 2026 17:18:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E8305673
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 17:18:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781371119; cv=none; b=ooNFjiUhyJZYY1+Lj54eZYpE/7rRUrAlri5CGvjrgZoSF2orOY9q5cJqW6lZI8THn2f/PlOKr9WqwG4ga7w4cGB7b73IsCWynXX7YKRyg7MJPnto3PvvxMyQQ6Q+sZfFkD5PFUJKvHCe4oMa9QeO1jUPIkYp/OJzrDppESl2/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781371119; c=relaxed/simple;
	bh=Cj5N0eeCmGO5Snsfg7U9jbw3jypnfrAo3YwWsSoyMOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK1p4bwRPvClxq7DoaMKC8uEd3qpyYViQp7TKJeG9FUD8nqT8PbQmceAo0VwV3EYkobO+eZZFo/DtG7KdExWu1h0AltsfoZuYwKTu3COoi8TeJIR4hFf0WK+i+X8qluZQZDwOy6QBqRhFkyCC12nfrshtsW+2tkGfDGpinCebLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky4Yk4jK; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso7915855e9.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781371116; x=1781975916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9WERUh0e5RRWU4hvKVbrVtwoM+Idz3+GqskEiEcWjU=;
        b=Ky4Yk4jKkAk5XURJrbYmOv7GB0fqJLjySPXF0/njsTkFJSftsY/MTPrHl2r73JlmJq
         YtYeCLyzu60VmlnB0HwHKiPLllxappq1D4uhNr6Q9roZhMr1q7Mu+9mx8U88E/bK3P6R
         Gvj+kcldwBYlgy8QOvJxfvflpRR6T4w72/zMlaDSsduHVaFMTqU6L3wOgwaJabsEztYU
         gbHlifh32fRgnAQM+HWoNpZ+qeh9eBuGviJsfVztKqwGarjtEMsY3NXmgPzEh+WgFcXt
         hRNuFuVD1MVqrB2Fc4E2KL1k1pbT/rOz/sbiYavl27HudMglJCmT5NXyMCWBfFWRuJB+
         1xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781371116; x=1781975916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9WERUh0e5RRWU4hvKVbrVtwoM+Idz3+GqskEiEcWjU=;
        b=iDnjqlKH/tGXRulFMwH/56feqDdNz5y1BZmj0ndgPhl0xc5pPJO8yh/Sbio+tdzypl
         D430T/TPs5D28QAtK4NUxFRdcc5gpec1z3xqYeBdzD3k9aITELwtZUjl/N+azi0qun6Q
         gxOsxmGHDqbjTPD575vlvopbUKODrx9JfXKI+h+ZutZhTeAzCufW/vraWXpuop9HCOWI
         G5jZJZPNw5/qCdzfGhothtxLKHOvyGmbYMR+vTidUMgaM5sVx8WVzhIEnJrDDwI4jX9g
         j/UnYqrLlCyvk+R2JWsunBfV1AO/DncI4QEGgcRTZjuAetIcQmlZ1rTZDs6WvrI7ygs/
         b5WA==
X-Forwarded-Encrypted: i=1; AFNElJ+kOAt2Iddd+hyzpHu10NnXe+wTAKl+FNttC1+6u5x1QSZdyC0blceUEXZsSxmgdfnsnMrh8CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcBRG6HkvkZhD+lI8uuimM9CMyCeu83XVwP4uxBQEA1TH6H2T
	tZAzoR+jnzPCctPwdYQs8/xNUuattqqM5skExSKKq05rpzIoeKzWnIA7
X-Gm-Gg: Acq92OHUKUQUOe7fhWbmh7s6klwqjGgnMVMtXU2J961HQ08xAaejQWL+LHckq/6gCJ2
	eukFsfwgNH/fVaSxUlzZjdbPEWyNIRsGy/az7aTHjTf5czoWrC6SzDwTHAR5YsMY05ZIJlvNuxU
	3Fg+Mh4Vne/KsoHJrK3qYTXtfmyov7T6Uskqg12BaExnWcIcPj4a58uaxujReK8Z51vQOBwb4GL
	PSyI/3CwLoPrWiq1Sj36SiqZDfJ6peDJAOwLUqKhxd3v7viASp6L9MpHHGcAKZB6PUdwfNtnbgT
	ChZJ1xest4d3PeTuag/g8MmGk0yj1rENgFojljHqsYRLvBL/9ECyv+CQ+TpkiiD3IVefely2M5H
	bXdOVTpY+5CuMzLU3344R/jzKFdFRCP0yg8qlUhMLsLvC5VJHss8gSf+1dOPyUiMsWpoFbdaaTu
	k+tN5RxMVuw5t3YYjfoixe8Y9FS3cObj69xvWE9Q2joNxGL+wtCe38sM0SN0b0ZuwE4X1stSNx3
	hldxtW+PR7XzElvHvq/SKni
X-Received: by 2002:a05:600c:3145:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490ec480f88mr89427715e9.2.1781371115732;
        Sat, 13 Jun 2026 10:18:35 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f38df00921b0efffe889e28.dip0.t-ipconnect.de. [2003:c1:4f38:df00:921b:eff:fe88:9e28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202edf89sm96591285e9.1.2026.06.13.10.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 10:18:34 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 6066731BD2D8; Sat, 13 Jun 2026 19:18:34 +0200 (CEST)
Date: Sat, 13 Jun 2026 19:18:34 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: tighten the FIN exception in tcp_sequence()
Message-ID: <ai2Q6r6m-iUWrUbR@gandalf.schnuecks.de>
References: <20260610-tcp_fin_more_restrictive-v1-1-eefc30d7ddd8@gmail.com>
 <20260612154355.37bb426d@kernel.org>
 <aiyY24QTFcqQVW25@gandalf.schnuecks.de>
 <CANn89i+q3Q_k3PHvwOJfOgor4xD1YzSVYO-G+fY4+_ddkKLTQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+q3Q_k3PHvwOJfOgor4xD1YzSVYO-G+fY4+_ddkKLTQw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298992-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:devnull+gmbnomis.gmail.com@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB87D67F237

Hi Eric,

On Fri, Jun 12, 2026 at 08:47:51PM -0700, Eric Dumazet wrote:
> On Fri, Jun 12, 2026 at 4:40???PM Simon Baatz <gmbnomis@gmail.com> wrote:
> >
> > Hi Jakub,
> >
> > On Fri, Jun 12, 2026 at 03:43:55PM -0700, Jakub Kicinski wrote:
> > > On Wed, 10 Jun 2026 00:09:24 +0200 Simon Baatz via B4 Relay wrote:
> > > > From: Simon Baatz <gmbnomis@gmail.com>
> > > >
> > > > Commit 1e3bb184e941 ("tcp: re-enable acceptance of FIN packets when
> > > > RWIN is 0") added a special case in tcp_sequence() to mirror the FIN
> > > > exception in tcp_data_queue(), which accepts bare in-order FINs even
> > > > when the advertised window is zero. That behavior is not
> > > > RFC-compliant, but was introduced in commit 2bd99aef1b19 ("tcp: accept
> > > > bare FIN packets under memory pressure") to break tight FIN/ACK loops
> > > > caused by broken clients.
> > > >
> > > > However, the condition added by commit 1e3bb184e941 ("tcp: re-enable
> > > > acceptance of FIN packets when RWIN is 0") is broader than required
> > > > and allows other non-compliant packets as well.
> > > >
> > > > Tighten the tcp_sequence() FIN exception to only allow packets where
> > > > the packet is a bare in-order FIN and only the FIN flag extends beyond
> > > > tcp_max_receive_window(). In particular, this exception is only
> > > > reachable if tcp_max_receive_window() is zero. Otherwise the packet is
> > > > already accepted by the normal sequence check.
> > > >
> > > > The existing packetdrill test tcp_rcv_zero_wnd_fin.pkt exercises this
> > > > behavior already and does not need to be changed.
> > > >
> > > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > >
> > > This is odd. You are sending this patch which shares a lot of
> > > similarities with Eric's patch:
> > > https://lore.kernel.org/all/20260608151452.706822-1-edumazet@google.com/
> > >
> > > Why are you submitting your own patch instead of discussing it further
> > > with Eric and letting him send v2?
> >
> > That's what I understood from Eric's reply to my comments.  He asked
> > for an alternative, so I sent this as a concrete sugggestion.
> 
> Yes this is fine, please next time includ a link to the 'other patch'
> since this discussion
> was started by someone :)

Hmm, in hindsight this is quite obvious...
 
> About your patch, I thought that it would be fine to allow a remote
> peer to add a FIN
> to a payload packet of N bytes even if RWIN == N

I just realized that RFC 9293 has an "or" in:

  RCV.NXT =< SEG.SEQ < RCV.NXT+RCV.WND

  or

  RCV.NXT =< SEG.SEQ+SEG.LEN-1 < RCV.NXT+RCV.WND

(SEG.LEN includes SYN/FIN)

Linux TCP is stricter here effectively requiring both conditions
since commit 9ca48d6 ("tcp: do not accept packets beyond window"). 
Given that, it's fine to accept packets with an "additional FIN" that
fulfill the first condition.

> It seems the bug of your other stack is that the FIN can be sent with
> no payload,
> and this is a less broader case.
> 
> FIN storage (a bit) is there, we can generalize the acceptance of FIN for free ?

Agreed. Let's drop this patch and generalize the FIN handling as you suggest.

- Simon

-- 
Simon Baatz <gmbnomis@gmail.com>

