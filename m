Return-Path: <netdev+bounces-145370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB29CF4A7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3991F2774E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5A136338;
	Fri, 15 Nov 2024 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGCHQ9gK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748713D297;
	Fri, 15 Nov 2024 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698163; cv=none; b=orzQ60BFTm1AqB7cZRXvlzZ2CFyxhNIi84G1HN2GGAMrzSpsD4UtLp82VY1o8CangIONX87m27wwtUsarPuSkZIEz6TcBHmZ5vr0Z0RUiVwxsPx5iz2cR4+Tg3qlSRGuh1MlWYBKaDzJEV/+mm5ZmrJx69Y+YNY/CdHEaFT7xEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698163; c=relaxed/simple;
	bh=v58laIWzvhfBzP7d5gf9TEaF+ylw++r826cRUx2pSjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPkC6VwQzC7OYwhqf0dYC0UNuUf59JxvKrMflxvTbjLPmZI63cq9c8kcbVsx3W1tE3hpvmk4rbZhjwaqYq5/GGsHNpoTWmmpONMPZY7OA+aps1HhO2BLTfeMdD/dAqAh5gfkgeZAO5gOhjyx5lOmf8ZlXiK3Cb4UQtz0EAqLSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGCHQ9gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7963DC4CECF;
	Fri, 15 Nov 2024 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731698162;
	bh=v58laIWzvhfBzP7d5gf9TEaF+ylw++r826cRUx2pSjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iGCHQ9gKajwyF9YSZiTDz9clnYtUb4yr0ET4c63qWlSdFQMG4ncNaC9dHffZyhzXf
	 FeXukGV5s8Jt02NuwmMPJkUZ85uglBZjvWf8Ryf2SIoG1dROgekbf122PXvCU16XrZ
	 CyyQ0MGVqi80lsOwF261IMy4+kyXz1FWDm92YKxjuSG5PLAMdSl/sd6QdzKh/G2qeA
	 oQGSDWAQbFlnCFgvs/jHXIoylORTNu7QSz52c/D5kWEDzxEDK+4bLpj65M5YYrWn9i
	 HwsWdrszg3DSy3BGUWR8ruG+5zRc+v4LjLT0IYkq4MtNeK2TCeE0nb5NsTLpNoyz7J
	 SdOAwRjG39P5g==
Date: Fri, 15 Nov 2024 11:16:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefan Wiehler <stefan.wiehler@nokia.com>, Breno Leitao
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
Message-ID: <20241115111601.63785391@kernel.org>
In-Reply-To: <9837c682-72a0-428e-81ab-b42f201b3c71@redhat.com>
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
	<20241113191023.401fad6b@kernel.org>
	<20241114-ancient-piquant-ibex-28a70b@leitao>
	<20241114070308.79021413@kernel.org>
	<20241115-frisky-mahogany-mouflon-19fc5b@leitao>
	<20241115080031.6e6e15ff@kernel.org>
	<9cdf4969-8422-4cda-b1d0-35a57a1fe233@nokia.com>
	<9837c682-72a0-428e-81ab-b42f201b3c71@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 17:55:11 +0100 Paolo Abeni wrote:
> @Jakub: do you have by chance any cheap tip handy about the forwarding
> self-tests setup?

I presume you mean how to get all the weird tools it requires in place?

This is all the things we build on the worker:

https://github.com/linux-netdev/nipa/blob/main/deploy/contest/remote/worker-setup.sh

For mcast routing you only need a handful of those (mtools, smcroute,
ndisc6?), but we don't really track which is needed where :S

Ideally we'd use some image building to compose this automatically..
one day.

