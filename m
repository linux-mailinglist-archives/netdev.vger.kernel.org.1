Return-Path: <netdev+bounces-213884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B07B273BA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F80170858
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68FB6ADD;
	Fri, 15 Aug 2025 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns1BwATl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED88288D6;
	Fri, 15 Aug 2025 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217408; cv=none; b=YJADIz6baOZBElYUWYsUauTYe3FzM2BZlfTtKf4PLBB9EgB2UOt4WJmWvklc9hxlNy9x0MY7UFxKq3j3nJ392igIe/vdMvSacqVByVZTFdKtqkiYgmUMvuN1lREKgM2NT13Us0eX2lfefnhx/mUpVnrveo5jA86XtKIik7VsVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217408; c=relaxed/simple;
	bh=WVeyY9LgABja4jiKaiRJMSLw7UOd2yNQ9bR/C2MNRBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QX9GQ6datGwggij8qgGJ2rNz28pxmwLjrGyABjzgxu4ZZdK1ntAc1NQKTgOPnGWi/konSHMbQcBbY5o/E15XnQiVKWDizApfDMjNDl4j/KkTo5nt5GrZrY6wejxkCxs4C2od19SV5tLtxFZd9eQdKMk8flCp8jR0PnXnKl07CNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns1BwATl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB95C4CEED;
	Fri, 15 Aug 2025 00:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755217408;
	bh=WVeyY9LgABja4jiKaiRJMSLw7UOd2yNQ9bR/C2MNRBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ns1BwATliYk8zlxHu+Mpic3f+m/k4ZC1yYBzzF7R0ZbYjLZ63/mTNapyqJr3sLH41
	 XdPJ8UmDyISFQg3zQiCadCHbQrflFSa1MMwn+e8ql16yuXd6v20WqHfQGrJYo0i0eL
	 Us8QAfQcsmA0XjE7kmc4vx7ZPDOmPzcfloC12EYk1zEgnhuGYIiQrZdcy/t39F4nrH
	 Cfn/5H1b4OplxHNh62v3jMyKGgzik5X7K2OPN5NxxuOvrA1KRXeVDQPHRYsK2Wp/cO
	 8b54hIpPVtcLrFpaI7d9P80TY91mLk2KoR/gO5syki04d+48P039ghV0n527TRnx9S
	 A7qGWIS40l67A==
Date: Thu, 14 Aug 2025 17:23:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mike Galbraith <efault@gmx.de>, paulmck@kernel.org,
 asml.silence@gmail.com, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole:  HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <20250814172326.18cf2d72@kernel.org>
In-Reply-To: <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
	<oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 03:16:11 -0700 Breno Leitao wrote:
>  2.2) netpoll 				// net poll will call the network subsystem to send the packet
>  2.3) lock(&fq->lock);			// Try to get the lock while the lock was already held

Where does netpoll take fq->lock ?

We started hitting this a lot in the CI as well, lockdep must have
gotten more sensitive in 6.17. Last I checked lockdep didn't understand
that we manually test for nesting with netif_local_xmit_active().

