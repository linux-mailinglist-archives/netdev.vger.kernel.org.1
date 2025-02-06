Return-Path: <netdev+bounces-163548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACBAA2AAAA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFAA47A18C5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C0F1C700C;
	Thu,  6 Feb 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqKX8Yzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3B1EA7F1
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850667; cv=none; b=licVkFIn/BQbXKiuuM6TYlOuMOy2qyQgirmeiuO2yaF/QpP0s+qbR7bHRajxMGXIF1+VHsXT4CHgC4xHjeM5dRW32iHu5/5XO8abVwxmAWSLrpdw9+bCGWASa/NEFTFFZfZK44DZecRRILekaRPWHw6wcmJW7bEsqOwwxpLxBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850667; c=relaxed/simple;
	bh=19nECr+ASy64dshvuXClrkN2BWfEJE+QeGvO2kZZuJs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZinroTaBCymgJUy9QN4FXqc2jqEmTn4R/Wpy/OW1qVxVHVDaZmXrlJ3vCCfIIoT8GejHSaku2oMYPxKuOB48k1ldBl12ktwNGqh6D4Uk4IDN25+L/gQVXk6pR0Aytd4iYyCUfhmYFSFrnZxdmbI/zEH0Cbg42nr2LcyQyi4E+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqKX8Yzn; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4678b42cbfeso19302781cf.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738850665; x=1739455465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+3Ezt2jw0RdDqA/5KYlY0tIx4bpbtm31jU4B8gciR+w=;
        b=iqKX8Yzn7gcGL9ObtgfpeXDTsmzCMjHCqhxPv6Com4rsX8hsAkRiJQ3Lv0WjKpfwB/
         Yb1M1EwGrVvFCbwQOnMClCoaNhTw8Xn1O0+noyhc8xUggSgEtQo0KFgzf3f6Jg9jTwGX
         WcMpxgWAweFlA49ktxVB1ahANRiKIJEHKLB7f8EyE5r3UOEhbNz0M4nEkfkjVvwwZUML
         iUCvTzfgQelFJCQdBfzvkXPlyRX7EvHpQ2nBR2w0DVBja0HGlVWv5hjvoMhTLVKyJk5v
         zJHAcWM1KUa64rFQWPhP3a9F9CCpPm67UWHiAde8elq/rwjScbqb7IVYapdN4EbNjtwy
         pZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738850665; x=1739455465;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3Ezt2jw0RdDqA/5KYlY0tIx4bpbtm31jU4B8gciR+w=;
        b=J0+Ne1b+LYb1X/cOMW0V39tawBS2K219QcOddwTY5tQuvJxtEno7gAlXIZ62ArbJ3m
         xWkQmTVOmH1RR4fXQaQVqm29quwr5qX/1zV7B/l9x15XexHbAm374hlravmiU2yohDzL
         WIHYCLcQ8+4BtYd/eZYMxVl6Vq5h0r+3nQ0sxqVGCIFTDDTWnYSgfFiSgFbdCXp619Hf
         1k2aEhg+R8oK1nXp1wu+TLPb3vJoBfaT+eeGjXPJnXnj4PlJCKp2xExYmkJVIveA38di
         i/t1KDBPiyZ7BZ9gj2KOnVD9WlYISBAgh8TiP3akojGuYcJD4fPjzINiJXd0LeaK4Z8y
         VjMw==
X-Forwarded-Encrypted: i=1; AJvYcCWi9v60Wqr36maRoRKAGRMqSrmFayUpcMlsdVRI55UexAHc8pykJwZS21T1nzzLUfv6WaZYj0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YywcWQ30W0VNOtsusKwHZfZjHabJbcCQGRUIwbNFHEhBWishFUz
	dPaGPPV7hki1S2hOMwSGPeWj75SUA1woSqi52Txe/StDPgck6zZlK8XgCbi8sU2K6QLaqjT7mbl
	kdW3lujJURQ==
X-Google-Smtp-Source: AGHT+IGmSvWzxT0JJEjR2UGpgY6nrETDcW9JU2BjWy3ffm6raX1CzjZuAApA5SzGLq9qKqB6TprTN843Sw8wFg==
X-Received: from qtbbv26.prod.google.com ([2002:a05:622a:a1a:b0:46e:4a3:1078])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:6083:b0:466:9d0e:1920 with SMTP id d75a77b69052e-470281ce121mr80192321cf.24.1738850664781;
 Thu, 06 Feb 2025 06:04:24 -0800 (PST)
Date: Thu,  6 Feb 2025 14:04:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206140422.3134815-1-edumazet@google.com>
Subject: [PATCH net-next] batman-adv: adopt netdev_hold() / netdev_put()
From: Eric Dumazet <edumazet@google.com>
To: Marek Lindner <marek.lindner@mailbox.org>, Simon Wunderlich <sw@simonwunderlich.de>, 
	Antonio Quartulli <antonio@mandelbit.com>, Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a device tracker to struct batadv_hard_iface to help
debugging of network device refcount imbalances.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/batman-adv/hard-interface.c | 14 +++++---------
 net/batman-adv/types.h          |  3 +++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96a412beab2de9069c0f88e4cd844fbc0922aa18..9a3ae567eb12d0c65b25292d020462b6ad60b699 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -51,7 +51,7 @@ void batadv_hardif_release(struct kref *ref)
 	struct batadv_hard_iface *hard_iface;
 
 	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
-	dev_put(hard_iface->net_dev);
+	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
 
 	kfree_rcu(hard_iface, rcu);
 }
@@ -875,15 +875,16 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	ASSERT_RTNL();
 
 	if (!batadv_is_valid_iface(net_dev))
-		goto out;
+		return NULL;
 
-	dev_hold(net_dev);
 
 	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
 	if (!hard_iface)
-		goto release_dev;
+		return NULL;
 
+	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
 	hard_iface->net_dev = net_dev;
+
 	hard_iface->soft_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 
@@ -909,11 +910,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	batadv_hardif_generation++;
 
 	return hard_iface;
-
-release_dev:
-	dev_put(net_dev);
-out:
-	return NULL;
 }
 
 static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index f491bff8c51b8bf68eb11dbbeb1a434d446c25f0..a73fc3ab7dd28ae2c8484c0d198a15437d49ea73 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -186,6 +186,9 @@ struct batadv_hard_iface {
 	/** @net_dev: pointer to the net_device */
 	struct net_device *net_dev;
 
+	/** @dev_tracker device tracker for @net_dev */
+	netdevice_tracker  dev_tracker;
+
 	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
 
-- 
2.48.1.362.g079036d154-goog


