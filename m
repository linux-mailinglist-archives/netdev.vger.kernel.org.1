Return-Path: <netdev+bounces-26883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB6779406
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FF51C21782
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F061170F;
	Fri, 11 Aug 2023 16:12:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF311701
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 16:12:19 +0000 (UTC)
Received: from out-124.mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8AF2722
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:12:17 -0700 (PDT)
Message-ID: <33708eb5-d64f-53b4-5107-8f663ca22c4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691770335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kv429vn4vrSk3k/7v41brV0Zux6uwlxmmzbB9l5tuo0=;
	b=cNArDGwshUnaLan3+ZQHwp/yQxNnjNwDYr5AnuuykMARyRZGX6XBHOBj+TMWDbT2sfsFyY
	koPL+1ZQjcVPbei/xPlRFXipRrPzkC5WuFC+Q8a+wFKmEjB68EtF/Oi6RXa67rdiX1i37I
	L80+sM4WXgpoBiCA2rNOprL3+YJF+dY=
Date: Fri, 11 Aug 2023 17:12:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix kernel panic issue after removing igb driver
Content-Language: en-US
To: marshall.shao@dell.com, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Simon Horman <simon.horman@corigine.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Kees Cook <keescook@chromium.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Lin Ma <linma@zju.edu.cn>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811120225.4133-1-marshall.shao@dell.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230811120225.4133-1-marshall.shao@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/08/2023 13:02, marshall.shao@dell.com wrote:
> From: Marshall Shao <Marshall.Shao@dell.com>
> 
> This patch fixes a kernel panic issue after removing the igb driver
> from the usermode.
> 
> A delayed work will be schedule in igb_ptp_init(),
> 
> 	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> 		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
> 				  igb_ptp_overflow_check);
> 
> If CONFIG_PTP_1588_CLOCK is not enabled, the delayed work cannot be
> cancelled when igb_ptp_suspend is called.

But should this work be inited in case there is no PTP support in the
kernel? Maybe it's better to avoid any driver threads in this case and
move the initialization to the if block where we know that PHC device
is created and working?

> 
> Signed-off-by: Marshall Shao <Marshall.Shao@dell.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_ptp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index 405886ee5261..b21822ea1c7d 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -1435,12 +1435,12 @@ void igb_ptp_sdp_init(struct igb_adapter *adapter)
>    */
>   void igb_ptp_suspend(struct igb_adapter *adapter)
>   {
> -	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
> -		return;
> -
>   	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
>   		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
>   
> +	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
> +		return;
> +
>   	cancel_work_sync(&adapter->ptp_tx_work);
>   	if (adapter->ptp_tx_skb) {
>   		dev_kfree_skb_any(adapter->ptp_tx_skb);


