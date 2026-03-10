Return-Path: <netdev+bounces-266354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JH6KFWUsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:59:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCCD258949
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B14CC302806A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B453F20EF;
	Tue, 10 Mar 2026 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mHXu0kwG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CMXYprae"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C43F1670
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179975; cv=none; b=ZKqZ5UEMwA3m+f3IrlV0wACQ9rGUYBQ3F90oOmt0jqmDBF5KlzDzsVwCzYeJUYtXNN00YRRL90vCm7ImjKXxy5dXde7SFDoKjJ6TbIXa/A2EXV8b/ehC6rPX2JeMQQCf9WniO76HlmrwmqSl4N1OmiAhm7gik96iKeFq36cMjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179975; c=relaxed/simple;
	bh=OlGJHfqdZR2vZF0BbVwEIZKM3bzNZ9oFbQCYAK+5BlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJ9Yo+B0KWaJMvvtA4T4Zprr8zGVE4rxaRqWnlmdFokMsEuiKF0rhcTa6YDJzAygd+7INxTIekzojOiy3WVtm1Q0ytHhktdErEb8VxGll2didZP4jPxh/Dx0m+PVfbbeYa9pFHKaLvPcprLKM3qpn5Hdqinn7/+FXowV3OI22v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mHXu0kwG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CMXYprae; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E8F5F1D0013B;
	Tue, 10 Mar 2026 17:59:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 17:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1773179971; x=1773266371; bh=vEDjXbW0TS
	ofbN0q+vGRRNEw7jjpNw5jiwCVhGq0MFQ=; b=mHXu0kwGdnaqLOU7IMzpw2kKjn
	8WXzkrcj34FUM2w/gOhryVvn3GAcOOzK2agmQVlp1asn2ybwVFH7EcfJsXBc4fV3
	Sozzu7/EoLCbvr0SwsG/Mz6QcL+7R7li/pf/D7LBymAXAOrHj4g6Lbs+M3Dwg/2B
	kwpGMROA8hN1yWughzt84rO1lWiTLRJAYKC5/Gk99Q97jk9yuqzzSXEcNMJKS1K5
	SK4g2jgJU2brfzbrgOnmfBnvYAgCV9xPiXGp9taDq3Bv2nsbFE/M8qXU+KHjyquA
	X2kDGorCebvIhC5DiBGXsg6D3RjHM57SLP040zk7x30UqT1tT60yBlRiGuwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773179971; x=1773266371; bh=vEDjXbW0TSofbN0q+vGRRNEw7jjpNw5jiwC
	VhGq0MFQ=; b=CMXYpraeQ5obqb5PiLfmoJLVFP0KSU1ZNMrbeFWjRuDJtEAnBg7
	0c4UNRI5qBIC/XtPj53r38GnLepc5Z46JzQ8xJQ37q1hWuNxLBV5rX+hZN8vxIod
	oEQZNS6ZaNpoGZoEYagijpg0nGqgjxCs3J6hd3fyniMh7uAsA8PBEkLbPjdySW4y
	Ym9BObVFB7d5hDvRVwSHDZDM/WpnWIBSeENfRqe5Kj2roNybV/esbR8hPu39bgxW
	5zmbhnXnbZV1I+TycJw66068qW7z3XCyhBi40r+Q3+p4TOe1JdARPw2ckrBlhx/q
	Li/7DZqiNtjOVQkKZ1D/7LvElATex3F1Ddg==
X-ME-Sender: <xms:Q5SwaQiKZngLT_VFvbB4MEPW3MsS3zzIQUAv6SgOTXpFLHU5owsKRQ>
    <xme:Q5SwaQC2OvYI3tFKHi7pjRnzvOaSNsIBxI3pj9ES89eHjyHrq8YysjcRxvEU6mJIv
    jFQ475OMF7QwxhS2za2ZoyRavVJodnndZlM20N4DkhjisuUYCmq6io>
X-ME-Received: <xmr:Q5SwadGLbcyLh3jmyEdFuGiIhyq8ry2MHebQxdnurtE1OvqelI9kALZhRwhH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthho
    pehkuhhnihihuhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q5SwaQJcDnIGJXeMMdJLfv2UO7QVs4-0isMt3ghh5ZZ6Eh4Z5pd0lA>
    <xmx:Q5SwaZku4LFsa3GjA4VI_ewtUh__AbE4xQ-DyzO1xAEkNvBUNwfwGA>
    <xmx:Q5SwaQSb8xegfMCW-G7NbBgQP_osek4mbGgmD2uFx449mCX8JNA9FQ>
    <xmx:Q5SwaTKsmfePmORjoQRAiQqgpwYcqeZLTOjKJAakj8Y_4ZalhP5XfQ>
    <xmx:Q5SwaVQt_A6nfVkoZ8055r_9xoa048O5rbm4K-vR-j-R2y2UBdV52ZUO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 17:59:30 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net 0/2] neighbour: fix update of proxy neighbour
Date: Tue, 10 Mar 2026 22:59:15 +0100
Message-ID: <cover.1772894876.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CBCCD258949
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266354-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,queasysnail.net:dkim,queasysnail.net:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

While re-reading some "old" patches I ran into a small change of
behavior in commit dc2a27e524ac ("neighbour: Update pneigh_entry in
pneigh_create().").

The old behavior was not consistent between ->protocol and ->flags,
and didn't offer a way to clear protocol, so maybe it's better to
change that (7-years-old [1]) behavior. But then we should change
non-proxy neighbours as well to keep neigh/pneigh consistent.

[1] df9b0e30d44c ("neighbor: Add protocol attribute")

Sabrina Dubroca (2):
  neighbour: restore protocol != 0 check in pneigh update
  selftests: rtnetlink: add neighbour update test

 net/core/neighbour.c                     |  3 +-
 tools/testing/selftests/net/rtnetlink.sh | 55 ++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.51.2


