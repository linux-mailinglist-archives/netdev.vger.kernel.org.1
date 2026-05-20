Return-Path: <netdev+bounces-289939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBCZKbusDWqP1QUAu9opvQ
	(envelope-from <netdev+bounces-289939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:44:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B62EF58E0E0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A9BB300BD7D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE23DDDBC;
	Wed, 20 May 2026 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJuCyU09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BED3DA5B5
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281077; cv=none; b=Fva6NFebASwn1gp+YmGh5gdEAPYfXjXjX34qURwF7Kwrb/wRxqDs+agXH+t2rpXgFhgb/uXUAjOxF3Htd/G2o/7DAtXOBtUuV7J/vvaeOCI+//Syj/zmVrQ8YvHMde2etGWQICyATKyKJEOGoave7vcxpuCK2fhr8vehdKpoh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281077; c=relaxed/simple;
	bh=thxoksPQ+15g5hS+3SczibJzhdj7OfrhTFsfdTgiklA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RlCH5CXXSzguCSWCOmAOU0kvgUW9KlLYMzXam8rjo0Oh+Jpnl4Y20h3udkjDuCa12S+bBLe7NZe95ZWqFNmJs/90FHeKrBqubXMmu6Bxh5AywSW2wIyd88MSe+AqmKo7xqPSS+tf3XV/BbPOQfqa48QUYhFMkTTQ5qnRN2XpKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJuCyU09; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ad135063so38959295e9.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779281071; x=1779885871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5eLz8Qn47d0khh31ps9ZsK9pvOA5rKAX3QPAASD/ZA=;
        b=JJuCyU09+0cIJBznTa1ERor6YqcU/jATezzLfr1erIFuYbTY4n7xZaerP7nIhQ7xYx
         X5z7OTZuELOvRyddfzQ1cocE40Htwi81xU+QOKRVAfywKCT6apzHn9FkZeEEgbtt1jFg
         l3fr3AXdUl+aoasL7Ax9u7MFhfDf/cKlCs5xsCRHLhIT2j4tKpe3vCm2b7+kqNMiG1nl
         dbQw0eH+biiJlx4uyaL6x+1h0GdEGuZ8LtTTdGKDuneY++YtYjGJa5qW7sHr8Ql76Qoj
         9X1DWJwwzAzQo0OO4v/0vbsOy0L/0s2hQ2CJN+DHDAQeYb2OWlWl6l+RJBgCHvJqelrE
         R7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779281071; x=1779885871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5eLz8Qn47d0khh31ps9ZsK9pvOA5rKAX3QPAASD/ZA=;
        b=Gy0ibLERbhyLq5vylpPAN0mCq7jMXdwA/s6YvqAaNj1BMgkILD9vvMdw50BMHczrnt
         13g0l3Hku3++I40GK6041GItL+0KNvseP2t7bkblzAv58XyldupR2Z3tgIsPo/tVEZMQ
         pICs2lBnp0kYw0TPytoa05KaJwk9J0STZuRwV8T6BemypO+aAAVifl9QKzqjk0lQ52/V
         +XL4V/EAJnDwI+h72wmUetW60NrjIYFddDItVcfUsECpbfOGqghMqvRu8dDVelFb4PJP
         d8PC1Tbd2Mhj1+zIdScmfrjYsyDyM0nIG9Cd9BiKlgWDZunoX+eSuY1AGTSq9di1JtzG
         HvCw==
X-Gm-Message-State: AOJu0Yw8pgaVzoUO2aUg4cVFI0GH+p8d8+J9svZ4EuWNWQMqXK5APjHi
	yNJWNB787OuDqT8/PLPSmohFZ6v8RbcGwrm434Ox6SyItHFrB/APENyErABOO95h
X-Gm-Gg: Acq92OHTCdINLsIwbSSgV+2KOUFZfvvSa34ub/ZGhN54Sc6cKs8WTUCmBdnKuchCaSj
	h4JFjglDLV2zhiBeVQxRr7Yyve5g8vpdP9zb+ihopgDup/Q4x03rq6PFSEoU6747cNTFHiDzIve
	ehi0xs3md3ZXQCdWJEAImQz/mD1g4oZh01w2tg+koOslLcFmRVHz161V5OhCnC0vNo+mlBGIJ++
	XvrDX4ldpiSp45HnMcB0k62bH/DMui1zWtuOAqe4FQsnFsFqza32VDaocNK3FR7T+AtDAYz4CjT
	/CH1ViuvNt1vLkX8sUS5SXTUJL0gIswlobeBx/RLRcmWqojhJp+mS/UIdYWvyelQdP2cglHb+DF
	DbWCJRYJPzqRDo2zf4HQHTeSqcTKZ0Z/hQ+5IDldMHd1c2M7+RWjgyQMRhSHQ9pA3MNKRQUtE1/
	p8XBi4iRVmLAItE1KSi0BCni9hsHyIWo61jm0H
X-Received: by 2002:a05:600c:1709:b0:490:327a:1b47 with SMTP id 5b1f17b1804b1-490327a1b5dmr7754165e9.8.1779281070939;
        Wed, 20 May 2026 05:44:30 -0700 (PDT)
Received: from localhost.localdomain ([31.4.38.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm387739955e9.4.2026.05.20.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:44:30 -0700 (PDT)
From: Justin Iurman <justin.iurman@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	justin.iurman@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] ipv6: ioam: refresh hdr pointer before ioam6_event()
Date: Wed, 20 May 2026 14:42:42 +0200
Message-Id: <20260520124242.32320-1-justin.iurman@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289939-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B62EF58E0E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reported by Sashiko:

In ipv6_hop_ioam(), the hdr pointer is initialized to point into the
skb's linear data buffer. Later, the code calls skb_ensure_writable(),
which might reallocate the buffer:

	if (skb_ensure_writable(skb, optoff + 2 + hdr->opt_len))
		goto drop;

	/* Trace pointer may have changed */
	trace = (struct ioam6_trace_hdr *)(skb_network_header(skb)
					   + optoff + sizeof(*hdr));

	ioam6_fill_trace_data(skb, ns, trace, true);

	ioam6_event(IOAM6_EVENT_TRACE, dev_net(skb->dev),
		    GFP_ATOMIC, (void *)trace, hdr->opt_len - 2);

If the skb is cloned or lacks sufficient linear headroom,
skb_ensure_writable() will invoke pskb_expand_head(), which reallocates
the skb's data buffer and frees the old one, invalidating pointers to
it. While the code recalculates the trace pointer immediately after the
call to skb_ensure_writable(), it fails to recalculate the hdr pointer.

This patch fixes the above by recalculating the hdr pointer before
passing hdr->opt_len to ioam6_event(), so that we avoid any UaF.

Fixes: f655c78d6225 ("net: exthdrs: ioam6: send trace event")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/exthdrs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 47c5502a34a2..2f991c974395 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -967,8 +967,8 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 			goto drop;
 
 		/* Trace pointer may have changed */
-		trace = (struct ioam6_trace_hdr *)(skb_network_header(skb)
-						   + optoff + sizeof(*hdr));
+		hdr = (struct ioam6_hdr *)(skb_network_header(skb) + optoff);
+		trace = (struct ioam6_trace_hdr *)((u8 *)hdr + sizeof(*hdr));
 
 		ioam6_fill_trace_data(skb, ns, trace, true);
 
-- 
2.34.1


