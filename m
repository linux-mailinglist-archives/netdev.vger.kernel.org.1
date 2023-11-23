Return-Path: <netdev+bounces-50591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46EB7F63DA
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88920281677
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177B3FB06;
	Thu, 23 Nov 2023 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSEnw3Hx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681935EF4
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F3FC433C9;
	Thu, 23 Nov 2023 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700756650;
	bh=sO1ksmFy3dxYjZ7SYh2q6RlWRYinApSzz7vBOVeHMe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSEnw3HxsN7djKy4vOGVbhHcp8nkz64GihXtJlz796mA+lNuBCadpeX2I9qlZRlLX
	 9VxlJrvxmfC05VCxgAoN4IxgaiHOb5/WdfuE94VWp7JBHGnGjHX3ttHkONg0fnF4XA
	 tn2kMqdZbTMhRnVIlt81V/cvzP58/E0G2xYedeDj09gIDiUFJ16X0aJjSV7NRgVOd3
	 UNTJCg7tKOL5k66Gj2wnFcHlf8yIamcgeX52Joucc4SuEiTwtWQ4r9eS6gwYD2ZkWE
	 iiE0SIPL5cGa+xrPXREJqM+d4oZWV/YRy0dMZx90RaNGBGItAe/h07p41POvfRoHL2
	 tiW5FgNNbgCgQ==
Date: Thu, 23 Nov 2023 08:24:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <20231123082408.0c038f30@kernel.org>
In-Reply-To: <ZV8qJ1QX9vz3mfpT@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
	<20231120084657.458076-6-jiri@resnulli.us>
	<20231120185022.78f10188@kernel.org>
	<ZVys11ToRj+oo75s@nanopsycho>
	<20231121095512.089139f9@kernel.org>
	<ZV3KCF7Q2fwZyzg4@nanopsycho>
	<20231122090820.3b139890@kernel.org>
	<ZV8qJ1QX9vz3mfpT@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 11:32:07 +0100 Jiri Pirko wrote:
> In this case, the socket is not opened by kernel, but it is opened by
> the userspace app.
> 
> I basically need to have per-user-sk pointer somewhere I'm not clear why
> to put it in struct netlink_sock when I can use sk_user_data which is
> already there. From the usage of this pointer in kernel, I understand
> this is exactly the reason to have it.

Various people stuck various things in that pointer just because,
it's a mess. IIUC the initial motivation for it is that someone
like NFS opens a kernel socket and needs to put private data
somewhere. A kernel user gets a callback for a socket, like data
ready, and needs to find their private state.

> Are you afraid of a collision of sk_user_data use with somebody else
> here? I don't see how that could happen for netlink socket.

Normally upper layer wraps the socket struct in its own struct. 
Look at the struct nesting for TCP or any other bona fide protocol. 
genetlink will benefit from having socket state, I bet it wasn't done
that way from the start because Jamal/Thomas were told to start small.

Please add a properly typed field to the netlink struct, unless you
have technical reasons not to.

