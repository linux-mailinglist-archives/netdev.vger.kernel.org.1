Return-Path: <netdev+bounces-210061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE8AB11FD8
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FCA3A907B
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD821DFE09;
	Fri, 25 Jul 2025 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXEp6twe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A019E99F
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452878; cv=none; b=Nw37NQvw4QjBB3gYPv2bqBdIbdlnZM2TAcGbovEYmRlQIv73XHs5QeKlUzxWvMe9/ybu9sxXlw0CzmxkeqjC2D/r/6SKMxYOncMQIOn+8w7CrwcJe3Wen2j7iMLMdbvJj2ClD6fBXBQwZ4efhherp4B0iFWnP1EM2tSAHt/oCA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452878; c=relaxed/simple;
	bh=+mK+uBD3JRb1BeXBncFSDbQt9iV0QiyjxV1/nyzllYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLCxBVm6wRLXrbCdEGZf0XJx4xdYh1PuHEOkSrg0s+zgZsTxZIANtRQ5sNj8/IFKrIDW3THj1YBidKMcfkD9hgMnVv/biiT26m+YLmsKe7cpMCRogkMw15BpxirdDpY7p4HJO48cEopynflJEthn9Q5naiIqbkLz1SSzqsfzcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXEp6twe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149B2C4CEE7;
	Fri, 25 Jul 2025 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753452875;
	bh=+mK+uBD3JRb1BeXBncFSDbQt9iV0QiyjxV1/nyzllYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pXEp6twex13dGxvHzqslk1jyUmsyly+2KTHjU7KhU8oKq4hfXTeIfU2Ss4QlzXyYj
	 7oTKaxExdukP2Ja/Yy1ZPvRAJdtTiLGgmBP7qUEYevcU/4iejHhfwocc2g0iqmi7A1
	 NX4w1x7eX24R7/X2yk2BLe1FkReO8f2zvL+h1qzaY49h404zgfBooe0GoiS6NuVtq4
	 X7V7sKaduI0MG7Es91uFrTJAfCsBz4z3wwN994hg2UbkDHRpVa1d8dkhc3XKBNUsZw
	 TM2qPTF/JBQHOv6bacvd7+ALWmHYQ4CMfTVrA+odAVPI6HmdXIjywSXXmuYDkz1mzv
	 FP5lncNg/Ir4w==
Date: Fri, 25 Jul 2025 07:14:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Jason Wang <jasowang@redhat.com>,
 Zigit Zo <zuozhijie@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, leitao@debian.org, sdf@fomichev.me
Subject: Re: [PATCH net] netpoll: prevent hanging NAPI when netcons gets
 enabled
Message-ID: <20250725071434.4e1611fe@kernel.org>
In-Reply-To: <837ee1c6-a7c8-490b-84ae-6c24fdd48e4e@redhat.com>
References: <20250725024454.690517-1-kuba@kernel.org>
	<837ee1c6-a7c8-490b-84ae-6c24fdd48e4e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 14:23:26 +0200 Paolo Abeni wrote:
> > If this warning hits the next virtio_close() will hang.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > Link: https://lore.kernel.org/c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> It's not clear to me if you have been able to validate the patch into
> NIPA already?

Sorry for the omission, I sent the patch in the evening after just 
3 iterations but left the test running. It completed 30 iterations
cleanly (boot, run the selected tests, no hangs).

> > +static int netconsole_setup_and_enable(struct netconsole_target *nt)
> > +{
> > +	int ret;
> > +
> > +	ret = netpoll_setup(&nt->np);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Make sure all NAPI polls which started before dev->npinfo
> > +	 * was visible have exited before we start calling NAPI poll.
> > +	 * NAPI skips locking if dev->npinfo is NULL.
> > +	 */
> > +	synchronize_rcu();  
> 
> I'm wondering if it would make any sense to move the above in
> netpoll_setup(), make the exposed symbol safe.

Fair, somehow I convinced myself that the nt->enabled = true;
is more relevant.

