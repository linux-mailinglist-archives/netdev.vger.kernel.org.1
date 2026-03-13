Return-Path: <netdev+bounces-267620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKOKHSCQtGl0qAAAu9opvQ
	(envelope-from <netdev+bounces-267620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:30:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5A28A673
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9C243022458
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B7382291;
	Fri, 13 Mar 2026 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ff7n9r/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C4382287
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441036; cv=none; b=bex+Wuc54wp/Zi8RCGZrSavjFtOy83fkor6IWByGw0bnmQSC+DM38JNdlr7bTdNLhmNo+JRTRe1H/ansYjcqmIMlD8IgAahOg/Tms4FV4p0YANgKYvToQb1T/wCfF7jv+7F4ZGd2ruF2eq76ffbepVGdHIsIWNj8T15ZS6kR8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441036; c=relaxed/simple;
	bh=OSIhld/8cPmcioyVfZ926MRv4gb50JYRi8mjnvQAO74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRpfpsTgDR44aC34rZRwy8xfyIn8jKrzhB/SqYPqs0+equflPhZgp6mxxlEEXfFf0QEhoiw8QKGxjxJeE9p4XcOLd0hc4/ZsNR5yon5lEmQCsO0mOt/6pdZ1fnYlMAwkJNyorXKWsaLp1YQDWy0rzQep23G6S5wANn4b8s0uCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ff7n9r/z; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-463f00cda04so1691793b6e.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441032; x=1774045832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4YrcG7dyAIkvfBnIr5QQD0gb9f+0O2huZFQNopL/90=;
        b=Ff7n9r/zr+VKvyUBkUT3Z1vF/0Vy1YOUjtixiRJRd1gKvFRb08+KROWBFvvIOqyKiA
         pM+JwvGlV/4u1uei202IMCJyYKUydAojOzYCBxLc1MSLRdCF/qwoQbzCUc5Ywq4JMPvY
         EcrI/x+5enAu/3KfcsZwPqR8Nhzb5+qCnSsZVheSaHOeQrb7DVJGiPykjXvV9QCxSKGP
         UJ9gibFE9AJHrvSd5j0gdbug3qeg/cDK3VEwNrTCyewV6rvWih1x9LBAavSP9xNhMxPP
         TsP5Bnlj1bv9z4qD3mvV5fENjHU6IgXpjtHVmnaZhv9iAmSm906O1NYITYqJE/pOJNkg
         4VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441032; x=1774045832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4YrcG7dyAIkvfBnIr5QQD0gb9f+0O2huZFQNopL/90=;
        b=FE1YAAsnzM6zJi9rNcjtLE5dBrFJdrES25tit5zobKgvaLi69ikUIkuXeiukRlBB/z
         LCA5CDFjUXbKNBGsGydhDBVg44SNiwQBLnFvQ3v7WpSd3a1CAGNvunUHNd2KX4Rmxngp
         0sPfx2aeZdxVMkc1RInhYcbJ9zVkKGvr+cv+AhYOemi8P95uvCkGdXUioqd8YldF12D2
         9u0UZ0c8M3hGrJACA5TgFV87T9oaUoo2FPpyWb3AdKPXKzXvOB9sw7bIoj58Tfa0nUA4
         fQsCR+FA9lN0hvpB/Cy2+M7e/A8bwjz+oDOn8b7gf+wPJfMPcsSSBLfgzlzIVToiktg2
         1/kA==
X-Forwarded-Encrypted: i=1; AJvYcCVCEGubWqUqyWZFFqF0QCjQ9iWTvpFVvQIkoveeoje/49Uoo8d1yjguTUjnLtxRmkvfk1Zw1zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+0JtFM8XqPA2I6t6MNfsGgZovzRodAMKNIOPwi2SBmOB18vw
	dj1cDTcFcp6wNBvXRyh2ygHjFaC89dQWTzDH6L8gLNUtxplOUKaTlMwq8dRRidpZtsg=
X-Gm-Gg: ATEYQzzhjfCEaMmhxzQpjhhjzV/aMWOGk3KrIJd4ZTfrXc2TCTOpDN2x6naA6HikKj/
	nA0sigwRfcBQKqPhIq+Qm6uvwsI56qicsmAxCtLkwbJaHk7mOSiTiUNI6yb03lRDFmMOh1mwLl2
	4wCIJetXDzBCg5SDzL5ElGXduGKeshHV4JhmDojV7ym+fL8MRREWtoX2WLkPEiFXo5FRH1QzaF2
	vYaLoFtKe0muuLRkKX4RGKNenCZ2LPMhkx0kugZ0HQe64QRGNYSJlj4EDMiLWQjnpkYMXZinPqA
	JP+mwU5GdnuoEX3qiIxPwxPVQoaen19sE9lEMTuF1e0T5KHgsTaWSRwfMPrUqec2h2YwUJLrBd7
	iC/fJPm2MJiPPwL4axdX0XIJNNKHxeCI+r6Rth+/seAkh140v03+3IFpZnQui1eJexM/qkqhAsq
	GDBKRa3ylA
X-Received: by 2002:a05:6808:23d1:b0:467:15ad:9de5 with SMTP id 5614622812f47-467570a27f2mr2598220b6e.13.1773441032469;
        Fri, 13 Mar 2026 15:30:32 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:30:30 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 0/6] bnxt_en: Add XDP RSS hash metadata support
Date: Fri, 13 Mar 2026 17:27:30 -0500
Message-ID: <20260313223029.454755-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[dama.to,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Queue-Id: C3E5A28A673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds XDP RSS hash metadata extraction support for the bnxt_en
driver and includes selftests to validate the functionality. I was able
to test this on a BCM57414 NIC.

Patches 1-4 implement the driver support:
  - Patch 1 adds bnxt_xdp_buff to wrap xdp_buff with
    pointers to the hardware RX completion descriptors and the
    completion type. This is similar to other driver implementations.
  - Patch 2 adds xmo_rx_hash callback for CMP_TYPE_RX_L2_CMP completions.
  - Patch 3 moves bnxt_rss_ext_op to bnxt.h
  - Patch 4 adds handling for CMP_TYPE_RX_L2_V3_CMP completions

Patches 5-6 add selftest coverage:
  - Patch 5 refactors common BPF map helper functions out of the
    existing xdp.py selftest into a shared net/lib/py/bpf.py module.
  - Patch 6 adds an XDP metadata selftest that loads an XDP program
    calling bpf_xdp_metadata_rx_hash. The test skips on devices without
    xdp-rx-metadata-features.

Changes from v3: https://lore.kernel.org/netdev/20260306230600.1628196-1-carges@cloudflare.com/
  - split out bnxt_rss_ext_op into header
  - address RCT issue
  - rebased on net-next

Changes from v2: https://lore.kernel.org/netdev/20260303024510.644962-1-carges@cloudflare.com/
  - bnxt xdp: actually fixed RCT issues
  - bnxt xdp: Added patch 3 to handle CMP_TYPE_RX_L2_V3_CMP completions.

Changes from v1: https://lore.kernel.org/netdev/cover.1772211065.git.carges@cloudflare.com/
  - selftests: moved tests into net/hw
  - selftests: fix pylinter errors
  - selftests: add check for no error count
  - bnxt_xdp: followed RCT for variable declaration
  - rebased on net-next

Chris J Arges (6):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction
  bnxt_en: Move bnxt_rss_ext_op into header
  bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
  selftests: net: move common xdp.py functions into lib
  selftests: drv-net: xdp: Add rss_hash metadata tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  47 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  19 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  57 ++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  10 ++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   2 +
 .../selftests/drivers/net/hw/xdp_metadata.py  | 146 ++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  95 +++-------
 .../testing/selftests/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/net/lib/py/bpf.py     |  68 ++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 12 files changed, 513 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c

-- 
2.43.0


