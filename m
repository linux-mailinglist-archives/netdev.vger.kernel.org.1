Return-Path: <netdev+bounces-205363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7E4AFE4DC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE057166A9B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15AA288518;
	Wed,  9 Jul 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlipk4xq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8B2877F4;
	Wed,  9 Jul 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055386; cv=none; b=RJ5yhEe1JPCEI7L/qdSSdq5/+hjOD9Ig6CHAfv1nWlSwz4SkM7X5ViZBNMhG4awm8jwnLP0slIMFr/UhghNvDl8t9Ii1A1PDoTcvJ2qXGsRaSdBtlPXghAx32QO9nvBKf/AUztX+nhGdpdYUQAOrccWSu5lDXb8vD36ibfzWW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055386; c=relaxed/simple;
	bh=Fdoodfrgd85b4dBqka+S6BWRVmKdcyjof9xDTs/t7h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2qvN2fh48ywhFPsct91slqElSNGN1Xw/KzVxTIcjwWCknwQgPk1Jq6I9e1boIrCLODTKWVQT/Nm8iKT/n2JdlHkyKB/vtmRSKwHdRS036sELmuV3Febq7GaFmu51KnTyBhtlqPB6IBxZ6L+zHz/GYx+q3xnerUOQ9pR6rctoW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlipk4xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83253C4CEEF;
	Wed,  9 Jul 2025 10:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752055386;
	bh=Fdoodfrgd85b4dBqka+S6BWRVmKdcyjof9xDTs/t7h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlipk4xqz63QtxVwnIKH88STTIuoiMHUcwSmN9k5iAi52HNwlH3Rs9cOKSR0wnqLl
	 Lo2Z44T9ssEMpRp0pD29a3jRU8ock/68QkdQJzXJQ5k2MzSH3eIoTXiAoNoamm2EUO
	 zZid5VlhgwP/nqoaCbn8MdFPhYRtlO8Sv96ktPp188BSzSiLTDyi2nlLwHl52sLQAM
	 bRYpCPoRkYOe/XAsTbGCkxFHbLlmbJLNt4Cj4GFpgIGO8gNqXoMAap4hO1qfzOvZ8T
	 mXPx9f1RpGmL15doZIb1SQQuy/rWPWCdUzqW7xACjG50DCa1hAnidyaSXI8qMo3de6
	 h0HtXNEN313KA==
Date: Wed, 9 Jul 2025 11:03:01 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Joe Damato <jdamato@fastly.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devlink: move DEVLINK_ATTR_MAX-sized array off stack
Message-ID: <20250709100301.GS452973@horms.kernel.org>
References: <20250708160652.1810573-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708160652.1810573-1-arnd@kernel.org>

On Tue, Jul 08, 2025 at 06:06:43PM +0200, Arnd Bergmann wrote:

...

> diff --git a/net/devlink/rate.c b/net/devlink/rate.c

...

> +	err = -EINVAL;

...

>  	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
>  
> -	return 0;

Hi Arnd,

It looks like err will be -EINVAL here, which doesn't seem desirable.
I'd just return 0 here.

And, FWIIW, I'd only set err when it is needed, even if that
means some duplication. I think that is an idiomatic approach,
at least within Networking.

> +out:
> +	kfree(tb);
> +	return err;
>  }

...

-- 
pw-bot: changes-requested

