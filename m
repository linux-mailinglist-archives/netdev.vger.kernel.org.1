Return-Path: <netdev+bounces-49578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7236B7F28B9
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5A2B20D2D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D843B29F;
	Tue, 21 Nov 2023 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdBxAV7T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674251FA7;
	Tue, 21 Nov 2023 09:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18901C433CA;
	Tue, 21 Nov 2023 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558599;
	bh=9PpdhyBVsu45ZCI81VGErhQfiGGxB/f1DEh5vaZ3fm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdBxAV7TZbxSuBj60zoJAneC4IgZRVvo2sHh/6D4pz5ADsXfKZA5QMskKPFDr2B21
	 oCKJ9/YwuqeOpqa83og/tUyjhUgQ9RgHZr3yuB7eG9hMig0QjfE0URzhU8WtjVkiVe
	 KZHyJz/eH3hNcqfJSyBj9Y8XnN6uvO1RpyhN9Eg4kRSbhA/pmUM4/sGe7KRGmtbogo
	 PmVVy5nHHmDbXaJgmjishZYFwYdirQmhuX1FArM1mQeLSOLt11wJV9VYxUlluFLwOk
	 JIZ+KunqutGepha4LK3HN10iz7yCPOb6IJqMDNheXVqW9IHM7Ei4CfHFetByJn0AOW
	 c1eoOhGTjT2gQ==
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
Subject: [PATCH 09/17] tty: hso: don't emit load/unload info to the log
Date: Tue, 21 Nov 2023 10:22:50 +0100
Message-ID: <20231121092258.9334-10-jirislaby@kernel.org>
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

It's preferred NOT to emit anything during the module load and unload
(in case the un/load was successful). So drop these prints from hso
along with global 'version'. It even contains no version after all.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/usb/hso.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 83b8452220ec..48450fe861ad 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -363,7 +363,6 @@ static int disable_net;
 /* driver info */
 static const char driver_name[] = "hso";
 static const char tty_filename[] = "ttyHS";
-static const char *version = __FILE__ ": " MOD_AUTHOR;
 /* the usb driver itself (registered in hso_init) */
 static struct usb_driver hso_driver;
 /* serial structures */
@@ -3231,9 +3230,6 @@ static int __init hso_init(void)
 	int i;
 	int result;
 
-	/* put it in the log */
-	pr_info("%s\n", version);
-
 	/* Initialise the serial table semaphore and table */
 	for (i = 0; i < HSO_SERIAL_TTY_MINORS; i++)
 		serial_table[i] = NULL;
@@ -3285,8 +3281,6 @@ static int __init hso_init(void)
 
 static void __exit hso_exit(void)
 {
-	pr_info("unloaded\n");
-
 	tty_unregister_driver(tty_drv);
 	/* deregister the usb driver */
 	usb_deregister(&hso_driver);
-- 
2.42.1


