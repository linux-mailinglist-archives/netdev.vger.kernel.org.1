Return-Path: <netdev+bounces-221607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F71B5126E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF374870F6
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACD3128DA;
	Wed, 10 Sep 2025 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gJ1JyjkB"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E030E825
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496351; cv=none; b=bfdNxR46V0+SV3NPPxZowiP7Yoa12qZvoTYGuZDIz4G5OoJVGrnvPBeW9BwYtaRxs1glxVMHMoJT0vcmMpo22JxvfK/030TVoh2ljHaTAwMA8Jox82HIXB/6t0pdjysmevBvlpXOOqyFTFz723dRn2YMV4mGdJZB48FT2ugyrvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496351; c=relaxed/simple;
	bh=HNILZtt0hwwuxNVL/jW9PoH0yqkXYiFDFS+0lRZCWTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0rSXGKmjxv0DGxvBvPbq+qjmgV81k3E0fRd1nODqteb0c1s+ZcFOj0NTm6ui3DDPnWmqnpYhkJQze6wU2hrYeLnyd1KcBswitZSJeEWHb25LGGa+zNQYhAa8OFSCmCd08867nOuCUl9iFskCu0xHS8t5czeZzXR3sAKJ+cxsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gJ1JyjkB; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757496349; x=1789032349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsgebjoGUOrCSMEDwcajyXGY4GIsEupdqnjHKO74RKk=;
  b=gJ1JyjkB3vJCRsFPEh40HJJoOGmlsXUiJtx9gClUTGn3lfMKl38L9flB
   HJ0lLKss+X0u3HtuVqNgfOn8Lr+8tbm94hDJWi20mKTB+riLYj/V2yMBh
   wnDSkQ/VIew9d49OZiDdmaPHaQie1o0jKmzbA8eCOGvG40ECklXaPcuMY
   9j9L+0ldyJLFliyQsWb7EWWKerw0EifPu8gZ9kvfNcHTTmCh1tdJhxzGM
   R4T+s75aPj4oIk1zVCG7U7zDpAEerT4NDiagKLcDNLpfIFG48lHaXRs7h
   jnh6djh1bWq1wVWbCUO6PRjjRVfGRN9oLR06ZIfVGsuhjhwfbSSQ3GxU8
   Q==;
X-CSE-ConnectionGUID: Kw7qBZ6ZTAamd1guporJ+A==
X-CSE-MsgGUID: kmInTI60TJ2s0uunu3OY5w==
X-IronPort-AV: E=Sophos;i="6.18,253,1751241600"; 
   d="scan'208";a="2633235"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 09:25:47 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:43888]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.164:2525] with esmtp (Farcaster)
 id ea498177-17d9-4ab8-bc5d-400dc2e76433; Wed, 10 Sep 2025 09:25:47 +0000 (UTC)
X-Farcaster-Flow-ID: ea498177-17d9-4ab8-bc5d-400dc2e76433
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 09:25:47 +0000
Received: from b0be8375a521.amazon.com (10.37.244.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 09:25:44 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <kurt@linutronix.de>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<vitaly.lifshits@intel.com>
Subject: Re: RE: [Intel-wired-lan] [PATCH v1 iwl-net] igc: unregister netdev when igc_led_setup() fails in igc_probe()
Date: Wed, 10 Sep 2025 18:25:08 +0900
Message-ID: <20250910092537.30823-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <IA3PR11MB8986C779F51731B60D07BEB7E50EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986C779F51731B60D07BEB7E50EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 10 Sep 2025 09:02:51 +0000, Loktionov, Aleksandr wrote:

[...]
>> >>
>> >> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>> >
>> >Thank you for the patch and for identifying this issue!
>> >
>> >I was wondering whether we could avoid failing the probe in cases
>> where
>> >igc_led_setup fails. It seems to me that a failure in the LED class
>> >functionality shouldn't prevent the device's core functionality from
>> >working properly.
>> 
>> Indeed, that also makes sense.
>> 
>> The behavior that igc_probe() succeeds even if igc_led_setup() fails
>> also seems good to me, as long as notifying users that igc's led
>> functionality is not available.
>> 
>> >
>> > From what I understand, errors in this function are not due to
>> hardware
>> >malfunctions. Therefore, I suggest we remove the error propagation.
>> >
>> >Alternatively, if feasible, we could consider reordering the function
>> >calls so that the LED class setup occurs before the netdev
>> registration.
>> >
>> 
>> I don't disagree with you, but I would like to hear Kurt and
>> Aleksandr's
>> opinion. Do you have any preference or suggestions?
>> 
>> I'll revise and work on v2 if needed.
>> Thanks!
>
>Just in case /*I'm Alex*/ here are my 2cents:
>  I’d treat LED setup as best‑effort and not fail probe if it errors.
>Warn once, mark LEDs unavailable, and continue. That keeps datapath
>up and avoids tricky probe unwind. If we still want to fail on LED errors,
>then either (a) fix the unwind (unregister_netdev et al.) or (b) move LED setup before register_netdev().

Got it, thank you for your opinion :)

>
>  If LED labels depend on the netdev name, it’s fine to run LED setup after register_netdev().
>Since errors are non‑fatal, there’s no unwind complexity.
>
>Keep igc_led_setup() returning an error for internal visibility, but don’t propagate it as probe failure:
>err = igc_led_setup(adapter);
>if (err) {
>    netdev_warn_once(netdev,
>                     "LED init failed (%d); continuing without LED support\n",
>                     err);
>    adapter->leds_available = false;
>} else {
>    adapter->leds_available = true;
>}
>
>In remove()/error paths, guard teardown:
>if (adapter->leds_available)
>    igc_led_teardown(adapter);

I would like to adopt this approach, where we don't propagate led's
failure and manage its status using flag like leds_available.

I'll send v2 shortly.

>
>Keep current order but fully unwind on error:
>err = igc_led_setup(adapter);
>if (err) {
>    unregister_netdev(netdev);
>    /* del NAPI, free queues, etc. in reverse order */
>    err = -E...;
>    goto err_free;
>}
>
>With the best regards
>Alex

