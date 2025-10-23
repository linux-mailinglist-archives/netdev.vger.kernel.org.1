Return-Path: <netdev+bounces-232202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5032C02716
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A147189F5AE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E863A2D7D27;
	Thu, 23 Oct 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="WlOenW9l"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111012D46A7;
	Thu, 23 Oct 2025 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236846; cv=none; b=GT1wwpavC+QEWjH9uiD7mTGyhhKpM0wmaCAAvMPuyIgwIOxCHyfenFd1wmQ04ZkDPP8iExppwtRZBzsYsHp9aoYHvxQfAahhfqWLlSOXGoKSMPEYGcZwKWmRIKRFGjuz7ER/Bu4bzfFm2kcDSUc4qPf5tv4e4N5PZVHuUkHOEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236846; c=relaxed/simple;
	bh=Grs0gM9dzqfJn35R0W9gZX6wLE9dzv8v3TtYtjxwN38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wyqm1qSRGXNEiyJJEyF6ZGH/DxycLuI7QChmrYA7SBlNcZaHsx760W7xd3xNtqb9PxcAQm7LLZVgOkboEWhUpcVUo953mvdUUI3sg3FvYD9WBC9uXF4poOU/11oENwxLw8yQ8gYcSfi4k0CMDs8PFCrB+PNfPQl0vLv1l0gq3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=WlOenW9l; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761236845; x=1792772845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2lBkDsdUPck2BkjmBB98y45Ia11Tv+czovWMGGK0xbU=;
  b=WlOenW9l1lxRKm1tsARaU42w+BfCrASyqYJS50zecnFcdsZ+/PHVot+C
   Yr0a1jnkHVWEtJbuLdZirwe+hdGsoVdsXtkXe5DhVyJ8MFBlxDZTVXxDK
   MftfWeJqFTGFLIpm+JQPBnQg9BE31k/kOl1W3OdO6pIWF1hg2jNIyfv9W
   c4obKXTbtYs32sCli22NXOd7zxu6EnY7gXcf4e5GnUriEiaNHHG+usY6i
   dQrP+3rZIpNHffkKY9M/r8VFlK3Jhillht5lvicofKPH9UY7TfETFyZDa
   RPr23vvIEllz1MEwRq1pJpsVhzqAhgYvFZLYeiVNskoL70S6fEAy4R0s0
   g==;
X-CSE-ConnectionGUID: 13dYSAKUR5iCcQWCEwQOCA==
X-CSE-MsgGUID: FTESq6ZuRNqRxO6Pwk4pSw==
X-IronPort-AV: E=Sophos;i="6.19,250,1754956800"; 
   d="scan'208";a="5573970"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 16:27:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:31281]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.51:2525] with esmtp (Farcaster)
 id 8f5bdf07-dcf1-41c5-b591-846f69aa12e2; Thu, 23 Oct 2025 16:27:22 +0000 (UTC)
X-Farcaster-Flow-ID: 8f5bdf07-dcf1-41c5-b591-846f69aa12e2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 23 Oct 2025 16:27:22 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 23 Oct 2025 16:27:19 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <kuba@kernel.org>
CC: <aleksander.lobakin@intel.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <enjuk@amazon.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next v2 13/14] ixgbe: preserve RSS indirection table across admin down/up
Date: Fri, 24 Oct 2025 01:26:38 +0900
Message-ID: <20251023162711.97625-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022172649.0faa0548@kernel.org>
References: <20251022172649.0faa0548@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 22 Oct 2025 17:26:49 -0700, Jakub Kicinski wrote:

>On Wed, 22 Oct 2025 12:40:45 +0900 Kohei Enju wrote:
>> On Tue, 21 Oct 2025 16:10:06 -0700, Jakub Kicinski wrote:
>> >On Tue, 21 Oct 2025 12:59:34 +0900 Kohei Enju wrote:  
>> >> For example, consider a scenario where the queue count is 8 with user
>> >> configuration containing values from 0 to 7. When queue count changes
>> >> from 8 to 4 and we skip the reinitialization in this scenario, entries
>> >> pointing to queues 4-7 become invalid. The same issue applies when the
>> >> RETA table size changes.  
>> >
>> >Core should reject this. See ethtool_check_max_channel()  
>> 
>> Indeed, you're right that the situation above will be rejected. I missed
>> it.
>> 
>> BTW, I think reinitializing the RETA table when queue count changes or
>> RETA table size changes is reasonable for predictability and safety.
>> Does this approach make sense to you?
>
>Yes, if !netif_is_rxfh_configured() re-initializing is expected.

I got it.

>
>> >> Furthermore, IIUC, adding netif_is_rxfh_configured() to the current
>> >> condition wouldn't provide additional benefit. When parameters remain
>> >> unchanged, regardless of netif_is_rxfh_configured(), we already preserve
>> >> the RETA entries which might be user-configured or default values,   
>> >
>> >User may decide to "isolate" (take out of RSS) a lower queue,
>> >to configure it for AF_XDP or other form of zero-copy. Install
>> >explicit rules to direct traffic to that queue. If you reset
>> >the RSS table random traffic will get stranded in the ZC queue
>> >(== dropped).
>> 
>> You're correct about the ZC queue scenario. The original implementation
>> (before this patch) would indeed cause this problem by unconditionally
>> reinitializing.
>> 
>> I believe this patch addresses that issue - it preserves the user
>> configuration since neither queue count nor RETA table size changes in
>> that case. If I'm misunderstanding your scenario, please let me know.
>> 
>> I could update the logic to explicitly check netif_is_rxfh_configured()
>> as in [1], though the actual behavior would be the same as [2] since
>> the default RETA table is a deterministic function of (rss_indices,
>> reta_entries):
>> 
>> [1] Check user configuration explicitly:
>>     if (!netif_is_rxfh_configured(adapter->netdev) ||
>>         adapter->last_rss_indices != rss_i ||
>>         adapter->last_reta_entries != reta_entries) {
>>         // reinitialize
>>     }
>> 
>> [2] Current patch:
>>     if (adapter->last_rss_indices != rss_i ||
>>         adapter->last_reta_entries != reta_entries) {
>>         // reinitialize
>>     }
>> 
>> Do you have any preference between these approaches, or would you
>> recommend a different solution?
>
>I was expecting something like:
>
>if (netif_is_rxfh_configured(adapter->netdev)) {
>	if (!check_that_rss_is_okay()) {
>		/* This should never happen, barring FW errors etc */
>		warn("user configuration lost due to XYZ");
>		reinit();
>	}
>} else if (...rss_ind != rss_id ||
>           ...reta_entries != reta_entries) {
>	reinit();
>}

Thank you for clarification. 

At first glance, noting that check_that_rss_is_okay() would return false
when the RETA table size is larger than the previous one, since
user-configuration doesn't exist for the expanded portion of the RETA
table. This should happen in realistic scenarios even though there are
no hardware-related or HW errors.

Anyway I'll refine the patch using netif_is_rxfh_configured() and then
submit to iwl-next first.

