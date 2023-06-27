Return-Path: <netdev+bounces-14347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7967406D8
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 01:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662261C20A82
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 23:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B11ACB1;
	Tue, 27 Jun 2023 23:33:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3232749F
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 23:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C16C433C8;
	Tue, 27 Jun 2023 23:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687908827;
	bh=ICAejiuFUC/1Y/I67hPGjW+XknCM1NTjVehtolvc5/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCgLg90R9nb6tEwNk63w9P5PVVk25wJ+WW6pX7u4s0m+h3Deg7440fxTOv5yMR7JD
	 tZSL7Mii3FkTTTN0i29DtuyTcwm3pPKVhMUqwK591eZ6VuEe8LSDmTg8bXVwg/JdNZ
	 eok58l6KnUzC0iB68zgoz0skXHB8LFhYNdStUgwz21jP73sTYU8l1ftWUxiP7fLzXp
	 MLbTtCVO5jRUWALfmoQu0BRNZB4BW+O7qejH5Rl0PsPWUj5N4VE9Nf+R8wJLhVFIca
	 FPEf4XWqCae/fuQ4slLWCptdFsyvJyuUn2ArHtu57JCu9fOLnxeKFJEZmfga5SZ4Wx
	 pmDuJTsM+0Rwg==
Date: Tue, 27 Jun 2023 16:33:44 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <20230627233344.GA1914803@dev-arch.thelio-3990X>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627232139.213130-1-rrameshbabu@nvidia.com>

On Tue, Jun 27, 2023 at 04:21:39PM -0700, Rahul Rameshbabu wrote:
> The .adjphase operation is an operation that is implemented only by certain
> PHCs. The sysfs device attribute node for querying the maximum phase
> adjustment supported should not be exposed on devices that do not support
> .adjphase.
> 
> Fixes: c3b60ab7a4df ("ptp: Add .getmaxphase callback to ptp_clock_info")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/netdev/20230627162146.GA114473@dev-arch.thelio-3990X/
> Link: https://lore.kernel.org/all/CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com/

Thanks a lot for the fix!

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/ptp/ptp_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index 77219cdcd683..6e4d5456a885 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -358,6 +358,9 @@ static umode_t ptp_is_attribute_visible(struct kobject *kobj,
>  		   attr == &dev_attr_max_vclocks.attr) {
>  		if (ptp->is_virtual_clock)
>  			mode = 0;
> +	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
> +		if (!info->adjphase || !info->getmaxphase)
> +			mode = 0;
>  	}
>  
>  	return mode;
> -- 
> 2.40.1
> 

