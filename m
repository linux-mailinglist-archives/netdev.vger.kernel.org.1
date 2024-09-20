Return-Path: <netdev+bounces-129100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332697D770
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C13C286AC5
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EEB17BB11;
	Fri, 20 Sep 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M76hI5HT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D770EC13B
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846037; cv=none; b=lwpK2QUSF3YcjpWzHeYz1yvZ4aCxquOCrKjzmVCettgHH5AS0PlLZGbodB/WVMtfxVGekkKCYAkUc2GbXcjAXczHyZhvdp8g3Ol3Q6tKT+p2OYHnZlNcxSkpAFtdXE7ioiKkkfcUsPnaE+L5S3PSZcKeCsWhB2ofOfIBYhwE9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846037; c=relaxed/simple;
	bh=KPrlGpZnGLpeXzoZi73xN1P5Q65BIaYXwSfYdeVQJ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6EcFhMP7c5JI+D3QKqzzu6XWt8wn2sy7QB6k5xk6AHGYcAUh7512LI7f41w44Bd5puh2Jj9hBhxL0HOy92UrK1qdykBZm+xeIjUWg1d0lYpRgPnTs4KZL1I1AlLoY8wzm2istobiqTIQ7hs0sS8b/I20CINHHk4Z7cWDkNdn4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=M76hI5HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73877C4CEC3;
	Fri, 20 Sep 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M76hI5HT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726846034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPtVSjCsw7hP74dB48c+epdRVIHu9uZkO6i/klxH/8U=;
	b=M76hI5HTs+ZhqaNTsppdKlQmLSFAbINKYlYOnmQ0D9LMQfzuHPblpCuj3B7zN9mmDxf+AX
	sWizT7Ekr01Ki8DDUavVCqi9T3JOXIgFdDiqlJbucI91YiuzgzxPG6GUbeJQfN4EFkIKpu
	n26I0IOwyNIjDRKRdz8Lkx5jtwkvE44=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 605a5579 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Sep 2024 15:27:14 +0000 (UTC)
Date: Fri, 20 Sep 2024 17:27:12 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] wireguard: Omit unnecessary memset of netdev
 private data
Message-ID: <Zu2UUGtENfHmtnOc@zx2c4.com>
References: <20240919085746.16904-1-tklauser@distanz.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919085746.16904-1-tklauser@distanz.ch>

On Thu, Sep 19, 2024 at 10:57:46AM +0200, Tobias Klauser wrote:
> The memory for netdev_priv is allocated using kvzalloc in
> alloc_netdev_mqs before rtnl_link_ops->setup is called so there is no
> need to zero it again in wg_setup.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks. Seems reasonable to me. I'll queue it up in the wireguard tree.

Jason

