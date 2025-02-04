Return-Path: <netdev+bounces-162530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75CCA2732B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C0188943C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4100215163;
	Tue,  4 Feb 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6MsF963"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6721517C
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675449; cv=none; b=f9/Nzwj4HAGaGKJLgOofZ4JGJXjfcu+j+8i9j5bUFnTI8LWuHXzG9MUA3ndPCaHnydV2LCqG0pQNzHECZ8JxHHHrSKR1f7xBMz0RnbwHxJGoOaM7+3Lw/47AX6GF4NYnQKUooHZSUL4x2FnLTbWTDdSAE4bBVm3ZFmsKrmxv78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675449; c=relaxed/simple;
	bh=BjDBT6Ld/KkPV9e18e0rFMjRoUhNxwx0+3f23tk62VA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HOf/Kkvljm+kJvB2Ekgmzj8Qu1+jxpQlABVoH4o+Mq7ZKfKfMKyxBc7tQvsIXfRuL+AxcmyykEhiEQzKbQqKpmQL3/IOCwvNpdL4kMejNeOGkXclxlFYK8iznXw3rZkqriigZoaSLuLqtoyyk/W3KRBIN7EYdQyLPs4AyKSeL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q6MsF963; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d8860ab00dso93220936d6.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675447; x=1739280247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFUTWn43E87kH4WvQpJOMQwE5y357mjWskRk2Y0FDpo=;
        b=q6MsF963jASmlizTK94q4CX1aYMubCT3imm4oKUpqkwDsSVU7i3TKfbGtxyflQFfCt
         3EpnOg58a2zuI4M854WJHil/bNSY8O94piRCHdVoVGxTQdNZOIJcRfWLG3N66ElxlrTz
         AbCls4vxagMh1PbItK5sgIPc8IaLyNkwFye0fZZIw/lueosD6kK5EZTm7kzfhKqr9GyT
         4n8tKcUkD1LfZldqpfPPXmwjRADVzoBaK82Dj8yW99W1wfDyAnnJ98kvg9sys7IYnilh
         LWrk5asEX2CYzO1uVDnt8XSxEcioStoE2RRU7u6xiQWycyTYoOfhJ42HKfkDupFjaSMQ
         RAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675447; x=1739280247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFUTWn43E87kH4WvQpJOMQwE5y357mjWskRk2Y0FDpo=;
        b=b8ruGij6O4tIVpdDMJ5NEklLD5//T9fRudMtOhGxQZvTzHSEUY8E3IQdagh+Voxzjv
         oW1zpfUQupcmgYC5xRsTdmVrPU2wmkTDc9H4LmwAlz7oMBOe31eUo2mp02YvqjzW+CFw
         TDgugWCaa83PvWTCHrpyxmvRz5/AnzMmGofoR62GMhRhQ/+FRVVnFc4R2X0uyjC+qhV6
         dQMb+b5vKqfuu8/o3ioGFnXUNFGZWX+wctXDafUX2rX8kNLytmtnGgufPb4HdF8C+1b0
         eZKYYkU4GMgnrrkZ4slxQuWu+Sz0D2pyjeOiwaoSmUkvEyHh9VDeB9uCuLmzNKo3G2T4
         gwVA==
X-Gm-Message-State: AOJu0Yx2lwkZ8zb+hGdcqh06Bz1nJmsdd6f9LXyyKRmRXF5X/dXNtH8x
	7y5uBYAN+6og4MNtt4uU/QyeSdXzxyJ0e0PZYLsb4dfjjvCfHV71PvH7nTNBt2sKDJuUtXDuKiU
	HzqL8BBBkCg==
X-Google-Smtp-Source: AGHT+IG0iXuTPBHcfUn85DMxtkb2Lt22iUpYV6F2F2g8xJVTlspVOOlw7xIkFFGV2gr4nWqdLnt948o+t1Q6Fg==
X-Received: from qvbmf4.prod.google.com ([2002:a05:6214:5d84:b0:6d9:89e:9cf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:21ad:b0:6d8:848e:76c8 with SMTP id 6a1803df08f44-6e243c7e244mr394041746d6.42.1738675447131;
 Tue, 04 Feb 2025 05:24:07 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:43 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-3-edumazet@google.com>
Subject: [PATCH v3 net 02/16] ipv4: add RCU protection to ip4_dst_hoplimit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip4_dst_hoplimit() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: fa50d974d104 ("ipv4: Namespaceify ip_default_ttl sysctl knob")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/route.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f86775be3e2934697533a61f566aca1ef196d74e..c605fd5ec0c08cc7658c3cf6aa6223790d463ede 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -382,10 +382,15 @@ static inline int inet_iif(const struct sk_buff *skb)
 static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
-	struct net *net = dev_net(dst->dev);
 
-	if (hoplimit == 0)
+	if (hoplimit == 0) {
+		const struct net *net;
+
+		rcu_read_lock();
+		net = dev_net_rcu(dst->dev);
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
+		rcu_read_unlock();
+	}
 	return hoplimit;
 }
 
-- 
2.48.1.362.g079036d154-goog


