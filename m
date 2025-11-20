Return-Path: <netdev+bounces-240420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15333C74A8C
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D328C2ACD0
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981352F1FCB;
	Thu, 20 Nov 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uT1Z529N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736772E542C
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650345; cv=none; b=AQbE2kVwI9yNB2kETNtRoVWznJsP6yi4c9JjA/6zs25fgzUI456bmQ5NrtwDK9J9TXoVEIebeqLGpukSLzJJL9se0dbRzr0p+87ED2JiuCgOJgSBXTk0dqxXzDxyXfTb2lD6h5kRoTvdtgIXsAJPArTukjztZivajFEXfJ0DaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650345; c=relaxed/simple;
	bh=YMmvji9k0l5z1bLwT7W4OFry7JGlInMOVfzy+fHrUQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipSzF0T3oSolRw7VvGF0MmuLAMBNLv7uMxWceTtQIXfgZ7AScHLGs9I9auU5TOI/L893UNWg6E09g0iIwXAgIIG9wz37kSLxj3D/q0x/SVhOETvxd9hPZ/l9zrfmZXVJV+nOeLtmr4cNI/GoWujcR2cWpI8QTXsMLeE9Dx06NH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uT1Z529N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876F0C4CEF1;
	Thu, 20 Nov 2025 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763650344;
	bh=YMmvji9k0l5z1bLwT7W4OFry7JGlInMOVfzy+fHrUQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uT1Z529NPpffZXWmB4mgxYWgXkZTgJrKrv6aNGKyuqgLSp+gvBOiHaulp16AYd7/s
	 i/X6V+Xxbx9lsZFqF7lA0KxxZrcltY8wTOAJjO5gcOm62cFfUtdqJ4kwShg/DL3hL7
	 skmk2ee+mxkY8RFBmuvnNp8RLJFsLWdAjk1KrXQDdhbzEBY0cnTOhht788NLNQUZ8Y
	 Lu3uLEpU3C4gyo0U40QTlb0hUZMbwyUFyPm/t/QG+VbO4xRMf8GbFHK6+TbtUMbhvm
	 HpvTIXCwUTOibKiHDysaQ78CDW8ERGT9/qjbhtj6SAHAPyNEKFOoLg9fcuKDUy1ZkO
	 cCW5uej27Y05g==
Date: Thu, 20 Nov 2025 06:52:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Message-ID: <20251120065223.7c9d4462@kernel.org>
In-Reply-To: <32hbfvtxcn3okpylfcgfeuq7uvrufpij4y7w6au6vxrernwthb@pdxvc6r6jl5z>
References: <20251119165936.9061-1-parav@nvidia.com>
	<20251119175628.4fe6cd4d@kernel.org>
	<32hbfvtxcn3okpylfcgfeuq7uvrufpij4y7w6au6vxrernwthb@pdxvc6r6jl5z>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 13:09:35 +0100 Jiri Pirko wrote:
> Thu, Nov 20, 2025 at 02:56:28AM +0100, kuba@kernel.org wrote:
> >On Wed, 19 Nov 2025 18:59:36 +0200 Parav Pandit wrote:  
> >> When eswitch mode changes, notify such change to the
> >> devlink monitoring process.
> >> 
> >> After this notification, a devlink monitoring process
> >> can see following output:
> >> 
> >> $ devlink mon
> >> [eswitch,get] pci/0000:06:00.0: mode switchdev inline-mode none encap-mode basic
> >> [eswitch,get] pci/0000:06:00.0: mode legacy inline-mode none encap-mode basic
> >> 
> >> Reviewed-by: Jiri Pirko <jiri@nvidia.com>  
> >
> >Jiri, did you have a chance to re-review this or the tag is stale?  
> 
> Nope, I reviewed internally, that's why the tag was taken.
> 
> >I have a slight preference for a new command ID here but if you
> >think GET is fine then so be it.  
> 
> Well, For the rest of the notifications, we have NEW/DEL commands.
> However in this case, as "eswitch" is somehow a subobject, there is no
> NEW/DEL value defined. I'm fine with using GET for notifications for it.
> I'm also okay with adding new ID, up to you.

Let's add a DEVLINK_CMD_ESWITCH_NTF. Having a separate ID makes it
easier / possible to use the same socket for requests and notifications.
-- 
pw-bot: cr

