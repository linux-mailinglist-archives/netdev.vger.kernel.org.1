Return-Path: <netdev+bounces-296510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iQF5L/euJmqRbAIAu9opvQ
	(envelope-from <netdev+bounces-296510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:00:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA39655EDF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:00:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=JHINyc8l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296510-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296510-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4831300CE64
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E60036C59A;
	Mon,  8 Jun 2026 11:55:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC236D50D
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 11:55:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919741; cv=none; b=WGuvK/ehcK9x4w2OksmDTt9kosfpHf0OVaxDA+zgXVUJuc48emgo4P8eTuqrgJqbTgo+u4S5TDSVk/WjuWZY4S3SF8htuyjJOSm5GKfsTtAGyQ1pRchjNl+8/VhLspI5K85KYZv34Z8gU/7JOYwVzduulxUHoNglJLnxuTC1PfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919741; c=relaxed/simple;
	bh=GDW9+aqULI0HyFPUN1PPbkuleapjY3eI4I4fbLij1FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5Yo5HeQvBxZt99Iu+idYq8PJPAvq9Dk3mc+FgS15JeS5oNPzyZdWtbl2jCGAom7JDCVuOw0oZgQkzXPYJIZrt4tb7wxEyDBj5yv7hqiPyfsaX7faPf6J2GM7Vvr1xp6pDweObXzI+RjSbgru/E930wIBhKnew22OIHH3YQ4KPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JHINyc8l; arc=none smtp.client-ip=91.218.175.183
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780919727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qj4Q12pUOBjHOwzDHSFIiIS1Y3DX8JtbmMSEhVS6yjM=;
	b=JHINyc8lIP8GGjW+ejm5m4C5iOv83O3dYu7SUWyIMYfFMT81xLOvfwUvpy1zUfnXl7K1fS
	N+tUA5OByDFBjqDG/SO9xtVlQNsHtWzeBfqfaWyXvO7fbB8TcA4U46jJM5s48RCoLYqB3+
	HeZU3JWIYRV2D+mAf20vDeQtAuqbRi8=
From: Menglong Dong <menglong.dong@linux.dev>
To: xietangxin <xietangxin@yeah.net>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, jmaloy@redhat.com, menglong8.dong@gmail.com,
 kuniyu@google.com, horms@kernel.org, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stable@vger.kernel.org
Subject:
 Re: [BUG] TCP connection deadlock under simultaneous bidirectional
 ICSK_ACK_NOMEM (OOM)
Date: Mon, 08 Jun 2026 19:55:11 +0800
Message-ID: <g7DvITFWSiW9AoI49uyghw@linux.dev>
In-Reply-To: <b8a3b4eb-b75d-4cbd-ac1c-9b0a606a932a@yeah.net>
References: <b8a3b4eb-b75d-4cbd-ac1c-9b0a606a932a@yeah.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296510-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[yeah.net];
	FORGED_SENDER(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:xietangxin@yeah.net,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:jmaloy@redhat.com,m:menglong8.dong@gmail.com,m:kuniyu@google.com,m:horms@kernel.org,m:willemb@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stable@vger.kernel.org,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCA39655EDF

On 2026/6/4 16:22 xietangxin <xietangxin@yeah.net> write:
> Hi all,
> 
> We have observed a TCP connection deadlock on stable 6.6 under heavy stress testing.
> 
> 1.Both Peer A and Peer B enter the ICSK_ACK_NOMEM branch in tcp_select_window().
> After commit 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
> Both peers freeze their rcv_nxt and set rcv_wnd = 0.
> 
> 2.Prior to freezing, both sides had already sent out flight data.
> Since both sides are dropping incoming data packets due to OOM, rcv_nxt stops advancing,
> but the peer's seq of subsequent packets continues to grow.
> 
> 3.When Peer A receives Peer B's Zero Window ACK,
> the packet's seq is far ahead of Peer A's frozen rcv_nxt.
> Both peers drop each other's packet, also no Zero Window Probes are triggered
> because snd_wnd is never updated to 0.
> 

Hi,

The problem you addressed is already fixed in this commit:
0e24d17bd966 ("tcp: implement RFC 7323 window retraction receiver requirements"),
which hasn't been picked to the 6.6 branch.

That patch doesn't have the Fix tag, so I'm not sure if it will be picked
to the 6.6 branch. Just CC the linux-stable :)

Thanks!
Menglong Dong

> 
> Simplified Packet Trace:
> 
> Assume Peer A's rcv_nxt = 1000, and Peer B's rcv_nxt = 5000 initially.
> 
> Time  Dir      Type        Seq   Ack   Win  Len  Status
> ------------------------------------------------------------------------
> T1:   B -> A   [PSH, ACK]  1000  5000  3000 100  (A hits OOM, rcv_nxt=1000)
> T2:   B -> A   [ACK]       1100  5000  3000 200  (Dropped due to A's OOM)
> T3:   B -> A   [PSH, ACK]  1300  5000  3000 200  (Dropped due to A's OOM)
> 
> T4:   A -> B   [PSH, ACK]  5000  1000  3000 100  (B hits OOM, rcv_nxt=5000)
> T5:   A -> B   [ACK]       5100  1000  3000 200  (Dropped due to B's OOM)
> T6:   A -> B   [PSH, ACK]  5300  1000  3000 200  (Dropped due to B's OOM)
> 
> -- Both sides are now in OOM. B's Seq is 1500; A's Seq is 5500 --
> 
> T7:   B -> A   [ZeroWin]   1500  5000  0    0    (Dropped: Seq 1500 != 1000)
> T8:   A -> B   [ZeroWin]   5500  1000  0    0    (Dropped: Seq 5500 != 5000)
> T9:   A -> B   [WinUpdate] 5500  1000  20   0    (Dropped: Seq 5500 != 5000)
> 
> Should we relax the sequence check in tcp_sequence() for zero window ACK?
> 
> Any feedback or guidance would be greatly appreciated.
> 
> -- 
> Best regards,
> Tangxin Xie
> 
> 
> 





