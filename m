Return-Path: <netdev+bounces-223656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DCEB59D39
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AFD326BE1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EFA2882B2;
	Tue, 16 Sep 2025 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2cmNLuaU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436631FEE9
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039018; cv=none; b=jcO1R97bCcwDrnL+JtiZIb9W9nJ8XpCZWVbbhlYaj6C7CohFpb2YLXaDWdT+DZVO8HQHiGY8XKd6kJp1NBUDWMKZ51fDlxEULLBa/fsRYEmRvu7mUDkDG5pogDhbyXRcLU8JoyGvgv7JY5ZhdYSh4GsfvANwyVLv+gSkKpj9180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039018; c=relaxed/simple;
	bh=747M/e1xPvL4AkrBwjheKj4MWWLSkuH1ji0NoQpHqeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GfHHIeNPDWH943VY+spnfiA0530DreCw6JSlp/A/LBUX1Sm3Gil/t54rcwSdpvPclhxOJ/GNyZcsKW1jFHIs5xl4vE9f+utFqKmF4S1KPq2DHuB04XF0nxFtKEmqe9Y1PWRT4AT++FPW9yjWFGrs6a8e4+y7+FNklCH+emiqsTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2cmNLuaU; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-827a6eaaf18so719143985a.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758039016; x=1758643816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvMj5nTjacAdmKLzgoM7egeZuxLvUDInFd/62t5BZLs=;
        b=2cmNLuaUXgZ7oVUsJ22aeJGVqcSfU3VV83YNnqgW8sIMAHQvMlsRt/j9c+YFtvvulo
         TX7M+ihGOz6duWAAoULEXgepK5wpV0+z4yrdCjtBXU9hau7HLyL6xktlMIyuv3p8Hg+b
         e9IG6d7q2apmxd1Ri5mW0+LviqfKtm/ZiznxkzE0iKMO9ztAaTMrHoLE5TN3FEdKywLM
         OMhIn4IAmTP1AkFWPD3jC1RaZPetuoU6XkLrKRVQIXOelUXjMm2BaADgwLteba9Iz5tl
         IPncgZ2fmhRun626AthsuN7dEtEO3623qI22VLASusY1rhQQ76G5x9L2MBqlYX4VpEL+
         4mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039016; x=1758643816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvMj5nTjacAdmKLzgoM7egeZuxLvUDInFd/62t5BZLs=;
        b=K/xTHhGGKBKFSRExrVFOzDEH/mM2bfb93cvsOqzRmm8qhC7dIjNA1SNWQf5AUjga86
         yqJyXAI4gmAhgQZS2nG3d6ZFM+Df2uSPFc28Ko+MtgKPpCgvNnjyPrbZeqBs8Xjhk+65
         k4SuuCFISflgPfhBW2z14MKBLYWO5W4KQH9+mitxanNU3mZFrMO06UnsjsoP7UCb7zqX
         S+As0oNEJiaQP69olEUeBv98RhNz9QufgoVMpqmeP+dIa7Y2KlwupvbyrDGG9uJKs6xM
         DePc8uNCqTPizzCbpkBb0lGHyQx6qJZiSa+xb/qqE2eYVIQORxargFHLZSQT9y4z298h
         A9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUukooznuX/uGB+PpogWoLLn4uaIpdXxS8o4pup/tZjdMrIG0MQWG1ZEXBhmEoos6HSvMCaobM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj22+AkO3PxGvGQC+whkrB2fQed8z1oAqfYyRN7ebzp4ms0Ra5
	z3JrcFNc20mCLGY5c7gnCOgkgszfna/gZ+d7JCtnGys8tHwlvSvHXzobWyNcAx8uPanWuQya7L2
	YQHwFImvXLjrWTQ==
X-Google-Smtp-Source: AGHT+IEQGj4LCca2KAQsd2VdTqKb9G7TKZqr6FRIcRzp8Y9NTgBXsGOiycJ1W2xR/XgtrGrTKjHTPCwts8w4jg==
X-Received: from qtbcb8.prod.google.com ([2002:a05:622a:1f88:b0:4b3:ba3:354e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4cb:b0:4b2:eeed:6a17 with SMTP id d75a77b69052e-4b77d12a30bmr217804591cf.46.1758039015499;
 Tue, 16 Sep 2025 09:10:15 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:51 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-11-edumazet@google.com>
Subject: [PATCH net-next 10/10] udp: use skb_attempt_defer_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move skb freeing from udp recvmsg() path to the cpu
which allocated/received it, as TCP did in linux-5.17.

This increases max thoughput by 20% to 30%, depending
on number of BH producers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 7d1444821ee51a19cd5fd0dd5b8d096104c9283c..0c40426628eb2306b609881341a51307c4993871 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1825,6 +1825,13 @@ void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 	if (unlikely(READ_ONCE(udp_sk(sk)->peeking_with_offset)))
 		sk_peek_offset_bwd(sk, len);
 
+	if (!skb_shared(skb)) {
+		if (unlikely(udp_skb_has_head_state(skb)))
+			skb_release_head_state(skb);
+		skb_attempt_defer_free(skb);
+		return;
+	}
+
 	if (!skb_unref(skb))
 		return;
 
-- 
2.51.0.384.g4c02a37b29-goog


