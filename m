Return-Path: <netdev+bounces-194417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5BAC95B2
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 20:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F799E64FF
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851927703D;
	Fri, 30 May 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWDXyW/e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73221CA04;
	Fri, 30 May 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748630231; cv=none; b=I7vUDCP6124HJDWF0KxQmNWI8zfXttRb+G0SM64ay7THoB3NDRIDr9ZtnwwfibXMm+9mTj96HL7xOoi3Q5BIngPgnIMMwHldHbSojGxwvb0TDvOV0Pwdr/wpOcbdFElfNFPatPHY064v93B+rTYSxcpBbm6sAGFCZmfE8oDLjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748630231; c=relaxed/simple;
	bh=oL3G93u+nb0bJX6WZzEqm+QZoVM8Zp5SW1I8CcpeCuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2XCS0ik3vC2LvTeh9RLffXZbGhnOAXxjId+AD0fivhXzsGvrU86n9Iuo/0vX6tChRH74GCtkZHaAw1crEmxGOyow8IYRSJuTDecLpOe7uxISrQE4Y36sQoOea2OC8q08eSb3ExlIRCsz+1EZ9A1Uf/z+ISqzjK/0WTNmlEqzGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWDXyW/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB26C4CEE9;
	Fri, 30 May 2025 18:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748630231;
	bh=oL3G93u+nb0bJX6WZzEqm+QZoVM8Zp5SW1I8CcpeCuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWDXyW/ef3bkh1fzw96dptxo4R/01qixJt55SNtKwb/+imEDeCXkTGKKgG6zMAFi4
	 9xg+I2CH7wQIlwHMta3ssdAGNLBKpPfu+ksTcuNxbayPq25qSb2pa9YTjAbG+3vBrD
	 4OCzafvMrCIpfsnGFITKPPeziGcAfwU4L52pyDCj23CybS9ax0YQPljI+gID57i97m
	 VnGnOuaGG6LO7LN01gy4UK7Q6dLvmC5MLZ/TqD88My4TbGO+9plmWzW4AY9J0uvMfo
	 1r814meh6VKcFlRenJjxHoNOoHeUroVkya96stL5bxLJTkMH3URzyUC711YseHv6yg
	 g7jPxvnV/vhDg==
Date: Fri, 30 May 2025 19:37:06 +0100
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Shiming Cheng <shiming.cheng@mediatek.com>, willemb@google.com,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	lena.wang@mediatek.com
Subject: Re: [PATCH net v6] net: fix udp gso skb_segment after pull from
 frag_list
Message-ID: <20250530183706.GV1484967@horms.kernel.org>
References: <20250530012622.7888-1-shiming.cheng@mediatek.com>
 <6839a707f1b14_1003de2943b@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6839a707f1b14_1003de2943b@willemb.c.googlers.com.notmuch>

On Fri, May 30, 2025 at 08:39:35AM -0400, Willem de Bruijn wrote:
> Shiming Cheng wrote:
> > Commit a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after
> > pull from frag_list") detected invalid geometry in frag_list skbs and
> > redirects them from skb_segment_list to more robust skb_segment. But some
> > packets with modified geometry can also hit bugs in that code. We don't
> > know how many such cases exist. Addressing each one by one also requires
> > touching the complex skb_segment code, which risks introducing bugs for
> > other types of skbs. Instead, linearize all these packets that fail the
> > basic invariants on gso fraglist skbs. That is more robust.
> > 
> > If only part of the fraglist payload is pulled into head_skb, it will
> > always cause exception when splitting skbs by skb_segment. For detailed
> > call stack information, see below.
> > 
> > Valid SKB_GSO_FRAGLIST skbs
> > - consist of two or more segments
> > - the head_skb holds the protocol headers plus first gso_size
> > - one or more frag_list skbs hold exactly one segment
> > - all but the last must be gso_size
> > 
> > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> > modify fraglist skbs, breaking these invariants.
> > 
> > In extreme cases they pull one part of data into skb linear. For UDP,
> > this  causes three payloads with lengths of (11,11,10) bytes were
> > pulled tail to become (12,10,10) bytes.
> > 
> > The skbs no longer meets the above SKB_GSO_FRAGLIST conditions because
> > payload was pulled into head_skb, it needs to be linearized before pass
> > to regular skb_segment.
> > 
> >     skb_segment+0xcd0/0xd14
> >     __udp_gso_segment+0x334/0x5f4
> >     udp4_ufo_fragment+0x118/0x15c
> >     inet_gso_segment+0x164/0x338
> >     skb_mac_gso_segment+0xc4/0x13c
> >     __skb_gso_segment+0xc4/0x124
> >     validate_xmit_skb+0x9c/0x2c0
> >     validate_xmit_skb_list+0x4c/0x80
> >     sch_direct_xmit+0x70/0x404
> >     __dev_queue_xmit+0x64c/0xe5c
> >     neigh_resolve_output+0x178/0x1c4
> >     ip_finish_output2+0x37c/0x47c
> >     __ip_finish_output+0x194/0x240
> >     ip_finish_output+0x20/0xf4
> >     ip_output+0x100/0x1a0
> >     NF_HOOK+0xc4/0x16c
> >     ip_forward+0x314/0x32c
> >     ip_rcv+0x90/0x118
> >     __netif_receive_skb+0x74/0x124
> >     process_backlog+0xe8/0x1a4
> >     __napi_poll+0x5c/0x1f8
> >     net_rx_action+0x154/0x314
> >     handle_softirqs+0x154/0x4b8
> > 
> >     [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at net/core/skbuff.c:4278!
> >     [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> >     [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
> >     [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
> >     [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
> >     [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
> >     [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
> >     [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp : ffffffc008013770
> > 
> > Fixes: a1e40ac5b5e9 ("gso: fix udp gso fraglist segmentation after pull from frag_list")
> > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> 
> Is this effectively a repost of v5?
> 
> I think Simon suggested changing the subject line from starting with
> "net:" to starting with "gso:", but this revision does not make such
> a change.

FTR, my suggestion was to correct the subject embedded in the Fixes tag.
And that appears to be addressed in this revision (v6).

> 
> Btw, for upcoming patches: it is helpful to add a changelog below the
> --- marker line, to help reviewers see what changed. See also the
> SubmittingPatches doc on that point.
> 

