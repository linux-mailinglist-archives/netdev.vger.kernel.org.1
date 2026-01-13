Return-Path: <netdev+bounces-249593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F7BD1B659
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4FF3047961
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D037332EB3;
	Tue, 13 Jan 2026 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="F5zVmqgD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ppghVhTo"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7832B9A2
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339670; cv=none; b=VzJ7IjsZ61+mOxHUUIfMbo8//8IJ+4L7zNmsHqpNgSbwjDxQk+idm4oNBfdqrnrFD6ELtz3YNIbFIiyu0TM10VweGlEsd141O3pElBCuZl09z0h7456AwGz8XvAc5oSzxuso8zCTvZpfCby0Rw/UW1SR7nQx7L9sSyZbgL/BBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339670; c=relaxed/simple;
	bh=onLy8rh0Sxzq+on4nQlM7E1vkIm2/fx4ObviXrPUnMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYNuxsc5Dsj61wDG1N4on4wZc6RKJSRMPLF8PrGz/LaMgVSjBRiBuiQAuu2eDgQOR+RJpLQR3W7pcULp899vwVMxYcENkBN6H0ExITUUCocQejMFbMXi8dV6xvigb3V68ZdBVWXumCP10ypD6rMHdd1ZR+GVudEKhUt3X72uJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=F5zVmqgD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ppghVhTo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAFE714000FB;
	Tue, 13 Jan 2026 16:27:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 16:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339664; x=
	1768426064; bh=97rZN3zfyP+9HyJaaXJWBdlSFYbE1XZFkkSX0/ke+ik=; b=F
	5zVmqgDLXky59l0jXW6rEt7pw29WtzRvYa2OPpvDZSEIZ/qvlRGF77LirqRvswoR
	iQJZpyKNqyk6X78jTsXHI20DogvFgig7H/vk3yDlcM4tviHioiDlslbA+9wU+OJx
	CPotmnGdSHxB7dr2Z8oksL3y0iF676eoREsrz/V8Lrhk5PffSLB3adm0JgIxUtCx
	iJfJKgaEcv9piaqJI1CCIXBQt+YR3qepZKsu8f0apoCQb6hlmpivqpKrJ0qSWeL6
	6nmsB9HEiSOHr0XAbPnRWSRheyThP064i20yjaydEnEtHh8LcC3nXxQ8Yeu5iGwN
	dgWCyk5pHHos08W7dte/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339664; x=1768426064; bh=9
	7rZN3zfyP+9HyJaaXJWBdlSFYbE1XZFkkSX0/ke+ik=; b=ppghVhToH7qC7DOI5
	d12+fQKtgntXcmQYSawlKVvDFfEQJ+91hAPhjmLQUm0J018rNOT0QEIt80ifOk4G
	2XBND7XohWdp+R+Lti1oCALpyDWn4klNpw2m6cAtwxBDGZuYPbkL+89YBHQO+fMQ
	fPwAmYvaBnqSlW5F4/EMdzPDTo/YkCDSEpBdbm6mJPITSwMLNz6E7R0rYI/86m8b
	TJL2vivvE0Q5amB7grcAmAsSQfbZZzmm2IPZ7radPmk5vGLNd+bHzRRg/MY97w4x
	j77nZjZ3Vw5IXq4MRIDlIGelIIZyH1LasX1MhylHnY9ZiPZyWBrrQm0Xr58z6DNx
	xVpvg==
X-ME-Sender: <xms:0LhmaYAcwIZ-PVIfmdiLZrLzkolzQJv0AElLJif4R-yrsTLssAFzLA>
    <xme:0LhmaQ6h0ZEj7MV3BGsZ_kdRoBFhN7SrVm9zO7FK20rjEFir_16YyGLC2uoDMJx4A
    mqcGrLVIntR7Eyj4Bxm3oJ4xhOli7KQuQG91HObyispL3srOXKrCw>
X-ME-Received: <xmr:0LhmaX1IzIaadVZPjTvlvuzqiRyytR1Xz0oD91e_zGSbgxwFVR3tIXS_IcJe9nt2rAW16IZi8GEZNA1LU7HYKZ9l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:0LhmacnKxIy6OeT4qyM0cZVmnyp77XEJszJAQXaUcFDJGU4uavxjdA>
    <xmx:0LhmaV74MJa1aB9jE-U8vp4l-l4HEV6-HmnG_XalGoV3vt5f1FpovQ>
    <xmx:0Lhmafl_UHqyDtI8wviAHbkp9RP7H1W4kmPcCDJ-mNLfBqHr1zyFeQ>
    <xmx:0LhmaQUWusjhsrDiK8-MD5-Wk4W1X4TMw0aBj3U9rjwTev1ieH1H0A>
    <xmx:0LhmaS9avmweTx9dhyCXM7_eVjuPaw78h3CIYAHwkQhe1302vVNHB9jj>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:44 -0500 (EST)
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
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v2 03/11] net/ipv6: Drop HBH for BIG TCP on RX side
Date: Tue, 13 Jan 2026 23:26:47 +0200
Message-ID: <20260113212655.116122-4-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113212655.116122-1-alice.kernel@fastmail.im>
References: <20260113212655.116122-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Complementary to the previous commit, stop inserting HBH when building
BIG TCP GRO SKBs.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/core/gro.c         |  2 --
 net/ipv6/ip6_offload.c | 28 +---------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 76f9c3712422..b95df1d85946 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -115,8 +115,6 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 	if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
 		if (NAPI_GRO_CB(skb)->proto != IPPROTO_TCP ||
-		    (p->protocol == htons(ETH_P_IPV6) &&
-		     skb_headroom(p) < sizeof(struct hop_jumbo_hdr)) ||
 		    p->encapsulation)
 			return -E2BIG;
 	}
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 6762ce7909c8..e5861089cc80 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -342,40 +342,14 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 	const struct net_offload *ops;
 	struct ipv6hdr *iph;
 	int err = -ENOSYS;
-	u32 payload_len;
 
 	if (skb->encapsulation) {
 		skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IPV6));
 		skb_set_inner_network_header(skb, nhoff);
 	}
 
-	payload_len = skb->len - nhoff - sizeof(*iph);
-	if (unlikely(payload_len > IPV6_MAXPLEN)) {
-		struct hop_jumbo_hdr *hop_jumbo;
-		int hoplen = sizeof(*hop_jumbo);
-
-		/* Move network header left */
-		memmove(skb_mac_header(skb) - hoplen, skb_mac_header(skb),
-			skb->transport_header - skb->mac_header);
-		skb->data -= hoplen;
-		skb->len += hoplen;
-		skb->mac_header -= hoplen;
-		skb->network_header -= hoplen;
-		iph = (struct ipv6hdr *)(skb->data + nhoff);
-		hop_jumbo = (struct hop_jumbo_hdr *)(iph + 1);
-
-		/* Build hop-by-hop options */
-		hop_jumbo->nexthdr = iph->nexthdr;
-		hop_jumbo->hdrlen = 0;
-		hop_jumbo->tlv_type = IPV6_TLV_JUMBO;
-		hop_jumbo->tlv_len = 4;
-		hop_jumbo->jumbo_payload_len = htonl(payload_len + hoplen);
-
-		iph->nexthdr = NEXTHDR_HOP;
-	}
-
 	iph = (struct ipv6hdr *)(skb->data + nhoff);
-	ipv6_set_payload_len(iph, payload_len);
+	ipv6_set_payload_len(iph, skb->len - nhoff - sizeof(*iph));
 
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-- 
2.52.0


