Return-Path: <netdev+bounces-21586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE3F763F54
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D12281E1C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7814CE8E;
	Wed, 26 Jul 2023 19:16:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B24CE89
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:16:10 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7E02722
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:16:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 19D081F459;
	Wed, 26 Jul 2023 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690398967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KITOh7mhAROX0DHx75ByZrgCqzDH9fXcM5TVvAo8OYM=;
	b=1C3e0ctjSPoSpwtQGVrW2AFt3CtWwz8+mTabngYFL9X16Ff0t0SrQ45ebY9YI6uEv5xqwd
	lH2r/zMgpRRX4BYaRS8xthjCClkzZCuTmkszZBQKLerIw5BARx+uZFxjT3ZGFTm7WmoBZo
	hsaBNYYDRv02mUyJcYeGr6Fmv4bbNW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690398967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KITOh7mhAROX0DHx75ByZrgCqzDH9fXcM5TVvAo8OYM=;
	b=4sPB6xkKaA7snlGJoFk67uN4j8KG/HgszKRih1Fn8mmpMq+8lFIvJ4+KLfrF7cximcyHES
	+G8I8cexvRk4ZSAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 2209F2C143;
	Wed, 26 Jul 2023 19:16:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0F0E351CA32D; Wed, 26 Jul 2023 21:16:06 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv9  0/6] net/tls: fixes for NVMe-over-TLS
Date: Wed, 26 Jul 2023 21:15:50 +0200
Message-Id: <20230726191556.41714-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

here are some small fixes to get NVMe-over-TLS up and running.
The first set are just minor modifications to have MSG_EOR handled
for TLS, but the second set implements the ->read_sock() callback
for tls_sw.
The ->read_sock() callbacks return -EIO when encountering any TLS
Alert message, but as that's the default behaviour anyway I guess
we can get away with it.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Add a testcase for MSG_EOR handling

Changes to v2:
- Bail out on conflicting message flags
- Rework flag handling

Changes to v3:
- Return -EINVAL on conflicting flags
- Rebase on top of net-next

Changes to v4:
- Add tlx_rx_reader_lock() to read_sock
- Add MSG_EOR handling to tls_sw_readpages()

Changes to v5:
- Rebase to latest upstream
- Split tls_rx_reader_lock() as suggested by Sagi

Changes to v6:
- Fixup tls_strp_read_copyin() to avoid infinite recursion
  in tls_read_sock()
  - Rework tls_read_sock() to read all available data

Changes to v7:
- Include reviews from Jakub

Changes to v8:
- Use tls_read_flush_backlog()

Hannes Reinecke (6):
  net/tls: handle MSG_EOR for tls_sw TX flow
  net/tls: handle MSG_EOR for tls_device TX flow
  selftests/net/tls: add test for MSG_EOR
  net/tls: Use tcp_read_sock() instead of ops->read_sock()
  net/tls: split tls_rx_reader_lock
  net/tls: implement ->read_sock()

 net/tls/tls.h                     |   2 +
 net/tls/tls_device.c              |   6 +-
 net/tls/tls_main.c                |   2 +
 net/tls/tls_strp.c                |   3 +-
 net/tls/tls_sw.c                  | 142 ++++++++++++++++++++++++++----
 tools/testing/selftests/net/tls.c |  11 +++
 6 files changed, 146 insertions(+), 20 deletions(-)

-- 
2.35.3


