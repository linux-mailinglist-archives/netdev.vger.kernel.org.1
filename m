Return-Path: <netdev+bounces-127429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BAF9755E7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC121B2C224
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A87219F11A;
	Wed, 11 Sep 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5Rvg+rV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC215C13F;
	Wed, 11 Sep 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065807; cv=none; b=fENcTjO6IMgYUmmGh5xlOQiNYbuarhE3tU4GwJrnJMNkhVNlaP0rbY/dRtwDAqZ9KNJoilTQrmKezy4GfGtMrX4u3LLYAA8OHURqKYIkW3hpmtumbHrf8MalnYgSHdV401M4QdVF4KOLOAuAu+jzaOsljTxD8DN2bHYf+Mp2ndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065807; c=relaxed/simple;
	bh=+wRuhHc/wVNIPLuGnw335YpmZsh16sy4Z1lcWFtJxMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDUTdOnihMXwVerQAGiDXHWLHmhHbehdJfUqR6oQOpo0T+CJE5WnLGLYSEK48+NNQOEqStSTYClHZ84t/hbRPoaKjhQoEsg+xrNblHolyhi3W67bbbVtr1R7DvHnMMK38NtOSn1yrt+hfiglisqsSDxy2JZCWlJfw/VeTBTCVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5Rvg+rV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562D4C4CEC0;
	Wed, 11 Sep 2024 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726065806;
	bh=+wRuhHc/wVNIPLuGnw335YpmZsh16sy4Z1lcWFtJxMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g5Rvg+rVQVW/wf+pTnR2yeZqkiF68uiSLy05yibcAyuGsPpHPFsJhqKvtzUdLwBxd
	 LafdTMfZV/gQCAXzBE0DgZjf3IK+AWsR8bJds1lisu+FgYEjwnVqobpBvEJuYqgYJO
	 W163W3iJGPn/6xWXAfsdxIDcUTAGaVThsE+1yuM50WcfYU4u5Fh6Dszl1xi5ii0nBU
	 OWWeWPszofZkS5BRguBSaLBbrMlkLGrK00Ta0BQAwSzy00Snuq4rYFvoWdh0xSQmUN
	 8RarJEekkV5tcu5w27oV/2+d+VLG//r+bYC7rR/CUZaTWtHYeG7NT7KmNyoId02ju0
	 NAd0acNg/4xyg==
Date: Wed, 11 Sep 2024 07:43:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jeongjun Park <aha310510@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 ricardo@marliere.net, m-karicheri2@ti.com, n.zhandarovich@fintech.ru,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: hsr: prevent NULL pointer dereference in
 hsr_proxy_announce()
Message-ID: <20240911074325.55704611@kernel.org>
In-Reply-To: <20240911100007.31d600fc@wsk>
References: <20240907190341.162289-1-aha310510@gmail.com>
	<20240909105822.16362339@wsk>
	<20240910191517.0eeaa132@kernel.org>
	<20240911100007.31d600fc@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 10:00:07 +0200 Lukasz Majewski wrote:
> > The structs have no refcounting - should the timers be deleted with
> > _sync() inside hsr_check_announce()?  
> 
> The timers don't need to be conditionally enabled (and removed) as we
> discussed it previously (as they only do useful work when they are
> configured and almost take no resources when declared during the
> driver probe).

My concern is admittedly quite theoretical, and perhaps completely
impossible given current RCU implementation. But what I was saying
is that timer may be running, and interrupted by a very long running
interrupt, say on CPU 0. Then, say, we unregister and free hsr_dev on 
CPU 1. When CPU 0 resumes running the timer code it will UAF on hsr_dev.
Again, probably completely theoretical.

> Anyway:
> 
> Acked-by: Lukasz Majewski <lukma@denx.de>

Thanks!

