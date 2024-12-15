Return-Path: <netdev+bounces-152046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E29F2761
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 00:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261AE188465B
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B5A1BDA89;
	Sun, 15 Dec 2024 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufg3v24X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126101885A5;
	Sun, 15 Dec 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304420; cv=none; b=YUCewpO6KA49U2mbQYD2TePKpMl0foOIAa6mFM5n1qRHlD45i86h+gQ/NMhy2Q8GpvGwX/wAW85SbAZhc86f/o5TN0co4FQZHy57p7VLxgsD4oQMLXn7xq0nJ3Zn0fM4wf0rG4q/Qwc6vhiRXY9zh/1RXhJvMH2DYNvXYZbElRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304420; c=relaxed/simple;
	bh=rjY1BfZS2hcFy9ioshTwl5SCCfIdJY0PvIXzYF6EoWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt6Va5kzGrYBulXLu4Hwf2qD8dF7UdMlkd5EU9S4iNjm6XYnm6Q9XOM1Ab0mKtgjpyV2h9Wb3raEO7Zcd94NVIRMH+8N3GyZF8gcokSTamANMsi2PcFvjWMByQNqiQXPoCJqN+CT37crp7yvH4MeqdWr2yMor5w8zxKX4wj4osw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufg3v24X; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43637977fa4so1064165e9.3;
        Sun, 15 Dec 2024 15:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734304417; x=1734909217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20p+ETg747maiNgD/3eH/GlhvstWZXWIVpbyOW7bH5I=;
        b=Ufg3v24Xf6sFmQLXLbKACOwHepe0/qjdm7aWVrduNpADj+OLHw4hGSntWkCENj+Whq
         ffQURfnuU+5ZlHtEsI11AbTDLT5KHTG7CsDJr8fD+oSxgqnUPbrlU3j6/OKapmruQpna
         Xt4iBAx3yI5+n58fEhcbxFtInd+4400j0oPVFInIpxBoGhRq+kjIHfbiB7sVik1R3XYd
         XXm/qnXO5zL6kPRyoKixNRJvirEUQ71HfLT0rYKkIjXJkv/txNhBy8wRQ14RkuvA+MiO
         FVwGXEEsXwHBA0YTIQGZy86zyXL54kvjoW08+Dhb1aH/8fUhRZ1QqBI+KzVBqVEpVNIC
         dTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734304417; x=1734909217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20p+ETg747maiNgD/3eH/GlhvstWZXWIVpbyOW7bH5I=;
        b=I8V2T4cFvvTYJb+vWKZ3DYkEbCrad9eGQCsCrl/OdwShTrMi+fQtV28X27w2w9/Kid
         IdO8P1F1RDtSIZ0lX6yb20sD0J2K04afQFJnj+wCB6tEc0WltM/zf+56c//aF7ANlStU
         85mLSFHSAWkZXDUBRTTRbI2Pr6Vn0ICsVGa1Fs9AJB3oWcSSa91tjorn+fW35Ua3uXmW
         8PujMX/9j/PyYBnrwOQq+U53yhHHN4GXcuwSWsYLeCXAFzlys1ZCxoAQEBph4VqVt3UA
         ecITyNHcfauVUY2Vgfd/w7OZ122LdmjZs+QcTo/O6+r8om7UHvSkM5Us/Jma4N5VZqUY
         AhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRFPHS1o+Rba0fjaCrbMVv7yiOzo81v7PKqYcMfugjc+wV7AMruS4e3LBbJSvFAL0RJDltR4joceU/QI8=@vger.kernel.org, AJvYcCWvrdVndfI0uUB3y+sZDaZ3Cqo5Uqk9lmwXVbX5g4hsss/wrSU4SqQQFJSyjuG+x9D7FEAybvrD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tC0RUEnss7fWc+wZvDe8VVUKDNjWyGAWI5ytCEMYHsbXfvz5
	5frYfecuPL9dfX/eKLbxPEnvty1zoTt+xH303c6gTPlicSXyiBJe
X-Gm-Gg: ASbGncttW3OzYw+v10eUeRYf1SUzXk4mlC1uCdbuT4rG+ldS/RBEGHsYOu5bTA6i8SE
	jEUaBU0FEcRBaCAYuwj/DXu6cDUTf2VWdiBdsq0ZlMEZcSTuRO+/TvhT94qdKHe/p/ORQOHwSeQ
	D/gDtX40B4WbzSsklofAkr7cs2sPIe23MBsOk9ItLFWVl28N3lUfFvJk0IzsC0t9W+3QRRyQebS
	KkFyVJ639ZZwHId7VpEC9rLxs3xYsBelrmYEX2DBibB
X-Google-Smtp-Source: AGHT+IGaZL3Yyiu4Cqg7rrGRXHgRBwFOQjoXwcnrTBfZSr3TgPZDtcxMJWNU8UJ4mCStRRMor7SZTA==
X-Received: by 2002:a5d:6da6:0:b0:385:e10a:4d98 with SMTP id ffacd0b85a97d-38880ada7c6mr3833899f8f.8.1734304417111;
        Sun, 15 Dec 2024 15:13:37 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c804a297sm6363333f8f.67.2024.12.15.15.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 15:13:36 -0800 (PST)
Date: Mon, 16 Dec 2024 01:13:34 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: qca8k: Fix inconsistent use of
 jiffies vs milliseconds
Message-ID: <20241215231334.imva5oorpyq7lavl@skbuf>
References: <20241215-qca8k-jiffies-v1-1-5a4d313c76ea@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215-qca8k-jiffies-v1-1-5a4d313c76ea@lunn.ch>

On Sun, Dec 15, 2024 at 05:43:55PM +0000, Andrew Lunn wrote:
> wait_for_complete_timeout() expects a timeout in jiffies. With the
> driver, some call sites converted QCA8K_ETHERNET_TIMEOUT to jiffies,
> others did not. Make the code consistent by changes the #define to
> include a call to msecs_to_jiffies, and remove all other calls to
> msecs_to_jiffies.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---

If my calculations are correct, for CONFIG_HZ=100, 5 jiffies last 50 ms.
So, assuming that configuration, the patch would be _decreasing_ the timeout
from 50 ms to 5 ms. The change should be tested to confirm it's enough.
Christian, could you do that?

