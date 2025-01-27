Return-Path: <netdev+bounces-161198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C592A1FFDC
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695891887572
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3F1D88D7;
	Mon, 27 Jan 2025 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqFUBH1V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2961D7E31;
	Mon, 27 Jan 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013587; cv=none; b=IUsWtTylcvohutQ2W0NI5L27DYJo0BfxglQhMaMcPNvMaXXBH+Zpwtw97PZZ0zt0uoYXXc7CI7qZzx96YxpzZmu6aJP/SUEvzOwb3yW8z/1knAsUv0uqWYBq5VDdl1tjiXbIJpqccRg8GJmfPhz2SjI0jJ2IkcYoQd18+mK6P84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013587; c=relaxed/simple;
	bh=/OeDR5k+4FDDPhh8tmp+lqPzXI7McdFUvLCLFm+Izqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAOQi01W9MBP9VoffpkyUv0PdHEyyIBCT5hLIHIvjnCmWeBWpPaMjDRvKB03sOWbht94nhf0jIXShd2DPCw0b/1bvGOcSHsmJaBMCDpHL0p3uRj285/jXAxo7oq5tgvM2p28KWUXV1xfbrgwhbZfpFc8WxmjlmuoJXqXRPFwQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqFUBH1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF808C4CED2;
	Mon, 27 Jan 2025 21:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738013586;
	bh=/OeDR5k+4FDDPhh8tmp+lqPzXI7McdFUvLCLFm+Izqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oqFUBH1VuudKCknXx1YNMhHxiUykBJYLVoxVqkGjrTrKgODVwjI4oF9CjwfjihZ54
	 1qM/Wpy4BYXhcbaMZQ3Tpd6pmPx2bOlqKb86uLIJNA/o10yNcyIQc42z5T9DLg8tGC
	 Q1ejjwB71++GJ1mLC3tHJv3H9ngLTyAxR+noQ9UitJt3rpcru1rIo6VXvLEi/l6HA7
	 FvRFZ6sSyq6KlzJV/SWYN3P1rch2yVOfia1lLwAChJxOOR52pyEZHJ2Zx0ukM13eHG
	 OW2W2A/BLaOsIHtBDgGMgwJXl74E3X+5+9bW1nv2RThvkQ/9SPW2Q5ldgrzDmAQvDd
	 hFHFz2GQQhmJA==
Date: Mon, 27 Jan 2025 13:33:04 -0800
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
Message-ID: <20250127133304.7898e4c2@kernel.org>
In-Reply-To: <Z5ffCVsbasJKnW6Q@LQ3V64L9R2>
References: <20250121191047.269844-1-jdamato@fastly.com>
	<20250121191047.269844-3-jdamato@fastly.com>
	<CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
	<Z5EtqRrc_FAHbODM@LQ3V64L9R2>
	<CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
	<Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
	<CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
	<Z5P10c-gbVmXZne2@LQ3V64L9R2>
	<CACGkMEv4bamNB0KGeZqzuJRazTtwHOEvH2rHamqRr1s90FQ2Vg@mail.gmail.com>
	<Z5fHxutzfsNMoLxS@LQ3V64L9R2>
	<Z5ffCVsbasJKnW6Q@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 14:31:21 -0500 Joe Damato wrote:
> Actually, I missed a patch Jakub submit to net [1], which prevents
> dumping TX-only NAPIs.

That patch only addresses NAPI ops, here I think we're talking about
attributes of the queue object.

> So, I think this RFC as-is (only calling netif_queue_set_napi
> for RX NAPIs) should be fine without changes.

Weak preference towards making netdev_nl_queue_fill_one() "do the right
thing" when NAPI does not have ID assigned. And right thing IMO would
be to skip reporting the NAPI_ID attribute.

Tx NAPIs are one aspect, whether they have ID or not we may want direct
access to the struct somewhere in the core, via txq, at some point, and
then people may forget the linking has an unintended effect of also
changing the netlink attrs. The other aspect is that driver may link
queue to a Rx NAPI instance before napi_enable(), so before ID is
assigned. Again, we don't want to report ID of 0 in that case.

