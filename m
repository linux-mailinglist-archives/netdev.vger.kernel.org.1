Return-Path: <netdev+bounces-164004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA3FA2C44C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1C93A5925
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA49215F42;
	Fri,  7 Feb 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDL6/EEm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1A1FA14B
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936733; cv=none; b=c7vNMgqvicsUlRpX2+Kr4gOHQbbISZcT9d0+jlbrDtSSHsZi37mQ9U4L4CLbFihDAshJprE6DPWVm8cnc6uTvfXkeC+mzux4r0XBLUImA4m1XX1sO2NfoAA3q6wEPI1iiLgz80EySmHaVQkkFr0A9PeoWqLWPsHJes0/4iyYfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936733; c=relaxed/simple;
	bh=yBJdou1b+8zfvzSVi2ytl9JJsa9LYRdbGqytlnCas+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hs+ZymOzgbnrCjbogeAwW2WAKZdMROH5USb/GmyBuBa/DwE0Fp01DLH2ETnDbIe5igJgGAU4p/ZBjsXfYU+/mP2FhNHnRspRGt65Rz9BXSxvzipJ94Ho1JK9FxtuWtGl1gJOYrAOoVR9LVPIl0UPbha/5IOqldBRWSw215gZp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDL6/EEm; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-4ba8ff9e3d2so27031137.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738936731; x=1739541531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FEHxJ1egnTLzdNXmQ9LfqrzLd4QQBmw8hL2PW9CO32E=;
        b=RDL6/EEmBhKiuZBKBAYN5CjE1HYGgwWICD/IZnC+77PD4PGTvZpBfkXY58lasLs/gO
         /CItH0jNe/KVC11QWoCvvEgSnciGNJbVKIEmGIduEmgVXm+Sm5X/5Za5VsGlCZ7Cv012
         /YwHvIGGg5VQWNIGJoa6lWMQR1bUIfDWiwDS1Xj4x9ax4MDnLt4t3mm0u2XdkykrRRA4
         Di8+jK2odNSki+ARiuuzlLybajKOgW95+p9OyrwdMQE+5YdHmILrpGCQPuMbzZB2bdbx
         bWAnhcIxGXyPMr+S9YLOLvN8i1UYMBNhneNdupbQIXNJOHibjXC4vhSA5c1O68mR5DKO
         mFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936731; x=1739541531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEHxJ1egnTLzdNXmQ9LfqrzLd4QQBmw8hL2PW9CO32E=;
        b=bSN2vwewVWmRiESKEd4rwaavwO0ubh07FaadqP2JmX0modrqcCltXilzw+KrENTrIR
         +R/IVvzlFIu7AMraNAkXfFgKXXbhUt8JZWMUlCQG5bHR3c8Pj8ESXDaUCdw1Tbv/8Qv/
         NhF3N0+cUVUhCIu2/BYG2NKfK5sD9b1NpNA7HYqhdUP/1tV1/9Zg8xCyCOo8Q8u6R2M9
         8IX4t+tDmWtlOEcsiKeTg91xga9HW3Si4LBccy4M6/XtGlyWmUB+YzbH206JMMydApEi
         DzBR0+6Jvo+Trsy7LTy+iv9s849AM5LVAK/i3xVbEBkLgQvLzT7S8HgaPprTG5QOyPUw
         GjHA==
X-Gm-Message-State: AOJu0YyYP1Ix2FRAmyYoTHS0jnmCpxyh4JPnTuYLV5bd4MV6pqEce3uv
	FUwy7wtnfss28Oe0IZ1XySotvHO8Othzh6VM1nVxyuOahOfCVnmlDo9u8ryd+e0l8CF9sFMFRqJ
	L1HcP/+3FLw==
X-Google-Smtp-Source: AGHT+IEeSqV7Y/LaM/MPW7W9uSRsUm8GJrW/kqRPzWUEF6Vr22FsM0c1CnNE1BfE9UzLgmh70Vy3NwAfvx0+JQ==
X-Received: from vsbia26.prod.google.com ([2002:a05:6102:4b1a:b0:4ba:8260:db8f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:1627:b0:4b1:1abe:6131 with SMTP id ada2fe7eead31-4ba85f906acmr1719480137.25.1738936731025;
 Fri, 07 Feb 2025 05:58:51 -0800 (PST)
Date: Fri,  7 Feb 2025 13:58:38 +0000
In-Reply-To: <20250207135841.1948589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207135841.1948589-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207135841.1948589-7-edumazet@google.com>
Subject: [PATCH net 6/8] vrf: use RCU protection in l3mdev_l3_out()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

l3mdev_l3_out() can be called without RCU being held:

raw_sendmsg()
 ip_push_pending_frames()
  ip_send_skb()
   ip_local_out()
    __ip_local_out()
     l3mdev_ip_out()

Add rcu_read_lock() / rcu_read_unlock() pair to avoid
a potential UAF.

Fixes: a8e3e1a9f020 ("net: l3mdev: Add hook to output path")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/l3mdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
index 2d6141f28b53097fe452cbdaf5faa977fc6e6782..f7fe796e8429a5e633f7540430675a728ed4de66 100644
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -198,10 +198,12 @@ struct sk_buff *l3mdev_l3_out(struct sock *sk, struct sk_buff *skb, u16 proto)
 	if (netif_is_l3_slave(dev)) {
 		struct net_device *master;
 
+		rcu_read_lock();
 		master = netdev_master_upper_dev_get_rcu(dev);
 		if (master && master->l3mdev_ops->l3mdev_l3_out)
 			skb = master->l3mdev_ops->l3mdev_l3_out(master, sk,
 								skb, proto);
+		rcu_read_unlock();
 	}
 
 	return skb;
-- 
2.48.1.502.g6dc24dfdaf-goog


