Return-Path: <netdev+bounces-161207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D5A20087
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27E1162970
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F3E1DAC81;
	Mon, 27 Jan 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvx4vRR/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8FB64A;
	Mon, 27 Jan 2025 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016643; cv=none; b=UwqrIMH0niZx3mO3hopdcPBKbRVh8yFHH++EJ4SIVk+3bHQlIOYgWecoypzmXYE68ww+yWKVNYtTW5V+ltCYqriMO9Db0UB2sp4dGrIkDb2GSEKuknOelizf5Dwu+YgGABaQzK1EGkhtcGj25lNmHxnGlnJ59k3DeJnv6P7AD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016643; c=relaxed/simple;
	bh=XGepAOlaGVpZbPKJ9qsKU3cIrTbHjdgZ6PAelXcfGXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cE6hUbpJbggO8uo5fMgotWiRiKk8a2afYLqroFMB3MPn0vkbeFibThwNpL9dSca9sD+fFZ9B8bQ9wQufnhC9DdsO6dOU7XQ3Ro1eo3RJjSpRddbdNSeGa/w/mah0nwWkrAJ2Y+7wHkyVPVk/uMmijmKKmm07CZrrI/qBSfZ5vc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvx4vRR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC34C4CED2;
	Mon, 27 Jan 2025 22:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738016642;
	bh=XGepAOlaGVpZbPKJ9qsKU3cIrTbHjdgZ6PAelXcfGXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xvx4vRR/yyq+BbukOaT0YG90hBeu8liLZd2VHgAlD4rrhd+9vnFcE3bf+hmgEMxEj
	 nP5lqC2SVB94SR1gTiWRMlPwhAUc7kRlo710dbtO1XLNvLE2BSbA4clnRqgQOLycLd
	 O6iC7rRHKkdy+MJDWmEdikOxx2PLfOVXHr1jtqqt+YP2lqkNr2dE2LkLAuHxsb8uyw
	 7l1ax/W3oLRiN9ZhExAcchEVotvwQ5VPXbTxXl9UWBDZOGAXlcljdzYozt16tkcuvS
	 TnDxW1OvPt5p8zhw50J6ByecG5npSJp66/hOe/ioAh1YAcrkZIPS+6Tgd6DyYXG052
	 YweQ+MrX5Vxqw==
Date: Mon, 27 Jan 2025 14:24:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 gerhard@engleder-embedded.com, leiyang@redhat.com,
 xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca, "Michael S. Tsirkin"
 <mst@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <20250127142400.24eca319@kernel.org>
In-Reply-To: <Z5gDut3Tuzd1npPe@LQ3V64L9R2>
References: <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
	<Z5EtqRrc_FAHbODM@LQ3V64L9R2>
	<CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
	<Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
	<CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
	<Z5P10c-gbVmXZne2@LQ3V64L9R2>
	<CACGkMEv4bamNB0KGeZqzuJRazTtwHOEvH2rHamqRr1s90FQ2Vg@mail.gmail.com>
	<Z5fHxutzfsNMoLxS@LQ3V64L9R2>
	<Z5ffCVsbasJKnW6Q@LQ3V64L9R2>
	<20250127133304.7898e4c2@kernel.org>
	<Z5gDut3Tuzd1npPe@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 17:07:54 -0500 Joe Damato wrote:
> > Tx NAPIs are one aspect, whether they have ID or not we may want direct
> > access to the struct somewhere in the core, via txq, at some point, and
> > then people may forget the linking has an unintended effect of also
> > changing the netlink attrs. The other aspect is that driver may link
> > queue to a Rx NAPI instance before napi_enable(), so before ID is
> > assigned. Again, we don't want to report ID of 0 in that case.  
> 
> I'm sorry I'm not sure I'm following what you are saying here; I
> think there might be separate threads concurrently and I'm probably
> just confused :)
> 
> I think you are saying that netdev_nl_napi_fill_one should not
> report 0, which I think is fine but probably a separate patch?
> 
> I think, but am not sure, that Jason was asking for guidance on
> TX-only NAPIs and linking them with calls to netif_queue_set_napi.
> It seems that Jason may be suggesting that the driver shouldn't have
> to know that TX-only NAPIs have a NAPI ID of 0 and thus should call
> netif_queue_set_napi for all NAPIs and not have to deal think about
> TX-only NAPIs at all.
> 
> From you've written, Jakub, I think you are suggesting you agree
> with that, but with the caveat that netdev_nl_napi_fill_one should
> not report 0.

Right up to this point.

> Then, one day in the future, if TX-only NAPIs get an ID they will
> magically start to show up.
> 
> Is that right?

Sort of. I was trying to point out corner cases which would also
benefit from netdev_nl_queue_fill_one() being more careful about 
the NAPI IDs it reports. But the conclusion is the same.

> If so, I'll re-spin the RFC to call netif_queue_set_napi for all
> NAPIs in virtio_net, including TX-only NAPIs and see about including
> a patch to tweak netdev_nl_napi_fill_one, if necessary.

netdev_nl_queue_fill_one(), not netdev_nl_napi_fill_one()

Otherwise SG.

After net-next reopens I think the patch to netdev_nl_queue_fill_one()
could be posted separately. There may be drivers out there which already
link Tx NAPIs, we shouldn't delay making the reporting more careful.

