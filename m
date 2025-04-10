Return-Path: <netdev+bounces-180989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F097CA835E7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD306464A62
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DE91C1F13;
	Thu, 10 Apr 2025 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UevNFDt/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419A1B4F0F
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249632; cv=none; b=M22ShC/bG7XVGN0kJ6qto5XL/vUjzlCvxv1cbXtFkn/EAM1oQJOA9g9xk72fNzh1egrovJZxHXiE/7QiVR7MdPhEYPKFQv6gi2WI8ENV5c20+hTmPhqDlS3fZb0GFZzL1E5qHKi3QhOstJBDUbeS9IMTwdGF9TTo+Ebkivbgvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249632; c=relaxed/simple;
	bh=isnKNCougcLmJ5pvVmLSxorQwWo1xGQ1wqKfgVLr7Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV/gJvRO6ybLomZdZ0jDRrx5kbEonpbWsqZ2Cjx1d0+NYrMyApB+cAKAgZmp+jJHjmn8D57CXviwhw8UI4B/cKdqbcmE0Qk5bsDdtnCUX6DCe3Pc8oo8FkNxLg6CITM5eu5H0Ogw69r1hh7sPfIdRcDnw2B8Gho/MbeDo8vrfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UevNFDt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68615C4CEEA;
	Thu, 10 Apr 2025 01:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249631;
	bh=isnKNCougcLmJ5pvVmLSxorQwWo1xGQ1wqKfgVLr7Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UevNFDt/Xk1rwwhAZKoTkJcOUkzMbUoYxi9VdVNcPuhfnfMNfyUZjTLqUJznPDrqE
	 qQoOWJWj5TFDdZbUzq9HKhqvsV0cIGziByjTRIYGldjwN3dXxO4PXq7CxI6niZoL1C
	 HEfWc1LtWa6CMjlisMNk4V8mIGp/Y5au8XQf9A4dljOivfyFEpWhUjOLU5VEpQfGpf
	 6o2VfSNLrifqON+K3NI7JxzW8Lll2MqZ8WRU3OJI+hHzGqWoUzVWXaT199cKyOTa0q
	 wzH2/hpayuyia1k895oyqyvPlw1JOCL/l4PTdV0xWtbq4uf56Jvhgt11zhN9iqJ4z7
	 5US8Zv7YdVyOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 02/13] netlink: specs: rt-route: specify fixed-header at operations level
Date: Wed,  9 Apr 2025 18:46:47 -0700
Message-ID: <20250410014658.782120-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C codegen currently stores the fixed-header as part of family
info, so it only supports one fixed-header type per spec. Luckily
all rtm route message have the same fixed header so just move it up
to the higher level.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-route.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 292469c7d4b9..6fa3fa24305e 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -245,12 +245,12 @@ protonum: 0
 
 operations:
   enum-model: directional
+  fixed-header: rtmsg
   list:
     -
       name: getroute
       doc: Dump route information.
       attribute-set: route-attrs
-      fixed-header: rtmsg
       do:
         request:
           value: 26
@@ -320,7 +320,6 @@ protonum: 0
       name: newroute
       doc: Create a new route
       attribute-set: route-attrs
-      fixed-header: rtmsg
       do:
         request:
           value: 24
@@ -329,7 +328,6 @@ protonum: 0
       name: delroute
       doc: Delete an existing route
       attribute-set: route-attrs
-      fixed-header: rtmsg
       do:
         request:
           value: 25
-- 
2.49.0


