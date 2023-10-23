Return-Path: <netdev+bounces-43501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47857D3A9E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40021B20D2E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433DF1C28A;
	Mon, 23 Oct 2023 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcPcblnd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194A1C283
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 15:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F283C43395;
	Mon, 23 Oct 2023 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698074629;
	bh=DKDkRNSnXzhTGGNSSBp7bEj76rJrv16ueNO8snSn1xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VcPcblndPjltM3kPpB1dNBMKkG9OmDe6DBKHwdmhUxw+v48xPWdvpgtWSQNFuYnSm
	 8Kh538Lhp/sYcbvyk68w9U60ksCl3X7SnA479k58jOkT0AVyt6U109EBu3eIj8Ea7C
	 KLaINIVpvxZ5BqjZB5DiKvU1nyaVMgm63PzpLffv3cO24wKpxogOQoJXi1aK79NJIH
	 tFO8hVaKU7qjBYSf3CWybMEAjXNSYTQLc9SPWG9rEjmS5lgYv+BqYJ2wfWnl01T0HB
	 tvSDGWkWSeBG5mEz2c+05C1Z+gGWPNQ+GIXnZ+3tvrTjiCuswtqi4+43SqJna3IYCm
	 Er5MnJkiJPAww==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next v2 4/6] net: trust the bitmap in __dev_alloc_name()
Date: Mon, 23 Oct 2023 08:23:44 -0700
Message-ID: <20231023152346.3639749-5-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023152346.3639749-1-kuba@kernel.org>
References: <20231023152346.3639749-1-kuba@kernel.org>
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

This shrinks the possible ID space by one from 32K to 32K - 1,
as previously the max value would have been tried as a valid ID.
It seems very unlikely that anyone would care as we heard
no requests to increase the max beyond 32k.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - mention the loss of 1 entry in the commit message
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


