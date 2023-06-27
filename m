Return-Path: <netdev+bounces-14152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9366473F4C1
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5189C280FF0
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E1F20F3;
	Tue, 27 Jun 2023 06:44:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777AEC2
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:43:59 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0783044AB
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687848217; x=1719384217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eUy5EfgVb1+xdbu62bMzYmrUZPL6pO34zlgoYiwoF7k=;
  b=X9aNGeWz43K9Z17cGoEqLKK0NVgS3y3m/6GEAHDqTIY7B0IfUqT9PlSA
   STQYDFOP69OIk+QgKLIftlu6BKrKwmAveBmR5gy88X9B2nF5beDt9k9Sq
   /gUWj8riXeUotDscBcxSnYujhCVCGQiWqEjpkbJjDZmZ9mGpDqSNAsvTb
   W3aYF7czQOT0LaqAJBRR9Tz/lHTyUwWF2dXJS6Jt7zX+yECxVZgd8dT/Q
   Et0tHnZFtwTP2MeUF0HJx7FhaOql2rcIWgLSyW5AflQ3TDNmqt0WRJ2W+
   P6VzadrjmdGK44GFC7u0UyebY1gDCQuqLoTKIgzXFAp+nMeG/ZQRa74bv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341080215"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="341080215"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 23:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="666579673"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="666579673"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 23:42:02 -0700
Date: Tue, 27 Jun 2023 08:41:54 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>, jiri@resnulli.us,
	ivecera@redhat.com, simon.horman@corigine.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Vlad Buslov <vladbu@nvidia.com>
Subject: Re: [PATCH net-next 06/12] ice: Implement basic eswitch bridge setup
Message-ID: <ZJqEsoFLPBqkgs6c@localhost.localdomain>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-7-anthony.l.nguyen@intel.com>
 <ZJmgB9fUPE+nfmoh@localhost.localdomain>
 <20230626103542.68800299@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626103542.68800299@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 10:35:42AM -0700, Jakub Kicinski wrote:
> On Mon, 26 Jun 2023 16:26:15 +0200 Michal Swiatkowski wrote:
> > We found out that adding VF and corresponding port representor to the
> > bridge cause loop in the bridge. Packets are looping through the bridge.
> > I know that it isn't valid configuration, howevere, it can happen and
> > after that the server is quite unstable.
> > 
> > Does mellanox validate the port for this scenario? Or we should assume
> > that user will add port wisely? I was looking at your code, but didn't
> > find that. You are using NETDEV_PRECHANGEUPPER, do you think we should
> > validate if user is trying to add VF when his PR is currently added?
> 
> Can you try to plug two ends of a veth into a bridge and see if the
> same thing happens?  My instinct is that this is a classic bridge
> problem and the answer is STP.

Yeah, the same happens with veth connected to the bridge with both ends.
Turning STP on on the bridge fix the problem. Thanks for help :)

Michal

