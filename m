Return-Path: <netdev+bounces-298319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m9NCOQYNK2qF1wMAu9opvQ
	(envelope-from <netdev+bounces-298319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF1674C0F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b="e sktzsd";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=Q6EPtZzS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298319-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298319-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA1023008620
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB7029D265;
	Thu, 11 Jun 2026 19:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640EE29A309
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:31:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206269; cv=none; b=je7Iw1EgW4bfl3q5UnRmPDnXcPRwq1Z8fVZ18osULnmvW5AXwLXnd1TlLNvpJ08JKmDkKxH7uRIm1pQWIOnzAQMZlHMJUjFHaHHDgOYPzeQlXLegELYIZ/C7hF5rmO/v7DTlCxCeXk5FvbVpUBlTL/fvuYMSlmdDk3UbmXX1LiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206269; c=relaxed/simple;
	bh=NfyjXcXPVZPF7w6Bcme5G+ASurpWWQTb1BYBNJKEMuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGbcXlrhB5pcWI/MyDHa8FPMaMKCmK94j6OEtK+2Em1L6sF2/8Nx0pPSJOO8o4ApzGdumGliJcQ089kQdPcl0SjymHXZEuakpNfYO2/kZIylXlPVA6WriyM4FCeVBhvq2vFDF+sx6ruledFQPqbux/mPc4LXz+KyvH40yKXXrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=esktzsdj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q6EPtZzS; arc=none smtp.client-ip=202.12.124.147
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 441201D0017A;
	Thu, 11 Jun 2026 15:31:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 15:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206267; x=
	1781292667; bh=q45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=e
	sktzsdj/JIHzb046dhdYQp5Y+uyGKAEtnDQ4P+zQfeVXrzLpvqqq4xuPvIFpFRJE
	mq7BUcKKbvfXBHiDsjWVIazROWNq0wv6Njg8x99IjzWsgK5f7vyGLSmG+iGxmjST
	eCWWMrdLmFpnaC9EDwVTsI0DZQFX+IrdIeTaHjAIp6Xh2LLUcWY0zCYJP015J1bW
	QLGNEcaFBIsAwLxwr6CZw29Loc/sMbf394arDubXwV06nveG0c8auvR9wyelbV9F
	WTl8q7jLC+onAItmwPgN9HeC78s2FNS+sC4EhzCB2xGPYoEZhgIKrrK2bTLbaeav
	XW1y5+KcYbCYtfp+3KCHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206267; x=1781292667; bh=q
	45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=Q6EPtZzSSZSwCbQ1H
	+XxZv73NpN6jSTvkB6KOU3lHjJd7vQ/wYVe1TSO3qjDwdFxryTNFg4CvUFkLN0N/
	5SRFIbhfkvGtuPMb4r4uLGQG03JKCA9jipJ8dncrmq1BoMOy1DVVBkQzniUYEBBC
	+YJxHJ3H9tIU/+nIXadutOJCrjPOW3P2Avd16UEV8CW6dph5oud4kqXo+80h/cR8
	OrNWiOvbvZjxMfVoYtVqVquq3SG9WttMzgeiBO53yfMi7/ImeMO2t7GGTfk1ziUm
	RIleFn498S1mi2o/wl+adDJmAs5hjAEKwDxP6HHOmSfW+OZqdedwLDr/FW090/hi
	ZuECw==
X-ME-Sender: <xms:-gwrarbD3WB5AQV0OTxc4iSMBAinmd2xm1DvYb008g4RoD985UmCYw>
    <xme:-gwralT0BTKxuw_CmhFsfsm0aTqDgea2IZ7qxalGcgPMSSuBs0Xyw4kvf6-4AUv0V
    en-ZNUCB-tmOrgI-Wvytu0KiX3JoSnfoMapXTW-6cW5Eebq2fz3kCc>
X-ME-Received: <xmr:-gwraoLL4ox3xRAxUlD_DaEqDm20Czyf7hvnfr7tOmWAcUjlVz-4gTTe-UsKOybySneUbVp72be30g-6cXWn9Xg>
X-ME-Proxy-Cause: dmFkZTFfZbmRQfFl73aqa0rEAMUUOSnQviameGPSkHNGSu/bIjErCgBuhupqsVQEoC8oKz
    aOx2URfNI/mdltPZICHf4EfhTZXbe+cFZhYFefnCD1XgSHag3vzH9a3TvVqJCNgeOvoiR4
    1FYUYSyeKP0776ix4wGTI4K61oYPa8VGE+NHaitJz6DDKEGe2UcN/AtVhf4bWyHYcqxE1b
    u3BVMXGiMXz5kyQRIbt0govpUMDRiMNty5Cd6uwQuQzsO7xWAwssdPV/BjQJFRKWZQLW+a
    P03sFWUqIff10jyZuZPM6iG3+CexjT2xeHQ/f9So5wVTdBDqeJMyV06Y7sBcfJfOaGmCDw
    nxTFTyV77KQrSgQq7a/ywM3hv9L9jfP7adfBXCSmVDcufT0Tw3dIGX0SjXuqbDqh81v+ZC
    mkiz6Xk5VdOenMtvLcBRbOvZbILrGex+CrmXlVayLOymOW2CUis+LYFKaTBkSqL3K9ma8q
    DaMXPqx7xIPjGE9EsSYUEH/fxyh7UpB+geIU44bc8eqkSMpiYzTt0qj3rvVfeku5+sz8/X
    wmN1fzT965RGd/YD7Mha6EuL73ZR9teJUww/NOuxY2vPBRhWykReHaPWon3Rs8vkXJy2EJ
    te5icLkGbQmUEicD09DM3Y6unE2zugm6gFhzsjEMwHALFk+2SBMeKnsBPOwg
X-ME-Proxy: <xmx:-gwrajWwPuf8LOQUp3FXaN2GA7RLe9IrNXpWB1KyusSDnulaYuFwqA>
    <xmx:-gwrasgiFWtYWqMBXw9JO2a_1f7jL-nyqyZS3IJMlm9IFRdDto5NxA>
    <xmx:-gwravuETPT-9pnTmq8nBhemB4ml65QYP3cEUmzxV0G74RaRvD6Ccg>
    <xmx:-gwraszq87LwYTgl5fpBFp-t4ZVkfQ47wsHq0RoYIUCW4ntyEe2k6w>
    <xmx:-wwrasACTsDMoa1miychMmKf_o2Ei_Y2zCU9SEjVD9Qtum8YGHI38Dzb>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:31:05 -0400 (EDT)
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
Subject: [PATCH net-next v7 08/11] udp: Set length in UDP header to 0 for big GSO packets
Date: Thu, 11 Jun 2026 21:29:52 +0200
Message-ID: <20260611192955.604661-9-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298319-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,vger.kernel.org:from_smtp,isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,fastmail.im:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7BF1674C0F

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


