Return-Path: <netdev+bounces-66065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6906A83D201
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA54A1F25F6C
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF2764C;
	Fri, 26 Jan 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="J4ggHKNA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C745387
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232241; cv=none; b=rT0YdLs2Rcaf/eAXskZcc00TPQdBEhMrsJcgtNmxUmv2QR2dB7CiL2l3Bm29B7R95TIHI79gt2wGwM6nW0AItkwlf3LJq92D+RM7FigVu/ZzsAAeRecKj5m70VwU35ZSLXxQqeg9wxkALVhj66RuLl/Lfg+6DVVwIl8D4q8g+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232241; c=relaxed/simple;
	bh=s+XLf0ILeQlN1rBQw/th1nGxtGVIVnbXsRItTjxA2fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UDJz8yxvYWsq2ySPgW/1fiXHhtsDPRdS+qvvx8k1lysv9yGPFQUceLWBZcVB7Y2OPmAhCPmcMiqWQ0pRfDTOiGncz11ByGXEeZfR5nCRQrHrubKTxA4+NeswKWAOJET2iAzHeCoNiYVDU/XfErTP9AyLr9wdvaPSKfjYLqVu2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=J4ggHKNA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7881b1843so18821905ad.3
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 17:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706232239; x=1706837039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PgxW0rsOig/8+DlpkiKfg3LqjPRVFbwptWTCI6OHQo=;
        b=J4ggHKNAKqb3lvlQD78ADegwBUbMXJp8rDt7quW1BFedvM0jXM4mC9U+kcWNfBgHxA
         OcrzylGCepzdcMKwO2Lj+WpQfc30LPmTzMP1ddXZkNLKNAF4wPRORO0k7HSpN2MHwMmm
         M7uvgDWT9aSeqhG6YgK4nD0OEj07KPvVZvPScpzZhuVbiggZ0bNJR6NUWDCW93WQe6aP
         Xk6VmNRapsf9l57OnwyfLpB2xcAUwQB7sE4jtl6RE2TF9wsPhkQyEfj5d2AqkGqO6/BD
         sra0wkdK2hlYdouKDmxgy97sv9PGzvdr2/agvJSkHRIMO91GBnZyYYvZFkjzc7kmUcOH
         NW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706232239; x=1706837039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PgxW0rsOig/8+DlpkiKfg3LqjPRVFbwptWTCI6OHQo=;
        b=fbT3Ox+6LxeV/+XuCSgrQ3S0zOPodGaVHJqDTOwvyCl648yXPEbGedlesOB3ZEADlW
         q605eIw1LBx4Jrty5voEn+IFfsnBN4/uC3+d6VWDh/mkJJbQ8d06vXfWBN/BUUcIG+Zs
         dEQXkGI05eiTXDLX9wB7atOXhhcD2k19UMGg/k7BFRRxAuwhlc6uv9fx9sOEyNxUZNeP
         0TqUXLw/LSoSrv55vm+o51NJTdp3q3DGImtVL8D7MjWlb1gLdD9nhDropexaYv14PcNn
         nC+1AAW4GIRJYpAXm6KVPxu37DgAGeoTfaE927rQKZkjGPS22Zm6nv/cmLR1vZK5oSEe
         hljw==
X-Gm-Message-State: AOJu0YzPB3sL9CjzmzJbBQJnTtagYpSgKzJt3Jk0mrPriIPIR1ugVMk6
	XZC4XNddLNseg2+V9CZLEQBQJKOqP0mE6KAOCkeIjOZm93nTA2TFxuPn5uYzUVhv2/UrC7fqWyu
	Y
X-Google-Smtp-Source: AGHT+IEB9wnDTlUF4DeQQ9wXcMaH6xqdPfKpnQ/JsbwPSh57/WOsVFCW47QnGU4Q//1Sg9MJszC6dw==
X-Received: by 2002:a17:902:c44a:b0:1d5:4df7:17d6 with SMTP id m10-20020a170902c44a00b001d54df717d6mr481311plm.95.1706232239674;
        Thu, 25 Jan 2024 17:23:59 -0800 (PST)
Received: from localhost (fwdproxy-prn-028.fbsv.net. [2a03:2880:ff:1c::face:b00c])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902aa9600b001d71df54cdasm112917plr.274.2024.01.25.17.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 17:23:59 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v6 0/4] netdevsim: link and forward skbs between ports
Date: Thu, 25 Jan 2024 17:23:53 -0800
Message-Id: <20240126012357.535494-1-dw@davidwei.uk>
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
v5->v6:
- reworked to link two netdevsims using sysfs attribute on the bus
  device instead of debugfs due to deadlock possibility if a netdevsim
  is removed during linking
- removed unnecessary patch maintaining a list of probed nsim_devs
- updated selftest

v4->v5:
- reduce nsim_dev_list_lock critical section
- fixed missing mutex unlock during unwind ladder
- rework nsim_dev_peer_write synchronization to take devlink lock as
  well as rtnl_lock
- return err msgs to user during linking if port doesn't exist or
  linking to self
- update tx stats outside of RCU lock

v3->v4:
- maintain a mutex protected list of probed nsim_devs instead of using
  nsim_bus_dev
- fixed synchronization issues by taking rtnl_lock
- track tx_dropped skbs

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
 drivers/net/netdevsim/bus.c                   |  72 ++++++++++
 drivers/net/netdevsim/netdev.c                |  35 ++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |  18 +++
 .../selftests/drivers/net/netdevsim/peer.sh   | 124 ++++++++++++++++++
 6 files changed, 249 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


