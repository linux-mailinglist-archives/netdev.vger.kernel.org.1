Return-Path: <netdev+bounces-161321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063FCA20B1F
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F693A52B4
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F21A08A6;
	Tue, 28 Jan 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="mK5kn2YI"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943026ACD;
	Tue, 28 Jan 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070169; cv=none; b=ArKXtFzUASJLaWXgmA6T9rof394bYswPP6JLlceIzk/Wte/0SuDbYEt3LAQQnaPBr+ozk26ThSxSR0kFN1+3000pd7K7MSG4eVC3bIrITFEddqfkVxMgp5XgOq63n1IcFz8iR5Q5X8fQgGrQz9XoE/96zozDtsTvdSfU35NQkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070169; c=relaxed/simple;
	bh=oI1njKZ/0zBPQut765XFyPe7ZRA4d0h9ArgkXeasAkM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NbVny9TW9FblDlLxwTCilINw8pWKYZH1lAhjjaQO59lQMUIO3gji+uX0JiAE9cDMwFzjDJKn/ox+D7eQdferzx+INxqHjVb1lSNrJRdIxSfPym1mb0U0F5w1HrF0diSP95gE09JJ3yMtlFGcvburzl56WcYcdeZwkgOoQcIvd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=mK5kn2YI; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tclRj-002o4M-GL; Tue, 28 Jan 2025 14:16:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=g5DPFjwAJruYCGKJSY8OTRgGKcoAebP9ZM1Trl+quIA=
	; b=mK5kn2YIJ5Y7PnhCnR/m9P5BZEdoWAkQDFvOqPVKtxh7z63YJbn4gxCyV9W7rmAt90RxYOPc1
	9MAWtODqYVSUVg0uqCpHBRtY9tTdHla1Q1NGL6PWBTdM1Wp9B1YZBEpem+HfOpi/3y9qbecd5/WOS
	4lfNOP6k0nhAzJpPqwW6wHCQRJKLwTtLrP4LPS1QZDPMiLNIZefIIOPgkdDqTeUi6OiRBzAvqoBBJ
	6cP4sZqPkAs/h0/u56s6OcACnT8P06/ezJ1cSXZEtg20G6rdmMY8x2fd3UKY+H2N6cDlwY6ZIugGP
	Fp8Wvf3LBQkPRYVe5bVGquZ6LyEbJzflIY/UOg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tclRi-0006w9-V3; Tue, 28 Jan 2025 14:16:03 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tclRI-000mZg-Rl; Tue, 28 Jan 2025 14:15:36 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v3 0/6] vsock: Transport reassignment and error
 handling issues
Date: Tue, 28 Jan 2025 14:15:26 +0100
Message-Id: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7YmGcC/33NwQrDIAyA4VcpOc+htrXtTnuPsUOqdpWBFnXSU
 fruExlspx5y+BP4skHQ3ugAl2oDr5MJxtkc9akCOaN9aGJUbuCUt5QxQVJw8kmiRxsW52Nugq/
 oRmMV4QqbYWKqRYqQhcXryaxFv4HVEe55OZsQnX+Xj4mV0xfvDvHECCWypzxP3Qmurn5061m6o
 ib+J3F2LPEsISpBxYCN7uVP2vf9A3t21gcTAQAA
X-Change-ID: 20250116-vsock-transport-vs-autobind-2da49f1d5a0a
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
 Michal Luczaj <mhal@rbox.co>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Series deals with two issues:
- socket reference count imbalance due to an unforgiving transport release
  (triggered by transport reassignment);
- unintentional API feature, a failing connect() making the socket
  impossible to use for any subsequent connect() attempts.

Luigi, I took the opportunity to comment vsock_bind() (patch 3/6), and I've
kept your Reviewed-by. Is this okay?

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- Rebase
- Comment vsock_bind() (Luigi)
- Collect Reviewed-by (Stefano, Luigi)
- Link to v2: https://lore.kernel.org/r/20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co

Changes in v2:
- Introduce vsock_connect_fd(), simplify the tests, stick to SOCK_STREAM,
  collect Reviewed-by (Stefano)
- Link to v1: https://lore.kernel.org/r/20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co

---
Michal Luczaj (6):
      vsock: Keep the binding until socket destruction
      vsock: Allow retrying on connect() failure
      vsock/test: Introduce vsock_bind()
      vsock/test: Introduce vsock_connect_fd()
      vsock/test: Add test for UAF due to socket unbinding
      vsock/test: Add test for connect() retries

 net/vmw_vsock/af_vsock.c         |  13 ++++-
 tools/testing/vsock/util.c       |  88 +++++++++++-----------------
 tools/testing/vsock/util.h       |   2 +
 tools/testing/vsock/vsock_test.c | 122 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 153 insertions(+), 72 deletions(-)
---
base-commit: 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a
change-id: 20250116-vsock-transport-vs-autobind-2da49f1d5a0a

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


