Return-Path: <netdev+bounces-281527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPa4AX3o72l7HgEAu9opvQ
	(envelope-from <netdev+bounces-281527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:51:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F17E047BA1F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1054C3011743
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4550E371CE4;
	Mon, 27 Apr 2026 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matanco.space header.i=@matanco.space header.b="lWi6L1Ax";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dvUJ8O+F"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2689308F1D;
	Mon, 27 Apr 2026 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330297; cv=none; b=ZlmjUJdGgURwag+xGxgxvd0DdE7NL0R5XkPU5/8UrsqYiMFcsF5aSDp645Jxy7Iw4jBVRXK7+RjDVhBoaK3HQz4CUJlakWbIII0ky9a7b84KlcOfp3RT5OsXDmqtPXBo3dGKifwOyFu3lmhfJLw/W0LMolkah++uEmSqrzVUAZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330297; c=relaxed/simple;
	bh=0rU2Fa/FOve11ZoomfUo2pat9NKsvDb5AkumLD865Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUXvl1drzoeK0V6TZ6DjuH/BGdWeFRPnr4wpvmAP7kSx7+yJlQ53RzqChHIhWr0URpoC4vzmtyPkWI45VObfFkkuioJRjdYFcy/mT5/qe7PBlbS7whEeOQ44VYpiPiulj62fAEIcTg4EL8Tp4gGJyad2vtec/BMO+FtSfBRvu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matanco.space; spf=pass smtp.mailfrom=matanco.space; dkim=pass (2048-bit key) header.d=matanco.space header.i=@matanco.space header.b=lWi6L1Ax; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dvUJ8O+F; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matanco.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matanco.space
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id C1EB71301075;
	Mon, 27 Apr 2026 18:51:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 27 Apr 2026 18:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matanco.space;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1777330293; x=1777333893; bh=TBr8zfQdpD
	gsi4t4J60NknBWWQ2et6GG2T+r2jxKkSM=; b=lWi6L1Ax3bPhlGpV7nUi56E9Ht
	dXnHt8SLQpc+KPL2NErU+PP/E7UbPmf+dfRZIhsDifhW2RtwWduWI5aIHCj5gwqp
	DXf1ucDPxNdLczgFOhL6u6bnJO/+Rgfry2Rp9SP9Hd3uUJ+hMdjbqcAe15D9nMr1
	7LxbW6Juz/p+qHK9zCaj/VVJ7MQsNQiWbmqBeR1TF8HBV5u6NhyrTztJGphhE5Cf
	1lIxprynu69deh+DKQGiKxNAxi2NEg7ulqx5dZBsBI4prWLmdhGviEAuolx81ELu
	CazBtD4mBHWDqZSnJJStPFLKgLx40o5fs+63l0l6P7QaIN4M0rGCOgGbP2Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777330293; x=1777333893; bh=TBr8zfQdpDgsi4t4J60NknBWWQ2et6GG2T+
	r2jxKkSM=; b=dvUJ8O+FZL5PVlQupWCeQAqvgzXwapnt0sefJPz3Cfs+KptdPMb
	q2EiMWIBreuTD+ztt+1/beygSmKqOohTa343UVX63DvPstNCiYEFhOeRpdqK4Y+Y
	cy2RXoWsEF4J2oi9m9qYHiuGlOp89uaErB4IXaU7+kR8sE6W8jGnUBeS/Qz8Se7l
	vag72o45AgoYOkaYtoaja9r1sBJL7+pPh6BmGskTbW0OUQB5WCFLRWLxKqOZwefq
	y3qVPoiJYG9u8Bl3pAuHLSCeayqO2r786Uc3CAOPnG5cE63+8G0zzyxeAnPgBbaR
	lQyetcAZHMDv3ATUwg+/qFjNY1tA7N9lOuQ==
X-ME-Sender: <xms:dejvabwdRc5fNhCAYZcCl6zDfNpVeET2nkA44ha5gdoWM8KLVTy6kQ>
    <xme:dejvaYcfs4XIpmV0xakK0IIjkZfU-7etOQl_yfEqO_2k8TQ6ZnhZrgaNj4nw_AAsP
    blueDMXMbFRmB27YaN5KOSHEcy9Lc9SZ9OX29OFN0PDPXskQZs3Kpo>
X-ME-Received: <xmr:dejvaWO0w97F5PG9a9KzkGTpdPFZIHCTGq1Ak3dMKCM8qSK8OJ7jvR-heUmdB1AQ6LtzA7_WnMANlM29adHYFvG-uWhOMGC6MOYy0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejleelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepofgrthgrnhcuvehohhgvnhcuoehmrghtrghnsehmrghtrghntghordhs
    phgrtggvqeenucggtffrrghtthgvrhhnpeefkefhheehgedvuefgvdeuhffguedvvdehke
    eugeefhefgudegieffteegjeejteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehmrghtrghnsehmrghtrghntghordhsphgrtggvpdhnsggprh
    gtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsgho
    gidrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmrghtrghnsehmrghtrghntghordhsphgrtggv
X-ME-Proxy: <xmx:dejvabsQbFXnI9kmtrJ9CqPrOgycu2FOS8PnrG6db2AlwWasfI2IQQ>
    <xmx:dejvafABIz8sYHSXELNYIIauCe6J_1aL0z69AGjXGB_aE-Znds2YkQ>
    <xmx:dejvaSZIA8Y-MS98vHOCiaHo2oCBdWt5tVII99TeX1bp_xJ-dVbfwA>
    <xmx:dejvaaWRzMYDb_H87p72N5plyMszOAWVVSIIkJYa7P_UPwPt8CF2ww>
    <xmx:dejvaVZaUzyOpyl2rj5UHTfbc0ioO9iTqFCzKkQIrKzTVmnnenMi-qXS>
Feedback-ID: i07264b6d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 18:51:31 -0400 (EDT)
From: Matan Cohen <matan@matanco.space>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	Matan Cohen <matan@matanco.space>
Subject: [PATCH] net: lwt_bpf: replace name-based BPF program comparison with digest
Date: Mon, 27 Apr 2026 22:51:19 +0000
Message-ID: <20260427225119.13733-1-matan@matanco.space>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F17E047BA1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[matanco.space:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281527-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[matanco.space];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[matanco.space:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[matan@matanco.space,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,matanco.space:email,matanco.space:dkim,matanco.space:mid]

bpf_lwt_prog_cmp() used strcmp() on program names as a workaround
because delete requests rebuild the LWT state, creating a new
bpf_prog instance for the same program.

Name comparison is unreliable: programs with the same name but
different instructions compare equal, while instruction-identical
programs with different names compare unequal.

Replace it with a two-step approach:
- Pointer equality as a cheap fast path.
- SHA256 digest comparison as the fallback. bpf_prog_calc_tag()
  computes the digest (instructions with map fds zeroed) at the
  end of bpf_check(), so it is valid for every successfully
  loaded BPF program.

Signed-off-by: Matan Cohen <matan@matanco.space>
---
 net/core/lwt_bpf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index f71ef82a5f3d3..6999da98b6b97 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -494,17 +494,20 @@ static int bpf_encap_nlsize(struct lwtunnel_state *lwtstate)
 
 static int bpf_lwt_prog_cmp(struct bpf_lwt_prog *a, struct bpf_lwt_prog *b)
 {
-	/* FIXME:
-	 * The LWT state is currently rebuilt for delete requests which
-	 * results in a new bpf_prog instance. Comparing names for now.
+	/* Delete requests rebuild the LWT state, so pointer equality is
+	 * not sufficient. Compare by digest (SHA256 of instructions with
+	 * map fds zeroed by bpf_prog_calc_tag()) as a reliable fallback.
 	 */
-	if (!a->name && !b->name)
+	if (!a->prog && !b->prog)
 		return 0;
 
-	if (!a->name || !b->name)
+	if (!a->prog || !b->prog)
 		return 1;
 
-	return strcmp(a->name, b->name);
+	if (a->prog == b->prog)
+		return 0;
+
+	return memcmp(a->prog->digest, b->prog->digest, SHA256_DIGEST_SIZE);
 }
 
 static int bpf_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
-- 
2.43.0


