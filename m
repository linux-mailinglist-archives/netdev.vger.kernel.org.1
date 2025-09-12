Return-Path: <netdev+bounces-222616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4B3B55055
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A84D5A74BF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39430E857;
	Fri, 12 Sep 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="YimiIWHi"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5930FF3F
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685834; cv=none; b=EqZ+h304OS0Vd9EpAGfiWcJ1vQtTX+aaLXkLAEuzGMfFn1YFT4KN6VWpoTm+agfnDb9UgrJbb8j09eAh74zYUnwSv1LAJHNpRYSfyyMzxzIpeCSFtxqYcMjGwXsm3jI+ZPWazReC/uUKe/49mgdkefwo9hFeQZIY/LzSXmriHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685834; c=relaxed/simple;
	bh=UJVPDzd6dE4obJVjk0dJkD/HH5mi89UtaHiuwVysF1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fh4ahY7rATNZaDQNuoACNFKHlYFz+vXDBpbw/VQszA1qDQX9nOwQYOhId5tVkTkvcJzXPuXJkkCALWGvZ3Z6+f+gAnqoucoO3y3uCljWKivSOMGgWcQxPvicEkOvL1mOYzwyfTRIjSS50AQZHEyJNeEuh7d8z3rw8dSNQ0XtBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=YimiIWHi; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1757685825; x=1758290625; i=wahrenst@gmx.net;
	bh=wLVGluBE6IdZr4GSVZkP0cPDX+sxAivU67mv7RMkft0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YimiIWHilGwtdyJAuRYcXQ7RubU5OJJFr1aQ6nLApnPcxZGJpr3yfudiFaWxdR5E
	 bkZiQYyYAoo4lvCjqdk/gcTv3qp2KBlAQ8eEjJ6n0V21LMZgIGEIsZbyPkdLmgckg
	 iE+gRrhHvMsFAA1gNIeRk1/fH/u/96lHHyUh9Uojs66M6U7R4EiL6V1oC5cd8QlHQ
	 KshQMpaVKWo6fUJcUwTS+5Yw26eWgw2Bh1RR88dteBYQZ7rLMiGKbC4R7diGaF/eQ
	 8vKdnIHkE+27FEcbs6ug/7MqW5s9TYNv9fIKNAmKiY1J3M9s7GEEp5ZaLDry/gu4a
	 tyJg3vztfYeUn+N53g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KYl-1uM83l3kgj-00xRJl; Fri, 12
 Sep 2025 16:03:45 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 0/2 net-next] microchip: lan865x: Minor improvements
Date: Fri, 12 Sep 2025 16:03:30 +0200
Message-Id: <20250912140332.35395-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ueU4QuWlfurttcTsnvdsaDCfRgLl0pHjRO7REvV6qfhjHhb3OOC
 LLeormJFlGHTA7vPgKLo4rE5mOofStFW4BDnSYLVBpbRYr7oIcm6u721coVgxM923z6rim6
 nYFFeSSRWCtedkYTojv9Nhzhr2ik52aVa/c+y2wlb5pFbX2DbWHFB+lzfAdLKIKmieYqGAD
 my4Obnn6polexdxwLFwyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p3rFMd+UKJg=;DcSYc1KIbfd+3cVjbJheTvxjGTf
 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

Recently I setup a custom i.MX93 board which contains a LAN8651 chip.
These minor improvements were considered as helpful.

The series has been tested with the mentioned i.MX93 board.

Changes in V2:
- add Andrew's RB to Patch #1
- implement fetching of MAC from NVMEM in a generic helper,
  so lan865x doesn't need any modifications (Patch #2)

Stefan Wahren (2):
  microchip: lan865x: Enable MAC address validation
  ethernet: Extend device_get_mac_address() to use NVMEM

 drivers/net/ethernet/microchip/lan865x/lan865x.c | 1 +
 net/ethernet/eth.c                               | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

=2D-=20
2.34.1


