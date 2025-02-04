Return-Path: <netdev+bounces-162765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBECA27DE7
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BBE167377
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D421C9E0;
	Tue,  4 Feb 2025 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ZCLcCx91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E521C17F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706194; cv=none; b=g6/X4hkHK+L5IB8TPEwLZyjJ2DCZwaJHmoDblbeenTfb7SvxQ6pV8BTXs+xmJpBIVcQuxpq2zkuwyLnNfZRqsD9ROlG30WQrTecXxF66Rqobm1UJTP4JMrSyF76hFG7/SCee7dfZbKcFjxSMJqo1ZbtTxInbR2XuwzY/M0Ign7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706194; c=relaxed/simple;
	bh=lG2z0hn6DZ4HrBGW2ckt3E0dnlk19OJByJdCg8rBNho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm8BJBOJ0pLEu9GPHcMOzymgHqDoZl2eQWLKBRPzPf9B2aLHiS128j0THyKN0SPe+KfdS8U7kb0yVxmXzQSFlCRKdraq3nX+6X8ooknRWyblecUcaCUrKHhc4nG8J2RGeBgEZ1t4dx3USryHSLftSLdWAUo0jNwnDlLzrZtg5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ZCLcCx91; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21619108a6bso103175185ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706192; x=1739310992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7MXw0r+iM5bOECzDlk9lTDUMp4kdULo9Dt3lX8ZVKI=;
        b=ZCLcCx91z0EOySV/tOUoH5EAGoYMH9DMXad+b1busEtfk4/du/03Zd/KIAb/4v7zTD
         l7aeR+r8opvmlgwcKaMyxyy48OIIiR4NjcExE4qy6zUZdVPXDG2dIANQAuIFJz8ThiKk
         0ly0+IxaKLczl1idA09LDnryO76t2ex0FB+hqenQM4yla6jyk3jGxUtpUJDZoabeBuGz
         yttXfG2rcaR+3cHh+bmy6LGgPEmwfuGg8i6QhR2vAXyg79E1RSNYeZkJc1EWLx/DtP8w
         PjJumQxfXg6Z2AkkehQ08Vy5IvwB7shraCjK+kpnYbqd7oZg/V605DxbPBvYiEfqcKCb
         iLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706192; x=1739310992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7MXw0r+iM5bOECzDlk9lTDUMp4kdULo9Dt3lX8ZVKI=;
        b=gn2/rGbsXmyv80LswlcGd9GyVmnuoVZ945uR7sh8iq7/+sLDqtR0BEd+uJFhhlc2j4
         Nfc46+PbJwwpue2yU5NRku1i1E/GvHgJg95MOekxxo8q0XkeOSHcU7T+S/XV66JdKNi0
         2riPXxgeja5J7ZAeD16osdWziAmcUH55wE+RPDee1kL+2KELlxEkaGHIHwxa+EFRO2HC
         BiYoEsRHfDmphKpRg9Yh7yeMJ94miGoXexjlL/5GM19iOii4LwHdTkrkcOaQRCQDqubK
         z08YQyOQF6e0PKj1zw6WgjIh9hBBNnC08FSpNEpL3A0TJf5EQ1IAuK0lTCVynvIESoXP
         zZlg==
X-Gm-Message-State: AOJu0YwSCj726EU+yhnXLdHGQEwiRaqrYHKSrsyVwmC45J/Q1xUUF+8D
	2+sxGwKewabzsGD6PcpUagdd6VPIS6DDYbaDJstbN8iaO7A646hVHmG/lvHsHtsbnxL0nZOjTwf
	Y
X-Gm-Gg: ASbGncvWYQwwhB/qfcHAZd8gbJ5blPCFzZD1d/9gk59kXrhwsK9DFryPY4JsOzsAdJZ
	2OsRnByQW/lY+caX5fb9qZARBiMNDwlUtcJVDPjj2bRVS84W3wOzpAkvm87AwzGz9gtGf5++Evv
	eUSrie1wB/URycBr0zzzVIoguUXDXomaQSIWw0Qh2L5M3puvsCoGMfeGLazBV0ZFvdEH/BWlppP
	IcyJCzq96fAqe15c/jGouo96DXSSY9Q7uQYPv+1+5oyelB5KyFT2J2kwDFiJlU1QCR1uh2Z
X-Google-Smtp-Source: AGHT+IEeXAtgFahjPW7YdQS2W59wSDfZANuCUUyvcDi/62NpP8cFS974cnlJ3Awrq0bMP4Zkl62PJw==
X-Received: by 2002:a17:902:e74a:b0:216:5b64:90f6 with SMTP id d9443c01a7336-21f17edc502mr4680835ad.45.1738706192135;
        Tue, 04 Feb 2025 13:56:32 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21effb60da0sm22221275ad.120.2025.02.04.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:31 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v13 08/10] net: prepare for non devmem TCP memory providers
Date: Tue,  4 Feb 2025 13:56:19 -0800
Message-ID: <20250204215622.695511-9-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
References: <20250204215622.695511-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

There is a good bunch of places in generic paths assuming that the only
page pool memory provider is devmem TCP. As we want to reuse the net_iov
and provider infrastructure, we need to patch it up and explicitly check
the provider type when we branch into devmem TCP code.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/devmem.c | 5 +++++
 net/core/devmem.h | 7 +++++++
 net/ipv4/tcp.c    | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index cbac6419fcc4..7c6e0b5b6acb 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -30,6 +30,11 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
+bool net_is_devmem_iov(struct net_iov *niov)
+{
+	return niov->pp->mp_ops == &dmabuf_devmem_ops;
+}
+
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 					       struct gen_pool_chunk *chunk,
 					       void *not_used)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 8e999fe2ae67..7fc158d52729 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -115,6 +115,8 @@ struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
+bool net_is_devmem_iov(struct net_iov *niov);
+
 #else
 struct net_devmem_dmabuf_binding;
 
@@ -163,6 +165,11 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 {
 	return 0;
 }
+
+static inline bool net_is_devmem_iov(struct net_iov *niov)
+{
+	return false;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b872de9a8271..7f43d31c9400 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2476,6 +2476,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			}
 
 			niov = skb_frag_net_iov(frag);
+			if (!net_is_devmem_iov(niov)) {
+				err = -ENODEV;
+				goto out;
+			}
+
 			end = start + skb_frag_size(frag);
 			copy = end - offset;
 
-- 
2.43.5


