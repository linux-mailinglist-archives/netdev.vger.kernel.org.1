Return-Path: <netdev+bounces-184043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20458A92FD3
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C88A4655
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF1267AFF;
	Fri, 18 Apr 2025 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtwcAHAN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA207267AF9
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942637; cv=none; b=GGtM4+yVPI2P7AYauzGQxgurxAMEGVmpj11fWTZ69env95caoGjSut03VoWecmq/Jmo5oTMcd4kqA4KHE5lir2fr0ysM/9sHllBidsyDteuCyP58VbgwkyJmzpvgLIbCJyVY1qYQ2edy1GbncoYya4/trks6YY/jItbyGRTwFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942637; c=relaxed/simple;
	bh=g5Zs3IoDN8HSPHinYH/cNE7KtKjdcKfsFLH/51XQdPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSOztdM6ZyRC8W+86gzuO60nt5jfLNAseuagaPfJNmnb2kYOBFjXJCtvoFm5hNJZVkie6vedunyhQYI16hSfGtgQh6MXTmv8syxNNv7pk7YpPTiQQbGTFkAOuPncHva3dWztIal2NpVnhMeHikCCi2Y06sQdsRAS/u1pYkoIDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtwcAHAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD29DC4CEEB;
	Fri, 18 Apr 2025 02:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942637;
	bh=g5Zs3IoDN8HSPHinYH/cNE7KtKjdcKfsFLH/51XQdPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtwcAHAN9wIAbz8+A8/HmJf3qwkDpdoJ9VOaviBsG/AcRrVA33/l5ZO1v9yJS+jXd
	 ElHEo9EUMtTd6ioLRB9ifySRLISu8c88HeW3TGBTzRTUUpb1/nq3n0CFwQz96BOM8R
	 Mjiqe0ooZdDw41O8VFRTYIBnAVUeMVm/QCvo6sPaVwYD6n+KGuSgCF+RwtxzhJbUl8
	 eRhYZqwdLD/QhM/4KrPNQgYqUUqYbyhNDqEBI7RL4f9Kofr8XHFmPqBXWMMxAZEmL2
	 fTqby1UMEJb+f4jDvYLjTtkEYDBzXoeX8Ewf9pQ3teYpC/Mv4xVcfpzULKblDcGbqG
	 uIFii70wygzag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/12] netlink: specs: rt-link: remove the fixed members from attrs
Date: Thu, 17 Apr 2025 19:16:56 -0700
Message-ID: <20250418021706.1967583-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
References: <20250418021706.1967583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of the attribute list is to list the attributes
which will be included in a given message to shrink the objects
for families with huge attr spaces. Fixed headers are always
present in their entirety (between netlink header and the attrs)
so there's no point in listing their members. Current C codegen
doesn't expect them and tries to look them up in the attribute space.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 726dfa083d14..cb7bacbd3d95 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -2367,7 +2367,6 @@ protonum: 0
         request:
           value: 16
           attributes: &link-new-attrs
-            - ifi-index
             - ifname
             - net-ns-pid
             - net-ns-fd
@@ -2399,7 +2398,6 @@ protonum: 0
         request:
           value: 17
           attributes:
-            - ifi-index
             - ifname
     -
       name: getlink
@@ -2410,7 +2408,6 @@ protonum: 0
         request:
           value: 18
           attributes:
-            - ifi-index
             - ifname
             - alt-ifname
             - ext-mask
@@ -2418,11 +2415,6 @@ protonum: 0
         reply:
           value: 16
           attributes: &link-all-attrs
-            - ifi-family
-            - ifi-type
-            - ifi-index
-            - ifi-flags
-            - ifi-change
             - address
             - broadcast
             - ifname
@@ -2515,14 +2507,9 @@ protonum: 0
       do:
         request:
           value: 94
-          attributes:
-            - ifindex
         reply:
           value: 92
           attributes: &link-stats-attrs
-            - family
-            - ifindex
-            - filter-mask
             - link-64
             - link-xstats
             - link-xstats-slave
-- 
2.49.0


