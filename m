Return-Path: <netdev+bounces-166187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C55A34E2D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180823A5027
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4753D242914;
	Thu, 13 Feb 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUqUpwov"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666C28A2BE;
	Thu, 13 Feb 2025 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473494; cv=none; b=Xj9NWVtrimJuNJDdy4P8c/wK46IlGCzr3KTMYQGRUmTIaLtyCnr7H+mlVkaNWVQrkxTHl+0hg8z/zGTADcdgXSAIi9+obHl7HSao0sJanVJRPzxuhge5IgXxmMheNtQHaFZf5KIP7eRclPyJ86/m9e4TSCxRhO4pIghEsKEAStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473494; c=relaxed/simple;
	bh=yLIWYbIxu30mqkOd5xDvuh5HShBDy4Ny/i25bHYqoC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNJKvcWhH742fF5PdYx5kn9+JT1b5cEa7yp2IH/2DPXzCG1sDxUTXV/LtomNpJEbUXduqmNAovB6O3IPa3NdZPAZykJqUfczZJLI/OrTLYHu4ENJz9DhU8kvx6znZlusrY9I6vhz5w9u2xiOe182tO9fSph09bCGTUOFaYEkRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUqUpwov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD5EC4CED1;
	Thu, 13 Feb 2025 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739473493;
	bh=yLIWYbIxu30mqkOd5xDvuh5HShBDy4Ny/i25bHYqoC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PUqUpwove5nP6fZVqhA6X6T5N4JvBtvWnHqO/ETwrj/IixsxTr6nQWQLgFC5W4zAv
	 snruunWQaPHlGJxMvqIkM7Q2XtyYyKz/9oGxJ32ifzxX+GyiW6JSd3UeN//3hitwOk
	 nXq2KzerehJe7w9rPnqy77BwYS7B2bUOayCrQhXNiMaaUPkZuwT1HYq27ZN5gxUbDp
	 Jvqf8aSK9YkBbpi7l5KSlEIkpwlrJBmmGFEHWUkV2hh0BHgGpVjJO05vxTv7VUsBsr
	 3kwycg4iDcIEeMVX96feKWA1+d6EegIKTz8X1aqQpMmfaXI3LwZIHdDyd9TNSLLH+M
	 GXWoh8vrn6v3Q==
Date: Thu, 13 Feb 2025 11:04:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hayes Wang
 <hayeswang@realtek.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250213110452.5684bc39@kernel.org>
In-Reply-To: <20250213-camouflaged-shellfish-of-refinement-79e3df@leitao>
References: <20250212174329.53793-1-frederic@kernel.org>
	<20250212174329.53793-2-frederic@kernel.org>
	<20250212194820.059dac6f@kernel.org>
	<20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
	<20250213071426.01490615@kernel.org>
	<20250213-camouflaged-shellfish-of-refinement-79e3df@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 10:14:02 -0800 Breno Leitao wrote:
> > The problem is a bit nasty, on a closer look. We don't know if netcons
> > is called in IRQ context or not. How about we add an hrtimer to netdevsim,
> > schedule it to fire 5usec in the future instead of scheduling NAPI
> > immediately? We can call napi_schedule() from a timer safely.
> > 
> > Unless there's another driver which schedules NAPI from xmit.
> > Then we'd need to try harder to fix this in netpoll.
> > veth does use NAPI on xmit but it sets IFF_DISABLE_NETPOLL already.  
> 
> Just to make sure I follow the netpoll issue. What would you like to fix
> in netpoll exactly?

Nothing in netpoll, the problem is that netdevsim calls napi_schedule
from the xmit path. That's incompatible with netpoll. We should fix
netdevsim instead (unless more real drivers need napi-from-xmit to
work).

