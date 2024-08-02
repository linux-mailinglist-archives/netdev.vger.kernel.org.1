Return-Path: <netdev+bounces-115326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8261D945D92
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E24F2848D3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751231DF66A;
	Fri,  2 Aug 2024 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vKDAhoJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802E1E287D
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599920; cv=none; b=DItftVY2YYokxVvYeBvuyUUF8fS/NP06gd5DpCNlO8vF5SYq+bPuBY8/5ApGjgZK/aNv70Qy/1pc1e2PsgYvbCWPYOUL00BXNYQHjb0scMatuLBFOpf3ABKG3RCaU2To2nade8/MrV0NrvYOY3cNca646JjnTYYF4t7kmvHWQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599920; c=relaxed/simple;
	bh=Wjys6nJapjYSgM/k2yEoRlTGNx4JtI/g5G3SkITC8l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqcRFZiDqzR1m2hW+yUW9V8nOq6mK0DcuSM9m6J0V+PMjOcKRBnZ3CCG7uhoNo+P/2VhTMxKp4anAQeAQLWsjFy0FU4cPZATVaiNb6VgtFboCsY2unxzs5tQkc8X8dnm6z5zRFLw3R128EG/mbpXTerYR9FghH9Uth5VVOcO55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vKDAhoJm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428141be2ddso53392095e9.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722599917; x=1723204717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEa7Z7UbYtVi0+f2XKzgTemysh+MWx4/eGmyrqCj/Sk=;
        b=vKDAhoJmiZ51VBVb2caj+/NhKJ/qsNJzIw7MvFEF9ZYpe3a276dOAB5Qrqf2I4nLmd
         ePJj8MR5o9pT+7Emx+ypEw0Epqh+iP1oHGTBIuThYMLc2doYQHKptATe+GdoxlxenRA5
         CufPHYf3Z+0HpDSMkY4m58wzHbEEr34nPTTBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722599917; x=1723204717;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEa7Z7UbYtVi0+f2XKzgTemysh+MWx4/eGmyrqCj/Sk=;
        b=Aw9A4M3c4bI/U8xEcNBItTs/qKpctctEqrU/mjts0KUXORBNXQNcJG0qUQXFTLwftH
         q0ilVxEJzX3/K2qXehgM/DiMfXmokvj3Jw6IB5VsKiDa3dzsGWJA5mm3XzjdHLr/tMUo
         d2IntJtBXkVWaZBaV0hlUONOtH5KDe38ImlkWQMapy9URhzzLTla7K5vmCLpAjwx11Ld
         whw/98D4OR+Uz5cWYjdstQQ+TQIDHEfbNk2dW+rie/SXToH8AVO0AxQeCVcdHuSTwp3N
         fexS4crXrap2nXB3sCuFajvzwECHcx1ppKik5ldjSnbK2q/d47XLtpvet0qiABKVA5k4
         wa/A==
X-Forwarded-Encrypted: i=1; AJvYcCXakcvFzRSdzSxzOwM5MefvNcSxVv/46MjMCTnyH8FiDeu8S3Uo4JLP0dmumsecolsp+/tRydXU3Bilbb42ZRJR5u550dfY
X-Gm-Message-State: AOJu0YzFWk04mF7SRVMUoSYQDW+1/+Z+nvWSvHfSZcggyvHmfY9ruXNS
	uod7yjBQ7JCIah3GKWYBVJ4tUeMDTrH7TCG/ZRCYoOKNyVRtku4GFEEYaK1hn5g=
X-Google-Smtp-Source: AGHT+IF+6/MTpbPLL96qvE1+dXw7bSNSVKDrESUlJVLXCC3fTaVEIHsQcSEGfm/E1iLFl1Wtb6a66Q==
X-Received: by 2002:a05:600c:4f0f:b0:428:1b0d:8657 with SMTP id 5b1f17b1804b1-428e6b33138mr21728775e9.22.1722599916744;
        Fri, 02 Aug 2024 04:58:36 -0700 (PDT)
Received: from LQ3V64L9R2 ([62.30.8.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01f01dsm1805795f8f.51.2024.08.02.04.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:58:36 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:58:34 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 06/12] ethtool: rss: don't report key if device
 doesn't support it
Message-ID: <ZqzJ6tLil3vwvfgh@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240802001801.565176-1-kuba@kernel.org>
 <20240802001801.565176-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802001801.565176-7-kuba@kernel.org>

On Thu, Aug 01, 2024 at 05:17:55PM -0700, Jakub Kicinski wrote:
> marvell/otx2 and mvpp2 do not support setting different
> keys for different RSS contexts. Contexts have separate
> indirection tables but key is shared with all other contexts.
> This is likely fine, indirection table is the most important
> piece.
> 
> Don't report the key-related parameters from such drivers.
> This prevents driver-errors, e.g. otx2 always writes
> the main key, even when user asks to change per-context key.
> The second reason is that without this change tracking
> the keys by the core gets complicated. Even if the driver
> correctly reject setting key with rss_context != 0,
> change of the main key would have to be reflected in
> the XArray for all additional contexts.
> 
> Since the additional contexts don't have their own keys
> not including the attributes (in Netlink speak) seems
> intuitive. ethtool CLI seems to deal with it just fine.

FWIW: I took a look at the ethtool source and I agree, but didn't
test it.

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  1 +
>  .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  1 +
>  drivers/net/ethernet/sfc/ef100_ethtool.c      |  1 +
>  drivers/net/ethernet/sfc/ethtool.c            |  1 +
>  drivers/net/ethernet/sfc/siena/ethtool.c      |  1 +
>  include/linux/ethtool.h                       |  3 +++
>  net/ethtool/ioctl.c                           | 25 ++++++++++++++++---
>  net/ethtool/rss.c                             | 21 +++++++++++-----
>  9 files changed, 45 insertions(+), 10 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

