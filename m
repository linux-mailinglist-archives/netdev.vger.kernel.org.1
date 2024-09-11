Return-Path: <netdev+bounces-127287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7F974E32
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD47A1C269AE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43517C22F;
	Wed, 11 Sep 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="IKZ8p6uP"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF517A584;
	Wed, 11 Sep 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045864; cv=none; b=N1bnGtIr8Jkm3Qhsro9t33GR0uSyHUYuNJzOrfk0MH1yQB8VwQUjWmJ7iMm7D1eQlf6DrvU3BZ+DqG5qC8SVDA0C40E+MoS8L1qDE+6tS5ZB/oPwIfiVShnI4/SJjAKYvzdqr+V45gpw/HdgthIJ+2CWZYapu7xGNK1okZtA+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045864; c=relaxed/simple;
	bh=2c4w0r9Ea/sw99GyPYRVq+HtuWZK5k/qD607q5Esn7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ryap5I6vQz+VnJU7WkQgCXK4//DtVb4VfVaSaK5+3j55YFg0tPVwkgO8shBIp6EbWYjVusQEVIt+JF0rxA8I3DUO4/lG8J12ZsKwtGWZQR17ukKGYX4BzlvE8+BA+GYTiDo2ts3el0MJIUZekzCoRNKBnT7D2CjO8rciqrB/jvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=IKZ8p6uP; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1726045858;
	bh=2c4w0r9Ea/sw99GyPYRVq+HtuWZK5k/qD607q5Esn7c=;
	h=From:To:Cc:Subject:Date:From;
	b=IKZ8p6uPNH+WGC1SUr1bArWgX816/7ZRtBomcCytacFUZZD14vBSJR/EZNgxYoXsd
	 j8UpHmlfnQs9yeZnydLSJ2mrZ4JdXQcS/v+HaeWgmZ5smbPBwX2jbwKKdWfcWrp/Cm
	 3xtPN6JogbLnkX6QYuBM7JkxDjdRefvtCrBAMTci2GzDt4VaoaBqEHv4/W7GVBITg2
	 BNK1CIMkrLEnIwkmaItunOwGDl99UhRH7DfcI4m+XVyuELtl5Vas7iefFhGqadWVp/
	 YNG9wl5uCQMQlLOznH2brBMAGDCkkkFqGePgIYPc9rBvhaGZZ3PGamskF3EiA8lvld
	 7dtfdEiMiAsPA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0CFDB60078;
	Wed, 11 Sep 2024 09:10:30 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 979472017A4; Wed, 11 Sep 2024 09:10:15 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] netlink: specs: mptcp: fix port endianness
Date: Wed, 11 Sep 2024 09:10:02 +0000
Message-ID: <20240911091003.1112179-1-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MPTCP port attribute is in host endianness, but was documented
as big-endian in the ynl specification.

Below are two examples from net/mptcp/pm_netlink.c showing that the
attribute is converted to/from host endianness for use with netlink.

Import from netlink:
  addr->port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]))

Export to netlink:
  nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_PORT, ntohs(addr->port))

Where addr->port is defined as __be16.

No functional change intended.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index af525ed29792..30d8342cacc8 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -109,7 +109,6 @@ attribute-sets:
       -
         name: port
         type: u16
-        byte-order: big-endian
       -
         name: flags
         type: u32
-- 
2.45.2


