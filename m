Return-Path: <netdev+bounces-180532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7297AA8199B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86251900427
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB87082D;
	Wed,  9 Apr 2025 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpqSak1P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5A6F305
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157070; cv=none; b=QrPAZr/R/ge0652IeLnEC8QgiHM81P5tHVWPwk4vTFw5LoOX9rP5oro2iSX/HxmrO4H33VzeArzK6uXBzyFOqUNkjdBP1+EZKefAyKC0ZeDOEAZ5xmOCzOG1YsUkiqeL9G4SGgms95aM3EiWr3/EI7WKLXNHH3Ist/rqQa3mvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157070; c=relaxed/simple;
	bh=NqkWdvZYizdpf4a6+3a6mmJwSrEipCzNUFfKJC0GVUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbju1xBiVBSuPWK1DBaEoujqxtN4gkcNflPkv3HV34ha0TocxrD9Eb0mklDFmGz4M5srkruZWyd00M9SRcHXktlhCWHDKu0YGdC0Nu0u7EBMPdR/jDQTL7pVsMbs/J+0Mm1/ylJi2TJtkwnywlwHbM73utwIAavghuuDKwMuaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpqSak1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC24FC4CEE9;
	Wed,  9 Apr 2025 00:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157070;
	bh=NqkWdvZYizdpf4a6+3a6mmJwSrEipCzNUFfKJC0GVUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpqSak1PvNUNvPH56rh8am5eVtfm7Hff266N9Onl0UCMG6VJYopTadB/EVtewITZz
	 m/R3BHOVXnXK3oMOY/+Fd8BErkXdJcYcBc9Nm+k4x4s51aWkf82drV1Pvb46VWkInd
	 yWP8V4OyvPLxraNRqmIPz2hznc9w+oKiDNv1tQdoZw1uIhnoAr2PhjnUj/SxAKwOmL
	 x4y7sOX0NCQJFgJDH087sjPluog4LZD3bQ54uumQxiK5PASRKblTcowiCaGPfzSYM1
	 ZQHGi4XjgqNt8Pa704nyXu4SJxkubdehSFgclAqKHdNjVuXVNS0SsFBv9PwlsgluFq
	 Pqxbf5sUmYPmw==
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
Subject: [PATCH net-next 11/13] tools: ynl-gen: use family c-name in notifications
Date: Tue,  8 Apr 2025 17:03:58 -0700
Message-ID: <20250409000400.492371-12-kuba@kernel.org>
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

Family names may include dashes. Fix notification handling
code gen to the c-compatible name.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index c97cda43a604..5fa1db3d5cf3 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2726,7 +2726,7 @@ _C_KW = {
         return
 
     if family.ntfs:
-        cw.block_start(line=f"static const struct ynl_ntf_info {family['name']}_ntf_info[] = ")
+        cw.block_start(line=f"static const struct ynl_ntf_info {family.c_name}_ntf_info[] = ")
         for ntf_op_name, ntf_op in family.ntfs.items():
             if 'notify' in ntf_op:
                 op = family.ops[ntf_op['notify']]
@@ -2756,8 +2756,8 @@ _C_KW = {
     else:
         cw.p('.hdr_len\t= sizeof(struct genlmsghdr),')
     if family.ntfs:
-        cw.p(f".ntf_info\t= {family['name']}_ntf_info,")
-        cw.p(f".ntf_info_size\t= YNL_ARRAY_SIZE({family['name']}_ntf_info),")
+        cw.p(f".ntf_info\t= {family.c_name}_ntf_info,")
+        cw.p(f".ntf_info_size\t= YNL_ARRAY_SIZE({family.c_name}_ntf_info),")
     cw.block_end(line=';')
 
 
-- 
2.49.0


