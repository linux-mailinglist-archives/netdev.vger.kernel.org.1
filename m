Return-Path: <netdev+bounces-249597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D4D1B64D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D9FA300EBB5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B2325700;
	Tue, 13 Jan 2026 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Rxt/necM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kdP0JOks"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF637337105
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339680; cv=none; b=L3CHCVeh9gMu+Qi+3wdwtHqNVvX4W+cE50fXp8a97h7VRLaveqLaLri+4ZhVzAK7wIuIJVQYjCo4Nm0MGyYmEsyi+/aGHVZD+hKTd7SOJs4Z4QH17A35kke6mneFRGH4fP5bo3biICl8jW4EvW9MEmQSR8jb3TazOJcRwo1N9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339680; c=relaxed/simple;
	bh=M7Hs3XpqH+QCCszgGjd4sNZHnuzd6nNGGc/4hEr6TDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORrg+dJMQm30iTixG1FvuPFeXmdugAC9eDPOr+j7VTI/xEkvF8AYw/iRoZB1cySaJekJZcxidaZQ8KHepitRTHzRMnjPeGhlAHF5Z99jAXX79hRkcTHpJOaHhD7l+MWWWlHvwkI72MlxXwkZvcSbPI3HtgT/hGSp9FhFXPV+LyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Rxt/necM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kdP0JOks; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC8E01400105;
	Tue, 13 Jan 2026 16:27:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 16:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339675; x=
	1768426075; bh=mcaD8LgMxov6CF0CoahA/TGFox6zqbx35UGP7ooQ3IU=; b=R
	xt/necMDO2wYmyzwB1PdEp1ohSCIfpLt+WPmxDqW1gDebDy4SrOyGIEp7sX6jVlh
	okgTVn3tknU49jdVt8QMIs4H/HgpujUQr4ADRK29+ANyO3Plob6kPOtoVpu5Oekd
	PMeE1GJkD9i16wnbts+dHnnnR75831AjtAhb9VhIg1ipzHzY11OfpUgrsBZy3RxG
	iI06iuGJ1D2mb1+Vv/78ETdHYCelkgTeoz36D2lQGAirQW4jJVTnkbLfK97DbBVq
	cDR+QzMrlGt6/r7zB5E/4/qmIYCKbsKQUfbUfTz0P4IXppD9bvUtF42EXTEtg/QU
	5D6rXAsejppKNiHULlHDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339675; x=1768426075; bh=m
	caD8LgMxov6CF0CoahA/TGFox6zqbx35UGP7ooQ3IU=; b=kdP0JOksJC8qptf8g
	OF/Sg+7lJxocAXQMGiMSieEFBynzY0lUxFAO5eBW/mIvZqNE9qkFfuDg6YGziZlU
	2F/Kb+Pjz2CpOndAG47mrhNdsayPZbHvL6xrX+zw+UU+wY8KLbDDu5YtAX9rDnas
	dtpWycqn3X5sE145MIGY+umSsS9QUIj12ePnQBDdXCIdj0H+D0aBxAm7+uoNOr8m
	XeFINCMY0UbDCEfchlBehWvtmCTaac1x0eOzFc21b+yRbR4gkXc5fggyfdLwYJ19
	0US+0egk6xQ/gVlk2dXICn0brL7k5w6SR9O2tU7BgIv40KxAt3mWXJBrMW0jBwgU
	QEKeA==
X-ME-Sender: <xms:27hmaZ-prU15nt-uHxsnnJ3pJuLhIYmo8WHpcpXpr9NRtGKZEEXSlA>
    <xme:27hmaUGRVKxTrDW_x-D1_z9XCVu75wIUpa3F3bAsFaJHxR9tW_B4RSJObKthGjudR
    -aZnBxYgPpMIPMWOyJoeZogVP_dmX1lFq8OJlGf5fxof_y3huvoDQ>
X-ME-Received: <xmr:27hmaTRgXh1oLp5NLTrvexFyGc_1gxMAPznkbdUB8Wsd8vAdTyytEJhC74XK18bxPoEb3cQq4z8UEvDI0NkUFpA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:27hmabRN-3jHLHx5XXbOl6qlH34c9T1qCNtaLZ_q6hsLMlRJ4HqsBg>
    <xmx:27hmaW3YqZ100KRXbeCVlOORNfEF61Y6I9m3j-gIR2uVPVwIgxcUZA>
    <xmx:27hmaVxg6dH661f_M5zQfqFn0CPJDBwaG-AF88KOYHh90M0wXtAKEQ>
    <xmx:27hmaSySriMHSBWL8a3PqAfX7qWxDU6sse26vySDMHYMy1Tinum5Gw>
    <xmx:27hmaXLX-peXJ3Uprm9COXeuEL4xdG7UR7I8SkOM-Mkm-Ac4sUtAwqJ4>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:55 -0500 (EST)
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
Subject: [PATCH net-next v2 08/11] bnxt_en: Remove jumbo_remove step from TX path
Date: Tue, 13 Jan 2026 23:26:52 +0200
Message-ID: <20260113212655.116122-9-alice.kernel@fastmail.im>
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

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the bnxt_en TX path, that used to check and
remove HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index cb78614d4108..6a143dc6cb09 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -517,9 +517,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_free;
-
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -13852,7 +13849,6 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 			      u8 **nextp)
 {
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)(skb->data + nw_off);
-	struct hop_jumbo_hdr *jhdr;
 	int hdr_count = 0;
 	u8 *nexthdr;
 	int start;
@@ -13881,24 +13877,7 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 		if (hdrlen > 64)
 			return false;
 
-		/* The ext header may be a hop-by-hop header inserted for
-		 * big TCP purposes. This will be removed before sending
-		 * from NIC, so do not count it.
-		 */
-		if (*nexthdr == NEXTHDR_HOP) {
-			if (likely(skb->len <= GRO_LEGACY_MAX_SIZE))
-				goto increment_hdr;
-
-			jhdr = (struct hop_jumbo_hdr *)hp;
-			if (jhdr->tlv_type != IPV6_TLV_JUMBO || jhdr->hdrlen != 0 ||
-			    jhdr->nexthdr != IPPROTO_TCP)
-				goto increment_hdr;
-
-			goto next_hdr;
-		}
-increment_hdr:
 		hdr_count++;
-next_hdr:
 		nexthdr = &hp->nexthdr;
 		start += hdrlen;
 	}
-- 
2.52.0


