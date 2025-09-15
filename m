Return-Path: <netdev+bounces-222919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D306B57039
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D55C3BD471
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 06:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1B27A93A;
	Mon, 15 Sep 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UBPDzdM3"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564417C21E
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917651; cv=none; b=WXKlWVOAeQmsjOGsZQ5cDSrYDz4PWx6JnqId1IFZIEkGdkx1S8MNsIcs/Xy9OpamuNS/qpDzVJdHXyyuSXbrAE1fVBlZxK/fUI6Tqw2oeG2gW6+RIRrqoyhZq+h81MW6Zx72krRAnY1YhMqdQO7gCRGA0q3pExzSI2HPbRs5XEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917651; c=relaxed/simple;
	bh=Zo0I9+0+r5vqkiQWt4oR8UnvtykhV+2zTVJdLt1bnJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDB6zUknhUWlshT0ENi2YFtGW05B/ODSko9WLSiOqQIfRjRGscZ7yuIIMOYGEBcCruQHbIbUynAqAb/J46p8c4S98r21Aat/VCQuEogzRjSfDHw4sSmpZNLqoWiKY+pTIQ3SC1dIzM9mCrsvCF4h+hY99bn8lzr7xHkp6J6OJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UBPDzdM3; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757917650; x=1789453650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0cx64MLt6wOLnGfchORu8msW59PuoSYedOvwRKPWZz0=;
  b=UBPDzdM3s1Nus7Odc1D3HEMWR5R+0CsLkH1TJcK0KwOXs52xtUNqFSjd
   TjBb/pcysQAQxuZX0bow7oejts7kNrU+0wrBGZ4nKQQ6GpTVUAVoTMXlp
   72AyUAgsDGmKgiCQq1fkmW62esLufjaCv8E/eEQ/F3wJ2HFVPcOryB4yS
   paaAGNqskh5erI22zuVtFmye1wWKdWtf3vZRBd5SUGKgUCHznavj6eql3
   aN+qUmhZ4LzCR0Yuslohig+wJYHIA80NiyjmNxfN0RC03Ws1oZc8DZcD3
   aoq1tR5s/FgrvFOvWPp1071L3Nzukd6icWLl+IGdobb3fTpH+dEkVCemN
   A==;
X-CSE-ConnectionGUID: o2vD+q8zRFKQdLkWLGH3mg==
X-CSE-MsgGUID: t1Y+BNU1RiaI/AD/xghYWg==
X-IronPort-AV: E=Sophos;i="6.18,265,1751241600"; 
   d="scan'208";a="2988076"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 06:27:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:4553]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.105:2525] with esmtp (Farcaster)
 id 53496f85-2d7e-4b5d-9ed1-690a7113ee27; Mon, 15 Sep 2025 06:27:26 +0000 (UTC)
X-Farcaster-Flow-ID: 53496f85-2d7e-4b5d-9ed1-690a7113ee27
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 06:27:26 +0000
Received: from b0be8375a521.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 06:27:23 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <vitaly.lifshits@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igc: power up PHY before link test
Date: Mon, 15 Sep 2025 15:27:06 +0900
Message-ID: <20250915062715.48528-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <5d795b34-1ad7-4250-b7fd-0b8558e30b5e@intel.com>
References: <5d795b34-1ad7-4250-b7fd-0b8558e30b5e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

+ Alex

On Sun, 7 Sep 2025 16:51:53 +0300, Lifshits, Vitaly wrote:

>On 9/6/2025 6:49 AM, Kohei Enju wrote:
>> On Mon, 1 Sep 2025 07:36:21 +0300, Lifshits, Vitaly wrote:
>> 
>>>
>>>> ---
>>>>    drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>>>> index f3e7218ba6f3..ca93629b1d3a 100644
>>>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>>>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>>>> @@ -2094,6 +2094,9 @@ static void igc_ethtool_diag_test(struct net_device *netdev,
>>>>    		netdev_info(adapter->netdev, "Offline testing starting");
>>>>    		set_bit(__IGC_TESTING, &adapter->state);
>>>>    
>>>> +		/* power up PHY for link test */
>>>> +		igc_power_up_phy_copper(&adapter->hw);
>>>
>>> I suggest moving this to igc_link_test functionn igc_diags.c as it
>>> relates only to the link test.
>> 
>> Thank you for taking a look, Lifshits.
>> 
>> Now I'm considering changing only offline test path, not including
>> online test path.
>> This is because I think online test path should not trigger any
>> interruption and power down/up PHY may cause disruption.
>> 
>> So, I forgo the online path and my intention for this patch is to power
>> up PHY state only in offline test path.
>> I think introducing igc_power_up_phy_copper() in igc_link_test()
>> needs careful consideration in online test path.
>
>Yes, I see that now.
>Then it's ok to leave it as is.

Sorry for late response. Thank you for taking a look, Vitaly!

>
>Regarding the question whether to wrap igc_power_up_phy_copper with an 
>if (hw->phy.media_type == igc_media_type_copper), I think that it's not 
>necessary. First of all, igc devices are only copper devices. Secondly, 
>in the other place where we call this function (in igc_main), we don't 
>check the media type, therefore I suggest being consistent with the 
>already existing code and leaving it as it is now.

Indeed, I think you're right.

I looked at the existing code and found that indeed there are codes
which are assuming only copper devices at least for now. [1, 2, 3]

So, I'll rephrase the commit message in v2 to clarify:
- This change is applied only for offline testing, forgoing online
  testing.
- In this case, original power state is restored in igc_reset()
  afterwards.

and leave the diff as it is in V2 patch.

>
>> 
>>>
>>>> +
>>>>    		/* Link test performed before hardware reset so autoneg doesn't
>>>>    		 * interfere with test result
>>>>    		 */
>>>
>>>
>>> Thank you for this patch.

Thanks, 
Kohei

[1] igc_main.c
```
void igc_reset(struct igc_adapter *adapter)
{
  ...
  if (!netif_running(adapter->netdev))
      igc_power_down_phy_copper_base(&adapter->hw);
```

[2] igc_main.c
```
static void igc_power_up_link(struct igc_adapter *adapter)
{
  ...
  igc_power_up_phy_copper(&adapter->hw);
```

[3] igc_main.c
```
static int __igc_open(struct net_device *netdev, bool resuming)
{
  ...
  err_req_irq:
  igc_release_hw_control(adapter);
  igc_power_down_phy_copper_base(&adapter->hw);
```

