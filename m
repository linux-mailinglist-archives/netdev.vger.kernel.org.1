Return-Path: <netdev+bounces-294117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JNwONamHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:48:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAF62BD89
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EC9030E1258
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170D63D170B;
	Tue,  2 Jun 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="aUzo2b8i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpvTU97s"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9275E3CAE66
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393257; cv=none; b=MsklADxmKKH5I0Ls9jL45d9u+YIeQYVaZtMC6QUPtWuMwnZ9i+2vOazJ/9xuUXKdmrB8q+QD23nPpif68nfQ6xRYHNIhudm54ksAO2k82hdmkDyBgyl1uSN6qPRv2+OTy60jDjKRK6obvFpF7vR2cMgRO8zvSKNDAVevcp+b13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393257; c=relaxed/simple;
	bh=I09xySj6emQ1Yb0sm+w8DnYu7oo1mBsuc6nTRmmw8WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHlwPebFQwou2joVfzuzBk4nouPQVxHDkff3kLYuHU9qBq7VC347oh0QyCKZjr3hbnk1rvJ8EBC0F/815YdJXextBA0yeWI++vQJYrjbthi20b+lVScwi90Ccnly4qWRoKCt8ENa3hsuLzBRpULewK9C/TyIqjwtts0fwuPKiK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=aUzo2b8i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpvTU97s; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9104A1D00114;
	Tue,  2 Jun 2026 05:40:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 05:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780393254; x=
	1780479654; bh=hzCHAaOZxR0iDxeItShWKugLTiJ5MMjjnK/wn+1/ytM=; b=a
	Uzo2b8i3aPH/riKloD2Tw260IvA/PWUweF4QinZkwkwoIgDQZfT8LgtZyu8xQ4ce
	OJmioXlLuI3wSHAnD0ivptQ/FOlJrKS84HCiKsRMaVFMXNZWKPVPeG5QFmnupYaq
	i8Y4SoNHgPiXNmkC3dkH1Whog748qf7ZpjaJQqYT7FRlmduwgnYLqkmEeR59fqfw
	LUGJevhlIdw8hCeJR2/C9f9NTZTsYK/t6X5jvnXe9ZdWD0CIrZO6O9sx8OERRI/l
	IzniABGEaU0osVYW+sPyMSvbvGrWmFe6B/pFncRcOrvCitUwwq508CwUDdygZWk/
	q+YxTEiHgI761Wytk1h1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780393254; x=1780479654; bh=h
	zCHAaOZxR0iDxeItShWKugLTiJ5MMjjnK/wn+1/ytM=; b=SpvTU97sw1txWM///
	JhEtPeA7lvLM6uugv1GfmDqcPQmJ+FOcv5Xy2iuIJbYsyYtVF1ZiHlLMczSjPL46
	larBiyu1gG99xekpdwSxZipPeDD+Wau4ftHAzeZX250TZ8DiGrEYcktO2C7ok1RE
	t/If9rgn4M5b5r8lw7Iq5BKZF91TCme+evmJnPaKVJq9feZ90DzSelMTWUQfqz7Z
	GuJkF5CqDFiJfVpgMWuc6owLef7ZT6vXsUqx3C9V71ju2xk5y3OW3jHxRPU8YQoZ
	gVBLnW7gxlgF8mpm9OPaCWzAxEXS64XbDuA7SKCU3FZPPGOG1JvsJkRjYIeB8jzl
	6ei6w==
X-ME-Sender: <xms:JqUeavJQKCVZVGWuGiKBVshSJzXig3Ls3a_Uia9YH80pMzHCks6Uww>
    <xme:JqUeahohgmWuCxBzMzIyIydu3bgI8q-HBrr5v12igIgAalK1ucTNRb2zGU4R4Ee1u
    UtCIYGmRc0ioiRCO9SwYvTorJMYAbErQL7gx_RPWC2LRFpynehCR1o>
X-ME-Received: <xmr:JqUeauiPGagcMqdoHd50ZpLCJcnCIYHf4VltHACXteMn_jy5TtyqQAXqh9Bdwyvqbe74sQ1VqUaKnaO06-c>
X-ME-Proxy-Cause: dmFkZTFJUcnAIarPmRWdE+FMXHoN3k8Ela8FpOvuXsrzu+zD1tYguEESDDgt0sXk3NiHYP
    Fzpf7CYDI4dKJcjZSlkykh05J1uhIxGafmHRb42brGy/vMA9YFz/Wdi2R6oaZdPBrLyAIz
    lVupEGyAF96oodOYgXH/JqnPAU0hDK7uwX0ja8ODIDvHoVG7o9L+aan32BwASgXTsu4Jab
    kJA3ncqtwHqbK+DWNT5Ez9t1EHXYFbPycxq61cJpTLeKBMWmQv8x4UIrg1cU3QhRM07Q24
    wFI4Dr0RogINIHhau8/enuVZtLjXLcwMXFgisT1/Mk4oj38K7Kgmw0/W7ycyhyra0anfl9
    XrZ3r9nR9AcU4xyiK08MByHTMkSViDvLWgAGPiV1DldgdYNIw3DWc5h82SdFIQ8qi9M28V
    PN2qwkvGj+TXODNzvmJzn/NVEq2CjOH0kqn6FHeZZJE9z3a6icMMhUGl15nvSsXaODK8EH
    n/elPfLGVPkcheDKCX9maJVXa1kroi2f/K18Hq0yK0ROX0cJef9PKfCAbYqt4MZLOAYLL1
    N5x/P1NtZMUy30qeMwpV0DtAcNHffnyF3L0XJzUEuxfSmx45omrOhIBi9G00WtuXjllKyW
    e69m8aRXr7npaJhuckNDJZRvR3+OwNkzhO/zHqX+x8xhphX4bCQU82cLrwXA
X-ME-Proxy: <xmx:JqUeaoYBczV2N1gPgMe3gObvC0b9EPQmqtvf_h3Gul4xiQoCwjE45w>
    <xmx:JqUeaulH3YAMJhYnJ-ae5QEpqrTTHnI6_SB2u42kPmfCyYDhQIocng>
    <xmx:JqUeamxy10HNWBXjHV4I_jFlWjYO1YUUDNceT-kYifhG5As6G4eY4w>
    <xmx:JqUeas_FxZu8MSgHU8VBFVaQQrCFTERbae7RgJnceNbfAmIsCxL1Sw>
    <xmx:JqUeauaR3zOVpgIGzqdRrqXQVZQ1ghnqrKW8fg3-3di5X4ogOrhbOAV0>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:40:53 -0400 (EDT)
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
Subject: [PATCH net-next v6 05/11] udp: Support gro_ipv4_max_size > 65536
Date: Tue,  2 Jun 2026 11:39:25 +0200
Message-ID: <20260602093931.516281-6-alice.kernel@fastmail.im>
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
X-Rspamd-Queue-Id: 23BAF62BD89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294117-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Currently, gro_max_size and gro_ipv4_max_size can be set to values
bigger than 65536, and GRO will happily aggregate UDP to the configured
size (for example, with TCP traffic in VXLAN tunnels). However,
udp_gro_complete uses the 16-bit length field in the UDP header to store
the length of the aggregated packet. It leads to the packet truncation
later in udp_rcv.

Fix this by storing 0 to the UDP length field and by restoring the real
length from skb->len in udp_rcv.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c         | 5 ++++-
 net/ipv4/udp_offload.c | 4 ++--
 net/ipv6/udp_offload.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3e92575f1d55..856c23b9d6dd 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2583,8 +2583,8 @@ int udp_rcv(struct sk_buff *skb)
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(skb->dev);
 	struct sock *sk = NULL;
-	unsigned short ulen;
 	__be32 saddr, daddr;
+	unsigned int ulen;
 	struct udphdr *uh;
 	bool refcounted;
 	int drop_reason;
@@ -2605,6 +2605,9 @@ int udp_rcv(struct sk_buff *skb)
 	if (ulen > skb->len)
 		goto short_packet;
 
+	if (!ulen)
+		ulen = skb->len;
+
 	if (ulen < sizeof(*uh))
 		goto short_packet;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 96987b1c05cd..f7da760f046f 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -919,7 +919,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 	struct sock *sk;
 	int err;
 
-	udp_set_len_short(uh, newlen);
+	udp_set_len(uh, newlen);
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
@@ -956,7 +956,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index c92cf5ee3e6a..7370bcb80332 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -171,7 +171,7 @@ int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
-- 
2.54.0


