Return-Path: <netdev+bounces-270036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPLVBE6avWmR/QIAu9opvQ
	(envelope-from <netdev+bounces-270036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:04:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 683C72DFB07
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B952E3041D67
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CAC2F0661;
	Fri, 20 Mar 2026 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOnd+wvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB662DB7AB
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033323; cv=none; b=ibjpeMA/lZ4Co4rKakmDkDLsQMUAtQAfl1sdns/vopiUvIiNz8koB/KLZMlDQXzo6tLmqaXCuytC0a/Pw7fCElC+8pPbUJ6OvNXYYEMKwNEKfgyMLpf3uovyZFadAhqQqEPdynNJy+JCPIwNYpfGp+EwU9Il2fr+xzA/EmujFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033323; c=relaxed/simple;
	bh=ccUI6jM2nybPoK5MYdOpHmVaJZygNSNodoJKk+GY4PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBdY+zn7d/kXqB0SxsB5yUlnHxVUBDqn3PtkjLc1V41bpBeKFslYfiUSne9yivGdxwSLfEQvWBWtsPhD8m8SPmSTY75DDJoZOEOyxdHXFdAP/lJYB9OWXHDHc7sJhi/ATCenOR6DeqTtzjqz+4RCmJAxc8ed0HQKuJPztY/UZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOnd+wvl; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ea73e7b60so1747969d50.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774033321; x=1774638121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LKII24aXXYTMcv/Z2LM8O3cfYOKRyYvXiYN+sxWGmS4=;
        b=SOnd+wvlr//zUfchDDbYMpn4qXo0btcjaa3KAYl0QjOdQXXbv+jAj2URnOHn93nBuh
         WxOE4/qi8XDi5lOMW0J0Vxp+3PjYkEbKVNCtaNN3e0cLjmXbt48u9FcGSCt6hIcrVgn/
         gjecMk17DFCuSNwFTi+0Uee9EHr6xDTd5XZltoyPtVh/ZJECW7Zn1RJtbIHX12KX0H/8
         +ThV0tO0ShRymDlX9iY18j+9wJfL9VTDAFQUoJKJNfBAuth94kXCJpsEcj9q0DarmmoF
         4eE386JK+65PRX5+IHyIq56rCep0WoLQckTPcdOtnILAQ7WKvWpHgBAht5HJZ2+a/8ZL
         mKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033321; x=1774638121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKII24aXXYTMcv/Z2LM8O3cfYOKRyYvXiYN+sxWGmS4=;
        b=dFRUZHsd7F8XkT6w0oCoaGctz289f09w4PyMkcD7jR+sixkqStK6Hco3euhmz/ocDK
         N+h2rB3xdoTg3uqIZRm0KwARrwaUebT7AOwI8PMCOMB6y1g6WkKNcZD7pLDmuY2g2HxR
         4qFYcygoY+aRoMmHkKkp8rU9UP0gQlioKy9TbpXKSLxYqNQvVH4HHYlhXS1S64kWdV06
         +UYvs0iH9lYAa7xq3c66FOoV7J1olK+Tr6ButoHcYOiwtxZKzlo8yRXhfEwTYhXhFmC/
         sFwZGUIjjhVBrD5uSeQPpMELE63wMus+53cNfdwxx3h1mI6PsmlCvp5koKg+4pzytUE9
         ZoGA==
X-Gm-Message-State: AOJu0YzYj7vLOI7XtQq4pPt0CMuz3v6WqnELhFMLgtOTUwiOX5KF0pbH
	R7B9XYEN5TubuvfwfXFQk5q2cLAPe9OitGf+Wrga3svNb70wudFWc6UnyF1fKg==
X-Gm-Gg: ATEYQzyF0dYw6Wq88MYJ733yzc2VPr5As6Htw1q75leML0A/zt/3NvmiKZIgbODTfCe
	qr/k14nrra+5QMoSkwwf/lw9g7X47ylmuPLCDvQ0EBkn8xhRMAjd5rDudhV/m2ERYmGOySCKHWt
	9fjj3UEWrvFABslvI8mjTHnIQEopf+zx5ld2wrhg6QvtO3OgMs1V9OVQMJbtnGgB1XgMDervgeZ
	cxjU6IPfIxwq+kwB65O31pEu92HkvPU9lul/z4d6W83PlJrK/CiW/JPB7cGuFa/AMPp7mnddKR5
	hw44MZ6Q0qMUcGlsvyxeJgA7RBWLd9Sev4dJ8SCQfRdUnU6OAlXRI10Hf0IaBOpBouLctfEWv3K
	udINf2K2cMrhnAV6dz2PxeEs6HqgP81ZZDpIDD/dPSi98HkDgCDHRJBIrz5QCkB+8miwd7rVt4w
	fD+rkPaRoVe6GhA+LRWiSxqSPEmuoLRKIlUktcYA5qUeKOTl7IbUcP80oY3RlEzZFaDqNVBvzvx
	9xvUqAv+NjPbiXHQnipacgkOcE=
X-Received: by 2002:a05:690c:dd3:b0:79a:3f1c:4afe with SMTP id 00721157ae682-79a90c5109fmr46354447b3.56.1774033319289;
        Fri, 20 Mar 2026 12:01:59 -0700 (PDT)
Received: from willemb.c.googlers.com.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a9057b4ecsm20955277b3.35.2026.03.20.12.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:01:58 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org,
	Tangxin Xie <xietangxin@yeah.net>
Subject: [PATCH net] net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback
Date: Fri, 20 Mar 2026 15:01:46 -0400
Message-ID: <20260320190148.2409107-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,yeah.net];
	TAGGED_FROM(0.00)[bounces-270036-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.877];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 683C72DFB07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Willem de Bruijn <willemb@google.com>

NETIF_F_IPV6_CSUM only advertises support for checksum offload of
packets without IPv6 extension headers. Packets with extension
headers must fall back onto software checksumming. Since TSO
depends on checksum offload, those must revert to GSO.

The below commit introduces that fallback. It always checks
network header length. For tunneled packets, the inner header length
must be checked instead. Extend the check accordingly.

A special case is tunneled packets without inner IP protocol. Such as
RFC 6951 SCTP in UDP. Those are not standard IPv6 followed by
transport header either, so also must revert to the software GSO path.

Cc: stable@vger.kernel.org
Fixes: 864e3396976e ("net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6_CSUM")
Reported-by: Tangxin Xie <xietangxin@yeah.net>
Closes: https://lore.kernel.org/netdev/0414e7e2-9a1c-4d7c-a99d-b9039cf68f40@yeah.net/
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/core/dev.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 14a83f2035b9..fc5557062414 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3769,6 +3769,22 @@ static netdev_features_t dflt_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
+static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
+{
+	if (!skb->encapsulation)
+		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
+			 (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+			  vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
+			skb_transport_header_was_set(skb) &&
+			skb_network_header_len(skb) != sizeof(struct ipv6hdr));
+	else
+		return (!skb_inner_network_header_was_set(skb) ||
+			((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
+			  (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+			   inner_ip_hdr(skb)->version == 6)) &&
+			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
+}
+
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
 					    struct net_device *dev,
 					    netdev_features_t features)
@@ -3816,11 +3832,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
-	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
-	    skb_transport_header_was_set(skb) &&
-	    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+	    skb_gso_has_extension_hdr(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
-- 
2.53.0.959.g497ff81fa9-goog


