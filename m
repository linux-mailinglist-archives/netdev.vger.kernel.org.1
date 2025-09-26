Return-Path: <netdev+bounces-226563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC718BA2226
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75231625C52
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168A187554;
	Fri, 26 Sep 2025 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Obt7o+k1"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256A1632DD
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758849808; cv=none; b=NxPQ88eoVGmJmaNQCNL/lQow5zCR5iYJhjJ5L0yNAsek22J2Vq7O0tAyhDB78QOmPNabGg83djT1eMsn8OJU1fnff3Fs4i/IwxtryOkIzTDSvt8/Mh83F10wgiun62VwqyZp36Z5VKfymRMNvKF4UJpP9X7YfWQsw9AMn6/b72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758849808; c=relaxed/simple;
	bh=rQ6+fWzwEZStw/pYSLa3ldIDEbpq2fNo2CGWocq+lSM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=HEABo2kOt3CIf8/Yn5mukjz7rjXCqc+/gHoq5jw6JZzjhy0XeloumthIBIZ23pgNYoJUSekXm7eOHk0a0YIxZs/AIhqh+io4qcwSrCzGX5b4dfgwHYTo1ptTZ5DOeOSRtIAHfPtVAHB57gprzjx/7JRFv4FSE2KASWhGhr8+Fx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Obt7o+k1; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758849803; h=Message-ID:Subject:Date:From:To;
	bh=bSHPkjbAfKumVMS94rKG1+ATRDLpph+iaCwV+JSfMvc=;
	b=Obt7o+k1zbh+oqj7LDyyGtAduCWpnLncnmsx0EWGoOss8vBdhkDLppFVEw7eL/o113Z1RT4ttmq0NOAFXQJrdUZpjx01fEP9kCXSs40cU7KqYTGb9ybsIX2DqDaMaoGUw47DRTzx2Ua/CBQEBmF+ecTEEFyl7D53X/GBgXB6MRo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wopd4j._1758849801 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 09:23:21 +0800
Message-ID: <1758849684.4742515-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Fri, 26 Sep 2025 09:21:24 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
 <cfae046e-106d-4963-88be-8ca116859538@intel.com>
 <1758782566.2551036-1-xuanzhuo@linux.alibaba.com>
 <bf3a6b81-de2e-4c63-968e-5f0937727855@lunn.ch>
In-Reply-To: <bf3a6b81-de2e-4c63-968e-5f0937727855@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 25 Sep 2025 16:11:57 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > > > +ALIBABA ELASTIC ETHERNET ADAPTOR DRIVER
> > > > +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > +M:	Wen Gu <guwen@linux.alibaba.com>
> > > > +R:	Philo Lu <lulie@linux.alibaba.com>
> > > > +L:	netdev@vger.kernel.org
> > > > +S:	Supported
> > >
> > > this is reserved for companies that run netdev-ci tests on their HW
> >
> > Yes, so I think this is fine for us. In the future, the Alibaba Cloud instance
> > will provide the EEA NIC, and we will test it on such a machine.
>
> Until you do have such tests, and can show us the test reports, please
> don't use Supported.


Of course, we do have tests, but due to project timeline constraints, we haven't
scheduled them for public release yet-though it is part of our plan. For now,
let's start with "Maintained."

Thanks


>
> 	Andrew

