Return-Path: <netdev+bounces-269105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCleCXPYumkycgIAu9opvQ
	(envelope-from <netdev+bounces-269105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:53:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 800522BFAC3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B48F434D363C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6163FCB23;
	Wed, 18 Mar 2026 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DY9orxUg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ugd2nc8d"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232353EF0C6
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850530; cv=none; b=aeI2cxtbDkwuPYZ6z8qhCKhudtIaX0i1S3MK1qLXKihkdliLOEfL9rek3KAyxkCO0L7TJ6HGXkHOADbM5C8xkM2B4AxpkzVVypxgRJnZ/mHUMgVMtv4nSLIO20hF6AzfJUnd70qCNT09yDrtC6LLFPMCdowPbBgfCmHxVasjsLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850530; c=relaxed/simple;
	bh=9eGUCcbgPQSumH1X0QlKgr3478YIwFVcRTIB1ZC0QTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pe4SkeYXSwqboUYw9QN5p3HHPN84/nMAtaBHcqljRd/aZ1aZiuBulmajqXtcMs/aGb1Aq4Jpi3TKY2NPPmAJ8u4numxNu9ddDIfMkqf53NhFiPH+q3KjFIDiIuFZ5vvMCXZLZub4INV/5EpVdIpQG1A7Hvt/2+qEH0ujJk1//Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DY9orxUg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ugd2nc8d; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96E091400046;
	Wed, 18 Mar 2026 12:15:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 18 Mar 2026 12:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1773850522; x=1773936922; bh=YuNPQfoGoJ
	gKz2yatcKU00MfVpIafY1RGpVpq+j6KT8=; b=DY9orxUg5cO1F26WyBvq/3whUU
	wQevgV+3ZNzlf1q3bwZiIxEhanjZxIyA04Yxd1lDKov09VH320sQIaHQdeNiMZII
	4XC9ov+PDdRTSuWON628+03u2SIItXgC7yA2teNZMDWLIi9CSWOI1K5PL09zHtyv
	fT5OYKZbadInC/QtzJTJjHVjMYZpt2u5fu1iYQ1J85OEMfdBHQ4sGg2sBsEBu3Qx
	V6gEV0K8zdpUjgKNrpRcu247X1QfreISku/j7tRnODz2UIB4+jnKd4jxj5k7nU5c
	bC9+v2ql2dKOfXXMpKHTNh2okMJ1NnVHsoLEWjfmDfVbyviRqImSDT9auCsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773850522; x=1773936922; bh=YuNPQfoGoJgKz2yatcKU00MfVpIafY1RGpV
	pq+j6KT8=; b=Ugd2nc8dheNRzYGk4A3oLmzKu2VXfc4EJ26u/aVTuEdUbQ/SPTw
	TEOpDYN9WOij4kJMHbEs1qoq0A7IJRF0yImz4un3zQ7tdIPFHdihCAH9QCIKpN5k
	qzNLkFkeb3Sw2nSDSOjx8yyM6RUevpnp/sJsRVS3uy+UKkNpvuVHNW4Hdl2taPTA
	fv9V5T0J4y2Az1T2B3tAd2DBBbkfRB97Ew1ARsoCWKFtQUYZIiMB/Yu01UNZ3BgF
	GJ75VLHPvIKdtNUGZvLcNU/NTO8Jyx02bPngyN1gtj+jgw6IJ59joMaYDkKrO+G4
	9w/4+a2B0hV04AlJWuAnt+GWqcvZei9hSfA==
X-ME-Sender: <xms:ms-6aVpuiAnyTQqFRAgOJKvd-tFdteQWA9Zwti6pELkWCvuXhUXV8w>
    <xme:ms-6afHPBRuMBB9IfIiZ9OETQ85lwR9Hz55cEKTY_c4hQzqooyNvFxboTX9cw5vek
    wJj5VhBZQX03hgit-6GA0i0Q7t2iiq-HNQSVOy8htYF8YDNEYIvCVo>
X-ME-Received: <xmr:ms-6afkX9p7hHiKGfcJ2iY464CZHb_bkwfn68SvlU1hcJeVtf2_o1hkjSVuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthho
    pehkuhhnihihuhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:ms-6aaluqLiqB4kNZMdOx4sYhgboP5va2t1P6r39md13SMzhX9AMrw>
    <xmx:ms-6aYtvUO8kujKi01ABheO9w14suCkor-mKHvYC5A5KlZKHE5dQqw>
    <xmx:ms-6aVnhK5LTOqnQ_duzet3K69iv83TDpDRxMq3h_TTi1ny8lcYhFA>
    <xmx:ms-6abvyAwMRPsSH6MT09HFQ2by6X6Bf2UigzOdUx_YGnmqTp2pCqA>
    <xmx:ms-6aaQwlH3kriqsj4ajpGcoPFwaHD_Xo-_ShAWt3xwrzwrjTOQS8TKw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 12:15:21 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net] rtnetlink: fix leak of SRCU struct in rtnl_link_register
Date: Wed, 18 Mar 2026 17:15:15 +0100
Message-ID: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269105-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 800522BFAC3
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

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index dad4b1054955..8072a43196ef 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -627,6 +627,9 @@ int rtnl_link_register(struct rtnl_link_ops *ops)
 
 	list_add_tail_rcu(&ops->list, &link_ops);
 unlock:
+	if (err)
+		cleanup_srcu_struct(&ops->srcu);
+
 	mutex_unlock(&link_ops_mutex);
 
 	return err;
-- 
2.51.2


