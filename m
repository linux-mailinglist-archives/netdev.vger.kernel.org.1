Return-Path: <netdev+bounces-219431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC9B414AA
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1806547C4E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5922D6E55;
	Wed,  3 Sep 2025 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc9uqEt1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2928368A
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879555; cv=none; b=sMCGkOxeWGFUb5n4fFAhAm/+phkeGTNc+JU7xu2E/R3Z9aLS8GNQPvA1BGn4mV6JTXCr2Gd9sTiyVd4sT02bTErckGD9B+NLHjtI3ccqS/twF8+y0l2cq4wSoLQQV49mgT8kAqsSQcups13db0HBG8mQZGM+jUs83KBdv1uitqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879555; c=relaxed/simple;
	bh=XOapVgaqOVcZ5SeMIrHRggXFpGYHiKdTB7LZfT4Jj+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7wQUvoMCld5SjJs1k1ZSy110zmxA+uY8wCM0QKezeXll2w8vnnXUSUh+DWz3qEwvXUwM6ELOmCdO6tH8OiZ2DQK4eseB57zoERk4tonc2/0SMF0B2YoWz3Kj9rRvs3PUB2lgsb422MPnx+G13GGIGpaecQbvow/qQ+bdu8y2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc9uqEt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E70C4CEF0;
	Wed,  3 Sep 2025 06:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756879554;
	bh=XOapVgaqOVcZ5SeMIrHRggXFpGYHiKdTB7LZfT4Jj+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pc9uqEt19PGlR2klcNPomheSUEMk1tmRZP4CgOQlf3Jf0bxmHcndJkg7yRv5JJyzB
	 aeR46G6i5VT+uvvKTX3LKWxj5fBY82FQPofvef98nMNAKkYOWwVQT86fo7YKNftKlq
	 1ez4dU6QNRUWdZlOFx46cq6r5llER49VUUlX9xe9D27ZUEaoe3rO9apyGce4ipkHU8
	 JE+tG/BELh/Tn4jqI/PbjG4OSDW6vXXHcCPrGNpz9eQMF03LhgZTg4vUZDmpgOY9iK
	 bHL7C9YaTUjhe4XUzI6jXoRwcIcjwQsmA7w0cGBdJIGG47f7E2g/VOVu4nKZlWd56N
	 bzSgqrJL/AXrQ==
Date: Tue, 2 Sep 2025 23:05:52 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v10 11/19] net/mlx5e: Support PSP offload
 functionality
Message-ID: <aLfawAgTtPDK_ZWf@x130>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <20250828162953.2707727-12-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250828162953.2707727-12-daniel.zahka@gmail.com>

On 28 Aug 09:29, Daniel Zahka wrote:
>From: Raed Salem <raeds@nvidia.com>
>
>Add PSP offload related IFC structs, layouts, and enumerations. Implement
>.set_config and .rx_spi_alloc PSP device operations. Driver does not need
>to make use of the .set_config operation. Stub .assoc_add and .assoc_del
>PSP operations.
>
>Introduce the MLX5_EN_PSP configuration option for enabling PSP offload
>support on mlx5 devices.
>
>Signed-off-by: Raed Salem <raeds@nvidia.com>
>Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>---
>
>Notes:
>    v7:
>    - use flexible array declaration instead of 0-length array declaration
>      in struct mlx5_ifc_psp_gen_spi_out_bits
>    v4:
>    - remove unneeded psp.c/psp.h files
>    - remove unneeded struct psp_key_spi usage
>    v1:
>    - https://lore.kernel.org/netdev/20240510030435.120935-10-kuba@kernel.org/
>
> .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 ++
> .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +
> drivers/net/ethernet/mellanox/mlx5/core/en.h  |   3 +
> .../ethernet/mellanox/mlx5/core/en/params.c   |   4 +-
> .../mellanox/mlx5/core/en_accel/psp.c         | 140 ++++++++++++++++++
> .../mellanox/mlx5/core/en_accel/psp.h         |  47 ++++++
> .../mellanox/mlx5/core/en_accel/psp_offload.c |  44 ++++++
> .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 ++
> drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
> .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
> .../mellanox/mlx5/core/steering/hws/definer.c |   2 +-
> include/linux/mlx5/device.h                   |   4 +
> include/linux/mlx5/mlx5_ifc.h                 |  95 +++++++++++-
> 13 files changed, 361 insertions(+), 7 deletions(-)
> create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
> create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_offload.c
>

[...]

>
>+struct mlx5_ifc_psp_cap_bits {
>+	u8         reserved_at_0[0x1];

The below cap is not set or checked in the whole series:
The only occurrence is this definition.

$ git grep psp_crypto_offload tmp/psp
tmp/psp:include/linux/mlx5/mlx5_ifc.h:  u8 psp_crypto_offload[0x1]; /* Set by the driver */

This should be at least checked in mlx5_is_psp_device();

>+	u8         psp_crypto_offload[0x1]; /* Set by the driver */

This comment is not true, the cap is advertised by FW on a psp
capable device. Nothing is needed from driver.

On CX7 and CX8 (FW already PSP capable, without this series):

$ mlx5ctl 0000:17:00.0 cap -i cmd_hca_cap  | grep psp
         psp_old: 0x0 (0)
         psp: 0x1 (1)

$ mlx5ctl 0000:17:00.0 cap -i psp_cap
Node: psp_cap
         psp_crypto_offload: 0x1 (1)
                             ^^^^^^^ (Advertised by FW already)
         psp_crypto_esp_aes_gcm_256_encrypt: 0x1 (1)
         psp_crypto_esp_aes_gcm_128_encrypt: 0x1 (1)
         psp_crypto_esp_aes_gcm_256_decrypt: 0x1 (1)
         psp_crypto_esp_aes_gcm_128_decrypt: 0x1 (1)
         log_max_num_of_psp_spi: 0xb (11)

On Cx6-LX (Crypto, but not psp capable):
$ mlx5ctl 0000:97:00.0 cap -i cmd_hca_cap | grep -E "psp|crypto"
         psp_old: 0x0 (0)
         psp: 0x0 (0)
         crypto: 0x1 (1)

$ mlx5ctl 0000:97:00.0 cap -i psp_cap
Error : opcode 0, syndrome 0x3d6c79 fw status 3 status 0
query cap (0x1e) failed opcode 0x100 opmod 0x3d

I will clean this up as part of my mlx5-next PR, my cleanup will cause a
conflict when re-basing this series on top of the PR+netdev, so just take
my changes "current" to resolve the conflict.

>+	u8         reserved_at_2[0x1];
>+	u8         psp_crypto_esp_aes_gcm_256_encrypt[0x1];
>+	u8         psp_crypto_esp_aes_gcm_128_encrypt[0x1];
>+	u8         psp_crypto_esp_aes_gcm_256_decrypt[0x1];
>+	u8         psp_crypto_esp_aes_gcm_128_decrypt[0x1];
>+	u8         reserved_at_7[0x4];
>+	u8         log_max_num_of_psp_spi[0x5];
>+	u8         reserved_at_10[0x7f0];
>+};


