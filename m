Return-Path: <netdev+bounces-115370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B5794608A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8446B283018
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2D136351;
	Fri,  2 Aug 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwqUFimT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D0EAD5
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612614; cv=none; b=dXCD0EuodBehMae0kDzSvTGvqlaJlhgfc/9rY7XZo6z6nzz1rxsuPJS7roItsKGLZQ7o2PhC0iMg1loCbdJzFqDT/b3fbvWuidHCNRGfJDzf2nGt6ECah4+pOl1HvYKxGYQngGWLEVsYq+nMFbA32BR8qyIy2LLbXYEhAhJKB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612614; c=relaxed/simple;
	bh=Ght40GavoZXveKLwYfGG1uBPwRHOQjoZgoymTL6G8gk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmyr9uMzEXYqcOme6zlVsDxBJbD3DZ5uknyFaCJmsGh+a02OhsEg3ae/rM6PoLlVGQAJxLURFmL0Sg5uzk5I60B5QhIvLZfbgmR1X/vsS67DFoAmOxZT6i8LCq47QQ8ry9MLwxVFST9iKXJiKYvYMEI3qtiVjIP1t6mmIuJRVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwqUFimT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C75C4AF0B;
	Fri,  2 Aug 2024 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722612614;
	bh=Ght40GavoZXveKLwYfGG1uBPwRHOQjoZgoymTL6G8gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LwqUFimTq+YqGJ7bpI1nrrGCGfm/e5bUOUmn9DtstmoDETdUy+AQOpnFug3Rtrxt1
	 PlWrPw6r9Iv9U0N2WTaSuVjGmFBpVPtOOlMZG3Ex5EukzTy0/BLCRsdNp/6fG2dWyk
	 rKd641+ok18GG1w/1XUwvaZnOZD0LlC2XNZW1ZgV6T/JC+2umfBfFLgHkdujmiCWm1
	 oXD94/pXl7bcqP7wDVGOGWUdz5MmRVrfTjWZYY6kYRKUNfgD7GKF3z3qyliSd2MdGY
	 R1gUXbLtEhnShNXl6f7dc1iMSLncKC3nSQ2WdHZVOt4R6dZGB8MT2fCdk/ltGaQpWG
	 19SVL6Ch/hL1g==
Date: Fri, 2 Aug 2024 08:30:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v4 0/7] tcp: completely support active reset
Message-ID: <20240802083012.062e2c0e@kernel.org>
In-Reply-To: <20240802102112.9199-1-kerneljasonxing@gmail.com>
References: <20240802102112.9199-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 18:21:05 +0800 Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This time the patch series finally covers all the cases in the active
> reset logic. After this, we can know the related exact reason(s).

What happened to waiting 24h before posting the next version? :|
-- 
pv-bot: 24h

