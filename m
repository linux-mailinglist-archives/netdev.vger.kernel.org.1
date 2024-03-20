Return-Path: <netdev+bounces-80846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCD881441
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 16:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906831C213E3
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A414F4EB23;
	Wed, 20 Mar 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbvJb2b3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32F4F206
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947580; cv=none; b=i/GtKnlAs8YSjEOSLnTnF5T4DBWoWLvPvn7p1pgCYwg1KxJVzdqMGLiPjgxMI6JOJ11YQAQEbCcTiWfBGH606LoaqyRotVChi2qBb8+8JDB6pcknEYJ9dKVGLa0/zYtDjZD+BCRowYaXkQ9lcnKxYFY2/eWo3VyaS8dawuOvGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947580; c=relaxed/simple;
	bh=i+tKmqgZnnh9+pttj9dap4bvVlkNNTK6aULhpl7//Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1BTYtFupNGprePgnceTLLO2SgjBoaJd5MFNycsksu2WUSqzpYGcPUcJn6OrwKRl+UpsDsE3AjyVGAolKi5zWwpxT5b6duB0El0v+ElY+0pHPABC4SJ7XW3hvuIe6IO7HIX8juQv2PDgaMuq2IfJj+8S57XeOmfeGF6QlFHLKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WbvJb2b3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4147018a4c9so213605e9.2
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710947577; x=1711552377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctyybnIHwNW6PGvk49fm2Gpbgi59v1p9U9Md3gm0UFg=;
        b=WbvJb2b3JXsxq41dfq8+lfA9skw5oRE7298So4ZjA5C7GIhq3/fPHf0YV81Tjy+MDQ
         +0IBoTyCRiwDAg4a8Jri5uGx+n3XAT0TbChjOJUH5PEFbG7IMU/BSXnipUgbPb19x6mi
         Z77GByE57DInW9MEy/+MMTh9sSzzpVV/DSd/Fv6X5q/MQedg9ZtB3k3Bmxp57qlaQ8v+
         300JKlOzorCgh5MiPsQ558LQilVQ5uv7lK2wWxcs3sG3ePGluw6eW91JW6IUCS7q97XY
         bJ6TRzz58iVkjFmx/jg0qaa+tGNSVByWHdz2K6Eylxxdj3QBKln/9dQSgWYX6F2beksZ
         8eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710947577; x=1711552377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctyybnIHwNW6PGvk49fm2Gpbgi59v1p9U9Md3gm0UFg=;
        b=pTVIiwZP434HDF5fp7D4dojsykwrNOtsc8sAkTqE7MwBiXkNjCIDeO3OHYzpY89m6/
         NcNUc8At64apOPZcZQU6csHc71mbGoVk54NNnOmFQCcZ0wYtOmCpN2ofmf6CkqKIivl1
         zRQ82fo9EZRiofilAhpg4d/cNtnhf4bQOYzmc7MxOLBxuWgHN3+kG0MXnoVwJ5jIrYuA
         7NCrUTHsb3umhmc10KbVR42b0MmREqSAJUam6pbNG1Dm4iFoitGCq8pdGfgL9OP+QfIT
         liFIf8Zk1bIcDOsf0HZLahzt9wRjbYIsTzNpG74FE70ridZYdylgG9cuBdl1blwEbJgJ
         6Rew==
X-Forwarded-Encrypted: i=1; AJvYcCXCgfp/+6pPf69SbilPgSOc7aUDrjAHzrQVL9Nm4X1D+wcI60vJeTp8e+NlfLOULQL1PrJ11PEXnlIqI6DFilOzO3IdTB0T
X-Gm-Message-State: AOJu0YyfecHpeZqkZyame/wvByI4U75m9owkSRGW4Ux1wLsnGv++MtcX
	D2sUZZnyVHZfQEoJ43EbVyvoz4Bm9eX8//xwxWkkVh5Xk1Ut6ZuCiMXuMZWJFDQ=
X-Google-Smtp-Source: AGHT+IEv8JwEztBjjKZIlETMOxUOOoE9GArqnJspTzquEOURRZk/UoRLJfzwZlTxXchqm0KsDp70uA==
X-Received: by 2002:a05:600c:1f85:b0:414:24b:2f4e with SMTP id je5-20020a05600c1f8500b00414024b2f4emr11044127wmb.39.1710947576692;
        Wed, 20 Mar 2024 08:12:56 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b0041464451c81sm2471387wmq.20.2024.03.20.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:12:56 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:12:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Claus Hansen Ries <chr@terma.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, Alex Elder <elder@linaro.org>,
	Wei Fang <wei.fang@nxp.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Wang Hai <wanghai38@huawei.com>
Subject: Re: [PATCH] net: ll_temac: platform_get_resource replaced by wrong
 function
Message-ID: <342875f8-e209-456c-bbac-032a5b7de057@moroto.mountain>
References: <41c3ea1df1af4f03b2c66728af6812fb@terma.com>
 <20240320115433.GT185808@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320115433.GT185808@kernel.org>

On Wed, Mar 20, 2024 at 11:54:33AM +0000, Simon Horman wrote:
> > ---
> >  drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
> > index 9df39cf8b097..1072e2210aed 100644
> > --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> > +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> > @@ -1443,7 +1443,7 @@ static int temac_probe(struct platform_device *pdev)
> >         }
> >           /* map device registers */
> > -       lp->regs = devm_platform_ioremap_resource_byname(pdev, 0);
> > +       lp->regs = devm_platform_ioremap_resource(pdev, 0);

This should have triggered a Sparse warning "warning: Using plain
integer as NULL pointer" but the problem is that this file does not have
correct endian annotations and after a certain number of warnings Sparse
gives up.

It's a bit tricky to check for this in Smatch because it's not
dereferenced unconditionally.  Perhaps instead of asking "Does this
function always dereferences the parameter?"  Smatch would ask, "Can
this function succeed with a NULL parameter?"  I don't know...  And
even that might not help here because the success path is complicated.
I can hard code this as a dereferenced parameter by adding it to
smatch_dereferences.c.

	{ "devm_platform_ioremap_resource_byname", 1, "$" },

But adding functions one by one doesn't scale.

The other thing is that this kind of bug is normally caught in testing
so it's not really suited for static analysis.  Normally the warnings
mean something weird is happening like it's COMPILE_TEST only code.
The common false positive is that the dereference is several steps away
and the function call table hasn't rebuilt enough to know that passing
a NULL used to be illegal but it's allowed now.

Looking at the warnings there is only one false positive:

net/netfilter/x_tables.c:1630 xt_mttg_seq_start() error: NULL dereference inside function 'xt_mttg_seq_next(seq, (0), (0), is_target)()'. '0' '(0)' 49 9

I'll investigate that.  The rest seem like real bugs.

drivers/scsi/pcmcia/qlogic_stub.c:274 qlogic_resume() error: NULL dereference inside function 'qlogicfas408_host_reset((0))()'. '0' '(0)' 33 9
drivers/net/ethernet/cavium/liquidio/lio_main.c:810 liquidio_watchdog() error: NULL dereference inside function 'module_refcount((0))()'. '0' '(0)' 44 9
drivers/net/ethernet/nxp/lpc_eth.c:1401 lpc_eth_drv_probe() error: NULL dereference inside function 'lpc32xx_return_iram((0), (0))()'. '0' '(0)' 62 9
drivers/net/ethernet/nxp/lpc_eth.c:1401 lpc_eth_drv_probe() error: NULL dereference inside function 'lpc32xx_return_iram((0), (0))()'. '0' '(0)' 56 9
drivers/net/ethernet/nxp/lpc_eth.c:1428 lpc_eth_drv_remove() error: NULL dereference inside function 'lpc32xx_return_iram((0), (0))()'. '0' '(0)' 62 9
drivers/net/ethernet/nxp/lpc_eth.c:1428 lpc_eth_drv_remove() error: NULL dereference inside function 'lpc32xx_return_iram((0), (0))()'. '0' '(0)' 56 9
net/rxrpc/io_thread.c:454 rxrpc_io_thread() error: NULL dereference inside function 'rxrpc_input_conn_event(conn, (0))()'. '0' '(0)' 54 9

regards,
dan carpenter


