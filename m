Return-Path: <netdev+bounces-163092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F0CA29547
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050F01885BA2
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319341C8FBA;
	Wed,  5 Feb 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztKPalBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3C1A7AFD
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770692; cv=none; b=XWz2TRpAmbx7LJ/g3xFGswBM5vWwfGaopHH5igv5oZlXBwXQgUjvAfLUbxST2t2I3utTWAXR/j5e2u+rwG6eAsslt4ja0v7P4L78CJw0qxvqhcM4Jl/yldiSY0do91tgOt1kA6bDO7lCmtsDsIK0cb/i75orIJlI10GP6zbgkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770692; c=relaxed/simple;
	bh=IjoS0wZAHK91Jak8vmBaki/M3ogZdNysqnPdn+F/nUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z2lb/M6Se88U0hCeRnDp0kdhlUNs8AVGywlOTFR7hz61BxfMGOP+ztrHEbYcZ79mB0rR3pys1qWawJrG8lxQqjOfTsf7PHa3UvRGqYnA9geOqkR6qRk+VIeuPcRgf4vAJKsSbSqCjt8fZqHEt1tMyBthv2BFcQgmlVnH6bMZY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztKPalBJ; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e4244f9de8so44159946d6.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770690; x=1739375490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7cOpAiJ3jNVE76pwOVOdST2btjk2f5QzQeM6NMvd44=;
        b=ztKPalBJ5gyfRJ5jqNXFMBVmJkllMec9mpJ0PwvAGzHhsz3h5/g339x5m7ARB4Qf/L
         CS3spk/AnkPIgStDm0o6mm+eY8TwK9jZcuBANRfThRG6QOiSFFIxmroVRjN6SssYJvJ7
         A59xG/R7Rw12FhMRZTqJ528yvxjnzl2pKWP1yRUsofUAhPOrO5t+JTNM/kXtUWyKKX23
         BJ9Cby/B64hTE4E60Ufel6HIae7CzrHlTll1EDPfT/Pakdgqvb9dATx/khcY0+Pk9S8y
         HMucd5phFDcSgZ/kqmCAKSNfX4NJGjWz6hUxpvVBm8I54CoHH2rQSxWc9W8MFRKUQqwx
         12Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770690; x=1739375490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7cOpAiJ3jNVE76pwOVOdST2btjk2f5QzQeM6NMvd44=;
        b=jLDXJWa5iM3mjrk/IzswZ2atSLaDko2lckr3fJluNAHoRJ4yqXTEV4C9+dcKkOcvIa
         9gQU3JXZOgrCqJNIuHm9SBbY6GAaEk8K7K54MlAtlYAaPjTscwea1swPnOe9jMrDpelA
         5fd5pNHdfGIR9EjEcdMnor/uLT/9Mqxvw3UOLEt2Hn+CyJi/TeI3SwbnbmjCc53LzqFv
         Xe2r3nDRARzWJ4e5Yb/+mvbkJnaw3CVVun01wSZ4wya1kLQM3B9/1Retx0w8PvMV5m/P
         Q4vG4goMQASATvsdpkxwhCS/5HZf+WE/kk3BPvUdGG3Ec228btQHSo3guThUq5vtiXjk
         c+Pg==
X-Gm-Message-State: AOJu0YzJQUeJgsvHKmXthvw44DffGu9U2EE4fXL1jVKqacUDJacuMKSn
	diNUd3/lYj2SqBm9QIH/lxYgW0FWMmFYbCycFmdtLtoJrrtjuVGC2M10bry+AKx3qJkN79OLAD4
	ytUwtUUI6WA==
X-Google-Smtp-Source: AGHT+IEnHVCGbyVE46EL2MLk+lE/S3ZwV7TvsyZSKm0+Mnf454fsTzdIJlkZu3o7HbyJzUDkYvXjuSoRhzgJbg==
X-Received: from qvbof6.prod.google.com ([2002:a05:6214:4346:b0:6e4:3725:e7a0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ec6:0:b0:6d8:8cb0:b40d with SMTP id 6a1803df08f44-6e42fc70219mr42473856d6.39.1738770689824;
 Wed, 05 Feb 2025 07:51:29 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:14 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-7-edumazet@google.com>
Subject: [PATCH v4 net 06/12] ipv4: use RCU protection in inet_select_addr()
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


