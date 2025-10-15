Return-Path: <netdev+bounces-229450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12DEBDC644
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729953C7084
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E02DAFD2;
	Wed, 15 Oct 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b="U1isCTAG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EAWA6PmO"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459471A23B9;
	Wed, 15 Oct 2025 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500905; cv=none; b=sl/tpIr3ZxOTLlObZxPApeE+LR56caEKDiHLzSN38AMm4p/VUXIt6egZU0d0XV4R93YVkFBHOJWisgimMQTP0Jsy8T6TJVnLXE1c9o8L1iJ7pdSK3oKL0EIMl8tauK3at4ZSTDWpRWzkdPGwEHpvLjW05Sn8yt0MmgRG/WsH34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500905; c=relaxed/simple;
	bh=9sd4teg4rfdZGNVNm/AWHHIB6GDF9uxx1RY0TusgNCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kZZ15Vu1IXTsS06dSf9jwd9K7fXEbCXSlsOcb0hJSkfWD/rEQxi/eMJnRfgcRNH2m8hKKFMVJ6oYc9ad+9gmRSnjk+bgDALgItz99XHycN3vGXrmzjHrOnxX9pXCvPcs7PBgLuOZ3xh9cL5+CmDPuzTRuw4GnSi76zV+XQFdr8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au; spf=pass smtp.mailfrom=traverse.com.au; dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b=U1isCTAG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EAWA6PmO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traverse.com.au
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 51C03EC00B5;
	Wed, 15 Oct 2025 00:01:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 15 Oct 2025 00:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1760500902; x=
	1760587302; bh=XCWHoRuV1DjkFLRWX6y3FW6hHQ+pKszYSvd269MSNUo=; b=U
	1isCTAGnljLpJFRu90X8zRZlHugWZUZXnV4cTBq1sJEuF/yAwCdL8e2yFHa0vda3
	rdpn1GMbRBoabUgfWIfUW38o/H8xrSRJpbjoaJDcLoO8WDnOM8krj0TuIce8L5Yv
	an90Yr0W8OZYldlu8sImFFMkS+lnDID9m+thWeI5RQsA52PFiy22pbUDNx6Tm5aa
	NAknu7ZP1DKe6d2+vHp7IqBy8ZcaKY9xl2Whp3MKKjlfXJ5zEe0wj5NIKtm80RVb
	qn+QbnGG8ce9voB28tm2qiEJakH84t9cTfY0Pm7yOeuRsyVuFUwcdCj+QMhuZCFQ
	RVuRCa3cddDJaw7c2LNrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760500902; x=1760587302; bh=XCWHoRuV1DjkFLRWX6y3FW6hHQ+p
	KszYSvd269MSNUo=; b=EAWA6PmOxCNXWo9slkqpCiLtT3oFvLpF/vk0vxWqye2v
	odU7RCRatCx6rTuY1D2P6tqXq9yrWfpSV1YQH9CeCeNwpLM2cuiLBUYsVOyXFqgJ
	HXG/oqlA1f+sdgBOvlnv0ZMh9/OfbkVukujZDZZyGy+qKovE26uiGFnRxQKDozi5
	zxh3oP6/HHD0wFRGCAYWc0s+/1CM+tSuvPN318L3H3pDyOQEvJMmxrt072hRGzdc
	eKLLIFXuQKlov9JsVILo9wm90oOgNBAkRsqYdkMouFmd8ThH2UiP5G/1vWMwAfSo
	6dfXIKdIPZwTqWROaUImY0Gr/H5H6vc4W2f3L9rE3w==
X-ME-Sender: <xms:pRzvaIOuqiGlL89yi49UeBQj7tONJV-7cj-O0U67ZTrKY31SZnDbKA>
    <xme:pRzvaPa12zotxnwG0qcwuzWMa_34OVxfE-h4wlqJA03gpM7LyNyrOiJZ0Lqd1GlgU
    eZ8ZUSu9z2BiIO-kLKPlkW4dZHeOYlKkd-YDGTLUTWOpp6qm0xhfA>
X-ME-Received: <xmr:pRzvaP951lDa4BQ9k5gQSbPuopuFLSYNwD93_DClfaim_rlUYXUTb31Xa6rbDQ1EtWoJodo6EIhW8SNzNrTrsmsKadCNQ9t9WZ94ggroylzl9zfmKfUkn-DPpLmQCc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhgvficu
    ofgtuehrihguvgcuoehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruheqnecuggftrf
    grthhtvghrnhepfeeiueffffejffduiedvudekhefhgefhveethefgfefggfefteekfedt
    udeijeeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghtthesthhrrghvvghrshgvrdgt
    ohhmrdgruhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghupdhrtghpthhtoheprghnug
    hrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghv
    vghmlhhofhhtrdhnvghtpdhrtghpthhtohepihhorghnrgdrtghiohhrnhgvihesnhigph
    drtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:pRzvaITyzC1OJJuPnaH611QqKjY-363MngtpJHPM5YPfcUrE_9kU-A>
    <xmx:pRzvaBcTfB9j5rvUYrM_NouQKoDH5MiYNAVYoF4UH3RMePjiamg3NQ>
    <xmx:pRzvaCTMo5ztKjQglm-T6NespL7XU6K-SUi7dBPscYRfUaU1deAR2Q>
    <xmx:pRzvaFIbdKCgLx8OjsZzPsqQCeBRT_KnqPY0pvP5qef-lR0MEC2D2Q>
    <xmx:phzvaDDNIpOLCZkcKx75ElWnNnbb_2qVRb-b0nX4KznC2FIQaATpLG1T>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 00:01:38 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Wed, 15 Oct 2025 15:01:24 +1100
Subject: [PATCH] dpaa2-eth: treat skb with exact headroom as scatter/gather
 frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-fix-dpaa2-vhost-net-v1-1-26ea2d33e5c3@traverse.com.au>
X-B4-Tracking: v=1; b=H4sIAJMc72gC/x2MQQqAIBAAvxJ7bkHNiPpKdLDcci8WKhKIf086D
 sxMgUiBKcLSFQiUOfLtG8i+g8MZfxGybQxKqFEKOeLJL9rHGIXZ3TGhp4SDnqadNA3mmKGVT6C
 m/dd1q/UDSEZeAWUAAAA=
X-Change-ID: 20251015-fix-dpaa2-vhost-net-3477be4e3ac9
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3

In commit f422abe3f23d ("dpaa2-eth: increase the needed headroom to
account for alignment"), the required skb headroom of dpaa2-eth was
increased to exactly 128 bytes. The headroom increase was to ensure
frames on the Tx path were always aligned to 64 bytes.

This caused a regression when vhost-net was used to accelerate virtual
machine frames between a KVM guest and a dpaa2-eth interface over a bridge.
While the skb passed to the driver had the required headroom (128 bytes),
the skb->head pointer did not match the alignment expected by the driver
(aligned_start => skb->head in dpaa2_eth_build_single_fd).

Treating outbound skb's where skb_headroom() == net_dev->needed_headroom
the same as skb's with inadequate headroom resolves this issue.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
Fixes: f422abe3f23d ("dpaa2-eth: increase the needed headroom to account for alignment")
Closes: https://lore.kernel.org/netdev/70f0dcd9-1906-4d13-82df-7bbbbe7194c6@app.fastmail.com/T/#u
---
A while ago, changes were made to the dpaa2-eth driver to workaround
an issue when TX frames were not aligned to 64 bytes.

As part of this change, the required skb headroom in dpaa2-eth
was increased to 128 bytes.

When frames originating from a virtual machine over vhost-net
were forwarded to the dpaa2-eth driver for transmission,
the vhost frames were being dropped as they failed an alignment check.

The skb's originating from vhost-net had exactly the required headroom
(128 bytes).

I have tested a fix to the issue which treats frames with the "exact"
headroom the same as frames with inadequate headroom. These are
transmitted using the scatter/gather (S/G) process.

Network drivers are not my area of expertise so I cannot be 100%
confident this is the correct solution, however, I've done extensive
reliability testing on this fix to confirm it resolves the regression
involving vhost-net without any other side effects.

What I can't answer (yet) is if there are performance or other ramifcations
from having all VM-originating frames handled as S/G.

As far as I am aware, the virtual machine / vhost-net workload is the
only workload that generates skb's that require the S/G handling in
vhost-net. I have not seen any variants of this issue without vhost-net.

My original analysis of the problem can be found in the message below.
The diagnosis of the issue is still correct at the time of writing
(circa 6.18-rc1)

https://lore.kernel.org/netdev/70f0dcd9-1906-4d13-82df-7bbbbe7194c6@app.fastmail.com/T/#u
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index c96d1d6ba8fe9..4eaf7cbec558d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1439,7 +1439,7 @@ static netdev_tx_t __dpaa2_eth_tx(struct sk_buff *skb,
 		percpu_extras->tx_sg_frames++;
 		percpu_extras->tx_sg_bytes += skb->len;
 		fd_len = dpaa2_fd_get_len(fd);
-	} else if (skb_headroom(skb) < needed_headroom) {
+	} else if (skb_headroom(skb) <= needed_headroom) {
 		err = dpaa2_eth_build_sg_fd_single_buf(priv, skb, fd, &swa);
 		percpu_extras->tx_sg_frames++;
 		percpu_extras->tx_sg_bytes += skb->len;

---
base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
change-id: 20251015-fix-dpaa2-vhost-net-3477be4e3ac9

Best regards,
-- 
Mathew McBride <matt@traverse.com.au>


