Return-Path: <netdev+bounces-154597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE309FEBC0
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 01:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724CF160802
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 00:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D1376;
	Tue, 31 Dec 2024 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh6doiJQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00B36D
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735603661; cv=none; b=hr//9GEqPy++C0zEuwoeO6gAX9g8g9nJ2lvGzhHRk8F4ccQup93/W0SMuDdMgXSQ7aXm9EV+FTWboLWgNFkAcmLodE4t9j+9XlMfWrzNDYiapbNn3uDu+2VA6C0DndnaZdWNm3mrMXbPZTZUPGCSUIkoFHi8GBajd+2KdTyLRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735603661; c=relaxed/simple;
	bh=VEuFZvM5kTqoFXlaUWNW1FKOfhyDeQpSF3JkK5zx+zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7vzz/bzrcpCH1FYHRFSRMWyr2qYHOSLNmLovzhWh0MFWzGnkbIq8F+HuCUulm26Krc7k5VdHvpDCv+yeSdtd1Kn9OS188YPOnp422BEvjdQUzLTtgbIOE2+P7MK2zIdvE+83W/ms4QeL5/hHuwIo3LAXO5myo8AWENSNxQxWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh6doiJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63579C4CED4;
	Tue, 31 Dec 2024 00:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735603660;
	bh=VEuFZvM5kTqoFXlaUWNW1FKOfhyDeQpSF3JkK5zx+zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hh6doiJQh2/bEpYRwn4V6p9vMPWqo2LZxaozs7sr/XL72vEc7DxhveXy2uZs4wn7U
	 eAQGB981OYigXNz03gMhmhfXfx5QRPZYTXo0DeBevXJF1N4QXPG7QlZcSZBM6oWC7J
	 lvE2JXWzlHyuxAIP8VUJw3KnOhd1V3nNaHB38LWBIDGy9ul9H+6HXI+nVZobwclAZ0
	 oiIqpCepNL+4ObouEdyvdH/iRZjP+iZC1Vzyv3bK67Sscszfn/gVjMT1JKcWXhuYpm
	 H+ivUoRxX9GSEqkQsOHz9mttMN3EMoEGl1HSDb6HKYrJEX02OGDCSGM6WOnZoi7dux
	 i8r1AqH5YDOSg==
Date: Mon, 30 Dec 2024 16:07:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, eric.dumazet@gmail.com,
 syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com, Martin KaFai Lau
 <kafai@fb.com>
Subject: Re: [PATCH net] net: restrict SO_REUSEPORT to TCP, UDP and SCTP
 sockets
Message-ID: <20241230160739.351a0459@kernel.org>
In-Reply-To: <20241230193430.3148259-1-edumazet@google.com>
References: <20241230193430.3148259-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 19:34:30 +0000 Eric Dumazet wrote:
> After blamed commit, crypto sockets could accidentally be destroyed
> from RCU callback, as spotted by zyzbot [1].
> 
> Trying to acquire a mutex in RCU callback is not allowed.
> 
> Restrict SO_REUSEPORT socket option to TCP, UDP and SCTP sockets.

Looks like fcnal_test.sh and reuseport_addr_any.sh are failing
after this patch, we need to adjust their respective binaries.
I'll hide this patch from patchwork, even tho it's probably right..
-- 
pw-bot: defer

