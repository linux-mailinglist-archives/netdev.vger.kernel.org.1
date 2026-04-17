Return-Path: <netdev+bounces-279373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fb8Nrtl4mlm5gAAu9opvQ
	(envelope-from <netdev+bounces-279373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:54:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6194541D5B0
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D925C30AB72D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B360C344D92;
	Fri, 17 Apr 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dbOVHUiX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LTHWONaw"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB93451A7
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444614; cv=none; b=TznTKKTNZqnzF6zEWdUKqYkOQISZohN5wxJbUQFVMBW7cVw9spqNQce1ew6AFiAetRQCjSmpxIvZhRZj24eX7qVXDTpV7M2TnQ9foIn2a1H+V+jTSwgw1ETp60Y3rRLhL1UU2wKzui9R8KFo2O/PCrd/fPhcD4HlYoDFcVJ1H0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444614; c=relaxed/simple;
	bh=HWU4VA4PID+RzJi4n84M6PNUrfn8WJ/8f1pYVu66Qf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+JH3ViXmO216OECjdC6/6wr0NhoAr1mYsRY2uRaMMS84KnIt5QIRww3UnPeJ9fwH/ZbzZLw8cdptONpKqM61VxWJYpoVQz2NBLnK69y/N1QVXkyzQK5URlOXWHhQVPNvAoaUogfblfQ7oCsShNgf+ijANUC/tfYW7mHX/3BKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dbOVHUiX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LTHWONaw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B72621D0016E;
	Fri, 17 Apr 2026 12:50:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 17 Apr 2026 12:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1776444612; x=
	1776531012; bh=blXRkcGhYdiTQaQ+9FGewBCdVAYGBG4i1C90fiC98n0=; b=d
	bOVHUiXsohYIZZ+umNwpEdZ8hKqaPZU7WcGl+GNMJnKYJhRGWb0f48oGttYO3C6i
	C5Kzj5u9FQjMkfnP+izOOmVTmSzUmBNncHybUId/+d9rvZrFt/qD7WUquFRx2u94
	2F1ioOjltA7GrOcNydk8ynZbkz6Gh9c0XLOvIEyAM/6OuQ+pGaFpVCkLpi7GwB9O
	7xfWD/M666fK4iVp4uTBQ8HdYaxce+7KVyilYMwtqTSSW5Vo+tGfC7X4rJdlzFCG
	u15FjzqNlLYLW1MTvnbbXuznJidhKa5264eG84Yu9BAAyMuPNYvpf9fWaxmqItMN
	sSr3ZdzHnk8LKmw9foTsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776444612; x=1776531012; bh=b
	lXRkcGhYdiTQaQ+9FGewBCdVAYGBG4i1C90fiC98n0=; b=LTHWONawJWLCVoPKp
	ejYcsZwkcBA9JJW9J5VpuTHD+HnHv3zuj9HmwlwAKbTRQ7DaHsFYscOWtfZ4yn+z
	PeaNGXUQuZHCuxGN6BH0kR0dohhC7SD57lZjDzeZSTLhe4swLX8vwj5VkJU6jz2E
	KC4V70eQHaUurUcUgt5zQgLxFD/wnxevoM0zrr60cV6DAHNM1XEya8+eAuY9LiuD
	gmDnX9dVFOTGP9M/MKcSJ/fwDZY2DPwBo2oL3HxSNG8Ki6dV5qLcvbgC6Oun8IUs
	ZnMb33yLKWIDiN+WEzy6oA3jL3RcjRd20xOcq6pAH2XvTwrcjHvEqUlCxaV/kGQD
	0R+fg==
X-ME-Sender: <xms:xGTiaSEMKsXPW5qAxTHABg_mU7X05cEd3LNoGHHviyhse4CDyfjfdA>
    <xme:xGTiaaWQZ-nAzicRJ5nfWUzVw3H0t4ITsBLNd_fSf8gYdLJk_f8cUA4EDioQtiDu2
    HGe79LlCOK4EthsMbAhFZVeonkaat0Sq89smgImphyXs6BEaLBVGNQ>
X-ME-Received: <xmr:xGTiaRLiEkl4ENfeRGx9MxIQ3VLd0q7_PMbSsJ6fDOSGUurnZ6ak0X2nsESbaqMnNemafcE7NG26PczIcqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugif
    segurghvihgufigvihdruhhkpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xGTiaa973vHNchlxokLW3jUQCcSMIKA4jSHT8z721M_sINIYqMQ_cQ>
    <xmx:xGTiaUIZb1OQDCIeFCYMaW2rVAJZZiAr7hAXFj3jiZQ27IMotMz_NQ>
    <xmx:xGTiaflabSrzn0PSkZF7NCKtJHEKufhkQOMO9BkXukMWlI4prMVj7A>
    <xmx:xGTiaYOFwqMPBXrJGDdzPUaC93ZWxEMkdRbq1TWyz3lk8JvmiGUnSA>
    <xmx:xGTiaY6aYx8Q8gBL4brRjkNkSkEjPYdkDnUqdq3LZY1el4nbNpoRE22e>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 12:50:12 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH v2 2/6] selftests: net: remove unused variable in process_recvzc()
Date: Fri, 17 Apr 2026 09:49:48 -0700
Message-ID: <6d8347cf7c991655b3abe3e73a62bc52af95aea8.1776444379.git.juanlu@fastmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776444379.git.juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com> <cover.1776444379.git.juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,fastmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279373-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.com:email,fastmail.com:dkim,fastmail.com:mid]
X-Rspamd-Queue-Id: 6194541D5B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove unused `sqe` variable in preparation for multiqueue
rss selftest changes to process_recvzc() in the following
commit.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 334985083f611..c15916311f0dd 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -269,7 +269,6 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 	unsigned rq_mask = rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
 	struct io_uring_zcrx_rqe *rqe;
-	struct io_uring_sqe *sqe;
 	uint64_t mask;
 	char *data;
 	ssize_t n;
-- 
2.52.0


