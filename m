Return-Path: <netdev+bounces-238962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC6C61B21
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 19:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 286FE4E2B86
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71D30FF3C;
	Sun, 16 Nov 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwTqVY+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B822578A
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763319588; cv=none; b=mpEnJuvAY2CNHnESSsQdMvRQfaYWsyglz2LLh2QS8Zvt3wVsWK3ZhTwQ2NlL1AFAtGD71fmePjjFX5AmfH4YFZbvMnOws2Qn+XazoKHrcWpRo0pXguuXuX4s7Lu5NBvLn7FpiXwREk3p6n6cNowYSbURbH6AMi0aWedTzPdAoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763319588; c=relaxed/simple;
	bh=yu2NuTuEzodbOyf6RgfGdHkSvgHznx9Ba89qNX7icrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AavneAAeX+UX6jyjuY5Uz4o0IhczD7VkHHA3SL+soyxXGZoPpuYpG95bK6SEYGCxMhpBryyTxnGhFJYAAJdzKtoxu4lIZjk81Su/raDLIpzK7ZpchoQCNqfd/WS6KqGRiMonL2hOyDHe1woo4Zs8KDm9Nd5Vyh55FKO7ahIiz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwTqVY+V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so24294305e9.3
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763319586; x=1763924386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0QOGpOREQFi+91a4uGctnzik47SA2nu5lAp/EQKXvs=;
        b=VwTqVY+VZRBe6TvA6ifnb9xHnepyxKdBfLOoKffKGN91um3YMXkkNmWUqZHKI4JzM0
         EMLSKJT97KD7hKf8xlWKCFw0vUxRiL5ZwqpCihj2W/4bPuQymlxccU9g6Wq/HDmG1y5o
         ktklE91lGD0NwAY9v0NuDZnpR3sGnefZyRuOl6PelzCTC2s09beK7kpj+dXmz28I4TgL
         dryHfht8Nafzb7W6DO4uIjPWwVNiTKR5a91VciSGPZJf3F2nKDx+/5gcI5zIS1ScMF7V
         RegHbAa607IPiGS/xPiUzHnnjLjn6GsUJ+4UnElIqhpMYZXtoiAnNVw6qdHWpd+P2K8T
         +Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763319586; x=1763924386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0QOGpOREQFi+91a4uGctnzik47SA2nu5lAp/EQKXvs=;
        b=ealq4FF5o+3f900+wNN++pQ9uTckwdHy6WTn57urJkpXcteGeGFyXgocr5SK7pM8ED
         BLLk7ryBzlewHBWd+HE4zYuvdQRZWErAphmxfswkgIV4CBzYW/4p+FwgFDjPu+aEV/zY
         Rn/DRGZPKtcGey3l4Ji+jKj21X1UN9V1MLDa4RdFyhQNcSjS9bBpfpl8TOk9mGd6l6pX
         wlpLWkHvqTsNTybO4lGbgJqy1lDsrffoFNuTg1wlW+pApDyLpn6z2/p7s3ciTAmEDOhs
         W0qe2iIbSknlzlVhK9ZP+5d/8Li5vBZrs8sTskWoFFtoRh2yfZ2ecS5P7iZTt5SIO4yy
         8P9A==
X-Gm-Message-State: AOJu0Yy2Tu7cLlgH0Zn/TuU+Ce3xPjSIFwVdiWSHDPg4DvnNmNalAhQM
	Dhai/97zM1Xk+rHE+on62QVDvBjw+HRCVLmdXZBORRHaIv6nJJbClHyO
X-Gm-Gg: ASbGncvAhIdTGjvODl/NYAaQdQQB2fAKIaHtdww1lxlE5F/WjSQt1pEW9BklYm3jLSO
	N+GXDHSHX/jEh/g0CzeIfH9bNb32LmoPXSpRX8cZejVy8VDulsT/ASnaB5PUl3ZxqfPG+Y3LBK6
	OZD4fqtaG4bwkkYiYZiyf8TQFL4+edcPYaE4SGfotVmSljbrb2KRQLQ9mLs15Gx3EBcAKE9tgdM
	TdFCuHsYygZ3Bl4Ig3lYyOhw46Cdfb4kgV3fmt3NLJq5wBm5I7ALyLN197ZjmpVmp801LWRAn9o
	p/xaPP/KOkL6hEzirfF0RZW8YGMHf4G9uohPnOJuVZtgsHHFcyJpJpaNVCs/Li9WPL31TOR7dvY
	DuGooQ49O3dGzB2jP4xsdRQ+KBtkPuVWHw7lsaWHai0/jQHVzjUhbB3awunyBkrcUxcw/s9l+EZ
	KCdkwEMnPKDfET06hE4g==
X-Google-Smtp-Source: AGHT+IERb+y1n1bO8T8kzXWc/3DtiyzEfo/UYelcHhco5aO8dlNi4yPNrpOSOP12nWwlJD6g83oUgQ==
X-Received: by 2002:a05:600c:3546:b0:477:e09:f0f with SMTP id 5b1f17b1804b1-4778fe60310mr104243275e9.8.1763319585467;
        Sun, 16 Nov 2025 10:59:45 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b14bsm21804372f8f.9.2025.11.16.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 10:59:44 -0800 (PST)
Date: Sun, 16 Nov 2025 18:59:43 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/5] selftests: netconsole: validate target
 resume
Message-ID: <vt5igunw47u726ty5romoycbibjbbjgtv5cz53cyq2uh6mtnw7@dvehioj2kkiw>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
 <20251116-netcons-retrigger-v4-5-5290b5f140c2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116-netcons-retrigger-v4-5-5290b5f140c2@gmail.com>

On Sun, Nov 16, 2025 at 05:14:05PM +0000, Andre Carvalho wrote:
> +	pkill_socat
> +	# Cleanup & unload the module
> +	cleanup
> +	trap - EXIT

I noticed a small mistake here. This trap line should be outside of the loop,
right before exit. I'll send v5 fixing this after the 24h cooldown period.

> +
> +	echo "${BINDMODE} : Test passed" >&2
> +done
> +
> +exit "${ksft_pass}"
> 
> -- 
> 2.51.2
> 

-- 
Andre Carvalho

