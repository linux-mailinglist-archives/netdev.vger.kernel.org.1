Return-Path: <netdev+bounces-218661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E5B3DCA5
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6E41637F9
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A602F3C36;
	Mon,  1 Sep 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="L/6bEpLG"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C82FAC1B
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715884; cv=none; b=P5/rEYlVrkbCPzxZIg/5N9yZV+K/gm+JmExH8S3mxQEKM5AkYhfwxlrgGWhQuhJY49UyWoFjrQa2A3JfYOw38IgIXRM+dH9htcomgyYQ6rAYoIgdXz0fOnuB9XcUVeGSsPdot1mgypBR5vEcRXAu8YvY2MZqTRzo5W5nUSE7Sk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715884; c=relaxed/simple;
	bh=+w/C58tG1CkHtgQLHbTG6lK4vmElrZrRFD77iFSF888=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTS44FWz6Bu4amwV27THFtAR62TA+k5uRd4QjyPxYvxC8WN1PziNUG8tO3sjaz93ktUtOWTag0cMJayuBSm0/ThH36o4yyxRh28a59V6jjedIZW0a5uCSyKIl7HVI4be58u40hrkBYhU0AQabQCHsB0HUw71SwydhJBQAF72xEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=L/6bEpLG; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756715882; x=1788251882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YieHs2EdzcXdNtbtuJLTZuoSL3hLDGAdJYs4wWPl/QM=;
  b=L/6bEpLGZaaW3JzDMyKi+BJiCcxJTjrlkR8DQ/P7ai8pNg0bIzG52uCC
   ZcaQzDoIqwfCg4Pw610I9Y2i+sums+EVU1y3MeqfvEZmn7DM+I6ccigpb
   CoMDD9SlPvPt5jALs0VaWw2+CA3ZSRnRs+Px3XPIwR5tz+I658IYxRnz9
   Mbk18WxkZcCORyz4tgkDZmbB6B3vpUWc3wMPihgsoHSZfXrnZmWdsg1pI
   ajYAoDzBquSiR3AVjWMyBQzZQ5N8xsU9xDC9Z4nerDsnlJx5C40Nu79TE
   qv6B6YkbIEpLy4qcr0JAQqSniUMzjgHK00+mhPsiCt/cwcY/7R9fPIC2L
   g==;
X-CSE-ConnectionGUID: Z3bwL3dbRW+HSmTeOi4sug==
X-CSE-MsgGUID: SUOQhIPAT2WHiC8V55SrWg==
X-IronPort-AV: E=Sophos;i="6.18,225,1751241600"; 
   d="scan'208";a="2036255"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 08:37:58 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:48252]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.13:2525] with esmtp (Farcaster)
 id d5a0e15f-fc4f-43a7-a7a3-4ea2fa567d3d; Mon, 1 Sep 2025 08:37:58 +0000 (UTC)
X-Farcaster-Flow-ID: d5a0e15f-fc4f-43a7-a7a3-4ea2fa567d3d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 1 Sep 2025 08:37:56 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 1 Sep 2025 08:37:53 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <den@valinux.co.jp>, <edumazet@google.com>,
	<enjuk@amazon.com>, <intel-wired-lan@lists.osuosl.org>,
	<jedrzej.jagielski@intel.com>, <kohei.enju@gmail.com>, <kuba@kernel.org>,
	<mateusz.polchlopek@intel.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<stefan.wegrzyn@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: fix memory leak and
 use-after-free in ixgbe_recovery_probe()
Date: Mon, 1 Sep 2025 17:37:38 +0900
Message-ID: <20250901083745.69554-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <IA3PR11MB8986BB7E1C9B70B43014F1BDE507A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986BB7E1C9B70B43014F1BDE507A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 1 Sep 2025 07:11:26 +0000, Loktionov, Aleksandr wrote:=0D
=0D
>> [...]=0D
>> =0D
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c=0D
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c=0D
>> index ff6e8ebda5ba..08368e2717c2 100644=0D
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c=0D
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c=0D
>> @@ -11510,10 +11510,10 @@ static int ixgbe_recovery_probe(struct=0D
>> ixgbe_adapter *adapter)=0D
>>  shutdown_aci:=0D
>>  	mutex_destroy(&adapter->hw.aci.lock);=0D
>>  	ixgbe_release_hw_control(adapter);=0D
>> -	devlink_free(adapter->devlink);=0D
>>  clean_up_probe:=0D
>>  	disable_dev =3D !test_and_set_bit(__IXGBE_DISABLED, &adapter-=0D
>> >state);=0D
>>  	free_netdev(netdev);=0D
>I'd add a guard here: if (adapter->devlink)=0D
>What do you think?=0D
=0D
Thank you for the review.=0D
=0D
Currently ixgbe_recovery_probe() is only called from one location,=0D
ixgbe_probe(), and also always adapter->devlink is not NULL in this path=0D
since this is called after ixgbe_allocate_devlink(). In other words, if=0D
ixgbe_allocate_devlink() fails, ixgbe_recovery_probe() never be called.=0D
=0D
So I've thought that the guard might not be necessary like error=0D
handling in ixgbe_probe(), but could you let me know your concern if I'm=0D
overlooking something?=0D
=0D
Thanks,=0D
Kohei.=0D
=0D
>> +	devlink_free(adapter->devlink);=0D
>>  	pci_release_mem_regions(pdev);=0D
>>  	if (disable_dev)=0D
>>  		pci_disable_device(pdev);=0D
>> --=0D
>> 2.51.0=0D

