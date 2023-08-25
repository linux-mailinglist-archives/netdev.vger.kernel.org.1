Return-Path: <netdev+bounces-30799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE65789283
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55F61C20FD6
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1B1AA89;
	Fri, 25 Aug 2023 23:51:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC61174E6
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 23:51:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B938173F
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 16:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693007479; x=1724543479;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YI8Mb/8zWyLdXKtk/iagfKn58875Yl9J3N5bmaD7nOE=;
  b=MpSb4jU4/9rAIFKdnXUQiah3V9M5QC0+acC0hNv5nmOIsNQDR3gAQu4d
   whxdPCPNo9EK/X7WxQZX5Xb5lCcOAxffIY8OU9bAGK5sVAz+9fDVWHBeP
   1qjjdYveHbWUyQO6wpZBbtPdoYfnUSo1qDn7DXMtVU3k2QMbfX1v0ooH5
   /C/8mM4t7CSIOzKsobZOfXxb4+DR2mr5L/cUmDNMZ7WtqUUxRvwCljv3Y
   UeL9ZB6O2XQvKCSWA2xBtLc+1L3ynbyhqntJP33v/bRnTRW6SCkOslPip
   Dok6MEalAZXdwR+znrdnfKXUvPex4fn0lP56ynZ8e7tkjnD469llrwhs9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="373699368"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="373699368"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="911446172"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="911446172"
Received: from rtallon-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.111.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:51:17 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Ferenc Fejes <ferenc.fejes@ericsson.com>, "jesse.brandeburg@intel.com"
 <jesse.brandeburg@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "sasha.neftin@intel.com"
 <sasha.neftin@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "anthony.l.nguyen@intel.com"
 <anthony.l.nguyen@intel.com>
Cc: "hawk@kernel.org" <hawk@kernel.org>
Subject: Re: BUG(?): igc link up and XDP program init fails
In-Reply-To: <87ttsmohoe.fsf@intel.com>
References: <0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com>
 <87ttsmohoe.fsf@intel.com>
Date: Fri, 25 Aug 2023 16:51:16 -0700
Message-ID: <87o7iuof4b.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ferenc,

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:

> Hi Ferenc,
>
> Ferenc Fejes <ferenc.fejes@ericsson.com> writes:
>

[...]

> I don't think there's anything wrong with your setup.
>
> I am considering this a bug, I don't have any patches from the top of my
> head for you to try, but taking a look.
>

See if the following patch works. Doesn't look too bad, but I have to
think a bit more about it.

--8<---------------cut here---------------start------------->8---
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e7701866d8b4..d1b3c897c3ac 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6462,7 +6462,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	struct igc_ring *ring;
 	int i, drops;
 
-	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
+	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
 
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
--8<---------------cut here---------------end--------------->8---

Cheers,
-- 
Vinicius

