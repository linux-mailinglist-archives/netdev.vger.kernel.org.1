Return-Path: <netdev+bounces-253578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KARgHs3Cd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:38:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 243178CAC6
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477D8302CD16
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7842874F1;
	Mon, 26 Jan 2026 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAMYRbsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61480219A8D
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456309; cv=none; b=kqQtmgXGYumESjPN77xUtsQpIt0HZkAJJk6bgApdlb9r24yAoBQwA12riMCA1FRVFkziRFENl3gt8pMzwuA7uCqGs3ezB/E35XWwQVe5wF74vAvp5tvN+oJuRrDsF1JO7n8NC0Y+uSvySXwtNT5RzqeXkyHRSfHtXsMqTQ3nrpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456309; c=relaxed/simple;
	bh=KE5ceNF2zDqw8LnnABdcfLeNarTK90DNj06IOU74ZGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sKrDxN806owuHGeqq+DaKhEF6FnRP5SgHiAs89GdkFesdmxDa4e69S7X5eUIPqhM62+0Wo1FQNz6cuV3hN3NhTE3KXeSrx47Kc+7ShaKhgIYS9dqWrIdC/GKsaP7CgAp4iXVEzA9mv3KmsKm56bqhZf8M4bOivwqQ5XnxdDe3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAMYRbsd; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7941578064bso30339557b3.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769456306; x=1770061106; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+aNIXln8blsmbOccfH89nynTXB7Mbf5xzL4onU0SVg=;
        b=cAMYRbsd+L5bRr+zw3z+k9CFSWmTQE1wKX0/5tehT9Lfo3hRmFeC8TopY9W1gcd7Uf
         9GjmymYgiQit1MBfFTSKIw+0ZDZJNPMc7mLxsc03/XVPOlJcXYBROfROWRCVr5idrcJa
         c+mbYbOaWjJHitxS/pRW4mVEcX2ccInIesczksVu9I8Jhikvc+zWSicqr1I4PCximlgT
         7un5I8/TalngCmta3ptUZCikUSFSmEmxi6EndcrucS8grk6Cd6xN9MjntddEOxjG5qeJ
         CbR49wxl15xkKPs2O9Nrod9ofYNQQOM15fgsHg3cra4A7UxAGl6VVTAuZCbAhmkLLmlF
         UmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456306; x=1770061106;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+aNIXln8blsmbOccfH89nynTXB7Mbf5xzL4onU0SVg=;
        b=fL7nQ3nlMUo9x8n1XLh5FuZV6290h8N8YieN4SSPJkUCKTk7eqSTdZ36NQNK4aDVn9
         eC1mZkKbckfV2cwZtLTFFezGm2R8gWxaU2wlycGP0DG1HGSc7N0Cch6rdvkz73Gn+IaM
         jGcqnuQxD5QzFzprvciiX5S5qD84djivEbfBYGruUFAvpfu+qDfpS12TxSoJkYnIQnun
         ifSstDiYKeblmjAA85XIaBQhzrwGIwdDUPkuKZ0TVZSMTHWKksEqWrTSnTGRnhY/Y7ct
         OogjqxUa7o1bQZw0nNWcVrl0eBTY9OUj+EKhvmwDmB1Z66n9QYGy8K+89l0xRBamuVvR
         i/Ug==
X-Gm-Message-State: AOJu0YwYf7xjwCH7SfykkOh9QyVMEyGDbHWhRtifsjGJ/vvsH/cZStWZ
	T2c2TrfNxvmap4WWhhkLuCekV1N382HsAl8c5KR8BbalMWb0Tay1GJR4
X-Gm-Gg: AZuq6aIiYy4y0Zv2+dwN7t9Ril8th++7h8+Ei67MKGkR8taBQ15SGbP7ExfBJ9njGO6
	3Nf6PcuIHwU9oty4yc9cULVTozeDzSSp12GkV1Zp5S1KjC+7Q+EDhrXEYVRYH0bn+4kbnus6W2m
	cGWHgC5Uo8f5EYVEYKNkowG1mf97W1zAiGtbct0C9GxeasZm3sht+ScfgqAbMW14zBGTVnOeCF7
	o1+b99RP7F2gi1Lt+TNLE0dGafby1/JD5ThkOmxf7xB2gSocwOYUKXyl3Nn8RhK762H8CN1nC7z
	885qG1jCLJjP6Y/SYqsHRqZMqvX6fGXJEaPy/11jjSqpcVWGXk1/jnUKymVkbl5Um5hADzAheJh
	jcbLHL+aChmfJNGBVnJvjx5kJ4fWTicn3hjsCR2m23/kfJsti8u0oEsMJSOXGJano4CeNI9UyX3
	KSl1OXCVI=
X-Received: by 2002:a05:690e:120e:b0:649:39e1:6498 with SMTP id 956f58d0204a3-64970c9dedcmr4255047d50.60.1769456306319;
        Mon, 26 Jan 2026 11:38:26 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2a2ed1sm51516537b3.30.2026.01.26.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:38:25 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Mon, 26 Jan 2026 11:38:17 -0800
Subject: [PATCH v2] net/mlx5e: don't assume psp tx skbs are ipv6 csum
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-dzahka-fix-tx-csum-partial-v2-1-0a905590ea5f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKjCd2kC/33NTQ6CMBCG4auQWTumnQYorriHYVFLhYn8pUWCE
 u5uJXHr8v0yeWaD4Dy7AJdkA+8WDjwOMeiUgG3N0DjkOjaQoExIIqzfpn0YvPOK84o2PHucjJ/
 ZdFik5HRtSas8hQhM3sWzA79WsVsO8+hfx69Fftcfq/6xi0SJ+U1IkWeF0lqVTW+4O9uxh2rf9
 w+HsDvtxAAAAA==
To: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
 Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253578-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 243178CAC6
X-Rspamd-Action: no action

mlx5e_psp_handle_tx_skb() assumes skbs are ipv6 when doing a partial
TCP checksum with tso. Make correctly mlx5e_psp_handle_tx_skb() handle
ipv4 packets.

Fixes: e5a1861a298e ("net/mlx5e: Implement PSP Tx data path")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
This is a bug when an ipv4 tx skb passes through
mlx5e_psp_handle_tx_skb() and tso is requested. It was previously
undetected in my testing because my setup involves cx7's on both ends,
and mlx5e_handle_csum() marks PSP rx skb's with csum_unnecessary.

To reproduce the problem just turn off NETIF_F_RXCSUM and observe:
nstat -a | grep TcpInCsumErrors
---
Changes in v2:
- move declarations down into branches where they are used.
- Link to v1: https://lore.kernel.org/r/20260123-dzahka-fix-tx-csum-partial-v1-1-7b0107693883@gmail.com
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
index c17ea0fcd8ef..ef7f5338540f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -177,8 +177,6 @@ bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct net *net = sock_net(skb->sk);
-	const struct ipv6hdr *ip6;
-	struct tcphdr *th;
 
 	if (!mlx5e_psp_set_state(priv, skb, psp_st))
 		return true;
@@ -190,11 +188,18 @@ bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
 		return false;
 	}
 	if (skb_is_gso(skb)) {
-		ip6 = ipv6_hdr(skb);
-		th = inner_tcp_hdr(skb);
+		int len = skb_shinfo(skb)->gso_size + inner_tcp_hdrlen(skb);
+		struct tcphdr *th = inner_tcp_hdr(skb);
 
-		th->check = ~tcp_v6_check(skb_shinfo(skb)->gso_size + inner_tcp_hdrlen(skb), &ip6->saddr,
-					  &ip6->daddr, 0);
+		if (skb->protocol == htons(ETH_P_IP)) {
+			const struct iphdr *ip = ip_hdr(skb);
+
+			th->check = ~tcp_v4_check(len, ip->saddr, ip->daddr, 0);
+		} else {
+			const struct ipv6hdr *ip6 = ipv6_hdr(skb);
+
+			th->check = ~tcp_v6_check(len, &ip6->saddr, &ip6->daddr, 0);
+		}
 	}
 
 	return true;

---
base-commit: 709bbb015538dfd5c97308b77c950d41a4d95cd3
change-id: 20260122-dzahka-fix-tx-csum-partial-952e8dc28375

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


