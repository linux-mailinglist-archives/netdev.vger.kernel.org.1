Return-Path: <netdev+bounces-89023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE88A9413
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B689283D1A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49538651B1;
	Thu, 18 Apr 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FlOstQqj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73A6A356
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425583; cv=none; b=IgmGxTK65drunhUwT4C5r83S254OfPZPi5+JtvueSFArPiaCE8Km1yYbB/5EKZJnD7Q9KxiB/RM1FDZse7YFKM28eZigYSANnZN5BZzhY7YCA/EzjW69HO7vb1K4u9GN2aPXfJXLdwbSO8pFqR8CtLhDPP0lEgU+IFK8gM2GZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425583; c=relaxed/simple;
	bh=vGDRsF2SQuhzhsL9wSQ8KZPZPJN1nEctETCneR7xS0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NWLiid4ThfRq/1tBn3+Wfx/fTfeKzvHDPhqCo5Ex50Y7OH9icAqEgmD3jFY6tbnnKspkyVowZmqGY0lWKu2epPmSsXejGX15+I8jIn1gCXkNkz4HJSX6w6jxuvy1AQRGGJ0cJh2LuYKMjBff0eOFRnKJxc9b22Io1+HIYMup2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FlOstQqj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150e36ca0dso10110937b3.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425581; x=1714030381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjbA9Hm94DgM6gUo1HGzOdv08CERKaJKOCV/kzrCO/o=;
        b=FlOstQqjgM2rg7vsIlRs1PgOmXhoJIMOWDjttqFj1XXg5GVomokFVWz/NAVm5Z19aT
         YvsVbnsy90V1jZcM4yB9FzXcK0FnT8iGt504JgQGjeYu5hhpZSOv7lz1OVf4AVU1vk/d
         lgy35tAZFFcxpacLMl++oYQXhYjV/0ZeNPYpiYQH5YbGfL+cXIliVzzzxWvpLHl/2JsZ
         oF7EfBLce+raALbUHdANt+MHX/K4YY507KFyp3IOMOAtIlotZ8qf+eY0DF83FUNVnv5y
         SHb13H7DAh4yC2470at0je26xqAmI9UAtbzPPsVxYQo8dzr1qjrodOWkXN70BmVpmnA7
         Ih+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425581; x=1714030381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjbA9Hm94DgM6gUo1HGzOdv08CERKaJKOCV/kzrCO/o=;
        b=KaZXT9TcWqKAwD2PsjM2ZdFPXmX7MkGshjuLwiUqhve0nghRDzrcxcGprFuv4r2Ynx
         M/sbz622v35vISUk7+1Tmwe/VnhU93RZQTyqTGoyTP3xz66vG2iZi/0F3Fp0Vp2os4+a
         IYiMf5p0j5U00uCbzI3amUrgMSfit6NZBheJv+8MbXWRARyz5SVr7+Ohmbgd8oz7M3wQ
         MUYxuPzGoZVTsWWv++5EmJZGq8GyNyrll9NS6mGtEBSdHMvHADMVU0+vFGj5fZFgdSE0
         JphunvYyzVaFcWQ9gxNnwGlHfu8sH4wCghyARsNq4ylgEtWThvKAngd9DvLRDLDT5OZj
         Vr0Q==
X-Forwarded-Encrypted: i=1; AJvYcCULWkQiqv6OIPjaW4z8JflwQSSg42P5M72rNevYFFAWgCmc0agzAwLle2WOt6RzqM3wDnjmM6QmEwZGGo3r1U/cnlmEE5Eb
X-Gm-Message-State: AOJu0YwSEKgH8TEXquKCY1zBniIW2pXmiKscatia12IxKpbloguyKGbc
	VXpeAXia1U/cT3+9f5KnVfeUGFMGdo7bkb2KcsoscQawKa6xNSMqLcXJVp3nALFO5v1DHlaJHPz
	esIvK3M6J3w==
X-Google-Smtp-Source: AGHT+IHQgiXzPz/RbfPTLrk16d0yT7utDif2qCm3fdg6LsIQPZmjjg6BQwu7TVsoYvw9USBsr9pQijJ6OOcc/w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2c05:b0:dda:c566:dadd with SMTP
 id fk5-20020a0569022c0500b00ddac566daddmr134882ybb.4.1713425580690; Thu, 18
 Apr 2024 00:33:00 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:40 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/14] net_sched: sch_tfs: implement lockless etf_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, codel_dump() can use READ_ONCE()
annotations.

There is no etf_change() yet, this patch imply aligns
this qdisc with others.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_etf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index 2e4bef713b6abc4aad836bc9248796c20a22e476..c74d778c32a1eda639650df4d1d103c5338f14e6 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -467,15 +467,15 @@ static int etf_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (!nest)
 		goto nla_put_failure;
 
-	opt.delta = q->delta;
-	opt.clockid = q->clockid;
-	if (q->offload)
+	opt.delta = READ_ONCE(q->delta);
+	opt.clockid = READ_ONCE(q->clockid);
+	if (READ_ONCE(q->offload))
 		opt.flags |= TC_ETF_OFFLOAD_ON;
 
-	if (q->deadline_mode)
+	if (READ_ONCE(q->deadline_mode))
 		opt.flags |= TC_ETF_DEADLINE_MODE_ON;
 
-	if (q->skip_sock_check)
+	if (READ_ONCE(q->skip_sock_check))
 		opt.flags |= TC_ETF_SKIP_SOCK_CHECK;
 
 	if (nla_put(skb, TCA_ETF_PARMS, sizeof(opt), &opt))
-- 
2.44.0.683.g7961c838ac-goog


