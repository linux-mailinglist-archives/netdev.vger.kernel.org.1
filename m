Return-Path: <netdev+bounces-118887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D4A9536D1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459341C23655
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AF81A76C1;
	Thu, 15 Aug 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gOwnxxVT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K72e86Xw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e+u0tcs7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NvshA/QO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A319F49C;
	Thu, 15 Aug 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734868; cv=none; b=s9hNh01eCo5Zk6jEOorMxlWVGxRJJL0Bnm06nJmuxPpI1QB5BoNyYFKh2k6r2T6dr/3FfEqToqxhSEnJYL9pBR19wrRiK/ZH+nbshCvmaZKFnA8uSPV4idpdSyOK/142cBEhc/WaHz/6Bi41/rOo8zBnKHPxyf2+25SqpRcp74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734868; c=relaxed/simple;
	bh=IhFK3y645P0bDgxIyMoMcTzFNThrkvebX7nJA29NB4M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TpITod6RzaEro2CD8JJ7+VyTKs/Qyg6wJV6p5vBROirwigTE6p/1v/V404dTtu+qkanAzxBPq/ro74jqXaUn1gWbZGHWS5uJnUWR0tPhUeyLTw8pVRH0vOcpzHfz25aqLMz5Kn4kySp+aFq8NRABPbTrcPRi2rqmAINyT94ltIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gOwnxxVT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K72e86Xw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e+u0tcs7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NvshA/QO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E8C420029;
	Thu, 15 Aug 2024 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723734864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2cKgRGJO5WlplHfZHnhQEmWHeHizXxXj0Q4z6lX7e9A=;
	b=gOwnxxVT2ZiPOAkUIU9FQd9F33yY3d9AxTY2QJ9GTU4dGREJh01h7J/K6XJclP5scGbIOI
	1go79LdtWI6g+ZpbQhjoMKbt4kQUqvWs3aECtmLBRr+3wZlQRo4ty7ogycco1yY56xd6uX
	ZLe4Mqi+WzhoIjxOKT50qZG+oKf3UZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723734864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2cKgRGJO5WlplHfZHnhQEmWHeHizXxXj0Q4z6lX7e9A=;
	b=K72e86XwRyyx0uiVqxiQKq6IjSHilTHdH9ZT9s/CnLg0QscBBexmSTIrCH8ZJlXQx8fCzf
	FfqVSCpCtdg0B+DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723734863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2cKgRGJO5WlplHfZHnhQEmWHeHizXxXj0Q4z6lX7e9A=;
	b=e+u0tcs7HVTuvOVwvhjl0fWtnaFDVcr2hDhBHUBI7xm0+8BTCCWPZEKzMJkH3PQL2w46q6
	yvv5dz176qGkfY+Bd6y5H2PEfTAc2TgoBDdwAiw1ntFP4YqqGLiV1OdAdcBQnF1CEekWJI
	GETs3zB68k3FPqoAmqyMgXxSrazXA+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723734863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2cKgRGJO5WlplHfZHnhQEmWHeHizXxXj0Q4z6lX7e9A=;
	b=NvshA/QOTQCdVb7tCPgE/aBIccEydsqfbUJtnzY46ej68fcmwDEwxTUf7dlcN7MD56b08e
	/8bchd9rWW4FFtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0793C13983;
	Thu, 15 Aug 2024 15:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9/mlAU8bvmYHCwAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Thu, 15 Aug 2024 15:14:23 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] ip6_tunnel: Fix broken GRO
Date: Thu, 15 Aug 2024 17:14:16 +0200
Message-Id: <20240815151419.109864-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

GRO code checks for matching layer 2 headers to see, if packet belongs
to the same flow and because ip6 tunnel set dev->hard_header_len
this check fails in cases, where it shouldn't. To fix this don't
set hard_header_len, but use needed_headroom like ipv4/ip_tunnel.c
does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
v2:
  - Added Fixes tag
  - Fixed broken reverse christmas order
v1: https://lore.kernel.org/lkml/20240813115910.87101-1-tbogendoerfer@suse.de/
 net/ipv6/ip6_tunnel.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9dee0c127955..87dfb565a9f8 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1507,7 +1507,8 @@ static void ip6_tnl_link_config(struct ip6_tnl *t)
 			tdev = __dev_get_by_index(t->net, p->link);
 
 		if (tdev) {
-			dev->hard_header_len = tdev->hard_header_len + t_hlen;
+			dev->needed_headroom = tdev->hard_header_len +
+				tdev->needed_headroom + t_hlen;
 			mtu = min_t(unsigned int, tdev->mtu, IP6_MAX_MTU);
 
 			mtu = mtu - t_hlen;
@@ -1731,7 +1732,9 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct ip6_tnl *tnl = netdev_priv(dev);
+	int t_hlen;
 
+	t_hlen = tnl->hlen + sizeof(struct ipv6hdr);
 	if (tnl->parms.proto == IPPROTO_IPV6) {
 		if (new_mtu < IPV6_MIN_MTU)
 			return -EINVAL;
@@ -1740,10 +1743,10 @@ int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
 			return -EINVAL;
 	}
 	if (tnl->parms.proto == IPPROTO_IPV6 || tnl->parms.proto == 0) {
-		if (new_mtu > IP6_MAX_MTU - dev->hard_header_len)
+		if (new_mtu > IP6_MAX_MTU - dev->hard_header_len - t_hlen)
 			return -EINVAL;
 	} else {
-		if (new_mtu > IP_MAX_MTU - dev->hard_header_len)
+		if (new_mtu > IP_MAX_MTU - dev->hard_header_len - t_hlen)
 			return -EINVAL;
 	}
 	WRITE_ONCE(dev->mtu, new_mtu);
@@ -1887,12 +1890,11 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	t_hlen = t->hlen + sizeof(struct ipv6hdr);
 
 	dev->type = ARPHRD_TUNNEL6;
-	dev->hard_header_len = LL_MAX_HEADER + t_hlen;
 	dev->mtu = ETH_DATA_LEN - t_hlen;
 	if (!(t->parms.flags & IP6_TNL_F_IGN_ENCAP_LIMIT))
 		dev->mtu -= 8;
 	dev->min_mtu = ETH_MIN_MTU;
-	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len;
+	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len - t_hlen;
 
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
-- 
2.35.3


