Return-Path: <netdev+bounces-224426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BABB84935
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1F14A8674
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6978302747;
	Thu, 18 Sep 2025 12:26:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EF34BA28
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198368; cv=none; b=KAc8aOwmkCDsXI3pxCmAYoCnxPBADmn2C9yyUQzTbeNZq5mUkPTQ4M+y8wOVyVLSP9V4fCG4qOG4P5rRWssLRKajuUZsNXTG70jg2HyogeNQIMUW51ZyqMegGxh9L+A97XbzSIRfPEzAj/oK/Giiq5db4Re7z4dCsBqMrIrEJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198368; c=relaxed/simple;
	bh=VLreZAgyqdt4IbDGMWq+hXQwd3RALL3xojB4JGVGAs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKqZtt4uK2asMP/UfZV5diq1YLji4nTS9qJP8uweN/TKe0vWDSssCxUud/4HdUPV5Pw2OfqbD6lhs8uBvnAp3En/fyxEMfEvk9eKopRFQ1FTHoXVJlchtgeJR4NV/+TbMW+TCUM7T3+FMvfqp3TY69+3PoyBIDbYp7icm/poQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07c081660aso156957566b.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198365; x=1758803165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD1VaIvti5I+7WNRpeNj278YauNyi5qcRsCfkF8NXy0=;
        b=CRVGp/XLsFGYaHRrliHZqKt/hKyhfqvr9jaY0UAHfYyYwFq4AxiFi/SleR6PvzlK34
         6ETmkEwsvkHT2ICFKH3v2es++bA6O27hopcQ0XRcctIwmgyU0VlkWhWdoOEE//AMCAYY
         anBQvfqXzofgDsEXgCkBjcQX9DNh8c9pGPJTAmBKpr2Z1T4MWB5vmqZjICoUnKNTR0nh
         G3/rig1r/rqgvJf/wldzFQpfnEa2p/u37Q+N5Xzf4FF2ZYyM3rDNtTxrHfEhElpMKxPa
         aLRy//dinzqXjlIQNs7nFGPm0GNqDqQC/Q7pn2n/LAYqVgZH8v6+0AiCGgJC1SF8KKrS
         38CQ==
X-Gm-Message-State: AOJu0YyiDzF9P3Be07Jkpd/2SkVty6te6yl6IxKpgkKbXsU9GD13Cs4p
	qq5pegBHe3S5OFx/ZJyljNNSfsJOib9aO+yNfs+i43nIB6+ZBrSFOt8B
X-Gm-Gg: ASbGncvcTUwZG2iu35R8NStsERb6G/FBErV54Hrjw9c6MvugAl4VTveZ9QI5DwZDlbA
	TW7WrygbchzF4YSqoAOqzYGogdAah+nh9WiaiI0FyVqMV6aA8CrE9PJQvhAAdRFPU0GMbZYKCEH
	UpcTf0qFgxArCKZ7wl6/koHWHBpVy8SIB9GKa3usHg2xdIYujDnPh+bmof3+4fEEAQ2HJIt+JrG
	2BHBsz7ET0rz02Ay/Ff4JUnrzIfdRx4jBQoxCH/tQxBiQEWgVBByDIPK6+fdGrripKugMUgz/5X
	Lc5hd51RInV4eLGESGUZ+4ygrYrfb9UHoTypsIFrVGMvqvuKt0+zq3+1DEXGaXDS9KEHDKp0snJ
	5Yo7XePhF7ZacztX/DBRAXEde/Mnk4QWp
X-Google-Smtp-Source: AGHT+IF9zGGM5Txf3w00xeQL7fGLKXH5vp/N0vU4vHKJkKL72AIxdJLQXn1U0lonSYohOi0T7w2fjQ==
X-Received: by 2002:a17:906:99c5:b0:b04:5e64:d7cd with SMTP id a640c23a62f3a-b1bbebb4f54mr644912266b.46.1758198365258;
        Thu, 18 Sep 2025 05:26:05 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd271eaf7sm178964166b.100.2025.09.18.05.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:26:04 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 05:25:57 -0700
Subject: [PATCH net-next 1/2] net: netpoll: remove unused netpoll pointer
 from netpoll_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netpoll_jv-v1-1-67d50eeb2c26@debian.org>
References: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
In-Reply-To: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, efault@gmx.de, jv@jvosburgh.net, 
 kernel-team@meta.com, calvin@wbinvd.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=leitao@debian.org;
 h=from:subject:message-id; bh=VLreZAgyqdt4IbDGMWq+hXQwd3RALL3xojB4JGVGAs4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy/paueKKm+EP1z+8W5G+3Mcn96G1lIfSZcB3o
 EZF+npCtiOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMv6WgAKCRA1o5Of/Hh3
 bR5tEAClbr3TKA4OeKmQktqQjjMU1FVn4CWfV1rLzztyu6Zpp4VaetdW9ON7AK65TqEYDoiKJhy
 7zqpPXgJ5/ItB7vlQ1Qw6LofkbsedUSufR5o4KQ1Nxj4jKB2UF3+HcXuaS6iLqFfLgo4izxWHir
 EyK0MEDDjSHudEdJwDTJb99SRHMvLkqNGdbUnijGIp6DLA2BOLUkrjFiQX8CK5B1+jl6n5UbvMD
 Vo57q5SqsPqT5wHmpmQl2vSWH9AHPQO2aLN0YEnO9gUgV0uFNnpUgRG+Wlj+7xHFlMTGR/IdBUj
 3plMrV2FyLOK2ToRWQvVsOtSyFWSI5ZZlwvYBBOAGOWftCPShFHFifEnO0MLZnxAEwbr3Cdj1ui
 2V35El+WpnTnID/xM8pL5TAfcwyswa3EwJizyv0mwfTJJRX7voKto5jBUIa6b+4Z8DBi48p3nMa
 hLX1tNZBvxMcnjn364FKU8Veg+u1QC/3GRX0n4IPu2TtD0GZqPZwi2xO+Iw9cJaqZkcmvLSMrDn
 yNqm712p2dOTFZtjbCMekTcaJTnPB36HFPPv2vbjWUU2IeEbIDnHf77JtSRt2l11nLEt0z1NiZW
 uLJ5cNBPq8d2u+MydrHcmsCpbM3F+Ds8wVpYGg1JHwoDUABOzTcnLdoAY/InPmXwFE6e6v5VsL4
 OFQXRU/VNqPuLaQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netpoll_info structure contains an useless pointer back to its
associated netpoll. This field is never used, and the assignment in
__netpoll_setup() is does not comtemplate multiple instances, as
reported by Jay[1].

Drop both the member and its initialization to simplify the structure.

Reported-by: Jay Vosburgh <jv@jvosburgh.net>
Closes: https://lore.kernel.org/all/2930648.1757463506@famine/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 1 -
 net/core/netpoll.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index b5ea9882eda8b..f22eec4660405 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -55,7 +55,6 @@ struct netpoll_info {
 
 	struct delayed_work tx_work;
 
-	struct netpoll *netpoll;
 	struct rcu_head rcu;
 };
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5f65b62346d4e..c58faa7471650 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -591,7 +591,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 	np->dev = ndev;
 	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
-	npinfo->netpoll = np;
 
 	/* fill up the skb queue */
 	refill_skbs(np);

-- 
2.47.3


