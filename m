Return-Path: <netdev+bounces-296546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qh2TIRLAJmo3cQIAu9opvQ
	(envelope-from <netdev+bounces-296546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:13:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 042916567D6
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:13:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iOFsLPl+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296546-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296546-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBE6B30298BA
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C5C2F5A13;
	Mon,  8 Jun 2026 13:08:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629B2BE621
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:08:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924119; cv=none; b=Hht4fO2gBkikrxxcKgCoRrK6s7RtTvVwZRm8tfb0xv7tHURfQk/ZdAEJXrjmH1PZvbLfJGR/Swrj6B6lEkt0t4YmyKgXLtIFstDpToS0E262ysINWsaSrSSHTgYcGzkS1UrVqTV5UbHn99pR6fzsXjfkBUplaOe5ZmUm3epYEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924119; c=relaxed/simple;
	bh=/WviZK7HebsWE5B4z3ncmXj2PIIbtnHX7PDp7y5qc3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQ45C8DDcdG/L3Fuf7DdnGphNVMg85d2YMJ9l9hVdaOicIMqw4wDUPnulZQrNERPvIID2LlQEZlqnYGcA8LGrpU0YSvPZOphwKT09NK0joiX0ec6XFTtp5RCAl8tuv0Pbb7J6fw5O8PCnEcyWIWNHmBMkUK1b4VjDAYhNTa3XtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOFsLPl+; arc=none smtp.client-ip=209.85.128.66
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490c28f84fdso6707035e9.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924116; x=1781528916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb/A4+uQP0Fl0PAz7enDUsv+XlOuVlZvi6kQXmgrc4c=;
        b=iOFsLPl+mIlzdXMQB3KyiEdIrGZ0dWFPUN5YyqhrFUQjnKJaXA8Qxx+d+ACcP8XftH
         DVg/k2Fdp/atAPu2JrgmlzrwqFzNGAdeYFKru53tma96/uZI/KxemeTTwPkJV9oCJfRi
         f2ojIzkGcsLy8NO5GobpphQs40hl+zO02yN4OskO6PxWINilHAahvi+rWzoqSDsBMJZc
         Qlg13jOjLDt0mcuJJCVQo8krp1EpefEindBYlAnSyGH3a31WmXQAUIudTqYKsTR4QhjK
         tcLYYX//82eTsRyJ0aIWL8JrOF4zPtRwygRtFPDgcJTSp5brLhrbE3QryuR5vbQ1hbUL
         heqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924116; x=1781528916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xb/A4+uQP0Fl0PAz7enDUsv+XlOuVlZvi6kQXmgrc4c=;
        b=KQxdy0XQYx7p7or5UirS5L2lzX9EE4BpOG9YPIhxJ7oLNEpsE8Wl40W/DcfIOWRo+m
         7scB33gbMNDhOzSJ/mMtsIijGzY+3abqiPnMG5n5+yCO9vTb/JgqZKEKBX+bTIubp9z9
         vIVAEn4f3nYD6JRpigrv2na8MPkwktPZMKaPpQNSVk+gk1K9pv3sn1QswZVij5fZG66U
         PXi/0b/eNnrt8rHQx+AGTOOKYuHIa17A0VXvlM2dWVrN4s+LFnsJdRtdC+d14V7Sa70/
         lzsX/21ZGJUylw9D/InqxtCGQjluMDf84geyBWaTdS37Uo+lu+S/+Lfe+GOVPRRKxIva
         47cA==
X-Gm-Message-State: AOJu0Yz1q29DsHG7H1Hl9NEfEJfjN7wdqucpZkrAeO6R+4PQdSfkLIp0
	Bt5O/nvUdpPSTrMsi6BDCc8wOWrrHpHRiTOd83d9ivL02Z7UHvh59nS2bP8kNLsN
X-Gm-Gg: Acq92OEfPe/BV6twjV3Rrw5Pl+NhIJYBmjUSaWEiGcR9h6U5IkIuQp9+hlbFhoyC0Bk
	9kiHiAj95K1+u+/D46q8B7C/BCjTg4pRdhTaS7pUQ58REO7aL39I12HSw2hU9fvn4791jymuWYh
	UzO5GsRyGGQxO1KZ8Y+rXfrLjhGnMwJvZRbDxlWZXEdyxASgkBKlB78D9m4bPr8zH1w5Y6wuhfc
	DiL32WNVMQdZj+lZh6SMMW8jTuTKQERDiFy0w3ccTF7XdPQCzhC0I+GTSqesqGBN1dcnccDIVht
	QHvWxpp75c4Wljr7JGjHH9bFyV+2KyeYHZd08F9Gp//dpyiiqvR2wCfZ772oYMobBNM0PINqXAE
	F/nMKbRrogu+HBB9D0Xi5QM3oZRS9E5mIc/m7yedciMYqBNzG9pA//guE9AbY26OVo0no8vA5vm
	HSk27rKdJgJGpzqBKiQ74axHA2Qs149N4=
X-Received: by 2002:a05:600c:8208:b0:490:b2b2:87d2 with SMTP id 5b1f17b1804b1-490c25ed6camr101389755e9.5.1780924116161;
        Mon, 08 Jun 2026 06:08:36 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:08:35 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 01/10] ipv6: do not fragment packets into jumbograms
Date: Mon,  8 Jun 2026 15:07:46 +0200
Message-ID: <20260608130755.5626-2-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296546-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 042916567D6

This patch prevents packets from being fragmented into jumbograms by
capping the effective MTU to IP6_MAX_MTU in ip6_fragment, as RFC2675
prohibits a Jumbo Payload option from being carried in a packet that
carries a fragment header.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 net/ipv6/ip6_output.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index c14adcdd4396..67c34fb281c6 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -935,6 +935,8 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	}
 	if (mtu < hlen + sizeof(struct frag_hdr) + 8)
 		goto fail_toobig;
+	else if (unlikely(mtu > IP6_MAX_MTU))
+		mtu = IP6_MAX_MTU;
 	mtu -= hlen + sizeof(struct frag_hdr);
 
 	frag_id = ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
-- 
2.47.3


