Return-Path: <netdev+bounces-50972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C17F8599
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4C71C208C4
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8F3BB52;
	Fri, 24 Nov 2023 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr8ZxkXH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F572EB09
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 21:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A565CC433C9;
	Fri, 24 Nov 2023 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700862405;
	bh=tM/5aswPeqhmOGdMvu4T1zqrybFh+MTIDCkxhhqR31M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lr8ZxkXHAHzyV+ob5DoLD85mf3cnaOx2N+W0B32dbV6FpV/vbusldq2sUdnpg4CFR
	 EVlWKqz6iiKN4AWTZJy3R4GkLfMRyhG4QWY/VAMz/76yMA5faTIpoNgfaF4DsqeaBW
	 KYs/EI1mjKrTV/nuUY8u8SThOmxLRyK2aJEP/LURYetUEVx677ryZHkZDXr8Xv6zy5
	 fvmgW1xLygFTdzTojsJOx7XeYOhXpnjOAbqkIcC3qNP0guLoxeuBAlVjkwoFdlT8WX
	 CI5Ka19I0uq9gSzpcw9JcODBuhQMgyYo6S+OTWuj/dClyLUuAg7HJbwLvNNas/MyXU
	 9iZGQ4+4Ihlyg==
Date: Fri, 24 Nov 2023 21:46:41 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 8/8] tcp: Factorise cookie-dependent fields
 initialisation in cookie_v[46]_check()
Message-ID: <20231124214641.GE50352@kernel.org>
References: <20231123012521.62841-1-kuniyu@amazon.com>
 <20231123012521.62841-9-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123012521.62841-9-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:25:21PM -0800, Kuniyuki Iwashima wrote:
> We will support arbitrary SYN Cookie with BPF, and then kfunc at
> TC will preallocate reqsk and initialise some fields that should
> not be overwritten later by cookie_v[46]_check().
> 
> To simplify the flow in cookie_v[46]_check(), we move such fields'
> initialisation to cookie_tcp_reqsk_alloc() and factorise non-BPF
> SYN Cookie handling into cookie_tcp_check(), where we validate the
> cookie and allocate reqsk, as done by kfunc later.
> 
> Note that we set ireq->ecn_ok in two steps, the latter of which will
> be shared by the BPF case.  As cookie_ecn_ok() is one-liner, now
> it's inlined.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


