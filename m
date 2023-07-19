Return-Path: <netdev+bounces-18924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66617759187
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35EE281633
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9F111BB;
	Wed, 19 Jul 2023 09:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E410961
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DB2C433C7;
	Wed, 19 Jul 2023 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689758824;
	bh=HkdsbiYan4Z2/PiV2JAbE+Eka1wHoCrZ2OTOxBgPknE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZGAkSzOo6rUUEWspehXeIemCN6WtDGto6aiLLXI/IpNqYgfLolAqrPpZXZBFcKekw
	 n+mtiyd5BLX4By9SnPv1y76fIaQcFKusWC2LVB6tC6rPiV6n+vlLMxudJSpTInRzit
	 pWL1oBtc7mTJsgcnzCEYQwDmHFjo4DhbnvqRb3oscCBMtL5W/U/fNySAX1Z1cCeDhk
	 mTI4ax5WVoWBrrL0wBqhgFqPj9itSnLkNEWbFfHhoaVprHDUq0Qt8PQeEst4WDl1lw
	 wPtzjj0uIdQkr60MrWQdwatE1cLNrC1CzuIPhOmwbIG8Y/zeq2KmyXr/P7qo5wK5kJ
	 EU8eByXIBq07g==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>,
	Ilia Lin <quic_ilial@quicinc.com>
Subject: [PATCH net-next 0/4] Support UDP encapsulation in packet offload mode
Date: Wed, 19 Jul 2023 12:26:52 +0300
Message-ID: <cover.1689757619.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

As was raised by Ilia in this thread [1], the ESP over UDP feature is
supported in packet offload mode. So comes this series, which adds
relevant bits to the mlx5 driver and opens XFRM core code to accept
such configuration.

NAT-T is part of IKEv2 and strongswan uses it automatically [2].

[1] https://lore.kernel.org/all/20230718092405.4124345-1-quic_ilial@quicinc.com
[2] https://wiki.strongswan.org/projects/1/wiki/NatTraversal

Leon Romanovsky (4):
  net/mlx5: Add relevant capabilities bits to support NAT-T
  net/mlx5e: Check for IPsec NAT-T support
  net/mlx5e: Support IPsec NAT-T functionality
  xfrm: Support UDP encapsulation in packet offload mode

 .../mellanox/mlx5/core/en_accel/ipsec.c       | 27 +++++++-
 .../mellanox/mlx5/core/en_accel/ipsec.h       | 12 +++-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 61 ++++++++++++++-----
 .../mlx5/core/en_accel/ipsec_offload.c        |  6 ++
 include/linux/mlx5/mlx5_ifc.h                 |  7 ++-
 net/xfrm/xfrm_device.c                        | 13 ++--
 6 files changed, 100 insertions(+), 26 deletions(-)

-- 
2.41.0


