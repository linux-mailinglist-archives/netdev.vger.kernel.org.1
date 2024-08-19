Return-Path: <netdev+bounces-119731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00104956C6B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB071F2232B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315AA16C879;
	Mon, 19 Aug 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubUSnYgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6C1DFEF
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075316; cv=none; b=UJNIX3XizTbf/8L8lYyTUN2cKCkwhFWC/tw32k6iYtn/hZsO9ksX7l6SudqUjtf5CDWQqltVm6T4V1xWw15msgE3I1wH2G/cjJYn6V+/w4VYlgBp+VeNroYtaJbg+upIsz7qzIqLfMSF6PjCrfF1RDBFPFzp1d3i0VDA7PrMb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075316; c=relaxed/simple;
	bh=hzivC0QY8/OrDsjl0zLN3oA5RAsMUhmZXb81iP5BZzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ehlf3KXCmx2uYInc+poqXnz6Z57DDonG40aHB7Kho1eVT+oEm3WhMHAbXnPU9XZdKBPUnDyL8el14A3qwfTLUExvI/HC691bfikk3YDcptop116+mMuEQaRNDLjJJopcXsflZKQLgeSpuVKPbmdj7nR4hf+fsHDK8FHAOu7cH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubUSnYgt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad97b9a0fbso82520007b3.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724075313; x=1724680113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E28CXQYWoYPohvZg7/J6bFm5MrC6YxPoWTodXDcnZFU=;
        b=ubUSnYgtRHEM9LsmYbhxY747XGLFfs6mcGmgq1WubaqzQ19Krbd2U5ZoSFHyKNyNjQ
         xVhwvUCTnfE7UJ11rY6xP/clphdGOq/bfgbfJ0jWck+/DhkYr3zF+gBWofkkfcu4R2i7
         UT+bkv56L184FIwzINCtPLU8MSxF+LBaT+/AOMXqf4pGHlzBih2gbXq6/A6uwUUeuHC5
         fn/AGo3FCPfJCR/LxJoxWlZJ5IDsOW0MXmY/0cObUxJMl0sf2zfElGzEsJwsgSRjD7PT
         rV6rzI8b3fYTI9/SsexAVn6MA+Nz1DV9nfZCkJbdOBVwFOJcIP3gfi9d6+nLGLubeiw6
         UOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075313; x=1724680113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E28CXQYWoYPohvZg7/J6bFm5MrC6YxPoWTodXDcnZFU=;
        b=ZhSsu1enzsP6QVuyqCQ4h1V1e+zSzvQTZl8AEyQ8pr2r1qzuNQMtmshTyBJIdWswTK
         8ejNhMZ1A9xpJPLrDlI2m2JSqh/Dp2kbjrwkOzJBa5RIIhHIkRgvLOomLFXBAgBogyt/
         K2VJbQZeZz62wqkpsNF/xVYcem2O5fzRTGf1Wq93tRWcEO8rAbmqE6QfjMnzL3M68AEe
         KnkyTRRkXo5pc2i9hMvPP9I4Aj93tTGApPPW2mPJpS1uPCqCOKDnvx9ZDLg+Ugid4oC3
         pFpWgWfDBHT4sbeNx4LWoyokTsOMRHCLgKPk/fImpiHGU9oEk7PjmQzdDjeafc+PWLyQ
         wgPw==
X-Forwarded-Encrypted: i=1; AJvYcCWGPuJvnAHd0bxr3M5dh54/2F1hMzwigzaK80tzn6Rl504aZ/QCaNrpGlTlGNtlZoEwdNSeqKZQhVQtqXL0p7S+XpfIwFgK
X-Gm-Message-State: AOJu0YxkHZZWdnxP2jmYiNKHv6La9tkuB7qwyHDdrDugsTmixuMJiqjk
	2YRXQengw5tyGVAZ+nEp8QEXW3L5prfhs9SHbTw0EYIqOq5odvv4r19MpGcmtYhvVg2a58J2Ll7
	fl5NXKTxn2g==
X-Google-Smtp-Source: AGHT+IHQgYLbEquFrfoUiSkjfEhiT4oGHVosZbBEM0PwIzzCJomv3d034DZlpLXRcNNdr1N4Y5t1trCaoNAb3A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:abe6:0:b0:e0b:fdc2:4dea with SMTP id
 3f1490d57ef6-e1180e7ba5emr17110276.4.1724075313553; Mon, 19 Aug 2024 06:48:33
 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:48:26 +0000
In-Reply-To: <20240819134827.2989452-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819134827.2989452-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819134827.2989452-3-edumazet@google.com>
Subject: [PATCH net 2/3] ipv6: fix possible UAF in ip6_finish_output2()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Vasily Averin <vasily.averin@linux.dev>
Content-Type: text/plain; charset="UTF-8"

If skb_expand_head() returns NULL, skb has been freed
and associated dst/idev could also have been freed.

We need to hold rcu_read_lock() to make sure the dst and
associated idev are alive.

Fixes: 5796015fa968 ("ipv6: allocate enough headroom in ip6_finish_output2()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vasily Averin <vasily.averin@linux.dev>
---
 net/ipv6/ip6_output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7b53effc80f8b3b7a839f58097d021a11f9eb37..1b9ebee7308f02a626c766de1794e6b114ae8554 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -70,11 +70,15 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	/* Be paranoid, rather than too clever. */
 	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
+		/* Make sure idev stays alive */
+		rcu_read_lock();
 		skb = skb_expand_head(skb, hh_len);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+			rcu_read_unlock();
 			return -ENOMEM;
 		}
+		rcu_read_unlock();
 	}
 
 	hdr = ipv6_hdr(skb);
-- 
2.46.0.184.g6999bdac58-goog


