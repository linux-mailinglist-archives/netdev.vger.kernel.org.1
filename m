Return-Path: <netdev+bounces-261569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MN9KQaroGlGlgQAu9opvQ
	(envelope-from <netdev+bounces-261569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:20:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963E1AF018
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6343E30179E4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF56E42885D;
	Thu, 26 Feb 2026 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="TB/XwVnX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uyrkjxhF"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C139A7EB
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137001; cv=none; b=MOYqqiY9/NKQPHepa8HxhN/hMHTb7IltVeu54LVWVdfPz6lU6cMrnK8IIm6OqQyO3w804x+4GtDQotnGniDVruYTjibEGXtV7/JnuU/B2d0W32hGKbwSLa7gVGiL/1FXqOWZ3l5/Ctcokpa3quCA0P1tuIjJW5ySpELNDO/6OYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137001; c=relaxed/simple;
	bh=xD25iUAw+xHZAtpSgefvXzmnvOHmzOjAN/kR5DH6kOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnIxeOxMeP++d6F6+6XpTh3rgVgFTMP8eV856wZqlk5NLHdgGe89fSViCdfhYK1Xb9gTVAvjuP1/D8erJ7eMyaVX4r2MEsTbBkMwFTT0CKUOEAZfl1gjJj9CugS8zGP+vxMeL75Eq9F6HzZp9NfN3s/3/j3yBzOsqPDm/C3fptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=TB/XwVnX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uyrkjxhF; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 084DB7A00D9;
	Thu, 26 Feb 2026 15:16:39 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 15:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772136998; x=
	1772223398; bh=/1cau5cZS/yX7mwjl9ZEJw87J8noORr5NPZ/yN4JaTE=; b=T
	B/XwVnXQ2uWYCHeEmdXy03uPCzRlV8U1GGimT7tuS+MDnDo/LadhyAH7M3N945Dg
	BIyYSzBEEMeRthr1HLn2EBGvk9nMBf8fEi5cchSUzLkLUzSVjVTyYgwoLiF30h0e
	q8p/kJWh2xKTNr5ZrfsOChiQQkUy6pTB6Px5HXvcm2teHw478XLlkHVOj9eoUt/L
	4KPPC8jeyZEIAAxXW9vmTmKIiUzuKZok9h0WZsdp7Zv4oRU3XwMH5EHzdPwBoDSA
	cO9GlDsdeln/i6aMIIuQ32vhmYrUvY1Im5EWTFPUVVxBi/947kdcu3F5iiAp0ls5
	ubkdOza2+CIF/hrmMtfng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772136998; x=1772223398; bh=/
	1cau5cZS/yX7mwjl9ZEJw87J8noORr5NPZ/yN4JaTE=; b=uyrkjxhFl9eyZ2F/9
	9PYcnPyOW842rqscFc3Cbf00aHZLFJJnFjBGOV9fK4REUVmxbaLVcrem3goC7Rl4
	1I79VhCGsBJAlObskoktu5XPAktm0OGssi0NThhO1yjcRPQStsxIW3paQmNJmy0Q
	DCRyDIl+9tqQugWHhDFfacY2zMXDNwjhVUpdiyz6olS+zeiWnqD7cgYLbZoLeQJa
	Mv2VBmdfT+B6ZntthB20jz78NRdvJOTY0Gs/bnmiV1Fe2M4BBBNaAfbODpJT7VE6
	UXQF/AVvjF/bHXhQi3yN+lhjv0ZTBvFQCCUSJyR6mocBBOnssFocopiasBmpI+XK
	8My2g==
X-ME-Sender: <xms:JqqgaSkb-BABAgvqcgnF_lbaErEVHW3fF5Dl7kgtk0ZOAnICvhBwtQ>
    <xme:JqqgaaTZgO21ajUyTM8ho_Wa5Qm3xdy0W86U_I_WWZM8NU7NTD76pqdCCUtHoLcU4
    pC6JHfwjMgNKsXyEcrOGw8FKJLP6zx-FtQuQlk-5xzWH5pm6D9Efw>
X-ME-Received: <xmr:JqqgaQZzeR9zAxKZEjqmGtLkwXnhmh-rEkS1zVOl_r3yOQnUukEHr86spdtLkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:JqqgaS8tJxgh-xxXRWXPjUjORNCX6XReqPKURhPUjpRM3QrsbEImVQ>
    <xmx:JqqgaamBRf8jlXjuB9gEvTsnHRZXTHf4hhVODxZJMSJmIMVLn_J9xg>
    <xmx:JqqgaXZqlewW4HvucKZXRCarx2FyiP5t0invomdfkI8BSxhjTy4jIw>
    <xmx:JqqgaSPgXYbiS-5f5JfH2VYGB4X6LS5yyaalAMZTqGy-ghRYxan74w>
    <xmx:JqqgaZfH7LGf56XmlN-Myd2KNvayoprFqLJM09AbjP3F1FX-Z3MErgKa>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:16:38 -0500 (EST)
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
Subject: [PATCH net-next v2 01/12] net/sched: act_csum: don't mangle UDP tunnel GSO packets
Date: Thu, 26 Feb 2026 22:15:49 +0200
Message-ID: <20260226201600.222044-2-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-261569-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,isovalent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 0963E1AF018
X-Rspamd-Action: no action

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
---
 net/sched/act_csum.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 213e1ce9d2da..a5cc76613f32 100644
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
2.52.0


