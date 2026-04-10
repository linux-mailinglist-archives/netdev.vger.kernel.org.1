Return-Path: <netdev+bounces-277450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KwiOlMT2Wl+lggAu9opvQ
	(envelope-from <netdev+bounces-277450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:12:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F823D901A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 447F530371A2
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866E3D9023;
	Fri, 10 Apr 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="QRnIadx+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SdtdeTkT"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B433D9DB8
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833827; cv=none; b=Hk0omNUV91Hvccb7FMOySSfEnUd3UrN/XO/e6do5Jpu77pFkRzrDBrAM7YfR7uGhUDhjyALluIiQijx86zLh6f/pxeAJHB6pQMfPmP0tXIctZy0NkotGYQtFX28WsqL2NRh8kZ2o898P4sOQ2wjP/fv3FDHIUUzHhzjxUxpgPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833827; c=relaxed/simple;
	bh=LS15Xu4zsM2P2cbnJH9QXzxKg+QCuDTxe5Jn5c55cq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e36tauAHpEhmu7qspoH4JDW1omVeT83TglazOvr6+MAHS5qAy8i3s9edodzeH0qxgX9rnsjvxN5XM9h4Fnr1/23jFPPfa6ckQqQeoPt3xXH2vVtq3tD0y+bLwQOOnKxQ1z4imkS0AdXu58WIJQrDDyFSSOkaQLaRU6uXIl+7dyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=QRnIadx+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SdtdeTkT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E67041400265;
	Fri, 10 Apr 2026 11:10:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 11:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833825; x=
	1775920225; bh=5S8qt1e78cR8wCsoHJgfBEraa//yXwr+TQS7xLGFo00=; b=Q
	RnIadx+zFeOVbuh2SSi/h0iS7LPomalSk32y4Rz5aSGk8P7J2515GieFN9ue5/OM
	yCHVR3f9je5ThgB2BkHvMfshsJC4NWjEaoCtOlQo4QjYwAMFKWh/N2CCkhO3SDXl
	V12V51TlvkEY++7C0uF59OYz2eQczi6Lpr3ckoxsC2YlEGY7s5VmlK18JAapq8IE
	WDannqO2Rvo6lVMCZ55mfOKPCemUhuTNC/Di8bN5G0Nbyy/0+v35GNJJLKysZtIQ
	tAfoMmORRx6I5YnYEy+39Z+SjI0ctCFP1DWxNmktKutvdovzMry0IuWdmjcDr4/X
	1vYa9XFbz3Vsyhv0jss7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833825; x=1775920225; bh=5
	S8qt1e78cR8wCsoHJgfBEraa//yXwr+TQS7xLGFo00=; b=SdtdeTkTwq9bKD2DH
	0aWta4wNK9UKKAIsilFXnBb5fwuAoQeiUEobaN3La8sM2oSqh/vzksjCbqp76dyE
	nd4IxFcn8mV9bT0ZFgZBZIAlGG9T7wVYy7Lypbqt0MfiS50LHUsnSbe4/FDgLiWe
	cPOi0mZwpvBzs+gSSZvEU7ylWFnUBZF6S6ftYUNEXHNAcub32kVAXA13RX62KCqw
	SbCdg57SIlFkMsq/zxnV5MzH/6oHaqIkOE9Lo49yxNBAftoYeIEj70Kz/4uPN7ag
	6p46Na7ps/W6VvT25b725T4NtfoUg1vDtaNeyrBXd4JjmBsoYEXN3vTRE7LpF3Ie
	7iItA==
X-ME-Sender: <xms:4RLZaUrM880VXrg-Be0-rWL6E99XSVLfwpM9oiCVmvMdA1sdqafmyw>
    <xme:4RLZabHqOm5wn4Y3jEe_Y2aqZ8TrvhmMdO72pofqk10oKkfBf2nl-jpQxW3k1ZHLt
    V6BhrCmM6ywRtu0NusTBZPTz6opgJn531AyD91Ad8XwDlj1nfqVRoEJ>
X-ME-Received: <xmr:4RLZaY9jABgxFej52PQmdJUCfEMcsPBrswZuU_JyvsBssard56dMmCBNbL_z_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:4RLZaYStArLPvs9verwjcfaOM9pfY7Y-toxG8zZGZSCGpyIDnZlk3g>
    <xmx:4RLZadqDY7vlhAeE0YJYjuXTGt7jOkMm5TASuw7BFCllSKzd3nt-ew>
    <xmx:4RLZaVNfgH5Tl7LzMu3E0eSCqhcelwsWkKWQlEmJnXdzYoHgRWdJZA>
    <xmx:4RLZaTywIiGsMf9E1-lsjtw2jTUenlHkKbhk9-T_CXRzc5HIjNabng>
    <xmx:4RLZaQAnZjlKVrighfMNJLbVYcPVm71DWJkZzwtWOYgzUvemoKg1ESvC>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:25 -0400 (EDT)
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
Subject: [PATCH net-next v3 08/12] udp: Validate UDP length in udp_gro_receive
Date: Fri, 10 Apr 2026 18:09:39 +0300
Message-ID: <20260410150943.993350-9-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277450-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fastmail.im:dkim,fastmail.im:mid,isovalent.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: E8F823D901A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

In the previous commit we started using uh->len = 0 as a marker of a GRO
packet bigger than 65536 bytes. To prevent abuse by maliciously crafted
packets, check the length in the UDP header in udp_gro_receive.

Note that a similar check was present in udp_gro_receive_segment, but
not in the UDP socket gro_receive flow. By adding an early check to
udp_gro_receive, the check in udp_gro_receive_segment can be dropped.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
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
2.53.0


