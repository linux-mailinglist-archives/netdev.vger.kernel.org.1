Return-Path: <netdev+bounces-120745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D21E95A7ED
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4B2283213
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 22:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6717B402;
	Wed, 21 Aug 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/whd823"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE54170A2A;
	Wed, 21 Aug 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724280567; cv=none; b=g9Zu7WsUS+yh+6e2YTANE0VRUqs9ryae/1aBYxG4t2PLpA76eGtBDF21qP/5K1DDE4zR4Babk263xSEiViDgGOi+Zab33bzunbhMkBIw6SmuDeKXX+2yq3ZKCreKbZ6v8jh+2D7PSimkBpr4469B5sVGE/AbolDBSz+oliASJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724280567; c=relaxed/simple;
	bh=2MskA3zbNh+3ybAqK5Hk+d7ziHwmFQWue6q/gFbKUJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbp4oKDCYzuWfP5SuOoAWQpg84CsM3U7yoKYDHHJJ9KoT/pJfMaDvLi0mnAhH8x3oH3OU4NdbNr30bt4sAFQSdUh1vpLdGjzcaqdfOdfYieudWHwV5cpKKCqqKzHo0uDeV6+MsN48mc/mKIrmWrtaRCXWwM9Kb7SIVf5vL0sS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/whd823; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C3DC32781;
	Wed, 21 Aug 2024 22:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724280567;
	bh=2MskA3zbNh+3ybAqK5Hk+d7ziHwmFQWue6q/gFbKUJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s/whd8230jgyJbA5L00dL3RxM/q0j2QwqBo6aKHSuCYZ2+Guf0ZzuHUQPRyU6I/ZO
	 bdm8gpQYuF+mWSwcNfbb8+Fzk1tMjkRf2hxoMNCvcA1lJDZWyGujz7rIYcweiZCaOR
	 AYADYlLV4SqkWhVZyb8ZRExwT6jiw9y2fPPl8yZgz+91Itle4L/oqs0ZNBpBcXNtfH
	 OY5MBJVgY+NTpQcYsFlxFSAdBeQ16zgxREsB+E4bsxQH4G/XPXiukDllCFd0RgHxgh
	 izzp/+rme448zn9ilO59g3iKLB8eeOmtP2YnXaneG3/8GCOCvb+4fiG8ljR8eYVM86
	 ie4NCq0XsxKEA==
Date: Wed, 21 Aug 2024 15:49:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Aijay Adams
 <aijay@meta.com>
Subject: Re: [PATCH net-next v2 3/3] netconsole: Populate dynamic entry even
 if netpoll fails
Message-ID: <20240821154926.14785d66@kernel.org>
In-Reply-To: <ZsWjpuoszvApM1I0@gmail.com>
References: <20240819103616.2260006-1-leitao@debian.org>
	<20240819103616.2260006-4-leitao@debian.org>
	<20240820162725.6b9064f8@kernel.org>
	<ZsWjpuoszvApM1I0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 01:21:58 -0700 Breno Leitao wrote:
> Another way to write this is:
> 
>         err = netpoll_setup(&nt->np);
>         if (err) {
>                 pr_err("Not enabling netconsole. Netpoll setup failed\n");
>                 if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
>                         goto fail
>         } else {
>                 nt->enabled = true;
>         }
> 
> is it better? Or, Is there a even better way to write this?

Yes, I think this is better! Or at least I wouldn't have made the same
mistake reading it if it was written this way :)

> > As for the message would it be more helpful to indicate target will be
> > disabled? Move the print after the check for dynamic and say "Netpoll
> > setup failed, netconsole target will be disabled" ?  
> 
> In both cases the target will be disabled, right? In one case, it will
> populate the cmdline0 configfs (if CONFIG_NETCONSOLE_DYNAMIC is set),
> otherwise it will fail completely. Either way, netconsole will be
> disabled.

No strong feelings. I was trying to highlight that it's a single target
that ends up being disabled "netconsole disabled" sounds like the whole
netconsole module is completely out of commission.

