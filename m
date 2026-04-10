Return-Path: <netdev+bounces-277447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHR/GG0U2Wm7lwgAu9opvQ
	(envelope-from <netdev+bounces-277447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:17:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C4E3D912E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF08308DC21
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A943D9023;
	Fri, 10 Apr 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="V8TQgG8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rgO/kZyt"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DD22578D
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833819; cv=none; b=o4rpYSpoL+cxZU33KXEJwM4/ObLvT/C72UzwX9P+0eU0QNjm2nZ7XnVPrZrNL/vKsHZ9/aBQd+5jN9OJaAzo7h+bft2KiWpHtjq5sHzSN3eJPJ/J6/kpbBRINf0+nXtNm7yJaZ3g2Ry6XS329TYmPL3ZD5+H9d79k7s+Tof3rFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833819; c=relaxed/simple;
	bh=nLkC7AmAZ5I+uIgCqvby19di/BFz6hB7GIwkYQlaBCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojfXK0zhHtZLn9NByr/GWXa10oifVoTSVPychPKr8wDAogFQPGmTKL2IKOjVwB1VTiyc8brv8ZlvB2IrQK7faT0EJ61UL/nqf1U3hZGOqZGdgGxSMxn8LncSszLygf7qrhdeg9EGYy9/jwIMkt8vv/nslmYsTe9je1JU5ltLos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=V8TQgG8e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rgO/kZyt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7E481400250;
	Fri, 10 Apr 2026 11:10:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 11:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833817; x=
	1775920217; bh=KtZIh2BvNEI2jKeSVP36/2OpUvdk2U2uPom69HUxxBQ=; b=V
	8TQgG8eue2NctOBGMxZNcCzIX3PH8QQ5GFW4p1JsN0AbxUKHuabnas47GJUtENn/
	cetCFe9DZg+yHwKgMnEWgaW10MWBtIssPj78zDVzZ+RK9G9BoOEiH9UbuDBn19uR
	ua4lbug7vliO02o8aPzQzHEp0I16yyWAJ4KIBJcckbYZxpl+mihT/b2xZZf53vN2
	2CRLFm21cLc2eQBfJzUs8MJILIDndK1EjFm+n4HlprhK/Te9DW9I1LSXEwa2j2xB
	PjMfK4/I5WqwTLPBuyrCC1km2JdAYt3cK9Wdlzi25ZvtzJ9Wm1ItpHwizJo9V4im
	p2e5IoMrrWTsEgMsQYHuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833817; x=1775920217; bh=K
	tZIh2BvNEI2jKeSVP36/2OpUvdk2U2uPom69HUxxBQ=; b=rgO/kZythBI+i91aG
	DBl+pu096NuUZnRMbCvTU6oLRdRen2NEO96ExBD74lq9AEwT0D6G6xERXoPp/TMc
	m7HxTwqrIor0D6L4Piu2ITTCPU4seCOBmXKQa5qyhg2er1PWSHIapSeg0uo8ggpI
	ijKgKY+AHNEHSrAXBuGg0P2V1PRpPU+F06Q8Tg1RbTAjNiSe3rlSTqLkPSxw2FLu
	YfIkmJbsyH8XNtjAl4AeJQYcBiUhreZtWhG0Wxtp/xA9SpzK44Dbr8UWjgDX4IO8
	fzXRv+K/jx6+IkwU145U2udOcbdQC1vX742RWX38kd2mQBn1eqI7ESQNHKOAjG5E
	eNOlw==
X-ME-Sender: <xms:2RLZafyhWooqEWTJn6C1qkOQH-UEl-JDesz0U8rtdrON-3j2F9Y99A>
    <xme:2RLZaXvTGWbebL2dyGwe_Q92vwfKPqLKXPAdzeXqtpesKfDHIp-56tH04ybFyYSNX
    tBS3u2zaLwLANAY_YfwWG1DKqEai6NOCGe8TDpEvv8OOQlTT2zKXw>
X-ME-Received: <xmr:2RLZaZH9Rq3-vNknVZkEZrqWKb4dg9teLbkadJkhixyL7_KLVR-RVhPLMzJIjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:2RLZaV4MSGW6YAQ8_ZiK0TdPE-E94Y7kBJa2a0s4QTnb1uB1Rjfytg>
    <xmx:2RLZaazCHOCxGIieDQ4nRmrs-upssObCM6j4lpZt8no0OVlCpv6IoQ>
    <xmx:2RLZab3KaJX2uKNZ3yqSLTbin7fapvNSBTF6fXOJ6ItLp-UtLh1lfA>
    <xmx:2RLZaV6oUaRa8PtBMBzlXDvFqBO7UduyTHLoPzwcXNz692Juazd2fw>
    <xmx:2RLZacKAMotOT-_Zqtv_UVEPEXgg9FSLfosvursbROyD-wEu-Njc5tHb>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:16 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v3 05/12] net: Enable BIG TCP with partial GSO
Date: Fri, 10 Apr 2026 18:09:36 +0300
Message-ID: <20260410150943.993350-6-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410150943.993350-1-alice.kernel@fastmail.im>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
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
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277447-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0C4E3D912E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 net/core/skbuff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e50f2d4867c1..0a6354dfe584 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4761,6 +4761,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
+	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
@@ -4776,7 +4777,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    !gso_by_frags && mss != skb_headlen(head_skb)) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4804,7 +4805,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
-	if (sg && csum && (mss != GSO_BY_FRAGS))  {
+	if (sg && csum && !gso_by_frags)  {
 		if (!(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
@@ -4838,9 +4839,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
@@ -4864,7 +4864,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int hsize;
 		int size;
 
-		if (unlikely(mss == GSO_BY_FRAGS)) {
+		if (unlikely(gso_by_frags)) {
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
-- 
2.53.0


