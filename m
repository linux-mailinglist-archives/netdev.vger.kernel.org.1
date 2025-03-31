Return-Path: <netdev+bounces-178421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65126A76F8B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2B116551B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E321ABA2;
	Mon, 31 Mar 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfIbXtKd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85040216E23
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453816; cv=none; b=cfYHCEFYGNRDSgHHaQfRsE47c9wZXDE+mzrktRWfPPsB0ABzTZz8oQ8DcIUmACy4O780N6o3S1EF5Nvm+mdrOiVyz1RCA3+o3EPr/ENTfqkrTNsE31pjoI6sf+8TP6++CrZ7e2T/BbReT1mE0RWk+jqJy7LchncV3n42e9JF+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453816; c=relaxed/simple;
	bh=Zu8UaA1/OedLWu90BoDmUnw3s1lLnLt9pMbny/ia9dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Td/z5BQZQOgADxHqvm1IdYJzIURRL3yzh9M10D4IPoByblliDHiIa9jEqn0lzzyaTYpqmzd389k+9Q0lJRkD0RCSDvC1pgx52TofloKGFbw3YQc5heNlvmDHqjDlL6nZQa34uduHjgJipNrkGWmm9YftOP5VSbuUCPDe/uQK3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfIbXtKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6A1C4CEE3;
	Mon, 31 Mar 2025 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743453816;
	bh=Zu8UaA1/OedLWu90BoDmUnw3s1lLnLt9pMbny/ia9dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pfIbXtKd27iB4xFC5F0VAw/8MIeeDVhMEZU4LsWTXdm6vKXQdXxQPzImNSDDOdsbx
	 Um6ayYQ+mHpA7w27ivKkWzB3OLSEPlY22BwPqCfLtbqskZul2bYopW4o/Wpkpwd/at
	 ieXAVRIXySd4gzDeWObl+unn2Oqn36XfTMtHNbQO4bRQ/9/qfQc47oMUmGP0YarrVf
	 E5VvTGRUgjTHk8dOFIdaR6SCwBgYkxUmP1gUQJMALrbYJmcz0WPK+SQaWGhzgY74D0
	 KhSablUOi2kKdWa9H7JyHGo+hj4QH3dsHPX2yMLv2RhOx4kJY/QmllgabM9SKLfnh+
	 RBLmv9wssGZzw==
Date: Mon, 31 Mar 2025 13:43:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v4 01/11] net: switch to netif_disable_lro in
 inetdev_init
Message-ID: <20250331134335.009691e4@kernel.org>
In-Reply-To: <20250331150603.1906635-2-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
	<20250331150603.1906635-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 08:05:53 -0700 Stanislav Fomichev wrote:
> +EXPORT_IPV6_MOD(netif_disable_lro);

> +++ b/net/ipv4/devinet.c

>  	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
> -		dev_disable_lro(dev);
> +		netif_disable_lro(dev);
>  	/* Reference in_dev->dev */
>  	netdev_hold(dev, &in_dev->dev_tracker, GFP_KERNEL);
>  	/* Account for reference dev->ip_ptr (below) */

I still don't see a way for devinet.c to be built into a module.
The export and moving the defines needs to go to patch 3.

