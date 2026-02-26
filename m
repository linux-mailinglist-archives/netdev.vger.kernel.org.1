Return-Path: <netdev+bounces-261576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHLQHUaqoGlGlgQAu9opvQ
	(envelope-from <netdev+bounces-261576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:17:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5E1AEFD2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F6713012B58
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3942885D;
	Thu, 26 Feb 2026 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="h3CfDsJ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9PdBx46"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631544A739
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137023; cv=none; b=tWzThYYKCRSXjT5WxeU+BFZ6289WpHSIUF0UCVlsmq9k8AcXyXrnY2ps9wIZ8ihUDGwLghE/Vw57lgBDjQHm+RhOJvWkHbCf5hBxFLbOT2YzGmWiyQep7PqMVeb3JVAFUcrG7YvJ9b9VEqRCigk8B0VW4sUT1NMts1DNTI54ffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137023; c=relaxed/simple;
	bh=vfPTgeSa0kf/+W1qqiDgXX/4FM4SUHMkBaIC+VmGcv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSZgz1xQYPMJTdmDMKODg+0xRSPJEQkrhCvIUOOf2xQLyQIZk5D6Ez/qfBRITFvSSYKz03Prjaax3U2ETSDHkKzC3IO4ezwxjl6l4zZTlBq/xV5RuL2n1ysG/YuK+CW+Xd4yMV+d8GHmXKW9rvsWVtAAoffF4sh/rcLnia31B0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=h3CfDsJ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9PdBx46; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 374F57A013F;
	Thu, 26 Feb 2026 15:17:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 15:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772137021; x=
	1772223421; bh=Ctr1AZADpP7yYAZ6xgrVN26SphNQyQeXfrv1YlHOcJw=; b=h
	3CfDsJ6GxoAokwpc55YV8D9BO5bbC5VTYvSO34K1dmykuXTi7hQ3jd0j8yBZF9oq
	bvvzMsdBPjTOXLM6JefeJgK8jZV7kBkqjHeQ0bHvoBidLhq6CgcIdrP6i/CGFakz
	Lb44vFbduk6PvuRBEtfEkhb7YRJxRlETsG2RFklrsOGyN1slGbedbFmY5CFMcQdl
	t3bUQog0MjLy3a76FYe1gezlWtrJRRKp4tYHq25i7OnDNs0xtPSAkMptj3rWklnS
	t6nXSxnFvViVui1P6zx5h8IBx0f2QT3MZPuEEhib80tldEB/FD+J5yhRXmhtYHoe
	sp3FPZQskGVglYI460DKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772137021; x=1772223421; bh=C
	tr1AZADpP7yYAZ6xgrVN26SphNQyQeXfrv1YlHOcJw=; b=M9PdBx46UA+8vOUE6
	RQzo4LmBcOn3hz++qJTWdPwqR9yBxMbLfTdxdDj+KlIrQgnOcuwrst4yzrYqJjjh
	OJeyW3U+kzgwehW+SqEAXztTAhxi6PEF6wiIINop/jE3vsw1YLaZcO2r0aB1xj0d
	51+u1f/vmvRdlAEgjOs2aRc8+X0Ry3c5mDk4L4gu6hujFcaxOYiZcm/HLPadyMqK
	el1DPJOLdaJZh5Q60vGAwQb5LRHX2zNyAcL4hAnlyi9rjZh4HFDuwRN8QXG9m/71
	ZD8cP8VnPkI9AM00XODrF+JDGzLO8yhIKtFfhK+DqcaDmK7Z7VNICtLfWwOu7zeq
	ksPEw==
X-ME-Sender: <xms:PKqgadSqO6V8rjVHz_2W8dl8QaL820QW0kDehTjYpgPLjdRfYZ1bFg>
    <xme:PKqgaXOn_Hxpc4O8hXjPxeTN4gbIlznmNmAOqqVyOl5dSY5w5KcSyZeWMknH6EnXB
    9ipqGrOYWgYAh8Y_idRPOPtZil6y_rncGmQly28Zs39NjeOaWrn-bI>
X-ME-Received: <xmr:PKqgaSkO7K7axIGAL0EEbCPgkiaIXDcBTJuP1LlDtGVwWDWxdZh836PJTVjOcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:PKqgaRatmIH0KGHtRD0nwSDTWvhgwa-Vfua69dxv2iFQII4_OJekxg>
    <xmx:PaqgaQSBdhj1g2JEQcTpxtAYLe1sv5Ake6Mm_hJXWfAKwkIg9CSXzA>
    <xmx:PaqgaTXmwf1xJ2hWlI8XX6bq2RVaVFglPcWles3YMqD4NUMCDeTupA>
    <xmx:PaqgaXYqkIN-o9abC_FY2CqXF8caiTDSQ7Zyae09g1CgrPuuAWsN0w>
    <xmx:PaqgaVp-oTq6D7LAh2ObP3-K-gaZzP7efL534s2LgS1vDSDGT7ql4NXB>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:17:00 -0500 (EST)
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
Subject: [PATCH net-next v2 08/12] udp: Validate UDP length in udp_gro_receive
Date: Thu, 26 Feb 2026 22:15:56 +0200
Message-ID: <20260226201600.222044-9-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226201600.222044-1-alice.kernel@fastmail.im>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-261576-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,isovalent.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 3CB5E1AEFD2
X-Rspamd-Action: no action

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
index 780df257a8d9..5d9de8998867 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -706,12 +706,8 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
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
 
@@ -781,8 +777,14 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
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
2.52.0


