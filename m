Return-Path: <netdev+bounces-229123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58262BD8610
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4473A4AAA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8B23F294;
	Tue, 14 Oct 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="BVVCl7vx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hx8xaEOP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19918A6AD
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433475; cv=none; b=gWBcqwBr1o3kbKpuW5sOTzwVpZBNhH4ui2iqN85FE197KAgcXndtasjYQtSpBbMPhALNPmXirzmbqADHHWwnOnKgUeEQGzNoQD5a2jNkFoLKnj3vpCMq/ryX48A8BXemRLbQm2vq0dv8xSAIMzKm46Jwqr4STb8pgZWKT35ul/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433475; c=relaxed/simple;
	bh=iKDgbS2VnKWQ+Oa2dkkyEpGcZTraH1HDsorEjgq0+tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOSuPqwkrUrTcWpgfYPCjRI0189iQFWG5U7KYghtgaKgYunI8JtMeqC1zsqlvbHAGfV/eVhTsFT3k7hIgwVXMO4nWdxpN3QkNjSPtUjZFzaUZ+Gx84n3vtleeSwMWpkJXNf09uHNXagFHnJJbDOwtD4ypoMBNRRPK22bUZN+i8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=BVVCl7vx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hx8xaEOP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C187614001CD;
	Tue, 14 Oct 2025 05:17:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 05:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760433472; x=
	1760519872; bh=XvCZyU3dEGrZCabnQS9D9II5Xb5CjqTARtjE88kAbI4=; b=B
	VVCl7vxw/habl01SGcQmlgYQBqXWBpwTjfN93vz85a+ZmEC4QUI8l7exyTcfZPQY
	4GLJXmFJMB9ILF8fOQqdzQ1NktHA7PA/BdUGMW/TMVExYYgMh09Fo8ulNJIvxBNX
	6Rak9NQjNNR4XQiUveJ2EK2CeUktfM7CNllQNOIUYAzDS86C38y+oyC0DSDkk7/D
	FC7oZa9B7q6u5PbBOOIyvKeoAa78tsxlu/NPl/lzX9WaqfyVWwhDl1fFhXE/Y7UC
	hFf3+za8OsIQngiYwSRvGzZF++2m7wiQkmZam5EFMJQu6AWb8KTf/h97DPhjSXao
	+PE4mHgyIRf5fW6vS7LTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760433472; x=1760519872; bh=X
	vCZyU3dEGrZCabnQS9D9II5Xb5CjqTARtjE88kAbI4=; b=hx8xaEOPNljRFl/MZ
	D4ZZHgol+Ij9Tzaonx+4Egowf00gedUvc74pkLaOTO9mA7/WT7BI3s+a6M29a9nc
	oHAsJWHmM8AZ0bJCPMPYZJlMFOVl9mTy5FPVJ+WGsZ2aIJAbDOOZOuaLNFb5tuQt
	QNhGCZ8moZC7jhUUsc3R6qO4FE4EGEy/QvtdU84BkVax91MFTJ+5nDpEQ/7/uqQQ
	zFN59lVcjMvitirVLgVJVb/FpD//neyVMjvLRNTEDvRyCr2m6S7lC8cEzJD7gU4T
	12qds0Dhp7E2Li5ERQ43s7LPc9fm4yOWdVaT94SGM45b9IWcdXtiGE0Ol9l0yO4W
	45l1A==
X-ME-Sender: <xms:QBXuaI7t9be3u_ODKMf5Mbs4aYPV9knnj4RJHxDiJVVVsZRI29Ig8A>
    <xme:QBXuaAygOIWbdzMZaEFztbie3IiAfNB2Bfw2S5anu-ZEYLWq3Ec25eTHN67xKo7lc
    wHYlS7wRD9Nx3lxjWhWSkrzKtk_UKB_y4q0l_xNeKCiu3KZ12e8KXw>
X-ME-Received: <xmr:QBXuaPx_CS_hgvZ_zmHcBa-PhQ9Tda_eVDce4rJIL3GzpE1NS10sKldjtjaB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhhnh
    drfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QBXuaIwQ-Zla-qGESCzwWQllR38E82sH3MwlFlrBzpHuW-uYKK46MA>
    <xmx:QBXuaJaQDzJ2arXob5JY7xqkvNA8Q7VBPuhEOcC6tvame4OzWw-psQ>
    <xmx:QBXuaJWty66Ca96TzGyzqhVJDdwNP8jaxIpOXQjFVbLD-Y2TpzY22w>
    <xmx:QBXuaHgOQvy8vpSs8h1n_yovdKNWdcSNvZAiRvOhlIjKG_1YrjDEMA>
    <xmx:QBXuaMNU8rawmPYeoEqKdx8N_RBDhKpcySOsyuWKRrySIpCL2SI8KDqB>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:17:52 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	jannh@google.com,
	john.fastabend@gmail.com
Subject: [PATCH net 1/7] tls: trim encrypted message to match the plaintext on short splice
Date: Tue, 14 Oct 2025 11:16:56 +0200
Message-ID: <66a0ae99c9efc15f88e9e56c1f58f902f442ce86.1760432043.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760432043.git.sd@queasysnail.net>
References: <cover.1760432043.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During tls_sw_sendmsg_locked, we pre-allocate the encrypted message
for the size we're expecting to send during the current iteration, but
we may end up sending less, for example when splicing: if we're
getting the data from small fragments of memory, we may fill up all
the slots in the skmsg with less data than expected.

In this case, we need to trim the encrypted message to only the length
we actually need, to avoid pushing uninitialized bytes down the
underlying TCP socket.

Fixes: fe1e81d4f73b ("tls/sw: Support MSG_SPLICE_PAGES")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index daac9fd4be7e..36ca3011ab87 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1112,8 +1112,11 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				goto send_end;
 			tls_ctx->pending_open_record_frags = true;
 
-			if (sk_msg_full(msg_pl))
+			if (sk_msg_full(msg_pl)) {
 				full_record = true;
+				sk_msg_trim(sk, msg_en,
+					    msg_pl->sg.size + prot->overhead_size);
+			}
 
 			if (full_record || eor)
 				goto copied;
-- 
2.51.0


