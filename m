Return-Path: <netdev+bounces-226026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D77B9AF17
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB55719C198C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05C2D0C68;
	Wed, 24 Sep 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeISFgy+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABD182B4;
	Wed, 24 Sep 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733262; cv=none; b=Ib+jQe33ZgL5lehY3GjNaXVmcwFil0+OyHQZ5mBu66Myxo5KKxPAi5UUEqAZf0p4GnVuafCIqOlkxHZV6CwwO24gJHk3TUNvATFiSzVjaBuoYYBtunxL4TsXqgcssUY0L6nZoK53NGzBQmY/4VIyfVo3r6SVZ20bh6kHf23FNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733262; c=relaxed/simple;
	bh=/ha7u5oWJGOwWkBbMsuRTBXKN/a2H7FPYRgxpQ/zK+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFLHjstgaWdY0iaCwF7G/xIcZq0dumg8d5ZNv126WhD4hgfe72jwa9GBgOHkWZoqqYtEGLckOELGwslmvD4Kat2cgNqaqwY8eH/lwfHFPqmOYzcUEqKr9WfHDQ5uv1/8U88fg2oo+LplL4hvrvFXtbnS/JqwOe0p/B6zf2tVp2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeISFgy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713A5C4CEE7;
	Wed, 24 Sep 2025 17:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758733261;
	bh=/ha7u5oWJGOwWkBbMsuRTBXKN/a2H7FPYRgxpQ/zK+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HeISFgy+gQd1FWz92qJfJEWmv2WKpELi1nT48aN0sCS0gHMQHOFMROB0sX8j/dbAQ
	 uLDKtk0lQLthA5smUex5k+ixh5MrS32BRgcZiTkM3Y7lF7ljdOkEBvRtEDT73/n5OS
	 V/fHjvKiPF4hGuderBGhdCy+6i5Ci0ud6G+rKGR7l5rcfTlyReMeJHBNSlMR+TcOfE
	 HbMe7qu0vuinCsR6HDAgYvAYOmL5tHz3zpHTIfLE4/z0lH8Xvixi3OK/yxj+5PCwX2
	 aDdn9+/X6FBnhAzhS+lOHa7MaC8cHf3pkNYeE1knEYBCtZEhlfu0QOiOUlpgXPPU7y
	 RETuXMlvZojCw==
Date: Wed, 24 Sep 2025 18:00:57 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
Message-ID: <20250924170057.GQ836419@horms.kernel.org>
References: <aNKAvXzRqk_27k7E@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNKAvXzRqk_27k7E@stanley.mountain>

On Tue, Sep 23, 2025 at 02:13:01PM +0300, Dan Carpenter wrote:
> The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free()
> and the caller also calls zl3073x_devlink_flash_update() so it leads

s/zl3073x_devlink_flash_update/zl3073x_fw_free/ ?

> to a double free.  Delete the extra free.
> 
> Fixes: a1e891fe4ae8 ("dpll: zl3073x: Implement devlink flash callback")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks Dan,

Aside from the nit above, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

