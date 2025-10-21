Return-Path: <netdev+bounces-231079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 214B0BF48E5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 06:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA77B18C4EDB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 04:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7588F1DFD8B;
	Tue, 21 Oct 2025 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fqG04iT6"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF0819F41C;
	Tue, 21 Oct 2025 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019219; cv=none; b=mibgzQ6PZUOVSXTwipXSCfcWs7ZCRs10TGQzX73JrQ1xXxv6FES1qY3TKo157CefhuXDG2iD+t8j8svxSY1vIvBvYtMNfIzuabeHVm5ezeMfHkBmMqnWegoevPPoIjgnu5y9/8uskHUPP9ZKu/soiZ+UNbQ1cNIxtLjbppq7GLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019219; c=relaxed/simple;
	bh=XdZ+bSwZitbUWOlq5HzK0v+64/RHdlaknUCUZVBOaTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmGugFRTwVb1pXrxoJod7p6oTtrR9Ck+UY7umA6kqr3LVZky49YzDa7anaZBGAxQ1XyZdsOuSfm2N2FEEc/dQBnXQVDKrvzQcdihnYIAaqqYMyYaMkwej/p9vKB5IXv33jsDVD1iexLeo30T4ohVDm65fNJaQ5g/W1OGOAZ+dWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fqG04iT6; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761019217; x=1792555217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KTzOv9/b1xNagjNFcLWg7luH3jx9poz7xbR0D710bEY=;
  b=fqG04iT6zLB3NjCsdMTfNZv1WNGOe5Ee2MTwkXzVod98mI6jYBjDwfmQ
   naOWHlqizcHEC674H5bEOI8pVLHfMKuePODZmgAYcC+1wA8jZSukDrg5T
   cWsfQssYm+CPR3waiLjdyQDOhEGeVfEXIOKsY26Wcw+tFNSw0SC8dvZGz
   Cx26RasjLyLclrWr5rbhzSr5zL8ESFY/CjW8JjhVVu0M2tOsFYHRvGmSA
   OOcxMMJJHTXcZozK3tJB1NTWp9w8RyIVm9fhbwFUrR6bsWCViw1fGJ91k
   jHw3iHiSKt8gb4aYDDthb/CnNCFn6FvxnuEXzWJffUC+pKkCs5lTFoOi1
   g==;
X-CSE-ConnectionGUID: FOWWBHa8SpORO7ARxemC/w==
X-CSE-MsgGUID: 820b810wSsWhi59t+ZFK8Q==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="5301474"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 04:00:13 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:13820]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.191:2525] with esmtp (Farcaster)
 id 9f5b59e0-db79-4614-aa8a-fa0e9880c6ac; Tue, 21 Oct 2025 04:00:13 +0000 (UTC)
X-Farcaster-Flow-ID: 9f5b59e0-db79-4614-aa8a-fa0e9880c6ac
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 04:00:13 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 04:00:09 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <kuba@kernel.org>
CC: <aleksander.lobakin@intel.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <enjuk@amazon.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next v2 13/14] ixgbe: preserve RSS indirection table across admin down/up
Date: Tue, 21 Oct 2025 12:59:34 +0900
Message-ID: <20251021040000.15434-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020183246.481e08f1@kernel.org>
References: <20251020183246.481e08f1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 20 Oct 2025 18:32:46 -0700, Jakub Kicinski wrote:

>On Thu, 16 Oct 2025 23:08:42 -0700 Jacob Keller wrote:
>> Currently, the RSS indirection table configured by user via ethtool is
>> reinitialized to default values during interface resets (e.g., admin
>> down/up, MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
>> Check for RSS key before setting value") made it persistent across
>> interface resets.
>> 
>> Adopt the same approach used in igc and igb drivers which reinitializes
>> the RSS indirection table only when the queue count changes. Since the
>> number of RETA entries can also change in ixgbe, let's make user
>> configuration persistent as long as both queue count and the number of
>> RETA entries remain unchanged.
>
>We should take this a step further and also not reinitialize if 
>netif_is_rxfh_configured(). Or am I missing something?

Hi Jakub, thank you for reviewing.

Actually, you raise a good point about netif_is_rxfh_configured().

However, we can't determine whether we should reinitialize or not based
solely on netif_is_rxfh_configured(), since the RETA table is determined
by (1) the queue count and (2) the size of RETA table.

So, simply skipping reinitialization on netif_is_rxfh_configured() would
leave invalid RETA entries when those parameters are to be changed.

For example, consider a scenario where the queue count is 8 with user
configuration containing values from 0 to 7. When queue count changes
from 8 to 4 and we skip the reinitialization in this scenario, entries
pointing to queues 4-7 become invalid. The same issue applies when the
RETA table size changes.

Furthermore, IIUC, adding netif_is_rxfh_configured() to the current
condition wouldn't provide additional benefit. When parameters remain
unchanged, regardless of netif_is_rxfh_configured(), we already preserve
the RETA entries which might be user-configured or default values, 

Therefore I believe the current logic is correct as is, and we should
reinitialize the RETA entries when either parameter changes, regardless
of netif_is_rxfh_configured().

