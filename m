Return-Path: <netdev+bounces-156086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D83A04E48
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD576165E6C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE461DFD8;
	Wed,  8 Jan 2025 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS66PPhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713C20B20
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297447; cv=none; b=lwMXTvyxDCBBdakdpae+7b0C+YegZGRlVZCxQiYhTsdDUeNNKaLNZ2cm1qZlQopLXIv9ZynOv2v8QNzUkdTvqOTPdhQbQuUt9PXe+pAG2Yn2lxx9HjyS/Rz2IXihp6Ph4fBJX4mvXfXlIHuc2MGfoMDUiE09+PKYtiKaQSZxS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297447; c=relaxed/simple;
	bh=d9/V7hCzg3h+rqrhhkqMfGHEuhUw8gpGxETtLHU0TEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCx/EN74il4FKhMsNkfGwzJQFgQL/RtGJH7Kqah+Jni8nRxe+45GD2BHtbGvg1Rg2qiHTSDHeiH6q5g078DraV0mtHIxaENnvQwIHUlbOes/+sL5Ksp0itDrIMjRZhUV+IP7FfjnNC8g9Wgotg5nMHmLM/807O2gJuOtJRVaCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS66PPhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFCBC4CED6;
	Wed,  8 Jan 2025 00:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736297446;
	bh=d9/V7hCzg3h+rqrhhkqMfGHEuhUw8gpGxETtLHU0TEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AS66PPhiT0z/K+tvweiN18sme9odw3CoZS7c4xnrEKT9Ib4t4bMaWhcO3W81/M6Ym
	 b7UTQe933RZoKLLQmSEAdUYcvR7ll+Krk5I/sIJ0pDtAMBuJM6gIfCu7se3LvmBuo8
	 QK3JTXtutzZJGbh2Ap4ujfQmONX17/t5pXcn1rMG1c1U1sVSsrdpRPrLQnER29SmQU
	 HjDLiujfFu8meYQ/12LBrpbE7Xxw2RkH5wJ0qzFosgeyU5GuiWm/jnOc3SqeB0McAn
	 367NFg8SQtxhnGu1PJtfhTCp5pNC3YeBGR+tnCgMB34xuhbsytfyEJRW30eE4Nqa6K
	 FRlqrT4zvUSUw==
Date: Tue, 7 Jan 2025 16:50:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, sdf@fomichev.me, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next v2 7/8] netdevsim: add debugfs-triggered queue
 reset
Message-ID: <20250107165045.0fa3e761@kernel.org>
In-Reply-To: <CAHS8izNM-fMV-FZabhJGq6aAdExVGyT3GwUm3rfhnoFpKULiKQ@mail.gmail.com>
References: <20250107160846.2223263-1-kuba@kernel.org>
	<20250107160846.2223263-8-kuba@kernel.org>
	<CAHS8izNM-fMV-FZabhJGq6aAdExVGyT3GwUm3rfhnoFpKULiKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 15:00:29 -0800 Mina Almasry wrote:
> > +       if (queue >= ns->netdev->real_num_rx_queues) {
> > +               ret = -EINVAL;
> > +               goto exit_unlock;
> > +       }  
> 
> Is it correct that both these above checks are not inside of
> netdev_rx_queue_restart() itself? Or should we fix that?

Crossed my mind, too. But I didn't want to start futzing with
netdev_rx_queue_restart() based on just two callers. I hope
we'll get to a queue API based safe reset sooner rather than
later, and the driver needs will dedicate the final shape.

More concisely put - a debugfs hook in a test harness is not
a strong signal for whether the API is right.

