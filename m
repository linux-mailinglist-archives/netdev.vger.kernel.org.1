Return-Path: <netdev+bounces-257180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIInESSfhGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA6F37D0
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7944830A0615
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080E924503F;
	Thu,  5 Feb 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="o0EyePu/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AnXRCiBt"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F923BCED
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298811; cv=none; b=A0vn/YFwsak40Mi/KWJcOTaXMuBPCjWXb2VH3NESYH2L8oy+58FOdIsS2FfeIP+3dkbff0149FBE9u43LUaqp+Hrp0CDUr6LYV5NdMfI5x3d9G/LwsRhzOfnNoOSAvVPu8j0wjQm7mjGmf76eAz5lv1nRQx6sEbguYe4hO/fueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298811; c=relaxed/simple;
	bh=2rg6N0wCuCckIjjAqk72Fgd5bpa2ST062nAf1xdiscg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSUUoUtxzTrSBu+Frd0Z/0zXuUbu7jH4NSM5HxPZz6pQ6ogQDRM5bQWLrgp6JJsAmvpMocnmeQh16TJvyb15prVy85Br66SgnaWNn6cE6tBM0NwGvumAEgxlr7IywSfjbs2S9QgMN4hxh7ZrRxCWJoJEImmWVQbd/BzMBFAqfug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=o0EyePu/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AnXRCiBt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD92C7A016F;
	Thu,  5 Feb 2026 08:40:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 08:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770298810; x=
	1770385210; bh=LfBhDP+s4yhh8YWcwuOWOz8P9eriaIQoXEHpk0i1xyQ=; b=o
	0EyePu/b7w8juEVfRzLQK1AZAZCqQQS1FYHdDzPYauo0M9KXsZ9ZuzJm0E9ZxxAg
	EglDf9fywhDrHHBpe6WH/OodmHSD2le7+n7Wfh3SFvpemNFjIslhA/P+c07/r3uU
	xWwPTtEDIdHrYrQx+kawGeXWOyyodxKRWaMQeLUO1Nci8z1OHA4pWEYDTNnEOtVl
	laOwlP+M8goWEqGdEoqSrC5xJISBzbywxqRDGB7UIAoE7y/PJSzSXHGrh2/daFXz
	CjOMtVRUI7aOO7nCirkeSLa/mrcrm4WO3FGhUmb5vzgJSblcDp4edgcE86i6Km2u
	I2k1Rp6HBI74hcZTL0HHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770298810; x=1770385210; bh=L
	fBhDP+s4yhh8YWcwuOWOz8P9eriaIQoXEHpk0i1xyQ=; b=AnXRCiBtQUncTfSdV
	mDApJCzjf4ncVXQtfKTx4anUoSYnYQqqSJDAZLXbqQObuyZkVWIh8SYVYsgQRwLI
	ZR5nW7X1GCxft6EUFT2gtGyQ4EfnGsPzrX+RUHBDT01gVYzmAlOue5qyp67Ow84A
	SPod1Gf7brFN9C7cce4u8hOfsnFjeEBUX+vduljI1XiHtsMEMhP4f7LWC57RLfn9
	HmayEPeiqVYZ4n4r2pV87KP5b8zb3dpBMkUisyaXJAun9nq0ZDBjaPcAJvuDKb22
	+c/Zywnm+9/UPSSlHjCsnuzMU+KbqGoHIS/KJhEdYfyjmtiZTeJzBfTYdJ35OM8i
	PfB0A==
X-ME-Sender: <xms:up2EaeWLMqAMl0VWYQff2nqsBQdtA_wVtVei1BBar-eZJvn7y9RjYA>
    <xme:up2EaQhwQalFtEcsDyznfu6t45qG20GiivurBYQYQEZ8BuQnMTBfA2zqQM2Ix--6t
    ktLlnaBe6yNwR80yWIlNWXk1gK4Sy8EyMLwT46LWZmJYvH6bnRH8Rw>
X-ME-Received: <xmr:up2EafiCUXh0oYMxpmh7I4orQs81yjBluez5M4qd2wYyviHYGWgVIWEueCaZ3Bn1KxuESQ>
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
X-ME-Proxy: <xmx:up2EaWGe6duQSVgoLSmH__SZzO5Rb6pKYjU8WlkqbMO-NqX2JuGWTQ>
    <xmx:up2EaUDh2bMFoOWc-yXSs5em4dilR8NpxSaPhXYW9lj_ocXnKuy7dQ>
    <xmx:up2EaUBLEvUZ-KeMRqNDqrvp48nMweKiJIMWDpzGYgkkr0BbgKKqcQ>
    <xmx:up2EaaN9K0U2rljI0PhHTDMdtASvp0EsGZsOmnQWAhPxZxE3WERbaQ>
    <xmx:up2EaZEewpI2gPtixuFNAOoz4VpBPgj2PeutFaqb8C3WyhogbylM_Sgo>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:40:10 -0500 (EST)
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
Subject: [PATCH net-next v5 11/12] bng_en: Remove jumbo_remove step from TX path
Date: Thu,  5 Feb 2026 15:39:24 +0200
Message-ID: <20260205133925.526371-12-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-257180-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,isovalent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: 99CA6F37D0
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the bng_en TX path, that used to check and
remove HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index de26ef9b5641..a2616f037557 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1463,9 +1463,6 @@ netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_free;
-
 	last_frag = skb_shinfo(skb)->nr_frags;
 
 	txbd = &txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
-- 
2.52.0


