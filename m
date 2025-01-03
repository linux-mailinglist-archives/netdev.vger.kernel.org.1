Return-Path: <netdev+bounces-154956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5CFA00784
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A975162E66
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E81F9EAF;
	Fri,  3 Jan 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEsrDZA0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3881F9EB1
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899113; cv=none; b=iZQvxeEdvoWaEYozy4egD2OvGT83C9RcifChEtdLWAV9Yf/+LxJS+U7AXJNatI0z9fnnAniKPb8KzWu5jPcLJlNmdkjiqo7qSkHf0DFTwUJPmeZXOs/sGl8M8GZl3sUFFu3aG8wVmpk4fitbBNPbxeQo/FqSyAF0M/OO9OlHWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899113; c=relaxed/simple;
	bh=GDLNHR9k8+1hipWdtjk2O8KNbKTEQZ3UMkSvyzFmWoY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LVQbA8p5kL/pE4ZnEcdHbpeRI6CubIp7PVMz37E9zgwXuCjsOzva0ThgQeNULo7OicVTdnUY1F0E7GTfPX8opXIdubKSOXoMWBmXeUOrfIMiFJhhRNyZU9vDdN8jQBs4sqw7j3B8GKvaZzE42eySpar1+A5p5gcsw7cUU+mU7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEsrDZA0; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d87ee5fb22so174415966d6.1
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735899110; x=1736503910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EGxIY7yLyi80A6nXzL3FGSmniFcyDd6VQFbzNc8nsyA=;
        b=DEsrDZA0DmztQk7bNDZGRrPTFAdzjM3C1WgwHaLWvDSYSvrlCBHBGSia+b1tvd/keH
         yKBIQzyi1p2UrelgYm7c4D24zDEtQ4ilpOMTsfKGXfJn9QkJqdHcol8Jw7t3jmKvswwF
         gw41WSvjjHKYtPGRr+CO5PIk5eyZHAGO0bPHRbHT2PUIKyZscsgrqAXRfRZzqfGynMzR
         cR5bbzAC7BN7pfdnuSrHk2ILlQ9ImMNFuHoBVYgkrQfDZs5VaFfpsik9cPWpg/3hF5QH
         l3zxd1fUVWsbe+E7oFbXhduENHdinWnmIroKRCQgy2z2T5YsxqQrTwVmMS0835JOtIfK
         RUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735899110; x=1736503910;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGxIY7yLyi80A6nXzL3FGSmniFcyDd6VQFbzNc8nsyA=;
        b=G/+W/Khbp3IIn/KkAY/zrYdAJC5PXfSBjHOkACX7Jz0fOjCrD6UgiYld7/hvLgC9ng
         TR6EVflsuyXPFgdvt4+VE4SfcfjgIJyq+LcVDLlRXTD9+UjOier92bbYjd90spgBGwvY
         anY22O1NVfSiPvvWK2xBTpu6Piqj0JZ7+PvagrgSbIftJIl7FR0z+6Ek1yYb+LxaP9Bf
         iMcJIjtpEsfyNQlkNY7EkH0xK1lhIHEyjx9Tz0TIbCFXS4faeArhEiLaIBd+phCmvFs4
         4vdHgJ+bWsPZv2Urp0jbBQNi8DbA9LVTnPVB6wYOJfn8KHJOf5MZSMTu1JuqBiEdPVHs
         qMfQ==
X-Gm-Message-State: AOJu0Yzh65QT45U8blycIo1qQWSX0WSOiec78m9NReY9gFEpqLtsumIr
	Cc9ogJFYD6ZCDsqrHovFm5kGVawCcLkV6bHhiK/v+ZEadTo3432vtG4TvlZk8PHbZmHjW4naoHf
	/jS4Owl2z5A==
X-Google-Smtp-Source: AGHT+IFlLL1lc9gyKcD003nJ6yRiO/e7x3l1XHwbURO+OFt4VBDqfNuc+2YJnlndIIKy0VFORak4QJaHKGaEgA==
X-Received: from qvbda11.prod.google.com ([2002:a05:6214:8cb:b0:6d9:319a:87be])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:19e4:b0:6d8:7efe:f791 with SMTP id 6a1803df08f44-6dd23345594mr886712376d6.18.1735899110189;
 Fri, 03 Jan 2025 02:11:50 -0800 (PST)
Date: Fri,  3 Jan 2025 10:11:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250103101148.3594545-1-edumazet@google.com>
Subject: [PATCH net-next] net: hsr: remove one synchronize_rcu() from hsr_del_port()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use kfree_rcu() instead of synchronize_rcu()+kfree().

This might allow syzbot to fuzz HSR a bit faster...

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/hsr/hsr_main.h  | 1 +
 net/hsr/hsr_slave.c | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index fcfeb79bb04018f3a84be3e24f29c6b92f2d8be1..7d7551e6f0b02ad965561eb45885a949dcf1756c 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -163,6 +163,7 @@ struct hsr_port {
 	struct net_device	*dev;
 	struct hsr_priv		*hsr;
 	enum hsr_port_type	type;
+	struct rcu_head		rcu;
 };
 
 struct hsr_frame_info;
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 464f683e016dbba659ac0e4f2e02306bfd016ad9..006d6ef97e53f4077eb16f08077ee366d8cb4bbd 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -235,7 +235,5 @@ void hsr_del_port(struct hsr_port *port)
 		netdev_upper_dev_unlink(port->dev, master->dev);
 	}
 
-	synchronize_rcu();
-
-	kfree(port);
+	kfree_rcu(port, rcu);
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


