Return-Path: <netdev+bounces-94663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259E8C019A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980311F2400E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE81128805;
	Wed,  8 May 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G6sb7fiK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0B8663E;
	Wed,  8 May 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183968; cv=none; b=hUbI37MP0JFJNBxqFWXNRx8OyPgDUGyVLK86fXzjk3rweYtYonoGZE7AjNZMbLSqrMgjigwa3BEwAFyafzQKrQtNAS0WkJ64UhTcD3xYmJbuLfzMruVwpe+tsGmbywNy72C1VItrR/sttmyQNL/2gQE0rkd9jvQD/hZV2qqyHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183968; c=relaxed/simple;
	bh=Vr4ak7PpgyRFjcXcRl+OWn3i7tJscUswaAZxWq/gJMg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=aX77JCim5VYWW19SDOFZXILJbFkHzwwB8wpzxlvbN2iIYhwUP2s6UxBxDVWzx5bXY28JfXAIBeiUKPoGr93+7hSGusahzJBOGS7V4bkNtue2MmCdIbhZerLBZ8ia3eykCE7O8Hb2bFGYJ9egkieqEFyW2n8RuXifm5tKZ9EyM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G6sb7fiK; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715183958; h=Message-ID:Subject:Date:From:To;
	bh=bDQQx0bxj6KLo4YVZhxf/+u13Y8cYMKCpaQfBhfDF0c=;
	b=G6sb7fiKZiWijlHWXN72XbwKaOdBofXjwf6XeUGhD7We/aT0sR7IvMIy9G6xO6e8O3RrrSiludu5oJzvY85iKqWRjFzcQRyv2GAqurRfUdXPRVPEwk2lWldhVJeTYJsXvHg6AacAXVFtQET/UdqMnYbY9xFMXWJDI7IjE04gAAY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W64.QmE_1715183954;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W64.QmE_1715183954)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 23:59:16 +0800
Message-ID: <1715183609.0604343-3-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v12 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Wed, 8 May 2024 23:53:29 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Paolo  Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett  Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan  Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul  Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
 <1715134355.2261543-3-hengqi@linux.alibaba.com>
 <20240507194707.7c868654@kernel.org>
In-Reply-To: <20240507194707.7c868654@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 7 May 2024 19:47:07 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 8 May 2024 10:12:35 +0800 Heng Qi wrote:
> > I would like to confirm if there are still comments on the current version,
> > since the current series and the just merged "Remove RTNL lock protection of
> > CVQ" conflict with a line of code with the fourth patch, if I can collect
> > other comments or ack/review tags, then release the new version seems better.
> 
> Looking now!
> 
> Please note that I merged a patch today which makes DIMLIB a tri-state
> config, meaning it can be a module now. So please double check that
> didn't break things, especially referring to dim symbols from the core
> code.


The transition from bool-state to tri-state has no impact on this series,
since functions in the DIM library used by external modules require
EXPORT_SYMBOL in both conditions.

Thanks.

