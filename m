Return-Path: <netdev+bounces-51836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7EB7FC673
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8405B2449D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402204436F;
	Tue, 28 Nov 2023 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="j8D31Q9p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336971735
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:57:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b27726369so42649085e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205076; x=1701809876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg2wTeQcpZed4qmQGZeMtHI8/aYwGBDHLZSGLE1zswI=;
        b=j8D31Q9pEnWnPtD3zpGLqT8MONMLBfkRFxcOLbDiq/Fc8zqIGvbLS/wDCKX2pKqhaI
         VXFIbFaH+uITOT44/86164XBtEB1rzDp091VUeT9/RvAAma4kNAPlGdzhzZxYem7DLim
         V9QGj9ckv00rUN1Nre2W9jbFw8GZndF1AUt/qRJ7FiZP0XHwAomyUqXnbhNIliKXUc0E
         a9Knwik46XchRSoHc5C83O4s7HBnVbHg6x5f3n/cYsRz5E6V/WUAF5psNk7hW0WdNrtA
         pSy6s59/EN99RQVSKB6ojfiCW9PbusPN99GdkHnvNcggSHcOUFH5SS06S8/bCa4s6sdF
         SNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205076; x=1701809876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg2wTeQcpZed4qmQGZeMtHI8/aYwGBDHLZSGLE1zswI=;
        b=oID/FZUumm38hH5XTGo/v8d+p22J8CHAGaU3w2ja7kaG064zPynT2PYVPrFpq/Vnpd
         oKTdrHhumSa19HNi/aLUWJCHn1HpAjkTI4ExkJoEgnqCvJ/NkNHGkB05t7PyOYk/F5Of
         xBo9PeXavQPeDorDrfYZNjDYdvVldpgGDaETpYeJ1v1TzpQ/0ZRXkr8PQtcI1t/JvUe7
         Rqmki+3zko1A2JTjLuQ3zvvFkQXSunxn1si0fl0ZuAp/3g6J5ITkUG8SBRoz+jLFMPxO
         pGtDhHDFVK045kN0cEnYAquIh2xIyUNDOJMNUGFguguORJGZJ6YA39R23j9SPxZ7PNFG
         iqxQ==
X-Gm-Message-State: AOJu0YykoV2mZSoU1uMzQJUi4N4L9m6YyQmbUZP3WLeQ2/P1OfkkPNRK
	p5Jgvkye0TZaqPD2KOD0xpCSdw==
X-Google-Smtp-Source: AGHT+IHhlmDunPhVUt0EJd91505nMJdUTWbIOFTIF0zQ8f6XyZLElANclWwrHhH1iVcCQYsYmF/saw==
X-Received: by 2002:a05:600c:1552:b0:40b:5075:c147 with SMTP id f18-20020a05600c155200b0040b5075c147mr934652wmg.8.1701205076677;
        Tue, 28 Nov 2023 12:57:56 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:57:56 -0800 (PST)
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
Subject: [PATCH v3 0/7] TCP-AO fixes
Date: Tue, 28 Nov 2023 20:57:42 +0000
Message-ID: <20231128205749.312759-1-dima@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

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

The following changes since commit df60cee26a2e3d937a319229e335cb3f9c1f16d2:

  Merge tag '6.7-rc3-smb3-server-fixes' of git://git.samba.org/ksmbd (2023-11-27 17:17:23 -0800)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-post-merge-v3

for you to fetch changes up to 822e6f2d14a1e1de98835fcc3940c04d28582656:

  net/tcp: Don't store TCP-AO maclen on reqsk (2023-11-28 17:57:32 +0000)

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
 include/linux/tcp.h                 |  8 +---
 include/net/tcp_ao.h                | 31 ++++++++++--
 net/ipv4/tcp.c                      | 13 ++++-
 net/ipv4/tcp_ao.c                   | 74 ++++++++++++++++++-----------
 net/ipv4/tcp_fastopen.c             |  2 +
 net/ipv4/tcp_input.c                | 26 ++++++----
 net/ipv4/tcp_ipv4.c                 |  4 +-
 net/ipv4/tcp_minisocks.c            |  2 +-
 net/ipv4/tcp_output.c               | 16 +++----
 net/ipv6/tcp_ipv6.c                 |  2 +-
 11 files changed, 116 insertions(+), 64 deletions(-)


base-commit: df60cee26a2e3d937a319229e335cb3f9c1f16d2
-- 
2.43.0


