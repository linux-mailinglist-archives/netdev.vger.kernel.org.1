Return-Path: <netdev+bounces-170646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851BA49715
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6525918892D5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764025D526;
	Fri, 28 Feb 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="AgwWGUMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395F157A55
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738109; cv=none; b=GvnBho/lNMSKLL6pyJymS2fxvzBGdG0JKyWevAvSbMdlC7uJadpCVYG3l7T1BBfgIYtCh9IITFecDazUVJANPQHQGUSlOy2PAZzid9qvY36cmcfqX9/zDYdLfSBLLIn4ftizI7NPzIjyKSwSkLmqe6UxT4SmLdl+invK9Chtx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738109; c=relaxed/simple;
	bh=ev3jcClBm0/UlWGLZk9GAz3V7Axko4AwetFnS2iSMZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMExqJfKlwhAJersz9qDcxNs8tkhxM8DOX+3xAEXMAWcCu3GHnQ4ruOlOEdTt13pFW0+u1mYnbcwrHuBCxJZhdc7oIy4MwBfXVS2ECwHzceB0oQkAYBPUTv/zCYZ/C5TAXo8rJHzKBNH0IBNlINTnn8g72GKSB39ItGnIvVSk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=AgwWGUMG; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-390debc81d1so177907f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740738106; x=1741342906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph4NE2EWoc8N+xxWzSkjuPjoZHyPJIbxipfLCY5RZ24=;
        b=AgwWGUMGV0YzbQBhoMs1E4jVPRCO3FIjCWa5PeTKFCXohK4B/91osDVb2J42qbK16f
         Duo30O4M+wlBD0wYU+6aeXQUPZvXSVqOrWjMa01mp3Xs+dLMXJ41UTFpN3lqjPQIPmpH
         9nwJ18PWAGUjxRe9Qd6PFEZtZ9ItUW2lyTlLz9bOtrcBD1rwGoCwBrhESoO8KmWG6iSr
         hAv09xMVCodbmw3mRNo2tyhhpGU5r+Dr7Cx++JRYDqcl+65Psk+n4DyM6xN0QsrRLUD6
         beRrUAkQqREnJqpKZBMGXoHRO9VSOQq7iQP7s19JDuYW3ohkiVBYgD3vWsXNkOnowHmR
         p3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738106; x=1741342906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph4NE2EWoc8N+xxWzSkjuPjoZHyPJIbxipfLCY5RZ24=;
        b=AqOLGV/t6dgyEkUPAEYvFzOzwVTP0/SyzimLpm0mw+Sf2yIiJEPVCLHNVOBs1fHBZ8
         lL7ij2oIw0JyyUV9nmp8ljpGKHnbTU3SwSUtinEniPO3pbxVKA//PuLFHz+NNU9oS8Z+
         qQsxqep+PqwG6P/h1moTIGZQ9uJ3fGjCYXXFvQACeReSorKv/zwqhfIiSgvb/YUhrygT
         7J583yQ3jL4qNnMGHI1xtGZ56Aikr4a3gudldf2AjWkph9OsC8VBhtg/9lM21YSOOE49
         IBWKJB/vA3rEzJZsbjobjetEAvqNFq1Lj/UJ4ghnRfO/mZ7fYxtsXndmKHY8/saXNmru
         9NJg==
X-Forwarded-Encrypted: i=1; AJvYcCW22jGclGyQU4PObWn5yvEciNXgSOaheWVbvesBXx3yZpBWzhyZeBqaWCJwnzcaPGHZIuvs4nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpiYmIfHmqvPMq7A71JJUibnqV29OU/BU5b/kc02GUvgnyezJ
	7flc+j46lzUyjO/Fdtue3XmUTcuUwyPeYN6lKkuYoHk7NC6xAJq59gySO6KzHA6qqRw6rPnKsg1
	4rkELUKIx6s1BnYPPiOFTkGZfuwtDGgkF
X-Gm-Gg: ASbGncvL8BJrzOQGeMqBVh9Mx5c74h1eNoxeFhb0DLXZvdZYXYDTL34tAQ7CCyWEutd
	7SKfvhPqsm9mpi+/Uq8sK6hD0OYRYTgGQqQRXBu3vzhRSLhyulSAbn5GuhtqTdMfEI45YhCl5Uw
	jxhTzHysOPD524BmqmkyKtCW9uZ91+aO4tQfqq8foIv17fmzYuPr2d7VlEZq0ODgXGWyTkdGtKS
	nyJnua6WLGLITOBQR72h10kYoS5m1bWK3SbCOB16bIlHnW+9wP+GQpKF2D6jDvElt7WEM5BLrk/
	CTmchKLDP5+poP+qq7pmdBwVApBjtbp+HPU8KzHOMRzQAapjCvmNEH3DG2AvTdej4RJxNfA=
X-Google-Smtp-Source: AGHT+IEiF1Zzdx8mqFPfDVf+h2A/lqC/5lvOIS4uRjqOGRC1mYV1Ky4UK9tVxDvZxuyJtP9t+wA6DhERXb7F
X-Received: by 2002:a05:6000:1887:b0:38d:e078:4393 with SMTP id ffacd0b85a97d-390ec9c1bb1mr841609f8f.6.1740738105739;
        Fri, 28 Feb 2025 02:21:45 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-43aba5746dfsm4681995e9.44.2025.02.28.02.21.45;
        Fri, 28 Feb 2025 02:21:45 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 8AD3E18602;
	Fri, 28 Feb 2025 11:21:45 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tnxV3-000eHx-AM; Fri, 28 Feb 2025 11:21:45 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v6 2/3] net: advertise netns_immutable property via netlink
Date: Fri, 28 Feb 2025 11:20:57 +0100
Message-ID: <20250228102144.154802-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228102144.154802-1-nicolas.dichtel@6wind.com>
References: <20250228102144.154802-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to
dev->netns_local"), there is no way to see if the netns_immutable property
s set on a device. Let's add a netlink attribute to advertise it.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 Documentation/netlink/specs/rt_link.yaml | 3 +++
 include/uapi/linux/if_link.h             | 1 +
 net/core/rtnetlink.c                     | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 8b5c0f067328..31238455f8e9 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1160,6 +1160,9 @@ attribute-sets:
         name: max-pacing-offload-horizon
         type: uint
         doc: EDT offload horizon supported by the device (in nsec).
+      -
+        name: netns-immutable
+        type: u8
   -
     name: af-spec-attrs
     attributes:
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3b586fb0bc4c..318386cc5b0d 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -378,6 +378,7 @@ enum {
 	IFLA_GRO_IPV4_MAX_SIZE,
 	IFLA_DPLL_PIN,
 	IFLA_MAX_PACING_OFFLOAD_HORIZON,
+	IFLA_NETNS_IMMUTABLE,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b52e610e157e..8b6bf5e9bb34 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1292,6 +1292,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4) /* IFLA_TSO_MAX_SEGS */
 	       + nla_total_size(1) /* IFLA_OPERSTATE */
 	       + nla_total_size(1) /* IFLA_LINKMODE */
+	       + nla_total_size(1) /* IFLA_NETNS_IMMUTABLE */
 	       + nla_total_size(4) /* IFLA_CARRIER_CHANGES */
 	       + nla_total_size(4) /* IFLA_LINK_NETNSID */
 	       + nla_total_size(4) /* IFLA_GROUP */
@@ -2046,6 +2047,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		       netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN) ||
 	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
+	    nla_put_u8(skb, IFLA_NETNS_IMMUTABLE, dev->netns_immutable) ||
 	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
 	    nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
 	    nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||
@@ -2234,6 +2236,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_NETNS_IMMUTABLE]	= { .type = NLA_REJECT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
-- 
2.47.1


