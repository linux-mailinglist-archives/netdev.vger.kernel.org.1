Return-Path: <netdev+bounces-294113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFLhDyKlHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:40:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CE062BB70
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C16230117BC
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7A03D1712;
	Tue,  2 Jun 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="BkSYPeUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Do1m/Ql/"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D33D1707
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393241; cv=none; b=Zdho5ObeT0uavZENGbsnLjoU0WyLbDq1HjW2B3lAx2kB5sQgmnPVLG0/m/N/jqZqi7NCK37GPIg0KhyAigf6otnJ2lHFN82Xeft3irxFlrquivocGCLhVEDkTLVkjTn47+6uFRu4ZBUk8RVegVS00rEBJdLUgE4kCz3mIR1klmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393241; c=relaxed/simple;
	bh=NmyU+LzzDIVulR+Wa58VSzqOQTcNA5ulDK0vhrFu6CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKvKJ7goKjLH0OPfMzR9y5uPs9iweX80c48wZ3y4hW6F4aInaLwP5rMmlXk5jfqRxD++nIxDym6xjGB3bKqZ6FjeZupcCSy7oNLN+iVjBurAW+lw31CL7CNsuQDfpuu5+bGxhoBDqhvnIi3yEeC5f1nBd0wVEyInbt+bSAAWm58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=BkSYPeUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Do1m/Ql/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A6037A0137;
	Tue,  2 Jun 2026 05:40:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 05:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780393238; x=
	1780479638; bh=C8+Mu4wSB6ALx3Xp69hOWTqTS8HOJYoIAdW81FNJXtk=; b=B
	kSYPeUkKpHIdySNesTQDa9yRbZJNYXF5GhQE8DoQh17zHsY1pPg7AIm4OZPodnEn
	YC0smwy7GQ4q65obzSEecnhj/k5Tgz0TSDMLOokdRsm5KWyHelCx3YcgpZBv1uCY
	WmvpVVfBFxUa1QxrN7J6yBV3dIauAbeTJ/gNBnmnulLgtHSN89BrPDa2aNnwq0KM
	rTCLReUfXwFAkngAtGt1N9pxXvp62LvnlpLqzye4Lkd4+fzzXy2Ad37XSqvNOeSM
	/6WJ/CKSsyoPscIYwnZxfTkBBbkZwVL3ry1nhyjnHaXKPFz51E6ctIntv0R4DOiz
	JU8fFEIPRsxyy5qicfirA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780393238; x=1780479638; bh=C
	8+Mu4wSB6ALx3Xp69hOWTqTS8HOJYoIAdW81FNJXtk=; b=Do1m/Ql/TDzyEH20Q
	qA130vLpkEtaYIvuIxk++SFAwF7Gtgf7Xq27MaVgNZ+bGfSgvvyDcUADOZrRVHBV
	KWu4zfvoI0RMb+v3wROfFgIUTDGlju7OjS9v3DmyS1keZpZdBrKhkWsXPz2IcBoY
	HNtl+8/TLNTU0g10Zqubccfwa3CnK7aESM5Gr5APVvjGaKXo2QytWQEeAv3uWNPi
	/5thHrCXwoWMESlDTTP8tHeDpE+g8NIuB/Hl76X3YEmtp0qTXt0SN7IsHqy3boHI
	CIS7Kgq7xH0/SiXvMugfHdcLZVdXqjVhv5ahUBS4ZWvlI0H4y4PUa1HzfNb8fazN
	C8ZMQ==
X-ME-Sender: <xms:FqUeakaL7T1kgueITbGBjfClssv7llL391MidbhU3jczm48l9M_o3w>
    <xme:FqUearv6To_LbWCpIGWH5Ab8Ay1BxfXzsm_KBJ0yK9abb8bIUObjl0P4tS-fxogGN
    a192zLAL7kV2nG--YUxN4pN5bf_kN3vFXr9eqh42C8kC8-AEQP3gyY>
X-ME-Received: <xmr:FqUeaglmPgIkId37dxoB9TARjDLwifOqPos_1RRvkxvIirUxEkuXS2mG2aZuyckVYDZEKOU1PGyIflPrMAw>
X-ME-Proxy-Cause: dmFkZTE9tBEANdqxv95NqhdHHdXhj1o4AkdIVzwb8jjM1HqleHqSgAphWGPVWdofWa5NaJ
    ER1+bdTKu4iuMySGow/dR0s0eFoVOC/6dTzun6tkdzaeOOWbtEG06zBndcZtwjRhyaEqpS
    LIdhK0NEaayYQ6YzxQmC4sX50yKzwArmaEuiPOivokZV1AkyAlAc9SSPgZ1GnEgo3o6dDk
    bEn0w3Mqi9k2vnkZorhnXwd9uFf0d2PQPwaZiDxl+oi2Y7rHQyMVhjEWYHKl6/Ux+ouroe
    m5aDk5b3HiFHY/885fmPi0ztz+42JdSIp35bNIg/uJarg5ZvUClTXutfFP+vZJrYnhYFX5
    aHfeA8xDEGHnL3852B82GsCmioilNYvUdwQzrtZYZBLy7+17zKKD0MUqivVLOOSpziuYg+
    1HXAfmqYnKS3B30o2C3i9o0HQnQ1GKL5OAVuxZNTSk8yFUfZk+Rf6O93yfQV/I8lO49wDz
    hmtRPMtTbqwhARRtsbDiHzAX6H1WULOCwf8vyW9RyfRwCunkT0Y1ZvzcNYSid7nfBZ0X08
    w+DaMJT2l1/YQG1k6PX2wiOFPG90OnXAHVONOnfQiqwfmIVnU9T78Fb4dYQseEjBO7g2Gi
    LL1uzR1/LJMy/6gzPEJBmuouHoa2X0z0AmlNG1dBxqaB7jglfqC15OtI4OAw
X-ME-Proxy: <xmx:FqUearxGziuEaFRknTu9KzzQ978R70eiD3s-AIh-Gcd0pTHTEltfTw>
    <xmx:FqUeakyikvqhGnDkGAF8J2r0sQuk21DVTgYTAVGh1zvVfthYSEOC4A>
    <xmx:FqUeai879RbyQZWtowQVwsZqTlcxrJhegxaT2NhFMIYGzNFdecVJpg>
    <xmx:FqUeas8fqndF-_aOACV3ly9MkeciNivX32r2xFi05z-SeB5zEkhOFQ>
    <xmx:FqUeamsNxLcBJRr29EgtOvfgUfKblZGCzQbJkpfMXXTFJgAaxYGFBdG3>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:40:37 -0400 (EDT)
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
	Alice Mikityanska <alice@isovalent.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next v6 01/11] net/sched: act_csum: don't mangle UDP tunnel GSO packets
Date: Tue,  2 Jun 2026 11:39:21 +0200
Message-ID: <20260602093931.516281-2-alice.kernel@fastmail.im>
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
X-Rspamd-Queue-Id: D4CE062BB70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294113-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com,redhat.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,isovalent.com:email,messagingengine.com:dkim]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Similar to commit add641e7dee3 ("sched: act_csum: don't mangle TCP and
UDP GSO packets"), UDP tunnel GSO packets going through act_csum
shouldn't have their checksum calculated at this point, because it will
be done after segmentation. Setting the checksum in act_csum modifies
skb->ip_summed and prevents inner IP csum offload from kicking in,
resulting in a packet with a bad checksum.

Add UDP tunnel GSO packets to the exceptions, and also add UDP GSO
(SKB_GSO_UDP_L4), as the same logic as in the commit mentioned above
applies to UDP GSO too.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/sched/act_csum.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index a9e4635d899e..078d3a27130b 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -259,7 +259,9 @@ static int tcf_csum_ipv4_udp(struct sk_buff *skb, unsigned int ihl,
 	const struct iphdr *iph;
 	u16 ul;
 
-	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type &
+	    (SKB_GSO_UDP | SKB_GSO_UDP_L4 |
+	     SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM))
 		return 1;
 
 	/*
@@ -315,7 +317,9 @@ static int tcf_csum_ipv6_udp(struct sk_buff *skb, unsigned int ihl,
 	const struct ipv6hdr *ip6h;
 	u16 ul;
 
-	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type &
+	    (SKB_GSO_UDP | SKB_GSO_UDP_L4 |
+	     SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM))
 		return 1;
 
 	/*
-- 
2.54.0


