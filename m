Return-Path: <netdev+bounces-299131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fGZrA4AnLmq7qAQAu9opvQ
	(envelope-from <netdev+bounces-299131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:01:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 519026804F7
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:01:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=l6hGXIpg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299131-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299131-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE4D30238DE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 04:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02923ABA8;
	Sun, 14 Jun 2026 04:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77E2772E
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 04:00:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781409660; cv=none; b=BGulZNux1AnuR+esAjSgLi/3d3/SyIfwCmkTKhNIQ2Y5yUWibWjtpWAsqhNMlNVkXBSRQLjtAkvfLywhaqGwHnI82waRdbFy5gRf6u5ME0/Jj6NhCu+fpPe+12c0jb/A9TbIFnXqnPx3LOGhqdfHAdPIT6xe64QU+1cQlZUeuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781409660; c=relaxed/simple;
	bh=APT6um1Gw37K7BhotudONjWhazcoIfn8CWJ3A7ulKkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VfpEZxgblQUKHypfuBJxlQlRtptNvyCwwPJMVs/81iPGzB9pEAHXSqlXxMPaJtodHfsErH7v8ZIGU7sNgpacuRrqb05zAtmJr3pKjIqcepeR0TN3zIIaIxW5v9DOYngYoXtDj5sYNRpyt88tWXl4wlW9wm4ZsFMobxq10tc0SSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6hGXIpg; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b900f350fso1967351a91.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781409658; x=1782014458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q49mRONNBYR0JeB0FoFSRUEZksnbOzysOYCNAb9xxlY=;
        b=l6hGXIpgzKTgu0GF5KE5NyKQ5JIjnIu1HUFB63vTIbWIylCRvDwVFtcXv5qjskkNGI
         VlxbSJ0Ph6k5wT6K1ZhpRg91M3ppt3+N9x1K97VXsMzd5kXT3tUrs3zLT5bWpplR8Z1T
         Z0JVebbzWKLNOFqc0COJaCe9GT4XPPZRgg95BPkJgZjL2fiNsOiKD6lBLufGPFYcDY1s
         7hIeQAYkCWRzRQzXjNTNAABuD9UfSjv3Hnnre8RoGdkzqsOizqiiP7n1cxpcXuoRK4rk
         QGLJd7AHnlSejDbPfzSCRAwGdfBjIoglW++i+AzD3snrhLjXJtsVx2yiZimGfmBD6FxC
         FfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781409658; x=1782014458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q49mRONNBYR0JeB0FoFSRUEZksnbOzysOYCNAb9xxlY=;
        b=fZHi8/dPBuQT6zdOg7IwUFnZ6ID82fj8lnEVzlVsuA1t2E+FGRmhBjnywmrEJdkse7
         kN5jud8NjoFggRCW25E9mrPS1T0xVpMBopKdBkBdllviL/BpvmIciP/vSFaAihjIsl5F
         rXoBvV46cWS61j5cumOFVE0NKiNAMqXeMBVCfBSxKwnZ6QoqLHUFLLeAqdLZI9He2fzg
         I4/7yGjBpw5Xcju0OXAFCSUpNsoz+n8cNTrPzoqY31uay63akyKKjnRLTjUN+t0FZfE0
         jweU/UtLNbQC2NIayfTmJiCyO0HFWNs2yYLNl9OHQT0mD7I85SbjcB/IskMXKTXw8PWP
         bPcQ==
X-Gm-Message-State: AOJu0Yz+lvWx26gOel+s8ombv3s7A3mvP4yU53AfWi35XE2UUZ7yW20w
	n8rSA7vUt5x1/kb0wPPSPhbqEL0JKICUt/Io5PYn382ovLzzjYvFQI10GDUhHtbZ
X-Gm-Gg: Acq92OGtRi+YkSo0D1o70gzbFSHryNFgzEues71VooHs4SkDCwz62l7jDn0+1KBZL1Q
	FyyWq+WNa3lG94trZDcrqPAZ5St0g/F3bqZ5t3JAcSpRxOqEqCVrfE4xtX5Y/xGN65EFANutvVs
	N19EWwf889PoGbgGGQTSbHCSxJNt1oCD9P5TyJabGN6p2Yb6cCK6Ud3a879hJc5Vq2729RYkHnE
	hwXq07bcfRrDovsC2rGX9nLvxlZCd03Cm5k2tHeFzcxrVk1m0C6mJbrXfdP29dw8dpAwQ6cORsG
	Z5nFxz7I1mnqgpRdtFABVEVf7JKPGVEAZuhjE54mvuhijVqzOTcI7ZJZKl54RiC78Hr0L5rQi8Q
	Jhsu9+QMvORfUWsouXQwTBUkjdizFI7RZTWeAaWHnfp7EZIThfpHmZfoIF1gi/5AVgtoKlOE4Ur
	hY7qED+jP3yFUt6R/Ee0vfrpOyeMRSMA==
X-Received: by 2002:a17:90b:5588:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-37c2bd79bc6mr5257855a91.25.1781409658385;
        Sat, 13 Jun 2026 21:00:58 -0700 (PDT)
Received: from mincom1 ([115.4.79.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm5676983a12.0.2026.06.13.21.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 21:00:57 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [RFC PATCH net-next 0/7] net: airoha: add EN7581 SOE ESP packet offload
Date: Sun, 14 Jun 2026 13:00:25 +0900
Message-ID: <20260614040032.1567994-1-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299131-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gondor.apana.org.au,secunet.com,vger.kernel.org,gmail.com,collabora.com,lists.infradead.org,nbd.name];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:ansuelsmth@gmail.com,m:nbd@nbd.name,m:linux-kernel@vger.kernel.org,m:hurryman2212@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 519026804F7

Add Secure Offload Engine (SOE) support for the Airoha EN7581 Ethernet
driver. SOE provides inline ESP packet offload for native ESP and NAT-T
traffic, with the Ethernet/QDMA path used to submit packets to the SOE
block and the PPE path used to bind eligible ESP flows. NETIF_F_GSO_ESP
and NETIF_F_HW_ESP_TX_CSUM are intentionally left out for now and will be
revisited separately for feasibility.

This is posted as RFC because the code was originally developed and tested
against an OpenWrt 6.18 Airoha tree, not against the current upstream
net-next driver. The original OpenWrt commit used as the source for this
RFC is available at:
https://github.com/hurryman2212/OpenW1700k-test/commit/7c1b5e662f7790b3d23ed143beadc1dcbf6d15f7

The SOE part is intentionally linked into the airoha Ethernet module
instead of being exposed as an independent crypto or platform driver. The
user-visible ESP offload control is a netdev capability: xfrmdev_ops and
NETIF_F_HW_ESP live on the target netdev, and the feature can be controlled
through the usual netdev feature path. SOE also shares the FE/QDMA/PPE
datapath, private queues, DSA conduit handling and netdev lifetime owned by
airoha_eth.

Patch 1 adds xdo_dev_packet_xmit() because the existing XFRM packet
offload transmit path does not provide a hook for hardware whose ESP engine
is reached through device-specific packet forwarding. SOE needs to consume
the skb, add a hardware hop descriptor, steer it to a private QDMA path and
return the final transmit status. Drivers that do not implement the
optional callback keep the existing XFRM output behavior.

Jihong Min (7):
  xfrm: allow packet offload drivers to own transmit
  dt-bindings: net: airoha: add EN7581 SOE
  arm64: dts: airoha: add EN7581 SOE node
  net: airoha: add SOE registers and driver state
  net: airoha: add QDMA support for SOE packets
  net: airoha: add PPE support for SOE flows
  net: airoha: add SOE XFRM packet offload support

 .../bindings/net/airoha,en7581-soe.yaml       |   48 +
 MAINTAINERS                                   |    1 +
 arch/arm64/boot/dts/airoha/en7581.dtsi        |    6 +
 drivers/net/ethernet/airoha/Kconfig           |   13 +
 drivers/net/ethernet/airoha/Makefile          |    1 +
 drivers/net/ethernet/airoha/airoha_eth.c      |  668 +++++-
 drivers/net/ethernet/airoha/airoha_eth.h      |   40 +
 drivers/net/ethernet/airoha/airoha_ppe.c      |  606 +++++-
 drivers/net/ethernet/airoha/airoha_regs.h     |   16 +
 drivers/net/ethernet/airoha/airoha_soe.c      | 1896 +++++++++++++++++
 drivers/net/ethernet/airoha/airoha_soe.h      |  126 ++
 include/linux/netdevice.h                     |    8 +
 include/linux/soc/airoha/airoha_offload.h     |    5 +
 net/xfrm/xfrm_output.c                        |   11 +
 14 files changed, 3342 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-soe.yaml
 create mode 100644 drivers/net/ethernet/airoha/airoha_soe.c
 create mode 100644 drivers/net/ethernet/airoha/airoha_soe.h

-- 
2.53.0

