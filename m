Return-Path: <netdev+bounces-236555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D910C3DF81
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFBC3B1D80
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEAD27877F;
	Fri,  7 Nov 2025 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WQ0IPCYA"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24842773CB;
	Fri,  7 Nov 2025 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475121; cv=none; b=bkczGoBRXXDckR0Wh4Hy1G9atq5ITtyPt07yNR3vfHTKjyb4Z+zojH3xPgmQEo8Bd9HmEQdUxzYwmBHpNFYmFKPFPiqCQ3ZPtjYl7762Q0lb4Q3atA2brNt+Vys3VU2IlPffUhtUvVPaJlCyoa5PKB+vytx2voGhn++51f7WPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475121; c=relaxed/simple;
	bh=Vyx9pR0im3zusSdNU6TOS7hc7sA8JZvNevn4v6hMwW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nq10RvLhrJdwHmKhA4dq1+REb8vUBEZyHC864aIs75Fc4+bSnZZK732JUk0h/NDF+sC9R1Z2fmYN8Kd7odKmk+yJxXqVMavb1r+kUsWCAPPx4ZZ+b6YlmTbJ/r6GfDpqHHwjdqYFB0gASwRuK8W4XKeq7T3KNgdJ9Y4pUglVCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WQ0IPCYA; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EADA1C0003E6;
	Thu,  6 Nov 2025 16:25:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EADA1C0003E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1762475113;
	bh=Vyx9pR0im3zusSdNU6TOS7hc7sA8JZvNevn4v6hMwW0=;
	h=From:To:Cc:Subject:Date:From;
	b=WQ0IPCYA5hQrNNH5aRZ4UvOoGHFWnSnUYfT+H/r62PNLR5yvz/W9sVWmuh68O8fat
	 L6NvTdMs7JVl240q97VvnXiP2DoTV8+bnOj+6H7RfETnNcdzdwSAMk+zY8KD4/W2PH
	 zc5+pQgg+j+mUA6ugsaB/GQrADUsiwOD6Ymzbndk=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 871E618000530;
	Thu,  6 Nov 2025 16:25:12 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Antoine Tenart <atenart@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 0/2] Allow disabling pause frames on panic
Date: Thu,  6 Nov 2025 16:25:08 -0800
Message-Id: <20251107002510.1678369-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set allows disabling pause frame generation upon encountering
a kernel panic. This has proven to be helpful in lab environments where
devices are still being worked on, will panic for various reasons, and
will occasionally take down the entire Ethernet switch they are attached
to.

Changes in v3:

- early feedback as to whether we can disable pause on panic
- correct documentation
- simplify network device list traversal
- only need to disable pause frame generation (TX)

Changes in v2:

- introduce a dedicated callback that runs in panic context

Florian Fainelli (2):
  net: ethernet: Allow disabling pause on panic
  net: bcmgenet: Add support for set_pauseparam_panic

 Documentation/ABI/testing/sysfs-class-net     | 16 ++++
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  8 ++
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  1 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c  | 10 +++
 include/linux/ethtool.h                       |  3 +
 include/linux/netdevice.h                     |  1 +
 net/core/net-sysfs.c                          | 39 +++++++++
 net/ethernet/Makefile                         |  3 +-
 net/ethernet/pause_panic.c                    | 79 +++++++++++++++++++
 9 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 net/ethernet/pause_panic.c

-- 
2.34.1


