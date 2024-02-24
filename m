Return-Path: <netdev+bounces-74656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE0C86222E
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9C01C251FB
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 02:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F083DDD1;
	Sat, 24 Feb 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohm20qmb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B57FDDA5
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708740179; cv=none; b=BdRKTXEffxcx+y83Z3eg7Sy6rNdZjTkTKtEijF4hGYYXAd0UEzuJorUG+7jSeDLWi8wrj/eFro4WH68+KALx9XJDocL+4N18vTS7jMLog3OHOq+L2/6fyul6zIxWr4NihgLqUk90moOdRRDeCR+/RoB6wqxtzp4p3btJSClizFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708740179; c=relaxed/simple;
	bh=eiSMFYXQz5u6FPsICS8lzJ6JGHZgwC509FXdpJir0S4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCV/e0uLZqEj/96OBPcE7EYePniSXPDbj5NN2kuCAW6iesHvQ5XKQFYIhWWr6F76sBrADthk3Qpj27ewmxbLvuE9JqMSMd2F41wLl60bQeeeOpiiE7fJaoiok18crZNWHVhd9wJkeKHc2DecHLNFbeY+myBntJQI1lOZW6ADxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohm20qmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DC3C433C7;
	Sat, 24 Feb 2024 02:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708740178;
	bh=eiSMFYXQz5u6FPsICS8lzJ6JGHZgwC509FXdpJir0S4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohm20qmbxFsJWRWP5QDBJO1hrEF7W/hgGNznxajL3WvsRaLYiH1fTwgB4cZumRLgL
	 cK1Fw1s0d0++fiJYIrC1iNqfybDKqU8d5Ks9xfadrwJLedCKwG3phJnwFjW3A/jIzy
	 32CKciofIdnTd2oWrmb86EZkVxA5jTdpxfd65movSeXZFXbiL6evJ2w6m78MUCiPjW
	 goWlUJr3XIsjbl9CzFqL9b92kGxvSdUdD21J9+NpZnoMTpJFloMafOTWYVZa55pCMm
	 6otm1/+VPEMqZ32SxvvyH1YfVghPisWW4YgCMndRqMjx+Zk5gxoV/Xo27+yWw8Rmbf
	 RaGAn4YntbQcg==
Date: Fri, 23 Feb 2024 18:02:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v2 net-next 3/3] net: Use backlog-NAPI to clean up the
 defer_list.
Message-ID: <20240223180257.5d828020@kernel.org>
In-Reply-To: <20240221172032.78737-4-bigeasy@linutronix.de>
References: <20240221172032.78737-1-bigeasy@linutronix.de>
	<20240221172032.78737-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 18:00:13 +0100 Sebastian Andrzej Siewior wrote:
> +	if (use_backlog_threads()) {
> +		rps_lock_irqsave(sd, &flags);
> +
> +		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
> +			napi_schedule_rps(sd);

Why are you calling napi_schedule_rps() here?
Just do __napi_schedule_irqoff(&sd->backlog);
Then you can move the special case inside napi_schedule_rps()
into the if (sd != mysd) block.

> +		rps_unlock_irq_restore(sd, &flags);

Also not sure if the lock helpers should still be called RPS since they
also protect state on non-RPS configs now.

