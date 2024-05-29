Return-Path: <netdev+bounces-99190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FAE8D3FB7
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384C41F25B97
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B115B141;
	Wed, 29 May 2024 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb8VPDlo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089771B960
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015137; cv=none; b=AT0nbJt3fcesyMTbecIwVlcHY9BDdwBVBfkdSiYrbTP5Co5PIZrSwbTdIPbG+4EQhDFtddqSEavlAYkOw3u8nb0IzvQnKgB7WdeiR4XtFBSmcZR9HaLlhm5qnKRgVfocsED625SCHciCfaOxFLoGUBnLRGeel6BiZbWGIZqu+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015137; c=relaxed/simple;
	bh=gvANO/rjzqBb55bTxrlCrR5BIzXcgViG0wd3eS0YtK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txycjtnak3luYl6ZwNfBNx1sk27cFOIuOw2QxKye8ScVMkh8dGmmjohBcJZKkvfriL0Ti0RlK7FfBiDghWz2Cfjc3CEViHOzEH/GO4bIWa4yZqCQvs7iKsn/W4amuXlqW9YlfIxZZzdZ3aSmKV3xVsxWRWXo8j9PyMeWw7f39pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb8VPDlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A639C113CC;
	Wed, 29 May 2024 20:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717015136;
	bh=gvANO/rjzqBb55bTxrlCrR5BIzXcgViG0wd3eS0YtK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kb8VPDloladT5nFGfjM3hWU+0WcIhxqsS27TVnqU7O49ggMAK7pL0cZLm1oXJhi3N
	 HwS4ZLZSmIT/I3EJLtSW37KukfTu8cZ43ivNrmn2gawKF6dnpTnXWluyV6s4sgh9gF
	 3ZGnC+IblqiSMQl5DKV7J23J4a1nYrGc4yMUIvo5ZEc2gWupQNyDkLitakx6givQHy
	 Iafcb7mBWogxIyZSbk3Z3rDY4aeaJJhYpZVhkVKyOrmbctCidahInvYPVVeqJUgeYc
	 p0uaW4dTms72rh/hTJhdxWkCalVlkhKTB947ELSZRMSDJw3fkCK+JeBHBwkP9zuthV
	 fFULs9+OWZ0aQ==
Date: Wed, 29 May 2024 13:38:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Boris Pismenny <borisp@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, gal@nvidia.com, cratiu@nvidia.com,
 rrameshbabu@nvidia.com, steffen.klassert@secunet.com, tariqt@nvidia.com,
 jgg@nvidia.com
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
Message-ID: <20240529133855.57196164@kernel.org>
In-Reply-To: <b65723e8-aeec-4c4d-83b9-6119d5297f8f@nvidia.com>
References: <20240510030435.120935-1-kuba@kernel.org>
	<3da2a55d-bb82-47ff-b798-ca28bafd7a7d@nvidia.com>
	<20240529115032.48d103eb@kernel.org>
	<b65723e8-aeec-4c4d-83b9-6119d5297f8f@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 22:01:52 +0200 Boris Pismenny wrote:
> > The drivers should only decap for known L4 protos, I think that's
> > the only catch when we add tunnel support. Otherwise it should be
> > fairly straightforward. Open a UDP socket in the kernel. Get a key
> > + SPI using existing ops. Demux within the UDP socket using SPI.
> 
> IIUC, you refer to tunnel mode as if it offloads
> encryption alone while keeping headers intact. But,
> what I had in mind is a fully offloaded tunnel.
> This is called packet offload mode in IPsec,
> and with encryption such offloads rely on TC.

Do you see any challenge?

> > Depends on the deployment and security model, really, but I'd
> > expect the device key is shared, hypervisor is responsible for
> > rotations, and mediates all key ops from the guests.
> 
> I can imagine how this will work, but there are a few issues:
> - Guests may run out of Tx keys, but they can't initiate key
> rotation without affecting others. This fate sharing between
> VMs seems undesirable.
> - Unclear what sort of mediation is the hypervisor expected
> to provide: on the one hand, block a key rotation request and
> the requesting guest is denied service, on the other hand,
> allow key rotation and a guest may spam these requests to
> the hypervisor, which will also spam other VMs with
> notifications of key rotation.

I don't have much experience working with VMs, or a good understanding
of what mlx5 does internally. Without access to the details of even a
single device which does PSP - any comment I'd make would be too much
of a speculation for my taste :(

On the NFP I'm pretty sure we could have given every VM a separate
device key, no problem.

