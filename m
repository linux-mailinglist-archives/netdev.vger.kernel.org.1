Return-Path: <netdev+bounces-146755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303AA9D58B9
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 04:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA65B280FBA
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 03:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890311442F3;
	Fri, 22 Nov 2024 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKAWScB2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8002582;
	Fri, 22 Nov 2024 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247779; cv=none; b=SEFU1Fyy0BG0oB0rjyWwIJB6ZIcWRqVCPHX+hzRXdXLY8gDYEp+xEnpIWhDmsUhGJD8YbHfK/3wOKiRXg9S6nLKRoPZ4Il/V3YBzvPgjUXTwygMlQvsKwWJ6itDgplePQlig1mscwqPfGxlanrQpM2nm9hLF36S2d1DkW0lGS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247779; c=relaxed/simple;
	bh=NkdKjCXLxBBvRKbI3TMFn7tAVIKFeOG6VfOztyPRGFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1Y0IKWnp3RXS8gQYWYiPTrab60Dr0Jfck91YjSCjwNM9/gLh2hxqmfqXCmBrSBlsrY3KD2MQyV6dvU3x4nV1x8ZH337BpY/yAA7n+jFHy4Y9SMeZileCq4wxQYRlgFA+VlpiWMyL1ypXhpEfKSMwkT+F1pq5BOAkHVg07Wu3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKAWScB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F77C4CECE;
	Fri, 22 Nov 2024 03:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732247777;
	bh=NkdKjCXLxBBvRKbI3TMFn7tAVIKFeOG6VfOztyPRGFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RKAWScB21CUSGCf+Lv8NbvndnvTk4GVL/fK7E6zJvbLxXcVAU3E+Y0OtYHWPQV2Fw
	 vSyuPW8Stle7iKfrLDtn+XJ1g6bP0uZfT4NGNL9vksBofFRLt013/rRuCHS0sRLHbB
	 ykHNctNaXzxYDgTqyeRV+7BBFjY0iljeuiqvseFtUdK2VPsje5Oz7RsFzMC05E77GM
	 d13flEC2jzT/ghQicBZSNXCMLrhPOSyC+3H/xOAy0ZY0JmiPW2BZGFXOcnewAt1KVw
	 0GJZL16tdBJ8LfpcN79k2qBkOuHpHPbOyDHy6VzPi6ag+jhCXNhcVl5r5VA1plfI46
	 HBd6wmJUgQV3g==
Date: Thu, 21 Nov 2024 19:56:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Michal Kubiak <michal.kubiak@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net] netpoll: Use rtnl_dereference() for npinfo pointer
 access
Message-ID: <20241121195616.2cd8ba59@kernel.org>
In-Reply-To: <CANn89iJeaaVhXU0VHZ0QF5-juS+xXRjk2rXfY2W+_GsJL_yXbA@mail.gmail.com>
References: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>
	<CANn89iJeaaVhXU0VHZ0QF5-juS+xXRjk2rXfY2W+_GsJL_yXbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 00:41:14 +0100 Eric Dumazet wrote:
> > Fixes: c75964e40e69 ("netpoll: Use rtnl_dereference() for npinfo pointer access")  
> 
> This seems wrong. This sha1 does not exist, and the title is this patch.
> 
> We do not send a patch saying it is fixing itself.
> 
> I would suggest instead :
> 
> Fixes: c69c5e10adb9 ("netpoll: Use rcu_access_pointer() in __netpoll_setup")

Or no Fixes tag and net-next...

I'm missing what can go wrong here, seems like a cleanup.
-- 
pw-bot: cr

