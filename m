Return-Path: <netdev+bounces-193186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EB4AC2C11
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 01:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C07189079A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4A224882;
	Fri, 23 May 2025 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6iUBZ+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F522258E
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041544; cv=none; b=Ma+EUaXHoI/iZIwulB0aMK0GLFgEeqgRvhiUXpgcKA3Y/mOvA1psAGJVT+SH2KcSC9T0moQibMgmJztrodU+zek+atY5egpitSXycwIvW6b7kKoBAsJ3eUFx3+JIVIdkTDi7ZrkVLOvK5G56KjIK4RPk38ONj+Fun5tX1uYu/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041544; c=relaxed/simple;
	bh=0JqtZHm1FjwTp/r9FfFXp2DhxiRW0Bdbv5viNa2gMfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F0WfqBD4HsX5FtijjTLYU+HRiCxt2eRc1sra6jxO5y8Tu0cUvXhFi/vRLuk3wY3GvdjEr/PS6FMOgFkMO5achsif2hexmTusIGZEvKOyJMjdqpiF7v8t2yF36QhdgNEwOCN6NMc7URfPFsHn6pe9MhsBoP54gQD//RyPqIzvDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6iUBZ+9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-231d7f590ffso2179855ad.1
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041542; x=1748646342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9027k/STZBsLuLsL7i9IP6pBTVAG0SO2AdEyoxFagU=;
        b=R6iUBZ+9HVQ0voT5m+RPF6iohB8uARMGrHOt/QAtNhActs24wu0LUZpv9rmD9UQPKA
         7yYVB/6ZynPCnYCMgYYLn7Xzb3f30iagRVmduoJ/cbrN1WfKN6CkmHINV1xcKHUGHUox
         HBVz2TmIHqHoxG+JSj+2OjffHWR/6+UjiYQBBuQ8wsQEXGPQ4tMjaGP3Gj87Fy0P+its
         okRYfbq0gQwBQGOd2rlYAORqCZ2N0mphubNEDbvd+q4ILWY2+28rW6kBOMMWlFAfo/vi
         B+rahlr0S9MvwlbDetoKWBFcCIX3X191jA+N7EFGLwDkhVO/pYUi6lRRcSH+MT65me9b
         BFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041542; x=1748646342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9027k/STZBsLuLsL7i9IP6pBTVAG0SO2AdEyoxFagU=;
        b=lJnZhDxO4RC6yazUNuZ+m4gUwlaBW18k0qcHQNOUjmtqyWkJ7r/iA5On297nHqE/Uv
         IGpJ1xjsOypfqwfgHoIN/BjUs+VDPKNY3B0mP/8gCNEOIJIur/yrnT6TMMzic+ecE2Pt
         tcU//brNIZS6+P8p33DsGeqy8CsISwGvqG/+/plle2JuP1zlG7Mxu1qPEQGZwJUtXLyQ
         nbs4NuT7GiiHbOam1/6pX66bJlSfDrztmDJh84CrB35CUfVRpTziBvKQqGJWa/rtScam
         bAVBvpU+CxonXqyqVrlw51KuTg4QipiUlflll7CMx7r+wfKMcn/153Lvl2yIpO4Z0LSE
         cPUA==
X-Gm-Message-State: AOJu0Yy3Ryq8+cdA/Wv7cHQXfejfFsBzL3cHqMnM+RRG+cUwXadrDaXk
	w3SIhAbU0X94jt1//PzwZVgu0KhzRi7HLpfbeNE/wLHThUJfgXzJs1h/FLbVRu0lyyByj2pFqqU
	FISUfYdX98h/HkQ8bdYbXqjJlp51Jtsc+d88zrepuc5HdN6q3gZgggSy5JthajNHt0e0HBwxHuR
	te3KUCVvsUn6T6Ww8HHyKIDxu846PIZ9CMUHQ82JB0XXGZXuuuazthRiE+JNTtTzw=
X-Google-Smtp-Source: AGHT+IHn8TkCdj+ni+aC/DsrAqi9Ur2+n79I6LNfYvaRRRjb46r0pJxbHJPzmzbCwlmXoCzWPkQvZhUhuI8g+DiH4A==
X-Received: from plbms3.prod.google.com ([2002:a17:903:ac3:b0:223:294f:455a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc6:b0:224:2175:b0cd with SMTP id d9443c01a7336-23414f689ddmr16906845ad.26.1748041542350;
 Fri, 23 May 2025 16:05:42 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:24 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-9-almasrymina@google.com>
Subject: [PATCH net-next v2 8/8] net: devmem: ncdevmem: remove unused variable
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

This variable is unused and can be removed.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 3c7529de8d48..03f0498cdffb 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -537,7 +537,6 @@ static struct netdev_queue_id *create_queues(void)
 static int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
-	struct netdev_queue_id *queues;
 	size_t non_page_aligned_frags = 0;
 	struct sockaddr_in6 client_addr;
 	struct sockaddr_in6 server_sin;
-- 
2.49.0.1151.ga128411c76-goog


