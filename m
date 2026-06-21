Return-Path: <netdev+bounces-300874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QlveEg63N2rLQAcAu9opvQ
	(envelope-from <netdev+bounces-300874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 12:03:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4D6AA903
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 12:03:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=m9y1pVFh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300874-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300874-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 050E4301691E
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 10:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230528BAB9;
	Sun, 21 Jun 2026 10:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8CC27280A
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 10:03:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782036214; cv=none; b=ZEmJzE142OLjCYlVVbKPJC4oYvXqcE8YnsQZhcyPyPr4wutYxUHXKhT+njEalxoNNaYLVp4Re1owvAz0sypJaJ4gtf6YKhb0kiWXCe/8AjBb5RthKAfDLY1e7pmcL8/FQ9XwbezLmQoIumEjR+6KMP2vKG5zviHpCwIwiACDJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782036214; c=relaxed/simple;
	bh=6CEbWy33VQ653DeO6SgR9Jnu4uEbZ3wkIcMoSTq+82E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPaCw9Z/0K5gJ53Ow71lJqxrmDU9uwMlWDnit60wfOYtotsY89GSqjLCQlkbHRpOmOQdK0Yaf/ioYXN+mLGCVIp9Ky6FlZ0tp7dki808u8HncBPf7bNY7kVwkusE10KvXZj9i37Tl7yVl/1pvXh8B6EitKFjK1Ao2C25Nf9Ql5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9y1pVFh; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b3637b90so25793675e9.3
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782036212; x=1782641012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbaqv0SFZQJBjRBPKXCNne2CJMpBAx0iotepDfutYis=;
        b=m9y1pVFhjR8wrSQXdpXVTXDcxpJA8iErIqV7s4nUXQqk4Al+Mi/midGC6BPkp7YXro
         VgxXj2O2zRO+F0A7bdUhpIc8PxAY8A/UxUM12qSjW5FRuDUpV3+DWZ3hh4qZwhd9UNEO
         cdKrgH1GDgoNrVs2dfGwPPxOUcOq+gtljFEhBV4eEbULI4usg5M1BbJZHrOuLYun7Jf9
         MP2G6FA8oKq5QUGDKu3UHWegmpkRBTmfhjQGOwf3C8xU0euYMnvHchIP4zyZWG1QOeEN
         3uEmKcAU1Dspx0rGXq8YEBs+kIKR7pyvmW6gSG7a0c/GX9XmwaaBXdarjqUcOYB0036o
         xg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782036212; x=1782641012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbaqv0SFZQJBjRBPKXCNne2CJMpBAx0iotepDfutYis=;
        b=O4w5niXnuxO6y7WVvbtL+hBxYBCMIXZt6IUBabC/K+m3HOEYTW6msbuzMeFxGDgDMv
         t7ZAHHZ7vNT/tsuyBqQnP3g+q/0fy/cFGKeF7XrHBN9XaKqCq9pxp7xdN1luZGU0HBby
         lcrVJQE6FfgWl5rjUekDKUTuxhmoZ1gNu9Ehqq/+QPc9xHJ3NnN5UC8jqRDgESWJL5av
         cOSxAs9x3C/tyC2ShTDSHYipIu95g1vx84R2WaD3KlpntRO3DHqLcbyXZSxH9xNurApD
         KFQhNxL2cTiX5IkwSHAo7mPpE6/wqYnyfePHduaYZLWqIt7Xx9yKXi0GgOVDvASvp6W+
         q3NA==
X-Gm-Message-State: AOJu0YzunFLlnD9OBC4fjNiLtEv/qGXhbZ21KJ0kt9I4ex1GG6rjDPON
	QNoNiVapvE3vnQYQUpwhQvFHbx3r2SyEXY+e8yTu7vbgw08KA+FCLn6iE3fEDeTY
X-Gm-Gg: AfdE7clkkFJuHrfN+ZF9VLqhsKEWmWMMk1yvDDIsgpebTEFsdBhIc1dkp+uZYl0/22t
	t3C0Y65kORu1KQtnXU1gpVnBLTZW5xtwIyKM/Qd3pRNITcweb+AsRzL70SZGCK/Unsf/H3S72Sq
	HH0r5IBdYHnUY1hnnxRCCguuA35Gk/JY1FYXlUBUmTgo0oYvP78SABxKOLINkXfNdpJ8MWyZmnE
	EuSPIso/IIsUO+MlEQynmS6Tx/QRtfCepzzMIlZpWlXfKSHuTTKtUOreLpdwVgN1rqO84JdlEL7
	WlGOFF1Llyiz5Hd1Pp5/i2FJyBT3pk4fRPR1p/cWI2x00sZ6FSe2eELioA3k60LyYjAbZEqvy16
	zEhxiLoaKbzszcAP4xmvilTkw4JQNAiH7K64m/V7O4AdNzc7uAUukH8NukZDx4OLK1mhgElFWDD
	S0FRlA33xrN0S+7vqXF4xHPD4/cF3UgJ7iVq6YeQVvYEveEcJ6MOCsAAysFkmHzEElLZseuDPdr
	YHUZ5s=
X-Received: by 2002:a05:600c:628f:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-4923f56c067mr170228675e9.23.1782036211668;
        Sun, 21 Jun 2026 03:03:31 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f563dsm14400283f8f.3.2026.06.21.03.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 03:03:31 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v5 2/2] xfrm: fix stale skb->prev after async crypto steals a GSO segment
Date: Sun, 21 Jun 2026 12:03:27 +0200
Message-ID: <20260621100327.40203-3-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260621100327.40203-1-petr.wozniak@gmail.com>
References: <20260603064659.3867-1-petr.wozniak@gmail.com>
 <20260621100327.40203-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[queasysnail.net,secunet.com,gondor.apana.org.au,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300874-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:kuba@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99C4D6AA903

skb_gso_segment() leaves the segment list head with ->prev pointing at
the last segment, an invariant validate_xmit_skb_list() relies on when
it sets its tail pointer (tail = skb->prev).

When validate_xmit_xfrm() walks a GSO list and some segments are stolen
by async crypto (->xmit() returns -EINPROGRESS), those segments are
unlinked from the list but the head ->prev is never updated.  If the
last segment is the one stolen, the returned head still has ->prev
pointing at it, even though it is now owned by the crypto engine and may
be freed.  validate_xmit_skb_list() later does tail->next = skb, writing
through that stale pointer -- a use-after-free.

Repoint skb->prev at the last retained segment before returning.

Fixes: f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 net/xfrm/xfrm_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 19c77f09acc9..aec1e1184a71 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -224,6 +224,14 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		pskb = skb2;
 	}
 
+	/* skb_gso_segment() set skb->prev to the last segment, but async
+	 * crypto may have stolen it above without updating ->prev.  Repoint
+	 * it at the last retained segment so validate_xmit_skb_list() does
+	 * not chain onto a segment now owned by the crypto engine.
+	 */
+	if (skb)
+		skb->prev = pskb;
+
 	return skb ? skb : ERR_PTR(-EINPROGRESS);
 }
 EXPORT_SYMBOL_GPL(validate_xmit_xfrm);
-- 
2.51.0


