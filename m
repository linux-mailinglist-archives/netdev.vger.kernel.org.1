Return-Path: <netdev+bounces-246826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76511CF183F
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 01:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42269302F689
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 00:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638C61A256B;
	Mon,  5 Jan 2026 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfOPCdJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161E19CD1D
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572979; cv=none; b=aj+MN4ArtTkjUN4maRr/4c1x5PQwyFU7wk5yczfgjEuqwwaHqxHqTVYv0oPHJ1dni9J+faIPoHbl8d7mVPI90/Xm64U6yE0emuXDcgZ0vZuYr3FQAhp28DTxBbmZRZPNQINmr6VZsIsdze1DX0brPgTklrsqPcAH4RPCUcqVTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572979; c=relaxed/simple;
	bh=R7k14VC3vVWz5wUwTkk93NrVOWEgkpo5zchT4ujK+c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxFJfZJDU13UHuPJzz+phfdH+45PaxkIeFmi+Rc09udMndQkRaGiorCeYePyLAxh89Zu2VP6cZBCe2bXcfjgh4aBGwZUgUHoZJQN1JmdWm7LXynhJC4AVgN9ZhrmtIBoxjBoUW5Jk4+11529aizqd34ItUzo7Hex1VbMZhc1JnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfOPCdJg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso8216236a12.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 16:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572977; x=1768177777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uO23YZhHNP6Na8oKr9lYMioRYmvDQ+E4qMSAXH4O1T4=;
        b=kfOPCdJgdjwRZ2sm/cLo+9rzdZQKGq0EtAfZ4j51CSoNDUhT+vg9QHlzfIYg7BXh5h
         Kknm1Ge360FVsE9ybdxovMZ5V6iN8dqSYJ+pMD2Vvc9ZQVJkCUy59GpeYVFrB+oh2L/E
         PmFQAg68rReXvYIWLbrfXl0MyllKYgRUnsmubAdLgS5hvd6bqHijhBKBDioDXaED9rPY
         t/tRKF77bJz66GY0QF136vRDAABPIzYpVU8T0uYe8JleDc/kCE9pW5JaMkzblHhvOwb0
         lLFOp6w5qdX8Fcs85SQPw9ZlwGnDoK6oDZt6cAD6LbrzdmPbld1OQTpJcp3R4nUBVykI
         07jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572977; x=1768177777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO23YZhHNP6Na8oKr9lYMioRYmvDQ+E4qMSAXH4O1T4=;
        b=rnH9KVlhK9Kd0xssP+JN6/wMgziwI4IR2piVDtEXFi0JId22i8cQWvfTqXYSWJVvKP
         rn6t/g0edRp6/KlnEdpRjG4dDqgd8ejhObaQy9bf2Q4aIty5v4Hhyg6t53DMMwC2bIf3
         0YvMv+LNFm2c+nGeoeUZE/Ckumc7uyx8NpXAPRCnyOpUtcUB+yGdGsQCz6DK906hLjU3
         74KWwgb8JMH0HcKy/3StlB/CVkwycP0jOh7Y8R69zWKuPFwnRKmJzpGOxEHzbhmyUreg
         odv8uu7ZfbZqcsMRNQWkbRqfols3psDH119V+lEuOEx1NdpZh2UD68ItlqHmcCumPcSV
         j00w==
X-Gm-Message-State: AOJu0YzKDGE5GR4DveRBMVm3o4Q20gKJ7rrFdvnaIz6wrlc3atP8C0f1
	VoLSuc/VvXSxHiIe7Vd3FHFt+gdRisO+sETudcxtQ/+ZXHoNWcYNg3mr
X-Gm-Gg: AY/fxX7WIhUw72WgoQRqAm3s5gwpOGkzCE9wEDznrd1HmAx1vSddCrdgiGMluRni03q
	uOH/aWQ7qoXpXJP2P0MBZhsC3R1PO6s6hAoTP+EhUS64x6CgfTCNGsh5NOMQOD3kQkoRUCsQrqZ
	taq9XjgV0xQrX+VZHFbCU0x/Oa6zVx772NUTIBS0kzSyNtfvizHbK7HJ8ou+jP4PcNt2VwIMoyB
	cBDMgcPWxdpVWD0u3NzGyWkQWBSwFyUooh465JMuuGMPZtCV/I0h9VqdgK5e5mTGRQ1Fpd0K8Ji
	GHEY2n+EgIEGAcegQkl2R5YusCN0821fZxpnXxF3jgsFjDzknick2h63A2AtR1ForHLt2zysBTD
	k8IOYngA4lFGgxOtRaqnBksJImaoERnqpLafRb5lm63y5OqDIxskkeCHnwutEGAfpTfIvfLmKEr
	XsJS/Mz20HPw==
X-Google-Smtp-Source: AGHT+IEFj/onAwnN6q7XitBIyXARl7Pt43J0EpL/HG5gSDcAd1q+FPGbMbIICB6wr8OHnl12SpH5kA==
X-Received: by 2002:a05:7300:d208:b0:2a4:5005:7ee1 with SMTP id 5a478bee46e88-2b05ecabd4emr35873438eec.37.1767572976876;
        Sun, 04 Jan 2026 16:29:36 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc2:1ca0:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e7esm9441947eec.22.2026.01.04.16.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:29:36 -0800 (PST)
Date: Mon, 5 Jan 2026 00:29:29 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 5/6] netconsole: resume previously
 deactivated target
Message-ID: <aVsD1Vuckt_9Tr7E@archlinux>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
 <20260104-netcons-retrigger-v9-5-38aa643d2283@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104-netcons-retrigger-v9-5-38aa643d2283@gmail.com>

On Sun, Jan 04, 2026 at 06:41:15PM +0000, Andre Carvalho wrote:
> +static void process_resume_target(struct work_struct *work)
> +{
> +	struct netconsole_target *nt =
> +		container_of(work, struct netconsole_target, resume_wq);
> +	unsigned long flags;
> +
> +	mutex_lock(&dynamic_netconsole_mutex);

This ended up causing build failures in CI as it needs to be guarded by
ifdef for CONFIG_NETCONSOLE_DYNAMIC. Unfortunately, this was always set on my
local tests - will fix that as well.

Sorry for the noise in the CI. Will fix this in v10.

> @@ -1945,6 +2022,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
>  /* Cleanup netpoll for given target (from boot/module param) and free it */
>  static void free_param_target(struct netconsole_target *nt)
>  {
> +	cancel_work_sync(&nt->resume_wq);
>  	netpoll_cleanup(&nt->np);

Will also address the AI Review[1], which seems to indicate a potential use-after-free
when a dynamic target gets removes (and disabled) while resume_wq has some pending
work. I think this might be a true positive and I'll see if also canceling the work
on netconsole_target_release() makes sense.

[1] https://netdev-ai.bots.linux.dev/ai-review.html?id=ca5cba91-a1a6-4240-bf10-e4da9c5bc58a

-- 
Andre Carvalho

