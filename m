Return-Path: <netdev+bounces-104110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15D490B428
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DA11C21DD5
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710DF166305;
	Mon, 17 Jun 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ouFxYDFE"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242251D953C;
	Mon, 17 Jun 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636121; cv=none; b=EW+aSljevANaf01uBXmIXD4EQiYQLihnvR8XBBqOIpWk8PXC4u91oTkGQGQ3576rPwRvxSQl7eWKTSCkmPOTgyLkJ5Z1PFt4lhLzasWqUegLOiN0gW+bE8p5rU48RVJX7+QWKueraCJstSnNN6Xh3z/gEOOfZDyoupdaZa4l7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636121; c=relaxed/simple;
	bh=MT+99X0NIQWvQyyjnPMYWLmza1llhonajUvakTRvzzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzVqVrINYNywrGmoLVSpQRcIkCLMS4Ad1JfXJidJ+Cjy/PEJazV/tzdDsjDmdbTn9r9A5A88vsfxvylWzvlXvE1eeie8y/dZqWjfi0JD/nWB+kw/YViE3WxENXlddnADcR7jOUlPPmY+TPyhu1k9eb2dBXMEet2HiAn+4byFxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ouFxYDFE; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718636110; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9+BAYVTQlvYXYc86qKjLmTsOqa7IuYz7qUgU89HASps=;
	b=ouFxYDFED5600rOytRLidF+ujw9LdRGr4EG8anhPDzIQQfPLdpf/CEUdjDdk+bQz2sqqkKyicr21dzwQBBj95CjziXHcbnLQfBvB8nlWKkcOCArlFGy1x8QnQGG9qUrwHXbNZlRJnEZWvct7r2KXcHEHY/fcovAUPMpserYE32o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W8h-6Rn_1718636109;
Received: from 30.32.109.41(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8h-6Rn_1718636109)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 22:55:09 +0800
Message-ID: <c7e7be36-7aa2-423d-9c95-96aed2844aa5@linux.alibaba.com>
Date: Mon, 17 Jun 2024 22:55:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ptp: fix integer overflow in max_vclocks_store
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Yangbo Lu <yangbo.lu@nxp.com>
References: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/6/17 下午5:34, Dan Carpenter 写道:
> On 32bit systems, the "4 * max" multiply can overflow.  Use kcalloc()
> to do the allocation to prevent this.
>
> Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: It's better to use kcalloc() instead of size_mul().
>
>   drivers/ptp/ptp_sysfs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index a15460aaa03b..6b1b8f57cd95 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -296,8 +296,7 @@ static ssize_t max_vclocks_store(struct device *dev,
>   	if (max < ptp->n_vclocks)
>   		goto out;
>   
> -	size = sizeof(int) * max;
> -	vclock_index = kzalloc(size, GFP_KERNEL);
> +	vclock_index = kcalloc(max, sizeof(int), GFP_KERNEL);
>   	if (!vclock_index) {
>   		err = -ENOMEM;
>   		goto out;

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks!



