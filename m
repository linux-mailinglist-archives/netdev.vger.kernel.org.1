Return-Path: <netdev+bounces-161542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A6A222E4
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95343166D59
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6811E25E8;
	Wed, 29 Jan 2025 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xa8qBN8l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9881E0DCA
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171489; cv=none; b=Ir8VdEjAZwhLgqZpmVgDqnTBQ6l2HQBFlG4o1fAUvRxY4PLhIuHhOVqSKizzSuctg87U8OVp3iqqtgFegoATID80o2pYASiiGlBc9W6lwj7FoSaLkmbveSvyh5X3BQblBfsQhPB9IPh4IFchcA10l8e4hFkKkLz9/jN4wKis/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171489; c=relaxed/simple;
	bh=N0YneRw92WXGIHdikNV2IiZfnjq0rTZVJ82U1x+yMTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3/Jo2ZFB2mJ6m96nASHTCBTlxbh1qhdF7PYwTmOilWb/qw1zNSFXL3qzxA2ZScByTzkzph3fZpxLQENrlJomN6mH9VnxY1Pf1PIQ5sJB0dQd9h/DjeSaWDdK6T52Nrd51mreGAcoZoy+KOuNRJJh+kJnx8QiwWZb3ee6B6Ta/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xa8qBN8l; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21670dce0a7so10770435ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 09:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738171483; x=1738776283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq4/gMpDYbPjuvYfh3I5NVoS6GqeADLR3UUjHmAsbcU=;
        b=xa8qBN8l2XoRvMYZwWZQJncjhJoLDsyLSgqNlpR+8hL6A3ivSynKS+K3QsamVnOjIO
         eDIduaBcHxNDObdNuWPYZNGjT/P8O8cJFJzKYyDzYrpdOzS38tggknJmNvH6RsGJ8S5D
         L37PcYrzG0S7e+Mve0XhvUosU3eVRqj3rfeVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171483; x=1738776283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aq4/gMpDYbPjuvYfh3I5NVoS6GqeADLR3UUjHmAsbcU=;
        b=bvetmLuARjI/YgwaP/kZeQMuUkE28P6Cqt58Tm5qQ0QuX2ICFTdjpDNWBTimp7jrWx
         0luhQnIKQ5rHPPmKjpgYOlRnFaLgDJdqd2hAU0kQdQ/84HuYZ9ox5J5qjVALXKyJ9vXH
         3ZgLEt9FSs90ViZke8uZrRhtcKBUdpfSlH+2SMcjm5GBg5Mu2CvCJlM68tIeqorQ3cI9
         SG9drjQXSGg1xfUwevVJUfLwuRcrZv+erT2P2OGg346+O1IAENYe6iWckxigagunYniz
         6iuk/PGdZcoshoq7tJ+6pwIIdLKAl/0FDhSX5DDC2gbXi1GSVLxQWO2jzliK7SA3RraT
         Iirg==
X-Gm-Message-State: AOJu0Yxrkn2Plu7Fvm19cZ9g/AKAGohdVdeiCgmaABRu1Xw/GQIZjZtq
	7E2J7IQ7q17JPpPEEaAYJ+cp87f0KX/AwnqibfIjgYYiDfMIVV2z7p7YZkI67MPofJRUVXIBXIm
	TmClLjov4ELz9m3kPmyC/eKivyJrS3JhWatnkwwkMkHEYB0XHAzDkA+jMZQUZYAJHY7waI64gJG
	cPDuVoHKSx3jV3Fq8J+SXvUafTUvn/TtddqVE=
X-Gm-Gg: ASbGncu3kyTyDZJGsxE1W/taJITv5yeYYTz0bVw4bRz+/rSmbJKg1hhPH1ry6tWVN2Z
	JiVurQrCu2Xkj8OSZjnqDOYhGH5UrGKpPdBtg/EO+KWIxj7g7URR+yoQTszJc40Wy/E8Pm6ti9t
	l+/iKhSw7KxxwBmE8UEqKPSpUF8WdabticqDvpSlc4h7bmgH6Vgjr8GVy2gQciGWykHA8jO3cF7
	1+oQYe3SPnOwwr1TvEUwjOLq+tMK7hzTDnG0XllQt1kQF2oN1cV1TyDFQMkR5e37mtFCEIGdMrh
	qh2oYpFrvKryG3SrOQXwzgQ=
X-Google-Smtp-Source: AGHT+IFTb6XDnBS6Kmn63C4xyF4rg4Vtlz0IPi7h1hNldfq2r+c1V0Jig8cb4HmfqwS/oFthayJOoA==
X-Received: by 2002:a17:902:d48a:b0:216:4064:53ad with SMTP id d9443c01a7336-21dd7de20f8mr69481155ad.48.1738171483392;
        Wed, 29 Jan 2025 09:24:43 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4bc5c1fsm101147295ad.82.2025.01.29.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:24:42 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC net-next 0/2] netdevgenl: Add an xsk attribute to queues
Date: Wed, 29 Jan 2025 17:24:23 +0000
Message-Id: <20250129172431.65773-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

But:

1. I couldn't pick a good "thing" to expose as "xsk", so I chose 0 or 1.
   Happy to take suggestions on what might be better to expose for the
   xsk queue attribute.

2. I create a silly C helper program to create an XDP socket in order to
   add a new test to queues.py. I'm not particularly good at python
   programming, so there's probably a better way to do this. Notably,
   python does not seem to have a socket.AF_XDP, so I needed the C
   helper to make a socket and bind it to a queue to perform the test.

Tested this on my mlx5 machine and the test seems to pass.

Happy to take any suggestions / feedback on this one; sorry in advance
if I missed many obvious better ways to do things.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/

Joe Damato (2):
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 10 ++-
 include/uapi/linux/netdev.h                   |  1 +
 net/core/netdev-genl.c                        |  6 ++
 tools/include/uapi/linux/netdev.h             |  1 +
 tools/testing/selftests/drivers/.gitignore    |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 32 ++++++-
 .../selftests/drivers/net/xdp_helper.c        | 90 +++++++++++++++++++
 8 files changed, 141 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: 0ad9617c78acbc71373fb341a6f75d4012b01d69
-- 
2.25.1


