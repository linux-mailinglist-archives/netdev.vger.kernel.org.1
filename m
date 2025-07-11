Return-Path: <netdev+bounces-206245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52563B0244B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1816F16B83B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D342F3C2B;
	Fri, 11 Jul 2025 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mb59gfCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CFA2F3C0D
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261027; cv=none; b=tZMRqZVbFrqzF1D3vXV17Xq18ZvmTPP7mIFyAgJJ7/3ggZBOUch9Mge9iOZgKAnLdGHUFvRq0f/2f0+FaHFxTCmZGIyuPt8eTs1nwL1TJLnnoL6KtLd5k+0mKkHjMLJaIf/bGWTVZNjD4Ge9J56Duy4O33Kf40UZoDGPi8A57UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261027; c=relaxed/simple;
	bh=afxFgp7+DxgWy70N0aJWpnxw7SEgoETWrdWJeOqJ+lg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P0QQkbUb+iMPKtmIw201kv3HXE5NALQ5+G/uHabRDXtymJ1FmC7qdSjNctvgkv1D+HoCAc58jMhf56m99OYVTwrF841zdYUFhqHPNZnR8L5Sl72Dn+mVJG3X884FUQQmXdrBBMe7YCI769zPiSd8UYzEZOsW8ClaZCeJXd3DDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mb59gfCo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234a102faa3so18445295ad.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261022; x=1752865822; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+vmelULdOP2oyeTqkHP7aVERGND3AuW4vvp5WniXAo=;
        b=Mb59gfCobTDZNdDpgDV6M5BtlzA+KCVGb4fok3fA4t6JAAaUfCcCreFOXdZPeIQ/EU
         r0EpgdhBGLvnRUlE+aQjJYNBto5ZximqiygUcqx5dwAUMqcIS3d3wv29nqsqvqtePI3u
         tE680P63l/eLsivfICXrIij8klwo49HqfRTGssyLhOTvXvrkvAz5d6M7HzjE71VcgW7L
         XomM6KLVJ7xP50Trpf18HXzF34cxM4dNH929Oqgw8LpmJjC1lLe6WsVHfU5hpQhlgDas
         pz2uzU4VeOuIKRrVaU0648zkCufZRLK3uhwC5mprZwWo1rNHbe9yuw62tKMqbvtiCdpI
         NvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261022; x=1752865822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+vmelULdOP2oyeTqkHP7aVERGND3AuW4vvp5WniXAo=;
        b=RDZvjiWF9773ATJdf+Tb1qHmfAI/h9o6NPPa4VcGPb8A4uU8Wg2tvt7kDw/xSUZHgs
         QOFyHgkbU6wc8t+sc+LjNq/cTtPSRMa1UG6ZOd43GQWTpAkA6Itv4+YviJDO7uy335OS
         ix+7NfhSzglCBJi9Q3M0j/NG32j5/VfrJ7p3RrBnvT2SZv9rfP0GGaO6GZOwxVNI/r9d
         dZue41qJCU281I5RPW0emwjl9HlfS+a99WbxRhzz1k//soiRYZTFkpbHPXY3QZpnKra/
         KR1uN6pJ6QFgjTzRzOZIv+AFbwrpPAVYGO394PXAAHRR3zyMlBtBmZVIhz9v4ZHKSHHk
         AWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtX/ETyrsiVTdOMSfIWMhu8q6cFX7KzPbAqOv92yA8x0xwXpd72C40qG1JRTcLJtBqjf0zECc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WOpG6zIAKunFBUF915cPOGIK9R7p9ZqwgxltCSecNz0bjkOl
	AD/dLCV9eW6oDY7H22QwVa2UkJDP3Vj//m8C96gVZyCzT2X3u0Uhdgyg8M1ZI0XyvgSM1bOymhM
	bTnMrjg==
X-Google-Smtp-Source: AGHT+IFaCbaLxmywoQSzp8GTN4Nt1kAYGuszskef9QlFPYllVc8NVbK18pbB9jCPxHePvcvoY/tX8eB6IkA=
X-Received: from plhy4.prod.google.com ([2002:a17:902:d644:b0:234:46ed:43f1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a68:b0:234:8ec1:4af6
 with SMTP id d9443c01a7336-23dede9222dmr60681935ad.45.1752261021970; Fri, 11
 Jul 2025 12:10:21 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:12 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/14] neighbour: Annotate access to struct pneigh_entry.{flags,protocol}.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will convert pneigh readers to RCU, and its flags and protocol
will be read locklessly.

Let's annotate the access to the two fields.

Note that all access to pn->permanent is under RTNL (neigh_add()
and pneigh_ifdown_and_unlock()), so WRITE_ONCE() and READ_ONCE()
are not needed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6725a40b2db3a..e88b9a4bfe6ea 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2039,10 +2039,10 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = -ENOBUFS;
 		pn = pneigh_create(tbl, net, dst, dev);
 		if (pn) {
-			pn->flags = ndm_flags;
+			WRITE_ONCE(pn->flags, ndm_flags);
 			pn->permanent = !!(ndm->ndm_state & NUD_PERMANENT);
 			if (protocol)
-				pn->protocol = protocol;
+				WRITE_ONCE(pn->protocol, protocol);
 			err = 0;
 		}
 		goto out;
@@ -2678,8 +2678,9 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 	if (nlh == NULL)
 		return -EMSGSIZE;
 
-	neigh_flags_ext = pn->flags >> NTF_EXT_SHIFT;
-	neigh_flags     = pn->flags & NTF_OLD_MASK;
+	neigh_flags = READ_ONCE(pn->flags);
+	neigh_flags_ext = neigh_flags >> NTF_EXT_SHIFT;
+	neigh_flags &= NTF_OLD_MASK;
 
 	ndm = nlmsg_data(nlh);
 	ndm->ndm_family	 = tbl->family;
@@ -2693,7 +2694,7 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 	if (nla_put(skb, NDA_DST, tbl->key_len, pn->key))
 		goto nla_put_failure;
 
-	if (pn->protocol && nla_put_u8(skb, NDA_PROTOCOL, pn->protocol))
+	if (pn->protocol && nla_put_u8(skb, NDA_PROTOCOL, READ_ONCE(pn->protocol)))
 		goto nla_put_failure;
 	if (neigh_flags_ext && nla_put_u32(skb, NDA_FLAGS_EXT, neigh_flags_ext))
 		goto nla_put_failure;
-- 
2.50.0.727.gbf7dc18ff4-goog


