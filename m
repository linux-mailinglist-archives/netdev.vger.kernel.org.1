Return-Path: <netdev+bounces-164725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314BBA2EDC2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE69B165019
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C2E2288F9;
	Mon, 10 Feb 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/cRFdgG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E7225A44
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194093; cv=none; b=XNQfZYsYBhkhXjP37BBCLAa4vRqCf+JGCqqh8qQLN6LQtmS9E2QS9wmmyEt4CyFP3UC/UH4bL5kqbh9oy1EoVJjZ2q38r6nRFqMe6GMg9CQAqB2rCnFvta/qMGUHUC/cMCJyKMW5cUBWxxX3ZvMNRXUuW8dtSRobwqFetRmS/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194093; c=relaxed/simple;
	bh=jTvYQuh/vCGpkUiycoEx7DEwUYNyVd1tjghUZc/43/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK4MsgYnwAmfLQ00uMTKSjboR2aeYGzgcmXMj+shYCOtnu8FgtJb3etH/cQ0y5iuCfEzH+qmLngOKmxbsItcgdIJ1wlVM9Um/y4hKMHgnT2ZGUHABGMYjxkWX+tCaqbpqToQD0Cv6F0Za0kNy5jcrsFk3jmwVUrx4unPyx0ZU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/cRFdgG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43658c452f5so4587255e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 05:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194090; x=1739798890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oK6wtvTaEd+SXRdZypndNe+C4kPnw1fsW71LVIJ2s+c=;
        b=m/cRFdgG5ZbttZuWni6mN09VGV2ETnbw+e41vYCE4gxktW8v3uXhdeV5ZzinBWmkV2
         vh2BaJz6EudWiPbHEpMR/Oru88pcbn27P+p5RrnltRIFQn6PVJPG+ERnyX20iY9VnbEC
         awTvpTadJPR95Lnzlr6X1rv7LXkTvmcTOimIsgtvqObdLJP5E0BzTvw6mTD34QD6/6Se
         NLajZQylnQ08ErFtuCL7wGHU2ijuJySlVDh6dEP1uft8gYXl/0jx2Z3vkDhtMKZbIAD8
         +mhtKvLJZyrxXVoSfj+2zm/8BzFXClxbr+M+FSiJ07je9ff8v4prbC9OM1iJYfgC/1gD
         mZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194090; x=1739798890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK6wtvTaEd+SXRdZypndNe+C4kPnw1fsW71LVIJ2s+c=;
        b=HD/0DNy9XBVWyj3AbX68GIpUlwarQB8kMA3FdgO5EJI5CJTKy2KtP6EM3V/0VvzSEa
         kcLzm8BY0Rf6jwFw5LhlrIg+v39tIi/KfyTCQo+6rEY7Qa4+c3CWO+ItkZ0nK0OfXWc1
         EOO4lyAzOVhkf0kvmoXaCP0RwwFttbcbX/CXMYoV1mqhd2bkNuEr8vXhhRY/rx3v2zgx
         GYJ5Zz8mRjgfpADXTtJCX/cUwLM1Eam+ITD30a3tRohXFu3uEFjpAKiH+gnMNgKwpphr
         64n2f+tvABDOxo72MO/lIufrcBh80zAQHKa3UGyyhulLXbVaf4jls6ZLbZT1shW5fc9Y
         TWWA==
X-Forwarded-Encrypted: i=1; AJvYcCUSXt4FAukNGsz2ejj28tlQUOSyrgpfbInlWoRNeNBr2SEE7k2YFt//df7/6mLJV2mCcAjXY6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfZKCtRY41BWEvukNp0h/42xkH+4SijlnBfgbGLQnx6g4Dybd
	pQoXjynF6yuVBKpsKNQYjwaNuCM4e4etqxsR5SqXm6Hc6QOeAqdq
X-Gm-Gg: ASbGnctiZuNdv3gYEUrjv2wOX9sQs0aJd72dNN4f5ztTDwVIiJiQak1oDpNxcpHEVL7
	6JAYEj4MpXDajrbqK6IKJs/pBHe97AomDcKh/K+Jq1KayDqZNIQcborwR+kjKQpJe/xL5cSaXts
	FYgx77FCiz4qs35lAXRKGKOoBtcHz3H+8Fs1lCLgJrKvG0tt9em68Rc+IubagrhQrqS13vO8gbh
	qt44RU9yS6WjD5HIW7sFTLl+d34JUX/5S7swcUxjqK7TPBfs5M7zq/K3MR60eOSC8V1kwk9mrnM
	7C0=
X-Google-Smtp-Source: AGHT+IHNhPhl11CHj4a45PNKxZKnynVbzux780L09zjRvHkFs6XNbonfvQMbHlQqT/H3bN4FlF9GoA==
X-Received: by 2002:a05:600c:46c7:b0:434:a30b:5433 with SMTP id 5b1f17b1804b1-43924b5dcdfmr45242695e9.5.1739194089779;
        Mon, 10 Feb 2025 05:28:09 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc5839877sm10736992f8f.3.2025.02.10.05.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:28:09 -0800 (PST)
Date: Mon, 10 Feb 2025 15:28:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v3 0/3] net: dsa: add support for phylink
 managed EEE
Message-ID: <20250210132806.djzhqgemh4egiz2w@skbuf>
References: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>

On Mon, Feb 10, 2025 at 10:36:42AM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> This series adds support for phylink managed EEE to DSA, and converts
> mt753x to make use of this feature.
> 
> Patch 1 implements a helper to indicate whether the MAC LPI operations
> are populated (suggested by Vladimir)
> 
> Patch 2 makes the necessary changes to the core code - we retain calling
> set_mac_eee(), but this method now becomes a way to merely validate the
> arguments when using phylink managed EEE rather than performing any
> configuration.
> 
> Patch 3 converts the mt7530 driver to use phylink managed EEE.
> 
> v2: fix mt7530 build error
> v3: send correct patch 2
> 
>  drivers/net/dsa/mt7530.c  | 68 ++++++++++++++++++++++++++++++++---------------
>  drivers/net/phy/phylink.c |  3 +--
>  include/linux/phylink.h   | 12 +++++++++
>  net/dsa/user.c            | 21 +++++++++------
>  4 files changed, 73 insertions(+), 31 deletions(-)

Apart from the kernel-doc thing this looks fine to me. Please keep the
tags in patches if there is a need to resend.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

