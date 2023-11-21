Return-Path: <netdev+bounces-49579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BCD7F28BF
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67731C212D2
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A5038FB1;
	Tue, 21 Nov 2023 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joL4lNee"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130213B7B7;
	Tue, 21 Nov 2023 09:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE8C433CD;
	Tue, 21 Nov 2023 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558601;
	bh=J9+0GAdeqi0Ihu8k/yKWMGuJLA+L/8D5q4AyXvnWFUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joL4lNeeXdT8sgymVjfPxJdGEgdmJMXdx1lxwxLRpzs9JPGNAmnht0AnabfVbu479
	 1k/dvSQKu37gIQKySa8+yCQv4AO5mmQhV5b4sb6aSxTgWlDMoJwGSUUwUU1dN/kVGe
	 wrRTKvMy8ZwK2sDFLF7bdedr8jBGVSU5t/USoo+hTzaDcVOraZJ2mSPXKio9X6Ksbz
	 M/5DphpvnwANBpsAoI3OZoTNVz1kbiPX/Apb+tQP+cTpipXiCpTySfnOeAmTIc5qAE
	 FOrggxWRY9i/kzp+EHW6TuOWdKfcWDxeQlgaKpBpfiERpVNGqxt+liG/CtpuSLRrq5
	 FRaTfyApDjMVQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 10/17] tty: hso: don't initialize global serial_table
Date: Tue, 21 Nov 2023 10:22:51 +0100
Message-ID: <20231121092258.9334-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'serial_table' is global, so there is no need to initialize it to NULLs
at the module load. Drop this unneeded for loop.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/usb/hso.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 48450fe861ad..f088ea2ba6f3 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -3227,13 +3227,8 @@ static struct usb_driver hso_driver = {
 
 static int __init hso_init(void)
 {
-	int i;
 	int result;
 
-	/* Initialise the serial table semaphore and table */
-	for (i = 0; i < HSO_SERIAL_TTY_MINORS; i++)
-		serial_table[i] = NULL;
-
 	/* allocate our driver using the proper amount of supported minors */
 	tty_drv = tty_alloc_driver(HSO_SERIAL_TTY_MINORS, TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV);
-- 
2.42.1


