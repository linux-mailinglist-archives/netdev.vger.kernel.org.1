Return-Path: <netdev+bounces-276641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BXaOhGG1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:45:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CDA3BF090
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2023065895
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB873B9DBC;
	Wed,  8 Apr 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mIKiSUgo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rpMtodrf"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5D3B3C11
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666320; cv=none; b=LC0lc2bSNoBBNbsOT/4mZxlQpGtK4oolyYE5Dp7mphmn5sC3N4kBV9WEqz/QUAAnT4RXP3WR7prlz1/4NdzmlbO1KTXpLDuawm0QVLiJFVdT06rT5D0rUCwee9lCdvgYMYTds+srLDSIS/nc+FFHp3aBfLtUZ11q0Op5qOsINvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666320; c=relaxed/simple;
	bh=KlPmwoeMgWHTjATVRUnw9M5waW7wNMphDVZ7SE5c/Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQimvwAtLTPLZfunuNoHuYUG3sGIhhs6SnVVVtiKB53CQ2gql2RYbvgpCuZpkasExp8JXe2DwP48PzqtOgRsVehp5MLx3KNPcW0O26LxWfcrXhmZ/UTHTojoyMCOfXniC88AOUrDpt+Kp5Po9vC/yBJ06GDNJ/iZ+fjCI+6ZLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mIKiSUgo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rpMtodrf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E881DEC01BD;
	Wed,  8 Apr 2026 12:38:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 08 Apr 2026 12:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775666317; x=
	1775752717; bh=hoqNxZTzX5z9bT52hTg5m+WV+ktsLfPv9BSaF8nPgaM=; b=m
	IKiSUgoZ8BGwaBR46hnWXwKoaaYLlwoz0iLY6tLYs93YVXSr8jMzPL5jPVrX3H/k
	5qy2REd/8jiSsQ1YdCFDmLDYKaXb+H5OBDeIXaNzXwPem3Cj4yGl7L8F3hP2WUPs
	t99GYapJNpU0ugKL+w6toiU0HtS3M9+MGNj4PAcJmBVcRZ6KI+6fkRgd4iieDAuF
	QL6gAlM6K9/7Mrb5Ti58zGfHp4jg6D/ENGN8E/5B2gZsxLCKHxtC5u2P2BhJ8wqk
	qheAxT6S2KvPXCCqdvT79Npjz++4D7CqC/R5yobvQzBsnA0+62KhQcqR68QhKf5F
	NeWtMkXnr8h442L75HQTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775666317; x=1775752717; bh=h
	oqNxZTzX5z9bT52hTg5m+WV+ktsLfPv9BSaF8nPgaM=; b=rpMtodrfntRxjkTW3
	Va1uNdfW3KR4mr55eIBL5xgtCAyfTXWMWHLZh9mEaDJ1GJmdmx3jUAFcOmL3X2+B
	RYPFfuEhTySceEuH+BnCk+YXkby75uWVORyrnJWTKNwc3AGfT6ca2aiTnqzSCClD
	41EPcBaAYQyhO/yAowoTAd/mfsbelC+oifCS4yABXcNnC0EKy2xfOz6jl2tx87Cd
	PDl7NmRaZXKGAu6hgd4pFuKPQo0YYmZmejwGDSs88ifBanu2xvvPxBuoI8dyv7/+
	UYUn/ni5OtMAEgvVnv4Y2adZtG9bgilqr5VSE56QtM07qU7cFlP1QtyX/SmrMQju
	NKKZg==
X-ME-Sender: <xms:jYTWaeVdN8LtLk9c4IP03wtRj2XjlrghZg55PHK3IpRHCBmyZyD10g>
    <xme:jYTWaQlYnm10RHaQKvzUh83qTLMFM94nGJqHB0XeDzyFyuD5zwVnWWEet5kN_dAwZ
    6Tc_Vq4PMBu6Ag7SnvkwZSe7rgsOYPJkNm7xxZm9s44-frz7PM5j0U>
X-ME-Received: <xmr:jYTWaQCIGBoHErXYwys7_eZXQJNIesIW3mqvbhWW3v7HeqRwAB7TSA6W3gjkV-9PzAMRGfIqoKDJjdUvvPWNyfX9LHSsgp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhurghnlhhuse
    hfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:jYTWaQcxfK55b7Bw31qsSkdnGQZNmO_bplunMimV2cNzzW6PpU0RMw>
    <xmx:jYTWabKnJw1iSe4TukCAVMvK6wAP8GJGFIeR5cxtmQDth1ftf1BtMQ>
    <xmx:jYTWaTc-PMz59V5BrqaygBAepIa2e7Vt5jBXIA8bKI_4YkQhN0ginQ>
    <xmx:jYTWaS2a1P03Y_6lIJSDUzwxSmoK3e9aOMNDmPLMQC1GxlWdCMZbLQ>
    <xmx:jYTWaZtCknbxtI65-lF7oOAmZhWlcOwhm6rchAh_K-AcMqr_oPvugdfQ>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 12:38:37 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: netdev@vger.kernel.org
Cc: Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH 1/5] selftests: net: fix get_refill_ring_size() to use its local variable
Date: Wed,  8 Apr 2026 11:38:12 -0500
Message-ID: <20260408163816.2760-2-juanlu@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408163816.2760-1-juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[fastmail.com];
	TAGGED_FROM(0.00)[bounces-276641-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.com:dkim,fastmail.com:email,fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 89CDA3BF090
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for multi-threaded rss selftests, fix
get_refill_ring_size to use the local `size` variable,
instead of the `global_size`.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 240d13dbc54e..334985083f61 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -132,10 +132,10 @@ static inline size_t get_refill_ring_size(unsigned int rq_entries)
 {
 	size_t size;
 
-	ring_size = rq_entries * sizeof(struct io_uring_zcrx_rqe);
+	size = rq_entries * sizeof(struct io_uring_zcrx_rqe);
 	/* add space for the header (head/tail/etc.) */
-	ring_size += page_size;
-	return ALIGN_UP(ring_size, page_size);
+	size += page_size;
+	return ALIGN_UP(size, page_size);
 }
 
 static void setup_zcrx(struct io_uring *ring)
-- 
2.53.0


