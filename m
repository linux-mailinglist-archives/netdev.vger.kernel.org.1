Return-Path: <netdev+bounces-99169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9248D3E8C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD72E1C21797
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89315B139;
	Wed, 29 May 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB3fCxMz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083821386A7
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008634; cv=none; b=HikvkrTPAO9FeoC4zt4krEXFym7bKEsbZj260D+QKBqSCyTOw5ygZIMG7ktGZDuEJPYMTGRbvnEo0v5EpK8bo7s2v460fEXXl9NQ8CQd6ipUo2e69lmch0V4mDN/ooMl2KuYMtUkogsxOo1OafwO5GMR3fo2g9qB3ue7nqvlXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008634; c=relaxed/simple;
	bh=HG2GGsGQpkpTUKw//p2QoG1jCbO3GPUzgAaZm/6PXC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLk4MUt1zTy+8L9SuHT28XcjisW7Q0wRJNfoC5k/uvSnFXQbOo+5HbcK4Q3V20oxwO5WRTENui3QItNjsWaJnNe2eEyXxw3eOFRoXf0a8v/BvRFLvJQbSKy580eZOz8QEFqkOSlDaNr+WXgmr+jEkUxhuYWedCg4CkuRcIb7O/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB3fCxMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D94C113CC;
	Wed, 29 May 2024 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717008633;
	bh=HG2GGsGQpkpTUKw//p2QoG1jCbO3GPUzgAaZm/6PXC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LB3fCxMzP7pQrVstCygdUO9yY0O1GrhFRKVp6TtgmnSDtRzjzTTLl6QLGiFpgkG0z
	 Zy1RAtR0Xo6ESxb14xOmOY0nC3vlsp8/0+zsRFHtdCsm6xGsi7MFdt3yiFjfTdDHXt
	 9YRvQndIt0rQXGOGmomjSKL4cz25dLZPmCH2KWwZVmVeopQU7v8P8dXkQx4GCViIHY
	 6mopDvj6iswm7LOyTX2xFOI45n4HV8/n+v0lCmy4a+p7sCmc/tF+srvKbX6OT3UXt5
	 3IutqpZeKOotZySVJ8bp7+A4K2r0A1zvDhr3jVbUIrrrWXoKTrl+1zf2vVf7bg0HsW
	 dGiytTL4Mq75w==
Date: Wed, 29 May 2024 11:50:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Boris Pismenny <borisp@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, gal@nvidia.com, cratiu@nvidia.com,
 rrameshbabu@nvidia.com, steffen.klassert@secunet.com, tariqt@nvidia.com,
 jgg@nvidia.com
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
Message-ID: <20240529115032.48d103eb@kernel.org>
In-Reply-To: <3da2a55d-bb82-47ff-b798-ca28bafd7a7d@nvidia.com>
References: <20240510030435.120935-1-kuba@kernel.org>
	<3da2a55d-bb82-47ff-b798-ca28bafd7a7d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 11:16:12 +0200 Boris Pismenny wrote:
> Thank you for doing this. I agree that TLS-like socket support
> is a main use-case. I'd like to hear what you think on a few
> other use-cases that I think should be considered as well
> since it may be difficult to add them as an afterthought:
> - Tunnel mode. What are your plans for tunnel mode? Clearly it
> is different from the current approach in some aspects, for
> example, no sockets will be involved.

The drivers should only decap for known L4 protos, I think that's
the only catch when we add tunnel support. Otherwise it should be
fairly straightforward. Open a UDP socket in the kernel. Get a key
+ SPI using existing ops. Demux within the UDP socket using SPI.

> - RDMA. The ultra ethernet group has mentioned RDMA encryption
> using PSP. Do you think that RDMA verbs will support PSP in
> a similar manner to sockets? i.e., using netlink to pass
> parameters to the device and linking QPs to PSP SAs?
> - Virtualization. How does PSP work from a VM? is the key
> shared with the hypervisor or is it private per-VM?

Depends on the deployment and security model, really, but I'd
expect the device key is shared, hypervisor is responsible for
rotations, and mediates all key ops from the guests.

> and what about containers?

I tried to apply some of the lessons learned from TLS offload and made
the "PSP device" a separate object. This should make it easy to
"forward" the offload to software/container netdevs.

