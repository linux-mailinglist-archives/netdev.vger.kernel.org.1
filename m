Return-Path: <netdev+bounces-227729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FCBB641E
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 10:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E12519E36D8
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BFA274646;
	Fri,  3 Oct 2025 08:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115C26F2AE
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481113; cv=none; b=U4escgMnGO6E23jmHbPvjwzqLj/vwQFcdAmHX4loCRqpMqMzCVaBPzUISw6wZFwcu8BUsXTqoN8ZdHUV9GHAUX6nsEKL1CH7e06qiLG498PJv9E+FcocnoYZnm0Hza5z3rI8X7McVTDvDe8/WAd1/y57/WKYnRkoTzylff1B/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481113; c=relaxed/simple;
	bh=YB1ghMEOeQ5JFYWeY2ps8djFxf5/HuRtlXBeq/CH+jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA+rMgWoQN4XHWM4UubKM+rOMSTSfCUAqqRF7HsS0a8dcJecKIdOazxHs+jQy7KxJfTvyS5AjsmTTiqFHC6CR3XXg7dr2+PwOGukZp+Hm3njuEfFbaIlXTkkPqj6NjBO34UeepP3O7pO+HEPNe4UrO/wlP1J5RrKWZ+FD11p0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so4300487a12.3
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 01:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759481110; x=1760085910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNchDiEzIDmBEztmo8oZmioyYgfq18ckj4ZJE8yTj5I=;
        b=bJfQr4d2VbPAwmwrC6FgtGSv+ep2T7Z13nS18SOp6AgA6Z3QHh+ofgwP6AAy7n5Uwd
         U9ivfD+pfpKAc7cWj0KPg3srtkGSpSU5RoTkSRenkWh5n2lF1KQ0m+2XJi1fb5oaOXCJ
         +qdjO5mbe697DTo91v7Oh0HOI0y6Vozz5eHzRFEwAJbpmkB8MNmbEeO3C7n5oJ8wU/Q6
         QXqzJBYCYk2ZOh57aC9Ip+qUk/Ayl7iNlpf1jK6+HAQjOuvHYMFCIb7XEt21hrpHF7YS
         3Deu2AeMk6lg96t2qkZieSFu9dnYWGEgFJBo2BXmubPcOloXknfH8qW+jMpo69ZfULGD
         vThg==
X-Forwarded-Encrypted: i=1; AJvYcCVe3OghLoiNydloz/k0Ptw2Sd7H3AD/3KXMgUuYNGd0MkTO9qXJUQjOcBOnqSQyZoaVPpACSv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3SQSzspDLF0LVNxt7iSb+K83qvJbBkzhtInQdFdoqRhNtg9W
	NpUi/v7LQNpQgvXDUW4ZlJ6kmzb/p7YxSQ6cs5SQPb5Oyf+rglC1H7oU
X-Gm-Gg: ASbGncvWpVzx3OWW8XSKkQm7UxlMk2V/WURgc+2VHcY+703RlnEou+EzGTGqloSQa7T
	A+kmvxLBZXulgjhbJmQzKt0VFy86SYjBXDEuDkIDDPJj8/WqnCTcKHF3gAqf1s+pV8eNFZ9ozCh
	BzJLrBDEqBpym0bIia7qAbrECJvTWo4FcGrepIMI4HDwMKEbSuzQoEeOEWNItPlBDvQ4wbhKYbO
	EBuicIc2f7qWbhTt8jUQbCkHDoCAA/pxeutQAya4BZ3C6TQ+R3YNcjRgUjwbq3Ix4M+0CG5jOz6
	A1r1PnwCAw7EfklNqEy/pXp6RbfcLToC7oiS9aMj/hlxtOC+WMDeMJ/JaP9LpARaC8n1/owSnAi
	G2vX5eZ/yoIK3Q2j4pAAS0JEXNop3ymOQ8ap08w==
X-Google-Smtp-Source: AGHT+IGjw0zmq2CU/sdA/VkxJILpqI/TtLALso31v4P2kiwd0BksUPICZg/6K3fI5iB1htfz3dZPgQ==
X-Received: by 2002:a05:6402:5347:10b0:634:5297:e3b3 with SMTP id 4fb4d7f45d1cf-63939c509b6mr1714584a12.38.1759481110436;
        Fri, 03 Oct 2025 01:45:10 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811f14bsm3554826a12.45.2025.10.03.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:45:09 -0700 (PDT)
Date: Fri, 3 Oct 2025 01:45:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net, stable@vger.kernel.org
Subject: Re: [PATCH net v6 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Message-ID: <s4lrro6msmvu3xtxbrwk3njvmh4vrtk6tmpis4c5q5cbmojuuc@pig4xhrvhoxq>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>

On Thu, Oct 02, 2025 at 08:26:24AM -0700, Breno Leitao wrote:
> Fix a memory leak in netpoll and introduce netconsole selftests that
> expose the issue when running with kmemleak detection enabled.
> 
> This patchset includes a selftest for netpoll with multiple concurrent
> users (netconsole + bonding), which simulates the scenario from test[1]
> that originally demonstrated the issue allegedly fixed by commit
> efa95b01da18 ("netpoll: fix use after free") - a commit that is now
> being reverted.
> 
> Sending this to "net" branch because this is a fix, and the selftest
> might help with the backports validation.

This is conflicting with `net` tree. Rebasing and resending.

