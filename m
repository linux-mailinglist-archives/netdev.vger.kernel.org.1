Return-Path: <netdev+bounces-20182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E775E2CB
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 17:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9BA28174A
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968171850;
	Sun, 23 Jul 2023 15:07:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31310F4
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 15:07:29 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF22F3
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 08:07:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99b9421aaebso7324766b.2
        for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690124846; x=1690729646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NErtpmKZLDudWNuVZ/0OM4T/FxzlnDuRfRYmitD82g=;
        b=dwgbO6GKaHAqW+LFtaslcJ4q3w+T5gxHonbMLkXZ98QEsonyJ+G99ojQFbOVzzzgB3
         2oH2Jg1gDQdoRjxW/yI33vo/b4O/EycXHp46cyf4XdHD24J/77TMkDYPYkMouQcGm/oL
         0KXUMKH4LgcdH+23eBfhhQUbXJdj53/CBiwj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690124846; x=1690729646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NErtpmKZLDudWNuVZ/0OM4T/FxzlnDuRfRYmitD82g=;
        b=gcZCwCXZeHSQf0+9q52TEsyB7ZBz17dyIzdYc8Yvi5RnWV57MkHL2YHs50r3ltQOrT
         oAJtk0bdK6ZJ2PHO1Cqpi7EYjGIu7R/wGVy/1lNmsUdmE9R4uSD7x8omF1XLHb3+Jpha
         uOuTXQkwSFjSk0/lW2MTOpBYhyPxFGHkPchfs9S3+MS+3NCcgsFxtRQ047to2TebIU30
         GTuopad0RwaGbv8UOkKv4mHth4AOb0mWFr+OzCT8iNEsPwDI8GxO3Df1Ztv853aje9Dp
         XN5rVc9GB2Ogc6QvOUqaMSGQ/yoUURCer4jJ+DFItyrTbMfVDzEfLqoCD8S01WzzmQor
         tUsg==
X-Gm-Message-State: ABy/qLafxUTrcDGcR5r/zdrD4dPB1MV98MId0TzhoiAPZryjNwrxwTqx
	JGv+rJ8xAb81VQG0+bbiMiljxvI1A3IZRtFgJWEZS7XuBtp+iOBk2TVkLLPX3+iFuulw2qwJJPD
	2RzP2M/QtdST5DdE4BBP5VOUa9UdRtxhjQ5PMDNR7BdpQkNyNfroMii2ZoNQlz8lBHx2MSbGwyW
	DM
X-Google-Smtp-Source: APBJJlG9eVdbuWWsSvWOHjNaGAWjri0ArafcUcfiImigaOveP4JfxckC2J1CP/DsZ8r8rC3PrFYfeQ==
X-Received: by 2002:a17:906:9bf6:b0:988:6e75:6b3d with SMTP id de54-20020a1709069bf600b009886e756b3dmr7208827ejc.33.1690124845756;
        Sun, 23 Jul 2023 08:07:25 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709064f0a00b009929d998abcsm5227691eju.209.2023.07.23.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 08:07:25 -0700 (PDT)
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
	bhutchings@solarflare.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [net 0/2] rxfh with custom RSS fixes
Date: Sun, 23 Jul 2023 15:06:56 +0000
Message-Id: <20230723150658.241597-1-jdamato@fastly.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Greetings:

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

The patches include the relevant fixes tags, as I think both commits are
fixing previous code, but if this change is preferred for net-next I can
resend.

Thanks.

Joe Damato (2):
  net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
  net/mlx5: Fix flowhash key set/get for custom RSS

 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 23 +++++-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  5 +-
 .../mellanox/mlx5/core/en_fs_ethtool.c        | 33 +++++---
 net/ethtool/ioctl.c                           | 75 ++++++++++---------
 4 files changed, 84 insertions(+), 52 deletions(-)

-- 
2.25.1


