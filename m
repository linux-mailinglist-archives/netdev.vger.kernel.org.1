Return-Path: <netdev+bounces-284085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHI/N5Im+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:06:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7EC4C4BD0
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3DE83003EAB
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992E33909A2;
	Mon,  4 May 2026 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QbX3Xrij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782E390990
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935822; cv=none; b=EvySdek4d2DLaevV/+h3lSdgrI7KKcGvAtHNe+uOl5L/M/H3GLj7m2wZKigQtT0cHxFmnLaRWSIXDySqswegKBw1KhSGicgGlcqJBFMJOkkjUKyXjiiL0/8owCVtwfkJaMofY9yvqQKmbD3jCOFO7NtO5dO+X7MjNkct68zajF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935822; c=relaxed/simple;
	bh=CDoLIigsd2wY6tMjFFq24W4lUGOUFrfKo6vF0oLaiW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4IL/apdWH1twWJFNsYu7VTxX+Fc+1UsFj2JbunFgm8sMwShEFjoH9SqgRSBvZE/py/p9XB+foBJ9QnsMLqouQwgj+ccxFR5/8ggiXkbZP3yAAUWAORRF0eGMG8w23/9Jsir5NqHjqgL/Zt4Wo98mjut7dgQvRTs90AUHlvYCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QbX3Xrij; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891f625344so48893325e9.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777935818; x=1778540618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGP5eRb1J9za/K0XnfRaqR8QQJseZa7TWMN5JM+tR7s=;
        b=QbX3XrijqSyxUF4I7WmRIMkU5OO2RHLAj4TrQJL4L2WwdXZCg5oURPRHAd/dS7CRWZ
         Z/tud2qZmzDaPAhryaPeVc6sieV1JN1r215FDNV7B2VAT+bY95Rqn40Uz5uCDsvOg3Pd
         h9uPSLmPuB5Pu2iOTzwGVNT495+eDyRzmXweF/VmFqpGP91EOUK4L2iMWcrP2N6HvhbF
         9uDo1YXxKNB00q2ndPehB6A1aMNbc5UU6b7vlAkfPMjFAzGORBXvFboHnWm4qpugMeeG
         nEPKP4rvkI7pyXtMkrdMaPWg4Lljxrz85G/sC23RJzvtV7cZwaQzm+b7sj1HXiSeUpKS
         dD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935818; x=1778540618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tGP5eRb1J9za/K0XnfRaqR8QQJseZa7TWMN5JM+tR7s=;
        b=HFsplruOJzG6stf56qCPX+da9FoCczZAczG9nyJzyJMfrcEv8EqmGTe+/yXLPAaRRO
         H6K40ZCa+BybuOfFxXsYRBWF//eYM3Gq3eIPB5q7FcoP3a0/aZ6vp5lKJcyWhFsmiLaz
         +up2oXSkFr9nyuZSDQ46SuJOPnFTyjDnTygcbCyRDcMD/vOuWTMzIt1lmQ+zdB8cCvVW
         e/U2dCmWZLTBNKFomu6d83YttG1b0Qpuxr2mC7DHj7HmIzq5A88nEEUte43hgi3mG5m5
         xkBQx5Vk0CYlwuOxhSca7oYArw9zT8wtw6IuvAuvU3zH/oaWODk6mp1z8msWpaBKGvfY
         sjgQ==
X-Gm-Message-State: AOJu0YxTrEZuOZhxAlkI/su4mMEppjMYJTXEsirahY6F4j1Pmvcfqbw5
	JbpohS4CnM/Kk0uFY5b4Hrdrwmtt8SPycLzqnkAMNGGN6Z8CFSLD65F7DbkXvB/61uFcPf7AL/j
	tq5BlLYgGGbP+9OqDk+00P//rO4C/XTqXgI0SZ3s4QDIa9O0q7OrCafMRFY2UacXuT3A=
X-Gm-Gg: AeBDiesEhabpxNkHnR5jgKWl+eJYxodcgrUvuo24jtKWpgnkSiWWaf3n0jcjLxs9+ij
	pOgWnTC7ZkHhDNICQ4K4sf+JAlJHHj5pwY7i7VUqaDM23n9oQ1EnhzIngNJyEBnD+VmSlw8iR3h
	B3MGbeQ6+0J7Bni4UDuL0EmBRg0caBYBodrN436QQIlxqjZrlvN2s3jtbVetHEwVR9ZsYilYRJk
	eCychV8ykqIhYgehxRbR4PK93yQrhEcreOuIVh1gu3Uj0+0hYCWwiN4NzzRpK2mjgOieU948nFt
	miQ5uA9DdPSuGHN0H4zGbqwicBh9IruGeiRpT0v7BPxCbolJ9vxYpP9AxCK7dQx+so1DKtYinmu
	7Y0WMY4joppoPINBI4ASYXS2VKFFqC+saUAC+pUaC2kh2hgF1SFIFra+x07NthswA36rlmNAxc7
	fRO87ymMxyt+Qmess+AglpBMJJN+KOYlM2RzA4hdvHYEmmR6I=
X-Received: by 2002:a05:600c:4e16:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48d1425b450mr21275215e9.10.1777935818524;
        Mon, 04 May 2026 16:03:38 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:1d7d:7ce5:717a:133e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm636149165e9.2.2026.05.04.16.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:03:38 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ralf@mandelbit.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/3] ovpn: ensure packet delivery happens with BH disabled
Date: Tue,  5 May 2026 01:03:04 +0200
Message-ID: <20260504230305.2681646-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504230305.2681646-1-antonio@openvpn.net>
References: <20260504230305.2681646-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B7EC4C4BD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284085-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:email,openvpn.net:dkim,openvpn.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mandelbit.com:email]

From: Ralf Lici <ralf@mandelbit.com>

ovpn injects decrypted packets into the netdev RX path through
ovpn_netdev_write() which invokes gro_cells_receive() and
dev_dstats_rx_add().

ovpn_netdev_write() is normally called in softirq context,
however, in case of TCP connections it may also be invoked
process context.

When this happens gro_cells_receive() will throw a warning:

  [  230.183747][   T12] WARNING: net/core/gro_cells.c:30 at gro_cells_receive+0x708/0xaa0, CPU#1: kworker/u16:0/12

and lockdep will also report a potential inconsistent lock state:

  WARNING: inconsistent lock state
  7.0.0-rc4+ #246 Tainted: G        W
  --------------------------------
  inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.

because attempts to acquire gro_cells->bh_lock by both
contexts may lead to a deadlock.

At the same time, dev_dstats_rx_add() does not expect to race
with a softirq (which may happen when invoked in process context),
because the latter may access its per-cpu state and corrupt
it.

Fix all this by invoking local_bh_disable/enable() around
gro_cells_receive() and dev_dstats_rx_add() to ensure that
bottom halves are always disabled before calling both of
them.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index d92bb87be2b2..22c555dd962e 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -91,12 +91,18 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	/* cause packet to be "received" by the interface */
 	pkt_len = skb->len;
+	/* we may get here in process context in case of TCP connections,
+	 * therefore we have to disable BHs to ensure gro_cells_receive()
+	 * and dev_dstats_rx_add() do not get corrupted or enter deadlock
+	 */
+	local_bh_disable();
 	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
 	if (likely(ret == NET_RX_SUCCESS)) {
 		/* update RX stats with the size of decrypted packet */
 		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
 		dev_dstats_rx_add(peer->ovpn->dev, pkt_len);
 	}
+	local_bh_enable();
 }
 
 void ovpn_decrypt_post(void *data, int ret)
-- 
2.53.0


