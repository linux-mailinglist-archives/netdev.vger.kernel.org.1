Return-Path: <netdev+bounces-59324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E581A767
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 20:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE42A1F238B3
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 19:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074A848780;
	Wed, 20 Dec 2023 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MldE3lCL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCABC48CC1;
	Wed, 20 Dec 2023 19:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B636C433C7;
	Wed, 20 Dec 2023 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703101638;
	bh=SvR08pJSv1fMG1aYuyzwnVSg2LeMS9zvV8dA/9nMRYA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MldE3lCLoi/EpoxEXdCyGslvy/VW6URzDeZrdqU/DQOh4fCTEE0/QpqKI3k1UP6j8
	 WkBj+Hopkz57N/o+t+5/U8kcbpEgM/XgNEI/03/EcaX2zDOHOWVQj5PRPVTUyuEcb6
	 o3RRxJwZoZ7DV4WjotKkTAfENlPeMPgII1H79nRHf2nPNNo/A6eE0b+luOHlyN59+l
	 R0qnin/B9YcZrz9rO8dBTQRbpiZL4ukeATlu4BCIMzYY8IgzKQ5Eyfr2/48ZQf8NqW
	 /5DvfCMPIOb2IKEzqzQAG7TImalzihYptB6MycTE/sVtz5El9XfSmXAAO7eN8FH7Bb
	 1CV4G80JJU19w==
Date: Wed, 20 Dec 2023 11:47:17 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
    kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
    nhorman@tuxdriver.com, matttbe@kernel.org, yotam.gi@gmail.com, 
    jiri@resnulli.us, jacob.e.keller@intel.com, johannes@sipsolutions.net, 
    andriy.shevchenko@linux.intel.com, fw@strlen.de
Subject: Re: [PATCH net-next v2] genetlink: Use internal flags for multicast
 groups
In-Reply-To: <20231220154358.2063280-1-idosch@nvidia.com>
Message-ID: <1cce66bc-af3f-97d8-f898-130e81fcfcff@kernel.org>
References: <20231220154358.2063280-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 20 Dec 2023, Ido Schimmel wrote:

> As explained in commit e03781879a0d ("drop_monitor: Require
> 'CAP_SYS_ADMIN' when joining "events" group"), the "flags" field in the
> multicast group structure reuses uAPI flags despite the field not being
> exposed to user space. This makes it impossible to extend its use
> without adding new uAPI flags, which is inappropriate for internal
> kernel checks.
>
> Solve this by adding internal flags (i.e., "GENL_MCAST_*") and convert
> the existing users to use them instead of the uAPI flags.
>
> Tested using the reproducers in commit 44ec98ea5ea9 ("psample: Require
> 'CAP_NET_ADMIN' when joining "packets" group") and commit e03781879a0d
> ("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group").
>
> No functional changes intended.
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> v2:
> * Add a comment for each flag
> ---
> include/net/genetlink.h | 9 ++++++---
> net/core/drop_monitor.c | 2 +-
> net/mptcp/pm_netlink.c  | 2 +-

Thanks Ido.

For the mptcp change:

Reviewed-by: Mat Martineau <martineau@kernel.org>


> net/netlink/genetlink.c | 4 ++--
> net/psample/psample.c   | 2 +-
> 5 files changed, 11 insertions(+), 8 deletions(-)

