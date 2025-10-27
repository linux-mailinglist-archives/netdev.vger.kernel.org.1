Return-Path: <netdev+bounces-233172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF2DC0D7EC
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39B4B34D4A4
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617D3009F7;
	Mon, 27 Oct 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="F0Ci4ne2"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF432FDC3F
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567894; cv=none; b=JkRl0zJHfTAbBrs9D2BgTSDm6liFcwtBurM0Xcw2YypgwRwiHInoDG9ok1mwFrn9lbjRHPT4jvt6PcW6RddSULcfHzd+14LA1o8Onvb7pI00Pg43xf7BVdd7U8IB+8Ss33dJN7yj0OJ7pEg7ymD9XUox5io3CK8aHBVqrtua8EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567894; c=relaxed/simple;
	bh=+RyZMr44ePS9IxhF1+DAq/fz9kbSF4Uu8qUbK8YCFR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8yPWmXGdjTN5d2g0xfOBngZTBocJOJk+WT49MnsTD9nUXhFDE8cIV3ov+A2NwnT23aCTAZ92rM3j/myZon8ANMdrjoPmUE+9MQqdZ4XADut+y/ujh/7UEuvpbuExoIN6pKcfBjKtoTy0V2WWynBhsVahAsE8VcKLV5UnnXBQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=F0Ci4ne2; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761567892; x=1793103892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WrJLIDy5DjO1Qi1gKZCpTvgxvq7dxgqrY3OppodPWIs=;
  b=F0Ci4ne2JK0PNDUmQ1DG1Zc0krcxhh/lM2384XYmliX22m9iinOtC12j
   G3jESGR246jo3lJXjnwAmxhJYHQQ0fEJIQQ54ZeBAm9Kz/Bdi/1HOZyjL
   nQpWXnyeaRsBOTSZFHTb0ykbzWUYUDirbIsf2xkAhxajuZYJEstAiOg/p
   V7DmMwjDe4LH4+JTnF57AYJMSmLBrf8r+Tsqg7Pojfv8E0DmQ7wPDQSrp
   g6pJ5FoGUczStgDHTXHOqMMF3tAH9HzGO7SW/PCLRixP2a4plR+CI1usr
   tppESiFO/7ukI2MaEmFqvdlW2H0HUg6qz9ysgFvJkCZM1dpDkZTJQzlbo
   w==;
X-CSE-ConnectionGUID: LzM7aC4yS8ayhj9JELmetQ==
X-CSE-MsgGUID: sQM+1O4oQkuQLKQYyS0+QQ==
X-IronPort-AV: E=Sophos;i="6.19,258,1754956800"; 
   d="scan'208";a="5597335"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 12:24:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:18342]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.61:2525] with esmtp (Farcaster)
 id a5010076-be11-4429-adff-4f15b9de8100; Mon, 27 Oct 2025 12:24:49 +0000 (UTC)
X-Farcaster-Flow-ID: a5010076-be11-4429-adff-4f15b9de8100
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 27 Oct 2025 12:24:47 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 27 Oct 2025 12:24:44 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <przemyslaw.kitszel@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <mitch.a.williams@intel.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] iavf: fix off-by-one issues in iavf_config_rss_reg()
Date: Mon, 27 Oct 2025 21:24:21 +0900
Message-ID: <20251027122435.22442-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ada06185-257b-46de-9e5b-470f2724f014@intel.com>
References: <ada06185-257b-46de-9e5b-470f2724f014@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 27 Oct 2025 13:13:54 +0100, Przemek Kitszel wrote:

>On 10/25/25 18:58, Kohei Enju wrote:
>> There are off-by-one bugs when configuring RSS hash key and lookup
>> table, causing out-of-bounds reads to memory [1] and out-of-bounds
>> writes to device registers.
>> 
>> Before commit 43a3d9ba34c9 ("i40evf: Allow PF driver to configure RSS"),
>> the loop upper bounds were:
>>      i <= I40E_VFQF_{HKEY,HLUT}_MAX_INDEX
>> which is safe since the value is the last valid index.
>> 
>> That commit changed the bounds to:
>>      i <= adapter->rss_{key,lut}_size / 4
>> where `rss_{key,lut}_size / 4` is the number of dwords, so the last
>> valid index is `(rss_{key,lut}_size / 4) - 1`. Therefore, using `<=`
>> accesses one element past the end.
>> 
>> Fix the issues by using `<` instead of `<=`, ensuring we do not exceed
>> the bounds.
>> 
>> [1] KASAN splat about rss_key_size off-by-one
>>    BUG: KASAN: slab-out-of-bounds in iavf_config_rss+0x619/0x800
>>    Read of size 4 at addr ffff888102c50134 by task kworker/u8:6/63
>> 
>
>[...]
>
>> 
>> Fixes: 43a3d9ba34c9 ("i40evf: Allow PF driver to configure RSS")
>> Signed-off-by: Kohei Enju <enjuk@amazon.com>
>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> index c2fbe443ef85..4b0fc8f354bc 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> @@ -1726,11 +1726,11 @@ static int iavf_config_rss_reg(struct iavf_adapter *adapter)
>>   	u16 i;
>>   
>>   	dw = (u32 *)adapter->rss_key;
>> -	for (i = 0; i <= adapter->rss_key_size / 4; i++)
>> +	for (i = 0; i < adapter->rss_key_size / 4; i++)
>>   		wr32(hw, IAVF_VFQF_HKEY(i), dw[i]);
>>   
>>   	dw = (u32 *)adapter->rss_lut;
>> -	for (i = 0; i <= adapter->rss_lut_size / 4; i++)
>> +	for (i = 0; i < adapter->rss_lut_size / 4; i++)
>>   		wr32(hw, IAVF_VFQF_HLUT(i), dw[i]);
>
>this is generally the last defined register mapping,
>so I get why KASAN is able to report a violation here
>(I assume that we map "just enough")

Just to clarify, I think KASAN is detecting OOB read access to the slab
memory region (dw[i]), and not detecting register write access (wr32())
directly. 

Anyway, thank you for reviewing, Przemek!

>
>impressive, and thanks for the fix!
>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>
>>   
>>   	iavf_flush(hw);
>
>

