Return-Path: <netdev+bounces-242248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B563C8E161
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8543AA4B4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1932AACC;
	Thu, 27 Nov 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOPbEcRE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D212FBE03
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243921; cv=none; b=huJWm4metD4dkThgNLDc2ixX3k7q0cODRUke2FPLJuaCeaKD+r35EuPvOZitWSlN0/GuZH1i9zsZr46YixeG3s9Znv9hh4QdY66QaHHUVmgjhX3RrSCKJg72UlMBp88mXEGsj2Rnv5AsQBlkYAMtxARy/N3w5fZ3WE0JTE1pF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243921; c=relaxed/simple;
	bh=4N8aVeG3r57xJFID0/PYHsDmVbIx5RzBSTf7W1TTCIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOxAuULWknZN0PmyTBgGsfKDfQv90C7YDKDNOxaqS0HFiioiSx/STkdbPBZApCeXJQxu9IIdC/8WbQ/sbqTMXAHw7pPm8MMvGlE/9Hp1JkZigsS6CizrJy6vCg6X9Kyzk3j1SjlTz0dm5LLFTAASys2NZOt7iXpkWsdic1cAO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOPbEcRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03090C4CEF8;
	Thu, 27 Nov 2025 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764243921;
	bh=4N8aVeG3r57xJFID0/PYHsDmVbIx5RzBSTf7W1TTCIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOPbEcREP3YuG7SxiKodW5WZlTPecxukASxDGGJ0NiJyIn8zD943JUJ3g23XPF+WA
	 EOzRZIlz2/MXGZytK3x9a3T/Zc4t5M2lEsiy7U5+gzJ/Fp+emW3Gq/Fu58h6pYeKgH
	 PKiNDw9xtZArenxemSOniO4HFFrDNeOr6CBOcvEXjfyeXsEmgblsxXBPfieOcUXWJ4
	 IedvA9QpqRRpq3gYDYh5iV8NPDywHsdtgWclupnxN+FekY6/4UD8RMjJQu1Kf6VW++
	 TcR4reF7yjQi2BAXeSk6JtK4zlLwpL2FQQ+PTG5G6Pl5WHM178uDXGEHe8hyHZLFvS
	 z3yhXYt19VHMA==
Date: Thu, 27 Nov 2025 11:45:17 +0000
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>
Subject: Re: [PATCH iwl-net v2 3/3] idpf: Fix RSS LUT NULL ptr issue after
 soft reset
Message-ID: <aSg5zR-6ZYXBuIVd@horms.kernel.org>
References: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
 <20251124184750.3625097-4-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124184750.3625097-4-sreedevi.joshi@intel.com>

On Mon, Nov 24, 2025 at 12:47:50PM -0600, Sreedevi Joshi wrote:
> During soft reset, the RSS LUT is freed and not restored unless the
> interface is up. If an ethtool command that accesses the rss lut is
> attempted immediately after reset, it will result in NULL ptr
> dereference. Also, there is no need to reset the rss lut if the soft reset
> does not involve queue count change.
> 
> After soft reset, set the RSS LUT to default values based on the updated
> queue count only if the reset was a result of a queue count change and
> the LUT was not configured by the user. In all other cases, don't touch
> the LUT.
> 
> Steps to reproduce:
> 
> ** Bring the interface down (if up)
> ifconfig eth1 down
> 
> ** update the queue count (eg., 27->20)
> ethtool -L eth1 combined 20
> 
> ** display the RSS LUT
> ethtool -x eth1
> 
> [82375.558338] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [82375.558373] #PF: supervisor read access in kernel mode
> [82375.558391] #PF: error_code(0x0000) - not-present page
> [82375.558408] PGD 0 P4D 0
> [82375.558421] Oops: Oops: 0000 [#1] SMP NOPTI
> <snip>
> [82375.558516] RIP: 0010:idpf_get_rxfh+0x108/0x150 [idpf]
> [82375.558786] Call Trace:
> [82375.558793]  <TASK>
> [82375.558804]  rss_prepare.isra.0+0x187/0x2a0
> [82375.558827]  rss_prepare_data+0x3a/0x50
> [82375.558845]  ethnl_default_doit+0x13d/0x3e0
> [82375.558863]  genl_family_rcv_msg_doit+0x11f/0x180
> [82375.558886]  genl_rcv_msg+0x1ad/0x2b0
> [82375.558902]  ? __pfx_ethnl_default_doit+0x10/0x10
> [82375.558920]  ? __pfx_genl_rcv_msg+0x10/0x10
> [82375.558937]  netlink_rcv_skb+0x58/0x100
> [82375.558957]  genl_rcv+0x2c/0x50
> [82375.558971]  netlink_unicast+0x289/0x3e0
> [82375.558988]  netlink_sendmsg+0x215/0x440
> [82375.559005]  __sys_sendto+0x234/0x240
> [82375.559555]  __x64_sys_sendto+0x28/0x30
> [82375.560068]  x64_sys_call+0x1909/0x1da0
> [82375.560576]  do_syscall_64+0x7a/0xfa0
> [82375.561076]  ? clear_bhb_loop+0x60/0xb0
> [82375.561567]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> <snip>
> 
> Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


