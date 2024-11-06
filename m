Return-Path: <netdev+bounces-142146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 938109BDA63
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4887A1F23753
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0838396;
	Wed,  6 Nov 2024 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0N11mMm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950AD1F16B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853429; cv=none; b=tbkgGkXDl8M7HTGoaWuZd8utpyNhBIKpIaWJ5ciFIWyeGIwtBPfvLIDbEzJAO0YoQVyToGTQjHvjmfWsYajVRv6dPmngHaH028ERUDdN0SYsj5PnkzUWmhpTNNj9L4j0BPdMKu/sTMajbyPGdcrFIBgrn05TMwCZNmAliBrUdkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853429; c=relaxed/simple;
	bh=yTsYTl9cqN8qn0pn0Dk6n2/xNP9n1J56n5TNZS5ChmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9lIUMPzCcauSpqIj1k5xLHcJmSPjjD9x2QVfpw3+PiRCcyp2kEEa9KEZVrVJXoj5pjeKdtea3cTgQK3/UAkvhFfJevRuvFiO/+3RdZtwlVm58vDqW4aVZwCXGDGqJBc1aDSS4Thr3diX7oeXZM3Zfi7Dm0EDYWNichBd9Y3ZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0N11mMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AC1C4CECF;
	Wed,  6 Nov 2024 00:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730853429;
	bh=yTsYTl9cqN8qn0pn0Dk6n2/xNP9n1J56n5TNZS5ChmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g0N11mMmUSVm0RHfstknB6NsTFvWupL2srIoqmR4x+IQjfnMmri5AVCe3f5bpw/FC
	 OU34qMdj4VLSGntZ8+sVSepdmdQ85ZVMPM9FtRmj9WK5BJ+RlP72KX/c9+sQ/ntQhn
	 YJkQkbjRzIPj9Dv0CIhiLundA5ieG2yc5v0DWWpT+BDdDPrcK6Hodq4rv5zWaaLivn
	 9w2xAbFEfRV2Ife+EcLtX7zgjSr9qifRHoUFHW5ln2+nUdv+okdVGUuZRBdDg7sJwr
	 lT5niIKYqcUtr5KDUC86bJEsLeChHCX6OmuxIax1N/v0OCEeMCPJee+Eesvu/vqLPo
	 TcgQ84epMYfsw==
Date: Tue, 5 Nov 2024 16:37:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov
 <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 2/8] rtnetlink: Factorise
 rtnl_link_get_net_tb().
Message-ID: <20241105163707.7d90b418@kernel.org>
In-Reply-To: <20241105020514.41963-3-kuniyu@amazon.com>
References: <20241105020514.41963-1-kuniyu@amazon.com>
	<20241105020514.41963-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 18:05:08 -0800 Kuniyuki Iwashima wrote:
> +struct net *rtnl_link_get_net_tb(struct nlattr *tb[])

"tb" stands for "table", AFAIU, it's not a very meaningful suffix.
I'd suggestrtnl_link_get_net_ifla or rtnl_get_net_ifla
ifla == if_link attribute

