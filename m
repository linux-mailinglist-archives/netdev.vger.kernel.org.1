Return-Path: <netdev+bounces-247765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B7CFE577
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42DA5300F31D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F634C141;
	Wed,  7 Jan 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LwmwbkUV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1134BA46
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796093; cv=none; b=PNnUSzJIzfUyF2iapY8Sd7DPogU044v2rjXLUXNnubQIKavC8nL6EU2zvDLJvgbgFX7JQPlkSfedbC2iNbUDVilJIDa+dFAUoD0AlAMbKzk6Oe3RyBmkFWAHBUEl5YZvbY5GufVAqa2WvBIe+6lZ7t+iD8CD+SCzIMxSSsm3JHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796093; c=relaxed/simple;
	bh=Eu6ilaH8UuDw7IwCHWdvumqfGOwaK2NCp0A8fqgTDQ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hcgnqmsLx8AqgPuGpHaXAMCYWW3UHaPGtg8aUw7uBCJzgdCCA3RuXFcfQU9408BIuv/fQLYZqjSMe93aID8WP5c7R/NAhlzVJ/OTynAOeH0GPfljDOgEAeWux1DjB0rJGR82uFkgrZipfuIXuqeGl8h2bPE5AlF5wrsYDRJMvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LwmwbkUV; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b83b72508f3so350659666b.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796090; x=1768400890; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXZ/1IRyrkfvpzIX9P5wE04Wi2LMwB98c3ecDlM6NcQ=;
        b=LwmwbkUV8BY/zPjtQZxuyUPZK5xGiLqgdSa6g8wSkpQAQbHSIVVFjzs80AyBNpUMvM
         shG9X+3IhRmk9c1HPC3gAz78mdSuIVwiYXDEdGNtPNBC9Km657BKsJkmC+uJFt65yc1L
         mfcbsykfhNY/Fpc0MeVPmnvOSbIMgifT6ognkDDbPowA+9h7bPMx25TpRVIOPWZsfmb4
         R1LEFayVkGFV7/gE24Bs1ltbkS2+cm5Tf7kFVDrn+8fYNnbVnR9BMAUGLM8q3nUxivrS
         Ad1kXDETzV55irfmEY6M9ufGXyLiTOYAm4/58vHsTo70UA/ZGFa6Xu9AUbsCAvyUmIA5
         Ktew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796090; x=1768400890;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXZ/1IRyrkfvpzIX9P5wE04Wi2LMwB98c3ecDlM6NcQ=;
        b=GcGyxCBpOPuR/bxkm/p6rdwb0r30rmkCnB6mSZr+k2ZR56Ol+0DqfQB3DocjtoDY3k
         Xfk35r/H8ETMCW1s3cwea7IR9188cBQd5v/IkXnNK6Bf3NPpWXDEcLJ007kXCFtqVcXO
         J3mHgAFquPFPNWED4RwAC2ybQobnnwz8lrYEXWwG14IfcQeW3qXyr5oEuB9AKllXhW7E
         alkijnAjPE+DOx1JPTK+qjGn7W6JkiSgknI0d+n7155nTI4e71Gy3GxaAttkXlibPwPq
         PowlplaKCRx6ipkUf6mCo7Tdq8Nixd2jyYzMT5IQY6CiGVlyFXtIR2Uk3r1GNTNxRnEE
         h1jQ==
X-Gm-Message-State: AOJu0Yw5AAp4v06wqaXuiNLFEKtuyGNcPACJLVmxJt2Rx7U1YvmHra7i
	Jx04nnxC1vRIuXwLtFlXaCFz2KwdGqs2ZDNiiWcMT131U63FehwB5fVEKwVcD7Y76CU=
X-Gm-Gg: AY/fxX6sqIhxHPTBpP2R7SDy5KZpaFsf4DvP7PxK70TiiVCpJDvSC4aMustMt0cz63H
	Qfk1Wrb61gCCPITtYHucZv3ndHiN11tG8jG8hszdNamdVzHFBSUwAhRsL5I1bVaqPp9zKdEWTDe
	awz5hlOuatblFXGVnlflMPX61lo12k5lshywrfEbPW97YyeDcqEkb+pjoNty7/50Vjj1Gt/OW5c
	FU3x117Li4m6+lL+35z4XXxTfucUmsuKrZrNPlGWNl28hLZd3LcTJKzSNjczuQ0L7SQn6hM52Oy
	KaOSqkKS/vnV1Cs+J7yZlqyUgZaiWZKlT69rJNitIPJ1oq5B57gz1qclL/9+kINH1LwagoKFdu2
	K9/lZ116hN4h/Kr/MpnAHs+CLJIWT1M4oeO7quj8wm8TTME3TYcI93Qe1cyo8NJxmCaQO2m1w9H
	ZCihc3JCdHQ4jCIBuANDLFuysqA6uYqBSIZwbZ3eLwlqEHiynvwWUbDHqqOsI=
X-Google-Smtp-Source: AGHT+IGoIuvDrbD78kTl/itHNAZl4UA1IKW8Enb2OFYQWSEoOEC/UFEEv9VXia2+Uk2rY/X+EVzxPQ==
X-Received: by 2002:a17:907:1b1d:b0:b79:f984:1557 with SMTP id a640c23a62f3a-b8445378cb2mr279344166b.46.1767796089952;
        Wed, 07 Jan 2026 06:28:09 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56962esm534525266b.66.2026.01.07.06.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:09 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v3 00/17] Decouple skb metadata tracking from MAC
 header offset
Date: Wed, 07 Jan 2026 15:28:00 +0100
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHBtXmkC/42PwU7EIBRFf6VhLQZombaz8j+Mi0d5WGJbOsCQT
 ib9d5EZY4zGuLy5eee8eyUBvcVAjtWVeEw2WLfkUD9UZBhheUVqdc5EMCE5FzUNb4rOGIEGMLh
 65wxdMGpMgfqNumW60NoILZjmEjWQDFo9GrsVyTNR68fBFsnLrfF4OmdrvNczhgDFeqxuTia/n
 NmwQhxpaiijckDFOuhV3aqnYXJnbSbw+Di4ucBHG6LzlzIt8UK/r2j+syLx7Oj6tjOSyabh7W+
 OJD65B/bt0z+4InNBcDy0vZJg4Ad33/d3YU8H2ZgBAAA=
X-Change-ID: 20251123-skb-meta-safeproof-netdevs-rx-only-3f2d20d15eda
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

This series continues the effort to provide reliable access to xdp/skb
metadata from BPF context on the receive path. We have recently talked
about it at Plumbers [1].

Currently skb metadata location is tied to the MAC header offset:

  [headroom][metadata][MAC hdr][L3 pkt]
                      ^
                      skb_metadata_end = head + mac_header

This design breaks on L2 decapsulation (VLAN, GRE, etc.) when the MAC
offset is reset. The naive fix is to memmove metadata on every decap path,
but we can avoid this cost by tracking metadata position independently.

Introduce a dedicated meta_end field in skb_shared_info that records where
metadata ends relative to skb->head:

  [headroom][metadata][gap][MAC hdr][L3 pkt]
                     ^
                     skb_metadata_end = head + meta_end
                     
This allows BPF dynptr access (bpf_dynptr_from_skb_meta()) to work without
memmove. For skb->data_meta pointer access, which expects metadata
immediately before skb->data, make the verifier inject realignment code in
TC BPF prologue.

Patches 1-9 enforce the calling convention: skb_metadata_set() must be
called after skb->data points past the metadata area, ensuring meta_end
captures the correct position. Patch 10 implements the core change.
Patches 11-14 extend the verifier to track data_meta usage, and patch 15
adds the realignment logic. Patch 16 adds selftests covering L2 decap
scenarios.

Note: This series does not address moving metadata on L2 encapsulation when
forwarding packets. VLAN and QinQ have already been patched when fixing TC
BPF helpers [2], but other tagging/tunnel code still requires changes.

Note to maintainers: This is not a typical series, in the sense that it
touches both the networking drivers and the BPF verifier. The driver
changes (patches 1-9) can be split out, if it makes patch wrangling easier.

Thanks,
-jkbs

[1] https://lpc.events/event/19/contributions/2269/
[2] https://lore.kernel.org/all/20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v3:
- Use BPF_EMIT_CALL in gen_prologue (patch 15, 16) (Alexei)
  (Will convert bpf_qdisc/testmod as a follow up.)
- Link to v2: https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com

Changes in v2:
- Add veth driver fix (patch 7)
- Add selftests for L2 decap paths (patch 16)
- Link to RFC: https://lore.kernel.org/r/20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com

---
Jakub Sitnicki (17):
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
      bpf, verifier: Support direct kernel calls in gen_prologue
      bpf: Realign skb metadata for TC progs using data_meta
      selftests/bpf: Test skb metadata access after L2 decapsulation

 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   2 +-
 drivers/net/ethernet/intel/igb/igb_xsk.c           |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   2 +-
 drivers/net/veth.c                                 |   4 +-
 include/linux/bpf.h                                |   2 +-
 include/linux/bpf_verifier.h                       |   8 +-
 include/linux/skbuff.h                             |  37 ++-
 kernel/bpf/cgroup.c                                |   2 +-
 kernel/bpf/verifier.c                              |  54 ++--
 net/core/dev.c                                     |   5 +-
 net/core/filter.c                                  |  62 ++++-
 net/core/skbuff.c                                  |  10 +-
 net/core/xdp.c                                     |   2 +-
 net/sched/bpf_qdisc.c                              |   3 +-
 tools/testing/selftests/bpf/config                 |   6 +-
 .../bpf/prog_tests/xdp_context_test_run.c          | 292 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  48 ++--
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   6 +-
 21 files changed, 466 insertions(+), 89 deletions(-)


