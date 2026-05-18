Return-Path: <netdev+bounces-288979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I0iAuDjCmpr9AQAu9opvQ
	(envelope-from <netdev+bounces-288979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:03:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13B56A45F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3F1D30158BF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D233246FE;
	Mon, 18 May 2026 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1N8W0YJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C73E6397
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098502; cv=none; b=smfmeSW641L2L9bfq2OBEByGqCNjxgVjyWazkO2UMyOXgRbbHYTTvOF+85Qn/iNPi0RPZDmX/Y/8UenaYVxR9OVKo0kL9Z+v80j53V2Jk+++FSAN7Zb2u3EhcCBODoOKXRgXLZwHEXU+2BE+Xix4PvpKufBFO1dbcsGujQd0Ylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098502; c=relaxed/simple;
	bh=c/trwgziv1vz2AwyOeXMFX4AVndsk0kHdmZmLkXT20s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p9rDcKbBJdKCi3cSoWxPSRc/hCe/qQbWVAZbgrZnIkYlsWToZTZHY6tnpktDU0aMIZpkO6/xyu1Bcpk8LA+6JUa03o/9aYx8iI7kB8yMCIeBpW57ORMyuGldABbH54mvV9soRQU7ToEeRWdZ8ZtaOzTtlSViaEWEGxZCJ4zguDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1N8W0YJ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5104b861649so97733511cf.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779098498; x=1779703298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QkPgyF49xu09RNO4wUWq+KVBfoZAcFGIUSSqnIfmUw=;
        b=M1N8W0YJ+WCOmmmDTl8ATPo+hRjX2/jcgZ+9JKCGmsV+l/T6f5YPaLk6bX6KfLomHH
         /ZtUL+T2faQuPcROlP+Nf0I5F5Drq34gINKjCxQT5LfjD0svuvljJSoast591L1IYiHu
         qz4+xnWYUzZ58kqyRlpZMdxqy80pPp0pDspAbji2CoAWX1p6bFJaISEoqor0q1PeIv+o
         4Ca+DumibXOK3Ra+lARqkyJ+h32S8TU5AHGP1XWIqmpr4MDuQJb/UhdKPEtfB5ClsR3v
         tkB1AM71Z7J/DRkzTTk0K4eli0UV49+XqpTPUVI5q/ALGWGmL0WBXG91VcZT7KRDXUyh
         Cb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098498; x=1779703298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QkPgyF49xu09RNO4wUWq+KVBfoZAcFGIUSSqnIfmUw=;
        b=TrVfFdcHIEdAltSgQnoLoqNQVn8GRjIaVwbZA3ZfhWdNLVMuYQhNLUMT3FRehranA2
         AbPYAYzhOgnEAILRUYvZ81QKg+J/A3CvTxlrjJ/RqKLnaIYZHuaFJgDfV9WI1GgPugdP
         +M3Ap+LLcEWaAerpkegmOZ1RQOpdMGMOrSFvOVWJfWfbNvkXxlcmvAMVmAPBjeKui5e9
         mTGZlCbZ/e+Ei6IAdjcAhJWoD61BOlK0G/0vjc9eduP54q6esSMbP4XOm+YXZmcMJTEj
         /+EDIP50cKRuxmhYntJXiMjmyNds1qNzLIQWSww7RyaoGRrVG4UgudbWOWq3XASUjHYp
         2O0g==
X-Forwarded-Encrypted: i=1; AFNElJ8zDopRxIZFvF8AfrSybpuW9Rp/SKnZt0LWMKL2UmIT2cT9MeuHvu1dmjfSVOX1uVVp7PWcX3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzttxZIaL13MmYDcoB2P7dpIkDqXXEhCiBEdpvUuuoUVJUnUczX
	FxMIYrwGjaXdtU/d9vZMS1p/IAaWYBW9t6nIQXBQR6JneYTsoMOJ7LbkPZ/RjBDAmJ7CEUYInY9
	AdvNHq9qRL4rRPw==
X-Received: from qtax17.prod.google.com ([2002:ac8:5f11:0:b0:50f:cb2f:fcc9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1e89:b0:509:30b0:8323 with SMTP id d75a77b69052e-5165a0a4269mr202342541cf.31.1779098497641;
 Mon, 18 May 2026 03:01:37 -0700 (PDT)
Date: Mon, 18 May 2026 10:01:33 +0000
In-Reply-To: <20260518100134.809042-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518100134.809042-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518100134.809042-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9A13B56A45F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288979-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Avoid corrupting a netlink message and confuse user space in the
unlikely case rtnl_fill_prop_list was able to produce a very big
nested element.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6a5e9ace55a0880d7b1e4303d12dc0a8b8b7c5ed..ae0254f19178735b2805a8189e81a960a49b2858 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1971,7 +1971,9 @@ static int rtnl_fill_prop_list(struct sk_buff *skb,
 	if (ret <= 0)
 		goto nest_cancel;
 
-	nla_nest_end(skb, prop_list);
+	if (nla_nest_end_safe(skb, prop_list) < 0)
+		goto nest_cancel;
+
 	return 0;
 
 nest_cancel:
-- 
2.54.0.563.g4f69b47b94-goog


