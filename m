Return-Path: <netdev+bounces-39778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25977C4727
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BF01C20D57
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB16814;
	Wed, 11 Oct 2023 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epGL/J0b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763580D;
	Wed, 11 Oct 2023 01:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961D7C433C8;
	Wed, 11 Oct 2023 01:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696987114;
	bh=MVgS0pN9w8AckyfTLTkMpsiuBuE5xCRBX+y812EyspE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=epGL/J0bt6eA1/yO21fN39dbQ7HfIYfLw52pFv6Am4gAhIOb4gEgvEmkCwxYkYTbC
	 L2pD395SVfEjw216Gce3/neA+uTZDKuqM6OVE+Ikb/1gGxWslw+fmczXlTtS63Y2qt
	 9e9ubbOqObzqEGpCkvbxLwE5UweafzjRCXoJ/QrK4tp6GHE6ietR/BYS2jaAjPN9O/
	 oztsNdIVMnJuMo2SpvgW3/RR4fK6qkaRvtZUpRhRlYoZz/5XEyxKrlsR4wFqWIhf9i
	 a8g8YNh2RML3LFNipb7+DsAFaBWXWOkmL2Lgg8LDzQls0nfL7Q4g1Y4NScbMttZFay
	 2bu2z/RAV0JmA==
Date: Tue, 10 Oct 2023 18:18:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
 <horms@kernel.org>, <leon@kernel.org>, <corbet@lwn.net>,
 <linux-doc@vger.kernel.org>, <rdunlap@infradead.org>
Subject: Re: [PATCH net-next v4 5/5] ice: add documentation for FW logging
Message-ID: <20231010181832.176d9e2b@kernel.org>
In-Reply-To: <bc8fe848-b590-fa4c-cc6b-5ccdf89ce0fa@intel.com>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
	<20231005170110.3221306-6-anthony.l.nguyen@intel.com>
	<20231006164623.6c09c4e5@kernel.org>
	<bc8fe848-b590-fa4c-cc6b-5ccdf89ce0fa@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 16:00:13 -0700 Paul M Stillwell Jr wrote:
> >> +Retrieving FW log data
> >> +~~~~~~~~~~~~~~~~~~~~~~
> >> +The FW log data can be retrieved by reading from 'fwlog/data'. The user can
> >> +write to 'fwlog/data' to clear the data. The data can only be cleared when FW
> >> +logging is disabled.  
> > 
> > Oh, now it sounds like only one thing can be enabled at a time.
> > Can you clarify?
> >   
> 
> What I'm trying to describe here is a mechanism to read all the data 
> (whatever modules have been enabled) as it's coming in and to also be 
> able to clear the data in case the user wants to start fresh (by writing 
> 0 to the file). Does that make sense?

Yes that part does.

> I probably wasn't clear in the 
> previous section that the user can enable many modules at the same time.

Probably best if you describe enabling of multiple modules in the
example. I'm not sure how one disables a module with the current API.

> > Why 4K? The number of buffers is irrelevant to the user, why not let
> > the user configure the size in bytes (which his how much DRAM the
> > driver will hold hostage)?  
> 
> I'm trying to keep the numbers small for the user :). I could say 
> 1048576 bytes (256 x 4096), but those kinds of numbers get unwieldy to a 
> user (IMO).

echo $((256 * 4096)) >> $the_file

But also...

> The FW logs generate a LOT of data depending on what modules are enabled 
> so we typically need a lot of buffers to handle them.
> 
> In the past we have tried to use the syslog mechanism, but we generate 
> SO much data that we overwhelm that and lose data. That's why the idea 
> of using static buffers is appealing to us. We could still overrun the 
> buffers, but at least we will have contiguous data. The problem then 
> becomes one of allocating enough space for what the user is trying to 
> catch instead of trying to start/stop logging and hoping you get all the 
> events in the log.
> 
> I can drop the mention of 4K buffers in the documentation. Or we could 
> use terms like 1M, 2M, 512K, et al. That would require string parsing in 
> the driver though and I'm trying to avoid that if possible. What do you 
> think?

.. I thought such helpers already existed.

