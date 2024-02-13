Return-Path: <netdev+bounces-71401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8E8532A1
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E594B1F27282
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC457329;
	Tue, 13 Feb 2024 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1l0JnQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB72E57315
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833190; cv=none; b=T93BYVqu7ki8gEfGf3BTvbBTGB2sqpWUlERqkcmeHdXdg2f436pY+W6kU0wyTnaIvRyvwaoYOalZG4QN5IMiwVMgAeFCbSDBC8juSE2YsCMZAqpSsNKbJzrgVZ58EHj4x3D7DuNGhaJkUu6uVBqQ7dh1TqMc4NI9MU0JpiycUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833190; c=relaxed/simple;
	bh=TStINRVFhm9HzVI+/oSLRgbCmC3937DPOtZqDEpQyOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/mC0OAFwScmppivxmpEbYW1rPcKQtmgDtDwqseIi+h8t+BAkQ+bR38Jh/SiGBCx63yaZc9CrHsV9GDAKuisaEjnBkgoGz2A0vcljF6Xn0tCWweOGaV2MRskLCI35t5hJdOLVy0sW1/kwY5Q5WZxYuuw+oaBKrT3p1qa+H4uA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1l0JnQA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e104196e6eso177788b3a.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833188; x=1708437988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNRRMX/M9s6K5W6pc2GtqVUZ7M9Go0EAy58TztDkPPw=;
        b=b1l0JnQAAhOeJIOGK9Q5c3oevzxZxvTqap7IrsacjNlZUsPEmGrZxmhuop8PtCTH9k
         e/iSXZ1qI1oUDJBPKsfYrl8JI4Z5qI3DN4vZs7sQ4RdT8OV1OUjslyfqx+U14/qZvG8/
         JFGE+g8dkSUaJhsNayPPJwTt8VYqO7fHPN9HCAcFavTsc+Rw0Jg/94m/wJnumqXSJ6bD
         OUgSvk09VxX/KrYoMiKzDJGw4AcFWsLWo2YtbWsGkjVn5+63ZMkqOAiZCK3oqDCsoj01
         b0GUx8X4XVP8HxENKC7qjcpp6uCppOkSsmOABeVKsfcNoxVHY4VKB64V7OHexxV7HWwE
         XPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833188; x=1708437988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNRRMX/M9s6K5W6pc2GtqVUZ7M9Go0EAy58TztDkPPw=;
        b=e7PmCSmdcSCOOts/0tZQlhWcQ7wPikmpE28JP6XAh6o3dL6qaW1KmXHLN7nIA5UJE4
         gJvA9RLCTe6GD45fDntqvLzYP9fh/oxwLoMJsySCwL/U6JjQia3n4uc13YgADM5qkJLt
         1x8YuX/4Y8tZhDqGoNUWp7ltNa2w9O7QDC1NOIBpKzn03CcncZXTu5gKHX+FfhEMQCuT
         q+7D1UBVN4wyjOm7rAZFa612gg5LxL8FF8HTXE250sREn/sHX39zQ1qQfcQ36Y4MlU2r
         2wJrv8LAQocJpb8KgANfBkchKOcrDN6b6iHwhjI4g7QtS+jDMmst2/L339xFb+CQadxp
         KG/g==
X-Gm-Message-State: AOJu0YxqSltiHcTkBcZjdRXBhOTYYqCP10rPinXXwoCNGfVNHPYq+DqG
	OLafrErlExshhQSeKTuHl0ERCkRUe3ZvjlRyw7RqRb6fBrhiwDuA
X-Google-Smtp-Source: AGHT+IENFQQguds0gUVknQFIiWQtTE8ZCs7a4wrfxwxqxgFweytQakcsMYOvVFeX1+013XuuBZfPLA==
X-Received: by 2002:a05:6a21:3a81:b0:19e:cf1a:5372 with SMTP id zv1-20020a056a213a8100b0019ecf1a5372mr7772656pzb.34.1707833188269;
        Tue, 13 Feb 2024 06:06:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDEXDrZDzYzZ+BrHZTEYSfJB7O43mofO+RFJGWRa2LzNm91QvP9XU5MkPYKtbA9tbcuK4H7GEzYdTA1HsISRNWe9U9FxPj7oFsIzjZq2xRhkGm0FsI+4GmFC6DODTQqLLYdcFrEMsQz2YEbgDfvW9XhWtCBPMurLmryMMmLsXTNmf5FWCmtw6864LJFMLsdSBX55EzkfchhnnOKHXXKYkRjrz5xhr93vpK2he361Huuq4BM3Yjf/3CfvDaofwUUAl0
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id q19-20020a632a13000000b005dc8702f0a9sm1306247pgq.1.2024.02.13.06.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:06:27 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 6/6] tcp: get rid of NOT_SEPCIFIED reason in tcp_v4/6_do_rcv
Date: Tue, 13 Feb 2024 22:05:08 +0800
Message-Id: <20240213140508.10878-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213140508.10878-1-kerneljasonxing@gmail.com>
References: <20240213140508.10878-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Finally we can drop this obscure reason in receive path  because
we replaced with many other more accurate reasons before.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 1 -
 net/ipv6/tcp_ipv6.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c886c671fae9..82e63f6af34b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1907,7 +1907,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		return 0;
 	}
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (tcp_checksum_complete(skb))
 		goto csum_err;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 73fef436dbf6..29a0fe0c8101 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1623,7 +1623,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (np->rxopt.all)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
-- 
2.37.3


