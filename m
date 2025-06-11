Return-Path: <netdev+bounces-196403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8C8AD47D3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 03:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556D23A89A4
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B7E433B1;
	Wed, 11 Jun 2025 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ28WDl6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D058C8CE;
	Wed, 11 Jun 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605031; cv=none; b=uPBmNZJYcElOeiy2P6jSiaa8f2PrvsvEN8x5uPCKvHS0OqI16+5QG2MGQ/CcC4qfH8PlCcelCOaHApPrk1qmEsmddrdhuaby+U9pI2khlkh4flOGFn+e43G/vY7a0ZzFTe/XdNJVPnVkVnHrTKsceHpTPfaQxKjY8ZnqH+ueCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605031; c=relaxed/simple;
	bh=BDCf9UbwdWpGMgZtYBVVj+5jW5/DNFofhldRk0JItWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z63j+7JXNkke70wTr8+BLYyqitFXIBVkLVPa6OQqldsxwTZy39oWUCLGrL+GmNHlHWkC1NgUmhzKnYkwuJgsquK04DIHmUcmVKspaiHoaOLGsLVK/a46F4G6EzrxxHWZ9/rQcJsAY+TT0BDkQnz4qdM2+LvL3mZNBq7d3IWZB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ28WDl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C532DC4CEED;
	Wed, 11 Jun 2025 01:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749605030;
	bh=BDCf9UbwdWpGMgZtYBVVj+5jW5/DNFofhldRk0JItWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQ28WDl6A/e3hLBO5F7mI0CtoH36tVgmSSRBc4XsJPXGCrK5iRlsUWndw/plqw4SR
	 9Ilmbvh0+zUoCdpTSihvL47h8JWecyb+Jd/98Ox7vuVe5ohuMR6/ect+uGzX/5dumH
	 3qyrQuegAev8p75VURnnE6TOA8Mr8ZaIDgfyS0Mt9iRnQkoxPhyBTlwK5JUQwEa5t0
	 iu2U5ERIaZx4phsCmlEx841570CRDbkMPEEJddcwvCidmIBKWoyp8uiJ60Z9F4fMEc
	 fnZGDCQV4cYdUkp12BSIR1lrtduslfs1OoQTOcidWTBe5/Romup04eA3rkL1MBvVFl
	 OJZILGwtZ3tDQ==
Date: Tue, 10 Jun 2025 18:23:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, ziweixiao@google.com, pkaligineedi@google.com,
 yyd@google.com, joshwash@google.com, shailend@google.com,
 linux@treblig.org, thostet@google.com, jfraker@google.com,
 richardcochran@gmail.com, jdamato@fastly.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/8] gve: Add Rx HW timestamping support
Message-ID: <20250610182348.03069023@kernel.org>
In-Reply-To: <20250609184029.2634345-1-hramamurthy@google.com>
References: <20250609184029.2634345-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 18:40:21 +0000 Harshitha Ramamurthy wrote:
> This patch series add the support of Rx HW timestamping, which sends
> adminq commands periodically to the device for clock synchronization with
> the nic.

IIUC:
 - the driver will only register the PHC if timestamping is enabled
   (and unregister it when disabled),
 - there is no way to read the PHC from user space other than via
   packet timestamps,
 - the ethtool API does not report which PHC is associated with the
   NIC, presumably because the PHC is useless to the user space.

Do I understand that correctly? It's pretty unusual. Why not let user
read the clock?

Why unregister the PHC? I understand that you may want to cancel 
the quite aggressive timestamp refresh work, but why kill the whole
clock... Perhaps ptp_cancel_worker_sync() didn't exist when you wrote
this code?

