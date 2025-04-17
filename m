Return-Path: <netdev+bounces-183785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A21A91F2B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0297A16422B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D324EABC;
	Thu, 17 Apr 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeSguyAx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0904922E40F
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898982; cv=none; b=HH4He/Z7nQFt1PhEpLRCU52KKpjbUJFYvVfIk9lEM7xIrlSRFOCNo9XSLBkgqPuRPx+VcHqw6V6ex5cvDyJFc0tP/kGM+cnym2uCPGv3n0EidzeuXTdDxsjLp3gHe/ESh4WUc6w9BrbnRIHdnoNvHreloG8dj58r3U2LRIRKw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898982; c=relaxed/simple;
	bh=zScwQK0PlqbzzNH1QntN5K7sEfDAyKzh0P6HR0e/M4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5BkqrWG9MC4jEMzgs71jrRBlfdJpMaf5CclIeS9diPxN39IN3d9GzBCLtrR1hOtk36/Rgl5oh8mujuAVVkr3n7C36LHPc3D0s38OjNGoUK3UlBA3kLWfC5yQQF/Yf8U5+0h0k45KgajzAi/hj23OoY/5UG4iiYuPPZ5vXnx3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeSguyAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8C2C4CEE4;
	Thu, 17 Apr 2025 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744898979;
	bh=zScwQK0PlqbzzNH1QntN5K7sEfDAyKzh0P6HR0e/M4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qeSguyAxKwvrM12CFbynrWH48qKf7tTXu0ol6AjpU2JsB9ytrI6Zz1Xc8BFl4DhI3
	 9+t/5a00DY2mShEmCWWakegYtICP98lRVecw30XDLsnVjkMRT5i1WA2yzA7uqBUatg
	 Y7NuA0ffp4ignTVYs12aps3zoa7Eu6aM2ormsjGLXFvKa68qPO6zaSWSKOvpnaDoNc
	 Z8nAFnOWqmzBrBaPoJOpqPG9Nj46SFPEIjuUnQqQ85ubGaE4aULGM10o+wbcMMc51O
	 5ia2hpKaG9uUOxz+IJXCyxsWk3zgP5W0AfJ6Wm0sCCr3EvKKfESupspFf+bHkbIpB+
	 hYI1KfXs+8maw==
Date: Thu, 17 Apr 2025 07:09:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Mina Almasry
 <almasrymina@google.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250417070937.332dc7d4@kernel.org>
In-Reply-To: <CAMArcTXCKA6uBMwah223Y7V152FyWs7R_nJ483j8pehJ1hF4QA@mail.gmail.com>
References: <20250415092417.1437488-1-ap420073@gmail.com>
	<CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
	<Z_6snPXxWLmsNHL5@mini-arch>
	<20250415195926.1c3f8aff@kernel.org>
	<CAMArcTWFbDa5MAZ_iPHOr_jUh0=CurYod74x_2FxF=EAv28WiA@mail.gmail.com>
	<20250416173525.347f0c90@kernel.org>
	<CAMArcTXCKA6uBMwah223Y7V152FyWs7R_nJ483j8pehJ1hF4QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 15:57:47 +0900 Taehee Yoo wrote:
> Thanks Mina for the suggestion!
> What I would like to do is like that
> If binding->dev is NULL, it skips locking, but it still keeps calling
> net_devmem_unbind_dmabuf().

note that the current code in net_devmem_unbind_dmabuf() is also not
safe against double removal from the socket list.

> Calling net_devmem_unbind_dmabuf() is safe even if after module unload,
> because binding->bound_rxq is deleted by the uninstall path.
> If bound_rxq is empty, binding->dev will not be accessed.
> The only uninstall side code change is to set binding->dev to NULL and
> add priv->lock.
> This approach was already suggested by Stanislav earlier in this thread.

> Mina, Stanislav, and Jakub, can you confirm this?

Maybe just send the code, even if it's not perfect. It's a bit hard 
to track all the suggested changes :)

