Return-Path: <netdev+bounces-191503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B478ABBAE7
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4237A570E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582C02741B3;
	Mon, 19 May 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXByOON1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5F26B095
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649968; cv=none; b=naTLFL20rYDUO270/loqoLBxFjeSVBcRsT4/Wt66rgMHXHtwfbEYFqeySdiR6vxzOVJ+vDPvPW46MSyHmUxH4l7DY2E4GaSU5HOBymkJSdwjPo52WPchJX9SRJAO6k4nhEwW1fWGIvtxU+Rrr9U9VfykB0Cpwl7OUBRx1+7lKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649968; c=relaxed/simple;
	bh=JZwRXyoZTBkvUmRPIKE5OHqxpzCewCZ9kB5GSZOlL6M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=eFsIUyDajp6wkBjJAuGqIyd1C3a8PhMsQRD48eOpKvlAp0HfMXewbyQj+sPHS++Ms7GM13qVW9g2gOVvM4KUkNW8ylX0riRFg7CP2iDl4O2Ppym8nE0RpnBMVieBIrJ3zpPAa0EmXRecj7JKxOUQf87es/3UwlZ1upuowEvMhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXByOON1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe574976so28513585e9.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649965; x=1748254765; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZwRXyoZTBkvUmRPIKE5OHqxpzCewCZ9kB5GSZOlL6M=;
        b=nXByOON1t8PYwwu/weSkAYJPZ6+qTiHzltNGCdYV13uy3C//zI8HDmubM2UNN2LnxA
         ADrug+BjLcZsXQo9vUPgUbx5KgLrY7NtEWuGCA+m/CLhjPb/jDqNvOIzDjfbNHealHJf
         Ub1+LZAXi7IVZ6nEuV4JO/vozMEjldOdwykxp5Hik+0kr1P77y0yf/i7Oj4MjuVx5EA1
         xXzz+b0SsTWnjyRaoRj3bL6UbsQwZyxKDyfcO7Sssp8iigXbqlJzcdmb2EtiBqgIv3Jz
         qmDNk6GCyuQDzfa72fJVQhOuxfYxDEQHSqHiMZjdvdy4TpPNFeaR+Qkq3cv2VxjwB5N+
         dBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649965; x=1748254765;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZwRXyoZTBkvUmRPIKE5OHqxpzCewCZ9kB5GSZOlL6M=;
        b=U792jrLmkeS7n/CyO6Cid6N6wlCcjvijLSR7urLygHPihpBKme8+AVtzOmzdg/ejVZ
         r4xZg9ANnnFUKIXEEw2UXtNzHWeQP44WfcxO6i+cuXuVp72k41+mRiOAgjdT3iL1LBCH
         4nzLhA159s8jgDhwRbHENir9QTB6YDPewhSi5IOxa6VkjDue7UsvloJ0m40VmEil31Kn
         xzEGDgS2zMIVCAzbtblvHyrEC0Ki/tiybhbjcf3Q+uk2QXOkFWHkZzddPzU3/pv47Nxa
         5r3U9PxD67GCYFl0VUHKZEyHCyVpufDv9K+nvBHTO6qj1PB0uW6AU7wK3/Zs4yD/qhWC
         r90Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKjNeXR7A1YGWwPQfbwI14aXHbGs3IvVdv0U6sRCWWXqvbUcU27SPj+60ZyoUvZqEsr/8IiI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbUt8VFCAVQEcqgZDu1BPfvAOD+jx/7frR0cJzfpUh1E/1qA0
	zEY1+xhrFHHc7avl7vRWtgC3KxvLHHq7j20li8CvDzglGX8wmfL4jDSD
X-Gm-Gg: ASbGncvbPCeymY4zJ/knA1c1uMY7RIkgwdBHkrqS1nn7DinKqHWEOIJtGFLgyhtMh8f
	RtZXkGk6MTXmHwkRj5iytJ7Hl+GEAUATicDvG+0oW4wWr2gX27s0O+B3FahTYZ1k4mk5Ebl47VY
	B6HLsWAPcHWaaUJPOLmOVzpVcnRZ3t+rBUJbBw6Mox38Lazh4eytMSl3kcrkG89k5rmjEkNINcY
	KyxDWBicX1HuQQeBK1jmpIHeXxkDnkGtCg5bO9H8zB+ZDMgG6PHwMyEr1M2XQTHxTULEoG09R+C
	4zK5z4VYiukJdnPHXpxUxRTPVIcUSDmJu8P+GMvyIAxFUB0jXticnAiSfGgtso/s
X-Google-Smtp-Source: AGHT+IGB7hpDB5GUv5m1FY69tFioaKjOiG/eFrFPzAcr7OS14QAfYwCXuKNYct1/KISy8Uioyzkl8w==
X-Received: by 2002:a05:600c:a00b:b0:441:d437:ed19 with SMTP id 5b1f17b1804b1-442fd625914mr111177335e9.11.1747649964758;
        Mon, 19 May 2025 03:19:24 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50b983sm131231405e9.11.2025.05.19.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:24 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 02/11] netlink: specs: tc: use tc-gact instead
 of tc-gen as struct name
In-Reply-To: <20250517001318.285800-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:09 -0700")
Date: Sun, 18 May 2025 14:35:38 +0100
Message-ID: <m25xhykpn9.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> There is a define in the uAPI header called tc_gen which expands
> to the "generic" TC action fields. This helps other actions include
> the base fields without having to deal with nested structs.
>
> A couple of actions (sample, gact) do not define extra fields,
> so the spec used a common tc-gen struct for both of them.
> Unfortunately this struct does not exist in C. Let's use gact's
> (generic act's) struct for basic actions.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

