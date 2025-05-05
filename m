Return-Path: <netdev+bounces-187853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEEBAA9E67
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 23:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76EE7A4CF6
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 21:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C4427464E;
	Mon,  5 May 2025 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5WrmmUs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79D2741BD
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746481879; cv=none; b=tYr/SqxTw7GPxQa2dM3JdD+vbVyRS0GRfgErWdi6svHeW9bBXOpujud+jPnu+PgUxcrHWgcDEx5mEsMUxDUNqrf5HQ9qOYS8aVfIpq97YeUss0yY1cEbLwNDBl8qF+rykG6q52Z3Pg6Uu6PE1DMfLNYdzmj2TbDyfxLM7qPMrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746481879; c=relaxed/simple;
	bh=PtRbj4ojV5CQFGuyDkes8lXVdT6FWR/jknkbMuhPTVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL/HI6VW8UH9bYusNoKdPe8kqSN/Q+KcWKNvbOdLLxcnlOotXCH1I1okIiHxcd3nOs+AXSEBe+TeKfayCoVoy4yKDasT6yTsh4Ncu2zSCo1buVjzykmiPDP7lGv6RP6qc/60B0pKX9PcJmm99X+jd/lTZyLbdojVrjMWowFT1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5WrmmUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789AEC4CEE4;
	Mon,  5 May 2025 21:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746481878;
	bh=PtRbj4ojV5CQFGuyDkes8lXVdT6FWR/jknkbMuhPTVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5WrmmUsafCD2W5lU2oG5+TQN3nsFflM2BeINOMmZeGPAYfwCWTf2h7DbWBT7n0Ye
	 cjiI8I2EF4vkRGWWgiwupNaAZXtaR2Vd53boV35+bczz6Ul0TqMqK14tSU6jFtAVoj
	 DGCmikY2edeiyOydhU6vKhSIo4CpoQ5744wZ2jPbriIGBfviviTo2EuwoaOCXdjO27
	 xDWfiIjD7TWtjdinFG3wZQkhBGVNarhsjAw+yprHBfXeZ3k0Q/Q6akzIistV+0AUF6
	 rW0hq96Yzyfi+gxnjsGqFNqV6To1p5+w6kCyB4DOKteHxnD4hMEs/5mndPqqLb+6aO
	 WQbx/KGBf1ocg==
Date: Mon, 5 May 2025 15:51:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gustavo Padovan <gus@collabora.com>, Aurelien Aptel <aaptel@nvidia.com>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	netdev <netdev@vger.kernel.org>, sagi <sagi@grimberg.me>,
	hch <hch@lst.de>, axboe <axboe@fb.com>,
	chaitanyak <chaitanyak@nvidia.com>, davem <davem@davemloft.net>,
	"aurelien.aptel" <aurelien.aptel@gmail.com>,
	smalin <smalin@nvidia.com>, malin1024 <malin1024@gmail.com>,
	ogerlitz <ogerlitz@nvidia.com>, yorayz <yorayz@nvidia.com>,
	borisp <borisp@nvidia.com>, galshalom <galshalom@nvidia.com>,
	mgurtovoy <mgurtovoy@nvidia.com>, tariqt <tariqt@nvidia.com>,
	edumazet <edumazet@google.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
Message-ID: <aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
 <19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
 <20250505134334.28389275@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505134334.28389275@kernel.org>

On Mon, May 05, 2025 at 01:43:34PM -0700, Jakub Kicinski wrote:
> Looks like the tests passed? But we'll drop this from our PW, again.
> Christoph Hellwig was pushing back on the v27. We can't do anything
> with these until NVMe people are all happy.

FWIW, I believe Sagi is okay with this as he has reviewed or acked all
the patches. I am also okay with this, though I'm more or less neutral
on the whole since it's outside my scope, but the nvme parts look fine.
The new additions are isolated to hardware that provides these offloads,
so I'm not really concerned this is going to be a problem maintaining
with the existing nvme-tcp driver. I trust in Sagi on this one.

