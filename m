Return-Path: <netdev+bounces-15723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB87495D8
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70101C20CB2
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A387E8;
	Thu,  6 Jul 2023 06:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F56110C
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 06:44:04 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D14419B
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688625843; x=1720161843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=odkPhiodI0sR5/e1NdXixWj2wCvO46ORM+eZOvGyN6A=;
  b=E83tsUm1CjNLaC9pXALlVJbUryiSdLeZ812VWxOK8Iax0Z4O7iwIITyc
   5VEQSKMT5Bap9BATWxoEeQhEw97POTuUurb7vf+V3LD8djxRUMToAHvPw
   UJhEkiuUuy7ESSO/FVB+hu+cF8TWoaqdfume89mqdCRnYQflluD4jBrTw
   Jql0YPd9cIDsjVvWaSWa95GEKnunCudj724N8OwrAS8j4cKgQ5S8RcrXP
   huhunxFHo+mDLi/tdNbApd61bZNfPEtGOC/VWO22QS4HxAqsTyxjxj4Ik
   MaOoanVhoR0cgJlddAENKxSPHyrmdV++TDs72w1/eBmAmGmmU2QNa7Jbq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343851555"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="343851555"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 23:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863988311"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="863988311"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 23:44:01 -0700
Date: Thu, 6 Jul 2023 08:43:53 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: prevent call trace
 during reload
Message-ID: <ZKZiqTzTvE4pATqg@localhost.localdomain>
References: <20230705040510.906029-1-michal.swiatkowski@linux.intel.com>
 <c3c7bd46-5fbb-b11c-2f6b-ab108d1ee1d0@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3c7bd46-5fbb-b11c-2f6b-ab108d1ee1d0@molgen.mpg.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 11:33:55AM +0200, Paul Menzel wrote:
> Dear Michal,
> 
> 
> Thank you for your patch.
> 
> 
> Am 05.07.23 um 06:05 schrieb Michal Swiatkowski:
> > Calling ethtool during reload can lead to call trace, because VSI isn't
> > configured for some time, but netdev is alive.
> 
> […]
> 
> > Call trace before fix:
> > [66303.926205] BUG: kernel NULL pointer dereference, address: 0000000000000000
> 
> […]
> 
> I’d be more specific in the commit message summary/title:
> 
> ice: prevent NULL pointer deref during reload
> 

Will change

Thanks,
Michal

> […]
> 
> 
> Kind regards,
> 
> Paul

