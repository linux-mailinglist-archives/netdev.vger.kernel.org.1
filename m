Return-Path: <netdev+bounces-57665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E4813C8B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 22:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3901F22676
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6C46ABB8;
	Thu, 14 Dec 2023 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2Frw4SyT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE66D1C4
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d359f04514so12593355ad.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 13:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702589093; x=1703193893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmoSpfucyzPZuwkoFuJHyDB0eTE1Vp5ZJ3f3ybkYVL0=;
        b=2Frw4SyTB0vMmuS++cPhcqYC+sSp9lmyuCH5/aYEwjSvwP1N8tOsZvVDeJqZNIgwXn
         5BCsw74G0Zo62XlpOSHugeLNYVz2jBFJnM5MPLfPzZHzVkbGkzkgvpum5ycrwh4dftCz
         urVdzmwtb/Bt2/28sKeSgmv63og3HX7d30gl5nhskvxn/TxPxITj0PGdB+7OGqhxyIjl
         C1ouEGAzNh+l5L2//eXHVwjx/AFIZSrSDJAaUs0Bh154BGpvenO6CAWHDi+myYKAzM2q
         saOiS1LuayLwTwfygh99c60VUP7M6CrvUr0tMAavfCDc0j8/D64bLgwm5TT7QdNww6pC
         Ljmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589093; x=1703193893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmoSpfucyzPZuwkoFuJHyDB0eTE1Vp5ZJ3f3ybkYVL0=;
        b=HYxmVzPuYX6WmuRm/7QXcDAaVqXorBI/HEJ4ahsoRVo4se7BLW5gz2xIjYZZdtftpX
         kZzdHd8vqaqhf/buLI/f0HjcFuWqMmdsHq1xofT0e+MPPNgaW7odQPfLwFw0IfeX0h/7
         4uHQGVEBhaml0nN6YLKXaePTQOL5PqBtXLGYS/dvv4/vzNok4WnHuLToG/ImFfS573bJ
         pP595YG/LjrIOaxBQ2lGjvRAccQK0tSw7zLtt4yjeA+ob8NduplTKoW63Bwezv8KAmbg
         VsUap5arYb59NbgaUmCFXvJ52U+CINw4Hlog8VPowYVXJZzeNxqoyg4u2IRF58emG7ML
         kI0w==
X-Gm-Message-State: AOJu0YyT7O8lAIvyBpZkZcdmq9rEstWnIldOUynm6QfrIDrWUyZusxGk
	4Mdx+tOCxtco+IsaKSnmajWSAg==
X-Google-Smtp-Source: AGHT+IHvjpFh/z2a6fMqi5IeLw+QplVChEKgG5tyejGyjC/Zq00HCHx0bbIfK1Ak+SkgZNh6EASnNA==
X-Received: by 2002:a17:903:230b:b0:1d3:6c48:7f5e with SMTP id d11-20020a170903230b00b001d36c487f5emr1255899plh.121.1702589092855;
        Thu, 14 Dec 2023 13:24:52 -0800 (PST)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001d08e08003esm12865112plx.174.2023.12.14.13.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:24:52 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 0/4] netdevsim: link and forward skbs between ports
Date: Thu, 14 Dec 2023 13:24:39 -0800
Message-Id: <20231214212443.3638210-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the ability to link two netdevsim ports together and
forward skbs between them, similar to veth. The goal is to use netdevsim
for testing features e.g. zero copy Rx using io_uring.

This feature was tested locally on QEMU, and a selftest is included.

---
v2->v3:
- take lock when traversing nsim_bus_dev_list
- take device ref when getting a nsim_bus_dev
- return 0 if nsim_dev_peer_read cannot find the port
- address code formatting
- do not hard code values in selftests
- add Makefile for selftests

v1->v2:
- renamed debugfs file from "link" to "peer"
- replaced strstep() with sscanf() for consistency
- increased char[] buf sz to 22 for copying id + port from user
- added err msg w/ expected fmt when linking as a hint to user
- prevent linking port to itself
- protect peer ptr using RCU

David Wei (4):
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports
  netdevsim: add Makefile for selftests

 MAINTAINERS                                   |   1 +
 drivers/net/netdevsim/bus.c                   |  17 +++
 drivers/net/netdevsim/dev.c                   |  88 +++++++++++++
 drivers/net/netdevsim/netdev.c                |  29 ++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |  18 +++
 .../selftests/drivers/net/netdevsim/peer.sh   | 123 ++++++++++++++++++
 7 files changed, 274 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


