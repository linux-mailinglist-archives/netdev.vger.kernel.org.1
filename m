Return-Path: <netdev+bounces-150119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29FA9E8FB6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7486D280C8D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EAF216E1A;
	Mon,  9 Dec 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kosHdIfK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0971216E0D
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738876; cv=none; b=jMXws8BklxQCJ65KBTNcpRnh9DzlkEqTmQYJwCbcQUThAdu2bj8JuQ0+LyvWCNBuKzlkf+QnZu6tnURB1QPK5wLJ0ycTPrIZ+cxN9ARq9/NmsK0T+CBVUxlK8paXMOSGCEh7JMrKyeUCiFxmecep4Wbpl+7i8CN7AeAKq0rOpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738876; c=relaxed/simple;
	bh=8xxlCLEmX5IzwHr+HlPsh8ho+d8E+ltz36Vu01KXIO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xk4H2AbaJKR8uHbF8R/f7Rz8tOMx9PJJqqcjzgUOC0mkbix6OFa/SVu9/S4GhI52B3luvgU63RBtv3pzRwAwKeGxcFzNTQT5PP27OClYqJoHnMm7XkmWywMLXJBixCgROJ54AYnGV3Wi/t4vp1JFndHFJ6h6v5V1f/bqy5u287g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kosHdIfK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e38902a3200so8496020276.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 02:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733738874; x=1734343674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwMO66CnlgZQswBuDJJhAg7/MBDE5Pzh4mwB6lYj7Ys=;
        b=kosHdIfKiXj7yWxwoA/sB+jj2kt82cIT6tzIXc+n3HOhrrbHVoAXNMM/A56Eo7GncK
         CtkB4ARBJi8IJs+tfRS82zgfxhXjIS6fwcjFBQQTmfvZtFJxPrqiPWQ0svL9dobJgNxX
         IsGG02r3ySohmVL07oJfaMBZZTs7rSLBrsgU6j/ZgKZ9qTKaEq+PifuvyZW3L9ZGNZ1T
         i4p6FSPJyMCKMNXF+/3w1qky7HIZideruqGimLFv4By6PxdF6VVzktGYVOznJVgk+yma
         HcIKQQUHZ+bbBTkbNuqqG2D9F2hDqiCGVrc6RGmC5G8cj//htDxW7V6wGT6Dcf1Q1yPS
         jmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738874; x=1734343674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwMO66CnlgZQswBuDJJhAg7/MBDE5Pzh4mwB6lYj7Ys=;
        b=GFYtu2hNamMTZQ5c65eXeBBhG5A212uoOgDkW508/8lT4c+r9sepJk/qjANfR0+KcY
         1hcow5LIBqV3+SM7/sAGGSdV18/ZeL5hAx10BIYuWiat5c6OSkr6fB4bPUMKlcB5pCsz
         tUk0X9LO8LidRly2v3EaghkQO0b9EgNE/JjlwDjDPSmz8pZ/YNOP5Bc4HqihL8vW2uKw
         EwBXSUPdIamkmzErmXSf8zaS3FHXixDX9Y+mG1Kfnsn/2EFQOBVU7ORgnXeU4N6FTVtP
         TpuGrKEDWvKo/D7DyBT11go85Sk1l2mS1b8QodakkFgCabyLQBzHrlTO+BZ/t+JTXSnw
         FN9w==
X-Gm-Message-State: AOJu0YyTWWOdMRNJ3HJfi2YXA+8BjzyE2NEoBvbUycsHbUU5foFi5MAo
	5YoSg4nA9izf/ju8I12s4YeJzj2/VyvGBip+uqn6gw1BLIl/Niq77aru1MKBoDHWK8hI39x2fK+
	it5s3hBfy4g==
X-Google-Smtp-Source: AGHT+IHs0DyW1RDgo3EvbunQHqAjGHyqm/3WruQUE68Yg+3cozyqkpZ2pUgzoTnpm1YQnPMXjjnOLmfaZqyNYA==
X-Received: from qtbhg22.prod.google.com ([2002:a05:622a:6116:b0:462:4391:1c48])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:2b8f:b0:e2b:e0ba:d50 with SMTP id 3f1490d57ef6-e3a0b072fccmr13163722276.5.1733738874021;
 Mon, 09 Dec 2024 02:07:54 -0800 (PST)
Date: Mon,  9 Dec 2024 10:07:47 +0000
In-Reply-To: <20241209100747.2269613-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209100747.2269613-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209100747.2269613-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] rtnetlink: remove pad field in ndo_fdb_dump_context
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Ido Schimmel <idosch@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

I chose to remove this field in a separate patch to ease
potential bisection, in case one ndo_fdb_dump() is still
using the old way (cb->args[2] instead of ctx->fdb_idx)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/rtnetlink.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 2b17d7eebd92342e472b9eb3b2ade84bc8ae2e94..af668b79eb757c86970b2455d9d820c902699a13 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -181,7 +181,6 @@ void rtnl_kfree_skbs(struct sk_buff *head, struct sk_buff *tail);
 /* Shared by rtnl_fdb_dump() and various ndo_fdb_dump() helpers. */
 struct ndo_fdb_dump_context {
 	unsigned long ifindex;
-	unsigned long pad;
 	unsigned long fdb_idx;
 };
 
-- 
2.47.0.338.g60cca15819-goog


