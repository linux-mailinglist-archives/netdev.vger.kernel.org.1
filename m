Return-Path: <netdev+bounces-170054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F68A4712A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B099516DF13
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 01:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9381EB5C4;
	Thu, 27 Feb 2025 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HrUXedkq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC271E520F
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619391; cv=none; b=qWk9FVoAqMC30KOBzdWCGKJx83Y7VdAEIPuc+duQc+X++jjp5CHu40+HXx7aXoxSiCkyBP29pcylGuDQqXDF5T6Q7EYzX/6kSxTAaAJ0n7iFpIqOpVXBwKdlbytZi32nv7GfA+mk2PzUJ6yjPjrJx95tUohChHvxadqP6WxFgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619391; c=relaxed/simple;
	bh=JA7masIb+fyQcs/Z0y1gbGLPicAtIT3ViR4aoSMjtXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U0ghx9pNCqQIT/jqHLbQczBYKoZhR4LgTq12TWHzOyjKwFFHDElBZrADqxQjD/wt7xNM5we8kapW9eTre9auckc4XVgfgGMcD9RdjE3VH1avazoBA5GDH4GbCCJICkZMrarUGCi+xRng9dz1SdMR3jOLJHESin/HwEyYjgYtUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HrUXedkq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4399d14334aso3874415e9.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619387; x=1741224187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMNJiu3Lg627dyePrVylvpX/tk8XNSi9bzrWTv7Zr2g=;
        b=HrUXedkqibXL2QcBS9o8V0X07xj5/cGswmD8wcr6XWE0PV/WJgqTVJxL20MnROcbTM
         b81EUsBiwEf1K8syp3ecj25aTX30hs0HHZJ8OdUh/i6Cv0L2kRxVXL0URWxvuuFB59Lv
         NxoXbTCasvJM28QUX0QdjOJbbhy+hqO+vElMaUoC/8XvfxT8x792aSB/SRWyOgtl7wbn
         rDyMagDjRctSmKN2/hTof8CJlxgXd6SHyclTV91lYaWMP93s79bNS1XNUk5vOtSbJYrD
         Z08I8Fu4y8TJvr+omfY2AsxUhO9UYG2rF+hyKba4DHm4Srpo9QKRn9R9/2lGxIi9h1l/
         lKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619387; x=1741224187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMNJiu3Lg627dyePrVylvpX/tk8XNSi9bzrWTv7Zr2g=;
        b=li1/MrGuKTQTEgqSLNdoH8uOzRgOz5cVy4DPlpH/x57s5+RfB9b2PVbvmm8ikMS5Ml
         hZ5PR8+NdEJ9O8Q5NDXkeUhgSq8JiI6m6c07ut9ju7BhTiDmm1NDbTOYMphk+wzNtKON
         8HP5IaktaSaA5Zwg3eR7LxzGlrzXTbSlRrnY8Wl3n8izwvL9t65DBkgqC32BSgJpC5NO
         iXRImgdKrVb8GgBu6GU+zgi8i0lDsIcQgDmPmGy0dTgXTJMHrU3xAsALEJ+yp5san6ti
         glovm0VE4ZWn10q6D57OduQtWJIbMmRTSwdV7eDBx5Wsl5ujou9dr6rg/aB4o2Y6o6eq
         EPwA==
X-Gm-Message-State: AOJu0YwQg8jzVFca2NfzCRfvzgrf6fHlImThwRWfKtJdczgurXxYgacl
	M3gN32vmBvHAlMFMp/oSg0hoTRvS5J3eYp67b7oasWygokZ6o2RMtSNamBe1rH09xmmkGe4aln+
	8
X-Gm-Gg: ASbGnctpNtIH3Kuzd71eaYT5BhklM/SFsPI9ghu55wVKHpN9SoNf/WvgnfQoGKi34t3
	ObP4divqvA83NPFN63zepfAO+M/Ua/s7x7a7JHNo1L1Eh015VHpegZ5HNmyxWJKMOxPDvkNccj3
	1trmO/ELdwHzOuhw6gpzFL8kt8CsxLeQcKfYVDQv5iX3L+ZLp5ZmcpKFKUdydDBPHu70iUcTMn3
	NaSsAjv72KiJu7W9OrPh/tKWJyWzZGexjfSn210vdVJvk8pvjNlDN9eiAJpI9lFJetjmjROLIXO
	nDULFPpk2NamkI9DKXn19v9YJnJE1eMudqCS3A==
X-Google-Smtp-Source: AGHT+IHbituMJs3rWfj8UVNf8ic9Oyz4eGoJgyJUmucaf6WbuSO33oox4PlIFWu+TXXxyg8QKwaFBQ==
X-Received: by 2002:a05:600c:3ca3:b0:439:6a7b:7697 with SMTP id 5b1f17b1804b1-43ab8fe183fmr54568035e9.14.1740619387375;
        Wed, 26 Feb 2025 17:23:07 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:23:06 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:43 +0100
Subject: [PATCH net-next v20 18/25] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-18-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=JA7masIb+fyQcs/Z0y1gbGLPicAtIT3ViR4aoSMjtXI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75hcisvqzn3UoVZSgYaxLRA6UQy8GGmElNPn
 kzJUW2THpqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YQAKCRALcOU6oDjV
 h/fjCACL64BMaoFluD7BHFJUw6XwGNM+33rLusIfvoJ+Dwnd4uZNQC9E8S3JeRqc0dIceB/h2+r
 pu++E7+PwsOA22DHQTtMh8cr8uuGeAcU4LQv19Oa0oIslFlo+WMFvWJzy0ZghrnmyWe8MGrsQN+
 r2vrtKHLOs40wdK7VW/gRo9UY1beFRsIIcAjNnTWLbpDSwUrsfSVGeP1+l3l53YutjNSERSDu1c
 4/8EZbSfQyTJxSrz1RiidWSBCJGA7llsR8WAX1AzKPnmWU+FXF1v4RmOrTrtuc+7s/6Ta1yntDJ
 69GAf+Cv+DOXAISew8DZlaxvNX6lZSLPdwTY4eKhmXBbcssR
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In case of UDP links, the local endpoint used to communicate with a
given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 98c43509a4c9161db65a4bc876940bce33290fd3..cf32f3a354c10a71c23c7261aee5a2f98ecb6cc1 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -522,6 +522,51 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	llist_add(&peer->release_entry, release_list);
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
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv6,
+					    &ipv6_hdr(skb)->daddr);
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
index c8e9218b1f1a096c3307ab6c687dd6836adf9741..6e60a0d1023b3289be4fb618e3bac24bad7b32b6 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,4 +153,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.3


