Return-Path: <netdev+bounces-220543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8CDB4682E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D112D560E0D
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FD1A0BFD;
	Sat,  6 Sep 2025 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqEVm47n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C8145B3E;
	Sat,  6 Sep 2025 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123770; cv=none; b=E3dAFNUkxfcw5doAozZ5/bl/if8X5/HqcAARsHiyz108ysgAGoJUra1Q/RbXEXPgE9LEDJTaXJsXEwQM437Y7M6K9K/flferhyxeXbxOVNzvWb/7MCoHpPIIpgfTPvVKHQSHPtoju8okLkcSUzsfRZmlSsH6Zrz8sIaRtdUYaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123770; c=relaxed/simple;
	bh=2N5oPQH0GrIyzi7ps5mcWTPe4nuxHMMFUsSOQvXSTTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYSNglJzvqMr8i+LYQSrqAlg98KBPitvmgxbcTzfcKzj9HiZIIfo3CMls1UWAQXSY4D8kFB7HyNkd+MO/VozfdI4R2uy+cLbj5GEDFG+JhP4ywj8Sv1Lk9LlC1cixrIe2rBUoEZbXwV/v1vsK+TNj22Cv2fDvxst143MISqxunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqEVm47n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F508C4CEF1;
	Sat,  6 Sep 2025 01:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757123769;
	bh=2N5oPQH0GrIyzi7ps5mcWTPe4nuxHMMFUsSOQvXSTTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AqEVm47ncbNtowEtefsD+kBgd3Mwx+H8P1sdRy/JlE9lRIYzGJaRTSq4zibX9KHwI
	 PEtjOv3Nht0n4em8lhT4914UH5ZGds2YhHwxq7DRhd6cQfWfeRLbVg97tDO1xryJFG
	 HKpLWd8dsrO5fqiGGd932WSvp/jGrVCoV3oDJC1AE8hbs8UFc3cSH+MxNCIVdlu8Mq
	 JDHvvuQZTEHCUuTzwfJPqAdM14+QvSzEqPPwHa5DjsiPvgoMmp2lz/A1UAzfavGOMc
	 VfjSbT2geNZeXkvwmsve66KVSYLxesrVFuvrrrFSIIf+wOwfnFVgeKW/1MmevCdEWZ
	 gK44hQxqXKCmA==
Date: Fri, 5 Sep 2025 18:56:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com
Subject: Re: [PATCH v5 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Message-ID: <20250905185606.42328008@kernel.org>
In-Reply-To: <20250904203502.403058-5-shenwei.wang@nxp.com>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
	<20250904203502.403058-5-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 15:35:01 -0500 Shenwei Wang wrote:
> +		if (fec_enet_alloc_buffers(ndev) < 0) {
> +			fep->pagepool_order = old_order;
> +			fep->rx_frame_size = old_size;
> +			WRITE_ONCE(ndev->mtu, old_mtu);
> +			fec_enet_alloc_buffers(ndev);

And how do you know that it will succeed now?
You can't leave the device in-operational due to reconfig request when
system is under memory pressure. You need to save the previous buffers
so that you can restore them without having to allocate.

> +			ret = -ENOMEM;
> +		}

