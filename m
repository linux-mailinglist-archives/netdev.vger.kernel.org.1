Return-Path: <netdev+bounces-186541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1746DA9F8D6
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1278D3ADCE4
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4809126A0CC;
	Mon, 28 Apr 2025 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwQ/uJir"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7221B040D;
	Mon, 28 Apr 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865985; cv=none; b=K1iWMCwJ+jg4TyZPIcYt84mAE42nXwzRKHa1NEunx51rQmvTFzxvtZ50DU5Nza5GRnS152RL2ZozqFlnoKSoFblKt5igvuVKhgR2k8NFvji/sxkUXtJLvwUD6roYpOCl6fRTvBhYQTlEFtV4ihv71qY+ODZ4EOWpQd8sk2wnrjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865985; c=relaxed/simple;
	bh=eg2rhi0L3VMr8m4UZ0QPZtf2aVXg+cv9p7DYcqzOc+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG16IwkPMQW/itdsSV1r5oYXTwDrQmPNBB9NEk6cMWwPeybU7+TRo//moPbKgWEdP7m4FMYV8yxzF/J3bE5zicCvblqXvecZq5XM19mCxRWI+BvsTvSrUpfINsf0y1X4teZ1n5jjU1S0/nUNHJS4HrdxaLEzLyRXRRNTYlkjQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwQ/uJir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D976EC4CEE4;
	Mon, 28 Apr 2025 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865984;
	bh=eg2rhi0L3VMr8m4UZ0QPZtf2aVXg+cv9p7DYcqzOc+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwQ/uJirTeuEwbzEq35HzL0lhukH2fGVnWgA0xvyKMAKApCs7eQKnUgIHU7VWTM1z
	 Z7clnXZlmMDwtZVmyO5DHHqq9YcbhMqttevow3Q+agRCh5lsKO3u8mw3q9eYpJs7/1
	 onMgQ28y7+7Un/zt0I1LGwFSuAJ8nYmQnyBtVDbc37L/ZwKqJgqCfzXjPhtarXMU7+
	 4EVngi8i1xpiiQy5R41NB50pKGpWYG52jGgdB+rn+IHxIXamDzJF8yp1C9M8NNeuJP
	 3OOwNXp441BywuQ9SVRWqe+AvMBIvUUX4Km14gQ6g8GwKPkwAX9VC36pxB0ynHFKW3
	 oKyMJRYdrFMdQ==
Date: Mon, 28 Apr 2025 19:46:19 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: shiming.cheng@mediatek.com, angelogioacchino.delregno@collabora.com,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	jibin.zhang@mediatek.com, kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] net: use inet_twsk_put() when sk_state is
 TCP_TIME_WAIT
Message-ID: <20250428184619.GH3339421@horms.kernel.org>
References: <20250425123354.29254-1-shiming.cheng@mediatek.com>
 <20250425203624.43634-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425203624.43634-1-kuniyu@amazon.com>

On Fri, Apr 25, 2025 at 01:34:08PM -0700, Kuniyuki Iwashima wrote:

...

> From: Shiming Cheng <shiming.cheng@mediatek.com>
> Date: Fri, 25 Apr 2025 20:33:48 +0800
> > From: Jibin Zhang <jibin.zhang@mediatek.com>

...


> > Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
> 
> I guess the sender's SOB tag is also needed here when the author
> is different ?

Yes, I think so too.

...

