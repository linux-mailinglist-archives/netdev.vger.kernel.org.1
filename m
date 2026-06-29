Return-Path: <netdev+bounces-302813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yX+nH4fFQmojBQoAu9opvQ
	(envelope-from <netdev+bounces-302813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C8D6DE40E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:20:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=R9BrGp9K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302813-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302813-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C781301349D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A55395AEA;
	Mon, 29 Jun 2026 19:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56682EFD95
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 19:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760836; cv=none; b=LDjb47IUSk19eiX319IW8tlfChvOb8Zrj/UxDe/5oOMloMjRpPAyFa6CjcRhXJN1XfwUcaN1P7gSUzTxO+ivAsBVj+PrkGsVKST2VCjkZfHV86VH87bWYTtAMbfB10/zxQkVtmnA/pklfNjVzV2hPJ53y+Nt5nB6oi0kI9ZJ1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760836; c=relaxed/simple;
	bh=AksPqJm8AdB8z1GseHv2j/6UI9KT3j821AcEjIKRZf0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nXubU/ClKt8Ly9Itk2i77a/zmtru/gMgnynqTuI3Tnaccp6eEGj/xi390g20N0IEjL5bE+Q9/2geialq7/Gam04jQk3lUeFfGxxDAV0axZ2WxmCUGg8QqIoI9zV2+P9r4meaclq2xpl/9GMoYf67UjO7pN2WoktzIzO4QM9343E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tanshuhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9BrGp9K; arc=none smtp.client-ip=74.125.82.73
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1384427c3efso11701980c88.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782760834; x=1783365634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tuVF3Ubxy2bUmwCTppAH3J3uuqug40elm+qvkif8OCQ=;
        b=R9BrGp9KZNZTcwu+pZFC/+ubQCHAL8u19fS90sISGqNFHb3GhtwlHvgA7TTs2t8IlC
         j/cl4uIlbugJR7cKPUdyMJ0mqkihE2IwqAlkZzGTHGOXnuUGWhSCeEWoj5Dohbcp6wM3
         l/eC/NGv7talln9Zu6JXDtMEYLnVTxDn08/uMnOt1bFstRsVgkrz+mZWp1YGTIoXTbDY
         yQ4G0+qycmFLOYFKaQCyB3wU+QGMhqaP3/fCtlmq2kTfWAPXPdDZ5EeNUxLlCcf2ENrn
         VxEUKCegT5dKXyWLIU9vfDPfq4EQLyj7LS0RkYj6XlEvRXT2VGn63wqh+nwWhE5YL8aP
         Z82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760834; x=1783365634;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuVF3Ubxy2bUmwCTppAH3J3uuqug40elm+qvkif8OCQ=;
        b=Y0Gm6LckKnVO0zfPpFz+DROk9pB2vM7q4KrkfkYiKrsS7Ik/XAYrwHJ1BjnMrG5QNm
         VajX3zwEcIJ+phVyQGbWDGxv0iQYwh3hKfYbtPN6hHEWStNApP4phqZRJ4Vs5Cv4TVQo
         K0CR1IH4JtTzgsmX9kr0iSgtwlG6PWWbsBvRAzXVi+H73wkEukXYu57pCYk3gy8CQA8K
         JKmSoi7yB49HwygN5a/eyV9FO+BvKAZ2rxE2+jd+F+CzJwtVGFUAawlgdV2vOOs5R3zI
         cq+iB11ALB0AvAG/hYAfzLTvvdOgLa+cUKABWnHoWdo7Inhit2BNncMN9MGf/zS+04hu
         fb+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/bCq6wX/PBYvRotJyWcrCR5JRWMjU35zyg2HKlLULI1TrM7GYrsm+k8YFq1l9ap48CDL2CvSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8+WYUhSHnGuDxYRu19ibjf5LIFjRDnlOv03TLBkhza48m4rq
	nulNPl+S1N0PikfUQdve87mxceJrGCB9+vCuoxTvACXbfMF9XI/b2YDaNKZIGO75WLH/ikpOn9Z
	MsmQ7gCykvrfekjVEbw==
X-Received: from dldyq21-n2.prod.google.com ([2002:a05:701b:4555:20b0:139:a5e6:cf73])
 (user=tanshuhao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:923:b0:137:e532:f53f with SMTP id a92af1059eb24-13b2a1c32b0mr389067c88.34.1782760833527;
 Mon, 29 Jun 2026 12:20:33 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:20:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629192029.4013794-1-tanshuhao@google.com>
Subject: [PATCH net-next v1 0/2] Reuse threaded NAPI kthread across napi_del()/napi_add().
From: Shuhao Tan <tanshuhao@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Shuhao Tan <tanshuhao@google.com>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:tanshuhao@google.com,m:almasrymina@google.com,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302813-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0C8D6DE40E

Currently the lifetime of the kthread of a threaded NAPI is tied to
the napi_struct. netif_napi_del() stops the kthread when it destroys
the NAPI struct.

This patch series reuses the same kthread (thus preserving all of its
attributes) across napi_del/napi_add. The kthread is parked between
napi_del and napi_add. This series now ties the lifetime of the
kthread to net_device instead of napi_struct.

The usual workflow for threaded NAPI will be "enable threaded" ->
"configure the kthread". Driver reset (that can be caused by a NIC
configuration change or link flap) often destroys the configuration
and causes a usability issue. This series aims to improve on this.

There is a downside of this approach: If a device reduces number of
queues while its NAPIs are threaded. The kthread associated with
removed queues will not be stopped. Since the mapping between the
index passed to napi_add_config() and NAPI is an implementation
detail of individual drivers, it is not straightfoward to perform
a garbage collection and stop kthreads that are no longer associated
with a queue. The kthread still shows up in /proc, but should not
consume CPU cycles since it is now parked.

There was a discussion
https://lore.kernel.org/CAAywjhR0TPKZ-xzqjSP709OVmZWUisDNv2CVc_VxgOrXRtop+g@mail.gmail.com/
around what to do with the kthread between napi_disable/napi_enable.
It seems that there was an intention to keep user configuration for
the kthread across NIC configuration change. This patch series extends
the effort to cover more NIC configuration changes. Roughly tracing
through the call hierarchy of napi_del reveals that at least the
following drivers will not preserve the user configurations:
- idpf: idpf_set_channels(), idpf_set_ringparam()
- mlx4: mlx4_en_set_ringparam(), mlx4_en_set_rxfh(),
  mlx4_en_setchannels()
- bnx2: bnx2_set_ringparam(), bnx2_set_channels(), bnx2_change_mtu()
- gve: gve_set_channels(), gve_set_ringparam()
- ena2: ena_set_ringparam(), ena_set_channels()
- fbnic: fbnic_set_ringparam()
- (non exhaustive)

These drivers destroy and recreate queues during configuration
changes. If a NAPI was threaded before destruction, during the
creation, a new kthread will be spawned for the NAPI.

Some drivers do not have this problem, e.g. netdevsim. But these
drivers and the drivers mentioned above will still lose kthread
during link flap (ndo_stop/ndo_open).

Because the kthreads before and after these configuration changes are
different, all the attributes associated with the kthread are lost.
These include CPU mask, priority, scheduler policy, etc.. If the
threaded state is preserved for a NAPI, it makes sense to want to
preserve the attributes of the thread as well.

---
Changes since RFC v1: https://lore.kernel.org/netdev/20260612173644.380972-1-tanshuhao@google.com/
  - Refactor to get rid of RCU usage
  - Treat napi_config as a mirror during the lifetime of napi

Link: https://lore.kernel.org/netdev/20260612173644.380972-1-tanshuhao@google.com/
Link: https://lore.kernel.org/CAAywjhR0TPKZ-xzqjSP709OVmZWUisDNv2CVc_VxgOrXRtop+g@mail.gmail.com/

Shuhao Tan (2):
  net: Save kthread of threaded NAPI in napi_config and restore it when
    trying to create a new kthread.
  selftests: net: Add kthread preserving test in napi_threaded and
    busy_poll_test

 include/linux/netdevice.h                     |  12 ++
 net/core/dev.c                                | 106 ++++++++++++++----
 .../selftests/drivers/net/napi_threaded.py    |  41 ++++++-
 tools/testing/selftests/net/busy_poll_test.sh |  24 ++++
 4 files changed, 163 insertions(+), 20 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


