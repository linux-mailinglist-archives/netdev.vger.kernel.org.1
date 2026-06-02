Return-Path: <netdev+bounces-294120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLYVE1KmHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:45:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ECA62BCD8
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0FF43022250
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F973D1A81;
	Tue,  2 Jun 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="emoxUgaK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsYFfrlz"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB093CAE66
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393267; cv=none; b=GLwI/mBXD5O5KBbF6U4Jvgnf2dHKhIW1kHE8nmrDoa8n0qvNwbJfiZqAZwDq6RuzPbSu0WcF4ZVoG1pXodsAp7vo69081F8W3cG3UlPlsY759TA2SWFQPWyHf/akcavn7J5oPRygb2xBfq/NH9rkLuQnH55RJn33Yzazd002t2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393267; c=relaxed/simple;
	bh=NfyjXcXPVZPF7w6Bcme5G+ASurpWWQTb1BYBNJKEMuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFFd5HpQT1YzTMhfJ1fA5Pg9mWK9zuXOcpWkCgHsguUoEPNK0iMoNGKT0vrVdud6wRO3XmU9L3Y5QmnqDauVroulIb6DxsOq7UiVVMdMpSCAjAvqCCDuUOJslTnoQc7EPeXeOd+zc5/bBB4eYsRYYdHs1EnJ+XrPyz5lij8qKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=emoxUgaK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsYFfrlz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D8C381D0011E;
	Tue,  2 Jun 2026 05:41:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 05:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780393264; x=
	1780479664; bh=q45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=e
	moxUgaKdY7aDvlYEZGkXRW8zqmNMK57fD6rj/RDkmFredaVpKpMwTcgeaGAOq2uR
	WEgGCrAQTaSlRGaHrM4RoB524Tnud7lMLn8GESNqxBasfKwaKW6pWLljhXUN7LCf
	u6IyoUqT/+D9wHhT5v/tew5xfsRyq5vw4ht2YJ31r7IbhWutqSrucqt8uNPCOOyM
	kjfxGtvYTa7kfRr39rFkQUX2gAj8feopkPX2TPqn5ZjFXuNchP4TwDERkFCiit0K
	fHbe/oTW8FMQIEwqXUVb37zz+lHw3kWgRvM6NZ7nV/6le0dy5CD9DyJVEIIpO5ns
	hmTEquWKLpppHPPvBQFnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780393264; x=1780479664; bh=q
	45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=AsYFfrlzBF6oQRfpR
	T2NUqhUyVs7Q9Vmw4tEXgmmJM1uULVlaR6y/OLyjIu4MCyaS5NTNlwURsPEmnS7U
	TRKAbbS7yqDHsmFNWHL7g2JbSXWj1borOa9Q7hCl4GaLc/VTa50mGHTrpCAhy3oh
	59IQQM92yLEsuxkNKS7DbNgwFNSDRGAjoz8ufxIQZDhi4TK2F0yVsFsAHZGYwAC4
	89FtxKzYsyRNvVbiBNnQ2G/+D+/2mok6ECtagdEYCTdMoKHRQqNfC6qxeSeKhbqp
	jTaZVySwhAvoOxU4hPiAmp72fFg6LSES/AUhsVsinWgGIfTct/gjap5scbNOFs28
	Tz1ww==
X-ME-Sender: <xms:MKUeasV6cItAwootMQvGT7HUfVuY5xyP7oNO6vszGtJcuVj3_HE3zg>
    <xme:MKUeavGBU1Atu3-d9yoP4uXlWKtElxdZ6wJ6mtYmFSsFu8JoR2fVUHR0wngQNpAzG
    _4hu1GmsEUSFEIlIARSvkCY394AiOzbQxujQYrG7rLDXybD6cmcrS0i>
X-ME-Received: <xmr:MKUeanP1dHhPsi_AjsZtVKdkb-ac-Hk2MMisMJC47CLstjlAL5v3_Nq4l5JgTJwfruVvO4momByom8hhY7U>
X-ME-Proxy-Cause: dmFkZTEX9sA/iW8hUznfeUkvdsOwTMHpjKI82kyzHYlXBG+BytP3sMKILpZuMf11wLu+1Q
    7GBTq7ZFvBHQlZMiiOLVzr3vpW2UtF3gpGYLQFOC17gXSNzT0JBw5XfAUT4laexFzibnVj
    3Q3gThGiERdCs8nKtsLAUdPi/k917bBI8eUl738rJI3hDfeSe9T4wDKAU9l1kgHoMM0aPs
    XeFQ6KS/FoiKZ8w3egOHBMy3eEEF3EcTah5/dyxjAipRRftqgl4016nWrzXKet9byWxLeY
    JGGd1suInFGbDKb99oC9Bopt2U15TpIcwLgIEYRW1yVmJNLCdu6w8yYALs6i6NCwzo43Q4
    r7Pfmocb8UaihF5y2ZssR+gUDJ53Q5vskTxLFjz/tYyLQVRKKdUY+OTGHpIQUJ+w8FmU+u
    EuMIpJ33FTVK0QFV8h29977bY0aSzWtr/lfGEyQkqj99UtdiellGdQ5vDx+SA0mSLXqrDi
    jb0dRTEDYvlu7DipYTlRbXEbm30882VdQiOmkjuQcZQZy5jKpIfAV+v+zTFGsqKw/DbgNm
    3F+pzBRyr98WoY+eNJNWvSGGZtbcbU0HtzCJQagxHYOs68EdQ/7vHc1NtQhY0dweRezI7P
    eTi9tvlqk2rHqc5acZ85Z9pR03KpbsawgvUDZdtUMS6CrzVeLZbnsvk7/vYg
X-ME-Proxy: <xmx:MKUearUfvC-fSG_KSjjHrEu2aok8IyMCBbsNHEpXBunJs3pn0z3jDw>
    <xmx:MKUeauxbcVjk4KHN5ElsfK7IDeqTyXKEftoSzmHdHct7lJXfzd7sfA>
    <xmx:MKUearOpoiJdaKbDQi9fJgchFcRyUD88AjOkFubVorBe-9AgduW-VQ>
    <xmx:MKUeagoZam3-QKyDyWuvkGf3jb83grnd5T1MYRB6XRef2rOh-bWpPA>
    <xmx:MKUeape3ehSe7CB-NmDrlLMt8SUySNBCqoj-IfMjn9uzy7NulkUxNdA_>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:41:03 -0400 (EDT)
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
Subject: [PATCH net-next v6 08/11] udp: Set length in UDP header to 0 for big GSO packets
Date: Tue,  2 Jun 2026 11:39:28 +0200
Message-ID: <20260602093931.516281-9-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093931.516281-1-alice.kernel@fastmail.im>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62ECA62BCD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294120-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,messagingengine.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

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


