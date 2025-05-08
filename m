Return-Path: <netdev+bounces-189038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C5AAAFFE0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638C21B64211
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456B327C150;
	Thu,  8 May 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeUUCOaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE427B501
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720288; cv=none; b=MGRp50hjRwH8jxxQZhjxX9meTEYt3e+K0Frz5PR+/0JEIrWdF2OV81lpBuRWKVHpVnteZJahPbTmq6ED08YM2uPicgt188BjJYdo6MAxIkyDIHCEig6HVtpZv3TKtrLaqwP94LxpGECgyzby/jUR0pV2p3hzgdqkTxCHQdX9R2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720288; c=relaxed/simple;
	bh=en54wuSZFW/EGgKHuzPwEc+beIj2Va80LV7o1nAuzFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3oh9/oU1OJWwtE5nU/UCZwhMwHftB9c06INKx2hiHNAHTYwFio5P/twkEBWIDajnb407HgKqVz8Njzvq7O5ZnecFdsaPgcmDZ8/lneJ8wNUm3aHKPiQ2oCUYSW8UVopfCVi0gE3dXT37v0Qet2Fdvnj+MwnalTttnP6crv5/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeUUCOaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C109C4CEE7;
	Thu,  8 May 2025 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746720287;
	bh=en54wuSZFW/EGgKHuzPwEc+beIj2Va80LV7o1nAuzFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VeUUCOaMIby/axVv8MmHFGNfSxwHUec7qqeN6Wqm+UPwr1jRINdge16rRpUcx4ryn
	 M6YFikoHHjD0e4SECOdSa+w9/rJe8MaOu+aHxWA5HrlnTZSJHI5RNkcxsarnyNpK7Z
	 3Vtcpe6YrEXyMe/S8AfNdTm3RTC1+V3w7PkahaqKVEDO68f3Z3Hb2yc9KeQhcZj8QZ
	 JRZji0H+3tcknvIUQoA9NdAsX5hrQ2IhZfTxe371uyy2Umh+Fxt/qDOneZI/EPydTA
	 XSRIsQZDBiGnUwHcxFVSgJYsfwxf9qzvM6Z7NGWCpq0aMbMLdPJo6q2rRjzjumwI5z
	 T6G33uXIti5IA==
Date: Thu, 8 May 2025 09:04:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v2] net: Lock lower level devices when updating
 features
Message-ID: <20250508090445.3b235bcc@kernel.org>
In-Reply-To: <20250508145459.1998067-1-cratiu@nvidia.com>
References: <20250508145459.1998067-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 17:54:59 +0300 Cosmin Ratiu wrote:
>  			lower->wanted_features &= ~feature;
> +			netdev_lock_ops(lower);
>  			__netdev_update_features(lower);
> +			netdev_unlock_ops(lower);
>  
>  			if (unlikely(lower->features & feature))

I'd be slightly tempted to try to cover the accesses to members of
lower, because why not:

			netdev_lock_ops(lower);
 			lower->wanted_features &= ~feature;
 			__netdev_update_features(lower);
			still_enabled = lower->features & feature;
			netdev_unlock_ops(lower);

 			if (unlikely(still_enabled))

WDYT?

