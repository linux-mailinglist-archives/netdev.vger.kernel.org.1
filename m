Return-Path: <netdev+bounces-155233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20433A017BE
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077C01624BA
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41A35977;
	Sun,  5 Jan 2025 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS1emyfX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83735961
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040330; cv=none; b=OFzG4ht7eeJVavSlKu7E6uvj5I7oU3+T9FmCUIrV4y0s0dFWZn6LEx7vZ224gVHthT3KSRZF2qgpgFQRjp+brGpIGyZ6Z3vGXX8FYVpa1GXpGUOYzcz2vuTUthv416Cd2WO8I/AaAawJRjv0S2vVKDeakUlYaGW6syAb1+a9+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040330; c=relaxed/simple;
	bh=6MonRFTi3F9rFmbR0sv9hYcpzmfgujw4rt8BgrxAWjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFNJBj6R+nVwE+rU5SYEVI38mV7un5Hypc77bgVBtLZQmlf5Jn3wUPMgIhY21urCERmKx14hUeO6WqLIREtk598jlrWX6Nv+hbnIOoOtPBFCTn1N9OqffN+NKClSz8BqPDDqw9R/ANwtXeqdF0S3KYyk+Inj0Rb3ooh5she/ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS1emyfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224E9C4CEE0;
	Sun,  5 Jan 2025 01:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736040329;
	bh=6MonRFTi3F9rFmbR0sv9hYcpzmfgujw4rt8BgrxAWjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pS1emyfXxxXGLWZA64TNETHDQQF/0k9/akXQYBdE9nA+sapbaLLDuKvkcCtSpPPhJ
	 XhCUNGw7Hj0CxeRsfSz3HqTF9/XhLEG/0s3r+uNCQv1GOxKzeWYmkIwEPYkXpeeJml
	 oB0pkC14vMt0iDROV6TJPzcxfLIsjOt1PNdCLq4qi/Ev+bdmsjKRgP2gKwhhuqMsEp
	 C1bA/yh3Q4Xz3VV1VQuA6ze+FpEUWlb5IwKawEncJ8BKPYFLjsEar916wsZuUGJ4qb
	 FfIh4rzOmFHDHS2FVzHhb9Bb93S2AIp5KhzAfSJVyCXJrze+4IqxutitMiGpdOZwtb
	 /oEmwj9gzZC7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] tools: ynl: correctly handle overrides of fields in subset
Date: Sat,  4 Jan 2025 17:25:21 -0800
Message-ID: <20250105012523.1722231-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105012523.1722231-1-kuba@kernel.org>
References: <20250105012523.1722231-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We stated in documentation [1] and previous discussions [2]
that the need for overriding fields in members of subsets
is anticipated. Implement it.

[1] https://docs.kernel.org/next/userspace-api/netlink/specs.html#subset-of
[2] https://lore.kernel.org/netdev/20231004171350.1f59cd1d@kernel.org/

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/nlspec.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index a745739655ad..314ec8007496 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -219,7 +219,10 @@ jsonschema = None
         else:
             real_set = family.attr_sets[self.subset_of]
             for elem in self.yaml['attributes']:
-                attr = real_set[elem['name']]
+                real_attr = real_set[elem['name']]
+                combined_elem = real_attr.yaml | elem
+                attr = self.new_attr(combined_elem, real_attr.value)
+
                 self.attrs[attr.name] = attr
                 self.attrs_by_val[attr.value] = attr
 
-- 
2.47.1


