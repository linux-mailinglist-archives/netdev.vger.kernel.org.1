Return-Path: <netdev+bounces-191240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D5ABA74A
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63401C026B1
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBBC10F9;
	Sat, 17 May 2025 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTSa+8h9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBB4C76
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440813; cv=none; b=NJOjwrVJbEqURZ/98LJO30Nth8TN97or2KD+N26gm77J8L22cWesjqKI3+DYqDLdU1dJQvQXxbU07Tn3tDDEHC8Qpby5668DQN40NoRyY243zEwXuXs8iFZM2Yw+VUSJ5yLl5pR6qokIBnS4IEjyHx1qqmn1m+3T3cgsSS2mopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440813; c=relaxed/simple;
	bh=Y1lgWsYPnCgmJK8tq4MX2EgN5kms7BJMTB1MHDZYCYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvwno/5s4IsAzF268ZyG8eLO/N9zgaAOIDylZ+KhkWIJRkgH9SxDX9NaYCdggj7VaIjkSol99JwNPOYsVdT+XcA7uRcENdSuQCoD0+EEt0ZYpaV+OPJgLkPs5eha4sbWOHfEICj5rmFvx3ROoQM3as+KEiK2FihuZsAHevjpOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTSa+8h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C2DC4CEF0;
	Sat, 17 May 2025 00:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440812;
	bh=Y1lgWsYPnCgmJK8tq4MX2EgN5kms7BJMTB1MHDZYCYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTSa+8h9qBrdsLOjedETFUsfjpvdlxvrpgl5ll2kh34ekg9usG+3W4LgYfEmFr0ny
	 0KxSsllagCSPmEp87JXhPaowtbtzCEGZ/mOXwb5XICU5i8XRKNat/0aNszuGhyiNy1
	 RvZUhX9tk/kp0qsdW0niLGjrV6bMyPyLEdo1IWdJXrA7Fh7BuDFKnnS1hR34k3QfZs
	 UOSoVHimoLbg9gk49XRF/O8VSsxL1vdsMdSXMFWDJ1g3hLgbjSl1y33le5ip9h0lBF
	 Crn2I5GASkWSjSRvrCf7pjMaf60ELraa4lrigat1AIMzxN5w5oYPfuED2XxcgaLQPL
	 fdTncG1qSxW8g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/11] netlink: specs: tc: use tc-gact instead of tc-gen as struct name
Date: Fri, 16 May 2025 17:13:09 -0700
Message-ID: <20250517001318.285800-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a define in the uAPI header called tc_gen which expands
to the "generic" TC action fields. This helps other actions include
the base fields without having to deal with nested structs.

A couple of actions (sample, gact) do not define extra fields,
so the spec used a common tc-gen struct for both of them.
Unfortunately this struct does not exist in C. Let's use gact's
(generic act's) struct for basic actions.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tc.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index c7e6a734cd12..697fdd1219d5 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -1186,7 +1186,7 @@ protonum: 0
         name: firstuse
         type: u64
   -
-    name: tc-gen
+    name: tc-gact
     type: struct
     members:
       -
@@ -3457,7 +3457,7 @@ protonum: 0
       -
         name: parms
         type: binary
-        struct: tc-gen
+        struct: tc-gact
       -
         name: rate
         type: u32
@@ -3480,7 +3480,7 @@ protonum: 0
       -
         name: parms
         type: binary
-        struct: tc-gen
+        struct: tc-gact
       -
         name: prob
         type: binary
-- 
2.49.0


