Return-Path: <netdev+bounces-169060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD99DA4267B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF719C122F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C1254856;
	Mon, 24 Feb 2025 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5E9qslO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76CD14A627;
	Mon, 24 Feb 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411041; cv=none; b=ZM8Elg8nAyX7sjW4tIF8KWszuooH5cttQ32+SiKLgS0C+Oh5ETidgz2RY9/YdGaYweYxpticYuZJLguqcU0UMCGWTISwXJlrWt2u14TpjLWyyDfHpPRx0S4oQ9BE5ePa3QIAb7m7NV5n+e5R7UoKhhXXdUTWchhIiJvaNBrvVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411041; c=relaxed/simple;
	bh=9GsHZ0uWFGERQSLMdeBUy4lnnkfD5bg12vUs6N4mbcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sjglHfaSH/MLYEX/E8fS8aNNLNH0lDKAOHnv8BcOhpif57XYirHEux0ho+JCYNzJNaEiMaIlqtet7zyDoiuJ30uiY7IFUshJGOP6kTy5MJ5dV+244w8dyxdhvxosD9qMEg01lHIeU0kO/0AoU1oHV+/8GDBIiqWF+uGRbL3c2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5E9qslO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc0d44a876so7307302a91.3;
        Mon, 24 Feb 2025 07:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740411039; x=1741015839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WhmASDOQInyvXr70wajSDlxu87HIS0H9xeXcz6t5iMo=;
        b=Q5E9qslO+OTDnNCE+L7o9Ca9QqBDO59URGGhjKHjq48rFlHL6zhZ/ip3EM5BNyiXiW
         W7MDxysRmIga1NgImilEi5vJq8ItDQyKIycH/d5ywrATMTukFAsnWE+F35jmanCtJZpu
         dLpgbpRIJPG4cX8wVWmOcrhxT/LNMnOTtzkXsjSXpeTxBQ1svTN+fN2MKYabLESwcsS2
         eyW9ApHvnH8gGOIUgMuv4u0tsDq4RAuzUkVngMsVEpPRVY2jluwiKJGXZRoJhtqZNgRG
         o0fnAqwMn/uIDpR/PFL5P//vIi6FwCkW2GsS4iV2nN7Z2kJqg2V3Vq2jC7gVT/fzeKLs
         EF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740411039; x=1741015839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhmASDOQInyvXr70wajSDlxu87HIS0H9xeXcz6t5iMo=;
        b=jHRpfB4Kqz/4Skg17nYM3Oad0dQMJG+idMoXrg+kJezcRw6gFmMu7M02Bgsg1Zekhh
         IYVDFhAdTaayHJ0eZ5UPaFRA3h5eRH+gX74prE4Fg7qBWdrrhOEhzpk5K9bFLbaJpyh7
         s8eRvoBB2Xd3XHxy5+7ecg9vufvdI0TuxJ3rlQKzquoNb7bSRCz0cAJf9SxVlGBBSOww
         SE23VxQo6IhXcnz7SzIpE5Q97LZCQsItBSY3ephywuH989XSW05F+g6+JHGx4BZBrQP/
         vKM9E7a+JDxAZaO4RM1r561FzKC84AXDEIjuGZP8FPOyHd+MYC2TmzNJMauXUBVjVqE3
         5tCg==
X-Forwarded-Encrypted: i=1; AJvYcCU7wqvxOuo79vLniQ0datzjCBWEwGJ1CdGjncN0MgC7kJGiNs8OdeXpa3q6BCFGzQXImQ7Qwo1Z@vger.kernel.org, AJvYcCWH6XXyeFX9ys6YH5UuCPtF6rWb48L/WEdV9EIXFMgs3XTUVizsB9xAMJ+CkmNHIQxGGd+nh3JHltOV5mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKERNmpWacUUww7LQwQRieEHQ8zhv/AOisD4XMZCxYUrbMCsxa
	rXlnH0V9kPnjndGptXgNpV/om17Se+LKnru+wYrmOkvp3+l4fhwNRpIY7X2v
X-Gm-Gg: ASbGnct6PXsJUwhwlXVj+qBryqZ8w3wHWPFODMY02mr2P+GqgnOk0cs1xOMvFXEY0mX
	nR68AjEDf6OhzG9c+Pt5xppjWblBRoEp/3iuCJ42AdSmQTXci7bbhJc63a/4WKwhbti31bhyz0c
	NXA+z4BL24Hgy9eem8z++9kdkl+TtSzOS4+zabi6DW4jMyVefmyBdXT3eGqDXiVIKx3e4kxRZUt
	+oUQEx+4bODNp9vmJ7Yq+9PHrKK/wvsIPYS8XII9N6fQ3RtVr9DQ/xoKGP5X9T4xkFRVBKYBgYO
	SVbwHcylrv0qKGZTCtTyxL/ImWyagYJR/XZTO0nDisG+SlSIxt9mpu0iZ4aiIUZ06bMG6VobPOi
	tVgSNOXYL
X-Google-Smtp-Source: AGHT+IHDtb5JrFiaPGMhffUhvx3dhN8y94hLjdsSH4uZOiIHwdMeD6rXeQmlcXEAz/gxx1PdC1W2cw==
X-Received: by 2002:a17:90b:48cb:b0:2ee:e961:303d with SMTP id 98e67ed59e1d1-2fce7b4b904mr22754862a91.35.1740411037786;
        Mon, 24 Feb 2025 07:30:37 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-194-76.dynamic-ip.hinet.net. [220.143.194.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb04e525sm6592432a91.20.2025.02.24.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:30:37 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] af_unix: Fix memory leak in unix_dgram_sendmsg()
Date: Mon, 24 Feb 2025 23:28:46 +0800
Message-Id: <20250224152846.13650-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

After running the 'sendmsg02' program of Linux Test Project (LTP),
kmemleak reports the following memory leak:

  # cat /sys/kernel/debug/kmemleak
  unreferenced object 0xffff888243866800 (size 2048):
    comm "sendmsg02", pid 67, jiffies 4294903166
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 5e 00 00 00 00 00 00 00  ........^.......
      01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
    backtrace (crc 7e96a3f2):
      kmemleak_alloc+0x56/0x90
      kmem_cache_alloc_noprof+0x209/0x450
      sk_prot_alloc.constprop.0+0x60/0x160
      sk_alloc+0x32/0xc0
      unix_create1+0x67/0x2b0
      unix_create+0x47/0xa0
      __sock_create+0x12e/0x200
      __sys_socket+0x6d/0x100
      __x64_sys_socket+0x1b/0x30
      x64_sys_call+0x7e1/0x2140
      do_syscall_64+0x54/0x110
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

Commit 689c398885cc ("af_unix: Defer sock_put() to clean up path in
unix_dgram_sendmsg().") defers sock_put() in the error handling path.
However, it fails to account for the condition 'msg->msg_namelen != 0',
resulting in a memory leak when the code jumps to the 'lookup' label.

Fix issue by calling sock_put() if 'msg->msg_namelen != 0' is met.

Fixes: 689c398885cc ("af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 net/unix/af_unix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 34945de1fb1f..cf37a1f92831 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2100,6 +2100,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (!msg->msg_namelen) {
 			err = -ECONNRESET;
 			goto out_sock_put;
+		} else {
+			sock_put(other);
 		}
 
 		goto lookup;
-- 
2.34.1


