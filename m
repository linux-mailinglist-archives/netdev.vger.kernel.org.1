Return-Path: <netdev+bounces-275198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMQfE+ob0GnN3QYAu9opvQ
	(envelope-from <netdev+bounces-275198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:58:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAED397FC9
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5F6C30087D9
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8913A3AA514;
	Fri,  3 Apr 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XnEozkJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWtlUcHc"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FB28505E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775246310; cv=none; b=Uo4Hn23ywxwt11HYpyk/w1YmiqHjjOobyiU91ZhYmcyAOBmVUnb5OPjCLmRn/KBzm+KAMsGPZoPDjDfQTAPDOw9zJcOARoXbvlWRS58WBTBSGZCVzOiv9BzsoXFtbuByGINtITdaeo50u2orFJXhnF0/97H8zexHA8LGh+nLF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775246310; c=relaxed/simple;
	bh=x62Eavkmz0SkoF8wT21ADnynD5Y4uXt9DhSnEgPAvNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlrLMFwMCxGoDhecoElL42o7Blquyk+gfi0z6DdijKbT+Vbb3YtSJO4COBKBmuepRY4jRfcD90bU1M4MeRKlxbjYuldoP7ov6md0HM4hCRfZFdldkhyre+n363Ko7srn57B95Nkj/fw+zbn27rdKW96OXOxiX/D3R/MSJFQOURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XnEozkJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWtlUcHc; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37F3F7A0129;
	Fri,  3 Apr 2026 15:58:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Apr 2026 15:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1775246307; x=1775332707; bh=y8w9sOgxlXszWUu5wSKj+
	Z9HCoYTPQ2KsCb/qnXdpEY=; b=XnEozkJcIVWsLNyJxH/q58hhyLVCDlxa3+VE6
	4zclXN3qq3hSA+f0NVVpvtsEWSHBKZJStKKcfacKp5okroobsWdymXKRShtfbxb/
	LWMTtgXkhjbhjrduyeD4JpsXCpgI8WSLoAIyYUR5oU99PvNE8RqvBIzyYQMJ19m0
	PWNmQSywCjyiiqu/8o4qzwtFewZyS3JODbSknA2CQ6izCM6YB8SOFPTD12ZpqLjx
	o2vtlzVbZXws9B/ufBBjMF1eb5UvQ5Z4ls/T/7zb8JN2trZIPOP1eRzAzZYwdgz6
	fJlXKNNjil6WlSeGNzZ+EHWwzK4mW+dGMfqhgXfdQ+8z2UYgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775246307; x=1775332707; bh=y8w9sOgxlXszWUu5wSKj+Z9HCoYTPQ2KsCb
	/qnXdpEY=; b=bWtlUcHcRvlTsZmRpF3wKG/YdCG8Foca3R5d5W2wRvxDyyqIt8a
	Y+Cqv6qWDYAwH7gUIDqdKwyuyH5Nmf3B3tPyGPWIArDXkemZdX1fF3U+AL3PmCVL
	FvtLG9dNnJut8V0oI6BqMMxLsrZicCy0psD5TItQTvBHvKlw3X74h4Et5mYrc+X4
	G6MaSdb7PyODJHqbsi8mrXj28PieUOM2nywKHu5ZyCtPom7VAYQw4yuHH6dmbvmI
	l5MZqw6VFXtnIq3vhWNFhu5Y/maHMbbE2imhX+reiz+AitqRt1RBuc8GwkFiFTqq
	k6CcEBTqlfh+hwO0T6fSiOgNeIGz97Av7hg==
X-ME-Sender: <xms:4hvQaVPDbWv67JpnNdqbJOsHbr6u238za3gFxuUgzyUfJ-LGPkBUOg>
    <xme:4hvQafazjhc7rxVwT3G5vhoRSxd3cCEY23qtAlVu403vXV8ygZJoOH0QE76ruYGEG
    BnGWQtxkdh2ANnRA_2_tpxTEyHiUat350zoMCcgS4jopTVgmysP4Ozw>
X-ME-Received: <xmr:4hvQaRqst6zk01NuWa4HXnjeqD4pHAUCasjkRlxB_G8uttYLh7mhV-JKoX6cTUgLeN-rY55mu_0yJTWtCjipj7Ih9UtfWKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpefluhgrnhhluhcujfgvrhhrvghrohcuoehjuhgrnhhluhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeggeffieevgeejffefieekieehledvie
    dtveetudeitdejteetkedtgeeuieevheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:4hvQabYmlqsnlZDZpnsJt36U2O3U-tmf-_n0uj9n63avfb8a0Nxllg>
    <xmx:4hvQaRR73-ME-TUVfQp2l6UVStk9UDlr63HQDJWPubM4oy0IeyUYAA>
    <xmx:4hvQaa7gvKft2jsm1Vs6EOI-zqMdtuoy4CoEp85vA5ACSc2fOcJ-bQ>
    <xmx:4hvQaewHg48X-zHvVg6yxu8HfYcXm1OunXEbzasLYRl6FpiekLgpPg>
    <xmx:4xvQaapbIxSJt5iUt_YZ5HTxn45w1ZQ5KmnECSLcAK1VjnFIpRvJ43b9>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 15:58:26 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH] selftests: net: fix checkpatch warnings in iou-zcrx.c
Date: Fri,  3 Apr 2026 14:57:53 -0500
Message-ID: <20260403195754.10619-1-juanlu@fastmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fastmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275198-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 9EAED397FC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 240d13dbc54e..df44b0eb46cc 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -266,7 +266,7 @@ static void process_accept(struct io_uring *ring, struct io_uring_cqe *cqe)
 
 static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 {
-	unsigned rq_mask = rq_ring.ring_entries - 1;
+	unsigned int rq_mask = rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
 	struct io_uring_zcrx_rqe *rqe;
 	struct io_uring_sqe *sqe;
@@ -406,8 +406,7 @@ static void run_client(void)
 
 static void usage(const char *filepath)
 {
-	error(1, 0, "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port> "
-		    "-l<payload_size> -i<ifname> -q<rxq_id>", filepath);
+	error(1, 0, "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port> -l<payload_size> -i<ifname> -q<rxq_id>", filepath);
 }
 
 static void parse_opts(int argc, char **argv)
-- 
2.31.1


