Return-Path: <netdev+bounces-159465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8613A15942
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3433F188C039
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247E61ACEBB;
	Fri, 17 Jan 2025 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Y4TNiVpB"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E061B394F
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151221; cv=none; b=mkm9l9ch0I/iyRVJuTXA1k1Or94RatVjhb6MjV4sCCHFeMltWt2yBlYZLSo6lyQUhH3jRKxk0jtbF1FiBoY5S07d9fJUXjhLH2UxFFCcjm6YJVgucT3RQIE438ADVwu+6bxHx5ff1UfQbwmqmCvKO6Zb88UxmawguPGePQ5ezyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151221; c=relaxed/simple;
	bh=zOyHN4J5SzHuCoLdZaQ6Sz50VcvPgiiPgWFa6eOw9Ws=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VFN3+9W3CK98aF24+GopPA6iYNJ31Q/sccXEsizWOKhrZw49dXVGqUzITRf0BdGuYUQ14aj9z9hK//EFEhngBDByIWYsSbmcsPLkVYfup5Sq3i4PRRb/KheCQn6GHlGJpnKMuK77d2F0YASMjgjMepCWLMsLFTl8azFLhoGvjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Y4TNiVpB; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tYuNq-008tgG-UQ; Fri, 17 Jan 2025 23:00:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=lZrgMIPqrwL81qHRF7ZBsqshsVG/SOpFzOsxKOwVFdU=
	; b=Y4TNiVpBmoeSFAV9C06XmhyaSQmDN3tiNRKvwWCxB3sNONaK98e3QmG19MjOcUepqKiTrmzLC
	VgKX2FE/48ElY+RgeM7n1ZL0cB4YsiLrSVfq12SPb6XxOaC18YsHnX1Bc7saUKsUGichO2dx1qz8g
	OcIEqpwOax7HZkQEj+m7+6o1i/+Pwck+22x/StM10d51LAeUBWr7zu8ah22kIwN0JsgpMrgwvJkSa
	BlgL/TxfoZ6xCVXl4PYsJOXcCWl5lgJJWqd3l49kdvsj6lBWgCUjrUwvlqHcZ2gLQnsJCsm7NsDhi
	hQtLQbbK3c0X43OycUsRfqTQXTyu5g5YFrdsNg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tYuNq-0004sV-1L; Fri, 17 Jan 2025 23:00:06 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tYuNj-006md8-ED; Fri, 17 Jan 2025 22:59:59 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net 0/5] vsock: Transport reassignment and error handling
 issues
Date: Fri, 17 Jan 2025 22:59:40 +0100
Message-Id: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMzSimcC/x3MwQqDMAwA0F+RnBdoyxzor4wdMhtnEFJJOhHEf
 1/Z8V3eCc4m7DB2Jxjv4lK0Id46mBbSD6PkZkgh9SHGB+5ephWrkfpWrDYjfWt5i2ZMme7DHHN
 PgaANm/Esx39/gnKF13X9AJWyOGVyAAAA
X-Change-ID: 20250116-vsock-transport-vs-autobind-2da49f1d5a0a
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Series deals with two issues:
- socket reference count imbalance due to an unforgiving transport release
  (triggered by transport reassignment);
- unintentional API feature, a failing connect() making the socket
  impossible to use for any subsequent connect() attempts.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (5):
      vsock: Keep the binding until socket destruction
      vsock: Allow retrying on connect() failure
      vsock/test: Introduce vsock_bind()
      vsock/test: Add test for UAF due to socket unbinding
      vsock/test: Add test for connect() retries

 net/vmw_vsock/af_vsock.c         |  13 +++-
 tools/testing/vsock/util.c       |  56 +++++++---------
 tools/testing/vsock/util.h       |   1 +
 tools/testing/vsock/vsock_test.c | 136 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 155 insertions(+), 51 deletions(-)
---
base-commit: 5d6a361dc01d823cb7c10697f16695d45a82b909
change-id: 20250116-vsock-transport-vs-autobind-2da49f1d5a0a

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


