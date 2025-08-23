Return-Path: <netdev+bounces-216241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C824FB32B90
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA28F1B671B0
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCD91FDA94;
	Sat, 23 Aug 2025 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GgX5PohX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91BC2E0;
	Sat, 23 Aug 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755975891; cv=none; b=f/9J1fgkJkYDslSdaogtML7Vq8Y9aTBrdt49M03aiZ0xAXJPAZ8SQLWSw0NQRGEkYW30eSNMlqrK47fxarJDHtMwvlezp95pXKOEhrCJkrCI+TZ0OX9QkC8D9NBiJovA8MXpe4BPwyMTLBUqy3ACUPpjmxBUXgRQN7u0bsGqyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755975891; c=relaxed/simple;
	bh=PYci9OAh12Y7SG6DScPtfHOJ8ghkDJtkM0fCHJQhGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr6MZS3Wu2MDWY1faVsVMpN2ckqEXSh2fL/7y1gPkX1DO7oo4aF3IaqF4aB/A3xjHazwEas6DJLKrZu5yOhjM3TbgfhH3yDy9ho0P8IFp3asLteWG8EY6MWRyEQyA/CdhtYuBKIjd0RzCu5tximgOMvNKCDgd4dGwRywVdv8CCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GgX5PohX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JV/U2PEabZ8vJakMuUdVm46V5/z9LSLuPiXOcpecQaU=; b=GgX5PohXUQWHlmWI//pB3Ju1s+
	JClc4UcpwMUlSJJ4kcWn3G1piEdmWnJirVxvYV15ghvzPGuhrHAvvcwkqVWSHz9Yn8SRn7WqiXUy1
	t5Ixu9a3KTVl+JYTbN2bh7sN7NIj6mWL0+ZDXWzym4xyJ8I2ycVwzHA0wPbVf3XuP9z4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uptXZ-005mCO-7G; Sat, 23 Aug 2025 21:04:37 +0200
Date: Sat, 23 Aug 2025 21:04:37 +0200
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
Subject: Re: [PATCH v3 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Message-ID: <d4a28c9e-7b7f-4904-8c29-cf87ce322955@lunn.ch>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-2-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823190110.1186960-2-shenwei.wang@nxp.com>

On Sat, Aug 23, 2025 at 02:01:06PM -0500, Shenwei Wang wrote:
> Refactor code to support Jumbo frame functionality by adding a member
> variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

This looks sensible now. Thanks

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

