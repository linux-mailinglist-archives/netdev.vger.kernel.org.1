Return-Path: <netdev+bounces-91510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C08B2EA5
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 04:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440361F221C0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 02:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1D1878;
	Fri, 26 Apr 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X90ITTOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED23AD58;
	Fri, 26 Apr 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098112; cv=none; b=lyCin4OFwrvJtwHTllYJMkncmKAAq2o8MAUf61BE1VZCkx28fgrTcnGt+2F8RB3c0Bg3jQdY2KF6D7eUjKbDwOrv9l5xKdg5pJJ906cAa+MPXAgHyYkimoj/PWI1bDuffumWOZ1tcl6qtZ7Tj+09ZjVB9v5DmPf7nnfrDrbXJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098112; c=relaxed/simple;
	bh=B7wGq9xz34mGMzz7FTmEnJlyzB+aJh7cfNs70AND9cM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWqMcRX5n103vI7hx/mO2Fa1iyvcWAf73ZSDWrozs7EL7wwHheyz1pBL2uxWZAv0bEfxGiyr4AokzIgRRRc+PkOfnmVOjac4qjBmXMe9GsxcsUoUOTQeeAOqe0MryCKmFCsDyQJDTIxyPZAioEpy0gJPPd2UmTHpSpu/dy9yVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X90ITTOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D8DC2BBFC;
	Fri, 26 Apr 2024 02:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714098111;
	bh=B7wGq9xz34mGMzz7FTmEnJlyzB+aJh7cfNs70AND9cM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X90ITTODUovXFHSdNEdoaZlVWj+L2AT/HzLdy/un9xbac0+Gb47q60ZjpWQ39Je5S
	 RzndB66NdKXNvVCgJCDbFWLBqIdFYtHpNYq2qsHGIfn8fAiS4T7DuuDlX0rALuYZOe
	 dzHTFBt98xXFa6jLZTvOIBdLYlBKLfOb3aVGbXz0cUPOKtFg7axg8k29Oi9qv5w2wL
	 YkshBEachm1m+e+uU6wtWGKMqWWUOfehu6kkbvBhLv0qQXs7Qcv8bdDts6q7UZKk1f
	 xR8sNQ2aR60pfjk/I4mMU7mJ9WBRXG9qsvp3mtKgOEWc7crm8MMpauDO5jjK2/7nvF
	 CrfaBP4EzkF8A==
Date: Thu, 25 Apr 2024 19:21:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "Michael S .
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, "David S
 . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] virtio_net: fix possible dim status
 unrecoverable
Message-ID: <20240425192150.0685d4b3@kernel.org>
In-Reply-To: <20240425125855.87025-3-hengqi@linux.alibaba.com>
References: <20240425125855.87025-1-hengqi@linux.alibaba.com>
	<20240425125855.87025-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 20:58:54 +0800 Heng Qi wrote:
> When the dim worker is scheduled, if it no longer needs to issue
> commands, dim may not be able to return to the working state later.
> 
> For example, the following single queue scenario:
>   1. The dim worker of rxq0 is scheduled, and the dim status is
>      changed to DIM_APPLY_NEW_PROFILE;
>   2. dim is disabled or parameters have not been modified;
>   3. virtnet_rx_dim_work exits directly;
> 
> Then, even if net_dim is invoked again, it cannot work because the
> state is not restored to DIM_START_MEASURE.
> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

This sounds like a legitimate bug fix so it needs to be sent separately
to the net tree (subject tagged with [PATCH net]) and then you'll have
to wait until the following Thursday for the net tree to get merged
into net-next. At which point you can send the improvements.
(Without the wait there would be a conflict between the trees).

Right now the series does not apply to net-next anyway.
-- 
pw-bot: cr

