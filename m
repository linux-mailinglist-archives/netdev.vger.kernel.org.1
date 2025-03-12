Return-Path: <netdev+bounces-174158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04640A5DA1A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE4C189AE68
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A5D23BD0C;
	Wed, 12 Mar 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DXMLtJG3"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555E23A9A5
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773855; cv=none; b=r5aBwTXSO/Gt/RDzCF2qrjqpi5RF5Pddr64Q5K0ZKEbi9tZ3ua4v6JBSgfoKCr3NG4hmZmErenjOW4lGV4Nna900R5Ku9Lp5lMFZJCZK48I8wQHV8zC/cbp1zsyVUNQ9kyV7L+1SWOu1dFja27Hbt5MymIqu0y8oiIqfl3mP+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773855; c=relaxed/simple;
	bh=KJdF+mAbpGv13SIHL7mrYCm+ztOOplRrVNJLrMedj2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rk/VLrrI2+d7sPATIsy0zWfsjZT4aVJBtOO/BxZSVarB+LrI68My6qSda5TOguKbTe/uRAA0kjLoToqeb8dvQgIHGQXrgD+FH/I+fvp5PAR+Z0/U9Wv0dUT0jQK1tcBdEM1mYXXtFgDkFbNyZqXzubt6PgKMBQjDCJ9CB91K5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DXMLtJG3; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52CA4BDv1554069
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 05:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741773851;
	bh=Y5GWT+afwxSQq+G6ca2xkYsq9R2dvG1P+smCsz/MbSQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DXMLtJG3D6xZGcmBh8eAUUIKGzFbtQdrvTF0zFASIR0BGbXGlTa2YXbwWGMUBXcn1
	 ubdtTR4iPAKemD0E2paxc/nV5rZ75nWUAgK+9CpJy1DyKOz2F8/F8MVFhg2GvZxGZf
	 wRqBIF10XEOLJJ9QZfnVlXsTO3XgYIJCJcTTOMVQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52CA4Bk6025229
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Mar 2025 05:04:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 05:04:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 05:04:10 -0500
Received: from [172.24.18.65] (lt9560gk3.dhcp.ti.com [172.24.18.65])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52CA49Ko073242;
	Wed, 12 Mar 2025 05:04:10 -0500
Message-ID: <3d9f0933-cf49-48f9-8014-df6d4dc568dc@ti.com>
Date: Wed, 12 Mar 2025 15:34:08 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [bug report] net: ti: icss-iep: Add pwidth
 configuration for perout signal
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <netdev@vger.kernel.org>, "Anwar, Md Danish" <danishanwar@ti.com>
References: <7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dan,

On 3/12/2025 2:00 PM, Dan Carpenter wrote:
> Hello Meghana Malladi, Commit e5b456a14215 ("net: ti: icss-iep: Add 
> pwidth configuration for perout signal") from Mar 4, 2025 (linux-next), 
> leads to the following Smatch static checker warning: drivers/net/ 
> ethernet/ti/icssg/icss_iep. c: 825 icss_iep_exit()
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uldq91elFod7SsXEXBPp_9qX4ctECpS267LMjuddHxR5XHrYWmLvT3__LcAfcksmi66Dt81ZKpDRPzWAf4qxRVheEM2g0eVMTQ0PmIw$>
> ZjQcmQRYFpfptBannerEnd
> 
> Hello Meghana Malladi,
> 
> Commit e5b456a14215 ("net: ti: icss-iep: Add pwidth configuration for
> perout signal") from Mar 4, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/net/ethernet/ti/icssg/icss_iep.c:825 icss_iep_exit()
> 	error: NULL dereference inside function icss_iep_perout_enable()
> 
> drivers/net/ethernet/ti/icssg/icss_iep.c
>      815 {
>      816         if (iep->ptp_clock) {
>      817                 ptp_clock_unregister(iep->ptp_clock);
>      818                 iep->ptp_clock = NULL;
>      819         }
>      820         icss_iep_disable(iep);
>      821
>      822         if (iep->pps_enabled)
>      823                 icss_iep_pps_enable(iep, false);
>      824         else if (iep->perout_enabled)
> --> 825                 icss_iep_perout_enable(iep, NULL, false);
>                                                      ^^^^
> Originally icss_iep_perout_enable() just returned -ENOTSUPP but now it
> needs a valid "req" pointer.

Thanks for identifying this bug. I will post a fix for this shortly.

regards,
Meghana Malladi

>      826
>      827         return 0;
>      828 }
> 
> regards,
> dan carpenter
> 


