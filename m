Return-Path: <netdev+bounces-76148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2BD86C836
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DCDB233EC
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FE7CF23;
	Thu, 29 Feb 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADYsdvWU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0C7C6EE
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206829; cv=none; b=OkkJPGg2M9ipRRppOORD9ubqjbiZne/Mtq+4Q++VciA99jyVZLjJSDrlvj4yU1LchxN+BFORSBXZDTXj5KSB3+XjuuS3Z05l3EMvzxpg7pltzliBJncWetzqkkMOSfe2++49RczpTCBlsShw8tr2zoPkJEbzoTZM6SnsUSvD/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206829; c=relaxed/simple;
	bh=0YBJA22pQ9qE1ccUmGRibhk+TabLTZK0752CMfNwRyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mUOLTASgSOeFX1NHbH7PwjjOfuyEl5Xp8mZkloiwvR24QvSHCjKxNoMNH+hX4MD4+d1+rVI0OVNy3IdiLPARj6Z84M4nKCe4bTMW/JJ5mNrh8lXGkUlUHGCsMK8F8A3mUAymD9RztXSuoc/4JUqxfQaIj0exu1uw172Hik5SyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADYsdvWU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso1425330276.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709206826; x=1709811626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bweT+L7/wL6TdY/2iHKZCZXbLKyR1rcYmUPmhmttVEE=;
        b=ADYsdvWU1hSjS1XYUucpBwMuPHSW2EmJMCKCUae0CbNy1tvsJDWNTKEThPHXOSHg35
         gtyjJ11J+isE/JKTO5y8ZDEbhLyiu6yuXajTB91te2uz8Lw/Yj28CeduGdaUHbie63iw
         8r0Km0266iOzFHpx/TxPcLI5Q+wnyxXBMeDh3DE8AKcKXOz6omwW+pMlByxAXxq8gYsh
         WY3DwwOjFxhLw43LkPLOGA9coRK7IYV+25Vv9SkjNxW9BKL15V0Z9VGhvZbY4krhY4FP
         WSFbBxktLW1jSEH9xcrJRel3E17ux6+ZFoYaqQ/U51iiuAJhoakaPV8hhEo/NwEqSAiq
         AzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709206826; x=1709811626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bweT+L7/wL6TdY/2iHKZCZXbLKyR1rcYmUPmhmttVEE=;
        b=tbBmC9fcs8d8hqMDDkNBkUv8hzgbUM4f5ug1Yhe6vOIxzpdzHl8sWFlvPVFBQVEsdL
         Qbzodz3csgG+u+eNohUuUqF3Sm9+SGXGcfiYmoZcOn2WheJ4ZlL32NaKSfrzpTZOINe1
         MmA6IFtzncHluoOeHAj3nSQct9FIuYWtzC49FlwgdAhETeC4YFkOCAZUp/Hc5wegdDc5
         kKAD2qlJxpDkSvoYwe5c2A67VNx2ESXxohxi/tWd3+D+p0cCBx1MwFjZCyAoNGnmUKAP
         0aj2eykSza6akCe1cE+PBhsezgzRazVCwgPmR7KARBXPYCnVlI9ZBKDHHPgJLKC182s+
         PO2w==
X-Forwarded-Encrypted: i=1; AJvYcCUD8hy2MN7jfLMG9x95u5IH7nq33NK7MvElqy1APnDotGig740JlT9z7Q25tiD/xounUSWpWXCNm3mE9JP5aZ4v/woDcJCN
X-Gm-Message-State: AOJu0YwopdLg2A0FqBqWY4QJNx1DnxPm2BgYb+AqFM7YcPgeDw1jl0zU
	3SoAsuE1lDzMURLHIz9GnQMskb+rT4RKTuVVKjSHUkiRoYk5qhPRPOQAVCxsYIGj528DwHofi0/
	Rj+2rOqil+A==
X-Google-Smtp-Source: AGHT+IGOqsF0ldtQvO+F7+VmQ1WQuQHAfrYPddGNVdFARqyn/VSTDo6faDmemcuCpH5t5qzkv1gEMukN5Xv0Sw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:a8a:b0:dc6:44d4:bee0 with SMTP
 id cd10-20020a0569020a8a00b00dc644d4bee0mr75218ybb.7.1709206826712; Thu, 29
 Feb 2024 03:40:26 -0800 (PST)
Date: Thu, 29 Feb 2024 11:40:15 +0000
In-Reply-To: <20240229114016.2995906-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229114016.2995906-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229114016.2995906-6-edumazet@google.com>
Subject: [PATCH net-next 5/6] inet: prepare inet_base_seq() to run without RTNL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In the following patch, inet_base_seq() will no longer be called
with RTNL held.

Add READ_ONCE()/WRITE_ONCE() annotations in dev_base_seq_inc()
and inet_base_seq().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c     | 5 +++--
 net/ipv4/devinet.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 053fac78305c7322b894ceb07a925f7e64ed70aa..873e095e141db3e631e51763435ddafbf0d280af 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -180,8 +180,9 @@ static DECLARE_RWSEM(devnet_rename_sem);
 
 static inline void dev_base_seq_inc(struct net *net)
 {
-	while (++net->dev_base_seq == 0)
-		;
+	unsigned int val = net->dev_base_seq + 1;
+
+	WRITE_ONCE(net->dev_base_seq, val ?: 1);
 }
 
 static inline struct hlist_head *dev_name_hash(struct net *net, const char *name)
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 550b775cbbf3c140c66e224c69996df7051b3d36..2afe78dfc3c2f6c0394925f1c35532a2dfd26d71 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1837,7 +1837,7 @@ static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
 static u32 inet_base_seq(const struct net *net)
 {
 	u32 res = atomic_read(&net->ipv4.dev_addr_genid) +
-		  net->dev_base_seq;
+		  READ_ONCE(net->dev_base_seq);
 
 	/* Must not return 0 (see nl_dump_check_consistent()).
 	 * Chose a value far away from 0.
-- 
2.44.0.278.ge034bb2e1d-goog


