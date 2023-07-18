Return-Path: <netdev+bounces-18698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A0C758538
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E55E28118C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A4156C8;
	Tue, 18 Jul 2023 18:59:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE12168A1;
	Tue, 18 Jul 2023 18:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24123C433C8;
	Tue, 18 Jul 2023 18:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706742;
	bh=tIW9F0blQmONjRKCihDyCkNqERk15KypUIIFVcxHNwg=;
	h=Subject:From:To:Cc:Date:From;
	b=e43bOvCZ4gd9TuGJ0WdHOvbnfSfKHB6gzcrZ7InKZ4yb2ok7KR+vQlplbT5zx3CVW
	 zRx3i1kbdqT0DttCYmJf9thdVj77POBUem4daChelxAMjQkGiVk3jr0mRqtgIipqSH
	 axKllIm/MlouXGpn2a3u1DkNl8PB78kEkp+Z/OZNXC2FkSlPb/QqveI/DAknxRPZUC
	 2LcfLdMi8sjyRzMlBezd5QKRsAT8IhVi3PyLBRCmkWQW9jxTeL05njDLZtCeGr+jwF
	 Drxudl5XUKuyB56xJNPBvDbFtPyZt5Z9+1kbRLe4jWo3y/IXB3Kguv1PN7rulpq/V4
	 Td4swHdbfT5zQ==
Subject: [PATCH net-next v1 0/7] In-kernel support for the TLS Alert protocol
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 18 Jul 2023 14:58:51 -0400
Message-ID: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
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
 net/handshake/alert.c            | 115 ++++++++++++++++++++++
 net/handshake/handshake.h        |   4 +
 net/handshake/tlshd.c            |  23 +++++
 net/handshake/trace.c            |   2 +
 net/sunrpc/svcsock.c             |  50 +++++-----
 net/sunrpc/xprtsock.c            |  45 +++++----
 11 files changed, 433 insertions(+), 46 deletions(-)
 create mode 100644 include/net/tls_prot.h
 create mode 100644 net/handshake/alert.c

--
Chuck Lever


