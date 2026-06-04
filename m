Return-Path: <netdev+bounces-295118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id si3nCRpBIWofCAEAu9opvQ
	(envelope-from <netdev+bounces-295118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:10:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B3263E5FD
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:10:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yeah.net header.s=s110527 header.b=iI6n0JY4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295118-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295118-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yeah.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3915E3076B1F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E9E3E716D;
	Thu,  4 Jun 2026 08:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C01391E45;
	Thu,  4 Jun 2026 08:55:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563338; cv=none; b=i7FHRck1rVUmA39kZRAarp3SFKJHsfLVaM/0QR8tsdjyodJTqLju0yLivjTdVYIWBCSrCGLLp8YyBFABBmLKlqpEmZTHJVQ7ptbfdb6qjvTaxshYyjpx7XkNmLZVVKEmXDu5gFzuVQ+fn6WNOnxzKGYT54GNgv9XoA1IJdyle2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563338; c=relaxed/simple;
	bh=OZhIrREOk5xqsN7sLFlNvuIz95WyJa1sgb9bIzxf8IA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=oSo6+MXN601ReX5dT9OI8LcuIz5ER/fG4AfV7rxcHHrLSO+1v1iDnzW+5y+wza9HfxKl9SLus2ceB1ZyC59qs9HSn0TtL9nKQ2Gsz2xFdJdYPoQ1wcH5GQjhYVQc57Ug7sdi7V9nKT+66+FbFLG4EWXLSDiiYYajYZAVV46iWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=iI6n0JY4; arc=none smtp.client-ip=220.197.32.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:To:From:Subject:
	Content-Type; bh=qBFSoMFwX16MwlmUQDGEuGdAFIZgIayoUg2RKgDD4QQ=;
	b=iI6n0JY4Qg/6r6y9HbsazA5M1egTUqqmzGqEks6nqdNgBDR69EEGMwX2ENOMKN
	/qNBbEMA0EosY4UWcsNG8pnDJ06069r8FUmNpmJYP6J19o6mjXovvcgNp7MK7959
	LnIQi7bQbwMjUm7CSIR1YjBwr7GzFJrfopqDhndHWMSa8=
Received: from [100.70.220.18] (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgDnrbm6NSFq2tqWAQ--.7870S2;
	Thu, 04 Jun 2026 16:22:19 +0800 (CST)
Message-ID: <b8a3b4eb-b75d-4cbd-ac1c-9b0a606a932a@yeah.net>
Date: Thu, 4 Jun 2026 16:22:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
From: xietangxin <xietangxin@yeah.net>
Subject: [BUG] TCP connection deadlock under simultaneous bidirectional
 ICSK_ACK_NOMEM (OOM)
Cc: jmaloy@redhat.com, menglong8.dong@gmail.com, kuniyu@google.com,
 horms@kernel.org, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Mc8vCgDnrbm6NSFq2tqWAQ--.7870S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18KrWDtF4xJrykJryxXwb_yoW8AF1UpF
	n3Jry3Crs5t3sayr48tw1xG348Jrs8AFnxJr1qvrWxtw45CFsYgry0q3y09r9FkFyDJryq
	kF92vF1Dtr1kXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIRtekmohNbtCXAAA3t
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295118-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,google.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:jmaloy@redhat.com,m:menglong8.dong@gmail.com,m:kuniyu@google.com,m:horms@kernel.org,m:willemb@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yeah.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[yeah.net];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yeah.net:mid,yeah.net:from_mime,yeah.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62B3263E5FD

Hi all,

We have observed a TCP connection deadlock on stable 6.6 under heavy stress testing.

1.Both Peer A and Peer B enter the ICSK_ACK_NOMEM branch in tcp_select_window().
After commit 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
Both peers freeze their rcv_nxt and set rcv_wnd = 0.

2.Prior to freezing, both sides had already sent out flight data.
Since both sides are dropping incoming data packets due to OOM, rcv_nxt stops advancing,
but the peer's seq of subsequent packets continues to grow.

3.When Peer A receives Peer B's Zero Window ACK,
the packet's seq is far ahead of Peer A's frozen rcv_nxt.
Both peers drop each other's packet, also no Zero Window Probes are triggered
because snd_wnd is never updated to 0.


Simplified Packet Trace:

Assume Peer A's rcv_nxt = 1000, and Peer B's rcv_nxt = 5000 initially.

Time  Dir      Type        Seq   Ack   Win  Len  Status
------------------------------------------------------------------------
T1:   B -> A   [PSH, ACK]  1000  5000  3000 100  (A hits OOM, rcv_nxt=1000)
T2:   B -> A   [ACK]       1100  5000  3000 200  (Dropped due to A's OOM)
T3:   B -> A   [PSH, ACK]  1300  5000  3000 200  (Dropped due to A's OOM)

T4:   A -> B   [PSH, ACK]  5000  1000  3000 100  (B hits OOM, rcv_nxt=5000)
T5:   A -> B   [ACK]       5100  1000  3000 200  (Dropped due to B's OOM)
T6:   A -> B   [PSH, ACK]  5300  1000  3000 200  (Dropped due to B's OOM)

-- Both sides are now in OOM. B's Seq is 1500; A's Seq is 5500 --

T7:   B -> A   [ZeroWin]   1500  5000  0    0    (Dropped: Seq 1500 != 1000)
T8:   A -> B   [ZeroWin]   5500  1000  0    0    (Dropped: Seq 5500 != 5000)
T9:   A -> B   [WinUpdate] 5500  1000  20   0    (Dropped: Seq 5500 != 5000)

Should we relax the sequence check in tcp_sequence() for zero window ACK?

Any feedback or guidance would be greatly appreciated.

-- 
Best regards,
Tangxin Xie


