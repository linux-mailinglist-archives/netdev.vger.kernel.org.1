Return-Path: <netdev+bounces-16676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BAB74E474
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 04:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3D02814EC
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 02:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D311843;
	Tue, 11 Jul 2023 02:49:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877D7F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 02:49:49 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE7120;
	Mon, 10 Jul 2023 19:49:47 -0700 (PDT)
X-QQ-mid:Yeas43t1689043677t873t55355
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.130.21])
X-QQ-SSF:00400000000000F0FPF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2893266932846902209
To: "'YueHaibing'" <yuehaibing@huawei.com>,
	<mengyuanlou@net-swift.com>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>
Cc: <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20221105080722.20292-1-yuehaibing@huawei.com> <20221105080722.20292-3-yuehaibing@huawei.com>
In-Reply-To: <20221105080722.20292-3-yuehaibing@huawei.com>
Subject: RE: [PATCH net-next 2/2] net: txgbe: Fix unsigned comparison to zero in txgbe_calc_eeprom_checksum()
Date: Tue, 11 Jul 2023 10:47:56 +0800
Message-ID: <031801d9b3a2$191cc510$4b564f30$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFi2DHPEYcXaQ1O7miR/ExBhxCcIQE5uFuqsJfCJPA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Saturday, November 5, 2022 4:07 PM, YueHaibing wrote:
> The error checks on checksum for a negative error return always fails because
> it is unsigned and can never be negative.
> 
> Fixes: 049fe5365324 ("net: txgbe: Add operations to interact with firmware")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
> index 9cf5fe33118e..167f7ff73192 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
> @@ -200,10 +200,11 @@ static int txgbe_calc_eeprom_checksum(struct txgbe_hw *hw, u16 *checksum)
>  	if (eeprom_ptrs)
>  		kvfree(eeprom_ptrs);
> 
> -	*checksum = TXGBE_EEPROM_SUM - *checksum;
> -	if (*checksum < 0)
> +	if (*checksum > TXGBE_EEPROM_SUM)
>  		return -EINVAL;
> 
> +	*checksum = TXGBE_EEPROM_SUM - *checksum;
> +
>  	return 0;
>  }

It is a pity, I didn't review this patch carefully. *checksum will sometimes
be larger than TXGBE_EEPROM_SUM. It's correct to remove these two lines:

-	if (*checksum < 0)
-		return -EINVAL;

I'll send a patch to fix it.


