Return-Path: <netdev+bounces-287241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGrvFrZdA2qE5QEAu9opvQ
	(envelope-from <netdev+bounces-287241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:04:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9670525633
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3007130F517D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3A3D5C3C;
	Tue, 12 May 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="qCmZ4WB4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IRCZ3qU5"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8423C8C56
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605082; cv=none; b=dRNE+LOgZ1AY/RIWvnCv/cyh36ogXS0Fe/niSnQZdZbsueGGp0A0lJfK/OybMSVM+XUP2rhJTELhmACDc8RffPJWWET8CzNmgnkkd7ThmPylNGLxzVERcC2tCPcwa6tghvG+GjSnub/10MsLfzAuFpWXNXg8lq/Nu/Uu+RpxEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605082; c=relaxed/simple;
	bh=uF2J0U+AeUMpf8yatWTnd1IGwq3m9MEPTNSKwRsKd6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haW0wbYRYdoQ3Ag1n6ZaPkbsOARtVt3yd8LKj8cX+YzWqxGgdpeRVcWX0gW3MelulHeLOjSfoeVvpBqq1wZPNz8cgEHnZQhCneDemA1ohh0xUKbjfrm2SnBOX83VP2SiFQEgQ3kmx+UXz5WbKK1+Qp8iB1p+icrJOC9Lwbt0M64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=qCmZ4WB4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IRCZ3qU5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9038DEC023E;
	Tue, 12 May 2026 12:58:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 12:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778605080; x=
	1778691480; bh=MCyCNoaXKGya1g7fnQ6UO+KPouCstairzMyr+XkoEqM=; b=q
	CmZ4WB4bh3F0XIZGKULk7VX1u5JbJRyJ0U2AT8UVLtwmAVd/4OkAdOnSt/j00dNk
	XwNqO+ytqfHnKvendsk9yWM1RPfPkRnJrkhAwsNguCfa+XkT1Odx6ipz/KJvvaHa
	CDM7L0omg7PgU2wDqPixEIfEV7lwBPaYFuTx0pCj7XktTRTH98FT+jy9evmt5Z1f
	4fL7dxpadTTOQXHsG5kmCvUHb4PQ8KhlGE+WZg4YR6w+hTPaevvisniuxqHn3u/D
	HpcRPjSVbC99pvhJIseiz06NA9fWYZtJnJkK43Y6wIzSc+cmNUc/1rbG/zMdW4Wq
	4DDhkR6mh+HcvhaU5LOSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778605080; x=1778691480; bh=M
	CyCNoaXKGya1g7fnQ6UO+KPouCstairzMyr+XkoEqM=; b=IRCZ3qU5tuFx16/jh
	2++6b0eBTZ/JipIBgfJaMOAFEIR+6ypGHovQz/6FGSysiQD31IiF3tA8WFkWX++M
	4PlHTtE/8LpEqo8/3yYmoIgvWPNlvYK9NRxwz+9CT55d9gfn0oQlQz4p/R/A0lfI
	VF9K7cKYPWGva4BxtQJhVMekrLrPnWnS29TsVur29eshLWPQvUHOOGvIhLZtWEiD
	3KD5H0Ya8pBoZSxDunnn097by+aTChdH3RfbE1PVFen5tDP8l5mh2+m0OUZsuwpB
	scJeJCSHPZPdFKi1HUFZLJ1UTsbgMvBH/8INmfPHw2FuSuJwAv8xOEMhaPUJoQKD
	4SV7g==
X-ME-Sender: <xms:GFwDatTgTsdu1PfOrsYgxNg-ziKTRbiJo7pRra4wu6JaK3T8t0vwYA>
    <xme:GFwDajH8hYOEmcYxJYiui0QBray0-WbuXZV8YcvNM3WPWQB7-kns6vEBsrqJbqFuo
    MFB-74_aye7lATWVN_6DaxD7zWDfJeAuR50PLriCoSEypTTh50YAhQ>
X-ME-Received: <xmr:GFwDakcJwhV-UkuLY-QmlctbtpVQ7LZhjitGWXFjYnqQhpANikmhGDJ5cla6fnPQS2hEJ7i4vTuK1URRoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GFwDaiJ8rABQJ-63uIUECmysti7clg8C-Wsihw3TNC_yNalYewqhXw>
    <xmx:GFwDaroCMe_Fr4zqf63a_Q86yGwaHZQ1OpsXcM1Vos6Jb-hFr1tGPg>
    <xmx:GFwDagUeb9LKrYQXfe8qXKVhXibmpLOY6xeTdvHxI5rG2effP-WU7A>
    <xmx:GFwDau34o33Z1_VepmqQqhMC3daAnj7zL-So8zasn-qIXRkrggQGRg>
    <xmx:GFwDagi0ksknfzcmBJEA23jPsUnXCTdumOtOOxe-VlITwPJtAWlRqZwe>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:57:59 -0400 (EDT)
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
	Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next v4 02/12] udp: gso: Simplify handling length in GSO_PARTIAL
Date: Tue, 12 May 2026 18:56:38 +0200
Message-ID: <20260512165648.386518-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512165648.386518-1-alice.kernel@fastmail.im>
References: <20260512165648.386518-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B9670525633
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com,nvidia.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-287241-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.971];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,fastmail.im:mid,fastmail.im:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,nvidia.com:email]
X-Rspamd-Action: no action

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
Reviewed-by: Willem de Bruijn <willemb@google.com>
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
2.54.0


