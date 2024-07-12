Return-Path: <netdev+bounces-111141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D193006A
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 20:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22C3B2359A
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8C18AF9;
	Fri, 12 Jul 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haKkiWwW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297A18EA2;
	Fri, 12 Jul 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808426; cv=none; b=TJMfb4qyd5xCi4PKCA5EOz8uR3ELK5ugoGHbl4fMHuDFbPmbZNrmpDpdLWnEjfPfGaQziZEmJ83jRw11/vcLT7OzjIQGdP/Luyauur3Q3xjVLx4s4zLlAhvvX0oxGddhgNa/U+PfQb+B1iCsAKuUv6K98wIOtF6FuAH9N7DHISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808426; c=relaxed/simple;
	bh=i/tK8RDXFn4KoGAhILklscvA71+oECCSOQkenxyUpbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7qNIVykjdLYfEhop02tlddr51k/fX/++wJZ7d46Ya5TbRXHo2qWexHca27wtU0jayW0dxvRyEvHR/3WqhsbhO/nhDgfsZImKHCeptEtrfhsMGVo6ObSS9YdEOCObYUU21BqgKlWc7oob+6qSLIJ9c7zu+1h1lrUCkIW58DdMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haKkiWwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900DEC4AF09;
	Fri, 12 Jul 2024 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720808426;
	bh=i/tK8RDXFn4KoGAhILklscvA71+oECCSOQkenxyUpbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haKkiWwWEeXzBUAUfEvsHVmQs3SovcnVCl0c58as20YBRukHOtgPETQwktVMtuDMX
	 fzeCXDKLrAfbElg2Bjo3xHEKq3vuJhbdobw8uUOsyfmTdJDZj8oxRAerdX4mLko3X7
	 RgP2c1TBTT19mYN+ntSa2Qr1vgUBhXHAjoYvgmUcsoVzV9XnaaErUMXemF6Uq/gkq+
	 /wy8YuzkHkBzieJ/urc1ZH9HJ+IYZH+A4bQuxtuP+pKhGhgR1AsDt8IEFJbXzaudkR
	 CLTW/N8zjHc1f/nde/xfdpw9jKJ21vEQG5hMEkUb/1j07piUbgMNGMQIpMPa9dOupv
	 2RcVLW5kb9YWw==
Date: Fri, 12 Jul 2024 19:20:21 +0100
From: Simon Horman <horms@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH net-next] net: virtio: fix virtnet_sq_free_stats
 initialization
Message-ID: <20240712182021.GC120802@kernel.org>
References: <20240712080329.197605-2-jean-philippe@linaro.org>
 <20240712064019-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712064019-mutt-send-email-mst@kernel.org>

On Fri, Jul 12, 2024 at 06:41:34AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 12, 2024 at 09:03:30AM +0100, Jean-Philippe Brucker wrote:
> > Commit c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > added two new fields to struct virtnet_sq_free_stats, but commit
> > 23c81a20b998 ("net: virtio: unify code to init stats") accidentally
> > removed their initialization. In the worst case this can trigger the BUG
> > at lib/dynamic_queue_limits.c:99 because dql_completed() receives a
> > random value as count. Initialize the whole structure.
> > 
> > Fixes: 23c81a20b998 ("net: virtio: unify code to init stats")
> > Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > ---
> > Both these patches are still in next so it might be possible to fix it
> > up directly.
> 
> I'd be fine with squashing but I don't think it's done in net-next.

True, but this patch doesn't apply to net-next.
And 23c81a20b998 ("net: virtio: unify code to init stats")
isn't present in net-next.

...

