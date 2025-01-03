Return-Path: <netdev+bounces-155060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660BA00E25
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4684718846E2
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDCD1FA838;
	Fri,  3 Jan 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU8tNN5a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64421B983E
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930799; cv=none; b=olLBnusp3FrVbQgy8tU/sDTOHY02yYkbRPDLcTtIMwlM0aczwfLIfVKQlGKQ5IV8vO2sWGz4CciJhAcoBgIKVuO5JMPGY/oV1LNZstOHdJVDxHIMtZIDBE93YJHDoZueL5fiN40txnrw4X3BgRE4mggl6XHsQdeqWJMI+2WZx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930799; c=relaxed/simple;
	bh=WyE9s/riapW/iZNryslTu24/OicRaFJSnExysNxL+r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjhR2AwT2cfaj8MZfkye41JDfFcfndH7ydaFWdCjIV/3mk1zQKSucudOy0SlvrbiJNXUaTHCjhOWhioFeM3r9qWIZbYK+p391LcXCaPC7iXmc0HN9z2gdCDNTF7h4/ks1Xsu06hDh4yFv8oBeO7hsfcpwLtC7WXNEcW200u0D7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU8tNN5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C18C4CECE;
	Fri,  3 Jan 2025 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930799;
	bh=WyE9s/riapW/iZNryslTu24/OicRaFJSnExysNxL+r4=;
	h=From:To:Cc:Subject:Date:From;
	b=JU8tNN5anOLNj65JsxvhB5iHT3KbXowhVVLlAIqqDZxCEQeSXNOCkFZuGREGLoBZ4
	 PpYEB74QKpuE65+5I6G5uMxUBN6eyOw89jecID1fbVoz9Xg6/RNd1V3h3weP/TbnTK
	 Tsgafr1ghhikENu7iPM1UNubHIEL5ZEqNVZTHsJuHhW+WZQnE2p6uH40gT8wUxluHQ
	 XW8DinTYOhP50sn8oF/XifwCUCyKLtzG/VT3eDx6YvpOj/YTm4s7fUXwEYtHPbmWsE
	 EgSW+F7cYXzMS5s2LrZoDTVItYdaZJTqSMCOZ7xwn9LTYWVO8ijBGFyAZkRILznBKI
	 PrcspGOlUrv6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	almasrymina@google.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/8] net: make sure we retain NAPI ordering on netdev->napi_list
Date: Fri,  3 Jan 2025 10:59:45 -0800
Message-ID: <20250103185954.1236510-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I promised Eric to remove the rtnl protection of the NAPI list,
when I sat down to implement it over the break I realized that
the recently added NAPI ID retention will break the list ordering
assumption we have in netlink dump. The ordering used to happen
"naturally", because we'd always add NAPIs that the head of the
list, and assign a new monotonically increasing ID.

Before the first patch of this series we'd still only add at
the head of the list but now the newly added NAPI may inherit
from its config an ID lower than something else already on the list.

The fix is in the first patch, the rest is netdevsim churn to test it.
I'm posting this for net-next, because AFAICT the problem can't
be triggered in net, given the very limited queue API adoption.

Jakub Kicinski (8):
  net: make sure we retain NAPI ordering on netdev->napi_list
  netdev: define NETDEV_INTERNAL
  netdevsim: support NAPI config
  netdevsim: allocate rqs individually
  netdevsim: add queue alloc/free helpers
  netdevsim: add queue management API support
  netdevsim: add debugfs-triggered queue reset
  selftests: net: test listing NAPI vs queue resets

 Documentation/networking/netdevices.rst  |  10 +
 drivers/net/netdevsim/netdev.c           | 254 ++++++++++++++++++++---
 drivers/net/netdevsim/netdevsim.h        |   5 +-
 net/core/dev.c                           |  42 +++-
 net/core/netdev_rx_queue.c               |   1 +
 tools/testing/selftests/net/nl_netdev.py |  19 +-
 6 files changed, 292 insertions(+), 39 deletions(-)

-- 
2.47.1


