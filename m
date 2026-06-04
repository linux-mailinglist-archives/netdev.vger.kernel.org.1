Return-Path: <netdev+bounces-294986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id erOgHpHKIGrK7wAAu9opvQ
	(envelope-from <netdev+bounces-294986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:45:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D6D63C16B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:45:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ogj0RTpi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294986-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294986-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42F3B302DF9B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242C2116F4;
	Thu,  4 Jun 2026 00:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5F1AAE28
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 00:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533788; cv=none; b=nr9b7YSIAWXl4WrPdUIa8gvvSs5zxYEAVv2qje1tnA2brPuudcmWvxLWfwTd7xSnnb246Hh/AEYU/p7CE9lxPkxz+o5v02cdrspu7rFKULTjE5EMak6XH1Sh//tGrN3FZt1sqEtiVRRdAPGa6wvHvuV8slLya4Txw3WjHDBDo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533788; c=relaxed/simple;
	bh=pCtD5k7MvypEZUxpDcKQoAVqj5RgSw7ja09QgVIBbN4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V7o7W+o/IBhgMM8fiaqBqDoSkscZklBV5KpDebJwRqxWndfgv8VjafK8ch9SRRIRifSqSyMWehXaz1F4Rz2+jiJeSNclVeAwwj44SF5/uEy1S9rDryZCSbr8GkNCcFqT2OmTnIgv1I/X08dTWFPs2RpUL1vqQ1i/32g0DG/dJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogj0RTpi; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso80773a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 17:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780533786; x=1781138586; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gaSc57t4jmRqWa/tEAw7kwxJOfsrDztjZyVRXA4uTHc=;
        b=Ogj0RTpivOJUvr8Zy0r+IPYIPQc1Bdl59jmYxy8eIm64cQ73dw59GBuHCWHyTKIbj6
         l58ctYeDELnSZwJQ+IH38k1Wlht5Mei5r6/LlX0Zg06FyGs8JJG7E7jRA4MFwhjdYaUb
         B372yyUXm/0ab2qklABS2uZOKObRlordKNhlkYyURBKlC7ytXLKvMpXFAVNZGs5+0IM0
         17v7xYEKix4XOqdxOIhf2cI3bmly2bqEN1Zgsj096s7ckrbgNjRxWnVkCN7pHpjs+fYY
         Ppr5c5mZkVvbjDqmwUpFgBeduOuchYeUDlKsp5YMhjhCh8z4g8xbXoZ78M6ixWIZGB5J
         9o8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780533786; x=1781138586;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaSc57t4jmRqWa/tEAw7kwxJOfsrDztjZyVRXA4uTHc=;
        b=A0LrgHwY3LaLtQB+LimZC7+nX4G/sVmSq+1xopgyusppyUp++6ieg37weoNz8OQHL3
         ib6wqCiOi8toUpih6nAOuUm+64vhaxSIs8QAn8GrlAAuM06RtZhQhNyq08d8/bQpQ8sE
         dWbdwdLm94doptMlokj33sQGDrfFea1FnoXzBweYAdqrsWWApq7fbBEaErjIAe1AZszB
         aFntdnj1TURh7uepinNVazgAF/35QM6DxASN0FtY4gQsNPQl1LGacjfF0QFmiU5MmKRn
         ARn2ylPJS8a7RODUpjgWZXqs4aAkxsnObzcugp6gAlMNB4ZCPBc3GNhaRpZuszUT0OZj
         C5Wg==
X-Gm-Message-State: AOJu0YyHp/N0u51VKwSjdt0yBWpD/kAE7QwahjmOR6N/QEGL0V9aCBtf
	yoS+0lLFNGrlpZnZz3KUWZt8XQfl4VOy0ZLqbSWT7frVAEfW0XajqBtg
X-Gm-Gg: Acq92OFXcJNueg6G7zMxs9DRFfGfJH3as03amUlh7G3imFPiIJbV6WztGM8nnlAdGmI
	5z7nILsJ5BpHClJRk2jeNfO6fx6CitQhrXRGA0fO5p/K13UcxQG0cZPe18fqgezwS8YFcQddjQE
	3Wr/MfXspfz3g4g2i5sewNbir7AUkDQJ0hNDXxWTm3LkFdJ9MhFW5Jw5ZXdiuoEKoRQeH9AUSsA
	3so4we33Ux+r6MKs2jci2qRSJ6geSPkgaXtmctkvk/AMVJqyNXGIh1ei51CMJUXIajRzUq/t/xJ
	DtRFS2scDYRQZtnCxXFHpaatx7L1YeZMnrzZ4r0AG2w1jbXAyT7oCklpf7KSvkWl9TO2qbJSPYF
	jfCMbo00HX/drklUnu8hCUD8pTJQ+crMlHKuFKKvtn+TvAg8092fdMnzEo1FGNOtxF/+QjqnNgJ
	xba5gz6+EM5cCZeFTGTeK1agPXO5oUy9Tx85+QwYk=
X-Received: by 2002:a17:90b:3d4e:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-36e30e17847mr5798820a91.15.1780533786256;
        Wed, 03 Jun 2026 17:43:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c668f90sm1067665a91.6.2026.06.03.17.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 17:43:05 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/4] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Wed, 03 Jun 2026 17:42:57 -0700
Message-Id: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABLKIGoC/x3MQQqEMAwF0KuEvzZQK1boVcRF0YwTmInSFhHEu
 wu+A7wLRbJKQaQLWQ4tuhkitQ1h/iZbhXVBJHjngwvOc5335c+/lFdh0+0o3Ifed6lLrRsGNIQ
 9y0fP9xxhUtnkrJju+wGj3Y/WbQAAAA==
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
	TAGGED_FROM(0.00)[bounces-294986-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14D6D63C16B

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
Bobby Eshleman (4):
      net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding
      udmabuf: emit one sg entry per pinned folio
      selftests/net: ncdevmem: add -b option to set rx-buf-size on bind
      selftests/net: devmem.py: add check_rx_large_niov

 Documentation/netlink/specs/netdev.yaml            |  8 ++++
 drivers/dma-buf/udmabuf.c                          | 47 ++++++++++++++++---
 include/uapi/linux/netdev.h                        |  1 +
 net/core/devmem.c                                  | 52 +++++++++++++---------
 net/core/devmem.h                                  | 13 ++++--
 net/core/netdev-genl-gen.c                         |  5 ++-
 net/core/netdev-genl.c                             | 18 +++++++-
 tools/include/uapi/linux/netdev.h                  |  1 +
 tools/testing/selftests/drivers/net/hw/config      |  1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   | 12 ++++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 46 ++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 49 ++++++++++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 11 ++++-
 13 files changed, 220 insertions(+), 44 deletions(-)
---
base-commit: dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


