Return-Path: <netdev+bounces-261384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NYyGI9aoGlPigQAu9opvQ
	(envelope-from <netdev+bounces-261384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:37:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDBE1A7B04
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 708E23057E9C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816CD3AE70B;
	Thu, 26 Feb 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="2NEvzPDI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s3D0pIxS"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB372D8793
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116029; cv=none; b=cf11D0x08TRifGl3IWfLHBXDxJUtzWcSdEzRMzH9eooIimpoP/aE9bOg84y7Ww18Pnf7gmpB14A4BrxBX1VN7N4ICfDN9VDBHcNSVc2Jv8DjriZrOCjOOia4DyTNPttL9NCcqx41U/KuyoJbgkSEUg6c2c7+yiUi3YiVn9CUTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116029; c=relaxed/simple;
	bh=4/4re3hfT2tgAaTna+2xuDKpIKo2ks53AVQQ/3eWMNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+bIurdjzi8mEemotDTx9tGuZYuweoqVrosn6lkCxmbLEPzUdatwG6UjOG0sTs+c9eO18vHvJhxIyN6gBMSJZ+E6/21vGDHeE5XaJx+JrV94G3W7XtqX7atQ8ANl1iYceKqwfnFOw2O8tPWtbCO6w37F45Zls5iyCva4bcuJcr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=2NEvzPDI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s3D0pIxS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8792BEC0538;
	Thu, 26 Feb 2026 09:27:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 26 Feb 2026 09:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1772116025; x=1772202425; bh=mM41er6Stn
	kG2x3fxQtzxphRL3WkaFjpNNMVI7/16AE=; b=2NEvzPDINZdPnYOvnpRDkD2m2U
	HBVEel/J/kVLV5pkID/w12OqQZ61ID5wPV0hcRnYkqK5tpFZPvkd0kL+vIyUmxor
	ITDgjnRsWEALDh9tU+xDmEegKctd5kGwSMiXbzh8h8pvzSswZXZX6cqp89IW9PFI
	T3eLrKaHg+AJcMHdgbZqVNBISECSInQKtJmwkXdkhG4d7PzAaTABWrcWPxJ5wGXK
	M2RBhrjKXVKDmBx1rcI6VJJ6WDWwpIPBoUyGFTRgZLwx9lWXwE0sBo41PPcjnqnJ
	j5G0deA4aAIdrdiakHp58mJU4SKheZI/ZtdrwPATep5kU2kmKRa/lcccGKuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772116025; x=1772202425; bh=mM41er6StnkG2x3fxQtzxphRL3WkaFjpNNM
	VI7/16AE=; b=s3D0pIxSGQWUUN27l8AIbTZPHtPJbZSIqHG8QbkZWNlRnZuq0Ef
	Ky8pxUARk8EYYNQlbJEFoDZd1Fq1tgJcgdAWedjMSMYaQjiZklN1yv3juiINWf+2
	r6NsgM819XF/tUIain+eOdH+MQ6aJlTzGJjBL16i9NtMM6Nr2wsTIZ/Uvo2PG7DC
	+tZqWT8TujbnkwWFGx/QBy/LRYPx4j1X7BG5cjRH/dCtcSAwKA5zQCCDFjFyV0hE
	H32SdkHLXez2nSmU5U3oyNmLBIPnTGWfZ9tYKcS44JIdll3MhWcAah5brJUr//Sw
	zQvScGWA4e2ovnEwU8oFGY0NdCQoNdav3dQ==
X-ME-Sender: <xms:OVigaVvL6X9SqTQ8HAFU2uSc1rBwvQiNtwRqge3Z6hm3wgaBNToBtQ>
    <xme:OVigaVcYUkjsyWjh-fkpEMWnOlNEoLvwRuWv7pkOG7ikQSqP7sXHgIvMYY1AoA-rN
    qwfyuRWPG5UCBPJ5YZkxswCEcuOIdgUJfZacGF1aGWxCcq9BYBD6aw>
X-ME-Received: <xmr:OVigadyU8NwKIsPJmflaCanE7Z2YkNLeDw0l0w2pxK_yST_OTqizbgKjiMRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthho
    pehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehkuh
    gsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OVigabEXHRQj_rpdVbX35Xu9TBEc-S37CTnxiHL3pEWmOWTtZ69cNA>
    <xmx:OVigaRxSGba7w8AZHsBOe2iVk14xTcumqcvP0bHOX0v3IsOs7lvxhA>
    <xmx:OVigactr85AbDsmwR6ZrHNscr_pZ7_5pByy2BY36yCMNbpYdGHr-gQ>
    <xmx:OVigae1ajFuj_iDwEd4C1kTKxr00ng1XmU6H1gDDA0tGfjuUEdAcpQ>
    <xmx:OVigaWiyB4tvohbJY07XgiW-uBHe6yh1jv_EKzyj2YN0pcXrPZXButGc>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 09:27:04 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tls: don't select STREAM_PARSER
Date: Thu, 26 Feb 2026 15:26:27 +0100
Message-ID: <cb41e513a30eeaac0b419284cc87433f049b2ee0.1771871995.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[queasysnail.net,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-261384-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABDBE1A7B04
X-Rspamd-Action: no action

ktls was converted to its own stream parser in commit
84c61fe1a75b ("tls: rx: do not use the standard strparser"), but the
Kconfig dependency was left. The only part of the original strparser
that's shared with ktls are a few structs (strp_msg, sk_skb_cb) and
the strp_msg helper, those don't require building the net/strparser
code.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/tls/Kconfig b/net/tls/Kconfig
index ce8d56a19187..a25bf57f2673 100644
--- a/net/tls/Kconfig
+++ b/net/tls/Kconfig
@@ -8,7 +8,6 @@ config TLS
 	select CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_GCM
-	select STREAM_PARSER
 	select NET_SOCK_MSG
 	default n
 	help
-- 
2.51.2


