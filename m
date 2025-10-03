Return-Path: <netdev+bounces-227710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E55EBB5E69
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 06:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEEA34E1174
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 04:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679719E96D;
	Fri,  3 Oct 2025 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYpGAH/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E891E4AE
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465928; cv=none; b=AIJ1PF9fz0mi44shIClp6NDmrqL8isJngv0KpHETTu3m2xv6r277Wxc6K22xSrqmg/Z7DStcv5sXl41FETNr8jvWqBpBm7ZPRtxJElfvxbecEprWqokOYwikf/ScHN22yUvW+a2J2MB1lfdSGvjQJVaNLEV0go/SivRHJhVoWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465928; c=relaxed/simple;
	bh=30M2SYEXKiw8WZzmkL6ySmGYOxUGhfy4zZB7sDxdVWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IiKwulQy4PjYvnmsEcUnTClZgp9vqR14vnaJIb7tKZ6shbit80cxAB7VO+PRNuBAbdQWSNeczSusF72NcGD2CdcNTG0osK/Nib+BcEmIOUaalZrvolBG+hfzY/x0nNYMTnW+c5MHDy1ACiODnvLG+x9ILuaNmxAuW7wdbXQ4omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYpGAH/S; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so1403291a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465926; x=1760070726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6iRWbJphARTg9SH+UGYwTi095jj0E6vFAKoyN/er2gY=;
        b=iYpGAH/SFZ8QkF20ILCrWlpLWt6sbMpb2k6O6T84bvuQJVr++t8eaFw1mLUloM4dNJ
         UB4jXec8ikitL7+SYkaM+REusJ9c70Amel/qFZejZFDG4A0XXpI8xpLnjumhnAZkEzsQ
         9ecj15rKKNfAwQ2QwQDb3DroX5VYqh/GgF72bDjXrrJcadRXb8djNo+8gQChn+9lZ5hd
         DoqFCHOGpSYnb+3ilKVXc36F0UaY7lsjmTzOISGuJ7EVWS7aI569CIaOSCMCaKscim0i
         k4WUIUtFBH8pDeZBAcM65RTY7F1BmCP1XZ+21pUuUPuB+UD+ere8QEfP7LAMLFgDSvU2
         /i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465926; x=1760070726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iRWbJphARTg9SH+UGYwTi095jj0E6vFAKoyN/er2gY=;
        b=s+8vgzsoSxtFbqFTR1u9bsJsF6JZQ+/WUpJV2aPC70p6smLes4bpDgKIltVXIx9nI7
         9U+QQ2bJcgGpDur3jX09MhwTslDOl7HFhwrdzAv/WGObrDFP0Ohjj1dwQNQT4+h4UV9j
         2B0VtJFZc/dqKjAw6460Fr5wx0mtiOllzEJR3kBiq6zDKwZ/a0i74fEtygoNOtka7G83
         cakuyuaBVknDPyiMWUzwnE8XA/QoAJnQ9iyQYoGe4pn4XjVko8FlTE8UDmwgz4h7JE3H
         brihw8mn7yBUkwUSungdY3K/O9tqjU2xIADsz+/yEqwrF1uwSvu2gZ/1tj2RXgaKhPu7
         U26g==
X-Forwarded-Encrypted: i=1; AJvYcCXtl+C4Uozg811vS5wxp0IU8nv2EQ+P9e+6tToA/XClANrM8bDr9wDl4AqNxXH2ci00wEYVRcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaiIHXTp5YP0fpKn3ysWFcnfLoqq9vJDJmaJooO8uQfBcyBd6U
	Jfqq5jXIX987doBAMrrJk+ede81BSwkXTPydAzaBIncJc6TU/jNWuOTo
X-Gm-Gg: ASbGncs6JrRGnEsPDTFQbwPibPHurUmQoyk8CwflBnLCxfVXBssL9DKmcPFFOitsntU
	4iFHxacbDTOUwU20fwu33w6RpeMp93ty+UYffOBZ55vFmF8vjFsvwDi7T/lY7yO6ToIo+k+TSEr
	P3UVNQjPm4h/sZSOScbrOcXaxuNzezOb5Ht2ju5krjPKEm5XUYjFNFgJ0FDqzHBeD55bchwmbxk
	alcXCHn4pFhFHmkaZirODXzX4GUlWFVjkG94i510nX/vi9jDizhxjlM8BRPANSJYLT9iic6v0Qj
	0Hx5KFVlqdFfIzWj5xadi9GVu2wzkrRGSqJ6D/qEGVk99Jm4n76IzlRaMQDzFmx0wCLl0Cx8utV
	Fy5C82tpQaLrHD4DVZpO8TOzqV0eEpHMln58V7XuXL1tyitVQ9qOYeYjsk+pc/BLrsD2DKUxLct
	SdS9R0gjJzvNwr+Zly2jm87U48fp7oRZgWxOI/MBdcqkuO5jfpIT8D
X-Google-Smtp-Source: AGHT+IHzxGQNHei00u1+ginjgv2orHJOxfjQE4QOoj8gcgp7Hp+3jzZDnna3Wuw+xDdTBAA6cpxSvw==
X-Received: by 2002:a17:90b:394d:b0:32d:fd14:600b with SMTP id 98e67ed59e1d1-339b5092b52mr7933152a91.7.1759465925666;
        Thu, 02 Oct 2025 21:32:05 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:05 -0700 (PDT)
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
Subject: [PATCH v3 0/8] nvme-tcp: Support receiving KeyUpdate requests
Date: Fri,  3 Oct 2025 14:31:31 +1000
Message-ID: <20251003043140.1341958-1-alistair.francis@wdc.com>
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

Alistair Francis (8):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_sk_destruct_req
  net/handshake: Ensure the request is destructed on completion
  nvmet: Expose nvmet_stop_keep_alive_timer publically
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate
  nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs

 Documentation/netlink/specs/handshake.yaml |  20 ++-
 Documentation/networking/tls-handshake.rst |   6 +-
 drivers/nvme/host/tcp.c                    | 147 +++++++++++++++++++--
 drivers/nvme/target/core.c                 |   1 +
 drivers/nvme/target/tcp.c                  | 104 +++++++++++++--
 include/net/handshake.h                    |  14 +-
 include/uapi/linux/handshake.h             |  14 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/request.c                    |  18 +++
 net/handshake/tlshd.c                      |  47 ++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 12 files changed, 349 insertions(+), 35 deletions(-)

-- 
2.51.0


