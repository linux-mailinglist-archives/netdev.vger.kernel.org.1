Return-Path: <netdev+bounces-297072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nq1dMcQjKGqb+gIAu9opvQ
	(envelope-from <netdev+bounces-297072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:31:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA26610DE
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b=oXGGFQmP;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=a4gqd+eS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297072-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297072-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5ACA30B1AE0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99289340A6C;
	Tue,  9 Jun 2026 14:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45B22425B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:21:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014900; cv=none; b=mmEMhRvivPYBmlUmx8ghzOHbeAVk3zyR0eXuyisXQ9/wfaq7FROfuRGhuqrvsCZMSFYQmKvfcvrgTdnthYR1WdzDwSxyLPBhLns8N9a6IjMbEx4RRbOi1qayRY4i/4ES+cTqJ5iBuI4QspGlFOO4LGt8RkBBH56KVzPR6Ex28ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014900; c=relaxed/simple;
	bh=OaMY7F3CLZwtyHcsjMq5ztMoXn/pnQZq+Yhh2bEBDIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjI1OPkat3wKvPcBDkXBxgPwPe2aevsIQg+aGFlgLqiiBp6DsfjDIIO53rbiCWS0TueLttTStkPFOt5z4weE4uzfIgcT/KPIbBTz8Ngbudm3HwY4tYAfairrOQIwjDtwU/115Qn5MIf5BTvRQ+1cwMgo/dzHdjoeKlUOoT2PRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=oXGGFQmP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a4gqd+eS; arc=none smtp.client-ip=202.12.124.147
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B3161D000C3;
	Tue,  9 Jun 2026 10:21:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 10:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1781014896; x=1781101296; bh=ku8VLCRpj4
	MWRS79CuArLHV62+1fraFgnGpzL5XbPEw=; b=oXGGFQmPZiVMffbbXvE6fZhntJ
	MPkG+6CbHOhDY+wh5haWnGI5lQg9n57F8OU+4l0EqqJHDhbaFmOlE1FYRngq6VOW
	ZI1a6KE1T1kYdZkkKH9m1cogPQdJmT4pWueFNnnz8388NpKegw80sjb9SN1h7ufU
	6O6LHjUhfJQ9Iua+Dwii5Ld3Xxso+RdFSdSH7c1QdBSi/Ra7PhCnqoIyubV1FkPE
	rrkwPZpPq3ss4R66tsXOgA43qJJjS1Xc2rsdQ6WvUVq8+63ty9is+dHNlhRh6p6m
	u3n4p+YGT+ndOjMYeFRlp6+GW+WRMFSxkyrofpAjqA1rwylzJhTCrrgiMcSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781014896; x=1781101296; bh=ku8VLCRpj4MWRS79CuArLHV62+1fraFgnGp
	zL5XbPEw=; b=a4gqd+eS4T5mS+h+6RCkyWICejdH6tWewwTnOCY+lXx4asA5xBd
	POHVGNS1mVAlUg4ukEbfphL50V3l63L0Xnmo0X1GvH3BWxSgUsGNRigqb8vespeS
	IsJNnKeNF+FByK2D/3PRr6LkMO+11LwW1vyjg0VX7VTEvqhW7o6NodP5YU5Tv3ah
	J2aw1ZUSucGB1XkoEb0Pk7BO5KYOBVqd83xOnq5Wzq32dZTgyAVIU618SHNWw6NH
	MTFSDuAFPmND6yRaXSCNWGmiIlomSy2NUtQGatigJ4UdWloAHwwFc5YUn3TEKtB9
	nC1TSiVPFVVIMwKdy3bE0EQ+SmxjmdPmGKA==
X-ME-Sender: <xms:byEoasN1viiZ8PTyZi_mZ8mv5GpNnO0upb14geuQN0W8u7QjqrqZwA>
    <xme:byEoavg8dZhIFIad6t8IN0jMo_OL0f3gA3tkqEFh6EUMyqzbiU70MoV2c2rb9pzAN
    vthyQQ-tlB1gKQfw-Ydthi_0hbpoWhXBcpkFs_wrPW5u7Q8Ndc0Ut3->
X-ME-Received: <xmr:byEoanv-9_a_Gdo3UZi0OhzjdNqwott2m5rd2OpUc1pwQ0V3XXQkMpCI9vhc-anJ6iSM_vM_FiBt7x-4nEreFUU>
X-ME-Proxy-Cause: dmFkZTFE0iMOFAtn2idnhI8EvF2JYEtiljAsQ+jcA7+8OZQuvobPu643JM5zcBCYezBRBs
    mz77L1i89+V+rOO6dKCL7SN+RtKpXfVjWqckxpSgU37ddJUHKojhpYFvTCDPXfoZVdetIX
    m6w5lrQtNf14/4eVpA5yC6G/a0F/9a4iIV7tJsRFMSSTZzYqph+2YP15dOB5ffGx0CxhW0
    ZbzpNpaZzNhS9HkGst5RURJPpu5K4VI9QJn6xuds46fU8yviL6abO5ZGmOXpIgaPDiwjIl
    kO+KXma7PKYO9WgvfyktiiEe5hRy1o3UHZ8YbF6p+uaKxCy0M4Bj0E2xeKqT847RZp9Qi9
    w0rHBExPzXyD6fx17jWECIYiJE7j0YPBH3BSpNF6d/smHkifebiRKLYlE378fZ2ceX7RB5
    WPimr7EvVTwT1DJxoNZYgUcJ7a5/Qp1ZNbNWaDnd6FsqI4yEzNo8ArSMAanayZTRXrIEqO
    yVS5PXjwCYGpwpVAmufcpI5t9lTE5duvvx4KeGsvbZZUg3KqR/1imQs8mBiVTASfWtzYEq
    s6AmOMIw/PzaAuzbGqXt8+bsHjcSKexQivZh0QJ5o2L/IamWdovKi43Vy1L7VTUghS+rDy
    v6RKFiaKIjlhPMxL6S9VEFlsmjbTz5G6+w+9pOnZz2WNzu9f1fFezpEHOuyQ
X-ME-Proxy: <xmx:byEoarjdEmr_0rD9ooMcKkCGXRByCug9TOQrkGSuoZ3bP-5eA83-fQ>
    <xmx:byEoalaP-W7SFoIkFzHZqeUldef1v805NJfuTAMi4gGEbQD-I2Wmjg>
    <xmx:byEoaibDUwexmnH23gDhaxdjDYXKiJBXuX_qQqgpHjKPwGX7UxCgvw>
    <xmx:byEoaiykxs7FWCnQIWZRfVGepMUAm_KXFYXbWTmchKzmF1EmON5qMQ>
    <xmx:cCEoaoCoL_4KiTdxzPTcgg8OsfewZzm_mGmKeLnCKO6w0FwrMfYOyIua>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 10:21:34 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/2] net: remove tls_toe
Date: Tue,  9 Jun 2026 16:21:20 +0200
Message-ID: <cover.1781013810.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,chelsio.com,gmail.com,kernel.org,davemloft.net,lunn.ch,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297072-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:ayush.sawal@chelsio.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,queasysnail.net:dkim,queasysnail.net:mid,queasysnail.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91AA26610DE

This series removes the tls_toe feature, its single user (chtls), and
cleans up the EXPORT_SYMBOL()s that no other module requires.

Tested only via make allmodconfig + make.

Sabrina Dubroca (2):
  tls: remove tls_toe and the related driver
  net: remove some unused EXPORT_SYMBOL()s

 Documentation/networking/tls-offload.rst      |    6 -
 arch/s390/configs/debug_defconfig             |    1 -
 arch/s390/configs/defconfig                   |    1 -
 .../ethernet/chelsio/inline_crypto/Kconfig    |   12 -
 .../ethernet/chelsio/inline_crypto/Makefile   |    1 -
 .../chelsio/inline_crypto/chtls/Makefile      |    6 -
 .../chelsio/inline_crypto/chtls/chtls.h       |  584 -----
 .../chelsio/inline_crypto/chtls/chtls_cm.c    | 2336 -----------------
 .../chelsio/inline_crypto/chtls/chtls_cm.h    |  218 --
 .../chelsio/inline_crypto/chtls/chtls_hw.c    |  462 ----
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 1836 -------------
 .../chelsio/inline_crypto/chtls/chtls_main.c  |  642 -----
 include/net/tls.h                             |    1 -
 include/net/tls_toe.h                         |   77 -
 include/uapi/linux/tls.h                      |    2 +-
 net/core/stream.c                             |    1 -
 net/ipv4/inet_connection_sock.c               |    6 -
 net/ipv4/inet_hashtables.c                    |    2 -
 net/ipv4/tcp.c                                |    4 -
 net/ipv4/tcp_ipv4.c                           |    1 -
 net/ipv4/tcp_minisocks.c                      |    2 -
 net/tls/Kconfig                               |   10 -
 net/tls/Makefile                              |    1 -
 net/tls/tls_main.c                            |   17 -
 net/tls/tls_toe.c                             |  141 -
 25 files changed, 1 insertion(+), 6369 deletions(-)
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/Makefile
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
 delete mode 100644 include/net/tls_toe.h
 delete mode 100644 net/tls/tls_toe.c

-- 
2.54.0


