Return-Path: <netdev+bounces-105233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F9910356
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF2C284099
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E621AC77D;
	Thu, 20 Jun 2024 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKJQ/NB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE41AC45F
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884046; cv=none; b=GAaGeLzQJTb5puk3JLYX40b71izITeP61zt2qvsEvh+JcjAnWEhLpjMMJOktSPnVgumqNNKHWQorfUILMXScIWfC1ZAP7w4VUy4qNU2aZr7aOZjXYrT7Atj7xC4KS67ZARSvjl8ZzfQak5onm6EZRw0enjrlinpZe2nCSbRE9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884046; c=relaxed/simple;
	bh=+T49OIRbKSaE+8+oJxEeRuCse4sjpV+WKYunARmT280=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q34cPyudHE2iaH9I4rtn+vH2foM3gDEkJwlggQNkjZbLdBmkOVdibMWVR5di0yNSaB+dsdWTT9gVF11kI1NFcCEGNpdhCUeG/3/7LqMYHfULhKJ55yqqtpDXFS0wPEQAgRl4OZ99On56Asl3iYYA/5COOiYcfhrFYHNje7CY5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKJQ/NB9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a08273919so12624357b3.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718884044; x=1719488844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JD3FBhuAf4qKqnoMJjK56b09cZCacV5PEgeQK14QU1Q=;
        b=fKJQ/NB9omNuuiqGgM6u7jTTUcaSmCHg/xaxBYKTba0u3BsPeu3bFw1qiBxRyHGb4/
         sGFZ4vnRRtGZSPhqyiv0s++tKTJqKvY3wBjzWs8+uRoYmtaRDlRDilfs2ESQwqp0HcvE
         2JLy6SYvktnWNwbEcWGGJj/rAJFjXro7/zSBDn9qd27Hcb93cM3kDyZIO+apmGPtnW9F
         HfGxq8DOU/HiRE7Z+zsrNxc2d/f1iag9BRyL4sFI25fQdV2wjw3jUe7MNeWLbBxDVKSS
         4cbNEjh53dRfc7ygWwsI598FrTgeYbir22l1x9n7PN35JdJYrza0LOODayed4jG3ZAAQ
         05ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884044; x=1719488844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JD3FBhuAf4qKqnoMJjK56b09cZCacV5PEgeQK14QU1Q=;
        b=Ji6us7IlEfWiV1ixpd5cZsODp2524QCeK32TzBAZwk8uHHqBA3IYRlPfRl7xHd9eBC
         yrAP7c5+e0rFwGXRSfbI2BSiGk8sqHf0lfG9nX45kQvlTPcUJORhaOqo0CErg6tRqJts
         qO7+erJPNKTuZYFLmaDaQ6QQOsMSKzHoVz/YfMr9alAXSZfF6wBNTStxDMRMLWcGkOfi
         ZuhGooKUv80GrxgSxF9yHrZ2qIkEYi7VvoERjz0I9W0zYHuqM6VvtBZ3P7paQgMc6Qmp
         Q5nUvi+fnoZmMK9AizzcGnbXZ6epxjqKEr4vBm0u+7QcHgDVS0qaZoCV1T8EaDHo8DVa
         mQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCUtNeAG1qC0sr8oYNQGtMI1n5fGhlpU9475OQvv8u/HaORoviqcN2slYIdbCbDTysmIRBoO7X33mndgo6W056hwfFx970vI
X-Gm-Message-State: AOJu0Yyv81p3fIsj1E/zg/axzY+c4JS9K09cy0z+nmE6KfXcWgjknKWt
	ZENOzhHWUmH1zKP2999llM0tJyQ9pjkeWHq6zq/KtbTcteGzgeHi82fdaXERT1nwVdUpYTcMIC5
	a41rLB07qZQ==
X-Google-Smtp-Source: AGHT+IGaeYUovy1thNl52BFgtKzBRdwkBirvhnowiuw2TaDijojjzJMrBDptmJJUPNkEsV2cLjF7v+UXvPY+DQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:25c7:b0:62c:de05:5a78 with SMTP
 id 00721157ae682-63a8f524cebmr11483177b3.6.1718884043947; Thu, 20 Jun 2024
 04:47:23 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:47:11 +0000
In-Reply-To: <20240620114711.777046-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620114711.777046-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240620114711.777046-7-edumazet@google.com>
Subject: [PATCH net-next 6/6] net: ethtool: add the ability to run
 ethtool_[gs]et_rxnfc() without RTNL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

For better scalability, drivers can prefer to implement their own locking schem
(for instance one mutex per port or queue) instead of relying on RTNL.

This patch adds a new boolean field in ethtool_ops : rxnfc_parallel

Drivers can opt-in to this new behavior.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/ioctl.c     | 43 +++++++++++++++++++++++++++--------------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107d3cc010dd2f1ecdb005c412145c461b6c..ee9b8054165361c9236186ff61f886e53cfa6b49 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -748,6 +748,7 @@ struct ethtool_rxfh_param {
  *	error code or zero.
  * @set_rxnfc: Set RX flow classification rules.  Returns a negative
  *	error code or zero.
+ * @rxnfc_parallel: true if @set_rxnfc, @get_rxnfc and @get_rxfh do not need RTNL.
  * @flash_device: Write a firmware image to device's flash memory.
  *	Returns a negative error code or zero.
  * @reset: Reset (part of) the device, as specified by a bitmask of
@@ -907,6 +908,7 @@ struct ethtool_ops {
 	int	(*get_rxnfc)(struct net_device *,
 			     struct ethtool_rxnfc *, u32 *rule_locs);
 	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
+	bool	rxnfc_parallel;
 	int	(*flash_device)(struct net_device *, struct ethtool_flash *);
 	int	(*reset)(struct net_device *, u32 *);
 	u32	(*get_rxfh_key_size)(struct net_device *);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 56b959495698c7cd0dfda995be7232e7cbb314a2..e65bd08412aeaf35d276ba48e1ebe71656e486fc 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -986,26 +986,34 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	if (rc)
 		return rc;
 
+	if (!ops->rxnfc_parallel)
+		rtnl_lock();
+
 	if (ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
 
 		rc = ops->get_rxfh(dev, &rxfh);
 		if (rc)
-			return rc;
+			goto unlock;
 
 		/* Sanity check: if symmetric-xor is set, then:
 		 * 1 - no other fields besides IP src/dst and/or L4 src/dst
 		 * 2 - If src is set, dst must also be set
 		 */
+		rc = -EINVAL;
 		if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
 		    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
 				    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
 		     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
 		     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
-			return -EINVAL;
+			goto unlock;
 	}
 
 	rc = ops->set_rxnfc(dev, &info);
+
+unlock:
+	if (!ops->rxnfc_parallel)
+		rtnl_unlock();
 	if (rc)
 		return rc;
 
@@ -1042,7 +1050,14 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 		}
 	}
 
+	if (!ops->rxnfc_parallel)
+		rtnl_lock();
+
 	ret = ops->get_rxnfc(dev, &info, rule_buf);
+
+	if (!ops->rxnfc_parallel)
+		rtnl_unlock();
+
 	if (ret < 0)
 		goto err_out;
 
@@ -3007,18 +3022,6 @@ __dev_ethtool(struct net_device *dev, struct ifreq *ifr,
 		rc = ethtool_set_value(dev, useraddr,
 				       dev->ethtool_ops->set_priv_flags);
 		break;
-	case ETHTOOL_GRXFH:
-	case ETHTOOL_GRXRINGS:
-	case ETHTOOL_GRXCLSRLCNT:
-	case ETHTOOL_GRXCLSRULE:
-	case ETHTOOL_GRXCLSRLALL:
-		rc = ethtool_get_rxnfc(dev, ethcmd, useraddr);
-		break;
-	case ETHTOOL_SRXFH:
-	case ETHTOOL_SRXCLSRLDEL:
-	case ETHTOOL_SRXCLSRLINS:
-		rc = ethtool_set_rxnfc(dev, ethcmd, useraddr);
-		break;
 	case ETHTOOL_FLASHDEV:
 		rc = ethtool_flash_device(dev, devlink_state);
 		break;
@@ -3180,6 +3183,18 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 		rc = ethtool_get_value(dev, useraddr, ethcmd,
 					__ethtool_get_flags);
 		break;
+	case ETHTOOL_GRXFH:
+	case ETHTOOL_GRXRINGS:
+	case ETHTOOL_GRXCLSRLCNT:
+	case ETHTOOL_GRXCLSRULE:
+	case ETHTOOL_GRXCLSRLALL:
+		rc = ethtool_get_rxnfc(dev, ethcmd, useraddr);
+		break;
+	case ETHTOOL_SRXFH:
+	case ETHTOOL_SRXCLSRLDEL:
+	case ETHTOOL_SRXCLSRLINS:
+		rc = ethtool_set_rxnfc(dev, ethcmd, useraddr);
+		break;
 	default:
 		rtnl_lock();
 		rc = __dev_ethtool(dev, ifr, useraddr, ethcmd, sub_cmd, state);
-- 
2.45.2.627.g7a2c4fd464-goog


