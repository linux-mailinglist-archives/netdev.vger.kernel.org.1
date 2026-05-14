Return-Path: <netdev+bounces-287856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHWLNd6DBWo5XwIAu9opvQ
	(envelope-from <netdev+bounces-287856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:12:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F5253F1BE
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 159C8301BCCF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980593D9029;
	Thu, 14 May 2026 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHauOMU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DDD3D8127
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746308; cv=none; b=pKPM21MdzS2YVZgK2pC5sPaK0ERkJOsigsPgq3M4FUYtjjilB1TKfCZnFK2EHjiX02+oPjDhoqk4RKZsrIEnWQe0WmtGFIGX904G/EEmSI77UOQ3qJEcVA2DS8VV/132G9ab/4jMTQEVt1dgF38S6TYwKKfaJbGN1OQcBbStvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746308; c=relaxed/simple;
	bh=kkPDxk7OQpWCY/y7s9Mr8zrhCCBIgHaHwNxYTwv1mXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgjg8jjIRLPZ+LZCOgh7F0W65ePG+t2OE9wpt9WWu2dIFt3CzFJls1jfPvPUFuJqMlY1MPl6/yjRg6jL+QZ8+oJYT490mJ3S1TLOgthVdBZNYVaaAhtpHNP9w1JaKpSvuh57eNpO97O+y+UG7vyN39DgWSQ79dtyZqiuXEz0RqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHauOMU+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so127622025e9.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778746304; x=1779351104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FI+vW5VUqDX/h/2J5DFaTVeCzdVFXEjt4d+lYVo7VXU=;
        b=PHauOMU+Wx9DmMX/nkPi2Tt/ccsmQgPVIQaESeztbhyE97mCIa1OdzwNaPOn9VbHES
         BcoeRxZMTfXB5sexZV3cT4Hel3z5np30qflVocnKPE5Mvn6y1CaQr+rjN+vuQWmhDREE
         YL7BLDQ3zkPbNVlpOj1ZL8rTqhRRVl2Exe+gBYBIgwpJcj5cwa3VLWk30N8d6CEzjAzh
         MlGhmCI29n+ZTU7RvqIpMXQWhkvwu/4C212HEBaLgbzGGPAYyHUUZS5uvMmRxsoHYLL5
         Ce3Kfre4Ruuq+fbFFE6Z7O/MYC8WpcZVNr71l+X2MXHOU3AhJ//BLS5Dsjy+rS5MiPhA
         oMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778746304; x=1779351104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI+vW5VUqDX/h/2J5DFaTVeCzdVFXEjt4d+lYVo7VXU=;
        b=RDUKpdi+llmEVCidFNcGSoW6u8GtaywgCIhul1soPIcFWJwovSuOiurx2VFxy7HYYM
         VnHYKOnOyTOW/gLbeq4N6Gh/zoQy9uP/8JS+v3PjoVAgnW5TcTSVHpeq59WnnIWzT4KE
         sRpmvMzDrws55bKH9jJ4/1jUZeOEOlaP4BKTSPUQ5kYzOcrHj4lUfLKvxBQsWVtzmfPN
         UdNWnnj4a6gYyQkJQL5pf9LCWPeWUZl+Lox7SxiPINAMP4hYgpN/AKbwAjeN/T2ccfO0
         bWa2x+RaSEQlPpc5IK/cx4y23o8k+x9gljkr/drvOGmjcjsNQ3h6FzfKjSBg4ytzblAW
         a1Xg==
X-Gm-Message-State: AOJu0Yxk6PbSx+XqOvXrZER3DnHBZClMu9d+USoueKVYJshb+dtUQxXr
	nYQ2N+zyNmLItl5HcWZoD5EGMk5h7uZGLObl96fqMX4isEc0bZx76GrzeQ9ACmTt
X-Gm-Gg: Acq92OFsZwT6QfG2iES6KjvVLtsmZz+QLQbMUwGuFHc5Ah2qwcqrXAA5RUm6WsJ9L4a
	OYeEuO3maxrVj560BaPbSsg2GfoYTeM2B9oHEs/a2gYuMJSoZ4Vl3ifTSNUHYTNDiKtzzLKWLfY
	DoG1M7WvWNOfgJt24hkMZbbmw+ACGB/vmVjFyMLZ5ZBeCaYpp69NIFiiRo+hlEBTPub5ocHFIAT
	F3El1mONpIdqSaQgNgbGGizLoIHTScwTXXfCCT2o8J94OKjmqW4P5U/9xm88Twfdfj9KJLkGsij
	7iIeZ7PQ3dCrxYvLKLNRfgzXSprNI38rslSymAkKSxxqVUBNeH3MM3yDN/75JVM9+DPLmx48qqf
	IrpSqJYxLjSYR646kkvSBDGekNzJqEj0Z2oY+YRUAnBhEGE6uPX6RWi+aNSDanA7kclkG231e0X
	elJIyDp6VfQ9On5etzlI5ntTyieQeCmRW53NgJrqNDtWVC7GY02irBBRIgnEZcYM2LoqqjJFgE5
	33bbdk=
X-Received: by 2002:a05:600c:5246:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48fce9cf9a5mr99561185e9.11.1778746304359;
        Thu, 14 May 2026 01:11:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:827:3b28:500:4954:471e:9dc7:7f18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb278ad3sm43069565e9.8.2026.05.14.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:11:43 -0700 (PDT)
From: Alessandro Schino <7991aleschino@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	e521588 <alessandro.schino@sbb.ch>,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: [PATCH] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Thu, 14 May 2026 10:11:23 +0200
Message-ID: <20260514081123.1626-1-7991aleschino@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29F5253F1BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,vger.kernel.org,sbb.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-287856-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[7991aleschino@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sbb.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: e521588 <alessandro.schino@sbb.ch>

In esp_output_tail(), when esp->inplace is false, the old skb page frags
are replaced with a new page from the xfrm page_frag cache. The source
scatterlist (sg) is built from the old frags before the replacement, and
esp_ssg_unref() is responsible for releasing the old page references
after the crypto operation completes.

However, if the second skb_to_sgvec() call (which builds the destination
scatterlist from the new page) fails, the code jumps to error_free which
only calls kfree(tmp). The old page frag references captured in the
source scatterlist are never released:

  1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
  2. nr_frags is set to 1 and frag[0] is replaced with the new page
  3. Second skb_to_sgvec() fails -> goto error_free
  4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
  5. kfree_skb() only releases frag[0] (the new page), not the old ones

Fix this by calling esp_ssg_unref() before the goto error_free when the
second skb_to_sgvec() fails. At this point, the source scatterlist in
tmp is fully populated, so esp_ssg_unref() can properly release all old
page frag references.

The same issue exists in both esp4 and esp6 as the code is identical.

Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
---
 net/ipv4/esp4.c | 4 +++-
 net/ipv6/esp6.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6a5febbdbee4..5c4b162c1bb5 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -569,8 +569,10 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0))
+		if (unlikely(err < 0)) {
+			esp_ssg_unref(x, tmp, skb);
 			goto error_free;
+		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9c06c5a1419d..9166e1da3615 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -600,8 +600,10 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0))
+		if (unlikely(err < 0)) {
+			esp_ssg_unref(x, tmp, skb);
 			goto error_free;
+		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
-- 
2.41.0.windows.3


