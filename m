Return-Path: <netdev+bounces-116761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940C694B9E9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68F51C20CCC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E571E189908;
	Thu,  8 Aug 2024 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="l+E66vzk"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FB183CCB
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110285; cv=none; b=nK6WWgTVoi1WRPqlZL7Ur1zbv/qq5T5y6W90BCO9FLFc3VUyFSaVAdvCpSgSePJE+t45sGmXEMimwwFnfCLv/beoYuJFg1Rufti8/lwFCmVDK/6O3tUU2ASJaA7HLDVjmWBCbmpx9WCfuLYBOm3ZcN9Y7W4JFHqlCl9JDUXlxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110285; c=relaxed/simple;
	bh=PQmnMS3cRPw6xO3NzdtdCw783fEJ/tMYBQ+vZlX6QOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbAlUwYuq/Y7bT0CZgdiuWhrbhLFmASqRxXxo5fo8eP+2QROZ7Pwa/Lwvxa+IvIGV72bK+8VPfwX0PcWVqltZ6a0tmTeSaGDAvWJLuW/GJ1s2AiM7sDvXZ41XtqJ4mpxabzwGB9ft/BREVdUjLPgHonheYjqMhJthPjUmgR0gZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=l+E66vzk; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: abdac604-556a-11ef-90e1-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id abdac604-556a-11ef-90e1-005056aba152;
	Thu, 08 Aug 2024 11:43:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=8TMBy9nT6p/0jExdAj1f83P+ivcenpFl6UzW08JPF0I=;
	b=l+E66vzkaWKig0y4yqKpZ90qq/J/cdwXjC33qm2RCHyEBDoniepjBv1IKV94m6ETBYLH4K+4IwOzR
	 NGxOwj1wVYn5Gg2OuBhLau3dl79i8pwgMKwkiV8my/0rrTWn0aeIqAJCaViX7BgO7q02QWnimMEaHT
	 D374NUwjC//UvO3s=
X-KPN-MID: 33|obhpsKnR146r6jFmQDQ0taJI9PnBWo904Ai1ewrC4sOEcXGofgIrRB+PYVZ243M
 LWTmSCQCm5h+Y1cgV7G1n4EZVyqRXTq2Tft1wHA78qLo=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|3i5hAT5TRhc/CVAtW8jVJZJ5AnofOCpqaUzt0kc8JRXTSLPcS6X8RuWP8XIHnq+
 jxsXNkGsd8hQjQGoKi/CtZw==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ab66fde9-556a-11ef-a0ba-005056ab1411;
	Thu, 08 Aug 2024 11:43:31 +0200 (CEST)
Date: Thu, 8 Aug 2024 11:43:30 +0200
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>, Antony Antony <antony@phenome.org>
Subject: Re: [PATCH ipsec-next v9 00/17] Add IP-TFS mode to xfrm
Message-ID: <ZrSTQnisAPkwlvWW@Antony2201.local>
References: <20240807211331.1081038-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807211331.1081038-1-chopps@chopps.org>

Hi Chris,

On Wed, Aug 07, 2024 at 05:13:14PM -0400, Christian Hopps wrote:
> * Summary of Changes:
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> This feature supports demand driven (i.e., non-constant send rate)
> IP-TFS to take advantage of the AGGFRAG ESP payload encapsulation. This
> payload type supports aggregation and fragmentation of the inner IP
> packet stream which in turn yields higher small-packet bandwidth as well
> as reducing MTU/PMTU issues. Congestion control is unimplementated as
> the send rate is demand driven rather than constant.
> 
> In order to allow loading this fucntionality as a module a set of
> callbacks xfrm_mode_cbs has been added to xfrm as well.
> 
> Patchset Changes:
> -----------------
> 
>   include/linux/skbuff.h     |    1 +
>   include/net/xfrm.h         |   44 +
>   include/uapi/linux/in.h    |    2 +
>   include/uapi/linux/ip.h    |   16 +
>   include/uapi/linux/ipsec.h |    3 +-
>   include/uapi/linux/snmp.h  |    2 +
>   include/uapi/linux/xfrm.h  |    9 +-
>   net/core/skbuff.c          |    7 +-
>   net/ipv4/esp4.c            |    3 +-
>   net/ipv6/esp6.c            |    3 +-
>   net/netfilter/nft_xfrm.c   |    3 +-
>   net/xfrm/Kconfig           |   16 +
>   net/xfrm/Makefile          |    1 +
>   net/xfrm/trace_iptfs.h     |  218 ++++
>   net/xfrm/xfrm_compat.c     |   10 +-
>   net/xfrm/xfrm_device.c     |    4 +-
>   net/xfrm/xfrm_input.c      |   18 +-
>   net/xfrm/xfrm_iptfs.c      | 2822 ++++++++++++++++++++++++++++++++++++++++++++
>   net/xfrm/xfrm_output.c     |    6 +
>   net/xfrm/xfrm_policy.c     |   26 +-
>   net/xfrm/xfrm_proc.c       |    2 +
>   net/xfrm/xfrm_state.c      |   84 ++
>   net/xfrm/xfrm_user.c       |   77 ++
>   23 files changed, 3357 insertions(+), 20 deletions(-)
> 
> Patchset Structure:
> -------------------
> 
> The first 7 commits are changes to the xfrm infrastructure to support
> the callbacks as well as more generic IP-TFS additions that may be used
> outside the actual IP-TFS implementation.
> 
>   - net: refactor common skb header copy code for re-use
>   - xfrm: config: add CONFIG_XFRM_IPTFS
>   - include: uapi: add ip_tfs_*_hdr packet formats
>   - include: uapi: add IPPROTO_AGGFRAG for AGGFRAG in ESP
>   - xfrm: netlink: add config (netlink) options
>   - xfrm: add mode_cbs module functionality
>   - xfrm: add generic iptfs defines and functionality
> 
> The last 10 commits constitute the IP-TFS implementation constructed in
> layers to make review easier. The first 9 commits all apply to a single
> file `net/xfrm/xfrm_iptfs.c`, the last commit adds a new tracepoint
> header file along with the use of these new tracepoint calls.
> 
>   - xfrm: iptfs: add new iptfs xfrm mode impl
>   - xfrm: iptfs: add user packet (tunnel ingress) handling
>   - xfrm: iptfs: share page fragments of inner packets
>   - xfrm: iptfs: add fragmenting of larger than MTU user packets
>   - xfrm: iptfs: add basic receive packet (tunnel egress) handling
>   - xfrm: iptfs: handle received fragmented inner packets
>   - xfrm: iptfs: add reusing received skb for the tunnel egress packet
>   - xfrm: iptfs: add skb-fragment sharing code
>   - xfrm: iptfs: handle reordering of received packets
>   - xfrm: iptfs: add tracepoint functionality
> 
> Patchset History:
> -----------------
> 
> RFCv1 (11/10/2023)
> 
> RFCv1 -> RFCv2 (11/12/2023)
> 
>   Updates based on feedback from Simon Horman, Antony,
>   Michael Richardson, and kernel test robot.
> 
> RFCv2 -> v1 (2/19/2024)
> 
>   Updates based on feedback from Sabrina Dubroca, kernel test robot
> 
> v1 -> v2 (5/19/2024)
> 
>   Updates based on feedback from Sabrina Dubroca, Simon Horman, Antony.
> 
>   o Add handling of new netlink SA direction attribute (Antony).
>   o Split single patch/commit of xfrm_iptfs.c (the actual IP-TFS impl)
>     into 9+1 distinct layered functionality commits for aiding review.
>   - xfrm: fix return check on clone() callback
>   - xfrm: add sa_len() callback in xfrm_mode_cbs for copy to user
>   - iptfs: remove unneeded skb free count variable
>   - iptfs: remove unused variable and "breadcrumb" for future code.
>   - iptfs: use do_div() to avoid "__udivd13 missing" link failure.
>   - iptfs: remove some BUG_ON() assertions questioned in review.
> 
> v2->v3
>   - Git User Glitch
> 
> v2->v4 (6/17/2024)
> 
>   - iptfs: copy only the netlink attributes to user based on the
>     direction of the SA.
> 
>   - xfrm: stats: in the output path check for skb->dev == NULL prior to
>     setting xfrm statistics on dev_net(skb->dev) as skb->dev may be NULL
>     for locally generated packets.
> 
>   - xfrm: stats: fix an input use case where dev_net(skb->dev) is used
>     to inc stats after skb is possibly NULL'd earlier. Switch to using
>     existing saved `net` pointer.
> 
> v4->v5 (7/14/2024)
>   - uapi: add units to doc comments
>   - iptfs: add MODULE_DESCRIPTION()
>   - squash nl-direction-update commit
> 
> v5->v6 (7/31/2024)
>   * sysctl: removed IPTFS sysctl additions
>   - xfrm: use array of pointers vs structs for mode callbacks
>   - iptfs: eliminate a memleak during state alloc failure
>   - iptfs: free send queue content on SA delete
>   - add some kdoc and comments
>   - cleanup a couple formatting choices per Steffen
> 
> v6->v7 (8/1/2024)
>   - Rebased on latest ipsec-next
> 
> v7->v8 (8/4/2024)
>   - Use lock and rcu to load iptfs module -- copy existing use pattern
>   - fix 2 warnings from the kernel bot
> 
> v8->v9 (8/7/2024)
>   - factor common code from skbuff.c:__copy_skb_header into ___copy_skb_header
>     and use in iptfs rather that copying any code.
>   - change all BUG_ON to WARN_ON_ONCE
>   - remove unwanted new NOSKB xfrm MIB error counter
>   - remove unneeded copy or share choice function
>   - ifdef CONFIG_IPV6 around IPv6 function

I noticed a build error with CONFIG_XFRM_IPTFS=m. This error also shows up 
in in NetDev NIPA tester. However, it kernel builds with CONFIG_XFRM_IPTFS=y

a@laya:~/git/linux (iptfs-patchset-v9-20240808)$ make
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  MODPOST Module.symvers
ERROR: modpost: "___copy_skb_header" [net/xfrm/xfrm_iptfs.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/home/a/git/linux/Makefile:1878: modpost] Error 2
make: *** [Makefile:224: __sub-make] Error 2

NIPA tester also noticed the build error.
https://netdev.bots.linux.dev/static/nipa/877576/13756764/build_clang/stderr
I wonder why the  kernel test robot hasn't caught this yet.

Also note a few minor issues with the patches, specifically for the patch 
ipsec-next,v9,14/17
https://netdev.bots.linux.dev/static/nipa/877576/13756763/build_clang/stderr

-antony

