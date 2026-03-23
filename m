Return-Path: <netdev+bounces-270593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMtTLCdlwWkzSwQAu9opvQ
	(envelope-from <netdev+bounces-270593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:07:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 251BB2F7959
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3F62319817D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBFB3BC685;
	Mon, 23 Mar 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="cM6HDNCU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLtAQKIy"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF523BC661
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279195; cv=none; b=QLFsJXFAobjliuxKsswqR3uvjkJR33yLZ/4qr6yJCC5wQW1VUXpxyJNsTvgp4Uuf7fxSxlhyyWlxS7w4x2hYWqzbgpBMiFM/FWfvWxDyw/OtSpY81CQDJUcSTowpGx8QfV61c1nCjfnJs0CYSbGoAf2dJAO/Ae4cTORE9qfYJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279195; c=relaxed/simple;
	bh=u3yZGq2+SXJNXwxhK4pgXec4CoRlg6JTQ8D2r7gn0UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxVHRuOlA2+WgYPFPBB5BfL4d3ouA3M292Qzkhfq545qneO1I3gSMDZPtBYB5tgJr0Guc/FA1FXfC4O7r4agm+nCzMmPV2QFrGrkEocjRZCkdqv12dh4mDOwa1U8MV1BHDJR4SvJbH6cANXA5QQe9j++Cd2MHwHnrafwkyhKU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=cM6HDNCU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLtAQKIy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 624081D0027B;
	Mon, 23 Mar 2026 11:19:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 23 Mar 2026 11:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1774279192; x=1774365592; bh=CMDOm4CZRu
	yVbyK0eQxMGJO5Wza9U1LPbav2PsjQBIY=; b=cM6HDNCU+YjrLmRG9qsxWqJ5Xl
	KYULhKJJUP0Rn7rUdZ5vFiR7lWhqIURKY7Fv8J+6WrcB99hhg7kLesyldYgmNrZV
	4lIONXtoDJem/Q1wG5iNueuT7gUfj1RzK0VuFfA05SH3mlNqMEjKMZvK2+Gvpx/l
	+KomWAqCb9T8pHWQtC72RRH2wXLQavWV7+LFedw9DOJ9GNrsdlup9wrr0gsPSe4O
	TM1WrkxddbdjPWU9SSs8P6uGI0fHB1rjOjWElsSi3i3Ro6o96BBmi7qXdcxPxSHS
	QJOrxt9x8GZ0PEmr/wX/SNQb1eqwr2BIjQcZ9rV+K5gpW55Ai6JJppllWfHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774279192; x=1774365592; bh=CMDOm4CZRuyVbyK0eQxMGJO5Wza9U1LPbav
	2PsjQBIY=; b=nLtAQKIyvDrxo6MVlvatAKhmgoVLsRHRQUlKyY7uQxnRLg31llc
	somyGpZsOzGIroWy9AJv4067Ws+18Ub00pRNoxGbCqM27mbZlc/bDgucICr1zyp/
	SN/yJD6IWgOA5JMOTLOAEmm22TrXen2ozUn19S/71pXl7kPinm0K2OeqoPijXZLz
	G2Qo9wN6Y8yaUMXCbwzYaUgEy2mcAfN7sAUaCfeOPfhUCWkHC8T8JgUF9wavD/Bg
	c5lm/T7JRBp73LdkzsimM1YcigAsTakAMZMNDjNijrin+769D40dQlu/BFHe9OVq
	GSWHPlkK0CHipyBc1k1ISFfuM70I2pAaLZw==
X-ME-Sender: <xms:F1rBaR_R6SaB3n1Zn6mIO4IC3eivoTW9ETuKDCSQ0bA6HS6v1Ml7AQ>
    <xme:F1rBacukMrHHkm9Ycxs7Jt8aJEd_b88mOBQSQ-JN_CphIOieysd1e3fAWRCYtE0Um
    6cvZF5CmF6zYGFrTelm86dFWU_RmkfotMjrRd1947usjnMa-6Qmr-c>
X-ME-Received: <xmr:F1rBaUCarFVWVJKygL-kt_sAaDvaQhhxz0EJbZOw1QawUyKRnGnqTx3pwTiL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthho
    pehkuhhnihihuhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:F1rBaUU7MxmQdm3UP4AaazOnDul5_NqE2k0QGXti20smQm5ApIR4lQ>
    <xmx:F1rBaSBw7ej-3DgpMBgDAoKm46NX3Rf4e8TmE4yJLCIm4q972I_0IQ>
    <xmx:F1rBaX_L6-sElgxbUtdwjIkguHCUyQU75aWjy-yzW5-jSwW-7qh_cg>
    <xmx:F1rBaZHSOI9aIH5DPTlxfmgDI1xIZEP80PqO3_aYbDuJZGLD6iViGw>
    <xmx:GFrBaeOfaPseGpsQP0-uI-C1VdDu9WMsMR8ik2l_eNs9ZgJ-9LGqCIcI>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:19:51 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 net] rtnetlink: fix leak of SRCU struct in rtnl_link_register
Date: Mon, 23 Mar 2026 16:19:43 +0100
Message-ID: <e77fe499f9a58c547b33b5212b3596dad417cec6.1774025341.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 251BB2F7959
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.") swapped
the EEXIST check with the init_srcu_struct, but didn't add cleanup of
the SRCU struct we just allocated in case of error.

Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/rtnetlink.c | 3 +++
 1 file changed, 3 insertions(+)

v2: call cleanup_srcu_struct outside link_ops_mutex, suggested by Jakub

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index dad4b1054955..ef4bf017b098 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -629,6 +629,9 @@ int rtnl_link_register(struct rtnl_link_ops *ops)
 unlock:
 	mutex_unlock(&link_ops_mutex);
 
+	if (err)
+		cleanup_srcu_struct(&ops->srcu);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtnl_link_register);
-- 
2.51.2


