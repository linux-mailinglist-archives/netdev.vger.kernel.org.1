Return-Path: <netdev+bounces-251027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE260D3A308
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21BB13013395
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BD435505B;
	Mon, 19 Jan 2026 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KRoi2aIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DEA346AC6
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814969; cv=none; b=ATkdvi9rLMGJUhIMcRBcbSDpdt3PTWiUUjlapBWVrm238b6ml0qoy5yh430c2h+KS3EKPypGPI2olOKapjgWorTvrwR7bdHM4uCzyWsJG84c1Y7oSbQFijJw/wpAWZVAoP5ljHfy7zbQZuuTMyDB2Jweat99D5V+Y2UHLVbAeVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814969; c=relaxed/simple;
	bh=MZykRSDyhj30BjSCq2J6ccjOwanVT2N1C0ACoeLLSSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ms7wTHIPvGXlxkrhX8vGNiG9n+hkmJiyzrjKaKdynnnm2IWBVWj4fPFJxkSP15OrfMTgMH5ONjwSDROH17eBA/cJsKtYuhF6OxfdW/AZAZ0paqtTQZtJY8Hu4t1JTrUlOlf7pGq08L2k6fppQ2w2V3GvCPmKOkkt+msuJZCvlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KRoi2aIG; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a08cb5e30eso8690305ad.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814967; x=1769419767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCyc417zI+LatXSOTwvS8SNjJytYpjkoBZeOlVPfO0U=;
        b=JU+Qf13YFRNGqVc6FM/KmsmTrxL92Sh+nJF9Hcfcf5iUJNM8Fbjl4y3mSrFU0oPigP
         AJ1FmPxiJyiVTIbFGwdO8XPaT5j07sNi4N7gql3I6GyI7RNrzcui4cXc6CLBTscwQzCJ
         l6VA5lf1r8+uvKmRViW4k2kgOnO08L2sNcSSNUe/TsmR9QlCk17lThmlN7uvFFxxetMf
         eoL33B3CDQGYEMfDKjJdIC5oHSpJf6tZyTv+MXMRIZ0hQCcDDlZcLJbUJ288MYBPx94f
         A2Gq0EqH99zl69ryksh+0DClXzA6qw5zR3lys287IEG8DJJjWA8hE0pBNKR3zfi5dij9
         cqbg==
X-Forwarded-Encrypted: i=1; AJvYcCWCX3dUFpWauc8+F1yl0XolgkOG/EsuSC5crTYIv6MkqljbOzB4ix9KRBNtfFSC4jRrWJyyFM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zH+LyJtLX7TiuFS2b791ngr4/p4bnNwu68sG/7/U2UjF+/qA
	8rGiR/IWBzeDbUQG0QRbqfi6mbaYTTpwa2ugmLGuIiPbI5qJXols3qBsQfc/dOTTlSKvDKpKbDD
	7g6eQ5QYLtpCxMFkRBby9iv3EbUIxTdKH+wlzgkUQvecUKit4jPD+bonGEFwB8ewElzrsHagQfn
	0hGGgcWk+fDZOLe3/wbBCdxfDidKXTkDWUvO4bjBKwT0CJ8B6Z/XrCOJPQIKsD8RT3xId4T9n16
	Q5zGdHYKMCJDAQl2NZUO6BpFt20g3s=
X-Gm-Gg: AZuq6aJWQrJpi+g2mnb9kYlMe1qdPX1KF5+yGH7ayHVIxPk2bELYTbD0YMiGXSZJ54Y
	IFOhiyTnlt/Ik+fJec4XpiG7KVvXMcbIhfYTpeAEmrpJQVAhBQZo3ilIER7iBmD61UutlzvlXrj
	kHwuKmlqGsbFCaJEUFEgErYtwHaoaEjxktSbA18UGZW174WoGBQ/AZ5G+Ka4BlRMU87/OeRB54o
	QDIcpN1jarG2lRQBcWDqHIynRwAG9w2cU/ADLxI82bK541Xc+idFpbfbbB9myiLHTYRhAqJtSZt
	JFQv2pgZJsiYLQkuMnF7DGQ1oEFokb3eOE+K8mY/P1x8xjkhXNIvrvewPzohFR4crzrhCgFpDaL
	a5WcY1CHrsEw/kt56S1ojb6zNou27G405b0nJA0POJuXomLQcETB2ZJWTNcqB2NKyYZf8znCXy0
	vC/EdpXCigG1+9WW6LCIIAueTgynPDV1iuE17k+NBG2RAde3+1Gehe5eW3PqLYbA==
X-Received: by 2002:a17:903:2806:b0:2a3:1b2f:3db5 with SMTP id d9443c01a7336-2a7177dbb8amr48090115ad.9.1768814967531;
        Mon, 19 Jan 2026 01:29:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190d5587sm14087665ad.25.2026.01.19.01.29.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a39073c8bso15897536d6.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814966; x=1769419766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCyc417zI+LatXSOTwvS8SNjJytYpjkoBZeOlVPfO0U=;
        b=KRoi2aIGi2A1wPo6877aWaCxHp0Evo2+jceFRpB0iJXDhNF1f3hc7pYpRCHy6fSUnf
         H2xC9VmunsMLQ08p9BfA1z+aiQa1NdgHzGHAJ+y+idjdiAlw7Xp7h01CLvMyGU+lQ0Ar
         Hd9PboRF8IWvi7JA5Rn8nZMRnz4hzNSFtr6eQ=
X-Forwarded-Encrypted: i=1; AJvYcCXJfmuf7X3qoXprdWkRnA9J1UQfupMZrFgQQVvKeaOYVHfqyidbJZM6pqrOmQVeqIL7Y9gMcqs=@vger.kernel.org
X-Received: by 2002:a0c:e013:0:b0:888:3237:6fce with SMTP id 6a1803df08f44-8942dd8fad1mr137606356d6.4.1768814966267;
        Mon, 19 Jan 2026 01:29:26 -0800 (PST)
X-Received: by 2002:a0c:e013:0:b0:888:3237:6fce with SMTP id 6a1803df08f44-8942dd8fad1mr137605946d6.4.1768814965846;
        Mon, 19 Jan 2026 01:29:25 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:25 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 0/5] Backport fixes for CVE-2025-40149
Date: Mon, 19 Jan 2026 09:25:57 +0000
Message-ID: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commits are pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)
- 5b9985454 (net/bonding: Take IP hash logic into a helper)
- 007feb87f (net/bonding: Implement ndo_sk_get_lower_dev)
- 719a402cf (net: netdevice: Add operation ndo_sk_get_lower_dev)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

Tariq Toukan (3):
  net/bonding: Take IP hash logic into a helper
  net/bonding: Implement ndo_sk_get_lower_dev
  net: netdevice: Add operation ndo_sk_get_lower_dev

 drivers/net/bonding/bond_main.c | 109 ++++++++++++++++++++++++++++++--
 include/linux/netdevice.h       |   4 ++
 include/net/bonding.h           |   2 +
 include/net/dst.h               |  12 ++++
 net/core/dev.c                  |  33 ++++++++++
 net/ipv4/ip_output.c            |  16 +++--
 net/tls/tls_device.c            |  18 +++---
 7 files changed, 176 insertions(+), 18 deletions(-)

-- 
2.43.7


