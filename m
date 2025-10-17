Return-Path: <netdev+bounces-230291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D2BE6488
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C4719C4DF2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 04:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8CF2FFDDC;
	Fri, 17 Oct 2025 04:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBW8AnPz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAB1D5CE8
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675015; cv=none; b=obKV4U1TSGImm3LhblRWUApFrb9kFeUxPj9xPk2NdnuWXxSG3mnr7dlZvIWrsYQoa+QS3CjD+BHrbWzvNcDQscr5fY9XuLJbHoS4qjlGHUOcFAGF+HneYogIoatDnDiAVnXwSGd68h73DBrw903elxorUT6uP+J6uhDodmskjBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675015; c=relaxed/simple;
	bh=xlTdYn3ctaCUjwm/bvJufu9sD/yMlLPgVKinrC/dKzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DcUjrgwf5+fzBW6G8mAUs3y/Vd81BPEM2lRuLcPLh7FxGxs9OZj1er/ijxBpALGuku8dOkDeGDvgRMbYhQArIGJgcG6s2BiUloeQpQ9rA5ZVf1/FYeVHlrMWGGC5NfizPH1eat78TCwv9lBE5rmWSb10LYFUc0ms6IuVxTg+aEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBW8AnPz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33292adb180so1486525a91.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 21:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675012; x=1761279812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1LD4bJtaXgmuHvhblZcw2cHe5FWG+R07TopH1OUOIo=;
        b=NBW8AnPz+hbH4/HO5YOBRc3Yjnv1tWdFqSxgniJU1Dwvn1AcrNgTvEuo1eAYASIoQF
         GSpXsfWEf7YxtxiqLTAnVnVNy3dZS/7sl0jCrjl/cQvdE0Wjqx+tx0hIkvbOSPrE2OTu
         DRGQoxeLXDZbt8LM6VbT9JGtW0ygFoXBJCgNATbqbIL8OcIG/c+H8xwBXdv74kFV6SgA
         KJhvpKl1KdbyHWgqp1zUMCR19OSxQV40xsx22E+RKI8gPDa7J0aZ9MU46/RLuRtt9ZYC
         yqXhPpfo/8cQqzIZuTCpG4MzfS0X2ingfEp1TiWt7umxd6h0TWdIzNoa3gkLuL5OhS6k
         INbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675012; x=1761279812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1LD4bJtaXgmuHvhblZcw2cHe5FWG+R07TopH1OUOIo=;
        b=ncLW/p1qhEJMyL6wcUa3ZEumx7xoWLE8Qe9JDmXM2zAZuE60DOpnyEx0INQ3uhJaoA
         oLF453LHyJBrtC6KK8ZXPBshyL81lwAN3sYeVFJra1oPHWQ14Lnk5Fyw4Tc26+WfsT07
         Q/JgfwA4hh7K2WYzaiJpIeS4K9cfA8jbArER1LZSM6VM0nJCw5dOYbheuaBMtRqOLZ+m
         XuPmGgQ3uXflw3bxI1TXAhTifoPsWHop78xU9Dlu/4U/AA4Jm4sXK/z27V3xlb6yHz2o
         YAX6DmYC8tvK+qw95XFt6/KBcYmHhYy6OCKg8C+gYtgEdSuXwME9NlqANBaiDJV5IOpy
         E9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV9HXG1ImR0e1QZEF78O2mDEROIdtQhwbEmYnzv4+PDLT1WVImHS6qyMHfhimLaLqsXfRJ+824=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl3d25aIT6OWVVKBrIlP+F3DlDVU4TWQMu2RGf44sH8cj36dd/
	6FqkPOF9wiIvP7RjSvkDDYoSLgUOgdr44Fq79hn3BkVymlSm74PI5GBx
X-Gm-Gg: ASbGnctPl9vYzEann622zqE1orzP+qt7+r4YEeNz3vhiN4/xjv0tHXvFXWcA8QYgExH
	8LogRf81w80+EDSrz7oZM/Gt+ylfn21PHeXvhstrtV6CrTQfbBQJYjLaDRY4h1Bo26K2DFLBnCO
	ufi5vpPfU6wysJnCZXaOHWvZCrNI8c+1pdO8yfL0XWrGqaPzlWEzBpz39Jzi5gSr5kbUrWT3oXI
	oaE2coxsHv+VZCZLra0qLUnrcLiNDOQTJNLx39MjNG4IGOmzW8AQzPs9esiyeXVoxtbvqtRF2rz
	7+yVGnWCcTnq9hUMKPPBZhXgOi30xycyWMCZWV09xTgzpnmIfuXEB+bP1NoCinZafAd2XTB0bq8
	N+egyQTy8UMaO9H+ntAEjRCN5Q43+uYu9lBWH7dEuq+sHbAY65s47FIzORkjaNdHJo8FtuGUzHm
	SAsA/YLuBomzpogpgMjyLoYG7VhU/AkvARyLX88+EBgH/c3H+yf804fB0hl1FT/6nTRSpe4565u
	V9HJZp38Q==
X-Google-Smtp-Source: AGHT+IHf/fkMawdLEFWrxmlDZmQ5xGwA8hncSDzmuHZwevx77yhLGUBDFp3M4+pUOvAJ23AfWMIQvg==
X-Received: by 2002:a17:90b:4f:b0:335:28ee:eeaf with SMTP id 98e67ed59e1d1-33bcf8faabcmr2469604a91.29.1760675011886;
        Thu, 16 Oct 2025 21:23:31 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
Date: Fri, 17 Oct 2025 14:23:05 +1000
Message-ID: <20251017042312.1271322-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

The TLS 1.3 specification allows the TLS client or server to send a
KeyUpdate. This is generally used when the sequence is about to
overflow or after a certain amount of bytes have been encrypted.

The TLS spec doesn't mandate the conditions though, so a KeyUpdate
can be sent by the TLS client or server at any time. This includes
when running NVMe-OF over a TLS 1.3 connection.

As such Linux should be able to handle a KeyUpdate event, as the
other NVMe side could initiate a KeyUpdate.

Upcoming WD NVMe-TCP hardware controllers implement TLS support
and send KeyUpdate requests.

This series builds on top of the existing TLS EKEYEXPIRED work,
which already detects a KeyUpdate request. We can now pass that
information up to the NVMe layer (target and host) and then pass
it up to userspace.

Userspace (ktls-utils) will need to save the connection state
in the keyring during the initial handshake. The kernel then
provides the key serial back to userspace when handling a
KeyUpdate. Userspace can use this to restore the connection
information and then update the keys, this final process
is similar to the initial handshake.

This series depends on the recvmsg() kernel patch:
https://lore.kernel.org/linux-nvme/2cbe1350-0bf5-4487-be33-1d317cb73acf@suse.de/T/#mf56283228ae6c93e37dfbf1c0f6263910217cd80

ktls-utils (tlshd) userspace patches are available at:
https://lore.kernel.org/kernel-tls-handshake/CAKmqyKNpFhPtM8HAkgRMKQA8_N7AgoeqaSTe2=0spPnb+Oz2ng@mail.gmail.com/T/#mb277f5c998282666d0f41cc02f4abf516fcc4e9c

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

Based-on: 2cbe1350-0bf5-4487-be33-1d317cb73acf@suse.de

v4:
 - Don't stop the keep-alive timer
 - Remove any support for sending a KeyUpdate
 - Add tls_client_keyupdate_psk()' and 'tls_server_keyupdate_psk()'
 - Code cleanups
 - Change order of patches
v3:
 - Rebase on the recvmsg() workflow patch
 - Add debugfs support for the host
 - Don't cancel an ongoing request
 - Ensure a request is destructed on completion
v2:
 - Change "key-serial" to "session-id"
 - Fix reported build failures
 - Drop tls_clear_err() function
 - Stop keep alive timer during KeyUpdate
 - Drop handshake message decoding in the NVMe layer

Alistair Francis (7):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_sk_destruct_req
  net/handshake: Ensure the request is destructed on completion
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   2 +
 drivers/nvme/host/tcp.c                    | 150 ++++++++++++--
 drivers/nvme/target/tcp.c                  | 216 ++++++++++++++-------
 include/net/handshake.h                    |  12 +-
 include/uapi/linux/handshake.h             |  14 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/request.c                    |  18 ++
 net/handshake/tlshd.c                      |  96 ++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 11 files changed, 455 insertions(+), 86 deletions(-)

-- 
2.51.0


