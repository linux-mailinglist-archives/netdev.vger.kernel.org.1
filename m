Return-Path: <netdev+bounces-235592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5C0C3333B
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B071883863
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715DF2C15BC;
	Tue,  4 Nov 2025 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qkvu5Ovv"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C822255F57;
	Tue,  4 Nov 2025 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294893; cv=none; b=OhRrHfpeGJ0rwFQGhPELm9sVqZRPJ6OZluFJr+kA6cwJjlhVXtbp0ukQkP/T1LTD0jUUS04OxO5zSMoDGIVA272kt3ywIUYzJp4Gj49/Y07YycKjcgapjyN09mM6Rkxs/ailmztr3xvElFexfDd4tj0Tk5NhLkT5Xsb+YkYTbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294893; c=relaxed/simple;
	bh=dp4rk4gZic0U63g5qf3HGdw0YgmCDYUXdFC005r7kAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GC4Z3zzVxZTgmQarGPIfhvWF2iBnU7zn0ZwR8I0+mZ72wLpdQ7pJk2B6k7AMXplBoKKLlx1WFSl9CymZ0i3UkhQ4eZvjf9rHTYcb4eyBBSiGLzeEPBbu+LHzr7N84oKQxyk9bgtTVfxOdknjufTq7AD0d59CU09CPQ7pfYdkTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qkvu5Ovv; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1EA73C0000FA;
	Tue,  4 Nov 2025 14:13:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1EA73C0000FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1762294432;
	bh=dp4rk4gZic0U63g5qf3HGdw0YgmCDYUXdFC005r7kAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Qkvu5OvvnZ/J05Qx6G4kxFUY2GwU6pGWKaYomBfw7xnihZNrTH13Rqa4s+XGULQPu
	 7IFThHRhx6hsY1CQh1C8otC2/NfeH342Jp+vHnexh2K2k/vGHAr2D3GqlOA1V9p11l
	 at4FGLsFB8QSyvPCWkqBziyCXz+TuUcQbvOJMgtc=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id C24814002F44;
	Tue,  4 Nov 2025 17:13:50 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
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
Subject: [PATCH net-next v2 0/2] Allow disabling pause frames on panic
Date: Tue,  4 Nov 2025 14:13:46 -0800
Message-Id: <20251104221348.4163417-1-florian.fainelli@broadcom.com>
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
 net/core/net-sysfs.c                          | 34 ++++++++
 net/ethernet/Makefile                         |  3 +-
 net/ethernet/pause_panic.c                    | 81 +++++++++++++++++++
 9 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 net/ethernet/pause_panic.c

-- 
2.34.1


