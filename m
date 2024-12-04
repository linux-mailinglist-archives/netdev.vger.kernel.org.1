Return-Path: <netdev+bounces-148892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE79E3593
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF32116027D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD54195B37;
	Wed,  4 Dec 2024 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="ytvZW3X3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540818C03B
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301457; cv=none; b=QoZJ7gtJ72LOkEgtugGVJJ4lUxgO4KdBVjxn+aUB5HqG0U9RdEi86OK4GB6tR85luXoFBenKGRcVJY+pQcdhdS+qjP3ImQg2lpEcNyE2fd6+sC+Y2MhQa1uaXLn46C17l1slYqNJUsYFDiszy7pJ1QC6R5dQSv2prI4shNP4wC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301457; c=relaxed/simple;
	bh=EoVke9SqFUpCaQKo+qnhyQ0iycqkcohJkC/+ji9nimc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeEoX1ffp370en+n4BZ/QB8G7J29UrxMHx02wrUtD8UqnmGvTSXLCjsnEmJi8QogGWlvpFpZZQEur/CcQHWTURw/AgcMEzGN6m9ZfoMgmJj6JAjHeaISlzyzXvM9ogJFfoAvCUw1j63Qc1g2lIeRFSGea8lP+LcOcmu1JDLjC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=ytvZW3X3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3997835700so3347577276.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 00:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733301455; x=1733906255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EoVke9SqFUpCaQKo+qnhyQ0iycqkcohJkC/+ji9nimc=;
        b=ytvZW3X3oQHrPd7ygT0R8/0HSkVFbHIAiODywwp2E5FlD7hmU5U+E/ZYl4dJYT2vr1
         T/4ESlFZbanOn+Ip/n3bBHXOhM99SUIEMQ5Y2oidmeYModjTpEH5tMjUDvPnAygNJvOp
         eBtVi2ZYiZI4TH2yK2lrqrFbhxt5kpydRTXuiXdbh9D4/LzNMCP6ebRlaH+wIfabItRz
         WFlc01suVPmv1uvj134eGowQWoesCT6ekqETucRKsEEZ2StmJXwyrMtfYuzOLAUtEWFy
         FQvTD8hzoeAlyIwiykeTjVobuvzzICfaYJw2/SDfZI/QItHWuvUggariM/43StsYaWn2
         0wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301455; x=1733906255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoVke9SqFUpCaQKo+qnhyQ0iycqkcohJkC/+ji9nimc=;
        b=sUsorNdBwb7jaDhylQZv7114tEzGf2/Fy9MmmfDXKl1AwYVKfrr+YhLcXsUdZqwPVt
         cpoYnfRI7FtvFP6LfvIcB9g3Gx/d4IQUcWIvQaA1AVNXcssQOg6iwVoVZjO+QvIduGSm
         baSzBZjpsOLeU4vsD9ehLtPdARtzkUHiC9E3yneFsUHC71mii8JpYeGiQlBytF3UKtT6
         M4b+RADxS571clOCLpx8ne6VdR9HRVCVXFZqew2wjNUSGljh5f1dHXA9JNcXDf+vlsXS
         yR6zkEF1Smy4lqYYMuSWJydW/B7i54WkCiHYT7GjIDlqoFIFOAmU/Bf6O4ccLnGIrqjD
         4qiw==
X-Forwarded-Encrypted: i=1; AJvYcCVh8r4FbLXcSsFxu0VDq8Hpcg+HbJY86EiqnUQ39xTRp22Qi10RlgtXX0HDXYUyUWFhG90biWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHS4yp1xeE1Teve0Ar/RJbXn3uoBoJWRrrddPwmRaXrl8FxYg
	7i/ld2AqmHUcEL0LUn7bx5M+FIBj2UAjES8ijzEv8zdg8PuTn33GN6qKWY/6DYrcvaI57jP24qo
	o8x7LgX6TiuUtiJbM9lnCSTAJ7MlqRYX96+8yhA==
X-Gm-Gg: ASbGnctiRjpMP74nA/Pxn0ttZPdQwsyx2TWCC2QdaqBXmZE5P3D1jE3S+P4c315WxGs
	yGDr1TMA/U+HLuolmzoXjgA/j3iKLwAA=
X-Google-Smtp-Source: AGHT+IHrKkSgA4hGlK8jn7mrWKSIy07H4RXZ4L/gvYx86xaKYNomvgbtV66jTpE9OVKxPCEslG9WFAbqVeHjvw6aGX0=
X-Received: by 2002:a05:6902:150a:b0:e39:9032:122 with SMTP id
 3f1490d57ef6-e39d4389535mr7493688276.44.1733301455300; Wed, 04 Dec 2024
 00:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
 <20241202100635.hkowskequgsrqqkf@skbuf>
In-Reply-To: <20241202100635.hkowskequgsrqqkf@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Wed, 4 Dec 2024 00:37:24 -0800
Message-ID: <CAA8ajJkPzpGRXO6tX5CkgX7DjGwR6bPyT4AXjZ0z8kXBk8Vr_g@mail.gmail.com>
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

> What stops you from changing the 802.1ad bridge port pvids to unique
> values, like 3, 4, 5... instead of 3, 3, 3, and making each other
> j != i bridge port be a non-pvid member of port i's pvid?

I'm not sure if I understand this suggestion.

I tried to draw out what you described here:
https://docs.google.com/drawings/d/1UcOpENFgr-s6p8Ypwo-l4yTvtUZFM6vSLxLiX2FOMLU

I'm not sure how host A can communicate with B with this configuration.

Consider host A transmitting towards host B. When the frame leaves
".1q bridge 3",
it will be tagged with .1q tag vid 7. When the frame leaves the .1ad bridge
heading toward ".1q bridge 2", it will be tagged again with an outer
.1ad tag vid 3.

So ".1q bridge 2" will see the frame as having an outer tag of .1ad vid 3 and
inner tag of .1q vid 7.

Is that what you are thinking, or something else?

