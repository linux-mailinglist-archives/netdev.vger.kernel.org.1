Return-Path: <netdev+bounces-35634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8667AA5D5
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 01:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D71D928321A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD042941E;
	Thu, 21 Sep 2023 23:58:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48735C129
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 23:58:13 +0000 (UTC)
Received: from out-212.mta0.migadu.com (out-212.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D521F7
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 16:58:11 -0700 (PDT)
Message-ID: <e5022460-fc45-5571-1f5b-2b81f7811a7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695340689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUJHN3YfhHAwoXl+1sbrTgWZ/YrCi9D1KruOjj1djMM=;
	b=hz6nVQjKD0rPC1gxSGbf9AaBCRYE5ubk4LvtwRm0zjPsMz2vq/WYMTr5od3zFykk6d+1/6
	uzX2glTAi41cOAgZi4PWHKelE5jD+s8uUQrPiBdLtGF82daQfAXhVUs0MH8MRJCYgIrqr/
	JNLU2uUx1IJtzZ+RKW9lit3RmXVObtE=
Date: Fri, 22 Sep 2023 00:58:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] ice: fix undefined references from DPLL code
 when !CONFIG_PTP_1588_CLOCK
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 Milena Olech <milena.olech@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <20230920180745.1607563-3-aleksander.lobakin@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230920180745.1607563-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/09/2023 19:07, Alexander Lobakin wrote:
> DPLL code in ice unconditionally calls several PTP functions which are
> only built when CONFIG_PTP_1588_CLOCK is set. This throws a good bunch
> of link errors:
> 
> ERROR: modpost: "ice_cgu_get_pin_name"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_get_cgu_state"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> OR: modpost: "ice_is_cgu_present"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_get_cgu_rclk_pin_info"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_cgu_get_pin_type"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_cgu_get_pin_freq_supp"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> 
> ice_dpll_{,de}init() can be only called at runtime when the
> corresponding feature flags are set, which is not the case when PTP
> support is not compiled. However, the linker has no clue about this.
> Compile DPLL code only when CONFIG_PTP_1588_CLOCK is enabled and guard
> the mentioned init/deinit function calls, so that ice_dpll.o is only
> referred when it gets compiled.
> 
> Note that ideally ice_is_feature_supported() needs to check for
> compile-time flags first to be able to handle this without any
> additional call guards, and we may want to do that in the future.
> 

There is another fix under review [1], which came from Jacob.
It converts the code a bit more, and will create conflicts.
I would suggest to drop this patch until another series is fully
reviewed.

[1] 
https://lore.kernel.org/netdev/20230921000633.1238097-1-jacob.e.keller@intel.com/

