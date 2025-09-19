Return-Path: <netdev+bounces-224671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8694B87EE3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 07:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC8B1C8515D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 05:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175BF2627F9;
	Fri, 19 Sep 2025 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E0IEQt4T"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06222258ECE
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260579; cv=none; b=cFZLCW7AHqbMRlSi6OJFBlv64A2HEr/irGtgoFdNeIpXVS+aM41mQH5VDCd7XouSxMAxkCoNmllpdUPN4+AQ05rgoaFD1om/cvbyywEbgK95vxejQDCmen9YbTwWATubGXJanZLHvxOYMz527Crn2HmlZdM3jWgQ9yA/BMq0zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260579; c=relaxed/simple;
	bh=5ireFOLza4n+CYFr5LY6rKuquQUmlnwwbFA/iusmRT4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Zp1HbyAYhV2TgC/HmixAccRUKkr1tYau9Yd+3N/qtgqAvI+jGXTuEBLl1EeJqS22q84/0MeRGSy6LPNkGEM+BZ1TI4kSGTM9oYnAUEx7MZEUxY++sCMs6gwJwlzzEAT65NdT+pQVxvV9NwCKUVFXVj2EMm2YmACerQZ38uyYTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E0IEQt4T; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758260571; h=Message-ID:Subject:Date:From:To;
	bh=31i16PeWzKZy9H0XtrxI0I0C7x07sy/XgpoUTU+m3Vg=;
	b=E0IEQt4T0m/NyB0k1ZVFVvJKXilhUVXgVi+Amv8sI8fpAuCKjurupzjTk+veG34HpphDc6MbjRFJhTgtZ5GIhXbid6hyKwdFHAvqpRbtIv8+CEc98RT1pTb7yapslW09Ik98LLI5ceKXmtqIFWCkrUaKwr55E7rOiwFNObORAgQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WoIgy.m_1758260568 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 13:42:49 +0800
Message-ID: <1758260547.6875136-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Fri, 19 Sep 2025 13:42:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
 <DC717B917DF04BF3+aMy3tTTi0NZc-lIg@LT-Guozexi>
In-Reply-To: <DC717B917DF04BF3+aMy3tTTi0NZc-lIg@LT-Guozexi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 19 Sep 2025 09:53:57 +0800, Troy Mitchell <troy.mitchell@linux.spacemit.com> wrote:
> On Fri, Sep 19, 2025 at 09:48:56AM +0800, Xuan Zhuo wrote:
> > Add a driver framework for EEA that will be available in the future.
> >
> > This driver is currently quite minimal, implementing only fundamental
> > core functionalities. Key features include: I/O queue management via
> > adminq, basic PCI-layer operations, and essential RX/TX data
> > communication capabilities. It also supports the creation,
> > initialization, and management of network devices (netdev). Furthermore,
> > the ring structures for both I/O queues and adminq have been abstracted
> > into a simple, unified, and reusable library implementation,
> > facilitating future extension and maintenance.
> >
> > This commit is indeed quite large, but further splitting it would not be
> > meaningful. Historically, many similar drivers have been introduced with
> > commits of similar size and scope, so we chose not to invest excessive
> > effort into finer-grained splitting.
> Maybe this note should go below the `---`
>                 - Troy

Yes, will fix.

Thanks


> >
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> > Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

