Return-Path: <netdev+bounces-177085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F72CA6DCD3
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29128188C646
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A52620CD;
	Mon, 24 Mar 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ6J91Zr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEF2620C7;
	Mon, 24 Mar 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826079; cv=none; b=KpM7hsc/66Oba/ssKrHQYZdR85Wsww6mfz39f7qb5DzBMp4qq5uONKQBhwEOXjy79vIfpnawDWNC+aver8lPubtaBMPYMUjZb+o+HkIS+Jt0/bhOdmz1/2WKwEm/zEnjN6l0LYplr1d3EuQuwdH+xrFm59vt2vhIVSBo+UpyAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826079; c=relaxed/simple;
	bh=draAG8GfDmHMcX/XsjGWjVRvTRUqqLXrGbpf2rsAgKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyUi8PsLPnk7hqh8ATjIY922h80MY8d8KY+YuyfVoXLm2DdvuoXP0LLdt8J9Uf2uSxW7bsBsE2yQmY2ehreDnd9js9Ndlg/w71V+DKkzo3o5EoaXw0O18OYD/D0/VptYG3kAbPmfGdN2skhO2bcn2iE0zFm3nhwTuS9shN1TkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ6J91Zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709E4C4CEED;
	Mon, 24 Mar 2025 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826078;
	bh=draAG8GfDmHMcX/XsjGWjVRvTRUqqLXrGbpf2rsAgKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJ6J91ZrC7VMso5isoQYexPCAtmWubRMPoZ2XoMsY1K4/ECauDAJEaqaC5x7CU2y6
	 6uarbJdeb5/I1FmI0Ihgw7UYkWIo/GIcrAMVGY82NNMN/AxbbF8oLbC9qAepQjGZzS
	 4d647UfRupWxdRElE/XO8LDpVz5w/av5GS/feeIaTwN2iOBirv61tEdpv407mDYgvz
	 VkQTh8UdItcA3Fn4OLXbgm9C8cit22LxI6MXjKdVZg5YMkCtBPoJsu7zY2uXLDNRbM
	 ThePL59Oc+9lAJI67zGJoepVtQrmz+CI0j7fRwcqE3RvDFJ1XdmhZ2QzwM/zGJRneK
	 cruSOO9Gblk8A==
Date: Mon, 24 Mar 2025 14:21:15 +0000
From: Simon Horman <horms@kernel.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: isdn@linux-pingi.de, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com
Subject: Re: [PATCH] mISDN: hfcsusb: Optimize performance by replacing
 rw_lock with spinlock
Message-ID: <20250324142115.GF892515@horms.kernel.org>
References: <20250321172024.3372381-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321172024.3372381-1-eleanor15x@gmail.com>

On Sat, Mar 22, 2025 at 01:20:24AM +0800, Yu-Chun Lin wrote:
> The 'HFClock', an rwlock, is only used by writers, making it functionally
> equivalent to a spinlock.
> 
> According to Documentation/locking/spinlocks.rst:
> 
> "Reader-writer locks require more atomic memory operations than simple
> spinlocks. Unless the reader critical section is long, you are better
> off just using spinlocks."
> 
> Since read_lock() is never called, switching to a spinlock reduces
> overhead and improves efficiency.
> 
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> ---
> Build tested only, as I don't have the hardware. 
> Ensured all rw_lock -> spinlock conversions are complete, and replacing
> rw_lock with spinlock should always be safe.
> 
>  drivers/isdn/hardware/mISDN/hfcsusb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Hi Yu-Chun Lin,

Thanks for your patch.

Unfortunately I think it would be best to leave this rather old
and probably little used driver as-is in this regard unless there
is a demonstrable improvement on real hardware.

Otherwise the small risk of regression and overhead of driver
changes seems to outweigh the theoretical benefit.

-- 
pw-bot: deferred

