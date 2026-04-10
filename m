Return-Path: <netdev+bounces-277444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF52GgUU2Wm7lwgAu9opvQ
	(envelope-from <netdev+bounces-277444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:15:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 968713D90C8
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7BE9305C623
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EC73D88FC;
	Fri, 10 Apr 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="OkCPx0UD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTvoajLv"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306993D9023
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833811; cv=none; b=rWJe1D1jgFmvoTBT1YwAZZR1RazgW+Yu72zGjBXrAZdBYufFjDbnLWqD/6zBxmRB0Xf+p93aB+th+td1lIsT3VcKHrfYSuxz6xSK400tcWywnphQyBAIjyNDsoh45oExBH0nAUG89QqbM5MlXfvL/TRuEVjU4fLV20SzUxf2fxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833811; c=relaxed/simple;
	bh=nxnsrzL5r/C/+ZRUKWPTX9sgFQSHHCyhovFeBfpcrLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2cGFKwwddZyX8y29f+IZ367H23ETV0Sm1vK+kMYcdcJiIHr8Ja3SF4MIz8lKYjyNgKWw1xuQwWNi1Agdi44FrM6s6gPzVVOYa2kDDcAB2ndTXnxRPcHPZ+zpQWcETYPWk76Pwm4/S8mUc6eE6UvZysaqBp3cPawB3uh5bs67tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=OkCPx0UD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTvoajLv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D422EC0442;
	Fri, 10 Apr 2026 11:10:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 11:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833809; x=
	1775920209; bh=Q4qdeOvCTl3pwS+MpklFN0PITR02yqluSW2YmSKW/wI=; b=O
	kCPx0UDDkwHKRlwJYBmhZqg78N/OBAlefr1FdUZdyR0txQTCipVVZBeeaQdyAYhF
	04wz96Hhx/OFVZPXcbIpFZtH+vwLiRFcQ8dG4qTXX/nJsdBi13t87Gi6rqe63WOx
	TX4irnh+nG3Pmx3jCyYv+raLDQearbZ+Lbq/6uK6CUK6tEsMK4ymmlRgsbxi4CVA
	0j16Vhi9VO+N+fmRjyKBaEUOAYo+92zXGU21fSY9BlK041XPPcYzZJ/15ZJ+h6fY
	Uj198BhpRowZBy4tI+FR60tOTWMq4r2xjh53XHr9WqNp7UCKtBxno0LPNDlQ+plF
	wb+nKXctjkaVUF9cGi9Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833809; x=1775920209; bh=Q
	4qdeOvCTl3pwS+MpklFN0PITR02yqluSW2YmSKW/wI=; b=HTvoajLvYE0PCgxnX
	yRM1LZiAOzKkqN8vAGcWupLoP1VwUi47KisRb1mUkvWDLI/yu2H/q9aJ/52IkiIU
	/b5N1kj+348zspV7bHchjgrPI1A17iIasCaz3JxpdVlY5c8wtZrczMbgmJ4ZSwjY
	DVfeGi2khp2aFeGqOv5o/zUErlPy5u9dqOwr7+Ww9q9FYE4VUkYoaPYa9wW7u3oZ
	MJm3P/5Uiwh0FkNxuFXk0JrHx/uec/xDPzqvLnJdCRcbt1bxyiu8yZWWdYPZNWzR
	toKQjkLmhYI81go0bN2FIrJCwiuLSLcpCxdXwjHf1e1FTQbYyOjynCPQzhAkUrT2
	SKnUA==
X-ME-Sender: <xms:0RLZaSPRsaoEno-DCpuXGof0DDltyBy15D7udARMw2VhercPlTRnnw>
    <xme:0RLZafe7ZXWFWFG9HbPU6AVCj6sF5rAWwoyz3V6d4nxkNepLpNgxn1xaRJp-1f6Vh
    Qlt9D3QB6i7i_ZU-tM3GU9NXxBuZjYYwp-XDMc6n_DKm35dZ7Hc2ok>
X-ME-Received: <xmr:0RLZaQEO4VKRfO8cDOYOLV--wY6v5-id5Rjh1n3sCAMl6x2r5k2EuRvPIGI51w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:0RLZaSsouhRz-jM9Wgg5faM6VatxBZA25zq-KGSfe7PfFykzSvesyg>
    <xmx:0RLZaSr6_DT9Ok-ikBeiIUE7iKX9waAw4aGrf9r1fgobDgw1aHjJ3A>
    <xmx:0RLZaRm-aB8ol3XKiorWQBEAG5GTGQHxmyTV9h5CRnY0qgIxIgwN5Q>
    <xmx:0RLZaXhsHEYuwVlr3u6MyiPTI2o_4bq61hX24Pk9RBUKFKmgNPr5cQ>
    <xmx:0RLZaXJ9WvwKgubcVyZnIIstCSpqSkRrKnia5SdYn_aFiKosF1OpuvJm>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:08 -0400 (EDT)
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
	Alice Mikityanska <alice@isovalent.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next v3 02/12] udp: gso: Simplify handling length in GSO_PARTIAL
Date: Fri, 10 Apr 2026 18:09:33 +0300
Message-ID: <20260410150943.993350-3-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com,nvidia.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277444-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.im:dkim,fastmail.im:mid,nvidia.com:email,isovalent.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 968713D90C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
and fix the checksum (apparently ignored by hardware anyway).

The mentioned commit started using msslen for uh->len, but still uses
newlen to adjust uh->check. If the formula for check is fixed, newlen is
assigned but never used before the loop, and newlen is overwritten after
the loop. This makes msslen not really necessary, as we can reuse
newlen, if we don't adjust mss before. The adjustment of mss can be
simply dropped, because mss is not used anywhere else below.

This brings us back to one variable, drops an unneeded arithmetic for
mss, and fixes the UDP checksum.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Cc: Gal Pressman <gal@nvidia.com>
---
 net/ipv4/udp_offload.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a0813d425b71..2578aa7f9ff9 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -482,11 +482,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	struct sock *sk = gso_skb->sk;
 	unsigned int sum_truesize = 0;
 	struct sk_buff *segs, *seg;
-	__be16 newlen, msslen;
 	struct udphdr *uh;
 	unsigned int mss;
 	bool copy_dtor;
 	__sum16 check;
+	__be16 newlen;
 	int ret = 0;
 
 	mss = skb_shinfo(gso_skb)->gso_size;
@@ -555,15 +555,6 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		return segs;
 	}
 
-	msslen = htons(sizeof(*uh) + mss);
-
-	/* GSO partial and frag_list segmentation only requires splitting
-	 * the frame into an MSS multiple and possibly a remainder, both
-	 * cases return a GSO skb. So update the mss now.
-	 */
-	if (skb_is_gso(segs))
-		mss *= skb_shinfo(segs)->gso_segs;
-
 	seg = segs;
 	uh = udp_hdr(seg);
 
@@ -586,7 +577,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		if (!seg->next)
 			break;
 
-		uh->len = msslen;
+		uh->len = newlen;
 		uh->check = check;
 
 		if (seg->ip_summed == CHECKSUM_PARTIAL)
-- 
2.53.0


