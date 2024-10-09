Return-Path: <netdev+bounces-133510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37C0996254
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155C81C210FE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7E188008;
	Wed,  9 Oct 2024 08:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A782183CA7;
	Wed,  9 Oct 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462188; cv=none; b=sXbycmm/ox4k2TPvxpVafctT7w0V3YKd7OCgWGvO71Ooc9Htqr8CLnxaarUqUwJXwbTsbOljRew7zv8EhSliVfNPx/RpiLXYulvYzuRQfMyQDI2o4eF4jR/xadALl8Bxd16NsqQzHcs+X7FzkiyZnyRgrsIY4dv/1JQWXRab0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462188; c=relaxed/simple;
	bh=OWWHz4CYp9wbQBeMK6ZGclMLjxPNjr3c9tu4Ka7VYL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBFNgnN0WwR+PFR3cbA0ltpChGfShr332W4viP3kyUxYv6olK7qKRYC/OLmCzOeUK+WOTREVxqUXM+OWUSLdRYv/VUe7kkz/q0CoKzabhwN0JFE2jE8A06hRJzbMzEMNQRikDQ+OxMHryNH8aZ5+VEIe1ID6M6oK92B4YEWLthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9952ea05c5so463520866b.2;
        Wed, 09 Oct 2024 01:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462185; x=1729066985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQTACUhFeFr0g9FiP7m95mpmdKBO100vPkvIghW0C9A=;
        b=YpAfNWkZ3NElCnrTFU48uwg92nXJeWDIp/D8997+cd+/9NLwWnO9/ZsqTFc6Drj7SX
         WQ62VA/NyScXzwtx6p4HoS0qNYKxpqxUMhVsC4u/97N7HTxSVideV9lqYFgV0R9RERqV
         kRsivbWWL5PKcGg3fJ3VKc6uMc06zQ1RTgHiT6ucW3LueLbVQOJfgn2AfCTa0as4XEnX
         hVWFz4ku6xaA+KbQSfLlTxnZRVMmwSdqpnNSx+odSw8UWWdyCQFE1bqa3rNnZd04tDuD
         2cI/1iMIRWKhebt4CciItL8seIKSDTIWMVPJhMrjSxDsDgVOl0CAtvB8+OVkdm5NMDnH
         N1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlRPwQEODmz9boH/ImomqjFqWPoxYuinN3LQgvA0rPJz7wZNsUxg+f5WfMh1e5Z1wu/2TYDarC25Vd+QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8IXDeJTvqOnxqVAsKxwO9vjNH1geVfXsvNbBUx9y52R9XD4B
	KmlqUXB1J+H1i5PbwE9QC/kxVd2IhxHeMnEM5O5uZyLJsG4oRzzY
X-Google-Smtp-Source: AGHT+IHPiv3gAPsHrEJebDtaMKefHj3kMSI9yPHBKQpQBb980qL/DVK37VNaKHJcNKW1JAHj8HCSRg==
X-Received: by 2002:a17:907:2da3:b0:a8c:78a5:8fb7 with SMTP id a640c23a62f3a-a998d314e4dmr134343166b.45.1728462185169;
        Wed, 09 Oct 2024 01:23:05 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994a1464a1sm474369366b.106.2024.10.09.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:23:04 -0700 (PDT)
Date: Wed, 9 Oct 2024 01:23:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Jeff Garzik <jeff@garzik.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net] net: ibm: emac: mal: add dcr_unmap to _remove
Message-ID: <20241009-precise-wasp-from-ganymede-defeeb@leitao>
References: <20241008233050.9422-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008233050.9422-1-rosenp@gmail.com>

Hello Rosen,

On Tue, Oct 08, 2024 at 04:30:50PM -0700, Rosen Penev wrote:
> It's done in probe so it should be done here.
> 
> Fixes: 1d3bb996 ("Device tree aware EMAC driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: Rebase and add proper fixes line.
>  drivers/net/ethernet/ibm/emac/mal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
> index a93423035325..c634534710d9 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.c
> +++ b/drivers/net/ethernet/ibm/emac/mal.c
> @@ -742,6 +742,8 @@ static void mal_remove(struct platform_device *ofdev)
>  
>  	free_netdev(mal->dummy_dev);
>  
> +	dcr_unmap(mal->dcr_host, 0x100);
> +
>  	dma_free_coherent(&ofdev->dev,
>  			  sizeof(struct mal_descriptor) *
>  			  (NUM_TX_BUFF * mal->num_tx_chans +

The fix per see seems correct, but, there are a few things you might
want to improve:

1) Fixes: format
Your "Fixes:" line does not follow the expected format, as detected by
checkpatch. you might want something as:

	Fixes: 1d3bb996481e ("Device tree aware EMAC driver")


2) The description can be improved. For instance, you say it is done in
probe but not in remove. Why should it be done in remove instead of
removed from probe()? That would help me to review it better, instead of
going into the code and figure it out.

Once you have fixed it, feel free to add:

Reviewed-by: Breno Leitao <leitao@debian.org>

