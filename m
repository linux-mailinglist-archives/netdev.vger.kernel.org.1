Return-Path: <netdev+bounces-288764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GgsMdMJCmrqwAQAu9opvQ
	(envelope-from <netdev+bounces-288764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:32:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C75A156325C
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D712F3001A4E
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE83630B7;
	Sun, 17 May 2026 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDZI9mvO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEC2DECD3
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042766; cv=none; b=FQEy29fCZIdxd7RivO/vojgJbjAdPX2zfcw4mkPW/xgSXHTfgO68hDfc8nn45jAaYfACy9zXBs/uAKaGg7dy+N/rpnGY9sQ5J1maj8+LyMuO0In9OqYKFILyJQ3oiwdec5raQpdUgT/VJWxDYXaszN/y4Umn8URBPaMPhJmpUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042766; c=relaxed/simple;
	bh=2gpLkKTi8b89XhOJYb+h4Qu5Tvt0LWquMLx2EAJnZ6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hkKZs2u9qFtR4SjTKHg+zZBivZ8OPiWJ8QOl+hn7PxqMx+LElL1Ii5TUHzyLcmqVz2iHqVUUutIRI3rr/XkBp/Kj5JT9d9Us509depYqgmNpkqiPt4pvPo5iKim0wKNL3ZZCbns6sXFX99LBsWILvSio6bVqG2Ohsp7c5kyAUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDZI9mvO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b150559bso11555365e9.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779042763; x=1779647563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrX4cHfZiq2RSQ96iUeYw6Ac8LjFTgDBJ9ngVRFz7iw=;
        b=IDZI9mvOHX5Fz+WnmWkkCzu0UnPxRbbjtZSr/IkLtO/qIq0W6m8eSeOrYAe/GOH89d
         KVG0csVs6sGuU+sGrbF2Q+kCHE+ku+NGsJwCtaej/Q1ZWEvEHLp7gg9kxd2Znn04hLYr
         pIO5LoGt+uxR1dhk4WQP0Hu5Lte0LE/RiLSgabFtTMsCpR5pJc8Yp8qTt4WD3oUQwJWB
         1D0lcCeMLu0aUzH4WHRwq9yBdvREOiLMrW3agd3dkMDDgmGGMdW78D+EfShp3sDacmjq
         gkk2JSdVfjMdu6iX4i2gyPPdH58auvlY/OVCLbWq6r/qGPZmZdXHRNqCRWPf+mE9jZ7s
         v2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779042763; x=1779647563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrX4cHfZiq2RSQ96iUeYw6Ac8LjFTgDBJ9ngVRFz7iw=;
        b=SMwWc+YMIbUQcBJMr9nuTIY7XocNYHUjBxWRDtNMTXVBaGLc49fNIkieZKYJ0kyFHe
         /WH15mvh79JBG6W39WYHMOXXtIetVPzogUxSatRdAl75WnMU0jt5cXNo7CqhirNIqB+O
         tgKdVUtSfkd8v2cuO6TUA/NU4G50hzkE2/UJrzc0BCudvbsm+90FxPjAn3mvVsyt3MaG
         KjzTjlYjwoPh283jGSAmZNXqAhvlNrlRGsoFs/cAL2aLFmsZwoG44pPDVKiSzpseF34S
         3JMcJl1VPCh/wemCZsdVb7SyD7rfT+4UpSvZ2DmV7XWCSa7aYcVyrGoB/AQeXpyBz2e2
         /0JA==
X-Gm-Message-State: AOJu0YwdQM7ouMQsbx3qpQgLAEbYspWPiRSPmzvLz/DA5SK227u2jZKt
	41n92b8TzpgnJt5aRgHfGF8WhZGrqGxCAlfIhlaGENSqhBWrzzLVb+NRW4M9vmma
X-Gm-Gg: Acq92OHjFZy5oYStbyLLjOqArkUsJcEufXvGE4wfyGcstwhmfvMUfF+IPUfN1CT+pLG
	XCjWa8WSS8XPBKRFcKJBz5J7lzKyBMTODg0q/1wRky3dwS4QHkDgFE/yAmH5IujQbrsWG8sb05w
	jioN5rrM9iLEu8dqfYcD6Ddp12UT9UvYJ3U/s7fRmGBPmUcRp85Bes8+yVfMU0bKeDlrp6zPRO5
	aKIStLQXUlBmwkEl9TUd+t1vQv7BICbZtIHJU6DC0ZHNhVjT+Imc+L19W0F+JWaXSfoXae3FYoB
	YHUpmdzV2L4MmkK1dgDXS2Pd0OBCP2MacNQmHBr0ol+fXiUeZG2VadqF2DUEMaJ/o7H9SPNG9qi
	b400FMIIwW7anZlEhPl9gjdWRSBfpKr4cmy70LNXy7y3W4GE8OA69G4PaoRwtdAzVjRVeXtRmdl
	FFLV2KeBWDizDvae2vHaEYjaYEYhUrfW8MKIV9
X-Received: by 2002:a05:600c:8b13:b0:48a:6315:da26 with SMTP id 5b1f17b1804b1-48fe6513492mr202490685e9.26.1779042762748;
        Sun, 17 May 2026 11:32:42 -0700 (PDT)
Received: from localhost.localdomain ([31.4.47.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm16172225e9.3.2026.05.17.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:32:42 -0700 (PDT)
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
Subject: [PATCH net] ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()
Date: Sun, 17 May 2026 20:30:59 +0200
Message-Id: <20260517183059.29140-1-justin.iurman@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C75A156325C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288764-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Reported by Sashiko:

The function ipv6_hop_ioam() accesses
__in6_dev_get(skb->dev)->cnf.ioam6_enabled without validating the returned
idev pointer. Because addrconf_ifdown() can concurrently clear dev->ip6_ptr
via RCU, __in6_dev_get() can return NULL during interface teardown, which
could cause a NULL pointer dereference when processing an IOAM Hop-by-Hop
option.

Let's add a check and use SKB_DROP_REASON_IPV6DISABLED accordingly.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/exthdrs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 03cbce842c1a..47c5502a34a2 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -910,16 +910,27 @@ static bool ipv6_hop_ra(struct sk_buff *skb, int optoff)
 
 static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 {
+	enum skb_drop_reason drop_reason;
 	struct ioam6_trace_hdr *trace;
 	struct ioam6_namespace *ns;
+	struct inet6_dev *idev;
 	struct ioam6_hdr *hdr;
 
+	drop_reason = SKB_DROP_REASON_IP_INHDR;
+
 	/* Bad alignment (must be 4n-aligned) */
 	if (optoff & 3)
 		goto drop;
 
+	/* Does the device still have IPv6 configuration? */
+	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		drop_reason = SKB_DROP_REASON_IPV6DISABLED;
+		goto drop;
+	}
+
 	/* Ignore if IOAM is not enabled on ingress */
-	if (!READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_enabled))
+	if (!READ_ONCE(idev->cnf.ioam6_enabled))
 		goto ignore;
 
 	/* Truncated Option header */
@@ -972,7 +983,7 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 	return true;
 
 drop:
-	kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
+	kfree_skb_reason(skb, drop_reason);
 	return false;
 }
 
-- 
2.34.1


