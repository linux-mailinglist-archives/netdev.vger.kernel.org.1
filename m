Return-Path: <netdev+bounces-70565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0D84F89D
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1685B1C20E4C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246BA76045;
	Fri,  9 Feb 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FuuT5Hn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12E76058
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492678; cv=none; b=tPAXUTTZA6VjYXBbagvWK9e9zTwVJ0/kuW5olNhUakPkiDZ1DEY5KEzW6eVf5MGDtp8gYqRxPCB3nlF8mOW9KEroMuwVrT8mQFAT8dctQkWON7DgBpMEKGcmEuHxLVn3BpNZomco7VbzDvFPCF+41b611n7I3eocz7zLAQhO06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492678; c=relaxed/simple;
	bh=iI2q80cb/UBk0hyPN2rJWE2Bam3w1GLI1L6lEk/Kn/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqTWyxzU84e9c74EwIjh5ESMehM6cKjD0cLLYGMiQts+HhqGmfG4zUot5R1LDOayB0NtJEtgKNo9F7zsGTBuRuLOHOjGSZUEja3MuffUXC5jQNte05XspWzwCZs3C3aOkTyxAG47ZsuM0lb13Dlo5hRre3c96y+b5sWMM+T4ASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FuuT5Hn; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7857b57b21fso111848285a.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 07:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707492675; x=1708097475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6wZ5ayvtUB7kLpZdZm7Rb/qrdH5LblyO/CVz/oOAt5I=;
        b=2FuuT5HnyLCMBGbWBg914xYS3Xn3PEKDj22QkBN4ZFr+ywBd/IL5KFafiZxwVW01cL
         fAHjubRk84eDceZSvqgLQEv8VFlONArVQ+89XrEpxB/d8/Z1u/a/qt2OOXH3WlojSSBG
         MNDB2DX2LOd6cydIJy+BA5cNs7tQx4ATU8tp6SxB5HNguCpmh4X1cVG8Ir/4VzWXVWuO
         iJpMmM+4kkSqhJHOcBFBQCpFGEL19/KXOwNSf4TpjGxnj4Nwm8sr62cGtbnKmfAU7pOH
         Y+JdoQZJk3pgQHhU11Y5aPdc77icDDo/NHC0Fw6vIpOdnTS5VOygS85v8DyiYlBjEsy2
         eIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492675; x=1708097475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wZ5ayvtUB7kLpZdZm7Rb/qrdH5LblyO/CVz/oOAt5I=;
        b=Vhkv2dL62i7mW+Vd7dYrsZhancziA1gUJQOX1PvCXE+ECKe8qDMPusxlZfcA87jnT+
         +KU3jyBg5XdCF1Bc/MgAK5tIyRe+miIU+/LaNG6XB2hJjmC6uiwaYFrcKN2GnFt1A6QD
         OnT4l5oFVYpdMyMVIxfFkgxwEz0pr2UT+reOeRNawrAh75MmgiPnWIg2R8xet/Xv5YW6
         tly7xDDcUjkUZnThL2sQRr6JqZ9H0Rx0ZfLCaShX5GeEjDHW3cV1OBxES7P5ZS1BBXsN
         o6AzZBiXTk+ts8WaM8stPdTpEPqntD4KqTUIli3JT8XK3ynwqqEskyJHRduBjllhqmd5
         Jzcg==
X-Forwarded-Encrypted: i=1; AJvYcCUjhDpdgwdg9bi4LlvHE3RHtbxRSyR0W0HhhpcEsJMaGZ4csAuoxZsbICpDnKbiX0NjNxkZAR5wXibSUOtvj5me9zR7M8du
X-Gm-Message-State: AOJu0YwebnwX+jOcohBuVh6TVpHznTje/ceUxwp4Dr+91j1CEym05vNu
	Wab2YHpFdGdvkP9rz7hJPeAdk62yqzCaS9trJ7lp1pGfC/IkJ/RY2T0E/T6leBHczsOG7SwQ1ai
	U+HTCvdb99A==
X-Google-Smtp-Source: AGHT+IEl+vGRw7vnx7AYirz0rYMAHVra0xUsLzOAmG6DBf4S37BFAo9UakAtHrvSyok+8sOfRlwLfTQqy7h4Uw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:553:b0:42c:31e1:370f with SMTP
 id m19-20020a05622a055300b0042c31e1370fmr11179qtx.4.1707492675272; Fri, 09
 Feb 2024 07:31:15 -0800 (PST)
Date: Fri,  9 Feb 2024 15:31:01 +0000
In-Reply-To: <20240209153101.3824155-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209153101.3824155-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209153101.3824155-7-edumazet@google.com>
Subject: [PATCH net-next 6/6] netfilter: conntrack: expedite rcu in nf_conntrack_cleanup_net_list
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jozsef Kadlecsik <kadlec@netfilter.org>
Content-Type: text/plain; charset="UTF-8"

nf_conntrack_cleanup_net_list() is calling synchronize_net()
while RTNL is not held. This effectively calls synchronize_rcu().

synchronize_rcu() is much slower than synchronize_rcu_expedited(),
and cleanup_net() is currently single threaded. In many workloads
we want cleanup_net() to be faster, in order to free memory and various
sysfs and procfs entries as fast as possible.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 2e5f3864d353a39cfde138b725e790d7290b82c9..90e6bd2c30002cbf45f417f014e8493c8d24984b 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2530,7 +2530,7 @@ void nf_conntrack_cleanup_net_list(struct list_head *net_exit_list)
 	 *  netfilter framework.  Roll on, two-stage module
 	 *  delete...
 	 */
-	synchronize_net();
+	synchronize_rcu_expedited();
 i_see_dead_people:
 	busy = 0;
 	list_for_each_entry(net, net_exit_list, exit_list) {
-- 
2.43.0.687.g38aa6559b0-goog


