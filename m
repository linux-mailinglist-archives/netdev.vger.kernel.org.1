Return-Path: <netdev+bounces-162544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 903A9A2734B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAE07A5565
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F221C176;
	Tue,  4 Feb 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKxXAXoo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1F21C162
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675469; cv=none; b=lGSDwXtM0qr6ZHcysxc+AZA1mMbLAa2Ood/xvQgnIfmIdVm7TwGQi5JH351A3TofXr/tXAKEsDJa6LuwBMsBdwJqE7wUo20DvScJXnKjQkSqOdR0qKai9Aix8NU6vWhAkT3P+8xzwN8aHUH7CbpR1EvQyi2RGDlBLbP0fAXf1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675469; c=relaxed/simple;
	bh=IjoS0wZAHK91Jak8vmBaki/M3ogZdNysqnPdn+F/nUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tSQyFl/x6TU+vEfDz3A0nFy2LlBaAT8s6+zCS0S/se+ylbtc6bLf+elvB/kLTpAU49C9a6V5Q1kh1tl2OYOkRpRDIAos7pDzawdM7MWvA0yezvEnITWpRv66AzurOCMZt7zy9B6fINdPkrEPhZpeM1VKkTIYXg693S3wPK9TiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKxXAXoo; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e4221ac976so21962316d6.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675467; x=1739280267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7cOpAiJ3jNVE76pwOVOdST2btjk2f5QzQeM6NMvd44=;
        b=zKxXAXooKO6+UY+1DjaKzHw3TvTDhBZJW5zZDRcV4eG/iGbhFD/234vFjtDyI0hS67
         wNMwihAXsGKaWK+DtkR8eCFCh2SBS3e3oc6JRDbOLzcp1pRtSwpPpMOkUX/5UF5INI4X
         K8AOzxQeT6+v19s0+1RMZglvpM5jn4sOc+c2D7iGShhCxF8R2a67I/A3glbEmtXraHZi
         KD6AK9e1UnA3Fm/SlrfU1o5S0OYcUuH1nEj6eCcwXuuXyZaws8fV20LOYWU/gctq9bjV
         IvLA14/G44VtJplzLHSOYkxEAPRpQpRQAMzFBOMcReTZ17sgQcXKhhvu3JW/x5jMSLp0
         GaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675467; x=1739280267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7cOpAiJ3jNVE76pwOVOdST2btjk2f5QzQeM6NMvd44=;
        b=AxF8+E69F0f0rtwfFPqWeDc0uGUv1YXbHXXjnvrvNehFw2xEumZHAi3E1UkdHLwOdW
         hOBqGWMh4MDgm1goOdfmhLZBYQjvUeogZaeWQB9qjsrw9+fc1TPCbW0vGmuuiNYME1Eq
         +UjZHZfk4iyS79j4EVN4wh1k0yUlOj1Wsts5IvWreCwk/0AfkIgzYyXgTmDflo6MPQjn
         +U7quOljjcZ5KVcZe9rTrmsSGUv75FISnb7ZOg/x1DQp1NoM5AgrFyFAes9rpv11XViW
         GwWxlg971ByBpbfInHcSde3UYgjqvilB0lXHfiI0HzhZYU3TmNiiLVnMoU9NH7JRU8Qu
         rkiQ==
X-Gm-Message-State: AOJu0YytiEPewDDiG0LcQoeRqvo8c/tmT2ujdIx5c2BPbCvin93FlI/G
	M3MEsPZndWrFn28L7SICJ06t1gbACfbHPuZNIwhtG2aYvYtDCvQlQE0OipMR1phStehkcmqR48K
	2T22Gny+J+w==
X-Google-Smtp-Source: AGHT+IHz7DBvrLRxMBB2LZCLhGByE/FyhDGT4IFQ3LQ8MRrFYvPbFo8QXbTa1z/d+zmiy6nIeuokB7GPjW5c7w==
X-Received: from qvblh4.prod.google.com ([2002:a05:6214:54c4:b0:6d8:a765:adbe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4b82:b0:6e2:43d1:5feb with SMTP id 6a1803df08f44-6e243d161e4mr334224056d6.31.1738675466859;
 Tue, 04 Feb 2025 05:24:26 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:57 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-17-edumazet@google.com>
Subject: [PATCH v3 net 16/16] ipv4: use RCU protection in inet_select_addr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_select_addr() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: c4544c724322 ("[NETNS]: Process inet_select_addr inside a namespace.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c02941b919687a6a657cf68f5f99a..55b8151759bc9f76ebdbfae27544d6ee666a4809 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1371,10 +1371,11 @@ __be32 inet_select_addr(const struct net_device *dev, __be32 dst, int scope)
 	__be32 addr = 0;
 	unsigned char localnet_scope = RT_SCOPE_HOST;
 	struct in_device *in_dev;
-	struct net *net = dev_net(dev);
+	struct net *net;
 	int master_idx;
 
 	rcu_read_lock();
+	net = dev_net_rcu(dev);
 	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev)
 		goto no_in_dev;
-- 
2.48.1.362.g079036d154-goog


