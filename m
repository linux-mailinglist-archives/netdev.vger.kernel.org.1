Return-Path: <netdev+bounces-150389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8C99EA142
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08B71606D5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A9A1547E9;
	Mon,  9 Dec 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YMTcBcvw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409415252D
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779853; cv=none; b=OYeUs9ioKPT+B6PCqBHKFXNKT0UrSb1q4yYslQ9TDqhdDle4mEnir4BLxwfxBNQrV+ruVSzM+nV0TI8YLUULbqGtLTIygIh/0CdnoqRpHGhg1flkEBL8hlp2FFkbmgT1l7ppFoqW87m70cJJYWtDijRgGuRUBiBcP9zRq/6krSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779853; c=relaxed/simple;
	bh=WiJKMTsPf6wLrDfDk0ktMGtROs4LgWJkSuu0oAaTiuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsIKTgB2+tGhbob1ZQeiXgPp+45jNQ98uiFJj1SMFnZqnrEikDjtTthh04SnDYK4OkQnosA1iEAkIpT3lZkCfg1Gz24/UYbcts7qeq2QOPRLgSkj+TfHv3cWivVGuNfCSTqZtJ3sPol3roaD8OzfrgNkCiSk/8zjqOcT1wWLg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YMTcBcvw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725dc290c00so1479318b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 13:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733779851; x=1734384651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq4bE8ynK46fAtG2+WFAUVPbfKrAMZJysC5gDFoJ5yQ=;
        b=YMTcBcvw7kNuQXnFYN7cvvlc222ZV0BSFO94DlT/SFxiw6vnfdrxbyCmP5AJqlNnGp
         6V20My2YUfMUlwE5ZP+708lekJ3y8HhNGKShdga+YoXPMKAIJrrdzE0VGuIVW31hK6bF
         21+gb9wumEx0WmkbkoiqGzNq5SdjNRGzCCIRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733779851; x=1734384651;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq4bE8ynK46fAtG2+WFAUVPbfKrAMZJysC5gDFoJ5yQ=;
        b=UPy9CqllzN4IiAvaU2DaKOhJJ+81rrVldzKzow65mVBktMa/aWcYdbtMe/vm+61Jn4
         5RaCqL+YDIQqWVOxn3UnHCjdbVAw0QAp0Wuerg85hoHW5+9FHZV5zxWVstb24MiedAKZ
         Bb6bTykNZn+wLtOdcnfwe7gv3fNJCrckWKNUpCr8zSbGJ1ZPvliPwAGzrNHLSvYhEXXZ
         ej4Lk1vvgbfYHCxPepn0ZpdI8bxylYWmVgZxgiXEpApHHf+1IMwprLSxX01Y1sMmmfa5
         dU5Sp33kACSw1SxNixoQhSkLLcbGAqlJ/AmINd9a8RGnkT8VlzuGc5UCMWnGB514m7yX
         NPzA==
X-Forwarded-Encrypted: i=1; AJvYcCWAs1jCir63h8jVwKwRlMC3KdQT7auzrQP1kJLt7haClq3S3UMAv+yRY0oiyHB4Bw4GdWNlXHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaK1v3h4pQUMuZMts7ktr3mTIc8lGDDOgssXiKL9iSZYtCD43g
	1OfyudqxNAZfCuBXy3wVRm0RiQyKt8ueqVm2944gJgkLSe3ar534RxTgzi3WG9U=
X-Gm-Gg: ASbGnctiwH4bHrwNl/f28utHNzv2j6xbeQZSIvGukmRz9bL+Dy/uFSOWNZ3rm3aOWDU
	/daZVEdY2/CMx2hh+RkA8DuFV3XApqgZB2Igry6dzbZ/CV0VP3YI0iusluYLnu3jPjTrCzUm29X
	Ax+y5CndknjKfUWeV6cadIQ2VsEFBZxii9vTETQpBVisJNRXxzAhrsfBNjchT7Nlovdz9cOK2gb
	qxGrewchbkDxhgHB9ZaJVnciRdO8r6s3hCu1zNo3f0fsT+Wl1wpskEWx7kinNyu0l17cA6Rs8ls
	4M3tPU1sEgNXJfKtQTGR
X-Google-Smtp-Source: AGHT+IGaQl+Th+1UK4dZouO+Jykv6AjRjKda0D3INprhZjXS4b+yz4fFGUTDReg578joqoVWuKlWFw==
X-Received: by 2002:a05:6a20:729c:b0:1db:e327:dd82 with SMTP id adf61e73a8af0-1e1b43c4e93mr1633149637.5.1733779851414;
        Mon, 09 Dec 2024 13:30:51 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4846418csm2909498a12.28.2024.12.09.13.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 13:30:50 -0800 (PST)
Date: Mon, 9 Dec 2024 13:30:48 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] tools: ynl: add main install target
Message-ID: <Z1dhiJpyoXTlw5s9@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jan Stancek <jstancek@redhat.com>, donald.hunter@gmail.com,
	kuba@kernel.org, stfomichev@gmail.com, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1733755068.git.jstancek@redhat.com>
 <59e64ba52e7fb7d15248419682433ec5a732650b.1733755068.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59e64ba52e7fb7d15248419682433ec5a732650b.1733755068.git.jstancek@redhat.com>

On Mon, Dec 09, 2024 at 03:47:17PM +0100, Jan Stancek wrote:
> This will install C library, specs, rsts and pyynl. The initial
> structure is:
> 
> 	$ mkdir /tmp/myroot
> 	$ make DESTDIR=/tmp/myroot install
> 
> 	/usr
> 	/usr/lib64
> 	/usr/lib64/libynl.a

This is super useful thanks for doing this work. I could be missing
something, but it looks like the install target does not install the
generated C headers that user code can include at build time.

Am I reading that right? Is that intentional? I was thinking that it
would be really useful to have the headers installed, too.

> 	/usr/lib/python3.XX/site-packages/pyynl/*
> 	/usr/lib/python3.XX/site-packages/pyynl-0.0.1.dist-info/*
> 	/usr/bin
> 	/usr/bin/ynl
> 	/usr/bin/ynl-ethtool
> 	/usr/bin/ynl-gen-c
> 	/usr/bin/ynl-gen-rst
> 	/usr/share
> 	/usr/share/doc
> 	/usr/share/doc/ynl
> 	/usr/share/doc/ynl/*.rst
> 	/usr/share/ynl
> 	/usr/share/ynl/genetlink-c.yaml
> 	/usr/share/ynl/genetlink-legacy.yaml
> 	/usr/share/ynl/genetlink.yaml
> 	/usr/share/ynl/netlink-raw.yaml
> 	/usr/share/ynl/specs
> 	/usr/share/ynl/specs/devlink.yaml
> 	/usr/share/ynl/specs/dpll.yaml
> 	/usr/share/ynl/specs/ethtool.yaml
> 	/usr/share/ynl/specs/fou.yaml
> 	/usr/share/ynl/specs/handshake.yaml
> 	/usr/share/ynl/specs/mptcp_pm.yaml
> 	/usr/share/ynl/specs/netdev.yaml
> 	/usr/share/ynl/specs/net_shaper.yaml
> 	/usr/share/ynl/specs/nfsd.yaml
> 	/usr/share/ynl/specs/nftables.yaml
> 	/usr/share/ynl/specs/nlctrl.yaml
> 	/usr/share/ynl/specs/ovs_datapath.yaml
> 	/usr/share/ynl/specs/ovs_flow.yaml
> 	/usr/share/ynl/specs/ovs_vport.yaml
> 	/usr/share/ynl/specs/rt_addr.yaml
> 	/usr/share/ynl/specs/rt_link.yaml
> 	/usr/share/ynl/specs/rt_neigh.yaml
> 	/usr/share/ynl/specs/rt_route.yaml
> 	/usr/share/ynl/specs/rt_rule.yaml
> 	/usr/share/ynl/specs/tcp_metrics.yaml
> 	/usr/share/ynl/specs/tc.yaml
> 	/usr/share/ynl/specs/team.yaml
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

[...]

