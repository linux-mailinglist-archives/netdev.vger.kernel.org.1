Return-Path: <netdev+bounces-142054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6AB9BD3A4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE691F236F0
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CFC1E6DD5;
	Tue,  5 Nov 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ySm7TO72"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514F1E5731
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828654; cv=none; b=ElFZ940V4FPLeC9RvLIbBI6qZT+ptPIuxXzhh4UEgi1+JwSmRu9EiMTfJbVhIiiOSiRIv1RlpngBxWuBcFnINYqiz8O3CvhC18074Py95HqrVmtDf8FnGl1E5u14TK3DcWkBjCq2ZfIdTWm7HNMgFs32VFyB42ZuS2Lm6PGNX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828654; c=relaxed/simple;
	bh=MuGcy1XbX6kn3ZXD6dAvUfYIXmlqpINevK73ztYi2k4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DgByL7Vq4tkiFbJUiSCOwda06pWaCJPqzCznS07rJcm8Xqz8UvZNyibiwxFg+AqxldKE75pMWGyosTCsRLax5whzsdwO1HBvJYqFGpcEOhptaeYzIYBYyRcJoAmQ4FFjtbdwV/x38Sb+PGl8WI9EOxZMjrlnicMyXAyy7JDs0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ySm7TO72; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea7c5805ccso59394087b3.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730828651; x=1731433451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk9RwcETdnYNnhnNnDFXbvT1xexMcOlxhvFlwxxQSeE=;
        b=ySm7TO72lfs+QWGCTtQv2Me670O9u6O0+pAbkDNSf5B6X0wdA4GbV0vX7NPV2LuQV9
         1W8a6wBUvU7nvrutx7B28XtTClRHvdjvfaSPZX4IRZ40C0lOm9dF6S0AF2RdD3MJKo/Q
         cxDYskByr2pbT1btbzbJKLGkXjd4LQuKdBCR580fhDGQ6ELoLFwy9knZDNfV9Rsp2YTE
         Q716rxNwTMPVFkuHzG3h6eUZz6HNHyOjH0MIHnlu5neyjuPHK+vZ+9XP8UWfQo4WHbDv
         LOLYRM8OPZyUDH5G5b/TnB61N8TnAOjZ/mQIEuKelWiaUML320kGZVZzQUF75xGtAOOA
         HZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828651; x=1731433451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk9RwcETdnYNnhnNnDFXbvT1xexMcOlxhvFlwxxQSeE=;
        b=BgiCIKBw4i1HbnkTRX2mCvkIvcqnv7n8jpL0fLbc8EzYCatYYKFNe8VwKt5uaLC5C9
         0oBdHolysbbBwztPM04PROqS5kBqwU0F0t3a3UdD/gq1XMLdfuPOjmENLaLoN4Vkw1Nl
         zW3fg8Ac+/nGBbWXS2rDFzwjwRpe7kQvVcLxciKlS1k9jsyqYhk+eOToOYAg3vIk/pD5
         aQvUvd/XOX9xiTNU0J6lR5ZYZOdRgmQCR58fWxn9AdC51ZdIZOOqJwYJCm5JX/gx/V2N
         6gORO02TlcrxmEut9DFN94LAZ5Z7WuJ2oHNPGX7vHyMTl9D+ZrDgvpDbYwAONz5rutin
         lnig==
X-Gm-Message-State: AOJu0YwqCnO3hS+hj/D9klxaziVGZ4bqHRnjX97IgNpB4tTM08ssdPL9
	o/hFahD+l3H4XkbSPpvyVngGzF5BA85sd+7IQFEIxiIJFtYreCQg784cuVACloosAcU0qIpk9/Y
	fVzYo0nNdpA==
X-Google-Smtp-Source: AGHT+IHMcRTane1j5KFKCrVyoZ2tWmrBOyzPZ3YAl6JYYQPvovZalnf1oLAc+LdjhTwAaesXrriUw9KnslPaTQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:8541:0:b0:e28:e97f:5394 with SMTP id
 3f1490d57ef6-e30e5a3e278mr12995276.4.1730828651533; Tue, 05 Nov 2024 09:44:11
 -0800 (PST)
Date: Tue,  5 Nov 2024 17:44:00 +0000
In-Reply-To: <20241105174403.850330-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105174403.850330-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105174403.850330-5-edumazet@google.com>
Subject: [PATCH net-next 4/7] net: add debug check in skb_reset_inner_mac_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure (skb->data - skb->head) can fit in skb->inner_mac_header

This needs CONFIG_DEBUG_NET=y.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8dafd1295a6e921e9fba69b730286ea28fdc5249..32a7d8a65b9f8f6087007177e763dc9498215e34 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2982,7 +2982,10 @@ static inline unsigned char *skb_inner_mac_header(const struct sk_buff *skb)
 
 static inline void skb_reset_inner_mac_header(struct sk_buff *skb)
 {
-	skb->inner_mac_header = skb->data - skb->head;
+	long offset = skb->data - skb->head;
+
+	DEBUG_NET_WARN_ON_ONCE(offset != (typeof(skb->inner_mac_header))offset);
+	skb->inner_mac_header = offset;
 }
 
 static inline void skb_set_inner_mac_header(struct sk_buff *skb,
-- 
2.47.0.199.ga7371fff76-goog


