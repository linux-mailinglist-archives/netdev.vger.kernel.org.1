Return-Path: <netdev+bounces-93342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F4F8BB3D3
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DD1B21600
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A6158207;
	Fri,  3 May 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zEqs0hG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618D2943F
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764065; cv=none; b=iW9XubvwNZ0MXIUx5XQYE+DcAnzF+vdbauM5kjZNPUbL65WQaEi7+ayMN3hhKt5UQjiv+5UtRr5/P9Fequ2D3CWpNh4B1+DDvlEW6YH4R3x4XhUVew2siYYqCua5iZ76HdstyAb3OFYu+v7AhZYmF7KQvdAT03L1wSAGmsBh3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764065; c=relaxed/simple;
	bh=5+4RayyWeZBCxk2V3aJaBj9NTDUm0ShmZ5tB8hHBRVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c5/l5LvV8ok311VIDxJy+irT4CXbqjfMayD+oUDQ3sn26fvEjrQ9HgOLy/5nvX0Vy100wBx2sbxNibImWUYn3KtvtRQVyopoayHJ31rAi6FmpI6YiBpH2UyEYwkCzwtBUZkyO4K2M8SGlwA8Xbrwcqa0Yg5WCa8bo7J+QPBEUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zEqs0hG7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bb09d8fecso140412507b3.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714764062; x=1715368862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NliRQ/CYwpmitjtxwGzcwSoNhoffMvcr6dqlNHuVYeo=;
        b=zEqs0hG79AjF7N7E69uQR/m4vtEebJGMcV7DIRMXrtsBOMWJfEubctVBF7JQqaMU4F
         KjqyD+OaOUWHq1Lf/c9FC+fEzhymUddF5zsuSBM+8u03rj8JloyXfLPT2Flx8pKHHnal
         5JK5ztn6pOXUTQABonVRyYt9vjh+u6MMVbdzsQx0235Uwtwxk3aa8YQm2YrOSYJw2CAd
         i+RTmJmbxLzc0NihUanNXvCpkpJXnBmpa2RIc3Ko304A9lFkJkwfkDxitjy2EA9MUi9Y
         RKsPtjiDBESOHCtlwDhDIrP8UbwEF5dZSPSFmEZqpgf7BlgmGZ4O2yqYBnz8JjNGC2sp
         a48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764062; x=1715368862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NliRQ/CYwpmitjtxwGzcwSoNhoffMvcr6dqlNHuVYeo=;
        b=W3gvQKhQAXz67auusueLk/W5tywK7dXTHRVxf8YE7CMS8ljwQvznJt0bT7rFLxNWMn
         2Zc/0Be3DHr+twXfAjqI6OGCQqJj4a0bmMMDdykZ9Koe6FiYUg/EQN7l2RCKkZyY4iK3
         dCUEzIWoAc9oNS4R28yi+1lWG/yH/VyGisw2U8ynXnQz9zGIo/HSph6a9O+dXNR2m6jZ
         8sabt1AYoe27c/IOHjni5Bjtu5raOFbg34QX3CCx7VmQIX1ta9FdIR/3H39a6IdqEnFo
         Ih4KxZKco5eWTK5NNdJww/mGQGwExl2/Io8FDZNKvSuTIl/vSZIUcbq4d0ckDdiB9sHp
         F57A==
X-Gm-Message-State: AOJu0YzhyYlttwTBdEPQBjoIhzsQklkltryH7195K6Nx+f1LoJKsMVx1
	YhlomhWav9GjwL8r+NSJ9BZTwrjDdfmgj3OxotpEaHwxIF3uSECPxt2LDGNz9HuYzIFbSNdeyz2
	7avw34Yx9Yg==
X-Google-Smtp-Source: AGHT+IEuWkrTJzX79TaU9k/sdZ3In+L191ZcA+dEpvVrN4JhO75OCArhOj/zdjUfmLSpcBry5NUkAJNceBIACA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100d:b0:de5:319b:a211 with SMTP
 id w13-20020a056902100d00b00de5319ba211mr456961ybt.3.1714764062727; Fri, 03
 May 2024 12:21:02 -0700 (PDT)
Date: Fri,  3 May 2024 19:20:52 +0000
In-Reply-To: <20240503192059.3884225-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503192059.3884225-2-edumazet@google.com>
Subject: [PATCH net-next 1/8] rtnetlink: do not depend on RTNL for IFLA_QDISC output
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev->qdisc can be read using RCU protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 283e42f48af68504af193ed5763d4e0fcd667d99..f4a87f89d5cde0cdd35c156d78ebe31511d4a31c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1832,7 +1832,6 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (tgt_netnsid >= 0 && nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
 		goto nla_put_failure;
 
-	qdisc = rtnl_dereference(dev->qdisc);
 	if (nla_put_string(skb, IFLA_IFNAME, dev->name) ||
 	    nla_put_u32(skb, IFLA_TXQLEN, dev->tx_queue_len) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
@@ -1857,8 +1856,6 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 #endif
 	    put_master_ifindex(skb, dev) ||
 	    nla_put_u8(skb, IFLA_CARRIER, netif_carrier_ok(dev)) ||
-	    (qdisc &&
-	     nla_put_string(skb, IFLA_QDISC, qdisc->ops->id)) ||
 	    nla_put_ifalias(skb, dev) ||
 	    nla_put_u32(skb, IFLA_CARRIER_CHANGES,
 			atomic_read(&dev->carrier_up_count) +
@@ -1924,6 +1921,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		goto nla_put_failure;
 
 	rcu_read_lock();
+	qdisc = rcu_dereference(dev->qdisc);
+	if (qdisc && nla_put_string(skb, IFLA_QDISC, qdisc->ops->id))
+		goto nla_put_failure_rcu;
 	if (rtnl_fill_link_af(skb, dev, ext_filter_mask))
 		goto nla_put_failure_rcu;
 	if (rtnl_fill_link_ifmap(skb, dev))
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


