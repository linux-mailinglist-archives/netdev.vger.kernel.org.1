Return-Path: <netdev+bounces-177973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DA8A734E9
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 15:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB87D17C4EC
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF452185A0;
	Thu, 27 Mar 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxihlT9r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730120FAAD
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086684; cv=none; b=mkvAkZxmfsVYqbDg5nb9VCHXCf/bmxp18ZiXzgsVNBeYBMa9/R47I3kRc3J42h9crXcDmRIJ94i6UJDg1NxEZCjyo1ylal6hvDzrrWwmaUJp8TyAzCqOXkMZv/sVqiEI3+/n7WS2k7FQcVYPD/xTtnehSpFEW/pXZIVo5NzhN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086684; c=relaxed/simple;
	bh=CVMAUqdMqwXecFhbNagocbuE9MqK0AviK2J0er9BwnI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nXn0bPbCxXqQZqa84mOUxIix3NpeiSIxiVOebCyXwlzPGv+DGF4m6oaHujVeKNTaxD8LzHzd3Dgbwg6ChgCN4BTE70sismbcu6+Mo8fEa1xhBKOKXO98VcgtnDsCrQBBmHFS1NXfSx8MwnGlCr4WA0Sh3mlSRpXUJLkyu4BD378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxihlT9r; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c5d608e6f5so283338685a.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743086681; x=1743691481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8dDWbbj8k4GqLhr8HymvfryIzFqM+0uIB32B1g7MTTA=;
        b=sxihlT9rLZVhGabVXVjOVVpF5vRiH7U0Qrsm9ruUqNmrjyH/a6sTG+KBEA0AcJeQvL
         yaDOytUOqietZ2ZguRNibvwGYpi8s4pZx5s0RvtYc1GOHIjvmkAX7+hwKkFE9rzY7Ht5
         EB42qI2SSXZs7py64W3VMjeYitlvY80jjraAxMAEau6bw3Q2D3M0VsgiN3NWhCzSIlae
         tj1Sn1M+ONkh4iaKWg2xSin3S6iQ+5U3r/MuFVEPbzRU/obXiPymC5TMfp4Kru+8XLgg
         l9IHUMx0z4pBnCz958ZSPexbQ8ejZ8jlFTajXpJNQs4Hn5sjUy0SGn2QBbqXRVYp35cP
         7tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743086681; x=1743691481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dDWbbj8k4GqLhr8HymvfryIzFqM+0uIB32B1g7MTTA=;
        b=tgqoMvAu6qnlm9U84dtX16ejWp7W/TAQNxoGvy/7obEj1+r47MBYHs4tpDre9HSYXh
         zvMUVI+w+ARSjYVVupQRBbRHUodJagG1a7x1r7Hu1VTgq4vq2lTfMWHHYmnhKlOcXB0t
         AKgq+kZYI1Q0ZdgQCbIhtVk7SII0QuZaF8cBr2G2VdKF9WjZTYlO1rNtnkvTs4PVJoJn
         GpTOirm8BtRd1F5/tra7CtLLsvIJ6j35wKJwOBHMXYeqQKj+Tyf4LCBtmhXrY1wa5uSj
         Cpr7RhQRrQrSWEzW2Lo9x3L9fnNXmn5ItVf1lfPUFiEbHkvKkp/0x/W4tXdn/RnlCVun
         OO7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9rq95h5+6pfquPNlD4nUq90srUXE/Y0YLVzrKXmuR+oKho90B2KTLAH2dGeC2/g/3n0xas3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0dflan+HNMBRhJQNF/vvXf19FId/FnGd92V+U5iOgE1i3ocb
	w5qps2It8jWJVyuQhYpxL3PWItvGVoa6nAisQkg7GzuImCv2hpqlH7EDiCvlm7vN5sxOFdx98pF
	0aJ7nE8rgJw==
X-Google-Smtp-Source: AGHT+IFJejCgfjZP7pLbGOGNQw5dJHXGeYQyrEVwFYcWMBqa5aU6mETkYf7HxGs8K0yEFzbNLXu4h/+mcm4t4g==
X-Received: from qknor15.prod.google.com ([2002:a05:620a:618f:b0:7c5:7027:d423])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:468c:b0:7c5:9a4e:7b8a with SMTP id af79cd13be357-7c5eda82ddfmr751733685a.54.1743086681404;
 Thu, 27 Mar 2025 07:44:41 -0700 (PDT)
Date: Thu, 27 Mar 2025 14:44:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250327144439.2463509-1-edumazet@google.com>
Subject: [PATCH net] net: lapbether: use netdev_lockdep_set_classes() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

drivers/net/wan/lapbether.c uses stacked devices.
Like similar drivers, it must use netdev_lockdep_set_classes()
to avoid LOCKDEP splats.

This is similar to commit 9bfc9d65a1dc ("hamradio:
use netdev_lockdep_set_classes() helper")

Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Reported-by: syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/67cd611c.050a0220.14db68.0073.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/wan/lapbether.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 56326f38fe8a30f45e88cdce7efd43e18041e52a..995a7207bdf8719899bbbe58b84707eb4c2e9c1d 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -39,6 +39,7 @@
 #include <linux/lapb.h>
 #include <linux/init.h>
 
+#include <net/netdev_lock.h>
 #include <net/x25device.h>
 
 static const u8 bcast_addr[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
@@ -366,6 +367,7 @@ static const struct net_device_ops lapbeth_netdev_ops = {
 
 static void lapbeth_setup(struct net_device *dev)
 {
+	netdev_lockdep_set_classes(dev);
 	dev->netdev_ops	     = &lapbeth_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->type            = ARPHRD_X25;
-- 
2.49.0.395.g12beb8f557-goog


