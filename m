Return-Path: <netdev+bounces-249592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8AD1B647
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 283F7300EBB5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD93322A1C;
	Tue, 13 Jan 2026 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="XB/MjNBD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sdCq0tQE"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA1318BBD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339669; cv=none; b=p2vevDgPd1I4h81aNpO98oj/ohtwhWMHxqjIDAy3xS3nexhRanIdo9qZsK8xTEFZnpiuckl6aPJslEIikBa65DV1cL22msQbMV6xg+1TLVm/N7I6DXCZepQILYqytYS1vCjSWvyZUiT9blZlRuOL73hlQKMxWgwZBaDlPaHAcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339669; c=relaxed/simple;
	bh=FZNgx+EpI3WCjYfJMww++RwKyMnNbdcaJ9yANsbOEYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRcPh5FYA1+1/CVWlB9OZRpXdfHqzwUbxoFjIiIZkhGG/WD9NDO1lITVPu6Pt5WsRWoreR+iPMVo+revpn5W3xu/rbZbslQs0ocQoTx9xY/cAHmo52TPN6HSCv67/LngeI6CfK4oXHabTbze57HxJjJXeWOGI/m7xYXsciWOIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=XB/MjNBD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sdCq0tQE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 358F01400101;
	Tue, 13 Jan 2026 16:27:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Jan 2026 16:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339667; x=
	1768426067; bh=5YOU4vvet8qOMF3C3P9viD/I44Qq2mepKlAqNgEm9A0=; b=X
	B/MjNBDe98UWYYHo3OjRjpZsmipl5lZO6aFS7Eu3FRj/2GPz3AjdxW/ndlKNcaJo
	5BpaKn7TZKVCQefIMwi/7f9SfkGCezg7q2SycGM5cwTP/a84Kz+bWlGTDrXLDaQR
	lmU2zd0w34xhhFdWHtPteEi7H+NJOlUuUCRzIrhqkMCvkr3Ufb0wGRnGZ1brrBJV
	rqkJG8yHUmw/a2TX4l3cmPTOQkv0knrLAR7ygra0KTjYj3gNo+xLy1OnLB9ap15J
	s+HX8FGvByOaKvYqmkXdrP//DsbF5lQYTuE2o+4+CveriV5lMocwU/KUcGkBj0mB
	G3gHeAcISa6TLD+d9jl4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339667; x=1768426067; bh=5
	YOU4vvet8qOMF3C3P9viD/I44Qq2mepKlAqNgEm9A0=; b=sdCq0tQEUxZpe9pGk
	LaX5XWyeY6VTJnrIF2in0Wx3JHLB71ViX2TQAN3uG0Es7gT0YM9lFW/Pl1/hMzXm
	t1lVRFWgW6XGImQ4+l6pl9gZggv733GCvr/EtCEMtqrXOArah+3LXPC1wORvuB6U
	nKSdVmQ40+YZpjkcuC9hFg+aRwUdDWUzkCYHwK9KTTNwB21Ksy8l7WakbZWw0H5+
	apn3eoqkcS5xAaGASmWqB2MC5WX6C3Z0tbCluHeow5rKywrDauFrddTqXktkyTgZ
	PDn5fXRikv7wNtPfzkfemLZAy+TR4ovi5lczY6LsSfcAA183x5kt/aH8NPK5VaIu
	sup8A==
X-ME-Sender: <xms:0rhmabBSyqFcYFTgneS4B4fLG7JHpGvkpjgmjZmb_tNYhZRO_xDmmw>
    <xme:0rhmaX7TGdbv3fCSybs7ksNmaUMkq2UGdP-EM3UamN1GesrCKqyREdzeuoeRhrXOx
    ihNr8Tg1YIcy1HM-Ef_hCVvLycnagEKKkBrNMEUMSCiVVkP9qXv3uw>
X-ME-Received: <xmr:0rhmaS1iGhb-9JUWQdca5tJjOkB5VP3QMwskGAc_odX0-9X_WDIEop2MBngBtiz8Rq_2f7PxdV3Wx78FAaif4kGW>
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
X-ME-Proxy: <xmx:0rhmabnaWQoUWkubVsg5SsHpeqy6Wf7_VeOUxLUFrO0cURdJMiC2hA>
    <xmx:0rhmaY5hOsyp5f8C5Hskn_0G7GWNnoZ51aSaLKFmfUD8WG_oZ9VqEg>
    <xmx:0rhmaWlpE4kr1Yn9RfVERqBSE1aQ8kWfWaIWcVrYTQxV1qXogaDRnw>
    <xmx:0rhmabUasoLNGc_gA78KbWEv3xn2KN8GbrXZLUQGbmaYnaCfSUwg5w>
    <xmx:07hmaZ9ZnUIQKFdoHWeB-27BWBpHiS-zzamgmPrKaaGZUjSLBcUJy7ad>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:46 -0500 (EST)
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
Subject: [PATCH net-next v2 04/11] net/ipv6: Remove jumbo_remove step from TX path
Date: Tue, 13 Jan 2026 23:26:48 +0200
Message-ID: <20260113212655.116122-5-alice.kernel@fastmail.im>
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
unnecessary steps from the GSO TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/core/dev.c         | 6 ++----
 net/ipv6/ip6_offload.c | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c711da335510..fb142613ce1a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3800,8 +3800,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
 	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
 	    skb_transport_header_was_set(skb) &&
-	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-	    !ipv6_has_hopopt_jumbo(skb))
+	    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3904,8 +3903,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-		    !ipv6_has_hopopt_jumbo(skb))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index e5861089cc80..3252a9c2ad58 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -110,7 +110,7 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct ipv6hdr *ipv6h;
 	const struct net_offload *ops;
-	int proto, err;
+	int proto;
 	struct frag_hdr *fptr;
 	unsigned int payload_len;
 	u8 *prevhdr;
@@ -120,9 +120,6 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
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


