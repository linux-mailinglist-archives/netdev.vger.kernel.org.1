Return-Path: <netdev+bounces-218517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F1B3CF3F
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 22:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AE13BC562
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D992DAFA6;
	Sat, 30 Aug 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wo6oe1nx"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6C2D6E58
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756584964; cv=none; b=LifGD70DJfxwKaFXHRURFffrP1PxAdaRTVJk90lBNPV+3wfjsz41Ycpaahxp1jVAleG6lnjJ/GWherNM0zS5SEX6CovebARnaDPzhbRPMXdnd4kAFsteFkSf2nA2gYy/BtRUx9gH3hw783Qt0KU4B32DE49DFW7hFLmJ57K4ZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756584964; c=relaxed/simple;
	bh=dc1s8kUdUOkzL4FNfFiAzs+7MvakJKbZsTvrdVR9Nwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlKvP51/ZPtIR1ZMNGhVMie2eMAQJ4DUkV3rh4aGSIvAnsUO/gzJ21W1KTklTZLqK8PlbY2SH9ZkcE8wkLAUcMy9ldKA2y9Fp5o/b9QYaNcJCY+WyUw5aHtYSTcCB0C2Et2535vdzhrPRy1RPR4DBKP9c0i8kS6ifHBdHbzr8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wo6oe1nx; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756584961; x=1788120961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Afy9xvrfmePMFwDjUWP+2SP1X18TaC8FvGhXgpVdCU=;
  b=Wo6oe1nxlHV1bfR/GHpJPfSzmaV1pWoOyxwOzfikfi+Ub/lNaLjSEmH/
   aooWqUrOrKzsm0687D9G5P/feDxW+gpd3YZrC1GsFrNh9LHQwYVWkm2tN
   +JXa+8sJVcq3rcdX/z77/6f4vxdA1DlqovUN2o4o+xkQAfQwq9SMnoPmO
   PTkXdgtBv7oB1L5/B7skRrFxjroPPio6jGcZtbZ7F1cJjZ/GHmZlnIMCx
   vRTjCQN5uR4/ZuYLmW+1DwfJz8QLHdVssLRIf8Dhm5aonRis1hoT9E6S0
   sYkoHywpdACOc6hj48nn94kc8a6qmgptM+2emoi4xJb4nkk2ZSwYtEuTH
   Q==;
X-CSE-ConnectionGUID: nV4y56/qRhuExNPqGRSvGA==
X-CSE-MsgGUID: EfWgYBh4TjqDXay2cXPgUQ==
X-IronPort-AV: E=Sophos;i="6.18,225,1751241600"; 
   d="scan'208";a="1987828"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 20:15:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:57912]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.7:2525] with esmtp (Farcaster)
 id f7940bc6-4159-43ef-b4e1-28c436aa528d; Sat, 30 Aug 2025 20:15:59 +0000 (UTC)
X-Farcaster-Flow-ID: f7940bc6-4159-43ef-b4e1-28c436aa528d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Sat, 30 Aug 2025 20:15:59 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 30 Aug 2025 20:15:57 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <andrew@lunn.ch>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <vitaly.lifshits@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igc: power up PHY before link test
Date: Sun, 31 Aug 2025 05:14:41 +0900
Message-ID: <20250830201549.16083-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <7607d394-9659-4bb0-af14-8a3633cfc89c@lunn.ch>
References: <7607d394-9659-4bb0-af14-8a3633cfc89c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sat, 30 Aug 2025 21:27:33 +0200, Andrew Lunn wrote:

>On Sun, Aug 31, 2025 at 02:06:19AM +0900, Kohei Enju wrote:
>> The current implementation of igc driver doesn't power up PHY before
>> link test in igc_ethtool_diag_test(), causing the link test to always
>> report FAIL when admin state is down and PHY is consequently powered
>> down.
>> 
>> To test the link state regardless of admin state, let's power up PHY in
>> case of PHY down before link test.
>
>Maybe you should power the PHY down again after the test?

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

>
>Alternatively, just return -ENOTDOWN is the network is admin down.

That would be simpler indeed. Since the callback returns void, we'd set 
the test result to indicate skip/fail.
However, I think checking actual physical connectivity even when admin 
down is valuable, which other Intel ethernet drivers (e.g., i40e, ixgbe, 
igb) also do.

>
>	Andrew

