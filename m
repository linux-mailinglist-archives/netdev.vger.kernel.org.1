Return-Path: <netdev+bounces-21725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3536976471D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6611A1C214F8
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B2BA40;
	Thu, 27 Jul 2023 06:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B911BF1D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:43:14 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397AB2116
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:43:13 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qOui9-0002NW-LM; Thu, 27 Jul 2023 08:42:57 +0200
Message-ID: <06859eed-6f9b-5d66-3221-e55dcd83466c@pengutronix.de>
Date: Thu, 27 Jul 2023 08:42:52 +0200
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
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>,
 patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, kernel test robot <lkp@intel.com>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <ZMFfI3xU5pkJW4x4@hoboy.vegasvil.org>
From: Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <ZMFfI3xU5pkJW4x4@hoboy.vegasvil.org>
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

Hi Richard,

On 7/26/23 20:00, Richard Cochran wrote:
> On Mon, Jul 24, 2023 at 12:01:31PM +0200, Johannes Zink wrote:
> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
>> index bf619295d079..d1fe4b46f162 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
>> @@ -26,6 +26,12 @@
>>   #define	PTP_ACR		0x40	/* Auxiliary Control Reg */
>>   #define	PTP_ATNR	0x48	/* Auxiliary Timestamp - Nanoseconds Reg */
>>   #define	PTP_ATSR	0x4c	/* Auxiliary Timestamp - Seconds Reg */
>> +#define	PTP_TS_INGR_CORR_NS	0x58	/* Ingress timestamp correction nanoseconds */
>> +#define	PTP_TS_EGR_CORR_NS	0x5C	/* Egress timestamp correction nanoseconds*/
>> +#define	PTP_TS_INGR_CORR_SNS	0x60	/* Ingress timestamp correction subnanoseconds */
>> +#define	PTP_TS_EGR_CORR_SNS	0x64	/* Egress timestamp correction subnanoseconds */
> 
> These two...
> 
>> +#define	PTP_TS_INGR_LAT	0x68	/* MAC internal Ingress Latency */
>> +#define	PTP_TS_EGR_LAT	0x6c	/* MAC internal Egress Latency */
> 
> do not exist on earlier versions of the IP core.
> 
> I wonder what values are there?
> 

good catch, I think adding the register definition won't hurt, but if you feel 
more comfortable about it I can add them only for IP core version 5.

Johannes


> Thanks,
> Richard
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |


