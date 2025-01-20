Return-Path: <netdev+bounces-159701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2114A16891
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C953A5F07
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E4192589;
	Mon, 20 Jan 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="jO+qGSC7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CD18801A
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363640; cv=none; b=PttJTp7vXB8IyRRcTa7+HmDD0+lI8ShXRFRzYdYfwSOdWDzuwLNjQTcisKnrWGNLBVW7DrZ0avYkBmU/hhGC1uWFwk3luN0WU4Q1x6ltP/I+EvHKEtBGwTFZWCBkBI095S/TDzbxH9prATRzu/1qm3m6Tz0+KrBZ+IS9aii5nyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363640; c=relaxed/simple;
	bh=qcajYeuzQqig2Pw2OjJksSWvVLoxEiTtaDCHiGYHL/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dbiW0iQBY9OPOjFyhn/k8tZvhUc3QWuK/hQr6OxlXqZeJzV0Wbek2b1egPDU8+FxB9OIs0VNCJE1wD1+6diS7a5ZuZVcT6FRPPFQmI7Hbghgu9N0yPvBcEKPx7E2O+ZcqXWwrkS18zqGaU97gfIZobUoAcXtbS5qDQuh51QtrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=jO+qGSC7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so7289990a91.3
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 01:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363637; x=1737968437; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M73wUmCTBGNSLAfxRhHe8Rnzzifp0+HNyWyW7z7nYBg=;
        b=jO+qGSC7YWWbp38q5aTRWnoE8tafva1nVW3kCSAxnGTNgoR9bXi4NW5Ld9J80XOMhl
         aLjahDPnPiGFCwwUzUgY3G75GAMqy5fy/GUo5IEHAqJQk4hAA4ljTFZoLuqSTF2D1tYf
         DXcynP+xqyli6+wG7ji3pTO84t0RCdErZphIuBncGEDH0dn3PYaj0n9xk/bMU2+Wu/BC
         KTMAH867L7+lgrc7dxSjXAyAiBIYj6of/UkmH0RYEsSVSb2v832u3p1qRWipRLUZ7xxm
         LvAEqqSujc3n0frz2sDQiXKkkwOUpn8Sf7bZt6j/2M+PUq9v1Bf9OJiGDVGMRqe+7/jX
         ybIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363637; x=1737968437;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M73wUmCTBGNSLAfxRhHe8Rnzzifp0+HNyWyW7z7nYBg=;
        b=MuTDvlxIl/+wdqkeenAT9i3A8cNKTcCdd2Vy4M144qFyByI19gY02rYpHQZw55NVgt
         Au2OPwV5ogw3mb+OjtObDQfX/wFUwlfrxfKwdhvWwgZ3I6k/MG1NAGxRGE/jrrfMRUYy
         41BKzhByKq6hX7YQCkdfZVvQAT2BkWrP9SxdZuiUn5E7RLjBMP6Qp1YfZ9rO/TNcbiJn
         +IsMF1lSKQtKIbF42OgGaf1t/A0EmZmtJSbnWi4yn83pOfZY6fR5CSRUEG6sXHM2BJVJ
         oxxTJWfl2OEDK05KU5LVTV+SSmKoA9fX5srYIMKtalBvlrpx32CyPg6r7ARwQ5kVrB9G
         0cIA==
X-Forwarded-Encrypted: i=1; AJvYcCWqm0Op7i8W+mxBNDrjNM6p2aKbA5Kted9fVtOMIqgViCGKWq63KKKp8HIpvsBO36P3RYxvelM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbOQtHSwXvmtzyBMn859OAyi6pRstgY8LriHjY3r22btXIn1Cq
	aKNt/LotiIawwySDfPnZIbNpyR7KEtKUYLOydDPss52Gb78bc6o9vXDZYBzBkrA=
X-Gm-Gg: ASbGnctQ7BJCbBzkBLY+rlozeV+laGZAk/1b9cRNjkU2xBPgOJ2W/gE4sWEubBb8tx0
	YK7JS5cLMiGIw+RNRgvBAjnhUUuDnFVtAWbtg4RfestqFViJ1sLD9gXtxdtH8RLIFRMhK/5lQ8n
	WPKjUgPOV6C6NkZonJO+1qrpfel4pdsY/0Xwb2omEZZ9j5eFFWlOpmkj62VMdiQAeoRm72Xc6z8
	00wthjbNpurcrlDEhqmqxC51B6dElhY/utIVribuQrliuXFrHxbyTyBYk2Vz/5MkILvZD2h
X-Google-Smtp-Source: AGHT+IE1pLyS0CRQUGICRpfL+cuS6Zd8b3NmmH3IRRXgasWGxiLbxjOpEsY6IBDF/xH/j3M5fZzgCw==
X-Received: by 2002:a05:6a00:802:b0:72a:a7a4:b4cd with SMTP id d2e1a72fcca58-72dafbb61bemr17694966b3a.21.1737363637519;
        Mon, 20 Jan 2025 01:00:37 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72daba44453sm6487254b3a.127.2025.01.20.01.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:00:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v4 0/9] tun: Unify vnet implementation
Date: Mon, 20 Jan 2025 18:00:09 +0900
Message-Id: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkQjmcC/2WQyw6CMBBFf4V0bU1ftMWV/2FcFDpIFxYthWAM/
 +6kbDQub+6ck9x5kwlSgImcqjdJsIQpjBGDOlSkG1y8AQ0eMxFMKC4ko3mOVGvgzKmmZZ0hePl
 I0Ie1WC4kQqYR1kyu2AxhymN6Ff3CS4+mmnFmi2nhlFFtvLGqlUoadfbuFcN67MZ7ESziG2p2S
 CAkrfXG105Y4/4g+QVxvUMSoU63eM+hMb35gbZ9RYLnjC/I+5Trtn0AjlRLryABAAA=
X-Change-ID: 20241230-tun-66e10a49b0c7
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

When I implemented virtio's hash-related features to tun/tap [1],
I found tun/tap does not fill the entire region reserved for the virtio
header, leaving some uninitialized hole in the middle of the buffer
after read()/recvmesg().

This series fills the uninitialized hole. More concretely, the
num_buffers field will be initialized with 1, and the other fields will
be inialized with 0. Setting the num_buffers field to 1 is mandated by
virtio 1.0 [2].

The change to virtio header is preceded by another change that refactors
tun and tap to unify their virtio-related code.

[1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
[2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- s/sz/vnet_hdr_len_sz/ for patch "tun: Decouple vnet handling"
  (Willem de Bruijn)
- Reverted to add CONFIG_TUN_VNET.
- Link to v3: https://lore.kernel.org/r/20250116-tun-v3-0-c6b2871e97f7@daynix.com

Changes in v3:
- Dropped changes to fill the vnet header.
- Splitted patch "tun: Unify vnet implementation".
- Reverted spurious changes in patch "tun: Unify vnet implementation".
- Merged tun_vnet.c into TAP.
- Link to v2: https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com

Changes in v2:
- Fixed num_buffers endian.
- Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com

---
Akihiko Odaki (9):
      tun: Refactor CONFIG_TUN_VNET_CROSS_LE
      tun: Avoid double-tracking iov_iter length changes
      tun: Keep hdr_len in tun_get_user()
      tun: Decouple vnet from tun_struct
      tun: Decouple vnet handling
      tun: Extract the vnet handling code
      tap: Avoid double-tracking iov_iter length changes
      tap: Keep hdr_len in tap_get_user()
      tap: Use tun's vnet-related code

 MAINTAINERS            |   2 +-
 drivers/net/Kconfig    |   5 ++
 drivers/net/Makefile   |   1 +
 drivers/net/tap.c      | 172 ++++++------------------------------------
 drivers/net/tun.c      | 200 +++++++------------------------------------------
 drivers/net/tun_vnet.c | 184 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/tun_vnet.h |  25 +++++++
 7 files changed, 267 insertions(+), 322 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241230-tun-66e10a49b0c7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


