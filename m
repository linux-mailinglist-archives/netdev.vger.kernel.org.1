Return-Path: <netdev+bounces-22073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DBD765DBA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 23:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC9F1C216F5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159381AA91;
	Thu, 27 Jul 2023 21:07:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C20BA40
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 21:07:09 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725CA2D42
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 14:07:08 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 8a0d0197-2cc1-11ee-abf4-005056bdd08f;
	Fri, 28 Jul 2023 00:07:05 +0300 (EEST)
From: andy.shevchenko@gmail.com
Date: Fri, 28 Jul 2023 00:07:05 +0300
To: Minjie Du <duminjie@vivo.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] spi: fsl-dspi: Use dev_err_probe() in
 dspi_request_dma()
Message-ID: <ZMLcefaxpRVgkPyd@surfacebook>
References: <20230725035038.1702-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725035038.1702-1-duminjie@vivo.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
	SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Jul 25, 2023 at 11:50:37AM +0800, Minjie Du kirjoitti:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> dev is not ready yet.
> At this point dev_err() will have no output.

...

>  	if (IS_ERR(dma->chan_tx)) {

> -		dev_err(dev, "tx dma channel not available\n");
>  		ret = PTR_ERR(dma->chan_tx);
> +		dev_err_probe(dev, ret, "tx dma channel not available\n");

It can be even simpler

		ret = dev_err_probe(dev, PTR_ERR(dma->chan_tx), "tx dma channel not available\n");

>  		goto err_tx_channel;
>  	}

-- 
With Best Regards,
Andy Shevchenko



