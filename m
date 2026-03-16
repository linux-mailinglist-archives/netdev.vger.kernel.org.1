Return-Path: <netdev+bounces-268295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLFyOnSEuGltfAEAu9opvQ
	(envelope-from <netdev+bounces-268295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:30:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FB32A17AC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8808302E0E2
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C0372EC3;
	Mon, 16 Mar 2026 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDR/3HHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064F372B32
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700164; cv=none; b=Ja4/iH3AxLF650QZlenRAtNG0SvHxPjtN6onbNfzqs9X3hUCC4oOK/u0aM9AIEFmDsggN5FyiwF/draYus+/D/3zaqQYq99yI7gHm7EPfLeybYMkEnPpUZudyropMjgxKzutG1t5EVOac8r18vz0JlqollHBC134TYjYK4zZ1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700164; c=relaxed/simple;
	bh=m7LzcrwDBmaIfty6pcqphSCz4xQly0jpZEtJFxwEYFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dsQI4l8Z2ONDa80UIfxCkwk0O8LD4potlImLpzphRWl6Htzlq7w6WhqLeEQ6OO8cr/tFMVUFSrSPgnlpuxCnVLUgBa6t3H0328zHpFaT8/nusJeesXdYCnpOQN0+SbypH4W0xzKWhQded/FrQzT12fKK7wxFrfq7zhICyGcMKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDR/3HHE; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ca09f2056so3856355d50.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700161; x=1774304961; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4CvTWsBdAJJ2Kt1MDOaHVOFx2tItiY273T4n5voea4=;
        b=YDR/3HHE32C3Mf4A871LQvtD21pA7JgPYJANmeUbYhF2gqjGo7ofP1H/VTogw9qJ/B
         8zgsjRvR/XKFg3LlVi/FLjO5vQuTpzDfCdD/8pJZSlRXhLlQjZpBMH37xrJyIONAKtB1
         MiAXXWynJN4caNjBuDqFVkfpajdsRoVcwJyPded1jGASGzUp9Ra2a8+uIYQ1DIjZGesW
         KtNyg1uz6zxn4PfO6rxmP68Q//CZFXe28uxhcjQ1WmInpA00WmsY6WxBDNkOHMuVyVQs
         saMI3CLvENadTsf1/gE15fsfxvU/pYOHMODX4TBY5VSZojRelHAZ/On+cVbZ6r1Vquid
         Y57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700161; x=1774304961;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4CvTWsBdAJJ2Kt1MDOaHVOFx2tItiY273T4n5voea4=;
        b=cw6D2ZKl79ZLDU0CLl2cq8CfOv/2Jy1wj7N2L8La3yIolTHVwpjXVKSD/D1QpJ0ykq
         KgUkcId7sHGw0K1aXDW7/IajjD2FuZIQcy8XBDlZzrirDr6r6Uu7PU6HlJEvBl9sQRuv
         88G4jvwau2YOc/GQnjfwGxXuWKB49j08SuCexI+lolzC6SGhZQ81v2yomqeJNo1AasaW
         ABDUbWJeBjmnJ/l1Ammdlmb11tB5Yf1Mg4Vy59OMWCJcKxbeDMtSfxIRnoYPn9vFHSzz
         tp1nm6RIYFrTlAUaKZxBOxIJCztFkZFrPeZ2ZNXQBfB1VeXvBwrfr7FepwJPhLjQR/e8
         GHrw==
X-Forwarded-Encrypted: i=1; AJvYcCWjL7sXSnxl1ACYgiNr6h5srjq0b/ARr5ANqnUr8hdBjvSYQujUPbNPsFwx2OHXC1rTmc4xm2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcSZj6SV+V89/isflk5DGJ46BGd9mM+8yBnFGHg+NcMGTKH7M
	+Hjx6Fe3HqXZf3xzEnhFk8KmT5F6bP4xt/sdp11ZBFqTF95k0RifIyyt
X-Gm-Gg: ATEYQzzvuZmYXAfeWGFL/OyVo9apHCaMZBovCTySM0c7CpT4/tcXCKY7CkmUPJcxeQ3
	p22KrKIebWIRdhzWEQykmS/77lPP9nUE2jlVEkXuM+o8D9L1odVVMe7loHdF5Jb+ovNQ/KVlE9H
	7c0l9Rsk3yWwomSefqJIdamNbV52rHsVCAkbKnl2qJAl4LionhXWDz6/xn1NnQCE1YpUJzObihK
	Vz4FGEy/jNZV9Us6fGHY3OJpCQn/2getm4A9lukcOHBAFLnb1+njQym81WLK+6DWeBUjRMqHdyf
	ZBJfjFyioe0Rq7rPY/KpOEFbxpHx1h0EN2+AIaY7Ningi1KvC2H67cgFzftOiQgGgyaM9ejJjIW
	18k7NbngDA+qSF4hXYzRy6b/XdyLPNkySoIRonmYZ7jKUFjH3xSaT9sk7AW5GtxPYFFBt0u1owB
	szlFCcQYPZfwqy2vQE/PT/9EhlR4wMUMMQ
X-Received: by 2002:a05:690e:24d2:b0:64c:e7b1:3573 with SMTP id 956f58d0204a3-64e63041455mr9721861d50.54.1773700161215;
        Mon, 16 Mar 2026 15:29:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65a405c5sm6219061d50.2.2026.03.16.15.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:20 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/6] net: devmem: support devmem with netkit
 devices
Date: Mon, 16 Mar 2026 15:29:11 -0700
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmEuGkC/x3NUQqDMAwA0KuUfBtQO530KsOPtqZr2IzShuEQ7
 z7Yu8A7oVJhquDMCYU+XHkTcKZrDMTs5UnICzgDfduPre0s1li8xoxhC+FLNb9p9YIad1xWFNI
 X64ApTEO62fswThEaA3uhxMe/eYCQotChMF/XD1ruQhCAAAAA
X-Change-ID: 20260313-scratch-bobbyeshleman-tcp-dm-netkit5-fb85f437568c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>, 
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268295-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A0FB32A17AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces support for TCP devmem with netkit devices.

When a physical device leases a queue to a netkit device, the netkit
device is free to bind-rx on that queue. This works out-of-the-box and
for this RX path this series only introduces tests. The tx path, via
bind-tx, is less forgiving. Before the skb ever encounters the netkit
forwarding policy or BPF redirection verdict, the skb is dropped
because the upper devmem TX path deems the underlying netkit device
unsuitable for DMA and netmem TX.

This patch series introduces netkit and queue leasing awareness to
bind-tx and the devmem TX path, so that devmem packets do not
prematurely drop even when destined for a suitable netkit device.

When bind-tx is called on a netkit device that has been leased a queue
from a physical device, the binding looks up and remembers the physical
device if it supports netmem tx. This physical device is then used in
bind-tx and TX skb validation where the checks for netmem_tx are
performed on the physical device instead of the virtual device. If no
queue has been leased or the physical device doesn't support netmem TX,
then as usual these checks will fail.

If BPF redirect or ip forwarding lands the skb in the TX path of a
device that does not support netmem, then validate_xmit_unreadable_skb()
will fail and the pkt dropped.

This series depends on the queue leasing series:
https://lore.kernel.org/all/20260129222830.439687-1-daniel@iogearbox.net/

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (6):
      net: devmem: support TX through netkit leased queues
      selftests: drv-net: extract _find_bss_map_id helper in NetDrvContEnv
      selftests: drv-net: add skip-config flag to ncdevmem
      selftests: drv-net: add primary RX redirect support to NetDrvContEnv
      selftests: drv-net: add netkit devmem RX test
      selftests: drv-net: add netkit devmem TX test

 net/core/dev.c                                     |  26 +++--
 net/core/devmem.c                                  |  16 ++-
 net/core/devmem.h                                  |   6 +-
 net/core/netdev-genl.c                             |  38 ++++++-
 tools/testing/selftests/drivers/net/hw/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   1 +
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  58 ++++++----
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 123 +++++++++++++++++++++
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    |  41 +++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  |  60 ++++++++--
 10 files changed, 314 insertions(+), 56 deletions(-)
---
base-commit: 6c80a1ec8984e01a4d92225ecaba66ab74063d2c
change-id: 20260313-scratch-bobbyeshleman-tcp-dm-netkit5-fb85f437568c

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


