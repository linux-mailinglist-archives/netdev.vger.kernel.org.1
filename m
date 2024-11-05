Return-Path: <netdev+bounces-142055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B519BD3A6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E307F1C22A1F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58E1E7653;
	Tue,  5 Nov 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jW6jv2G9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214D1E6DC9
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828655; cv=none; b=pvBxxvCN61O3vOM3iSW/DJQ3UtDLA//q12z/bHZ3p3XRYhnQ0aBCOTkjdndPvZ+Rv2uCdYKo/XcSmSlYpwVl831Lk7VlYX1xmw3Af71DrtfqqnUeqsCPiZ2/QF0MYZWwvVIX06t9ROohUUXRcK6XjbYmaWiIjItfeXF+yiVBwUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828655; c=relaxed/simple;
	bh=J1s/lzxM/9r3pQA8JyR32+fZi56yZQUdaHdH2de007A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kRBedzkTmQ8QasHntsg16PnXhyNaChQXJrXFSYqSUCT3giK07JYRYlQAiRSRxHLRJmA3hE8bDyOav+njh5ZdnWMa0hwWgzHQcMDb+v0VrWEEGvcsLeeCwFWUFGbjuVAjtCIZDLcRDqCLAxqwkphDYl0TRPI52+JhrgyWFzGZ5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jW6jv2G9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3314237b86so5303915276.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730828653; x=1731433453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyQ4iSBUaIE+8Hy9IdFnubTi/J27YNEsIbYJcTy/f1w=;
        b=jW6jv2G9fVQMEebVflalHb3ODW4r36uZq5pF6NF19xu8xnQCIORTGvQj1O7DiHlolx
         zk2EMhljheY8PsJ4+BdiEdGa6zjiKoMifhTsJ7cDcclt6Y+nZsH/twCah4d8Rommw5np
         SeSaChQ79hBnPmyPlKEXs0n682MOquthz1JKQBCMs9JTnZnEtV7sDykzQw8v43DHF1do
         /lRLWTsJ8FzpDDHxTPbhZHkaFRo4ZKKKqruohclouhHn1qJ9ICyc9bVI3cucfbbEFI96
         KCaxsWN+ype4rsWYifiz10yjVuh4Qs5We0wkcsrQ0abyuoE3EqsA/JsmpLNGKWH3fZNp
         3Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828653; x=1731433453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyQ4iSBUaIE+8Hy9IdFnubTi/J27YNEsIbYJcTy/f1w=;
        b=ulIdNb096lDPyXskR7y6xkouk54Mtwmd3yWGyzd9ONCd0a9HRn+YyCJlJdnLtchYcE
         MQTLQOhugjJM+7Fg/sVM3i8hMSKb5CCITU1fFh9gL5H6na5kQMFksYDjxHNKn6TXAiHh
         lbP+qnMt7wwKBXmUBJOb/6wGLTZGk7NCN2tFvL6q0quspZsGGPV4YvJeUUPTjl2/Nf4C
         6BD8c5D7TNZ0ga0E9hulvefYIAgGXjWcsLFGZW51i0Dfzl3/q9w7p8Lp2hPcoUZQjwyW
         KfsY2sHQf3PjVcst2FJfwCrp+zXOvt2GtvPDnzkrBM9QlQ2vZEseNQfH+J/bx/0pfh3q
         GXqQ==
X-Gm-Message-State: AOJu0YzwhRv6zQqMbVyX8boz9jaeWIhoOUFqYISf91RZ6INvySAqX0s6
	XQ257kO2cTPJmwp31TS1Cw1sPZeiVPynJY9qbYT19macLAdKTpNkMBcC44o0QjCB9j4eK3fSuYx
	X/uQiifMkuA==
X-Google-Smtp-Source: AGHT+IGn45vHPnqzJ/Zhg+LkDUypc8OTWhrqworv3TQV90ntGK/FjInp7wEFBFSh8liy7F59bPi/B+TeVvY/GA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a5b:bc7:0:b0:e16:68fb:f261 with SMTP id
 3f1490d57ef6-e33025817a8mr11550276.5.1730828652919; Tue, 05 Nov 2024 09:44:12
 -0800 (PST)
Date: Tue,  5 Nov 2024 17:44:01 +0000
In-Reply-To: <20241105174403.850330-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105174403.850330-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105174403.850330-6-edumazet@google.com>
Subject: [PATCH net-next 5/7] net: add debug check in skb_reset_transport_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure (skb->data - skb->head) can fit in skb->transport_header

This needs CONFIG_DEBUG_NET=y.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 32a7d8a65b9f8f6087007177e763dc9498215e34..f76524844e7edc5fe4e0afc27ce71eed7fbd40f9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3007,7 +3007,10 @@ static inline unsigned char *skb_transport_header(const struct sk_buff *skb)
 
 static inline void skb_reset_transport_header(struct sk_buff *skb)
 {
-	skb->transport_header = skb->data - skb->head;
+	long offset = skb->data - skb->head;
+
+	DEBUG_NET_WARN_ON_ONCE(offset != (typeof(skb->transport_header))offset);
+	skb->transport_header = offset;
 }
 
 static inline void skb_set_transport_header(struct sk_buff *skb,
-- 
2.47.0.199.ga7371fff76-goog


