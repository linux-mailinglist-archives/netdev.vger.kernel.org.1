Return-Path: <netdev+bounces-42844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBF7D0615
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF44A1C20F65
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 01:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93935EDF;
	Fri, 20 Oct 2023 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9iKs/1I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75909ECE
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 01:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A1EC433CA;
	Fri, 20 Oct 2023 01:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697764740;
	bh=4nxRFy7uAeXFMKE//Wszpq3lf9oOTfgFd8lrOhnblBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9iKs/1IdZwt0/pcOsobUvDNteQpksrGPkVz996DCJIj008LpMgFifuzFblCXGv9q
	 xYWtbIek8fr4UFPJmY7rI32b5tqYjTlFjsKcdRar9BvaEF+QO+y0WcOEGaDO2lQv0F
	 WXKvjP3Uvj05H/V2iMv5Qvo93gcUCjUSJxWKJFELcS8822Cxf0TuVoTo7BX0xl3k5O
	 x2um2Bq1AYVvCc39i7cDAURFAg9T94kkugaMNxhckyQ3N9ZZElIA8AdTnfFDr0YSJ7
	 FdqAUpjkpj0PZ4d6ACPPKgewHqKSsoZUg8XKweSLzL/b3YxDj+gfMSPU5pN/0b+XLP
	 lp3IkqSfsj1Pw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next 4/6] net: trust the bitmap in __dev_alloc_name()
Date: Thu, 19 Oct 2023 18:18:54 -0700
Message-ID: <20231020011856.3244410-5-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020011856.3244410-1-kuba@kernel.org>
References: <20231020011856.3244410-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to restructuring __dev_alloc_name() handled both printf
and non-printf names. In a clever attempt at code reuse it
always prints the name into a buffer and checks if it's
a duplicate.

Trust the bitmap, and return an error if its full.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index bbfb02b4a228..d2698b4bbad4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1119,18 +1119,11 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 
 	i = find_first_zero_bit(inuse, max_netdevices);
 	bitmap_free(inuse);
+	if (i == max_netdevices)
+		return -ENFILE;
 
-	snprintf(buf, IFNAMSIZ, name, i);
-	if (!netdev_name_in_use(net, buf)) {
-		strscpy(res, buf, IFNAMSIZ);
-		return i;
-	}
-
-	/* It is possible to run out of possible slots
-	 * when the name is long and there isn't enough space left
-	 * for the digits, or if all bits are used.
-	 */
-	return -ENFILE;
+	snprintf(res, IFNAMSIZ, name, i);
+	return i;
 }
 
 /* Returns negative errno or allocated unit id (see __dev_alloc_name()) */
-- 
2.41.0


