Return-Path: <netdev+bounces-159799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33697A16F6A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506B23A784A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E811E98F9;
	Mon, 20 Jan 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="npgKw/Oa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9291E8840;
	Mon, 20 Jan 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387697; cv=none; b=k5DpfihLwcpynbWasRizq1gax7sI3Y15z9eDyPwEoM4M3h+Haas7lKtRRBGW0X2WSR8a/w24QdNuEis97nXNFp8nm7b30C0Ih1sq7iIptCtNMRQkc/KtOSRMWDXsgmRvkX5r+FC4ziRB8cv9bchAPUO1eCx6dPIojPPwLNQM6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387697; c=relaxed/simple;
	bh=va7n5tdBhfpWZ7h5Ya5gf8tOwmqV2lw1cMVpN/89vS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD02v+e+oTaZhTQNaLI3NLH1oC+Uk8IdDnBH7F7MDZFZ1ki/6fsiHAkgzPwVzT0+nAc/33qMCPALh22vajTt/KQ4p5PyymHb7lOHXMvrE59ZC9GzLa/daTGkMpzr2wJiUYy4volaGqKac8iOvjzkpYo0ZmFK57rXK26/NGymWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=npgKw/Oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455ADC4CEDD;
	Mon, 20 Jan 2025 15:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737387696;
	bh=va7n5tdBhfpWZ7h5Ya5gf8tOwmqV2lw1cMVpN/89vS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npgKw/Oa/AmszLwL4n0XYQF4JtbYc320KzeLf24TE/l21DnhH9mwZlWiq2JBeaWYG
	 RSBjJnTOUmtjbEHfY9u20OT5ga0VOlAE6ZrTQx0cX0bVIF8VgcCrseTm/n9ZtHZp/b
	 1x9iCkMMx+hIsKKLrvQn5S6fjy/3YUbDIYnB1p5A=
Date: Mon, 20 Jan 2025 16:41:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com, davem@davemloft.net, kuba@kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10-v5.15] Bluetooth: RFCOMM: Fix not validating
 setsockopt user input
Message-ID: <2025012010-manager-dreamlike-b5c1@gregkh>
References: <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com>

On Mon, Jan 20, 2025 at 06:46:47AM +0000, Keerthana K wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [ Upstream commit a97de7bff13b1cc825c1b1344eaed8d6c2d3e695 ]
> 
> syzbot reported rfcomm_sock_setsockopt_old() is copying data without
> checking user input length.
> 
> BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset
> include/linux/sockptr.h:49 [inline]
> BUG: KASAN: slab-out-of-bounds in copy_from_sockptr
> include/linux/sockptr.h:55 [inline]
> BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old
> net/bluetooth/rfcomm/sock.c:632 [inline]
> BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70
> net/bluetooth/rfcomm/sock.c:673
> Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064
> 
> Fixes: 9f2c8a03fbb3 ("Bluetooth: Replace RFCOMM link mode with security level")
> Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM connection setup")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
> ---
>  net/bluetooth/rfcomm/sock.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

This breaks the build on 5.15.y systems, did you test it?

I'm dropping both patches now, please be more careful.

greg k-h

