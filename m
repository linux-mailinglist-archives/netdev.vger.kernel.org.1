Return-Path: <netdev+bounces-180524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7A2A81993
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD4B1900382
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16F8DDBC;
	Wed,  9 Apr 2025 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozhWrx0V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA69BE67
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157064; cv=none; b=scdPSP5deMxiIaVrEc4PPoKYQkIgT7mN7r6DJzMRP5XDdMXMCQMEQoWEdGMqNKTHwVNDrD+l7i5x7bpzFcKBR3bizdNAzOMt/m+R9pb6T2BXPV7e45FDGZp6JWVS+1ykTGDeMiH/8A1QkC6ZLhR3IiFFn+qmrVBkKUnHVO7zDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157064; c=relaxed/simple;
	bh=XT/vAHIW4Bv4/CP/kihvWcUwTLw5FolzCZ8T2HANAJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ge+JI+a5BE5LJfXCDS/+YFvW3JMS0nGCmDCZ+ehKyILAZIX+RgOdyn+jBXXxiGSdUmwooGEX6UcBt1U03Plem4OIDOOHQKR9wtBiuuxONUnSOH6h+K2Uurpeprw7OYRPNAQdCAbVe/agnHYXL0U+ucSVHMhLWu/rNrHUgt8qGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozhWrx0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982AEC4CEEC;
	Wed,  9 Apr 2025 00:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157064;
	bh=XT/vAHIW4Bv4/CP/kihvWcUwTLw5FolzCZ8T2HANAJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozhWrx0VkXplXX1OxxomUE0dRiVfcEwIleNnBQwhnr5wbBrVsEJRO5iXNCIIEvCw+
	 K3d40qod59IpElFqrJwFyqNoN5Mz43AfVjKtcQ4yK3HXKhHY4SXP1UlCxjIBURrBN3
	 Pvk33yB7Ja2SonwYD6eC73Jo6APdFSitjU7SN/k2PNSsKdoE+yYYA3qRW8SYzz/AHT
	 yU1iDHi9r95EF9kds443mo29On0+gonmibiaypaY3Ghv0StytctGc8TBsJKm6VnD9G
	 A2YVmAE1WA9rAA8WBwUylGUxeRLvUpVm5pYfzQAIAw9E7nS9NygQNMG6Z4HeI98Etj
	 FoHTGcm93kiSQ==
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
Subject: [PATCH net-next 03/13] netlink: specs: rt-addr: remove the fixed members from attrs
Date: Tue,  8 Apr 2025 17:03:50 -0700
Message-ID: <20250409000400.492371-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409000400.492371-1-kuba@kernel.org>
References: <20250409000400.492371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of the attribute list is to list the attributes
which will be included in a given message to shrink the objects
for families with huge attr spaces. Fixed structs are always
present in their entirety so there's no point in listing
their members. Current C codegen doesn't expect them and
tries to look up the names in the attribute space.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-addr.yaml | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index df6b23f06a22..0488ce87506c 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -133,11 +133,6 @@ protonum: 0
         request:
           value: 20
           attributes: &ifaddr-all
-            - ifa-family
-            - ifa-flags
-            - ifa-prefixlen
-            - ifa-scope
-            - ifa-index
             - address
             - label
             - local
@@ -150,11 +145,6 @@ protonum: 0
         request:
           value: 21
           attributes:
-            - ifa-family
-            - ifa-flags
-            - ifa-prefixlen
-            - ifa-scope
-            - ifa-index
             - address
             - local
     -
@@ -164,8 +154,7 @@ protonum: 0
       dump:
         request:
           value: 22
-          attributes:
-            - ifa-index
+          attributes: []
         reply:
           value: 20
           attributes: *ifaddr-all
@@ -177,9 +166,7 @@ protonum: 0
       do:
         request:
           value: 58
-          attributes:
-            - ifa-family
-            - ifa-index
+          attributes: []
         reply:
           value: 58
           attributes: &mcaddr-attrs
@@ -188,8 +175,7 @@ protonum: 0
       dump:
         request:
           value: 58
-          attributes:
-            - ifa-family
+          attributes: []
         reply:
           value: 58
           attributes: *mcaddr-attrs
-- 
2.49.0


