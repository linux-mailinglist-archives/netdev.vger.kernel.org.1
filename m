Return-Path: <netdev+bounces-291812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLt3JhDIFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:19:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 409F25D98C8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDFF8304FBD5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BC23AFB19;
	Tue, 26 May 2026 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Nny8ZetW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sXlcXNRx"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE03B0AE6
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812013; cv=none; b=kRHFteETLN+I6ED242ae1pfuiVu3j/bfK9V5Q5kagw61N0ABxDblYiNbXMmAHtlmcpfahryHH/Plwm3Q9uK4J1IX1Xc+wocOVvqayghsbezxjZH5zC2hYHsEieICgh0qFRi/sYynBU20uf+qPubcF4OQjg1Eska1i94h6aZ3qpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812013; c=relaxed/simple;
	bh=NfyjXcXPVZPF7w6Bcme5G+ASurpWWQTb1BYBNJKEMuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG4cD60lbWqf6Zn7SIrYpKrNXYMqg8t7gQhBUXej9QgWHSXXbn6SREiL7e4XnnveE2/gCrSdozgdHE7TGPPvlpUkPVcyJAFP2sn5ddnBWBH2kVKcfYUtPeYxhyhae1l8ZWOVok/+yCRjONHLYjAvGWsZO6CZbx94I5XGVeSyNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Nny8ZetW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sXlcXNRx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C3CC71D0007A;
	Tue, 26 May 2026 12:13:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 12:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779812010; x=
	1779898410; bh=q45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=N
	ny8ZetW0q8+C3PwXkDA7xyAezpMVCG4jcqX3FeJQDKdW/gI5sOI9TQ0cYFaJ55ib
	O4HkjpBIoOYeXD0jaL7zH1R4LRf0ueK9wB67Lm9VMsCiUSQYSvV1LcXJmFPzE/qK
	OCZRyuAwThnS0jH4mCTLJbWtc3fhjbTMxCFjjtcMRsklxb+xjjb5x8O7JTDFiBI4
	f5ntV+j62TvVW8CY1J9HJczMV+CVsGnRuyAnAvQw3eCtnQhMOS4Q/3velHEeojcu
	lvcolhhbevj6SWVQmiuvZoxUh3pm9eEwaOUYXQXOpAAdYj5WDm3u4ZScSkM5+YDl
	+XMZoOf0fnzHNDSt/anxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779812010; x=1779898410; bh=q
	45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=sXlcXNRxVcEsIbX7R
	gAJ9AkGnhRN0FPOFIcjreOK54+OrF4ePqRUE/Agz7C9RFCfozjXZxI1FFWldeWiz
	kmrwWubEZjFIRvDEjfBPHs1aeLSaSpUrJJ1DFWQ7Kwuqj5AJOVD1okYtdRB0uQd+
	TWuAm/LS0QpnVeHoz89WoURljqQy35lkruVyiIa+XX344FPEhloW/gQkoLWfZF1e
	Zkc4AVf1xbWkMO6cns8iuWsiRauavxLB23EB49oIJsFcHbSeJj5Kx6YSSUDNKb0w
	G8SB2S9DqWPnFoh+IJB3bdJ7X+/aPDwWDxwQYEGtZQqIq7SN/U+Ld1U1xFqJcy8/
	v6oqQ==
X-ME-Sender: <xms:qsYVaiBZgjb57T7kqBjQiVYlPpu6jhM4Xk8sy8c9t2BVCABY6yQQ4Q>
    <xme:qsYVarDwmBqvQsHUU8e2V0dtFesHFpNtOZSGOOiKjFyAgZTidHdqrNLXrNRo2oL4V
    5FlTuAJrYZ4JXElE6uoticVO6qX4hVtaPiVlzhGjV0BAvhn1FQRmklD>
X-ME-Received: <xmr:qsYVasa2mLP5vWUoPJ_STLLNiH35a6A9vIwhdxsfoqSAi2c993VpNpAB0IIjHQIijO9jXutcE6O9M_tryYQKYaM63xFVt2xmBFqBag>
X-ME-Proxy-Cause: dmFkZTEg18DMLZAaEMwP5JeibyA8v4kSMbIfiFKsShGMeCC+mYq3Xj6D+aHHJRnfsMz3qO
    cuKd7ZotewIRqer1FcGDf8Nxg66ZDwyNdlSyy3fZSfMhELsXHQVakcA5JBFAQURXYlxzg8
    YRT4E2MdZK7OXNog9amFv8OWuKVoTJaGTpRl8CPU4Y3WiTyVTlnAVMZD6vH9ezm4AStojn
    hlvIFrNTGeh0xRdH3x+9x6t38vTiX3Q5nQ1u8nQS49ozcdEUYVRyPyHxHUcj7Oz8Lf10E5
    jgP6FMrvVig84YFcKNwhns2dMsP4LQUF5aC1tdX64QPu+ysHuc1h3JC+FKoqtdr7eG3zNZ
    R6rBLlhvtBE6fFl4fK341ZVXmQF5TGeCgRQeZ5uGhfkRkVKQY/dfYG/dN68N9KXF8QJOxd
    /O1Rk0fHDO55Wch4cib0tlHH2mBw4bXBCVLXAduKhb8MQL0IHbonj1Snegu6uPh/mDmfia
    Ep373CB4C7lIXq/RgaczTjZWYXSSEiMgC4RAKijL57Kk9AicSn1SLnC2rbPH6tiqYIwCSg
    vTcgeCv10oS/bx/1zaQ3K3Zjg6djijGgg29zR7uZHMswhCH8L66fnYRXdOx98PVkM04Smh
    X0VuGHgFJkw/YhVhMpoTRnqgGHFzXjegjCOIE1zlXGSXg97m1eQ/oA/sriCQ
X-ME-Proxy: <xmx:qsYVagwCKrBinIhOk_F2YfvLu0UrJFnn6u1lnMt-j3b9XahaKt23bA>
    <xmx:qsYVavfkyNrzZRsxG_u2WT0RMGd_Lgbid5fa0TW3ZngivMau5WPKOg>
    <xmx:qsYVamLlKyeUkas-Wy0ttW_djGAZ9v5wTL9EVzH13yBMlIlr2ILTmQ>
    <xmx:qsYVao28y25MeHa1Kodb7S1rwDlPIDyTovaSpzytms6fcgiJdgkhmg>
    <xmx:qsYVakKfSg6rxZxJ6uIh60I2OWpN7jEXM0qDheqkMRHdDD7rtNMip0RX>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:30 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v5 08/11] udp: Set length in UDP header to 0 for big GSO packets
Date: Tue, 26 May 2026 18:11:57 +0200
Message-ID: <20260526161200.1135899-9-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526161200.1135899-1-alice.kernel@fastmail.im>
References: <20260526161200.1135899-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: 409F25D98C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

skb->len may be bigger than 65535 in UDP-based tunnels that have BIG TCP
enabled. If GSO aggregates packets that large, set the length in the UDP
header to 0, so that tcpdump can print such packets properly (treating
them as RFC 2675 jumbograms). Later in the pipeline, __udp_gso_segment
will set uh->len to the size of individual packets.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_tunnel_core.c | 2 +-
 net/ipv6/ip6_udp_tunnel.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 0fccb38f074d..a128fe85620d 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -178,7 +178,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	uh->dest = dst_port;
 	uh->source = src_port;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index dcff7fb16ff6..32525a051a6f 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	uh->dest = dst_port;
 	uh->source = src_port;
 
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	skb_dst_set(skb, dst);
 
-- 
2.54.0


