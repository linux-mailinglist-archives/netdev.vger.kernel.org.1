Return-Path: <netdev+bounces-230802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9317BBEFB15
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FAE4343B3E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB412DE6FB;
	Mon, 20 Oct 2025 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="eaP1BzGb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5575B2DCC04
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945878; cv=none; b=A2dzNk1DwwYXUaEJaEGNYW02lctHVwgiws5vnm/GnF+G1bDjAn9mClTThebnJv2MgH9LvmV95UNmhDbqJwiaKG7O20Q9qW6N31Kfuyj8VUq8RctLr0vWO1CeWpc12iJwHxNS6y6oyDH8kgTawwnUvI9uzwsB/3GvgGiqd5E+ztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945878; c=relaxed/simple;
	bh=ox3TOaWQAvFKpnz40ggQEtOD27cJj2PEL0cWDHgrDMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbbE8o9HD5JP5V0lKr7gqO8Ys4+ltDncfGldSwlXO0AfRt6dsC94hMSO6NtWNLFQjdh42g7ZshUw7zYojFZ8hKmgdRShahLH0Bsqe/o4QQc7xNi3+6TKk4LdtfJ8HWl0r2VbbsJxDBC1NzWMgNXbxg5R5SFdtrRHM3qTOiXEnMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=eaP1BzGb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-471b80b994bso18309905e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760945874; x=1761550674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpfiyd6YNc3TjprvPUZOGbaOIC50tqtpCuWqlZLkhYU=;
        b=eaP1BzGb3pM4YC9w/kMLgduwBeUdQNKWKlr4f84XsMu0yjqKq1yh7Pemfg/6gCiCpS
         F08P8Co2VNfw5uD2fVEHPjaNkPMCNQ14enZ4NYU6ZaPy5St8z20XeKDiB3cgniDAOles
         ZN1UHms9eKj+yEEiztgP4CVbg2CAJNRX4AJCvdCh1iq+Qv7pNlxAi+ANQcL2KceSbma8
         M697ETL+vl223FX2S+w9sa+UWE/uVE+fjKKol9uipJFRaUtv6XSJCTfRR4m4ybxRkLRM
         E+pxssFC/xQGCC+hOSchsz7PisSKzwGIsie/m1HrYBJFPGJN1qWE39TQNYpUoPodsL07
         WL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945874; x=1761550674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpfiyd6YNc3TjprvPUZOGbaOIC50tqtpCuWqlZLkhYU=;
        b=alcZZUAcNJGXr/ci3WVlFxfUToMMDwFGtaIW3AU2DHOVZIGOpL0sriEkqcX1KL45B/
         K7MjPlthN+sRg8J0T6BxZam14mbppWmSzmpPsASPucgAbCGp9QrNrlCScT7+bpD2QSKf
         r5MjD+ZyvVKfmi+ywirx6k/jbi5guidii7kuxpPtXDH+6Sh/8BVdDhmHpiLKMZeB5DTg
         3vlVvHtECnUdXwZkt5Ml7kNGStRtBxsNJBCbGFCIlX604MlnfQjncNk8ILM8MzTj/4Yg
         g6rs1SN7Uf4X+vHlxSAj9RdcLBqZ2e3RyjSuYQpDksC3iIntJdxjZO/swrqdBp7BqOlt
         Nr7w==
X-Gm-Message-State: AOJu0YwUIs+ATpshQLhNn+myd4Q4F0xhto+ptJWN39MJl8zTwmyPrl6V
	aDdCALsXFmn8EsGhe36G4d1aV2IxzYanwfUn61u8EOBgscAXsZ0xWTIJ3mc598JRDTFoPiF/HwL
	2yi7NGIxfAA==
X-Gm-Gg: ASbGnct9AOvD4s1RhC5j/qxWcr3RrkiItjm1DhtuhEGVAoinZuS2UA0mJRvp3kBO64K
	h8Ix5nhQym8fgFG4kurQlT9h+qm7HC3Usa2y32H9B3qSWBPuSbmEsza7UjZx6N4JSoH5b8Xj9yn
	aTu3FskhTXHlcK7tHo9TOrAgy09Zp+w9LhOPAKBqd4TqTkzRQCBjYW+e4rBwyWXdUoIyVarwgSS
	iD/bz7V2e3oC46z2v5atJoSW3oRqzYkEqibkXr94OtaKWIvLaXWIH/3x1RYxmmIAiVXb6eatXn4
	PXmSnfCGPG9k5MxNnflkWV4zOdpOnDCmQMKtzy0fylKsVTHJO+zdTH8jvLT6FP81ztu0SUPCzOl
	CjTpdDwWjEjsgZZOzgwv6Wp20/o+yJQPSdXquTpHScsFLIy5BNJ1ZiY4fE0oGEAIIYF/Il+3/bo
	onZL2VhQ==
X-Google-Smtp-Source: AGHT+IErjDlY8SYwZAsk0dUz6Pc/uhzEOzfc8ko0KqqA3Ip2Mg1549orC3g5DKuQs0JvxGgY3sqB1w==
X-Received: by 2002:a05:600c:444d:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-471178b13c6mr79113065e9.17.1760945873868;
        Mon, 20 Oct 2025 00:37:53 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm132862315e9.9.2025.10.20.00.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:37:53 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v2 0/3] fix poll behaviour for TCP-based tunnel protocols
Date: Mon, 20 Oct 2025 09:37:28 +0200
Message-ID: <20251020073731.76589-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series introduces a polling function for datagram-style
sockets that operates on custom skb queues, and updates ovpn (the
OpenVPN data-channel offload module) and espintcp (the TCP Encapsulation
of IKE and IPsec Packets implementation) to use it accordingly.

Protocols like the aforementioned one decapsulate packets received over
TCP and deliver userspace-bound data through a separate skb queue, not
the standard sk_receive_queue. Previously, both relied on
datagram_poll(), which would signal readiness based on non-userspace
packets, leading to misleading poll results and unnecessary recv
attempts in userspace.

Patch 1 introduces datagram_poll_queue(), a variant of datagram_poll()
that accepts an explicit receive queue. Patch 2 and 3 update
ovpn_tcp_poll() and espintcp_poll() respectively to use this helper,
ensuring readiness is only signaled when userspace data is available.

Each patch is self-contained and the ovpn one includes rationale and
lifecycle enforcement where appropriate.

Thanks for your time and feedback.

Best Regards,

Ralf Lici
Mandelbit Srl

Changes since v1:
- Documented return value in datagram_poll_queue() kernel-doc
- Added missing CCs

---

Ralf Lici (3):
  net: datagram: introduce datagram_poll_queue for custom receive queues
  espintcp: use datagram_poll_queue for socket readiness
  ovpn: use datagram_poll_queue for socket readiness in TCP

 drivers/net/ovpn/tcp.c | 26 ++++++++++++++++++++----
 include/linux/skbuff.h |  3 +++
 net/core/datagram.c    | 46 ++++++++++++++++++++++++++++++------------
 net/xfrm/espintcp.c    |  6 +-----
 4 files changed, 59 insertions(+), 22 deletions(-)

-- 
2.51.0


