Return-Path: <netdev+bounces-172995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C262A56CC9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCE91786CC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714702206B1;
	Fri,  7 Mar 2025 15:57:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7EBDF71;
	Fri,  7 Mar 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363049; cv=none; b=he6XDGANBm5wvj/VGk7lwy3o0si6lkiBleVPav9K0AfRtHtBggLwZV0atzgdX4UMc1RRfOLXuuIY664JXER+vBbf74M1/b0YFsoFEQ/059ySP/jh7CIMHAjHtxwhNa5GuNh+tEl2d1TpNZtwOlequWudnI4Jh09ilafYwOF8zaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363049; c=relaxed/simple;
	bh=SxLIPGY5MWaFjbH5jwXnYCzIgIY8IZBhzMTbt9T4+M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tj1eccqq5DATGjs1/sSoAKcOhp/tLNPk/oUGh7IhE8IFEFs/LPPi75eSap5GR6U3kCq7BKF4oeExJJxHCJzfAAjIA+UUfgrQuLo2taD9olaUifVhAfkGjmoZnju9wzy+eeOTaiiSLGp+iPsOx2GVq456tG1DTxRpLvD5p8CMKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff087762bbso3125370a91.3;
        Fri, 07 Mar 2025 07:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363046; x=1741967846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioESNgWfxiXU5JD8t0Jb69ZxEn0ATTho+YLv7pdcm48=;
        b=xL+p2l7WFfM9d4hcfDV5aAarHOA6u8f2lrKR6MZHgblk6+Dn9Hq+GhhnbrHYoloBqw
         dulZXgJI0UiXamj1fm9bxR3TiWUFSkGjqJ+7kNuDxMrz7y6yT6dpXfp34BAnRUyaxcI4
         uAgVvqtdl6VTiAVk0Gc0kh6NOriVwQAq7NveFBWRQDaCj66lOZ+qFWtSrR3lj7a5Gj8K
         QDE7qxnnfwk0TN/7QotY+HxACeCDL9jMf7q1BF9AbUMkp814QFhMjGt7OsAal6/qfaxW
         jVekGJk1r5/pKGxe4HHft8ZLM2Y0Cy9y6FH1RWBqG4pCNIh70BLC3j0YVq7YazNTQT1C
         Cx8A==
X-Forwarded-Encrypted: i=1; AJvYcCXekNFeJijWZzg979xMqc1H17DALdsOO3rNCybGJ5H7JNND/6IRYhhG426vThZxBAj7n5m7f+XpuL5sHvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPiC2a8aJirzIutUnO7O6J/oQy8wfbaxzZTfS1/c4nVvauPnG2
	R3JPpChjmr8oiABYiqjw6iP8zmnBPeGW3Zvi15/JUZYZ5d83vhmyA+tI
X-Gm-Gg: ASbGncvStf4s/K7WNKNBDCh5sd2oxXOJayIbvu5sk/yr5m6cs1A8y9jg399qpqJ+aUB
	ujss3p2S6CC22ly7AtuUT5DqZu0m/ALQj/E/ORIvZjXaYqIoLpfbYHk9dR3+kGcoUWTlCluW7Co
	EWB9mYzjCQk13x7HmpSUb6jak/rAAcFS/kQ/csOdrlpRenLSxUPJiBKzyWx2zow3ak8BYDcyGp0
	Vr9loRSpDIv5JVo7znjf+dbp+7OkFNx6k4y0N7TtxKohsg47zo3opX8v/vGoon7cq5ApSUQCjLD
	taDX6kGs355S8O9LRbBsjk+Xd35JHzHuor9MUSGGmQZs
X-Google-Smtp-Source: AGHT+IELI3rN3kvPAEHX77hKWOPAf7aE/r9mym2Y+5j5YTj5NowySDBEa18BajbMuxXI3W2bjBQkVg==
X-Received: by 2002:a17:90b:3950:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2ff7ce82f03mr6410761a91.10.1741363046199;
        Fri, 07 Mar 2025 07:57:26 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff693f7f0bsm3208118a91.46.2025.03.07.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:57:25 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	jdamato@fastly.com,
	sdf@fomichev.me,
	xuanzhuo@linux.alibaba.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk
Subject: [PATCH net-next v1 0/4] net: remove rtnl_lock from the callers of queue APIs
Date: Fri,  7 Mar 2025 07:57:21 -0800
Message-ID: <20250307155725.219009-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All drivers that use queue management APIs already depend on the netdev
lock. Ultimately, we want to have most of the paths that work with
specific netdev to be rtnl_lock-free (ethtool mostly in particular).
Queue API currently has a much smaller API surface, so start with
rtnl_lock from it:

- add mutex to each dmabuf binding (to replace rtnl_lock)
- protect global net_devmem_dmabuf_bindings with a new (global) lock
- move netdev lock management to the callers of netdev_rx_queue_restart
  and drop rtnl_lock

Cc: Mina Almasry <almasrymina@google.com>

Stanislav Fomichev (4):
  net: create netdev_nl_sock to wrap bindings list
  net: protect net_devmem_dmabuf_bindings by new
    net_devmem_bindings_mutex
  net: add granular lock for the netdev netlink socket
  net: drop rtnl_lock for queue_mgmt operations

 Documentation/netlink/specs/netdev.yaml   |  4 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  4 +--
 drivers/net/netdevsim/netdev.c            |  4 +--
 include/net/netdev_netlink.h              | 12 +++++++
 net/core/devmem.c                         | 32 ++++++++---------
 net/core/netdev-genl-gen.c                |  4 +--
 net/core/netdev-genl-gen.h                |  6 ++--
 net/core/netdev-genl.c                    | 42 ++++++++++-------------
 net/core/netdev_rx_queue.c                | 15 +++-----
 9 files changed, 63 insertions(+), 60 deletions(-)
 create mode 100644 include/net/netdev_netlink.h

-- 
2.48.1


