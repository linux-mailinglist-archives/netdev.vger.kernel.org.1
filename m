Return-Path: <netdev+bounces-21723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15637764706
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26A6281886
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A249A95B;
	Thu, 27 Jul 2023 06:40:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE501BF1D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:39:59 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD92127
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:39:50 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qOuf3-0001oC-9Q; Thu, 27 Jul 2023 08:39:45 +0200
Message-ID: <8742d597-e8b1-705f-6616-dca4ead529f4@pengutronix.de>
Date: Thu, 27 Jul 2023 08:39:37 +0200
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
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, kernel test robot <lkp@intel.com>,
 Eric Dumazet <edumazet@google.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, patchwork-jzi@pengutronix.de
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org> <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
 <09a2d767-d781-eba2-028f-a949f1128fbd@pengutronix.de>
 <ZME/GjBWdodiUO+8@hoboy.vegasvil.org>
From: Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <ZME/GjBWdodiUO+8@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Richard,

On 7/26/23 17:43, Richard Cochran wrote:
> On Wed, Jul 26, 2023 at 08:10:35AM +0200, Johannes Zink wrote:
> 
>> Also on a side-note, "driver nonsense" sounds a bit harsh from someone
>> always insisting that one should not compensate for bad drivers in the
>> userspace stack and instead fixing driver and hardware issues in the kernel,
>> don't you think?
> 
> Everything has its place.
> 
> The proper place to account for delay asymmetries is in the user space
> configuration, for example in linuxptp you have
This is not about Delay Asymmetry, but about Additional Errors in Path Delay, 
namely MAC Ingress and Egress Delay.

> 
>         delayAsymmetry
>                The  time  difference in nanoseconds of the transmit and receive
>                paths. This value should be positive when  the  server-to-client
>                propagation  time  is  longer  and  negative when the client-to-
>                server time is longer. The default is 0 nanoseconds.
> 
>         egressLatency
>                Specifies the  difference  in  nanoseconds  between  the  actual
>                transmission time at the reference plane and the reported trans‐
>                mit time stamp. This value will be added to egress  time  stamps
>                obtained from the hardware.  The default is 0.
> >         ingressLatency
>                Specifies the difference in nanoseconds between the reported re‐
>                ceive  time  stamp  and  the  actual reception time at reference
>                plane. This value will be subtracted from  ingress  time  stamps
>                obtained from the hardware.  The default is 0.
For the PTP stack you could probably configure these in the stack, but fixing 
the delay in the driver also has the advantage of reducing phase offset error 
when doing clock revovery from the PHC.

> 
> Trying to hard code those into the driver?  Good luck getting that
> right for everyone.
That's why we don't hardcode the values but read them from the registers 
provided by the IP core.

> 
> BTW this driver is actually for an IP core used in many, many SoCs.
> 
> How many _other_ SoCs did you test your patch on?
> 
I don't have many available, thus as stated in the description: on the i.MX8MP 
only. That's why I am implementing my stuff in the imx glue code, you're 
welcome to help testing on other hardware if you have any at hand.

Best regards
Johannes

> Thanks,
> Richard
> 
> 
> 


-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |


