Return-Path: <netdev+bounces-75799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117DB86B381
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E308B28A6B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287B15CD55;
	Wed, 28 Feb 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bioa0AJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC115B990
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135011; cv=none; b=PObS7ATxWUlds+Q02oK+iaicHmx/Rxk1DItDSkpsL43Zd6X+GQ7Lqz6kG63DkyEsgC3IkZfrZxtOI0rPe8AgVgZY+oJ5QX3AQPzxq6oy3M/CApsd6G50cvasbv5SLbAZXUm7jrzHFOo3ERvk4uE2t0K717AacLW1IXvYnbBNCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135011; c=relaxed/simple;
	bh=yvohejmN6XM3X6H8sG6UQlBEcYoW/hyrUsMHzhgBzWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+RAGoTeo19+sV2Sbt9p/i9YSwUfsrGIzeD9MrEmRdQ7+EciNaZRFwJGWPtVVfZBdHMn8avaFh3uTRCdndeB0FSRtL4pzo7MSlpW2pad7cs2C8FAogIidFYjNMp+2sIpbo4WeYSHCKxWodbjkI7Mkn7qOICwhFPLiv3lzR/Hobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bioa0AJG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512be9194b7so5890025e87.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709135007; x=1709739807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvohejmN6XM3X6H8sG6UQlBEcYoW/hyrUsMHzhgBzWQ=;
        b=bioa0AJGjH0cAZyx2Hcpem9yR4KPxcLq+ISbM1pxYE79T0CWzICViAn5u2jaRh5lAM
         DajhPFeV4R1yOa28WW6E7qgyxL7N3r17GIonS8mYiYiFwNcW3I6ORJHaFNQ266CrkA8k
         AlJFhlAFcOPXCZZLdUd/2jJX/4nb9ZPPKfp8f21IVbQGntROOgZCafZhTc0bvuaHaloL
         EEPNhcBFHP+Iq9oNHorup0cVK8K5YupsegzVeDXBV3mlPKcqekfIWaC/YVl+q6PeoeH3
         dAR5iY6+sCtWq853lezyVYod4xkIJUzLEiPpXhIv/Vxcqm8uRoFFbpd/SVdqp+lrPA/D
         8OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135007; x=1709739807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvohejmN6XM3X6H8sG6UQlBEcYoW/hyrUsMHzhgBzWQ=;
        b=JRZ1//I+nEM3UKBWbgLafnX9XER+tC5xjm4+TWpDqHq9+KpAtKXRsHsrBpv2FhU5yE
         s0jOg1K6+GBdIJOtc6XSFJVRW1h71421+xbemZvnAr4DVPRo850uIYVnp8px3NmMNbYy
         ozj8T1MU8fS6O7dlTubSilvnDzW79Jj03NdsGbhK+Y/kkoMpjhfNIQ6SvxLB06wOxQcO
         ZlPkUen1TMBLfL3foSnzp+FbgTWn+khJBwUTjn7axRHoNMVfiDZp8zx5p3a5k2/hX7y6
         RmrTHoZDxiyRZi6qbUPz0i0wi16MjxKpZ6WVthfUXjhuapCPJmMnMqC4N3QVViKXxBnq
         BOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOY5rX6mumAN92C5/sFYz1zhOxz/6ZtCHp2Nn+R2jLZs/K+4u3zTMEb0GOqdbqlPg1YGOHDeQNFJkjUsAqnAQm8NW5IBQj
X-Gm-Message-State: AOJu0YyShNvqFyMUcFtglm4qHB09GkVuXP2x44bqtqAKrj6dzzU3Syvn
	sVGStTMtfUFzUyekSeAZYYdymYvlmgChmzKTDBq7m1iKSz8oo/GMYhOX+5292pk=
X-Google-Smtp-Source: AGHT+IHlyFN4PQiCKyj3XpTBh4GMnAKVvTIaow+duOgknVcTt+1tsIlTRgTt5SmzLwpzBhh2ogpG/Q==
X-Received: by 2002:a19:5214:0:b0:512:e4f4:b562 with SMTP id m20-20020a195214000000b00512e4f4b562mr56550lfb.31.1709135007261;
        Wed, 28 Feb 2024 07:43:27 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b0041273fc463csm2500472wmq.17.2024.02.28.07.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:43:26 -0800 (PST)
Date: Wed, 28 Feb 2024 16:43:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] Simplify net_dbg_ratelimited() dummy
Message-ID: <Zd9Um1LHjQ6NXVlP@nanopsycho>
References: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>

Wed, Feb 28, 2024 at 03:05:29PM CET, geert+renesas@glider.be wrote:
>There is no need to wrap calls to the no_printk() helper inside an
>always-false check, as no_printk() already does that internally.
>
>Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

