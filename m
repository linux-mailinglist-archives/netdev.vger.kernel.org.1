Return-Path: <netdev+bounces-291808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qASxLtPOFWqwcAcAu9opvQ
	(envelope-from <netdev+bounces-291808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:48:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC35DA0CF
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 675A9314BA87
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E53AFAF0;
	Tue, 26 May 2026 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="EywIqM/K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nnk823nW"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C803AEF5A
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812001; cv=none; b=C5Q465bpWTdUJ+DJbcNjHMc9s9R+OFECqD0azrFSgOZPquSIAaKUNziLXuFH0sxN9KOOHIfoDQbKlqk+Cv9jiyE/27OWP0ao//7YuPw8qhd1F7SXmiA5MRkp4nnSyhkusqLxUWCGYcGS6ksSKOfiV3FqLZhaKugAQxhwzn/eGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812001; c=relaxed/simple;
	bh=L3rwaAi/73P1SG6xoYEcJfPF0+vHETBnkx8uP/JFhuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKrogWTPhIRtUX4NyBibFFAHhRx+zuXJVGo6MWJ9tQPX0x1mUa8gqoqT+JF1d/8b6EfN3X1WaTBHuBbtTpD/U5CYMuR9cSLyOlT1Mt/Ovh+7A2KBtKiGUgqg8OwN148hvOb7RmR+Q7LzMdOWim3uyrlbBj0pHZRYKGqrvNTLuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=EywIqM/K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nnk823nW; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FF2A1D00094;
	Tue, 26 May 2026 12:13:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 12:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779811999; x=
	1779898399; bh=6eyk3yzfgJTFHwNv6Y9QfAinNGyoJU1Y80rOBjZss6E=; b=E
	ywIqM/K8iW6lgVExjiczaFgC10loZmPxXWHjsoQ9D+Rlc6LKu2extHLBuaGmVgVV
	9boNIGc5CLM0db2uJtCUdKRHBGjiOAO0FBwrB2B0SA5bn4Kbcm3E3fgB20T/0vB6
	gpIVBKOivGGHJC72IKpCUNAPmzwS8IpH9NjnnUZKRanRFwwldETVIgFXUhMvrUXp
	qGMff+jTvGyIG3Ab1LSrdG/VDMcMsM3t26Vydw1sqtM6CeZjf+20J82IsmkwLjv5
	n1ZcPT+NyD7UyB5L/v2G1+IAU/yqb/uP+KHzt+1iHLwjMriDMbfukn5aXcOgrC7J
	Bsxk8iqAlWAv5tebQ40sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779811999; x=1779898399; bh=6
	eyk3yzfgJTFHwNv6Y9QfAinNGyoJU1Y80rOBjZss6E=; b=nnk823nW5CXj9MFh6
	mzgZvS02/FjS1RC/Iv+vVkjDOCLcVjihcJU/ABxBNx3bCIj7qQDE9BB9Vya8re+1
	TNk1gIuksuGLVQmj2ihmP65fy17oJ932Ni17ATotBcux5SC7vkLsV0Qb6xuBD9jb
	cVGr79GZIBuPMhL/2QSVamyYK4431QEPmU/nJPr4MtdGQ4/C5QNX5JFAsXB724Ni
	ZHy2Yl6ij8g+/sNb0uYDhBSiw7xTqoCbt8xHaa0f4IH24sCgVktpccqMH/qmt1zm
	g2JmRZ05QTv+rWmUwdDrhv+E7StE77ZP2byEp0b5U/NsJOW5dZghF5a7MVwvicMP
	CZASA==
X-ME-Sender: <xms:nsYVakvY-IBfI5dgLb8m_-IgNMBqiB937AcqjT6Bb7nxVgRJ7V8qAg>
    <xme:nsYVav-38cp16wgZLlhfL0XpITBykf9jluz9KzC2oKY8XcCewEHwjmqu_S5Do78Pw
    APVh1RRhoNGqfcXBZq13ISpOasiCXEAulX5rCbsMiyMR5QcUKlyYqY>
X-ME-Received: <xmr:nsYVammNSst7-kzGErt0krCDOTr8rm2cef6gGIt-7tIUgo7RD2O55KMwVF-Db3JiOXjrDtWdDXIwVL-HWOW-SFWWDDeOpWtes90k5w>
X-ME-Proxy-Cause: dmFkZTG4G9zbtpZgR+LIx8EkHbmWKiCUD5lWWjQ7rQgOwm/VyUoO4wynI5PAYAu1dD2VK+
    aE6JARqIKgaU0Q1bOd4rLnkhu7UmRwqeTgvkSV5d7grxG9FOkQ0oQeRmYwxzVcDeyksT5X
    MnuMadVg8leAkVjnwRPLpa+FDPLAPVROlFfmUAgtPHyfk3o9NrypRZ0abuRJIK8O5lp5p8
    tzBD3Olzgd7un01+SJnRGQin/adteeVD2Zbc2V/ul/M6kb/60qayxpEi+pujApdRm0DdBA
    gAhadAA2ZHV1xUAE8cGyD+tUbCqQfxKzuc5eRxGV7Mo52+ocM4y7T5twJ1LOAdcR6Qctnl
    jXXEYvhLPOofanh6cPmrH+nBQBti84oLq5vvkojVLygI50UW7C7phHXu1xWY8oTaP3qcuZ
    W7nl7oDKMdUvHaxBjYXb7IfNJ288Dm0rATt9NZKb+HD9K5CSrMp6xhnBNCv44XaaH3E+6x
    KHWsdcXJVsKbpi/3kh0FY2n+xRX6CCCtiCuKIp6zpuv27S35el6pzQM2mh3YvQkWz5MmIM
    /Qcf/G58aNPdUgJrhakxIKe6IbgvNozalWq/9hFnS5zH+eHHQCEX8ktXeU/izO6wett/mE
    CdSsTxXDv/+6Tkjil/dbODPU34NW86RiNnjHJa/xF6cD3qloFRmIiGFHolYg
X-ME-Proxy: <xmx:nsYVanPX_MWeQNEBRf-UHVQC9n0Vr9-1y1YueX3usWgHhMwkikE34w>
    <xmx:nsYVatJLPJ4gFfv5pQTbpsk8PrOeM2fwWP92mXa-OMtzhTXW8DKb0Q>
    <xmx:nsYVaqFym8kNkPLTxuTpBUY4saNGqyOXXKFE7Fembv9-ea-dFZcUag>
    <xmx:nsYVamB6RakM3AGi-tOBDEdT-XVuuOuo_ltmmudp6nLcP3vSi08Fdg>
    <xmx:n8YVaqZv3Yvq824Rr9pkD6wsN4WeXyNE19WJyCKcWoOLreGM3ScaQnvp>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:18 -0400 (EDT)
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
Subject: [PATCH net-next v5 04/11] net: Enable BIG TCP with partial GSO
Date: Tue, 26 May 2026 18:11:53 +0200
Message-ID: <20260526161200.1135899-5-alice.kernel@fastmail.im>
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291808-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: 29FC35DA0CF
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/skbuff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bbc15e946c27..4d69997e5e86 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4750,6 +4750,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
+	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
@@ -4765,7 +4766,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    !gso_by_frags && mss != skb_headlen(head_skb)) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4793,7 +4794,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
-	if (sg && csum && (mss != GSO_BY_FRAGS))  {
+	if (sg && csum && !gso_by_frags)  {
 		if (!(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
@@ -4827,9 +4828,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
@@ -4853,7 +4853,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int hsize;
 		int size;
 
-		if (unlikely(mss == GSO_BY_FRAGS)) {
+		if (unlikely(gso_by_frags)) {
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
-- 
2.54.0


