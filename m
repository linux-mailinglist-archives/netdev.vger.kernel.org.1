Return-Path: <netdev+bounces-22001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53894765A6B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E902822FC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF5C2714F;
	Thu, 27 Jul 2023 17:35:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887F8BE8;
	Thu, 27 Jul 2023 17:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6A3C433C8;
	Thu, 27 Jul 2023 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690479308;
	bh=21ExaG7NXi2ELnUZh1WtffhaBBo7e5FYI6C/9C5pZds=;
	h=Subject:From:To:Cc:Date:From;
	b=UBJs7Hg/D2t+Eyg0JGY8LrGWqGHAxxWxBRQMo8ZY0mCZrZpj29nEqW/d/749Ay9OD
	 RuZfm+XGaUoGQa1NeR1whvMiAFfyAX3YlYCSE0IoKim0jwR2reBa4rxGodm+kDbUtB
	 pE808ngGkMPrXrPc6U+j7rZr7SjuoTMnfupYFCbY/XzSMFGUJ0VNMxt8qIx2u0oBd6
	 UH9AoBzmplP+OA1ZHo9YcxMiXPd2cejOWZIrTXfGqrMTdQ70OdMXtzsWM4wULHicX6
	 0mjOuhJkgdJamqom7N/aredzQasAkp/1g6zU9GPfFJEWlBOnqaPGVBR4h3nBrdatBy
	 A/a/RbFZ4UmRQ==
Subject: [PATCH net-next v3 0/7] In-kernel support for the TLS Alert protocol
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Thu, 27 Jul 2023 13:34:56 -0400
Message-ID: 
 <169047923706.5241.1181144206068116926.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

IMO the kernel doesn't need user space (ie, tlshd) to handle the TLS
Alert protocol. Instead, a set of small helper functions can be used
to handle sending and receiving TLS Alerts for in-kernel TLS
consumers.


Changes since v2:
* Simplify header dependencies

Changes since v1:
* Address review comments from Hannes

---

Chuck Lever (7):
      net/tls: Move TLS protocol elements to a separate header
      net/tls: Add TLS Alert definitions
      net/handshake: Add API for sending TLS Closure alerts
      SUNRPC: Send TLS Closure alerts before closing a TCP socket
      net/handshake: Add helpers for parsing incoming TLS Alerts
      SUNRPC: Use new helpers to handle TLS Alerts
      net/handshake: Trace events for TLS Alert helpers


 .../chelsio/inline_crypto/chtls/chtls.h       |   1 +
 include/net/handshake.h                       |   5 +
 include/net/tls.h                             |   4 -
 include/net/tls_prot.h                        |  68 ++++++++
 include/trace/events/handshake.h              | 160 ++++++++++++++++++
 net/handshake/Makefile                        |   2 +-
 net/handshake/alert.c                         | 110 ++++++++++++
 net/handshake/handshake.h                     |   6 +
 net/handshake/tlshd.c                         |  23 +++
 net/handshake/trace.c                         |   2 +
 net/sunrpc/svcsock.c                          |  50 +++---
 net/sunrpc/xprtsock.c                         |  45 ++---
 net/tls/tls.h                                 |   1 +
 13 files changed, 431 insertions(+), 46 deletions(-)
 create mode 100644 include/net/tls_prot.h
 create mode 100644 net/handshake/alert.c

--
Chuck Lever


