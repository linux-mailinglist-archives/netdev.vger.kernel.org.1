Return-Path: <netdev+bounces-306573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EQ1XHyv3UGqg9AIAu9opvQ
	(envelope-from <netdev+bounces-306573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:44:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA5673B5F3
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:44:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="m /6IT4L";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=lDhUqQ9z;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306573-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306573-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFE9C300A489
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0DF420E7D;
	Fri, 10 Jul 2026 13:43:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA0409289
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691021; cv=none; b=r7vrP91mu9MvklQW3JHrAmtNvjQDt+xpDJI7jO0xvNovbRWBkUoqf1NK+4KaUXXVS0smJOKJy4uyL+h7236aTFErz0/3j7hniw9jUip1WpQuVPYOB4/KLQTfGNr+dYdC//yhpkTRan5RCVDZyAzSmVViKi9VvRfrTxfE4IGuHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691021; c=relaxed/simple;
	bh=NfyjXcXPVZPF7w6Bcme5G+ASurpWWQTb1BYBNJKEMuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU0ADwb/njhx07Ftlivd+4WmH41ANLAEHx6i5TccD20rqzDB4WdZV+mwZYYiZxEz2j/DjlL5gMAWHl3SERV0tMqOPZwdJtmrLgxVkSK6rKIcgVxkTO4bYy/ekItxJPLNxm0vKehcg/XKcWhGjyhf79yCIIi+Zowpn1qNX6eLf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=m/6IT4Lp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDhUqQ9z; arc=none smtp.client-ip=103.168.172.153
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9E881400112;
	Fri, 10 Jul 2026 09:43:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 10 Jul 2026 09:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783691019; x=
	1783777419; bh=q45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=m
	/6IT4LpSW+FjjiB0YtK9Sz3BEurUOyYQCd71M0bQ3BCfpOem8ztr/79xff1VDZTz
	rkCLoXcdufYQtA5XeXMjyaCKIdfrhW/pfPbq8V5bPaLmzqjHn82dsuCorv4fnJED
	KVnjjQ1k0Kyw7FttJbDIQeeeT3AsgCHmA4Ldsd8ilJTGBx0ssjGSqvhm5H3aFdck
	c01v4cZt8hnxRt2eFT7Mt5NXSAKAY6LDKzny9v2iM7TyzzO8l7G9smjXeZHbvdUL
	SNEWxt/7aUyjEF1HnUagvWPursRlDTLY2cp569ojoV4xxevIXLKO/K1XP+GImsYM
	ustzp1aeT+EJXlgx8PDMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783691019; x=1783777419; bh=q
	45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=lDhUqQ9z8XSIxlqAG
	M2JryyHxMRi94gtL0c6XoByGXmtxIcmks4DkGrEIMQyaaBw37XIphnZmnEYZfzLU
	OwGSizIvovJxB2J3HZUsw53e4/jyjqDlTolVQQ4QxjrugPnuuEOWjGiXwfm2/A/D
	rWltUUfAKhSZt/SvlOzy0JKwaaVA8RehENORXvEWE1M2mEKSbVvGDywBO6BfMhh3
	y2hCKqDaJdPOeqmtUc7PRMPst4+BKWZIjSgNkxYErjKtxCdE3Q7exv+laDDjDbO/
	eWbFyUze0SQZqw3TjnSfb3HiE8b9Ww3jlup5TxNk6b/a3BybeV/jZZmlKG3oe25K
	Fgqdw==
X-ME-Sender: <xms:C_dQamnNHzmzA7yz7sgY4Y_CF57wvwCyBgDgp8qXK0YwQJkYqOohcQ>
    <xme:C_dQasUJaS9OH8qmAAB_TkqYGeTWrSAs6pXj7WpUL1p_NOryc1yKaG_Mv9unGV4_x
    5LPi44T1sF-bfVs9ex0qerBq_kXEL8dkN7_tqsG5TMlV2EALBiB3w>
X-ME-Received: <xmr:C_dQardCGNyZVINuP7B14U_DNbm3UzdFbvbc47SKLY3tC8RnuTZKbfj9zOtpgDcVY13pQuapRVq4uiAhpQtwggnT312QbkxQpV6e2A>
X-ME-Proxy-Cause: dmFkZTFfblbY/WlgwK1qxnfU7ZHHlBm//FxjeJis+PQfxpptIXrVsPtyY0UicD26PdrBRB
    EUdfTSpveIWm4ngUv4GlPbHaZirXANAX1B6Tr0GvWzchwZGvUsBR4WMASm+Hbw7QTrouQP
    J0elDao3/xCfNBnMnCoZcwFzy0JswZnDGyDCVdN5OT5sZGkgVqNz0ku9aEQMKmj3PSN7NU
    let8nXHm35fjgZMqwWjK0b3y3dtHcX9Fj0DaZxifnDqAMrDLBKbyzqUeJWMEaDXSVXL6Pz
    cUsSOzgMVDW+pill990Bs1qumLR+IQQRFOD8NutpA0kUDo4uqKDe7dnMeT1ntY+pzL3jo3
    rJm2Ok0SBxpDOPKAXi2QkQExc468cFXyxP1s96c0eKny8IWqhJhJcbOyBL/T13J6ze3ZTq
    6xSc45o9V++5RqT7WHQkoCMT0QyaNSZZ+OKiF50yD0Sr3imNHQB6nJ/WI+BV6zdTh/pb6N
    hjNj6oegQkQj9Pnu46YS/7JTv25YAKNR7uzFc1zqLGOHE9egAifOOiNwstXdciYW63Cjw/
    Z7+egNVxogfUdJgk61ly6pbmTdCv0ghndtg+7w1PGfw75j/n3uVLgnnP5GPkbfvbMERbfu
    hEjBv+cgNhWRo4oNFoNy67yjpufTdYdISaW/w/8ARLB6zLj7CTr9C2Fw5PgA
X-ME-Proxy: <xmx:C_dQaqkdX4ZSW0hMnhwZoZjv5ATsz5Qp2Lu47bOAz3ndh0XIjbiaKw>
    <xmx:C_dQatC08GDr7JQp4E8-0MWHg8iLg1hTTbv1BonlJ9OCvVvLDElGFg>
    <xmx:C_dQasda6NS_ttl0MFTM8vfl0FXD-kiXX9bpAqcWOfkHeb2JdPSE6w>
    <xmx:C_dQao52nojCARHzc7mAHGUPGJikhIvd_1XU5fbZV9muRuMwZbb-bw>
    <xmx:C_dQahzvWVSejERZlP_cnab_L87VWYYpk96wrGVx0zExg7XnJSmxWQON>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 09:43:38 -0400 (EDT)
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
Subject: [PATCH net-next v9 6/9] udp: Set length in UDP header to 0 for big GSO packets
Date: Fri, 10 Jul 2026 16:42:39 +0300
Message-ID: <20260710134242.216538-7-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306573-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DA5673B5F3

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


