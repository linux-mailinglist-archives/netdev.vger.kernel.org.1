Return-Path: <netdev+bounces-94205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC4E8BE9F0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74934B2F981
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28244200D2;
	Tue,  7 May 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La3wr7ds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDA433D6
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100392; cv=none; b=caLGdwX0fvU3fxia2BltjaKRkEHJHqTw5AoCHPgtqLAcVvzDY4gh0WsVUj6k1nCHiBRc6gBEtjtFxd0di2SmN3N4FviOVWlWMj3W+noxicju7uy8xz/+GmuuvrA8cYjk7lAG1eqRjQ1clUa2NTrnk2nbT4Hxzp53pL2eRan7MEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100392; c=relaxed/simple;
	bh=zsEtDb8lT9Y0gqMHNYDGmJx3NOWbYASrrSVCB9e0m3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HazhKmVkHatqu46CwATfpKh107z/PJApFNSxE2OcioWdP39sKBlzSC7KVeXfGSVqiflwdp4sC9ebXbwxMNvL38qMFUfi54S0hnMyZLIcm82mroeiDWPWVXEsZPkcZFOxDazkMJ3kSwnndGpmzgextM2eFnbP3aFreWKdm8gHCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La3wr7ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7981C2BBFC;
	Tue,  7 May 2024 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715100391;
	bh=zsEtDb8lT9Y0gqMHNYDGmJx3NOWbYASrrSVCB9e0m3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=La3wr7dsm/IodnahoyrEho4/AVGn89z92nahZtPs8u2YKkNNyQW71yV5bbxhqh4b9
	 F2AhCPLJGUKswknVs7fGE/dPa+ND9+Li5YUJ27ZxM3pirs787t9IdXTmvyXS0qjv5J
	 6MIoDAI3h925VM3BCvQYOFSm/PEr9dPSxBeM0eW27zjXqhzLR+I1RxTZ7fuBa9C6sS
	 KeIinM7cWrWgdOgrsRPVzUBqohPbFNvimOUGYeA6CV/OMU1H1GyYqsRd9hfUZ0m6CZ
	 yHbKhHbxpmuM+FPye1SzE3UF3NSGXqHxDpn/6IDlwl01FQJ7nTe1RkIU9G8h9tfqHA
	 Fq8lDp/ROFndA==
Date: Tue, 7 May 2024 17:46:26 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH net-next v2 3/9] netdev: add netdev_rx_queue_restart()
Message-ID: <20240507164626.GF15955@kernel.org>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-4-dw@davidwei.uk>
 <20240504122007.GG3167983@kernel.org>
 <b1d37565-578b-455d-a73f-387d713a2893@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d37565-578b-455d-a73f-387d713a2893@davidwei.uk>

On Sun, May 05, 2024 at 05:41:14PM -0700, David Wei wrote:
> On 2024-05-04 05:20, Simon Horman wrote:
> > On Wed, May 01, 2024 at 09:54:04PM -0700, David Wei wrote:
> >> From: Mina Almasry <almasrymina@google.com>
> >>
> >> Add netdev_rx_queue_restart() function to netdev_rx_queue.h. This is
> >> taken from Mina's work in [1] with a slight modification of taking
> >> rtnl_lock() during the queue stop and start ops.
> >>
> >> For bnxt specifically, if the firmware doesn't support
> >> BNXT_RST_RING_SP_EVENT, then ndo_queue_stop() returns -EOPNOTSUPP and
> >> the whole restart fails. Unlike bnxt_rx_ring_reset(), there is no
> >> attempt to reset the whole device.
> >>
> >> [1]: https://lore.kernel.org/linux-kernel/20240403002053.2376017-6-almasrymina@google.com/#t
> >>
> >> Signed-off-by: David Wei <dw@davidwei.uk>
> > 
> > nit: Mina's From line is above, but there is no corresponding Signed-off-by
> >      line here.
> 
> This patch isn't a clean cherry pick, I pulled the core logic of
> netdev_rx_queue_restart() from the middle of another patch. In these
> cases should I be manually adding Signed-off-by tag?

As you asked:

I think if the patch is materially Mina's work - lets say more than 80% -
then a From line and a Signed-off-by tag is appropriate. N.B. this
implies Mina supplied a Signed-off-by tag at some point.

Otherwise I think it's fine to drop both the From line and Signed-off-by tag.
And as a courtesy acknowledge Mina's work some other way.

e.g. based on work by Mina Almasry <almasrymina@google.com>

But perhaps it's as well to as Mina what he thinks :)

...

