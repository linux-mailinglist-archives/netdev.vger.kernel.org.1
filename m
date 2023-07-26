Return-Path: <netdev+bounces-21578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79963763F13
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5DD1C2121B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7104CE7C;
	Wed, 26 Jul 2023 18:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C97E1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52918C433CA;
	Wed, 26 Jul 2023 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690397735;
	bh=AtD8ujInD4eQEbTr16jfEpDFK+4gJweCbxqa4eDq7Og=;
	h=From:To:Cc:Subject:Date:From;
	b=QxCK5a81zs/kHV1sGICA+tKXav1sErH8W6lRkB26z63C0isWHxjV4W8+f/2Ukk6Xc
	 tnXkhlAYwmsG/VOkq9AJ5i72FXTKcyv08lMAZc62VJc9I49BMwJntp7FenR8Ig0L70
	 gQKOTTNvsxqDVtgVCF32rv91eLYKcW4VLev3XV3TDpsjGb3Ap4SnClWmylkLQYLcOk
	 +zPPpj7Ij5mX+DvoJBZpRtaVbNtLLy/RASBnurZujdiIAkd/tMQde8hVZjFUaKBYfH
	 mMGbN9aFqvwImL+5OOaVqS4XACCReFpuC428Pua7wO4UvxphpVPQ9yrO0z2v5Yf54T
	 QZ7WXHyQjNbdA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	leon@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/2] net: store netdevs in an xarray
Date: Wed, 26 Jul 2023 11:55:28 -0700
Message-ID: <20230726185530.2247698-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of more annoying developer experience gaps we have in netlink
is iterating over netdevs. It's painful. Add an xarray to make
it trivial.

v2:
 - fix the potential mishandling of wrapping (Leon)
v1: https://lore.kernel.org/all/20230722014237.4078962-1-kuba@kernel.org/

Jakub Kicinski (2):
  net: store netdevs in an xarray
  net: convert some netlink netdev iterators to depend on the xarray

 include/linux/netdevice.h   |  3 ++
 include/net/net_namespace.h |  4 +-
 net/core/dev.c              | 82 ++++++++++++++++++++++++-------------
 net/core/netdev-genl.c      | 37 ++++-------------
 net/ethtool/netlink.c       | 59 +++++++-------------------
 net/ethtool/tunnels.c       | 73 ++++++++++++---------------------
 6 files changed, 109 insertions(+), 149 deletions(-)

-- 
2.41.0


