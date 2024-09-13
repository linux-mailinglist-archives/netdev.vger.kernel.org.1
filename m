Return-Path: <netdev+bounces-127977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6CD9775EE
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656501F21D1A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 00:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B13376;
	Fri, 13 Sep 2024 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7KVMJB1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D792173
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726186455; cv=none; b=La9BK+hcvElme+EfExHU8aQDrPDIYgEJ1sO33eSzCPikyQru5tpcmAKnpGJp1yE6uuiV7nryfYphuDt47Vr/Bzb4ULKIz9AgL9bZbZFPo3Tv3FqNry9t+VAqFBr2EPrJ7lWyx3NH+QYXpFf3RLriUYiD/zi6qFOczzptV/YNJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726186455; c=relaxed/simple;
	bh=T9D80QRxOUV0Wpvp6PJEtGFs2vB+D5xizHHn7BtqsLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMMklmJccTFG+PbDVD/c2uH6I4n3Qc2osGZYeTaNiUrZ2JPat8LrrvSXb0gxEDse7nMw3hUUbKKgtyrMWun6GtpOr4lvrP/Jwgc6dcqda2EYVTRq0bujLw27ul3oVUbiV4JEgWYSWejmOZpwYjRad4VI8YX7u6UZ/HX7Vm73SxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7KVMJB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EDDC4CEC3;
	Fri, 13 Sep 2024 00:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726186454;
	bh=T9D80QRxOUV0Wpvp6PJEtGFs2vB+D5xizHHn7BtqsLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T7KVMJB1hONslgCXmZF30WpbVhJQbpNh3lQmeFTpyGSDnpv11nX+BGmSX11XOTgSA
	 KXJ6vQczTrqtZBGLkXvhyfPFSsPONA91+5hOfMBwMqLA0aA+R8DjaxvSzsvRFOzfF2
	 I4tP879uPqWvpcLo/UWFsoFB/iUQA5gpfujuzn4WDy2aeruriXR3CnRypKBwDsuEki
	 DuFTDQ4G0uddXOE89TdFfCJyl5UrfBduj2mwuQv1oJflr+T6a8kl2s9Cb1aCB+2dPH
	 4/I8GoqWCahrXh6XbpD9kkNpdMZOqf3wR8f8ggq9C0PNjd2eGjCzx01lYkZ9bpN9dk
	 V5xbrG9TZQurQ==
Date: Thu, 12 Sep 2024 17:14:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net 0/2] net: hsr: Use the seqnr lock for frames
 received via interlink port.
Message-ID: <20240912171413.4a81ab12@kernel.org>
In-Reply-To: <20240912065155.AyiTp0bn@linutronix.de>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
	<20240911155324.79802853@kernel.org>
	<20240912065155.AyiTp0bn@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 08:51:55 +0200 Sebastian Andrzej Siewior wrote:
> > The fix doesn't look super urgent and with a repost it won't have
> > time to get into tomorrow's PR with fixes. So I just pushed them
> > both into net-next.  
> 
> I just noticed that you applied

Yeah, the plural "you", but still my bad for not putting two
and two together :S

>    b3c9e65eb2272 ("net: hsr: remove seqnr_lock")
> 
> to net. Patch 1/2 should replace that one and clashes with this one now.
> I tried to explain that removing the lock and making it atomic can break
> things again.
> Should I send a revert of b3c9e65eb2272 to net?

I have a potentially very stupid plan to squash the revert into 
the cross merge..

