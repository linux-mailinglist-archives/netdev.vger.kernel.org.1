Return-Path: <netdev+bounces-226740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46FBA49E1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621841BC63D4
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709F82620E4;
	Fri, 26 Sep 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kQB/e5tm"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5D261B71;
	Fri, 26 Sep 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904058; cv=none; b=Gwg2liVeY+iY5VuLcFrOXHN/gXx/n2cKAK41M2XLFCdWogZXENb3DFHI57Q82yNB5Z8SodmXLzbn5sykfaHUC2DZVa7IQ/7Fwlo2s30UOn3HmY1FyrM5ds62JDkWdBJw2/Y+nM14YWHpYUV6I0xC8AmNzqsMcWJgIstG1G9XKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904058; c=relaxed/simple;
	bh=XfytwEFSArTnwGJWxKM/p45Q2hYGLlSoDYRTRMyG9Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BGDERoWhtbEN9Bwp1Uc1dFXuStWBfLG5bUmlMj8UUDKjQcjYB3B4CAx8y8poxlpMdOAxpa3cg9TQ3T1Ilo+H3FTGq7O6ub7+JQAi+HtyY6z5jEjGBAaTAgPxD/VEi9UK9XSsS2XwWZB2IISErczrPXt00Nzl575adjtx5SMfT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kQB/e5tm; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58QGR7701696030;
	Fri, 26 Sep 2025 11:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758904027;
	bh=zDKfLZc/kGlFP0DQqYCTgcQ569DeIzDh2t/0gNXzU5w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kQB/e5tmhiadW7rOAmoR5bFpjqGR8ejQXu16Xvgr1wy3KdrWlgOHQEjHR0oG/f3n+
	 Bu0xQ+mSLK+MKGPqtmYR73B6M6GVUHLDzQlVV7wCZiB2OAVhQVbS7wTSUtxuzXE6Ar
	 k6R0a0ADhPAYGGJkNSIge5bRiVmDhMoM3YONQS7c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58QGR7AP4108401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 26 Sep 2025 11:27:07 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 26
 Sep 2025 11:27:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 26 Sep 2025 11:27:06 -0500
Received: from [10.249.139.123] ([10.249.139.123])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58QGR3vZ1582454;
	Fri, 26 Sep 2025 11:27:04 -0500
Message-ID: <ef2bd666-f320-4dc5-b7ae-d12c0487c284@ti.com>
Date: Fri, 26 Sep 2025 21:57:02 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: netcp: Fix crash in error path when DMA channel open
 fails
To: Simon Horman <horms@kernel.org>, Nishanth Menon <nm@ti.com>
CC: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <s-vadapalli@ti.com>
References: <20250926150853.2907028-1-nm@ti.com>
 <aNa7rEQLJreJF58p@horms.kernel.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <aNa7rEQLJreJF58p@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 26/09/25 9:43 PM, Simon Horman wrote:
> On Fri, Sep 26, 2025 at 10:08:53AM -0500, Nishanth Menon wrote:
>> When knav_dma_open_channel() fails in netcp_setup_navigator_resources(),
>> the rx_channel field is set to an ERR_PTR value. Later, when
>> netcp_free_navigator_resources() is called in the error path, it attempts
>> to close this invalid channel pointer, causing a crash.
>>
>> Add a check for ERR values to handle the failure scenario.
>>
>> Fixes: 84640e27f230 ("net: netcp: Add Keystone NetCP core driver")
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>
>> Seen on kci log for k2hk: https://dashboard.kernelci.org/log-viewer?itemId=ti%3A2eb55ed935eb42c292e02f59&org=ti&type=test&url=http%3A%2F%2Ffiles.kernelci.org%2F%2Fti%2Fmainline%2Fmaster%2Fv6.17-rc7-59-gbf40f4b87761%2Farm%2Fmulti_v7_defconfig%2BCONFIG_EFI%3Dy%2BCONFIG_ARM_LPAE%3Dy%2Bdebug%2Bkselftest%2Btinyconfig%2Fgcc-12%2Fbaseline-nfs-boot.nfs-k2hk-evm.txt.gz
>>
>>   drivers/net/ethernet/ti/netcp_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
>> index 857820657bac..4ff17fd6caae 100644
>> --- a/drivers/net/ethernet/ti/netcp_core.c
>> +++ b/drivers/net/ethernet/ti/netcp_core.c
>> @@ -1549,7 +1549,7 @@ static void netcp_free_navigator_resources(struct netcp_intf *netcp)
>>   {
>>   	int i;
>>   
>> -	if (netcp->rx_channel) {
>> +	if (!IS_ERR(netcp->rx_channel)) {
>>   		knav_dma_close_channel(netcp->rx_channel);
>>   		netcp->rx_channel = NULL;
>>   	}
> 
> Hi Nishanth,
> 
> Thanks for your patch.
> 
> I expect that netcp_txpipe_close() has a similar problem too.
> 
> But I also think that using IS_ERR is not correct, because it seems to me
> that there are also cases where rx_channel can be NULL.

Could you please clarify where rx_channel is NULL? rx_channel is set by 
invoking knav_dma_open_channel(). Also, please refer to:
https://github.com/torvalds/linux/commit/5b6cb43b4d62
which specifically points out that knav_dma_open_channel() will not 
return NULL so the check for NULL isn't required.
> 
> I see that on error knav_dma_open_channel() always returns ERR_PTR(-EINVAL)
> (open coded as (void *)-EINVAL) on error. So I think a better approach
> would be to change knav_dma_open_channel() to return NULL, and update callers
> accordingly.

The commit referred to above made changes to the driver specifically due 
to the observation that knav_dma_open_channel() never returns NULL. 
Modifying knav_dma_open_channel() to return NULL will effectively result 
in having to undo the changes made by the commit.


