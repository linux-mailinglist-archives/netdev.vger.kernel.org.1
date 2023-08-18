Return-Path: <netdev+bounces-28802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BD2780B9E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF4C1C2161B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20018AEF;
	Fri, 18 Aug 2023 12:17:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110B17FE9
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:17:06 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC932705
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 05:17:05 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qWyPF-00016b-Le; Fri, 18 Aug 2023 14:16:45 +0200
Message-ID: <d3f8f803-e658-2cf6-544a-2305a09a1a97@pengutronix.de>
Date: Fri, 18 Aug 2023 14:16:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] stmmac: intel: Enable correction of MAC
 propagation delay
Content-Language: en-US, de-DE
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>
References: <20230818111401.77962-1-kurt@linutronix.de>
From: Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <20230818111401.77962-1-kurt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/18/23 13:14, Kurt Kanzenbach wrote:
> All captured timestamps should be corrected by PHY, MAC and CDC introduced
> latency/errors. The CDC correction is already used. Enable MAC propagation delay
> correction as well which is available since commit 26cfb838aa00 ("net: stmmac:
> correct MAC propagation delay").
> 
> Before:
> |ptp4l[390.458]: rms    7 max   21 freq   +177 +/-  14 delay   357 +/-   1
> 
> After:
> |ptp4l[620.012]: rms    7 max   20 freq   +195 +/-  14 delay   345 +/-   1
> 
> Tested on Intel Elkhart Lake.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

LGTM

feel free to add my

Reviewed-by: Johannes Zink <j.zink@pengutronix.de>

> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index 979c755964b1..a3a249c63598 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -627,6 +627,7 @@ static int ehl_common_data(struct pci_dev *pdev,
>   	plat->rx_queues_to_use = 8;
>   	plat->tx_queues_to_use = 8;
>   	plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
> +	plat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
>   
>   	plat->safety_feat_cfg->tsoee = 1;
>   	plat->safety_feat_cfg->mrxpee = 1;

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |


