Return-Path: <netdev+bounces-40462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF087C772B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E72282B74
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF303B2BF;
	Thu, 12 Oct 2023 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t98Na4Tq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58A28E16;
	Thu, 12 Oct 2023 19:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BF2C433C8;
	Thu, 12 Oct 2023 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140034;
	bh=7n2CxZhl+eoS8X8gkxaqlmbFhLFf2ISZBlRCSOTo8i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t98Na4Tqm6qoMJQAufLVj6nJ6iFLbGgx2eGh14SC1P6FLTqHA5bE5KPc0esQLMsP5
	 hEVhvOuw51n1fIopmRchWfoYWkn+QswLVoT8Ben4KBJ7S0DKgKpTEZb7b3ee1fkDXG
	 HagesHhRuMHkIL7C95Gg9EYg1hAHkRjqpfzrVbe6snwhh6Y06IQ3TLswu7+svqA39l
	 iiAjwir8z5gk2n5VfliHc4OVXOuLnBKQwAtAJyyo3y6G2G9aDlD5LUM+UK78evnqhX
	 PesFF3sm+22h+QRjvQNoPkacmpudmd4srs/8hyIdEqhLkM3poYDFXNN+Lk6socaVxT
	 9qw/byiPHhc9w==
Date: Thu, 12 Oct 2023 12:47:14 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_core: replace deprecated strncpy with strscpy
Message-ID: <ZShNQuRWSDiw2bF7@x130>
References: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>

On 11 Oct 21:04, Justin Stitt wrote:
>`strncpy` is deprecated for use on NUL-terminated destination strings
>[1] and as such we should prefer more robust and less ambiguous string
>interfaces.
>
>We expect `dst` to be NUL-terminated based on its use with format
>strings:
>|       mlx4_dbg(dev, "Reporting Driver Version to FW: %s\n", dst);
>
>Moreover, NUL-padding is not required.
>
>Considering the above, a suitable replacement is `strscpy` [2] due to
>the fact that it guarantees NUL-termination on the destination buffer
>without unnecessarily NUL-padding.
>
>Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>Link: https://github.com/KSPP/linux/issues/90
>Cc: linux-hardening@vger.kernel.org
>Signed-off-by: Justin Stitt <justinstitt@google.com>
>---
>Note: build-tested only.
>
>Found with: $ rg "strncpy\("
>---
> drivers/net/ethernet/mellanox/mlx4/fw.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
>index fe48d20d6118..0005d9e2c2d6 100644
>--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
>+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
>@@ -1967,7 +1967,7 @@ int mlx4_INIT_HCA(struct mlx4_dev *dev, struct mlx4_init_hca_param *param)
> 	if (dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_DRIVER_VERSION_TO_FW) {
> 		u8 *dst = (u8 *)(inbox + INIT_HCA_DRIVER_VERSION_OFFSET / 4);
>
>-		strncpy(dst, DRV_NAME_FOR_FW, INIT_HCA_DRIVER_VERSION_SZ - 1);
>+		strscpy(dst, DRV_NAME_FOR_FW, INIT_HCA_DRIVER_VERSION_SZ);
> 		mlx4_dbg(dev, "Reporting Driver Version to FW: %s\n", dst);
> 	}
>
>
>---
>base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
>change-id: 20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-67809559dd1a
>
>Best regards,
>--
>Justin Stitt <justinstitt@google.com>
>

Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>


