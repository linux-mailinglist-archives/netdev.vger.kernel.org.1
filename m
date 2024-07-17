Return-Path: <netdev+bounces-111868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D8B933C78
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449ABB22808
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012417FAD5;
	Wed, 17 Jul 2024 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVGz46z0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7917FAC1
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216768; cv=none; b=taMmrICL4229AcNWabD7/4TJQGQEcfYEp3wNN7Hr9/MXdVQmw4OjqBA+kIKn8wxTjKPFHown6gC0/qf4tW+ajeyd7d+OrRKU1c7UhfE4FBa/EVcz+aj0TUF7SKq+p54IeEn2FCtfrO/Jp2l5vSXQlB5VhYlmxCLmgkV4EUzuzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216768; c=relaxed/simple;
	bh=D9W43ShdA7kOt020q52WfoV3Jf27bYkbgTogmcLVKo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xm28k5zFlF88iTM5l7pE5K8+XGdQdtX+bTqygPtkyDdzRons+h9C2mV7wnhNp5giB2aD2EELsC2qMO53FYN5rpJzwolwlZ6pTCjlqhwcefsRYLVllvFfpJ8wAKsTKaCxdWrhxbxS2wfbup8aKe1uLA9zyx5lOjemhOmXEt4qKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVGz46z0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso4094515e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721216765; x=1721821565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFVvKTpASxeYd7tAPceGPVoD80AWH1SIDp48yMBpnbE=;
        b=FVGz46z0w4heqpOxf1i/7LAbzaqmLCi84a094xKp9qblUghi4AqVzl7mnnhDnkDuDj
         a3J9lSEOCzTL4zcpPy6hGAqWyd5ZfHIo9ULRfJsUYVdrexZlvwlBz8RE++wIY61EF3Qm
         N1iE1F92XuJNRZfmk3jGeOI1w51j2fojK+sYLky8E1byNj3QO4QhFr73EDspJxTvUGNj
         E8Hk97vR0PExZgfvP7BfD+LSbthi9nI+q1dKMbfGTtH1LcLw4jugi+F27t5I0uU0BUT+
         wSUFyDNelEQuxUTUhGLvD7R7AaVXDL0YzD2kRWpdTmBBm69df8y0MZGQARmuujOIGi2r
         WIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721216765; x=1721821565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFVvKTpASxeYd7tAPceGPVoD80AWH1SIDp48yMBpnbE=;
        b=rTk7pJrHUyp6kl25Zz/kiiMn1+et0iP7WU3d+72ZG7wxRsK0TK+eCdZWMKfCNvZ+oF
         dKLijoxcWLf392DSS8g+sjagNLP7S9dBFSOPEFiWbmLdxf1Ab7xJmS8TACPeQtz2lhPa
         SLw/fsL+Q90GR4BcYgthT5spEVtqIP5LbKh7VGj22oKGCa1h5PiWCQriSSnh17JzK5k0
         3QP8Wwlvsif2GZ/tmHkGKWmZk5ZXtXJkqIBQQ+IiXh1Zo8gweDavJcqx3SeS6QuzW5WN
         9ddynk/rfS0hWwLKJXSimcyPCNRIKe5ojuF51oCpb42BzdPji79PIa8KC2T5L9m0L+g7
         H4IA==
X-Forwarded-Encrypted: i=1; AJvYcCXw3upkj8KqvVNJFcAtDEooLLYzBdLAKAdLXROB+dGb+bbklWZLI9qSPyz4+mlL660EStxFc11rBvCMROCBFkyLintttaqY
X-Gm-Message-State: AOJu0YzhtGzfu7QuQv9+yB+vt6ElMXnDcmF4sPJRoF+vCmgamO7Ntq8l
	pV27pimQp4oGbsuG26P0SQ4cUEoZ4NfnGA/BliKVTHyaIxo5ARfz
X-Google-Smtp-Source: AGHT+IG2DYe80Tm04j4CIV0OqwC5Vja+H6FYgkZfZqXWV+wlTBjJAV67mrmuQlbf9t4gFnE9RndT4Q==
X-Received: by 2002:a5d:5f4d:0:b0:366:e09c:56be with SMTP id ffacd0b85a97d-368273500b0mr4094494f8f.6.1721216763941;
        Wed, 17 Jul 2024 04:46:03 -0700 (PDT)
Received: from skbuf ([188.25.155.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbb77sm11576714f8f.72.2024.07.17.04.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 04:46:03 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:46:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Willi <martin@strongswan.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Murali Krishna Policharla <murali.policharla@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: dsa: mv88e6xxx: Limit chip-wide frame
 size config to CPU ports
Message-ID: <20240717114600.a3dprto55puhfpjg@skbuf>
References: <20240717090820.894234-1-martin@strongswan.org>
 <20240717090820.894234-2-martin@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717090820.894234-2-martin@strongswan.org>

On Wed, Jul 17, 2024 at 11:08:19AM +0200, Martin Willi wrote:
> Marvell chips not supporting per-port jumbo frame size configurations use
> a chip-wide frame size configuration. In the commit referenced with the
> Fixes tag, the setting is applied just for the last port changing its MTU.
> 
> While configuring CPU ports accounts for tagger overhead, user ports do
> not. When setting the MTU for a user port, the chip-wide setting is
> reduced to not include the tagger overhead, resulting in an potentially
> insufficient maximum frame size for the CPU port. Specifically, sending
> full-size frames from the CPU port on a MV88E6097 having a user port MTU
> of 1500 bytes results in dropped frames.
> 
> As, by design, the CPU port MTU is adjusted for any user port change,
> apply the chip-wide setting only for CPU ports.
> 
> Fixes: 1baf0fac10fb ("net: dsa: mv88e6xxx: Use chip-wide max frame size for MTU")
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Martin Willi <martin@strongswan.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

