Return-Path: <netdev+bounces-178398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509EA76D8F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC4F16704A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4CD214A90;
	Mon, 31 Mar 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuZDz2Ia"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B93214201
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450155; cv=none; b=PkGyFfpSNfA0GlVlNqt8+As+slVBt/+Rs1C4qLQWKavDu1f4d+ozQth8VFuF42I4e4H6uAQCCzDWq5+oA08YLZIxHiEobpqsCc2w1nPbM2USewfaA47U+m+JyH3w3AMx6szU8P4oIED4FdrKNItaCUIpZMUbBF5g8Ww8Iod3log=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450155; c=relaxed/simple;
	bh=yVL/LceryJVCAlDIGfwOXnQ7ETeuYQenLLmAa5md7qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZYd/k/hYPlU8JXJKPPQ4x1oXrnTFw/T937Q1zlJ2lfDLu9s+HDDATvBQqLndR07Akgz/tCrdfyrGViMfYuQFY7Hz8Y8JoubeqISGmvnp458usuepwqZdHPLy0sDd0q6zWx2UiJuT+yZlQt323xUQIP26z/DCqraasa3SsZqmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuZDz2Ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF85DC4CEE3;
	Mon, 31 Mar 2025 19:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743450154;
	bh=yVL/LceryJVCAlDIGfwOXnQ7ETeuYQenLLmAa5md7qU=;
	h=From:To:Cc:Subject:Date:From;
	b=uuZDz2IaJZfmWbtuOdWeW0cQGyb5/EPSgzPWGiWug6pzP28diFv70A1llRBpv4Tf1
	 xXcGQNu76PTG7WrB+vWuSkW5kxMy7xMb1eOJ7D1bU/r6gjC3AwbIKaUKAZL5cf9Fvs
	 PelIlp78JB2cRm3ViBF1a7aQssN6ckBt6GbW9kYM5lZ566DN987EBFIXLHgbv3VQ8j
	 Gug3jYNElyKlczanf6q1FlmJ15inCY/sDriI9OUYnvVuJD+hU9nFwIEA/WCdsk6TeQ
	 wkUpNAQF3rDS4li7mIQJk4sWSZ0vSBdfC/xFAVblmWhbNSwHGk1iF4iYuranHthPQD
	 tXaSzvBshTYPQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ap420073@gmail.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/2] net: make memory provider install / close paths more common
Date: Mon, 31 Mar 2025 12:42:01 -0700
Message-ID: <20250331194201.2026422-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We seem to be fixing bugs in config path for devmem which also exist
in the io_uring ZC path. Let's try to make the two paths more common,
otherwise this is bound to keep happening.

Found by code inspection and compile tested only.

Jakub Kicinski (2):
  net: move mp dev config validation to __net_mp_open_rxq()
  net: avoid false positive warnings in __net_mp_close_rxq()

 include/net/page_pool/memory_provider.h |  6 +++
 net/core/devmem.c                       | 64 ++++++------------------
 net/core/netdev-genl.c                  |  6 ---
 net/core/netdev_rx_queue.c              | 66 ++++++++++++++++++-------
 4 files changed, 69 insertions(+), 73 deletions(-)

-- 
2.49.0


