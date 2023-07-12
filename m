Return-Path: <netdev+bounces-17000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6374FC6C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805C028159D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2F0374;
	Wed, 12 Jul 2023 00:54:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F43362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1909C433C9;
	Wed, 12 Jul 2023 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689123295;
	bh=jTA+fGMW3Ci5Y8Ht2MMIaClUflFM4sxaGaBC2f0giZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KSmFEUKLR5SR1RL9z4+zFZbMqroA9pqmfO5SAOCRrgPrlTpHSeYjJ0znQWoGUYdrT
	 NY3/s+5pLALz9tThlhbA1oNEbrpk3fjLlCT+xqnptzsrj124ShFVpuVRzlLqJbvLR/
	 A3JU98DLcepC2HSme/2qDZk5ZH7JtzQ3n3o3+nhEhuqI77hsagClbTzNNhpUvwwjo1
	 /yQ09Pw+EkcCqjLAxCv2VvGBMIFleE6Z3sNTWI5TidSjGn0gsuzecSlZHV0do24EP4
	 foCNw6u3UopCwDr3UsRxT1eeY3BHdnj/fukzv2tGhOjuON6mh7K0owskZ6ufWY4WMm
	 i78fUT36pFTow==
Date: Tue, 11 Jul 2023 17:54:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Florian Kauer <florian.kauer@linutronix.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, kurt@linutronix.de,
 vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
 tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
 sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 5/6] igc: Fix launchtime before start of cycle
Message-ID: <20230711175454.040822b1@kernel.org>
In-Reply-To: <20230711101233.GM41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
	<20230710163503.2821068-6-anthony.l.nguyen@intel.com>
	<20230711070902.GF41919@unreal>
	<7005af42-e546-6a7c-015f-037a5f0e08a9@linutronix.de>
	<20230711101233.GM41919@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 13:12:33 +0300 Leon Romanovsky wrote:
> > If I understand correctly, ktime_sub_ns(txtime, baset_est) will only return
> > something larger than s32 max if cycle_time is larger than s32 max and if that
> > is the case everything will be broken anyway since the corresponding hardware
> > register only holds 30 bits.  
> 
> I suggest you to use proper variable types, what about the following
> snippet?
> 
> ktime_t launchtime;
> 
> launchtime = ktime_sub_ns(txtime, baset_est);
> WARN_ON(upper_32_bits(launchtime));
> div_s64_rem(launchtime, cycle_time, &launchtime);
> 
> return cpu_to_le32(lower_32_bits(launchtime));

That needs to be coupled with some control path checks on cycle_time?
Seems like a separate fix TBH.

