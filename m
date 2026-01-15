Return-Path: <netdev+bounces-250074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54843D23C02
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F0F13048510
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9135CBC9;
	Thu, 15 Jan 2026 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OutONDYw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAF35B130
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470111; cv=none; b=uuNSOTcX9ccj7vTF/b2SnCIFiIn96WaBeFdgKGMTOJKRYOBnzFUivzZzKowjIidv53yV2exHFUelqZNEWIrxTfqJ7mzZeO4g7N9XtgSlAboz+SgP6kGq/9qDAGoL/iCyKwrhZrEBMx21I1Zquf0lhHUZck/akm5Ftf7ekN/rciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470111; c=relaxed/simple;
	bh=rIDbod+5PhHfWnCeEqeAnlXqMlpTvjREx4POHkm/2/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aTkV6mAJ19CFbmSKzjgp3gu253tjsV1FQZq4dfjbsOwXc526eUnPc4YKHZ2EQ3SNqaGWiMRG90tM8cSrScCgCaoGohSF6A3V3YJz3x/psuRBV5vAINXtB888gAyL7dR823BdKuy5JK7lrsCeiJ3Xkmc4vsDOy2BBU4Qs6e1488Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OutONDYw; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88233d526baso26551586d6.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768470108; x=1769074908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgHbUIoDMmCNIMWscCtl0fTgyKkLS4/xvz0vZlzAUGk=;
        b=OutONDYw9ptBdCprz8NO2s6q8jsKS569lQAInPDY/rSTAJc6/UyM0r8zAIC9ABvENN
         ysoe2qFfyiD84dSpnel/IkKoWIHvpoK0TlEdzBYUSTLNQedMI9BHPeIwiBlYEDpWknuf
         63Uvg/2QEE5Ym+u4GgAvfmKTDN8/jTR5qSBTVpHb9S/S/1GTL6qPuVYrcTEr16myNv/v
         IJm0GBTiX4d8fkd6bg0eJx6wV41bCVakUSKgijvr7k7q32JCbZ8gTPt8+zj/YFigtEU4
         1AOj8TeZ4SZD8uJ9LaJAWjlchsX6vop22yAD+Z7iwhFjnF+Ltyuhmqe54LvWs5nFlUAX
         ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470108; x=1769074908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgHbUIoDMmCNIMWscCtl0fTgyKkLS4/xvz0vZlzAUGk=;
        b=TDfgpffwDn9zLAGlya5X0PhsYoU/Kx3XiNZsOfsoLx+ByYvmr2OWCih3MFAuCeWXHC
         UnV+mimRSWS/yoI7RaYctpWKxvbYL/SDN3L2gU9hP0amJLoqN1Hmg1TY+684uH1+w1wV
         hyraoGvirwIenGZs+rUUBiQXbnWEKCiVKS7527CFsu/76gVbjlmmeuNlRVlKr61o/kmo
         M7x/HmJVfu7Eoh8xGvB4CyR7c4SO9VhS3Az1KImuz4/jAWYJXXh4vXfWa17B9f5uD/Ho
         6nilw6oQoYvg11tS+Wv6tIwuVInCaOW4yMGALULItFZZVGMT1ZOaWJKRRlGOxhXyv6qx
         FYIA==
X-Forwarded-Encrypted: i=1; AJvYcCWCG/8VKQrjvhutFF1blvc3dFSGnRX5NWC64AGKopsr3GxxRtC+gKrxeMIg/29z8fbOBQdd4Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGzJ5zdJw0bugle0ZRELK12ro4JLR5RW4ZQ9z38dtz2aFG/JD
	bJ3ouHLN7iQsh7HSinOpIydjGTVJ0OCkBZmKRFzNksZt/yle3sEqLKgZOAFlSWPXk/d5DInIiS7
	KtDPmGIpZfTRoDA==
X-Received: from qvbom27.prod.google.com ([2002:a05:6214:3d9b:b0:892:72f1:41d0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:e64:b0:890:80b9:122c with SMTP id 6a1803df08f44-8927439b947mr70532266d6.27.1768470108393;
 Thu, 15 Jan 2026 01:41:48 -0800 (PST)
Date: Thu, 15 Jan 2026 09:41:35 +0000
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115094141.3124990-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115094141.3124990-3-edumazet@google.com>
Subject: [PATCH net-next 2/8] ipv6: annotate data-races from ip6_make_flowlabel()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use READ_ONCE() to read sysctl values in ip6_make_flowlabel()
and ip6_make_flowlabel()

Add a const qualifier to 'struct net' parameters.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6.h | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 74fbf1ad8065a6596487b72af70131919a26c5a2..7873b34181d9bbf18cc61522967e6db5d646813c 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -949,10 +949,12 @@ static inline bool ipv6_can_nonlocal_bind(struct net *net,
 
 #define IP6_DEFAULT_AUTO_FLOW_LABELS	IP6_AUTO_FLOW_LABEL_OPTOUT
 
-static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff *skb,
+static inline __be32 ip6_make_flowlabel(const struct net *net,
+					struct sk_buff *skb,
 					__be32 flowlabel, bool autolabel,
 					struct flowi6 *fl6)
 {
+	u8 auto_flowlabels;
 	u32 hash;
 
 	/* @flowlabel may include more than a flow label, eg, the traffic class.
@@ -960,10 +962,12 @@ static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff *skb,
 	 */
 	flowlabel &= IPV6_FLOWLABEL_MASK;
 
-	if (flowlabel ||
-	    net->ipv6.sysctl.auto_flowlabels == IP6_AUTO_FLOW_LABEL_OFF ||
-	    (!autolabel &&
-	     net->ipv6.sysctl.auto_flowlabels != IP6_AUTO_FLOW_LABEL_FORCED))
+	if (flowlabel)
+		return flowlabel;
+
+	auto_flowlabels = READ_ONCE(net->ipv6.sysctl.auto_flowlabels);
+	if (auto_flowlabels == IP6_AUTO_FLOW_LABEL_OFF ||
+	    (!autolabel && auto_flowlabels != IP6_AUTO_FLOW_LABEL_FORCED))
 		return flowlabel;
 
 	hash = skb_get_hash_flowi6(skb, fl6);
@@ -976,15 +980,15 @@ static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff *skb,
 
 	flowlabel = (__force __be32)hash & IPV6_FLOWLABEL_MASK;
 
-	if (net->ipv6.sysctl.flowlabel_state_ranges)
+	if (READ_ONCE(net->ipv6.sysctl.flowlabel_state_ranges))
 		flowlabel |= IPV6_FLOWLABEL_STATELESS_FLAG;
 
 	return flowlabel;
 }
 
-static inline int ip6_default_np_autolabel(struct net *net)
+static inline int ip6_default_np_autolabel(const struct net *net)
 {
-	switch (net->ipv6.sysctl.auto_flowlabels) {
+	switch (READ_ONCE(net->ipv6.sysctl.auto_flowlabels)) {
 	case IP6_AUTO_FLOW_LABEL_OFF:
 	case IP6_AUTO_FLOW_LABEL_OPTIN:
 	default:
@@ -995,13 +999,13 @@ static inline int ip6_default_np_autolabel(struct net *net)
 	}
 }
 #else
-static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff *skb,
+static inline __be32 ip6_make_flowlabel(const struct net *net, struct sk_buff *skb,
 					__be32 flowlabel, bool autolabel,
 					struct flowi6 *fl6)
 {
 	return flowlabel;
 }
-static inline int ip6_default_np_autolabel(struct net *net)
+static inline int ip6_default_np_autolabel(const struct net *net)
 {
 	return 0;
 }
-- 
2.52.0.457.g6b5491de43-goog


