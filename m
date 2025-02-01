Return-Path: <netdev+bounces-161904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B56AA24887
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11B7164FB6
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822B014AD38;
	Sat,  1 Feb 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG9BjrJy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43D20318
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738409648; cv=none; b=E8GAnoQY7m77xGrblLnQoYnJwpTQc2FWF3prGHKrX/DJUC80tXxJJ+JXxfv44CyOnATRdSHWQsiz+22lB04TeDKmZh4mGuwT0HP6tdJKIsz+iFrjxauh2QMfUchnRE+o13NepyyHNHhojAAfK6W61yVzAUpQtuNz3/srJ0p6wfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738409648; c=relaxed/simple;
	bh=yGnyHCQuTpx8WEw3v+KjIpwR56gPbmp8NO5HU9ftjc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/WphrIavUfHCS1VO+PwlN/wqg8B/Omly8aakwReTzH3WwMGHZGX5N6x3YnQ79w6qtIzHTnrFGNq3SvWgQzvsDUDfQmAwJ+H4OX8rcI/+NnLfazdriKZoWJIawEHzDHIbp3TnQydiE1dZYYPTD54mOc0guSTZCXbQuyHnRWf26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG9BjrJy; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f31b3db5ecso1196150eaf.0
        for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 03:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738409646; x=1739014446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoJiyaiT8zL1pH/96yxqbiCU0Z2RsXjlcsoQBn1gDO0=;
        b=AG9BjrJyHwgo45bpCGX6vdQsazeUrCeL58KKglUx9K1O8f99rWH8S7/e28kzo4oB3E
         5MrR3RNnqdzSnypy0RcFGm6mxSeOedr7jvke4H2rqSmDiUrNONxcWrDDmLgb2ZH0Z2Iz
         sJt9kgd448lzrnrah4zE7A/WnSJ6PtnvJnXjKtR97yINes8LVEQVxIYFFKuDxho+1dOl
         MP147WsrwHKO4ycgm1aYr82Pv3ZiVQXzpnajDLK4zjLO36KWrtYRc+D/yuJcqVTckOlE
         I62+lOukpABDftRbae+heKOp8eLXHADsyp/HCQGv+vSHTi8AomcH8eQNk/f1K6b3K/Ey
         bqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738409646; x=1739014446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoJiyaiT8zL1pH/96yxqbiCU0Z2RsXjlcsoQBn1gDO0=;
        b=Ak0dS1YxeQzNQsewqPl3G25q/eZ7IdG1WpNFGW9IiLcIKJsGDFcQ74HhXCqtlQ1oFI
         WO3c4PsAZUI2/BgYYnoKLIM87AFfWXh+MEgni5uUuSjwY8W9W2w7+EmPZmt38zpRPH9+
         2h2gH2DDeM00XKzsjrPdsDYFn+j6zCnSYNkub7S9kvBaB174PzBXFtKmTb4SIReANlQW
         VURDaEeWYnD0OM6HU6gAoMJ2LofuPpEOzRdKvwMfBapQBzM67FGOO064TzTbWw5RIBEp
         aINzabGH0ZcNsAMsesabifsNxSxXiPaQCrBib3ekAPicsKN5nK/XaYFLceNGzbsx8yhv
         +LfA==
X-Gm-Message-State: AOJu0Yx0MvPtaBALTg4Gbj9o54Cav6MSPp/bQz9DAxoLdcYl0OixnaA5
	1jFwpNtcn9VH6NTuq36dCk8U1yjYf3Vjxfw+jqA9I7gGCblZLgA=
X-Gm-Gg: ASbGncup82yodJ90CRHkjoPDxUrHTBRiFNF9sK40O0CcPWK3LIE0mKPV0rK4vYbv3oY
	Ihd5Cr+gZBWW5esVpO6AxXct7uSvAIpN4Uq37lGJ9C5g67bT2bzFNptwyY39vJAfsSwhwp0SEle
	aJxyK623Zd+f0eLS505WfMiN5Epqd3BUzVBtp+OMAVwITxqMqZFMgUX2yBdk08Tp43gGEhrcOvX
	J9xY3dce2dnoDoiXUzCrK78v+2/zRqP4vBTs7QGe01QM31oHgRBGg8grFVho1287sKRzVIhiQ+h
	SK2+I4hoEtBzOVtTXQ==
X-Google-Smtp-Source: AGHT+IFDYNybLd2DtYz4Mw4fFBKYf3qjUGIhdKA64ghpVPrhGQpGa6BeQJnAfZJHFw1ganDDuHZnFQ==
X-Received: by 2002:a05:6871:d30b:b0:297:28e3:db63 with SMTP id 586e51a60fabf-2b32f09982fmr8965341fac.19.1738409645622;
        Sat, 01 Feb 2025 03:34:05 -0800 (PST)
Received: from ted-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356112310sm1820645fac.5.2025.02.01.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 03:34:05 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>
Subject: [PATCH RFC net-next 1/3] vxlan: vxlan_vs_find_vni(): Find vxlan_dev according to vni and remote_ip
Date: Sat,  1 Feb 2025 19:34:00 +0800
Message-Id: <20250201113400.107815-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201113207.107798-1-znscnchen@gmail.com>
References: <20250201113207.107798-1-znscnchen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_vs_find_vni() currently searches the vni hash table in a vs and
returns a vxlan_dev associated with the specified "vni". While this works
when the remote_ips are stored in the vxlan fdb, it fails to handle the
case where the remote_ip is just configured in the vxlan device outside of
the vxlan fdb, because multiple vxlan devices with different remote_ip may
share a single vni when the remote_ip is configured in the vxlan device
(i.e., not stored in the vxlan fdb). In that case, further check of
remote_ip to identify vxlan_dev more precisely.

Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 05c10acb2a57..3ca74a97c44f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -94,8 +94,10 @@ static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
 
 static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
 					   int ifindex, __be32 vni,
+					   const struct sk_buff *skb,
 					   struct vxlan_vni_node **vninode)
 {
+	union vxlan_addr saddr;
 	struct vxlan_vni_node *vnode;
 	struct vxlan_dev_node *node;
 
@@ -116,14 +118,31 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
 			continue;
 		}
 
-		if (IS_ENABLED(CONFIG_IPV6)) {
-			const struct vxlan_config *cfg = &node->vxlan->cfg;
+		const struct vxlan_config *cfg = &node->vxlan->cfg;
 
+		if (IS_ENABLED(CONFIG_IPV6)) {
 			if ((cfg->flags & VXLAN_F_IPV6_LINKLOCAL) &&
 			    cfg->remote_ifindex != ifindex)
 				continue;
 		}
 
+		if (vni && !vxlan_addr_any(&cfg->remote_ip) &&
+		    !vxlan_addr_multicast(&cfg->remote_ip)) {
+			/* Get address from the outer IP header */
+			if (vxlan_get_sk_family(vs) == AF_INET) {
+				saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
+				saddr.sa.sa_family = AF_INET;
+#if IS_ENABLED(CONFIG_IPV6)
+			} else {
+				saddr.sin6.sin6_addr = ipv6_hdr(skb)->saddr;
+				saddr.sa.sa_family = AF_INET6;
+#endif
+			}
+
+			if (!vxlan_addr_equal(&cfg->remote_ip, &saddr))
+				continue;
+		}
+
 		if (vninode)
 			*vninode = vnode;
 		return node->vxlan;
@@ -134,6 +153,7 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
 
 /* Look up VNI in a per net namespace table */
 static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
+					const struct sk_buff *skb,
 					__be32 vni, sa_family_t family,
 					__be16 port, u32 flags)
 {
@@ -143,7 +163,7 @@ static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
 	if (!vs)
 		return NULL;
 
-	return vxlan_vs_find_vni(vs, ifindex, vni, NULL);
+	return vxlan_vs_find_vni(vs, ifindex, vni, skb, NULL);
 }
 
 /* Fill in neighbour message in skbuff. */
@@ -1701,7 +1721,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	vni = vxlan_vni(vh->vx_vni);
 
-	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
+	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, skb, &vninode);
 	if (!vxlan) {
 		reason = SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND;
 		goto drop;
@@ -1855,7 +1875,7 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
 		return -ENOENT;
 
 	vni = vxlan_vni(hdr->vx_vni);
-	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, NULL);
+	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, skb, NULL);
 	if (!vxlan)
 		return -ENOENT;
 
@@ -2330,7 +2350,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 		struct vxlan_dev *dst_vxlan;
 
 		dst_release(dst);
-		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
+		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, skb, vni,
 					   addr_family, dst_port,
 					   vxlan->cfg.flags);
 		if (!dst_vxlan) {
-- 
2.39.2


