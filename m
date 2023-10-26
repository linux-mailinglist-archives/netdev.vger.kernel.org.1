Return-Path: <netdev+bounces-44596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AE37D8BFF
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 01:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBC6282023
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 23:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199CA3E01E;
	Thu, 26 Oct 2023 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n878+hnC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FA14F9D
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437DCC433C7;
	Thu, 26 Oct 2023 23:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698361201;
	bh=Tprv2HEJ1ZQn4DR9o0zCe+RP/h3cr0NDKFi8qh7NFT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n878+hnCauWva1JmpNtSNeJSFptlrbAncruHiZeq6+iA/qqnOtPfpN8Zo68DICvjY
	 iVYB1fg0c8D3R7LhJlNigqXI9SuklS3DJe9XTug7GpXAO8QdFT8dXdNIf0fP+pEW8d
	 R0rmEkZC6Zom5Wwnj3VCz1TCOb1chfI1qr/TwgNlu0OGm7Kr9plL+ajixRG2BuVpWq
	 4iN/adr/NLCU5WGYo+n1jy5RZPknZDxi4aYGs/We/sheVLyNamBTE338mowP3CPI//
	 XgnYi1jynEhBvLoULHVFq2XNCL4gEG8jiKvTCGA3/UiqU2qEXTe9W5B6T/C4nbCNWV
	 qHQx5denoyBqg==
Date: Thu, 26 Oct 2023 16:00:00 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cruz Zhao <cruzzhao@linux.alibaba.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [PATCH net] net/mlx5e: fix double free of encap_header
Message-ID: <ZTrvcHEC/rU1G4ct@x130>
References: <20231025032712.79026-1-dust.li@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231025032712.79026-1-dust.li@linux.alibaba.com>

On 25 Oct 11:27, Dust Li wrote:
>When mlx5_packet_reformat_alloc() fails, the encap_header allocated in
>mlx5e_tc_tun_create_header_ipv4{6} will be released within it. However,
>e->encap_header is already set to the previously freed encap_header
>before mlx5_packet_reformat_alloc(). As a result, the later
>mlx5e_encap_put() will free e->encap_header again, causing a double free
>issue.
>
>mlx5e_encap_put()
>    --> mlx5e_encap_dealloc()
>        --> kfree(e->encap_header)
>
>This happens when cmd: MLX5_CMD_OP_ALLOC_PACKET_REFORMAT_CONTEXT fail.
>
>This patch fix it by not setting e->encap_header until
>mlx5_packet_reformat_alloc() success.
>
>Fixes: d589e785baf5e("net/mlx5e: Allow concurrent creation of encap entries")
>Reported-by: Cruz Zhao <cruzzhao@linux.alibaba.com>
>Reported-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>Signed-off-by: Dust Li <dust.li@linux.alibaba.com>

Applied to net-mlx5

