Return-Path: <netdev+bounces-167034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA044A386CF
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562A71686C5
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A11D21D58C;
	Mon, 17 Feb 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOxFwSaT"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EE1448D5
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803238; cv=none; b=HDBb2QtzrnUWeeadnPNb20Nz+6yGX0Et0xUx0qEmGBpq9YuaSl9kAaCUXLuSmdJqrZd5nIfcJykvRy0F1uFYa7dWs8h7IxKX0ixdyHjM9oP1W3MwKPu0K+tO+qJ6+8US90pfYtDD/0McxVlYGxUBQoqiiaz9deIqTYZdHv0cExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803238; c=relaxed/simple;
	bh=zcIhLnYkLQJuAbMAhY1+QOldMZBVStDYwazT3yHekcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNnP8oVt5Jw/tNPm2CFLx5DaB2SpzuOGYG3yi+UosAR5qnWU+gQta2FlcZRe123hx40DY8IUyghrQTvAlGek04u4RD1wr1ckieQjl+xDbThiAcPoRnXV4GQrItZSu+CzAtO6WCFmGPo6BSYnDnVXEeQE+uaxU3qvkjpw0fTLzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOxFwSaT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BEC3F11400AA;
	Mon, 17 Feb 2025 09:40:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 17 Feb 2025 09:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739803235; x=1739889635; bh=xWT3EKZqoTOo9805ijPC48DJU8XcWr/zaJw
	fAvmUlos=; b=UOxFwSaTKBZ3BBDcUKBsiGDiUitshBPfFuTW3w8MGfHpDT8hnd2
	/R4NAREfqS2kAOKDLkQt65tcDaVJWz6fAcNGS8dgq49WG59jFr/84V3VPACCEpzj
	fwtQIDRP/kl7yPo4gLV3Srw1mGdct0b3UcPK/sk/48aKSA7tTpv74j5X/0e1RqcT
	iSQqsRSJPY5tQcjzg+v3i1zb7tm+pHef/P8zRRZU0Fmq//+k5B03Fk7REkDPAHXI
	mIWd4CazjFImInopL9bscAYd+atvxttt4cIAVhdN9u8orntGAvxaFQjXlDa4KpfE
	n5ok+1UmLVCiNXyA/0XUnQkOR36qavvgGQQ==
X-ME-Sender: <xms:Y0qzZ7yG5NMMTYjyBHTRjitCvUYlp2Fu4phYsJBrDHxHujBMb78yAw>
    <xme:Y0qzZzRioA4U7T-0VOB5dXYivYetqlqydSsLK-NOoM4ra4qckazhLB-LbbW4HbY1A
    BxxKAkUkTUJZbs>
X-ME-Received: <xmr:Y0qzZ1Xg1OlawuFcfhOHJR56PQl35HYcCdQ8g4s6arfv6a9rJYF4YGvAmQaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeejvdetieeujeeuheejhfeuheehudduteetueel
    lefhuedugeelheeuffdtieekueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsph
    hfrdgtqdhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddtpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjuhhsthhinhdrihhurhhmrghnsehulhhi
    vghgvgdrsggvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvth
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorh
    hmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdgrrhhinhhgsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:Y0qzZ1hOb5oLLWjgC84jmatsLGIIqKH9BdMUmquwhyxz0cPA8K9wwQ>
    <xmx:Y0qzZ9AvK4eQJmdQBZWHFodPvkFM_lxIPcaA_dpZA-P-W5JWu3yk9Q>
    <xmx:Y0qzZ-LX_k4iVBYaE_RIRTG-b3EGKd6jqQOonWZfHxm2Q13x0ckyGw>
    <xmx:Y0qzZ8CIbAuk0y9rdNR5EcIb_IDgGb3fqN0BOk1SFf8mr-OSqJE4iA>
    <xmx:Y0qzZxu11LE0qHJWCKr5vcdJwU9mSCQOD2zyrfvA3aKYtZ7p4a22ZsqA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 09:40:34 -0500 (EST)
Date: Mon, 17 Feb 2025 16:40:32 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, Alexander Aring <alex.aring@gmail.com>,
	David Lebrun <dlebrun@google.com>
Subject: Re: [PATCH net v2 2/3] net: ipv6: fix lwtunnel loops in ioam6, rpl
 and seg6
Message-ID: <Z7NKYMY7fJT5cYWu@shredder>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
 <20250211221624.18435-3-justin.iurman@uliege.be>
 <Z63zgLQ_ZFmkO9ys@shredder>
 <a375f869-9fc3-4a58-a81a-c9c8175463dd@uliege.be>
 <Z7ISxnU0QhtRGTnb@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7ISxnU0QhtRGTnb@shredder>

On Sun, Feb 16, 2025 at 06:31:06PM +0200, Ido Schimmel wrote:
> On Thu, Feb 13, 2025 at 11:51:49PM +0100, Justin Iurman wrote:
> > On 2/13/25 14:28, Ido Schimmel wrote:
> > > On Tue, Feb 11, 2025 at 11:16:23PM +0100, Justin Iurman wrote:
> > > > When the destination is the same post-transformation, we enter a
> > > > lwtunnel loop. This is true for ioam6_iptunnel, rpl_iptunnel, and
> > > > seg6_iptunnel, in both input() and output() handlers respectively, where
> > > > either dst_input() or dst_output() is called at the end. It happens for
> > > > instance with the ioam6 inline mode, but can also happen for any of them
> > > > as long as the post-transformation destination still matches the fib
> > > > entry. Note that ioam6_iptunnel was already comparing the old and new
> > > > destination address to prevent the loop, but it is not enough (e.g.,
> > > > other addresses can still match the same subnet).
> > > > 
> > > > Here is an example for rpl_input():
> > > > 
> > > > dump_stack_lvl+0x60/0x80
> > > > rpl_input+0x9d/0x320
> > > > lwtunnel_input+0x64/0xa0
> > > > lwtunnel_input+0x64/0xa0
> > > > lwtunnel_input+0x64/0xa0
> > > > lwtunnel_input+0x64/0xa0
> > > > lwtunnel_input+0x64/0xa0
> > > > [...]
> > > > lwtunnel_input+0x64/0xa0
> > > > lwtunnel_input+0x64/0xa0
> > > > lwtunnel_input+0x64/0xa0
> > > > lwtunnel_input+0x64/0xa0
> > > > lwtunnel_input+0x64/0xa0
> > > > ip6_sublist_rcv_finish+0x85/0x90
> > > > ip6_sublist_rcv+0x236/0x2f0
> > > > 
> > > > ... until rpl_do_srh() fails, which means skb_cow_head() failed.
> > > > 
> > > > This patch prevents that kind of loop by redirecting to the origin
> > > > input() or output() when the destination is the same
> > > > post-transformation.
> > > 
> > > A loop was reported a few months ago with a similar stack trace:
> > > https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/
> > > 
> > > But even with this series applied my VM gets stuck. Can you please check
> > > if the fix is incomplete?
> > 
> > Good catch! Indeed, seg6_local also needs to be fixed the same way.
> > 
> > Back to my first idea: maybe we could directly fix it in lwtunnel_input()
> > and lwtunnel_output() to make our lives easier, but we'd have to be careful
> > to modify all users accordingly. The users I'm 100% sure that are concerned:
> > ioam6 (output), rpl (input/output), seg6 (input/output), seg6_local (input).
> > Other users I'm not totally sure (to be checked): ila (output), bpf (input).
> > 
> > Otherwise, we'll need to apply the fix to each user concerned (probably the
> > safest (best?) option right now). Any opinions?
> 
> I audited the various lwt users and I agree with your analysis about
> which users seem to be effected by this issue.
> 
> I'm not entirely sure how you want to fix this in
> lwtunnel_{input,output}() given that only the input()/output() handlers
> of the individual lwt users are aware of both the old and new dst
> entries.
> 
> BTW, I noticed that bpf implements the xmit() hook in addition to
> input()/output(). I wonder if a loop is possible in the following case:
> 
> ip_finish_output2()                                         <----+
> 	lwtunnel_xmit()                                          |
> 		bpf_xmit()                                       |
> 			// bpf program does not change           |
> 			// the packet and returns                |
> 			// BPF_LWT_REROUTE                       |
> 			bpf_lwt_xmit_reroute()                   |
> 				// unmodified packet resolves    |
> 				// the same dst entry            |
> 				dst_output()                     |
> 					ip_output() -------------+

FWIW, verified that this is indeed the case. Reproducer:

$ cat lwt_xmit_repo.bpf.c
// SPDX-License-Identifier: GPL-2.0
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

SEC("lwt_xmit")
int repo(struct __sk_buff *skb)
{
        return BPF_LWT_REROUTE;
}
$ clang -O2 -target bpf -c lwt_xmit_repo.bpf.c -o lwt_xmit_repo.o
# ip link add name dummy1 up type dummy
# ip route add 192.0.2.0/24 nexthop encap bpf xmit obj ./lwt_xmit_repo.o sec lwt_xmit dev dummy1
# ping 192.0.2.1

