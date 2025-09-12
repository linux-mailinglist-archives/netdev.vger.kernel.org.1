Return-Path: <netdev+bounces-222399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E67B54197
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 06:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FD156850E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B321C179;
	Fri, 12 Sep 2025 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgkgIL8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6022147F9
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650188; cv=none; b=YjC/UJj9eFi9ZS0sGNJthj8kP0CxMbUgYMzYBSwA6JmKQytKLl0IXnry66u48EiUuh5J7x35CIXCaYT9YhRpBlqrpFHnM7ZcmP6HA68pN4sK9tGMmg3c/vxo+voC/vX1NDYg0lJd8HthK20S8q60/5pwMyBvvphUvILiJYCvn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650188; c=relaxed/simple;
	bh=zZkkZ9jtVN9zl8MOUiaRZ/AhuJkVluKe+HXlB+7F8d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/tQmE61NkqqbuSCYgwvHeBeCti2n+zWStT+0IVtcZZCv0oP4cMlb8mfgakX/VNMgbmUlFxwSvS5gejZAa+jiU6wFNAymBOg+GecittaeL9GVE3XQnyi9zHAbCooRd9XQs7+512Kj6mcPbtvCNashqzK0UhADGyS54BCzAvXUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgkgIL8Z; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77459bc5d18so1187333b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757650186; x=1758254986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6PvSPHugeaR1Sq9Pxzgn3oZJDYqC50hx/s/XnB6afU=;
        b=DgkgIL8ZThy0fXYIBjsFOufI4kP8lGxLNf3FyPUBa4MgBzKNvqIU8VVQh5/jtziSX+
         lsS+FV1j1Rek3zuwmHxMZ59VQSkOHFst7ZG/kKbsHw/0/o5PlnpA+V0LmVmxsGHHn0tS
         A8bdIW/kztOJsyzTpRE1LsHw/azJvPepSwsu+K8CcIrQzpg+4VP0gMgN2oItGrKVXCFM
         hwZprNeEA4j4XtuRxry7Fs+6H53ElDL0YAD0uTzJTBJR2VVOo8vcApXDvjW54+BqWjbq
         fb5ljrKa1EcuVGySzTgdx+Yr74kmJG4fwVyC4f8tkLK+yp6omq8m8VcFOc2KjGp5Rc0a
         UamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650186; x=1758254986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6PvSPHugeaR1Sq9Pxzgn3oZJDYqC50hx/s/XnB6afU=;
        b=A4UHmqTtiYcbKd+IgiDypbv9CYVzWGaxo/1MoD+z1bMkLhE6uSDO7WRuuteHVyh8p1
         BMrhnh8qkl/p4bCd/rpkvADmYECvIDQ97+D6ZX66h2Aiqsargp+2JhxWpSmHZZ1i9UZ6
         pyQbykBdSXg4xJcobyc3Y4lMxGQUan0FjPDHBKo+hdMCYyHx0PttMiKG91dbNx0EXXaM
         dw4LLcgLm5KkfWZ3YKuh6vgkJcSUmB68k9/OkLRu1ktA0TcBwtWVk5tC+ZoI6rb0aNu5
         iJHHGixrzIzmUpvY82q+DzT7S4rCIKQSub3CiV3AtwK40O5xuSQEU9MLBi+YkcK/HMYP
         afUA==
X-Forwarded-Encrypted: i=1; AJvYcCUURa6uBD1XyJoIWTAaD/tk7L4LwZmEfUeKDnLREDGeZT79itWr7ohjZbtVIk6GtAk7Z3uhF/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1chRgxT54/UzmtaeOmQIGd+gDp7PE2UH+tkEWtUdmm36ab+S
	N2nZPl5EkkZLsi+I7RfPlHwXQPBS43bJuTK4Pdq/LwKfxuc+LJvVjlqK
X-Gm-Gg: ASbGncsmqEMuf9eYIiQpoMbE7UGh88JiUntr09N9McDES/IAQo+Gwrst10MVhHWfHnT
	fYq8hYfpdf07k7zYOsv/xNxJCoBZn2xfonJ21fk059pnqxgZSIJ7T437/onjRi7fEH2qUaFeVRX
	210SKjPVyuIrPIJxZeTlLzR29Z4SXT/GCzoN3HVCGJGNBhganXDrtnobSK5wIn7xrtb9P+c8qX6
	lyj1ufuzac6266eiknc7DC06SXkiWrErcZAnXXtn6P0ysoP86KsyIYqVJKmRc+eipYyoUrOLo8z
	eI2X72aQ0t92hcy6evyzlInVnViIBlAAva+TCqkSOLdsTgmrKMAf60F1x2DNgbuGGozphnRvP2A
	Cu4e87nYTXx5LXwVS3G1B3V8wYw==
X-Google-Smtp-Source: AGHT+IHHcMjVW/z8OdxzzV0OTOhOnUEH80JZvwj4ElBZ0sgfnVRc6qC2OR+IY91vy5y/SGy5PU25Qg==
X-Received: by 2002:a05:6a00:2d8c:b0:772:5165:3f77 with SMTP id d2e1a72fcca58-77612189e56mr2035163b3a.26.1757650185575;
        Thu, 11 Sep 2025 21:09:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a4a24esm3780924b3a.40.2025.09.11.21.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:09:44 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E4AD941FA3A4; Fri, 12 Sep 2025 11:09:42 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kenel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next] Documentation: ARCnet: Update obsolete contact info
Date: Fri, 12 Sep 2025 11:09:33 +0700
Message-ID: <20250912040933.19036-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5408; i=bagasdotme@gmail.com; h=from:subject; bh=zZkkZ9jtVN9zl8MOUiaRZ/AhuJkVluKe+HXlB+7F8d0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmH58zTXHXN/cokgV2FNVrZQs5FpVXXSzs49+3mXn719 qTMHYsOdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAidn8YGRo3X54iO+XypoXn juz8JsewakJA0kc9jt5zDsETD1ziVHjE8Fd88ctFJ/c6/JcoOvvXtT5FdF7cpT8K7Om6uQHn//4 5w8gNAA==
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
 Documentation/networking/arcnet-hardware.rst | 13 +++---
 Documentation/networking/arcnet.rst          | 48 +++++---------------
 2 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/Documentation/networking/arcnet-hardware.rst b/Documentation/networking/arcnet-hardware.rst
index 3bf7f99cd7bbf0..1e4484d880fe67 100644
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
+have, do not hesistate to :ref:`email to netdev <arcnet-netdev>`.
 
 
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

base-commit: 2f186dd5585c3afb415df80e52f71af16c9d3655
-- 
An old man doll... just what I always wanted! - Clara


