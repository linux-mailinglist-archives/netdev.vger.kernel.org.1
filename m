Return-Path: <netdev+bounces-39652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6497C0453
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E791C20CFE
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35929CE2;
	Tue, 10 Oct 2023 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMhN2TCq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E702FE01;
	Tue, 10 Oct 2023 19:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB9AC433CA;
	Tue, 10 Oct 2023 19:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696965723;
	bh=FkJc0H6OMIzQhv7nVnzWu7KssuAvk/PqTWIo7TR0B2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZMhN2TCq7x8MzAmed0YdfWJMvjxXy8vvn6DRMNJKqofdnPwSjzbUKDv0Mgd723V6d
	 UDUOhgC7xYfBpWWcXZFSIlCenD0ODOXDa8tFMPZIfIJjU+Zu+ztW3dpi3a1CH9LLPi
	 i75PJFVTyjMtm9uAaIs3i+LIZooFY1PE55yFQ6Bv26au1uR4mifmBUfuQM9eJVb4mn
	 0uZIu9Ud56zIreMc0hYtQIdEZpgbl7Pn6+GKnCO5SC5iHd32jYH6rXdDI5fMxmC9zF
	 jZyzUpRVI+TqOVtVNxq4S38rigopzS38Kdy+vHPdUUd4+3iwMo09H6FWAZnajbndMB
	 kmwft/mXNOtuA==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 10 Oct 2023 21:21:42 +0200
Subject: [PATCH net-next 1/6] tools: ynl: add uns-admin-perm to genetlink
 legacy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-1-18dd117e8f50@kernel.org>
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
In-Reply-To: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CEeDuoKr4YsKIddFImJBrssE0bezdUIPrFAMqU2bEiA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlJaRV+0vC8TF4WfZNftXeCyx5hCfO811Y6oY6y
 5a9Ewv5TjWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSWkVQAKCRD2t4JPQmmg
 c7wnEACI2bsm/JE7+qvhFjq4ltf6+PDUF7ckVR3d3UqkYZoCcH858cbirCFjv19PW59InjdsUl2
 fwWKdfoX4cLdaPIAIAkQo5ZwBJWd5h5VKM7nNaHyElv34sRKMzdGyiuJUYopB+buNlHRnRmbwT+
 QroJ/7330TgX0ZPOR7HTz5opALlRsA8gpzMd0ziCHWOz3be1yqa2oKFTk/IX9qSl8fciuz0LEqY
 xES+Gu8sVUd5gn9lUSFI0flv6O0RGv6Vp+sj74z6V7yhO57/TKIXFVEFZ7wbfNinyU3CZtcpQlM
 xmDrkQtfbWIhCz/eMlD1XgeoU4m9sRKtIJw3mWSfIYg9k6o4dYfS6TKIFkXFg+qZkVDCGoolK16
 FFG/8CPRWEBQYZrmgmb/rZLscoT9PRMRMMhHTC4S/pM2Em0QCS4d+bKD8Z/UWDIXI/mC+yLEg9y
 pt1tN7cfq/FBJNtk56/iwba1FDwouuE56c/6t463bQWJS05G/l5BiiWwmMPgxorcEIIQKiGlIGh
 fSB64jqqEhauXk2SfDIB/j85wm73hArRPN45V1a0Bd1NO49fIwj/yotA1Fyi8/rqPjBhKGYDFrb
 WkR1joNU1+ArSJrfSJ8fmMKy7w8w/Rf0yWZ+P8mSXB7+OVTg//Aaht2nf23tEVxPSYmS8ogXiY8
 +wy90qiA9wt1heQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

this flag maps to GENL_UNS_ADMIN_PERM and will be used by future specs.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 25fe1379b180..6b4eb4b2ec17 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -328,7 +328,7 @@ properties:
               description: Command flags.
               type: array
               items:
-                enum: [ admin-perm ]
+                enum: [ admin-perm, uns-admin-perm ]
             dont-validate:
               description: Kernel attribute validation flags.
               type: array

-- 
2.40.1


