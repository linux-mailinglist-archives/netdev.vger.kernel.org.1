Return-Path: <netdev+bounces-158290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0CA11546
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAE93A17BA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EABC215047;
	Tue, 14 Jan 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nJAS5ELj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FAE20CCF5
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896859; cv=none; b=RYiJcZoCzoKuF5HiiSLRC34DQwq+bE59niTqNxijb23S2l694NYOCwNiJYsCWDb91aPg86VLTKdKsEz1fRGHO8sGmZEh/buC34KTHsWBIe1pjjODwjXfzR8De8+HjTFf1dz/ldK9atUn5M/S/mYTdHK+N+ta+3e1/dfgFGuraLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896859; c=relaxed/simple;
	bh=qtK4CJk349VoSgMwI3r+OyttjxK6DWVRzUhN/eYook0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmvPi7lhpB33fPUg6i/4Io8u48e+t3Pt2tgIYPEJaWruX4fAUm2aWno/jI2VT5KCzHX1v73hV7KmX2AdUFgQU4m1mCrdD4rpuGd2QiqLiP7AfMfXQCHpa6CSI35DyMnt60YYeR7yfflTs27s5W201bTFOqQBV1Q/SKCpmj7IO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nJAS5ELj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163b0c09afso111809105ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 15:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736896857; x=1737501657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgI8FRT3jiktssovW/bQndfqo1FHtSCBdNpIPW62nJ0=;
        b=nJAS5ELjHODVOkipNbBtG7y0kuFm1pKDnLLwy1VUFopVyVq6oCBWZKBtYAab0mczL9
         8Zf9hSiWJWSaQ7FopLFygWHQfzOt5Z9PuN9ACLaSok0a4DWiKJLU/xWdI3awmxDtvEeY
         uSBED21pPROo9cKEq6weqG4DQ2d8A95DIywgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896857; x=1737501657;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgI8FRT3jiktssovW/bQndfqo1FHtSCBdNpIPW62nJ0=;
        b=ioh7aq2HHPPjEDEQzYErjBFOdtpEh/ci0LE9O6G8259jpvT2QAOUmZq+XClV+A8fIF
         lMLPWko5iWbIY8ZvmUMOeKHHrJ9JLHHMDlZuLQFZyF6Tu/6661ar3qwP/KLuBACrI25V
         SsGBFtkHo9ngH2DnM9bawevQMMGca4zGjhOA6H7b+L3s2TEDmVRZeNj5cYhWAsxonRmB
         Y2incJbH0aViONCsXYAqz/6yCEfNTCIxzDP4cSs9XDhhfzQh+akGpao6ELK8CB0pmjve
         3eXjjW5e9GCR7MEGfS1Rs5drjf7zuXC9/5sw8LtYw1AnFMf1VPp0O3jUJ/Se3vZu8+R5
         PASw==
X-Forwarded-Encrypted: i=1; AJvYcCUN1G0NeN8r2jes+AzENyv5DjSVwM35/g5rCpO05m0ljaujvi/p9evNPvSX5GTaz8PwrC20ElY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2GjeUO2zdjoqdVIxnn6o5J2zhv3XOVsB0RLmjoDFepQCv+UT
	ATxZxCRItXtREgl5aETOL00OHzWxC0Htq6GQXU6uNyimZIY2RAcPB//YoJij22I=
X-Gm-Gg: ASbGncsJHYdFRThcJeELlCkxYDCkpMpDH6oAtDmUtth8AHAvzahln9QlsPlyWfg9hqM
	JD9LsHv1xIG9DjyC+52Otiv+en3bbfrdQGlktMlj1UUinn5GP3yFSUJygntHWo0sXdG9Q/mygJ0
	90WJv8JSFNEI96yNK/iGiKhJkgsWXpo2XnQrTzuFLMf+R1ochO9orVNnSf3DpskqfVyx8YUHU4K
	UB6O5cKCAnPJ6NVX+g0rWB0IZLPK/Orrjwu5py2AqW9zLp5pEfiJb9BqWyz+086Vf5qHypdm1YM
	IIruTOGpwjP27bjeh+YE634=
X-Google-Smtp-Source: AGHT+IEFIxfp66s0G56NRv30gfthy7I+IdrLmX8hA7Mxe2tTj6oDTSzJunFZCVk+56vka+ZQ3aF1pw==
X-Received: by 2002:a17:903:22cb:b0:21a:7cbe:3a9a with SMTP id d9443c01a7336-21a83f4bcd6mr424066215ad.14.1736896857015;
        Tue, 14 Jan 2025 15:20:57 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22f306sm72278285ad.194.2025.01.14.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:20:56 -0800 (PST)
Date: Tue, 14 Jan 2025 15:20:54 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 10/11] net: protect NAPI config fields with
 netdev_lock()
Message-ID: <Z4bxVg2c1tlXd5CV@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250114035118.110297-1-kuba@kernel.org>
 <20250114035118.110297-11-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114035118.110297-11-kuba@kernel.org>

On Mon, Jan 13, 2025 at 07:51:16PM -0800, Jakub Kicinski wrote:
> Protect the following members of netdev and napi by netdev_lock:
>  - defer_hard_irqs,
>  - gro_flush_timeout,
>  - irq_suspend_timeout.
> 
> The first two are written via sysfs (which this patch switches
> to new lock), and netdev genl which holds both netdev and rtnl locks.
> 
> irq_suspend_timeout is only written by netdev genl.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/netdevice.h | 7 ++++---
>  net/core/net-sysfs.c      | 5 +++--
>  2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

