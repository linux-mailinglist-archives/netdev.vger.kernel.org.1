Return-Path: <netdev+bounces-116169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A689495F4
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DB51F22EE2
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3944C81;
	Tue,  6 Aug 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH0YbXnO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6053E24
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963268; cv=none; b=PXPWG/VzOIq5wGJJ8E0boSngHv5AbMQIAAx9eSk31Ac65tHha3/eSUGmaa2TKvr14Ak3bAyZDln55bJDuTBw5wWS/RVVsQ+xEPNFfwOBonc6I0DkyGVZoB6OfEvNB8cy9M+g4vzFbFY5FgHT9mDm9BOPhkV3Bc8aDtU8l6DJr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963268; c=relaxed/simple;
	bh=Tyrgnb2SyIA9EoP1O7/CWVk7+dDhPmOFCM0/YwX/e8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+kCVJYZnQsO8WBasMdqfgou5tlyprvqptS6RRH6DQ/a45Wi2rVJneitNE5axm20Jd7DHMB8YedJWnuVm4jN4zuNiQTiHlV+X/OBB3OSdGr9vXU/Jl4OEhPWaAs9choK4tqIxVp7349KwU+a7vBcpjs7ouaonLS1CfmCTwebDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH0YbXnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B82EC4AF0C;
	Tue,  6 Aug 2024 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722963268;
	bh=Tyrgnb2SyIA9EoP1O7/CWVk7+dDhPmOFCM0/YwX/e8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KH0YbXnOiFxc8LcIpEHr4ZnGm7M2p4Rp646SBhwq8g1XKH5Wj9gQQFCwMFAHrhA6V
	 P10JH2LZ1PC7bDAvTBZ1bggNQqvJxgEQJ0bhdbVPC8vVdh+Ug8vlIaIMyt2/vgx2oz
	 uw2Ppl5hKO9vqrz9hVlL28Syk9Kk8QpF0mYqd/r4p4wIK/nctgN4eIF3GSXtjpd75f
	 ZB8JBkPdNC40ekrLODrDUQPdNQBum/FpdX/NUG5k2pfdr3XEVkf+CNAoUEQzaW01YS
	 Un7Oe4wMBXfQB07Dx7n50NIxOm80egarz0EXZqv1Qf/lUWuLDmjRtPHNtYzFFE/nZz
	 NPRAtoZcPkwiw==
Date: Tue, 6 Aug 2024 09:54:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: ethtool: fix off-by-one error in max RSS
 context IDs
Message-ID: <20240806095426.6c4bcd2a@kernel.org>
In-Reply-To: <20240806160126.551306-1-edward.cree@amd.com>
References: <20240806160126.551306-1-edward.cree@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024 17:01:26 +0100 edward.cree@amd.com wrote:
> Subtract one from 'limit' to produce an inclusive maximum, and pass
>  that to xa_alloc().  Special-case limit=3D=3D0 to avoid overflow.

It can't be zero

	u32 limit =3D ops->rxfh_max_context_id ?: U32_MAX - 1;

also1 if we want to switch to exclusive I maintain we should rename the
field
also2 check that it's not 1 during registration, that'd be nonsense
also3 you're breaking bnxt, it _wants_ 32 to be a valid ID, with max 32

For a reference this is what I typed in in my tree yesterday:

-->8----

=46rom 12f932531ef138dde108656074ff6175424a912f Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 5 Aug 2024 14:39:55 -0700
Subject: net: ethtool: fix ambiguity around rxfh_max_context_id

kdoc about @rxfh_max_context_id is fairly clear that the value
is exclusive, but code feeds it into XA_LIMIT(), which treats
it as inclusive:

 * struct xa_limit - Represents a range of IDs.
 * @min: The lowest ID to allocate (inclusive).
 * @max: The maximum ID to allocate (inclusive).

The default value also appears to expect xa_limit() to be exclusive,
as U32_MAX would conflict with:

 #define ETH_RXFH_CONTEXT_ALLOC		0xffffffff

The name of @rxfh_max_context_id indicates it's inclusive
(exclusive name should probably be something along the lines
of @rxfh_max_context_cnt). Keep the name but make sure we treat
it as inclusive.

Fixes: 847a8ab18676 ("net: ethtool: let the core choose RSS context IDs")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h | 4 ++--
 net/ethtool/ioctl.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 8c89dc33d51c..d4df5ac67d65 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -740,9 +740,9 @@ struct kernel_ethtool_ts_info {
  * @rxfh_key_space: same as @rxfh_indir_space, but for the key.
  * @rxfh_priv_size: size of the driver private data area the core should
  *	allocate for an RSS context (in &struct ethtool_rxfh_context).
- * @rxfh_max_context_id: maximum (exclusive) supported RSS context ID.  If=
 this
+ * @rxfh_max_context_id: maximum (inclusive) supported RSS context ID.  If=
 this
  *	is zero then the core may choose any (nonzero) ID, otherwise the core
- *	will only use IDs strictly less than this value, as the @rss_context
+ *	will only use IDs less or equal to this value, as the @rss_context
  *	argument to @create_rxfh_context and friends.
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index e32b791f8d1c..35b7e75c2202 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1468,7 +1468,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct=
 net_device *dev,
 		}
=20
 		if (ops->create_rxfh_context) {
-			u32 limit =3D ops->rxfh_max_context_id ?: U32_MAX;
+			u32 limit =3D ops->rxfh_max_context_id ?: U32_MAX - 1;
 			u32 ctx_id;
=20
 			/* driver uses new API, core allocates ID */
--=20
2.45.2


