Return-Path: <netdev+bounces-207707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 142DBB08597
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6CB1A61013
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 06:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAFB200112;
	Thu, 17 Jul 2025 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="muHVKx5P"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E221883F
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735373; cv=none; b=VMRHT0BaiaipEPTJcO5sBx83r9g0Id85aLJsFDdGwSS7BV81GGX/MI8gofC6VKCpEO1p0ZCFnJmUsalMJAJtIBkqmJX4PTooOO+82WiG+ztCXuNUOB0LLyKEo/fp4+13ZrLynKfol8cP4UPv4BjX7H13JOm6Z9OuNVJRHZFcR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735373; c=relaxed/simple;
	bh=2ryl1st/CliZamFSKmpOb95aW93th66/s2FFbrqQaqQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oe/K3zprT9xEk1XifydrsdpppFVB/vUUuCn/dcb8t4YgUZfjGupRzwQ+/AUD3RYpcjTZznDvKFdLhZ07yaKslkOH3XwbZfrUoO9tVpd1z5eSDW7YsC1krRLV/Kdb2gbcc0Byehmutj/fIjiXc1c0q4Y94REDg5TGcXruHAvZYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=muHVKx5P; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752735367; h=Message-ID:Subject:Date:From:To;
	bh=RdibcTFLD8R2tgGfh3p7k2j3R2UhkUbB96YU2fdwfLA=;
	b=muHVKx5PeSOrPUlxMFvmsrONLlZG7EbOPmHv1Kl0t+po0CQhISTT0Bu+06nCFsIZqKJ1ILDGq+eIZ85da6X8qD/iaI6BG0HRkD8M4yqnc8vMi9iB/QjA084KTJkBajzuSWW5q0M8dC4ABKEyLE6CwjtKOEK6a67FxkzTBxe8ycc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wj777kT_1752735366 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 14:56:07 +0800
Message-ID: <1752735339.8483515-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu, 17 Jul 2025 14:55:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
 <20250711105546.GT721198@horms.kernel.org>
 <1752645720.5179944-2-xuanzhuo@linux.alibaba.com>
 <3cb1810d-377d-4988-bf8a-75274f7b8216@lunn.ch>
In-Reply-To: <3cb1810d-377d-4988-bf8a-75274f7b8216@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 16 Jul 2025 18:32:14 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > > > +	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr, req_size, res_size);
> > >
> > > Please arrange Networking code so that it is 80 columns wide or less,
> > > where that can be done without reducing readability. E.g. don't split
> > > strings across multiple lines. Do wrap lines like the one above like this:
> > >
> > > 	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr, req_size,
> > > 				res_size);
> > >
> > > Note that the start of the non-whitespace portion of the 2nd line
> > > is aligned to be exactly inside the opening parentheses of the previous
> > > line.
> > >
> > > checkpatch.pl --max-line-length=80 is useful here.
> >
> > We are aware of the current limit of 100 characters, and we have been coding
> > according to that guideline. Of course, we try to keep lines within 80
> > characters where possible. However, in some cases, we find that using up to 100
> > characters improves readability, so 80 is not a strict requirement for us.
> >
> > Is there a specific rule or convention in the networking area that we should
> > follow? Sorry, I have not heard of such a rule before.
>
> That suggests to me you are not subscribed to the netdev list and are
> not reading reviews made to other drivers. This comes up every couple
> of weeks. You should be spending a little bit of time very day just
> looking at the comments other patches get, and make sure you don't
> make the same mistakes.
>
> In this particularly case, i don't think wrapping the line makes any
> difference to readability. There are some cases where it does, which
> is why you don't 100% enforce checkpatch. But in general, you should
> keep with 80 for networking.

OK, I personally also strongly prefer the 80-column limit. However, sometimes I
do think that in certain cases, keeping code on a single line can look cleaner.
Most of this patch should already follow the 80-column rule, although there
might be a few lines between 80 and 100 characters. I'll scan through again for
this issue and try to bring all lines under 80 if possible.

>
> > > > +#define EEA_NET_PT_UDPv6_EX  9
> > > > +	__le16 pkt_type:10,
> > > > +	       reserved1:6;
> > >
> > > Sparse complains about the above. And I'm not at all sure that
> > > a __le16 bitfield works as intended on a big endian system.
> > >
> > > I would suggest some combination of: FIELD_PREP, FIELD_GET, GENMASK,
> > > cpu_to_le16() and le16_to_cpu().
> > >
> > > Also, please do make sure patches don't introduce new Sparse warnings.
> >
> > I will try.
>
> FYI: We take sparse warnings pretty seriously. So please try quite
> hard.

I will add Sparse check.

Thanks.


>
> 	Andrew

