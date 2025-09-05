Return-Path: <netdev+bounces-220352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF2EB45871
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 15:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FB1A43A8F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0109022FF22;
	Fri,  5 Sep 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZbS/3WD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853B1D86FF;
	Fri,  5 Sep 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077641; cv=none; b=NZwlOCI+gb0knAncw+vvLIpr8aSZKIGdDQyNM+jl2Iz7zZZVDtLDoUth4HTFpmBheOkziNHPA6y36f6BsIM2NHu9b7ZFP/Bwcm1MF9a9n2WNffTdGs6djdq9tZsRaBjx4kD5nV3wnJFefADCj8ikvDllQaIrNSUyfvCCGSdWzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077641; c=relaxed/simple;
	bh=VgIsJYkgo7eZfkI5N4TxbO2fv4xkgz1j6BEUIRbuKdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnZYxK9yao6r04rFmy5sIuScYgaifJMxWhhrvXeTn9OO64701lC8SJzYEyhigizagWPhdxnSmt0ddCOFX1g3u5TqUHNbXcB7tlXmQzm995RBn3XQctHOHPwosHSBchnRuC+7toiBNsXEOJWeFGFqhHiwsOH2WbwgHb1UGOR890k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZbS/3WD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD17C4CEF1;
	Fri,  5 Sep 2025 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757077641;
	bh=VgIsJYkgo7eZfkI5N4TxbO2fv4xkgz1j6BEUIRbuKdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZbS/3WDDnlG6vbBRLlOfv/1LSAQLrtDBaifR1lSpDw0m6N269HWoehmf01dqKpNw
	 cmOBi4Es/tDyRbiw4sXQCOIA+wmvq//kbpMb5MWB+y8vGrFgcYwvYrbTGNnVk9Y4Di
	 ca1v7FN+95o99d6IrztwBxCWtfC4pyXoNaCugyEofvYw405y0N1YcaiWhBqvCxdQAm
	 adxUGjbM04Fl2SD7M+Td4QfcRZ233PntqnYasRRZFbfe+Zl+UERsWrM9251xsYsR5r
	 r+9J2P1SJHRn2ibk5BYTCjGoAt0spamOeGkeFiZ0qMEieZjkGPLmWk+xBxMXOCTG5R
	 968+7xKpbwI3A==
Date: Fri, 5 Sep 2025 14:07:16 +0100
From: Simon Horman <horms@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net] net: dev_ioctl: take ops lock in hwtstamp lower paths
Message-ID: <20250905130716.GC553991@horms.kernel.org>
References: <20250904182806.2329996-1-cjubran@nvidia.com>
 <20250904235155.7b2b3379@kmaincent-XPS-13-7390>
 <154e30fa-9465-4e4e-a1f4-410ef73c04cf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154e30fa-9465-4e4e-a1f4-410ef73c04cf@nvidia.com>

On Fri, Sep 05, 2025 at 08:35:37AM +0300, Carolina Jubran wrote:
> 
> On 05/09/2025 0:52, Kory Maincent wrote:
> > On Thu, 4 Sep 2025 21:28:06 +0300
> > Carolina Jubran <cjubran@nvidia.com> wrote:
> > 
> > > ndo hwtstamp callbacks are expected to run under the per-device ops
> > > lock. Make the lower get/set paths consistent with the rest of ndo
> > > invocations.
> > > 
> > > Kernel log:
> > > WARNING: CPU: 13 PID: 51364 at ./include/net/netdev_lock.h:70
> > > __netdev_update_features+0x4bd/0xe60 ...
> > > RIP: 0010:__netdev_update_features+0x4bd/0xe60
> > > ...
> > > Call Trace:
> > > <TASK>
> > > netdev_update_features+0x1f/0x60
> > > mlx5_hwtstamp_set+0x181/0x290 [mlx5_core]
> > > mlx5e_hwtstamp_set+0x19/0x30 [mlx5_core]
> > Where does these two functions come from? They are not mainline.
> > Else LGTM.
> 
> You are right, I hit this when I was working on another patch to
> convert the legacy ndo. I thought it would be nice to have the
> kernel log in the commit message.

Thanks Carolina,

I think it would be nice to note that in the commit message.
Kory's confusion seems reasonable as things stand.
And others may also be confused by it.

