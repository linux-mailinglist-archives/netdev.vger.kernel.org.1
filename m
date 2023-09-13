Return-Path: <netdev+bounces-33512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1948F79E56E
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCA01C20C4D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873D1DA59;
	Wed, 13 Sep 2023 10:56:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBF23A0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:56:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625C1726;
	Wed, 13 Sep 2023 03:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694602585; x=1726138585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LYSnaNLcsO7YvbC0ChoMxE2UJxhRLP+HoojmUoNAyII=;
  b=Og9Si3tNCOmb7HU/LVzSGar/jP8Q1qI/6g5hJL62Kd0noNVMvRRrZoyj
   InnKKhUMAfEHzjsUhz7A3LhtHnmb1iYjb8095JxdZcqrPws/k1XbUR21n
   V8fzCGdpJHbcX3+Cs6SJqIfnbKHMY4JVajHD73zgyNsVpnaUjo1nXYO2v
   y4mzXiCA7ybwir6Cg1/b+UUjLlDm05JSiaJjHgIfGOaqRMoAW15Sck8mT
   iLA2HtbQUekQ7IfvIjjEB9spdKpanIhuowxiHQmfXJ+UIQkc0yBXBOVRa
   pVYnn7syNligFaZWEKdsKA5yP/2fWdf1Y5PWZIzaiO/eW/FcY27zoFC6I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464996469"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="464996469"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737453054"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737453054"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.12.48.172]) ([10.12.48.172])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:56:19 -0700
Message-ID: <4f9e7d31-7c73-e5c1-b34c-3924c5d6b100@linux.intel.com>
Date: Wed, 13 Sep 2023 13:56:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] igc: Fix infinite
 initialization loop with early XDP redirect
Content-Language: en-US
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Andre Guedes <andre.guedes@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jithu Joseph <jithu.joseph@intel.com>, linux-kernel@vger.kernel.org,
 Ferenc Fejes <ferenc.fejes@ericsson.com>, Eric Dumazet
 <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Vedang Patel <vedang.patel@intel.com>
References: <20230907003005.99481-1-vinicius.gomes@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230907003005.99481-1-vinicius.gomes@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/2023 03:30, Vinicius Costa Gomes wrote:
> When a XDP redirect happens before the link is ready, that
> transmission will not finish and will timeout, causing an adapter
> reset. If the redirects do not stop, the adapter will not stop
> resetting.
> 
> Wait for the driver to signal that there's a carrier before allowing
> transmissions to proceed.
> 
> Previous code was relying that when __IGC_DOWN is cleared, the NIC is
> ready to transmit as all the queues are ready, what happens is that
> the carrier presence will only be signaled later, after the watchdog
> workqueue has a chance to run. And during this interval (between
> clearing __IGC_DOWN and the watchdog running) if any transmission
> happens the timeout is emitted (detected by igc_tx_timeout()) which
> causes the reset, with the potential for the inifite loop.
> 
> Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
> Reported-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
> Closes: https://lore.kernel.org/netdev/0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com/
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Tested-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v1 -> v2:
>   - Added more information to the commit message (Maciej Fijalkowski)
> 
> 
>   drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

