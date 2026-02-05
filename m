Return-Path: <netdev+bounces-257173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDDrCM+ehGkL4AMAu9opvQ
	(envelope-from <netdev+bounces-257173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:44:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACB4F37AB
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC6933079B82
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6DE23ABA7;
	Thu,  5 Feb 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="jGpzCdJV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dDo1BsQE"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF322FE0E
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298789; cv=none; b=p/RtA4+Fv8caj4NZpo8J2aL3uQQ8pxm0yEbcOqx0+twAu0+xSi6c4f5vThjn7nxMZts8YAgoknnUTJ4k6GiRFsqcVCb89qasulKiqKW/EbHcwookTtgViiiElpAyCJQcv5XtBfex/53xWSoRckVlbUic8DgaXXC74rtcL9+FhWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298789; c=relaxed/simple;
	bh=pCZ2C+kMHbXzK6Y2YjAqrnO0L2JdukaOFK3MX4dKZ9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+2owv66bjORWuFefs2NPwfFCtBwhoOopajNDIqHQKH3m0jIxtxmqJiQ0dajAJ1VgcedkEdLpFfF9gXufU0wBFuP+nqcoyaszsylBodJ5B3e+v0VoeCiVjO8POvYldOakRPXaYMLO2C4Ucw1Lyj9/oAR+Z5FROM+V7EwQydBC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=jGpzCdJV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dDo1BsQE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 926DD7A00D4;
	Thu,  5 Feb 2026 08:39:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Feb 2026 08:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770298788; x=
	1770385188; bh=2SS4qdV4seVZmo9WT1QHI3LHa2NO7Xe61ujySrFOKLw=; b=j
	GpzCdJVqEgwz66si58LNSi8oIWr/mWz3wwpoDfg7uVg2lYUzqQh5RFvRvcorgJvc
	J6uJluFsFVvHb1qFmDUeAnJk5PuDPa93QsouNdNyzpKRVow9R4GaGx6ZXi1Os8jL
	utM6qjOgJTuhJdkVmmc9EQmYKTxRIYV0cB6O1u37PP+S/MH0OSJ7H6uXsFxOm9//
	ENrlY2swnEXakrYLvkxTc8rnmszzlHoLg8afi6ncJdXlrnkHJNV4w29XE0uxdmtI
	s8p6TBMlK/vpNcTcEeal+9FBVaYfgl95YEkHkOHjCrAiaybJ5d6cnyah43Dn77qU
	Vg9QkN4lzcE0dGnbqn/6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770298788; x=1770385188; bh=2
	SS4qdV4seVZmo9WT1QHI3LHa2NO7Xe61ujySrFOKLw=; b=dDo1BsQEL8p4mF+UW
	OMwRGFLhuKUyQWK7FfkY8wDaLfzk/pnqgAsVFCXc2L/TIXeR5xOOiy3w0fceo3Cy
	GhS6I5CgDDJg83+oVitPAr5a4+MVhiN929MGg0SMBNjN0mFfP3CAjxMyVckPUz17
	SMt9DBmMTg9DeliFlJwRqoeUfvj9yDAGeOpq9LmHZEU3M+ovNGcvgaoOeKjyS3r4
	vHACa0y0HFAg+aaYPVoHyfxCQJoJjtvkym+u/7qvr8Rx89K1TE2y+aYQuqZ65DTJ
	SnzxeXZTPNBe+OFHPp8E659Cev4G9iKeUguSmCUaXIbiBHAMJW2hMt0x1C1T9529
	ErWrw==
X-ME-Sender: <xms:pJ2EaWfYsSWESUxegZtKUo7xZgT_pJ3UVT4CsC3pqzIS32KOro59Mw>
    <xme:pJ2EaWkshPiUlAG5qhIppqKivL6hwL9Qh8N_CdYfrg_9MiVybcOomZL2B3z0x9RBG
    WBrSLzvizlcExxHXZRi-n6Kf8JFk_HnbX9TN0rbCUxxtMXnEmvZieRZ>
X-ME-Received: <xmr:pJ2EaTxg6Qvry4sik-ayQkZrrWOIZmYDDLNnFw48VrQEWdazJfSXXv9i9dKfuL985lpMkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:pJ2EaRyBkeNCr6VuUpQ9eIKho0FVHmRJ_Bx-1jgwbN0R_PxanmDbYQ>
    <xmx:pJ2EabUrrYV-sxWkW0BfQfLHcrojiOEhk3EpQ0ecxlAbEhTp_XjEwg>
    <xmx:pJ2EaQSGhs7A8hByXX_UZZPHLu8nR7wj0NzVCSILS0zxlS8M6g1jvg>
    <xmx:pJ2EabSKTElNWabR5wgNQCKa8S79GQbbj0EYIJy2p9VBVaqRlPWKig>
    <xmx:pJ2EadAuEUmmzAnvP9qU06UiZKCIRsSN73GdELTUU-__2gV3hwg8R23T>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:39:47 -0500 (EST)
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
Subject: [PATCH net-next v5 04/12] net/ipv6: Remove jumbo_remove step from TX path
Date: Thu,  5 Feb 2026 15:39:17 +0200
Message-ID: <20260205133925.526371-5-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205133925.526371-1-alice.kernel@fastmail.im>
References: <20260205133925.526371-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-257173-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 7ACB4F37AB
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the GSO TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c         | 6 ++----
 net/ipv6/ip6_offload.c | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 43de5af0d6ec..ac6bcb2a0784 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3813,8 +3813,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
 	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
 	    skb_transport_header_was_set(skb) &&
-	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-	    !ipv6_has_hopopt_jumbo(skb))
+	    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3917,8 +3916,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-		    !ipv6_has_hopopt_jumbo(skb))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index c44bb5812484..bd7f780e37a5 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -94,7 +94,7 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct ipv6hdr *ipv6h;
 	const struct net_offload *ops;
-	int proto, err;
+	int proto;
 	struct frag_hdr *fptr;
 	unsigned int payload_len;
 	u8 *prevhdr;
@@ -104,9 +104,6 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
-	err = ipv6_hopopt_jumbo_remove(skb);
-	if (err)
-		return ERR_PTR(err);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.52.0


