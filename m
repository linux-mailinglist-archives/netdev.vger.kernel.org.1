Return-Path: <netdev+bounces-192215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB34ABEF69
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324083A83C8
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF3323D2A0;
	Wed, 21 May 2025 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxOJkxxz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A023D29E
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819131; cv=none; b=rgrtFrBYQp0iJbPMwXJuCNs3r+kO53HziIx+l/1mW+y35HrUrk9WwPXieoNoLmfdummXert4Xfggm7Lgzu26KCaIQspoPIaAUh064Byv0/Mx7sw5lOckWKA2307OvtE5VlZXVZTQuugG565dfj4+5y661z8p2jwAJ9d4FYc58Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819131; c=relaxed/simple;
	bh=g43jlQv2rVrFZSeM/Fo9D9ZbcGz/8Rbn/8ul2CizRBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI4ILldz1mi5ueQIkEHSk86v7JXgCId6RoY6qZz7JrL4kLSJ5j6Pka492g/hrOlZUsKV9glUo2H9YFOs+KwWQcRBJqvqtQKIa/D1LiDPQqsqQtQISc6teVi5Jkf8prVqgJN1cDsrtS3ZJgO+h8Sj7yhNvVY4Ifzrj78J4JqhS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxOJkxxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D69C4CEE4;
	Wed, 21 May 2025 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747819130;
	bh=g43jlQv2rVrFZSeM/Fo9D9ZbcGz/8Rbn/8ul2CizRBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LxOJkxxzS8XicJ5iUBvLcrcjO0J3yoEtO0+smKHKmxknxzxEO5IdI9ahAt9/aO3+a
	 yfy+zlPzZopJsbgMI0J6wKg/dVhoQvduIa/UFwOLA8mgSg4AByOFqDyo4lbi7Hzzp7
	 5pSkzv4vRTcnMlnsZHezmjuYR47SvdY1R8oNcIaA8eAx72SKl9eCf5VPc1xfljr62v
	 QBvpmChuUsVQNB6DEiOcmniFIWBs9dpVpwjOpc8G0oGdYcgar6JmqNBHsmfoqM5IqX
	 zrobSHDyFkNegWt595BiZamdXT8cBvsBeYC8AUCUURAMp9MCh4MZUgUIYLWPxMI++A
	 Xyr0sTGpbpXJg==
Date: Wed, 21 May 2025 10:18:47 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
	Mingi Cho <mincho@theori.io>
Subject: Re: [Patch net 1/2] sch_hfsc: Fix qlen accounting bug when using
 peek in hfsc_enqueue()
Message-ID: <20250521091847.GU365796@horms.kernel.org>
References: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
 <20250518222038.58538-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518222038.58538-2-xiyou.wangcong@gmail.com>

On Sun, May 18, 2025 at 03:20:37PM -0700, Cong Wang wrote:
> When enqueuing the first packet to an HFSC class, hfsc_enqueue() calls the
> child qdisc's peek() operation before incrementing sch->q.qlen and
> sch->qstats.backlog. If the child qdisc uses qdisc_peek_dequeued(), this may
> trigger an immediate dequeue and potential packet drop. In such cases,
> qdisc_tree_reduce_backlog() is called, but the HFSC qdisc's qlen and backlog
> have not yet been updated, leading to inconsistent queue accounting. This
> can leave an empty HFSC class in the active list, causing further
> consequences like use-after-free.
> 
> This patch fixes the bug by moving the increment of sch->q.qlen and
> sch->qstats.backlog before the call to the child qdisc's peek() operation.
> This ensures that queue length and backlog are always accurate when packet
> drops or dequeues are triggered during the peek.
> 
> Fixes: 12d0ad3be9c3 ("net/sched/sch_hfsc.c: handle corner cases where head may change invalidating calculated deadline")
> Reported-by: Mingi Cho <mincho@theori.io>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


