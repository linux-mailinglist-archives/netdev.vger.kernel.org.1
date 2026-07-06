Return-Path: <netdev+bounces-305187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4dawBUHyS2oGdgEAu9opvQ
	(envelope-from <netdev+bounces-305187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC02714710
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:21:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="C G5x/i5";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=m0x+pisD;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305187-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305187-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 185F43024B62
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C719437863;
	Mon,  6 Jul 2026 18:20:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC8436BCE
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:20:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362049; cv=none; b=UfiVql9+wlB63yqBd/dbvUud0pSXxSlAVUAw4mtUZTvPE49654z7B+VYTlUNpZsdJ/o1kHp8dpcHYfwhLMLSZRo14wEJR8y13HsLS57yvipMM0Xg1XbfyNrv9wFt0A5I/GsAusaqeW6NDj8Du6AC6INIA3K2uhiNjUk8yMQLa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362049; c=relaxed/simple;
	bh=ZWXbgafIGTz8xu/L99Wf9gJbdEsf4Q7FwDvYQks5ALo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlY9a1OGbYS8IFkUAKhvDtLw62ENddWZ8bVQcIPcupDKHmumFDxfKgCG6dig49Spi2gQCinn4FsnMi9dLk4eQ9TJoqRvyOIWlhrQcI9GLnI1UGVNZE2dHjCbkYMFVSLu7CJMvjlY4yhD6nmUaAW/ldSH27F+LXTuB1q3nH3wi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=CG5x/i5+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m0x+pisD; arc=none smtp.client-ip=103.168.172.152
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28F8E140013D;
	Mon,  6 Jul 2026 14:20:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 14:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783362047; x=
	1783448447; bh=NBxc7NjrXRB/RPnGvxFt2oPvmnXmDKIQnsk0vpD0Uls=; b=C
	G5x/i5+I84Wrc67RYMuoa8WK6OdWjuBr6rxvU0CP2BvcIVOYeP2r2Up9icTJMBqo
	NIVvCcGHbtHKNu1eFTb89kFcNjJCzjhyFgBEWRP3dHJgi9wGx/4doNcIkWHEwJa9
	0DKXTmH6aT3nqlwRoP4fmKq5pr23LH/saFe3IW4R1hulZ/SatQRzvmbbQ9pGp0FR
	C1bmLYV03H64yfd4+o7H03ngocNel68bB0nZ4FT05ElMmP7j3oeJkmejg0KOFDNt
	3gKHvtUXSfuaUeE0JJ3j4Tc03GsmJfMoHQh9fgHy61nPIPKFJMkbGocDtedHH2OX
	3lKvHb5TzMKBET+UCdkwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783362047; x=1783448447; bh=N
	Bxc7NjrXRB/RPnGvxFt2oPvmnXmDKIQnsk0vpD0Uls=; b=m0x+pisDr9klWsBGq
	544LKrFI0HhyIzWTHyvFCxeAfQo/5HrANBznm7PFgiw6JdGLTFq3Bia9C0QqyJZJ
	hYYBTulKeObKukk+Fh/2UXpMedRfejh+DUA4VviacyuvSOpiE0Ffp2tiYBB0dx78
	dqThO1ul+OV40DKZizV8ZPVG3OL1wI6RzTK4yW0LT2pXYUG8dEFVymlzq/Tm4LFo
	r2T7Hg2eaCVKftUvg8Sry7vhX4Qe+JK7NWjxVLZ+53FTiaOFn0NitCkaIP6rEF76
	v54vrd5OEzZsilOPcqME5j56RSRwOwaPPkp+/cu3GivAROFbmcsLwJ0I82Dme2Ja
	D8TUQ==
X-ME-Sender: <xms:_vFLatWXJ2CCj36k3YXVyogM34AC9RM7Egofpa9MjaoPw0PGmrgsGQ>
    <xme:_vFLasFBJxHRqYUmyofZFU9FBnnvH_V4LAXFfizsCKOZJhf3g7YKynsaCzeDCSFtZ
    _6v5ebkzd0hHFwtY_C5BbZV9Wght8dZ18xKuf6RWkwFKJom_XrhY7TX>
X-ME-Received: <xmr:_vFLagOBsgROv5FsWX6zdsZ4PCHdbd0YQflsHgpEJcMY5KB3O6y-gH7hzk8>
X-ME-Proxy-Cause: dmFkZTGUsUpJpDFa5ndE4N6eTKB/j2d4JsSbrhMs8kmEW2L9QK3N/6TXxA5y7ulUoXm7BP
    89asODAMfT3OBvY/M09D0GqR/9f8fV5gBQIGHO+HJK2v+bCFZ6PfrlSqdRObcl1ifowHpG
    tdD7vyUPEgwFuODXXuYyDriQ176ee08aLqbCrephkwOmUEbVwxNtxJmLaLFJpQP96s58mK
    npPwdvdZvXzqtDhxT3KN6NVuVc++tCiI8YGn0XKi84DG+Ojy+uujNScslpd1sVLQiZ4Ias
    tnSVjmdR3/qyqDiPkegvX2kZQRuflV0jlrEpRX03LLhuj7//XS63UPEDz3jVugM+iYgwJc
    JoO+NkQUFdO9dq2Cc1BX/CpMY1M2f3anZlQSmXc1lDT7FTwDeBuiGCaTdleZrycrlh4IdA
    xPNc+UMHU1jKylVeF0uFNThP3TVlmpOWtq09Xo2xh5CnEo5svQroiRzM6d7OQRr98fKRZT
    cLzBEWRTahuJDjh99QJnorSDPYRSBbfp9LhoMNEUHH44TOAInBoJFAcwH3Y1Hrt3oVaKJE
    MDUQS/a/561m6otvMYiw9PGlGqPkBFNj/Kdn7VbB7HMZrnQRjBaZl4AVupHvDLTSy9yccw
    FkxYq3DPpQMxFBQsWzyJ+blC5faRt/cM7GYZ7K/ku5nk6i7BAvdZprP9oO3g
X-ME-Proxy: <xmx:_vFLagXsE7rYRmJEfRZJp09koVTPsq1exjS9E4FLgq7uZ9ODo1rNaw>
    <xmx:_vFLavw5I9sIcpfGWHrOWb8vI6n6io1AsDBBIesKQCOjXY7LCaVR-A>
    <xmx:_vFLaoOWoCxASvhfZuHrX3tkWjtkguZX3F9ByIYDJWv_R-ch8OdtlQ>
    <xmx:_vFLaprNCoEL7_dHnBs-IQx2ytDn6ErWZ8pvnfdKSsDvP0C8KQfArg>
    <xmx:__FLavjxcrCaICMaMX6QUDjM3GfQpwfkyNNoii0i43UMq0IaYVjiTfgA>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 14:20:45 -0400 (EDT)
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
Subject: [PATCH net-next v8 2/9] net: Enable BIG TCP with partial GSO
Date: Mon,  6 Jul 2026 21:19:34 +0300
Message-ID: <20260706181941.385672-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181941.385672-1-alice.kernel@fastmail.im>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305187-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid,vger.kernel.org:from_smtp,isovalent.com:email,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACC02714710

From: Alice Mikityanska <alice@isovalent.com>

skb_segment is called for partial GSO, when netif_needs_gso returns true
in validate_xmit_skb. Partial GSO is needed, for example, when
segmentation of tunneled traffic is offloaded to a NIC that only
supports inner checksum offload.

Currently, skb_segment clamps the segment length to 65534 bytes, because
gso_size == 65535 is a special value GSO_BY_FRAGS, and we don't want
to accidentally assign mss = 65535, as it would fall into the
GSO_BY_FRAGS check further in the function.

This implementation, however, artificially blocks len > 65534, which is
possible since the introduction of BIG TCP. To allow bigger lengths and
avoid resegmentation of BIG TCP packets, store the gso_by_frags flag in
the beginning and don't use a special value of mss for this purpose
after mss was modified.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/skbuff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..6ae4c2b205f2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4775,6 +4775,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
+	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
@@ -4790,7 +4791,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    !gso_by_frags && mss != skb_headlen(head_skb)) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4818,7 +4819,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
-	if (sg && csum && (mss != GSO_BY_FRAGS))  {
+	if (sg && csum && !gso_by_frags)  {
 		if (!(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
@@ -4852,9 +4853,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
-		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
+		partial_segs = len / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
@@ -4878,7 +4878,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int hsize;
 		int size;
 
-		if (unlikely(mss == GSO_BY_FRAGS)) {
+		if (unlikely(gso_by_frags)) {
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
-- 
2.54.0


