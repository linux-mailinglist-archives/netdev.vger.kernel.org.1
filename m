Return-Path: <netdev+bounces-79485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F4879750
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6761F24A77
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328C7C0BE;
	Tue, 12 Mar 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7R5J0ZO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6AB7C0AF;
	Tue, 12 Mar 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256624; cv=none; b=YyPcgpVGv5UKp8pZxB/AdVsyKhAJMCaS9WGXz+ndOrGDtYaphIWTDIZi02cvcPzAqlAeolsTev91EMbtwP3Ds3W+byww0GA3KddwR1gWTZBnQggC2cwLbRrj1FOnUToxGS7vy7swhOyI6YoaYbvLegJI41coNm8qKMBG9pUicdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256624; c=relaxed/simple;
	bh=bSthC5syu0b9DNJKbHK9XMaq4/xDZjjE/HnWodCOT0M=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=fc1UdfgqWlN4wBpAPz/2AGCIpkNr/P49zuzWff9NI3mfTdTqiUilp6fv8cIwDfD2kBkN3RNPLgt8W8q8ZJOy3iU3Wf3rpoqZbJE3mHVoXaXB9I+U+Y6XNn5NAXP5vcWUS76eZcYH9GHrZ11LIk0QoUxlMa/qRzcLv3Zg29RrOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7R5J0ZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01613C433C7;
	Tue, 12 Mar 2024 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710256624;
	bh=bSthC5syu0b9DNJKbHK9XMaq4/xDZjjE/HnWodCOT0M=;
	h=Subject:From:To:Cc:Date:From;
	b=D7R5J0ZOluy2ENp7xwzCobRUEGVFN/U3YBtuScjB0Lmstqr9ZfHjdR2l8l2BP1ixs
	 GB6X7mGMggMvoewtaGm7zwhYV+Rn8O1Lcxv3uDB7ZMDPOf/GJJ6qD+h2q+AXCrX7vM
	 3LNngxj2AFoShllOWczsXlNk5T470CEPnSuJEQCx56r7hRvk7WdT52z5VVAAwe7Q/r
	 7E0HKIVoOXxfMM8kywm8dJJy1kp0c+go2AozNgCb9OKTd3gqhy6U2ibk0vwVaeJ2xG
	 vHbZZ5fqpyuHpT/djxEs37zyJmTO9XnWG5CQa+ZDwqK5CYIL1ZK4vB9ipAhfOpCfZG
	 XpYXQc0Xb4GWQ==
Subject: [PATCH bpf-next] bpf/lpm_trie: inline longest_prefix_match for
 fastpath
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>, martin.lau@kernel.org,
 netdev@vger.kernel.org, kernel-team@cloudflare.com
Date: Tue, 12 Mar 2024 16:17:00 +0100
Message-ID: <171025648415.2098287.4441181253947701605.stgit@firesoul>
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

Observation on a single random metal shows a factor 12 between
the two functions. Given an average of 12 levels in the trie being
searched.

This patch force inlining longest_prefix_match(), but only for
the lookup fastpath to balance object instruction size.

 $ bloat-o-meter kernel/bpf/lpm_trie.o.orig-noinline kernel/bpf/lpm_trie.o
 add/remove: 1/1 grow/shrink: 1/0 up/down: 335/-4 (331)
 Function                                     old     new   delta
 trie_lookup_elem                             179     510    +331
 __BTF_ID__struct__lpm_trie__706741             -       4      +4
 __BTF_ID__struct__lpm_trie__706733             4       -      -4
 Total: Before=3056, After=3387, chg +10.83%

Details: Due to AMD mitigation for SRSO (Speculative Return Stack Overflow)
these function calls have additional overhead. On newer kernels this shows
up under srso_safe_ret() + srso_return_thunk(), and on older kernels (6.1)
under __x86_return_thunk(). Thus, for production workloads the biggest gain
comes from avoiding this mitigation overhead.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
I do know net-next is closed
 https://netdev.bots.linux.dev/net-next.html

Hoping BPF maintainers can queue this patch anyhow.
If not feel free to drop and I will try to remember to resubmit.

 kernel/bpf/lpm_trie.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 050fe1ebf0f7..7a6f39425e14 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -162,9 +162,10 @@ static inline int extract_bit(const u8 *data, size_t index)
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



