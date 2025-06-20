Return-Path: <netdev+bounces-199921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F77AE2333
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 21:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71FD188D1F8
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A25A230BCC;
	Fri, 20 Jun 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+ND/jT2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0722DA06;
	Fri, 20 Jun 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449564; cv=none; b=ZxY+0yg0GfuXJbVSIK5g2Y1oT2tVfnVq4lqOA0HWCDGXCzSBjarEDg3jNlOXFdnt8/Uz1BSQHjryOvEsGt+z0yHyO8iAG9h2nDymaPK4sjxbu5fVq0hT5bI+5qw0anPoyRfDddjtDZPzU5B9PGGZEvs40dE8zOazLkBvYrzM5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449564; c=relaxed/simple;
	bh=CcO/Q638HJe+Qrayu/7sezNXngKawDVDrNRHENuFNwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbVFr/9S9AElwvjMFV76IlX5yOxmRed4VKCUvViHuvte3bYHbQM2muBeP0Ud85/yxIJS11VubHG7kuGSbk10saBbBadr0rN8roiQmcQY0Ps0a7DLbQjZHNnH7VCHkGxcU0xuVkooaN+8UFhEDIK9Pzb9Xb+FrTMhQfD3lc6ZG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+ND/jT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932EFC4CEE3;
	Fri, 20 Jun 2025 19:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750449563;
	bh=CcO/Q638HJe+Qrayu/7sezNXngKawDVDrNRHENuFNwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+ND/jT2oETaP85X5LBt4Qgfli3QMD4fiwV1OvvDL0aTpQsIeUeQH+l22z87KnRhR
	 ICEfdZuGS1MgIG6uBK3Yz3DoXJrXwk6eQ7p989TaDDWUMqfS6+Dbe6tx86knRnwUwC
	 TpMwWkhyPeluw/jNgOxbYi3WbH4+cJbUMxR0hx49PjL8Vh7EZkeJoN0fADg2tmB/eK
	 iu/qG4pYvTtvRumjlyOMjE6GRkHFA1nF/QVVqDTZIn58KXIM6t9veMzznkI9rqOw1t
	 UE1DtYkhdYc0YDMfKPnWXiltSXzvIx9SzKrpHK3YV8Hk2TYHRJ151i9XNXBnDzq8T6
	 PawPRNAPTFKDQ==
Date: Fri, 20 Jun 2025 20:59:19 +0100
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 net-next] net/sched: replace strncpy with strscpy
Message-ID: <20250620195919.GC9190@horms.kernel.org>
References: <20250620103653.6957-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620103653.6957-1-pranav.tyagi03@gmail.com>

On Fri, Jun 20, 2025 at 04:06:53PM +0530, Pranav Tyagi wrote:
> Replace the deprecated strncpy() with the two-argument version of
> strscpy() as the destination is an array
> and buffer should be NUL-terminated.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


