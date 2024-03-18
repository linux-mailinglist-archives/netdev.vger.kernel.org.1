Return-Path: <netdev+bounces-80404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D081187EA0C
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5951C20FFC
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66264645B;
	Mon, 18 Mar 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYhEnCDy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1647F4B;
	Mon, 18 Mar 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768331; cv=none; b=mBoAEwrTT5G2tE+437yrrj2lsOBrwyWAyODdJeJ69iJqmjIg/a/ngBzn9C8/tElCYtiloSfvuXInIM3+cu5Yr8eXQ91WbTt8WraMdIsfs8lDLa7o4E4X3n10L2zFeM/A1Iqt8jwmgT3wrpaWOPvE5PDmgWEB9fyoT6keJhEEmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768331; c=relaxed/simple;
	bh=Vf12dd/Egl8nCL4fAZyQY6z00cZn1KGW7EOXwQXKS2U=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=jYDRk23uCmrKRNVxbz6WkyQE/UzSkCWPfjW3TWC8HafOJrLRTg+rTrrJOsebflaef9SuxrNb5ki9r1RqyDdCssNCBtqvaPUjdFQTP5SFJh3hiE3pwiZuBzuK088yL+2UaEU4bTF/zaCL/fMwEgOoeXtcBIgq6SAZalj2Zht6HeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYhEnCDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D813C433F1;
	Mon, 18 Mar 2024 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710768331;
	bh=Vf12dd/Egl8nCL4fAZyQY6z00cZn1KGW7EOXwQXKS2U=;
	h=Subject:From:To:Cc:Date:From;
	b=GYhEnCDyMs3UBDxenTSxg/j7DlqzZZigVWDEAdzKdsoknZd1yF0TQ6zmbbp+7u9Gl
	 /BaCU6v7ke+D/B8cEFv7C3jthtvuWjrFAhWsq9eBCwasJu5TRcv4sdvrbmST7qz95T
	 8Tjfdb5pJcuhstJ9XMQDSv/2gDY03HKQcD141p5xrtHfqiL3ug76gAwBKg88li66nn
	 C3mOE0qz4EawfX8nuqngaeLicL6gUoLfksRHeb4KU2vthZa/JQMpW56HuC1OMU0T6Z
	 94Dt+n9Of2bzWd2zolh1lBpjoIJKgD4cvqPCFg9+l/ZvgFOHtAizuKaSjex6MSm66f
	 YKBXntQY336NQ==
Subject: [PATCH bpf-next V2] bpf/lpm_trie: inline longest_prefix_match for
 fastpath
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, martin.lau@kernel.org,
 netdev@vger.kernel.org, bp@alien8.de, kernel-team@cloudflare.com
Date: Mon, 18 Mar 2024 14:25:26 +0100
Message-ID: <171076828575.2141737.18370644069389889027.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The BPF map type LPM (Longest Prefix Match) is used heavily
in production by multiple products that have BPF components.
Perf data shows trie_lookup_elem() and longest_prefix_match()
being part of kernels perf top.

For every level in the LPM tree trie_lookup_elem() calls out
to longest_prefix_match().  The compiler is free to inline this
call, but chooses not to inline, because other slowpath callers
(that can be invoked via syscall) exists like trie_update_elem(),
trie_delete_elem() or trie_get_next_key().

 bcc/tools/funccount -Ti 1 'trie_lookup_elem|longest_prefix_match.isra.0'
 FUNC                                    COUNT
 trie_lookup_elem                       664945
 longest_prefix_match.isra.0           8101507

Observation on a single random machine shows a factor 12 between
the two functions. Given an average of 12 levels in the trie being
searched.

This patch force inlining longest_prefix_match(), but only for
the lookup fastpath to balance object instruction size.

In production with AMD CPUs, measuring the function latency of
'trie_lookup_elem' (bcc/tools/funclatency) we are seeing an improvement
function latency reduction 7-8% with this patch applied (to production
kernels 6.6 and 6.1). Analyzing perf data, we can explain this rather
large improvement due to reducing the overhead for AMD side-channel
mitigation SRSO (Speculative Return Stack Overflow).

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 kernel/bpf/lpm_trie.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 050fe1ebf0f7..939620b91c0e 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -155,16 +155,17 @@ static inline int extract_bit(const u8 *data, size_t index)
 }
 
 /**
- * longest_prefix_match() - determine the longest prefix
+ * __longest_prefix_match() - determine the longest prefix
  * @trie:	The trie to get internal sizes from
  * @node:	The node to operate on
  * @key:	The key to compare to @node
  *
  * Determine the longest prefix of @node that matches the bits in @key.
  */
-static size_t longest_prefix_match(const struct lpm_trie *trie,
-				   const struct lpm_trie_node *node,
-				   const struct bpf_lpm_trie_key_u8 *key)
+static __always_inline
+size_t __longest_prefix_match(const struct lpm_trie *trie,
+			      const struct lpm_trie_node *node,
+			      const struct bpf_lpm_trie_key_u8 *key)
 {
 	u32 limit = min(node->prefixlen, key->prefixlen);
 	u32 prefixlen = 0, i = 0;
@@ -224,6 +225,13 @@ static size_t longest_prefix_match(const struct lpm_trie *trie,
 	return prefixlen;
 }
 
+static size_t longest_prefix_match(const struct lpm_trie *trie,
+				   const struct lpm_trie_node *node,
+				   const struct bpf_lpm_trie_key_u8 *key)
+{
+	return __longest_prefix_match(trie, node, key);
+}
+
 /* Called from syscall or from eBPF program */
 static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 {
@@ -245,7 +253,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 		 * If it's the maximum possible prefix for this trie, we have
 		 * an exact match and can return it directly.
 		 */
-		matchlen = longest_prefix_match(trie, node, key);
+		matchlen = __longest_prefix_match(trie, node, key);
 		if (matchlen == trie->max_prefixlen) {
 			found = node;
 			break;



