Return-Path: <netdev+bounces-151815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14CB9F10CC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9939B284399
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4C1E25E1;
	Fri, 13 Dec 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apdoa0O+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8E1E231E
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103373; cv=none; b=WHl9WMu1Jjr/KaeYqtfvICIXeGmCoqjEmpBxOoKw4GH8mtQNVa+704ydcVZzx0VtyBs67/6T1OMO4li3uEi2pn6fTul81Zwk13QQ2PoUw31mxTL57spC7aASVzNNHXv/fYfK5ZHWwmi6GEE8lBTjg0hYgcEVPt/5FY8UWmENFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103373; c=relaxed/simple;
	bh=evLj1PNMToGvaBLcMmGXntJrGpYfYyX+hdfWjbQ7BCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDCln9mkuUKDZxe9zKtc66HnYL8ajAN7gNy9a1vvglVJEE0I0eGczEzVnfrs5rR1s9EIyBVREStxHSRPyaKncpYHyNIGvzjy303lxeMxSS2yZXHwLo1jWcp5rQ+pwSbrc/q61/ik96/zb17etpKwmI5sytuv36YsKjSudlSgwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apdoa0O+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BBDC4CED0;
	Fri, 13 Dec 2024 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103373;
	bh=evLj1PNMToGvaBLcMmGXntJrGpYfYyX+hdfWjbQ7BCk=;
	h=From:To:Cc:Subject:Date:From;
	b=Apdoa0O+T/GthgkzROGQJPIBAz1/Ggw74SNvRsxPfmSwHoo5K6fWtUBjnPC99bQ68
	 onVHY5RME/XkyvFRsW1WgvfmZCO86wo2+fk/Fv2dC1lVhjuPhBxbKUh+IJYHJWUvLt
	 Nc2cx6L5lxbs+7utGNgXEEKFPnKxeCG5NbM4rxxH1oGuqhQb78pL2dvyfRbWOWKnq4
	 rA5C1hjCeppeCr9j2qCmlbMQi+mGLqc6R2OQGh1NQEcP8W0lgtV/8MaRhU4gDDPn1H
	 pSeSVM5yhR+9F1/GcD2lOaFA1wyeSGGC+9aG0a0Y1vHycopGQr0KsEnUPQnk6+k9hW
	 sEAN+xt1oW+xQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/5] netdev: fix repeated netlink messages in queue dumps
Date: Fri, 13 Dec 2024 07:22:39 -0800
Message-ID: <20241213152244.3080955-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix dump continuation for queues and queue stats in the netdev family.
Because we used post-increment when saving id of dumped queue next
skb would re-dump the already dumped queue.

Jakub Kicinski (5):
  netdev: fix repeated netlink messages in queue dump
  netdev: fix repeated netlink messages in queue stats
  selftests: net: support setting recv_size in YNL
  selftests: net-drv: queues: sanity check netlink dumps
  selftests: net-drv: stats: sanity check netlink dumps

 net/core/netdev-genl.c                        | 15 +++++-------
 tools/testing/selftests/drivers/net/queues.py | 23 +++++++++++--------
 tools/testing/selftests/drivers/net/stats.py  | 19 ++++++++++++++-
 tools/testing/selftests/net/lib/py/ynl.py     | 16 ++++++-------
 4 files changed, 45 insertions(+), 28 deletions(-)

-- 
2.47.1


