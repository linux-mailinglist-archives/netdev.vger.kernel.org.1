Return-Path: <netdev+bounces-256117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBg+ELp8gWnBGgMAu9opvQ
	(envelope-from <netdev+bounces-256117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 05:42:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC8D4746
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 05:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2922C300C0F0
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 04:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D39D2264AD;
	Tue,  3 Feb 2026 04:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i34KO3ws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528021146C
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 04:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770093751; cv=none; b=NYJYtbirxer6wt5w+EEqlZhdUVa28Gv/noCRlbddRdFWvSkZjBNRnPmiykrEOAdt2YutzxoErzJnBthevtUaAs5qZ7TFgTpURPl7qB1fp+A/ARvsREJVM3DtrCYK7BgR8qTVvF1Jsd3Sb/aOs5eIT7NfjHdOgpGlkNDE9qifF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770093751; c=relaxed/simple;
	bh=/6GmYKxzVRUMSFcX4ICH3kSAIPIudyEiuVBD4LlEgPE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U/xsG7h8qDvgbbcsW633Ruo2FYyPvezs7lK5Dd+JfyhW3uy3qnlO01DNBs1zd602HGTW99sMkMsigAGTVHfVrj4uueT9caRZOvIVot+3bJd+xOVBe0MwKA3WL6ZOUUcFtMzp4q0RO31GJnty3N9lWy1Ws8hI77CXHM5AM7/buu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i34KO3ws; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64946b300a3so6641728d50.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 20:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770093749; x=1770698549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/6uVBoE73O8biFQak4QCZgMI1X5F9GhH0vfg6IZTeIw=;
        b=i34KO3wsx2Oqeq5g7Rg9ARt/+okEDGhbKeH9g/LkmGdVOZmsah5D3uMZPJTchhCzW4
         WNDotMIIrb5sqIXWIFG+jvX6nNQs+TpTj8WOXoBAuP9/kbyS9dQmLJCOx0EC3JtsOPXo
         7VlsCczDvJuNZhgHtQclfRbMSi2wfaHjTWwS6ouAW3g16Z700Sg8reXkxDt6ydkmA9oi
         44HxGjkGMurKcYshkwkpWCtyCmzGYBrBYgK4W7QbxYFWHD7H8x3ryyt4SCp/UT42iHKH
         k5CFKKqE5jBxWwwRk3w2+8afBYogqRkdQraHOkI3r96cxabY+KNfz6I3wUlhdv4mqmiu
         WnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770093749; x=1770698549;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6uVBoE73O8biFQak4QCZgMI1X5F9GhH0vfg6IZTeIw=;
        b=F7wqtcuYUUA+AfNmJYJytZk/uQGrerbnoTJQNnTGWKf4DEuQF496/kaSEqi4KIYlzv
         wEO/fOs8CVaB7+ui3/Q+MvKhp2N0OlIqMwhfn6G4XkMesUf+gz/JvfV9oTs8wZMVxrMt
         KCzL0QzxYWZfbq+MKKIAeJxcjFN4roJF8wUMxZnz665ba4vDZK9NwYHjDpPLnKQ7+QzW
         leiwoVaHBjXD1gHCmb4dhkVqt2KZUPdQocWtAStYPnxnzWhRiFJ3bPLLtVtYjFjDLfmD
         Omueyl+3QeHkjp49RTd59Vw6xIdNO+H5XnPm72nqcgTj/ookqbP02WJdpYnQhPKFxQVo
         Cp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe9TVCKB59H5DmaAxXuqZB+2s6Qw2p3MsK8+U4dLU8S6HqHdcvOvQ7fbfoUc0FQnNjJWanV2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VCC6b3GffnIz147jwyK0Mms6YGWcGrPBelOjK0WUu5X6rich
	Cm2iGSeSUk29cKviUfeLSvz3SwsU0Mj0lfFxeFOTYmzaVMxoP2Q9VUxIGAYsdWBVSY8cKCf2b8W
	MBE96jJupGI4c7A==
X-Received: from yxst2.prod.google.com ([2002:a53:d8c2:0:b0:649:3698:14b9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:d015:0:b0:649:d4ce:2446 with SMTP id 956f58d0204a3-649d4ce286bmr397309d50.3.1770093748989;
 Mon, 02 Feb 2026 20:42:28 -0800 (PST)
Date: Tue,  3 Feb 2026 04:42:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203044226.3489941-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: use __skb_push() in __tcp_transmit_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256117-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CBAC8D4746
X-Rspamd-Action: no action

We trust MAX_TCP_HEADER to be large enough.

Using the inlined version of skb_push() trades 8 bytes
of text for better performance of TCP TX fast path.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 1/0 up/down: 8/0 (8)
Function                                     old     new   delta
__tcp_transmit_skb                          3181    3189      +8
Total: Before=24896035, After=24896043, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 597e888af36d..f907f24f74f7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1565,7 +1565,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	 */
 	skb->pfmemalloc = 0;
 
-	skb_push(skb, tcp_header_size);
+	__skb_push(skb, tcp_header_size);
 	skb_reset_transport_header(skb);
 
 	skb_orphan(skb);
-- 
2.53.0.rc1.225.gd81095ad13-goog


