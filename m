Return-Path: <netdev+bounces-249159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB911D15270
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 381443020CC0
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F332548B;
	Mon, 12 Jan 2026 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dz9JdIE8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA9B32D0D4
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768248467; cv=none; b=YEdGWbbCCrnpEvCAPCdaGFTDmNd2ps1GoGYMFMVCR0vCTAZlgbf1p7+/U46Br8HsTGGCEocAWH9MkrvZj7Jy7lK9jYK1+nxTC3o1yP2u0Khj2F9hbUMivdukImIPfFtmFBWtHxWNI/YxbCEtQyv4L4t8+lJKyAZLbUQqSRz5VI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768248467; c=relaxed/simple;
	bh=XZu+AC6pVZqMGZzpWzCVw5iXRSSmgs5l7rYG1GfgkBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZjxQH4LYJhYfocqMGwRTiMEhcufeec6YqtMF8IjEAVQHDLCO5zxtlOSlkT3Bgb2O4qT+WeIt2b48L4bUbTaUybiZ80BiuhO0X6rQEm5I3wRbt7yCoOLc2h2e9i5QEzHaF8aXlaUxvaq9bvG6vbsWvA2TEVvwKjq6ZtQYnLSUwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dz9JdIE8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c5539b9adb8so1997285a12.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768248463; x=1768853263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+RxrWhXLFzG65d3qN5fMt55OpLuXZKS7OOAWYOQZr0=;
        b=dz9JdIE8ig3APSm1Hhs/+sTNlC+HHeWT7j8luROILW7SxOpbRcnbid+DiVENOGP0EJ
         Vn/e7bgKo2IIHqyX+RHcQsXUQC9x0UhkIkb/7uy1AnTlLKF+zQpEPZOzWE46A9W3AbtV
         eGPgi2X7i4Gj/qbtpu66cEvf8oBOEOIApiOl14VaQMhPbr3Tu7G+uFcLwF3VoaFNy1pQ
         GPCEsYOFFIoUInHmcupLTPx3x4HPjJY43kBHzIjpy8yByvdfByY9EJ56ld5HJeHQzObv
         y23VlkCJPi53TF9FqNMZt9uQp0sU8SzRgSj5OdnSSqlYpdGCLW+5b2ns0ApFhkNlkeld
         LXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768248463; x=1768853263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+RxrWhXLFzG65d3qN5fMt55OpLuXZKS7OOAWYOQZr0=;
        b=Q+3dCAW7MkAOkJqWFYNf0SaRJEUCy3znlle0C6fM4AIlAHgPYBLqke687KxtseiHhy
         kKGUqrsctNZraye7vLq7vxQQl7hvocgXowwZPdSVFRIY8S+JTDJ1paE/gp45tPHAa7u4
         3tTq6XaSWai0fVtArkiL3bmflM5Q9282ynv9plE99b4QD3L48V8+pFobSNCTNudFBTYZ
         MUXm4GF1JpOKgKBx3zdi3AeyDQYYbBTnJY8/vX40vOgiCmfibyQbVW54jvUeLL8J5cOr
         780vEqjXMQrBl4dsosjVhRTuGqUN9Y90ehRqPsnOIaIthUhK/Xoy8R7TIwiXJy9Viqkh
         71pw==
X-Forwarded-Encrypted: i=1; AJvYcCXF6Bq5f8UeKMKLT4m1CaghWIYjtMdX2mALCv5V3SGfP5U6b7/wlx7JvGiS7Ymxuw1t9cvMTpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTxEhrJIs7MeZlxjWL44euOOcwMhnbVD6PJkYOCcICW1hyTfu2
	M+L7Ofu3QJ5HSTFROF+NAvujc3vwB5TUVNkFvOsJimeC5tMZzkINLLqlheFDz+0qYs3IIBjCmtJ
	v4LS8Dw==
X-Google-Smtp-Source: AGHT+IHXIT9jbEPSbejcGntrDI3W4HtKILOyWXanpsY6AU+oDQKwB52/kh8OT7isQqyNkmd+DMhgU89xTK4=
X-Received: from pjbkl4.prod.google.com ([2002:a17:90b:4984:b0:34a:b8e4:f1b9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea01:b0:2a1:1074:4199
 with SMTP id d9443c01a7336-2a3ee4c10ecmr173693495ad.32.1768248462938; Mon, 12
 Jan 2026 12:07:42 -0800 (PST)
Date: Mon, 12 Jan 2026 20:06:36 +0000
In-Reply-To: <20260112200736.1884171-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260112200736.1884171-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260112200736.1884171-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] fou: Don't allow 0 for FOU_ATTR_IPPROTO.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Tom Herbert <therbert@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

fou_udp_recv() has the same problem mentioned in the previous
patch.

If FOU_ATTR_IPPROTO is set to 0, skb is not freed by
fou_udp_recv() nor "resubmit"-ted in ip_protocol_deliver_rcu().

Let's forbid 0 for FOU_ATTR_IPPROTO.

Fixes: 23461551c0062 ("fou: Support for foo-over-udp RX path")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fou_nl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index 7a99639204b16..0dec9da1bff46 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -15,7 +15,7 @@
 const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
 	[FOU_ATTR_PORT] = { .type = NLA_BE16, },
 	[FOU_ATTR_AF] = { .type = NLA_U8, },
-	[FOU_ATTR_IPPROTO] = { .type = NLA_U8, },
+	[FOU_ATTR_IPPROTO] = { .type = NLA_U8, .min = 1 },
 	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
 	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
 	[FOU_ATTR_LOCAL_V4] = { .type = NLA_U32, },
-- 
2.52.0.457.g6b5491de43-goog


