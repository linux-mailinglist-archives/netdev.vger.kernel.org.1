Return-Path: <netdev+bounces-217274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D2B38240
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A787B2F6D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A202F39DB;
	Wed, 27 Aug 2025 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6cZ5VYK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11620ADF8;
	Wed, 27 Aug 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297638; cv=none; b=JMstaek+ZXzK/ofbRydfuYKTwRJrsFa3/DjXVFHT/xXxVfhiB5/6Q550o0tvMvEt5xOfTFxMfK1Qw04EelUTJT9VHlAaDkC+YIJAKeQF4+D4VyuUxspaQ/OiBnZHDApNaJEpVqvY1r8kEK+wsjwwVq5nsq/FsdIqoAWmhWkB3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297638; c=relaxed/simple;
	bh=fl4z7PN1ePnizUpqZSWphJeM1YqqPrxngBZ54KduYL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONDXD1E2wBMuLq4CZMA/U4x+wFq/dBJczyPe6Cpuvu68IL09x1hMjHkCqKWFbhDwXy1BiiwwGel6nyqdiJMMDN4cG4VcFIIDI0d8eoUq3+Q28vDlI4d70YDCW2YRb/jZHXdua4OhQSk2HpTeimSSI6y5XUMYesgmoN3rYEhaETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6cZ5VYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A949C4CEEB;
	Wed, 27 Aug 2025 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756297637;
	bh=fl4z7PN1ePnizUpqZSWphJeM1YqqPrxngBZ54KduYL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6cZ5VYKjRSj1gzKSvqD3MRGFfbztClbAA86vZqAXTF7ZzgH11BO+VkeLxsDILGcY
	 VEVS+0nPeOpB/pBOQhE3sP91eOEcd6goccHDyOnHjoPYuxeLVBtclS1cuMOi2JaBxY
	 EihZvq6sWvEdVGOQeIJfzJh12eN8tBY9BeZG5wMQ7JSk2lvwgycOuodUG2NdZwWF8Y
	 tqVOeFdCorpEbERaAGhPINJLVFGP4vdeD5jhUJfTqc8AIkBua5iwdJ+v4t74d3K0/s
	 R731u1sonuxCXjZZCkhVsjYqOVQC0y/w2V0PZxCKP3gfMxACsZ8N+RNXyj3nRmETf/
	 Y5mRtRB13x/XA==
Date: Wed, 27 Aug 2025 13:27:12 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kohei.enju@gmail.com, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2 iwl-next 1/2] igbvf: add lbtx_packets and lbtx_bytes
 to ethtool statistics
Message-ID: <20250827122712.GA1063@horms.kernel.org>
References: <20250818151902.64979-4-enjuk@amazon.com>
 <20250818151902.64979-5-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818151902.64979-5-enjuk@amazon.com>

On Tue, Aug 19, 2025 at 12:18:26AM +0900, Kohei Enju wrote:
> Currently ethtool shows lbrx_packets and lbrx_bytes (Good RX
> Packets/Octets loopback Count), but doesn't show the TX-side equivalents
> (lbtx_packets and lbtx_bytes). Add visibility of those missing
> statistics by adding them to ethtool statistics.
> 
> In addition, the order of lbrx_bytes and lbrx_packets is not consistent
> with non-loopback statistics (rx_packets, rx_bytes). Therefore,
> align the order by swapping positions of lbrx_bytes and lbrx_packets.
> 
> Tested on Intel Corporation I350 Gigabit Network Connection.
> 
> Before:
>   # ethtool -S ens5 | grep -E "x_(bytes|packets)"
>        rx_packets: 135
>        tx_packets: 106
>        rx_bytes: 16010
>        tx_bytes: 12451
>        lbrx_bytes: 1148
>        lbrx_packets: 12
> 
> After:
>   # ethtool -S ens5 | grep -E "x_(bytes|packets)"
>        rx_packets: 748
>        tx_packets: 304
>        rx_bytes: 81513
>        tx_bytes: 33698
>        lbrx_packets: 97
>        lbtx_packets: 109
>        lbrx_bytes: 12090
>        lbtx_bytes: 12401
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


