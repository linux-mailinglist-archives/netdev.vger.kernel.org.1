Return-Path: <netdev+bounces-241208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A785C818E6
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEDE3A8C6F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9103164AA;
	Mon, 24 Nov 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="H+HUbVJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD705314D28
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001755; cv=none; b=U+aJXwCZMOUjD1iD5HQ0C3e8Aqe40Jyl7fdV4SPU+46scelWlA19ORHt6Ccly/7ZNqoijwOoEzIu/Avftwtz9mFFOYAazVxU1QXa+2tuTJFKWl+fGvqlr0EHQaYlANceY9ebVvxTBVUJ1hi0BBthkzAz8bY/RVJKx3Jg0EthGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001755; c=relaxed/simple;
	bh=Lm8xB3Mcw9N1Go16WgHAjr/poddp+Ohwf2ji4aVe5QQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HqUTE1mB4SNpQ4Ngdn3v5BsDwN8ddVtVDRixyo29UfiTPwpnN9vrfo8o4Sd5rlGoHawZw4qHkWmFv0l+8jVmgpKHJJbCY9AwM85DzFq9iwm5WarzmWefuP9Z153ia9Ox3ENR+PJ5d7NiaZzpeq1465m1hksiQ4/B6gjrq967xfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=H+HUbVJV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so7005933a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001750; x=1764606550; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGoUNPv9+b5m6zrJYppINsqJZopm9pY5jcWPoB5goiQ=;
        b=H+HUbVJVrs0KXws+u/f+SfdkHcYL59o5MBhMr+ein62kFdF7f2QU2sABUSdxpIcx+F
         5pMB7xLQkpSrf9yIdbWAaOiW3xv0luZBlBZSbSAsA26v836LOjJbuzLx9vW0AKhlG2cc
         kZ2pxtMd4LKhwG32kvm1wTMwIRvNnvV9NlgheMcYLhafdXpf9cgGz+DqZDFFAeeGaTf8
         cOGoYP6g+rCP1N65o6o9LuBzTcLwmU5lzArKJ1IO+Rck4XGSs5bUbFlC6sDsVV4+rehK
         iPznl13j8oHusVBKe2niSZLjS41EaaUFT7tTVv/IVyXKoQUQnqfvF7V5Z8ZEDjSvqYMv
         DaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001750; x=1764606550;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGoUNPv9+b5m6zrJYppINsqJZopm9pY5jcWPoB5goiQ=;
        b=F0r2vagHqcscooqB4Vi/97grKHkciW1EcuukTSzlng8peDvzqlOD5myDJWegZnodA1
         u+qTpd+g8q+Hlf0Z6jlG2B9HRJeCxaVUDhXIOrco1Wj0N6WaNszZnDhhzkb3r4m7+0N6
         2uKl/FlfyV717/7+2mEGHCXcuIcMfWBxYHs7nGWZHnQB9C/xbtznMr1fays+6p46NazO
         qIwv6hZDJxMTzsRnsYZ4xP/kl/FnAkp1/2c+/gK9Fxq1Xb/TbrXqO4jTtPDAgLzB0Az6
         QH0vKA06lRfFd14LhS7y87zR8MqNl7iuYOQM7Yb++oIwC7zQllltArvYpa8VGDC45++y
         PqYw==
X-Gm-Message-State: AOJu0YxZ38s7pH+c+ldEem4h9FFXiMD2d2apRshhg2cH/pJYbSFQvvz3
	x9RVN4l3YhwiihZDAg4Q1THOFXLUg8ytkyy1skMe7OOlt2l/ggyfnTyeRo9yuqnUu/M=
X-Gm-Gg: ASbGncvhIDMBa9IlmIJfaBDTarMqjzG1AlMPf6dwsCgXlxZsfBuxZUAVDWIN3q48EVw
	ywUo/knUzW9hpSF5Y9CGaD4nS7/jl1AnnN1DpsFATypWKy87dmA5or4T29Lmb9Ct/Miwboze7m/
	NdQfgA/oKR2XOZUL/rUcfUHk8uGu9Ld/1p6zS9jdVbmgOf/r+xv/NEH9bqKp45QDZVP7ibJeuRX
	iPfJGMFwmFeXlM5HQ2EKWBNMHieXfl+ENI9C0i8dW+BwxW8MQlfyfL3Lf74/ngLsxQyoXU1hfiE
	UiNoXIiV4Mj94R4xxzGPtt3kKSBsUsC99iAUL1FQDZ/44TgzHkJ5QCqLy56ID9ARKtYEBSp83em
	at2jH3hHk++m5/p10synEfCApl2eeVMWgU/leA3sxSaNNPjjohHFUloytmWL/tcHpxNsKWVdF4Z
	wW5Y+CdG1IsAf8P9oQ+31E+YzTHYwmtFfv9x+3iXDZdW2SBfkWAWcxmTE2
X-Google-Smtp-Source: AGHT+IF3vHK6nRw+jza7EUoGizJvZ3v4jQYsm0JIufX5xr171UcMTPf7qkJV4aqG04fXrh7aiIVr4w==
X-Received: by 2002:a17:907:3e1a:b0:b73:8d2e:2d3d with SMTP id a640c23a62f3a-b76715159e9mr1423949066b.4.1764001749257;
        Mon, 24 Nov 2025 08:29:09 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4f4esm1334710366b.45.2025.11.24.08.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:08 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH RFC bpf-next 00/15] Decouple skb metadata tracking from MAC
 header offset
Date: Mon, 24 Nov 2025 17:28:36 +0100
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWHJGkC/0XNTQ6CMBAF4KuQWTumFIk/KxMTD+DWsGjpVBqBY
 lsIhnB3K5i4fHlv5pvAkzPk4ZRM4Ggw3tg2hnSTQFmJ9kFoVMzAGc/TlGfonxIbCgK90NQ5azW
 2FBQNHt2Itq3fmGmuOFNpTkpAfNQ50mZckDvcrpdEdt+jMUCxto5efZTDb9KQ92KRT8nqsvzvR
 qUTocJhhwzzkiQ7iKPM9vJc1rZXuhaOtqVtoJjnD9ZcyvXfAAAA
X-Change-ID: 20251123-skb-meta-safeproof-netdevs-rx-only-3f2d20d15eda
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

This series continues the effort to provide reliable access to xdp/skb
metadata from BPF context on the receive path.

Currently skb metadata location is tied to the MAC header offset, which
breaks on L2 decapsulation (VLAN, GRE, etc.) when the MAC offset is
reset. The naive fix is to memmove metadata on every decap path, but we can
avoid this cost by tracking metadata position independently.

Introduce a dedicated meta_end field in skb_shared_info that records where
metadata ends relative to skb->head. This allows BPF dynptr
access (bpf_dynptr_from_skb_meta()) to work without memmove. For
skb->data_meta pointer access, which expects metadata immediately before
skb->data, make the verifier inject realignment code in TC BPF prologue.

Patches 1-9 enforce the calling convention: skb_metadata_set() must be
called after skb->data points past the metadata area, ensuring meta_end
captures the correct position. Patch 10 implements the core change.
Patches 11-14 extend the verifier to track data_meta usage, and patch 15
adds the realignment logic.

Note: This series does not address moving metadata on L2 encapsulation when
forwarding packets. VLAN and QinQ have already been patched when fixing TC
BPF helpers [1], but other tagging/tunnel code still requires changes.

Selftests are missing. The series has been developed against an out-of-tree
shell-based test suite at [2].

Note to maintainers: This not a typical series, in the sense that it
touches both the networking drivers and the BPF verifier. The driver
changes (patches 1-9) can be split out, if it makes things easier.

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com/
[2] https://github.com/jsitnicki/skb-metadata-tests/blob/main/rx_loopback_test.sh

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (15):
      bnxt_en: Call skb_metadata_set when skb->data points at metadata end
      i40e: Call skb_metadata_set when skb->data points at metadata end
      igb: Call skb_metadata_set when skb->data points at metadata end
      igc: Call skb_metadata_set when skb->data points at metadata end
      ixgbe: Call skb_metadata_set when skb->data points at metadata end
      net/mlx5e: Call skb_metadata_set when skb->data points at metadata end
      veth: Call skb_metadata_set when skb->data points at metadata end
      xsk: Call skb_metadata_set when skb->data points at metadata end
      xdp: Call skb_metadata_set when skb->data points at metadata end
      net: Track skb metadata end separately from MAC offset
      bpf, verifier: Remove side effects from may_access_direct_pkt_data
      bpf, verifier: Turn seen_direct_write flag into a bitmap
      bpf, verifier: Propagate packet access flags to gen_prologue
      bpf, verifier: Track when data_meta pointer is loaded
      bpf: Realign skb metadata for TC progs using data_meta

 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  2 +-
 drivers/net/ethernet/intel/igb/igb_xsk.c           |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |  2 +-
 drivers/net/veth.c                                 |  4 +-
 include/linux/bpf.h                                |  2 +-
 include/linux/bpf_verifier.h                       |  7 ++-
 include/linux/skbuff.h                             | 37 +++++++++---
 kernel/bpf/cgroup.c                                |  2 +-
 kernel/bpf/verifier.c                              | 42 ++++++--------
 net/core/dev.c                                     |  5 +-
 net/core/filter.c                                  | 66 +++++++++++++++++++---
 net/core/skbuff.c                                  | 10 +---
 net/core/xdp.c                                     |  2 +-
 net/sched/bpf_qdisc.c                              |  3 +-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  6 +-
 18 files changed, 134 insertions(+), 66 deletions(-)


