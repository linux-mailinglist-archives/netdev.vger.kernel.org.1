Return-Path: <netdev+bounces-268504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNTIGScfuWmbrQEAu9opvQ
	(envelope-from <netdev+bounces-268504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C32A6BFD
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ACD0302A6F8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60434FF48;
	Tue, 17 Mar 2026 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsaTgQwK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA02BCF68;
	Tue, 17 Mar 2026 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739634; cv=none; b=r45kKqMpKj2KERunRY0Ri53RcocJv+3b1bDBcaeZCoqqYC62O+qNolL/uMCcK/HiPtzeDPJU0oxmiGKQqblmktW7W+xqf49GPhtEvEaRbZnDeQ6RGmVLRbRo1eVAHRuNDTczYp4WwDMnNNtFkIq2oFVM9EtzH0OUg9hd55Gp4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739634; c=relaxed/simple;
	bh=46E2SlrKDMjiwhogUjCXQSWTkXudOZYJWyeylVxGdzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Haz/EFn5j44g/vnoIs020y66ArhUdpiDAj2foihIbcjzLRLECS7Qjin0swJa99vsP60Z6PpcAWqOG0c0SCQIB3c9VnFx3Ycje4QfcGyQIkK9g6WITfxr0M9InIz3pnyoA84lZX0HU8y3sRzHfrEiCkkugG1pD2MdytDCv8YCFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsaTgQwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41523C4CEF7;
	Tue, 17 Mar 2026 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739633;
	bh=46E2SlrKDMjiwhogUjCXQSWTkXudOZYJWyeylVxGdzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qsaTgQwKxteJBbOmGDC6tJd5agwejIg80OIKBYudI9qwW5FbG98DhwvxV2RnQbUgM
	 L3y3zTQC6HIFBmd53i5VB+PAv36z5qI+7LqtxvajF/q9I+jyQkg1KlyaOspG2NBctW
	 jpmTQV8TaN8gmhHnNOljwmzKnT4OJECzdOPq9cUVB0qdtf/TuyzXnedgVg3C3+pQ+1
	 FacJ2h52az4Me/ogl5LZYh5BCiX73lFOa94oE1xqKSCYmgEohN8Xn9R9IPtVJnRXMg
	 ei5mqurfEI94uqOapIBSSCm4OaVKwTsD04xnJiExBbm23VYpTsN1duSjvH02n+FBK8
	 Sowq8ccshIavg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 5/6] selftests: bpf: fix pkt grow tests
In-Reply-To: <20260316174550.462177-6-maciej.fijalkowski@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-6-maciej.fijalkowski@intel.com>
Date: Tue, 17 Mar 2026 10:27:11 +0100
Message-ID: <87v7euq00g.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-268504-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,all.your.base.are.belong.to.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D34C32A6BFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Skip tail adjust tests in xskxceiver for SKB mode as it is not very
> friendly for it. multi-buffer case does not work as xdp_rxq_info that is
> registered for generic XDP does not report ::frag_size. The non-mbuf
> path copies packet via skb_pp_cow_data() which only accounts for
> headroom, leaving us with no tailroom and causing underlying XDP prog to
> drop packets therefore.
>
> For multi-buffer test on other modes, change the amount of bytes we use
> for growth, assume worst-case scenario and take care of headroom and
> tailroom.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  .../selftests/bpf/prog_tests/test_xsk.c       | 21 ++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 7e38ec6e656b..a496f1784b66 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -2551,16 +2551,31 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
>  
>  int testapp_adjust_tail_grow(struct test_spec *test)
>  {
> +	if (test->mode == TEST_MODE_SKB)
> +		return TEST_SKIP;
> +
>  	/* Grow by 4 bytes for testing purpose */
>  	return testapp_adjust_tail(test, 4, MIN_PKT_SIZE * 2);
>  }
>  
>  int testapp_adjust_tail_grow_mb(struct test_spec *test)
>  {
> +	u32 grow_size;
> +
> +	if (test->mode == TEST_MODE_SKB)
> +		return TEST_SKIP;
> +
> +	/* worst case scenario is when underlying setup will work on 3k
> +	 * buffers, let us account for it; given that we will use 6k as
> +	 * pkt_len, expect that it will be broken down to 2 descs each
> +	 * with 3k payload;
> +	 *
> +	 * 4k is truesize, 3k payload, 256 HR, 320 TR;
> +	 */
> +	grow_size = XSK_UMEM__MAX_FRAME_SIZE - XSK_UMEM__LARGE_FRAME_SIZE - 256 - 320;

nit: Use defines, XDP_PACKET_HEADROOM, and maybe
SKB_DATA_ALIGN(sizeof(struct skb_shared_info))?

