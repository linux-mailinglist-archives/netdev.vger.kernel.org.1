Return-Path: <netdev+bounces-105559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AF1911BDB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208711F24629
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD313E022;
	Fri, 21 Jun 2024 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xXZ+Mw59"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1F39FD0;
	Fri, 21 Jun 2024 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951642; cv=none; b=o3CV5cvlc0ovmtRZlmLC6pa7s4MucI/vCQFZuy2UhF40VVuu8b/YPwGqQ1W41qHGxli4PFPXmSysNdLWWlhWiyhaCMlzYUYKeZBXratgP2pBc4DrvSNUxYNLKKnEX6asW5YWUKNGi4jGqnjGUOz3voW8a6Fu4b0mzaezrnI4Xl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951642; c=relaxed/simple;
	bh=Xb0mUtM8oiE38+41F9AbNF/z9ky5fLWOK4MWw6xBhLg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=VRbeDfI6Pbw6fTtG7SkLTrSGxZMVjdRrP/tUhybJ3e0h8FbHW5GsRASESPzAcC8kiB+RFVHNMdu0oHeXx9MYliT2Oj6ZM9AwtPejizhw8EoVaphesId9Un41YXOZ9ip/KsBzSUmrV7c0MxNir/msWw80/oU2IBN0Ul6f8Q/MloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xXZ+Mw59; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718951631; h=Message-ID:Subject:Date:From:To;
	bh=fGizkInIzi8S2Z/Q1zqQQM8kbuz37uBRTVg3F8UQ+QY=;
	b=xXZ+Mw59L9CZlA/wL4jXFTAZaPeNdEg3nlvqrkzDQllB7r4iduWpsUEb6WInbX5+Ho+fv/s/ZdgcoV4viENccCfYuRsxgssjBfa61rvLPtk/Ma50QPTksWjuAUQoxpnlcdDREGLkggO1otMotEC16DQwOtId5eBNUhuMv40XwTI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068164191;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W8vG-Z4_1718951629;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8vG-Z4_1718951629)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 14:33:50 +0800
Message-ID: <1718941478.823058-14-hengqi@linux.alibaba.com>
Subject: Re: [PATCH RESEND net-next v14 0/5] ethtool: provide the dim profile fine-tuning channel
Date: Fri, 21 Jun 2024 11:44:38 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 donald.hunter@gmail.com,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 awel Dembicki <paweldembicki@gmail.com>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
 <20240620204025.625f759c@kernel.org>
In-Reply-To: <20240620204025.625f759c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 20:40:25 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 18 Jun 2024 10:56:39 +0800 Heng Qi wrote:
> > The NetDIM library provides excellent acceleration for many modern
> > network cards. However, the default profiles of DIM limits its maximum
> > capabilities for different NICs, so providing a way which the NIC can
> > be custom configured is necessary.
> 
> Could you give an example in the cover letter of a type of workload and
> how much a new set of DIM values helped?

Sure.

