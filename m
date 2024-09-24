Return-Path: <netdev+bounces-129403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A12983AC7
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 03:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8381C21F62
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 01:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D31A41;
	Tue, 24 Sep 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blSG7nfq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40FECF;
	Tue, 24 Sep 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727141503; cv=none; b=QFo8HsxcP7ER0lAFtB65olwc7sCFC0Esf+uXxRHjUh759RT62j6N6GhjZEucZlnxk7jti63HJ/lj3adlD4XwxdO0tqCdl1/oDQSTcV7lpG2iv9GOnx1+7urq0cJDkGkw/70vqEQD3OQENQWz+rl3gDaNkCeWEBLJNiJMD3HeMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727141503; c=relaxed/simple;
	bh=xs5detKTVBLzPpGt/D9q21ZoFkPbRVyCsZ8mayN/prA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KHHZoi1OfCNY9fgA3M1lW4mywltxIJLZ89LJGWIqvv/udPmIzT+9criGLcZr4HSVePiW5Vk/v0lEXClTQVvswBhvT5BOFotESGItiNcRu+PreWCxjyEpy97/7ysMM6QuSC94SjGFc5Zyr8EKHX9RkGOknQKl1GJs+jNq/tURjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blSG7nfq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-537a399e06dso1676915e87.1;
        Mon, 23 Sep 2024 18:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727141499; x=1727746299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXUE+TGoraxHwTrjcDn7MdkTSgQGCB8AYjN18G7qHEs=;
        b=blSG7nfqrdFb5yBF9PsTTDx0eNmBzf+BHBIwalMuvnKt2/bZedTqSGBPfg1zKnhSI7
         0NlS7lIzaSn48Gn7WB9s9Y1iW9IBpJrOXdix9gKy7iPel50IVi8vjo4WRyolxgjCcvTM
         YnYsJ/n2PsttB4dFLCojH0+dzV0KWNASJKGcGNNu3/V9f93kxVKrwBBWV6vNLIgh43ax
         c4681adPyjtxcEpHQt0kJ/JKzCXK1votD5/X3PIct6RBue1X3Q/v6dn4080jO1KiY7cc
         YfjsZL3yTjZoRslxyQs4hVFRHd+CMN3vWP8fXr4rPEwwjV3eZtGvTu0DTZ7aCMN9slk4
         ylKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727141499; x=1727746299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXUE+TGoraxHwTrjcDn7MdkTSgQGCB8AYjN18G7qHEs=;
        b=laqimbp4cMvQaZ/qlmKFVReju4OT3tE3sS0ZnDPW1sobQwoxNepjDsq6/eHNzrxuXT
         My++kahwQaA1klVYCGl6gG+ltWhLxiApPGTYQ1WX9w+4gLeUVBizYESPqJ5KxPykS180
         AYqSARCq4MrJgjOFzHQAw8+gipbttSdahdnDhBgOId+AWpSVcodmbHMHpQMrQVLdzZD2
         hWHRKziNwlp2YitnbQcON/eudhfawOAijeiqdprPC4Ir7EYLGprQJLAhVEh0kjFV1P44
         qD32t53KQ/3rCjd4CfNh8aFBVLCqauy6gH55+GI9leGhToYi2TkNBfHmVZLwnoYNYe5E
         v7eg==
X-Forwarded-Encrypted: i=1; AJvYcCWdYzwbWOiS5/SeYCDRGfT6TJyafRAutyCZXsKaPwa103+LGbZ2flMN0L+bYEltzkOmZa1g0BSpqfidjQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUDVBTEGO5NIfUHSJnVkx3TJPxQidwzKRC1rGkKDsuu6zt6Ot
	HfgbtM24enJxmwZxXGKlWa+HZLiCmcmxVZQGh6/4qQWzSSNEuuI0RvlOVLUxOrY=
X-Google-Smtp-Source: AGHT+IFBLkPpAD23jrQ6hVZAW8PQa7/Mvpz9LGc30yvgHGYRnCjvbVouaQDoQGW8pZgLe35cmCIBWw==
X-Received: by 2002:a05:6512:401e:b0:52c:cc38:592c with SMTP id 2adb3069b0e04-536ac179d05mr7431867e87.0.1727141499229;
        Mon, 23 Sep 2024 18:31:39 -0700 (PDT)
Received: from dau-work-pc.zonatelecom.ru ([185.149.163.197])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a864d7fdsm52233e87.254.2024.09.23.18.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 18:31:37 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Danilov <littlesmilingcloud@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Suman Ghosh <sumang@marvell.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net v2] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
Date: Tue, 24 Sep 2024 04:30:40 +0300
Message-Id: <20240924013039.29200-1-littlesmilingcloud@gmail.com>
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
locally originated and forwarded packets in the DMVPN-like setups.

How to reproduce (for local originated packets):

  ip link add dev gre1 type gre ikey 1.9.8.4 okey 1.9.8.4 \
          local <your-ip> remote 0.0.0.0

  ip link set mtu 1400 dev gre1
  ip link set up dev gre1
  ip address add 192.168.13.1/24 dev gre1
  ip neighbor add 192.168.13.2 lladdr <remote-ip> dev gre1
  ping -s 1374 -c 10 192.168.13.2
  tcpdump -vni gre1
  tcpdump -vni <your-ext-iface> 'ip proto 47'
  ip -s -s -d link show dev gre1

Solution:

Use the pskb_may_pull function instead the pskb_network_may_pull.

Fixes: 80d875cfc9d3 ("ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()")
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
v1 -> v2 :
- Fix the reproduce commands
- Move out the 'tnl_params' assignment line to the more suitable place
with Eric's suggestion
https://lore.kernel.org/netdev/CANn89iJoMcxe6xAOE=QGfqmOa1p+_ssSr_2y4KUJr-Qap3xk0Q@mail.gmail.com/
---
 net/ipv4/ip_gre.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5f6fd382af38..f1f31ebfc793 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -662,11 +662,11 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
-		tnl_params = (const struct iphdr *)skb->data;
-
-		if (!pskb_network_may_pull(skb, pull_len))
+		if (!pskb_may_pull(skb, pull_len))
 			goto free_skb;
 
+		tnl_params = (const struct iphdr *)skb->data;
+
 		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
 		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
-- 
2.39.2


