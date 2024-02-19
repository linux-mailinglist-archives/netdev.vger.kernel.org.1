Return-Path: <netdev+bounces-73058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857085ABE8
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6478B2176B
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F235026A;
	Mon, 19 Feb 2024 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awkDvQkv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117F47F7D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370445; cv=none; b=jfgmgaKb7BSIQ4PcG34ZflVW/Ivvtc9RX8jZVWdY/tnYOgXJuQONwELJaY5TtZl5yQBCCNKeBP+5FHvsrh2Gd9cJTpgAbqRokCV2o5oUhxYJ/JSxudyqQIhlOlGGVh54vkrovcpts+ZntT+fEA0Fq6q3xlkpAIKhqPmZiwAgSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370445; c=relaxed/simple;
	bh=qUcNuwzzBfbfZ3Kh8STkH7tU81QXlSYTzjjiZnQe82o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy6BgGkGEMgzPRrxkYWxD6HSyP2k4fhv7TkwgFHBfzu3ckX35j8sybieQG8WZKOhPtiwds8OOwBWK7dLGIxJjDhwDmW8VvWQRDwfA/YaE1/w/nREz9esV5uocWSeyk1X1sGS98v8PJl253LqYQ0pbO7oh6Yj83iMoVocydk9h90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awkDvQkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552BBC433F1;
	Mon, 19 Feb 2024 19:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708370445;
	bh=qUcNuwzzBfbfZ3Kh8STkH7tU81QXlSYTzjjiZnQe82o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=awkDvQkvWNuXKbmXdxtdv3NgyK8P+JtZwefDl7oImCZHjx2Ee5nyF15LJInYssGj1
	 spfhC9ees+6m0PD3Sv08DkNjSG9V2n/oF1AByviDjINQ1aNHyRe7OoycaqyoqZEKnF
	 4tgND2PAaIiHbqY03hYrKjP43YbssVAsi5BHAu0zetIsjzzlklcGAjEYw0wnSqeJGj
	 0yFjqn1qaC2U/mN3XPSGtgcuMoEFj10EPiqlaFcZLY3swxW4uEssk408uBsQLM7ous
	 zEX1xFaAi3DjjzbJYk0AMxNvR44JDfLih7GeWTaGWrUf82fiu9JxV98jm5d4oprumj
	 kHXfkVOCeOkPQ==
Date: Mon, 19 Feb 2024 11:20:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Sabrina
 Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v11 0/3] netdevsim: link and forward skbs
 between ports
Message-ID: <20240219112044.550ac583@kernel.org>
In-Reply-To: <1bfeac24-73f3-4e9b-96e4-b9354be27285@davidwei.uk>
References: <20240215194325.1364466-1-dw@davidwei.uk>
	<ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
	<cf9e07d6-6693-4511-93a6-e375d6f0e738@davidwei.uk>
	<20240216174859.7e65c1bf@kernel.org>
	<1bfeac24-73f3-4e9b-96e4-b9354be27285@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 20:27:09 -0700 David Wei wrote:
> On 2024-02-16 18:48, Jakub Kicinski wrote:
> > Also looks like the new test managed to flake once while it was sitting
> > in patchwork ?
> > 
> > https://netdev-3.bots.linux.dev/vmksft-netdevsim-dbg/results/468440/13-peer-sh/stdout  
> 
> I can't repro it locally in QEMU. Maybe it's due to the leaky ref bug?
> 
> I'll send another revision and hopefully this doesn't happen again.

Grep for wait_local_port_listen, maybe we should make sure listener
had fully started?

