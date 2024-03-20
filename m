Return-Path: <netdev+bounces-80749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B2880EF5
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA861F22514
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6913B797;
	Wed, 20 Mar 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ML3v+xgK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9913B7A8;
	Wed, 20 Mar 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927965; cv=none; b=pMtJhSLgni4CHpXVFCp+MXYGHQkyYg6sCToYr3uvCHka2YCxWOOL1w1w29eWkP+5aYW8eZOJE6KVyD0vp9yCIfWbUPqcSTx/yDyKlya/g3FClgCn8Y8VpaMdMEP/Y9XPBDcZOQIBt+flOQSuLy50kFjC8cd6wOxCUEzmQJ823ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927965; c=relaxed/simple;
	bh=dLgoIfaTqa8nTP1PGLsxkGjCBSm52im/6G2YUb9BLjg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=uaL/aiOjPA960R5WAdmYeUQUVZpHxsol7m36CQqQaOYzanvtknpeKX1VRnV1t8Y6UdjPi3CY/q0EgDOt4pmtAGFGcI+eShNzupFWKSF9U74XhaaEg/QKaxOzRmtiYoIc3hu2EJwhJu2uOEavj6GvsBil0Dhn1bY8ztuSYIItepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ML3v+xgK; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710927954; h=Message-ID:Subject:Date:From:To;
	bh=dLgoIfaTqa8nTP1PGLsxkGjCBSm52im/6G2YUb9BLjg=;
	b=ML3v+xgKICazwkItpSIhqafMzbs2Scl3OYlbvsokruc/9cqi0vKM1UI6OSCGSX/IhE/mPoJjw7DNrPSddfuZaYU15rDK5i1gRbcUg/mikEd6qnvfCGvqm9cgAgxpHhPz9wOFWjHMhuaQ04YHLhW/DGxkeEV0GePxDhi+qGgJFck=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2wsc.n_1710927953;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2wsc.n_1710927953)
          by smtp.aliyun-inc.com;
          Wed, 20 Mar 2024 17:45:54 +0800
Message-ID: <1710927912.3040364-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Date: Wed, 20 Mar 2024 17:45:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hope this in your list.

Thanks.

