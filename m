Return-Path: <netdev+bounces-36239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5380F7AE808
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ACD3A2815CF
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 08:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7D9125D0;
	Tue, 26 Sep 2023 08:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31E125CF
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 08:29:35 +0000 (UTC)
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586DB10E;
	Tue, 26 Sep 2023 01:29:34 -0700 (PDT)
Received: from [IPV6:2003:e9:d70a:c570:868c:bfba:e775:55b0] (p200300e9d70ac570868cbfbae77555b0.dip0.t-ipconnect.de [IPv6:2003:e9:d70a:c570:868c:bfba:e775:55b0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 58050C07E6;
	Tue, 26 Sep 2023 10:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1695716971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0vyztthY/+tnaeVRiur0cBEZttZo6hoyQxPs/S2CiY=;
	b=gNUJfgU0YGWgelSzi7divbDQ6t54DPjAS1iMTPk0AwfLz5NERzWBxT5si/i15kICwB8rSf
	0WFP4tswjig3QIyaLcPPhmUUJCmjp2mbhHIuAOV2lCAJJvrGcgw5IAKNmgEFAu6+Py263x
	5PK5tobGjQQIyMbWTWFrGd3QicoSDW/wv9zo3gnAsVDKBY89N7O6kltad16u2ELJban+u6
	QCJ3FgQWg6HAQX2cv+8k10GlocJjN4nhDed/hlSa1HexxyGs+5o8rjH+tcCuLB2uM8Mdri
	y0Sow/sFZp3SMG2Qc6ravVQbFg6ZlSBYOEH7LAPIKPGi2GZochUWnGp6aa9YZg==
Message-ID: <adf9d668-0906-3004-d4e8-a7775844a985@datenfreihafen.org>
Date: Tue, 26 Sep 2023 10:29:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] [v2] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Alexander Aring <alex.aring@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marcel Holtmann <marcel@holtmann.org>, Harry Morris
 <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230926032244.11560-1-dinghao.liu@zju.edu.cn>
 <20230926100202.011ab841@xps-13>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20230926100202.011ab841@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello.

On 26.09.23 10:02, Miquel Raynal wrote:
> Hi Dinghao,
> 
> dinghao.liu@zju.edu.cn wrote on Tue, 26 Sep 2023 11:22:44 +0800:
> 
>> If of_clk_add_provider() fails in ca8210_register_ext_clock(),
>> it calls clk_unregister() to release priv->clk and returns an
>> error. However, the caller ca8210_probe() then calls ca8210_remove(),
>> where priv->clk is freed again in ca8210_unregister_ext_clock(). In
>> this case, a use-after-free may happen in the second time we call
>> clk_unregister().
>>
>> Fix this by removing the first clk_unregister(). Also, priv->clk could
>> be an error code on failure of clk_register_fixed_rate(). Use
>> IS_ERR_OR_NULL to catch this case in ca8210_unregister_ext_clock().
>>
>> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> 
> Missing Cc stable, this needs to be backported.
> 
>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>> ---
>>
>> Changelog:
>>
>> v2: -Remove the first clk_unregister() instead of nulling priv->clk.
>> ---
>>   drivers/net/ieee802154/ca8210.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
>> index aebb19f1b3a4..b35c6f59bd1a 100644
>> --- a/drivers/net/ieee802154/ca8210.c
>> +++ b/drivers/net/ieee802154/ca8210.c
>> @@ -2759,7 +2759,6 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
>>   	}
>>   	ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
>>   	if (ret) {
>> -		clk_unregister(priv->clk);
>>   		dev_crit(
>>   			&spi->dev,
>>   			"Failed to register external clock as clock provider\n"
> 
> I was hoping you would simplify this function a bit more.
> 
>> @@ -2780,7 +2779,7 @@ static void ca8210_unregister_ext_clock(struct spi_device *spi)
>>   {
>>   	struct ca8210_priv *priv = spi_get_drvdata(spi);
>>   
>> -	if (!priv->clk)
>> +	if (IS_ERR_OR_NULL(priv->clk))
>>   		return
>>   
>>   	of_clk_del_provider(spi->dev.of_node);
> 
> Alex, Stefan, who handles wpan and wpan/next this release?

IIRC it would be me for wpan and Alex for wpan-next.

regards
Stefan Schmidt

