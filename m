Return-Path: <netdev+bounces-291116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PuPCA3S/EWoNpgYAu9opvQ
	(envelope-from <netdev+bounces-291116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:53:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C71E5BF7A0
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41F4E3008A59
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81DA26CE39;
	Sat, 23 May 2026 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUQod8IG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C55184
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548016; cv=none; b=qgAqR9FGgTk1xmfnl3E4yNH+7wGq+/CVP8eaF4nTGZsob6d5uPAEor+FeIYP0ImzPuvHjifYXxZ774ZBhFO2kjoXHPjvaLw5h4nXelVajPd10phf4QFTb4GMzOMH+Z/TTrjKzMhGSaVUPZbCn40Qcr2TNdfvxa/S7nMWJJPigyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548016; c=relaxed/simple;
	bh=yyyr4Ie6lPu+jIbRXSP0Mil/Vfh89VQwXsVF98DJms4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IwX8hSRqSyLcqTLaV0nk9lHrIc3hZu9OQVD1E0/emDJxJXPNkDA7VFgnlYxeVP2sjHcILqQ1SKJcqqaE+Mtj5zcyvHJDP6v8ivuut6BIECVxIOORWBLY0uKLTK/gp6vADLVIW6G1PpjFbHYpzBjiGsyyldIWujfXirgOkRYyFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUQod8IG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c82a6278a4cso6338078a12.3
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779548015; x=1780152815; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqryLwyecP7XdFRP1fnNAzkgGZpfDJiUeUJsd1fBfx0=;
        b=lUQod8IGEOUGlco2J64NEi5RYJ7nrN58yUbUNg1hRHyNsc0UmACG3lOXGaMGDBhMVi
         KRDZgCfChV0vV1ha4GoOF/hyGwJ7ANpsxtloWbLNInwFboGeYZK8jIgyeHU3ZBZEoJII
         LDSvwSf490Q0XUHQtrPxCRrb4mNmB2KfxEJgK9mJ5JTrOTdkr1ej5BMk8iV8z7I6aBdf
         58Yv7dfs9/z1asCB9KYFq5J5pZyG2dXdBI7gHDkkbm9aEeTAejUfuzsWTpG4fszslRFX
         QKd0naNzoBoe7b9q1JLvOeWQ+pjk6lf7DxJi/m5S80kbTRjwuFxnDI8LjeyMhPbmeZsQ
         LrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779548015; x=1780152815;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqryLwyecP7XdFRP1fnNAzkgGZpfDJiUeUJsd1fBfx0=;
        b=kvkyKB4/uZukkWUT7Hw3AyvpusmTHcix+htR/c8t+ocBdGdyVRQtqpOgJvTYxccNT+
         29UrxxEpsXqqCt8dZDmny6bvdjxCQM+asoJ3hDcaPQvWyQRaPTC/nfc/a55GeBbn7ST+
         HpNR/wFTZHX3+XPd6e5f/WIn9osbQBqKWmIldEjD2JFHxKLLB6xO6nZ5wKADm5eB0W8L
         FEvesnydfRaAiJEV5Md2D7N77PM9+r6k3s/H1q9/xTR2Tt/tSk80MKAc7jPXTvj1oth7
         eUPaRh+vk0mnfjxPtIku1AAO3IOcGfwy0WMIjk3fQA3W45fqhNKi1pYbsbTvnxH+ylYy
         3JSg==
X-Forwarded-Encrypted: i=1; AFNElJ+7AMQue/MT3ry8YQgK0DIzfnpGxNT4szDs2Gvn8heey4f3Wy1WgXWsk2HbTabaN3d9t80bn8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvia0rGxNiPsy8hoBsJnWqgRtX7bdOV/LnGGDP+kGwcMpFGLEM
	NsY81kgotInvZHTHoeOpCYi0IUqua6zYLQ68hRW+2Dyzy4uJSehQjBkx
X-Gm-Gg: Acq92OFzEqyXHNLnEPcU5wGyb4QMzOao0OgBieZ0lGncoxPv2uKrOGmlLeuCCfW3Wi4
	tYdxyZQPvWLkvHnw+PQxqgWseoBeQxA3HLhDn7FOHxtN2U8q05cx7fNbe190dran9/nulGDSLmX
	DwVgeX9I0Y/CJpuKmFd/gd5R9m7/Zdme2MyBTSepYPBBQXx8oUe7Tp5XoI9PZZxepJey/7q9S9U
	TKyQwuerDdK7ljyJUFvIjTD4bAnCljKg/nbKLUjWfXCmCfMMtAJgyYxE3qLZ3m7OFLrqALh21uq
	uEdN92gLLHbOVHn0vXB09dokioB3JUVIeP2Bc6ZBWOBKsoH3uQVjTaK3oIFulrVjVorjdGDw4Cx
	CUQYVp2KMNrpn67PhHL76PBDPeBsQgTvs8l/oxYxuWyKCOygUcuHZ9BG+tCi5Ic0F5gzXhk1LPx
	soD7xiyvHvK9FcoHzN4NannJkuJv9JFmZlK3bg4kueDKMRiF1kMhQq5ruDW68eVqzLGSuLYJvJH
	QLuHp+Umd8y/Z3FwQo9O+RL6uoPdeeRAg==
X-Received: by 2002:a05:6a21:b8a:b0:398:6ea8:21d8 with SMTP id adf61e73a8af0-3b328cabaa7mr7949186637.15.1779548014578;
        Sat, 23 May 2026 07:53:34 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([103.129.134.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202902a6sm3974345a12.3.2026.05.23.07.53.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 May 2026 07:53:34 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH net] ovpn: hold peer before scheduling keepalive work
Date: Sat, 23 May 2026 20:38:27 +0545
Message-ID: <177954800752.73238.12097994883239164708@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291116-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5C71E5BF7A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ovpn_peer_keepalive_send() passes its peer reference to
ovpn_xmit_special(), which ultimately drops it. The keepalive scheduler
currently queues the work first and takes the reference only after
schedule_work() reports that the work was queued.

Once schedule_work() queues the item, another CPU may run the worker
before the caller gets to ovpn_peer_hold(). In that case the worker can
consume a reference that was not acquired for it, corrupting the peer
lifetime accounting.

Take the peer reference before queueing the work and drop it again when
the work was already pending.

Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/net/ovpn/peer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296..4e6cd2b69 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1285,8 +1285,10 @@ static time64_t ovpn_peer_keepalive_work_single(struct=
 ovpn_peer *peer,
 		netdev_dbg(peer->ovpn->dev,
 			   "sending keepalive to peer %u\n",
 			   peer->id);
-		if (schedule_work(&peer->keepalive_work))
-			ovpn_peer_hold(peer);
+		if (WARN_ON(!ovpn_peer_hold(peer)))
+			return 0;
+		if (!schedule_work(&peer->keepalive_work))
+			ovpn_peer_put(peer);
 	}
=20
 	if (next_run1 < next_run2)

--=20
2.50.1

