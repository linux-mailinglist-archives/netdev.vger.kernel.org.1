Return-Path: <netdev+bounces-207453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F0AB07520
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DDA58348D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF82F49EA;
	Wed, 16 Jul 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="M0GuYFvc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FDF2F0043
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666906; cv=none; b=ZrCt2n2CEc8uLLW0t7v5+BWzcI4jBM3I7HYB/U5t/vYgiEvi1kWLFAY7bhvrhH1OKJZfnQn5xVSgniJsfa44eBMAwo4X9PglXZKfmkrdfD83SaoyI8g1+IfpLwwe4/NofaWbE4UEpzOBclwDKrgs00qinIHXbyMXRFSbJty9794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666906; c=relaxed/simple;
	bh=b/Qr9fmfhU3zQ+ZlD86/dATEmD0yYa42hN/E8r9sTbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDR6k3Eebc5LKZZLD8VnnnJmqtYipp0+h4nqme7Kd987MTfZhUkpPTBD/8MIBy8CmutdIiw4hpBkXQQpu3PS6IHfHSo+3v5V3+vhK+q45IJmnipjrWQ68xnXs8npznY5l82bSXbdiVYPh8m7wfdwIcEnB+EGzNIHlFnQCYqxBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M0GuYFvc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso1210088266b.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1752666902; x=1753271702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Uy3kYc4RUx4HHgySuBAkgm8TQlGkSMGNPbV3xstLBQ=;
        b=M0GuYFvcIGHqlIPNAstlG4qkvwG7nDHFd9I+hwwQUXzy3Nl2vY/5rlOK5QJXw6ZhwO
         fM9JZYn6EG0wkq2MsYo0DI21dQDGMHbFFNyqt8U1uFzOtCPelJa41qWcU37x9AwKjNdY
         J23dPo7CiJ0d16F4XBz2WzhuEtqR2P0JtP26BchOqiNQfYggUVefjXavp7hGdzXicfVH
         B7SEyBvBndnjoQ5sZ3BTYNYGbaBYrl9Rt/FZtbIkRSa5JZSH6Dbs66MtcpybA8uXdzNM
         QjEJm8rTbsTzi/AmIZPY3wjNvuWNO8YR7S6yrXC4lS7aq0sGdpQlx22AXsdmNFtEc12/
         gH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666902; x=1753271702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Uy3kYc4RUx4HHgySuBAkgm8TQlGkSMGNPbV3xstLBQ=;
        b=tiMFKgKz0cEcqmXfJENDI8G6zBhSK6+eJjwCdO3P6RRjAslA+q/fk2/vQXl1OrKHdP
         WdArSCI0ovECehnmtLCNsIlFCTLVxawaEyiKcyfxXSu8jCL9QqzwQPDd68R0hZzj/GNl
         0Tj8zihPFGUZvrb5SSUFjW4GC4flZiE4F5Ab1A9oEM6nRQ6QGMgDWIs55ZO/FRxAsh2f
         VKVwvT/yRvWaJK1FDwnbH57t4snkmv4GyRw44ANj8yb5k3TM8sX5hIaQ7rCnE6avw4Oi
         hhGw/eKOQb61R0+8s9SU2mDZJ3rZy4DGWwz9nJ7y1AoSBoknJeorynR0YRRroA+tkS9R
         CCnw==
X-Gm-Message-State: AOJu0Yyl4spL9WMHnBqIoANPkrP0XDoSfDFACvf/6vRLtZzSF9XcDAL4
	l5BRsTOKnCpLOlLzlJgVzkfsvrLbjNiEYfvMinTb1yNPe7/Yb3jpjEbJmk7ob69h+xP33MTf+hR
	8DtA+DcOupZqTYCiJYUUo2LobHPGE/8ud+U51rEYATl2Bplk19eBw5aRfIuBPT1nG
X-Gm-Gg: ASbGncsy8Q0Sr5iAPKagEWeBBUc4RaTPPmLRwXBQF8KzQgCoa91rSZV4E/ixAucqOBv
	twIyZo5QlDI+kdBFxw1PKiNM1Zul5Pm88gPh7BSs65T1InrR/yVkHud4+QiU5Uu4hFOhVflcpFJ
	XBtW0jOBfJCL4CZu/JORUQXDU8au45CQ4MaZCE3K0YsAzh8ms//1p4MihodSKzWXaEElb68WWQs
	ydKcDTRy9LQRXty/6+X0AaUqFU+obfOSZakrlqVB0F84rm0rfwGD0BqLFLSBOM2cdZToI5NQz8U
	KBozKFYoJmSFQFNuCIbwJubniGlcF2wufv0j1N1EpMFUswD9P2m0uHNryjlPgxaoUK9eGE9SO99
	jnScBKNmEpLcdJ0nThgllUy7M898WY7U0U8TgbGxfBCwrxg==
X-Google-Smtp-Source: AGHT+IFwLwn5Rk9WDJdwgvsKxL6AyZ4UFuWomwB/xKU1sUj1/w6yPjI3y2s/LSJG8itS8Uetfr7clw==
X-Received: by 2002:a17:907:7b9f:b0:ae0:a590:bc64 with SMTP id a640c23a62f3a-ae9c99aa90cmr311908766b.18.1752666901758;
        Wed, 16 Jul 2025 04:55:01 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:96ff:526e:2192:5194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264636sm1169169666b.86.2025.07.16.04.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:55:01 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/3] pull request: ovpn for net 2025-07-16
Date: Wed, 16 Jul 2025 13:54:40 +0200
Message-ID: <20250716115443.16763-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi netdev-team,
[2025-07-16: patch 2 reworked to use attribute subsets in yaml spec]

In this batch you can find the following bug fixes:

Patch 1: make sure to propagate any socket FW mark set by userspace
(via SO_MARK) to skbs being sent over that socket.

Patch 2: reject unexpected netlink attributes in user requests.
This was partly open-coded and partly implemented via ovpn.yaml spec.

Patch 3: reset the skb's GSO state when moving a packet from transport
to tunnel layer.

Please pull or let me know of any issue!

Thanks a lot.
Antonio,

The following changes since commit dae7f9cbd1909de2b0bccc30afef95c23f93e477:

  Merge branch 'mptcp-fix-fallback-related-races' (2025-07-15 17:31:30 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next tags/ovpn-net-20250716

for you to fetch changes up to 2022d704014d7a5b19dfe0a1ae5c67be0498e37c:

  ovpn: reset GSO metadata after decapsulation (2025-07-16 11:53:19 +0200)

----------------------------------------------------------------
This bugfix batch includes the following changes:
* properly propagate sk mark to skb->mark field
* reject unexpected incoming netlink attributes
* reset GSO state when moving skb from transport to tunnel layer

----------------------------------------------------------------
Antonio Quartulli (1):
      ovpn: reject unexpected netlink attributes

Ralf Lici (2):
      ovpn: propagate socket mark to skb in UDP
      ovpn: reset GSO metadata after decapsulation

 Documentation/netlink/specs/ovpn.yaml | 153 ++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/io.c                 |   7 ++
 drivers/net/ovpn/netlink-gen.c        |  61 ++++++++++++--
 drivers/net/ovpn/netlink-gen.h        |   6 ++
 drivers/net/ovpn/netlink.c            |  51 ++++++++++--
 drivers/net/ovpn/udp.c                |   1 +
 6 files changed, 259 insertions(+), 20 deletions(-)

