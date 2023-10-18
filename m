Return-Path: <netdev+bounces-42428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E36E7CEA22
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00068B20EA3
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42CF38F8A;
	Wed, 18 Oct 2023 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEUZflsc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867EB4292A
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 21:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A45CC433C7;
	Wed, 18 Oct 2023 21:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697665163;
	bh=eokjp/1DggAE4rjPzpdAqEXMjUzwf27cj3Yk3nOotcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oEUZflscsi1FI1c/CICfZB3HLNdtX1KQbZHwWKb8ghYvECv3Hr5Nr/IN/2V3Y1OkR
	 l2p3hZE5D9xT1zvwOiB3yW7XJZKUPX1IvRZ+/HOrWAnqzPk5JTtmhrOwN0wE3Ys+W3
	 HAwdZdYgGhdK+bWa1AdOoerabF9tTXF/oC+ex62EnqsLahHGn6xqxPtSBePjfzBdhL
	 kfYp3SQxKPzjTs+jFEO9Kqp0q7mKsjQf9JPc/JAGQ1gGkIU3PAG8O+Zvg/YKMnUU7H
	 xrwypusV6LTawJhxr15opDGMBg7Wkr/mpARGzANIoejWAp25n6Bq7WGxw1+BA4idsu
	 dddRiLypRqIow==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] netlink: add variable-length / auto integers
Date: Wed, 18 Oct 2023 14:39:18 -0700
Message-ID: <20231018213921.2694459-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add netlink support for "common" / variable-length / auto integers
which are carried at the message level as either 4B or 8B depending
on the exact value. This saves space and will hopefully decrease
the number of instances where we realize that we needed more bits
after uAPI is set is stone. It also loosens the alignment requirements,
avoiding the need for padding.

This mini-series is a fuller version of the previous RFC:
https://lore.kernel.org/netdev/20121204.130914.1457976839967676240.davem@davemloft.net/
No user included here. I have tested (and will use) it
in the upcoming page pool API but the assumption is that
it will be widely applicable. So sending without a user.

Jakub Kicinski (3):
  tools: ynl-gen: make the mnl_type() method public
  netlink: add variable-length / auto integers
  netlink: specs: add support for auto-sized scalars

 Documentation/netlink/genetlink-c.yaml        |  3 +-
 Documentation/netlink/genetlink-legacy.yaml   |  3 +-
 Documentation/netlink/genetlink.yaml          |  3 +-
 Documentation/userspace-api/netlink/specs.rst | 18 ++++-
 include/net/netlink.h                         | 69 ++++++++++++++++++-
 include/uapi/linux/netlink.h                  |  5 ++
 lib/nlattr.c                                  | 22 ++++++
 net/netlink/policy.c                          | 14 +++-
 tools/net/ynl/lib/nlspec.py                   |  6 ++
 tools/net/ynl/lib/ynl.c                       |  6 ++
 tools/net/ynl/lib/ynl.h                       | 17 +++++
 tools/net/ynl/lib/ynl.py                      | 14 ++++
 tools/net/ynl/ynl-gen-c.py                    | 44 ++++++------
 13 files changed, 192 insertions(+), 32 deletions(-)

-- 
2.41.0


