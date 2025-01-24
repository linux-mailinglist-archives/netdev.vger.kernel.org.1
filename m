Return-Path: <netdev+bounces-160770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF17A1B4CF
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 12:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D13188D536
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C98F21A449;
	Fri, 24 Jan 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ish6hNS2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3A207A03
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737718667; cv=none; b=Ca/fcy5G1ulH6f6sRDYwer5kAaNeR2boEFqb67zHBDUbYMfeM2CxUkg4sHCC4nKdHXETBWk0sjej7sCmIo/jFDN3qpQu1C10DaccO8I1vlRebOXUOprelAaIf0G/n8cmFaniXPk8A4x1zbAMqLBYoso33Bd50wD724OMlCr/6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737718667; c=relaxed/simple;
	bh=DOgxYuNJGR/6wh6nuju19thFYosNZhn+4J/myN/Jx1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGhY/PtAhte8k/NjqTCgAUogdiD4Qz6klrZ5wIvif2vMbQO7KK6lBgmvwcYQ98wUM+83S+dmuCHGBJnUk1UhEIW/n+HOQMeqKyYHeTVAnFtKCCvuLfSGpG27BxmIUV/s9G2OsPUfj6Xpcerf6GjsK88aJmkgPnLd/wnfRLVMPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ish6hNS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471B5C4CED2;
	Fri, 24 Jan 2025 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737718666;
	bh=DOgxYuNJGR/6wh6nuju19thFYosNZhn+4J/myN/Jx1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ish6hNS2rGMV45xVSjhRFpucP6YMoGERJEfGGTOWv7qTCTgWW655QSdxWDnv4oQ5Y
	 iXt1lLsGmnWmQuayxwOoE75GKb72VxhtU5CTvBHp3ym+he14njZ0+1bYLoVZ2/ItjZ
	 AcXzFIgo+oaPLie2CjFMw7Zfs0qmpV/N8aFWep71mVFCyx//UztERXSXQpBPE9l4f2
	 34yVG3+DRX5uUsUn3AG87EJ3MDE0HDISQCc3glr406Tq0yNDIlje/tWhbZqGm99gHu
	 Lj/K1YqOnQdFAespmV/+M4EGsUf/Wr7HOEUrK0pn6wefsSM4qiTWYjboVKSzEQ18ms
	 aLvPgPxDR/0/g==
Date: Fri, 24 Jan 2025 11:37:43 +0000
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	quanglex97@gmail.com, mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net 2/4] Add test case to check for pfifo_tail_enqueue()
 behaviour when limit == 0
Message-ID: <20250124113743.GA34605@kernel.org>
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
 <20250124060740.356527-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124060740.356527-3-xiyou.wangcong@gmail.com>

On Thu, Jan 23, 2025 at 10:07:38PM -0800, Cong Wang wrote:
> From: Quang Le <quanglex97@gmail.com>
> 
> When limit == 0, pfifo_tail_enqueue() must drop new packet and
> increase dropped packets count of scheduler.
> 
> Signed-off-by: Quang Le <quanglex97@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Hi Cong, all,

This test is reporting "not ok" in the Netdev CI.

# not ok 577 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
# Could not match regex pattern. Verify command output:
# qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
#  backlog 0b 0p requeues 0

...

