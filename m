Return-Path: <netdev+bounces-185328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB38A99C51
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C09E3AC6EB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5862223DC5;
	Wed, 23 Apr 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8D3V+KL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13B2701BF;
	Wed, 23 Apr 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452404; cv=none; b=F77NJ9Km6OPYV8YYs/VC0rXYl8fHuFL+UVgrujqBbgel8PLzGCJdz4fOdqs2v14mwtvuWbL6ZpH5K9LifFlsPdPkiSBFaB9vgUQpn+pY8Rdw5DQzARAbeM/I+ZWWuHkvh89ABhTJwmQ1el5I5T/iWZpvufPoq47hg4BTHtuNlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452404; c=relaxed/simple;
	bh=I1XKLXR/QFtQnpyzb0c5ysHKF4kWME9hMZgKJ6VxLW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvPpWs6kgY6ZgEDjQs2sTtXVnbbnfiOWLnL4t6+dlg15irDm29d5AbLmPoZrmpLsNdzB9R96j0MYzuq8bhpjC8CNGozGhULmX7wgifyNpWyaHNZ3cOC2ix09eG4lMhORZMMCbbCkt6lgFE8DKEmO+1lYpYxqKaQzO2qVJjMm5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8D3V+KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF37CC4CEE2;
	Wed, 23 Apr 2025 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745452404;
	bh=I1XKLXR/QFtQnpyzb0c5ysHKF4kWME9hMZgKJ6VxLW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O8D3V+KLl8/Upm5zkSw0xu5LaCBgp1+4Lh4E9ZgW3SbC27SCiZ1yJ0i3zftkoJDsx
	 J4RMEE0L21ydU+GrldLJKa105ztKz+qKMp2PEJ8olH+p4zOmdUoyBqxEBCWqR3udyt
	 A7wAX2t0OGwPcSTEN9ZmKj1yqvFYXVP2TJK5AHv+HyTNJ8ZCaxxE+2qDLr65FF4PNC
	 Exr5FrnWwsyHBpBUZ8dybEl3Ot+pDB4woXu1epMoO0GYrVGKDXF2v3ReXqeD44ygNL
	 wxIrve0AAFqzKzK/yYG76kMvC1RZ3wg/gEK2j0p8YbuEMGNRonKj80noQ7HB7C/oTD
	 lCJDkdQJb8qFw==
Date: Wed, 23 Apr 2025 16:53:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/7] net: register debugfs file for net_device refcnt
 tracker
Message-ID: <20250423165323.270642e3@kernel.org>
In-Reply-To: <20250418-reftrack-dbgfs-v4-7-5ca5c7899544@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
	<20250418-reftrack-dbgfs-v4-7-5ca5c7899544@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 10:24:31 -0400 Jeff Layton wrote:
> +	/* Register debugfs file for the refcount tracker */
> +	if (snprintf(name, sizeof(name), "netdev-%s@%p", dev->name, dev) < sizeof(name))
> +		ref_tracker_dir_debugfs(&dev->refcnt_tracker, name);

Names are not unique and IIUC debugfs is not namespaced.
How much naming the objects in a "user readable" fashion actually
matter? It'd be less churn to create some kind of "object class"
with a directory level named after what's already passed to
ref_tracker_dir_init() and then id the objects by the pointer value 
as sub-dirs of that?

