Return-Path: <netdev+bounces-21030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0E76235F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE92828107C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC62D25909;
	Tue, 25 Jul 2023 20:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E024181;
	Tue, 25 Jul 2023 20:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984E5C433C8;
	Tue, 25 Jul 2023 20:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690317336;
	bh=wgC3dfxNsSskFWwCgc71Oa9GPok0TxBn/X51NgFutNM=;
	h=Subject:From:To:Cc:Date:From;
	b=bGTRWrUWIO0D2bklzLdIhzUYXOcF29OnSJM00dadiNhI323HNEXi/xzWl4TZT0FiF
	 WOGBXgY49l2uTq4qZ0EyCC9Kfp4/VcLROdkPh23ChcLHKxhTa6vxnIKYbxslx9M2b2
	 KqxDlQIGYoFUee1fB0j2LpA5eWjv1M0BfkocTnmnVHNiJDiDCZO3QCm9/Vpip27Z6E
	 +EKqZGdp7iJYz5BRsGra5ZGiM7km4aI69ld1TjC7X0S231RSFV4fBtHGkK2t9XJGFY
	 I6ENBefJEF0q5a67cnrHfHInAe8xJesgvKapR10JfjFlj9JsCBWU0OlQKzlSgYfJdp
	 yr73n2A5tRiQw==
Subject: [PATCH net-next v2 0/7] In-kernel support for the TLS Alert protocol
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 25 Jul 2023 16:35:24 -0400
Message-ID: 
 <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
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


 include/net/handshake.h          |   5 +
 include/net/tls.h                |   5 +-
 include/net/tls_prot.h           |  68 +++++++++++++
 include/trace/events/handshake.h | 160 +++++++++++++++++++++++++++++++
 net/handshake/Makefile           |   2 +-
 net/handshake/alert.c            | 111 +++++++++++++++++++++
 net/handshake/handshake.h        |   4 +
 net/handshake/tlshd.c            |  23 +++++
 net/handshake/trace.c            |   2 +
 net/sunrpc/svcsock.c             |  50 +++++-----
 net/sunrpc/xprtsock.c            |  45 +++++----
 11 files changed, 429 insertions(+), 46 deletions(-)
 create mode 100644 include/net/tls_prot.h
 create mode 100644 net/handshake/alert.c

--
Chuck Lever


