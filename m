Return-Path: <netdev+bounces-132650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4BC992A46
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C801F230EA
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D481D222A;
	Mon,  7 Oct 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="SntZXmet"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007018C010;
	Mon,  7 Oct 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300828; cv=none; b=O/4RcHg7+uMit+UJTzCOHt71XcsipkDYHqS9dIBk2tMti/5vSD8IJrUfqe++xZrIka7+oWXn3wo+KXGptyXOCuu+l4X14ylIN+cjyv8EKmQLYk6YrQ2u8a3uYJmDc7EbNngXqs4qz7aemYozveywO1im3uOzc1heCXyU1MPRai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300828; c=relaxed/simple;
	bh=xKf4y0Jr8/LqYaeSglDR5RFuVmUMwn39i4VfwuxQRZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eHeQfB/pOcofbi04JAsNkIquKJtLBWvXkdyON78PuyEON3wwlSuIKs5cII3KeAy0sdBiSAta6wK4cFEzhPFv486Lw/P9Y1sBIQ0x1b3NZftJdI+51EpUd5OdFpaLWO/wJlYLxNUq0aDbdreTzfkt2M425XMnlVla10R45fC+8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=SntZXmet; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728300809; x=1728905609; i=wahrenst@gmx.net;
	bh=h/dH6z1VSRHTq33+ShAFdkC4Q0hfIyeIUwjhK6BYJN8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SntZXmetWJJFI1gneNJSm225h7wAvrkhxgrowViO0hkmbtK9LSsf63OPVSDkXGZj
	 AkQ0KWMDtro4QQTAzW4yARD6b5LA/wbEEk/kWKp5XvS+zBtAWATPZG23aGBLOnbZW
	 C0QflFpQZpLZar78sjIWav+FhtRupP+Bdb6jLUm98LFr7Bm137jYGkkaVpf4xTWIY
	 BQhDWjh3Sedb058z4AvmiovuTwaZZbOfYW3ZlrLJLXXGWOyIxFRO9AlwQDLP904rl
	 FJCidBbllWBuJ7eMC25Ti4Np/9mLgp1a8HHgiOmQsrGBnjxLqoW2lgc6CwBaVsRhs
	 3SLl0ZkHW8746UOLnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMyZ-1tJRc00zI1-00PuCA; Mon, 07
 Oct 2024 13:33:29 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Heimpold <mhei@heimpold.de>,
	Christoph Fritz <chf.fritz@googlemail.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/2 net-next] qca_spi: Improvements to QCA7000 sync
Date: Mon,  7 Oct 2024 13:33:10 +0200
Message-Id: <20241007113312.38728-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nnbAoTjReWKIET9yrsv0bAR7IB+3jf4JyOtXcWTzVO5MD2UzcBY
 XCNdiog6P3gVZr/QCsnH08jLFOmI2QcwS5rraJGAErXrMG1NOBpSPFbL6ObR6QGuWudUrxc
 NWf1M0juGeuwxkJwKoB3I30PZgK1wZAHWOf3d5w6VUFqCyyQ1KZFSKnT27jj2EECS8JwjCn
 /DIyYM9OWoa3T8f9Adp9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oLtj2MWjjK4=;F5gKXbh33g3xyWh3K7gjvQqIHm9
 n0TBByumIVvk8jUWfIEOjEQK76lDSygTkxdTcQgzulMOuPp/WipttxbGr6rDB5kN7C1tkTN82
 67SCBKb5fGZKk3qZ23Mabt30sCSYXUCjM/mF6lZupwTE2c+c8XBbDWqrsT5VJP2Tz6fC3oNLB
 ZExyaSqlZGbCJpjMR8vifH3Fm2F8vAIy1y5pRdMLt4zLhQSf5Svkp2q8HQlHm5vEVufsvOx+K
 YSW7CuTWErbPOK7DAah+r2JmJ7HnLWbjsoIQ2al7NaUcd75d2S0qshIEz02BDOLAKdcmOH1Gh
 FRIgPZfCPsxrLV4KIkxVV94N3GPr/Er6QJNhmXV7AoP4WjCBXZenOJEWYKdZcNLZCohi9cCqC
 ucPRCIb9ycuQU3zYz3nH9XcV3PEWbsL6NcCPJM93lm9jK02E9rFwH+qNvkrMKcUHozzUmwbTx
 dys9woDApqrIhO+tZWLV3ILAYy1PnF5M+FHQtvNz8WKPe9rakOa9KuSBk/boO977k8kmuIbYf
 4a/uUYpnk2sYjf58EAk8PJg1lLJegxHtcSJahJAbL8rubsIFLwKG8CaQEbn9j0Hf+AcdDiXXc
 SQVvSBmsqcfQxiN5zIaIbkCLWoAt9CLXWN65tgxhrkkMu27RFgY4lUXUMsoM4fqwaAWw5qIDh
 iC2HIuAaMrdZyhifl6daPqvyEhbkKPsKr3MVVDjvWgJFJIYSYsEoOkl2O7WDGoXy0Mak7r+0c
 B3Kw+QYPYXyXW7l+FrIfhkDGOtLAGfNV2RoOqS4e9rJbv+nQRKRVXT0ufIqIlIQZ7NBu6aso1
 a1HP9U5iUm6HSdj4Lw1uQTMA==

This series contains patches which improve the QCA7000 sync behavior.

Stefan Wahren (2):
  qca_spi: Count unexpected WRBUF_SPC_AVA after reset
  qca_spi: Improve reset mechanism

 drivers/net/ethernet/qualcomm/qca_debug.c |  4 +--
 drivers/net/ethernet/qualcomm/qca_spi.c   | 30 ++++++++++++++---------
 drivers/net/ethernet/qualcomm/qca_spi.h   |  2 +-
 3 files changed, 21 insertions(+), 15 deletions(-)

=2D-
2.34.1


