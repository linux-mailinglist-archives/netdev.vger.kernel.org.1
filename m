Return-Path: <netdev+bounces-52196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE27FDDB6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333241C2091E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED503AC0B;
	Wed, 29 Nov 2023 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GwyzD+BN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545FB6
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:30 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b4c2ef5cdso17684275e9.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277048; x=1701881848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7aJz0uHa7SewL8HnYCUsCQUx9Soa+Sr5uJxTLKLlKs=;
        b=GwyzD+BN8sne4vzp82UGQSMSYfGW79rAlTVrXM1FRIcKwj18LURJp+qOC/GcvF+R2d
         waPLjDxJ3lXIE2CjyOA5zepcRDgz4lmvQ5G/Ygr0Oa+VwagyQq3jeRTrV9r/PVxFuK1s
         EPggNZX2OjGFhBIBpIpep6H2+AoC5OSOPxJf8ot1v/2N3bgEYfZOkgcrjKIdJgIJfqVN
         zc26BDVDxVuxshJLspr64J6+OPPyWJGqoVrkNk1LCWxEmWODMPRu33l6AWWOBRmBbhn1
         4D1qM22Rm0BODu230l5Z/P+XGS2oY/woctgspJ1rk83JD7GahUzU8F1Db5Z/jC/+AAK0
         Dl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277048; x=1701881848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7aJz0uHa7SewL8HnYCUsCQUx9Soa+Sr5uJxTLKLlKs=;
        b=J7KWLqJrVfxxiUaafSGNLO3IE3l+2e4QP/9qkQ6M1ZP+2nTIeMt9lSj9Bl2q4j5eXC
         QVaEEYiXY6nnq5RLpadQs20vh8KCLBX1UTnLYqh6fIFAU82tp7k40M6iclm7TCGmehOf
         kYobXvX5hLRu3DqmBZQ9d0WNkS4HEIjKAEASf1gNSJHTkyqqjwiSM1GdHi0Wv6UOhKmN
         VwKIWV0JIatAJ/mUc9ADvtzIcfrKjg3CGs6Vu6uJXbGZkGTCfMFjnAG/H9tt00qKpB/Y
         7XYL9A4gaNc1Ru2egqe+49yD05Ou/oRpNUrfxXzL3HtOd2aoZDAyVn8/fobPpRtzdYLH
         1Ncg==
X-Gm-Message-State: AOJu0Yz4ZNb9G8weQBACcxVrBRg3ZNTO27uYWTQEeZE0OegXQ264J9Iy
	YMbThANIvloPlp2eAC4zFkff3w==
X-Google-Smtp-Source: AGHT+IGvkYBjosEudVQ+49uvXPcnSWT1An1RijbQznPrsjN4wM5WkIEgwsLadS+Kpuj7lhAfU/UhSg==
X-Received: by 2002:a05:600c:524f:b0:40b:4ba1:c4f2 with SMTP id fc15-20020a05600c524f00b0040b4ba1c4f2mr4713557wmb.30.1701277048480;
        Wed, 29 Nov 2023 08:57:28 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:27 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 0/7] TCP-AO fixes
Date: Wed, 29 Nov 2023 16:57:14 +0000
Message-ID: <20231129165721.337302-1-dima@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes from v3:
- Don't restrict adding any keys on TCP-AO connection in VRF, but only
  the ones that don't match l3index (David)

Changes from v2:
- rwlocks are problematic in net code (Paolo)
  Changed the SNE code to avoid spin/rw locks on RX/TX fastpath by
  double-accounting SEQ numbers for TCP-AO enabled connections.

Changes from v1:
- Use tcp_can_repair_sock() helper to limit TCP_AO_REPAIR (Eric)
- Instead of hook to listen() syscall, allow removing current/rnext keys
  on TCP_LISTEN (addressing Eric's objection)
- Add sne_lock to protect snd_sne/rcv_sne
- Don't move used_tcp_ao in struct tcp_request_sock (Eric)

I've been working on TCP-AO key-rotation selftests and as a result
exercised some corner-cases that are not usually met in production.

Here are a bunch of semi-related fixes:
- Documentation typo (reported by Markus Elfring)
- Proper alignment for TCP-AO option in TCP header that has MAC length
  of non 4 bytes (now a selftest with randomized maclen/algorithm/etc
  passes)
- 3 uAPI restricting patches that disallow more things to userspace in
  order to prevent it shooting itself in any parts of the body
- SNEs READ_ONCE()/WRITE_ONCE() that went missing by my human factor
- Avoid storing MAC length from SYN header as SYN-ACK will use
  rnext_key.maclen (drops an extra check that fails on new selftests)

Please, consider applying/pulling.

The following changes since commit 3b47bc037bd44f142ac09848e8d3ecccc726be99:

  Merge tag 'pinctrl-v6.7-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2023-11-29 06:45:22 -0800)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-post-merge-v4

for you to fetch changes up to adb1a6e8d2034c1e17b6a84a512c71aa4c41c1d2:

  net/tcp: Don't store TCP-AO maclen on reqsk (2023-11-29 16:14:14 +0000)

----------------------------------------------------------------

Thanks,
             Dmitry

Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Francesco Ruggeri <fruggeri05@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Dmitry Safonov (7):
  Documentation/tcp: Fix an obvious typo
  net/tcp: Consistently align TCP-AO option in the header
  net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
  net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN
    sockets
  net/tcp: Don't add key with non-matching VRF on connected sockets
  net/tcp: Store SNEs + SEQs on ao_info
  net/tcp: Don't store TCP-AO maclen on reqsk

 Documentation/networking/tcp_ao.rst |  2 +-
 include/linux/tcp.h                 |  8 +--
 include/net/tcp_ao.h                | 31 +++++++++--
 net/ipv4/tcp.c                      | 13 ++++-
 net/ipv4/tcp_ao.c                   | 80 ++++++++++++++++++-----------
 net/ipv4/tcp_fastopen.c             |  2 +
 net/ipv4/tcp_input.c                | 26 ++++++----
 net/ipv4/tcp_ipv4.c                 |  4 +-
 net/ipv4/tcp_minisocks.c            |  2 +-
 net/ipv4/tcp_output.c               | 16 +++---
 net/ipv6/tcp_ipv6.c                 |  2 +-
 11 files changed, 122 insertions(+), 64 deletions(-)


base-commit: 3b47bc037bd44f142ac09848e8d3ecccc726be99
-- 
2.43.0


