Return-Path: <netdev+bounces-221736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 604ECB51B77
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F5018834F9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06043311C38;
	Wed, 10 Sep 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="S7i1w4vq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXtyLJvO"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726BE1B425C
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517744; cv=none; b=kaQTNX/HavmpN4bZVzgomgiuh5fTZ1OSuawftvZ/etmUUqfbNFDaSgNJJDzkH0vhlsssPgmh+xoqMywwp3gnPSsikElX/sPX7aNXMw92UnTZQYs1cL2AJd6WPtzn2a7JgX5FHO3Bws2AGm5AzfIlIzrZrnJ1/gsKLNYl7jAD1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517744; c=relaxed/simple;
	bh=ItPO/WxV8QBvBc2GR5va+RgVzppMNQcBc/Maz83EDB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ib57pYC4D0SVi59t8b6fct73R0Bycu7MHG6Kc4kFormhLV37t/VfQ6Bmim3HgIai+NYanIrgcbFPhd4bZJog/WvboRoXpO1p052lNuyBJPuxJkPnDsCjKH/qtVL9dy2PgBqKSFjV0h2SJiAlBRzuu1Hb+QJhXl2+zt9KXf9bHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=S7i1w4vq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dXtyLJvO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C2C81D00238;
	Wed, 10 Sep 2025 11:22:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Sep 2025 11:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1757517738; x=1757604138; bh=Ib8gmmQ7sH
	s8Tjit90kgoChYF+0C6tb0FiVRW/H64xs=; b=S7i1w4vqZDy5mlDSZ8iwtG3nky
	7z5uTU3LGZyLdeaCg/MUs+TNRPQeYq2jBWOtWlzVsKeeFQ1Rc4SibezTKCia8gBd
	vi3D/rCk/nKisRX12RGUi3954Xv+L/41/ylJda3YN1bG5oQvCNQSmCTCEMWbrUyu
	77IsQeGN3bEdVrbw/jOAoYb/O1rXjnyIDj2Wu2pusdbd+L/MwVisdvSeGApuW5mh
	55FgRtZtcDm8nL5MFmC4du8QEItIjV8yJ76Hc/uU+sTjj8WoNrggw2Y2tN7giWIs
	9X89ksVlA1VtVNVEXAcTc73H9I+0AlGxJQgQvMl6mpZHHliOfWI/9O6AMCLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757517738; x=1757604138; bh=Ib8gmmQ7sHs8Tjit90kgoChYF+0C6tb0FiV
	RW/H64xs=; b=dXtyLJvOtF34QkZDY9535B4LterxkOLF4oMHdK8UaRXVXYl0MDd
	h4kv4/r+6VcztRDvvCcwMk+IujzAwRtSQClqVA77q4JQBuFZpP6yyf6QlRVes5na
	oWOcAu/IFf4pUB5EOHG7Nd5ohrbZKlm3Fr3OBPxZu/uj9pQ2XsERsm6Rh6yvZPVj
	XtWDzhoQwa5kZs3M14QgTNzyFzWN6r9TCcLCC6urZiaiTfoy6CSrDTLDpX8VLv3o
	gS/kzEWDciiaUkCHbnKhoQ2LM4TFc+a835rfs2qn37ZPcRRwjL8iEwlJRP2O74ZG
	d9g+HJCW5J9B9ZXrIH9EmYoChGQ9USbRjdA==
X-ME-Sender: <xms:qZfBaLfP9oH-r9PPZOflNjurPse4aqDBlinJSl7rKkjd_I9N1KyvOw>
    <xme:qZfBaJo1LIymmCPtbaZwcKGbwKDNGjcz9DMN8r7fKIdSGUCD2XER2EquiRWka0n3A
    jYfoLjeSS7nHXtrHDA>
X-ME-Received: <xmr:qZfBaE-e4EAfFAR_6AOSK9l45IDUY2MbpjhznSxL4l_yp0HmfGQBJNzfwP2K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurggsrhhinhgrucff
    uhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeejtdeugfffkeejfeehkeeiiedvjeehvdduffevfeetueffheegteetvdfhffev
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsug
    esqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhrtghpthhtohep
    shhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtoh
    epgihmuhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhgvohhnrhhosehnvhhiughi
    rgdrtghomhdprhgtphhtthhopeihrghnjhhunhdriihhuheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:qZfBaNcwKEdmjNuDol-my6HUIeTjKKU5mRGuxDXyNi1rlUi2KDmINA>
    <xmx:qZfBaGIUYm8H2CRZzSAH3J71-ZqGe1KYuqUc_SeWcPfHTd4Z1P1qFA>
    <xmx:qZfBaFgwc19pyBuEqZS01eSYZQpHdDSFAsCrQkP9hpTow_Rn64htmw>
    <xmx:qZfBaMSpaAFHAlleLnCBwdM4_RNEWJKqOLR5uMWwdvTvtwhaQr7S7A>
    <xmx:qpfBaFyrzB1eNYHKINPScMAJ4npYQq44N0lHZFnQzs6e0sk6MeC2Sf4G>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:22:17 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiumei Mu <xmu@redhat.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH ipsec v2] xfrm: fix offloading of cross-family tunnels
Date: Wed, 10 Sep 2025 17:22:13 +0200
Message-ID: <c4b61b2da197f2ef3742afec3f8866c5ab8e9051.1757516819.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xiumei reported a regression in IPsec offload tests over xfrmi, where
the traffic for IPv6 over IPv4 tunnels is processed in SW instead of
going through crypto offload, after commit
cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
implementation").

Commit cc18f482e8b6 added a generic version of existing checks
attempting to prevent packets with IPv4 options or IPv6 extension
headers from being sent to HW that doesn't support offloading such
packets. The check mistakenly uses x->props.family (the outer family)
to determine the inner packet's family and verify if
options/extensions are present.

In the case of IPv6 over IPv4, the check compares some of the traffic
class bits to the expected no-options ihl value (5). The original
check was introduced in commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add
Innova IPSec offload TX data path"), and then duplicated in the other
drivers. Before commit cc18f482e8b6, the loose check (ihl > 5) passed
because those traffic class bits were not set to a value that
triggered the no-offload codepath. Packets with options/extension
headers that should have been handled in SW went through the offload
path, and were likely dropped by the NIC or incorrectly
processed. Since commit cc18f482e8b6, the check is now strict (ihl !=
5), and in a basic setup (no traffic class configured), all packets go
through the no-offload codepath.

The commits that introduced the incorrect family checks in each driver
are:
2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
8362ea16f69f ("crypto: chcr - ESN for Inline IPSec Tx")
859a497fe80c ("nfp: implement xfrm callbacks and expose ipsec offload feature to upper layer")
32188be805d0 ("cn10k-ipsec: Allow ipsec crypto offload for skb with SA")
[ixgbe/ixgbevf commits are ignored, as that HW does not support tunnel
mode, thus no cross-family setups are possible]

Fixes: cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback implementation")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 net/xfrm/xfrm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: reword the commit message a bit (Leon)
    no change to the patch, preserved the Reviewed-by tags from v1

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index c7a1f080d2de..44b9de6e4e77 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 
 	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 			    x->props.mode == XFRM_MODE_TUNNEL;
-	switch (x->props.family) {
+	switch (x->inner_mode.family) {
 	case AF_INET:
 		/* Check for IPv4 options */
 		if (ip_hdr(skb)->ihl != 5)
-- 
2.51.0


