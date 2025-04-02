Return-Path: <netdev+bounces-178714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A7CA78600
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 03:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41643AF1CA
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9211096F;
	Wed,  2 Apr 2025 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukoD2k7Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB72F507
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555784; cv=none; b=qPeDr4QAgUZFMvpyis/X4cU2Y+MKakD7ArQWmS9KQEup0re2v4DiPgofO61OOOrmJ/o1+m82cjy2tu+wWFB/dLLf8jC/9zgmAi3dhIt5K/Wlocqug451GCFUnt90ufC5TM7CYEm5NoLIRvehibuS12rxA4m8j8FYKVQ3YfsFKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555784; c=relaxed/simple;
	bh=UG/8IDjmHw6cVEvlQ7wjDK0ND3xss7cfz2MrvaU5+50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoN+8jRBk6gpJ5B20MmWz75QCLef/KS9mjv4EZi1GmeuqcFl+eYQDRZjNkrMI8NrFQO/FQNK8e0i+xJ73i5NB4Ucg7G3rmfx9aJ+Eju0s8loB1O3S9MTeqRK6etjJh3BR3f/ubgOElUYoYqwKOvJIjX7fReq838JM9ZnkuUvXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukoD2k7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2F9C4CEEB;
	Wed,  2 Apr 2025 01:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743555784;
	bh=UG/8IDjmHw6cVEvlQ7wjDK0ND3xss7cfz2MrvaU5+50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukoD2k7Yr5xj7AXTS0kSOeEcIuQouMKj7PFL3Wl8X5gSuYcyLY+i9racJjCL1d360
	 ppOorfRZUsIHh46WQTRURCSd2pmJI2XL/ObNO0bADFA0nRdzYPtLjhXNaDxGd7wIUI
	 JZC5MFTnaAP5UE557e+rXsNJbNDm5G7MHMLRZKBFx0YDPJnsiuvQJWZSGMDO2aLGhk
	 DC/g3edejww3y+285sesifDppxvQ7DPvSWX3HNBaPcyGGtqJaNjG+oQ9EKXBMx0Qvo
	 /ON838GqgajFFg2YTJjYPC3Uieq6JtjMkJSv3n+Utjov18g/tApTBxSJ/hl5ZqFhD9
	 H4moeGoRzlmFw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	yuyanghuang@google.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 2/3] netlink: specs: rt_addr: fix get multi command name
Date: Tue,  1 Apr 2025 18:02:59 -0700
Message-ID: <20250402010300.2399363-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402010300.2399363-1-kuba@kernel.org>
References: <20250402010300.2399363-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Command names should match C defines, codegens may depend on it.

Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt_addr.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
index 3bc9b6f9087e..1650dc3f091a 100644
--- a/Documentation/netlink/specs/rt_addr.yaml
+++ b/Documentation/netlink/specs/rt_addr.yaml
@@ -169,7 +169,7 @@ protonum: 0
           value: 20
           attributes: *ifaddr-all
     -
-      name: getmaddrs
+      name: getmulticast
       doc: Get / dump IPv4/IPv6 multicast addresses.
       attribute-set: addr-attrs
       fixed-header: ifaddrmsg
-- 
2.49.0


