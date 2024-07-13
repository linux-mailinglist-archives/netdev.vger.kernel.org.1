Return-Path: <netdev+bounces-111284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844499307AD
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC5F1C20BEA
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B731448EB;
	Sat, 13 Jul 2024 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAiU8Jri"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327E1B28D;
	Sat, 13 Jul 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720909214; cv=none; b=HafUUIf8hI93iFmuPRarOzA8ds2CW8jNTJaGIsIYgujwEJf/jhzRiXfqF+gdY4cHITVE6r6U+D2s5OXOA0LD4HEAujQAmVII6xoVzP8Dzy6E39/ciWhBOVUWjyjtqPnC1VuGht40XuWr98UUyyl1vJL3D8sg8+5/Zw91JzkmPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720909214; c=relaxed/simple;
	bh=vw/5G0b54ZvaP0GyutE3JIwnlU0W7UohrhAliZNnLUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSqCdNZudwwCQhK/9SMihu64Cr+vr1hEavugxS31pzhRWAAv4wx4aXNZDCMv/4Vg/FAqaW94jXsxYe0q2b8Jj086Ntu+3cahvaUnIZXKuF8XxNCYAwALRSeeXzwOW7/cj5zNLsRsW51f74D8cfseLuX5cxj7JZx++qOBrGGHoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAiU8Jri; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4279f48bd94so12964285e9.1;
        Sat, 13 Jul 2024 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720909211; x=1721514011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQt/kYZQs6KDNI+pc5wwQA39rgAHm/rL+vWQvwIIgps=;
        b=HAiU8Jrim8LhWGLHO1kJZSZCYDhsTOFfFGTZTLyWcwILl0ZRmKKQhsOFRKGs6LuWBb
         cz69QNe+EI6VpnCSzK3XYuxqnZWWpFslsDU38VnCmbaNACeK54O/0DaYRgqiSnnb5s54
         eveNR5WhNjnqTRAG5bW4uTnbwLydoyhpCDLO3iLIQhLtRz2kPQxYchYFb1jfHtfUSR01
         HMF4JMyzM38CgNdPocqCygc49ivLSIZ2EYA0TiABPs8EjDsHeve7/eOn8xgbPeZd8Iuk
         I8KecWYYzA0GcIda4P3f3YBFIvtQCMf9NnoK63mNg96zV8mIl6MvIn3xLNR1LkJ7Wisi
         OUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720909211; x=1721514011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQt/kYZQs6KDNI+pc5wwQA39rgAHm/rL+vWQvwIIgps=;
        b=YzcxWBZcsRDyko8I2r/nL2/713sslhw22N3sJEIvqh7mmKuuvtuX/cYJlyWM2eOni2
         YRvrR74SCT1GHzj936bUuDmH1JpYDbr9Okj3t4mYjVdYL1fGxA9lKWgfzaPgdQhPvaTC
         m8TWJHUoi5oSK9lsc0wNqUQVjh5MzGhyviVml72fjetky7YvE96yZ0jYuE8gYBmeLm1o
         lj8a9AZ/MpNuQS2fjdQ+g95pMx5p4TFwdlqEa0bg11zJkPjLVZVQbgb9CjHRtLkMreV6
         MucfFuuwWGJo3DoxMV+hgkzyIcdn0P9Qt7F4Er9ZaE3vEpGDTyt6b2370WpEhd4FbLiM
         xZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvxJnHrcFQzIKszZOZOkZjtRxoqESfYhby1taUaMEqLPX1ilBhYW0qLRAsHUxAEFeTZjSX8yxBPHN4h1QxWlDv7ngA9vXCmYb3P1Pa
X-Gm-Message-State: AOJu0Ywjg1sUAkZXgmMV+ZzpdS0wML1ezhAR5r2z0w9RS9dN9jVxfaER
	vTrEzoDWYInxDEdIYTBbFHtdVMylH7yeTI5qVaCND5sBdtFgv+EP
X-Google-Smtp-Source: AGHT+IF5/nkTGPBg8GM3heYlmUwdkzyC/ooGwBpJGdwSdEH+6sgUKz8DBkayBk1ouMFillqERc5ziQ==
X-Received: by 2002:a05:600c:4606:b0:426:6f3e:feef with SMTP id 5b1f17b1804b1-426708f14e2mr109464005e9.29.1720909210798;
        Sat, 13 Jul 2024 15:20:10 -0700 (PDT)
Received: from skbuf ([188.25.49.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e8e2ecsm34225515e9.21.2024.07.13.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 15:20:10 -0700 (PDT)
Date: Sun, 14 Jul 2024 01:20:07 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 08/12] net: dsa: vsc73xx: Implement the
 tag_8021q VLAN operations
Message-ID: <20240713222007.gzskwsqmz5puivwz@skbuf>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
 <20240713211620.1125910-9-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713211620.1125910-9-paweldembicki@gmail.com>

On Sat, Jul 13, 2024 at 11:16:14PM +0200, Pawel Dembicki wrote:
> This patch is a simple implementation of 802.1q tagging in the vsc73xx
> driver. Currently, devices with DSA_TAG_PROTO_NONE are not functional.
> The VSC73XX family doesn't provide any tag support for external Ethernet
> ports.
> 
> The only option available is VLAN-based tagging, which requires constant
> hardware VLAN filtering. While the VSC73XX family supports provider
> bridging, it only supports QinQ without full implementation of 802.1AD.
> This means it only allows the doubled 0x8100 TPID.
> 
> In the simple port mode, QinQ is enabled to preserve forwarding of
> VLAN-tagged frames.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

