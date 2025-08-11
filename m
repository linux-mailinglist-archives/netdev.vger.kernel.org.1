Return-Path: <netdev+bounces-212663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DBDB21986
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF481A21A14
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D722DA08;
	Mon, 11 Aug 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="F88HrC8q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90E4A21
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956092; cv=none; b=ooY1Vo1CV+jPPFcCnPjVb4RxDDeXU6hNBlomBJCYIFTWeR/Nc5IZ5QWYmGMYU09yuFGIUKEjZlVKvRhKs4hFXk1Mh0gax+GN48UnLOgI4Kx5jx21bT+x07/XTT9py/WuZ3MszU5iL8ZU6K2AiblidKiJSSp0wIyHM7Sc2pMr0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956092; c=relaxed/simple;
	bh=QHdGsbsGsMTF9ct+jFXXWmU25H4aBw6ecPoHa7EZZqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGfKvTN5eFFiiWZ22veI3i/MkePLYPFZ/6RJt/pvb6oCU5rlky9FfYj7oJhKVVKDFlZwNVjdZ2xp6urNQxWIR1hlsEFyzV9ueG/49wMjf+/uvEHQ/x8QEsJNGp0ij8+L/+1+Xs2IhgR8zaJLXJt1nQb7ZPOStu6x1otYgCIYYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=F88HrC8q; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4255b4d8f9so3279128a12.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754956090; x=1755560890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4XRSLXmEMw0woCxwm1Fun/oPeKwzB3yukJjNW3UI7g=;
        b=F88HrC8qUdQrxXC3tvFj9XjWPrV3p0qekcsK1I5otUb1UHxHK3AoN7Em0+ZGXxgbUz
         36mPhdmB/m0zJivW2oGuzfyuxs9+28QdHS5tL3gr7A3Wph+rArow2Vmlh1rwaxGhnWAN
         M60XkxpV8xjRHT9xh/g2jvYDHC/wvTEx2Y/d5rWLsAS+CHudi9L3ud3bLCD6TPsBO97W
         RP3LF3pxP57MRbbl/Lq4aE3FpkwF7C18g51OJ5wzr3gs71zNMsr/43ioYViVmIkkhx4c
         AKEiYUyaoB1GWf+IcbywFys3y8IZYZfdcHbj0dRSyMNXz0T2E8DrNcf6QeCwL5wU6Tfw
         NinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754956090; x=1755560890;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4XRSLXmEMw0woCxwm1Fun/oPeKwzB3yukJjNW3UI7g=;
        b=PrOAWx+q9dpfI2Dh4hB6fB6NHG+7H3x9J5nV/jptcKN4+SLvEqJSD/DxU8LZN5Ilxb
         A4rJn5ZFqkCR7FNqKCvSg9TrVtreHF7wl97Vy7Lmalm0JrbN9cdYRCb2Z+dR6h3Q8FlM
         eHihMhwTKa01LaHngwBGaU8ar3NuW1hAnTwpDIUgv4S9nkdTtC9eG50JN3/xYjU6+VHA
         3F0kOq7AonIo/r3pM/a8F5wk8XBJpOVdECFhmJKndn2VZYfO59bcJW+7JQUX1aBt6avp
         mfjiGQegxTkYKlebEKKM9n8of3R1H1WjjzjNoqmP9jfG7Q6HV0bZla5UGZB+QrmI1cvB
         3Vxg==
X-Forwarded-Encrypted: i=1; AJvYcCVgqpzhxqA9mI8cxXRGyW7bNF+qyBqhv/Z4IKUGlRrku/GyyXJkygXRB92WQbmK/hhx7ee/N14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EVsrkGgSevxl4YZCIUwfT1OZk+wsFbKdIeH+lBP+wsVjh+Dd
	B7gdKKecOMFAYZYxz7n7jDnFUSZh7RMcxGN6rx1swjekS6hPTl7jxTK/AbtmbF2/Qo4=
X-Gm-Gg: ASbGncua04VQp3ZE9+rcv/scoU3R91siwep7UPYonV3nRg9dJn9rMH/kBbfdmAlgPlm
	mJXccOC3jgF1j763e5IM9v4zd/Dzm53EjBAjKEH/PqUE683+HwygltpBxvADcPn9Ubjxvt8C5aO
	85fzJJW5lmdwfyKeSJ8PVyETnm2Okt4/3ZL/NZ+6rkasQTvWB2PAdyQuUT9thxZW3HqW4XM02+c
	NV2a7FfubZdrRnwUzDIHSjM9zYYtvioAl5qHunv3E2orscXPxBC0o5z7tCpdcoCDXiitGRjLDUw
	nb1PUm5aH5Upwjc24uGSFtc2iqIdPeiWl2UkdBavKOAm2cB7YphcwW/BAst7C8yqXcLFtzfUTiB
	y66nqQ0bojAOxAkdu6KvBCYAok28rsPMUJE0MyLSwT/GvRA7f+V1ko9ZRY7DdX8n2Rmo=
X-Google-Smtp-Source: AGHT+IG07aJWSFz0EKwHxV+0m672OZTjD+dXJRBt0J7U3ZDXaKrxKPz/mMfIbtp585GM0LtN28ugxQ==
X-Received: by 2002:a17:903:1ae6:b0:240:981d:a4f5 with SMTP id d9443c01a7336-242fc357fc0mr20275505ad.42.1754956090207;
        Mon, 11 Aug 2025 16:48:10 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2423783a84bsm252085905ad.51.2025.08.11.16.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:48:09 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:48:07 -0700
From: Joe Damato <joe@dama.to>
To: Tianyu Xu <xtydtc@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, kuba@kernel.org, sdf@fomichev.me,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, tianyxu@cisco.com
Subject: Re: [PATCH] igb: Fix NULL pointer dereference in ethtool loopback
 test
Message-ID: <aJqBN0xtMzt_cA87@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>, Tianyu Xu <xtydtc@gmail.com>,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, kuba@kernel.org, sdf@fomichev.me,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, tianyxu@cisco.com
References: <20250811114153.25460-1-tianyxu@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811114153.25460-1-tianyxu@cisco.com>

On Mon, Aug 11, 2025 at 07:41:53PM +0800, Tianyu Xu wrote:
> The igb driver currently causes a NULL pointer dereference
> when executing the ethtool loopback test. This occurs because
> there is no associated q_vector for the test ring when it is
> set up, as interrupts are typically not added to the test rings.
> 
> Since commit 5ef44b3cb43b removed the napi_id assignment in
> __xdp_rxq_info_reg(), there is no longer a need to pass a napi_id.
> Therefore, simply use 0 as the final parameter.
> 
> Signed-off-by: Tianyu Xu <tianyxu@cisco.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index a9a7a94ae..453deb6d1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4453,8 +4453,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
>  	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
>  		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>  	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> -			       rx_ring->queue_index,
> -			       rx_ring->q_vector->napi.napi_id);
> +			       rx_ring->queue_index, 0);
>  	if (res < 0) {
>  		dev_err(dev, "Failed to register xdp_rxq index %u\n",
>  			rx_ring->queue_index);

This LGTM but will probably need to be re-sent with a Fixes tag.

See: https://www.kernel.org/doc/html/v6.16/process/maintainer-netdev.html#tl-dr

If you repost, feel free to add:

Reviewed-by: Joe Damato <joe@dama.to>

