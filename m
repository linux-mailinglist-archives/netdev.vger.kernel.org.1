Return-Path: <netdev+bounces-139685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C969B3CEC
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DBF280D46
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A121E22E6;
	Mon, 28 Oct 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="byB3N/Us"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B231EB9E6
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151460; cv=none; b=TLSYfFSOusrTbv/LpQgQaBgRQ16fLEvjWvPcFhWt9EbPLnP2ToY4kuYYEE43DOECvzGgmjIyTMkDJQog0hYjykbpxuDLTrz+98BdIY0w2P+YJtxmqjUKy65dKNMzoTxtSE5+/K1ojfcMZBdm7LYdPUgu81g+/hsf/K/AV1TkuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151460; c=relaxed/simple;
	bh=/Fptveym2eKKF0x5Oma8JfPl+ff+1brHCM1fJcQRwVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQDaPWWg6+IVcfhHT+rzbnUmzHuKC6QuxgBZVrHGgOnjN50oDUr6ejUF+RdN8tsSOLw8t85DeC7rNdA/qjbTcBcaSSGqxhiu4WIX8rOqjAwfXqTmGwKsR+Q2N6Fp0VqxtNZe7FOdNfmGkVardxigf+2nK2OuaOC92aJERhtOqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=byB3N/Us; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fRCICEQQGv4K4ysWm0tUpGtXzi3Nl4Ow7zIuR7wNg68=; t=1730151458; x=1731015458; 
	b=byB3N/UsEqAZSRl5ZiktuV5kSTeWBIRFaecP1FED0ObGqMRh0iQ9DQ/evld4sfT1uebuJvW2VsE
	iS0+Ln52fTK344rYewc2+zKHMJud0qIn7OCp9gPvnHieD0oMYft65YoU9Ot4W63dFyFsO0Q1dRh8L
	AcqRCceZA0a6JniNuLW7YcEqiOd5SDsuUbqODKNaQJ0BZ7Z091Dwzkp5eMC+cBjWsb3vVsGlFEhvW
	9ifLNex/Lmtb7ByA/XWk5fc9yo1KLx5IQxHbdqRVU9PtNvXy3do8qUzFyKYkdRWDY5N81m/+ZnTTg
	xDRYu3ob5GXSoWRB5W7uLX06/kwl07r2MTdg==;
Received: from ouster2016.stanford.edu ([172.24.72.71]:54106 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t5XPG-0005xj-GJ; Mon, 28 Oct 2024 14:36:11 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next 00/12] Begin upstreaming Homa transport protocol
Date: Mon, 28 Oct 2024 14:35:27 -0700
Message-ID: <20241028213541.1529-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: dfe9a19d2d5d3f4658608889c96f7beb

This patch series begins the process of upstreaming the Homa transport
protocol. Homa is an alternative to TCP for use in datacenter
environments. It provides 10-100x reductions in tail latency for short
messages relative to TCP. Its benefits are greatest for mixed workloads
containing both short and long messages running under high network loads.
Homa is not API-compatible with TCP: it is connectionless and message-
oriented (but still reliable and flow-controlled). Homa's new API not
only contributes to its performance gains, but it also eliminates the
massive amount of connection state required by TCP for highly connected
datacenter workloads.

For more details on Homa, please consult the Homa Wiki:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
The Wiki has pointers to two papers on Homa (one of which describes
this implementation) as well as man pages describing the application
API and other information.

There is also a GitHub repo for Homa:
https://github.com/PlatformLab/HomaModule
The GitHub repo contains a superset of this patch set, including:
* Additional source code that will eventually be upstreamed
* Extensive unit tests (which will also be upstreamed eventually)
* Application-level library functions (which need to go in glibc?)
* Man pages (which need to be upstreamed as well)
* Benchmarking and instrumentation code

For this patch series, Homa has been stripped down to the bare minimum
functionality capable of actually executing remote procedure calls. (about
8000 lines of source code, compared to 15000 in the complete Homa). The
remaining code will be upstreamed in smaller batches once this patch
series has been accepted. Note: the code in this patch series is
functional but its performance is not very interesting (about the same
as TCP).

The patch series is arranged to introduce the major functional components
of Homa. Until the last patch has been applied, the code is inert (it
will not be compiled).

Note: this implementation of Homa supports both IPv4 and IPv6.

John Ousterhout (12):
  net: homa: define user-visible API for Homa
  net: homa: define Homa packet formats
  net: homa: create shared Homa header files
  net: homa: create homa_pool.h and homa_pool.c
  net: homa: create homa_rpc.h and homa_rpc.c
  net: homa: create homa_peer.h and homa_peer.c
  net: homa: create homa_sock.h and homa_sock.c
  net: homa: create homa_incoming.c
  net: homa: create homa_outgoing.c
  net: homa: create homa_timer.c
  net: homa: create homa_plumbing.c homa_utils.c
  net: homa: create Makefile and Kconfig

 MAINTAINERS               |    7 +
 include/uapi/linux/homa.h |  199 +++++++
 net/Kconfig               |    1 +
 net/Makefile              |    1 +
 net/homa/Kconfig          |   17 +
 net/homa/Makefile         |   14 +
 net/homa/homa_impl.h      |  801 +++++++++++++++++++++++++++
 net/homa/homa_incoming.c  | 1088 +++++++++++++++++++++++++++++++++++++
 net/homa/homa_outgoing.c  |  857 +++++++++++++++++++++++++++++
 net/homa/homa_peer.c      |  314 +++++++++++
 net/homa/homa_peer.h      |  227 ++++++++
 net/homa/homa_plumbing.c  |  997 +++++++++++++++++++++++++++++++++
 net/homa/homa_pool.c      |  434 +++++++++++++++
 net/homa/homa_pool.h      |  152 ++++++
 net/homa/homa_rpc.c       |  489 +++++++++++++++++
 net/homa/homa_rpc.h       |  439 +++++++++++++++
 net/homa/homa_sock.c      |  329 +++++++++++
 net/homa/homa_sock.h      |  399 ++++++++++++++
 net/homa/homa_stub.h      |   80 +++
 net/homa/homa_timer.c     |  158 ++++++
 net/homa/homa_utils.c     |  138 +++++
 net/homa/homa_wire.h      |  378 +++++++++++++
 22 files changed, 7519 insertions(+)
 create mode 100644 include/uapi/linux/homa.h
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile
 create mode 100644 net/homa/homa_impl.h
 create mode 100644 net/homa/homa_incoming.c
 create mode 100644 net/homa/homa_outgoing.c
 create mode 100644 net/homa/homa_peer.c
 create mode 100644 net/homa/homa_peer.h
 create mode 100644 net/homa/homa_plumbing.c
 create mode 100644 net/homa/homa_pool.c
 create mode 100644 net/homa/homa_pool.h
 create mode 100644 net/homa/homa_rpc.c
 create mode 100644 net/homa/homa_rpc.h
 create mode 100644 net/homa/homa_sock.c
 create mode 100644 net/homa/homa_sock.h
 create mode 100644 net/homa/homa_stub.h
 create mode 100644 net/homa/homa_timer.c
 create mode 100644 net/homa/homa_utils.c
 create mode 100644 net/homa/homa_wire.h

--
2.34.1


