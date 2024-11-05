Return-Path: <netdev+bounces-142051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920D9BD3A1
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BCEB217A2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BAD1E379F;
	Tue,  5 Nov 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quomWo7L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A231E285D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828649; cv=none; b=Zc57nfMR4oFtWKolAKQsq0CrSv/PZsNahCghOFtFAXR3KMsU4kFQVTfCunnaOAMfvadQZz7Y/pSUxclh2YT2foMgg2il7TjQw7TDHiLqeukXzGy+ZKNjovL8lHx9AKFkOuMgiEi0PkzTkZYn4X9bxqNkH8hfCpVSYOUDlS1eDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828649; c=relaxed/simple;
	bh=MYxeUBg12QQsE/3txUBzXdQMGaMsWXh0F6QpPFKQ/V8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rXXvEGXzLpUDgPdikaGvTCakw7pEeBm0Bm95vDgF5PgEgzQnVRHp1x4B2mAFsT8FxPt3k5OSpIYR5laiL1ay7tIZqtwmngxFlg2Km5jSA09Y0+86LJMNMKE4xVlxBeeSvFLKq8rNGcafb0cU0Sz0pAE7ZcY5eyxGafY/TSyTBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quomWo7L; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so9498300276.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730828647; x=1731433447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xw8/m+j84Aso/IIgICBQUZuuE4Ec8riP8LtcSlAhsws=;
        b=quomWo7LOLRkVa79IeS3NCDv/aear5zRdzx0veIDXCEqpemc8CMpqjh3VMM+y5hMOi
         5T5BNjZBopjB93WNj6AtZu7cOcBk+hsXd9zOJyFcgEE7UDu9lTqEFs1Cq5qwidcxBAz2
         lLPOtMv+SvBggcYhvJMBIk4ON4WUmjJnzq5VEWlg+4DicoHPqH3F9RmB9T/asP+Dx/DJ
         FaBr+rwEzWIQMjzLdHkkCPY13dKVcJn700WTn3n2Xz5be1shYdBvcWhU/q4rGeIqAfA/
         HbccwZLhxRo0H6FQ3RDRkgaIj8eHzCiPONhIJCjKJ5rGq9XVDUdHFGHFKIKv7E/V6xEx
         eCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828647; x=1731433447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xw8/m+j84Aso/IIgICBQUZuuE4Ec8riP8LtcSlAhsws=;
        b=P6oPSXg4Ac8prRTM66RzZsGt0fioeYcH2wTv9R7viDqoVI9eS4NlCh0eelucigQDBj
         o0+p5vbDcjbYS0y/HDOs6zrBZ2Ac38+cPZMG+dJIq+W4rnLPC4V5N5bHR6QMNk3+J/UW
         MJftF8zytEqVkUZKQw0uG9nPckW1KaXBt/CqufcqE/o+xdWvnIe+Jn36aAe3WKP5V7J4
         z+LwoA8/wRqd+qHIofaJ7BKXmJexqWZ+zDn5KbC5ufy428Fv3AftNGNg5LwdacOs/PRa
         HKg0nJChhJlb5VdZde/At09BdQagPej/RtU6ymvzUHoxGcQ9Q7kU7UwIPa4dFyQf7RMr
         jlMQ==
X-Gm-Message-State: AOJu0YwaD+VtrZOIMU7qC1N5HnAt9Ob1Sr/ko4BC4hu2/3wjzAl29EEu
	aX9iKJPKjxIRs3+s4fqjpBl4s+kmttNjxV2+bqGJfTl6OTLUT+tniZTj00d5bZi8Jjyi052UYx0
	SqqX2nAASLw==
X-Google-Smtp-Source: AGHT+IF6+3GnYV4PmgUZ/Wk6hRPbw7wOB/pTGusSdwsgVVWER9yTlBqoGsIAriwFJ+thfacZ1P4q/oTYWX6Dtw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:6902:181e:b0:e28:fdfc:b788 with SMTP
 id 3f1490d57ef6-e30cf4d455bmr16596276.9.1730828647054; Tue, 05 Nov 2024
 09:44:07 -0800 (PST)
Date: Tue,  5 Nov 2024 17:43:57 +0000
In-Reply-To: <20241105174403.850330-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105174403.850330-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105174403.850330-2-edumazet@google.com>
Subject: [PATCH net-next 1/7] net: skb_reset_mac_len() must check if
 mac_header was set
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, En-Wei Wu <en-wei.wu@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Recent discussions show that skb_reset_mac_len() should be more careful.

We expect the MAC header being set.

If not, clear skb->mac_len and fire a warning for CONFIG_DEBUG_NET=y builds.

If after investigations we find that not having a MAC header was okay,
we can remove the warning.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/CANn89iJZGH+yEfJxfPWa3Hm7jxb-aeY2Up4HufmLMnVuQXt38A@mail.gmail.com/T/
Cc: En-Wei Wu <en-wei.wu@canonical.com>
---
 include/linux/skbuff.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 48f1e0fa2a13619e41dfba40f2593dd61f9b9a06..5d8fefa71cac78d83b9565d9038c319112da1e2d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2909,9 +2909,19 @@ static inline void skb_reset_inner_headers(struct sk_buff *skb)
 	skb->inner_transport_header = skb->transport_header;
 }
 
+static inline int skb_mac_header_was_set(const struct sk_buff *skb)
+{
+	return skb->mac_header != (typeof(skb->mac_header))~0U;
+}
+
 static inline void skb_reset_mac_len(struct sk_buff *skb)
 {
-	skb->mac_len = skb->network_header - skb->mac_header;
+	if (!skb_mac_header_was_set(skb)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		skb->mac_len = 0;
+	} else {
+		skb->mac_len = skb->network_header - skb->mac_header;
+	}
 }
 
 static inline unsigned char *skb_inner_transport_header(const struct sk_buff
@@ -3014,11 +3024,6 @@ static inline void skb_set_network_header(struct sk_buff *skb, const int offset)
 	skb->network_header += offset;
 }
 
-static inline int skb_mac_header_was_set(const struct sk_buff *skb)
-{
-	return skb->mac_header != (typeof(skb->mac_header))~0U;
-}
-
 static inline unsigned char *skb_mac_header(const struct sk_buff *skb)
 {
 	DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
-- 
2.47.0.199.ga7371fff76-goog


