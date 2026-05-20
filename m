Return-Path: <netdev+bounces-290102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIvZOF0dDmpT6AUAu9opvQ
	(envelope-from <netdev+bounces-290102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:45:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D159A0DC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A2A230193BC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7936F421;
	Wed, 20 May 2026 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DuSvPyBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDes3Jx4"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062E36A34D
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309895; cv=none; b=XU7HlraJox6L4bZXpQ6Cf10vNAQetWN1UWoF7h0qnF+DYV5+AAFkpA02+oSJQGQ0Rrwum+mn6HQ+y7/E3AtbOf4f3zEepRkg08SLPxvClvmr8uDzb5XTFM040zaSVynFjWxL0BtBwm0mkcwHYiSs78c2lSA5zsF5KGsrZ6y/h5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309895; c=relaxed/simple;
	bh=+O8MAv14pMuRBsL1Pc2yMzFNGBar6BQMqDJrwqgJnNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXTo2vp0WSs/4MBPbrBqjtWaAMV/Qz8VyzY7ZgYeI67h6hoOHdnpFksvxZtPtHWmAWc70TvEEO3h412IUml5P+Kapk6MHkUT7h0xANhD+PO19rv4xoNUmtNfeJjA9VTf/rWPUH2jk2F0GnfiBQl4iHk+FaB2J3nBxUbc2SwSlFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DuSvPyBN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDes3Jx4; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D916E1D00078;
	Wed, 20 May 2026 16:44:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 20 May 2026 16:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1779309890; x=1779396290; bh=pFYuzxZEyp
	hWFvnyVIp/fTNvm5kNeUip0os9Gb52Z9E=; b=DuSvPyBNYvKCbyO9l4ED2kYoHm
	+uHbW4KHs+K8z71P3kKJKAG59+42lmFXi38Xfkf4X8oGwjWhredTYqfO3hCIcXRv
	TuE+pwgSWR3z8eSeHRV5khDzHdeK9M+xqyM8Vgz1MwKdsNGvBfHbMeYnlEU3gt4d
	1QF2FpkBSHQniqwZKtQXTF1QnK4EzCzPdKLXKVM8b3MVl58Ts2Xp0pDHutydtv2N
	Ms0By045DesYVoNDnhmpZMkkkjWCSWC3ZWS0haQQsceHvzCt+AWbOmjHTgxcCm/D
	4srumIvaw+171r6Bqo/KP5gDIBHeHD33Xey37PW7ptaDEi2xLjtMCbfMqCTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779309890; x=1779396290; bh=pFYuzxZEyphWFvnyVIp/fTNvm5kNeUip0os
	9Gb52Z9E=; b=RDes3Jx4BCOu4iIK8PQmH9vDnvpLGB9YxGvo3iHKssJ1c/vscWY
	wZxOsP5E9rVcbzj3nuKeoWwBf1IRUuor5SP0sZHrxFXY5TsjEtU1423P184NzVE9
	cRVS4nIUV4a5RTKm5guK2KcoerRb+GoNodHQ83Yik+BKUDDpdsWxGxTIIik6cnoR
	/hhdPDbtLtDd+50utYwIl0R/SssQaZk/TBM5XLE6wCjRfzo5NRPipTtvHsfO0nK6
	XF3zOPjA/DZh6vmgSR8RdsfzEKv9jNJW1Y/2ZQRDSzvp2msjzj1PMFTM800bLAbm
	jQ8yVRm4ZnN8IaVkvODaREXAQdHfNaCUuuQ==
X-ME-Sender: <xms:Qh0OaoYnT1BtKjWkLVqmZUBemQlMfr9w-ZesGwtXdK6_p1H8nr58tQ>
    <xme:Qh0Oal8YciUHoMJ4Rft-kJ4o3MSFyvT0ZLEydCRAwrBXkMENDitKs9HB43bJXSR8m
    vc2Zjwp9qdYTtQftHXA8wd8QZFFG08XfUwprvuXCZu5qdLvXW2yyw>
X-ME-Received: <xmr:Qh0OammPK9SGG4ee7lIFEtSo-RmMHrclp-VUSzAPLwoZM_uv43palUfDL5M52kGaHNTsLuSyA1uhTzaRpsSy-os>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehiedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Qh0OaiwbvckxOnu4lVsKt2l9QBecBhf3UsUo539aBUKK2J2Q9hn3GA>
    <xmx:Qh0Oao5J_oGOhlCzImYt1n1ClTFakj2Z_wwQaJKH1ukxI1WXrIM1yw>
    <xmx:Qh0OaqWb5NNi0qt8snPU-EPHKtQJVUXdW0wk-kux32F9emfd_ZO1Xg>
    <xmx:Qh0OaoJ_T_dkEGwpXxG3UeE4GCEGPXNIx7AVkByv3mzjQ9SnXXAhsA>
    <xmx:Qh0OasiBl3bkAuEt9UvQfQFvaSFa4Ynd9u-5jbWF0yGQDgHAoUvCG1J->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 16:44:49 -0400 (EDT)
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
Subject: [PATCH net v3] net: gro: don't merge zcopy skbs
Date: Wed, 20 May 2026 22:44:42 +0200
Message-ID: <c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,redhat.com,davemloft.net,google.com,kernel.org,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290102-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 582D159A0DC
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

Huzaifa has found this to be exploitable to overwrite the page cache

v3: maybe no stupid mistake this time. sorry again.
v2: as Eric suggested, don't merge those skbs
    https://lore.kernel.org/netdev/9f5afc14ea4ecd22c70d6eaf279a94d10fe29448.1779289597.git.sd@queasysnail.net/
v1: https://lore.kernel.org/netdev/4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net/

diff --git a/net/core/gro.c b/net/core/gro.c
index 31d21de5b15a..bae89062a053 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -109,6 +109,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	if (p->pp_recycle != skb->pp_recycle)
 		return -ETOOMANYREFS;
 
+	if (skb_zcopy(p) || skb_zcopy(skb))
+		return -ETOOMANYREFS;
+
 	if (unlikely(p->len + len >= netif_get_gro_max_size(p->dev, p) ||
 		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
-- 
2.54.0


