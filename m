Return-Path: <netdev+bounces-255989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLZjK8r6gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:28:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDBBD0839
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F56C3078F4C
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238EA3033FB;
	Mon,  2 Feb 2026 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="qcAH61np";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mDmr2QL8"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B383033D8
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060255; cv=none; b=tL/KJpvyzYaW1dXsMRucuhnBCh+HE7r9bSaaPRk45tiHfpDG2y7ok6IdMgqsn/dIJjnVEFnp3YjKrIB2igtqIicdVuCejmXeF7OqUDeNLsDrSvTix5nGS35fA8WxWHo0dkvEZEZiNU8nxaHWNjres7vHwoIeWO6hic1mXWq77Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060255; c=relaxed/simple;
	bh=HsMLsms5ly4gb7DuAOX4SGvGvKNwH59kuW2ywYb4CpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQMdCcpde/YKlfIWUcH2qMi20oKOlYjW0JMfVt/CsXAs9v6RRpaadt+TGDOc1NYAQJGkpeGHwvziRGVGaSsTajnhvSuUdVWShzrYRBV+cmzLriavNGFaKO6i9Bh9i+zJEnhC21gajyDtuSgGjktTDVS7cND4rz8lE7sry7o+pvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=qcAH61np; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mDmr2QL8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 229927A0099;
	Mon,  2 Feb 2026 14:24:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 14:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060252; x=
	1770146652; bh=XURfjpC2sRt1AW+JeMpGcRQ9FiGnwzHPpCLU2eMqaNc=; b=q
	cAH61npnQfeTagbmMPUQU9+3Ewm927wbrtJS165+jtBvdRVnVmcy0mFl9OZJD1iv
	vgpAbtlTSmRkbToduiGdpxLt8V17ZZqaD5uUAAl4BOAEO5g40yqladnNGCIBObGA
	AOStMY1mKimRFqqrLo4qipZGeq70GSgS5qr/bUaCV1FmMOfRh20saNTp+qUJVnH/
	maS5hHmgyF3sVR4uEaLYDkb3yQCrvA+UvjHoEW1rcdgmBptAQucXSCo83b4CHD+d
	TybcpIvtfp6A9xaXhTQNjD4J0Rh27gQVplWarsSP8UllkwVv7gcvqNAPDfDS5pv0
	4rPXDoJMtCF06OvXcpHOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060252; x=1770146652; bh=X
	URfjpC2sRt1AW+JeMpGcRQ9FiGnwzHPpCLU2eMqaNc=; b=mDmr2QL8Kt7Wbt5/P
	fQw7v1t5UCh0uSQklWts9WHFVjt/hByVRMwsZUhoCF15HjKwUOKXMWRwVGDiymyI
	En6Lxf35ghghV7E6yKXmEq3x7WpE1H3Ff5d2Q3BL+PL3F70aglIB9/IUlMl6yDU2
	9y2zv80byY9sCSA8ucXMnsv8pFE2toHl0VIUsGlsC08oEs463/8OHVF8hLEIK0hC
	xWRT9TfGBh62+PzgS1TAcQgGDlIRueSxoniSvxOoZx3HwiocgZcXLZmoVH2xUs61
	BDbcRxosQRRIUM4wC3Z9eL0rJpWXM3/wZ7sBE/ZR+Q+IyMj37WqPh2u4u2lH+Ky6
	cJsqw==
X-ME-Sender: <xms:3PmAaTnkbuakMUhUK7OH1KoO6Cc0yU1_P_6NscsjzYPCOwQevSewKA>
    <xme:3PmAadPgOOOmrepW8TLNwmJeOBy-A_j06POKYYdNrTjP_yON0k5QfL91jHRB05c3P
    8C4PGl_GT6o_ivruWqYC_KLmNsSDpUi_j08p5iZRwnCi7j1D4xXcZg>
X-ME-Received: <xmr:3PmAaV5tqZIO1ovTnbE9WHJTNf-FCTm5Cb-8nA5MEmFZRhfcYapRsjaZ0Uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:3PmAaZake2a8acNvqAw_JMHmpJd8SLFfoP4wnitnjOOdmzbE-7Xutg>
    <xmx:3PmAaafitR9v3PAy0GYk502BiZXH0jJ6b9p7RMlEwUPVI-eTRFkDXw>
    <xmx:3PmAaQ7XsbvEljIXiOybHxgKr4083R7SzRlB-M1bGgh-pwhgnkrTWQ>
    <xmx:3PmAafYHxZDcNyWLJJnqX6etGyjQRbSzhxZbgkCxNir7x-J9gyw2rQ>
    <xmx:3PmAaVLf_bcyRv-GL3uCfNVZyv60NSHjEtV350kqh1k7MKm5zIbnLYB8>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:24:12 -0500 (EST)
From: Alice Mikityanska <alice.projects@fastmail.im>
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
Subject: [PATCH net-next v3 07/11] ice: Remove jumbo_remove step from TX path
Date: Mon,  2 Feb 2026 21:23:34 +0200
Message-ID: <20260202192338.2373930-8-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202192338.2373930-1-alice.projects@fastmail.im>
References: <20260202192338.2373930-1-alice.projects@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-255989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 0FDBBD0839
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the ice TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 396326a6d5be..6fa201a14f51 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2156,9 +2156,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 
 	ice_trace(xmit_frame_ring, tx_ring, skb);
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto out_drop;
-
 	count = ice_xmit_desc_count(skb);
 	if (ice_chk_linearize(skb, count)) {
 		if (__skb_linearize(skb))
-- 
2.52.0


