Return-Path: <netdev+bounces-291809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCZyHM7HFWpNbQcAu9opvQ
	(envelope-from <netdev+bounces-291809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:18:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 144575D9865
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC1A93035E5C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE68D3AF66D;
	Tue, 26 May 2026 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="I3lvWYtH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vPg54cPK"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697D3AF643
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812004; cv=none; b=gMLBsGZOXDw42abLrHc8u8FsBtr9nGHjQ6IeZLN55dO5UI1d9ynAnZ3cPB639tv500TGky3oI0KpRxGhUZKj4yNDxsnxMOERDzKCv+dOiqL6a/hI0zjYcNJ53w59+XjmurbVgOMeLLws6o+dN09WmdgBVuDIhq0471uDvTU0fLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812004; c=relaxed/simple;
	bh=cDeh/FOUiN9z6ShTWZ7FgOgZVJ3biDffu23O0V2hJn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsiMTaX7ZFzCzZGZlBC0gdDEjxerq15YnLihGngPfHBilGs2mBTQGYE3G+qJxSdKovuPuxJPWy0+yFfZUHSjGCFFsp0VwD2Qc9SppATfNPu+nYe9LwC6Qgefh/CLlRTE9iOaVIMfu7SplCjxgWCmpzdISTCZIrOwO94/nVlSSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=I3lvWYtH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vPg54cPK; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2B8907A00C4;
	Tue, 26 May 2026 12:13:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 12:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779812002; x=
	1779898402; bh=VJi5+bmpSBR5N5UZsjBOFPNCZBngGPpTks/1KIRtgms=; b=I
	3lvWYtHqwr7zQuUwxRr4TSVtZ/3kDU2lurkEF47pZMWKs6dkMVmjGOJWVaUQG2Bj
	yw5utxjvzlxbcUKBbb6xgQ4lnOjYKc5EdDB2bMj61j7esnV/YKcvTkX4a7JSPk/Z
	SCFdIZQbNmhZochP5GIY4JaKJkI9dFakE2s0242NU8VX/vDWSvtqN4RHQ/fyfFRt
	//qFi4GRETQFbsN62UOVLn6z3oAphwXRVEQWzbwvdowGNUvmYvRHbGtmx5bSHFVN
	BMgdBOT2rbBYUVYmFHblDc5buzcnCRIuyxeo3R1/SJ+BDFccZYm9G+ClIWl4+emJ
	U/ZGs/pociuWam2020o6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779812002; x=1779898402; bh=V
	Ji5+bmpSBR5N5UZsjBOFPNCZBngGPpTks/1KIRtgms=; b=vPg54cPKcusu96pHv
	4FwaGWFtNLssMDjrI3QLZaCV3psqCAyadY86tSL/WVI2vF3Rs3xr23CCgHcwBmRs
	fsCs/vipkgDJZD1R3CM6j1BNtrLzEAlDZaHWMPheaQ7UNogvcd6I2EDgyZsn78A2
	EdHuzGQBOHRDRiN98jGXeJr3JKK62UD4PeoeZYcsQbivWEsPxhZVvIpdlfj/u4bP
	n1yib4/WRXWAjm6SddIHSW3po6xrWbDzFjgQH8Zs4QxBdNrVEY4UHGTc1154cMuK
	2wXu5tQDtkkKMLRZ7Xm5BvO+EDJfpKL/HA9XYa9XTzAGK/og1bWG4zDdhlqtpbqd
	EitDw==
X-ME-Sender: <xms:ocYVas9bhhhG72TcRATLIyXCFR6zZNnPvfinvmwRbj055NktdqM0TQ>
    <xme:ocYVajNPCywFzfVzymKPCE_Phzrrdh43Dx1C-qILrO1aYoYj3BMIZAJUnyGxSYxFh
    Yp4ZTmtiW_SsA9ZJusEt3wHut91RAZtyi_EX12liH-HO3kgQeyfTxQ4>
X-ME-Received: <xmr:ocYVao2m-JxSCGuxWKBQwJh2SDpSpdypiO_gdVvikqnmNd9JwpdgUp_MEVSlHvlM4DKUNF2zjfSWcNOkaP5EaPuVJwrUXhHri3ggwA>
X-ME-Proxy-Cause: dmFkZTFOcRRkO28xX+ZZv3D4x0vEz/+PehnzPRu8wbiezew1BUjq2LWEQ21wcreaw/apFw
    JiA35vhyA/thOqkxbTpvAsaDDQhE7+TK6YzA5Imz0j0mjVj4nMpkuOcNl8rfOo+T+PRk29
    89RNKcg3kKnjCls6kE0nQwjIVbry4l0C18uKaLMUOPQAslSVlRgA724iSJ+vKNP51hdwsF
    21LKpuW57iSv+o792n5cxwl/K98cqB8Em8Cz0T0FD3wH8rzdyw8vVkXheGkRWZtKXX3UFc
    7inAXrKjlwH986ANP+MXRhmd7xT3uRVGOCp//1jXieGe506Wo5Z1ab6gjvRtpmWjtWLsVu
    zdmuUJd6X/bbHAVuasEBfJLJfUkTrxe7YRNVLWWrv2ewB0meWtN1T2vwKsQgIRrtKdh0rY
    IsuTSSQwhpI2KY8SOSHrArKfQh0JuEWihjzAqZPGKZoPajoKWrwwfSsc4jGFKiJRsFNHEW
    S6neXQSRZYV5UFai7AknYBnhJ8adRXCJA73bCOJrplegGv4DvWaBQtSuLs6Fw5J8PTRpby
    2Wo/9/v0TGX/oesJkn9kn7znuuNTkKM7ivrC7brzne/kf6NYN3aicFWSIko+pq0wf6kX6X
    BO6H6rbUiIhWoxEwwu/f+Tfkt4G+WPFB/ptS5hZKQLLvXpu8g8XFzQN9NPLg
X-ME-Proxy: <xmx:ocYVasfj49xn4iaPEfce3qACk4uAio509Ui7XoUa5pQ01b4_rb_GYQ>
    <xmx:ocYVapYDIClk7ksRT_g4ksOkbkMCdrDI7gXU8kAIOcL7-7NbrA2LAQ>
    <xmx:ocYVahXJWuSj_-Uab_wileDVMunDFk69rGeznU6qigopyllRpb-eyg>
    <xmx:ocYVasSBWT-087XYgJnDFTbvZDZyykxsp23ZxIixclfPouCczBB4rg>
    <xmx:osYVagFqYRROaq7wT5hAKtByCkwrXWxFA-elwQgetqF60hGni-BZegcQ>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:21 -0400 (EDT)
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
Subject: [PATCH net-next v5 05/11] udp: Support gro_ipv4_max_size > 65536
Date: Tue, 26 May 2026 18:11:54 +0200
Message-ID: <20260526161200.1135899-6-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291809-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fastmail.im:mid,fastmail.im:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: 144575D9865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

Currently, gro_max_size and gro_ipv4_max_size can be set to values
bigger than 65536, and GRO will happily aggregate UDP to the configured
size (for example, with TCP traffic in VXLAN tunnels). However,
udp_gro_complete uses the 16-bit length field in the UDP header to store
the length of the aggregated packet. It leads to the packet truncation
later in __udp4_lib_rcv.

Fix this by storing 0 to the UDP length field and by restoring the real
length from skb->len in __udp4_lib_rcv.

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


