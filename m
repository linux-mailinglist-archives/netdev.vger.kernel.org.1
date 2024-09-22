Return-Path: <netdev+bounces-129190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8816F97E290
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 18:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996902812A6
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9015E90;
	Sun, 22 Sep 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4YgRILk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4826AED;
	Sun, 22 Sep 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024204; cv=none; b=Km8cXPrx/EP0v7wpE1+tRX8ALzo0uKAChWdQM0TG5lsfPTwQv+66PsHvRl61JN3t5cyNJzaIMF+0Zd/ZqzSmcojJJpG9pSX1T2LnVW7HhIjX543gTqG9O/4V5u0hsdFhyFDQ4XyIwEnEyd8FsASRtcnW/ApVOHqvJLUBXbVKaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024204; c=relaxed/simple;
	bh=IzUiiBWxKOEoxrsutv2RysTy/iP/OHwPa08dPre7tQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq3cWWlQX8LsfIiJJD+Y3MA6F5hJOHgoeUC3AwWchHSdeh3rn5olcDmKXOV0NcNCRaTN0g71geHFENi8welwtl5itVLJh7kooMwfNkmqOqx8FvSiKDc3KjZPMwBRRQSjQeWlkVZrFs34PAm6PaeXUdIallCE2wnThBTgM2WKxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4YgRILk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AE3C4CEC3;
	Sun, 22 Sep 2024 16:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727024203;
	bh=IzUiiBWxKOEoxrsutv2RysTy/iP/OHwPa08dPre7tQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4YgRILk12OshWT6BnrLKMqHDUe3Lx64bSH519hGw6a7t7JDwI4sg7P8a1NX1tN93
	 bzCjrvaFzvobs/I+k+DScvkFIyCobfOCXWEyUyFNGWL0pTdexv2hO//0YNqjnUUfEN
	 UVCt/QCY9w0IIxsBpkhZkT0Z45S06+4BrPACZ4tJVBKFeAhn8l8i52LDeuAanK+X+d
	 xT30buhmoOFV+SoPTGjtA5NKA/kut0lO721Fet6CB35nKA7UgrLdxBrVIuCYZZ+Noz
	 SQPXAartD/M4n8gNubeSeSdsjCXvMIClxRL8v7YXUeGFnliuWsoENwgovMXFCsdx4n
	 B63hxDr1g2sxg==
Date: Sun, 22 Sep 2024 17:56:38 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Himanshu Madhani <himanshu.madhani@qlogic.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shahed Shaikh <shshaikh@marvell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Manish Chopra <manish.chopra@qlogic.com>
Subject: Re: [PATCH] qlcnic: Use common error handling code in four functions
Message-ID: <20240922165638.GB3426578@kernel.org>
References: <7c98349a-bfa5-409b-847e-ed8439e80afd@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c98349a-bfa5-409b-847e-ed8439e80afd@web.de>

On Thu, Sep 19, 2024 at 09:50:13PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 19 Sep 2024 21:30:45 +0200
> 
> Add jump targets so that a bit of exception handling can be better reused
> at the end of four function implementations.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hi Markus,

This is an old driver, that doesn't appear to have been under active
development for quite some time. Unless there is a way to exercise these
changes I don't think that clean-ups of this nature are worth the risk of
regressions they might introduce.

If we can see bugs in error paths, let's fix them.
Else, let's leave them be.

-- 
pw-bot: rejected

