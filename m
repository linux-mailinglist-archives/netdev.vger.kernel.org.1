Return-Path: <netdev+bounces-25170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA80773165
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5951C208C4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C8517738;
	Mon,  7 Aug 2023 21:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2681772A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:42:48 +0000 (UTC)
Received: from out-79.mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD89B10DE
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:42:47 -0700 (PDT)
Message-ID: <2b7e0024-2a92-58c8-fbeb-d42beebedb03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691444564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNf4Xj9sYgqaAAtVS1B7R4VnMt3ohxXfiI3lq5GWxMU=;
	b=XfTujzKb52/AWob/D5e3RdzPz1i4tPMB0Xrdkj2kGQ24wC/uw0y0tLM9MnqoCf+Ko+YfWl
	Qz6oJJyy77vNgvVk17zSQr8dZ3OwpVLckVveLzQ9+HW8tEX329VZ3XWRqh1ubYMJ1mKnz+
	QzdbDpSjLAJ81s/mKN5aaN2KMb9cdLU=
Date: Mon, 7 Aug 2023 22:42:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 8/9] ptp_ocp: implement DPLL ops
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Milena Olech <milena.olech@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com, mschmidt@redhat.com,
 netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org,
 Jiri Pirko <jiri@nvidia.com>
References: <20230804190454.394062-1-vadim.fedorenko@linux.dev>
 <20230804190454.394062-9-vadim.fedorenko@linux.dev>
 <ZM/Uuhl4GwOWjku9@vergenet.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZM/Uuhl4GwOWjku9@vergenet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06.08.2023 18:13, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 08:04:53PM +0100, Vadim Fedorenko wrote:
>> Implement basic DPLL operations in ptp_ocp driver as the
>> simplest example of using new subsystem.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> Hi Vadim,
> 
> ...
> 
>> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
>> index 32dff1b4f891..e4da62ac9a9f 100644
>> --- a/drivers/ptp/Kconfig
>> +++ b/drivers/ptp/Kconfig
>> @@ -177,6 +177,7 @@ config PTP_1588_CLOCK_OCP
>>   	depends on COMMON_CLK
>>   	select NET_DEVLINK
>>   	select CRC16
>> +	select DPLL
>>   	help
>>   	  This driver adds support for an OpenCompute time card.
>>   
>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> 
> ...
> 
>> +static int ptp_ocp_dpll_frequency_set(const struct dpll_pin *pin,
>> +				      void *pin_priv,
>> +				      const struct dpll_device *dpll,
>> +				      void *dpll_priv, u64 frequency,
>> +				      struct netlink_ext_ack *extack)
>> +{
>> +	struct ptp_ocp_sma_connector *sma = pin_priv;
>> +	struct ptp_ocp *bp = dpll_priv;
>> +	const struct ocp_selector *tbl;
>> +	int sma_nr = (sma - bp->sma);
>> +	int val, i;
>> +
>> +	if (sma->fixed_fcn)
>> +		return -EOPNOTSUPP;
>> +
>> +	tbl = bp->sma_op->tbl[sma->mode];
>> +	for (i = 0; tbl[i].name; i++)
>> +		if (tbl[i].frequency == frequency)
>> +			return ptp_ocp_sma_store_val(bp, val, sma->mode, sma_nr);
> 
> val appears to be used uninitialised here.
> 
> As flagged by clang-16 W=1, and Smatch.
> 

Ahh, looks like it's not needed at all, thanks!

>> +	return -EINVAL;
>> +}
> 
> ...
> 
>> @@ -4233,8 +4437,40 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   
>>   	ptp_ocp_info(bp);
>>   	devlink_register(devlink);
>> -	return 0;
>>   
>> +	clkid = pci_get_dsn(pdev);
>> +	bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE);
>> +	if (IS_ERR(bp->dpll)) {
>> +		dev_err(&pdev->dev, "dpll_device_alloc failed\n");
>> +		goto out;
>> +	}
>> +
>> +	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
>> +	if (err)
>> +		goto out;
>> +
>> +	for (i = 0; i < OCP_SMA_NUM; i++) {
>> +		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE, &bp->sma[i].dpll_prop);
>> +		if (IS_ERR(bp->sma[i].dpll_pin))
> 
> The function will return err.
> Should it be sett to an error value here?

Yeah, you are right. And I have spotted one more place where err is not properly
set, just above this one. Thanks for the review.


> As flagged by Smatch.
> 
>> +			goto out_dpll;
>> +
>> +		err = dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops,
>> +					&bp->sma[i]);
>> +		if (err) {
>> +			dpll_pin_put(bp->sma[i].dpll_pin);
>> +			goto out_dpll;
>> +		}
>> +	}
>> +	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
>> +
>> +	return 0;
>> +out_dpll:
>> +	while (i) {
>> +		--i;
>> +		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
>> +		dpll_pin_put(bp->sma[i].dpll_pin);
>> +	}
>> +	dpll_device_put(bp->dpll);
>>   out:
>>   	ptp_ocp_detach(bp);
>>   out_disable:
> 
> ...


