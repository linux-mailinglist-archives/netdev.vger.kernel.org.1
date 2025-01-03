Return-Path: <netdev+bounces-154866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CEEA0029F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820C1162F92
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C53BBF2;
	Fri,  3 Jan 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9uVpa1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB9DDC1;
	Fri,  3 Jan 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735870126; cv=none; b=Zy9a8LUR53gEb69nyQugbMrFNqEHB0HNfvV0TBZxHcB+4iAwou8CIKfs+TrrTEuPE3duvm4+pecJw+5FG+MaWZISWCEPcvXZ33Y6YOGOdFv8ofJ6VU00i7PbqzBxlnV8/0Z05F4K5bJICA/ldk8PID6umB8Qt/4h0tVUmhluz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735870126; c=relaxed/simple;
	bh=Q80Rs2hJHfmj31h4PVTj611kA2JyS59/vWWM6fmuq8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFwsrldvUe2hz05ENWF+TFAwk6k2yk/oTn6DM5CJlqzAjY69LHMNhKlOslMpuPGpA4h+p7VY2kbJPuUpykUhQpdi5vMNY8GgWAVZ0uLe3VXT21TGrTFmxMj/9aQzQSxyrDrxbcfpAc0bZoqYzA9ZaIJrqb5Z1OXZOL44lCAjdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9uVpa1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96ACC4CED0;
	Fri,  3 Jan 2025 02:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735870126;
	bh=Q80Rs2hJHfmj31h4PVTj611kA2JyS59/vWWM6fmuq8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m9uVpa1anPSy64GbQg8xGPko2csJGaVfJZNJ7huo+iD+Qhyz+CR1go4TrU88u9ukP
	 9IOYc9mLhhB2lDLcK8AxU9DRNc6qBXdO5YbRpfUbw5fYZ/yisBkpvV6I2ABrWDTFrB
	 8teKyc0zAYITQWcaATopjeYRvhV4bXZ/RsObLtHmFu+mDefNsPijvO+KBJipQQDLWd
	 mngX0p5tVJt9RYoYRmUCUFWYWruAY6hZKvOGvlbYfUQhbB6AMSIA67IaCgeKYiE1cl
	 /WRaabMniZd737gs5ONTKLhjNFlr6niINZ99Jrp5OHmhs24wWMC6c/Oxux6CMi3B15
	 buYQ0eiCx5NtA==
Date: Thu, 2 Jan 2025 18:08:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leo Yang <leo.yang.sy0@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Leo Yang <Leo-Yang@quantatw.com>
Subject: Re: [PATCH net] mctp i3c: fix MCTP I3C driver multi-thread issue
Message-ID: <20250102180845.30742771@kernel.org>
In-Reply-To: <20241226025319.1724209-1-Leo-Yang@quantatw.com>
References: <20241226025319.1724209-1-Leo-Yang@quantatw.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Dec 2024 10:53:19 +0800 Leo Yang wrote:
> We found a timeout problem with the pldm command on our system.  The
> reason is that the MCTP-I3C driver has a race condition when receiving
> multiple-packet messages in multi-thread, resulting in a wrong packet
> order problem.
>=20
> We identified this problem by adding a debug message to the
> mctp_i3c_read function.
>=20
> According to the MCTP spec, a multiple-packet message must be composed
> in sequence, and if there is a wrong sequence, the whole message will be
> discarded and wait for the next SOM.
> For example, SOM =E2=86=92 Pkt Seq #2 =E2=86=92 Pkt Seq #1 =E2=86=92 Pkt =
Seq #3 =E2=86=92 EOM.
>=20
> Therefore, we try to solve this problem by adding a mutex to the
> mctp_i3c_read function.  Before the modification, when a command
> requesting a multiple-packet message response is sent consecutively, an
> error usually occurs within 100 loops.  After the mutex, it can go
> through 40000 loops without any error, and it seems to run well.
>=20
> But I'm a little worried about the performance of mutex in high load
> situation (as spec seems to allow different endpoints to respond at the
> same time), do you think this is a feasible solution?

I don't see any obvious problem, Tx seems to hold this lock already.
Could you repost with a Fixes tag added?
--=20
pw-bot: cr

