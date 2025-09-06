Return-Path: <netdev+bounces-220551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F833B468B4
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 05:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378F45A7C29
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D5D221DBD;
	Sat,  6 Sep 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KkrT+Agu"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8142217F36
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 03:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757130608; cv=none; b=H1hT0q8HdtIzell6g3IVVM0NdWhX2CFHBo0IZ2kWMw0nfuG4VI3M7JH1J28zQ8aiwizMia89x+U/gsWpank5sxsybpNVY83eogQ4g1JdytkOXLj1CpP7KVgzjFy4Wcm675HNxJrn6iuJPUG06NbhFqJa3PSG2B4KpN+v4XVNDq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757130608; c=relaxed/simple;
	bh=B/7G1iOAWOvs64Z0twQKj+uwkpczUrnOduoIVkvt1qQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EE3zv7ZYylKVb3qXloofy88GiZMqJ4lGpnkgFd3ghyL2oIdOL9KkqGyVY1/EwSX2qiOk7yCwbMSc4yW2M4QVznRAsSAgKH6Kb0vhOa8PTmzHB9nGmdb5Wuf6zJDslj8cjYFmB6j901N0WjJI1wGpj179P75umxwVb/ikXKsTgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KkrT+Agu; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757130606; x=1788666606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aO8+nEpF99IvHNQjRBfgpFFnyCKBbemhn1G4CvD32TY=;
  b=KkrT+AguFDZi3eV/y+gtbNwB38rWofzh3OQB+vc0GUHEm/jkVvX2yNe8
   Z7lkbF9rrOKValL3RvhOl9ySBec4xsxqc7Jyo1Z4aVoDUJMuU9rFm7hDh
   y8lAsN0Khher+O4ZONvMgH3cJlWwa1zWtcBhQkRg7XXLyaP+u/al2Dnia
   3DWPpMwH4fRr1wvjziqBFZ6eNWwdP5BSwVwnLhlmB2kayIiESgsCz59IC
   9aIhtQwzifMBzdvA6FXcLoLakDzU+Jno32TkLCm70GDKAJ/HPFWXFiKw+
   qpEchZ/tkwczfOhxSNjZr0bFchL4hCgkhAoO098XEy2hUCEUmsdqfBGZ6
   A==;
X-CSE-ConnectionGUID: JS+jbI/BQc+4/mnO851DDw==
X-CSE-MsgGUID: iVXFn2O7T66wRf5aBabymQ==
X-IronPort-AV: E=Sophos;i="6.18,243,1751241600"; 
   d="scan'208";a="2523582"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 03:50:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:56062]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.19:2525] with esmtp (Farcaster)
 id 114baa6d-9cb5-424e-a946-24af8906c8bc; Sat, 6 Sep 2025 03:50:04 +0000 (UTC)
X-Farcaster-Flow-ID: 114baa6d-9cb5-424e-a946-24af8906c8bc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 03:50:04 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 03:50:02 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <vitaly.lifshits@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH v1 iwl-net] igc: power up PHY before link test
Date: Sat, 6 Sep 2025 12:49:51 +0900
Message-ID: <20250906034954.82685-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <5a80cd22-49d9-4200-80d5-5416a1d78a5f@intel.com>
References: <5a80cd22-49d9-4200-80d5-5416a1d78a5f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 1 Sep 2025 07:36:21 +0300, Lifshits, Vitaly wrote:

>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
>>   1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index f3e7218ba6f3..ca93629b1d3a 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -2094,6 +2094,9 @@ static void igc_ethtool_diag_test(struct net_device *netdev,
>>   		netdev_info(adapter->netdev, "Offline testing starting");
>>   		set_bit(__IGC_TESTING, &adapter->state);
>>   
>> +		/* power up PHY for link test */
>> +		igc_power_up_phy_copper(&adapter->hw);
>
>I suggest moving this to igc_link_test functionn igc_diags.c as it 
>relates only to the link test.

Thank you for taking a look, Lifshits.

Now I'm considering changing only offline test path, not including
online test path.
This is because I think online test path should not trigger any
interruption and power down/up PHY may cause disruption.

So, I forgo the online path and my intention for this patch is to power
up PHY state only in offline test path.
I think introducing igc_power_up_phy_copper() in igc_link_test()
needs careful consideration in online test path.

>
>> +
>>   		/* Link test performed before hardware reset so autoneg doesn't
>>   		 * interfere with test result
>>   		 */
>
>
>Thank you for this patch.

