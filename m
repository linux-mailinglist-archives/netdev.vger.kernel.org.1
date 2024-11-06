Return-Path: <netdev+bounces-142262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3EF9BE146
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766AC1F22981
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024A21D3187;
	Wed,  6 Nov 2024 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yYW/bB6n"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F641922EF
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882827; cv=none; b=Dvw4dH9rz4gotJoat1R2Vw8veaIjdOdfAWPgyUua+0k4ilZ6EQgetdMxTnSRs/nKbTWoyfdv09PEaG4Ch6vvNSlvcXesuGB/dkXhYjpcLYFss4eVnw3qLtHa5tASu1ayGmGyEP/bjXJcDzuZz+Dllb7WU0YQFu6cg8LIQ7CNUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882827; c=relaxed/simple;
	bh=mDuHoyCsVT8fNy8uOP3L4BiDARjKYHXqekGIpA0UaxI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=VINxEe+oZF4mh36c2v6r8BOW+yH4BrDDBoEkWnLfXxrbywQaM+dM6FjygfcuEJRBuP5esFmsJ5CYPZ9Ot108QT9osp/8oJgOurm/+Tm+LBa1GYnVAj01etbU5mDB3OyeUR9H+ERhbMEUbjJ3ZqqQxM3Qzn1uu20Wab4djWEu7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yYW/bB6n; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730882822; h=Message-ID:Subject:Date:From:To;
	bh=mDuHoyCsVT8fNy8uOP3L4BiDARjKYHXqekGIpA0UaxI=;
	b=yYW/bB6nKSYIF7tocE3zKbYIt2ZbxB1oFAZhkQPo4N1D7pRCxEaui3Y9TK3sh9GgvvZoEMasMe1C3O+x3say5zFx1NTcv82zWb+MSiCrqCfgrlf8wbILFNfXbObAZY3AuzlmekL1rQxKIPULT04FFfVuf3hhT2PKb6iNi396Wps=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIqeaLn_1730882821 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 16:47:01 +0800
Message-ID: <1730882783.399233-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by default
Date: Wed, 6 Nov 2024 16:46:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
 <20241104184641.525f8cdf@kernel.org>
 <20241106023803-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241106023803-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 6 Nov 2024 02:38:40 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Nov 04, 2024 at 06:46:41PM -0800, Jakub Kicinski wrote:
> > On Tue, 29 Oct 2024 16:46:11 +0800 Xuan Zhuo wrote:
> > > In the last linux version, we disabled this feature to fix the
> > > regress[1].
> > >
> > > The patch set is try to fix the problem and re-enable it.
> > >
> > > More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >
> > Sorry to ping, Michael, Jason we're waiting to hear from you on
> > this one.
>
> Can patch 1 be applied on net as well? Or I can take it through
> my tree. It's a bugfix, just for an uncommon configuration.


Why? That can not be triggered in net branch.

Thanks

