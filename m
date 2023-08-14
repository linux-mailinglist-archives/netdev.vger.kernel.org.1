Return-Path: <netdev+bounces-27475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C654D77C1DE
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A2A280F3D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8539DDDA;
	Mon, 14 Aug 2023 20:56:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E330DDB4
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88F1C433CA;
	Mon, 14 Aug 2023 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692046592;
	bh=Pww0QPDRCCWYMr5y4OQjneTi5SA2ENciX9jlRODwxB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsVtKhNk/Cfldh70FZSI4/n+WG8gguMbOgdA/0x+RRtn9NvqA4cRqt4XQzDlo/33C
	 t5DvE6djDIItauPZTHtccKyR8kKlKjiVEfLwgCTvrDFpqFoTnZGH77vhVFJRuOgy/f
	 cFuivYSa07a05g4ZDPXmSpjkezQeX3QaQkGcd+Cp7YevGNAMnGW+ywZT8LKOzrZ4n3
	 gzB8kSY0X11pIOCfjCBt3kpuMhNVy0e0Vi//IDHHSrWV39FS/IiOdtKXOyrY4DRypR
	 letQnE8yUnP8Km4KOeDFyAX3EgmgwgHX8b5ECc3txy7C9iZjoI5KUeJTWKmU5WVJNa
	 DUnSl8ctwrFaw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] net: warn about attempts to register negative ifindex
Date: Mon, 14 Aug 2023 13:56:25 -0700
Message-ID: <20230814205627.2914583-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814205627.2914583-1-kuba@kernel.org>
References: <20230814205627.2914583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the xarray changes we mix returning valid ifindex and negative
errno in a single int returned from dev_index_reserve(). This depends
on the fact that ifindexes can't be negative. Otherwise we may insert
into the xarray and return a very large negative value. This in turn
may break ERR_PTR().

OvS is susceptible to this problem and lacking validation (fix posted
separately for net).

Reject negative ifindex explicitly. Add a warning because the input
validation is better handled by the caller.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Turns out concerns from reviewers that callers may not check bounds on
ifindex were legit...
---
 net/core/dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 636b41f0b32d..17e6281e408c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9589,6 +9589,11 @@ static int dev_index_reserve(struct net *net, u32 ifindex)
 {
 	int err;
 
+	if (ifindex > INT_MAX) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
 	if (!ifindex)
 		err = xa_alloc_cyclic(&net->dev_by_index, &ifindex, NULL,
 				      xa_limit_31b, &net->ifindex, GFP_KERNEL);
-- 
2.41.0


