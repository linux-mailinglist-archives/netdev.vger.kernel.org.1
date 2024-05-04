Return-Path: <netdev+bounces-93419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 754738BBA29
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 10:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA21AB214E1
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FB125DE;
	Sat,  4 May 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpBHayf1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3B8BF3;
	Sat,  4 May 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714812746; cv=none; b=ZsKWz2Uun8FpDcx14CB/3X8yscPVgayiqbm6BHguWEHplzAEPEEwoAc0e8ZvXrYfJ465Qg2uYxvWYw+BOSYTvUPiFTkihYv7/OewZX+gqxL93g8p6cy3SYjr0ie7cj5R3Bg1vtWyVx1iX07rdqPohiTD1an7I/C/LW122cAb+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714812746; c=relaxed/simple;
	bh=gjTbAWOHffRkjTY+E0llEHSkptTW2669uz+EGRUb2sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6mineg4pDaJdc/WWKF9/K/3Sf0HFmXcEEUGVy83k3u8a7eb7HVH6UeGLTMq76OVDWCvXg6onMv3mb3bUqyptw+Ciks/BPkhtS3OXQBsLxWysGAhVa1dprEc1pT0lpHeGsgrywjOpNOfSZSmPF2Z5z6YBdNdG+JwrctpgEXiUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpBHayf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43910C2BBFC;
	Sat,  4 May 2024 08:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714812745;
	bh=gjTbAWOHffRkjTY+E0llEHSkptTW2669uz+EGRUb2sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpBHayf1+JklxgG0+ht0+m7wIkS+WwDAOQpMFsX+ffl33mYn9cmGQ1td5UN9bmePv
	 yYmi7e8ZMyyqfzln0rP+5TmRpvXR+xJvRQXRRqT17NdBNDi2CC7wOpHiS0SkzAO/2G
	 EYvcng3eP4EvKIkLjbWxaZIizbstWSg5iVOPYb+et06JmeDFYLk74sgjF1xymi0ab2
	 yIOpz3+Itqg8GLYXrCaMLh5C8woEazLEnXa9RyD0yfuiqCnAoMQusneKuzdTCtBgxm
	 x7z0PY00arVg+/yUm3L65btuFxK/5TRCCpmJ5h3XLSfEw1bGWHc05MIAwAxwz1em+l
	 GvFnUCaEiXBcQ==
Date: Sat, 4 May 2024 09:52:20 +0100
From: Simon Horman <horms@kernel.org>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: microchip: lan743x: Reduce PTP timeout
 on HW failure
Message-ID: <20240504085220.GB3167983@kernel.org>
References: <20240502050300.38689-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502050300.38689-1-rengarajan.s@microchip.com>

On Thu, May 02, 2024 at 10:33:00AM +0530, Rengarajan S wrote:
> The PTP_CMD_CTL is a self clearing register which controls the PTP clock
> values. In the current implementation driver waits for a duration of 20
> sec in case of HW failure to clear the PTP_CMD_CTL register bit. This
> timeout of 20 sec is very long to recognize a HW failure, as it is
> typically cleared in one clock(<16ns). Hence reducing the timeout to 1 sec
> would be sufficient to conclude if there is any HW failure observed. The
> usleep_range will sleep somewhere between 1 msec to 20 msec for each
> iteration. By setting the PTP_CMD_CTL_TIMEOUT_CNT to 50 the max timeout
> is extended to 1 sec.
> 
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

