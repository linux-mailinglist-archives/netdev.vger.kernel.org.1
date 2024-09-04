Return-Path: <netdev+bounces-125017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FED96B984
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F731C2120F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4311865F0;
	Wed,  4 Sep 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ5TR0kN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D5126C01;
	Wed,  4 Sep 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447565; cv=none; b=sJjTai0EiI+qzQXGnp/02r761LtOYojWlN4iEL8JpRX8e1aAG3d3fYKOxpskH30JxlHiWXXMk6HThpl6CLv5ntj15VBCJ1TB5wzy+nP0UB58nVIEosZmAlZOyzEaq9kI/GHhkd9+0j8vqBk29Lzs/Zd04IQ8A8VNx2h7kzI8MVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447565; c=relaxed/simple;
	bh=lTxFiJg70RiOGvJCTBWPygBgjRZ/GyIOa86pkD+fyKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy8nraie65D1mwKMy94Dj6/ZM6+NoWR45neLrjSbqrKP0BWfYEV9WvCyYqaa3/VFEuyPfXHm9wfWNZ3wdsbMZzPOlTNG3mVq6qzpH2U6S+jI0fcXxY08TgrwAvSc5ASM4ARfoZ9Jo0cJV+iL2bXrKEEIHFGKuuhVg+fMSDVs5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ5TR0kN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEB1C4CEC2;
	Wed,  4 Sep 2024 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447565;
	bh=lTxFiJg70RiOGvJCTBWPygBgjRZ/GyIOa86pkD+fyKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQ5TR0kNPf9bMpnKj8AexZb63BIaqsSFPLVlCMCtQTZS6r6QaDS4/asXkHOuB37pA
	 a4cslMNnRuM4Py2TUyvM6iOLfhNpVdGor4t/S0egYXwMHma08DUkebb407gSLH+yTX
	 ypW0erT4GAF7iZBZKGY1EDD1WeIu24Bj5uB1AY2xv0u81e+4vOQjYOadbjwpSltzNP
	 uipKtiPYS+7P0Kj7CngrCgNHl7GaAUT8sUUfnFyAK5FesJJDg7kpYx0y4svb/kD7HR
	 tmVcljYDDyCRwfGrOkVSemyT5cuThaLNKNO/+3QSpqX1MLHk8SM49KTC4Yl5jvEIF/
	 VjQF3heUU18Hw==
Date: Wed, 4 Sep 2024 11:59:20 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 3/9] net: netconsole: separate fragmented
 message handling in send_ext_msg
Message-ID: <20240904105920.GQ4792@kernel.org>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140757.2802765-4-leitao@debian.org>

On Tue, Sep 03, 2024 at 07:07:46AM -0700, Breno Leitao wrote:
> Following the previous change, where the non-fragmented case was moved
> to its own function, this update introduces a new function called
> send_msg_fragmented to specifically manage scenarios where message
> fragmentation is required.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Due to tooling the diff below seems to more verbose than the change
warrants. Perhaps some diff flags would alleviate this, but anyone viewing
the patch using git with default flags, would see what is below anyway.

So I wonder if you could consider moving send_msg_fragmented()
to above send_msg_no_fragmentation(). Locally this lead to an entirely
more reasonable diff to review.

I did review this change using that technique, and it looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

