Return-Path: <netdev+bounces-80450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA087ECFB
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 17:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6861F21C42
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1468E52F8C;
	Mon, 18 Mar 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oJTRsKNq"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABA52F79
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778084; cv=none; b=o9BoiAWUxyZPGDSrNxkDd+Tt1L9R/qt6tSgqGWEhbCcjuJMChniRHVxlgHGF7rTzMe7fcjomIOVSyxUy0XQbJyc2Pe1ogo309+U0UHdOA5byOVyoNzhjDvX6V74ABOg7f384RjBmWGNi5MH8kQRsLXVZaQdtFLc9V70KGo2b/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778084; c=relaxed/simple;
	bh=XftcC/cufe2hINAjtjXcT+EDnMGkcOcgTjiPHmt1bdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iakNv7LBsuv25Ks6mIZwniojSoXou/VBzimwExFfDFNcA+IfgYtY3tqosZBQ6lfKUM4el3bQdKNaDZehJ0DYCaE3iNlvbmhxciqVTUGTcGGOnXqCJhD21CLsZF1tFfoBukKB0WjKIdFQ/P7EV7OET1oSbeyUHwHZLJ0jgBJd2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oJTRsKNq; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b849aa68-0f7e-455f-ba09-ff1c811db771@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710778080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwQPOjQn9KdVqbATUorSxLxTcDNlvestQijqzOe8SZs=;
	b=oJTRsKNqqrV1j8KZgt32XH+1pFyT52699CiQPGgQObTaFqP2snDQkONaqHQowRki3F02UT
	Ot7SfvR0evdgnzE9g6SieZbM/2LB+WWHiDQHEYMQB6c/0rjMAEDcjN345VbRKCPLUWkAZm
	SSoTLg4fBa37DH+apsl7WP7A/2CObTM=
Date: Mon, 18 Mar 2024 09:07:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V2] bpf/lpm_trie: inline longest_prefix_match for
 fastpath
Content-Language: en-GB
To: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Daniel Borkmann <borkmann@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, martin.lau@kernel.org,
 netdev@vger.kernel.org, bp@alien8.de, kernel-team@cloudflare.com
References: <171076828575.2141737.18370644069389889027.stgit@firesoul>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <171076828575.2141737.18370644069389889027.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/18/24 6:25 AM, Jesper Dangaard Brouer wrote:
> The BPF map type LPM (Longest Prefix Match) is used heavily
> in production by multiple products that have BPF components.
> Perf data shows trie_lookup_elem() and longest_prefix_match()
> being part of kernels perf top.
>
> For every level in the LPM tree trie_lookup_elem() calls out
> to longest_prefix_match().  The compiler is free to inline this
> call, but chooses not to inline, because other slowpath callers
> (that can be invoked via syscall) exists like trie_update_elem(),
> trie_delete_elem() or trie_get_next_key().
>
>   bcc/tools/funccount -Ti 1 'trie_lookup_elem|longest_prefix_match.isra.0'
>   FUNC                                    COUNT
>   trie_lookup_elem                       664945
>   longest_prefix_match.isra.0           8101507
>
> Observation on a single random machine shows a factor 12 between
> the two functions. Given an average of 12 levels in the trie being
> searched.
>
> This patch force inlining longest_prefix_match(), but only for
> the lookup fastpath to balance object instruction size.
>
> In production with AMD CPUs, measuring the function latency of
> 'trie_lookup_elem' (bcc/tools/funclatency) we are seeing an improvement
> function latency reduction 7-8% with this patch applied (to production
> kernels 6.6 and 6.1). Analyzing perf data, we can explain this rather
> large improvement due to reducing the overhead for AMD side-channel
> mitigation SRSO (Speculative Return Stack Overflow).
>
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

I checked out internal PGO (Profile-Guided Optimization) kernel and
it did exactly like the above described: longest_prefix_match() is inlined
to trie_lookup_elem(), but not others.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/lpm_trie.c |   18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 050fe1ebf0f7..939620b91c0e 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -155,16 +155,17 @@ static inline int extract_bit(const u8 *data, size_t index)
>   }
>   
>   /**
> - * longest_prefix_match() - determine the longest prefix
> + * __longest_prefix_match() - determine the longest prefix
>    * @trie:	The trie to get internal sizes from
>    * @node:	The node to operate on
>    * @key:	The key to compare to @node
>    *
>    * Determine the longest prefix of @node that matches the bits in @key.
>    */
> -static size_t longest_prefix_match(const struct lpm_trie *trie,
> -				   const struct lpm_trie_node *node,
> -				   const struct bpf_lpm_trie_key_u8 *key)
> +static __always_inline
> +size_t __longest_prefix_match(const struct lpm_trie *trie,
> +			      const struct lpm_trie_node *node,
> +			      const struct bpf_lpm_trie_key_u8 *key)
>   {
>   	u32 limit = min(node->prefixlen, key->prefixlen);
>   	u32 prefixlen = 0, i = 0;
> @@ -224,6 +225,13 @@ static size_t longest_prefix_match(const struct lpm_trie *trie,
>   	return prefixlen;
>   }
>   
> +static size_t longest_prefix_match(const struct lpm_trie *trie,
> +				   const struct lpm_trie_node *node,
> +				   const struct bpf_lpm_trie_key_u8 *key)
> +{
> +	return __longest_prefix_match(trie, node, key);
> +}
> +
>   /* Called from syscall or from eBPF program */
>   static void *trie_lookup_elem(struct bpf_map *map, void *_key)
>   {
> @@ -245,7 +253,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
>   		 * If it's the maximum possible prefix for this trie, we have
>   		 * an exact match and can return it directly.
>   		 */
> -		matchlen = longest_prefix_match(trie, node, key);
> +		matchlen = __longest_prefix_match(trie, node, key);
>   		if (matchlen == trie->max_prefixlen) {
>   			found = node;
>   			break;
>
>
>

