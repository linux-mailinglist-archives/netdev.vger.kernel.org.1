Return-Path: <netdev+bounces-204640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E72AFB8A7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938AC4A20DD
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D4621E08D;
	Mon,  7 Jul 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofNr/egd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65194D8CE;
	Mon,  7 Jul 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905860; cv=none; b=OQsJk/09doET5DkilGBl3h4bm/pYJFGFIB1hH3v8+Iby+pjBsLMZ19uS8UxXgxgv8ORmCJW1R7f+p2vtgYvObhWT5OAR5VGRpYHZLIp6ehizwxkuZuQXHMQfdukz/2FWvMHtOEDOZdWyc0k0G+c9jMtMu9SddKiMn+lek0BJBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905860; c=relaxed/simple;
	bh=obrzbDFNAYEb9+XtjEAKu8uNa8zuueSOrmOSfzEm0jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBlJ6d0Ih6vQxmNrE6V05dTTF5j/hEplgmJ5zyUn9X5HYBmfUp2nIbWtWM8YE3D714VMD9fQc7IoO9tgYZEK7dxqP7Zz0kWxi5qOHQ0DebB9eGi12FAcGhb29D4xHDjINHKjGIVt23wzg/vNi03h/aqCkVAyIFqAz2P5eh5r3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofNr/egd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7AEC4CEE3;
	Mon,  7 Jul 2025 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751905860;
	bh=obrzbDFNAYEb9+XtjEAKu8uNa8zuueSOrmOSfzEm0jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofNr/egdOSxtX8QLywn/ojxo8g5spbbjT7BLMD79BH8mo8gZxaHl7vWd0iHSPsitK
	 4faZurnLiyf18V7aBsfwSNwXfX6Q/Zw8yv3lz77vrLNqZwh53NvdoehuWjCeZL5lt7
	 PdAj4DMDW0UhWmxqsCus1+rL6O24OmD1+o5wJr7c+HWeukjlzpmGThwnol55va9fXM
	 0RuHGZg+6PGqHHdanqeYTClH5AZ12g2lyS+1Sd/em1Ao5M7JpwB83TfMJJw5EEIgAS
	 94+Sgx0sfYc89kluNWw6Y45Ep+pwrCNDECjX+V0TRV4FbaRFLeubxZE4YvkS7SPch/
	 QLD/+RasCxuZw==
Date: Mon, 7 Jul 2025 17:30:56 +0100
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mingo@kernel.org, tglx@linutronix.de,
	pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: atm: Fix incorrect net_device lec check
Message-ID: <20250707163056.GO89747@horms.kernel.org>
References: <20250703052427.12626-1-linma@zju.edu.cn>
 <20250704190128.GB356576@horms.kernel.org>
 <5c66d883.a83f.197d88a76c4.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c66d883.a83f.197d88a76c4.Coremail.linma@zju.edu.cn>

On Sat, Jul 05, 2025 at 11:04:02AM +0800, Lin Ma wrote:
> Hi Simon,
> 
> > Can start_mpc() run on dev before this function is called?
> > If so, does the check above still work as expected?
> 
> Great point. I found two locatinos that call start_mpc(). One
> is atm_mpoa_mpoad_attach() and the other is mpoa_event_listener().
> 
> Since this patch covers these two functions, I believe start_mpc()
> run after the check.
> 
> However, since start_mpc() indeed replaces the netdev_ops. It seems
> quite error-prone to perform type checking using that field. Moreover,
> this patch raises a linking error as shown in
> https://lore.kernel.org/oe-kbuild-all/202507050831.2GTrUnFN-lkp@intel.com/.
> Hence, I will prepare version 4 and try to think about other solutions.

Thanks. I was thinking along the same lines.

> 
> >
> > 1) Is this code path reachable by non-lec devices?
> >
> 
> Yes, though the mpoa_event_listener() is registered for the net/mpc module,
> the notifier_block calls every registered listener.
> 
> /** ....
>  *  Calls each function in a notifier chain in turn.  The functions
>  *  run in an undefined context.
>  *  All locking must be provided by the caller.
>  *  ...
>  */
> int raw_notifier_call_chain(struct raw_notifier_head *nh,
>         unsigned long val, void *v)
> 
> In another word, every registered listener is reachable and is responsible
> for determining whether the event is relevant to them. And that is why we
> should add a type check here.

Understood, makes sense.

> 
> > 2) Can the name of a lec device be changed?
>    If so, does it cause a problem here?
> 
> To my knowledge, the changing of a net_device name is handled in
> net/core/dev.c, which is a general functionality that an individual driver
> cannot intervene.
> 
> int __dev_change_net_namespace(struct net_device *dev, struct net *net,
>                    const char *pat, int new_ifindex)
> {
>     ...
>         if (new_name[0]) /* Rename the netdev to prepared name */
>         strscpy(dev->name, new_name, IFNAMSIZ);
>     ...
> }
> 
> Nice catch.
> If a user changes a lec device name to something else that is not
> prefixed with "lec", it causes functionality issues, as events
> like NETDEV_UP/DOWN cannot reach the inner logic.
> 
> That will be another reason to adopt a fix.

Yes, that seems likely.
But perhaps such a fix is orthogonal from the one that started this thread.

