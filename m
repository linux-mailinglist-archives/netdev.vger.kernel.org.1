Return-Path: <netdev+bounces-104934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E1590F359
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF9A2812D8
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EAB152191;
	Wed, 19 Jun 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1/JBABU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6015217F;
	Wed, 19 Jun 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812101; cv=none; b=b4aROvivEECbmx5MjeMikAy8MJjKtONHb1NON2P6r0U2Nb9cy56VYS9gvRWdmdSkjtasf3KqN9Eg0jqLwAeEwOQK+VPBegiQbxavhGqzib9aku+vaSujoOw16d75/tA3ZxvRjZD+wi9H1mofzzcarQzLJgKi+r7lhligS4D+7Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812101; c=relaxed/simple;
	bh=vhVm38CzOBi+DX3W3wH6ZhDs2k64WMxiCq0L2JgX9Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRRGvg1UnBDUDBAT0MneOuldB0N2tQCd7gCNqv8G9RQIWR+/pB1tPqg3YzaksaHsv03lid6sspK4wpF9vlQljqwlzFbi+WwSLzjZz2aTbW2qiZcGYRGe7Jen/9KO7+g2s6TVEuCgOYf4U+yd/eD/R5Xqjq/nqxBo3Yzkfo0ssaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1/JBABU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so587523a12.2;
        Wed, 19 Jun 2024 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718812098; x=1719416898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tn/b6EdxYYRJZewNjy8slWIqagVWtOTM9OXoa4qPUbk=;
        b=I1/JBABUx0pYb4Bwx4iBxK8+GRY8kDE8Xo26EBqh54p3FXj5yrbbzXvsNgkqx7inZo
         7cnqtqcg0dxI7Ze/2IT2EQaxaQMypaILGd1Dv+cgQUsVmlO6Y7j2D3ZEnj6DAMEIICaf
         HmxFRnLHo6vuaoWPAJNnPlviv6edCD39rE0Q3aJOLmGbl1BWIPdiUxpO5cj78wXNncge
         l4d/ySnDUhmCXQeTb/ji0HzQn7YxxjMv1hzHEbB4MrrxLwmMQ7kdG1jeOjMadIgppcRp
         t9/k00oQ/8L4NF/3pb204TRt9yaBZx9zkabEKZ2LcImIMWuVkYmx8p/KqAvoTN/swmOa
         glbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812098; x=1719416898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn/b6EdxYYRJZewNjy8slWIqagVWtOTM9OXoa4qPUbk=;
        b=xOjYP1SlTC4edkeyCKtGFjd3flkOAqCWoz1WLPcdsnL5TdaU09fDIJrZHEix33rXij
         y73u1BV6OciCeiCvo6+WTA3jSJntxWAYdGBLKe81MRXLxckETbrxk5VYT3DSmu2cqeCQ
         r/aeiA2ARB3U4oJ0M2C2lXYUcuI/Jgled3E+ehcWq+Jx6KqxZbM3rs/MWINS/bgzILPp
         2C4YL0RcrdlPjmvF+to4XkBSzpuIpbNJWlkl44liVeo4Ll38LBmFBJb0RrwK4t+U97Hy
         Gdjw3yL8dVz9zw3PEOFhTAYmiLuFKlkQrLCvYjFu/jzSr7WCdQOrJURHTX1ZnZiJ+oUy
         ocww==
X-Forwarded-Encrypted: i=1; AJvYcCVOorsvzoAXzu9gPb7ZCjxtwGx3U2q5TrT1JfcjSGmZU7/tenvmZvbiSGeQVOIwhR9yt4MjMM0AukiQF7cUjC94AilZCibI4PQ7IFEKmFcsYeSilJilB7R8NC/uYTtDWkRo6qU6
X-Gm-Message-State: AOJu0YwmF3CXY4sfy5fo2bm7aKfFeCl/xvPeSzQ/xqoPxG+GWljulO82
	jjOXREBtzn5V7LBV7BNQjfiptt64jMjcKlwekoadhIibFJK+f8w7
X-Google-Smtp-Source: AGHT+IFd/+xrrtas/Y+fjfeXQNEgrD4Gr0sIfeTJaOtOkcoRiWs+EhLvawFoYXaF2hHg8qkEOBdoiA==
X-Received: by 2002:a17:907:8025:b0:a6f:147f:7d06 with SMTP id a640c23a62f3a-a6fab7de093mr126716366b.77.1718812097563;
        Wed, 19 Jun 2024 08:48:17 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3fb9sm675978066b.30.2024.06.19.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:48:17 -0700 (PDT)
Date: Wed, 19 Jun 2024 18:48:14 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240619154814.dvjcry7ahvtznfxb@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
 <20240619134248.1228443-1-lukma@denx.de>
 <20240619144243.cp6ceembrxs27tfc@skbuf>
 <20240619171057.766c657b@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619171057.766c657b@wsk>

On Wed, Jun 19, 2024 at 05:10:57PM +0200, Lukasz Majewski wrote:
> > How do you know you are rejecting the offloading of the interlink
> > port, and not of one of the ring ports?
> 
> It seems like iproute2 is providing the correct ordering (and assures
> that lan3/port2 is called as a third one - please see below).

This is not iproute2 providing the correct ordering, but rather
hsr_dev_finalize() in the kernel calling hsr_add_port() in a certain
order that matches what is expected in ksz9477.

Granted, this isn't an actual functional problem, but given that you
are fixing a newly developed feature for net-next, and that this is API
that gets progressively harder to change as more devices implement
offloads, I would expect a more obvious signaling mechanism to exist
for this, and now seems a good time to do it, rather than opting for the
most minimal fix.

One way to make the restriction more elegantly obvious (both to the user
and to the kernel developer) that it is about interlink ports rather
than the number of ports in general is to carry the port type in a
structure similar to struct netdev_lag_upper_info.

You would have to make hsr_portdev_setup() call something else rather
than netdev_upper_dev_link(), because that eats the "void *upper_info"
argument when calling __netdev_upper_dev_link(). Possibly create a new
netdev_upper_dev_link_info() ("link upper dev with extra info")
function, which only HSR calls with a new info structure. Then, the DSA
core has access to that and implicitly to the port type, and from there
on, you can apply the proper restriction.

