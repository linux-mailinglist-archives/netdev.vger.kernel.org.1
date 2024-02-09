Return-Path: <netdev+bounces-70560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3207684F898
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C806D1F2213F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4199274E04;
	Fri,  9 Feb 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tI2QVOqM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11FE73174
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492669; cv=none; b=cPyX1di405SYv1IrFlDCXaLoZblMs7lq6dhicsule7zC75uXJGNuchKrYCGAUl9IY1SmEXRHJ71qUgHVxWheg8fuWyAHNxG6i1TB2WdHVja9PYCq8BcEAr3hEMx9Ijg0ReDu3FFPRSN2M8lshl2FIEMCGtAehNdp5Ec8UqVswEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492669; c=relaxed/simple;
	bh=KhuaQg/EfzRk9IdLGNKuwEE2PyXKI+D71irf8749zKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZiUCODoQ512gOjVPSIvXB93M5nU2g4yNsoDkoaS86oP4HbtaqChwOGs+IV+En3SFLNiab6zZVWtAF+zCCTnMRUjGNhsoY6qiXb4Uz/T/QPZPeogT69sv/qX0O+i7+jV7SElMIigNaosUnhVCJbeS+xo3Fe+EyObXeDlb1PypSRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tI2QVOqM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc75b9611d8so11379276.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 07:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707492666; x=1708097466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7oR5cghLYyVbVLhftgeLvAKgDRcJCcfXBzyPHMi8bBQ=;
        b=tI2QVOqMLKwTi2BakEjpnCGjVxidLhbTbUMJFx14Tmu6zHXd4MUMa3oNefzf/R+SaD
         xrVe0eDH4WxtAT28aK3iaQuHY4sI3s5wNkNyzbUJRdi6++8xxkOxvdAjJaN/W0FAvIyj
         yaQSm+p3ikwe5AfQH+8wFBM07TvdlZq4OhtongrgwFyZuaIaChSbCdMIdrNot0kyUzlS
         j02WI9E4oXJfB4vyQ86TW8z445GmBMlwetTq6SaEtboLjbumvvCjFtiUtmkpKzFPF7nW
         bHlTyzh91Xe1F3RNmGlcN5md7eb7jfeqz/XwZyadnIAcqdKLxNBxWScEu9hlGHefAlWN
         wF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492666; x=1708097466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oR5cghLYyVbVLhftgeLvAKgDRcJCcfXBzyPHMi8bBQ=;
        b=iSCZZ55qPw0IC/jZzV/5X2KeaJbWeUAuECPdpXhTq/HybXhjiUetknQN/3SQiY32yp
         Us5rYwATGScSR4DgdL+8FZlV/1rYYc62iho1v3KabeTbJWmeO/8ZYmD4yl9i8CoaANZz
         Eb7XIr5ezCb0PWaXUuY6Rl3w+rLLjgTkOL7wk7W/swwyKSeWu0e4LLhPSxqwvopBc/Hd
         qZzzDIVQqye3o1FJnVeqEZ3mIQoDdnH1rYRCQQfei9KHn8ThC6yhB3Qix0tBfYmtdVQN
         SkMIQ1K544XlpdD/LVJsdTttmlyeO8WZIUQYbePTMZ7FCc+EmQgSDDml0KfOhApNIi9L
         Z34Q==
X-Gm-Message-State: AOJu0Yy2qUTdmIU/546OKNe+6Y7CjbgSfIjYdBAmoGKoT3VWJWf6tod9
	Ii7/lLTzLaPPwg4UkQCaWjzWt072lvGCQLeB6MKjVuNkT2ujVY98JAIYolfSu+pWUdnyQ3g6XC8
	oU4lxN0MYeg==
X-Google-Smtp-Source: AGHT+IGNo9aB77VJex1aNZEXCYn7qZ9vkieGSAyg4i59y4WZJaIkSxbCoKvK7IRXNN0N2faFozJ+YBfJ5nCnQA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b20e:0:b0:dc2:26f6:fbc8 with SMTP id
 i14-20020a25b20e000000b00dc226f6fbc8mr47979ybj.7.1707492666720; Fri, 09 Feb
 2024 07:31:06 -0800 (PST)
Date: Fri,  9 Feb 2024 15:30:56 +0000
In-Reply-To: <20240209153101.3824155-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209153101.3824155-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209153101.3824155-2-edumazet@google.com>
Subject: [PATCH net-next 1/6] ipv6: mcast: remove one synchronize_net()
 barrier in ipv6_mc_down()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Taehee Yoo <ap420073@gmail.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"

As discussed in the past (commit 2d3916f31891 ("ipv6: fix skb drops
in igmp6_event_query() and igmp6_event_report()")) I think the
synchronize_net() call in ipv6_mc_down() is not needed.

Under load, synchronize_net() can last between 200 usec and 5 ms.

KASAN seems to agree as well.

Fixes: f185de28d9ae ("mld: add new workqueues for process mld events")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David Ahern <dsahern@kernel.org>
---
 net/ipv6/mcast.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index bc6e0a0bad3c12d641a1dc60a8c790a6e72b1b5f..76ee1615ff2a07e1dd496aada377a7feb4703e8c 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2719,7 +2719,6 @@ void ipv6_mc_down(struct inet6_dev *idev)
 	/* Should stop work after group drop. or we will
 	 * start work again in mld_ifc_event()
 	 */
-	synchronize_net();
 	mld_query_stop_work(idev);
 	mld_report_stop_work(idev);
 
-- 
2.43.0.687.g38aa6559b0-goog


