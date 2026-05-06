Return-Path: <netdev+bounces-284779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O2vBn8V+2lLWQMAu9opvQ
	(envelope-from <netdev+bounces-284779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:18:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC564D93A6
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 968403004225
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19CC3F0AAB;
	Wed,  6 May 2026 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8fmnp9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01836C0DC
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062293; cv=none; b=Gx5U5D6WESURYaO7Lh6taoWpXykJOID1A8XUiJTheKxzmYUKCI9iNi7bRUKT92mElbNQE/+d9XLQMVKUK3OZIyiobpKfFgTlOTiTsV5u8XM0mU5Cf5RWclCwD2Z1FHix2Ki3pVEgDGf3q5Y+Uu68+5fsRLk2n7/CQwQ8JIg7l6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062293; c=relaxed/simple;
	bh=qeCUuOr/hDBP+NYRwzrCl2eroVqrp2O0uXxMbs0mv2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ww0VwQrJGueDH368M6zIBF8TkAr+8KzcviUOerDgG3WOtSvmLj67o1eU6wCVvOQfIlxd0om4qihntVFYlGhPgmgJK/midAj1dPzIA6weMft4CGs1SaEQFHoU5uT0GfZWEySBLCe7nVSm9xhv7gMqtC587j0RSe+C4jtoj0mOXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8fmnp9t; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c1a170a50so8286977c88.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778062291; x=1778667091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvwBpTdc+XiyEreRo8SeSDyVWQHZ884Ep74h8yBEDlM=;
        b=V8fmnp9tB78w5NeK7AwmwZzNPZXV9HH/uyA+Vu5FQpd/CXewb9RPLEN+Cbb/2bHQLl
         yAdG7goENAKycpDV5V0GkJ5f9yO3GG5s+feH3uQ4oWvpY3dRLGXRyyh5AeNriXFRGHqi
         FJULDltbtUb/YdF/uff4v34hbGpN5Avbow0b3GiBYnBqIN6PcVrihX4LrcyMZtTpMVLI
         w53O3UMICBcTW1uCCWFYGCaiB1DkDNX8tgt2+q1LtwVmGrffOL+xkJdhfg9YGzuF35M9
         9AwSRbGBCWt8LOW/RuWIlJqeG63spJ0RG7MnvXHlYKC6H7ys5y0q1Q3F0tdqIl1r78C1
         W7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062291; x=1778667091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvwBpTdc+XiyEreRo8SeSDyVWQHZ884Ep74h8yBEDlM=;
        b=MVW+b9dGO7S+fgb6tdRF8V8NI9ORgEBO4sqrFz1A4TldrJz6mJXLPf1mdP2S8KRJRU
         DCJvEqEQEl4r3Nyyn7mkmkoRETHYDu5SK1IQxelK4g0z6r8tWRncrfO1opROLjI3F9PT
         siiI538B7+OUPI43uidernpWYRxFitzayoYUH+Skpzm156DH+RskEH5qROlz07g+vnaw
         6r1Rj+yq880arqDjLNrxJgad1K+I2nCpsS04GeIaWiMZfSQn0sh3lJzzzu8uNt+AiKfy
         rmTlNIVyBcyr0aMx/xsWQ7tm8ipVXxjcvf85CObn87lYeiRb9J/XKRMoxzjXwL1vQeqC
         wU3A==
X-Gm-Message-State: AOJu0YzeFoZUhyTVfH4AnI5pHt4pedmuHb5DU60ehSU0Kg0cp+GwOy4Z
	n+cddUwqBfJydMZRkokTFK0t3KpbUFKlEPVQ8zMiUjMHBSLR+i47Ic2u
X-Gm-Gg: AeBDieu2yM5jLKMbZiaF2r3HfIHjW/sl5ccQJVeEnF0sDFOVGBOLqpsmioEWhJ96WBp
	n+wSImeHhLcS8ueoR9ruNoVLaNofyA2G83b/Pss2nTIzOls9aSvcwQHzuKIfkPy/n+dsGhSm5dO
	cS9Vlzx9TIgeJrXj1XGihKUlWalM4hYWNSF3UXaYM3fkUlWgoPmD403n/HN/57WbaOO9/DjSoLf
	DYJ6NWLOehwSWH8HyEMkZA5jmF/z4QhAnCubp0E22PoHG0KOkRHpWHqmewfG0jACo/CzGd4g+ff
	51HUbWTu/OLjvhZhQAJQTn3s7AItPaALT/JThNBPMs0U/dT6oQ4WHAiSE8o87y3W9XL6IXPSgB6
	WP5cRG2ZLfYURToZdKx3Hi2uORMN7GbIet0deLRqsjh2RxHkQgoR6xbjSUbCaEnaZCIkWd3nphQ
	eo9eiYUhgKyFZWxtZZsWMzqajoTu3NuEqTtCHCc9UED9ZXmX7QShhjT5WaMEsEWlN/J+XpKMQbP
	o1ezNzGEYIXcOihZrhe
X-Received: by 2002:a05:7022:43a6:b0:12b:f881:d8f6 with SMTP id a92af1059eb24-1319d05636cmr1273328c88.29.1778062291359;
        Wed, 06 May 2026 03:11:31 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132030cb2basm2431131c88.15.2026.05.06.03.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:11:30 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] net: team: fix NULL pointer dereference in team_xmit during mode change
Date: Wed,  6 May 2026 03:11:08 -0700
Message-ID: <20260506101107.1174136-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6EC564D93A6
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284779-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.765];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Spam: Yes

__team_change_mode() clears team->ops with memset() before restoring
safe dummy handlers via team_adjust_ops(). A concurrent team_xmit()
running under RCU on another CPU can read team->ops.transmit during
this window and call a NULL function pointer, crashing the kernel.

The race requires CAP_NET_ADMIN (in init_user_ns) to trigger via
TEAM_CMD_OPTIONS_SET, plus AF_PACKET sendto() on a team device with
forced carrier and no ports.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 Oops: 0010 [#1] SMP KASAN NOPTI
 RIP: 0010:0x0
 Call Trace:
  team_xmit (drivers/net/team/team_core.c:1853)
  dev_hard_start_xmit (net/core/dev.c:3904)
  __dev_queue_xmit (net/core/dev.c:4871)
  packet_sendmsg (net/packet/af_packet.c:3109)
  __sys_sendto (net/socket.c:2265)

Fix this by reading team->ops.transmit with READ_ONCE() into a local
variable and falling back to team_dummy_transmit if NULL. This matches
what team_adjust_ops() would have installed moments later.

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/team/team_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 0c87f9972457..3ff08b5deccd 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1844,8 +1844,14 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int len = skb->len;
 
 	tx_success = team_queue_override_transmit(team, skb);
-	if (!tx_success)
-		tx_success = team->ops.transmit(team, skb);
+	if (!tx_success) {
+		bool (*transmit)(struct team *team, struct sk_buff *skb);
+
+		transmit = READ_ONCE(team->ops.transmit);
+		if (unlikely(!transmit))
+			transmit = team_dummy_transmit;
+		tx_success = transmit(team, skb);
+	}
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
 
-- 
2.43.0


