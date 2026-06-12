Return-Path: <netdev+bounces-298721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D2dPAGY1LGrgNgQAu9opvQ
	(envelope-from <netdev+bounces-298721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:35:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A267AFC4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:35:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=q9m43Nyc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298721-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298721-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCD193245BBC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C638D3EA;
	Fri, 12 Jun 2026 16:28:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB1369D56
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:28:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281694; cv=none; b=jma3kbnPJSMO2gMKHVoZkniv1rS13q0+G2g2XIOANbsDZKJU9lTo2Y93g8Rx29BIL5FiIX9Gg7GVi/A1ILCYJ6/ncRthOU9AsE4S/3uxHzeR4Jl/GQ6E2u10QO+azyVCdx5DVviFu/lvSXOa56ZgNMDV+c3gIrZk19vtNH0C010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281694; c=relaxed/simple;
	bh=6ZE69KeYwSFR9ddLxR0MdZCFmLqvmyPcMNYBiJZYTEY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fvMD31p/8wRsZcQbJYPWzycAuqjUunt0iJzcgmebqlSh9jvr03eO7P7jCosGc/ZgZqXYQwCwGL+IK8yqYdBV5k4nOwaYhFf8BtfHIIMT4Y6evYLiicKNqwEG3rOgCZtQIfZTwjZRGg4uQ+4/rwPEwdVA7x4dm27HyFdvpxHP2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9m43Nyc; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84275887a3fso1627670b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781281691; x=1781886491; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gfCjqesfW4kvsUaSrLF2IXLSdKMNWo5TtK5P4zLV3s=;
        b=q9m43NycljZ/y+CWZ61pjHLdFLTXuVlI/oW+KYmP2poGJAgnHxs0rvM60ACrkHXvvL
         MKyFwI+geeecXZcFZyIEu5IKO2jOxbYB453eGeHyk0zWP6/S7d0aTxFu7F6Ixwdkszwz
         x9xoIIpkgKb+CrAKZclsjF3x6qp0bBpf7YQUzlk+JOPZTqN1An129SBRlI9NdgGgZzOa
         H7Mjsd+lRaiNamZ4nsTsDFEiUuiceip9VVKaMoNRgnjmHjdyCaPWTrkSEFErP/IIsCBq
         Jx8MJ9EK6pnGBuSkeqNAZ/npJxldBR3AkkjfFamla+LOYhXHm1tYkb6V4hgkyt294P6o
         usTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281691; x=1781886491;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gfCjqesfW4kvsUaSrLF2IXLSdKMNWo5TtK5P4zLV3s=;
        b=kKE2q2Zkkd5LWgcW8cO8tlwmRrg7sWHR0oaIwh7+HKyda2Y+r2dOC6UHWkyFXrjuja
         eiBvOtwCQKK0SycJSE3cTqGTYtJDbE4kA09p6b4JFQ4gG3j79aFVz4FLQORcEJmYn/CZ
         q0G99cBMchB8dfSoYD3DZ/7l/jiXy2qtRXd33LB338KwS6HeDl/MAIyh+J8SzaD2cZO8
         wmrkUfuLZTWM4j6NFo6Wj0rMAUYB79EsGVhS/FFIRkYXslmBRyntnB8NXy5FTgKh39iY
         fPS0CYJKjfjbhyrVtDwMVntKsLelOVanN3LkFjYhG/Bs7FfgUcuUVYhIHInpS9X9+mh0
         Mi2g==
X-Gm-Message-State: AOJu0YzQSzydTK4zF4oa3y3GbgtaNmQlZjs52V9cmZrHI9974q6LeuC3
	eay9fGjCT1+beVa9QMSM2AodfhZmlKaRkw+3p4qyCRDy/4ursurYaPJc
X-Gm-Gg: Acq92OFpiv8z3B4qmaEt2+hhmxmh9r6vmowLm7m20lL91TwYTYuUjbbt4tz93su99eO
	d7zKd7FX2hajd1immF4u2ApG+SwjsW7di2OoXhoohuYkKwziFgPhFbNL07OUTwpBk0UM6VZck9Q
	DCK03g5ge6ykeG8YxbosR4WgUy0XVRUsW9Md6BXWRKy3+bN3WJPumjP8Xv4mFLu6z0k1PuxEkXe
	Ovf5plBDJld7iQAPLTcSRXjkGv4KUiaN5zWdyksngLUGbS7ohlvnTisXvM9Kyeoo9juFCmy81IQ
	eYQp0RqwDhJVzPHnbDtd35aLWAUq9WHWhuHrixILRqLKvTJuxXETFH/IADBjRQ13sWqLraHEf8u
	RXkQOaYNe6Wal8IpYqMGDkxXdqlW/2QEhTy/Xs2Q51UGWq+j2+gEdFrQyDvOaHVLcw9tTeIxcuD
	1XgSg5WQ2B1x062MWP3BE=
X-Received: by 2002:a05:6a00:2998:b0:82c:7420:82bf with SMTP id d2e1a72fcca58-8434d0b0bc3mr2959505b3a.19.1781281690860;
        Fri, 12 Jun 2026 09:28:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05d7d7sm2906069b3a.60.2026.06.12.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:28:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v3 0/4] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Fri, 12 Jun 2026 09:25:56 -0700
Message-Id: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABkzLGoC/23NQQrDIBBA0avIrDNFx0Yhq96jdGHNpBUaU1QkJ
 eTuBekii64/vL9B5hQ4wyA2SFxDDkuEQehOgH+6+GAMIwwCSJKRRhIW/x5nfLn0YIxhqRl705N
 22ilpLXQC3omnsDbzCpELRl4L3DoBz5DLkj5tVlXrP1f/catCiZO27uy8sWT8ZebiTn6ZG1bpA
 Cj1DyCUyEz3SfVse9IHYN/3L8Foqfj8AAAA
X-Change-ID: 20260602-tcpdm-large-niovs-56523a3a1077
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com, 
 dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:almasrymina@google.com,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,intel.com,linaro.org,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298721-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,2a03:2880:ff:4f:::received,209.85.210.173:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:mid,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 685A267AFC4

Every devmem dmabuf binding hands the page_pool PAGE_SIZE niovs today.
On NICs that consume one descriptor per netmem, this caps a single RX
descriptor at PAGE_SIZE and burns CPU on buffer churn.

In this series, we add a bind-time netlink attribute,
NETDEV_A_DMABUF_RX_BUF_SIZE, that lets userspace request a larger niov size
(power of two >= PAGE_SIZE). Drivers must opt in via
queue_mgmt_ops.QCFG_RX_PAGE_SIZE.

Selftests use udmabuf, but udmabuf sgtables were previously hardcoded to
PAGE_SIZE. This series modifies udmabuf to respect folio sizes in its exported
sgtable. The result is that when backing udmabuf with MFD_HUGETLB 2MB pages,
the sgtable is populated with 2MB entries, allowing devmem's gen_pool to carve
out large (eg. 64K) niovs.

Measurements
------------

Setup: kperf devmem RX/TX cuda, 4 flows, 64 MB messages, 60s, dctcp,
num-rx-queues=4, dmabuf-rx/tx-size-mb=2048, 10 runs per niov size,
mlx5.

   niov       RX dev Gbps   RX flow avg Gbps         app sys %
  -----  ----------------  -----------------  ----------------
     4K  300.63 +/- 53.21    75.16 +/- 13.30   54.15 +/- 10.23
    16K  321.35 +/- 28.20    80.34 +/-  7.05   41.05 +/-  8.87
    32K  347.63 +/-  2.20    86.91 +/-  0.55   44.54 +/-  3.51
    64K  332.11 +/- 14.26    83.03 +/-  3.56   35.47 +/-  3.11

RX app sys % drops ~19% from 4K to 64K.

kperf support (not yet merged):
https://github.com/facebookexperimental/kperf/commit/8837577f920876bce6986ec18869ac04439ebcd2

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- fix a bunch of non-reverse christmas tree declarations (Stan)
- remove extra uint32 cast for getpagesize() (Stan)
- remove overzealous strtoul checking (Stan)
- remove value checks that the kernel already performs on rx_buf_size
  (Stan)
- Link to v2: https://lore.kernel.org/r/20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com

Changes in v2:
- Use NL_SET_ERR_MSG_FMT for sg alignment failure details (Stan)
- Keep -E2BIG (not a direct ask, but seemed preferred, Stan)
- Update udmabuf commit message and comments explaining why
  "one sg ent per folio" is useful (Christian)
- Set/restore nr_hugepages in py harness (Stan)
- Link to v1: https://lore.kernel.org/r/20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com

---
Bobby Eshleman (4):
      net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding
      udmabuf: emit one sg entry per pinned folio
      selftests/net: ncdevmem: add -b option to set rx-buf-size on bind
      selftests/net: devmem.py: add check_rx_large_niov

 Documentation/netlink/specs/netdev.yaml            |  8 +++
 drivers/dma-buf/udmabuf.c                          | 52 +++++++++++++++++--
 include/uapi/linux/netdev.h                        |  1 +
 net/core/devmem.c                                  | 51 +++++++++++--------
 net/core/devmem.h                                  | 13 +++--
 net/core/netdev-genl-gen.c                         |  5 +-
 net/core/netdev-genl.c                             | 19 ++++++-
 tools/include/uapi/linux/netdev.h                  |  1 +
 tools/testing/selftests/drivers/net/hw/config      |  1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   | 12 ++++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 58 +++++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 36 ++++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 11 +++-
 13 files changed, 225 insertions(+), 43 deletions(-)
---
base-commit: 518d8d0199538a4d6d5e51064044ece71e0c42e7
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


