Return-Path: <netdev+bounces-184046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54508A92FD7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3B21B633B0
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC58267F42;
	Fri, 18 Apr 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx9b5IXq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B3267B98
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942639; cv=none; b=tnuCEDuaX6naPJFiDYgamvJWEgMYhF05nzXeeAq5bnt1mdBtEuomvtPLU53Rzc3e/XsCApEDwSWjyj+M+drqoun3FknVNh+bvECsB0BBL323pI1SDTAN890JvVKOER6Zf9TpuQzheNqpE+Hz8Uerv8Y0pGRfxoSw/mW4q9RB0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942639; c=relaxed/simple;
	bh=PMSQ7qnFK7wnHEHneabQKw9K7YFrTzmI4TECj1xLcH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6YEx2rLRZP/SUrjnfyZBRWcmcQeNKF4vDQv0Az4rYMREdnUEVtfabrYWHmcv6l2NfN61+lm6OcXMW/TeRDq6tyBWnDfjydzUsPPMmOIkqy/yDZRNtN8MEZf+nyF4pcRgIvl61tKacnxW+c1jEER0vCoYBDQd6a13TSb516tk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx9b5IXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD2C4CEF1;
	Fri, 18 Apr 2025 02:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942638;
	bh=PMSQ7qnFK7wnHEHneabQKw9K7YFrTzmI4TECj1xLcH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xx9b5IXqeUeOJ9sTe4AY6r9YDLU25+8oZf7WhZtngVASaqRqJiKyR2Qzl4QHETL2R
	 9M6RTpkZ7sZGEqx+Glk9yX/EW8B/Td3lUPtNr3An/TBgZDUkP6JreugOeHObolZcB8
	 cUvvW7DowP6twqLwtx82TyXsMRueU35OECX5HYP095hovOuNzYmbIQDWhljyGHKzm7
	 ObHukoCO+Ha2oddEs95tEVjn9bI/Cv/mcWE4q50rpXPMmM0jtz1AXIPaFGYKoGuC8d
	 n83IU75UQwClmXds66bbH8lcAvd+bpD6wLmeVIyyx4qfNcnLGKhJi6vsKjH5m70LdR
	 LTGPw/nr1/ABg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/12] netlink: specs: rt-link: remove duplicated group in attr list
Date: Thu, 17 Apr 2025 19:16:58 -0700
Message-ID: <20250418021706.1967583-5-kuba@kernel.org>
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

group is listed twice for newlink.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 7f411e8cd755..38f439911f94 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -2382,7 +2382,6 @@ protonum: 0
             - txqlen
             - operstate
             - linkmode
-            - group
             - gso-max-size
             - gso-max-segs
             - gro-max-size
-- 
2.49.0


