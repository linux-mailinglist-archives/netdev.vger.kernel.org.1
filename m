Return-Path: <netdev+bounces-289992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AD0ABrVDWrW3wUAu9opvQ
	(envelope-from <netdev+bounces-289992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:36:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5F759105F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D7F33C4F26
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643433F0A9F;
	Wed, 20 May 2026 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="qGB7VFgH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NEPHcQi8"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90623F54AA
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290326; cv=none; b=KH9AUg8Rn0opx1Cy04tngQQtTqf1vXHEOhXArz2mklZkAwoScE7waNbUcOOAvNCOBzqnXLVrhd6JWPhS/JLsYRdWScupCCTz8dLnvMz1XX0aRL0a3jYp2LNUdt0Gsz2MV0kXM2IndNi3mjRBTQEuJqVn4YjsXalnQkVBBjlkYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290326; c=relaxed/simple;
	bh=U4mAoz1/c91jvR0+i/Ssw51/uaWcKtAm5SRVRpmNklE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjJUSev68UlFqfeyTX4TNDzwx3eUuB1vAmj7Wx1LopBbZShOBsZTShMoV7hI8rA4wUryZz/xQYB9qg6oJlSUD4CeoJCmPxqKYf5GknFLd+B2FB7T0SH21IJiR3BWSXXQ/+H+r0rso7m9N8Z+EzFfveuC+le7V8CsgXhX/9edm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=qGB7VFgH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NEPHcQi8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3DEE7A0103;
	Wed, 20 May 2026 11:18:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 20 May 2026 11:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1779290321; x=1779376721; bh=ywv/tk7eF9
	QbTZ5dsylfWITkX8m8kEkEiXwGl0AkTu8=; b=qGB7VFgHrexoNV2UrPoL+FByoz
	kGFRzD+Jk1WGPneOxfQCQ/xRvmVLdg76LQPmaW5P6Ypdt0Ctup+F5nA9b1wAQVYK
	QlKQSSNlso/nQIYVGPbVTSrBmg19iHBrvCmPVnYOpfXdsr3cr5s10Zp2Hp7EEFpV
	EbHImf3Kp8avgzKyZHQA/GPeyd/vVPEw4w8wKY40VGhkcHWjmtQt86l3UQ81oWpp
	3DDHHAMmPY5sF5EYn7I9So1vMGIu+kQ2lrDDWfR7I4DXxGior+rOlqHbL5z6JwGF
	fNchpzXqXoWRF/K6eQONK5fzq9oop2fdjkPzic7ROkmFLfHSssHlrd69/Qyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779290321; x=1779376721; bh=ywv/tk7eF9QbTZ5dsylfWITkX8m8kEkEiXw
	Gl0AkTu8=; b=NEPHcQi8NODmIfYSm0TOP0q6BzAZKGvJwx3PwtzKyow3Q1hrDk5
	piE+zb+bWCmYcnf/b6Xaxh3TnYRCxaoyHMddnCYXoUr6Zwx5Wm5783NXc4xcwoC4
	XWkQHqan3BA27L5O5ezGWrHFMfW4+ASYCW6OM2zov/Fb/cKwL9tkE0zYZvyy1B2h
	YfsG/I/OipWeXLLOKCkcuQFIo5+Bs1CmsQMDGPznTNIolXIZIiJkysZVBpWIlQE5
	anWEvbTJv+vMh9bYDtY5wXkVEIWFqJdrbFKYHKpauYLTd3pVxFgS0vnp7yHr+ceT
	pgMGOhec8C7vFUjSnGeWzke/S2UzkMOmrqg==
X-ME-Sender: <xms:0dANakc7DOHKpi0oDkerFslaGlTWYmx2RZXjmYlOpaBJNH1PB0-WZg>
    <xme:0dANaoznnjl65KnA1q_Aw22lZqsARfk1o7yH_26HBMIUvLtAccHikCF0AF52zFlU2
    GE_9jngiEKV5feadBX6unfRRDTRUKMQ-_8HJLUqOooFx0fYM1wzwKk>
X-ME-Received: <xmr:0dANapIz3rDKhSMvJx0L0OA4yonvgH1Tm7n90KrLb7HeF8rcpkhEbSkC7RsugogfyXwK0iQSlIAIrcaBH6rYDnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepvefgiedtteejtdekheffteejkeetkeegjedtiedujeelheegueeludfgheev
    ledtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgv
    thdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnh
    gvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgv
    rghshihsnhgrihhlrdhnvghtpdhrtghpthhtohephhhuiigrihhfrghssehrvgguhhgrth
    drtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrsh
    hmlhdrshhilhgvnhgtvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0dANaqHWFSXeXoa-MgFp04inXZcy9weZmkTrDjTRYo4ezMi9ngMOwQ>
    <xmx:0dANal84DWV9nml_kPMjmtF_boHQv_nwn5N6z17inizrTEl5sI8efg>
    <xmx:0dANaqIQfFID6Wcf6WoujyRUMVo0leU-1S8lWHaLlqsb6ccJrRMnCA>
    <xmx:0dANajudIzAxf6t3m9fRieatc2vHEV-grsfTcJNPHW7ol5s1xKBR0A>
    <xmx:0dANao35FEkwFfzxnpAv0cBs5nxa3FA0atlR6vLhpjFuXC5gXWpO73hK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 11:18:40 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net v2] net: gro: don't merge zcopy skbs
Date: Wed, 20 May 2026 17:18:37 +0200
Message-ID: <9f5afc14ea4ecd22c70d6eaf279a94d10fe29448.1779289597.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289992-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,redhat.com,davemloft.net,google.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,queasysnail.net:email,queasysnail.net:mid,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 6F5F759105F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

skb_gro_receive() can currently copy frags between the source and GRO
skb, without checking the zerocopy status, and in particular the
SKBFL_MANAGED_FRAG_REFS flag.

When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
on the pages in shinfo->frags. Appending those frags to another skb's
frags without fixing up the page refcount can lead to UAF.

When either the last skb in the GRO chain (the one we would append
frags to) or the source skb is zerocopy, don't merge the skbs.

Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
Assisted-by: Claude:claude-mythos-preview
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/gro.c | 3 +++
 1 file changed, 3 insertions(+)

v2: as Eric suggested, don't merge those skbs
v1: https://lore.kernel.org/netdev/4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net/

Huzaifa has found this to be exploitable to overwrite the page cache

diff --git a/net/core/gro.c b/net/core/gro.c
index 31d21de5b15a..b22fb3ba7061 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -109,6 +109,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	if (p->pp_recycle != skb->pp_recycle)
 		return -ETOOMANYREFS;
 
+	if (skb_zcopy(skb) || skb_zcopy(lp))
+		return -ETOOMANYREFS;
+
 	if (unlikely(p->len + len >= netif_get_gro_max_size(p->dev, p) ||
 		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
-- 
2.54.0


