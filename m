Return-Path: <netdev+bounces-43502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D567D3A9F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F0C281544
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232D1C29B;
	Mon, 23 Oct 2023 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn/3wQ7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947421C297
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 15:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3EDC4339A;
	Mon, 23 Oct 2023 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698074630;
	bh=Ytxjxu7vOC51znHtTmSEisbsPOCPk9XldSLYyVun6eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kn/3wQ7+QPR5RViOa8UZu+VJI5CBJvY1vlNSggNX8ykoGo1Wotidtp6LpCM+ttwJg
	 qRTFM3ToKUVktXDB9aI99ydn4MF0+Wbwut303nq0oSFkqSJ+91ePQHIwFjMzQiOpdv
	 +JOQ4WL44lqceMvrPIx45EB7gt1ZhTbq+qHNgnv98Jqpn0gX2wJn0cSepDE1tfeN68
	 i+Lqpe5ZmUdkLKORU8LEcK5W1zFEWXEbaGoxkJjG7+EUWUWkg/VABtSPSipn1yqFQx
	 4rOzpbeHJM4fER/zT47qnTq9yoxWbss9cvXGYgN/eGGaVsaws6o7Iba+5/n98Owjgl
	 i6QUv5JgIx+VA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next v2 5/6] net: remove dev_valid_name() check from __dev_alloc_name()
Date: Mon, 23 Oct 2023 08:23:45 -0700
Message-ID: <20231023152346.3639749-6-kuba@kernel.org>
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

__dev_alloc_name() is only called by dev_prep_valid_name(),
which already checks that name is valid.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d2698b4bbad4..0830f2967221 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1077,9 +1077,6 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 	struct net_device *d;
 	char buf[IFNAMSIZ];
 
-	if (!dev_valid_name(name))
-		return -EINVAL;
-
 	/* Verify the string as this thing may have come from the user.
 	 * There must be one "%d" and no other "%" characters.
 	 */
-- 
2.41.0


