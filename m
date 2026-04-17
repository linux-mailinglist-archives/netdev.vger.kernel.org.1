Return-Path: <netdev+bounces-279372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGciFJpl4mlm5gAAu9opvQ
	(envelope-from <netdev+bounces-279372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:53:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A0F41D5A7
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 417DC3013D77
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB8314D2D;
	Fri, 17 Apr 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PhI2625X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+NV7e3L"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982433F8D4
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444612; cv=none; b=WU/iI5enr43Xl9+Va9XJstmvmkHMQGOXwPNxEKdVP6WK8KBUZSRBU8iSYB1Q9ei8OgDVK2fZjNOXkFJTPOBKETgPsF0f+90XyFXE3VxvHj3syiDVWqoRZtEbasHmWaQfaZtIh5rP/ZZznKvP/1/dWcfjy+wI028xrUfR6QTKxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444612; c=relaxed/simple;
	bh=4Yok6qPMPV+6qXKD5SpBMXQXqNZvdKolrNmBVgIiXvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqWZRIqamgIrnr3pSgFI3I5ZCO919ttrsPYp3sYVWpLuOS5TGmgWbU4VMHUVmO2z/Ah6GJ1Hq5JOv7nkaLZvAtVkkNAZ3HDTc88jll3rJsnuXt0h6AlJwJ77eqsgjJueHkZmzDJb7sgVdWw4YuNlcFOWdvaOXOrCmKNLwRJ/9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PhI2625X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i+NV7e3L; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A340F7A0204;
	Fri, 17 Apr 2026 12:50:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Apr 2026 12:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1776444609; x=
	1776531009; bh=MeWFCdeL2rrwwpOupYcuqzpeU32W8McmitY9EY74Gso=; b=P
	hI2625XurMQXKcIgKnugRm40oYDlg9JgIJHJwabSvj3rBWTHaHons6RQDGDm9Y5b
	llojZWKLOV2HIRIakiokpAAl0jjqIOjKioQr4bKmBec4wgCJIVO5/+WzmlSz3DcC
	GAJbMoturZzJ0emUhoNmuj4viFSGSVnlsxO/vXePVXgQzNkmU02OCGpQ5Glwg+7p
	o7Eh/OepWiEQ/FOG1MUCujv/xuCdHdMzGnj7tLi+SAse3GNB604PVn6SoQvUWExd
	+E5bVscWYe8gDno60antCOiAzp9889nTdjFbyN++qQ7AoKrRKG3GdEZxE2GJ1fNO
	Eijx5VyACnb8BWZQPyfNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776444609; x=1776531009; bh=M
	eWFCdeL2rrwwpOupYcuqzpeU32W8McmitY9EY74Gso=; b=i+NV7e3LzRaSKOjOI
	czIwEJqpHh6WCXbWqRLkgFPAx6141SL8fOpsxBVXDjkyvioNMmvdk+hHTDzZ2we7
	6rd8j5sLlZufmroigWKN2Im9YWnsZgRb41UVcfRYXpBY2uA1A/TEHbKqsMFbjVot
	CDs9H+dX+aynT7VRPMMK1W84MQsXctUWTZDYXfED3StV+8Cez9Q0pDf4McJrO1rT
	fBAEcO30K0/lRSJ1VHRYNPnZD0j1MU3TAilqPNGTH2p2HC0ZLs+nc4CUi4ivZIKl
	ew8VVatfOh/BxqafBDLxJuvW2FthuaasXi6qvX4pky9yvh0aefFFVyCDV5K+hrPs
	i6A2Q==
X-ME-Sender: <xms:wWTiaSB71B2ZRKJzkjoq4Gpdx5EYkGaJGpXYtXhSb7ZbNuUtTBjBnQ>
    <xme:wWTiaTjtxT7M0ku8rgcyFzopMUNfps2_i18csVzS2_w2bJxFOiA7y5ZWDvcZMoAH2
    P4r2yAwOj2e3FKdBxRSkytpOBM9HY5HS2P9M4OhbSt499RbajMfhA>
X-ME-Received: <xmr:wWTiaale8Dr0OUQtdUDZtqUXn9G10fVFpHpziPuTYfTzlPX-MEf1xGiviwoQieTeHh-JABDtKLRObl5lotI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugif
    segurghvihgufigvihdruhhkpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wWTiafoxULg4zrbTM9RgaUiDXwllS_N6o7Vu4QJNcKcLJT_siYGKKg>
    <xmx:wWTiaTEZxRKylP9UVQ1DhS_5o337rVp5uQ3NazqVMzEtbtxH3U5mkA>
    <xmx:wWTiabwNUBg5gpTYqDJpEbzBUzs9Zlpbm3wWEdVZXQ8P3Nsp0XYwBA>
    <xmx:wWTiaYrUp389e4y4Tu-PHibIjCe60VttBKujbWr5vv7PqYCkxJuGJg>
    <xmx:wWTiaS8FnnepXDdqaVXy9GhdQR2wKmjmoJTv4Q5MZXJUqvJmhE2xH8Rd>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 12:50:09 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH v2 1/6] selftests: net: fix get_refill_ring_size() to use its local variable
Date: Fri, 17 Apr 2026 09:49:47 -0700
Message-ID: <67922ec9819c741763b69bf73d57e12b74df1a8d.1776444379.git.juanlu@fastmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776444379.git.juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com> <cover.1776444379.git.juanlu@fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,fastmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279372-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.com:email,fastmail.com:dkim,fastmail.com:mid]
X-Rspamd-Queue-Id: D8A0F41D5A7
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
index 240d13dbc54e7..334985083f611 100644
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
2.52.0


