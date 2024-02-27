Return-Path: <netdev+bounces-75491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13886A296
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F73B24C75
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3BB55C27;
	Tue, 27 Feb 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh2pWNyD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6F55C1D
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073047; cv=none; b=bq/VW+zsCRfPs3wRSSjV+rhLAOwMwt7QctAYRIFfqpPESVlJXoD5nEp6TOMGwtZQ9mEp3xx99m3t5JVI5deEWqAf6Ifki/3r1mR4G7H5WbqbTFftd9dwqrdkFNJ5bwIpTBOaeypf+4URYWkeTE/6qBZsuKOD4FPKFA6CmZg6J4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073047; c=relaxed/simple;
	bh=9Js9D3cQJjlLTbnUnl0nFTnqgVXobg1gL/NJ9WZGfzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oenUSDEHNCaS3N9IXFj2RlEM/3/7957Ieb3UWNPCzJcWIVOB269urDiBPyY466t68oxnYHN4tPndweefuM6hlZUtq6D4WQbtwpfuA9KPJv+2iq3ICvdNfbXJDvd92jYrw8YAJecsJBw3YgJDqUHZIxQsW1wiv5lbrk/XkHVp8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh2pWNyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1F0C433C7;
	Tue, 27 Feb 2024 22:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073046;
	bh=9Js9D3cQJjlLTbnUnl0nFTnqgVXobg1gL/NJ9WZGfzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eh2pWNyDF7R1atUJZPNIMTZwuxjyP+DIyynJP3x0yI64SiIZBV3njlc16wdqX9h/2
	 mgiSIpCDWtvbHVs6XjjxyHbb/5lOMmMvhjV153Qy9Af0QrkRkf1hOJaB52052iQ4nZ
	 bCALijUPxMFOxsR28Yhwtzq0M8Misw6MqGF8A1/naY5wKoApItB0xI8hCatpar1Wc7
	 r+zzN6ivUNc9TJHTlSu2trIvVVfHJirI1+3M1t2Kpl50fzfv/WHN4c8SIhW8Bgmdo5
	 mZ5f9onyx+ukJAulnDC70VV5KcNp06ikLDaL6MyY8vGbGZ5ymaOajEyOzMSiXlUzfI
	 K3tNbot5ZqFqg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 05/15] tools: ynl: create local ARRAY_SIZE() helper
Date: Tue, 27 Feb 2024 14:30:22 -0800
Message-ID: <20240227223032.1835527-6-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227223032.1835527-1-kuba@kernel.org>
References: <20240227223032.1835527-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libc doesn't have an ARRAY_SIZE() create one locally.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 3 +++
 tools/net/ynl/ynl-gen-c.py   | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 1dfa09497be8..7f24d07692bf 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -27,6 +27,9 @@ enum ynl_policy_type {
 	YNL_PT_BITFIELD32,
 };
 
+#define YNL_ARRAY_SIZE(array)	(sizeof(array) ?			\
+				 sizeof(array) / sizeof(array[0]) : 0)
+
 struct ynl_policy_attr {
 	enum ynl_policy_type type;
 	unsigned int len;
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 90d7bf4849fc..407902b903e0 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1535,7 +1535,7 @@ _C_KW = {
     cw.block_start()
     if enum and enum.type == 'flags':
         cw.p(f'{arg_name} = ffs({arg_name}) - 1;')
-    cw.p(f'if ({arg_name} < 0 || {arg_name} >= (int)MNL_ARRAY_SIZE({map_name}))')
+    cw.p(f'if ({arg_name} < 0 || {arg_name} >= (int)YNL_ARRAY_SIZE({map_name}))')
     cw.p('return NULL;')
     cw.p(f'return {map_name}[{arg_name}];')
     cw.block_end()
@@ -2569,7 +2569,7 @@ _C_KW = {
         cw.p('.hdr_len\t= sizeof(struct genlmsghdr),')
     if family.ntfs:
         cw.p(f".ntf_info\t= {family['name']}_ntf_info,")
-        cw.p(f".ntf_info_size\t= MNL_ARRAY_SIZE({family['name']}_ntf_info),")
+        cw.p(f".ntf_info_size\t= YNL_ARRAY_SIZE({family['name']}_ntf_info),")
     cw.block_end(line=';')
 
 
-- 
2.43.2


