Return-Path: <netdev+bounces-250195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72734D24EFC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A7973011EF8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998013A1E69;
	Thu, 15 Jan 2026 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/e+vRr3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603F39527C;
	Thu, 15 Jan 2026 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487203; cv=none; b=b6C6vWxunl8dg7h93DDchbJ+xib7W/GYLsI2z9fR9Iq6DW9TtKAfENCwiH6Put3mRwacln33JlD+s9XcANtnFzcdDsQgiIp5MxnMwc741J86GuhYlHKFop7PqGGxlmKTfVxlja1x3D7NhbEoAX6kS+QLRfUm7Fu9ZZEWm8Af01o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487203; c=relaxed/simple;
	bh=PMAJAir+s0K7IBCyK9b2N9yWQhFNnwBw4MRBfncPqVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCDtCs+oApK5oj1IiSJinTmFpMUU8YO9SYzSCSRy8Bpk+AfNrL6FprqTgChma6FTrBaqCXna6JANJrqssAZE655XJk7fsv542WiOUsDw8cTczYCUPOt4hUSPKdEKf6Ic0xHVTjKmWO80prf2s1dTpWUX5ZziCDE5mkT+dS9yymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/e+vRr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F731C116D0;
	Thu, 15 Jan 2026 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768487203;
	bh=PMAJAir+s0K7IBCyK9b2N9yWQhFNnwBw4MRBfncPqVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/e+vRr3yMnj05RMUWiW/nquWu2AgkZz8V8HB3buU57g2zERJDI83jH4s0Pxt0m84
	 VC/caCJPd9uqFhlAi91h9J8xIONaj+G7xecXlkJzVHd91iQg6Aw+cUpxjpM1tElAa5
	 kUM/4Xzym2j/zRJlwOhXlLgfqZ0gU7y0/ML91nllzb34/8pq/ky/Yu6qBSVazAcVvJ
	 aR9pcW06YOn3HQRdGziAv1svEZm1R+CcvXjqqg1v7Ur5SPUhoUTTeQZCc1kKVZI7Lz
	 zbbbKU785Ni1by/hM7lOTLwl7Glxn6tzYRvlG9v2zSMSCawEeGI9+tS2pf8/GyXYCz
	 M3VtK+ZOZryJw==
Date: Thu, 15 Jan 2026 06:26:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr =?UTF-8?B?VmFuxJtr?= <arkamar@atlas.cz>
Cc: fushuai.wang@linux.dev, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 davem@davemloft.net, vadim.fedorenko@linux.dev, Jason@zx2c4.com,
 wireguard@lists.zx2c4.com, wangfushuai@baidu.com
Subject: Re: [net-next, v3] wireguard: allowedips: Use kfree_rcu() instead
 of call_rcu()
Message-ID: <20260115062641.57ef05fe@kernel.org>
In-Reply-To: <202611581213-aWihXdQpdnhXv606-arkamar@atlas.cz>
References: <20260112130633.25563-1-fushuai.wang@linux.dev>
	<20260115033237.1545400-1-kuba@kernel.org>
	<202611581213-aWihXdQpdnhXv606-arkamar@atlas.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 09:12:13 +0100 Petr Van=C4=9Bk wrote:
> Hi Jakub,
>=20
> Minor side note: I noticed a small typo in the AI review foreword. I
> assume this is part of a template:
>=20
> On Wed, Jan 14, 2026 at 07:32:37PM -0800, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least pausible. =20
>                                                         ^~~~~~~~
> pausible -> plausible

Ah, thanks :)

