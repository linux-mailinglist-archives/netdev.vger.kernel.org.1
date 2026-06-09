Return-Path: <netdev+bounces-296811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kdegJkVhJ2opvgIAu9opvQ
	(envelope-from <netdev+bounces-296811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:41:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C7D65B66A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:41:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=WtOZkssl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296811-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296811-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05BD8301FD6A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558624BD03;
	Tue,  9 Jun 2026 00:41:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AB246783
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:41:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965682; cv=none; b=WErClMUBbC7FzHeivM38d/GzTncy9VmT3vRMAUVhci1EEaC3mpp9Yqh2114sW45W9knVQ2DOOUL30uJWKb4UaWPf32V3aV6IPWIjgSvzG6/tXpZu/QVGB/8CIdb1cHgo6EaAgZzTrX5YfuSZoI8Ud+xxj2ZQ4mEGlNEvJrGel2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965682; c=relaxed/simple;
	bh=yMdhseqWo90O722IHDMJjBQLlryLdKcFA01iK/bwCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKx6JfNaBs5dB1Nb69ik6gJNb1+NFJjogqosSRioocrUHs6wocc2HOw+6pyGEx7eBokIyX679V3N39OOtsbutkNbPZ7QWuTW/aMnj/MAokyUznQ9XMMhbdNyXDME3u8AEwtSz7AiVKH1MzNZJLDwDkAIy1M8qjrh/WVBCtrkegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=WtOZkssl; arc=none smtp.client-ip=209.85.222.176
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-915bf8800a2so280991185a.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965680; x=1781570480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkV204jEuhHHv8VYaNEYsfOOb10+5uAkAOmYlY3It30=;
        b=WtOZkssllymybYVhX6DZbIeQAebBIEXGXAIzr0DIogLBvefxsUiW10/7eS/UKvnXdf
         fdTS4Ua04yDjTlcTtsWkv7MDLBhQYxI844lG2WU0dbbxwmc+ha2GOxA9QOlk1UTwtdu+
         ryB+eLIaNYLYzOHcaQRWIvOuvsgYnpPE2tcP3xls8RmJe5WfdqXaE2ykj3OQk1A3cBQ2
         JZNwEciJaX72jaafE9YK31PsNks4HR2p+3a9XcRIt3nLce8tnWRsxh+K4divjymK4us6
         vQtWOSz0K9jWJ3NGF+ELmiAvMVSQUUUXY1aZlP1wzruGT+tvso0Aqngn6l02IcIsLQSX
         u4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965680; x=1781570480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkV204jEuhHHv8VYaNEYsfOOb10+5uAkAOmYlY3It30=;
        b=e0e8I7y5DTcgQ/qDzwvDVz9/weB4kph/zY67aDDeNsor+QsoXp0eyKH8u7JQ4n/9e/
         uoFLGSIhOr+1NJCjsPNJAfZPWeb8HxrW82/dJP4OgCz1wJVg0xDN+090vXJ6Vy6xo3hF
         IogPNvfB6S1jzxoC4FTACFwfVJAfiCSpruIkruaNoQcngzJhUApWVT2emyQS3R54CReG
         ec0/h9au7lfSnSwkGwi+n+ZMXwlCbgGMQZ9XiGsPuriLw6iN68P8pl+AjkSrxF0F3NHz
         /EenuLOIMUbxA9eDT3xwFgV0VT0zejbkKi64zynDzLsNGUfSQKg2HjUP5Bgd6pdSf1De
         quUA==
X-Forwarded-Encrypted: i=1; AFNElJ+EmRYsbEe8LQN/HIUyWy7q9h6guFTFkFF9RaaWItbRgTJHy9ScEw0gG8RJyOsVg5c8rgTMkcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxPsHVDGfW+Z/wfm09Gh32LV21h21WjeKkhq3igJ9aa1b1bPR
	qedaqiYKhC4bGweBmPksIdRPbW4cDZQEBNgoVHYhdfSAX3os9RsoxcfFahsGvRiVIfc=
X-Gm-Gg: Acq92OHfxXqLa8bhbo2E/L0iFPdGiOZBANC8RiyqR2RyKRziCNsttMX9UNurkEJiV5h
	JxzurfG2J4o7CFZ/3MEmTvuWofyplhw6ou8H8sD5JAWmbPx9rodd/v/l0O7K3+kqbaL7leYWF1E
	Lbka+k5rtwejlju/+7jW2L6YaECDfF1TtaDe/nw+7SxQTkyrpXlJgtvXiVTKCffI2poj27d5Y6k
	7W57a1ecog8EiDIueZEtDWtNIwNbdOkZ/esJCRmN7dUIQmvbjFQTib5tWE/eeFWsAIWWB8/BT+e
	G6eI4q0hP3EVAd8yflQTY1q2On8f3ypy7SeBL691bng0/LZZou8GO6AXJ+kOr1JJtIyzSOktbOx
	l4ei+ZkvIKdNy9V3vty2dfU+BmmW/GAaSVD6jimcejiC8RZfvhQwLxN/am8r+ZLhJ2pl/PorfCl
	yjqkKvXSbNeX5n9txIS8EOGwIayG6webqr7npsvA==
X-Received: by 2002:a05:620a:1a1e:b0:915:e932:9f2c with SMTP id af79cd13be357-915e9332007mr22533285a.52.1780965680062;
        Mon, 08 Jun 2026 17:41:20 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a381febsm1869394085a.23.2026.06.08.17.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:41:18 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: fq_pie: enforce memory_limit without wrapped accounting
Date: Tue,  9 Jun 2026 00:40:26 +0000
Message-ID: <20260609004026.1238860.be23a168aecb.fq-pie-memory-limit@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296811-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15C7D65B66A

fq_pie checks memory usage by adding the next packet size to the current
usage before comparing against memory_limit.  That addition can wrap and
make an over-limit enqueue look acceptable.

The scheduler can also fail to enforce memory_limit consistently across
enqueue paths.

Use overflow-safe accounting and reject packets that would exceed
memory_limit.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_fq_pie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 7becbf5362b3..752c1c32913a 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -152,7 +152,8 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	sel_flow = &q->flows[idx];
 	/* Checks whether adding a new packet would exceed memory limit */
 	get_pie_cb(skb)->mem_usage = skb->truesize;
-	memory_limited = q->memory_usage > q->memory_limit + skb->truesize;
+	memory_limited = (u64)q->memory_usage + skb->truesize >
+			 q->memory_limit;
 
 	/* Checks if the qdisc is full */
 	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
@@ -160,6 +161,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		goto out;
 	} else if (unlikely(memory_limited)) {
 		q->overmemory++;
+		goto out;
 	}
 
 	reason = QDISC_DROP_CONGESTED;
-- 
2.43.0


