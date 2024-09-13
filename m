Return-Path: <netdev+bounces-128141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F3978445
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D86286319
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEEF191495;
	Fri, 13 Sep 2024 15:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAD18EFDB
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240158; cv=none; b=i9fugs9++QE+U1rhmxeWlT063kKM0rcnpXO9xukKoQmCxqehRr0FxEAsA6rfdwiMiTD7Mjx4/9r7TmYjKzgd0Fc4M/pA/7iBn2nLsYboLAzoIY0X5tekQ8Ksh+meKkYJBA4/Ljw8uK55AAmpfJ4zvD6Z/Nwhm4lA6NCPhkWh5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240158; c=relaxed/simple;
	bh=1lP4qZ/bh5rmBpEHCZM336wdfrixck7hvBaSkjw2HYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6g0PAwlhaAtjnW4OaEPfz1MZn5ilZ7GQVtRbMrA17OZX3SZyFBbu/bxu2TVDGTaXSArkw8ZjtOjXI2wLesVMzpKrU6VZrSeFr8L2pyYGSFaGlrH8KQpKyMG/j8N6l0z5rHS7QCOa1HjaFQ7CZilLTigyRPQ9bTiA6a8eRiqThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso2057568a12.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240156; x=1726844956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhOIOJSU+qybOmXl5RnB2MXxyFTR6QQo7CcRoJy0nAU=;
        b=Adm3ro8t5t5J8CxLHPqguTi8I2G1OYJGf/B8t9pB2UJ0ytv3p2TWAXoZg5uODpHmlJ
         GxQPU4jI7bwGsPKG21g3KouuC0Csbln9tYCTxNy6LcH/9Bkr6okTAwR6BRZexsCd06wc
         +M5OPuTvl6peWxe6noIKd1+yjG4RURvhj0S4NFedz7ssdajvaeZaGE/RCiTcSsUQdh8x
         pQ0JZad4BRWIfLvk66TM9sU/iKQJFONvDmjsfM8+IP3zHgmKpqzfj1YDji6e+dDrE9Cm
         AAj9tq6cj2XKUVnIgU20gh+BPMa/t/v1Y6yPt1kC/NhCwbG/sCRD+oKWVU4+NSY0Vkmt
         69OA==
X-Gm-Message-State: AOJu0YzgR9cJ4hnZYulWpwSX6U2phsqaVmrH2uAPXplVT2SpEF0rdwj/
	FWrPb5NS2LjkNQFPqyu9mTi7YLds+oyeUns/DSk15mLfFfHAbA1QLaj0
X-Google-Smtp-Source: AGHT+IFNTiqEg4vDq087UJaR26pt2109Qnr8CgI6FrFTm4b/MrTY32+3gltwZOVEWHAJqt8mwDEFJQ==
X-Received: by 2002:a17:90a:9e1:b0:2d8:a672:186d with SMTP id 98e67ed59e1d1-2db9ffb35c1mr9097917a91.20.1726240155874;
        Fri, 13 Sep 2024 08:09:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c3f57esm1875939a91.8.2024.09.13.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:15 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH net-next v1 0/4] net: devmem: TX Path
Date: Fri, 13 Sep 2024 08:09:09 -0700
Message-ID: <20240913150913.1280238-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1], sending the preliminary version of the transmit
path. It is somewhat based on [2], but at this point probably nothing
of the original patch remains. Since we are not using fake pages
anymore, I had to do the following:
1. Add new bind_tx netlink to attach dmabufs to the netdev and export id
2. Ask users to pass that id in SCM_DEVMEM_DMABUF sendmsg
3. The payload chunks are referenced via zero-based iov_base and iov_len

Note that this series should be applied on top of [3].

1: https://lore.kernel.org/netdev/CAHS8izM8e4OhOFjRm9cF2LuN=ePWPgd-EY09fZHSybgcOaH4MA@mail.gmail.com/
2: https://lore.kernel.org/netdev/20230710223304.1174642-8-almasrymina@google.com/
3: https://lore.kernel.org/netdev/ZuNgklyeerU5BjqG@mini-arch/T/#t

Cc: Mina Almasry <almasrymina@google.com>

Stanislav Fomichev (4):
  net: devmem: Implement TX path
  selftests: ncdevmem: Implement client side
  selftests: ncdevmem: Implement loopback mode
  selftests: ncdevmem: Add TX side to the test

 Documentation/netlink/specs/netdev.yaml       |  13 +
 include/linux/skbuff.h                        |  16 +-
 include/linux/skbuff_ref.h                    |  17 +
 include/net/devmem.h                          |   1 +
 include/net/sock.h                            |   1 +
 include/uapi/linux/netdev.h                   |   1 +
 kernel/dma/mapping.c                          |  18 +-
 net/core/datagram.c                           |  52 ++-
 net/core/devmem.c                             |  73 ++++-
 net/core/devmem.h                             |  28 +-
 net/core/netdev-genl-gen.c                    |  13 +
 net/core/netdev-genl-gen.h                    |   1 +
 net/core/netdev-genl.c                        |  65 +++-
 net/core/skbuff.c                             |  21 +-
 net/core/sock.c                               |   5 +
 net/ipv4/tcp.c                                |  38 ++-
 net/vmw_vsock/virtio_transport_common.c       |   2 +-
 tools/include/uapi/linux/netdev.h             |   1 +
 tools/testing/selftests/drivers/net/devmem.py |  37 ++-
 .../testing/selftests/drivers/net/ncdevmem.c  | 307 ++++++++++++++++--
 20 files changed, 651 insertions(+), 59 deletions(-)
 create mode 120000 include/net/devmem.h

-- 
2.46.0


