Return-Path: <netdev+bounces-165521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E1A326E5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0A11653BC
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF0020E328;
	Wed, 12 Feb 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0bBU2xf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7420D500
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366664; cv=none; b=Rs2GtIsUzjArOubx+/TQ3Cul2e2yaltvyqLb1z2P5YV94aqRQMo5LkbBb7Rz3Gs+g3tfjSq2Es+dUO5XlJgYp+T1q1h8HjAV2hNBd3RZvBH5W3AhuPZlv5J2meeoR4XGQ2nNMAmblmq92beWdinoUbfjq+DBTjnq/IlBcPhsJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366664; c=relaxed/simple;
	bh=jhACoiKQ3aSvjs+pkiXHJUz6f4bjCQTk8gPucaIHiTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LtBnhQk2k9TTtSPwf0WlovX7pcFvftQ2KtBh2tHczZzNnVqE9emkN5wKNbcP6FB4LYKwTZCmUdC8BKUrGt43ApxAiw6I8X/jdtRhQeMGhrmncBrnFyaoAgXU4sBqaAaUH6Su+XUMUJqkbpsGiN8aXiyqkUXjhJv5vf1dQhKX2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0bBU2xf; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-471ab7a28ffso26256811cf.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739366661; x=1739971461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nRFw9RpF6aMD8n6oflODQC64uRr8iptWae9j/dkj4Tk=;
        b=j0bBU2xffUF8XcqcDhLly0hw+r2J4m4D4d8qd1zz/CjhbOV4595MaWda9GOB4/Hbt+
         QYJ5weSSnFR2G0p7tzGP3v29L8GoBcSn8LgsR7d2d9rtZ+dwdXM2PmXwLKDXi73eWLx8
         F497w5PPOSP9qpedofBdoyM5pEzDIxRoUGIK2wFLzcGX2hS2PgoXUZN6MtvzRYEkLlA4
         HTN/zVbPTUpyn2F7Z85z68LluY1so570TgBlBoqGOvwljltwsd77XY0NqM2ODdi+Ua3b
         JpdrtbGEerAHNQ1br+KGmGKYBJk+5mUl7gWhHYfeZKJE95BmQMVofPp5lAwQ4/4vAAMK
         xtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366661; x=1739971461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRFw9RpF6aMD8n6oflODQC64uRr8iptWae9j/dkj4Tk=;
        b=oe9afanwUZdTKbw0c8OBenvwYxkwu6koCzOaCaQXuhEw8VGqYQADxwu4uFtnt5HO08
         zKbBhqHNVlo6YLnnnpOVz1Swg6QR97UolDItqaeP7IvT/HkufMYP4z7U69W5YW64Du1P
         hzw0bKaTtrUi+9aCBpaFSYkpJcqcjLcPNpwKkQJpv5RU3wjIUDEOTg2Q3fbCHDZtNqYi
         y6TRvjaADrLv5w9NbagMyBIAJ2vVCcXEiLTUqS68AMtVGBOhE+0tBNjtiNaQQ1KkHIAi
         SsQSVcwe9rm552D5rnOgHoI4+clSy6RVKCGySAbJaZLDGgQU6l9/9PQYja7KK4VfeiyU
         Pf7w==
X-Gm-Message-State: AOJu0YwX5bS66w+nf7JNRXdv5Rxmk9o4b4mYU3mYP0Jg6fVHJ59V89D9
	TCOyGKbChnP0o/pxC6O6r+QBm9X5JKMB9B3o6PwiWec+DJZOqZ+d/qx6Uy2Z8+3yFTPW+LGpMr+
	D/SbAI+aElw==
X-Google-Smtp-Source: AGHT+IHRebz6PY/DYCOiWqZ1nZOGI9jVYnzzgYfoxHFzVpstEkFsXwD+6OovXTBpIPRnU24rY1+wy6IVodp1jg==
X-Received: from qtbeh26.prod.google.com ([2002:a05:622a:579a:b0:471:b4d5:2345])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:401a:b0:471:b772:c713 with SMTP id d75a77b69052e-471b772d7e0mr22852111cf.12.1739366661519;
 Wed, 12 Feb 2025 05:24:21 -0800 (PST)
Date: Wed, 12 Feb 2025 13:24:15 +0000
In-Reply-To: <20250212132418.1524422-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212132418.1524422-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212132418.1524422-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We have many EXPORT_SYMBOL(x) in networking tree because IPv6
can be built as a module.

CONFIG_IPV6=y is becoming the norm.

Define a EXPORT_IPV6_MOD(x) which only exports x
for modular IPv6.

Same principle applies to EXPORT_IPV6_MOD_GPL()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/ip.h b/include/net/ip.h
index 9f5e33e371fcdd8ea88c54584b8d4b6c50e7d0c9..1e40c5ac53a74e1c20157709e49edf2271e44fe3 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -666,6 +666,14 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
 		memcpy(buf, &naddr, sizeof(naddr));
 }
 
+#if IS_MODULE(CONFIG_IPV6)
+#define EXPORT_IPV6_MOD(X) EXPORT_SYMBOL(X)
+#define EXPORT_IPV6_MOD_GPL(X) EXPORT_SYMBOL_GPL(X)
+#else
+#define EXPORT_IPV6_MOD(X)
+#define EXPORT_IPV6_MOD_GPL(X)
+#endif
+
 #if IS_ENABLED(CONFIG_IPV6)
 #include <linux/ipv6.h>
 #endif
-- 
2.48.1.502.g6dc24dfdaf-goog


