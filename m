Return-Path: <netdev+bounces-171500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4BA4D3A3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 07:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C98316D990
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A131F4264;
	Tue,  4 Mar 2025 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EKt6CdS/"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904AF152E02;
	Tue,  4 Mar 2025 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069093; cv=none; b=K8It7uIk3+KKTXIMKZh9BAZkEruGqgqAG/4RMbmOYL57ONfvr+ZT4b+oBVA3ONXyoH8EgoTxR877P5YpRliPO8gPu03J5WtmmpHaPlWj8R+ks257sahbkivtBUaoPsT4zxWOU3foMaDuap3UOIYoKaJZLIFK4HDvez1AoHUT68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069093; c=relaxed/simple;
	bh=QQOkh+3wVSJzLYJ7viJ3y47huTC98CGWMWaPdnjnjYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h8AxEa8yunKQ6cyDuUSW1nrp+iTg16uQ1mosRyBsbpkV8M4CZ/LnJ2L9v/M0edKcAsUnCVILcoO29m4UomEwg9SVjgUJXexIoX7SIHduwz85hu1KzmntyIBkDO6jZvVVAPVK9FJBNHI+qe6+SzR0IhF3iCJELrZtYt2Dua0Og+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EKt6CdS/; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5246HgYw3517465
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 4 Mar 2025 00:17:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741069062;
	bh=N9Y4JwuClarjXzxVWt1JrUj/6OJyXCE1bCRokMfQHlc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EKt6CdS/C6CBn25rAj78txKmE0D06kNV72m3EPZ0rkROu3/m+3MS2njKqxjDcCxFp
	 3BAEkq6O2IUL85Ul1fEM0yqTwL8R0voELQIKt5j+5y6awTG3jQA3Qge4sKuIkF6eKj
	 TU2XwMcBgqIWPYlYb/6W/O8bDqKjv9Suamshx1PA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5246HgB8028403;
	Tue, 4 Mar 2025 00:17:42 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 00:17:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 00:17:42 -0600
Received: from [172.24.31.59] (lt9560gk3.dhcp.ti.com [172.24.31.59])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5246HZvQ106977;
	Tue, 4 Mar 2025 00:17:36 -0600
Message-ID: <5cad21ef-a97b-4412-a399-7ace69b85356@ti.com>
Date: Tue, 4 Mar 2025 11:47:35 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 1/2] net: ti: icss-iep: Add
 pwidth configuration for perout signal
To: Kory Maincent <kory.maincent@bootlin.com>
CC: <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <horms@kernel.org>, <jacob.e.keller@intel.com>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250303135124.632845-1-m-malladi@ti.com>
 <20250303135124.632845-2-m-malladi@ti.com>
 <20250303180323.1d9b51de@kmaincent-XPS-13-7390>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250303180323.1d9b51de@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 3/3/2025 10:33 PM, Kory Maincent wrote:
> On Mon, 3 Mar 2025 19: 21: 23 +0530 Meghana Malladi <m-malladi@ ti. com> 
> wrote: > icss_iep_perout_enable_hw() is a common function for generating 
>  > both pps and perout signals. When enabling pps, the application needs 
>  > to only pass
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uVdqXRfP1m17KmZFPNPjnPB9kIuFmkbGwUjWeOt4PhpPuyUdhbWQXCWjPIg3CE7zH4vA7aR5lJOdoby6lh8SIqLqdFhb$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Mon, 3 Mar 2025 19:21:23 +0530
> Meghana Malladi <m-malladi@ti.com> wrote:
> 
>> icss_iep_perout_enable_hw() is a common function for generating
>> both pps and perout signals. When enabling pps, the application needs
>> to only pass enable/disable argument, whereas for perout it supports
>> different flags to configure the signal.
>> 
>> But icss_iep_perout_enable_hw() function is missing to hook the
>> configuration params passed by the app, causing perout to behave
>> same a pps (except being able to configure the period). As duty cycle
>> is also one feature which can configured for perout, incorporate this
>> in the function to get the expected signal.
> 
> ...
> 
>> IEP_SYNC_CTRL_SYNC_EN); @@ -474,7 +484,38 @@ static int
>> icss_iep_perout_enable_hw(struct icss_iep *iep, static int
>> icss_iep_perout_enable(struct icss_iep *iep, struct ptp_perout_request *req,
>> int on) {
>> -	return -EOPNOTSUPP;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&iep->ptp_clk_mutex);
>> +
>> +	/* Reject requests with unsupported flags */
>> +	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE) {
>> +		ret = -EOPNOTSUPP;
>> +		goto exit;
>> +	}
> 
> The flags check does not need to be in the mutex lock.
> With this change:
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> 

Yes agreed, will move it outside the mutex lock. Thanks.

>> +	if (iep->pps_enabled) {
>> +		ret = -EBUSY;
>> +		goto exit;
>> +	}
>> +
>> +	if (iep->perout_enabled == !!on)
>> +		goto exit;
>> +
>> +	/* Set default "on" time (1ms) for the signal if not passed by the
>> app */
>> +	if (!(req->flags & PTP_PEROUT_DUTY_CYCLE)) {
>> +		req->on.sec = 0;
>> +		req->on.nsec = NSEC_PER_MSEC;
>> +	}
>> +
>> +	ret = icss_iep_perout_enable_hw(iep, req, on);
>> +	if (!ret)
>> +		iep->perout_enabled = !!on;
>> +
>> +exit:
>> +	mutex_unlock(&iep->ptp_clk_mutex);
>> +
>> +	return ret;
>>  }
>>  
>>  static void icss_iep_cap_cmp_work(struct work_struct *work)
>> @@ -553,6 +594,8 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int
>> on) rq.perout.period.nsec = 0;
>>  		rq.perout.start.sec = ts.tv_sec + 2;
>>  		rq.perout.start.nsec = 0;
>> +		rq.perout.on.sec = 0;
>> +		rq.perout.on.nsec = NSEC_PER_MSEC;
>>  		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
>>  	} else {
>>  		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
> 
> 
> 
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://urldefense.com/v3/__https://bootlin.com__;!!G3vK! 
> TJ19I0FAUivlehxg6fb4ka96Q2RiJDOZNyHXmEeRdYIPu4Cthp- 
> iiGCHOwcUnPvn8Ek_htiuIef9PMEWGUfBEA$ <https://urldefense.com/v3/__https://bootlin.com__;!!G3vK!TJ19I0FAUivlehxg6fb4ka96Q2RiJDOZNyHXmEeRdYIPu4Cthp-iiGCHOwcUnPvn8Ek_htiuIef9PMEWGUfBEA$>
> 


