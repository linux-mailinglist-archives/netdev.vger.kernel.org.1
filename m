Return-Path: <netdev+bounces-165499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42AAA325E9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77690188BE6E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7992A20B1FD;
	Wed, 12 Feb 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xnsLUv5R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EA1F866A;
	Wed, 12 Feb 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363843; cv=none; b=ZU5EgWia4gk4qE/Xp/2KU3XG5R1LBH6u4008Fd1CJVUjTBga4B+qb1DThL6rEiUmDfCvRm3OtSWc1EBn5PjvM67xf+OwOIu26rR8H56RbpDeULQ30ZClk+Hi/qWARKLKYpOLKqZcQrexMsxBf9zue5Dc8749v9W2rv7Pn7jB7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363843; c=relaxed/simple;
	bh=qle33u/dAL1N4VPbUJFW2UE1ueYRFNYlUQ6lUOAGSv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpW/uOTzg+dJWYXbnr6D8kqjyrwgsncqudAS7tmbnxV0LfXMTr1chrDWRVk382/zR8ddRQWFub6daEHydacZpcG+gRyC02iNX746zNHQxUVSj0gQ7+B/2DqXId/pE70EiISok/s52NcnVm8uAbQE14ehCZ8LWJFIDoif+0nACEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xnsLUv5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8F0C4CEDF;
	Wed, 12 Feb 2025 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739363842;
	bh=qle33u/dAL1N4VPbUJFW2UE1ueYRFNYlUQ6lUOAGSv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xnsLUv5RYAAhxlNxnQXfsx44gUtY8xhm7P+hp54oF8MIbzKkV4Xu+7c/+qCsafERh
	 dyL/cgdGKN0pgoJY6vE3rp6DAl7pxZ208t0sxsCtmTUKayoiKO111pK2tNkBg1AmP6
	 5UAl31m8DHxvsFm/B8ub2ke77iTHlQKPcL55Fdnc=
Date: Wed, 12 Feb 2025 13:36:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	viro@zeniv.linux.org.uk, jiri@resnulli.us,
	linux-kernel@vger.kernel.org, security@kernel.org,
	syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] net: 802: enforce underlying device type for GARP
 and MRP
Message-ID: <2025021207-stature-unmasking-937b@gregkh>
References: <20250212113218.9859-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212113218.9859-1-oscmaes92@gmail.com>

On Wed, Feb 12, 2025 at 12:32:18PM +0100, Oscar Maes wrote:
> When creating a VLAN device, we initialize GARP (garp_init_applicant)
> and MRP (mrp_init_applicant) for the underlying device.
> 
> As part of the initialization process, we add the multicast address of
> each applicant to the underlying device, by calling dev_mc_add.
> 
> __dev_mc_add uses dev->addr_len to determine the length of the new
> multicast address.
> 
> This causes an out-of-bounds read if dev->addr_len is greater than 6,
> since the multicast addresses provided by GARP and MRP are only 6 bytes
> long.
> 
> This behaviour can be reproduced using the following commands:
> 
> ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
> ip l set up dev gretest
> ip link add link gretest name vlantest type vlan id 100
> 
> Then, the following command will display the address of garp_pdu_rcv:
> 
> ip maddr show | grep 01:80:c2:00:00:21
> 
> Fix this by enforcing the type and address length of
> the underlying device during GARP and MRP initialization.
> 
> Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
> Reported-by: syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
> Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> ---
>  net/802/garp.c | 5 +++++
>  net/802/mrp.c  | 5 +++++
>  2 files changed, 10 insertions(+)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

