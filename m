Return-Path: <netdev+bounces-128635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2FB97AA26
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3191C273F9
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB73A55C29;
	Tue, 17 Sep 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JK3MW6o6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72E76036
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535301; cv=none; b=dvHxspd38XI2oQoZartUbKN+NVgF1Y9N7sARY+WTvxVD5ehXetdVl+DxL1Emv98qon1ZCUkaqN+MCHDWXyC2JdMrAVG8JUqXCnuaPIEdNYRTrBAqUHUtNGdyDTHVD7n+u26mstQnurKIPOikgxP67nQyMgAsV0zAAInEzuGIYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535301; c=relaxed/simple;
	bh=Ac/8VnGlEXiqJzrHCDVfOhS/R3iJ0TL0QLChjbzMKDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfLMdWcQBS0LYMqY/80BpDDKKuyzcRB7rhorO2Bo9MbE08aBWAX8n5oscBKFepxdZIaSZxAAYgD1mePKz/QcBnJVSadrbz+9sDBT8oL8ovIQ3+w57sYxFWIOvnIzs3+VNudkzrenJniHFx6vmFcMONxYmtSsVOc+1zK8Yh2szWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JK3MW6o6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbaf9bfdbso31680945e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535298; x=1727140098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXj2oYWJ9f+f5gPdTz+1dRj6X9DJbzxwmvXd1qBnX/s=;
        b=JK3MW6o6Nt0Tgl5IdfJvxNlbCiELD2ZINEDqdtsbtaKb6ARgJxGePOSBKRaS0CtRez
         9eg5CMkhQrKnPoZBwF6cZscL+AHSdtOJoWvPxsQBI79NsUKp7JGFNLC/TChW1PaivgY9
         SAy1jSVgiLJ/6AdWa5hHwTpQ7jwAbDfSiqILaRgBkLmIglKNKoA3XFQ46UwLFI9W1rs1
         jJHERNpAyLQiUM4IE46Be4Bq0jQtfZetjsL21O9Yl83gHDDouzzsjlMUkJGaBb/+7Ou3
         Y1ZW050YJnoviUeAknFRP0HZcaaFcJ4AvW3sHBXsDT2kYjVnwdfstGIsl7XnN7NhgrVQ
         fHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535298; x=1727140098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXj2oYWJ9f+f5gPdTz+1dRj6X9DJbzxwmvXd1qBnX/s=;
        b=OLjKTSecTylm73EgC8a3fJl9qvbHjUNI6B25p47cIJdQk7fRbGDjQ9/lwlG/4U/Re8
         DUHX7QvGFq7QubsLFrjzh09DdD3piWJaqhrGuNIsijmf85MHGbbnqFe06TjvjXE2ZY2z
         UAI/x7BFGrQ/dLEBVFMmYa99GeN45fBSfqOwQVvDPR3e2WD5+yuK/9vtjYoM8qIkqSMG
         9qmQww2Ra3ZJ8ODmR5wHSWQJ/zjiBPQg2bTvnVmQSQV+ia5uQnTD5jbRhe+oAwVWaamO
         boavB17eGkjaAzRybBRPnh3fO1qZ8IPHCxLnvOME3tn9MNOfMd6Zkyf4EzzzK6mr/V9r
         6ZlA==
X-Gm-Message-State: AOJu0YyPnzaUeuY1RKvJacY5Ms+xc8zPWL+2k8F/qKMUX02MRNui88uS
	+qqbHU0EcbgZ4nHtVDLF0Zd+zazdmWoJXOkFrDnWl1dPeV0IN1qaTHcsVaAqOfSk1Y6oDFyztmh
	e
X-Google-Smtp-Source: AGHT+IGwQr6oyDt8HtAgu4v+sUwFWD5bmrUpTZvmFpQ3gzBBP+Ekm7DL8hc/C2OZvxGjHlyIy2Egbw==
X-Received: by 2002:a5d:4388:0:b0:368:5b0c:7d34 with SMTP id ffacd0b85a97d-378d61e2c14mr7612125f8f.22.1726535297716;
        Mon, 16 Sep 2024 18:08:17 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:17 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 18/25] ovpn: add support for updating local UDP endpoint
Date: Tue, 17 Sep 2024 03:07:27 +0200
Message-ID: <20240917010734.1905-19-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of UDP links, the local endpoint used to communicate with a
given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 45 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index cbe7b12be132..2a32bf4c286f 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -416,6 +416,51 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
 	return peer;
 }
 
+/**
+ * ovpn_peer_update_local_endpoint - update local endpoint for peer
+ * @peer: peer to update the endpoint for
+ * @skb: incoming packet to retrieve the destination address (local) from
+ */
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind))
+		goto unlock;
+
+	spin_lock_bh(&peer->lock);
+	switch (skb_protocol_to_family(skb)) {
+	case AF_INET:
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			netdev_dbg(peer->ovpn->dev,
+				   "%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+				   __func__, peer->id, &bind->local.ipv4.s_addr,
+				   &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case AF_INET6:
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			netdev_dbg(peer->ovpn->dev,
+				   "%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+				   __func__, peer->id, &bind->local.ipv6,
+				   &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+		}
+		break;
+	default:
+		break;
+	}
+	spin_unlock_bh(&peer->lock);
+
+unlock:
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index b632fabf9524..2b1b0ad3d309 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -159,4 +159,7 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.44.2


