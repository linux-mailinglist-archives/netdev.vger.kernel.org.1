Return-Path: <netdev+bounces-140049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6455C9B51F7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02DDB2151C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B63203719;
	Tue, 29 Oct 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQT5BhnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B41DA305;
	Tue, 29 Oct 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227198; cv=none; b=QDyPRfA6ZhdpZuFNtqXWXPQlpSLyWmIVbw6LigLH5sW/l3oRyBOgoJWKrhaQy2OqH7eXNcpm4XleyRURYi4OX+mQrusUrJ2Y7EhzdamXiEKsXsZjev23SWhhT3gAV/kcJRnWoQACWerZzttf2VXgVoSrX4q7iX7eMwDJuv4TRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227198; c=relaxed/simple;
	bh=RgfT3pIpqebkN83jwo/3I6MPLEG4c72/urpViXRIzUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1HYNhYQStWrWCpOuqeOEokhSLEYPw4WKcIEXMeAhiNSJ/em8pZCqCpPZvlfikStx37LFjHmVL9BgQs90zSeJO4t5bNGI9ni8es2PEyBhoe1wvK3ROiwNeB9Uhzvdjb4vIFpGdMRJuNP99SU3myCGllwo35J46TMKmBxqGKPXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQT5BhnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD4EC4CECD;
	Tue, 29 Oct 2024 18:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227197;
	bh=RgfT3pIpqebkN83jwo/3I6MPLEG4c72/urpViXRIzUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VQT5BhnNblfYueiFYe754q42gLqBJXsSGvkq2WJ8MZyeyJt8xQDOods+rgBK+5dEX
	 dr6Zt3SUXxijuO3O2KE+LFQrQ33+fcC3XZrhWPcOMC73Vf0xpjG464M6YICkxmvZEK
	 wIJtH3OJxZSe6HB1uTB5MJxPXLXJiHtHwHXZLdQpcdpBiIjwAAa3BaBkjJkUevzDZB
	 cgilj7ZqQZ960J2fEkC/fhNw+kD2gKZudxvic/49Iz48qJhEwkSVM0ruNMV7gu8F5r
	 QTqMBplCrgRd/8WhohGQRXvCFbK+DnPa8RmJz2SSVIcUsDELWgZOlCbwsoOL+AtDkv
	 XHYE4NQKti7ow==
Date: Tue, 29 Oct 2024 11:39:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241029113955.145d2a2f@kernel.org>
In-Reply-To: <7d227ced-0202-4f6e-9bc5-c2411d8224be@embeddedor.com>
References: <cover.1729536776.git.gustavoars@kernel.org>
	<f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
	<20241029065824.670f14fc@kernel.org>
	<f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
	<20241029110845.0f9bb1cc@kernel.org>
	<7d227ced-0202-4f6e-9bc5-c2411d8224be@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 12:18:56 -0600 Gustavo A. R. Silva wrote:
> >> I don't think you want to change this. `lsettings` is based on `ksettings`. So,
> >> `ksettings` should go first. The same scenario for the one below.  
> > 
> > In which case you need to move the init out of line.  
> 
> So, the same applies to the case below?
> 
> 	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
> 	struct bnxt *bp = netdev_priv(dev);
> 	struct bnxt_link_info *link_info = &bp->link_info;

Do you mean the bp and bp->link_info lines?
You're not touching them, so leave them be.

> Is this going to be a priority for any other netdev patches in the future?

It's been the preferred formatting for a decade or more.
Which is why the net/ethtool/ code you're touching follows
this convention. We're less strict about driver code.

