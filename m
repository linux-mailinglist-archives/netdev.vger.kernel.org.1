Return-Path: <netdev+bounces-43503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798A27D3AA0
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A09AB20E00
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8AB1C68E;
	Mon, 23 Oct 2023 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpDvUEGc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7141C2B6
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 15:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CD2C433C8;
	Mon, 23 Oct 2023 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698074631;
	bh=P/LdALCuwJvPW2LsWzO9RltfSB9Uxdur0/koA49/Uac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpDvUEGcWhz50+jRy7ofmZR484gStgLS+jD/jx8udL3AP1vORcL1+ClVdtYdRDedH
	 M0ly7i/lRvR5ZOHM1CHssJdRYD8JmfThjuLa3nLN80qe6E1kBKwSnUlFDEo5Ely9N8
	 8+OqNnak+hh2YRL3GI3sebz1iJ6IeM25t3GMFtSvoFLvx9jpwM2y5BArCVS4J1czxM
	 bi4HoMV/I0PXapWxSiol9moq2vdfDOHn4H7a5YupZwD1icGY4PPQaHksnNvDQKRMTN
	 LWU90/2fqin68h34rIBxHdHI1GRuax91tfvxHUbekVBcgk9x1EtaY3A6Iu1NRYX0pM
	 ZHXBFtvowYnMA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next v2 6/6] net: remove else after return in dev_prep_valid_name()
Date: Mon, 23 Oct 2023 08:23:46 -0700
Message-ID: <20231023152346.3639749-7-kuba@kernel.org>
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

Remove unnecessary else clauses after return.
I copied this if / else construct from somewhere,
it makes the code harder to read.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0830f2967221..a37a932a3e14 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1131,14 +1131,13 @@ static int dev_prep_valid_name(struct net *net, struct net_device *dev,
 	if (!dev_valid_name(want_name))
 		return -EINVAL;
 
-	if (strchr(want_name, '%')) {
+	if (strchr(want_name, '%'))
 		return __dev_alloc_name(net, want_name, out_name);
-	} else if (netdev_name_in_use(net, want_name)) {
-		return -dup_errno;
-	} else if (out_name != want_name) {
-		strscpy(out_name, want_name, IFNAMSIZ);
-	}
 
+	if (netdev_name_in_use(net, want_name))
+		return -dup_errno;
+	if (out_name != want_name)
+		strscpy(out_name, want_name, IFNAMSIZ);
 	return 0;
 }
 
-- 
2.41.0


