Return-Path: <netdev+bounces-130735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E184598B5BA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7D2280E28
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D701BDAAD;
	Tue,  1 Oct 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWVYy7oE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82981BD4E2;
	Tue,  1 Oct 2024 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768126; cv=none; b=s9F74L4xacePMH9CYvurVrFNTtUcpOJ7rl2OnYFouDkm0pvYd2PTEjUhKwXvCHCSzlId6PaLu4P6DEaKi1Pe2Zfuvrvlu331BVPv4dVyWvt+b1l0p3DhhyQ7YmfbYi6ILzFEvDhoa/lJPx5reP7hbStuJgkxzxAVnA2PvoOSEhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768126; c=relaxed/simple;
	bh=t0EIUrCVwE7d2xCGIvjjtdmS38hT+qvdd8x8DzPoNdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDhzBSVueZrOieHDiAQMqt5nJ9PZTiCbQFRKJxMXTjWgrnXMq9LN2oxy9/xvfuoQ0YtdAD2dKzEwTskatY1/r8AEeOn+mXPZs100qrZh0H+oICu6fHvl8dCB4hZE+ap/YCJkAeOYZ8XphwkuS09AlU5yjHsdQux2UjxyMMB5yd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWVYy7oE; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20b95359440so13952045ad.0;
        Tue, 01 Oct 2024 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768124; x=1728372924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+AhWGVHZRvRgtHPQc2knZ4d8aa8l8HCvTuwUct604k=;
        b=eWVYy7oELXeflxiI1otfwrQcNbBQSHpmuzlvVXRpuLRCWxsORhLzlz4WxtyhtapgVw
         Rm7aZI9KF4sN6gAU2RnxI8HpMS85OoFllTKQMqcrfMo+g9kg/nJv3nJDFLq58tJau8Ut
         VGI0bApw63vjzzorvNrpYAvK023cnjcI/hi5dxVj6G+A32qEqZMFeMJRty5M+Q4jpvJZ
         7VFIr6fuDUXhiXT1AeTbmfFdNmEpEaKrHgX6izd4ZAtqUneX4bxxviQ1iB9dyp+16nbX
         kLTUGN0R1HQw5rCrS4Trd5LofCMJaIAGUMos4Lko21v4JGH78L453ScbHWYVEl5oSqQM
         fUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768124; x=1728372924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+AhWGVHZRvRgtHPQc2knZ4d8aa8l8HCvTuwUct604k=;
        b=UqmQfRZoXttf1tPwKPDuuQmsSD97+5FTshIb3wD+O6ZFyKLBpgJ10SqBDBSDW7qg8b
         dEbj3O6RHZ4nF5TpO0Xp+9hwkukDT5A4yICTON+dL0R62BQM92kCxe3Xouo73vEuAF2i
         tTmTXkQy0BGVJfU6rG4r4WZHepkWr2O1GanCZ7BAkwU0OUpbhvc8NNXUS2T1SdOPcX3o
         LNQ9yHHIioVM++hSaoe3ToJMxCA4sn0hRwbhM3ibHXENdB8uEJftfRcahpzRDjMu7Y+3
         853Bg1k/n2hYSqCYNSP4PCyfmhAUoAjs88NR8RSBGYfu/f1byQBtLEpr49fYj2Ra5BYN
         ZcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1FPOuzFGsUxJoLSXe64z6djj2GbDNl6s/kyPAq7oceDtkhqguufXYFem+QOg5bFCkbjrVdXO7@vger.kernel.org, AJvYcCXHbWdeMMyPwDJ6+iOdihWOzTv1WVRcOvIHhdeDVcyR3AYEDttSLTCt4Vj9GyfbILcga3hDZ0hvuS7BHN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/rA/yjKkcmaW1WyO2HL1Ra/9u1o3m9zNyfPRvzU+dzPIL8/x
	5dOIg3K1oPuqCZXX+fBKtex4NlUdJtiGjBfsVl8xMwDFMjS7bo4t
X-Google-Smtp-Source: AGHT+IEsxrFj8i3FzQ+cYDwwIPiOt7gSYpMAm6JQrCNDtpLtDqOm5EMzKiHCu/5e5p/0TFZ5sI1Vqw==
X-Received: by 2002:a17:902:e945:b0:202:371c:3312 with SMTP id d9443c01a7336-20b37a538ddmr218284095ad.40.1727768123702;
        Tue, 01 Oct 2024 00:35:23 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:35:23 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
Date: Tue,  1 Oct 2024 15:32:21 +0800
Message-Id: <20241001073225.807419-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
new skb drop reasons are introduced for vxlan:

/* no remote found for xmit */
SKB_DROP_REASON_VXLAN_NO_REMOTE
/* txinfo is missed in "external" mode */
SKB_DROP_REASON_TUNNEL_TXINFO

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- move the drop reason "TXINFO" from vxlan to core
- rename VXLAN_DROP_REMOTE to VXLAN_DROP_NO_REMOTE
---
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 include/net/dropreason-core.h  | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b083aaf7fd92..3dc77d08500a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2730,7 +2730,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (info && info->mode & IP_TUNNEL_INFO_TX)
 				vxlan_xmit_one(skb, dev, vni, NULL, false);
 			else
-				kfree_skb(skb);
+				kfree_skb_reason(skb, SKB_DROP_REASON_TUNNEL_TXINFO);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2793,7 +2793,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			dev_core_stats_tx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2816,7 +2816,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (fdst)
 			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
 		else
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
 	}
 
 	return NETDEV_TX_OK;
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 0d931a0dae5a..9f6ca70fc470 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -96,7 +96,9 @@
 	FN(VXLAN_VNI_NOT_FOUND)		\
 	FN(MAC_INVALID_SOURCE)		\
 	FN(VXLAN_ENTRY_EXISTS)		\
+	FN(VXLAN_NO_REMOTE)		\
 	FN(IP_TUNNEL_ECN)		\
+	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
 	FNe(MAX)
 
@@ -439,11 +441,15 @@ enum skb_drop_reason {
 	 * entry or an entry pointing to a nexthop.
 	 */
 	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
+	/** @SKB_DROP_REASON_VXLAN_NO_REMOTE: no remote found for xmit */
+	SKB_DROP_REASON_VXLAN_NO_REMOTE,
 	/**
 	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
 	 */
 	SKB_DROP_REASON_IP_TUNNEL_ECN,
+	/** @SKB_DROP_REASON_TUNNEL_TXINFO: tx info for tunnel is missed */
+	SKB_DROP_REASON_TUNNEL_TXINFO,
 	/**
 	 * @SKB_DROP_REASON_LOCAL_MAC: the source mac address is equal to
 	 * the mac of the local netdev.
-- 
2.39.5


