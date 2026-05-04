Return-Path: <netdev+bounces-283720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHUBLHlM+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:36:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 458674B96B2
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2953301C940
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8C52E040D;
	Mon,  4 May 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcieLj0t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B32C21F1
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880102; cv=none; b=svm1c6PvSSSAbhKCl9pBNPwXgWtYLplLcWrvAEGnJY+MvYkcei58gRgDTUPGnuYBjzDP6Q7YLF+P6wsvcUC92GezUJSUgrICW8yfkEEjeuTTV3tNoqEiArImh3FLyuL9WOjPt/Qj35a8a7mVZU90tVY69bA5R42azQHbE+meEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880102; c=relaxed/simple;
	bh=LJZBfsLNp7e0CusqRA0MQMMo3k4IdeFaivkYp+6her0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuzibGurcUfyrpg+UPpIT/x8K+JCULmhyPJjzwT59TT0tCn5meJmrR7mhTwMYiLL7u41/KfEWRXsCK3PjDCnvbT/khEslZHW5/98CTUqTNASQK3InWppTXyF89LR6zAIe72ojPOffzp8CnByNGoLDMWi9xPT58MVnRVNwjakr9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcieLj0t; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adff872068so17859395ad.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777880101; x=1778484901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=694ufcFEujooEUmLIyfGuicFkgjufAYpi+YRAAOjBpc=;
        b=rcieLj0tWCAx/bWIFDUqs0sxE29qGwtQqK5Rye+UIRXO+eUbdKYLTyr05zPyW+Nn+1
         aUBzwmRq9IJUtzSpJpDUIeNW9H1ydFW4o7lkdgKMmqQ4byjh5si36TUUdvS/i7WDnkHU
         O4Jd6T1/gzmNBIxskBqnMyOlnNpZTUaIG5NelPKyhKz8vkwbGGE6gCh8QwDIFqBzNDnQ
         DG/tOs6zkG5bhcKWnXyy2Aw3KQGUlk88cIy3C0XgrA/VteKQmAyuEQyyiPhG5UZgB2+m
         mhJn5zWLdDmkf6i+2ltgALldfGVED7FF75IObJjCbzn10oq5pHmfdGI66eFWL9YwEWVV
         y1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880101; x=1778484901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=694ufcFEujooEUmLIyfGuicFkgjufAYpi+YRAAOjBpc=;
        b=VnEPB/xi+IQyG85BNdfnX+KiRyAmKkzlU5PTxRUXHd47hk5jzq4jWJL6iXNylUdwO9
         wa6GtqgV/fLXNbJRyfa6q7Pu9puZeqdHAU6zj1lKoSeeFwhsS6fBpO1/cMtin1X4Wv3u
         auH+kBMdVvHSK5ClhJpHymLgsf/HgBt4jkH2MLHdCTs1cwzxOp9SF/XQoFgftau3+Aoh
         xVUUlFE1Crush/iEGBU+zvkuWxX1UITT6TwcZurJnN/dSUkriJa0u2U0PI5x88C0buW3
         swHA6Ri3McLsvfE0djHrQVNnVQkEvbGGmXQ1FyqS2JKe5b33KRTZBnCfnDq7Zrq/MiJl
         62Yw==
X-Gm-Message-State: AOJu0YyUMPX5m86O86JXduANLSYgT1ED21Mp6Tt9ue/ZKRioAdEzfvUy
	CBPFZKIC2ognJIz65s2C6ryqiWbUMv7mbbZ7fTxHzpKW7SAMwHhEepjVNwspucsB
X-Gm-Gg: AeBDievao9mPmzMUNaGstohXa1VV+yFkIoqE7ccWeUARGw1VfSiXGZmOzUE46W8OsAB
	avvMnp2yq4TKFH7+R0WVlGN8BpNLRM7pabBnoLKNjD0yu9pUGTIhyBDmzeUnsPmOtJj58yGfGYf
	ja9Z5qVOWXlgX5afoYIMVNZfqCCTe3WpfQlKGNX1UkNeif8a2pKUmm6a5ypi3nZOWBSmAQwLTsl
	TH4j3a61ihUtg+w5o7PA3XAgp8mE9WN/aj5mjf+MAyR3OOr0G3vozBf2139zQZqKbZmlFXN78nF
	pvwzXn9jZt6oVBijUpUZnEW8+y4gMm8hK6rzg5kUuwv2ccgo5GphrexxW7NSKsd2hiNauGpgOKd
	ckTuAcIddkgw2ppRPgpBoeQQxfUnBIZ0s7dxs5eByV6MwisD77g6l3eMpGJ/KLKbslIKjCYAFfo
	pmYyKKEkDHfmdYWvcLUIdfLR2bdhk0IAE/KTizl8vzqsM6+ik3UiuOf/rBh0MBRy6N26I3M21Go
	7wJ8oW2wXLp9lfIzw==
X-Received: by 2002:a17:902:d2c9:b0:2b2:57f3:8d07 with SMTP id d9443c01a7336-2b9f252fcb9mr83238395ad.7.1777880100825;
        Mon, 04 May 2026 00:35:00 -0700 (PDT)
Received: from localhost.localdomain (59-124-8-50.hinet-ip.hinet.net. [59.124.8.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaaec82sm96828415ad.24.2026.05.04.00.34.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 May 2026 00:35:00 -0700 (PDT)
From: HexRabbit <h3xrabbit@gmail.com>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kuan-Ting Chen <h3xrabbit@gmail.com>
Subject: [PATCH net] xfrm: esp: avoid in-place decrypt on shared skb frags
Date: Mon,  4 May 2026 15:34:03 +0800
Message-ID: <20260504073403.38854-1-h3xrabbit@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 458674B96B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[secunet.com,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-283720-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[h3xrabbit@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]

From: Kuan-Ting Chen <h3xrabbit@gmail.com>

MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
so later paths that may modify packet data can first make a private
copy. The IPv4/IPv6 datagram append paths did not set this flag when
splicing pages into UDP skbs.

That leaves an ESP-in-UDP packet made from shared pipe pages looking
like an ordinary uncloned nonlinear skb. ESP input then takes the no-COW
fast path for uncloned skbs without a frag_list and decrypts in place
over data that is not owned privately by the skb.

Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
TCP. Also make ESP input fall back to skb_cow_data() when the flag is
present, so ESP does not decrypt externally backed frags in place.
Private nonlinear skb frags still use the existing fast path.

This intentionally does not change ESP output. In esp_output_head(),
the path that appends the ESP trailer to existing skb tailroom without
calling skb_cow_data() is not reachable for nonlinear skbs:
skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
tailen is positive. Thus ESP output will either use the separate
destination-frag path or fall back to skb_cow_data().

Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
---
 net/ipv4/esp4.c       | 3 ++-
 net/ipv4/ip_output.c  | 2 ++
 net/ipv6/esp6.c       | 3 ++-
 net/ipv6/ip6_output.c | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6dfc0bcde..6a5febbdb 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -873,7 +873,8 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e4790cc7b..5bcd73cbd 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1233,6 +1233,8 @@ static int __ip_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9f7531373..9c06c5a14 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -915,7 +915,8 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7e92909ab..1f2a33fbe 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1794,6 +1794,8 @@ static int __ip6_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
-- 
2.43.0

