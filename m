Return-Path: <netdev+bounces-287247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL64FeFdA2qE5QEAu9opvQ
	(envelope-from <netdev+bounces-287247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:05:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48E525678
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE3E93118B7F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3863CDBD0;
	Tue, 12 May 2026 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="gYCTM2bU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fsXP1eKt"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585823D9678
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605101; cv=none; b=ahzIvCkpskdJ3R0DuL7pFM++IhmnVG6z92MfENn0pvhwMwawLNSZ50QHhBULkAS19MZvt8O8FUHhsDsFPVRSAEFF+ufbqJfR1TIEb8Bv7AKUwsXCdlUs4w71OFCv74H9Q1PTr8EU0Z/rw+TztxafjqM2ihE/yBgq7nSUW2MDEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605101; c=relaxed/simple;
	bh=kJb3wCcAjVWh2DEmWg3hZjWXEeaVslT2uSAEk7ZNiCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZT7QVk4JkwAt6g/icMcObtMcqDrp91ikJvnycvhGI0L33XuDFBdQAnRug60fdhfBCeeGnbUe/x6xKswt6qr/yFmNpukZp2nTL98SodUouM9ANxKhCVeWdzmRgIloSe5GISZBDlF6vG0X+68KfUwTwohqc9AZxi/G8liyFOI5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=gYCTM2bU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fsXP1eKt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DBE2EC023F;
	Tue, 12 May 2026 12:58:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 12:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778605099; x=
	1778691499; bh=Rao+OQEzV0RiWsArKGBOXmjxJi7aTYahkFiOyHcTPeM=; b=g
	YCTM2bUkzICRTgndlki3Qfxl1JZvsKIRbDSgy7rt0Sp/ehcipkgOIToCCLG1y33H
	Jy0LpwfX4z+hMQKVUDhpHg33J3qRMSKRw38Uwn/mlrhtuQu6tDKPtRC8tjn4ktuN
	CDmlAClVh0VadYeufLZIP8A1isNZz6aP3QRoWZfuU9UpKTLPAkPDtZp9FPXAfrKl
	QMPrPEdCOJvn8/2VE6b6Vls9Xp2PlsQiup5opka4FEiYoDnWM6lL+aHemkb8oKpe
	xKwFcikERiALiYgYJIHGD5kD6WH0ffooO11Ymlx9sYCYItG1fLYoa7W+hDY5HPko
	eN/GduyDvhvU1zh8GsT8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778605099; x=1778691499; bh=R
	ao+OQEzV0RiWsArKGBOXmjxJi7aTYahkFiOyHcTPeM=; b=fsXP1eKtdHZD++csr
	+fS3urYmapNU/eogJOxqz5OvVkyuqK54Njy/yJ7FvAmv6coSsm872hYIFvHrWdal
	/dMtYrWbRDT/CFzNHDIz5yitWje5DsisKerrib9uUop2R/I9j5nnH5aS3rQPoNT5
	SViiciqN+TuDdcXTgAT5WkJAPT/8HCO4Q/4dJJbxs2mAu8ULePpoKxrRrpBqC18P
	kNa9uAvmQgWWjKK73F+gayyZSnLuCEUCI/tNl2je+gPqcBy80uMUn8SEwGgI/Hst
	oRGX4qcws2Rp5Iy1PTi05ZzR13wWtzJlExO2Zlw9fqT0U6eE++O+RQxMNq6Snbt8
	8lUVg==
X-ME-Sender: <xms:K1wDakTOapNH6pSTzHQvqCKwPt-_jjrWhtWQ44x9AfuTaAbLnxw3rA>
    <xme:K1wDagQpAbj17WZFHzm0Ow1Sf2DJwx2rDjmDLw9pcp_lQEOLkUa7BDxUQCrzdol4y
    Xe_wvcFMR-bi6N61mfsTc54HxZhu_RC_vxb9NGEpHKz5ceLF_ZZ_ek>
X-ME-Received: <xmr:K1wDaooqBCEgZ_M2C3cjqZm8H1SFYWT6QmmxqS6JjLZv1u0P_hiJXVj1mxnqkH_bgRbibBnP0Wj-R__Ynw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K1wDaoBknIFfnKaXvlDU90FWhfHXS6y9S0C051cVd_1m2uA7AT8vBw>
    <xmx:K1wDalsI4SfQ0ixgMOW4oQG1RZceR8-S4gBUzobaj8O_3-qdtLDi_Q>
    <xmx:K1wDavbObgKKrQHxyYOjkmUq32lg6e1jSRNAfAuTUUs0Z5B9uJXRng>
    <xmx:K1wDapEolJS3MyqKInlpUtPFkfOkBCXrvLXMiDVzp6E1ZMVtM4ZKuA>
    <xmx:K1wDahPbTeiBAvABAPgJW_pQ7OvIuGNRkQyBtV02K7-RYzPiWpPpHdc9>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:58:18 -0400 (EDT)
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
Subject: [PATCH net-next v4 08/12] udp: Validate UDP length in udp_gro_receive
Date: Tue, 12 May 2026 18:56:44 +0200
Message-ID: <20260512165648.386518-9-alice.kernel@fastmail.im>
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
X-Rspamd-Queue-Id: EB48E525678
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-287247-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,fastmail.im:mid,fastmail.im:dkim,isovalent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

In the previous commit we started using uh->len = 0 as a marker of a GRO
packet bigger than 65536 bytes. To prevent abuse by maliciously crafted
packets, check the length in the UDP header in udp_gro_receive.

Note that a similar check was present in udp_gro_receive_segment, but
not in the UDP socket gro_receive flow. By adding an early check to
udp_gro_receive, the check in udp_gro_receive_segment can be dropped.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_offload.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 23653872ca65..4bb37c8d234f 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -704,12 +704,8 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 		return NULL;
 	}
 
-	/* Do not deal with padded or malicious packets, sorry ! */
 	ulen = udp_get_len_short(uh);
-	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb)) {
-		NAPI_GRO_CB(skb)->flush = 1;
-		return NULL;
-	}
+
 	/* pull encapsulating udp header */
 	skb_gro_pull(skb, sizeof(struct udphdr));
 
@@ -779,8 +775,14 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	struct sk_buff *p;
 	struct udphdr *uh2;
 	unsigned int off = skb_gro_offset(skb);
+	unsigned int ulen;
 	int flush = 1;
 
+	/* Do not deal with padded or malicious packets, sorry! */
+	ulen = udp_get_len_short(uh);
+	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb))
+		goto out;
+
 	/* We can do L4 aggregation only if the packet can't land in a tunnel
 	 * otherwise we could corrupt the inner stream. Detecting such packets
 	 * cannot be foolproof and the aggregation might still happen in some
-- 
2.54.0


