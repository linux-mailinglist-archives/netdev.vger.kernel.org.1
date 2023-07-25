Return-Path: <netdev+bounces-21047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE17623FF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870FE28199D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A7026B60;
	Tue, 25 Jul 2023 20:57:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607326B17
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:57:19 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10EB1736
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:57:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bc0da5684so8562866b.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690318636; x=1690923436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0e2cyChRqGI3tRbPoTL2xt8a8S3w5QsHlIz9nls3pyY=;
        b=jqTc+EfXLmgZjGC5kaOFEqmUgycSNXUK+9S9FdyQ0cMymNN2iWk/hArhhAgo9rTNHF
         H9QrAzXDh2icbAEwLauwyV9rLpcyupXjv1T+/GLSt6se8WoJTJ4MILxmmeuDD6l4brg0
         eWxMj2P1BZkN/Xh0xXyWejzikAoGhzT5BgZro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318636; x=1690923436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0e2cyChRqGI3tRbPoTL2xt8a8S3w5QsHlIz9nls3pyY=;
        b=CdR27ix12MYtc8qoB+7hYKdYBi9sQfj0lRSboG9Mdtnjm9EUC38Je5ueY4oCIp6I8P
         r3JNBxa5lui3TyDhr9V4lyivKTvTRK6N8ehUitFYfe7UJcR4dmoq0WkiyHryW6huZ7B3
         N5GiBBVgIjuownMJaRQfEyVjy0uJgTUkAgGH5DkUZKqwVIzwKP4Cm4I+6YEVapVocpvc
         M3oxkmHgz5KVyMeogM6Fxb/iqHDpJNGcJnTEt/l5mf/uVRnvUIlfhTXhUfSZSOYpajmG
         sxwytojsfbYkYmpYwHjqraFqOL43kErk50jyqJYu0IeTwJ6zTZlIiOetckFAn81QcPUe
         NLhA==
X-Gm-Message-State: ABy/qLYC4eiJkwrkgGeeFvzjOSbwXzTlzuOEWmQK9sKb2jgY8QvGpFut
	TP4AcXEzVdCiXst4bO3LFQ3dHo4B5z0j8v3Bsu2O8j5m7ZZKhuDUXBlLSOkAOJq0dJ0ALCsE4+C
	nKIv68BQt1PftX8xZJdbz1CLaYWwMVbdnnR9DTITDMsnR6Ot0/4ZTVaSNNfIjbvH+elX1vD7+EY
	H7
X-Google-Smtp-Source: APBJJlFk6+OBdgoFmsams0uifI3NTvtks5cjyNRPRnxBISZaHzsVE9PQwnimrnJm2PliM0sy8Q6+7A==
X-Received: by 2002:a17:906:5594:b0:957:1df0:9cbf with SMTP id y20-20020a170906559400b009571df09cbfmr13487ejp.19.1690318636028;
        Tue, 25 Jul 2023 13:57:16 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709062dd300b0097073f1ed84sm8704186eji.4.2023.07.25.13.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:57:15 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	ecree@solarflare.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	leon@kernel.org,
	pabeni@redhat.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next v2 0/2] rxfh with custom RSS fixes
Date: Tue, 25 Jul 2023 20:56:53 +0000
Message-Id: <20230725205655.310165-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Greetings:

Welcome to v2, now via net-next. No functional changes; only style
changes (see the summary below).

While attempting to get the RX flow hash key for a custom RSS context on
my mlx5 NIC, I got an error:

$ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
Cannot get RX network flow hashing options: Invalid argument

I dug into this a bit and noticed two things:

1. ETHTOOL_GRXFH supports custom RSS contexts, but ETHTOOL_SRXFH does
not. I moved the copy logic out of ETHTOOL_GRXFH and into a helper so
that both ETHTOOL_{G,S}RXFH now call it, which fixes ETHTOOL_SRXFH. This
is patch 1/2.

2. mlx5 defaulted to RSS context 0 for both ETHTOOL_{G,S}RXFH paths. I
have modified the driver to support custom contexts for both paths. It
is now possible to get and set the flow hash key for custom RSS contexts
with mlx5. This is patch 2/2.

See commit messages for more details.

Thanks.

v2:
- Rebased on net-next
- Adjusted arguments of mlx5e_rx_res_rss_get_hash_fields and
  mlx5e_rx_res_rss_set_hash_fields to move rss_idx next to the rss
  argument
- Changed return value of both mlx5e_rx_res_rss_get_hash_fields and
  mlx5e_rx_res_rss_set_hash_fields to -ENOENT when the rss entry is
  NULL
- Changed order of local variables in mlx5e_get_rss_hash_opt and
  mlx5e_set_rss_hash_opt

Joe Damato (2):
  net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
  net/mlx5: Fix flowhash key set/get for custom RSS

 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 25 +++++--
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  7 +-
 .../mellanox/mlx5/core/en_fs_ethtool.c        | 33 +++++---
 net/ethtool/ioctl.c                           | 75 ++++++++++---------
 4 files changed, 86 insertions(+), 54 deletions(-)

-- 
2.25.1


