Return-Path: <netdev+bounces-153407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353CA9F7DBD
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E28B1894254
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14410225792;
	Thu, 19 Dec 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7oATp3Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363A225780
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621124; cv=none; b=Q/k423N3P1VLZtVPkb3rH8v3Jvguolo5tJqTboYdg72OUJpxJNYOLeYptbLgaKrtE9eNURqlPgkD05Fluc24j1xs12EmL59HDwqrEzp+Yy3STOPfDfpPXAfD/xJUZgKCtw4smX91LUE0E1mp+/l6w2usTcA9WX7339KwF+K7Nbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621124; c=relaxed/simple;
	bh=Q96ikkXx5H1v85tIMZfMFL+VBMwaxkRuI18KRto2sZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpRIhqHW46AmA3hsxTj9DEjnOFlj8nHskkbe0Lq/fqguhzFGmCiM5NrZbAzKYIEHgGPwf8Eqi3RScIVAM8S0k8a7LRiqwJFHkrt5O/JBohMZt4PEiDB6UZIqejA/fp3A2uHdyeXHIa67Ws2IVc8An7LF3OqOd3Jgru98yj1k58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7oATp3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134EEC4CECE;
	Thu, 19 Dec 2024 15:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734621123;
	bh=Q96ikkXx5H1v85tIMZfMFL+VBMwaxkRuI18KRto2sZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7oATp3ZcL0FP19nz7M7exYxFCgD3jrJzov1AsE/Vu+JKwusY+2mgHidh4lKsRlVG
	 46TQaif+Dl2DOCLfWeTUJ8tjESYcVxMkqLvRyv6o7o459UU28EdGl/mWUAAQ6jJ/Dm
	 e3EzOv+Amoyarh0HnrhDhfx7IcmO+pzqGK4skWAhNM71GBuHypzuCfLxOR9ybScfX0
	 r/iKibFTBAKfltgmJrrhrggKbrH9+LvzezY90d/Wi+DwKsN06/7H0NHVJCs5H4l+p6
	 qV6lRGTArwvqUGUsV+FQgrptL2KthFgzGs5/e4rHPsZOHQMzm74GMSMM/FOfOZhC2i
	 Qz7x7D33/RglQ==
Date: Thu, 19 Dec 2024 07:12:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan
 <tariqt@nvidia.com>, <netdev@vger.kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Yevgeny Kliteynik
 <kliteyn@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next V3 04/11] net/mlx5: fs, add mlx5_fs_pool API
Message-ID: <20241219071202.777dab06@kernel.org>
In-Reply-To: <d8788869-51d6-45c8-9009-e72453cc381c@nvidia.com>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
	<20241218150949.1037752-5-tariqt@nvidia.com>
	<0c6d6368-85ab-4112-a423-828a51b703e1@intel.com>
	<d8788869-51d6-45c8-9009-e72453cc381c@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 14:30:41 +0200 Moshe Shemesh wrote:
> > Locally (say two lines above) your label name is obvious.
> > But please imagine it in the context of whole function, it is much
> > better to name labels after what they jump to (instead of what they
> > jump from). It is not only easier to reason about, but also more
> > future proof. I think Simon would agree.
> > I'm fine with keeping existing code as-is, but for new code, it's
> > always better to write it up to the best practices known.
>
> I tend to name labels according to what they jump from. Though if I see 
> on same function labels are used the other way I try to be consistent 
> with current code.
> I think there are pros and cons for both ways and both ways are used.
> I can change here, but is that kernel or netdev consensus ?

Yes, there's a consensus now. But I think since all mlx* code uses
the "jump source" naming mixing the two could lead to confusion for
your internal developers, and bugs. So I'd say up to you :(
-- 
Since Przemek found a real bug elsewhere:
pw-bot: cr

