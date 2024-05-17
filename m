Return-Path: <netdev+bounces-97025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC808C8CC5
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 21:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F35282494
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639314037D;
	Fri, 17 May 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmK+NMF/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126FD13FD8D
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973861; cv=none; b=Wy/dBSm4CDmWnnOEqnNcgFSu9g+glEGZ/+m4YDmA2Ti9BzSJi5XsxO9fxWaolKLlxUup7OsCekq8GWowVglyriosrdHRNXkRQzfcH4ONBUKIizOU13yVmwmqr1QxIzU7uEkS4h8ZWn9KW4Nwo4mNT7UIig090mLZ6J4V4bG6Bss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973861; c=relaxed/simple;
	bh=loPmOUgtYeQU+tz5f2EC9Vv7JaYj3NTv44G0fVNlFk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxtQEeNkILBw7JuvlTHVQylur/M2sk5XvubLIOOflEsHfpT4X4zJzDp4S2Kiaqi9hbJH0oplxvFMhtJqJoTCM1mlAP62bv4A2vqnCMrXeN08g5hVvYsaEWS7EmqaF+amLSQbmFEYX/vAggz/T8f/AS+q7UuLMH3UbJbzZMWsyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmK+NMF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D037C2BD10;
	Fri, 17 May 2024 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715973860;
	bh=loPmOUgtYeQU+tz5f2EC9Vv7JaYj3NTv44G0fVNlFk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mmK+NMF/wO6BUUIgxW2mZWli77GxpkeIzGLGMmb6TKi3XJpVN7v3grSh0oM5/sWIt
	 YcPQOvcteKGP+VTzOhxOPyoe/zKlAQ6d4tCAKy+S0cJUg/i1v/R/VCVFQoovR+wole
	 URzcfig92r4g1YCNkWuhPfbr6o+vqO3Aa/DDlHueVQitHafy+IKLOsidx5LeFNKlay
	 cHOyOdk07LmRLPHMWmp1qO87cgwkDAjnGiARo6W1hK5spjEH2Dpb9llG+XKEMRTUiJ
	 ESmRwpm/x4zTnhLvBjHuHm5RB98590phzp/NnD3+qnheGrEfCVrmsA+TAiS8g0x7rj
	 Mut30MlWnlAUw==
Date: Fri, 17 May 2024 12:24:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <mhal@rbox.co>, <davem@davemloft.net>, <edumazet@google.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>
Subject: Re: [PATCH net v2 1/2] af_unix: Fix garbage collection of embryos
 carrying OOB with SCM_RIGHTS
Message-ID: <20240517122419.0c9a0539@kernel.org>
In-Reply-To: <20240517074742.24709-1-kuniyu@amazon.com>
References: <734273bc-2415-43b7-9873-26416aab8900@rbox.co>
	<20240517074742.24709-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 16:47:42 +0900 Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Fri, 17 May 2024 07:59:16 +0200
> > One question: git send-email automatically adds my Signed-off-by to your
> > patch (patch 2/2 in this series). Should I leave it that way?  
> 
> SOB is usually added by someone who changed the diff or merged it.
> 
> I think it would be better not to add it if not intended. 

My understanding is that Michal should indeed add his SOB, as he is 
the one submitting the patch now, and from the "certificate of origin"
we need his assurance that the code is indeed released under the
appropriate license.

If you could reply to your own posting with the SoB, Michal, that'd be
enough.

