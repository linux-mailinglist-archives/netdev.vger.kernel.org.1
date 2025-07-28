Return-Path: <netdev+bounces-210548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F936B13E13
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F4617E451
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354A27381E;
	Mon, 28 Jul 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="wg9Wg3a9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDkxjy9s"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037712737EA
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715890; cv=none; b=gCstllx/05r9lhqWGSFo6HcCle3GUAUN0oGXvmju3RlvhSczbVcnKBHszEXqI3XTyzDEwUv/pU9udJLtl8q+K5Z8BojuYKisfXhBZF+BqQGofrbfM27s3U6BV+DASdkEEHxynk0MIk8/t4WLHaLnObbnzBOHuexe1AzINKRhXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715890; c=relaxed/simple;
	bh=vELfsk6qj9NC7bDPljsQYbRA4AjGbBgGFdWX51KP5Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6MN5ahsH3B1pphxv0ed+7cxkCFbJ4mQteFGPc/0jeDCS4qP6Nu8m/DrC9V+mM1ER907l2cBXUIv3mfG1ax7lC92GCN122zy8SnIsjnOuy7FSDih1DoicHdwmccv6YOWGDrYVWY/h5ITaBBRsLcvOzT2oqmgwDfdTlLPdF9bpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=wg9Wg3a9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDkxjy9s; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 04153EC01DE;
	Mon, 28 Jul 2025 11:18:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 28 Jul 2025 11:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1753715888; x=
	1753802288; bh=eZGMj8H65pJrTuGqaqWRJirsSm66SzE3MZBCvyjF1dU=; b=w
	g9Wg3a9GOQvUOqQb7yjblgwYsvlUbe2cclI3TQtkZW+UFHHjSLhb4EthbiA1qv6C
	yYnMkNR4YaPaXjJefMPQnWWBVU5QgNIWOmctSYm73fBxYTjJipFnIOFPRbtp759J
	2nTEDbmrt4nZeW2+2QmiEdxsk344wcv2Px9g+646x5A7PFxBp6QpKiMhfNXsK61R
	lS4uMhVCBJXkKwj+5GnytH5gHAxNqKTe8RC350m4n2/maFnlMlbxnTms2rvBSEU8
	Q9WTdiGdu1UqxeO25oJTX3WbqC2ZHZfGzxf0/d9otQ7NiSOoa0cWYocTKnijPvm0
	acqJw0OsNhKVVYQ6auBfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1753715888; x=1753802288; bh=e
	ZGMj8H65pJrTuGqaqWRJirsSm66SzE3MZBCvyjF1dU=; b=QDkxjy9sHhWjQoXfU
	WPLU64s2dbHbeHgRAkDSQnIgocb6xteIG48SuPlijOz38cpKAwv7Z3NRwWw66Vvl
	XgLtl6kXnaKi9Fjph8zE+rOBgcb994Jtcr2N8uWRjVHrLPG0jboKHTp+Wsro7wxz
	vW1zMCiO/Ka5XSjnOIZzdxuu8YMKtxRc9jlv3rHBKI8BOziTomhjH+AyCJLDJm+V
	vW/YWLfl17/pX75GQ01L+PgcBW0NEpxMoRn+nrLcN1SI+xw7KGvKnTm29V++gGpr
	DOSlPlcij13r1aZ+SDBqPXc76sojzyhDV6MsJyK59B/Pb2aXpIWU8qohBKC9PloD
	JYrdA==
X-ME-Sender: <xms:r5SHaE2kSXRGH4G-y6FKualqkrAZ79RIw1qMc9HL2kUkoqiYSyP0fA>
    <xme:r5SHaKxbml2kWVsQq_TwTRKDfCHsrwh4iF5mplsItyv-nT_pi_mXCZT5BI5YOe8rG
    rhmJhDM5V5VZL1JADc>
X-ME-Received: <xmr:r5SHaJWRGmRo-kWKBSA1-v_6lugVHRHrN76SulvxhbJe2JNY4oGS8q7OQGBa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeevteeuvdegudehieetlefhteevfeevleegjedvtddtjeetiedtjeegheei
    ueefhfenucffohhmrghinhepkhhnohifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvght
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnh
    gvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgv
    rghshihsnhgrihhlrdhnvghtpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprggrth
    htvghkrgesohhvnhdrohhrgh
X-ME-Proxy: <xmx:r5SHaG-ylUUA9HD4Iq_TtwNq_LcOV-wR6fHDDglFJAkNC8q8WNdN7A>
    <xmx:r5SHaMsqY7juWgx0A0_L07IbGWfhNF_FSgZiQhYk__IcoGsZ_KKb4w>
    <xmx:r5SHaG0DkKvtEx74QJgUQ1btOsUJ4dqff-lYdtd78ZIZJaU6-1BDnA>
    <xmx:r5SHaBR0U-C7sAc_hgW8RfmlNvY5neBVxL4g9A5pPXVokEGrAdLVvA>
    <xmx:r5SHaJqZ0UwZeF5ivmQAh4c3mp_awPT1WlK-LsWdpGH5nzc59SqDHinP>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:18:07 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Ansis Atteka <aatteka@ovn.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec 3/3] udp: also consider secpath when evaluating ipsec use for checksumming
Date: Mon, 28 Jul 2025 17:17:20 +0200
Message-ID: <0e8fbdd7e0086f4cc73a46f010a79638d4910498.1753631391.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753631391.git.sd@queasysnail.net>
References: <cover.1753631391.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b40c5f4fde22 ("udp: disable inner UDP checksum offloads in
IPsec case") tried to fix checksumming in UFO when the packets are
going through IPsec, so that we can't rely on offloads because the UDP
header and payload will be encrypted.

But when doing a TCP test over VXLAN going through IPsec transport
mode with GSO enabled (esp4_offload module loaded), I'm seeing broken
UDP checksums on the encap after successful decryption.

The skbs get to udp4_ufo_fragment/__skb_udp_tunnel_segment via
__dev_queue_xmit -> validate_xmit_skb -> skb_gso_segment and at this
point we've already dropped the dst (unless the device sets
IFF_XMIT_DST_RELEASE, which is not common), so need_ipsec is false and
we proceed with checksum offload.

Make need_ipsec also check the secpath, which is not dropped on this
callpath.

Fixes: b40c5f4fde22 ("udp: disable inner UDP checksum offloads in IPsec case")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
Since the issue is related to IPsec and currently not visible since
GSO is currently broken for SW crypto, I'm including this patch in the
same series for the ipsec tree. I can split it out if that's prefered,
just let me know.

 net/ipv4/udp_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 85b5aa82d7d7..8758701c67d0 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -224,7 +224,7 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	remcsum = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TUNNEL_REMCSUM);
 	skb->remcsum_offload = remcsum;
 
-	need_ipsec = skb_dst(skb) && dst_xfrm(skb_dst(skb));
+	need_ipsec = (skb_dst(skb) && dst_xfrm(skb_dst(skb))) || skb_sec_path(skb);
 	/* Try to offload checksum if possible */
 	offload_csum = !!(need_csum &&
 			  !need_ipsec &&
-- 
2.50.0


