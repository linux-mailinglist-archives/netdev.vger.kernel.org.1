Return-Path: <netdev+bounces-129157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D197DF28
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 23:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12831F215FE
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96921154C07;
	Sat, 21 Sep 2024 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKcNHr2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBE282FB;
	Sat, 21 Sep 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726955724; cv=none; b=aWyoq84PkaLKHxWt4pwf9QR0XFghKvYlDZNVlivY7ML+AtTXSq6uDpuEyBSmRrBzzQHCAPDhjb+e+Tbknf3SyP3e+BAQxxKCyLBh2Jxz6voJimuZj8V/LGRShda2NYsI7dPu5/j1ltclE1q1Z+F+Vmubjoo9s72Z1zrIdSBn63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726955724; c=relaxed/simple;
	bh=M7rzspFpNHiw0JHMriMhB/4WhesrZv5SnNHM7+eIVaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oXjBNqTcPOpdqpgWxsp5RwS2s+3nXjcD06XgrinKbwHZUSpGNSIb59hmiUAwOr7UNPPMYl5aV+wO/faExQoikMElG0tHP3A0nEt8DS3+DSbBvvI+eLdXEHeu/lW5uLOQahfcU71Ahm391bgShewjgh8hWY9ArWXQFlxaAj5QBrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKcNHr2o; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365cf5de24so3964915e87.1;
        Sat, 21 Sep 2024 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726955720; x=1727560520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQnjiul16NJW8ioc7z7DKN4GAxwl3Hiyi8Nik5GXGq8=;
        b=PKcNHr2oNP0xxAGofsqUFiJVUxSJRAhg1ak8Z5vuAXFp6SMfYnTMK16up7tK1BjgY8
         FqtmFJyimATYp1vesuS9Lu2ve3s770rosS1HyONl7hYsXlqC9um0p9Zu/LLFbRFnNCC/
         QIIivcFUx/gFX1PltXDWk6WXDDG1d781OhFQ3s+d0AMocs7WFhrgwF2PqW8jQgndPt7V
         LfAMfBY+DWy8nKCqAMLhiIakLWaXXzf1icutQDfx7CLlbrKT5KygUe2gwD++ZDIz71gK
         dF0g6S61bmmsvrnkla0Lj+Mkfl1V63Sa1VvRTwVSqWMVAhQkCwgNFqPr3/M9uja55faS
         sayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726955720; x=1727560520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQnjiul16NJW8ioc7z7DKN4GAxwl3Hiyi8Nik5GXGq8=;
        b=L8yFTad6oMgEAd1GVQwb7JJjF0q4InKu+3BSfUhMcDFDb0NjZ1tuCCl/SLrmj+PpvZ
         yzoAiqyFx/8RtNr5JN9eBvNId5j5tg/f4ooNwkzVftmxvwzrvcLf3t5CCl+WkLvxZaWu
         9BUBimw7GHHmXE1Eac838bTtTF+ZXadAq2lwMVObV377SEXH/WNanLsXgBEqxxigwNHg
         F3/tixm/ivtUEMEy57DM5p+Tp5KJbg1fVWFrvLglb0wb5q9H4FZgVFZiva0i7W+q9oWn
         COKYV4PVDBpH5qsRcpghqF7PRs8LKeSklIGn84zybgt6oiL1D4nth/1IYtZaTsIVYVv+
         dFQg==
X-Forwarded-Encrypted: i=1; AJvYcCWbeYXjo2J2lZiCJJ9ahts9VGerKuJXK1BcEs/ei1SxCNgOfCtIq7Gyz8mWGMg8USlcxnOMaHAg5pe6CuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynANl9KQJgMETs+UuqgPsh5JWKO/P6kQSysygVX8cZx4hRVN25
	xZrrq6t1X5YPfJEH/Kb1E1JN/7y5y4sEBDx0pnO57uLJxLZP4/YcJYetxEGemxA=
X-Google-Smtp-Source: AGHT+IEDAImrve36sPYrWHGEjLLO2d/w0swTfPqqskrj4mxtrHVyQmJ/44pO1NU15tg0YaISYjUHPw==
X-Received: by 2002:a05:6512:3043:b0:535:6892:3be3 with SMTP id 2adb3069b0e04-536ad3d7281mr3708035e87.41.1726955720236;
        Sat, 21 Sep 2024 14:55:20 -0700 (PDT)
Received: from dau-work-pc.zonatelecom.ru ([185.149.163.197])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-536870467d8sm2730819e87.43.2024.09.21.14.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 14:55:19 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Danilov <littlesmilingcloud@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Suman Ghosh <sumang@marvell.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
Date: Sun, 22 Sep 2024 00:54:11 +0300
Message-Id: <20240921215410.638664-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regression Description:

Depending on the GRE tunnel device options, small packets are being
dropped. This occurs because the pskb_network_may_pull function fails due
to insufficient space in the network header. For example, if only the key
option is specified for the tunnel device, packets of sizes up to 27
(including the IPv4 header itself) will be dropped. This affects both
locally originated and forwarded packets.

How to reproduce (for local originated packets):

  ip link add dev gre1 type gre ikey 1.9.8.4 okey 1.9.8.4 \
          local <your-ip> remote <any-ip>

  ip link set mtu 1400 dev gre1
  ip link set up dev gre1
  ip address add 192.168.13.1/24 dev gre1
  ping -s 1374 -c 10 192.168.13.2
  tcpdump -vni gre1
  tcpdump -vni <your-ext-iface> 'ip proto 47'
  ip -s -s -d link show dev gre1

Solution:

Use the pskb_may_pull function instead the pskb_network_may_pull.

Fixes: 80d875cfc9d3 ("ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()")

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv4/ip_gre.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5f6fd382af38..115272ba2726 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -664,7 +664,7 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 
 		tnl_params = (const struct iphdr *)skb->data;
 
-		if (!pskb_network_may_pull(skb, pull_len))
+		if (!pskb_may_pull(skb, pull_len))
 			goto free_skb;
 
 		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
-- 
2.39.2


