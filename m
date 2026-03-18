Return-Path: <netdev+bounces-268968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD0wHryCumnrXQIAu9opvQ
	(envelope-from <netdev+bounces-268968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:47:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1142BA292
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60CB03083DEA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E080739151E;
	Wed, 18 Mar 2026 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="N7qBjmOa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="10DBAmK2"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593151D9346
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830765; cv=none; b=QlLMhkvgBPRbQvMBQxdz4km4/KJu3w1Z1otsw2I40SMR4368qmF/b8S60MPk8yj/QUbWz43nlB/z76tjNELyX8mhx5++vo7lIWqFLNbL2RgBn9DNefsl+qxMzJFfS98OXhIykdr07tWjcUUFOxZXxOTsuNJ0LUGVvbAvgjD0UTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830765; c=relaxed/simple;
	bh=8q9nWnm04+gvYg8x6zxtciDoMYz/fjqJaaCpiZ0/Alc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6fcmF86Gsy32be/g7Ku40EFVyGsMZ+vvRV5wFtGucESstw8IPtsm6wB3JctzzuU1XFfrLvi6n5O9769aEpiPLn4MCE+/tppvyQfApCo2ELqXd/IHoCgLmrqC/LPVnLUaXqtQ4gg02IlGZjkFVuakIZP4ln35lYNgSC9RkuIW4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=N7qBjmOa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=10DBAmK2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 650DC7A019F;
	Wed, 18 Mar 2026 06:46:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Mar 2026 06:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773830762; x=
	1773917162; bh=mnTVGl6Nk6lwNJKrFClBZQ1SLnqr+LvOJGzfq9VQXHk=; b=N
	7qBjmOaqnMM7KvK/on8FEhHDWFfHuAF0Tn5FcUG97TmnvAga9x7xSwVjk5WLq3gd
	Q+jeVkENPr9tG36yn4fbwCt+hKoGVGylUP7Ou3MQqTcvprin+w4vjdHo1EICvP9b
	keDot4i0+PFlbtrkRP91a7vRXltWcPBFTPlr+J7KbeobJOp3L9ngsxNdmPAP9G4p
	78aWeUH03T1Jwm4tYcprL1yGM7z5l3Hf8jLuyAl0b81sp/uWAktC+8DNghAmajwd
	hsy2srApAXGGlFQQ8Tz+HBJnTtITeRFR2Yx6392UzOEbp2RPeiHTOryIm4GNEZQw
	tN3xfuf6jSPKxYhWRZCfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773830762; x=1773917162; bh=m
	nTVGl6Nk6lwNJKrFClBZQ1SLnqr+LvOJGzfq9VQXHk=; b=10DBAmK2V137w2geN
	Xc0TgiHy2o6h4gNpHUGlzRPLoMLWsGlkKA8adoEG8kLUDuujfR/PkrkQfbGtDOtQ
	NzolVBnmccOs/258MM/2gPXOmLqbTxI0MBP+g/x0+AFxHaZSDcbNqI9wiJwtO5tb
	EG+FnF0MoV6byyrWMheqcJhfbn6Is9JrzLY//jf/EbXrE/DEPPKy119I/8OLZ73Z
	T1ItcgWly3QArTz/3HGt6QsMUZ9tpITcmCpWUYf3psFhYpXgrZFRzRe3fvhjnlTC
	U96MyXwuTp3Lml9gUqgWZM1BM78zWL214LyRX24TqDPea06l84wvsjIQghTUpOec
	L9qFw==
X-ME-Sender: <xms:aYK6aRZ0yXGt7wJVqSxId0OwDTMg6FpTb2aPbyfRpM2n57480ACv6Q>
    <xme:aYK6afQXh6T5goMwQm4Dvpu8JFXRZ9uDV1vBILc8N9CCKz3x4CJ_uzu28cEtIgl4H
    6A3OKhiP6u9HO4R9eRuwNwLrnIq5AJC5GazBl7p_OprlZXaQFsn7go>
X-ME-Received: <xmr:aYK6acT9DL23CgmKQKMdLWpTWZ9PtrIpktAxjgsStw81TzG4DsYSLpfqsSZ1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdefledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphht
    thhopehjohhhrghnnhgvshdrsggvrhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplh
    hoihgtrdhpohhulhgrihhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehrhigriigr
    nhhovhdrshdrrgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aYK6abRO15ioFNew34135msH4-2hFWe8HyKyKOUdvp9FvhSpQePIZw>
    <xmx:aYK6aZ73Z19h1G4nOnQCYfmeIen8gmpuQbVJuieMzFEvaZCHcQJabA>
    <xmx:aYK6af27YFUivUtkI9twu5j_S2PsGW917xqm9HiO965T9rc_rbfmaw>
    <xmx:aYK6acCgikxWq-apl_h2u2-zwG6W1d_rbIb6vuo7-xw2GuDIPSn-dA>
    <xmx:aoK6aY4QMxU1LSTObS-WhDiOapsrJXnB1UtS5Y5FOdXv5q3wWLR6zJ6D>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 06:46:01 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: [PATCH net 1/2] rtnetlink: count IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
Date: Wed, 18 Mar 2026 11:45:52 +0100
Message-ID: <c8acbb1f4f3651f50fc4f5ddee234f1ea6769588.1773829376.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773829376.git.sd@queasysnail.net>
References: <cover.1773829376.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-268968-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,intel.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: CE1142BA292
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
added those attributes to rtnl_fill_ifinfo, but forgot to extend
if_nlmsg_size.

Fixes: 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/rtnetlink.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index dad4b1054955..a116362f5f32 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1267,6 +1267,21 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
 	return size;
 }
 
+static size_t rtnl_dev_parent_size(const struct net_device *dev)
+{
+	size_t size = 0;
+
+	/* IFLA_PARENT_DEV_NAME */
+	if (dev->dev.parent)
+		size += strlen(dev_name(dev->dev.parent)) + 1;
+
+	/* IFLA_PARENT_DEV_BUS_NAME */
+	if (dev->dev.parent && dev->dev.parent->bus)
+		size += strlen(dev->dev.parent->bus->name) + 1;
+
+	return size;
+}
+
 static noinline size_t if_nlmsg_size(const struct net_device *dev,
 				     u32 ext_filter_mask)
 {
@@ -1328,6 +1343,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
+	       + rtnl_dev_parent_size(dev)
 	       + 0;
 
 	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS))
-- 
2.51.2


