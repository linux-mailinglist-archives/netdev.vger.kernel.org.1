Return-Path: <netdev+bounces-190383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9DDAB69AE
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD53465B3F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5C225401;
	Wed, 14 May 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3BpBzNz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79246447
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221629; cv=none; b=nVWd8yHu/v3dAFlPhla/ikGLK4C3YiLqo3AfTI+xvICa5BuJPC0dEcxDK8sjXOkrrajpjiu73PYHnEQv6EPFnHwG7kzodAy68hCIZVUYv2vPaTnG3FAY50TW0FNkh02lRU3wHjv80XuGczwP+MDwhYs+qws0fU06Gp8wK69MxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221629; c=relaxed/simple;
	bh=6O8koyW/+axmZ/2c6AMxoSvoEEM6W0JVzgylM4+XhX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvIavP24PA6OLoc74rlND8Uk0uYNwy5B2ieQ/Kk6XmS5yWu4rT8jDZhUKYtjBH7NTQyS0EeiClJAZUYCD8iScRYVV6FkzxWohO5CoVNr+2oF74/igujtMn5i/n3em6deCbKddpiUmVZ2WwFIGR08j6TSZb783hT7Sh2oOmnS78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3BpBzNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC86C4CEE9;
	Wed, 14 May 2025 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747221628;
	bh=6O8koyW/+axmZ/2c6AMxoSvoEEM6W0JVzgylM4+XhX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3BpBzNzlCSOsoZcpsGzFDY01OOHX9gSDMGgDBmX19Jfj9kF/CNyXVnwMLU7TYH1j
	 EE4Y1HYyUwjuwxYaKUZ59KPIy0wYqhVr5/QRJbDLEyOeHNFUHczMaHy8FCd0ScY9Tm
	 DTqaM9lf9xzhXKo9JCLibyIs8HNGXx+NyNyhEn3vWn5nc6JdHMknaTHd7uoVcBpAj4
	 GMKZhQEkJYzgObzoNHIm1QjTsTgS21zvb25jG2bMP4w5ph3Zi0GAYKksdMNOU1gHgF
	 0kwgb0TTMprqZ991xy2OKoOCcWFzNn9yzSNfSYraaKEjZULs1sxKQPs3jjfWbDGe05
	 3dBBNtX19kxWA==
Date: Wed, 14 May 2025 12:20:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, mengyuanlou@net-swift.com
Subject: Re: [PATCH net v2 3/3] net: libwx: Fix FW mailbox unknown command
Message-ID: <20250514112024.GJ3339421@horms.kernel.org>
References: <20250513021009.145708-1-jiawenwu@trustnetic.com>
 <64DBB705D35A0016+20250513021009.145708-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64DBB705D35A0016+20250513021009.145708-4-jiawenwu@trustnetic.com>

On Tue, May 13, 2025 at 10:10:09AM +0800, Jiawen Wu wrote:
> For the new SW-FW interaction, missing the error return if there is an
> unknown command. It causes the driver to mistakenly believe that the
> interaction is complete. This problem occurs when new driver is paired
> with old firmware, which does not support the new mailbox commands.
> 
> Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


