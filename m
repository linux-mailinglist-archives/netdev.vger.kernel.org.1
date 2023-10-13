Return-Path: <netdev+bounces-40566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA217C7AE6
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239D0B208A3
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE9B33DC;
	Fri, 13 Oct 2023 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hdf50J0M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D829CA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89EFC433C8;
	Fri, 13 Oct 2023 00:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697157397;
	bh=SoHARtidtKy4QUVJt+PBqGZ/F8sQuHRolWpdSz5Ehw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hdf50J0Mr/2Y0fEXErWPJMmr6tDNx5vNUjqKjxIZADgi53BX33DD9xoC2AOO/eEnc
	 RJ2YCI80h/NHph+VxoLACkK1qc9oaz35Wwc2LQ9sFIz7fsH+S6F2rAi51c4YmYdD+I
	 FYVS4N1kF1SWWq0IWfA/D14tCPrKi1mORBrk/0FYYGbFr9KkOvaJqyLT1HCRxSO+ho
	 81r3AsXy64naFUb7VTki6cSwwPZKWKva0/vLeGNupWDMRF8m6PA88o8tGUiSxxVlQa
	 LGU3edGpAEFTVvgpDW/DR3teuVqH9pHRKEwp9Qq38yVvbMeBiGHhTsrvL1WCo77pgW
	 qyWjoUK9zyKmg==
Date: Thu, 12 Oct 2023 17:36:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v4 04/10] netdev-genl: Add netlink framework
 functions for queue
Message-ID: <20231012173636.68e6eeee@kernel.org>
In-Reply-To: <8c9704c0-532e-4d35-a073-bee771cd78c5@intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
	<169658369951.3683.3529038539593903265.stgit@anambiarhost.jf.intel.com>
	<20231010192555.3126ca42@kernel.org>
	<fe26f9b6-ff3d-441d-887d-9f65d44f06d0@intel.com>
	<20231012164853.7882fa86@kernel.org>
	<8c9704c0-532e-4d35-a073-bee771cd78c5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 17:24:41 -0700 Nambiar, Amritha wrote:
> I was thinking your review comment was for the entire 
> 'netdev_nl_queue_validate' function (i.e. if the max queue-id validation 
> can be handled in the policy as a range with max value for queue-id, and 
> since max queue-id was not a constant, but varies within the kernel, ex: 
> netdev->real_num_rx_queues, I was unsure of it...). So, another option I 
> could come up with for the validation was a 'pre_doit' hook instead of 
> netdev_nl_queue_validate().

real_num can change if we're not holding rtnl_lock, and we can't hold
the lock in pre :(

> If your comment referred to the enum queue-type range alone, I see, 
> since the policy handles the max check for queue-type, I can remove the 
> default case returning EOPNOTSUPP. Correct me if I'm wrong.

Yup! I only meant the type, you can trust netlink to validate the type.

