Return-Path: <netdev+bounces-47813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6DB7EB709
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C400AB20A4D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998FD26ADF;
	Tue, 14 Nov 2023 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcjngx+s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8326ADB
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57ADC433C8;
	Tue, 14 Nov 2023 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699991624;
	bh=b44Cg1Nm3xRweiZaKLR7rcsJE+tAGmLA0GlDnpXQrKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tcjngx+s61YLRVW7hOdBOnRXDymSRjH1ZyDHlGLBT6VwZ/G9WKzWYBJGu+2UsCfuT
	 e4X9prUO6sNFrC2Rm8EwCeg0dXmqpoPkNXlMeDSe7/L4HQe5T3XqDAOwzc/g1lJvgT
	 MqunrdaHvQGP/Q8YgcTAiCqSZMcSuWcQn/0YeTRooBLXZqD/dEdKcXnP0pk97Bsfua
	 Ri3D+GXDykN5TgftzB55VrtkpcEusiPwzH2rwn5JxfSOZeRI6WGCSMuJaNwkFbsK8j
	 AETeR1MvzJ2WCFvbgu9xxIfitY8Sy1g36aHNjoWUzIuvvY7moSNI7noDtL9qB7EPwY
	 WiDqKhLmA89BQ==
Message-ID: <7146a57c-fcf3-4330-a760-5c163fc8796c@kernel.org>
Date: Tue, 14 Nov 2023 21:53:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: ethernet: am65-cpsw: Error out if
 Enable TX/RX channel fails
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com, srk@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-4-rogerq@kernel.org>
 <20231114120758.kz5n3x4fawhcegqi@skbuf>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231114120758.kz5n3x4fawhcegqi@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/11/2023 14:07, Vladimir Oltean wrote:
> On Mon, Nov 13, 2023 at 01:07:08PM +0200, Roger Quadros wrote:
>> k3_udma_glue_enable_rx/tx_chn returns error code on failure.
>> Bail out on error while enabling TX/RX channel.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 33 +++++++++++++++++++-----
>>  1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index 7c440899c93c..340f25bf33b1 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -372,7 +372,7 @@ static void am65_cpsw_init_port_emac_ale(struct am65_cpsw_port *port);
>>  static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>>  {
>>  	struct am65_cpsw_host *host_p = am65_common_get_host(common);
>> -	int port_idx, i, ret;
>> +	int port_idx, i, ret, tx;
>>  	struct sk_buff *skb;
>>  	u32 val, port_mask;
>>  
>> @@ -453,13 +453,22 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>>  		}
>>  		kmemleak_not_leak(skb);
>>  	}
>> -	k3_udma_glue_enable_rx_chn(common->rx_chns.rx_chn);
>>  
>> -	for (i = 0; i < common->tx_ch_num; i++) {
>> -		ret = k3_udma_glue_enable_tx_chn(common->tx_chns[i].tx_chn);
>> -		if (ret)
>> -			return ret;
> 
> Can you comment on the kmemleak_not_leak(skb) call above, and its
> relationship to the pre-existing error handling path in am65_cpsw_nuss_common_open()?

I am not aware why it was added. It sure looks odd and I'll get rid of it
and add the necessary error handling.

> I see that the dev_kfree_skb_any() call is being made from am65_cpsw_nuss_rx_cleanup(),
> which is only called from am65_cpsw_nuss_common_stop().
> 
> So if there are errors during am65_cpsw_nuss_common_open() and
> descriptors have already been added to the RX DMA channel, they will not
> be removed either from hardware or from software. How does that work?

I believe this is a gap and I will address it in the next revision. Thanks!

-- 
cheers,
-roger

