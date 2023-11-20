Return-Path: <netdev+bounces-49212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891A7F1291
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529191C21572
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50518B0D;
	Mon, 20 Nov 2023 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG4MuOWw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0261E8E;
	Mon, 20 Nov 2023 03:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700481592; x=1732017592;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hLlgtN7e+i6tZI3bxI8GySjeZu1w9pcdPAelbmCT79A=;
  b=QG4MuOWwVP+8bUeng02gZgltJNjHZDQMfBq6u1toMHwe0trieqn/jsNa
   V7eZzusbDLPbjP78BkuMz2pN8uj7GGoy9kFU6wLdBAjeOLdhaZMxWP06b
   DHOvmcOhLBm+2v4NvuMzI+D0T3qP2W3NkUCLJn6qbKQwHngHhV/XqRt83
   6Rcxzrv5zeBq+bV+bzTaBcnmtPAAsWdV5Igcs8ppqOZL3x56m2u7t4c9s
   7p81jNNSe3Whk7ZoLNUTh6T6ZsirKJ+ir4L29y8TCLKmmw9OBhzLA+raP
   uZv8Og2P4HbjLYmsd3SPskBFJtG3mTBwtqhl3VwEo5yo3uJq9zmQxdZs6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4723173"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="4723173"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="766253122"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="766253122"
Received: from akeren-mobl.ger.corp.intel.com ([10.252.40.26])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:59:46 -0800
Date: Mon, 20 Nov 2023 13:59:44 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ma Jun <Jun.Ma2@amd.com>
cc: amd-gfx@lists.freedesktop.org, lenb@kernel.org, johannes@sipsolutions.net, 
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com, 
    mario.limonciello@amd.com, Netdev <netdev@vger.kernel.org>, 
    linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    majun@amd.com
Subject: Re: [Patch v13 1/9] Documentation/driver-api: Add document about
 WBRF mechanism
In-Reply-To: <20231030071832.2217118-2-Jun.Ma2@amd.com>
Message-ID: <3e18c716-4c1b-ea3-ede3-5a67555f5e72@linux.intel.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com> <20231030071832.2217118-2-Jun.Ma2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 30 Oct 2023, Ma Jun wrote:

> Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
> explaining the theory and how it is used.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  Documentation/driver-api/wbrf.rst | 76 +++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/driver-api/wbrf.rst
> 
> +Driver programming interface
> +============================
> +.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
> +
> +Sample Usage
> +=============

A lot better but you missed adding newlines here for this and previous 
section title.

> +The expected flow for the producers:
> +1). During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
> +    can be enabled for the device.
> +2). On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
> +    param to get other consumers properly notified.
> +3). Or on stopping using some frequency band, call
> +    `acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
> +
> +The expected flow for the consumers:
> +1). During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
> +    can be enabled for the device.
> +2). Call `amd_wbrf_register_notifier` to register for notification
> +    of frequency band change(add or remove) from other producers.
> +3). Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
> +    current active frequency bands considering some producers may broadcast
> +    such information before the consumer is up.
> +4). On receiving a notification for frequency band change, run
> +    `amd_wbrf_retrieve_freq_band` again to retrieve the latest
> +    active frequency bands.
> +5). During driver cleanup, call `amd_wbrf_unregister_notifier` to
> +    unregister the notifier.

The correct kerneldoc format should be without the closing parenthesis:

1. Text here that
   spills to second line.
2. Second entry.

-- 
 i.


