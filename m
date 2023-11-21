Return-Path: <netdev+bounces-49606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88C7F2B7F
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD481C21712
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90D482D7;
	Tue, 21 Nov 2023 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMXZumOZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D8168C5
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 11:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38623C433C8;
	Tue, 21 Nov 2023 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700565068;
	bh=2GevDf923F/wmg4AP9lHNhi0wynht5ViVr+6FizelAI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=dMXZumOZ21LOJQSoNWfD3ARHnJ0BIeFTbpHaK4LkDyOZQT8A0iCzzLkRw76I6P+9g
	 o3FRcHZROQWT8Qdt0atYLyVbq5KfaPeNAXYwEQmu4FvHW5qXBq4eTdDdSWsomiio5x
	 Xmlj3Xy8stT3OnnzbNN/eFGT7VJDuEFoV2Jtj9/y9rYKYzQfZA3l+1DE/6ZApa0Vu8
	 RGeiFn1yNbVjZ2/BX0au2m+5XnKiuBRCcGXTNDecH9U0V4uLZRUzHEy4GoS1xcuW5B
	 hJWkj3MKowOKwZiX9rs49dZuDh59UxmCzxMjHhk5ADZ+dVzGVH2iUPYlr60xkOTro+
	 Ff/shOIvmgtYQ==
Message-ID: <4f09985e-396b-42e9-b7a0-5f9db58e6131@kernel.org>
Date: Tue, 21 Nov 2023 13:11:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 2/7] net: ethernet: am65-cpsw: cleanup TAPRIO
 handling
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-3-rogerq@kernel.org>
 <20231120140147.78726-3-rogerq@kernel.org>
 <20231120225648.pgvzd2jejg5jll2t@skbuf>
 <af23bd5d-2daf-487b-858c-9e3ad684864d@kernel.org>
In-Reply-To: <af23bd5d-2daf-487b-858c-9e3ad684864d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/11/2023 11:23, Roger Quadros wrote:
> 
> 
> On 21/11/2023 00:56, Vladimir Oltean wrote:
>> On Mon, Nov 20, 2023 at 04:01:42PM +0200, Roger Quadros wrote:
>>> -static int am65_cpsw_configure_taprio(struct net_device *ndev,
>>> -				      struct am65_cpsw_est *est_new)
>>> +static void am65_cpsw_cp_taprio(struct tc_taprio_qopt_offload *from,
>>> +				struct tc_taprio_qopt_offload *to)
>>> +{
>>> +	int i;
>>> +
>>> +	*to = *from;
>>> +	for (i = 0; i < from->num_entries; i++)
>>> +		to->entries[i] = from->entries[i];
>>> +}
>>
>> I think I mentioned this before: have you looked at taprio_offload_get()
>> and taprio_offload_put()?
> 
> I'm sorry that I missed this. I'll take a look.

Now I recollect. You mentioned this in a different series review
https://lore.kernel.org/all/20231011102536.r65xyzmh5kap2cf2@skbuf/

Since this patch is more trivial cleanups I will do the
taprio_offload_get/free() change to a separate patch.
> 
>>
>>> +
>>> +static int am65_cpsw_taprio_replace(struct net_device *ndev,
>>> +				    struct tc_taprio_qopt_offload *taprio)
>>>  {
>>>  	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
>>> +	struct netlink_ext_ack *extack = taprio->mqprio.extack;
>>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>>>  	struct am65_cpts *cpts = common->cpts;
>>>  	int ret = 0, tact = TACT_PROG;
>>> +	struct am65_cpsw_est *est_new;
>>>  
>>> -	am65_cpsw_est_update_state(ndev);
>>> +	if (!netif_running(ndev)) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "interface is down, link speed unknown\n");
>>
>> The extack message doesn't need a \n.
> 
> OK.
> 
>>
>>> +		return -ENETDOWN;
>>> +	}
>>>  
>>> -	if (est_new->taprio.cmd == TAPRIO_CMD_DESTROY) {
>>> -		am65_cpsw_stop_est(ndev);
>>> -		return ret;
>>> +	if (common->pf_p0_rx_ptype_rrobin) {
>>> +		NL_SET_ERR_MSG_MOD(extack,
>>> +				   "p0-rx-ptype-rrobin flag conflicts with taprio qdisc\n");
>>
>> Also here.
>>
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (port->qos.link_speed == SPEED_UNKNOWN)
>>> +		return -ENOLINK;
>>> +
>>> +	if (taprio->cycle_time_extension) {
>>> +		NL_SET_ERR_MSG_MOD(extack,
>>> +				   "cycle time extension not supported");
>>
>> Here it's ok.
>>
>>> +		return -EOPNOTSUPP;
>>>  	}
> 
> Thanks for the detailed review!
> 

-- 
cheers,
-roger

