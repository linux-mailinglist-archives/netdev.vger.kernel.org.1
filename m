Return-Path: <netdev+bounces-266789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBksEjPusWnbHAAAu9opvQ
	(envelope-from <netdev+bounces-266789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:35:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B926AEC3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C1EA3012BCB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710E237703D;
	Wed, 11 Mar 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="b5/H7IZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rxkMeK4O"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C29261B9C
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268527; cv=none; b=nI9FWCmfq64UzzXRTpcBgUh+O2KhlqZ3zGENQk5v9140gDYw4HcFJzamapXRdwDJ3mcq2a2vIShHephVyJInuJwJIl9peUvq8jisCM0/XcNgLvhmas9xaVDVGEaBVlYkjh5hcYPcLRzOaAONgQ1gh9nRkLy6l8T+naWNf0b/KU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268527; c=relaxed/simple;
	bh=B3GZt+18ohZmZ817GhID/iqk78G6iS7WqnQCmd4FwzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=li0j3sMKUfpqbkMHteY2+aUpiMM2QkeRxp1wsdBHW7lA4YePJ4bhZSUkoi5Wk5B2ZnCP6tCvCeCWScvalntO/eGVoUrLk5v70u5EKMeUbrSJIXMs+olSTqEQWjgPhlKHHsr9EolGkt7Slkk7NMTCM5AlWXi+JiFGrjgeYHPVy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=b5/H7IZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rxkMeK4O; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 80926EC000B;
	Wed, 11 Mar 2026 18:35:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 11 Mar 2026 18:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1773268523; x=1773354923; bh=UJGVqkir6v
	kCm5KBHvhN/Ep6Jgdjuok9JaBPunFjpno=; b=b5/H7IZWFI7+yZ7wrxI9PbabAt
	K2poQrkp1xGMuD64pZgFhkCdZ3rw8sGVC1Hyb65jzSB++DImIcfdPca6xtfYAfaK
	ofPrR0Ru0Hv0YUZkceMmBeHAeNAp1BIxix/nnLJwVJAzAYf009jMiK22uj3fb/MF
	pqctfCnq6JjRsB8hZOuWNMhNXx5qBQg+ZaI9FXyiN0x/8d820AaaqaG1Bh1bLArl
	TT8Dpy6CdOpR7pgFDzZAMNxPmbTLz8j+LhyikoQ9Z1147yinibmY9sCyf/ee2aOQ
	DlEbMNB21EXChFgZLlNPAdG/DXURt+bwbBUrOOnCLKIciuGLVQABXkQeXrGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773268523; x=1773354923; bh=UJGVqkir6vkCm5KBHvhN/Ep6Jgdjuok9JaB
	PunFjpno=; b=rxkMeK4OuAra/iqBtiAwYiyto+IC+H0OqY4tdlevLSBo09Uxqxh
	8Wiu1IVHyLEv3rBwEq/7Da05YWs3ZuOp4x73TIi6ZTJs8MBnWbyNo1uB+4Q11MQf
	QSYw+XIlM9jQKJSpsaCNBXpG6kWKrjKLlXwyZP+aBWAX9puiR5EmgcJ1g9mtFg+7
	g2zvYevxtVezetfbQlv/aeH2vAAftm2m543nJkvEajoxyfqDAh0izVawVYu2j+2A
	A8hk5M7p6gcvRXugIBpZAmFiHHxH36i6YMrDm7SFSJXTC6XQQxFPYQGafOzRhEHC
	5xtb5MTUTPLWBZZQCyMOSFwgzRjbOdgKX/Q==
X-ME-Sender: <xms:K-6xaZ4b6qEVjLNt4zw_0OhcLsdkFdWzotSMHfRSuk2DQQ1D9U6gXw>
    <xme:K-6xaeWt93DIRlFL0_qqfdjfzkQ6LRQaK69Mw0tchFdAxHxcymaLimDQ-V4u-FqQM
    xyM01GyQ5z-EJbWzHvRFtxFzf8lf3PxRNDmYkk62PG1sDrtk2INwyw>
X-ME-Received: <xmr:K-6xad3QSrnl_zDkYjpUkNiDJh6XUmzF-K8hIVwzOr6ASd7ulu9g0KgnaajI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:K-6xab3_BzfDXKjFphV6gC_XWV07DNv-eS2jktEE1b-TyLckmA2eDA>
    <xmx:K-6xaQ8tybCftip-AiUdNpXq9bNf3XwYEVgoSK1hoxXvL_xn1NsMzA>
    <xmx:K-6xaY0qiZqZaKYxTX3Kxx4Rl8ujBcdExktk73rBSwSMlBnUr_9FVQ>
    <xmx:K-6xad_VcPYCK3xSkitIMFFme2QimwizfJULLyKDqF6io5ixXurPUA>
    <xmx:K-6xafj4nNxH-i7ZXCGyVd-TjPYBE0S9XRAP_oS_FZO_3hPMfScLbPks>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 18:35:22 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net] mpls: add missing unregister_netdevice_notifier to mpls_init
Date: Wed, 11 Mar 2026 23:35:09 +0100
Message-ID: <7c55363c4f743d19e2306204a134407c90a69bbb.1773228081.git.sd@queasysnail.net>
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
	TAGGED_FROM(0.00)[bounces-266789-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D12B926AEC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If mpls_init() fails after registering mpls_dev_notifier, it never
gets removed. Add the missing unregister_netdevice_notifier() call to
the error handling path.

Fixes: 5be2062e3080 ("mpls: Handle error of rtnl_register_module().")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/mpls/af_mpls.c | 1 +
 1 file changed, 1 insertion(+)

Sorry, Kuniyuki. It's a bit unfair, but prior to your patch, mpls_init
couldn't fail after register_netdevice_notifier :)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ef9e749d5e08..d5417688f69e 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2854,6 +2854,7 @@ static int __init mpls_init(void)
 	rtnl_af_unregister(&mpls_af_ops);
 out_unregister_dev_type:
 	dev_remove_pack(&mpls_packet_type);
+	unregister_netdevice_notifier(&mpls_dev_notifier);
 out_unregister_pernet:
 	unregister_pernet_subsys(&mpls_net_ops);
 	goto out;
-- 
2.51.2


