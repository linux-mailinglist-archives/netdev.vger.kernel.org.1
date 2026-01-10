Return-Path: <netdev+bounces-248674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C61D0CEFC
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 05:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEC7230155AD
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 04:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7472F12D1;
	Sat, 10 Jan 2026 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1RDHwCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D32EFD9B
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768018547; cv=none; b=s999O3lReljAIZYKcUaokymJPtGSCNSjYhllTnp22R3KPv7l93vHAu4TyPsZwLOgfJSOuyY0T4WCjUg/yF4F2Z8604pGBqdPEcETCFTvVqjxM7ViIAFx5qkY7HuKPKcgSLlQ8xsxQ9TlRLoQqoI4YXJerjPIZH30rWmRgx9WD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768018547; c=relaxed/simple;
	bh=zRMaG2UZoaDAk8JWg4Py4arxiWvpQFKHkL9OU1MsMMQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dQi61trSszWrh31LrWsJU15UKarXdHZ0xkMPbWjIz3PsLxakLiXzQ5xDr+jss/5NaXHCfuUGdAPDThNgZ07e4YTjb0yYxH2HTiyoxiyvMboJnvydaBS6nBuiOf4wmFZr/hJG1RgeEaApYpSFX86Io1eg417daKFUgiDULkhCCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1RDHwCS; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ec838c33e6so2025732137.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 20:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768018542; x=1768623342; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzuCZ10ab2Iorj0lcSOmaTCThwhF5YTUtr2Jp++0Xa0=;
        b=f1RDHwCSGNaXGLhAQTXXmeqFdtwMaqUjJ0UI4PAl+oqmb3PyKZq0DdI2+jnAL2nTww
         nXGMmd5K20P0t8KosH/+Eq/KCuwYLA4Xi9saUaMY9Bmexv5pOFJnshUKVC2ZaxeuNH+d
         iG++tcTvmLclr9xOFlVWuIdsr9PGmB7K9MsmE9RHHUcLdSQNgLIIMkVJL9WvI8T7ZO05
         /RUZGRAcVJCp5rZcEMk/h1ugSI3GEGxGQ0a7k6jYy5K3uiVdqNgE0XdazRnSGBDTcPnM
         4I48oz/DEOvYL5nFCBsj5euZ15X1cKWFMGmIEm/S1KuZRotvV+awXXGB5eqY/U/YtjNp
         dSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768018542; x=1768623342;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzuCZ10ab2Iorj0lcSOmaTCThwhF5YTUtr2Jp++0Xa0=;
        b=iJ8EtGlVB4Bjlat2sF5HeKQoa5B389keJuydV+jR65u2xH2ZgJTUzytSauJ03c3dYo
         RGkAUyfFtO28FAPzn57NjTmbUedXfYn1uHLGncgE96Mogsix68Mc2kRPiCNfMozRNJUv
         6V8lNv6sWVF+JLSgt/tamPusUl8q4iB+zRZLHaVlleipp+eaKNhOMhlNnvdgfA76oMBt
         fz2LN6WGKfdBs4y7dGUWVsw1ORk/ENQ4HGpPt6WR3RO6KE9rmq3JmaAeYvMPUvZ2ecOz
         Lg7n7wTN2354BcFaBPAWMfgkx9mVoo/LbtTidIGRgJcYjW7owhaATkG1XsYYf0Si98ED
         6wOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA75xgvfftrOScIcL9lQVjff/A7zQoIiiDCXrZdyvIEwVrkiIbvlPKLvu/+slqWkqS8lhHvds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcDQ2CUGEBTAtTCEmZfxODQEcYOlwiI3Rnl9K933UeeGYe7YF
	e9rVofR6UnYviyvmcgEWk02niQWGY8hCOpxYCLAMo4vFGEqYX+7slxT9j8i2UA==
X-Gm-Gg: AY/fxX6zRHfoB3mAjZPRIWK8HkKiSvbMaSP8vMkxZRUfr7qxetixkdnnTfz5t7uO6bu
	WqXLKI/8cULQ90QcKlfRXo3AkibMQe0s2ytZqa4Gi/wWqMPUP2W+p2oqzegy5JyRiUTGlOZumdc
	ZMX9G63EgTveAbLWz/SqUui/wJAwukt+/wHuSLsg6f7SSBproSISMxGOo8A+ennxlM5NXlUN9NH
	02kAwqMp/TPiyntJ5rAiRZ42SDh5++UO1PMfXWkhyv+OLxBDKU80tK6GMRXPU5SeEtyKj5otnQd
	tz22WbwTJP9hx7arzL1AOr6LyoRbfrtGHWBx6V+SCaHJ/8aJwQY/n6krnsT1R0vRU/KBwdj25pF
	GiAflSrJBcAAUqOL7HVpRICetQu4auWycSvA7do+VVz9yGgb9PHFc/8q1EkEDNpwOo1rf/MMSSU
	S6q56ZxxWDSA==
X-Google-Smtp-Source: AGHT+IEz37L2wQQJA4qX8j5KYwrwN9NH1ecV7Azu8uWOr9xF8kdhENvXLiTeJfu5CUWtgau8Fq/JnA==
X-Received: by 2002:a53:d005:0:b0:645:5297:3e5d with SMTP id 956f58d0204a3-6470d31648fmr10030592d50.46.1768011539825;
        Fri, 09 Jan 2026 18:18:59 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790ae603282sm43469157b3.13.2026.01.09.18.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:18:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v9 0/5] net: devmem: improve cpu cost of RX token
 management
Date: Fri, 09 Jan 2026 18:18:14 -0800
Message-Id: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOi2YWkC/5XSS2rEMAyA4asEr0dFfttZ9R6lCz+UJrRJhtgNM
 wxz90Kgbcgua8H3C6EHK7QMVFjbPNhC61CGeWJt4y8NS32YPgiGzNqGCRQanfBQ0hJq6iHOMd6
 p9F80hgkyrSONUNMV6vxJE3xfS10ojCC8iMStyholuzTsulA33LbiG5uowkS3yt4vDeuHUuflv
 q2y8m2+VT2K09WVA0L2ynDjo9YaX0eq4SXN45ZaxY7n/DwvACE5zFbqmJWWB17ueGHO8xIQ0Km
 oTMzBue7A6z+eo5DneQ0IyqbodKeF9nTgzT/PUZ3nDSBQ8C51KiuMx+PYHc/PP9RqAYGHmJwyV
 mqVDrz75Q1ytOd5BwheJG+ckVx5s+Ofz+cPGcVR5jEDAAA=
X-Change-ID: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series improves the CPU cost of RX token management by adding an
attribute to NETDEV_CMD_BIND_RX that configures sockets using the
binding to avoid the xarray allocator and instead use a per-binding niov
array and a uref field in niov.

Improvement is ~13% cpu util per RX user thread.

Using kperf, the following results were observed:

Before:
	Average RX worker idle %: 13.13, flows 4, test runs 11
After:
	Average RX worker idle %: 26.32, flows 4, test runs 11

Two other approaches were tested, but with no improvement. Namely, 1)
using a hashmap for tokens and 2) keeping an xarray of atomic counters
but using RCU so that the hotpath could be mostly lockless. Neither of
these approaches proved better than the simple array in terms of CPU.

The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
optimization. It is an optional attribute and defaults to 0 (i.e.,
optimization on).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Changes in v9:
- fixed build with NET_DEVMEM=n
- fixed bug in rx bindings count logic
- Link to v8: https://lore.kernel.org/r/20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com

Changes in v8:
- change static branch logic (only set when enabled, otherwise just
  always revert back to disabled)
- fix missing tests
- Link to v7: https://lore.kernel.org/r/20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com

Changes in v7:
- use netlink instead of sockopt (Stan)
- restrict system to only one mode, dmabuf bindings can not co-exist
  with different modes (Stan)
- use static branching to enforce single system-wide mode (Stan)
- Link to v6: https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com

Changes in v6:
- renamed 'net: devmem: use niov array for token management' to refer to
  optionality of new config
- added documentation and tests
- make autorelease flag per-socket sockopt instead of binding
  field / sysctl
- many per-patch changes (see Changes sections per-patch)
- Link to v5: https://lore.kernel.org/r/20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com

Changes in v5:
- add sysctl to opt-out of performance benefit, back to old token release
- Link to v4: https://lore.kernel.org/all/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com

Changes in v4:
- rebase to net-next
- Link to v3: https://lore.kernel.org/r/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com

Changes in v3:
- make urefs per-binding instead of per-socket, reducing memory
  footprint
- fallback to cleaning up references in dmabuf unbind if socket
  leaked tokens
- drop ethtool patch
- Link to v2: https://lore.kernel.org/r/20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com

Changes in v2:
- net: ethtool: prevent user from breaking devmem single-binding rule
  (Mina)
- pre-assign niovs in binding->vec for RX case (Mina)
- remove WARNs on invalid user input (Mina)
- remove extraneous binding ref get (Mina)
- remove WARN for changed binding (Mina)
- always use GFP_ZERO for binding->vec (Mina)
- fix length of alloc for urefs
- use atomic_set(, 0) to initialize sk_user_frags.urefs
- Link to v1: https://lore.kernel.org/r/20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com

---
Bobby Eshleman (5):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: refactor sock_devmem_dontneed for autorelease split
      net: devmem: implement autorelease token management
      net: devmem: document NETDEV_A_DMABUF_AUTORELEASE netlink attribute
      selftests: drv-net: devmem: add autorelease test

 Documentation/netlink/specs/netdev.yaml           |  12 +++
 Documentation/networking/devmem.rst               |  70 +++++++++++++
 include/net/netmem.h                              |   1 +
 include/net/sock.h                                |   7 +-
 include/uapi/linux/netdev.h                       |   1 +
 net/core/devmem.c                                 | 116 ++++++++++++++++++----
 net/core/devmem.h                                 |  29 +++++-
 net/core/netdev-genl-gen.c                        |   5 +-
 net/core/netdev-genl.c                            |  10 +-
 net/core/sock.c                                   | 103 ++++++++++++++-----
 net/ipv4/tcp.c                                    |  76 +++++++++++---
 net/ipv4/tcp_ipv4.c                               |  11 +-
 net/ipv4/tcp_minisocks.c                          |   3 +-
 tools/include/uapi/linux/netdev.h                 |   1 +
 tools/testing/selftests/drivers/net/hw/devmem.py  |  21 +++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c |  19 ++--
 16 files changed, 407 insertions(+), 78 deletions(-)
---
base-commit: 6ad078fa0ababa8de2a2b39f476d2abd179a3cf6
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


