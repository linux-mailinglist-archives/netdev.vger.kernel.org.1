Return-Path: <netdev+bounces-298204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 15oDB2rhKmroygMAu9opvQ
	(envelope-from <netdev+bounces-298204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:25:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE080673771
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:25:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="n/yPXPd5";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298204-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298204-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0C1C3484E7B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF20423A65;
	Thu, 11 Jun 2026 16:17:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110D30674E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:17:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194638; cv=none; b=c/KFw0s9GhS8+1NhZZih5SeeX7i/7t2yUpG6r+6aZfnRaxXXCGJz+5RXbhb271Vo5s0B7wyv38Q4dTSfY8iyXyi2YZ7Sh+MhqGa4jp3Cmm6vJmtH1yRN56VSxb9cgtRujLT4Uo28dnJf8xSDkdOiOHBKVF+rnUtZvQ6uySQVRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194638; c=relaxed/simple;
	bh=+pK8PkXLRnqlfW1AuEdNtKOaf6kjQ3HiGkOzGHRe5C4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K7fRidEGLI6lMExcXHc6iQzvzBs3c3eRng0x4jQTgKdx+paFWVAJW6D5kS4wawF39aY3tTbU0E30M+qOLOwTjgFoVy+aL6VZagUaMSIjxHa+4ISRUkreeNCxmmu0NKk0mFAJQv9sgblgmUFRWDsskykGdw86EK09+whTfCECjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/yPXPd5; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8585cd8400so3220052a12.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194637; x=1781799437; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=og57coQD3NKK4AOSZLfMT1CyFR6j8/1DFkBGKs1z5do=;
        b=n/yPXPd5fKWYFljiv9npmnDfA7llZ5FJuz3T/gf9avWp3kNLzQFy+LnAzi6UMOdSFW
         gg0lboINXqwkK0cnPGzoPk/2O75BhYU5tP6GEXi2VK7RcJQbvULZAd4g2Eo1aWZANQuk
         I3aHmkp/KCmy609Z3ShvCVsE7/kY1oKwmRxrPuTZ1FLem6qUnhM0lNnzkgZCXx2Sp3Xf
         RFuFezKaf9spzJ3FisBXJRN+nA+IwyE4b//YkGWOlV+ELCRnkRJ4MPdiaCh3vdFbpqiv
         ZXu0aqw07F3RHkdCSRpikMoZz7gdwvrKq4rMys56O3KSvRlEuXn38or8ixqvkVZTekUG
         3z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194637; x=1781799437;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og57coQD3NKK4AOSZLfMT1CyFR6j8/1DFkBGKs1z5do=;
        b=ZJWTRV54i3qvUFnUReZJTrVspBouRAT/vN7SknOhHN9LQqw2JlS3NVrEDOGJLfjhLl
         z26is7UYdjE3ds2QfpvN69ZjYNNXweUcBIRnyED/89xK9BbSMRhRywxNV5cGjPnmsRLQ
         S1JW0qyZqQSlVlvhkvv73FNTla3LKUg3GyTePYl0RhoSR/w89FU+GFmA/Wq+5BSUQ+Rs
         /zIOhGxnNGkF75U+M56D8/BCuCuT+m0aoJmANbTnDaZ84ew5f10RHBFw+b+WvRZEBIJg
         EZCVkb2pu0JVHy1ZSPjH6o3Wq3Z3hroUU0/q9Ep7e6mQq+uo0Ogh3PxujXXf1210zCN7
         DCpw==
X-Gm-Message-State: AOJu0YxytldxOE2wHkmiT3CZ7d8ezW57O+P7jziscGndB3WsmTcL0tNb
	2CcdfFz9m8/sMie3M+ReKEdQFFPWDbjFLDr4f1DV152xWO6PEAw7zH7H
X-Gm-Gg: Acq92OEKnVTvkf3+YNFzt/prbZq8F6H3YAQZzM7a1V3/sE3OffLheasckIDEy1N3HfT
	/HdHny2hs/3CsBBp7c3PLvanCuFjjonqxtZ2CXrAR7dUcBpCLJlpedrH4ZlOFHWACCDBjjlTCw6
	IVAlXJfEXQWEM+leu5uTv7J6fmBUNoFYYgOeYX2JzHsJ+4vXesjUyDnp4xc4VR96710MnuGGp0+
	nelZTK9lvp+0A3KzNax+RAb07NIFZDTAM6vWfJkEt8j58IigoWsP0ZxUNplTOW5w+TISLLaZxyH
	zFlvp9rdmJuctJJjdlcXNaVJnPWRTlzLB9LUllSUt7P86uT1TPIemKqteDttIXU6lW+uEJkYdsE
	EKtHkFYTzEIRMxAGMUfQGxjIpDJUCq3Hhk/vcirDXtXKLpm/WoCpMiFe9HHjc11afvNSFpqu4qQ
	+Lpx+aHUk7W9i7pPtLWp0=
X-Received: by 2002:a05:6a20:cc8e:b0:3aa:f9cb:d438 with SMTP id adf61e73a8af0-3b5e32c48ccmr4294917637.21.1781194636389;
        Thu, 11 Jun 2026 09:17:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865880a1aasm2190461a12.22.2026.06.11.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:17:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 0/4] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Thu, 11 Jun 2026 08:28:41 -0700
Message-Id: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrUKmoC/23NQQqDMBBA0auEWTslJjUBV72HuAhx1IGaSBKCR
 bx7Qbrs+sP7J2RKTBl6cUKiypljgF6oRoBfXVgIeYJegJLKSCMVFr9PG75dWggDx5qxM53STrt
 WWguNgD3RzMdtDhCoYKCjwNgIWDmXmD73rLZ3/7n6j1tblDhr657OG6uMf21U3MPHDcbrur7y/
 TtwuwAAAA==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:almasrymina@google.com,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,intel.com,linaro.org,amd.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298204-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:mid,meta.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE080673771

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
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 49 ++++++++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 11 +++-
 13 files changed, 238 insertions(+), 43 deletions(-)
---
base-commit: 518d8d0199538a4d6d5e51064044ece71e0c42e7
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


