Return-Path: <netdev+bounces-71780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E48550D5
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835411F2285C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDC912839B;
	Wed, 14 Feb 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="pJ93D63X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gw1nHcbf"
X-Original-To: netdev@vger.kernel.org
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C4128814
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933141; cv=none; b=bkXtPoW7jXFwlhmD5MtHhaC3jy02nZpO9qrzuXA/6YFOPXSIvevvB7puyt1Qg6FHygibpaK06B3SQxXU4uGqthYZpzhsAzJ272CLoCy//57PmAClELmY7hpQ4R1RijRroFwkOWIVo9pzlnASLjnU6GSkf2hzaCkCjxMVZ8AwcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933141; c=relaxed/simple;
	bh=yzGd2DE8vejAu+fAQpL+9t8gQmz5fwSogpfMgdsMDPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adABRDpYkGuLK6aZfyCbTU/gxaRUuN4u+6OclKpJnSbzHqrQcHxQosbev75h9pgFEOabOboFeYwJIJv+BIXf4ykzVnmGCwwqfZVq3zW4cD8LR5Exo5fPQApCJW8OkG0MbSBub8iY7vhWS5qmFreO994vDDUtpMnKFTF0ZwelVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=pJ93D63X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gw1nHcbf; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id 2AC332CC02BE;
	Wed, 14 Feb 2024 12:52:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 14 Feb 2024 12:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707933137; x=
	1707936737; bh=i64UbA6XEuCyrCBY5sa8M6iJyXjvSYKXnF1fyPI6Bx0=; b=p
	J93D63XNH7kTDB2P9MZb5pyhy/UpY2bkl7rgt6FswuwamQt2YbwmBH4XDwD365jj
	bGcN2duOVaRKlmo4tXtGM5DeiV0HM5CPtqiP5mUkZuJO0A1WiB97nQWSXXyU1NQ5
	9uFqRKuWMKKVESxm0+U32uapPAWwsEwUZuj1PYn+kIZZW5XDYfuLIz7nZ17zhH0x
	7y5WrRsHQHP3nVS8fS32N7hDQk0q27TZoeQ/1vK83R/gX5ox6fgN2QPFzNmBBwgs
	yiY477xJ5rrfaaTv+OsyImAihutY8CXNpIHFl6Gs7fzrolrqhl+afvsGd6y5r1Et
	7eTxV7NUGDMXA0NE01b3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707933137; x=
	1707936737; bh=i64UbA6XEuCyrCBY5sa8M6iJyXjvSYKXnF1fyPI6Bx0=; b=G
	w1nHcbfJC2czS1kMS+nsk2RtvZoa6p1AYVLidPFSg19XvxNbiNuxxnxYebWkSekk
	58t7dYNxFNXzxxTw8hkQ72R6UH5klkvnSfDJ3zfxnWWPy6X8NEqw9Zo6iWRMsUB8
	lTX31HWJgrczBHWf+54eB1xQ+Dm5hjEJ+Xur9nd8LGnI/y/VQSONP4ZAGvylx2Fg
	mEpBgrEtNSDh+Y7O8q/J+Ws+i5WTIwXjjiEX6zDEqY4k19Endjy2vyVt+hCFEQAt
	iTL03h5INOTPuvB7J6++NLyFnw9OhvmUauB3ZX7Ik3P8ku5pdNhdh3mHpv9F9h6o
	uLIA/plTpNXqSRteXnokA==
X-ME-Sender: <xms:0f3MZYuoGCwiDPAz1erWG09QqMUi6A78NIrBPgTF_roNqBjO6yLe3A>
    <xme:0f3MZVfBBiDAHVIjj_lrCKLrx651GBSylgNyQE4oVeu22YXyXpmDeNpaA4UZByViM
    dheNpgY5YQ5WzKQE5A>
X-ME-Received: <xmr:0f3MZTzUKFrXbtZVay0X0phBBSIQ9CN3XWmvkebpZ3kKka1C06rWqxc4wQeTm28B6_9DI-e2FVvk7B_2TyUS7VzZP_gD2zT-mH6nnniHUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepsfhuvghn
    thhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrth
    htvghrnhepveeiheejtdevveeuueejtdevhedtudfgueekfeeftedttddttdelheduheef
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqh
    guvgesnhgrtggthidruggv
X-ME-Proxy: <xmx:0f3MZbOxQwZ3ZqLFJ6Oadd_f5IAuBNo83Y387s59cYmyKFPyy6BeKQ>
    <xmx:0f3MZY8_wcM3LoyZZbx7q2z_Cr_XEXNePuIqqUznCT7aB5fvvqxXTA>
    <xmx:0f3MZTUmHRMHc7vUfjb-_0UhghrHUxjr9D3F5nDXUt5SVXTIS9Z_Uw>
    <xmx:0f3MZYxG_Y0xrUi9eu757ABiG5cLJHad6IFVWkjpJu8yIwmZiwavs6ZrjnrMLmz->
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 12:52:16 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v8 3/3] ss: update man page to document --bpf-maps and --bpf-map-id=
Date: Wed, 14 Feb 2024 09:42:35 +0100
Message-ID: <20240214084235.25618-4-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214084235.25618-1-qde@naccy.de>
References: <20240214084235.25618-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document new --bpf-maps and --bpf-map-id= options.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 man/man8/ss.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 4ece41fa..0ab212d0 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -423,6 +423,12 @@ to FILE after applying filters. If FILE is - stdout is used.
 Read filter information from FILE.  Each line of FILE is interpreted
 like single command line option. If FILE is - stdin is used.
 .TP
+.B \-\-bpf-maps
+Pretty-print all the BPF socket-local data entries for each socket.
+.TP
+.B \-\-bpf-map-id=MAP_ID
+Pretty-print the BPF socket-local data entries for the requested map ID. Can be used more than once.
+.TP
 .B FILTER := [ state STATE-FILTER ] [ EXPRESSION ]
 Please take a look at the official documentation for details regarding filters.
 
-- 
2.43.0


