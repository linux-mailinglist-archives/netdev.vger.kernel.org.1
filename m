Return-Path: <netdev+bounces-119951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECCB957AA3
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A1728458E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57917BB4;
	Tue, 20 Aug 2024 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1jYPkt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE417BA4
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115538; cv=none; b=Y3MMhWSQsE51pKqj0ncU5pKZ1vXkNaZxHtOPOv5OCsHDJjIXzibZXnwUbebmsf6vvKULQCf1nPO7E/QKcmQV+KVPgNxvxqLOJf6d7R0Yw/bRKPGqLyGPk9FK/bcT2MwskQgQ1YJNsAvWLJkGVE5V8c9CUmFelW+/IRD+l0wrBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115538; c=relaxed/simple;
	bh=HbXRahyRQ6PpB6I30XAn8tIdi3t+cE0Zkao9pNlXiew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uufQ/4m5fZkOk/pc5z0zVb84mHR5WS8q32l+gX3pXkUFCAGC8R3IfrBk0iu4LI1eDGAJVd59LXvJaVgEAAg2wRMwpGhKldLxfwCBdzdmr24kwiyo2zEifv7U+HXLMQyQsvAvXk3oEgHDxVW6cwC+UnjiRG0eYHWrZRjEPWNUxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1jYPkt3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso3316716a91.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724115536; x=1724720336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oe9ob00k00Oma+vP7QfBVswLmNcdDPZmN+qvhP/jD0M=;
        b=K1jYPkt3OVO/8M70b9cy5+L7inLoLPnyc7+khJmAvduLGoLV02Bq04QtvIS3C5I0C2
         /xCr/1EP3x6eJEuN4DIGdv7PNKOg8bUpFgBfIVEGEFTaHcoyGcJ0KLjs+Qad7DFAoknD
         xRamM2dGUcaD9/eUa7qgwl7QxYxOkvSRASAa8WK+iDbxCmxOdKKvT3+dzx5zEuWVstcC
         VjLl7BVhMSPAX4oG3Y5ZU7ansQFDuSifIOPE9fy6BVA2zNSL09KD42Y1iVgf0/WBXFso
         pv++7TU//CgTvgQAC2VO9dkPKsMzExmeQLXd32FAygETOLLa89BdAvRsTLz+EZWfZ5Rd
         1OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724115536; x=1724720336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe9ob00k00Oma+vP7QfBVswLmNcdDPZmN+qvhP/jD0M=;
        b=j+lz6V6S74C3pEBNmEZ3rVNUZHKkTvbZRj8dsfvNp+iPNc3XfYl/Zwph4xxjyZGz3e
         rvwW7l/pP4qNcTQTlosxCiOzYsxi9q9LFVdSHd3GyVJzOlrvbHOFWgY8pLuZ3v+PvpU6
         o47WQ43vWafwqoBRLZTRGeuFhqsiKZpyfqr1upqX4XC8A0Mwyn8QKwTrw2SbFdetvC3m
         7ioqNOlnyiT0RECVzkgKtp5SsxkklJVS3cwYglmk+RP1ZxSs+XsKc9FaGtw4sae1awfY
         c97nfYDZUGW3giz2CEWNziI+wHTC7FS+jfHARiOQuMFkO12HUXgShjYiceagerPw2q5o
         rSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYRKfDpyGXe6QMzdssIaBZnHvb+GwbH9bZQt0tBkb3kl63WebCWBRL8bPp2phOoYFXeCdKACvgVlgjoXR11DfGbKN2OWsq
X-Gm-Message-State: AOJu0YxgVdeza5ZIg2CrQR60jRYYwDV5SRXGeGrg19/EMAowcd6kV5Ee
	1jzbzJv6xak3nBFMADE5zsAcSzTeHt0034BcEyLvFSmluP8BY/P3kpFhLjPLkhk=
X-Google-Smtp-Source: AGHT+IH3i64QbCJWd4oM30WKJh8BDld3k3HFWC4pUN+v8XawPv6aq5mX7LJaRPZQnlr9IfCuSmdOhQ==
X-Received: by 2002:a17:90a:ec06:b0:2d3:ce3d:84d9 with SMTP id 98e67ed59e1d1-2d3dfdaab99mr13421423a91.7.1724115535930;
        Mon, 19 Aug 2024 17:58:55 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3d68dce02sm8643867a91.41.2024.08.19.17.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 17:58:55 -0700 (PDT)
Date: Tue, 20 Aug 2024 08:58:51 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [Question] Does CONFIG_XFRM_OFFLOAD depends any other configs?
Message-ID: <ZsPqS6oFNpRmadxZ@Laptop-X1>
References: <ZsPXnKv6t4JjvFD9@Laptop-X1>
 <20240819172232.34bf6e9d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819172232.34bf6e9d@kernel.org>

Hi Jakub,
On Mon, Aug 19, 2024 at 05:22:32PM -0700, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 07:39:08 +0800 Hangbin Liu wrote:
> > Yesterday I tried to build the kernel with CONFIG_XFRM_OFFLOAD=y via `vng`[1],
> > but the result .config actually doesn't contain CONFIG_XFRM_OFFLOAD=y. I saw
> > XFRM_OFFLOAD in net/xfrm/Kconfig doesn't has any dependences. Do you know if
> > I missed something?
> 
> It's a hidden config option, not directly controlled by the user.
> You should enable INET_ESP_OFFLOAD and INET6_ESP_OFFLOAD instead
> (which "select" it)

Thanks for your reply. How to know if an option is hide other than review all
`make menuconfig` result?

Should we add a "depends on" for XFRM_OFFLOAD?

Regards
Hangbin

