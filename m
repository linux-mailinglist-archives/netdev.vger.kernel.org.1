Return-Path: <netdev+bounces-38479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565487BB216
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 09:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D972820D4
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61F63D3;
	Fri,  6 Oct 2023 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvjOfVhe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94163B2;
	Fri,  6 Oct 2023 07:23:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D4CA;
	Fri,  6 Oct 2023 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577008; x=1728113008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mWHcdTvH6aYA57g0fq1YlCnr+8VV/+w6xGLIONT5Tg4=;
  b=XvjOfVheXSvgMl9pQMz2L7czktDkrmcXvQo1QYHGB7MOaqdOMKMO+OS5
   SbDbmu4atELcLQOYbXYCn56Hi+KP89D7nYetBlBogl2BOmiljIdVAA6x6
   wCVx2gbPMyagqRhWbVODsA4rx90VW7FZwEanZT5HZYus8AOhSQiggA1FB
   5KTNjemrFvBZ/nnp/81BTpdtgPsswlJMgJZusMCKlfpUUQ8WjLiylBjqH
   VFhLIbYiT4XtBBki8lBERDz/6MWNuXqOBRIGwsB4JwW9Y+UKIT3Ywq6+5
   u9fQvoyGkW6lEchXnHrlYewyqISelNgRPr3Xv0+GvvO9O385XIsbR7y9w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="374046251"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="374046251"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:23:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="781543497"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="781543497"
Received: from pglc0394.png.intel.com ([10.221.87.72])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2023 00:23:22 -0700
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: kuba@kernel.org
Cc: alexandre.torgue@foss.st.com,
	andriy.shevchenko@linux.intel.com,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	fancer.lancer@gmail.com,
	joabreu@synopsys.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rohan.g.thomas@intel.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts handling
Date: Fri,  6 Oct 2023 15:23:19 +0800
Message-Id: <20231006072319.22441-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005070538.0826bf9d@kernel.org>
References: <20231005070538.0826bf9d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 5 Oct 2023 07:05:38 -0700 Jakub Kicinski wrote:
> On Thu, 5 Oct 2023 20:14:41 +0800 Rohan G Thomas wrote:
> > > So the question now is whether we want Rohan to do this conversion
> > > _first_, in DW QoS 5, and then add xgmac part. Or the patch should
> > > go in as is and you'll follow up with the conversion?
> >
> > If agreed, this commit can go in. I can submit another patch with the
> > refactoring suggested by Serge.
> 
> Did you miss the emphasis I put on the word "first" in my reply?
> Cleanup first, nobody will be keeping track whether your fulfilled your
> promises or not :|

Hi Jakub,

Agreed. I'll do the cleanup first.

Best Regards,
Rohan

