Return-Path: <netdev+bounces-96087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8136B8C4456
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217B91F21BDB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C8B15443A;
	Mon, 13 May 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbyYxF7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118D15442D
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614494; cv=none; b=bBFbZJHv73+ca3lV2GrLDOEB2tryd8+3liPuhpoTnOCFT5vsYO4TiojX0EWWu3N9+UoVyMRS+kphee6TjUyUsFbAvKSqaT4KebcsYlCoGb9aNM/F+71RwFZUBNb7hufHn9qdIAKAtfrGf0FJW2Vmf0mitbhZEa2uFRB5HLqR+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614494; c=relaxed/simple;
	bh=RjxsJcSs6mQfDHKt0IIgZxrvLhm0NZHbmMn6MvcVX5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOjfK0ZD/IUPw1Ch7K3eLlqI13UUmsNOKZtkPrX5WEv8p42XNNSpkuTaO6WyFOICoDJhIX1sbiginEZiTptiEVofCSvarAKZ5X6g1U+eSyrr5OgWeLVkoc4zNvEB+NsDrAblaZi6Bce4HvRKgjh8f30cA1d+vBszrj3nk7PgJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbyYxF7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5B6C32786;
	Mon, 13 May 2024 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715614493;
	bh=RjxsJcSs6mQfDHKt0IIgZxrvLhm0NZHbmMn6MvcVX5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jbyYxF7//qPQ5JFOsHvi5HviQNIGreeS+X57UQulapnC30vEWcUIadNF3lNcJIsum
	 3W+OlYA57+51NrZ5/PCd3qiYSSQFPNyir7xVeju2J5U183jKKonmMj96MVnB9Z+vLm
	 3+MPu9/NPhSPboiGRDz3bFM3ISd2ie6nMHp+jFt3VHjcgD9C8DCBUHQRY6hkKkWsBB
	 E85I3QSTbGqslsHURqXT8ON1Tqase9rhjtXMNiOTajiyqrKNx3WV5udix07ZnL4yby
	 BTHf6mr83SxiRFChEA4+4ma+j9PmM36a+AcIScfZ1q06itA+1Q8TjX0XnVA6ilUX3U
	 lrAW8eRrVRtCQ==
Date: Mon, 13 May 2024 08:34:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Simon Horman <horms@kernel.org>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>, Esben Haabendal
 <esben@geanix.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
Message-ID: <20240513083452.1a594ee3@kernel.org>
In-Reply-To: <4b42fa39-f204-481d-a097-7d41da53f7d6@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240506011637.27272-14-antonio@openvpn.net>
	<4b42fa39-f204-481d-a097-7d41da53f7d6@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 15:37:54 +0200 Antonio Quartulli wrote:
> >    * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
> >    * @napi: NAPI object
> >    * @sock: the socket being used to talk to this peer
> > + * @tcp.tx_ring: queue for packets to be forwarded to userspace (TCP only)
> > + * @tcp.tx_work: work for processing outgoing socket data (TCP only)
> > + * @tcp.rx_work: wok for processing incoming socket data (TCP only)
> > + * @tcp.raw_len: next packet length as read from the stream (TCP only)  
> 
> can you please help me with the following warning from kerneldoc?
> As you can see below, raw_len is an array.
> 
> May that be the reason why the script isn't picking it up correctly?
> 
> drivers/net/ovpn/peer.h:101: warning: Function parameter or struct 
> member 'raw_len' not described in 'ovpn_peer'
> drivers/net/ovpn/peer.h:101: warning: Excess struct member 'tcp.raw_len' 
> description in 'ovpn_peer'
> 
> (line number may differ as I am in the middle of a rebase)

Hm, the script itself is a fairly simple file of perl regexps
You can try to tweak it and send a fix to the list.
I presume using sizeof() to declare an array is fairly uncommon.
Or forgo the sizeof() and use literal 2? :)

