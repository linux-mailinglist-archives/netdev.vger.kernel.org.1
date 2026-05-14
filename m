Return-Path: <netdev+bounces-287882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OJiGT+ZBWqNYwIAu9opvQ
	(envelope-from <netdev+bounces-287882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:43:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F0553FF24
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EF0C303EE94
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813EC3A9632;
	Thu, 14 May 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMWt8wDo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958AB39AD33
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751755; cv=none; b=UIQw1d7L6YxJ6gbI94u/T+siVSYPsOv0B1QgJN0eOMTMwwr0bjmslYIaSqkC0ls4pPyux4u/zZ0FQ7Zj86kfx9Mwt+6pnC9Zs1ji0apMVlgtr2D16YQC0RnEhFKZpdEH1h1r75s9WKs7djEIH9ybPRIx/+1o09ZPGDl5rWz7JzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751755; c=relaxed/simple;
	bh=rQs/D4qYJck2kIgPhiZZ3Fg/5QkATjQrK5UVoTLqQHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LlRjCA9MdpCpvJ0rBMdSiLGLa8Xb0OlNin52KQVEe37OZQh/y+9W6PtWbYfK6j1jsQ1+XA1tbnEeJ0IirBv3w/GbdhFfxuJyzjv8Pxsi8I0GMOF9wGGJYMQoQD+n2xobh+CeeKfhYR9Td6Ib4kwcPvP0+YAaGsq6QemnovYrpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMWt8wDo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so86473165e9.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778751751; x=1779356551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RU5N7TG/2oOJFFJ1rhjydLyb1X8rOImh10nKex9OxhY=;
        b=rMWt8wDoEr/QWctj/Krh95UsJ5Q4Y6MMKQ88WpaS/TSNpsMJbbAamYfHYDPOLXekVG
         lahDH0ZZGlXECbgNizASF5dGaHXeiG9Yva+msOgv6wUFipIUfulI1ZW6fclw0UadVlpR
         ayVe7ndKBt9X4FzSpCHbVSDfmcWhgJtd+RGI6Y3+SddHijMoecLs39zDIR+PCeXRdQzY
         HIDfr7me5Y0SCzcLrrIh/KtjffGgl4u/QCECCwtTdhomWBqpHUNbRzfD/XEdk+T4e1n5
         Ecpw3RQMT3dl6Dy13SVOahoPZ4by9AOQAhW27QvkAdvTip0UVUX+AF9qNn8yrw8HorIz
         GuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751751; x=1779356551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU5N7TG/2oOJFFJ1rhjydLyb1X8rOImh10nKex9OxhY=;
        b=hLCtGBnSAk4zRBJgqD60+MbLYZZIzMVyTGa6hBrpkLqNh9Wd3YOI4ETQAkmiFuIufF
         OX/HPmVE/mXBUjzTsIGahP5z0UnxyVo7ixSB/KXHVNe5phmYFwwroeIvVmAk1zfKJXn2
         1v6s0jTYe/kU09NJa+UFSvubFbOFDyH2jYWEe/MaYG2s9ocVNz5z27PRmtI3ysmMOC9b
         exFj8HgSwROXv9x8DbU/Xk9pVzeO1cMHWUV+GjeaQtB8Wvf3KbfAAsUiPFbviuUAGhO3
         ZaY6WXljd3eaX6bMZp2/WQ2zFLKxVJc0cacttDDfEP/NmkQTqeqK2EDQlzkeGKooTcta
         kdSw==
X-Gm-Message-State: AOJu0YzFM7MvZVaXF+OYlhSFX5asK8SD28lNjp0SfHJbeg7v7XXxOsFq
	9ZGp2rr4HlMdQr6Y0j/agdg9UYEivcge76TubWkifRP+yn3YXATVkK4J3pYHqx2n
X-Gm-Gg: Acq92OGUsO9qiQMzDItpDSD4E88WcIHrpx5YcYwwnk0Le2OjGrKkbf/eeiNnnws/mIZ
	/7Pad8wpBrR073NszhAmOVFdT4mnbQVr4PJKN8caBAZaog9LbBF2sO6LfLcvWoqWfMyleX2jLCR
	Ojd9/lL8PKyCNJyoLpMB8BuEp7USBB0PzG+UqDXFVU4IkB6UuEkNKoODuDh9JnKdpsKGCZANZq/
	4F+2Ww4lahPyacSMCrilLqIKkiCPKx7LFZ7ygJepKq0IMAVt3feafYgckcXg35D2Q1r6ghJWaJm
	wze/dENN6gP2/Zxnys+wLtVzcZQMzMqDeG07tQza7b79syBpF3Vqm1NXzT5ulfUFbgX38/4REUL
	OQ/mlWL6V2eA9r7zJWukBU/Hy2R2nw04C5yuXt/wBDbSGzTsjIm4bki0QZ6n7dpWIC8BQeR2Wvo
	Nwo8pEbTl2reG22eLK4TQ/aZ5bbPnXo7xzAYM/IUTh84YKezwgIQKsd8bbdnC53XWKbuTNK15eG
	P44Q5w=
X-Received: by 2002:a05:600c:698d:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48fc9a31279mr112949385e9.14.1778751751255;
        Thu, 14 May 2026 02:42:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:827:3b28:500:b184:4b99:e746:532b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd648d3a5sm51654735e9.2.2026.05.14.02.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:42:30 -0700 (PDT)
From: Alessandro Schino <7991aleschino@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	e521588 <alessandro.schino@sbb.ch>,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: [PATCH] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Thu, 14 May 2026 11:42:11 +0200
Message-ID: <20260514094212.32-1-7991aleschino@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D3F0553FF24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,vger.kernel.org,sbb.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-287882-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sbb.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")

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


