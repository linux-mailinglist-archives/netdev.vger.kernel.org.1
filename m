Return-Path: <netdev+bounces-99211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B073B8D421A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16671C20E86
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 23:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593251779A4;
	Wed, 29 May 2024 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9SWLeMp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365E28E8
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717026426; cv=none; b=W8bGJu9U40JnEOteQPUFIwZQsQLvfZTT6W2nkNcf5rS1w6xv8AwLiF7tivXhvpqEHtz3j8r6lmtDTkZzixxTHnTkYQz3P4uSgOQnRTHkpd2E/uPPlmi6KaVhm98WbOzMIDj+QeVJFOZ/jnTegj1CkEsr0xAhXI/lZzE64RYGQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717026426; c=relaxed/simple;
	bh=SNpYgV5902aNUC4t5lLXfG1o7R0BrlknPBEBgrLaWs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ks1YyTV0V9NG5bBq+djy1ANCvs1WvHzNohi4vbyfbarSb8WsBIRc+pC4FB3zfSx0DhZlvWx8dbTymVfARpoWXmHEAVgajUbkYU6DHdMYg4Tbhcljq4UNkth+ecidsZTwYg2C02i8lg1tp9pBmyqNYqXG71VRbRq3AP3WpupT/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9SWLeMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7251DC113CC;
	Wed, 29 May 2024 23:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717026425;
	bh=SNpYgV5902aNUC4t5lLXfG1o7R0BrlknPBEBgrLaWs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9SWLeMpdTfJmlAAmQ5dpLoJo2wgWMX3GGogc6+EI3P4hddq8gG9WBPELC9+zCiew
	 nw4YwkJ+Wtpr/tKdpVZcgQgBm9OpGtLRmD5oR9pNf2VZx6KSo2Ekmr3ynalrCZyyC4
	 MUbzO+KPepfOtHqtRPvkP9sk0bCxQ/uVkGotpaYlvPCIPPL04BlF6Ypbg7dzGUqSNT
	 ee8I5EhdSlvJ246K4yUlgaE+kHszt7c3aSQpRJbdqE6veVKMk76ByQEmiqaG7l37rO
	 x26tt33aKE5ENXe/tx5HzHF5F911W/EJPLmlejSsRj3AuV5xROx1aVb0myax2Wh4hz
	 L47E0wH049whQ==
Date: Wed, 29 May 2024 16:47:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Yang <yyd@google.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, Yuchung Cheng
 <ycheng@google.com>
Subject: Re: [PATCH net-next 2/2] tcp: add sysctl_tcp_rto_min_us
Message-ID: <20240529164704.49b39fb8@kernel.org>
In-Reply-To: <20240528171320.1332292-3-yyd@google.com>
References: <20240528171320.1332292-1-yyd@google.com>
	<20240528171320.1332292-3-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 17:13:20 +0000 Kevin Yang wrote:
> +	icsk->icsk_rto_min = usecs_to_jiffies(READ_ONCE(sock_net(sk)->
> +					      ipv4.sysctl_tcp_rto_min_us));

This is somewhat awkwardly broken into two lines.
Could you use a temp variable to save 

	rto_min_us = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rto_min_us);

?

Or just go over 80 chars, but preferably not. Chaining 3 calls in one
line is a bit Java-esque :S

With that feel free to add:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

We also carry (a form of) this patch in Meta kernels.. :(

