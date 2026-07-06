Return-Path: <netdev+bounces-304833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SN4sCwY+S2qFOAEAu9opvQ
	(envelope-from <netdev+bounces-304833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:32:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4670C9EF
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:32:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b="2CAk/lY1";
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=M2t5S0UR;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304833-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304833-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D993007AE6
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 05:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91C93AFD1A;
	Mon,  6 Jul 2026 05:32:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-86.smtp-out.amazonses.com (a9-86.smtp-out.amazonses.com [54.240.9.86])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A753B19B2;
	Mon,  6 Jul 2026 05:32:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315970; cv=none; b=K3zgfKah+yMrurLFoQEO5VxWDoqeTbs57tx2tozjxS3mYf9w7fZlK3rLYnhwPj2IhgmTScfS6akP5roZMF969X1zZI87nvUQ2rmgl1pNO3Vh69LK88Wfbp4sVHYPvxcK+HuPFM0EjOl3ZIVcfXSCcuwkE9YVrjt4HYQr+ZS8J6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315970; c=relaxed/simple;
	bh=WE1BiFWnuVTqqmoH9eO0D5/X1+StHQ9spZ9M78Luwyg=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=QFenuq3OPlaEa1KapP2z4rUP9D6VhjopL4Gnu1LAb2YBzKEILsncqmYT0W0SBbGDhDUTKYhYw618EDf70NR3sB8Ie73VC5rikr71mnzzkX1JpWt7j7SBC29qd10BOCZl3/LdWhgkY425klKyDtS7WK90BFo0mzbVkLELDl0TcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=2CAk/lY1; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=M2t5S0UR; arc=none smtp.client-ip=54.240.9.86
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1783315965;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=WE1BiFWnuVTqqmoH9eO0D5/X1+StHQ9spZ9M78Luwyg=;
	b=2CAk/lY1vtY3ORTa9R6Sx21qdZojOgL8vgn/nnSybJTsC1u9ZUySW1KBNpN/nIpE
	AVfR8ssm0jxZkFuHM6Xg8x+6ASktDymbP8Eeh0fX/EYs0PWpAZae8Z9gGwRvBhKdWYu
	PXtu/m4WM67n9u2/JhXniIVwRg46LHYV5ud3jv54=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1783315965;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=WE1BiFWnuVTqqmoH9eO0D5/X1+StHQ9spZ9M78Luwyg=;
	b=M2t5S0UR1IAa21PcPl+UI8epEJ9WQ1cIwGhDBbgllCzF7KBx0ph6jofN+aQTbCRO
	FTmxvRnEkhiSONz/h7UkC7rBd3JRNVSF7F/+F3iDJC0Yq1g8RX2jCK1sYneuO3GHg8A
	/oRUWGeGhdzZZfktdTaaDsAyoO826IPwobbJbm7k=
X-Mailer: git-send-email 2.55.0
From: Johan Alvarado <contact@c127.dev>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com
Cc: Jose.Abreu@synopsys.com, pavel@ucw.cz, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	contact@c127.dev
Subject: [PATCH net] net: stmmac: raise TX completion interrupt at the end
 of an xmit burst
Message-ID: <0100019f35ea26e0-42ad009c-01ab-4a8f-b126-fa65fbacae5c-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 6 Jul 2026 05:32:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.07.06-54.240.9.86
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:Jose.Abreu@synopsys.com,m:pavel@ucw.cz,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[c127.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304833-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,email.amazonses.com:mid,amazonses.com:dkim,c127.dev:from_mime,c127.dev:email,c127.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FB4670C9EF

The TX mitigation logic only sets the Interrupt on Completion bit once
every tx_coal_frames descriptors (STMMAC_TX_FRAMES =3D 25), with the
tx_coal_timer hrtimer (STMMAC_COAL_TX_TIMER =3D 5000 us) as the only
fallback. TX skbs are freed exclusively from the TX completion path,
so any flow that keeps fewer than 25 frames in flight has all of its
skbs held for up to 5 ms after transmission.

Paced flows never queue =
enough frames to reach the frame threshold:
TCP Small Queues caps the =
amount of unfreed data at roughly two pacing
intervals worth, which at =
moderate pacing rates is only a couple of
packets. Every small burst then =
stalls until the coalesce timer fires,
and throughput collapses to =
approximately tsq_limit / tx_coal_timer
regardless of link capacity.

This is easily reproducible with BBR, which paces its output and thus
keeps only a few frames in flight at a time. On a YT6801
(dwmac-motorcomm) equipped Orange Pi 5 Pro, a BBR upload over a ~23 ms
RTT path is capped at 5.24 Mbit/s, while CUBIC reaches 207 Mbit/s on
the same path. BBR measures the stalled send rate as the path
bandwidth and locks its estimate near the floor, so the connection
never recovers. Lowering the coalesce settings with ethtool -C
(tx-usecs 100 tx-frames 1) lifts the same transfer to 447 Mbit/s,
confirming the mechanism.

Fix this by setting the IC bit on the last =
descriptor of every xmit
burst, i.e. whenever netdev_xmit_more() reports =
that no further frames
are pending in the current dequeue batch. =
Frame-based coalescing still
applies within a burst, bulk traffic keeps =
batching through qdisc bulk
dequeue and NAPI polling, and the coalesce =
timer becomes a pure
fallback instead of the primary completion mechanism =
for lightly
queued flows.

tx-frames 0 keeps its meaning of timer-based =
mitigation only.

Fixes: da2024510031 ("net: stmmac: Tune-up default =
coalesce settings")
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
Notes for reviewers (not for the changelog):

Tested on an Orange Pi 5 Pro =
(RK3588, Motorcomm YT6801 PCIe GbE via
dwmac-motorcomm), iperf3 upload to a=
 public server over a ~23 ms RTT
path, coalesce settings left at their =
shipped values (tx-usecs 5000,
tx-frames 25):

  before, BBR:    5.24 =
Mbit/s (cwnd pinned, bw estimate ~6 Mbit/s)
  before, CUBIC:  207 Mbit/s
  after,  BBR:    447 Mbit/s

Interrupt overhead stays sane: ~3.3k NIC =
IRQs/s total at 447 Mbit/s
(~38 kpps), i.e. roughly 12 packets per =
interrupt, since qdisc bulk
dequeue plus NAPI polling still coalesce within=
 bursts.

The 5000 us STMMAC_COAL_TX_TIMER value postdates the tagged =
commit
(it was 1000 us back then); the stall mechanism is the same, only =
the
throughput ceiling differs, hence the Fixes tag on the frame-count
change.

The XSK/XDP TX paths keep their frame-count-only IC logic: there =
is
no skb/TSQ backpressure on those paths, and netdev_xmit_more() is not
meaningful outside ndo_start_xmit.

The same completion starvation was =
reported by Pavel Machek in 2016
(UDP burst pauses, back then a 40 ms =
low-res timer):
https://lore.kernel.org/netdev/20161123105125.GA26394@amd/
His patch disabling TX coalescing entirely was rejected in favour of
"a real solution":
https://lore.kernel.org/netdev/20161205122711.=
GA30774@amd/
The subsequent hrtimer conversion fixed the timer resolution =
but kept
the timer as the only completion mechanism for lightly queued =
flows;
this patch adds the missing burst-end interrupt.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro=
/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..ddf4ac03538d 100644
--- a/drivers/net/ethernet/stmicro/=
stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.=
c
@@ -4626,6 +4626,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff =
*skb, struct net_device *dev)
 		set_ic =3D true;
 	else if (!=
priv->tx_coal_frames[queue])
 		set_ic =3D false;
+	else if (!=
netdev_xmit_more())
+		set_ic =3D true;
 	else if (tx_packets > =
priv->tx_coal_frames[queue])
 		set_ic =3D true;
 	else if =
((tx_q->tx_count_frames %
@@ -4910,6 +4912,8 @@ static netdev_tx_t =
stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		set_ic =3D true;
 	else if (!priv->tx_coal_frames[queue])
 		set_ic =3D false;
+	else if (!netdev_xmit_more())
+		set_ic =3D true;
 	else if (tx_packets > priv->tx_coal_frames[queue])
 		set_ic =3D true;
 	else if ((tx_q->tx_count_frames %
--=20
2.55.0


