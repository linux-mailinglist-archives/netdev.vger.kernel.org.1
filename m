Return-Path: <netdev+bounces-236596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A8DC3E3AF
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 03:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39251888E80
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7F62BD035;
	Fri,  7 Nov 2025 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EQrHfv32"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E3285CB3
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481878; cv=none; b=mazn5as60iPUWf2AUUkvOMghhNjI2mpfW4huKkwWkhFef7WT+Zr0pwzBLz97aQizx5eGSLhdOT2V4uoRX5jsdVmjOSeeoNrpM8bQhf00k4OIuj//18wT3RdAVsozPd5mj8RKx1hbCyF2U/0FrVPF+cLq8yWBN3M8193wLefeyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481878; c=relaxed/simple;
	bh=a6kJO+izSNfeswZUjVVnh4Ql39XsoQgKThiSq+LoccI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=e/jsFTFMkWGwgtQVA1kQbffcGehYwDoMw+VeqZlCZMIsBF6WiWzTGfIL5tYjpVAbaQPqg2TlqSrZgKKXaQUk/a5gtkVXaMw0hvxJSUMwoAdSGLb2hlk4RKc65SpA/eDIWPU+AgosOPxQVpZw0q1dwgRZB8H9C7LttXfIO4yYPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EQrHfv32; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762481867; h=Message-ID:Subject:Date:From:To;
	bh=RKl/KmbO5ZpBydU4EpkUtiJ1U6RUJRSLwTz1Mxj8QCE=;
	b=EQrHfv32O+HSWxcr9ecWAhE+Vsh7a0vNk9sBNIL8q8l0IKCHM2lYwvfjikdo4EFyNyMTtwTEAH6MnJ++qjSZCz5dVjzjdUZTeLoYIus+jB7J9Wip7NgibfLnuDieRWdHfpvQ9UhzWpTti7Cm0bXQ9OoM1nyyGkYAx9mc1XG0w8k=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrrNOBh_1762481865 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 10:17:45 +0800
Message-ID: <1762481859.4201689-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v10 3/5] eea: probe the netdevice and create adminq
Date: Fri, 7 Nov 2025 10:17:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S.   Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo   Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim   Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20251105013419.10296-1-xuanzhuo@linux.alibaba.com>
 <20251105013419.10296-4-xuanzhuo@linux.alibaba.com>
 <20251106180111.1a71c2ea@kernel.org>
 <1762481052.9107397-1-xuanzhuo@linux.alibaba.com>
 <20251106181328.25661cea@kernel.org>
In-Reply-To: <20251106181328.25661cea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 6 Nov 2025 18:13:28 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 7 Nov 2025 10:04:12 +0800 Xuan Zhuo wrote:
> > > > +	struct eea_aq_cfg *cfg __free(kfree) = NULL;
> > > > +	int err;
> > > > +	u32 mtu;
> > > > +
> > > > +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> > > > +	if (!cfg)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	err = eea_adminq_query_cfg(enet, cfg);
> > > > +	if (err)
> > > > +		return err;
> > >
> > > AFAICT this is leaking cfg
> >
> > cfg is freed by __free(kfree).
>
> Oh, sorry, please read:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
> don't use __free() in drivers.

OK.

>

