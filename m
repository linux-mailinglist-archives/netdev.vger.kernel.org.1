Return-Path: <netdev+bounces-291096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHWTCnyaEWpSoAYAu9opvQ
	(envelope-from <netdev+bounces-291096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:15:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 766075BED7D
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A655F30134BB
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6DF385D7B;
	Sat, 23 May 2026 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt2/qmco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0834FF74
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538542; cv=none; b=t83++X/4gj1vICxvNNUwy3obY42tQFBppAPTz/8U+nX/wxw2EG1a2kYOgAzoczwg+re1FZKMnURcmdv6azaWmi7tU6Z7ThtFiqpnlauYFqQttt2NiX/bzE2VOTy3SkaYBk3WrR8OsyazujujW84UWuKk6dwPwCaHnoQlDbuYPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538542; c=relaxed/simple;
	bh=WhlLcVVQjPEplzTRwPQy01UeCnAZv2FoMEU1WX5UEfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEkx4RG7j8q6qnwde7UweZTpDtkmlT+bCeXCojLx412KrmMNI/jo2dxMvZBvGGLdgQF7caBIubLn6x+hj0yapUpaU1ODSxTOsEkX3zlGN8PGATRRxsgjSiDe0qVBLIYE2UzuIqVzwJUlSB78YHUnvbgc5cm6AqLJFuuEEtCWPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt2/qmco; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba17c8cfacso84627265ad.2
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779538541; x=1780143341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DK7qqqpT4fnZlS3XGu6aIqnYT1MOPYfSV+g6L0GEpFY=;
        b=Jt2/qmcot64yPJ0VtmTXTp0qPREKBhDCt9IuYIdrMiluV8X5By8vGaC1S3TKy6aCyM
         v4hmUl9355+tz/ODSd+DEPfST5uEAOdfdYPOuag/zFDQRQMmDZfe6zyZ0g2TBmLNiIrT
         cV3awhasHJDSQOM1uYsNmK+9Zf54nM2V6AO3WDSwL9XhBfw1Yz4FbObgaCMlVN9g3A4V
         y8mlRr+UkaJWX/SLrouy+FmOdyO955UQ9FnWTCPdhiIjk5ldc/tJHcYDeu4X3CM2DEUn
         WkA1bAnqecMF3+g2IYYqnW7U8dH0DKp9axU3HASL42p9VUhQJpsPssSwXSeli0nqjonw
         VZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779538541; x=1780143341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK7qqqpT4fnZlS3XGu6aIqnYT1MOPYfSV+g6L0GEpFY=;
        b=dRICGMuUvQUFklbiky4xock2nxZfSEjPU3lFN96MNcsyUlbQ/j12CQfeNShR/r4ula
         XpwGQd3otLpMGU1orzc1pOC0BugdN+lm7FltiN6l4FUKkAO1TZ/dZbCVU9ziN8zEh74L
         vWM7T1bl0RiRbx8qSwo7kP88gJSAWWN07Wqd02TgROlVlQWljEdEqJ0RG5ib6wjaIEYj
         hdjKB9HLDw4+zMbT0xTFADE+7A+Pil3/oBTI27DNAvc43tT+H66apncADJRy1mTkCtc4
         DrvCX8D1OeqCZdYkmz8UGsmMT90GeKhUmScH7BJNQBmSbmuK9kR2KUOg7mDAkbdGvqqk
         e+Fg==
X-Forwarded-Encrypted: i=1; AFNElJ+cOBYN2qzOJ+jSe+ptTCJbvd7LYjhDjUbcVWHBNkfltf9Fq6pBUp2P9us26S4zZNndIZ9pbds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXyuYhMsRnCBC6csPAzcxZYfuisDwTjGNjzJKFLg3knR3j6YH
	KHdTvVV9c1lVB7c3Q+pPGNMWFi8b3ZBHPYFraJvF84ncrzjnhJe8rPD5
X-Gm-Gg: Acq92OF64TkBfwSq+coCDqiEgCDqNYqjW7+vRxrT2TqhvADrQB/PuxgZK7CYFqEepc9
	/Xdcnbct5Nau5QCo64SjgiYrBcuMzBEvaGcbThGYnmKFTi4SPzsy6+kuPcQUZCxGQUTTS3GO1AC
	L1N/6pNccdf1r505gFZd1B4qOOysDpjtk7ziNvwDI5uiMd0JZQB67WV8WDEO7IoO0ndVOZ1Xz0x
	ED9EifgA7JkLLQSSFv/pd4Mf4J4NsmEnnLCxggB+yCqAteSptAp+6U+NX5GjJDXlpWUdbw7Uq65
	8em97dV9sueGzKGkMzkDODl5mGHjNJfeGC7S6cYsrqkUzcVBBunO+GO8rkKsghHeuneQiH2LEkk
	EkenMIqrdELpBE+P4nQT+N6jTzYjZPGj67O9kftBHHtFgk+TZo70aEJvg7x8feuAbvWle1XgAq1
	EBdWJKRuRTqlN8iTdsj4Fi5MNT
X-Received: by 2002:a17:903:388c:b0:2bc:a577:70c2 with SMTP id d9443c01a7336-2beb06292f1mr83238405ad.31.1779538540585;
        Sat, 23 May 2026 05:15:40 -0700 (PDT)
Received: from mincom1 ([125.149.177.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ce4easm41746305ad.30.2026.05.23.05.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 05:15:40 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH 0/3] Add packet-mode ESP offload for Airoha/EIP93
Date: Sat, 23 May 2026 21:15:19 +0900
Message-ID: <20260523121522.3023992-1-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-291096-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,lunn.ch,google.com,redhat.com,secunet.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 766075BED7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds the missing plumbing for ESP offload engines that
operate on whole ESP packets instead of only exposing AES/HMAC through
the crypto API AEAD interface.

The normal ESP software path can already call into accelerated AEAD
algorithms, but packet-mode engines such as EIP93 can also generate and
consume ESP packet framing: padding, pad length, next header and ICV.
That needs a slightly different XFRM offload contract so the netdev
driver can hand the skb to a packet backend rather than trying to make
hardware fit the software trailer layout.

Patch 1 extends the ESP offload infrastructure for packet engines while
preserving the existing behavior for drivers that do not opt in.
Patch 2 exposes an EIP93 ESP packet backend for encapsulation and
decapsulation.
Patch 3 wires Airoha Ethernet GDM netdevs and DSA user ports to that
backend through xfrmdev_ops. ESP GSO and ESP TX checksum offload remain
disabled.

Runtime testing was done on a Gemtek W1700K2 running OpenWrt with the
same changes applied on top of a 6.18.31-based kernel.

Test parameters:

  - Static IPv4 transport-mode XFRM SAs between the AP and host.
  - ESP transform: auth hmac(sha1), enc cbc(aes) with a 128-bit AES key.
  - iperf3 TCP test, AP as client and host as server:
        iperf3 -c <host_ip> -P 4 -t 10
  - The host always used normal Linux XFRM software processing.
  - With AP ESP offload disabled, the AP also used the Linux XFRM
    software path; in this setup, EIP93-backed AEAD crypto was still
    available to that path.

Network-relevant test setup:

  - AP: Gemtek W1700K2, Airoha AN7581/EN7581, 4x Arm Cortex-A53 at
    1.4 GHz, 2 GiB RAM, airoha_eth wan (GDM2) netdev, 10Gb/s full-duplex,
    MTU 9200, EIP93 crypto and IPsec packet engine present.
  - Host: AMD Ryzen 9 9950X3D, 16 cores/32 threads, Open vSwitch,
    MTU 9978, backed by a ConnectX-6 Dx 10Gb/s full-duplex link.

AP to host iperf3 result:

  AP offload      Sender          Receiver        Retransmits
  on              918.2 Mbit/s    913.6 Mbit/s    0
  off             782.4 Mbit/s    778.6 Mbit/s    3569

This is a 17.3% receiver-side throughput improvement for the AP TX ESP
path in this setup, with retransmits eliminated in the offloaded run.

Jihong Min (3):
  xfrm: extend ESP offload infrastructure for packet engines
  crypto: inside-secure: add EIP93 ESP packet backend
  net: airoha: add EIP93-backed ESP XFRM offload

 MAINTAINERS                                   |    1 +
 drivers/crypto/inside-secure/eip93/Kconfig    |   10 +
 drivers/crypto/inside-secure/eip93/Makefile   |    1 +
 .../crypto/inside-secure/eip93/eip93-ipsec.c  | 1413 ++++++++++++++++
 .../crypto/inside-secure/eip93/eip93-main.c   |   69 +-
 .../crypto/inside-secure/eip93/eip93-main.h   |   38 +-
 drivers/net/ethernet/airoha/Kconfig           |   11 +
 drivers/net/ethernet/airoha/Makefile          |    1 +
 drivers/net/ethernet/airoha/airoha_eth.c      |   51 +-
 drivers/net/ethernet/airoha/airoha_eth.h      |   69 +
 drivers/net/ethernet/airoha/airoha_xfrm.c     | 1474 +++++++++++++++++
 include/crypto/eip93-ipsec.h                  |  132 ++
 include/linux/netdevice.h                     |    3 +
 include/net/xfrm.h                            |    8 +-
 net/ipv4/esp4.c                               |    6 +-
 net/ipv4/esp4_offload.c                       |   29 +-
 net/ipv6/esp6.c                               |    6 +-
 net/ipv6/esp6_offload.c                       |   29 +-
 18 files changed, 3324 insertions(+), 27 deletions(-)
 create mode 100644 drivers/crypto/inside-secure/eip93/eip93-ipsec.c
 create mode 100644 drivers/net/ethernet/airoha/airoha_xfrm.c
 create mode 100644 include/crypto/eip93-ipsec.h

-- 
2.53.0

