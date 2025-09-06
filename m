Return-Path: <netdev+bounces-220552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1301B468C1
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 06:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03AA1BC7596
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4521DE894;
	Sat,  6 Sep 2025 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IbwzF3pq"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349229A2
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757131434; cv=none; b=YRM49PXsp53lILA3h/VOFEIHbipAWv72wsNcX28KAyGzPadaGqARvTDOAQmUf1zG7MR87UjiAOaV0GlvD+FwaGuyuRWbD4j9bkTd6p9xha/zQWzolteEE9GryQc9N+wFWXh95LuycFFX7qgGyTlVj+lYXqQrF85QhTQE7so1flo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757131434; c=relaxed/simple;
	bh=jJDZY5SWYw6GMgJ9sawqFGdl4UvDAHdVkzonytw2GaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6RAkjkndGE5ECtpFEYKhi3+3WLHt4EMKC014kd22N9Ti6+5aAeFDGxyULIuK+159iTInXJDMfHxyBrOzkE9YvBXN47wKrIhdr73ue2BOq/3WO7TinzmcBDlqbUKUqM+cFU82C0B8empWAoeFytUf0iBFNqD7/91P4QeZs+rpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IbwzF3pq; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757131432; x=1788667432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J5ZOTt1HaPJaQ6DJyafCrxQeclOH3Tq1B3XLAa0dGoU=;
  b=IbwzF3pq/N1vvZrMfjd+SWrYHexUTsXv194pVAB/BSUbImTqxrvVFgjq
   VGhZE3BqKZ3EyQ4pumy7hu7gQTowFSkwaQohN2UYWyk9MTkpw/Tiw+f0N
   RvhBOchbAeP74UJE8ZaWzVKAD2wDcPvXoI2FKRe3aX/h42tWoJTNNfR9C
   EZRGie02YJtWBETWw3Pv5pq2BRr2Qg62e4JTXJ5TrzazG4YJANATgthbS
   31npabgBlVBb1/Mb5SPKk6R0FOghd2CeORJmi2J6k9PEfLG5DAvz7hOfF
   8mZNr/HRx/ir98KisDSwIlQ/HbOHdWpuYwvjQJA0LVZVE57ILX1vD4puQ
   g==;
X-CSE-ConnectionGUID: LcO5SYmSRgeaOoJAAZED9g==
X-CSE-MsgGUID: G2+nnun5Q/KylIEbs/+NXg==
X-IronPort-AV: E=Sophos;i="6.18,243,1751241600"; 
   d="scan'208";a="2411794"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 04:03:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:41364]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.106:2525] with esmtp (Farcaster)
 id d28f64c9-f167-4aa0-acdb-b99228e97b22; Sat, 6 Sep 2025 04:03:50 +0000 (UTC)
X-Farcaster-Flow-ID: d28f64c9-f167-4aa0-acdb-b99228e97b22
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 04:03:50 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 04:03:48 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <vitaly.lifshits@intel.com>
Subject: Re: RE: [Intel-wired-lan] [PATCH v1 iwl-net] igc: power up PHY before link test
Date: Sat, 6 Sep 2025 13:03:38 +0900
Message-ID: <20250906040340.87510-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <IA3PR11MB8986CD55611A08A9AB8B6DF1E507A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986CD55611A08A9AB8B6DF1E507A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 1 Sep 2025 07:03:34 +0000, Loktionov, Aleksandr wrote:

[...]
>>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index f3e7218ba6f3..ca93629b1d3a 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -2094,6 +2094,9 @@ static void igc_ethtool_diag_test(struct
>> net_device *netdev,
>>  		netdev_info(adapter->netdev, "Offline testing
>> starting");
>>  		set_bit(__IGC_TESTING, &adapter->state);
>> 
>> +		/* power up PHY for link test */
>> +		igc_power_up_phy_copper(&adapter->hw);
>> +
>1.You unconditionally power the PHY up but you don't restore the previous power state at the end of the test.

You're right about the concern, but it's already handled by the existing 
code flow:
    /* power up PHY for link test */
	igc_power_up_phy_copper(&adapter->hw);

    /* doing link test */

    if (if_running)
        igc_close(netdev);
    else
        igc_reset(adapter);
        
    /* other tests */
    igc_reset(adapter);

igc_reset() calls igc_power_down_phy_copper_base() when !netif_running(), 
so the PHY is properly powered down again.

>2. igc_power_up_phy_copper() returns a status, but you ignore it. If the MDIO access fails (e.g., bus issue), you should mark the link test as failed and continue with the rest...

Hmm, indeed I didn't check the status, but should I tweak `void
igc_power_up_phy_copper(struct igc_hw *hw)` itself?

My intention was to try to power up PHY if possible, but give it up when
not possible (e.g., bus issue). When powering up is not successful, that
is, PHY is still powered down, igc_link_test() should fail as it does so
now.

>n. igc is predominantly copper, but it's still best practice to guard with: 	if (hw->phy.media_type == igc_media_type_copper) or or check that hw->phy.type != igc_phy_none

Got it. I'll do that in v2.

>
>>  		/* Link test performed before hardware reset so autoneg
>> doesn't
>>  		 * interfere with test result
>>  		 */
>> --
>> 2.48.1

