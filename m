Return-Path: <netdev+bounces-266355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNTSKlKUsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:59:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A36F258942
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF8AB302926B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348273F20FB;
	Tue, 10 Mar 2026 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="vfEOtsx4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KXt0VkDh"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAA3D522E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179977; cv=none; b=b+v7cQDFsnWPDUPuSE1XcczjqmhQej7GBoTwhfonssONipLH7rBn/bfqJemLGm3ZuxCpH8NPrSelD63qEfbyo7+TniW2QSEp1E3w8QVQcak4SLnVeKjs+TXG36L1cVvpi4NFXtE8ObOkRwLdfbRLdYijKd5phn24zYGLfywktmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179977; c=relaxed/simple;
	bh=FyZZFrnM+G59/AiQVm89JBISlpHSnbGHrXkAV6OKDGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqXLoeiz5z4+T1lbTmwJgBFRM8xEodOPbFfV5lRB847TYp7075zUI8kh83IsWMD1uq25hy0owvNGt/HgRc7hd0R6pAASby49XdCRR0C3OQNnoU8qoc8i18JzpdFaPpjFzlP/6/kTtEK9C+USXHkpgZfmgq+T9KS1FydwIFxTni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=vfEOtsx4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KXt0VkDh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7DDD27A019A;
	Tue, 10 Mar 2026 17:59:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 17:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773179974; x=
	1773266374; bh=DpwvVZIuH2MWawVaGSFtOvPRQz9WFVT7aLzOytfjH2w=; b=v
	fEOtsx4y96CbteJm9BBRjm2bIp2yokMc6gOndGjHaJ5sMih3a+p5MPPZUkEgGfMM
	hwVkrXZFCw3jZ9g1meg2gmHX/vopRc7/6IUsuOoVb8mRdBoLUrSX3eSqWqDY6ei5
	IR1dkpx87Nm4VRtPvgybJjYfMeGIveMVdsyDaEbLs/YHHFrGyp6DqYYM8/MagCr9
	3H+jQVAB1OCyt6IK5gZLnVjn7ZrkUHfkZtQfxg08tjjlIWfRF4mdDpW0VZEj8uHV
	0UJfLFwQPCAiBQIyYWcOdpILH9y/7el8eCpvOw8fGUiXR9ZA5lqtsaSAVLZGlE06
	81c151eB73Z5NZKtXGsSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773179974; x=1773266374; bh=D
	pwvVZIuH2MWawVaGSFtOvPRQz9WFVT7aLzOytfjH2w=; b=KXt0VkDhOK6gQyyUJ
	GaDh+gR4twkA/fNojnmoEbPH4V2iNJJNzDOHaDHWy921Zj5pI+vk6WcgBZqKHKXl
	a6DZtGrK5Nj6bdHNP/X399KgVqFhcUVwyoehI2NsRRy58Pe/tVRym2MAFU2afBDF
	EKMhO2pPCnJTT7OBn7OgbieDVdpWwnZVVjPHJCoBF/tMeZdD6PdC3tms0JOsMVmW
	RulZ0WjXR2B/Zv8RcE15ZP3HRvttNN8vFM88dLMPxkKyH/xr5cv3z5IQuC4vHDMa
	Stp46x8V/AyHoGmCTIDhZC1XRkkc6H7ETPruJ5p03Yi7KvjXByxkDU6qnlXXtSe5
	YEpbg==
X-ME-Sender: <xms:RpSwafFBF9BF1qiEO_y7ohR_G2Y-08-TRPSarx756sFhr-yOwrrfXQ>
    <xme:RpSwaTVagKrY1FuwalC5kMRLIBOoEgGwnAKpzu_ZqhLk8bs3_02dD3mJyvTkT7K9n
    g8obpRAgZ0AA9UuS9JC2-opl7mkDDEJQYEoaGCxty5ieJy_IJg0ncg>
X-ME-Received: <xmr:RpSwaWIUeHZ4Fhk_i0cqwfH-ptCn5y19sfSi3X6dvCzSdVZLQqDefzO5JOiF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphht
    thhopehkuhhnihihuhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepughsrghhvghrnh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RpSwab_H6PIDHz9O1pu3BT3fznUVSRh21rDWu7udHN3Nu3pKBULwxQ>
    <xmx:RpSwaRLc5wOj0YP9maqNMMkU3iKXGuYzsuk5p6r0ZGLb7s9zXhSmfQ>
    <xmx:RpSwaYktn8T3fSkb7Iy-JipDp8GbtqU4pNxtoSy9U6J3YzCHwF13Vw>
    <xmx:RpSwadOM5grfArtDO5qIvRc3m_RVvoupKQyrD7T1Q3yaNdZIKQPujQ>
    <xmx:RpSwacVxCFv_DB11MbuIxHmf-mvgl-UCJgSslYIe_d0m9g8HoieS0ly8>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 17:59:33 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net 1/2] neighbour: restore protocol != 0 check in pneigh update
Date: Tue, 10 Mar 2026 22:59:16 +0100
Message-ID: <38c61de1bb032871a886aff9b9b52fe1cdd4cada.1772894876.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1772894876.git.sd@queasysnail.net>
References: <cover.1772894876.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A36F258942
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266355-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid]
X-Rspamd-Action: no action

Prior to commit dc2a27e524ac ("neighbour: Update pneigh_entry in
pneigh_create()."), a pneigh's protocol was updated only when the
value of the NDA_PROTOCOL attribute was non-0. While moving the code,
that check was removed. This is a small change of user-visible
behavior, and inconsistent with the (non-proxy) neighbour behavior.

Fixes: dc2a27e524ac ("neighbour: Update pneigh_entry in pneigh_create().")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/neighbour.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index a95cfe77f7f0..c56a4e7bf790 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -820,7 +820,8 @@ int pneigh_create(struct neigh_table *tbl, struct net *net,
 update:
 	WRITE_ONCE(n->flags, flags);
 	n->permanent = permanent;
-	WRITE_ONCE(n->protocol, protocol);
+	if (protocol)
+		WRITE_ONCE(n->protocol, protocol);
 out:
 	mutex_unlock(&tbl->phash_lock);
 	return err;
-- 
2.51.2


