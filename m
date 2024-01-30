Return-Path: <netdev+bounces-67235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876F18426F0
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99771C2506B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3572BF4EE;
	Tue, 30 Jan 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X8Ecblo8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0612E5B
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625057; cv=none; b=uUIldOHxZzUVas6pDxpHELcEwsMYJ8f1usydBY4m8p/u0P9dDOu/B6lgdPmC9Vz0a2veQlRnew1AH1JIRPSCROheYZOR2SpIjZznMcGoEB5Mr/KsxUjWjqHuOszhKJ7BK5BJdc0TdEVTUYrXpfiFGP1x9DJcKrix/dzU1hDXcYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625057; c=relaxed/simple;
	bh=9JuXSW7FVow1F3Kdl1e6VyrD170a+y5aAKbooQWMwjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFuLPpRXXcVGbBA7zcPtrEutlh51BqiXoLBhRS4SXDZIpTQxb6K/DZkd7z7k14sMoA9URU0WMv6YTYwirMC+uqwZE8ccldMmuZk/lNuoKhsroUgyXFzHXSevXNT4PsimiNVxcJUwWB3a40W+c+D7OPDTDl6UyArLAQhaOwnEupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=X8Ecblo8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e80046264so49564705e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 06:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706625052; x=1707229852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9JuXSW7FVow1F3Kdl1e6VyrD170a+y5aAKbooQWMwjs=;
        b=X8Ecblo8RDgEUc35evhUBxi9kb7gDRyZ2vjLyMl+eYW8ZS71aesQ2bVpb9OMSZpNup
         lKFci2WkFyNz06vY/tEl6Cp5Ajamkje7X3NqGZmw0WFfEAA04hoqUQdPdEkuECs3MIrS
         WLaSZCvM5CqlB4+3eh34nKMbbtGTjl/+UddvQRRwzao8sA53/Q4oN8NOlfd5Gr0VJNwF
         Ox+qRp4nlsoSHnVN06xmKrPpwvuozp1PVhRPXnCZ+RbFLDgX7i4MyoaIRnC8DhguJTUy
         YY6eNOQ3jh8xsbqsVgjX1JsblmwOzmFZJ8Y935RE4wCgqYvuNPcIllDmkuX9C5wnmUFz
         RRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706625052; x=1707229852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JuXSW7FVow1F3Kdl1e6VyrD170a+y5aAKbooQWMwjs=;
        b=TlZz5tJX4nduMharhnPyg/RR4Xra6obWp2SHttu9ZYmMRalIqzP0Gl2aHF5A4CTKvE
         tMLdOH6icQIAq89KldIxkJa3HcZ2ggsDMjbld6/Ya06FrX5Cm9GiKxyXrxjpDWhCZFyr
         FuWf02EQuVJ5JsNF0HfOsp6lSc00O/AZmovuWlvXmOQH1xAN4OzrEB4iJAQQWVixxfRj
         JRN3AObOFKv69VowxlhJZBCCTQaEYjwvTNqSYdbyYnJWc8+wwiMXmQGC7gIb+dajBQlV
         rq0Y0cfEZc2MmxGjI24B/fFWeGzq85n1uzQzGVzgwUFz+Gx6ILWMmIcr+JWAp/h6DbO9
         0dOA==
X-Gm-Message-State: AOJu0Yywmi4uFFWsE1O9NxV17AgPPVwe7NdUpeqrasUJ5fFGfOsrKC1R
	tslyAGYwQR5CNLrXaaFytaRDnb9ESIghMT2h8dCRVz5PxLS893iH0LWVnQxmjoVf9mnE+mkMQK4
	h9qI=
X-Google-Smtp-Source: AGHT+IEV1W36bEkv99WLtAZxdr/nsHmeCj/uU/gH7fTxc26J7tGx8juRLjxrqd1oyhF0ySY8x6pLQQ==
X-Received: by 2002:adf:cf11:0:b0:33a:f95e:9f14 with SMTP id o17-20020adfcf11000000b0033af95e9f14mr1578640wrj.30.1706625052052;
        Tue, 30 Jan 2024 06:30:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXgNoBOMkDkON5dF5aYygsz21Qtyn2IQRZz8HHGrAm250GxX/tKhACqtOvtMDXuGb9eH7We7sj9xFDP0K/YTAWiJD1FzKatJQqvl3Oxt0ukgaw50vYUVMqBbRWO8LTAy3ye+tetbJzFQ1CnJmGS5yFby7idNaDZB/k+B/QXbacTkjf8aUHaRoFOfbyuBgH+cJE
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id by5-20020a056000098500b0033afef9bdfbsm128988wrb.8.2024.01.30.06.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 06:30:47 -0800 (PST)
Date: Tue, 30 Jan 2024 15:30:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing config
 entries
Message-ID: <ZbkIFrruZO5DXODm@nanopsycho>
References: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>

Fri, Jan 26, 2024 at 05:36:16PM CET, petrm@nvidia.com wrote:
>The config file contains a partial kernel configuration to be used by
>`virtme-configkernel --custom'. The presumption is that the config file
>contains all Kconfig options needed by the selftests from the directory.
>
>In net/forwarding/config, many are missing, which manifests as spurious
>failures when running the selftests, with messages about unknown device
>types, qdisc kinds or classifier actions. Add the missing configurations.
>
>Tested the resulting configuration using virtme-ng as follows:
>
> # vng -b -f tools/testing/selftests/net/forwarding/config
> # vng --user root
> (within the VM:)
> # make -C tools/testing/selftests TARGETS=net/forwarding run_tests

For me, all tests end up with:
SKIP: Cannot create interface. Name not specified

Do I miss some config file? If yes, can't we have some default testing
ifnames in case the config is not there?

