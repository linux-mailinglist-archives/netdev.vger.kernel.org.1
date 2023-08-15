Return-Path: <netdev+bounces-27559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233C77C67E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B0328127B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 03:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC61FA8;
	Tue, 15 Aug 2023 03:51:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61A1C13
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 03:51:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407E2183;
	Mon, 14 Aug 2023 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692071513; x=1723607513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0U5mVMBc7pOFHVeJVlzVG7Zb1up3kpgr5XH1w5CKdFQ=;
  b=dJkIDYvZh2RWfJfpff76A3EB7lQDox3PLknJmHZlVZN3QworAVkgi0m4
   FNfcN2lQ5Y7YAjQri0OTa7Iu8aBrG6bCa0YoMqcXa/F7z7gOf9UYekceY
   pZUWCK7KgzBTKfzwKhlTKxofXtgVUrPd0ENVpPfDO/jusgfjhKj1gDZZ3
   /yW3l0exBOzC9QVGaR1y9rKzWi1bvPJY7PDmCbpVKi6kg6D+VgPikiywn
   FPvGXMWBbKeO1wNDqt6HzGjoGxHhMxXz6W55xooMH6GXe1bj55zW3JJly
   Aabs/WlZM8dczck+HK8Tn7YHDIXSu264Ued9sX/KQO3ruMOoVr2D5WetK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403176407"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="403176407"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 20:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="847904364"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="847904364"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2023 20:51:48 -0700
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: Jose Abreu <joabreu@synopsys.com>
Cc: alexandre.torgue@foss.st.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peppe.cavallaro@st.com,
	robh+dt@kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: RE: [PATCH net-next v3 2/2] net: stmmac: Tx coe sw fallback
Date: Tue, 15 Aug 2023 11:51:45 +0800
Message-Id: <20230815035145.16990-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20230814181354.8603-1-rohan.g.thomas@intel.com>
References: <20230814181354.8603-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rohan G Thomas <rohan.g.thomas@intel.com>
Date: Mon, Aug 14, 2023 at 15:06:37
> > > +	bool tx_q_coe_lmt;
> >
> > Please use a flag here instead of "tx_q_coe_lmt". This is the
> > preferrable method now.
> >
> > Thanks,
> > Jose
> 
> Thanks Jose for the feedback. If I read that correctly, your suggestion is to
> change " tx_q_coe_lmt" to something more readable, like "has_txcoe_limit".
> Please correct me if I understand it wrongly.
> 
> BR,
> Rohan
>

Or, use int instead of bool?

BR,
Rohan

