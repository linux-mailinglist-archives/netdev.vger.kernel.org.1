Return-Path: <netdev+bounces-231493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCABABF9A08
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3746819C5CA2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A871F3B9E;
	Wed, 22 Oct 2025 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uX27FIxI"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063BB1F181F
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097386; cv=none; b=tXdkZMx7X7jqx0LkZnqcTaIRM1RShWcf8m6trhc4DxjyAMqB5fLb3eqMySvaqRuYFwaucRBAyn7RTGPZx/Jax7Zls59Bi4360u8azlBw49g++X8wVYbLdxcR9pUvYYl4BWht6qpTvf3tbjGfsppyurCgtaGRwmSLmg2+jsbRnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097386; c=relaxed/simple;
	bh=Auhxjg5pNRBAFMysZdzEa2AyUIKO6XZwWubyCzixAlc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=YfhPHwiKlTUUlyhkklg5ZMwds/X6DQpFyK84kJ6CDi1OytJRRqd1neo7w03MH195aneT7x8xB0oG7GAlWBRtuXUicGmFAsxlY7p12km7G2boJRaBzLWCyBUbDA2r2qsRebdW9KPDpvFnJ+2ZUR8eAyhM+JVFTemCjtPrL4Gt7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uX27FIxI; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761097375; h=Message-ID:Subject:Date:From:To;
	bh=Auhxjg5pNRBAFMysZdzEa2AyUIKO6XZwWubyCzixAlc=;
	b=uX27FIxILXOaIEZK6QYOjtugdYZECsljRicVt9bzVgtsrf7Jeb4ONu2n2PMSGHprBgHpCpnyc7OzispVMkR4c1Y0301LaebhcvyYy03G4hNJ9M0oNZMja4MYlCtIm+dyz0bvJAZQaGWMz2r2wXMQb4sqZrrozYtIcb2fuUJE+EI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqkgZ5F_1761097374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 09:42:55 +0800
Message-ID: <1761097355.5092716-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: fix header access in big_packets mode
Date: Wed, 22 Oct 2025 09:42:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wen Xin <w_xin@apple.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20251016223305.51435-1-w_xin@apple.com>
 <1760662656.1338146-1-xuanzhuo@linux.alibaba.com>
 <20251017163856.4c554cc8@kernel.org>
In-Reply-To: <20251017163856.4c554cc8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 17 Oct 2025 16:38:56 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 17 Oct 2025 08:57:36 +0800 Xuan Zhuo wrote:
> > http://lore.kernel.org/all/20251013020629.73902-1-xuanzhuo@linux.alibaba.com
> >
> > do the same thing.
>
> Could you repost that? looks like there were some questions,
> but nobody sent review tags even tho they were answered..


YES. In my todo list.



