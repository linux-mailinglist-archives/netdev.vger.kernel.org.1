Return-Path: <netdev+bounces-231076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B5BF4768
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 05:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD5D405E92
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5798C1EB5FD;
	Tue, 21 Oct 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7Dn7VWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3241B3930
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016295; cv=none; b=r8LpcJVz8njlaV0zIVwY/BT8pvMrPZUxAQ+O13PnpBlep6TI3plC1Iz/MjUlTxMtWgaD/2UkHQ8noDApgfvfwOyLK665LS8uLOv49ddzQiH1cvIyN8cg5zQkAubVTXTh6DBq596MqBw1DkJIkut2pMSmvcsM5O6ejyqLVUg6VBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016295; c=relaxed/simple;
	bh=GiwpcrMR/TWL6tAbqQHX/odqPY5+0sz0jLyT8mHTXC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiIKE2+lq6BT7rSD1vOtOcYVH7MtDIXrWPNtd3IT370Hd3ZYCLBc83PfjhsbZ8NrGfkyq0rTXWhDs4CaXXJzXo3QOd0Cz65fU/4BzjFIRF9y1F62TccN90Dr+198lnQKBO4ktEJXtTNq95i71TLishVp6GGBVDW4GSl199183nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7Dn7VWD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290aaff555eso48911435ad.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761016293; x=1761621093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zzIYo6bijCpxcJWIZhtdJb/qti87IejtmfdbwcbHR4=;
        b=Z7Dn7VWDuuo4leCGlP6Tnn9hZlh8w88kUr6KdilBEFxcBSYOD+mcoVLbjfFYL/BU3A
         uUUBSm38Q9OmqAuyjMJngIW604p0xvwZ1eYw4p7+WWEmtQ/S8ROY/LVEH5kreXTVdd8j
         8WlGex+frZZDSoTmQXGOF2Fs6XY4qLuTWg4uK9KknR5Vavhcty9J3YMuWuvh/NP48kHF
         1bh9WjFdVIhDqZu3bursSUYf4ZkrvXTMjccL/LqMmtxPcOAQ7/4hClri/cmKkzGEYRCB
         HxPhnQ9SwsJMJHUgn9Bz0OcxOR6sYDWyt0f4KwU3kzMiNeE8RhEC6SkCKeUz5pEeMjsc
         Mmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761016293; x=1761621093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zzIYo6bijCpxcJWIZhtdJb/qti87IejtmfdbwcbHR4=;
        b=h7dVPcjDL8YRDZIUqD3SJsOnyZ622ZPPURsgyuJL94p8dbTWgqxHaY9gJaXvyeuZXo
         yYhbJKfqtIWSun2NYOQDNIatZ30A0NmShotiyT36ojXbDnO2/ouf1nHcXPnEj55+O1YC
         zMtULsrWyslfCiqedofaZ3zOrAbrbAAHKbt8VjPWPL5HTpWvg34cLSlaA7JKJK4O1uBx
         gpU+RrekePrtf2stPEh7PErKv+SJdLTwo3EuzwM1+WG51gzwfHJJx4pNGnaM0GncuY/d
         fXx8Ew8J0nMw1kwdGQkaNCcEVjjp5o8dqi7dedNXJ8uIknu8bT8hkN0l1wKZfmMp13cs
         c3vA==
X-Forwarded-Encrypted: i=1; AJvYcCXRp67IstNoy+fwbTgIeqYv6/EVpd2+T+MuF4YGX383K1iblCF0uvKsF9fU7uYRrzJc0nlZQH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvioiHpHtWtRN0ncLTsx2Z92g3ytaaMVYeauEZTM1kfcXY9lJ
	7rHt9r0rMqfI9s0IbKpA/uKFC2WRfEwl1mLKCckMTfR59q1vPr4Hwoaa
X-Gm-Gg: ASbGnctmUo5iVR1RtHcl40BEUHCFZTXMW+G0zkHvSq9FscpD94FpvEEkriCj3QDrAji
	EJQdgaKpBht5McBeYxJP+QeZ+tPr1x13L+H5Jr2YVDRuquP4mojWaWqXBYwcBmGQ7t/IT8OtZd+
	zLpJNS9MuJhqd9ucxUZqazB06F8u3WN+J//tPiVUyiRSTFAWIsLRH/uaeSqesDpwJr/Fi6QWsgk
	bTSLqcJJfvgaaNaX6v/gUAfvAws/Kz4Na3E5jg22MRhjdj8pKzSmsUG/osQGqV3n+d8azU2Gxd2
	uzPtUKvNkqyflCZWqSsPZ2k7nMjwTwY+2/9g13IaEaUUtM6xgrRDTs/v6s1/nctVEVrctcRBr9D
	q/95+yuda76GRzAE39jAGysSxLCyxEv+j3lq2KG2ib+iV3I/Kpz7T6HqGLB7Fe6zxmU1WZBBPO5
	scAhIMn8Dfbw59/w==
X-Google-Smtp-Source: AGHT+IEoy+E4PgcisDYxaWGi0W8ZQNNYC69FKnsLNNDw9J1mSnMjPF70iln4Fvt45A3k6aqHS0uRTw==
X-Received: by 2002:a17:902:ce12:b0:252:a80c:3cc5 with SMTP id d9443c01a7336-290ca4f9174mr168922825ad.22.1761016293038;
        Mon, 20 Oct 2025 20:11:33 -0700 (PDT)
Received: from phytium-Ubuntu ([218.76.62.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm95037755ad.52.2025.10.20.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:11:32 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:11:27 +0000
From: Zuoqian <zuoqian113@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: macb: enable IPv6 support for TSO
Message-ID: <aPb53y1MSNdDXr2d@phytium-Ubuntu>
References: <20251020095509.2204-1-zuoqian113@gmail.com>
 <657cf1e4-a27a-4d9d-9931-494ce26ef325@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657cf1e4-a27a-4d9d-9931-494ce26ef325@lunn.ch>

On Mon, Oct 20, 2025 at 09:01:13PM +0200, Andrew Lunn wrote:
> On Mon, Oct 20, 2025 at 09:55:08AM +0000, zuoqian wrote:
> > New Cadence GEM hardware support TSO for both ipv4 and IPv6 protocols,
> 
> What about the 'Old' Cadence GEM hardware? I'm assuming you mean
> something by New here. So it would be good to make a comment something
> like that IPv4 and IPv6 TSO was added at the same time. So if IPv4 TSO
> is supported, IPv6 TSO should also be supported, so there is no danger
> of regressions with older GEM hardware.
>
Thank you for your suggestion. 
The Cadence GEM hardware I'm using supports both IPv4 and IPv6 TSO.
However, I'm uncertain whether the driver's initial support only for
IPv4 TSO implies that older hardware versions exist which solely support
IPv4 TSO.
> > Signed-off-by: zuoqian <zuoqian113@gmail.com>
> 
> This means you are agreeing to:
> 
> https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
> 
> However, we say "using a known identity", since this is a legal
> statement. I don't think zuoqian qualifies. Please you a full name
> here.
> 
>     Andrew
> 
> ---
> pw-bot: cr
Regarding the identity verification, "zuoqian" is indeed my legal full
name.

Regards,
Zuoqian

