Return-Path: <netdev+bounces-287822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEJvI+pZBWomVQIAu9opvQ
	(envelope-from <netdev+bounces-287822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 07:13:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3437253DEBE
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 07:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23C0630058FC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 05:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4052B3AF64B;
	Thu, 14 May 2026 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3ahaRDS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE48D531;
	Thu, 14 May 2026 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735592; cv=none; b=Wz7C1r0OLqa8MNFsaoZPNjg+g32GKeN+j3ZOcCsICqoS0z+pyQQdWFTFK+RmAZnVZyZWEKwHwSO6qgq1dtb5+D3i5Wt3YteApvYJiUdxTy1T7oMLcKaB3CeLzmEjkckiokDzuLa8FUYVfxgCxHrY8MgZZMS6X61A0rWhSn080Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735592; c=relaxed/simple;
	bh=T9lfvGxrx+biqnw8/N/a4VAT5kVWPPAwubFu6rH2Nk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZLHf/PWetB96EsP6xeb59au6gnegteOtowvol54iEYioB97Ml4myUdeEahhhLjM6gMG2tJq6tSpuiVzbPnqQuq+n8sUoI4j4hwJpRZ2XrKD3BikPQqYlmNt2pBbKeo2MDPlR3+wBIt/fOnE/ppPUMDtjM16EqapRCesg9J03/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3ahaRDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6CFC2BCB7;
	Thu, 14 May 2026 05:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778735592;
	bh=T9lfvGxrx+biqnw8/N/a4VAT5kVWPPAwubFu6rH2Nk8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L3ahaRDShL6X91Z8UGBD/vcEmEDVpqcU5IIBoqQsXnLeAjEeOlB4o6huo52jDbNRU
	 RG58Z3b2cinRyHysOH9ssA7NWEcyIbmweRFQkrwekEyXpbWo7oyAbAslE+qgBgDOok
	 hcGC9DccTeC75Os+LGlKwEPmeVsaJXRqpJngAGoZ3TunHP1NqEkZIU1Uo+2AhAmyTe
	 aWI3rZK7cb/gOSQ1rLTDQ7yX51YCnRemJRJhG1LC7DcSZooobPpqPkAVkF63BiFhYg
	 C52FSkh6cp0GqiIwomPbjYk9i/EwcGjNqH+Y3gyX/pmTh3htNl4G5Gf5ZJt8Ym1CY6
	 7GrgVvnI7cNyQ==
Message-ID: <d784e8d3-e6af-4437-93f2-3103720b8454@kernel.org>
Date: Thu, 14 May 2026 07:13:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 0/4] xdp: reuse generic skb XDP handling for
 veth
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org,
 lorenzo@kernel.org, toke@redhat.com, Liang Chen <liangchen.linux@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 "huangjie.albert" <huangjie.albert@bytedance.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3437253DEBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287822-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,huawei.com,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action



On 09/05/2026 10.48, Maciej Fijalkowski wrote:
> Hi,
> 
> this series is an attempt to make skb-backed XDP handling in veth use
> the generic skb XDP machinery instead of converting skb-backed packets
> into xdp_frames for XDP_TX and XDP_REDIRECT. 

I support this idea.  Thanks for working on this Maciej.

I basically proposed the same back in Aug 2023 [1].  My patchset[2] was
motivated by a performance improvement 23.5% see [3], that comes from
avoiding to reallocate most veth packets when XDP is loaded.

Please read veth_benchmark04.org[4] as it documents a number of
pitfalls, and highlight that the main trick to avoid reallocation is
changing net_device needed_headroom (when XDP is loaded).

[1] 
https://lore.kernel.org/all/169272715407.1975370.3989385869434330916.stgit@firesoul/
[2] 
https://lore.kernel.org/all/169272709850.1975370.16698220879817216294.stgit@firesoul/
[3] 
https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark03.org
[4] 
https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark04.org


> This was brought up by
> Jakub during review of previous work, which was focused on addressing
> splats from AF_XDP selftests shrinking multi-buffer packet:
> 
>    https://lore.kernel.org/bpf/20251029221315.2694841-1-maciej.fijalkowski@intel.com/
> 
> veth currently has two different XDP input paths:
>    - xdp_frame input, coming through ndo_xdp_xmit(), for example from
>      devmap redirects; and
>    - skb input, coming through ndo_start_xmit(), for example from the
>      regular networking stack, pktgen, or other skb producers.
> 
> The xdp_frame path is naturally frame-based and this series keeps it on
> the existing veth xdp_frame handling path. The skb path, however, is
> still fundamentally skb-backed, but today veth converts it into an
> xdp_frame for XDP_TX/XDP_REDIRECT. That conversion is awkward and has
> been pointed out as undesirable before, because veth has to pin skb data,
> construct an xdp_frame view of it, and then restore/massage XDP memory
> metadata around that conversion.
> 

Yes, I really dislike the veth approach of stealing the SKB "head"/data
page by bumping the page refcnt directly.  If is awkward as you say.
I would be happy to see that code improved.

> This series takes a different approach: skb-backed veth XDP now reuses
> the generic skb XDP execution path. veth provides its own xdp_buff,
> xdp_rxq_info and page_pool to the generic XDP helper, so the generic code
> can still perform the required skb COW using veth's page_pool when the
> skb head/frags cannot be used directly. XDP_TX then uses generic_xdp_tx()
> and XDP_REDIRECT uses xdp_do_generic_redirect(), while the xdp_frame
> input path keeps using the existing veth xdp_frame TX/redirect handling.

I also used this approach in my patchset, so I like it.

https://lore.kernel.org/all/169272715407.1975370.3989385869434330916.stgit@firesoul/

> The problem this series tries to address more generally is that
> skb-backed generic XDP can end up with memory whose provenance is not
> described correctly by a single queue-level MEM_TYPE_PAGE_SHARED value.
> When skb is COWed the underlying memory is page_pool backed but current
> logic does not respect it.
> 
> For that reason the series introduces MEM_TYPE_PAGE_POOL_OR_SHARED. This
> type is not bound to a single registered page_pool allocator. Instead,
> the return path inspects the individual netmem and dispatches either to
> the page_pool return path or to page_frag_free(). This lets generic
> skb-backed XDP handle mixed page_pool/page-shared memory without
> mutating rxq->mem.type per packet.

I'm unsure about the introduction of MEM_TYPE_PAGE_POOL_OR_SHARED an 
ambiguous memory type.  In [5] I considered adding two new memory types 
MEM_TYPE_KMALLOC_SKB and MEM_TYPE_SKB_SMALL_HEAD_CACHE that __xdp_return 
would handle, but I labeled is as an "uncertain approach" myself.

[5] 
https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark04.org#uncertain-approach


> The veth part also removes the old rq->xdp_mem juggling. For incoming
> xdp_frames, veth now uses a local rxq view whose mem.type is taken from
> frame->mem_type. This preserves the frame's original memory type for
> XDP_TX/XDP_REDIRECT without overwriting the persistent rq->xdp_rxq memory
> model used by skb-backed generic XDP.
> 
> One visible datapath change is that skb-backed veth XDP_TX no longer
> uses veth's xdp_frame bulk queue. It now follows the generic skb XDP_TX
> path. The xdp_frame-originated path is unchanged and still uses the
> existing veth bulk path. The old skb-backed path had batching, but it
> also paid the cost of converting skb-backed packets into xdp_frames. The
> new path removes that conversion and keeps skb-backed packets on the
> generic skb XDP path. From my local tests that consisted of
> pktgen + xdp_bench I did not notice any major performance regressions,
> however Lorenzo and Jesper might disagree here, hence the RFC status. I
> am fed up of internal wars with Sashiko so I would be pleased to get
> some human feedback.
> 

My benchmarking in above documents, showed that needed_headroom change 
was a bigger performance boost than loosing the batching.

For a long time, I have considered adding batching to the generic-XDP 
code path, simply via SKB-list trick.  I did an experiment doing this in 
the past and my benchmarking showed 30% TX performance boost, because 
xmit_more takes effect.  Given people are not suppose to use generic-XDP 
if they care about performance, I never followed up.  If veth start to 
use this generic redirect code path, then it makes sense to do this. In 
production we have code that does XDP redirect of SKBs into veth (I have 
recommended to redirect native xdp_frame's instead, but because traffic 
first need to travel through some DDoS filters in iptables, it cannot be 
done without first moving those filters into XDP).


> In particular, let's discuss:
> 
>    - whether MEM_TYPE_PAGE_POOL_OR_SHARED is an acceptable way to describe
>      skb-backed generic XDP memory that may be page_pool-backed after COW
>      or ordinary page-shared memory otherwise;
> 
>    - whether passing caller-provided xdp_buff/rxq/page_pool context into
>      the generic skb XDP helper is the right API shape;
> 
>    - whether letting veth provide its own page_pool to generic XDP is
>      acceptable for avoiding the old skb->xdp_frame conversion; could
>      veth just piggy-back on system's page_pool? even though it could,
>      we still need xdp_buff being passed (metadata) and other refactors
>      that allow veth to bump stats and do the redirect flush;
> 
>    - whether skb-backed veth XDP_TX using generic_xdp_tx(), while keeping
>      xdp_frame-originated traffic on the existing veth bulk path, is an
>      acceptable split;
> 
>    - the INDIRECT_CALL for taking the COW path; I wanted to preserve
>      existing behavior, but is it really needed or maybe it would be
>      possible to come up with conditions that would cover both generic
>      XDP path and veth?
> 
> FWIW I do like the end result on veth side. If I missed CCing someone,
> mea culpa.

Added Cc
- Liang Chen <liangchen.linux@gmail.com>
- Yunsheng Lin <linyunsheng@huawei.com>
- huangjie.albert@bytedance.com

> 
> Thanks,
> Maciej
> 
> Maciej Fijalkowski (4):
>    xdp: add mixed page_pool/page_shared memory type
>    xdp: return status from generic_xdp_tx()
>    xdp: split generic XDP skb handling
>    veth: use generic skb XDP handling
> 
>   drivers/net/veth.c        | 179 ++++++++------------------------------
>   include/linux/netdevice.h |  33 ++++++-
>   include/net/xdp.h         |   1 +
>   kernel/bpf/devmap.c       |   2 +-
>   net/core/dev.c            | 124 ++++++++++++++++++++------
>   net/core/filter.c         |   2 +-
>   net/core/xdp.c            |  54 ++++++++++--
>   7 files changed, 216 insertions(+), 179 deletions(-)
> 


