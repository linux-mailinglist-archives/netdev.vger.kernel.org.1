Return-Path: <netdev+bounces-200843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6AFAE7155
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A02D5A1CDF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C479625A33E;
	Tue, 24 Jun 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSCmXhiC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6CF25A323
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799410; cv=none; b=jcYASrd8z3lBrmb7U9SgnBju+RZ/TsyRFeT/0So1pCUle81zkZjhQhlNAyACRb8M9bCAMANHJnovzfSsGpMJYEgEAfbzguQ1wxP0fPct/Q40sxq/0aZU0K8UCyfwjdsSf3YRDjl7/mAr23iZlwkb4w2+Ii5VAAJni9mRExo905Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799410; c=relaxed/simple;
	bh=PTC4OlbJlGYwczpcPO5nJSUOD/8kX5HD/udqtXGA2do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoNANNXYjqFh8PTXNkJghrxzSgJ6Gv2NxDWxHnYwkFBBUuOiga3W78clNE5PxvPmdgDC2+f8Wkucb7dOLPO6bCjhgnCp++uwwedz6el0oH/CCTOk/ZUdbMZCst95Iz+e2WMu1ofpPn1rKkYvhpK7OxgRk6OWw1rhGf1+1+NYuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSCmXhiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08703C4CEF5;
	Tue, 24 Jun 2025 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799410;
	bh=PTC4OlbJlGYwczpcPO5nJSUOD/8kX5HD/udqtXGA2do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSCmXhiCQ90LZNqORs21tLe9Z2afLbc8082POs0b65T4r9TK21iHGdE+9OtH2ntLo
	 j2GrcObsGRBJcVI2NI6J4/EM2lsK6wQET+Ri8f7vDktY0XTWiO3lwTQWHX5fdlY+mL
	 f0VkCImvtKEQEiUH0pJEn5vH2dQ3qxl/ymBtv6eUbwEMlhwQ4ziVIBUsofIKmBrWv+
	 nRp1iXFk46la6lRZEKXLbF8DMfQfAzVm647SYKTE8ssot9lEVqPGSBkzJ2fmMBBoiA
	 DTttcMcxirLU80X7Ohwcn+jhg/UVABH5Zl0dr1Lj8PBf6ZFSkULQYfZ7dfSj3+qhC6
	 W8Rja9bupHW3Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	i.maximets@ovn.org,
	amorenoz@redhat.com,
	echaudro@redhat.com,
	michal.kubiak@intel.com
Subject: [PATCH net 06/10] netlink: specs: ovs_flow: replace underscores with dashes in names
Date: Tue, 24 Jun 2025 14:09:58 -0700
Message-ID: <20250624211002.3475021-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624211002.3475021-1-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're trying to add a strict regexp for the name format in the spec.
Underscores will not be allowed, dashes should be used instead.
This makes no difference to C (codegen, if used, replaces special
chars in names) but it gives more uniform naming in Python.

Fixes: 93b230b549bc ("netlink: specs: add ynl spec for ovs_flow")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: i.maximets@ovn.org
CC: amorenoz@redhat.com
CC: echaudro@redhat.com
CC: michal.kubiak@intel.com
---
 Documentation/netlink/specs/ovs_flow.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 46f5d1cd8a5f..7974aa7d8905 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -216,7 +216,7 @@ uapi-header: linux/openvswitch.h
     type: struct
     members:
       -
-        name: nd_target
+        name: nd-target
         type: binary
         len: 16
         byte-order: big-endian
@@ -258,12 +258,12 @@ uapi-header: linux/openvswitch.h
     type: struct
     members:
       -
-        name: vlan_tpid
+        name: vlan-tpid
         type: u16
         byte-order: big-endian
         doc: Tag protocol identifier (TPID) to push.
       -
-        name: vlan_tci
+        name: vlan-tci
         type: u16
         byte-order: big-endian
         doc: Tag control identifier (TCI) to push.
-- 
2.49.0


