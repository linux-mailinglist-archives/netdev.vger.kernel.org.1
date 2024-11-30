Return-Path: <netdev+bounces-147949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F09DF3C4
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 00:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419D8B212CF
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AAA1AB51E;
	Sat, 30 Nov 2024 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="lq6Fg0Am"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E4192D6E
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733007816; cv=none; b=nOiwTpq5REC3hfulA2vrzyvNd4Qj4W/FTFsX7UxkSl1xzIvihUXyZAJKAgEI/yoNbKL82yUyd+kK9A83Q8k4FLI2k0HXjgk+v2M99BV9nRt2FE1sKQv94+heTTBP/vz3LD7KZVJmwJmRsdkzTsZH4Ll8tp8uQuA1vbQita9SMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733007816; c=relaxed/simple;
	bh=Oj23kvXML5YxbzImIPjLr7bu4A1f9m4DYN95To+LWn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eez+xYfYUpOIfDlpJm38m5/Lxumds87wNXPmjwbfoc3MMFiQxIXbvO3TNgM4Pmpms6JsbaEF4vvdS1Nud2q6/yE66gzdswMWnXupYR46Qpg6msA7bBs6BSw9Ug3pta+MiBK/ebiuC+g6uw1d8OxKf7V0XE49UR+PKr8dTIAw1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=lq6Fg0Am; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3983426f80so1814585276.1
        for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 15:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733007814; x=1733612614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+lZDk59n4UHv5yZ4bNmxMnAKZtUzjiM3soOA0zJRIR8=;
        b=lq6Fg0AmWbnv+5LSzi3KTFh3YXayo9bVjWEHegEzKD1fG4lRyPrktXM0BJ5EBwwrDi
         x11i/bcgfKN9gtiehuyNFu4aW/2EIZtjSM7DdP6Sqq/ePAuPqEUJNYAgL2u70ynu9ODH
         5CSz4iNHck3I8W+aQIeQ6+2PufnhycaH4xWxeQfUCLVlqt1uQ1JK0zizTHUqv4lO3RRF
         Qtfz1EfapPUrA2/VYIilB+3jDzSPO1Bq2kFLciSsnDQwLx9gXuMFP5+ifGsLGwQnA+vH
         8Cwj6X4mzQyOc2S7Jl3/XeW9xwLpzhP7d/t6cvZJP22pzRZUFqYFDNt8ExlMuAiWVD3D
         x0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733007814; x=1733612614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lZDk59n4UHv5yZ4bNmxMnAKZtUzjiM3soOA0zJRIR8=;
        b=qxzfDS7fe4+OFQqPgpY+agjZoWZrZ8aXnjA0vKIHrPK6KtHzyuy9uaXo/T8jB/uJAx
         L8pPP62uZ/PFU01+irWhvZahkwEHZuHiPP5yINuJMCdYehG1KdsAi4nAJwmG8DD6a/01
         bxVlnc7DFskJTSlEArOLWGuBkS668/IG6rgp2Mfq4mvZIC3iZV5aQHsump5BZzE1SSYJ
         UtSdR/lImxSLe0mOCrJlSNHdnsFkA0wBepzDJ3hXFi+bUjIiYn5ClzxIAqal8L6cQJIQ
         c2eJkbrX4plHhcCvWifRfkxh+e2TEshER5T2PuCL5/zOt+Xmt+0aW4AZ0NX6D/dAVC6P
         TDHA==
X-Forwarded-Encrypted: i=1; AJvYcCWECoOI8TALT+nxxsaOKKmO8ZpLD6chKlVHwE4i7qlCzRi+wMyYNeF4eYEQZ6NZmtC7wLLVRm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAxuD6jz+qWurT8Xj7MAOV1HQ9RBD8DKXM2pWPJC7HjhSeMjY
	QMrVZhw73T0aCHbOAEORIybqQGNQ01pkSerEvXyQB2qlDwdwzsvhol6utEDynuhXVbRQ23PhVJE
	W0HRLu8h5YsCIevxwbRl7dbzQbMLP5F+ItjnBkw==
X-Gm-Gg: ASbGncvUouFfjYhXLxsa3w81YQKuBz1lhcJyeWZWnSK8JW3VL6sPnLVzK7555NEj1bY
	2aWPNJOXeTJEW90rGfRuSCYYiC6vmNg8=
X-Google-Smtp-Source: AGHT+IH81R4XFg2CPj0gwX0HCIBF9TK4lO6eQU9i9Eh6UvUy1XLoSg/49272JtHDhspwSlHmAL7DhLTLqjgun/Hp2yM=
X-Received: by 2002:a05:6902:1549:b0:e38:c692:14a4 with SMTP id
 3f1490d57ef6-e395b93b17dmr15727852276.36.1733007813990; Sat, 30 Nov 2024
 15:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <20241130160815.4n5hnr44v6ea3m44@skbuf>
In-Reply-To: <20241130160815.4n5hnr44v6ea3m44@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Sat, 30 Nov 2024 15:03:23 -0800
Message-ID: <CAA8ajJ=Grm47nKZ+Yp-TEXAFfyoDOkJ9Kbc+NnUOx6ehg0o=vg@mail.gmail.com>
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

 Thanks for the review.

> I was also going to plan asking Andy what is his plan on making
> switchdev digest this.

Since switchdev switches don't seem to support this, I wasn't planning on
making switchdev digest this. I was thinking that it should just
be disabled for those hardware switches.


>The switch ASICs I'm most familiar with can learn
> on inner VID or outer VID, but not both.

I don't know of a switch ASIC that supports this.

Is that a problem? I thought that it would be OK to add features to
a software bridge that don't exist in any hardware bridge.

I've tried to see if anyone else was facing this same problem.
All I found were concerns about the fact that the provider bridge
needed to learn all the customer's MACs.  As a result, it looks
like 802.1Qay was created.

It seems that 802.1Qay is primarily addressing a concern about TCAM
limitations, and decoupling the provider and customer networks.
I think it's possible that 802.1Qay has inadvertently
fixed this issue for provider backbone bridges. But for my use case,
I'm not concerned about TCAM usage. I just want isolation between
the inner vlans.

