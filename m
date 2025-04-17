Return-Path: <netdev+bounces-183838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7D2A922F2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF5C464B79
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0AA2550C2;
	Thu, 17 Apr 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hFP13GVt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9A254B17
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908209; cv=none; b=dWmmldF7cjQ3QQ2RPtCLYPc7WVQoie9BtKiFrw+WfoVub4wP6+kjuT8W4Ss7DIyyI3LIhJGSJ+437Sl3FWL2SmGcWVM1LyJR3nhE03SHaKNtRC4afg/jNxA+239nYL162pY9Pj3TZ8CBPuiI38gDLIrEHdh2wSW0VSBcW6MeBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908209; c=relaxed/simple;
	bh=cE0SsJXubMVoO/NUjivTf4Jtt0m+Kx9DZncRgLItiJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDfHnFZ0eQnxxP6ZZ8pGLNoUNq+K82G6R3cgcynAYR/B2SPc9A+xfdZIv6HTmsLfyuxQmKn2uIP/wskLRkxQlXyt6k4ayfvGQzxpJkGF2GMTmxubbm75qOFnlhXd8L9ekXQOsCOyDhNNk0ARfbEDjO+Xr1GgxeQdvMKvZh5oyks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hFP13GVt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7369ce5d323so931408b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744908206; x=1745513006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJs3R27mGXFnUc6xsOALgXGRVDRyXs8OoUcWIG3enHk=;
        b=hFP13GVtwYn8MV8aG2khVJWT1njBW5N2uFkrWfNIV4v+CTVErrPkFiBGt6Mnnp+j1j
         f1bIW6/SyZhCQWNRNuV2paZCvpH4lwtXa2Ww3iSVipiSnrMfqmer2evE1yHz+261x9Vh
         bsQfyf5nTXFJ+whm6X1eTfJPdePEcOeHYdZsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908206; x=1745513006;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJs3R27mGXFnUc6xsOALgXGRVDRyXs8OoUcWIG3enHk=;
        b=GGaDKgVn+gjeD6AC0rZFuEN2ebQc0w+z2C/J0FeGEdzgOHYIx1qx2fMeQX7cHfIliw
         ocwOAr5ezLN2zIh5HLx1YM3PFPkQ38cT3mCyworw068w1gpX5tnU2me70agBiOW9Yd0K
         Ky0XUklOQ0p4gieL4C37J9Y3C387eQ5U1QH7ribt9PgXXuX1aS8nMZSiJHIemcoxuHFL
         +PEgsRCquf5GdtnmvCY2SBCQOXKMLllmRqcbQaIkrLO7YNxBvUR8QWXk6jpW9SdblsDy
         rNBJtvxXus4uCMgYRUDTllfgIZKdwYUf2kMB9v32P6dEpGM7d//eDJnssjFeiV8kKT4y
         xMJA==
X-Gm-Message-State: AOJu0Yw7WmWC2WKWl5lOMQ4/5+7kxBSsRntyb5n0KyV78ncV6pRt9Eub
	HjsCdgCrZbYDgcMAevK22/TlJxLkoKResne/PvNxGUg4r24XKnWekImeT6j6IeU=
X-Gm-Gg: ASbGncsMvBdZKNf+P5nT1zcOAwERnauw+IWCyHbJjGv9nf4bieS6Tpn9eRDLxB/Y/Mh
	Q+evs2ZPTGWpCvhl5awRkaWg0ZClQg/msbet+UsJ+9lC+2/QyCN8lmQImb86fYSfp84q3WDK9MX
	faaTkBjOKSClSiambRTI2m5eDgv3PYplfjFzcPUyzIbpE5RJSeEMHuORScdsBKGt7L/3yxxdUnp
	U4b+IKXNauxWZgNajnKOOoaVraoyXilDo+IFOu42Ogkw2ED2TbXqhehpSMI8Z6yQsZH84c2FUxq
	sUuJhsgrtd0hhM/3fGSK/oqOYyrTIn6zU2z9MUgDEfHGXN7/286+1N1sOx6G7i0LAKQnXgTMk2r
	BqYB2d3Na+ZS1
X-Google-Smtp-Source: AGHT+IG+XpQJVC4yi6kR32NZ5IA6ihEOayDuhg24CWyM1y1U1cd5X2UW8o/p/Y+LyClf8OSD/ROclA==
X-Received: by 2002:aa7:88d2:0:b0:735:d89c:4b9f with SMTP id d2e1a72fcca58-73c264c4cb4mr8349614b3a.0.1744908206170;
        Thu, 17 Apr 2025 09:43:26 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8bf802sm63829b3a.13.2025.04.17.09.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:43:25 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:43:23 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is
 non-zero
Message-ID: <aAEvq_oLLzboJeIB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250417013301.39228-1-jdamato@fastly.com>
 <20250417013301.39228-5-jdamato@fastly.com>
 <20250417064615.10aba96b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417064615.10aba96b@kernel.org>

On Thu, Apr 17, 2025 at 06:46:15AM -0700, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 01:32:42 +0000 Joe Damato wrote:
> > Test that the SO_INCOMING_NAPI_ID of a network file descriptor is
> > non-zero. This ensures that either the core networking stack or, in some
> > cases like netdevsim, the driver correctly sets the NAPI ID.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  .../testing/selftests/drivers/net/.gitignore  |  1 +
> >  tools/testing/selftests/drivers/net/Makefile  |  6 +-
> >  .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
> >  .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
> >  4 files changed, 113 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
> >  create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c
> > 
> > diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
> > index ec746f374e85..71bd7d651233 100644
> > --- a/tools/testing/selftests/drivers/net/.gitignore
> > +++ b/tools/testing/selftests/drivers/net/.gitignore
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  xdp_helper
> > +napi_id_helper
> 
> sort alphabetically, pls

Thanks, fixed.

> > diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
> > new file mode 100755
> > index 000000000000..aee6f90be49b
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/napi_id.py
> > @@ -0,0 +1,24 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +from lib.py import ksft_run, ksft_exit
> > +from lib.py import ksft_eq, NetDrvEpEnv
> > +from lib.py import bkg, cmd, rand_port, NetNSEnter
> > +
> > +def test_napi_id(cfg) -> None:
> > +    port = rand_port()
> > +    listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']} {port}'
> 
> you need to deploy, in case test is running with a real remote machine
> and the binary has to be copied over:
> 
> 	bin_remote = cfg.remote.deploy(cfg.test_dir / "napi_id_helper")
> 	listen_cmd = f'{bin_remote} {cfg.addr_v['4']} {port}' 

Thanks, fixed.

> > +    with bkg(listen_cmd, ksft_wait=3) as server:
> > +        with NetNSEnter('net', '/proc/self/ns/'):
> > +          cmd(f"echo a | socat - TCP:{cfg.addr_v['4']}:{port}", host=cfg.remote, shell=True)
> 
> Like Xiao Liang said, just host=cfg.remote should work.

You are both correct; sorry about the noise. I thought I tried this
last night and it was failing, but clearly I was wrong/something
else was broken.

I've fixed this locally and dropped patch 3 which is now
unnecessary.

I think the main outstanding thing is Paolo's feedback which maybe
(?) is due to a Python version difference? If you have any guidance
on how to proceed on that, I'd appreciate it [1].

My guess is that I could rewrite that line to concat the strings
instead of interpolate and it would work both on Paolo's system and
mine. Would that be the right way to go?

[1]: https://lore.kernel.org/netdev/aAEtSppgCFNd8vr4@LQ3V64L9R2/

