Return-Path: <netdev+bounces-214257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD66CB28A81
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 06:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99323AC19E6
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 04:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615F5BAF0;
	Sat, 16 Aug 2025 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UUh3rOWL"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4434A33
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755317774; cv=none; b=gZG6R/IBg2aHrYSmUYYcMw7eKBgujG+Of0aCrcnMCjFN0Uf4vt+QblGNl4YMhNatC6IXPLlWHW5KGF1P6Sn4bQUM7TVbOJVdDGs7HykmvCaH7Ny6s+30ggaQic3Tp+Rjko5czKVfLOnNAyhkdwwDekBloA2xS2fj/auJoqUuewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755317774; c=relaxed/simple;
	bh=4pl7HhioxdvaFIegkDUeOmLYPbeUzrx5Kk8on7OU6Go=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7/gFusnCqTK2tOvUIi8y2HpPcP6gr4M7oXIYe2pRuHTbZ3zfBwz5XpYrPGGq6Bt5fy1j045ksiY/22qOQG7QpCWDNuEEU2Et8mmfe8dR5dQdp2xDhYQ0mXzcNBRxl7qc61SUw1jYfThfHbl92Fjd4B2z0s/93XR0YdTnktT9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UUh3rOWL; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755317772; x=1786853772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=grQ8MznX0ax9VmAPZJL5cknDcX/BG/AnrXvD+2GWl80=;
  b=UUh3rOWLB+yE8f9EpogEoqmUQrnAk/BtcrRo0LYtnQwqyO8YLdq5hjG2
   JUAgYo+QLp+FEMIP1hD0H11EXj70msSgJ+lazCK7oIUDgMipR7qfmAdHc
   yHn6u2W2ekbwsxbQEMvzuIty+F0am5/wPSYcoUJO1vOZYOW6BH5CJgHMJ
   j+tyGve1jq8mrz5aqvutKk3ewzkqlq8SZe8aZ1TZlxrf+ZtvHokaMTyML
   5qdAICLStw2jU4RTMCl+waZD8To8tWoGZCN19VYdyB2/x8Jh8zVyVTRpM
   ZxmGkKFFvUvDntJvyjy/EhSL5akfm+w23VrtL2fChxiTBIXpNlFuVNZMS
   A==;
X-CSE-ConnectionGUID: zVwOjIXKRri8HnBOwpJqWQ==
X-CSE-MsgGUID: 8XG63X9vSWOTCSVAYklqYA==
X-IronPort-AV: E=Sophos;i="6.16,202,1744070400"; 
   d="scan'208";a="1244802"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 04:16:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:6564]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.64:2525] with esmtp (Farcaster)
 id 33b31170-08d4-4ec5-90ee-1f3758c28f5d; Sat, 16 Aug 2025 04:16:09 +0000 (UTC)
X-Farcaster-Flow-ID: 33b31170-08d4-4ec5-90ee-1f3758c28f5d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 16 Aug 2025 04:16:09 +0000
Received: from b0be8375a521.amazon.com (10.37.244.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Sat, 16 Aug 2025 04:16:06 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <pmenzel@molgen.mpg.de>
CC: <alexanderduyck@fb.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<enjuk@amazon.com>, <intel-wired-lan@lists.osuosl.org>,
	<kohei.enju@gmail.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igb: fix link test skipping
 when interface is admin down
Date: Sat, 16 Aug 2025 13:15:28 +0900
Message-ID: <20250816041557.71794-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <01054bc5-74b6-4472-b7b6-78febaaf575f@molgen.mpg.de>
References: <01054bc5-74b6-4472-b7b6-78febaaf575f@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, 15 Aug 2025 09:41:28 +0200, Paul Menzel wrote:=0D
=0D
>[Correct Alexander=E2=80=99s email address]=0D
=0D
Thank you for the correction.=0D
I'll use the correct address going forward.=0D
=0D
>=0D
>Am 15.08.25 um 09:38 schrieb Paul Menzel:=0D
>> Dear Kohei,=0D
>> =0D
>> =0D
>> Thank you very much for your patch.=0D
>> =0D
>> Am 15.08.25 um 08:26 schrieb Kohei Enju:=0D
>>> The igb driver incorrectly skips the link test when the network=0D
>>> interface is admin down (if_running =3D=3D false), causing the test to=
=0D
>>> always report PASS regardless of the actual physical link state.=0D
>>>=0D
>>> This behavior is inconsistent with other drivers (e.g. i40e, ice, ixgbe=
,=0D
>>> etc.) which correctly test the physical link state regardless of admin=
=0D
>>> state.=0D
>> =0D
>> I=E2=80=99d collapse the above two sentences into one paragraph and add =
an empty =0D
>> line here to visually separate the paragraph below.=0D
=0D
Yes, that makes sense. I'll do that.=0D
=0D
>> =0D
>>> Remove the if_running check to ensure link test always reflects the=0D
>>> physical link state.=0D
>> =0D
>> Please add how to verify your change, that means the command to run.=0D
=0D
Sure, I tested the change using the ip and ethtool commands, with the=0D
physical link down. =0D
Should I include the following test steps in the commit message?=0D
=0D
Before:=0D
  $ sudo ip link set dev enp7s0f0 down=0D
  =0D
  $ ip --json link show enp7s0f0 | jq -c ".[].flags"=0D
  ["BROADCAST","MULTICAST"]=0D
  =0D
  $ sudo ethtool --test enp7s0f0 online=0D
  The test result is PASS=0D
  The test extra info:=0D
  Register test  (offline)         0=0D
  Eeprom test    (offline)         0=0D
  Interrupt test (offline)         0=0D
  Loopback test  (offline)         0=0D
  Link test   (on/offline)         0 # <- Not expected=0D
=0D
After:=0D
  $ sudo ip link set dev enp7s0f0 down=0D
  =0D
  $ ip --json link show enp7s0f0 | jq -c ".[].flags"=0D
  ["BROADCAST","MULTICAST"]=0D
  =0D
  $ sudo ethtool --test enp7s0f0 online=0D
  The test result is FAIL=0D
  The test extra info:=0D
  Register test  (offline)         0=0D
  Eeprom test    (offline)         0=0D
  Interrupt test (offline)         0=0D
  Loopback test  (offline)         0=0D
  Link test   (on/offline)         1 # <- Expected=0D
=0D
>> =0D
>>> Fixes: 8d420a1b3ea6 ("igb: correct link test not being run when link is=
 down")=0D
>>> Signed-off-by: Kohei Enju <enjuk@amazon.com>=0D
>>> ---=0D
>>>   drivers/net/ethernet/intel/igb/igb_ethtool.c | 5 +----=0D
>>>   1 file changed, 1 insertion(+), 4 deletions(-)=0D
>>>=0D
>>> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/ =0D
>>> net/ethernet/intel/igb/igb_ethtool.c=0D
>>> index ca6ccbc13954..6412c84e2d17 100644=0D
>>> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c=0D
>>> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c=0D
>>> @@ -2081,11 +2081,8 @@ static void igb_diag_test(struct net_device =0D
>>> *netdev,=0D
>>>       } else {=0D
>>>           dev_info(&adapter->pdev->dev, "online testing starting\n");=0D
>>> -        /* PHY is powered down when interface is down */=0D
>>> -        if (if_running && igb_link_test(adapter, &data[TEST_LINK]))=0D
>>> +        if (igb_link_test(adapter, &data[TEST_LINK]))=0D
>>>               eth_test->flags |=3D ETH_TEST_FL_FAILED;=0D
>>> -        else=0D
>>> -            data[TEST_LINK] =3D 0;=0D
>>>           /* Online tests aren't run; pass by default */=0D
>>>           data[TEST_REG] =3D 0;=0D
>> =0D
>> Regardless of my style comments above:=0D
>> =0D
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>=0D
>> =0D
>> =0D
>> Kind regards,=0D
>> =0D
>> Paul=0D
=0D
Thank you for the review, Paul.=0D

