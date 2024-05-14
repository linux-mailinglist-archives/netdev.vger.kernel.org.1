Return-Path: <netdev+bounces-96371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 970E18C57B6
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C08A1F22851
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251511448E4;
	Tue, 14 May 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxAaiHyq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31FF6D1A7
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695862; cv=none; b=CUuv9Cy7lqhWY60rM2tBObFFgkyM49HUG+iF5p3PrHyILsrEQ4UrKEk28Fnz17q738vc9N8KgQa4CA4NTtSo3OJuBgUB4B6iccKK+E8wLDvw6NYpetDIHs1II3rz9qcmMb2QuyQw1bvYG9u7tuYQBtxF1RtEEVOqU7HMgDMmhBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695862; c=relaxed/simple;
	bh=jjVOh6+7U4byGkHWRXe+pTFO9pOTWWYdHCIOSrdporY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CreXcd+Frtfzz8uugcWhkvyeW2WCV2b3jAXG+3s+q0krSj2XRVo108j49nDy2JZcpm9gZZGeeZKVAdBAC7DoJpPxt/wOEgZ5bbIemGvmxgIxtzPLpaNw5xlG4b5LarzFMXDHqXRL4Kf9GBWdCPRHCMFXUKPfaa3KSUiw7J0Bc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxAaiHyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9D2C2BD10;
	Tue, 14 May 2024 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695861;
	bh=jjVOh6+7U4byGkHWRXe+pTFO9pOTWWYdHCIOSrdporY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CxAaiHyqnTx+zbJ18g8MaQyRW+8QBdVG2zhvufX6tMyADbX1vDVLDDtFnrd4fltVH
	 XQSdjs9WzxUIBM8WqSFkHuKtDOA27qq+Kz7nCLP9peXzSpXLIydoMVxm/9flKxpAc8
	 p0oFt6bWfHTQwVHYrKuEIjupPkLdM2rI8wzNG/mCQau56AtFX+M2CYA49/MJSwkHST
	 77pRwG6viUi08DoVrBIJ5iZE0o0BvtKPjKUjScb95B+sXm8hXG3q984jiwlPZxGuxN
	 WjS2U018LhTWN8pykiFjNCxCmkC1nwJekyK8f9yl9W61KEmPmM0wIYvy6ujt6Nbocv
	 eS9EbqeeSYNVw==
Date: Tue, 14 May 2024 07:11:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>, David Miller
 <davem@davemloft.net>, Realtek linux nic maintainers
 <nic_swsd@realtek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for
 GRO-scheduled NAPI
Message-ID: <20240514071100.70fcca3e@kernel.org>
In-Reply-To: <CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
	<ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
	<CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
	<e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
	<CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 13:05:55 +0200 Eric Dumazet wrote:
> > napi_schedule()         // we disabled interrupts
> > napi_poll()             // we polled < budget frames
> > napi_complete_done()    // reenable the interrupts, no repoll
> >   hrtimer_start()       // GRO flush is queued
> >     napi_schedule()
> >       napi_poll()       // GRO flush, BUT interrupts are enabled

I thought the bug is because of a race with disable.
But there's already a synchronize_net() after disable, so NAPI poll
must fully exit before we mask in rtl8169_cleanup().

If the bug is double-enable you describe the fix is just making 
the race window smaller. But I don't think that's the bug.

BTW why are events only acked in rtl8169_interrupt() and not
rtl8169_poll()? 

