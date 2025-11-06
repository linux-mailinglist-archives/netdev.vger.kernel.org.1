Return-Path: <netdev+bounces-236507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFAC3D5B3
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 21:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C513A4856
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CF2FCBEF;
	Thu,  6 Nov 2025 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2vtpF+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4466A2FC00E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460985; cv=none; b=crM5DwjNUsNskH+up6uqCkfdsh5lCERW7aehE57sguXMyV0M1Kw9PrreVGlBBnNgrbyrrxHJ27eqt1dnxoVXxZZkgBjcpcEaHHb3/a12zz+2yomYz5dJKmWiBw6yGyfqX6j4a4cUZ4sgph1GTFy2dRsw8FMWTIUbJ2JS3USssaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460985; c=relaxed/simple;
	bh=TH0wbNKK37NkAKquOfCZEq/jZqNhMc9USFmULGQvDmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OjzDJ+I3gRGkJuCaEQKlUMcxkCegGkvLo0bPYWC8+nOIrU+boKuzEdtQpwc2h/P9Alsb12yK4yqWUuq/fxrR4WeUqulTuncUg4dhElnU4hDnuhyAPoHl2Z6NCTcK8iC+17bI1PdsfCGa/+CEkekyXQRWRcKc4heT7949bMlcoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2vtpF+f; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-78efb3e2738so1376386d6.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 12:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762460983; x=1763065783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBZe3BFlmtSiuAXDjO/70cCV6oIG4SbbNGdCjbpjUew=;
        b=F2vtpF+fd7sNdj8eZxMaPpa8EWuyYY3Cw4W6blOG6XxvUe/6yyhGxuM7I0FxNnunQv
         FmsZb8dKOvrIiYpPENIPzQY6HEO58aBuhKAZv14I78BCxGCLirJxvThZwXCWIABih8Yg
         EzPQqvmu+4flzb/jTKz2alKeC3sEpttQX16A9WlpwSjnW9GViDzRWkh2m4OHKTz7/uYw
         sEfCAAhMs7/PrT88Ye7Ocqb0/wrk16QGlaVAuzgsrOHhuH0HeWp6gppi4vWOygkSD+J2
         k1IbSs1CQLLtKddSJhgpRWDvY5SomvPKgKqAJLd8J8OneIlWkfgRQreHJgnZrnTicTTz
         zO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762460983; x=1763065783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBZe3BFlmtSiuAXDjO/70cCV6oIG4SbbNGdCjbpjUew=;
        b=MNm/YRLbT3kMMFv9VJUXBpjzgFTClACCZhwceX4CXCxOuzx0I85iFN3tYMXuVyNWMq
         bLyMHsRdvm4rwV/ppYH4H5DoAbjUlHzv1Yhu0Unugje+K/VCN8iFPXtO829AMw9D0ZPn
         PHB1/75PgNiBgw3Rap1YYpHH1IBMjI4L1Js2pt5TGKsOV71KBPz7Wr+9jKX1TMxnOfrR
         cedOVmw1buHJ9Du1cPnR4OJjT9HK+uLCQzQJZwFoua2IGJJbS9hEutUbliZhINUDemAc
         +QpUdCzay5MVGBjMXTxIWdrUN3Rgmrn+oeJ/GCyb9QLFjvIEHhLP8vm5QNtXMji3G57s
         d29Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPGtroNm2eMdOpj8lSQUreOsn98dMixNBAy+g12VKpbnwn/oWeGbVbTyg4LaowygQSj3t/yZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LvqgJ1uA3mWUReTO1vXmESUZKwYPMpTOfVufUj1QL6wT/Qvr
	gmHKYZgQxWPVSZpjmtPj/gsH1KdkC3m/S4fbZgCnIvt1OaSi0imapVlT/R7y67HOTcmqs0sNgGR
	j6w7a6XCMN5QbdQ==
X-Google-Smtp-Source: AGHT+IFR6Awbc+iox4lR1Gcw9ilrjucx5wbzA2mYBUxpzYClbYSqTmnvbU+OiSUOsjoBkqNhwfv8LE059GVmYA==
X-Received: from qvbpj18.prod.google.com ([2002:a05:6214:4b12:b0:881:174f:e560])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5011:b0:795:54ab:6785 with SMTP id 6a1803df08f44-881767813a6mr14448956d6.59.1762460983130;
 Thu, 06 Nov 2025 12:29:43 -0800 (PST)
Date: Thu,  6 Nov 2025 20:29:33 +0000
In-Reply-To: <20251106202935.1776179-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106202935.1776179-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net: allow skb_release_head_state() to be called
 multiple times
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, only skb dst is cleared (thanks to skb_dst_drop())

Make sure skb->destructor, conntrack and extensions are cleared.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5b4bc8b1c7d5674c19b64f8b15685d74632048fe..eeddb9e737ff28e47c77739db7b25ea68e5aa735 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1149,11 +1149,10 @@ void skb_release_head_state(struct sk_buff *skb)
 				skb);
 
 #endif
+		skb->destructor = NULL;
 	}
-#if IS_ENABLED(CONFIG_NF_CONNTRACK)
-	nf_conntrack_put(skb_nfct(skb));
-#endif
-	skb_ext_put(skb);
+	nf_reset_ct(skb);
+	skb_ext_reset(skb);
 }
 
 /* Free everything but the sk_buff shell. */
-- 
2.51.2.1041.gc1ab5b90ca-goog


