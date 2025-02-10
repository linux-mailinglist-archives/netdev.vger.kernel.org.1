Return-Path: <netdev+bounces-164903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3558AA2F96B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EA11882834
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D0825C6F8;
	Mon, 10 Feb 2025 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DnzRmHBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252325C6E6
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216970; cv=none; b=EAUNAT64fqLn9qnSlXYQ8nUCCnDUF8MQWRyM/ygB2PfAiS3yP/4uQv+uVsG8lf1VMJ9sqwthW5T/PeXcpeM6WGJgESRligQqF66OjS3zUROhtY5EssT151kP1VbA1mu4Fln0FVtotBJFdFGbsSlea4UpGHb1DIJbKoBkqxL7Rbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216970; c=relaxed/simple;
	bh=f+UmLSmLtSGO/3ybQPpkX2cWkUy4Dc/MC+1IyQAQvNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMgrGkpJgIibCwUE2MiP1d7Yip3ROVildCKdGPPV2ElIgg53aE9gasx8VE3+QQASB7zfOCVoccGYNJ9CfEGJXQho7Xtahb1AgncC61WQcTCfA6xzJmUGjCo0uxqO8Y/VZbxiqOQlWYebdYceVSaXuZP3t4o2vgHzHzVi1UlEo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DnzRmHBv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f5268cf50so47728275ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739216968; x=1739821768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTt2O+89+OX1qceRzkPwIzbuTN/WSFucT4iz8Aiof2Q=;
        b=DnzRmHBviHY+Pg3i9zE/TELFmyasC5ii+sEIu+yXj6DnYRnmnLDDMj88RCOuXSlpIC
         WMc5St5bRQVqHhWtqtkADyYmYs53JiFS4lyCDchBObnOwCyE+pOU5i0RIDuKocjlxF9u
         kIpGmQjpDt+JhbQTjagcNYuy9J/bDh7SCehSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216968; x=1739821768;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTt2O+89+OX1qceRzkPwIzbuTN/WSFucT4iz8Aiof2Q=;
        b=oNwW4A5J/wgM10bSiwP69GKmQYC5ZXKJ+gGDWICm0mb68SBEaPRYLYwmipnIxHEsFY
         iIdyHoqPpxglLf0abpbDemRIutM0HvX1drMt/fTXi6y7JkrHr94LEQ6GtBJhJHfYPzVw
         29Df+HVZQPmWHPP339140GOAGeb5lqhtIR0nKZ/lVwRnMTYUbb7HdhVxNuTuXXkYye8Z
         p9BVF9yJx18EvBg6U7JoIwaxa2SGB06mqbNjbtAcgpVTzpn/cvrYYKOGwqxtMtYmxK6v
         bgYrUtQPBBdOila1gQKKH/k15sYqYM45Q7kpRE0Av6q8WTlOHN8IyBFBVOxvWcU1aGEt
         dzsg==
X-Forwarded-Encrypted: i=1; AJvYcCUCEWP+VCG5mzY686XFH2t3pDAuH+t6SwAdhpO+vhahAOX+1hfTWLRZ90RKUsknYQ2sXkcO3C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHWbukV3kf7dH4JiDMckX5kJg68XQ0rzhC+qiTd9DHUJQmok5
	ghhpzPk1uQucVzMiIeFqmGuqzyTHIkmzFHQWR0YyvS7C9UzH1LI/RgKEJ+nBnTg=
X-Gm-Gg: ASbGncsVMpjPQHvMoqyAchEyaM2Zlj4u8mzRjMAHQHjyd2BhA029SJpIGtjwS+VTxtE
	4HERwsdTp7QgWF8jwT34mlzFEhE3vNHPMmbZMICCOUoami4+0L5CYcsozBsWmvXiJia+jnuvGYA
	fwNueUo6WkqXx1y/X6jf45G4jRbCI/MHk3kOyENvgpbp32kqhk8SESZ8v3uRr0RE1uUi5AgNkGH
	t7DEx9g02+1Jw4dzhTJqDbvIDf/NrNvMisHbkVVyRYO+vcI8X4G9N49msYReUV7AlGgeOx4YoH2
	tgIZcY+9V6AnI5Z+s/N6O/0bNYwexwE1UVO+AdPu/OtKsO6Sy/rQy75LLw==
X-Google-Smtp-Source: AGHT+IHMJTHT8nKASCoftPW5WagcofTFuEZVGDHpfUu+3/RTdlhPh3dGTiFUWppYL39rlkLByj5LEQ==
X-Received: by 2002:a05:6a20:258d:b0:1e1:a6a6:848 with SMTP id adf61e73a8af0-1ee49e8ccecmr1955504637.25.1739216968391;
        Mon, 10 Feb 2025 11:49:28 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53e71fb23sm4569990a12.45.2025.02.10.11.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:49:28 -0800 (PST)
Date: Mon, 10 Feb 2025 11:49:25 -0800
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] igb: XDP/ZC follow up
Message-ID: <Z6pYRXGiVmLDMe4S@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>

On Mon, Feb 10, 2025 at 10:19:34AM +0100, Kurt Kanzenbach wrote:
> This is a follow up for the igb XDP/ZC implementation. The first two 
> patches link the IRQs and queues to NAPI instances. This is required to 
> bring back the XDP/ZC busy polling support. The last patch removes 
> undesired IRQs (injected via igb watchdog) while busy polling with 
> napi_defer_hard_irqs and gro_flush_timeout set.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Kurt Kanzenbach (3):
>       igb: Link IRQs to NAPI instances
>       igb: Link queues to NAPI instances
>       igb: Get rid of spurious interrupts
> 
>  drivers/net/ethernet/intel/igb/igb.h      |  5 ++-
>  drivers/net/ethernet/intel/igb/igb_main.c | 67 ++++++++++++++++++++++++++-----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  |  3 ++
>  3 files changed, 65 insertions(+), 10 deletions(-)
> ---
> base-commit: acdefab0dcbc3833b5a734ab80d792bb778517a0
> change-id: 20250206-igb_irq-f5a4d4deb207

Overall wanted to note that Stanislav is working on some locking
changes to remove the RTNL dependency [1].

My previous attempt at adding this API to virtio_net is on hold
until the locking stuff Stanislav is doing is done. I am not sure if
the maintainers will also ask to hold your series back, as well.

[1]: https://lore.kernel.org/netdev/20250204230057.1270362-1-sdf@fomichev.me/

