Return-Path: <netdev+bounces-48237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DD7EDB54
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 06:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF82DB209BC
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 05:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D9CA46;
	Thu, 16 Nov 2023 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXTdquPf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D18C8EE
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5DFC433C8;
	Thu, 16 Nov 2023 05:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700114009;
	bh=P0Gs4ZUIQvJp5YnAc/ln0Sc7g1rdR/2Mp8f1Wd03Kao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QXTdquPfOJsS6uV9bOzp23h38lTvYARqLUIvy/wujgviLFL+hm+/pi8KZm+K8atTt
	 eI8aIrRbFN+SfLC4vVL710U/ItBXH+Q4SsFyFkJurqwgqYDmCHe4M+Y2QpcqyFbByT
	 7WPTVF+Xq+q5fRITskOV31Mep9SxoOyLJd4rRRu2c31a14H7UNysQ0lN03+7kLVgP0
	 lSiDIhqRPhy2jimI3Dfb5zzKF8fO9S520OpKuBZWrqFR4wZ9JzbRMj/ujo0vCMwn8F
	 YupZY4Pm9T0MGZ4keGHlH1VmyJDAOgOjvWB+hzfy8UcwkGoLx4MB1njmEh6OC6/ZoS
	 2SsYxLo9EE6Jg==
Date: Thu, 16 Nov 2023 00:53:27 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v7 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <20231116005327.365065ab@kernel.org>
In-Reply-To: <3edec947-a760-4605-9334-81c40ce62670@intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
	<169992177699.3867.16531901770683676993.stgit@anambiarhost.jf.intel.com>
	<20231114234801.0faee5db@kernel.org>
	<3edec947-a760-4605-9334-81c40ce62670@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Nov 2023 13:05:24 -0800 Nambiar, Amritha wrote:
> We could drop the word "queue" from all attrs of queue-object and also 
> the word "napi" from all attrs of napi-object. Only concern is, queue 
> object will have NAPI-ID as "napi-id" while the napi object will have 
> NAPI-ID as "id". Same values but referred to as "id" and "napi-id" 
> depending on the object (although should be fine as the command names 
> carry the object names).
> Here's an example how this would look:
> 
> $ queue-get  --json='{"ifindex": 12, "id": 0, "type": 0}'
> {'ifindex': 12, 'napi-id': 593, 'id': 0, 'type': 'rx'}
> 
> $ napi-get --json='{"id": 593}'
> {'ifindex': 12, 'irq': 291, 'id': 593, 'pid': 3817}
> 
> Let me know if this is okay.

It's a bit of a judgment call. The CLI JSON obviously looks fine with 
the $obj-id format, perhaps even a tiny bit more consistent. 
But the C uAPI defines are unpleasant with the NETDEV_$OBJ_$OBJ_ID
repetition. And I think the same thing would happen in Python code.

I'm guessing user may end up writing code like:

	queue = netdev.get_queue({'id': X, 'type': "rx"})
	do_something_with(queue_id=queue["id"])

which seems pretty clear. With the $obj-id it'd be:

	queue = netdev.get_queue({'queue-id': X, 'queue-type': "rx"})
                           ^^^^^   ^^^^^          ^^^^^
	do_something_with(queue_id=queue["queue-id"])
                          ^^^^^    ^^^^^  ^^^^^

IOW we'd also say "queue" a lot...

So yes, I'm only 80% sure we won't regret this but let's drop the 
$obj AKA queue / napi prefix.

