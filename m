Return-Path: <netdev+bounces-201370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A3AE9357
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0427A6531
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4233993;
	Thu, 26 Jun 2025 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUPCo/wa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A2EEDE
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750897219; cv=none; b=LFDi5ZVNos8qxKAIMH8/GiW7D+XZModKiHck5le3FLiqDOlcGnc1V450AvI5sa6QjKJW1/2rAavJykXstI41S5CM4ilpq3gLfIj5krDVlp5DzUJE5UpUIJ8stwg6zba++BcybVXLSVQj64o+xVSmsGpBlRZNyNIO8QoGLexLEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750897219; c=relaxed/simple;
	bh=0H0s3NHA6Do6Cgkzj1VH/Y7kfE+I/KuzK4NdLxYNwPY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Sx0l5t13VzUDP8L1KGIH81REls9FbdBXnLyyQ1qkUADR1N1T/Xwiic+yac0AIqGx7rcH52NjjvhuXFAYo66Czti3hbG2gh1paxJC2g8iATv7PP1RwJZLXTr13hvoUhlVuACOqJnu5uv5uDkuAXW2+eI2ibURBachJ8ewZhqmm8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUPCo/wa; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e23e9aeefso4256557b3.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750897207; x=1751502007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gs4ejpuXHLGTX9L0lDbiBLPC0PjXU3YMoO9+1dS6Bd8=;
        b=dUPCo/wa8FF9CRo+z+0spu/jRAr5hg0EdpWe/guviqE8GVBTabuY9/ai3eg+HwFq34
         Fs/5pzeKpMaAUWXGwAR2A6epTjSUwBHvNOaylz6gyKy5mHLzQecjooDc8WxeF+BEFwCz
         LQK1ADyzSsdZOnXIWOKvblBdXsnSTE6EPMSWA2ANOtscXJNVdsHQP638cGbcNO7bmKWl
         ZecqE3Xomk0x6+gRVpN5AmmUozT+Tnd2ketAr4KU/5lCmJ28gPkwQQfyjKZ6zFNgvqWV
         h5PoZ/GHySnBxwMP0FVroHShU1yTzymwLhxU4UV8LAdDCR71fXg9nfbFaxf5x/BTXBgO
         /H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750897207; x=1751502007;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gs4ejpuXHLGTX9L0lDbiBLPC0PjXU3YMoO9+1dS6Bd8=;
        b=a6swrOSvwE2/J0gkcgXjDAKVY+rPqrSOcfMXuxCiP5N+SX/jL6rsEdet4tQXfb6Wjv
         k4ewTA1mM5gwG15BYScKZMdMUXoOhrT+V/5WIlP8ntSC7aEJhgUnHheRKZTmzQbyCTaR
         jHsxjEbj+5GvR1pjQ4fkMTCke7mkE8ypL16QCmAi7hfhR81FjyYKtG9UoIB+qMeSw4ru
         FakffadfLrUuZZ+E/1QBDhYI3rouhlQKZpR19/0pI+rbATUa+bBuuqpxZ77slSE86nfu
         J0zg9wGFR4cDGglsV9easUVah0v4/r7ogD0/OFbLgMpfFvGKyrT3OARn3od0iS0K2S/r
         evvA==
X-Forwarded-Encrypted: i=1; AJvYcCUihGGCQlWjLzCgVJYp17I1tHZ3QAcSInKymp2AssCs6ORai+NbKFpXHnIytQBm9QBkGXsxiA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCa6bElDPbMeYc/jhf25rhs7t+482VQMnGUvWTIStlEJjLUC3D
	YFv8ZWt/MG5nCewBwj+s9MlLFIC0sYpaoZT3oIlGbjhwy+A1fmgSbyUo
X-Gm-Gg: ASbGncuzGtEt3JoDJdxM7/YA0cvHevlivhA0c9wLL5zrLQ6zcBuJ5mH9ne+XNx1VoWo
	CIy++ByG74UmKXDab+E60gh6D0TNtriZRjBg0zC0ylLGpdCHtgDCl4neTPdEdr07ylEvRIW35KN
	NQkZ2xkY1gUU8Rf+5bx3+Jh5di6tMfgE5cnuPi6Z7yKXYmSlY/qtO79ZNEWqKC41vP3gv0a3pqX
	L1yGhHZK/z62hTiOM+pLu09Pl6oa7AuCpYRbuYdVSVbkUMes0fGzSbU3VG/dtQekqc+UOGUaJ6/
	bbhByVvrcu3BLbflYkDif1MaLpxO9m6A29KwvHcu4vmY7/0GrLNgYvSLIWpH2cavi0SYYCN+hr9
	cUe6n1RqeL0jAOqVPoBFlpVdecAeqcGhi0hiJRFNYcIswegwuJOmI
X-Google-Smtp-Source: AGHT+IFzezoKH3r+JeF0iy5GxlDtTlLl/z/0/m3ZKNYBojvjwj2nxQs/yEPQUMZTfmRxI32BhVji+g==
X-Received: by 2002:a05:690c:6e13:b0:714:250:833a with SMTP id 00721157ae682-71406df28eemr73768407b3.27.1750897207698;
        Wed, 25 Jun 2025 17:20:07 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4a21f02sm26583867b3.45.2025.06.25.17.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 17:20:07 -0700 (PDT)
Date: Wed, 25 Jun 2025 20:20:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685c9236a44fc_2a5da429471@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625135210.2975231-11-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-11-daniel.zahka@gmail.com>
Subject: Re: [PATCH v2 10/17] psp: track generations of device key
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> There is a (somewhat theoretical in absence of multi-host support)
> possibility that another entity will rotate the key and we won't
> know. This may lead to accepting packets with matching SPI but
> which used different crypto keys than we expected. Maintain and
> compare "key generation" per PSP spec.

One option is for the device to include a generation id along
with the session key and SPI.

It already does, as the MSB of the SPI determines which of the two
device keys is responsible.

But this could be extended to multi-bit.

Another option to avoid this issue is for a device to notify the host
whenever it rotates the key. This can be due to a multi-host scenario
where another host requested a rotation. Or it may be a device
initiated rotation as it runs out of 31b SPI.
 
> Since we're tracking "key generations" more explicitly now,
> maintain different lists for associations from different generations.
> This way we can catch stale associations (the user space should
> listen to rotation notifications and change the keys).
> 
> Drivers can "opt out" of generation tracking by setting
> the generation value to 0.

Why?

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

