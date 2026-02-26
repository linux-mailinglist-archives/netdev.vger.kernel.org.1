Return-Path: <netdev+bounces-261575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BDGI1eqoGlGlgQAu9opvQ
	(envelope-from <netdev+bounces-261575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:17:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D91AEFEF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59789301A7F0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587A42B74A;
	Thu, 26 Feb 2026 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="JmCVLZPl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQdss3s+"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6344A739
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137020; cv=none; b=cmikxH/zg4CxxwrSgpXqn22oRQ0jlaE6lIrA0oO4yfeMEAkz4x3ycKUFdpioZ3J3XLvKYBlzSnzeUun0YDzr89kTAIzd2T+6xI+VLYYwWVngzNVf6xn0BrgYlHCSdHF1cp5tz25L2w2vzXwkBaUq3FXDoCkRHqKOLtYyQaKkrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137020; c=relaxed/simple;
	bh=U8IRZYRyFOIsErSX8tuqE9E6V/KWIlqLuhX8Ne9Tqog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzgoJyu5FY939zmlr86yNAV/AbIXLS6PgWPTKu7Np/s5646WPeShHJmEHNM3fDUjldZQj50WJAHO1CwaQQZczc9IAEnoCZXax9gd2kImAEXUH7VPazDeT5WmKuw4xPQ7s7nFrkH4u17ljuYH3YiEKG6At7D3hgrtbSvYobQa0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=JmCVLZPl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sQdss3s+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 001867A019E;
	Thu, 26 Feb 2026 15:16:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 26 Feb 2026 15:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772137017; x=
	1772223417; bh=ITvoeK0erDKFOAGW64Mad0+sofs8RTwkyYSlolaxdZk=; b=J
	mCVLZPl2DuZcvYHhz0urmnUnLANhjSfcVABqKLI4Aa8mL2kKJlQOoMfKBsfHd5J4
	KfoGegrC1KQ8Xj3UQFLOTU63IFLvj/mQBU22qbqKnaeoWnDUbNc8Hkdf0duJtvu6
	GqPCMhMD2HbNywlhbM9+yafKXiI89YKIOddP1O6E70YIvw+aBrYvfwn9rhBOh4O1
	BeSti00Fg0va92Swzs0obczNgRsgDKl434cYjTmvv/N9NY7rE6T9QZncSc3o/w94
	zNKA+OWMSgGNoVqBn2/sEeEFUCNRTr5B9L309LvWM52pEiDHHxWoAHfdqP6rHhhJ
	K2kesnEp/Lz1UBBZUuLog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772137017; x=1772223417; bh=I
	TvoeK0erDKFOAGW64Mad0+sofs8RTwkyYSlolaxdZk=; b=sQdss3s+OrWTdOGt1
	9WV1dl4fVFkLHOLh8vnArZhh1ybZ2KUxij9F+AHQ+5wp01V7mZm97rM+DkL7LVHj
	82kPeb08db8+TF0380aTIvkYDId2x6wNvl2dT69wfeDLfG6zPH6V0KLnsU/PhCap
	qOKVrRwk6vbi6VPzZYBhpW0q/Ek1hUJKMLO66O1ws3rKLc7Widn9Tvr+n/HPRAH8
	nXxx+6j8yTFsYDpENnnlGqlwhhnL49QlSlwonLWfh4k43UbQl+IeLJUTKhLINk5P
	zN19EdP7XPzaZsvo+YgTGJEvnAH4Kiqxz9PcXafTkdlD29HCeZbCMJdXwqnHWh/A
	d1vrQ==
X-ME-Sender: <xms:OaqgaTyLery2YxVF2JRPN3F5YttcEvPF5eItvSVssiLWKtqGUpiijg>
    <xme:OaqgabujP_AG4Nye8SUGuRWmmis-h3e_ois7Amprrx8uVoSg2PSteueqlg3hQdkU5
    lSEm21BETRuFbeDw_TmdLwoJHoEMd8mvZ7Fmu89wp_Q7FCVYStY7-v_>
X-ME-Received: <xmr:OaqgadEoevMhR6S5bvqagotbAeNr6c8GcPo-SHmTcUPhKAyj84ibkg581Tw3RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:OaqgaZ727KAKLVtVmv_of3rWNxk0M_P_Ky6nttRy_R4siS7_Ryv0Xg>
    <xmx:Oaqgaez_yeKqx2ujO_oR25_yQ5fMA_u603bLrKjsZVgOKsfyy9lTaA>
    <xmx:Oaqgaf1eM1XXyRmheafeJa3yMQKYOv03ZMP8yQ_Cb7-jOMif20xsVw>
    <xmx:OaqgaZ5HxHm7j-peS9rG5fWTz2MaiEqdHUNBO3yLxVc2mF7i72Gyrg>
    <xmx:OaqgaQJEoA-MYozewG0cRwgNzf_blMrPi41yWPWzVWUMSj96SV4VEGpf>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:16:57 -0500 (EST)
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
Subject: [PATCH net-next v2 07/12] udp: Support BIG TCP GSO packets where they can occur
Date: Thu, 26 Feb 2026 22:15:55 +0200
Message-ID: <20260226201600.222044-8-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-261575-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,isovalent.com:email,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 325D91AEFEF
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Wherever a GSO packet can occur, and its length is used to fill the UDP
header, use udp_set_len that assigns 0 if the length doesn't fit 16
bits, so that the packet can be properly parsed and segmented later,
instead of having truncated length.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/ipv4/fou_core.c                    | 2 +-
 net/ipv6/fou6.c                        | 2 +-
 net/netfilter/ipvs/ip_vs_xmit.c        | 2 +-
 net/netfilter/nf_conntrack_proto_udp.c | 4 +++-
 net/netfilter/nf_nat_helper.c          | 2 +-
 net/psp/psp_main.c                     | 2 +-
 6 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 7aeb6efbfc44..d934860e1f34 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -1043,7 +1043,7 @@ static void fou_build_udp(struct sk_buff *skb, struct ip_tunnel_encap *e,
 
 	uh->dest = e->dport;
 	uh->source = sport;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 	udp_set_csum(!(e->flags & TUNNEL_ENCAP_FLAG_CSUM), skb,
 		     fl4->saddr, fl4->daddr, skb->len);
 
diff --git a/net/ipv6/fou6.c b/net/ipv6/fou6.c
index abcf23500299..3c79fe8aba1b 100644
--- a/net/ipv6/fou6.c
+++ b/net/ipv6/fou6.c
@@ -30,7 +30,7 @@ static void fou6_build_udp(struct sk_buff *skb, struct ip_tunnel_encap *e,
 
 	uh->dest = e->dport;
 	uh->source = sport;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 	udp6_set_csum(!(e->flags & TUNNEL_ENCAP_FLAG_CSUM6), skb,
 		      &fl6->saddr, &fl6->daddr, skb->len);
 
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index b460998e348e..08b0b5bfe4ec 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1089,7 +1089,7 @@ ipvs_gue_encap(struct net *net, struct sk_buff *skb,
 	dport = cp->dest->tun_port;
 	udph->dest = dport;
 	udph->source = sport;
-	udp_set_len_short(udph, skb->len);
+	udp_set_len(udph, skb->len);
 	udph->check = 0;
 
 	*next_protocol = IPPROTO_UDP;
diff --git a/net/netfilter/nf_conntrack_proto_udp.c b/net/netfilter/nf_conntrack_proto_udp.c
index e9bd1632304f..ca7d259ded8b 100644
--- a/net/netfilter/nf_conntrack_proto_udp.c
+++ b/net/netfilter/nf_conntrack_proto_udp.c
@@ -45,9 +45,11 @@ static bool udp_validate_len(struct sk_buff *skb,
 			     const struct udphdr *hdr,
 			     unsigned int dataoff)
 {
-	unsigned int udplen = udp_get_len_short(hdr);
+	unsigned int udplen = ntohs(hdr->len);
 	unsigned int skblen = skb->len - dataoff;
 
+	if (!udplen && skblen >= GRO_LEGACY_MAX_SIZE)
+		return true;
 	if (udplen > skblen || udplen < sizeof(*hdr))
 		return false;
 	return true;
diff --git a/net/netfilter/nf_nat_helper.c b/net/netfilter/nf_nat_helper.c
index 3853f41db499..ec34a2f4baa8 100644
--- a/net/netfilter/nf_nat_helper.c
+++ b/net/netfilter/nf_nat_helper.c
@@ -161,7 +161,7 @@ nf_nat_mangle_udp_packet(struct sk_buff *skb,
 
 	/* update the length of the UDP packet */
 	datalen = skb->len - protoff;
-	udp_set_len_short(udph, datalen);
+	udp_set_len(udph, datalen);
 
 	/* fix udp checksum if udp checksum was previously calculated */
 	if (!udph->check && skb->ip_summed != CHECKSUM_PARTIAL)
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 2415b75a2a12..c9c60cb69daa 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -207,7 +207,7 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
 	}
 	uh->check = 0;
-	udp_set_len_short(uh, udp_len);
+	udp_set_len(uh, udp_len);
 
 	psph->nexthdr = IPPROTO_TCP;
 	psph->hdrlen = PSP_HDRLEN_NOOPT;
-- 
2.52.0


