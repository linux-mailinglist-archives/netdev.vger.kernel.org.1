Return-Path: <netdev+bounces-290896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAGoEXSVEGqBZwYAu9opvQ
	(envelope-from <netdev+bounces-290896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:42:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B433C5B86ED
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBA653098508
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A497355F46;
	Fri, 22 May 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ouk9dWhk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F397367297
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471008; cv=none; b=K0SP7fBkI3mq2g6u77NyKXec9ev6Jv8WUZacxzAWanmkFQa2TrTGLXTINIqDxdIxD/oKFJEbW0MFDChyC9B3BVdbnyyl79GhmAtcQMPdgSuBlJ0ahMqqU4JgS8RX2pdIkpD+ixrAVDDz/VVVwsEMNVucB8NtEat0BD+tU/X0FHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471008; c=relaxed/simple;
	bh=JhlU7oXAt7A5ki721SvXwT+Zt8vU2ddRT9hfpe5MU2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r3wELKIgMLQzp5x8rXMOTwMJggFnIxXNgYfX7nM3YEuQ9kwhuWpEzAqHFJ//2G+1dcumulKVaR9L6VjQ9xXoZFqZCPvoC1hXBO+aJ6RqLfcP5aPV4sylXD6vvhJOpWsm5AZ3AThjGmBZ1mlbIXaXO7JM0XUueYzgYwMV54mFel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ouk9dWhk; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8ba8a1f3dd7so153546446d6.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779471006; x=1780075806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjSBhNC0h9wwpHCPED0OGmqhRZBvObIlaVqa9gB8gOI=;
        b=Ouk9dWhk8LmVAOIRPIwV6HfmMBZ8oJZEWjYFwEBMam/JraB/XfKV+eZSx5+DaeKlS0
         mJwa1EZZSeg4sbHTdSBlw3dwAhbcgUM2Y4KpwEhUNR/OAaYxIfUMoGKMk+gkO5/Ph8Mh
         6hNnicNVfiwcuyJQ+O3X1tw5K6wYAdPEha59qfDvf7rz12FPfyOoziwPX2RStqWdDiv5
         2g0KVlAMABsHvYz7yP0Qn/xrERFNiRqUp/5lmmiqwrEn52BiWAWuy9DRxwFiopKNKtv/
         QZiwGRN5FC183EGJU8OYBVFycMgf6FOI0sZwe+M+soWckGAoFlf1cj0+we4BCO4/YKrZ
         rd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471006; x=1780075806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjSBhNC0h9wwpHCPED0OGmqhRZBvObIlaVqa9gB8gOI=;
        b=UTJJPDEQMXk1bDT14MQFsIiT4klxl65lRlNyZREr0KFWNk+TqtP22e1upO1U+KZu+f
         vN/o65xXF5SpvPisV0gyRPRfwg1JUYH1rzMTtCyOiCgKshtfB1lBMIuCRlUnRhwI3zMm
         glY/lLsZZv/Th8vZ9aYUiq22LZURAkcbHGlStLkpvg1RAfz1+P5oepxGvsgvcMhG9/Ip
         rTQ2SiBMDJ+1wWRKvREgyX+Jhfv9L0cfrjdD0ypO3p+j3QjD0tToYNIHI9JTTgu8+Jah
         CxGhJALuSq9Zep8uM5nemWlsk9g63pv84erbkleTTVi9kR5vueIg54/Ym0iSrsXq5e3y
         Va+A==
X-Forwarded-Encrypted: i=1; AFNElJ+jTesV69f1JFsWYoMWLvOuMVo8/MNN5fkFUULSu2rf5CgShlgqxVUo51zAF355yKuAMPZeAQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA38Erk6vLCiwmaMpDR7VnePfDzlFPhjfvOhUVEJlsXKOHHI9c
	w7lifQDEDU8H20k7k/z6gmJptQ0v8OhLEd0+UayXEcg0aLMEZHNcyTAkzdBDIGbTCm8OAGuNs/t
	bKiU6Ua9HAcvexg==
X-Received: from qkgj19.prod.google.com ([2002:ae9:c213:0:b0:90b:7161:3cb8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:28c8:b0:910:896e:dd56 with SMTP id af79cd13be357-914b49ab2b4mr685676585a.51.1779471005831;
 Fri, 22 May 2026 10:30:05 -0700 (PDT)
Date: Fri, 22 May 2026 17:29:58 +0000
In-Reply-To: <20260522173002.2181677-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522173002.2181677-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522173002.2181677-2-edumazet@google.com>
Subject: [PATCH v4 net-next 1/5] rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290896-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.945];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B433C5B86ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid corrupting a netlink message and confuse user space in the
very unlikely case rtnl_fill_prop_list was able to produce a very big
nested element.

This is extremely unlikely, because rtnl_prop_list_size()
provisions nla_total_size(ALTIFNAMSIZ) per altname.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3d40ebe035b37ae0f38fb81f918eb76742371ef1..3dfa28927c7f92f906a0d89b7a1812b975d13854 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1971,12 +1971,14 @@ static int rtnl_fill_prop_list(struct sk_buff *skb,
 	if (ret <= 0)
 		goto nest_cancel;
 
-	nla_nest_end(skb, prop_list);
+	if (nla_nest_end_safe(skb, prop_list) < 0)
+		goto nest_cancel;
+
 	return 0;
 
 nest_cancel:
 	nla_nest_cancel(skb, prop_list);
-	return ret;
+	return -EMSGSIZE;
 }
 
 static int rtnl_fill_proto_down(struct sk_buff *skb,
-- 
2.54.0.746.g67dd491aae-goog


