Return-Path: <netdev+bounces-211055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D102B1655E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61693AA00D
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5E2DFA34;
	Wed, 30 Jul 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbsOXqtC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E92DFA26
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896103; cv=none; b=mG6nz6wejKPlFTLg+kLL1EMPqQgA6fmlswNF9tHRjaiSqGKcx2RUJlrgjkusd+ioyi9Acy+rfWk/EEgilgtzO/kzLoSjwBoNGN1IcVbKq4YMPFqkfT3G6ihqNAJPwX6tZCB4L5a/Lv+pYWiRvTicfOV73ghg4x1hO00lR8KHps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896103; c=relaxed/simple;
	bh=UqE2rwavA09PzKrISHbXZedS9k8tbGp4kOjuk/9mNYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4DXuGcfyq5S93+R7t20ktgXrVyx0QKXvujjWeqOZYuysNSTSmBPgQC08jSYdRD6JF1XoTnuu8MTq+6RV1/hDknJhf5A++UmA7j99qHcAVDB94ymogkY8JVmgcIhg5Wz1xmd7wFJBHESD6D28mQnOZKQ2YRXPCYAMJXfwVwJZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbsOXqtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B42C4CEE3;
	Wed, 30 Jul 2025 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753896103;
	bh=UqE2rwavA09PzKrISHbXZedS9k8tbGp4kOjuk/9mNYo=;
	h=From:To:Cc:Subject:Date:From;
	b=QbsOXqtC7ERRFzOMreIsNIGnLqPtieNx9ccT36ZNCtLogqSnPtdUsN5xdvW7Z9WPh
	 7y/u+L9ZLgwxcAM1D3HA3pg5ngEnCiCEWl52MP2l1YFxAfkP3v0KY1CrmvhmOdthp6
	 fBOowwyB9xkSwXcOuIP47laZag6w3GeTz9WocTWHL9ra1hmelt5s+CSdYsL5MO0a6K
	 m9vw1OiHqrlAdOk9NDukVQYEs7p9igYJknW60sDF4e0HOYVDoTZd6B96YxGUjnmH3j
	 JiYy1W7c23f/IhQjGzj2j8/w9UvPjqRjlGxHaS9ljGnE63tspPbwn7XML6eYZxxt3N
	 RfO8aF+MfJMYQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Duo Yi <duo@meta.com>,
	andrew@lunn.ch,
	donald.hunter@gmail.com,
	kory.maincent@bootlin.com,
	sdf@fomichev.me
Subject: [PATCH net] netlink: specs: ethtool: fix module EEPROM input/output arguments
Date: Wed, 30 Jul 2025 10:21:37 -0700
Message-ID: <20250730172137.1322351-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Module (SFP) eeprom GET has a lot of input params, they are all
mistakenly listed as output in the spec. Looks like kernel doesn't
output them at all. Correct what are the inputs and what the outputs.

Reported-by: Duo Yi <duo@meta.com>
Fixes: a353318ebf24 ("tools: ynl: populate most of the ethtool spec")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: donald.hunter@gmail.com
CC: kory.maincent@bootlin.com
CC: sdf@fomichev.me
---
 Documentation/netlink/specs/ethtool.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 1063d5d32fea..1bc1bd7d33c2 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2342,9 +2342,6 @@ c-version-name: ethtool-genl-version
 
       do: &module-eeprom-get-op
         request:
-          attributes:
-            - header
-        reply:
           attributes:
             - header
             - offset
@@ -2352,6 +2349,9 @@ c-version-name: ethtool-genl-version
             - page
             - bank
             - i2c-address
+        reply:
+          attributes:
+            - header
             - data
       dump: *module-eeprom-get-op
     -
-- 
2.50.1


