Return-Path: <netdev+bounces-286482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJeSHOmDAWoFcAEAu9opvQ
	(envelope-from <netdev+bounces-286482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:23:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1258C509122
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11E693004DF9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29CC37C914;
	Mon, 11 May 2026 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX8mJ++t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F58B37A487
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484197; cv=none; b=M/U6t1+QA//L6c2i8+/hIZlJSO7+yOhHeOvP0FqTpUUWlYbzaCSEQ0YP4xwKTGFmGO73i9bnyfHlhEiXnM1/VN7tWQCKbbXTZm+HjZlOxL3jxdUTxHnxau7dTBPmKoB1BTXRSNt3FGl4A7FPsxBN1lF0jvtjLEynLmJAH+P/Tjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484197; c=relaxed/simple;
	bh=QBJ9bAgBdlvl+Y+NPkJIUuN4hkKheOjiuSWIb90iRDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LsqSZEJqtuo8tllpsS3XNfP2fIB9VfEoAK6FvXlMwKFNP7BC6UlE4HBySGertp8cQ2BTH/OJydZXKBNFaJVYu2NZRh5IlDwVW6EZSJzFS/WGaSCtYBYL7Vxay02GI89rNrEtoYf2OGOS/lFUwlY5EQBAciE4j4S19RYXBifJvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SX8mJ++t; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50fbc70cfbdso95939761cf.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778484195; x=1779088995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LgfR7YGNZGuLLZeQ+ZuGIJz/Ma2zGid6K+DTuQe30s=;
        b=SX8mJ++t0922zC8jKWFg3MI7OlUdvdJT36RfwjUK+CXhmrvwRHz2+R3WG1x3OYpbgX
         eATJB5EsyMcHabgFAv40xHrbU+mWrz+2cfVqzEfv5A+kOacHOnoPkxjCodujALNxPQZV
         uFOdxgFs9NKHMB5eoQkp5fkLJaAAQoTQE5N9KdTKQ5wQJKpAUniss5jTXxZu9MrJKn0r
         1VHesl/SFIEhJKVKkwaol26OlJaLyCHif52J4e/IoRyt1727zJMjQbJZym3QBYWag/ON
         TKrFqvDMb4sJKg8qs2MYdjpcM3szR3aoR+wq875H82PEwLX+bOPov8+yA3W/KSszncD2
         OmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778484195; x=1779088995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LgfR7YGNZGuLLZeQ+ZuGIJz/Ma2zGid6K+DTuQe30s=;
        b=cN12fXJEOJFhn3cPlBDorEhBBKoBr71QPDWTczm8lkRom3I1s+njxhwf4VOzcnZdyt
         9dgLBGVMjVtrjD3dGkf3xB8Y4V4RNYpCX+2kIPFcxAcNrDdxRJhAlctlOZyiIRYQG6a0
         olRjMR6A9FLaI5DYNwXKTnbddHmILXvHCJNe26c230ZaljfHn3rv4HfrOch25wcipvVH
         ZcFw59La6waRZ0ugya6MNuHff3ewRrDuGpj7YoYZHuDv/TRj+0z/OvFA1vECu80umNfa
         lVrx/Nlnp41sld0RWVJzj+ACPA1K9O+HDnVt3WvjvBL18tLHrfylz0IqtauecItqGMqN
         uFUg==
X-Forwarded-Encrypted: i=1; AFNElJ+1/CdnazkcPSbIGXI1IF8bcCYBeEeFy4mDN7MHoYZWO+2amNhLHcqQ+YDWrTTM+kYC8DEE40M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdSAnC5m3JuxxQkvvAFN6w5RUFcO8k65iJnaBVT3tQj5x4T09
	jHxEd9t1lOC/7maeiqAKYiak4VUAUJeRIAJ85DjFtn2RFVg6NsAdHNVCcjZXsrLucv78I78lwdN
	PR4jG1WyRtRIubA==
X-Received: from qtwo19.prod.google.com ([2002:a05:622a:93:b0:50f:def9:dd6f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5a09:b0:50f:d54b:34c6 with SMTP id d75a77b69052e-51461be01a0mr325111601cf.12.1778484194959;
 Mon, 11 May 2026 00:23:14 -0700 (PDT)
Date: Mon, 11 May 2026 07:23:09 +0000
In-Reply-To: <20260511072310.1094859-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511072310.1094859-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511072310.1094859-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1258C509122
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286482-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Replace a bare kfree_skb() with a modern sk_skb_reason_drop() call,
and provide IP_OUTNOROUTES drop reason.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/tcp_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d13d49bfef19457cc5902cb556605a80f4c0ab2c..0d5e2b0a3f579a240e3457881bfe6c647cb3d2d9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -982,7 +982,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 		return;
 	}
 
-	kfree_skb(buff);
+	sk_skb_reason_drop(sk, buff, SKB_DROP_REASON_IP_OUTNOROUTES);
 }
 
 static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
-- 
2.54.0.563.g4f69b47b94-goog


