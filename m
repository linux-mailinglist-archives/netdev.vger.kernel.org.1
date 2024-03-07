Return-Path: <netdev+bounces-78229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88157874701
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281E11F23684
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 03:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A7101CA;
	Thu,  7 Mar 2024 03:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LZJLwZHW"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F87484
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709783881; cv=none; b=Nh8rSlOH/upBHKYXz41KiUuYjlOBuKoaKbkYH4/VDlpguJ9tH6Uji5SOd3Nz2v/q2N7SK4O2qJOBoDYV1J/o7MLv4dr1O5ZY+htaR7klbaTVmROK9y8ccj1xzzKryTGHizQVdTtT+Bi0u3oLdYWkNLP4e15/w4SESZrWgln0xCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709783881; c=relaxed/simple;
	bh=GMgkp+yscZsRM1U8J6RkT4IGJ9uG4UFDIrOWZTNAWoM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=l/1u9D5DhFQ6R3Ljsucco9ZswEwOttEdXmF56q5144WU1Vs5GFJhszs2t/3JgtH53v+fJyia8QFA19FHdrq+011godI8nERZFa0r6UoI2sjBm08hPr4c6AT4uFSha+j3g2TEEE+BPARaYeipJurRb4XQKmtkPONjj5ma+WbFq7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LZJLwZHW; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709783875; h=Message-ID:Subject:Date:From:To;
	bh=NbVOwjRfy22DH84uegjWTqJAOzXJDeObfAkmRBzdswE=;
	b=LZJLwZHWe2IAnB5dmsTopoIoJLQArLsTjj2CMbKd4BfuCnosIDAPGDDCc4uJBmsSf7GCUY/IKOdjuQVjXSqkeMjesIPCudraZfkfsGCkAy9TxsH8r+XzKjyIe6TZJ/Ng+ey8/RgCEav6319su/BLHSFxawbd40HQ5lO9jHI4YE4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W1zJt4M_1709783873;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1zJt4M_1709783873)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 11:57:54 +0800
Message-ID: <1709783855.0510879-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 0/3] netdev: add per-queue statistics
Date: Thu, 7 Mar 2024 11:57:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 edumazet@google.com,
 pabeni@redhat.com,
 amritha.nambiar@intel.com,
 danielj@nvidia.com,
 mst@redhat.com,
 michael.chan@broadcom.com,
 sdf@google.com,
 przemyslaw.kitszel@intel.com,
 Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net
References: <20240306195509.1502746-1-kuba@kernel.org>
In-Reply-To: <20240306195509.1502746-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


For series:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

On Wed,  6 Mar 2024 11:55:06 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> Hi!
>
> Per queue stats keep coming up, so it's about time someone laid
> the foundation. This series adds the uAPI, a handful of stats
> and a sample support for bnxt. It's not very comprehensive in
> terms of stat types or driver support. The expectation is that
> the support will grow organically. If we have the basic pieces
> in place it will be easy for reviewers to request new stats,
> or use of the API in place of ethtool -S.
>
> See patch 3 for sample output.
>
> v3:
>  - remove the dump error handling, core does it now (b5a899154aa94)
>  - fix ring mapping w/ XDP in bnxt
> v2: https://lore.kernel.org/all/20240229010221.2408413-1-kuba@kernel.org/
>  - un-wrap short lines
>  - s/stats/qstats/
> v1: https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
>  - rename projection -> scope
>  - turn projection/scope into flags
>  - remove the "netdev" scope since it's always implied
> rfc: https://lore.kernel.org/all/20240222223629.158254-1-kuba@kernel.org/
>
> Jakub Kicinski (3):
>   netdev: add per-queue statistics
>   netdev: add queue stat for alloc failures
>   eth: bnxt: support per-queue statistics
>
>  Documentation/netlink/specs/netdev.yaml   |  91 +++++++++
>  Documentation/networking/statistics.rst   |  15 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c |  65 +++++++
>  include/linux/netdevice.h                 |   3 +
>  include/net/netdev_queues.h               |  56 ++++++
>  include/uapi/linux/netdev.h               |  20 ++
>  net/core/netdev-genl-gen.c                |  12 ++
>  net/core/netdev-genl-gen.h                |   2 +
>  net/core/netdev-genl.c                    | 214 ++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h         |  20 ++
>  10 files changed, 498 insertions(+)
>
> --
> 2.44.0
>
>

