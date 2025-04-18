Return-Path: <netdev+bounces-184051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECACA92FDB
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531841B637B2
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4322686BD;
	Fri, 18 Apr 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWSG31D/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD22686B3
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942642; cv=none; b=HlUcK842mWmNbb/0sjmr/+JDChN4iIifGEYUCurTfecDNX5PwTdtrB+k1d5bob/nxDSwKP4GgsTRJLaVlhopEnzbiVJmQXUOn9pzCHFJATt55FiAec2vC2tUTueez9rXhJNSAy8SqTyDH736smE1xYtv0rj49t+PWLsz6KsiDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942642; c=relaxed/simple;
	bh=BH1KAmuS8KE/1hlWJ9YClplCMaz8tVJ+glU00j3N+0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOvm4bwINP066nvejjATrjcuX+MtmJGCSVepv8dDhNVQ8aApy4ipFUIFi94qLTe4hP8g/DyCaooU7ePUAHkRvNm0cnON/28gMouC+ZitYJhYCIsiZQC9erLK0uVhryAefHXtIm4A0zeYQClizrEz14Yj4EcBf8/7vG5m2G9Yl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWSG31D/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA8AC4CEEB;
	Fri, 18 Apr 2025 02:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942641;
	bh=BH1KAmuS8KE/1hlWJ9YClplCMaz8tVJ+glU00j3N+0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWSG31D/FS7Cf4c/IMeQoxLZabtt7yhFRjrEQLucLFLeMPFHpEsW9fLclCkJmvke1
	 mcVFUeQB3phtMChZi6FCkRw5aYbMR+eH8z6QVVueCTEDWivywoqcySioQ/fLwTt0xP
	 TydUM3ahZPmv1JRkJRULtOsCctkYdoNfeGfaDdAJajjp37qGdovPRRgYikqubrD/Dv
	 dzdJQxXZFhlO0/rnvFa8+WlCCoDYiqTDtm7ikYpXGUBsFkRgSpAz3slorH7Ve4XmXB
	 YLvacaV4FUjDTCU/BrHUKQreibO5WSpF/nX5gJVqez93KSp47URW12svSt9HcgHFJZ
	 Hvu8yypUfSibg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 10/12] netlink: specs: rt-neigh: make sure getneigh is consistent
Date: Thu, 17 Apr 2025 19:17:04 -0700
Message-ID: <20250418021706.1967583-11-kuba@kernel.org>
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

The consistency check complains replies to do and dump don't match
because dump has no value. It doesn't have to by the schema... but
fixing this in code gen would be more code than adjusting the spec.
This is rare.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-neigh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index 9b87efaafd15..fe34ade6b300 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -402,6 +402,7 @@ protonum: 0
             - ifindex
             - master
         reply:
+          value: 28
           attributes: *neighbour-all
     -
       name: newneigh-ntf
-- 
2.49.0


