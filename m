Return-Path: <netdev+bounces-252115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLhbDtZ0cWm3HAAAu9opvQ
	(envelope-from <netdev+bounces-252115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E0660177
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A0BF568997
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031130FC12;
	Thu, 22 Jan 2026 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFdPijQ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97A30F7F0
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043091; cv=none; b=WwfISXnHrnLM1gxTQPWND9fH9MI8Z655x0znWWydMyDPgb/z5HAbmE25GMCMccjpdLaR6Ox6p+Sfct7p5zs6fhUyb6Fm5G8gEwPj4GAz20G6b5nFSbgrDbfdCtpcSwgNTRKFcYD5/gsXW7A5eDR9ifhzi0evs6AfkIwDk9BuPD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043091; c=relaxed/simple;
	bh=h8kDgYNX2Y12ZiAH62QF0iUpP96asjl+9oP8dgp6gzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ReyT9pPw936XLCfIE/eAbyM1MNSkYPJACvMV9lB7hqibmtBDGDTfqaNw1/7LU7f+KKdihrssvm759+Zh+YhWKvEEKUXD/vMPA4pfSv0yZXUVJ/Pjkb2lrhjyJucuhHeFOULRciAyUE3uOqpkWD1+svA3PRHILWzCZcmGdnjawQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFdPijQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6F5C4CEF1;
	Thu, 22 Jan 2026 00:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043090;
	bh=h8kDgYNX2Y12ZiAH62QF0iUpP96asjl+9oP8dgp6gzg=;
	h=From:To:Cc:Subject:Date:From;
	b=mFdPijQ5rnHyfjxcH5oUpDSA379QWf5jcjrp2HIaLO/avrQXxLgAG+UJpqBrVbZSW
	 sAnzNyaC4V2+10o9L9e08aN/IIWCrBCkoOHPCUqyAFYEcZm91EaQtoU0v4Kawih9Fw
	 KH0F+FtAVjL4hbwFkWdq8P/pPul5jwQ38Kbvu4UiNIduStp9xRtF5cJlVtCdJNUhna
	 48JtlXDIsLrHV9fIlCb9UZe9Y7V6Rlo3Bw1i4nPz95d035FGaQkT8RmOaWhkfTO2bs
	 tGJ5yjZngsX+i7AE6JFqVBh114k5q5Div2l+qHJ7UWIDjI2B/lmK7QdgDhYixoFUW+
	 XlBMbuQ+ElsQg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	asml.silence@gmail.com,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/6] net: restore the structure of driver-facing qcfg API
Date: Wed, 21 Jan 2026 16:51:07 -0800
Message-ID: <20260122005113.2476634-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,nvidia.com,gmail.com,davidwei.uk,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252115-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 98E0660177
X-Rspamd-Action: no action

The goal of qcfg objects is to let us seamlessly support new use cases
without modifying all the drivers. We want to pull all the logic of
combining configuration supplied via different interfaces into the core
and present the drivers with a flat queue-by-queue configuration.
Additionally we want to separate the current effective configuration
from the user intent (default vs user setting vs memory provider setting).

Restructure the recently added code to re-introduce the pieces that
are missing compared to the old RFC:
https://lore.kernel.org/20250421222827.283737-1-kuba@kernel.org
Namely:
 - the netdev_queue_config() helper
 - queue config validation callback

I hopefully removed all the more "out there" parts of the RFC.

Jakub Kicinski (6):
  eth: bnxt: always set the queue mgmt ops
  net: introduce a trivial netdev_queue_config()
  net: move mp->rx_page_size validation to __net_mp_open_rxq()
  net: use netdev_queue_config() for mp restart
  net: add queue config validation callback
  eth: bnxt: plug bnxt_validate_qcfg() into qops

 net/core/Makefile                         |  1 +
 include/net/netdev_queues.h               | 17 ++++-
 net/core/dev.h                            |  5 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 23 ++++---
 net/core/dev.c                            | 17 -----
 net/core/netdev_config.c                  | 78 +++++++++++++++++++++++
 net/core/netdev_rx_queue.c                | 60 ++++++++++-------
 7 files changed, 152 insertions(+), 49 deletions(-)
 create mode 100644 net/core/netdev_config.c

-- 
2.52.0


