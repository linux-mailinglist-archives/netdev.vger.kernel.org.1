Return-Path: <netdev+bounces-216243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE1B32B99
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E54178260
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5023BF96;
	Sat, 23 Aug 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eCEPuZim"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546C21B905;
	Sat, 23 Aug 2025 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755976296; cv=none; b=g+yRM78/SaqvRIFcgyRVktIa6Q8SQvAwj9zf1xmLzj0MM/sGE218FeJkyNfNCLyk2fFG0w0b0odGkQ5ikvoZrI/rICbtiJu13HXhBbbpkg0uN5lbzZcF0e0vR4GOWkwhilsPrc7c+bZFmwCc/8Y9UZVK8oWrpR4NFydDObeBh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755976296; c=relaxed/simple;
	bh=lsq95s/732jE4C3nM4zlgdt2WMXnlUfbMrqTqawyuOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1oaHrgyV4lPGr0412DZxDWupza2RU40gX8718xIi1bGt5XibK89Xjsm1Z53DM5Yy/VLHGAqm1mkwJRQethS52GWV/HjoPZ/0CXyqw5gqW+jISqbc+QxUEBHXlh+2iMFmuB6lJji3m//NHeWcoTbHybypNfUsIv3+iZwY6IAiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eCEPuZim; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vcB5e3XbzFW6qOme7k+k1AL2VmG2ZIbx+XXJlr6h78s=; b=eCEPuZimr5VFB5jtXV7qh+pC16
	VU4IggHbrysevpy44nZeYidNBFZY31ZXD/CfK9hcGifpqjBt77atzxB7K9pTPI83UPK3umOY2rRw5
	Vw6+vDo+4RB3rcFFDC6Y3XCfARJ+HPUJZXgSK6iQxF5oLGnhHAKNFS+6pqgTHx04lFhc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upte8-005mEm-Ko; Sat, 23 Aug 2025 21:11:24 +0200
Date: Sat, 23 Aug 2025 21:11:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Message-ID: <0abb2c91-3786-4926-b0e3-30b9e222424d@lunn.ch>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-4-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823190110.1186960-4-shenwei.wang@nxp.com>

On Sat, Aug 23, 2025 at 02:01:08PM -0500, Shenwei Wang wrote:
> Add a new rx_frame_size member in the fec_enet_private structure to
> decouple frame size configuration from max_buf_size. This allows more
> precise control over RX frame length settings. It is particularly useful
> for Jumbo frame support because the RX frame size may possible larger than
> the allocated RX buffer.

Please could you extend that a little. What happens if the received
frame is bigger than the buffer? Does the hardware fragment it over
two buffers?

> 
> Configure TRUNC_FL (Frame Truncation Length) based on the RX buffer size.
> Frames exceeding this limit will be treated as error packets and dropped.

This bit confuses me. You want to allow rx_frame_size to be bigger
than the buffer size, but you also want to discard frames bigger than
the buffer size?

    Andrew

---
pw-bot: cr

