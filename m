Return-Path: <netdev+bounces-291805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kILrGrfOFWrkcAcAu9opvQ
	(envelope-from <netdev+bounces-291805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:47:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C63D95DA0B9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2170310FC4E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2C43AFAE8;
	Tue, 26 May 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="qErxMUc8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDhIWREV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C53AF660
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811992; cv=none; b=h9RN+pS7XK117FUdXkOWezHEVyPoLm9ZRo22f82PHLBMeliwR3M1hd5l3xIyXQWsGTMmnuKXgy02UPFcVNxykApIflbNqCmd7Hcd6CJNurLsvkapGBTfD7yE84YI/Bm7xPw9g5CtE2g778zY5w49r2nekoixyqMbrI8vUOy3fhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811992; c=relaxed/simple;
	bh=NmyU+LzzDIVulR+Wa58VSzqOQTcNA5ulDK0vhrFu6CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpvupzWUuElyj/Ve5il8oZMSK518lFmuRTk8wALUBEKdUGAhkCnQsCdDHk6OY40Z3ZyEaJEXgowg3piimCioo8wi3ea7i/OJ2I35lQJx8OCIRQNOju8FmiqmInu7twcxManPOlqE4+JI+NTBYr/50T6dVZPmfShx4g9Vn/5fEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=qErxMUc8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDhIWREV; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CE111D0005F;
	Tue, 26 May 2026 12:13:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 12:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779811989; x=
	1779898389; bh=C8+Mu4wSB6ALx3Xp69hOWTqTS8HOJYoIAdW81FNJXtk=; b=q
	ErxMUc8F5LB032Rf3QI/GEjcOPNKNQbM+c6ZlqkxCyBnPqWamOTdVl1ZlNan/zTG
	FLkb2clcmr9QXK8wWt4x8QoQAKjlsSx7Ht0lsGBPSNK6r+SMO7mEn/CbbVef3cPx
	xX0v2VD2FZ7IowdGImiChUjq2/ce32icVIUvjtaTAfOe6r1iYefMV3/JEZNORGKn
	Y7gyn8KrRgS/TSLismL2w4Gl6O7ssSgIuUrJEvcMlTVIG1+BdGlni5CW8ggw/KOn
	lLFRMzpuWRM2cmAC+ytoTIwFufnRAm+GqmEH6S6q9jOPZ1JmrlZmMCDKyhSUzQie
	2sjNCMWfOkvuMetVNcqTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779811989; x=1779898389; bh=C
	8+Mu4wSB6ALx3Xp69hOWTqTS8HOJYoIAdW81FNJXtk=; b=hDhIWREV9sGj/d0is
	L9hytOEZ0arQETDltH8Mn1uZcTKNJUg9EbFihoePCi/h37+gIsvFejgfVlxdJOT5
	YR5tNniFlnlcO7RIKWBPjKulPPFeGHPn6t9gfqqDrwWUInYnbLqS/fJz1PkbM6uU
	JvY2CPbAsCmZhCRyXWfDcREP/AURD4ANu07LM6OicMq6pwTtQZS0jZFioennntiC
	18SZgblWoSwnw1pMjMRIwejZFkbNaq3rd89H3g0MEl5xrDm5l22CXsgl+3U6ASvg
	5FItCUD6crIGgN2rAHyOCWvXlbIC/uL83yk8FXevxesdHTSvI1T1k5PhgDYym7bb
	lnMJA==
X-ME-Sender: <xms:lcYVakPSNady12RpBZ_nnkhL9H7_aMhUX8LiXuacT-nIRFFFgj22UA>
    <xme:lcYVanSCGCpc7YERkAhVIGMtpaRBE2yPjgIqztR3_Mn2JSwyqKMddy4jD_bP7_G6G
    nkng29SnX9ILKGm77q_5MVuUy5i9dj7VkOWLgLnrlrvzqlEVJauAUQ>
X-ME-Received: <xmr:lcYVas5liYb2vkH0DSsJ0m1XoBEUmNu5Be-DneHpfEoW14s7Gun1BnMp61d8So481YbxcJl0AeiTffrvUh1ZppuceDl8FoBemSJ_BA>
X-ME-Proxy-Cause: dmFkZTG4G9zbtpZgR+LIx8EkHbmWKiCUD5lWWjQ7rQgOwm/VyUoO4wynI5PAYAu1dD2VK+
    aE6JARqIKgaU0Q1bOd4rLnkhu7UmRwqeTgvkSV5d7grxG9FOkQ0oQeRmYwxzVcDeyksT5X
    MnuMadVg8leAkVjnwRPLpa+FDPLAPVROlFfmUAgtPHyfk3o9NrypRZ0abuRJIK8O5lp5p8
    tzBD3Olzgd7un01+SJnRGQin/adteeVD2Zbc2V/ul/M6kb/60qayxpEi+pujApdRm0DdBA
    gAhadAA2ZHV1xUAE8cGyD+tUbCqQfxKzuc5eRxGV7Mo52+ocM4y7T5twJ1LOAdcR6QctbJ
    tgvQeWAVJ4QQd1aF8MxFeGb82aLG6re1PFJ40rnLbB5ZbLKROIaUdJtpkxYbFdjdOdlaKS
    2ZSzpBWGfLNkn4j4E+6uXaBH3296uxauUoc39AvVz0OzqnBpjlS+gABZbyuthmJa8CkdxY
    j04yYWNkH5yGN2NPkmEH1XUgCFIkAFo6j2zXjBQ1RXTXDVLybixCkRBDBxkUsxhi49ugVN
    0vYucS2ElXlzoKgNktZQglr7azoKndRlXYSMl7f/ZkAlebJcUQxaH6eMUIkDQ3juxYGzK0
    hXfsbt8XejYbAhgyFbrn4Emwc5VKTCyoXl08wSOcgnF0WkEVdi0DQqp23tnA
X-ME-Proxy: <xmx:lcYVap0rJIHJ2y_sVa0yUO5rSLE8GYbp1u7C0wefn-t7DQwxZGIKXA>
    <xmx:lcYVahk8M5mQf9rY5A78Opmj7VdtDEQ0qZ2EqyS9mxX6DfVS9w6Hww>
    <xmx:lcYVanjlgHoUMWA-csTinFySm8zx2JasnUb8U8L1bzdnJI0da_iIAw>
    <xmx:lcYVauQ2a55wq5N7qzMw9bjmd2N_jmU0KwvGfYAevj0D-BQmxgRZSA>
    <xmx:lcYVapjtc078ZCOY9TVphuLBwORDfdYSOsNeUwD5yZflacTncG6T1XeX>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:08 -0400 (EDT)
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
Subject: [PATCH net-next v5 01/11] net/sched: act_csum: don't mangle UDP tunnel GSO packets
Date: Tue, 26 May 2026 18:11:50 +0200
Message-ID: <20260526161200.1135899-2-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com,redhat.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291805-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: C63D95DA0B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


