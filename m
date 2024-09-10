Return-Path: <netdev+bounces-126992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D89738FB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EE6288300
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5EF19415E;
	Tue, 10 Sep 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwLlzpIi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38013194151
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975895; cv=none; b=SasFF3nZf1zKG0eDdL7zb2iv+YUpp/lMLVPqHHcnTez+eeHV37mMhk2Jl/VwrV0sakkJgCveljiSG8oF1aSnjiKbQt1q/yPRQ2C9uBOOITD1NBf22d2B4W/j5Z6l2JXoOMrc+m5h2LEOdIb3AC596X0EQW7L0wWtYnj4WaGmYP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975895; c=relaxed/simple;
	bh=eaLqeAInK6K3654dZeMhVnccjfoZ1sMA2x4ltUHXf3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJbxU2Hjb49VI3RUT7n2QJ+ulM5Y7/70SF1xPHoH2fN1wF+rSNHPf2vWBb0Ivht/FFRwv2ZTYY3D77x+P6eErAEJ+ScfsrqM47Y/H+XvRbdGUS4dW8+OF+uXhSJUz0PjWE+reY1g64xAxmOIcDMObH+ncheitjbYlB8Fql8qFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwLlzpIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AC9C4CEC3;
	Tue, 10 Sep 2024 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725975894;
	bh=eaLqeAInK6K3654dZeMhVnccjfoZ1sMA2x4ltUHXf3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IwLlzpIipUu0Lty8wC8U4QUYv3whR9KN+ccgQE23hRCaCVhi9FClX6NtRa/zkSQ6a
	 HZZRuJweOBela8XsGZh0c9gJozXu8jmnP7y+K+HpHz3iH8kqRh/j5yvZGw0xo/zJtc
	 +GN36+forZFsd6EWxYmCVq6bm8ufUoWhCTQJwAw4Izmqchuw7iVW2tjqT9/PG94/6x
	 nBod3Dv4sijGDo6xNURMqhTdhtxZfQGoqVvt8q0GiMPVwCr4WbmmsXWB/WeiC77kKl
	 4Xy2mPCAeROiGi58hKUiX+rYuIx7UgXa794QrXoz2i3CFx91XrQmcN6GBBeZO0AbXP
	 7s8zqY4SCfY1g==
Date: Tue, 10 Sep 2024 14:44:51 +0100
From: Simon Horman <horms@kernel.org>
To: Rao Shoaib <Rao.Shoaib@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kuniyu@amazon.com, netdev@vger.kernel.org
Subject: Re: [PATCH v1] Remove zero length skb's when enqueuing new OOB
Message-ID: <20240910134451.GD572255@kernel.org>
References: <20240910002854.264192-1-Rao.Shoaib@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910002854.264192-1-Rao.Shoaib@oracle.com>

On Mon, Sep 09, 2024 at 05:28:54PM -0700, Rao Shoaib wrote:
> 13:03 Recent tests show that AF_UNIX socket code does not handle
> the following sequence properly
> 
> Send OOB
> Read OOB
> Send OOB
> Read (Without OOB flag)
> 
> The last read returns the OOB byte, which is incorrect.
> A following read with OOB flag returns EFAULT, which is also incorrect.
> 
> In AF_UNIX, OOB byte is stored in a single skb, a pointer to the
> skb is stored in the linux socket (oob_skb) and the skb is linked
> in the socket's receive queue. Obviously, there are two refcnts on
> the skb.
> 
> If the byte is read as an OOB, there will be no remaining data and
> regular read frees the skb in managge_oob() and moves to the next skb.
> The bug was that the next skb could be an OOB byte, but the code did
> not check that which resulted in a regular read, receiving the OOB byte.
> 
> This patch adds code check the next skb obtained when a zero
> length skb is freed.
> 
> The patch also adds code to check and remove an skb in front
> of about to be added OOB if it is a zero length skb.
> 
> The cause of the last EFAULT was that the OOB byte had already been read
> by the regular read but oob_skb was not cleared. This resulted in
> __skb_datagram_iter() receiving a zero length skb to copy a byte from.
> So EFAULT was returned.
> 
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>

Hi Rao,

This is not a proper review, I will leave that to Iwashima-san and others.

But I would like to note that as a fix for net it needs to be annotated as
such.

	Subject: [PATCH net v1] ...

Unfortunately while the patch applies to net it does not apply to net-next.
But without the above annotation the CI did not know to apply the patch to
net. So the CI can't process this patch.

I suggest posting a v2, targeted at net, after waiting for a review from
Iwashima-san and others.

-- 
pw-bot: cr

