Return-Path: <netdev+bounces-226200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77413B9DE01
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372384C0961
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773E2E541E;
	Thu, 25 Sep 2025 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ur5xZHno"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE342512FF
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785978; cv=none; b=Xfx0josmPW78CjD+MGKSaD2Ywk/zS/KW49bwkOny6ZYpGrFnca4ORGKJXaKS4UpALsqWLA12z2UPBwh1O9UdR0lgDDuB5lAEGjebZubAia5tFip+WCDy7g8Y5dM9LdokpQ9IUOtoylltjnvcaVU3BY568LEK8UAMRpxGG9the3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785978; c=relaxed/simple;
	bh=TZaTmLdC0c0yO9OiOxHnU+3QIh8Tm/p5DcdoPSaxrUk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=PwxnOAPH2V39BTcTbganwPt1yq6gb8s96xtFx6n0z+LkvDjptR2XBJEZO2QDAZVvkbP7+7u/me+EG47NC1iF3kjIVVzC6vL4f6b48TMb0erNSq/+9JBa/GRhJCwaHz5J3vfUaZOqbWW3KsnsIEWF6b5DrtlcG9IiPOWxq7KxkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ur5xZHno; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758785968; h=Message-ID:Subject:Date:From:To;
	bh=F7RjEg8GOQOcIsBuOZNvXL738XUqky+Jj26x5BX+EQw=;
	b=ur5xZHnolpPo7PX1ycPMy3RBBKWLFEHNUZTLLK6uTLYL7FF97178ZUGW/rdt1MiuFkG+alykokJPUseDGsVLY69+h+it1cSS64TNCfGIspuyxuS9uhXPUWt6cQPmQKl1TJ7X9e4+0qw/GweEehlxDRJJqEuJ+s/okzpAiINSxL4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Woms0eP_1758785966 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 15:39:26 +0800
Message-ID: <1758785815.7641003-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu, 25 Sep 2025 15:36:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert  Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
 <cfae046e-106d-4963-88be-8ca116859538@intel.com>
In-Reply-To: <cfae046e-106d-4963-88be-8ca116859538@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

> > +			   struct eea_pci_device *ep_dev);
> > +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work);
> > +
> > +const char *eea_pci_name(struct eea_device *edev)
>
> generally such a thin wrappers for kernel API are discouraged
> (this driver would be part of the kernel, if someone will change
> function that you call in a way that requires change of caller, they
> will also change your driver;
> it is also easier for reviewers and maintainers to see something
> common to them instead of eea_pci_dev_id())


I see. But I do this because that the sub struct of struct eea_device is
invisible from the out of eea_pci.c.

And the maintainers can change the code inside eea_pci.c directly, they
do not need to care about this api.

Thanks


