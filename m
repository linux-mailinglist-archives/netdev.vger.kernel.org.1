Return-Path: <netdev+bounces-243128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B29C99C36
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 02:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CED44E195E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 01:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB691A262A;
	Tue,  2 Dec 2025 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNm7M0ne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA77156C6A
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639307; cv=none; b=nz8WoLwKOaC5S+0p6Dh6GJZwcQeTEWgrgjSf4b2oBIQFI4vtuYZzYeLx/lv6JBsLz0H0LqhG/Vya/qtxUPFwzFsX+e8SocotjhCmluLVUb/5zptNwFqNRRoVfmgx8tjhiSez9E6Cn9XYvydcGO3G0T9JLPajQ9K2sfGOtsBh9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639307; c=relaxed/simple;
	bh=QFsXnu9MdkgXAqXQJzYkeKJGZVvnPkPJKQ+sI7t/4I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWYE16ffG8CNpPoEMba9Cc3Ws6RRRgDy62uyPgqw4jV+MtGDqjKhLjl0OuFsV5/QbXP+b/eEWF4kjMhstfboMvlPSp5q3M72Nam9D5LfRR2x0Ugr2+GYzxtFa1Qxp8HdEFGJd6QnKoGxYozO5p6DcGofO3IeWlfvlP61O67cEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNm7M0ne; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2980d9b7df5so58216075ad.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 17:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764639305; x=1765244105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOcMvyPGMcTIjq6QNdUg0HCwNMNqed1s4YiNfKDSxyU=;
        b=MNm7M0neogagbWEb9t3E8tC0TkiUBn9ClSehkcOYyRaomF1/0HIQtSnvkYvp4bJPRP
         nmWqcgins+RYRztvK/P2wBHeXL8wujMPZUBaXeJ928zv5PexA41gJB/SshUfdCCLol/R
         6/LDu+NsY2AIoTmBNIDO0OtZffc6KzMWDPsk0tV4zPP/btPKXOLvrTYF0q9QRR7+e00u
         3O59w6uReXv3/NDcqSJr9ew68iilt63HAU9NcxIOyXezQHilxRk5RZadbLiPz47HTGss
         LFZlhviN55eXKm3xo65Ohv8uLlFdop1297goJNn40INoLmrQcA8q9m3bUhtA4Cb6w5tn
         V0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639305; x=1765244105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOcMvyPGMcTIjq6QNdUg0HCwNMNqed1s4YiNfKDSxyU=;
        b=pH5ZmiZbeBYNSkii9WEqWaKMN4RCc8upMTbgkj1Byqi9dRui8pZC1ZYvp4N0rrKtbZ
         EUmh9+aBU241jSfIdsn2k/3tvUI16tUx8WRciX57QhzMcTQfCoTu3LEXPCY6N2Ud+/dK
         lmcv5o4xSQg2Sb0zl1ZN8QTr/kyOU7gtWlOpPcBcaJFC9hEAUZM2FaIC9W6t7SU1Ld2d
         aZ8rVDTcubo/b8uydQENpODXIUbsx3ovboxpvnhlaaO3+ZF/751nr4arl06ArtPMB4aS
         ok0ca8zFluqm3TIguG9hL0hRZ/JG07jmDuP2gnR05OG8aXsBK9K4xMwJ6Iv9gnM58U6p
         Tnjw==
X-Forwarded-Encrypted: i=1; AJvYcCUQAVpgRwpJ+F/hHtovYHrBftopYdXJa6aJIDnCXa81+tI5P/OiN2EZhy8eGv4CdAepFb7F4hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBOuSyMY5tuOpIzt0dysV8cg1fRnDhqi/jJyczRR3aQeaJWYL
	CnYevXRJsK3tb6gqGyyLv2MAIWxDmXiOux0ov+1N4aYWmrWe9cj+xRzC
X-Gm-Gg: ASbGnctQjt4lLiT2xYzGzRB2YUhH8cPVi3EtAe11hUJff27kHOtuzsIN5VtKM7wa0RD
	9RPKewOmkpiVbXl4P8RD+dsf4cFHy6FETotRNNtbW6rLgmRPOohNMyX9id2gGMyKzwGCWhgqNvN
	+BqRox6IPEAltZRgy1koflBEVkXp93b3XY+ve+vrAkB3HR0nGff62lP5JIE2NUdRowsB4uOfroN
	39iYdadpeFU56LaiC5xvxNEBLTyMg8u7cUrzXK4lPAMBP1hKhrvpPgt5Um4twvnB9ViAPKMpYVo
	pl8DD+I+wjyBxLDo5psa0xiXlE7f5wP1zkN1zHvvi3hFegnTT9Kyrz3S6z+Jez7GmwE11ZWm4Np
	1YE58TLhglhS2pfuBtYTlRafy1I8mrRz+NSsT/51IucTi38N3Veo00f1s4k2Wa9J5xW3pIG5zLD
	zcXx0JWTyDDTF+vQnsZ3Gwu6qcJ93Uo6RNS+kV0lmeSdgsHkOhFzptT78ZtSI1V02JSPlqpyh/g
	ALb6Saw7vZV0cYz3Sw=
X-Google-Smtp-Source: AGHT+IG2js8otbv+uQSAe0fNFhmo5Bp5ciBaRf9d70pDhultX+GW+649FyeVTJlTc0iOHCrbLvVJdQ==
X-Received: by 2002:a17:903:19c6:b0:271:479d:3de2 with SMTP id d9443c01a7336-29b6beac7fbmr426147885ad.13.1764639305257;
        Mon, 01 Dec 2025 17:35:05 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54563sm132378575ad.89.2025.12.01.17.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:35:04 -0800 (PST)
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
Subject: [PATCH v6 0/5] nvme-tcp: Support receiving KeyUpdate requests
Date: Tue,  2 Dec 2025 11:34:24 +1000
Message-ID: <20251202013429.1199659-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
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

v6:
 - Don't free handshake request on completion (handshake_sk_destruct_req())
 - Add handshake_req_keyupdate() which reuses existing handshake request
   for a KeyUpdate
 - Other small improvements and tidyups
v5:
 - Cleanup code flow for nvme-tcp
 - When using recvmsg in the host code first check for MSG_CTRUNC
   in the msg_flags returned from recvmsg() and use that to determine
   if it's a control message
 - Drop clientkeyupdaterequest and serverkeyupdaterequest
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

Alistair Francis (5):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_req_keyupdate
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   1 +
 drivers/nvme/host/tcp.c                    | 111 ++++++++---
 drivers/nvme/target/tcp.c                  | 213 ++++++++++++++-------
 include/net/handshake.h                    |  11 +-
 include/uapi/linux/handshake.h             |  12 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/handshake.h                  |   2 +
 net/handshake/request.c                    |  95 +++++++++
 net/handshake/tlshd.c                      |  97 +++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 12 files changed, 480 insertions(+), 95 deletions(-)

-- 
2.51.1


