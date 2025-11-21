Return-Path: <netdev+bounces-240595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B0C76BD2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8B3A357AC2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67262248AE;
	Fri, 21 Nov 2025 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eDBh1/5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4A1F09A3
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684454; cv=none; b=Fax5jOhJSkVkkls81CP38bX6+SmnMW2HzeUQYN+Js+SYLiDyuwP9sZjQX5ZAt7+f4zms8p1G4+LCX7Osz6IKvfyV7EW+zKyO0g9ChFZXYBKhxM3zxKpfSlS045TS1JK2ZIjXDE5E14D2ftngrYsN9+aL6oQrZ8Vx9/ISGCsZgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684454; c=relaxed/simple;
	bh=gkVr8IobuC68eHv3Z7VDv3KtRdI5x5m7j6A4Cq1f+Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YDxELL7OEKBGW7yLXQHCcbtNWJcr7LKhPHHHuZMXSKR3UhwESAQ9aTEO8vkbxHmw2VLm/CYJXgazWyd4xUolxxHwd9uaCsxxeg01Lnd0X4WWxp8oPotf6NyqRLDu0PPPokHpbF6u2RLMIaEVMHEof06LQu0jNoaxog+MSlJOYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eDBh1/5j; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso14256815e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684450; x=1764289250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZEcjIjXTcoCtcoHMKS6yM6dPDyzVSynlkUTK2L1Eyc=;
        b=eDBh1/5jVornOlC3bGDMlIKrSIzcThlN/n9FqHGMJ5nq9IQo7/b0VP2iqVWQuOiZzb
         zQQK64BXXrQDbMTkuIGzzU9mCs/mHYr49+kmPJB6MgMPxs+kGVw1jUG+tzAleMnB+Xjj
         YhMLkFwmdTV9WrVcv3TtIDpJAPweHU/vnMfVdLChr1f++jxjc3q8w8b5tURZl6kXTQRD
         RMCRll8P4urM7vwZzw7q/z6tGlosAgV6NokDfXGZO2lZm9QI4nkNaIH87WyMoG0K/pV0
         Y6Rg8qdsafQ8qHYfaRZ0BZl5/NzY+QPVwk5xSBuOOvs0551eLmApCoEnZlOfyiREJ6/T
         PiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684450; x=1764289250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZEcjIjXTcoCtcoHMKS6yM6dPDyzVSynlkUTK2L1Eyc=;
        b=R8csnalLr8hq7xqmiiQVMig6+7Gsqjr+IIBM8ihb83pnDXbB7eu89qqNSsv0Av8iXL
         0a9nCErPaViEcQyAwR9QT0kyhKmvsG3pdeSuDoJMN6/Ws2lnUozzf5CuF3m305kMWSqp
         qjEYluZ9uQwIYawEQOksTV8qEwMoOeC7bagRs/8qe8zXzDMCTFYf09F217sz7wLZS8p2
         u6OxRy6zTguOQG2gTUWMVv2VlokxX6iXfV9Y8fNNOlT/VNy7Dm5knT9ICf5J51IZs58n
         9LKgnOfKF5b+ABkKTALFEHxRVCgkok1J5sKMf6y8Uw+Yj+wxTtrYY14yj1eQr9TGmiTd
         2W3g==
X-Gm-Message-State: AOJu0YzQAcOXPgg/jNIBwEltSU7PoRS/tKMAqZHBzbb3aXvuoL9N2Rp0
	sDMYjYExaz8sipR1Cpr0pjU73+R0y2XGLWpbW+owxoMVYJxKFzcSsy3cg1cDAHvXzjqtorYK3EA
	55QpoDwbu5o9A8rc2BcmTNb25wcBnQf1rA6TZYtMXvhsx/fwTt6vdNQF/HaQiFqaKNQk=
X-Gm-Gg: ASbGnctuCpg+c/9bb1DiE8MMMfTgGiym5L4S4Wq0YoYQf2mG9bkTl2Emk1TARJHD4dT
	NolCvDpRIdlMHrTHfrsHOA8G0UGDOLIoIQ0NxZ02E2rZEQnOOSWFT7L7zMUacdzNtWwxB/E4uvg
	mag5A+pG2UJj3Srj4aeyjfBIrkJiSRZNPppnpIof18MwYLBvq/Pvsxerdo4/JYLDh2ATOyfWOpp
	xiM+BPtFZODVvoxZfhv4/g/B2Wt9gT11UJ0vT3LHv1xYBwjBdi93fNFq4gT+HjqOQzduPSfm7q2
	qgnRwcplU7gJ4mXjkOoeFPWyM5jzCk3r/qBHLGLPMx9w+KPA3JHw7CosN0Qslf1rU1Ur1an0H/E
	yvaEFC00BMijkiNzYXng8kC2GR96LA8ZjUCEa3EVa7G6lxZpysE//6v6I/f2k2EFH0iakAa1jIq
	DzMevhShUBrhwGJ7FpILiE0p8gdnAnsyQ3dFw=
X-Google-Smtp-Source: AGHT+IFUsYW7hYLEsGViwAV+3gSRUjYStxH02gAJMXNSlf/oVnRvsCZ+DsOFchdok41u9ZKOmJE2Wg==
X-Received: by 2002:a05:600c:5494:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-477c0184c3amr4926295e9.10.1763684450102;
        Thu, 20 Nov 2025 16:20:50 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:20:49 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: [RFC net-next 00/13] ovpn: new features + kselftests
Date: Fri, 21 Nov 2025 01:20:31 +0100
Message-ID: <20251121002044.16071-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear all,

This patchset is just a respin of my latest PR to net-next, including all
modifications requested by Jakub and Sabrina.

However, this time I am also adding patches targeting selftest/net/ovpn, as
they come in handy for testing the new features (originally I wanted
them to be a separate PR, but it doesn't indeed make a lot of sense).

This said, since these kselftest patches are quite invasive, I didn't
feel confident with sending them in a PR right away, but I rather wanted
some feedback from Sabrina and Shuah first, if possible.

So here we go.

Once I get some approval on this batch, I'll send then send them all
to net-next again as PRv2.


Thanks a lot!

Regards,


Antonio Quartulli (1):
  selftests: ovpn: allow compiling ovpn-cli.c with mbedtls3

Qingfang Deng (1):
  ovpn: pktid: use bitops.h API

Ralf Lici (10):
  selftests: ovpn: add notification parsing and matching
  ovpn: notify userspace on client float event
  ovpn: add support for asymmetric peer IDs
  selftests: ovpn: check asymmetric peer-id
  selftests: ovpn: add test for the FW mark feature
  ovpn: consolidate crypto allocations in one chunk
  ovpn: use bound device in UDP when available
  selftests: ovpn: add test for bound device
  ovpn: use bound address in UDP when available
  selftests: ovpn: add test for bound address

Sabrina Dubroca (1):
  ovpn: use correct array size to parse nested attributes in
    ovpn_nl_key_swap_doit

 Documentation/netlink/specs/ovpn.yaml         |  23 +-
 drivers/net/ovpn/crypto_aead.c                | 162 +++++++---
 drivers/net/ovpn/io.c                         |   8 +-
 drivers/net/ovpn/netlink-gen.c                |  13 +-
 drivers/net/ovpn/netlink-gen.h                |   6 +-
 drivers/net/ovpn/netlink.c                    |  98 +++++-
 drivers/net/ovpn/netlink.h                    |   2 +
 drivers/net/ovpn/peer.c                       |   6 +
 drivers/net/ovpn/peer.h                       |   4 +-
 drivers/net/ovpn/pktid.c                      |  11 +-
 drivers/net/ovpn/pktid.h                      |   2 +-
 drivers/net/ovpn/skb.h                        |  13 +-
 drivers/net/ovpn/udp.c                        |  10 +-
 include/uapi/linux/ovpn.h                     |   2 +
 tools/testing/selftests/net/ovpn/Makefile     |  17 +-
 .../selftests/net/ovpn/check_requirements.py  |  37 +++
 tools/testing/selftests/net/ovpn/common.sh    |  60 +++-
 tools/testing/selftests/net/ovpn/data64.key   |   6 +-
 .../selftests/net/ovpn/json/peer0-float.json  |   9 +
 .../selftests/net/ovpn/json/peer0.json        |   6 +
 .../selftests/net/ovpn/json/peer1-float.json  |   1 +
 .../selftests/net/ovpn/json/peer1.json        |   1 +
 .../selftests/net/ovpn/json/peer2-float.json  |   1 +
 .../selftests/net/ovpn/json/peer2.json        |   1 +
 .../selftests/net/ovpn/json/peer3-float.json  |   1 +
 .../selftests/net/ovpn/json/peer3.json        |   1 +
 .../selftests/net/ovpn/json/peer4-float.json  |   1 +
 .../selftests/net/ovpn/json/peer4.json        |   1 +
 .../selftests/net/ovpn/json/peer5-float.json  |   1 +
 .../selftests/net/ovpn/json/peer5.json        |   1 +
 .../selftests/net/ovpn/json/peer6-float.json  |   1 +
 .../selftests/net/ovpn/json/peer6.json        |   1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 281 +++++++++++-------
 .../selftests/net/ovpn/requirements.txt       |   1 +
 .../testing/selftests/net/ovpn/tcp_peers.txt  |  11 +-
 .../selftests/net/ovpn/test-bind-addr.sh      |  10 +
 tools/testing/selftests/net/ovpn/test-bind.sh | 117 ++++++++
 .../selftests/net/ovpn/test-close-socket.sh   |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh |  81 +++++
 tools/testing/selftests/net/ovpn/test.sh      |  57 +++-
 .../testing/selftests/net/ovpn/udp_peers.txt  |  12 +-
 41 files changed, 855 insertions(+), 224 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/check_requirements.py
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer1-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer1.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer2-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer2.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer3-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer3.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer4-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer4.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer5-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer5.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer6-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer6.json
 create mode 120000 tools/testing/selftests/net/ovpn/requirements.txt
 create mode 100755 tools/testing/selftests/net/ovpn/test-bind-addr.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-bind.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-mark.sh

-- 
2.51.2


