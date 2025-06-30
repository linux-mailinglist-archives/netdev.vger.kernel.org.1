Return-Path: <netdev+bounces-202429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6181CAEDD84
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6CC18858ED
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC535286D7E;
	Mon, 30 Jun 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlhRXnPe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A855B2868B4;
	Mon, 30 Jun 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287873; cv=none; b=QbckDRITaNBPLulxIcrRayq/4ZBMjj9xjQKmjJEVYauWfvKEFWtu8wj8iPL/8z9LkeYlazm+LpiEsk+ClobDo3V4mGumqu9CIYhF2wOuiY/bdOmbBdlDXoCmuiNSHAxgXR79AkbdgothNpl/XDaF1R24WSwm2/xwiHjSFM6k7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287873; c=relaxed/simple;
	bh=mjYSJoVT5dvUajn3ent2ZGoDomPuTp34GeIy2fuO5Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRGG/CvcGhyt0zMf9DVaZ0Wk2p4Xbvw4V5Mbb0boszJ1Mj45X7DFkKCiILOawxAxkG4sMmXMjKJ/WDk8eHZQkJEdPV80xK/7hbwJMtBd0f7gOkAhb5Hxe0O24uj0Aq06/hOPdBnrx3Gylx9W/XSPbXLNSkfbvzuDzuBJUB4ocwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlhRXnPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE95C4CEE3;
	Mon, 30 Jun 2025 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751287873;
	bh=mjYSJoVT5dvUajn3ent2ZGoDomPuTp34GeIy2fuO5Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlhRXnPe7VN1ZFx/PfCeWEX6PWR/KvKgKLv26S3Uq2qJf+waGpea2WiM54qYNeh9b
	 CupCx+SoGDvTP/xviAkFDBib3Ms759TwYgn5tozfka5l4s9vCCrAfOYazi+OcniP/y
	 vbSAZ0UuHPvPFXmsfQN0ZdvEeMwcjVhTCYLJkvpmVknAuKprvfY4+ebs7NjOkFlgxb
	 /fUNhywQf2gtfls0WV6QbdR2UBGAc6nBBKsi8lbo9X8RRn321vrMMX2SXUZ8Zfff/v
	 /ojN7VoiiIF96ewVmHzwtPWf5BQKgTrD0DEZsbeyULiqon99jiIYtYSQGdv91QZWBS
	 g+NMdGum12SGA==
Date: Mon, 30 Jun 2025 13:51:07 +0100
From: Will Deacon <will@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/5] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
Message-ID: <aGKIO8yqBSxXZrE2@willie-the-truck>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-2-will@kernel.org>
 <7byn5byoqlpcebhahnkpln3o2w2es2ae3jpzocffkni3mfhcd5@b5hfo66jn64o>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7byn5byoqlpcebhahnkpln3o2w2es2ae3jpzocffkni3mfhcd5@b5hfo66jn64o>

On Fri, Jun 27, 2025 at 12:36:46PM +0200, Stefano Garzarella wrote:
> On Wed, Jun 25, 2025 at 02:15:39PM +0100, Will Deacon wrote:
> > vhost_vsock_alloc_skb() returns NULL for packets advertising a length
> > larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
> > this is only checked once the SKB has been allocated and, if the length
> > in the packet header is zero, the SKB may not be freed immediately.
> > 
> > Hoist the size check before the SKB allocation so that an iovec larger
> > than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
> > outright. The subsequent check on the length field in the header can
> > then simply check that the allocated SKB is indeed large enough to hold
> > the packet.
> 
> LGTM, but should we consider this as stable material adding a Fixes tag?

Yup, absolutely. I put it first so that it can be backported easily but,
for some reason, I thought networking didn't CC stable. I have no idea
_why_ I thought that, so I'll add it (and a Fixes: line) for v2!

That seems to be:

  Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")

from what I can tell.

Cheers,

Will

