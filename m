Return-Path: <netdev+bounces-293896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKSKDnrcHWpsfQkAu9opvQ
	(envelope-from <netdev+bounces-293896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:24:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8708A62496F
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBECD3015A60
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB1C370AD6;
	Mon,  1 Jun 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVtb3QZI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0822349CFD
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341878; cv=none; b=iQY65XcJjMR0KLhDIAc1LND7IqcmHg/iQtOOdCa7FjTwdyjcbQ/9Bhb9UxVgDwrhOJxPpHvgQi73CRrqIbSZsTEifyquCUgTyjmS/ZS11MxfcCuCWeEMwfhZt+JzV2kWJYipvODjhXlSQyl1yLl6vCrRJiuzLpZ6uHBHlLjNnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341878; c=relaxed/simple;
	bh=vAdRkEFKDae2aMLrGZaTH2BMgHDgL57AkeWweCLFki4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QNOUDERs8DUC1uyCuN3mbMFgwJz0OJBrNsu2fJfN0+KlITnp3qfwrrKv6nhOvTdzRrqBF/92f0P7fRtTDH8H2nm3+xkCBIOeL1ny2xZ4Zca0hdKtG6X4Hy3bCIn+rOF/yKzsoyl7Cs8yXVA3ylK9of97DcoBGPpz5w98C1qY16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVtb3QZI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8587427468so806560a12.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341877; x=1780946677; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/MCmyoZSECFIrOxC29z+xmAbGeR8WzWcA1U+w5LzaXY=;
        b=KVtb3QZIjmwDnd0c2OOdbHq+T8kb4gOc4OQ3FkCQQG4J9sT7d+ci7A0n3H8RuW0rBY
         e4UzJos2UK79FyF7RqUBP7oxm2pSqgB+HWYSQZRZOkan34Enpnz3OnS1ma4nIptT1d3m
         ZB9nVCQo21oEeLZqyLzIACJe+y2FHh5v7rqxVxDNo3fH7S2124R9vhEcDdNc38ghXS+f
         lzMjPT496TwoE2bVKIDEea4wHAeLVPHHcg1LcNKcOaACnc/+JR4377KTarY+qaEgg99y
         obxfjtzSjblCcQCPG05ZkasXpVf/HCtTq0d/r1XX3KViBWt9Gxl2Fv4gDkBSiYEXF8T4
         J2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341877; x=1780946677;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MCmyoZSECFIrOxC29z+xmAbGeR8WzWcA1U+w5LzaXY=;
        b=o1aHDPxMmJItBbLyUgHRJ3HpjWYT1VuCeMlFfPbFrl/lbYjM1+NP+wS6ZGMJTtJ2r+
         0VQXiAUBEYdubfgcOfr9zFgnCSNtnhdMTxc/iG6lmLcDcMAeP8G7d5+9Urnj7W/g/qxa
         BtLhSciE9Oly6oXaFyfswe2CtCLukBanIS42H/VV4r0v9kB/97ibgwAziFrw3xZgs9q1
         xltWE9XsCjc6W07yaXrCcArzt8O8fZOS4Awh7slOoS2vblZntjOEdMwTOLGjSKe0eWRC
         +grK5RCDTc3bLDf8dY5k2JNtNLOOI9uiKhHBm/NjwpptZPmxEgiTnGXQkEWU+4gPWxF/
         aU4w==
X-Gm-Message-State: AOJu0YwEwk1CdXuQR1r3S9YT10W/m/Z4kyik2aBt3oO/G/aHwOgxuD9B
	P5UxAv1GvWea+rJcTDwkiJ1b6TesM1OckVEpPW+FUFTFDkBVu8zUtSiO
X-Gm-Gg: Acq92OHi1d7VYwr475HDvy+M7LDglWmytw+/8b7tqLZQuyBY8MUUIMnXbLC91hszb93
	Qps+Nd3h7dcG0wssoDEEu2HQIaVRhUQ+HGA5vbWlnNiHd/dXIfQnK1NEukt/Ou46/Bm90NVmVXi
	uf/iHBLN730FiJGRPadt0Y/NEkJtwYJSl6Kp/5R3x7mMc7IJTGJrKlhB0lA8lNQFbDpXMKwilrZ
	LS+nzBLxhZeqbMWrb6J+aB0R5E+OpYBAVysLai2bLzeq0IlmInBW6oBt1inCcx1KnpzZ7qZoI3q
	jEcrU/VBus4Bq7FUOm271pXymBLoHJOf9EgGboYdihZvKh7sLRbLrsgCCJyqwdnTL/FnYx3TdvM
	4t8kOCV7n4WqMPN/L3gaHp+x2tKYBd9Pt7yCeiJosLhHgJQwV2hkoXmXkPKyuwC0HQVH6JFCoH1
	lAhtsV4+9OhDD84vceohKC06khaF5PvOSvkWrNCfk=
X-Received: by 2002:a05:6a21:6e8e:b0:3b3:2703:123 with SMTP id adf61e73a8af0-3b427fe5105mr14193245637.45.1780341876971;
        Mon, 01 Jun 2026 12:24:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842487f60f9sm5022651b3a.8.2026.06.01.12.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:24:36 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/2] net: devmem: allow bind-rx from non-init user
 namespaces
Date: Mon, 01 Jun 2026 12:24:26 -0700
Message-Id: <20260601-nl-prov-v1-0-9bc57d6ca3f3@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrcHWoC/x3MWwqDMBAF0K0M99uBMVSp2Urph4+xHSijJBIEy
 d4LngWcC1mTaUakC0mLZdsckdqGMH9H/yjbgkgIEnrpwsD+4z1thR9DOz67WYJMgoawJ13tvKc
 XXA92PQ+8a/0DbupmVGMAAAA=
X-Change-ID: 20260529-nl-prov-491a85c020b0
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293896-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,nk_devmem.py:url]
X-Rspamd-Queue-Id: 8708A62496F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NETDEV_CMD_BIND_RX is GENL_ADMIN_PERM, which checks CAP_NET_ADMIN
against init_user_ns. With netkit and netns support for devmem, it is
now useful to let workloads holding CAP_NET_ADMIN only in their own
user_ns issue bind-rx for a netns owned by that user_ns.

The first patch switches the flag to GENL_UNS_ADMIN_PERM so the check uses
the target netns's owning user_ns. Init remains permitted.

The second patch just adds test cases. They are identical to
nk_devmem.py tests, but using a non-init userns.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (2):
      net: devmem: allow bind-rx from non-init user namespaces
      selftests: drv-net: add userns devmem RX test

 Documentation/netlink/specs/netdev.yaml            |  2 +-
 net/core/netdev-genl-gen.c                         |  2 +-
 tools/testing/selftests/drivers/net/hw/Makefile    |  1 +
 tools/testing/selftests/drivers/net/hw/config      |  1 +
 .../selftests/drivers/net/hw/lib/py/__init__.py    |  4 +-
 .../selftests/drivers/net/hw/userns_devmem.py      | 48 +++++++++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  |  8 ++-
 tools/testing/selftests/net/lib/py/__init__.py     |  4 +-
 tools/testing/selftests/net/lib/py/netns.py        | 79 ++++++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py        |  7 +-
 10 files changed, 146 insertions(+), 10 deletions(-)
---
base-commit: 0906c117f81c2ae6e6dbfa82719f79c75e1c9325
change-id: 20260529-nl-prov-491a85c020b0

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


