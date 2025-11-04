Return-Path: <netdev+bounces-235335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A3C2EB90
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB09D34C631
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078E72639;
	Tue,  4 Nov 2025 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmQqpE0G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0E310E3;
	Tue,  4 Nov 2025 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218958; cv=none; b=RwfFmW/s3+YJb1Ah0TW32XosqSm19dDdxAv35wZrKZDISCueSjN/uAkoaRqh8ayqfsvnNzztRVOwFQrErkNJmX3wQQGSHIhLvKROG6w0dKUQ7RAPt2FKqLaG2VUqfTYNNrctoZlU0ebJwxvUFFamQgDEHh5KjzoWAZaHl83ysNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218958; c=relaxed/simple;
	bh=PyX0r1p2GBJLWvA1hjoLip38ZhoUpyGel1Q2+nuA5JY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiJCWqmZLd4pGEDhV1shd8XHMovRZ3CtpRtGBl7bdRPLXtDbUIuY43qdNhD6dkxVySn69aqiKKAqrLExEdW07C+PhgDqCZXa5I7QIEDMC+5AEWw3GysCVJb/fGMRo8NVGKr/sqJLJcTn3sa3E6ahzjSmVJAF3PNl7ynf2UELUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmQqpE0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ACBC4CEFD;
	Tue,  4 Nov 2025 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762218958;
	bh=PyX0r1p2GBJLWvA1hjoLip38ZhoUpyGel1Q2+nuA5JY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmQqpE0GwuO7+qZIwUM/UIkZMgtW7m89xsXxGRHNSK0uHe0Ul7MKZdZm2CTCXyjWS
	 MB4zZ/wQ5tfPGA5KI+4nuEcmdZV5CNYDARj1XLbPwma11w06Y2QEXRi8PfQR1l9vbh
	 UdkXxNeb9z7XHCRVxMhewQjjZxbgZv45BIQ1dzDenm4NtPjJWV+xAnyioIxpbMarWk
	 rR4KYAR2Vp+Q4Hb8+ZRmSXKcgVFC7qP4mOzqkZ+Ir3KSsFPRzGihG5uXV11woDDrVL
	 zge4GU0v6KYt+1ZOychQQHnGil0GHw3PUZTV/ytJmO9T2oOGM1OkN1cBHQOShE1sR4
	 u/cPiwiSB1NSw==
Date: Mon, 3 Nov 2025 17:15:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: kory.maincent@bootlin.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 syzkaller@googlegroups.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH v3 1/1] net: core: prevent NULL deref in
 generic_hwtstamp_ioctl_lower()
Message-ID: <20251103171557.3c5123cc@kernel.org>
In-Reply-To: <20251030124947.34575-2-r772577952@gmail.com>
References: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
	<20251030124947.34575-1-r772577952@gmail.com>
	<20251030124947.34575-2-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 12:49:47 +0000 Jiaming Zhang wrote:
> +	/* Netlink path with unconverted lower driver */
> +	if (!kernel_cfg->ifr)
> +		return -EOPNOTSUPP;
> +
>  	/* Legacy path: unconverted lower driver */
>  	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
>  }
> @@ -498,6 +502,10 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
>  		return err;
>  	}
>  
> +	/* Netlink path with unconverted lower driver */
> +	if (!kernel_cfg->ifr)
> +		return -EOPNOTSUPP;
> +
>  	/* Legacy path: unconverted lower driver */
>  	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);

Sorry but nit:

instead of adding this to both callers you can add the check in
generic_hwtstamp_ioctl_lower().
-- 
pw-bot: cr

