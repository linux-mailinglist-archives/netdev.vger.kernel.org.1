Return-Path: <netdev+bounces-212669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D9B219AB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68E93B693E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECEB1E5B70;
	Tue, 12 Aug 2025 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="aF+71G73"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F21DDA09
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957234; cv=none; b=vDqBBK37nARtkqLsoFZORlJ7dMPTkZvEJkBWZet9VykTbHWmljEAlB2W6gYROo2G5jtSaDWiQOqVhbe8uhxSeVQ2Y2fcJt5mb7dZ7PaSOnae9bZjcZJNSibG6fD73+fz4xxjmQThGu+QK8FZodjSWUqCTu6BKXdA5A1qihHAkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957234; c=relaxed/simple;
	bh=JcSgJQ59yH0IPqCQ2lzDThjFVcjMFEEKe5mh0ALIIDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN9/rUdsOJXRnBBqMAE83pNlN14+S6mPFfUVAax3YlKunI+IGxB9gIt61cQFDzNeo/LCF2W1ymLig6ar97tTNOpg9qKL5VcuSmfjg/Pt7iCkV+7PiG8eS4Iqv7GKis7uBUJnRZUlvY9GiJLf50nwQIFfuTHVr+zJ1TJuYKEgKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=aF+71G73; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so5160812a91.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754957232; x=1755562032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqFUKsCtzRdN7XcvDwxDgMUVAASi1G418UR1zVxhIeQ=;
        b=aF+71G73SX2e7aIvoCE84/j+6EVFJw0K0JoWz083ABNL3IJRBUBX6aWmgCIznFIYn8
         GEy/imi42j06lNv9TWNUeulXwbAMy8E/FWf04/DSBrtzanI5cYDkzTJ/Q7NjHfFLw1Hi
         tujGDG163X2TKg3PcpXNzaz+qWf8S0P2oQK4IbHHFZMOf7fBsVNRvujFruMw5iVQPMhP
         24iwg4TvMKFCmbao6vI/PedqPM7s6/56EZ3X6mk8Thf/oElrkXSEMF4Lw6ZlWl9EF4sU
         sPuLaLAQhG/oQxy1Ogb38IXq6ZsrRzjmCA8Fmouvi4kIk/CAHtmkNA4aGfDlmkYr37vk
         jwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754957232; x=1755562032;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqFUKsCtzRdN7XcvDwxDgMUVAASi1G418UR1zVxhIeQ=;
        b=Y+ygNsXeYxrUwR3/0jHVovzQCcLicrhl4ArECSqQI2fskOQBCODEOk17sff+LUvKYe
         4v4S0caMm0g5ZGa+zEI8I3zRYBU+xlZE+3dMh9fZfwneyV8XuyWmLuaLdtil7Owa/sRu
         AUr+yNDjHI60UlEacE99pNbxEl//7Haw/xjgROxf/jkP0CdOZyE2FCrs6VUP5b+slwTY
         JIavpc64cFX6wl49vH7vY0DwB3OWxXc7NGuGMc2bxZNYa4Vcuas6IFeGfTDMmw98/h+D
         AZ/TJkWddzc2bD3YQwROfVl7g557pZBMIF4MlkKsfbuUZ0mfOIZ4pezZrWZqrHuItVGL
         egNw==
X-Forwarded-Encrypted: i=1; AJvYcCXnbGNoQhrkFxc0obEOikQnuudp1UYVfY+wDV4fg0WV5hV7J6ediej7VYtvIAySaNCasgh2KUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywTohiq/UiX4I9RbbK3wbXwiKkZKyo63QARvyCCSOSY1pkfsCK
	FntEcEBpxQdFfI+tyv33KXujzbb+7cXdGQ6wWKZ8DHo9qXDtqtq8eD/p7Pzv47A+vrs=
X-Gm-Gg: ASbGncsAxd3Ra6WIGcISIuNap8JEMWtyshxkkqHhj/YuPg+TvwU+nlYKs5OuSQL7zbm
	QNf9hbNfTztP/ugODNdeFPXxyDyE1AAPsn0d3STYfbGQSFxBWtH0CSMRy2ALQiWdCPhx9H2YIs6
	ffd6Vv6FQTYsw59R+dlFMa+vxp7pUTXLV8SP8wwSiuK7aXzQgKqQrvxz0mHsoDFgkHu/7huhTk6
	txG5XVnEQyMHA2qJAujda9s7oeDEZhc+SIQVy9l+UB6asRSMLVpK39JzSaq0P0yd4F+cwZbwh1r
	m5V9DlgfVEM8sO1HJgIXX2OgBNmGfF6JhQ+95lLzmzDk4uA6YtCm5pHDZkoBrTNFfVbsudDIVef
	avkWV9NR2lMzurvWjcZ3gsFl7G3Xge/KOgXLvbKQGEJnKNngkgxubvSfnMASuVHVnD/0=
X-Google-Smtp-Source: AGHT+IHvTfW8ErtYxmCHyfwmYUsv3qThL/CdkOqZ2HZYuqS8vGSb2x0qKaF105IAiumURKGEoJjfPg==
X-Received: by 2002:a17:90b:3c83:b0:31f:22f:a221 with SMTP id 98e67ed59e1d1-32183c46097mr21445066a91.29.1754957232026;
        Mon, 11 Aug 2025 17:07:12 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b43c54fbce4sm5843931a12.55.2025.08.11.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:07:11 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:07:09 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: devmem: add / correct
 the IPv6 support
Message-ID: <aJqFrdKEqRj1mI3y@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-4-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:32PM -0700, Jakub Kicinski wrote:
> We need to use bracketed IPv6 addresses for socat.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/devmem.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> index baa2f24240ba..0a2533a3d6d6 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -24,7 +24,7 @@ from lib.py import ksft_disruptive
>      require_devmem(cfg)
>  
>      port = rand_port()
> -    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port},bind={cfg.remote_addr}:{port}"
> +    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"

FWIW I had no idea socat supports bracketed v4 addresses (just to make sure
this change won't break anything). A quick test I did locally shows it does.

Reviewed-by: Joe Damato <joe@dama.to>

