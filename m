Return-Path: <netdev+bounces-231959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5212FBFEF6D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 04:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 724814E1613
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 02:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B321D3E4;
	Thu, 23 Oct 2025 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OozcGfgb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0C2AE99
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761188125; cv=none; b=NWxclao4PyZkDvRXL03MrVGVpRobka6PVsTTi8ybxdM1uGMnb8H23vvIeRLQp7dzvgw2n8mhgjcmviQeNWRGta5MENetJxNH/J8oJunxfGdWa9Ih2FfH8bdSddM6IYAJztDBhofKTQ4wKRWZQKlWb8AOgK8fjqnHToU/Kz0sung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761188125; c=relaxed/simple;
	bh=RTUk2WSlE0halvN9moYsr3H7Bj2oinnqonBwfh8+6Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXVB8HfRdDu4vPtdrvbxsyrd+U35sJLYUXizHIzXOwpF1KBUNzqWTOMISWOJMh7qTwXltd94fau1yu54vF57UsDt6F/Kt34dY9/r7YKQ0JhYcMWCdFMA3HI/9/4iE/aDk7H5MV2JK/4DlNSsdF8Zs5TCkYT9qHc9AeuQXDqoRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OozcGfgb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7811a02316bso238421b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761188123; x=1761792923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7a6TkCx3t9Jt6uhfJfOsOowa2UNIpvCOCiP3SP22cv8=;
        b=OozcGfgbZ/akCWzE3KuQNjePE2bGA67nHohMB6jf1IwuZIfFHXj6kzgpa5vCCzlj/K
         OcCo9Pf+4BJLkiEcloalfeDrJqCCt43FpuJRrodT073aXGVC5ymlcEcufxrZVHyUnTtY
         BJ+hbxcChUzuIvmkZRFoBTaj7gc4tIRNFu8C5MFkdIVou6LpbUwpT88gM9lanVt2VfBO
         qbR3N0+uAbn0g3PLKGBG2/0YUsYUMfXoCAWqEveX2uKahNpi2x/iJ7zguiKzgq0aRqF8
         K6PnKhBG2PuGH16LtSCW6IUnUIgn90FVv3Nj0tYhhGKjXtJHjqBZG5RCABia9YeUGA/p
         nOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761188123; x=1761792923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7a6TkCx3t9Jt6uhfJfOsOowa2UNIpvCOCiP3SP22cv8=;
        b=D+13E1AtnP02XZfX+43O/ckOtrjJhbccPdX7ZAmkmcpPUdBn1YIuN1mVytDagkcMRe
         0UyrBkhtxmqIThlB9NWS4fRbmmJZUNpkFZsFSvvQuPrl1ZUnl0S4WE0uMy7huDjlx8dx
         GkKn0NeFdQ/7C/NSveB8770J8aCStkFr3hX1PpKjN3sT5LzA5grYrreoCmC+yOreLUIT
         jiIkkSxg7yGdu/O8X4Z2VXFraTtYQM2yqtZ6yKGmrV0UYw7OrYKDKg9PsitvCBUCtqUi
         D2NvJO2AGhb6CmlEZch0S0jtmQmGcp6pI0dL9EKh/nDhHy2yvRzqwA0M75ZQgsQTW1oG
         1rtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEOrO6zf+2nWsz5UOeAE3aFZ3d3KpO8AYCgk0lpTY26J8XcxJoNrsmXF8Y04sk7QQg4nXibW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwx/Kb51/U8ZdLFdqMqJUFbSpRhyeWmjcn6yHKnar/e6LpqWy4
	HxwnrgRqvaIqM72AeWEEYrbEd0+pkpTEmNKUDb9775A9PJfJSh9ISJDR
X-Gm-Gg: ASbGnctbAh6ALsT4imqqZI6uZ7WBsxxo+cAlYMFN8Y0t9Nx0ZAYGbLOm24hw0+x2Js1
	sgEnCXUvsXnvef9CZNeijibmAWp6F9lmnCKJmP62QiXnsFCQQ/ifbDu6S1B1rlpG4aFFzCfa+eI
	d12W0dwrAS/IRyS+JTjvimtKitXf3ialKkIEfOP0uyLnXI2Vok+DTf9vstiIrRLJoD2+ieyuzWW
	MigEAmj/Xg9GdSBBSeEsGyKj+me1vpuzy9/jCV59epeV/91tW6JqGIPcjMBx8c8bkP4GimmHyWu
	v3qUiMBaAGVun2drTy/jSxicaTMQVy4teRmhren0UYYXINmz8zR90crljIl2KqNXXpDduLMvpbX
	yKZFeWUwNFliHArwC8MZqyGWCMol7/M6B+xRdESrBSSj9VTxVUlyU3hfoTzw2Fwz1qSe0iFVfmF
	1+CXE=
X-Google-Smtp-Source: AGHT+IEOQiYULCLq6q4ZVfIhojbHQnwTfEVVcHH2POX69CUfxseKjeD0bXzVVcovqZOKoBJphJtWfQ==
X-Received: by 2002:a05:6a20:28a5:b0:334:a99f:6b83 with SMTP id adf61e73a8af0-334a99f6ed6mr21844436637.2.1761188122652;
        Wed, 22 Oct 2025 19:55:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c4d83dsm558850a12.18.2025.10.22.19.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 19:55:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7A94D41E88E1; Thu, 23 Oct 2025 09:55:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Avery Pennarun <apenwarr@worldvisions.ca>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v2] Documentation: ARCnet: Update obsolete contact info
Date: Thu, 23 Oct 2025 09:55:06 +0700
Message-ID: <20251023025506.23779-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5672; i=bagasdotme@gmail.com; h=from:subject; bh=RTUk2WSlE0halvN9moYsr3H7Bj2oinnqonBwfh8+6Wo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBk/p8Txv3y16+DXnd0XsxgdO461LeZx09BP2NnFsGq5t er1e9YLOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRUxGMDB3fW/JPbZgY7dF3 svFTgF/0B+F8Rv5pf59O9uFsLLPiDWNk6NlTks2su+iNtcu12tfv3wp5F2UXX3w+9/yCA+1vlfX D2AE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

ARCnet docs states that inquiries on the subsystem should be emailed to
Avery Pennarun <apenwarr@worldvisions.ca>, for whom has been in CREDITS
since the beginning of kernel git history and the subsystem is now
maintained by Michael Grzeschik since c38f6ac74c9980 ("MAINTAINERS: add
arcnet and take maintainership"). In addition, there used to be a
dedicated ARCnet mailing list but its archive at epistolary.org has been
shut down. ARCnet discussion nowadays take place in netdev list.

Update contact information.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  - s/hesistate/hesitate/ (Simon)

netdev maintainers: Since there is no reply from Avery on v1, can this patch
be acked and merged into net-next?

[1]: https://lore.kernel.org/linux-doc/20250912042252.19901-1-bagasdotme@gmail.com/

 Documentation/networking/arcnet-hardware.rst | 13 +++---
 Documentation/networking/arcnet.rst          | 48 +++++---------------
 2 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/Documentation/networking/arcnet-hardware.rst b/Documentation/networking/arcnet-hardware.rst
index 3bf7f99cd7bbf0..e75346f112920a 100644
--- a/Documentation/networking/arcnet-hardware.rst
+++ b/Documentation/networking/arcnet-hardware.rst
@@ -4,6 +4,8 @@
 ARCnet Hardware
 ===============
 
+:Author: Avery Pennarun <apenwarr@worldvisions.ca>
+
 .. note::
 
    1) This file is a supplement to arcnet.txt.  Please read that for general
@@ -13,9 +15,9 @@ ARCnet Hardware
 
 Because so many people (myself included) seem to have obtained ARCnet cards
 without manuals, this file contains a quick introduction to ARCnet hardware,
-some cabling tips, and a listing of all jumper settings I can find. Please
-e-mail apenwarr@worldvisions.ca with any settings for your particular card,
-or any other information you have!
+some cabling tips, and a listing of all jumper settings I can find. If you
+have any settings for your particular card, and/or any other information you
+have, do not hesitate to :ref:`email to netdev <arcnet-netdev>`.
 
 
 Introduction to ARCnet
@@ -3226,9 +3228,6 @@ Settings for IRQ Selection (Lower Jumper Line)
 Other Cards
 ===========
 
-I have no information on other models of ARCnet cards at the moment.  Please
-send any and all info to:
-
-	apenwarr@worldvisions.ca
+I have no information on other models of ARCnet cards at the moment.
 
 Thanks.
diff --git a/Documentation/networking/arcnet.rst b/Documentation/networking/arcnet.rst
index 82fce606c0f0bc..cd43a18ad1494b 100644
--- a/Documentation/networking/arcnet.rst
+++ b/Documentation/networking/arcnet.rst
@@ -4,6 +4,8 @@
 ARCnet
 ======
 
+:Author: Avery Pennarun <apenwarr@worldvisions.ca>
+
 .. note::
 
    See also arcnet-hardware.txt in this directory for jumper-setting
@@ -30,18 +32,7 @@ Come on, be a sport!  Send me a success report!
 
 (hey, that was even better than my original poem... this is getting bad!)
 
-
-.. warning::
-
-   If you don't e-mail me about your success/failure soon, I may be forced to
-   start SINGING.  And we don't want that, do we?
-
-   (You know, it might be argued that I'm pushing this point a little too much.
-   If you think so, why not flame me in a quick little e-mail?  Please also
-   include the type of card(s) you're using, software, size of network, and
-   whether it's working or not.)
-
-   My e-mail address is: apenwarr@worldvisions.ca
+----
 
 These are the ARCnet drivers for Linux.
 
@@ -59,23 +50,14 @@ ARCnet 2.10 ALPHA, Tomasz's all-new-and-improved RFC1051 support has been
 included and seems to be working fine!
 
 
+.. _arcnet-netdev:
+
 Where do I discuss these drivers?
 ---------------------------------
 
-Tomasz has been so kind as to set up a new and improved mailing list.
-Subscribe by sending a message with the BODY "subscribe linux-arcnet YOUR
-REAL NAME" to listserv@tichy.ch.uj.edu.pl.  Then, to submit messages to the
-list, mail to linux-arcnet@tichy.ch.uj.edu.pl.
-
-There are archives of the mailing list at:
-
-	http://epistolary.org/mailman/listinfo.cgi/arcnet
-
-The people on linux-net@vger.kernel.org (now defunct, replaced by
-netdev@vger.kernel.org) have also been known to be very helpful, especially
-when we're talking about ALPHA Linux kernels that may or may not work right
-in the first place.
-
+ARCnet discussions take place on netdev. Simply send your email to
+netdev@vger.kernel.org and make sure to Cc: maintainer listed in
+"ARCNET NETWORK LAYER" heading of Documentation/process/maintainers.rst.
 
 Other Drivers and Info
 ----------------------
@@ -523,17 +505,9 @@ can set up your network then:
 It works: what now?
 -------------------
 
-Send mail describing your setup, preferably including driver version, kernel
-version, ARCnet card model, CPU type, number of systems on your network, and
-list of software in use to me at the following address:
-
-	apenwarr@worldvisions.ca
-
-I do send (sometimes automated) replies to all messages I receive.  My email
-can be weird (and also usually gets forwarded all over the place along the
-way to me), so if you don't get a reply within a reasonable time, please
-resend.
-
+Send mail following :ref:`arcnet-netdev`. Describe your setup, preferably
+including driver version, kernel version, ARCnet card model, CPU type, number
+of systems on your network, and list of software in use.
 
 It doesn't work: what now?
 --------------------------

base-commit: 26ab9830beabda863766be4a79dc590c7645f4d9
-- 
An old man doll... just what I always wanted! - Clara


