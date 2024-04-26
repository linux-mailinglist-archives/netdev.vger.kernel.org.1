Return-Path: <netdev+bounces-91503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D968B2E78
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 03:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3653B2276E
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 01:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9FEDB;
	Fri, 26 Apr 2024 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/hDdrtB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881985680
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096286; cv=none; b=VeEDc84CsZeIxWVtFVeFH7eQhbMR7CLuhbxPEbuAuE74Qq0Cn9IoXGkRi59fw6BVlqSUmobjwpYwzMR6OWg5KTcdh2hnXe7SRlhIBKyNcjdX5ux8715cFCOL2HNGHUdm0V8QrUtL7OyqYG8cMvXU3MWshrOj7mN2u9cg32bVEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096286; c=relaxed/simple;
	bh=eVd5CcCHnLqmDQxbjdtU3yHjDZKsWMl6PioVpPlitR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PitkkaKeb8MkDez1bnWWYSDmS6kigjOR7eLppxX/KOzouOwJbuwU+nmubIFXdcGP0SlBmQkAUdDgWVxohLrSD4cYWeA06QEjJI8IFFuKOjHjnJyNr7jcuCxmRM5vB/6nLKrzGU5Px6ezMEMUz+t4DriD6j+0b2GcPCWr1/ZvBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/hDdrtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1FCC113CC;
	Fri, 26 Apr 2024 01:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714096286;
	bh=eVd5CcCHnLqmDQxbjdtU3yHjDZKsWMl6PioVpPlitR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/hDdrtBSS5GjRg5kb8DhL7HVQVwZ3zbGAtTjFZeZqf8Te+SpNYmd5Fc6nVL+qe3Q
	 v4u0N9cGVciCjmH4G3v16A2W3mClzmy3VfGQTcClqWLL3O83pC2OdZTiIpvGGGVKN7
	 hMxlZWxzvS9G5bOQaI1IIM5oyl5tSMRWzPOI31t47/8/M0i8bDxSEAta8uY0j0yy0O
	 S8e2ZdNQwXjNRDfxm/j1HtyKCpPqW/cvvsEnPiGljNL9mJX5In/t259JY0WANHJbb1
	 3D13wVHddwRZXrPF5kvCXwnJECdfkXWOBY6S7pHbw35i5nha40MEvALnF0QjI85wZH
	 j790L5I5DODVg==
Date: Thu, 25 Apr 2024 18:51:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] net: selftest: add test for netdev
 netlink queue-get API
Message-ID: <20240425185124.7d9456e1@kernel.org>
In-Reply-To: <20240424023624.2320033-3-dw@davidwei.uk>
References: <20240424023624.2320033-1-dw@davidwei.uk>
	<20240424023624.2320033-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 19:36:24 -0700 David Wei wrote:
> +    try:
> +        expected = curr_queues - 1
> +        cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
> +        queues = nl_get_queues(cfg, nl)
> +        if not queues:
> +            raise KsftSkipEx('queue-get not supported by device')
> +        ksft_eq(queues, expected)
> +
> +        expected = curr_queues
> +        cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
> +        queues = nl_get_queues(cfg, nl)
> +        ksft_eq(queues, expected)
> +    except Exception as ex:
> +        raise KsftSkipEx(ex)


Why convert all exceptions to skip? Don't we want the test to go red
if something is off?

> +def main() -> None:
> +    with NetDrvEnv(__file__, queue_count=3) as cfg:
> +        ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))

gotta call ksft_exit() at the end explicitly. It's a bit annoying, 
I know :S

