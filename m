Return-Path: <netdev+bounces-39106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA30D7BE140
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711C52816CC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D1B341AC;
	Mon,  9 Oct 2023 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUT2ZZjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78F341A4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CECC433C8;
	Mon,  9 Oct 2023 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696859314;
	bh=+HSuQE4uwcv/S7v9Nu+yPUKMpHFCIut7bedSD0CoE+8=;
	h=From:To:Cc:Subject:Date:From;
	b=tUT2ZZjjoyKrHy9spdRqLkKumZ59dlMndP1ekBAykHym+I9g1k39CRcqUXSeoVTqo
	 Z3xuUbY7mXsnOwgIi7yBQdMycUPRHFK35wzu94NkC9wXqe/ov4uMJ3UABP+2vXkI9y
	 UgteuuzSZhHsyo0DlcXKeFIzGGvj/2vjsvHXPD0PwUMqWZvXMU8qPTz9T5yoCbeEDu
	 R1dUaGDrRW5kAPCebPaeAyyc3t1SX9N6IF0/VFFSi5q/r7GjWPMHOv9zDuGbTtPEas
	 H4u/mTKT2CY5C6k5UY61G0i73TUhMGHtV5AmPgywk6CReOKL866HVwmyoAJWy+ZG2L
	 S4CgJoKX+MF3A==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Lee, Chun-Yi" <jlee@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	Lee@web.codeaurora.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Date: Mon,  9 Oct 2023 15:48:19 +0200
Message-Id: <20231009134826.1063869-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

These functions are simple wrappers around memcmp() and memcpy(), which
contain compile-time checks for buffer overflow. Something in gcc-13 and
likely other versions makes this trigger a warning when the functions
are not inlined and the compiler misunderstands the buffer length:

In file included from net/bluetooth/hci_event.c:32:
In function 'bacmp',
    inlined from 'hci_conn_request_evt' at net/bluetooth/hci_event.c:3276:7:
include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
  364 |         return memcmp(ba1, ba2, sizeof(bdaddr_t));
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the __always_inline annotation to ensure that the helpers are
correctly checked. This has no effect on the actual correctness
of the code, but avoids the warning. Since the patch that introduced
the warning is marked for stable backports, this one should also
go that way to avoid introducing build regressions.

Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
Cc: Kees Cook <keescook@chromium.org>
Cc: Lee, Chun-Yi <jlee@suse.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/bluetooth/bluetooth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7ffa8c192c3f2..27ee1bf51c235 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -359,11 +359,11 @@ static inline bool bdaddr_type_is_le(u8 type)
 #define BDADDR_NONE (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}})
 
 /* Copy, swap, convert BD Address */
-static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
+static __always_inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
 {
 	return memcmp(ba1, ba2, sizeof(bdaddr_t));
 }
-static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
+static __always_inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
 {
 	memcpy(dst, src, sizeof(bdaddr_t));
 }
-- 
2.39.2


