Return-Path: <netdev+bounces-104708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EA590E129
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4681C20F2F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399B5227;
	Wed, 19 Jun 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf32uwrn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19521876;
	Wed, 19 Jun 2024 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759718; cv=none; b=btztIUYK4YtqAbpxMBYOaqQivqO/ei+d4XLUeVn7e40J77sMDFEgKO0RoeVa3wgDg0dpupnTpjX05gCaCOnV5LG5kFahKebPy11QDwSwVNhSumVofJR64vnQqLlNEakUhTnm+zvbnvSfMemq+/iFpYMbAt8fZFpvMkIPU3oK/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759718; c=relaxed/simple;
	bh=txv75gnyDaI0dhggEgXUoqJ1Ns902WFRZhtWvl1w4vM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeUISqK/FioG5C45/VRzr/qBHoLZHWQwHAY+60RdZJ3dheUhtuSQu5517lq1q4zfG5OZSdCD05bppJmo+d+WaY3SX6zZpSzakIl++p2yec9Ubb8mlMyydr5kBkSE220ne17wqttNl+UE//NNC7tWeCyHcr/V8A3ia16pdSd+330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf32uwrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978F9C3277B;
	Wed, 19 Jun 2024 01:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718759718;
	bh=txv75gnyDaI0dhggEgXUoqJ1Ns902WFRZhtWvl1w4vM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sf32uwrnw6XVRnZu08nJmbF8/dIFbimU3gOkEk89tqQ52qNHOglwEAYAaVmVT183W
	 5bbYxayzk3ElMyocBttHr7hF5grq3cobcwKZ6Q/Vh2JSLZyW3NokhdsTQCMDdiml8E
	 vqBw9RodLuOPJV2Qoc1ODql1mcNYcKFTGLqzLH1cP5cQqn6g5NwrSbJqspZMSHeKd4
	 a+brX+rw+HUch8dM8ix/vXndXb4jzuZbY/hl/bo/b41xgdxlWNaJ/5wJyXvbxOoIsH
	 4l5ZNBZnQXrfD610UgIqkixptHdh94+09/OdUQHgTR4z8ItOSOip4Dm0wApB5c2+c3
	 zfCQpg4vSZgzg==
Date: Tue, 18 Jun 2024 18:15:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, Thomas Huth <thuth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
Message-ID: <20240618181516.7d22421e@kernel.org>
In-Reply-To: <1718680142.7236671-11-hengqi@linux.alibaba.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
	<20240617131524.63662-2-hengqi@linux.alibaba.com>
	<CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
	<1718680142.7236671-11-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 11:09:02 +0800 Heng Qi wrote:
> > (Should we manually do checksum if RXCUSM is disabled?)
> >   
> 
> Currently we do not allow RXCUSM to be disabled.

You don't have to disable checksuming in the device.
Just ignore VIRTIO_NET_HDR_F_DATA_VALID if user cleared NETIF_F_RXCSUM.
I know some paranoid workloads which do actually want the kernel to
calculate the checksum.

