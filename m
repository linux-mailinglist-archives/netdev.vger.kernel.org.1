Return-Path: <netdev+bounces-50672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E487F69C5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231A6281740
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2936C394;
	Fri, 24 Nov 2023 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kRvkrt2M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7710D3
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:30 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50797cf5b69so1895537e87.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785648; x=1701390448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8QM/m7UTtv+MC2zusUkJTGgTrqbe8gRAx9REDFyuSU=;
        b=kRvkrt2ME06+64sbnWjGIGz9OeN3KFbdlPZCk6Htz8uuIVvLqj5G7mXzp4wlNm3bRk
         QnuhH1Yvx4CzN4NKknKX42dYX99voJKjXarmoW/8SV2PT91kr7JluuO/Ta1BJ1Wul+8S
         i1cfndvTTlGCopgzie4xQWu6yVpiTDtJPaFjIy5EiQ0kZX2DMCxAmW2P1Qq4FRCfTeiu
         mMJVerT1bcYdOalTqZbgESxMYt9pKi94hpnX/4dHnXd7KyhknNqrly9GwSo7MjLIX6Vn
         BTTnzoOxtjk//3hPh8PSbYWkelsNeJxf3t03za17Z47C3nock2n2LtqRGBQWWAjYqnpn
         vxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785648; x=1701390448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8QM/m7UTtv+MC2zusUkJTGgTrqbe8gRAx9REDFyuSU=;
        b=kothmwphc72QbUM5xSXEYrpiesqlvmpAv2Y7QqZI/sua3gpyQzVNN0R4m/RS5SNGnj
         cBjwo6dTVykUxe4ndp/hGWKPw1OCx6GqyO642WrhQ8c8PZpBjWwxyCl+zmq1h+tJSsKQ
         0h9FgEcwsSl6zuAkzHaO+XT7XXRdeKU034/iUJ8iChyZHaP/iqq5t7F5az14M5GXPktF
         UYMhN2tr0yZK8T3RFQKVOTI2I94L5EfCLU97tB78wxATFKqDl/OWphrsXyg7Bw6DJ2ul
         I+cd4TcsZGZydeLAu8+/2hq7ibG2J7VQbAQJQd7alug5V6rx/SYZP8Z7+/e7J0rugPL6
         tDiw==
X-Gm-Message-State: AOJu0YxCytBf9gDpuBclBD9JdDRDgcrRXoFpyxoddw/Vb2YJuHTDw1Fo
	uwMoCo0n+1rILaMSjS/TaA5FQA==
X-Google-Smtp-Source: AGHT+IFh+qtjDvYkcbRMFlh/WyRvztcosddBJ2m0H91J1i9G+Zxs4K+RjS13PJvfkM83cKVos7a9uA==
X-Received: by 2002:a2e:3615:0:b0:2c5:2fa8:716a with SMTP id d21-20020a2e3615000000b002c52fa8716amr689164lja.9.1700785648284;
        Thu, 23 Nov 2023 16:27:28 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:27 -0800 (PST)
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
Subject: [PATCH v2 0/7] TCP-AO fixes
Date: Fri, 24 Nov 2023 00:27:13 +0000
Message-ID: <20231124002720.102537-1-dima@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

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

The following changes since commit d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7:

  Merge tag 'net-6.7-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-23 10:40:13 -0800)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-post-merge-v2

for you to fetch changes up to c5e4cecfcdc7f996acae740812d9ab2ebcd90517:

  net/tcp: Don't store TCP-AO maclen on reqsk (2023-11-23 20:54:54 +0000)

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
  net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN sockets
  net/tcp: Don't add key with non-matching VRF on connected sockets
  net/tcp: Add sne_lock to access SNEs
  net/tcp: Don't store TCP-AO maclen on reqsk

 Documentation/networking/tcp_ao.rst |  2 +-
 include/linux/tcp.h                 |  8 +---
 include/net/tcp_ao.h                |  8 +++-
 net/ipv4/tcp.c                      |  6 +++
 net/ipv4/tcp_ao.c                   | 57 +++++++++++++++++++----------
 net/ipv4/tcp_input.c                | 21 +++++++++--
 net/ipv4/tcp_ipv4.c                 |  4 +-
 net/ipv4/tcp_minisocks.c            |  2 +-
 net/ipv4/tcp_output.c               | 15 +++-----
 net/ipv6/tcp_ipv6.c                 |  2 +-
 10 files changed, 81 insertions(+), 44 deletions(-)


base-commit: d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
-- 
2.43.0


