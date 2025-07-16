Return-Path: <netdev+bounces-207411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EE7B070E2
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32614A6023
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B4B2EF664;
	Wed, 16 Jul 2025 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAmTOu4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB32E88B5;
	Wed, 16 Jul 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655859; cv=none; b=Q1kHYqyBxg5hu/97Zwt/l4MPfG1F6apASQjD06HNUdDRst9otSu0ISK7qLPgqI9nQA7WlBjQXTXo8rCh1jWOiL/kDLxoi4nUEqbg6qIyNkvmB27mfMND7/Ut7tZL+ZjZv52M1P8UJ9TXRYrB+y8zmfyEKcMVXvwAsBB+qOh9gjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655859; c=relaxed/simple;
	bh=GS2XHA226b6emGNknYbU7j3knflLrU/I0nHrns/wD+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxT69UYIVwZ5bMeWzIxvLheGObt53zRCj3Pe7sWxoydDPfD54tNDwIg4pI0qZe8bFhtz5cv86hdsxZEWUYVgONUFQvZwuvNTK9JijBUyP7NewUxKYcPsJ3/4kzjoSM3t5mIdVXWL1mh0t4qdEPLGUO3jTDXonGwkPspgU3+7z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAmTOu4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF3BC4CEF0;
	Wed, 16 Jul 2025 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752655859;
	bh=GS2XHA226b6emGNknYbU7j3knflLrU/I0nHrns/wD+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAmTOu4zvCP8hEtoVUfB8Rk2hDssr+5Sw7W4iffqxMJkKWNdNAobP+ULQr7+C6T7l
	 QmZPP+t8wVXHn0AfE9Vp91U0PoFoG1SZyY4Uw9gYLkjKBYbr9hy2UyRw5kBhqEywgx
	 oZ+w5vwNcyrEbOEd+r48LSAfmVcK9iyrFVsmFstUdGi54fxc86FwB2G4gzNOcWtY3e
	 Rg2uKQe831FWqiTP9E2g+ycMSliNEWMPF99VhqWekx/FaBZM8tuyEyfKA47iubfrF5
	 kIO++//02Owst8ncBpYtIfMWsx45jtOtl1sgx0Jk/NkijNWarNwywBKVV74RJQEfn3
	 O4jbTUiod6TCw==
Date: Wed, 16 Jul 2025 09:50:55 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13] vhost: Reintroduces support of kthread API and adds
 mode selection
Message-ID: <20250716085055.GJ721198@horms.kernel.org>
References: <20250714071333.59794-2-lulu@redhat.com>
 <9dd21a72-9451-4b77-9ab4-d9b31b408e25@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dd21a72-9451-4b77-9ab4-d9b31b408e25@web.de>

On Tue, Jul 15, 2025 at 08:43:45PM +0200, Markus Elfring wrote:
> > This patch reintroduces kthread mode for vhost workers and provides
> > configuration to select between kthread and task worker.
> …
> 
> Is there a need to reconsider the relevance once more for the presented
> cover letter?
> 
> 
> …
> > +++ b/drivers/vhost/vhost.c
> …
> > +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> > +{
> …
> > +	vhost_worker_queue(worker, &attach.work);
> > +
> > +	mutex_lock(&worker->mutex);
> …
> > +	worker->attachment_cnt = saved_cnt;
> > +
> > +	mutex_unlock(&worker->mutex);
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(mutex)(&worker->mutex);”?
> https://elixir.bootlin.com/linux/v6.16-rc6/source/include/linux/mutex.h#L225

Quoting the documentation, I'd suggest these circumstances:

  1.6.5. Using device-managed and cleanup.h constructs

  Netdev remains skeptical about promises of all “auto-cleanup” APIs,
  including even devm_ helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.

  Use of guard() is discouraged within any function longer than 20 lines,
  scoped_guard() is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.

  Low level cleanup constructs (such as __free()) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  __free() within networking core and drivers is discouraged. Similar
  guidance applies to declaring variables mid-function.

https://docs.kernel.org/6.16-rc6/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

IOW, the code is fine as-is.

