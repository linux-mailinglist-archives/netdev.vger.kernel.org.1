Return-Path: <netdev+bounces-94713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 387178C051C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 21:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D8F1C21009
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D16130AE7;
	Wed,  8 May 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQa1tWWS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F412B156
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196794; cv=none; b=MzcInmEIzpnjnlC7Uo3Zbtn49RuhEzp1Z9dispe1F4D5EOvfPX3TN5TNMSREtnGehFOYmBKXXVewWrlB5UydO7g8zQwIClbAQEbMApzXlABU1bJ0pxCMaCL1bLbLH24gTmS5mPWCs5+URf3hPAYL+rAfoDH/Akrpbq91g3/sJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196794; c=relaxed/simple;
	bh=BqASjYSExQ+D7Yd+cxznVTfXPxXorUXWvTG6AeWlH3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVSUiD5lylCUasMYuNVL7OY0jfwdvBZEWt6sQQ5T6GGCOuCu85XYb7gHoOAcnsBKnhhidCg4Vq3TDeqn88vjN18SxUd7ZZ4e2zQ1L2M7Bz1L+BxjHXzDtrQSq1B801TnjhOaohwmAtMGdIrXiLSY36nzq9WWWgWNnmeGNPDSwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UQa1tWWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D5DC113CC;
	Wed,  8 May 2024 19:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715196794;
	bh=BqASjYSExQ+D7Yd+cxznVTfXPxXorUXWvTG6AeWlH3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQa1tWWSpnsQOi3dp5NKMdGe3cMEdHHphY+y/2nUymWnqqf/e8+UIEkdtLg5yPur6
	 0W4BBrcZkwt1SgmHsROH0hNeDsAJ+7hNCBDtKfr7OUUBtL1AeockbogA93jl4TBVpT
	 fIT8X+LXl2gz0CttL5Ciwzs3L6an8JFQKIIgmAmE=
Date: Wed, 8 May 2024 20:33:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: cve@kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
	netdev@vger.kernel.org,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, wei.liu@kernel.org,
	paul@xen.org, Jakub Kicinski <kuba@kernel.org>, kirjanov@gmail.com,
	dkirjanov@suse.de, kernel-team@cloudflare.com,
	security@xenproject.org, xen-devel@lists.xenproject.org,
	George Dunlap <dunlapg@umich.edu>
Subject: Re: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle
Message-ID: <2024050802-playful-brick-0c67@gregkh>
References: <171154167446.2671062.9127105384591237363.stgit@firesoul>
 <CALUcmU=xOR1j9Asdv0Ny7x=o4Ckz80mDjbuEnJC0Z_Aepu0Zzw@mail.gmail.com>
 <CALUcmUkvpnq+CKSCn=cuAfxXOGU22fkBx4QD4u2nZYGM16DD6A@mail.gmail.com>
 <CALUcmUn0__izGAS-8gDL2h2Ceg9mdkFnLmdOgvAfO7sqxXK1-Q@mail.gmail.com>
 <CAFLBxZaLKGgrZRUDMQ+kCAYKD7ypzsjO55mWvkZHtMTBxdw51A@mail.gmail.com>
 <2024042544-jockstrap-cycle-ed93@gregkh>
 <9a2018c6-4efb-4bfe-b90f-531a072f0ef8@citrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2018c6-4efb-4bfe-b90f-531a072f0ef8@citrix.com>

On Tue, May 07, 2024 at 02:57:08PM +0100, Andrew Cooper wrote:
> Hello,
> 
> Please could we request a CVE for "xen-netfront: Add missing
> skb_mark_for_recycle" which is 037965402a010898d34f4e35327d22c0a95cd51f
> in Linus' tree.
> 
> This is a kernel memory leak trigger-able from unprivileged userspace.
> 
> I can't see any evidence of this fix having been assigned a CVE thus far
> on the linux-cve-annouce mailing list.

CVE-2024-27393 is now created for this, thanks.

greg k-h

