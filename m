Return-Path: <netdev+bounces-234232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61BC1DFFB
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CA918896AF
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B3E242D60;
	Thu, 30 Oct 2025 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrxLeXHL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1E23AB8E;
	Thu, 30 Oct 2025 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786738; cv=none; b=AHc93w7KAsJ/DcdS47kevA1/5Hmfb3RspzawRBbsj15tPbG1hlKciamPgWkgOyUAY/Ck5yzdqnO6VMkdHA2xRh1da/pslvZ46IYtiBw9cHSzNtlxyj+dbnoo/isJAC8SuEtzDGN/458aztWoT2o0HJC89mQsDbNHWueXsg3D7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786738; c=relaxed/simple;
	bh=YXalAHtpMKTJzA7WQ1LS2bM6wABz7S3b4hWv5jMe9mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LliIkL5XZtDY8D+zVLmKFtg0FnJXrE3KYJqSedJzO7stzmS1RML6FQA9uzZcUcXwTh2BUKnyomXLWJH3h5RR71wmEvDWy/z3n4WIMXzIEkGzoyA5ZRUBpuewMCo5hesOKdxOA2c7RWmyEEWXQq1e6dOsUeHClgoxIGISX+y8uaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrxLeXHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0F6C4CEF7;
	Thu, 30 Oct 2025 01:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761786737;
	bh=YXalAHtpMKTJzA7WQ1LS2bM6wABz7S3b4hWv5jMe9mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JrxLeXHLwno/hRcRY75a2HoYBaTrFwn9uLVs2wD0RGdmrNt7eYW2Zky7USbjMkCrV
	 LJ8xwTEB76CIWMJppRA9texVsRFtEOtTa4DfI7nR68kl/pAE2NWpRrX9xuUEYLmNhm
	 thtbNf9piBORYEf1hBmYG+C/m7WczRY3MI6tMddH30N2pWBKz0sbfVcTxFtl266AE2
	 r9hsy7zdtT1J5t//RBv6bHam6yaQjxAip3bGRdMKmAIJ3Ys3DSw1LnWPSGU7IOcrv6
	 L3Ug+IdYFXswe4uHNcVB6JX8wcR9vpnnfRktT/rAQLM2LX0j3X4rTqQbGbcf33LmYW
	 2P/+PXq1or/MQ==
Date: Wed, 29 Oct 2025 18:12:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas
 <noltari@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
Message-ID: <20251029181216.3f35f8ba@kernel.org>
In-Reply-To: <CAOiHx=nw-phPcRPRmHd6wJ5XksxXn9kRRoTuqH4JZeKHfxzD5A@mail.gmail.com>
References: <20251027194621.133301-1-jonas.gorski@gmail.com>
	<20251027211540.dnjanhdbolt5asxi@skbuf>
	<CAOiHx=nw-phPcRPRmHd6wJ5XksxXn9kRRoTuqH4JZeKHfxzD5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 11:15:23 +0100 Jonas Gorski wrote:
> > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> >
> > Sorry for dropping the ball on v1. To reply to your reply there,
> > https://lore.kernel.org/netdev/CAOiHx=mNnMJTnAN35D6=LPYVTQB+oEmedwqrkA6VRLRVi13Kjw@mail.gmail.com/
> > I hadn't realized that b53 sets ds->untag_bridge_pvid conditionally,
> > which makes any consolidation work in stable trees very complicated
> > (although still desirable in net-next).  
> 
> It's for some more obscure cases where we cannot use the Broadcom tag,
> like a switch where the CPU port isn't a management port but a normal
> port. I am not sure this really exists, but maybe Florian knows if
> there are any (still used) boards where this applies.
> 
> If not, I am more than happy to reject this path as -EINVAL instead of
> the current TAG_NONE with untag_bridge_pvid = true.

IIUC Vladimir is okay with the patch but I realized now that Florian 
is not even CCed here, and ack would be good. Adding him now. And we
should probably add a MAINTAINERS entry for tag_brcm to avoid this in
the future?

