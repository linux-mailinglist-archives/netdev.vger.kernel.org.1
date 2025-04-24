Return-Path: <netdev+bounces-185493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74F3A9AAC6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE9B3B5236
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CA221FBF;
	Thu, 24 Apr 2025 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL4IX31v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD625487E;
	Thu, 24 Apr 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491206; cv=none; b=h59cggkHgow3at/krrFvWX5NdnM+N9V+mJyEXgyr8G9ibO63lwqoPdz8bz40OKrsduloRsEW8nB3TwXhAkXLTMrNOYo4xLwAxO77zOOqi4kw3I3ak1L04NdwNH0jrXrJoziTUFUJj+W/anv3I9+JlV3YaR3xKK5S9oA/yQXUawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491206; c=relaxed/simple;
	bh=1vSr9BLxCUPjlNlEXJkAyGHPTaIvCHIG2IQrFD1DRzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEmYnl5EKmtRGLDDoc60pnP4kP7tIKwDwcUmrsZKqOngm2Qolp9hgVB40zLFzHKm68nfRHWngWGeZyV1F39NqS/crFcxrGLbOwYp67peRTFS0+MbKluj1HBFK9zxLJANh477paHCct95jJETNPCIZUOxRw5FRGQ6XANgZJDza68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL4IX31v; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43e9ccaa1ebso1059105e9.1;
        Thu, 24 Apr 2025 03:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745491203; x=1746096003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SoN4/99QCeCPD/IFUUNrENS2wuoOQu8z5Qt527CEi1o=;
        b=EL4IX31vZMFBwg/OS82l5Zl9OZyXFwkUxu6oVcwpBKjWJmjRftU/k0zCAM+AsaHGzO
         kRQFcUgxOnaUaqGbmpMI673L5551j/bYKgg8eUYSVhzYP1I6v2b5DIrSE71y6z48vVQx
         5OIEm2kIUzjXKTq4VBBADCMqjEACCfMTe/GW7/BcYL8b+TS2TWNUp/ZIictubozMgItZ
         YrrMylOp3Fd+1AEnkrydJdh7Ylh9nWvYYubkOoNtN7pU0UycC1BpMfOTTNp0RxlBRq+y
         uzBJ9VKDb2rCQ0Wbesejjbe8QR4wMWJhSSWabKRg2icjEEaaD0pmuPTi2rfAaZP3bpbz
         6Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491203; x=1746096003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoN4/99QCeCPD/IFUUNrENS2wuoOQu8z5Qt527CEi1o=;
        b=d+MgivdBsr7wVTzhlkmo47LI/UkQ3gZoEM8WSF370frHr2KDzVfrz38kqE6MJGmf6P
         wpSGX1Z7q3olBrbaWWu2gQtWFc498fKMs3YjZSzhv4Ntte7nai04CQiktIojSL/ksLWF
         bdeDbF6tgDVM5PuAkN6Bab31BYrfFRrGAgRlGSSCQBtd2OCpBncO6okqivwJ63jt5hsN
         K0XkeUJWwz3ff6urq6D+xBjEzFEQHXykR8fgOTQs1fPkGkv6QXGuMLakaUddmYGqJAIM
         szWxadZdw/TsZM+ObDnFgAT/hvcsY7MNIsByp5LqGRJo2no+iANmm/Cq3hcl0smR4moT
         t2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6+HVQzRjoyB8gA1s0iK/pr/tQDL+8AGzcyboBgpRYbH5YtSgk19Q2+1n+EohE5BY0GQSHw2JWvS4XOK8=@vger.kernel.org, AJvYcCU8m2Nv3x7dF4bIbKNXJIxy3RL3GYHuwo6F0mKuAHPTXlVp20HhsQByw9fuVejul600DJHhpD8E@vger.kernel.org
X-Gm-Message-State: AOJu0YxSiFpQJJ/RrTIjD2ihAFJuyqRPDfrEmVRAWojLdJNyWS7euseG
	tfH1B57qdcHps3M3ToFdh5nuyss18FBK5FgE4DNmxJchrgWAkf4EaCPpJA==
X-Gm-Gg: ASbGnctW/IaLwHQPtvRAkW7FcYKIe80c2FF3iOqj9QCHVTf0hlIuXi3GwxmYYISo5nD
	E3yaHxdtbYWT55BoIn8o3dd29+SoZJAVn4LwoxxIqHC1QYMbsn3bjwZu0V63clOUl0YLFRTpKNv
	l6zaLCS6+PFT2QqLLFEa8G8dHBv6+rHrEwSaCUjcrEbGjZpkrIsasXWRzJ/xWH9nu3Vdsfhx+k9
	quF4RmoJtESl11pUoTtXhyXsK64U0kqRTQouN5+lO+POTxfLiclMDauau+hAU0LhQT3+0f/2c5h
	C87OR1Gab6ezeqH01QnqOkEEUCPH
X-Google-Smtp-Source: AGHT+IERnn6Lllt+pk1rksgyARdqZz/Xxbg52YA6wZMDe6rtFjjM8/E9kc1gFGW2aF+k041jBLFGpA==
X-Received: by 2002:a05:600c:3516:b0:440:58d1:7ec3 with SMTP id 5b1f17b1804b1-4409bda5fadmr6714175e9.6.1745491202872;
        Thu, 24 Apr 2025 03:40:02 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d0a7802sm49830355e9.1.2025.04.24.03.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:40:02 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:39:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>, Neal Yen <neal.yen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: dsa: mt7530: sync driver-specific behavior of
 MT7531 variants
Message-ID: <20250424103959.tifvhfhpsytqzxpf@skbuf>
References: <89ed7ec6d4fa0395ac53ad2809742bb1ce61ed12.1745290867.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ed7ec6d4fa0395ac53ad2809742bb1ce61ed12.1745290867.git.daniel@makrotopia.org>

On Tue, Apr 22, 2025 at 04:10:20AM +0100, Daniel Golle wrote:
> MT7531 standalone and MMIO variants found in MT7988 and EN7581 share
> most basic properties. Despite that, assisted_learning_on_cpu_port and
> mtu_enforcement_ingress were only applied for MT7531 but not for MT7988
> or EN7581, causing the expected issues on MMIO devices.
> 
> Apply both settings equally also for MT7988 and EN7581 by moving both
> assignments form mt7531_setup() to mt7531_setup_common().
> 
> This fixes unwanted flooding of packets due to unknown unicast
> during DA lookup, as well as issues with heterogenous MTU settings.
> 
> Fixes: 7f54cc9772ce ("net: dsa: mt7530: split-off common parts from mt7531_setup")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

