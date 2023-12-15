Return-Path: <netdev+bounces-57705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC58F813F61
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094391C22058
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFCE624;
	Fri, 15 Dec 2023 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htFd+MzO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734DF804
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 01:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF35C433C8;
	Fri, 15 Dec 2023 01:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702604766;
	bh=pOA9iQ3oiHnXchJg588/G4CIPWlxrqFDcw3s8wXyqws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=htFd+MzOhXJsdFv6KasWkyach/PjprBnMtSP606w6G/RDDnABjSV+NMIW/ydkfk0M
	 soS6InwL7Em5khpnGz190BuAXMhfHeYBcA2JJTdJcA65v+0c6jkUtcPmeHFVpUkyPS
	 3yGRDvGg5sUlQHl7SXENDnoZkGnfNpLDLBURHGW2qaJ98wnu5MYyZ85Hfybtu6x8VT
	 joFttvBlP1eB16lvaomSmeUjGr9NniZ17C3VD8jo891VaMCbV6C2kBOVOIxB+2aPWV
	 FjQdnBlYtXftrmRlTb4wXSr0F1F/yFLwyv9yINRX59D8pUnm2+VHRfdNmauI0souxZ
	 tvMfCrBw5SKtw==
Date: Thu, 14 Dec 2023 17:46:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 qi.z.zhang@intel.com, Wenjun Wu <wenjun1.wu@intel.com>,
 maxtram95@gmail.com, "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Simon Horman
 <simon.horman@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
Message-ID: <20231214174604.1ca4c30d@kernel.org>
In-Reply-To: <55e51b97c29894ebe61184ab94f7e3d8486e083a.camel@redhat.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
	<20230822034003.31628-1-wenjun1.wu@intel.com>
	<ZORRzEBcUDEjMniz@nanopsycho>
	<20230822081255.7a36fa4d@kernel.org>
	<ZOTVkXWCLY88YfjV@nanopsycho>
	<0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
	<ZOcBEt59zHW9qHhT@nanopsycho>
	<5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
	<bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
	<20231118084843.70c344d9@kernel.org>
	<3d60fabf-7edf-47a2-9b95-29b0d9b9e236@intel.com>
	<20231122192201.245a0797@kernel.org>
	<e662dca5-84e4-4f7b-bfa3-50bce30c697c@intel.com>
	<20231127174329.6dffea07@kernel.org>
	<55e51b97c29894ebe61184ab94f7e3d8486e083a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 21:29:51 +0100 Paolo Abeni wrote:
> Together with Simon, I spent some time on the above. We think the
> ndo_setup_tc(TC_SETUP_QDISC_TBF) hook could be used as common basis for
> this offloads, with some small extensions (adding a 'max_rate' param,
> too).

uAPI aside, why would we use ndo_setup_tc(TC_SETUP_QDISC_TBF)
to implement common basis?

Is it not cleaner to have a separate driver API, with its ops
and capabilities?

> The idea would be:
> - 'fixing' sch_btf so that the s/w path became a no-op when h/w offload
> is enabled
> - extend sch_btf to support max rate
> - do the relevant ice implementation
> - ndo_set_tx_maxrate could be replaced with the mentioned ndo call (the
> latter interface is a strict super-set of former)
> - ndo_set_vf_rate could also be replaced with the mentioned ndo call
> (with another small extension to the offload data)
> 
> I think mqprio deserves it's own separate offload interface, as it
> covers multiple tasks other than shaping (grouping queues and mapping
> priority to classes)
> 
> In the long run we could have a generic implementation of the
> ndo_setup_tc(TC_SETUP_QDISC_TBF) in term of devlink rate adding a
> generic way to fetch the devlink_port instance corresponding to the
> given netdev and mapping the TBF features to the devlink_rate API.
> 
> Not starting this due to what Jiri mentioned [1].

Jiri, AFAIU, is against using devlink rate *uAPI* to configure network
rate limiting. That's separate from the internal representation.

