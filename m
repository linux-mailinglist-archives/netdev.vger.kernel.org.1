Return-Path: <netdev+bounces-79081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2FB877C7E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D61C20506
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C671314291;
	Mon, 11 Mar 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImhaLKh/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275B14F86
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148805; cv=none; b=g51UaTZI3UHoZHoc9UszwXhusNmPseFHRLgjtWYqlD0MGY4von6WD+O6DxT1uWoExKt7myFfD0bV9x2lZfLg7Am/WaACPh1a0ObA742EkpRcIwZ9sGVD+2H9QgQwUbT4G0ZWesto4AUTIivvwhgObgkOpSOk7GXMCYN4u0mL8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148805; c=relaxed/simple;
	bh=1ZiMUTyyeo0Z2XlLdCasELZ6tHnvHUQMcSQALkw8vsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2PTw708lkDqQaGKOkTulariqVcddMY28xfNhiKxij09n4cqr6oFtQqBkwM+aLocBPfwbUTuI/oNXLZOmUiCWAmGmMpYTeRuu+9cUzJWTEVzYbwh1bfFjlUBXtfqCUqZy23xOdA2x4oD4X1xSxVHirMCEfYIf6tfXoXXug2GvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImhaLKh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3A1C433F1;
	Mon, 11 Mar 2024 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710148805;
	bh=1ZiMUTyyeo0Z2XlLdCasELZ6tHnvHUQMcSQALkw8vsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImhaLKh/sklgFpDP+QecQSNCvPQ60CMSmle7HMQ3ToNFo9JA6F8cptz9Y3t6bRthk
	 8XX9W6wU7r66lPdKO7mODntjvv/trk294ZxBo33Fio7ql6EzRiV3UlG8WhFpkLWoWo
	 16zovr9QkEAGfyQePrBVwI/poISCjfyQJvVf59unXuRmRQRM5l2yT++AvoyyMa85+A
	 KEUrvy5XaJPkAj0vyePj1DU5wRieHf4dbJ6E40Lf/hRrjSSa6Ya+qLYZMN+Y17xrqD
	 q531FugF7hD8z6TyPRYZX0uhXKl2xVPIQVwAojSCgejUOMGwZrIzUg5jz3ZVi49lH7
	 mrzagGp1QGVPQ==
Date: Mon, 11 Mar 2024 09:19:59 +0000
From: Simon Horman <horms@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com
Subject: Re: [PATCH net] devlink: Fix length of eswitch inline-mode
Message-ID: <20240311091959.GB24043@kernel.org>
References: <20240310164547.35219-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310164547.35219-1-witu@nvidia.com>

On Sun, Mar 10, 2024 at 06:45:47PM +0200, William Tu wrote:
> Set eswitch inline-mode to be u8, not u16. Otherwise, errors below
> 
> $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>   inline-mode network
>     Error: Attribute failed policy validation.
>     kernel answers: Numerical result out of rang
>     netlink: 'devlink': attribute type 26 has an invalid length.
> 
> Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
> Signed-off-by: William Tu <witu@nvidia.com>
> ---
> Or we can fix the iproute2 to use u16?

My understanding is that it was u8, prior to changes moving the
code to use specs, so I think that fixing the kernel to once again use u8
is appropriate.

Reviewed-by: Simon Horman <horms@kernel.org>

...

