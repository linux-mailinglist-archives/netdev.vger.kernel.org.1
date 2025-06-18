Return-Path: <netdev+bounces-199278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCDDADF9EA
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7FA3BBDED
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC627A455;
	Wed, 18 Jun 2025 23:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="DNv0Cd9J"
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160121ABA0
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750290491; cv=none; b=rE/lou6ocYJiZdHkxtt3GX0aJMwT1dj5v2J8xdMRZIshCUrCHpRACvRENgb2Vw65j5jzhELeOE+xp+xP/NLjpUl9hZOX8IZU+yT++NuUJKISdoro3Ha01kwUQVcujpvZoL2lFEhsdvG2qGZy/25FfWwpy6CXFnQ6qYb/+Y/jNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750290491; c=relaxed/simple;
	bh=KX3+sbAUZBhuFKdfTceIWjUodmFefs0lTiQe3yvmS2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdyybvvkFbILvhYF8nMHvQX1RlVnPkGQMXtDfUPPia0SXE+kJ00uVnzaKQ2tbMP585Zu2lJ+b+Uza1IBGsUSiVKWV0hG7XN/+ODF13A4BeI5/48LprCbURg7xdiwtMTwmZUIZJoRm62ocD6HwNjMCtu/mOyX+IOTQNxF/hDiw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=DNv0Cd9J; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 55INhdnq2863814;
	Thu, 19 Jun 2025 01:43:39 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 55INhdnq2863814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1750290219;
	bh=YogSa5Vo5USFmhduzVsGIopj0xtIN2VwHMaZPHQ9Sms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNv0Cd9JkHCh/nKHLdvcJTt6TZ01m1unKf9nkFtBAqXm/yXxeGSljTyBFE13HfVQh
	 jfGHsg3coGLJx5csEFx5fWt9AAjdToRWfpEj6iYmyLCAA6Kp+V1Ts6DwYbNfWAVIc+
	 Hlnvi9Xja8xY3yRFxjiLHvhYrAZ/YdwWxpN9WU0k=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 55INhcW22863813;
	Thu, 19 Jun 2025 01:43:38 +0200
Date: Thu, 19 Jun 2025 01:43:38 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/2] net: atm: fix /proc/net/atm/lec handling
Message-ID: <20250618234338.GA2863787@electric-eye.fr.zoreil.com>
References: <20250618140844.1686882-1-edumazet@google.com>
 <20250618140844.1686882-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618140844.1686882-3-edumazet@google.com>
X-Organisation: Land of Sunshine Inc.

Eric Dumazet <edumazet@google.com> :
> /proc/net/atm/lec must ensure safety against dev_lec[] changes.
> 
> It appears it had dev_put() calls without prior dev_hold(),
> leading to imbalance and UAF.
> 
> Fixes: da177e4c3f41 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/atm/lec.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index 1e1f3eb0e2ba3cc1caa52e49327cecb8d18250e7..afb8d3eb2185078eb994e70c67d581e6dd96a452 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c

Acked-by: Francois Romieu <romieu@fr.zoreil.com> # Minor atm contributor

While moving proc handling code from net/atm/proc.c to net/atm/lec.c after
seq_file conversion back in september 2003, there was a misguided change
turning:

dev = state->dev ? state->dev : atm_lane_ops->get_lec(state->itf);

into:

dev = state->dev ? state->dev : dev_lec[state->itf];

.get_lec included dev_hold. I didn't notice the change :/

-- 
Ueimor

