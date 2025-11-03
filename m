Return-Path: <netdev+bounces-235233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2DC2DF02
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 20:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF68218925C1
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 19:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE629D293;
	Mon,  3 Nov 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UZQKSJwI"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACD29ACDB;
	Mon,  3 Nov 2025 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199211; cv=none; b=TegjOENqZGBo0PTbJC0cAs5kjcGvERfgnyy1fQ2bCTghWKgoqGBY3hEgTILjIdbZkbq1p6ng1jrcJ9nqpieOEUbO/rYQW0JZvGQA6pGmy18xqx61jQsvEuKz7UiNZ3LmWLKOgN3EcV8SFtgV6VPY7ZfuWWYpGu8MhPWQzh8c0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199211; c=relaxed/simple;
	bh=nzL7Ptcfl43WHATFv9Hul72L7iQ+Pvm8RIGVEuUvQxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FjJqfM7qAHa9fq7fKXKtskadYiW0Pp2OiSbEEy2ZCFmtQackm1EpykhZ8H8bQMeXSfTjwg0sae4pE+sFXUBLrfml5c7k36jCIb/8tI1s+F7sMz0VlKhO07lntTTGrDWtDFOr2QAuYNcMM7RKOaiyJZgSq2E+dAszOjDKcUyglBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UZQKSJwI; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9C99CC000543;
	Mon,  3 Nov 2025 11:46:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9C99CC000543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1762199204;
	bh=nzL7Ptcfl43WHATFv9Hul72L7iQ+Pvm8RIGVEuUvQxM=;
	h=From:To:Cc:Subject:Date:From;
	b=UZQKSJwIWlCFquLJ1IVFDrTEH/rsOaOHGfaXIuDemdcho729oziwrT8nkam+gaQ8m
	 qNjpQrDZE+7UE9md8ImARGo5sqlx77KujhtXQnYTkfIpBF7i0qkFMS9vzCqjqfngl1
	 NRbNJBWADfYRDhaPzbfAiCIoeqpVBtv6GpRJa3UM=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 33EE34002F44;
	Mon,  3 Nov 2025 14:46:43 -0500 (EST)
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
Subject: [PATCH net-next 0/2] Allow disabling pause frames on panic
Date: Mon,  3 Nov 2025 11:46:29 -0800
Message-Id: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
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

Florian Fainelli (2):
  net: ethernet: Allow disabling pause on panic
  net: bcmgenet: Support calling set_pauseparam from panic context

 Documentation/ABI/testing/sysfs-class-net    | 16 ++++
 drivers/net/ethernet/broadcom/genet/bcmmii.c |  9 +-
 include/linux/netdevice.h                    |  1 +
 net/core/net-sysfs.c                         | 34 +++++++
 net/ethernet/Makefile                        |  3 +-
 net/ethernet/pause_panic.c                   | 95 ++++++++++++++++++++
 6 files changed, 154 insertions(+), 4 deletions(-)
 create mode 100644 net/ethernet/pause_panic.c

-- 
2.34.1


