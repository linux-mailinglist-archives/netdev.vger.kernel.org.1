Return-Path: <netdev+bounces-172626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B26A5592C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CF37A21C2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F3D277017;
	Thu,  6 Mar 2025 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2e6Y22X2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5122702B8
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298126; cv=none; b=X50JJBywGdW3wOO67zD3y1BOdzPQiZc5hwiiDn4Og4r9esT//T8/yJ6jeqiq9HPyQob62gizGPE+rEtwDVf7b59k7GVKKly99Bs2sBDLrqy5LR//EFWogivB4DP6JI+xwSFjDhNB34T+LiM9pU3LQhxKzE2FPaAsmAuOak2s0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298126; c=relaxed/simple;
	bh=azxxHglNwZOmOo21MSzDsXJjKofzRYYuFM+xpJtchuw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SEvCBkx26aYhHho1kzGURhCpwaIPog7hMfM6Nkq6owlu0m7FQYLEGFdpG55vWgyUS8EAdW+40+jDl3u0OMnuUoZe+dAzTVNv9w4lsa5/y48lkykdmiN0x7fZPsnQrgwLz/J5XjjJm/6LvYEL4fAFFyUOWWo8PwQ6M7pJLkszkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2e6Y22X2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff68033070so1907015a91.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741298124; x=1741902924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NLkSmt1DZnRhFx9XULHVdYEwtFXJcPydAoKqmySuLlQ=;
        b=2e6Y22X2yuv+HlRfCtMdXPKmiILHbBvD5jKCLW5IIzXiSw+gzORJCF2/ZTua/OPmAS
         uun1x+WWai9AqJxTfmJ1RELdjJ4sfoSuZvrbv/3Zwv6HQNXRrMcqWyFrcbrKsHAFz1Ce
         744en2q9mUwqynJ0e0UmPNrngk+B7hs0Mz/IGx0XFGfzZfL2k4WoG3It8z0FsuFwpA98
         4qw/6zYDHRvFBvC8cFcozuqeRktwkikBAuUAvNzsreEXXKvvffY9BDHuU4B04JMEwP7v
         B9lBpjS+y2XI+e0xJHo5DlDvLeMr5G+gq3t57Z7/ArGi84U0cQyhhX79TNB9vJUCB7g0
         Gy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298124; x=1741902924;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLkSmt1DZnRhFx9XULHVdYEwtFXJcPydAoKqmySuLlQ=;
        b=Cxi4lhH1ECMRTwxBFnWi+9MG3HH9UXoAEtJB6sKYyGKgON513PuVT+AZ63HUjwI8P7
         HxfsIoYM68Ern+5fonwmPRIXKOqX9PyrD/8sQ0eRVngHoUKbeh/OspRPllEWTUWKM5mN
         thX1hUQHY2jATMtkbzZ3ibs0iFi5t4ypuNlriCXOr9vllOC78vfro/nlB0w5mggOmQcM
         BnKvudM+DzRv45HUR6ERYsTXPHlxi48rFr+7Q7S96UMxKHZxG8NT6Yb5cv0wioVsvlHy
         fGLvZV2pMduaxI9EaI8HtNrII+CeUMerjcf/8iU3X4RdON+W36odQgq97RcOysL7dhQS
         YBnw==
X-Gm-Message-State: AOJu0Yzh3LDPUdcXUgjas3uaHJ+YvnvlBhgsIkhhWRC/bMjEyPxqasgX
	PJlmM3TuLNC9bGfvayZpuKt+OsQ+PHPtXPEUL+ihgrpS9mG1OH/LIzfofNchVYYiYa/QkuBnSx7
	34kJTOKbAcrA/M43oiQJ3VxjhXbBeWUwUVUg1jGr2QnHCOxe39upjlspa8ca3kdi5noY/BBWXBB
	ScQqi3wlwvsl3hqHhO5ZbksHWukCXFHWZZYlpyOPBPNCCF6X6FQ0IMUG8au5s=
X-Google-Smtp-Source: AGHT+IGHDB9A44dGCVln69a2GwdZhq805JNhLs2P9Wez5QFWx8ZhmbyqG15VhWEUgx6YhN7ouHokY7Am1brqjoBqXw==
X-Received: from pjbdb16.prod.google.com ([2002:a17:90a:d650:b0:2e5:5ffc:1c36])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b11:b0:2fe:955d:cdb1 with SMTP id 98e67ed59e1d1-2ff7cef99b6mr1144261a91.23.1741298123934;
 Thu, 06 Mar 2025 13:55:23 -0800 (PST)
Date: Thu,  6 Mar 2025 21:55:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250306215520.1415465-1-almasrymina@google.com>
Subject: [PATCH net v2] netmem: prevent TX of unreadable skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently on stable trees we have support for netmem/devmem RX but not
TX. It is not safe to forward/redirect an RX unreadable netmem packet
into the device's TX path, as the device may call dma-mapping APIs on
dma addrs that should not be passed to it.

Fix this by preventing the xmit of unreadable skbs.

Tested by configuring tc redirect:

sudo tc qdisc add dev eth1 ingress
sudo tc filter add dev eth1 ingress protocol ip prio 1 flower ip_proto \
	tcp src_ip 192.168.1.12 action mirred egress redirect dev eth1

Before, I see unreadable skbs in the driver's TX path passed to dma
mapping APIs.

After, I don't see unreadable skbs in the driver's TX path passed to dma
mapping APIs.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2: https://lore.kernel.org/netdev/20250305191153.6d899a00@kernel.org/

- Put unreadable check at the top (Jakub)
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 30da277c5a6f..2f7f5fd9ffec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3872,6 +3872,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 {
 	netdev_features_t features;
 
+	if (!skb_frags_readable(skb))
+		goto out_kfree_skb;
+
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
 	if (unlikely(!skb))

base-commit: f315296c92fd4b7716bdea17f727ab431891dc3b
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


