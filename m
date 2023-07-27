Return-Path: <netdev+bounces-21745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D48764903
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D021C21517
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6929CC2E7;
	Thu, 27 Jul 2023 07:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963D17CE
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:41:38 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A82B5265
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:41:20 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qOvcX-000300-3c; Thu, 27 Jul 2023 09:41:13 +0200
Message-ID: <2c9eda9d-c433-93c5-9719-78c4940c7957@pengutronix.de>
Date: Thu, 27 Jul 2023 09:41:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Content-Language: en-US, de-DE
From: Johannes Zink <j.zink@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 kernel test robot <lkp@intel.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>,
 Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-stm32@st-md-mailman.stormreply.com,
 linux-kernel@vger.kernel.org, patchwork-jzi@pengutronix.de
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org> <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
 <09a2d767-d781-eba2-028f-a949f1128fbd@pengutronix.de>
 <ZME/GjBWdodiUO+8@hoboy.vegasvil.org>
 <8742d597-e8b1-705f-6616-dca4ead529f4@pengutronix.de>
 <c30e3a37-b7f5-77bc-198a-b9acf4eb6422@pengutronix.de>
In-Reply-To: <c30e3a37-b7f5-77bc-198a-b9acf4eb6422@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/27/23 08:55, Johannes Zink wrote:
> Hi,
> 
> On 7/27/23 08:39, Johannes Zink wrote:
>> Hi Richard,
>>
> 
> [snip]
> 
> 
>>> How many _other_ SoCs did you test your patch on?
>>>
>> I don't have many available, thus as stated in the description: on the 
>> i.MX8MP only. That's why I am implementing my stuff in the imx glue code, 
>> you're welcome to help testing on other hardware if you have any at hand.

small correction to what I wrote earlier: it's not implemented in the gluecode, 
but in the general stmmac_hwtstamp. My bad, I added it to the gluecode in an 
early prototype version, but then tried to generalize it.

Johannes

> 
> note: for v3 I am going to check if we have a dwmac v5 and won't call into the 
> correction setup function otherwise.
> 
> Best regards
> Johannes
> 
> 
>> Best regards
>> Johannes
>>
>>> Thanks,
>>> Richard
>>>
>>>
>>>
>>
>>
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |


