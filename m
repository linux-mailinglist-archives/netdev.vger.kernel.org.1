Return-Path: <netdev+bounces-233846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD12C1920E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D403406527
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EFA320A03;
	Wed, 29 Oct 2025 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WOjbNjG3"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976531C58A;
	Wed, 29 Oct 2025 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726379; cv=none; b=lXOp0Zylf0BuEl74UcdVW3tJtItCsLIU+G85TJS1tOJcQsS+s6OaBf/Bvs2V9ebREEyzmj/UoQ1gwMz1y5IMyTYazylJvO5CEnyL2EcbajKWQ5RYvYM/SZf3dphbfXkzYAR4Jqfx5GMP8SZVHi8WkJqFYEbPB2ANDYEc1+fFDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726379; c=relaxed/simple;
	bh=7n0FfGcmzp3sNjlSHTd/BtFKyNVUTtXLlmaA27/jVvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9gwqnVNxTS3oCbaFanCcwoVm7o3yMe6BhXDtd+P2U32WOL2EwA8qoZ2hagJmXIZI8JxpleaQOdKzmRpjVIWnac6MoOeMWpc4UKQN2x8VVkRVUWXOGHMaYOlSYL5e1PdIqG59NfzUcNhTrFRCIwMF6auPyXQs/vw+1yJWNLdFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WOjbNjG3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1761726369;
	bh=7n0FfGcmzp3sNjlSHTd/BtFKyNVUTtXLlmaA27/jVvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WOjbNjG3AF9maNjuh2s6gOQMjZ0rrlXABp12uP+CQBMNRqw2Xw3jlvROKaqnLQotL
	 urJusJ8vuDpRaUL+NYo9KAnmJJVZjTZ7B+4sS3eEFOPOJ7cXI/Ra2mxdg7fbNR/tyG
	 dRWFdxkErrxn1Bv1vMG6bMi5gzDwJTi7w/FC4tGLztcDUQKngc+FS8npulPiyc7T8W
	 nXXm/PK8B52iuIocweEfVIJ71Uhw9QgBx169roKE98++Nh5/Tn12eYAV4lljinSxwU
	 NfQsZKzzoPEoy8YiyQNcNoV8sBQlFQsxbAlOK+9HYPusJ9VaBQonU1nZOtmBddoTBs
	 QupA0Fg3FuD8Q==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BCC12641F5;
	Wed, 29 Oct 2025 16:26:08 +0800 (AWST)
Message-ID: <eab5b41703789ae545e744c2df8ae44d884b43d0.camel@codeconstruct.com.au>
Subject: Re: [PATCH net v3] net: mctp: Fix tx queue stall
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jinliang Wang <jinliangw@google.com>, Matt Johnston
	 <matt@codeconstruct.com.au>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Date: Wed, 29 Oct 2025 16:26:08 +0800
In-Reply-To: <20251027065530.2045724-1-jinliangw@google.com>
References: <20251027065530.2045724-1-jinliangw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jinliang,

> The tx queue can become permanently stuck in a stopped state due to a
> race condition between the URB submission path and its completion
> callback.
>=20
> The URB completion callback can run immediately after usb_submit_urb()
> returns, before the submitting function calls netif_stop_queue(). If
> this occurs, the queue state management becomes desynchronized, leading
> to a stall where the queue is never woken.
>=20
> Fix this by moving the netif_stop_queue() call to before submitting the
> URB. This closes the race window by ensuring the network stack is aware
> the queue is stopped before the URB completion can possibly run.

Thanks!

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

