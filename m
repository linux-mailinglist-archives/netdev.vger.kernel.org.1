Return-Path: <netdev+bounces-125941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3596F552
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B81C1C21C55
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F51CE705;
	Fri,  6 Sep 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WBqaMqZK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0BTIKlKe"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759721CDFBB
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629301; cv=none; b=Ug6hx8xOCSg1mRYEqjU6k4C+yP3ajCWvIhxCmD9nqpcSbZ6tKP6Y2DTkR1PUax6KIHphJYCQinWIll92USijHZ161gncJcZfHF5IMgBHsjI0CWYRIp/Grq0bRhrjHUZm1DVKA5dF8fIZoWAe6QevWKlGqAhFz1ogm+t3wN7QZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629301; c=relaxed/simple;
	bh=4ylEbwMQwpNt+PdriqKu8LyBTplHV413NdnFFiRPpqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQga74nAMI2t1NY0+mQyJ0tBvBtrssBbGJOMn9ASicLrRVbZ1i7RyK2jFsHwWtQLdpjeUf81lb4gqx+ECvMiF1U4mDyw8AYs2ROfr45wkkdsUDOWBMlu3LIPmvHlCNIiI6SMSp3hFZAgYcy03kcLas+T/ewSyu3VAnsRnNsic5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WBqaMqZK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0BTIKlKe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725629298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQSw+ylJoDoi7ze8AEXpYyrepiaU+KdCPjGRxNv1XCc=;
	b=WBqaMqZKv12umzykTPO5HPoGy0Ikoh9KXB62JOOwK8whHlxSmddcydDTzya8KeNKFJOf+r
	n9lUGA2I8W1Lk8HcG+EJwuvy8udkG3MNdMap7LRu0qekP+FHLShiLl4N13CGtDKGStQrjZ
	K42iEadBqSnaDYUmSmUXERO46fMlx6yMbMr8hk9WRVQW2zCaQHCsCXSWFELRocC4+CNreO
	vStMzYnHdAFE47Dk8ZRUUSy1mS0+kVdr5iqruwL78Hk1rBk9pCfCkTf/8xQIev1p/ygMJk
	LpzRpxJhQ8Lwn+ckPZ4LNJzUOdWRGgq9rLNXEgubF6Db5kLuZk11VnUB8m7jVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725629298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQSw+ylJoDoi7ze8AEXpYyrepiaU+KdCPjGRxNv1XCc=;
	b=0BTIKlKeW82ok7sESMDQG43vYej5SKzVDXBYfImEU0Nt7pwc3Lcc+F+qF3ZlmtOajeVplV
	Y6QfeEjtjIpKuKAg==
To: netdev@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	syzbot+3d602af7549af539274e@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] net: hsr: Use the seqnr lock for frames received via interlink port.
Date: Fri,  6 Sep 2024 15:25:31 +0200
Message-ID: <20240906132816.657485-2-bigeasy@linutronix.de>
In-Reply-To: <20240906132816.657485-1-bigeasy@linutronix.de>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot reported that the seqnr_lock is not acquire for frames received
over the interlink port. In the interlink case a new seqnr is generated
and assigned to the frame.
Frames, which are received over the slave port have already a sequence
number assigned so the lock is not required.

Acquire the hsr_priv::seqnr_lock during in the invocation of
hsr_forward_skb() if a packet has been received from the interlink port.

Reported-by: syzbot+3d602af7549af539274e@syzkaller.appspotmail.com
Closes: https://groups.google.com/g/syzkaller-bugs/c/KppVvGviGg4/m/EItSdCZd=
BAAJ
Fixes: 5055cccfc2d1c ("net: hsr: Provide RedBox support (HSR-SAN)")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_slave.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index af6cf64a00e08..464f683e016db 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -67,7 +67,16 @@ static rx_handler_result_t hsr_handle_frame(struct sk_bu=
ff **pskb)
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
 	skb_reset_mac_len(skb);
=20
-	hsr_forward_skb(skb, port);
+	/* Only the frames received over the interlink port will assign a
+	 * sequence number and require synchronisation vs other sender.
+	 */
+	if (port->type =3D=3D HSR_PT_INTERLINK) {
+		spin_lock_bh(&hsr->seqnr_lock);
+		hsr_forward_skb(skb, port);
+		spin_unlock_bh(&hsr->seqnr_lock);
+	} else {
+		hsr_forward_skb(skb, port);
+	}
=20
 finish_consume:
 	return RX_HANDLER_CONSUMED;
--=20
2.45.2


