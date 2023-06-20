Return-Path: <netdev+bounces-12432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52A07377B1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 00:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF52B1C20D78
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71031800D;
	Tue, 20 Jun 2023 22:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68352AB42
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 22:57:05 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2810F4;
	Tue, 20 Jun 2023 15:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687301824; x=1718837824;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9b6M6GkQMwHB7xw638t8AtwIppSq4XNQXPspm0IhPTU=;
  b=gSeSSNWiEve6brp0FjT/MmHRwFpF8greI11Vew+zPrTtBwDXqYJNp48c
   Qo1vKg2ERVlWs/4009qWNA0PEEGUSpK7L/ZHI/0EFzxukT0Ps2AQwhwWS
   K+Yp5FlW6mtKuLNqFKXOHCea6/RV8GX+8oVwIhB9wHvYyIq4uIJ9qcbdn
   f2xlzWva3Fqk6IqyQ+Y9uo4eb+EY2ozsITf6/4jGpKUdvkjzrDGnlSvma
   PDYWeMx4TAvsqarQnLPYODuMgBJJtqZT1STW2pZkkMHEVysWeWzPUh+Fc
   a3wZdlNYn5Mha0gsYSrYU5yqQ4LLJBYP3CX4QFqYpL6Elibd6H1/Y9CW9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="363424837"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="363424837"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 15:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779614321"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="779614321"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 15:57:02 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Florian Kauer <florian.kauer@linutronix.de>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Tan Tee Min <tee.min.tan@linux.intel.com>, Muhammad
 Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>, Aravindhan
 Gunasekaran <aravindhan.gunasekaran@intel.com>, Malli C
 <mallikarjuna.chilakala@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kurt@linutronix.de,
 florian.kauer@linutronix.de
Subject: Re: [PATCH net v2 0/6] igc: Fix corner cases for TSN offload
In-Reply-To: <20230619100858.116286-1-florian.kauer@linutronix.de>
References: <20230619100858.116286-1-florian.kauer@linutronix.de>
Date: Tue, 20 Jun 2023 15:57:02 -0700
Message-ID: <87ilbhrbcx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Florian Kauer <florian.kauer@linutronix.de> writes:

> The igc driver supports several different offloading capabilities
> relevant in the TSN context. Recent patches in this area introduced
> regressions for certain corner cases that are fixed in this series.
>
> Each of the patches (except the first one) addresses a different
> regression that can be separately reproduced. Still, they have
> overlapping code changes so they should not be separately applied.
>
> Especially #4 and #6 address the same observation,
> but both need to be applied to avoid TX hang occurrences in
> the scenario described in the patches.
>
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>
> ---

For the series:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

