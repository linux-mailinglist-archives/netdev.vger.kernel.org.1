Return-Path: <netdev+bounces-289593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLeEAeq6DGrdlQUAu9opvQ
	(envelope-from <netdev+bounces-289593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06047584354
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56CC83028544
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3EE37C10D;
	Tue, 19 May 2026 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2DHrry2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D736BCC4
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219171; cv=none; b=jA8wOLcyaJH7EvPnII+cf5yOwraMYQs2DyRlJgSeg1TflE+EcOXFF672X2ZhMXcxIytoXkFOVYmMglPv3iLMc5FLgCefT11VOZ0Q3GiLqL9TTnD9cRpZAbj8Yic6kcPXSQvSFY3T/mBQMzVYadKX1746T1CdbI1bz/GfpgfPZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219171; c=relaxed/simple;
	bh=yh8uVRe3irnDfvAe8yiKkx1FeVL6MCeb1DtVxRrD4Q8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pzUN5e/VpAppNU/3/7dJ/tbpztF9np9ACCrH74zmhQlXUpjzRxz+95udWdGYi+P7MJGDpE9T89PGlr5QprTW5o+Aib+tY6pzjN4Qscqy0LHgAN1UPlxCYlL0q8qxZVf/NkVPDgEVkOSNe8RIxNE99dG2lSuC9Fu9Yb7FQrKQ8F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2DHrry2; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d8e8c47a3so115732121cf.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779219169; x=1779823969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qq/3S0ROoAjSh/H+7x7/BryAkm27kFjyQqhQYJPnXJ0=;
        b=l2DHrry2IK5T0rBqo/moQXoGRZh94++I+qpn9y19kghSDzv+G2n5ozviiSr4JOzGgO
         iAUI4VTZYaOyGioloPb9Gt5l+xb76n8U2NWa2jpMG4E7MfTWJQJjf9PDYtgwOYhQqtUA
         ac8HvBgfEXnnIc5Vfqt0nId3HE5fnsWxUljIAHQ3LiFfotTQgzb2n8y/3fCX5zv2mxKj
         gJf6D8kWlfq02zhW9iP5kyqxGimkRcrOpvaqwHsh2+iqXUsZaJTurJIQHy8CJWN0mc2/
         mPwVK6+cErLeIjHFuwwCWFwYKznYWftFDp9C4P4DLWUZYnYfQmWKQn6AN6mlp+fs0ow8
         7JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219169; x=1779823969;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qq/3S0ROoAjSh/H+7x7/BryAkm27kFjyQqhQYJPnXJ0=;
        b=pumEDkZVi4ZkmixnJTWIjJOc0fSmKbZO6TldWJU/CeAfQFgp1en7ukyG7ZVTDmC4ng
         wSTHLx5/w875qcwHhauFLq1eZi6GRBDq596CcGWPkdkMJ6qHEqMsAGWfiWn4RTti1mAS
         8iu8XOcteQlXvd46tPLDodI3zRa/xV3dQet/wv+Hsm9+34VrIWp/0AxaEiu1886bxwbT
         KsAxwpCl217BZRUgUZMKBCIuFaSgAhlLCxeXCmpGDnePvGRA+aU55xJj4hUb4b5AONGC
         xTFLHbTUQFv14uW+yQGERhsvbdmYw5nin6GhokswQ8FhBoJ2DwvzaW1044J7s0hBA7DA
         M3+w==
X-Forwarded-Encrypted: i=1; AFNElJ/Fy084LdUpqevzUSv46o+T5nImeBMWqEZLpdd//Kvb8dkkKEO2AntJBdFDtmC1rlWbOd3QxG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPcdo2opU7YSNP5m++rlYdddP6g0Gc5NE8WGdZJG2OkXqcOsg
	mPlFmlISZrnAUV9Sd2tsXuV1QhOc7S4uC4NO8CLHIcUQWGaif8cwqEV4zfsR7AR+KJFW2LqdoS/
	iPkZLwRb91C6Y/g==
X-Received: from qtmr15.prod.google.com ([2002:ac8:424f:0:b0:514:d761:2649])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a04:0:b0:50f:e0c0:9d92 with SMTP id d75a77b69052e-5165a26bab0mr285873751cf.54.1779219169182;
 Tue, 19 May 2026 12:32:49 -0700 (PDT)
Date: Tue, 19 May 2026 19:32:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519193248.4018872-1-edumazet@google.com>
Subject: [PATCH net] ipv4: use WARN_ON_ONCE() in ip_rt_bug()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289593-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 06047584354
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It turns out ip_rt_bug() can be called more than expected.

syzbot will still panic (because of panic_on_warn=1), but non debug
kernels will no longer die while repeating stack traces on the console.

Fixes: c378a9c019cf ("ipv4: Give backtrace in ip_rt_bug().")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index bc1296f0ea69b0705e00e547a0d550129e03326a..3d62d45d84bda986db8b3592c0c7f5c81da3fb7e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1272,7 +1272,7 @@ static int ip_rt_bug(struct net *net, struct sock *sk, struct sk_buff *skb)
 		 __func__, &ip_hdr(skb)->saddr, &ip_hdr(skb)->daddr,
 		 skb->dev ? skb->dev->name : "?");
 	kfree_skb(skb);
-	WARN_ON(1);
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
-- 
2.54.0.631.ge1b05301d1-goog


