Return-Path: <netdev+bounces-233383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D2C12955
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27E0E4FD714
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774ED257841;
	Tue, 28 Oct 2025 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Bte/Aj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482C2494FF
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615948; cv=none; b=apPK4fwzpcMBrAEZt7znNmEml9/bmeeckrkWi2py/bNjgPPvEYdUqS18XNnX86bLFUEg26XOrR/h6DeXHmEfYMIpE1aZiyDuuTEBQZt2xIQNdOtasH1W5fsLcHizlJmRo+odXBd8NEN0ITDF4d0UR/BAlB0NcxC1NrPZZykQrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615948; c=relaxed/simple;
	bh=GF+MC882OMnI8S27LLYciURvp0ZasVg7CZfx3nxVP9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffQtebHZ+uj/hAeRnllWqTtQd+nZVTOJ0djR5ax4P6IT63dk7HwILpJhcFi/Yg456ung4VpB6pwUCJOkxD1ZMwSSr78WHsnprkBFtYd86ZqlRqd8FxfAoGNCNFgr7zG239wFWkgkw8xS7wUYaPnQTaIQ8H+eEAHbnyEd0lWD5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Bte/Aj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so5280659a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 18:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761615946; x=1762220746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tpNWD1OK7YuCBqN99mwKFZZzGomTddAkF6+EFAt55o=;
        b=O4Bte/AjRy6+2MxCF80R6ZMqXyqPIOI6u+rKhmJfqcIJvKBY3O9qhEP3ipN0iUeJmc
         mOYn9PiPuowIdXBlasDfRE7m/Un/ljRi2NBGxdceJSESHNH/kGIReIMtihCuy2u1VTlS
         mnkjdU82X2OB4a6fhtouiiX7p841Dc7eyseCSnqpXC50d7OjHivCRt83F/QWXrj0V3XK
         73zgjXA+N4k7l6r/s5ln+NQ+Pbq8qafL475d0VO55rHo8U7kSYrqRu4JisPJsexAxQTB
         G8Uo2AP1A1oboaGyY3a4ukWnmoTRG0eJn4qqT/ob7jpOw7c9lTo806m7s+NVZgnC177W
         T4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761615946; x=1762220746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tpNWD1OK7YuCBqN99mwKFZZzGomTddAkF6+EFAt55o=;
        b=Ohr2XQszeO2Frkcal3tN7rRqnBagnO0HXtf98/4MaCej0ek9i7JZWGw5QAiWZaX9ae
         El9AjvlIxphjq5/Aq5+zgl8cHM1k6GrUWdiOJUpDTrJ/xx0MKADLKQ+ZjfPMe3mNz+nG
         V962wsswCY11DYtIs92NxFU1/C0M5NeHBw9TH4H0VGrz+GMNeZsNbJPkWu1+FK3rygAK
         r/aEkvukiEWxjL5ci7eLbDQXZnwABmZS7Z7HNj8IEoD3HOSshXLlZnf88U3J7CNjfvg4
         asbEo00lC/6wpUARhkCxM5RkSP8YV8u11hOsQquXp1vO6LB5kR0yunH7Cw3hiKENzExU
         5NVA==
X-Forwarded-Encrypted: i=1; AJvYcCVzqMskbQTdQcHP7ubUAovjWh6JDUPNOidzHSXx4MXWFNheNlWmFT99Hlw/lFJ2I7lD+KIlva4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywDATREdmdEpp9ohkqNJHnyWUWSxIJ9ew2l2RV5FXbY5Udxu5C
	AjsvEg6vUazI9s4GbB9D8fMUDrmfjSQzEw0x+DPjkQXFjTVH/JlfFtsUL4YuqIz6FPc=
X-Gm-Gg: ASbGncuKSyk87MH9gqJD4vfPMJdEuKm+rHVE4458l7+TKT9bLMRZPFyldV18NCa2cqq
	J/V5BE07swdxeao1JDlfo4/gfYrq45W4t3l+9UINnzGRpNbjQhwJmCDVQvxZpOsjxlQIaeD0iqF
	HHCloonxi4TG0mjbTm/pXg82C6wQNmDkItlTs75Oug2glxop4+Vzo7Z04AfAYm2v33f1qRriB0r
	mBgpOm3ffd77C7qt+qcdYhzRyawjVATmXm+tNNbkylVDnzLr+Lpdr19bKZJVpsDjI0WjZZEdE37
	t/Z6lLFfxJdSxYdutRtBFbAU8AJbWp76AIUyi8AmRHxIDWJEABdwfkA8Bn5kRA4XJoOiXpDcq91
	0Lgk5RJuM8uznTkrnTlwlvBtMs5kQeV8PRSONRQTRPNJf2lW2AUoGSRHb1nHj/+2Wd1F5sbDsj7
	Op
X-Google-Smtp-Source: AGHT+IH0lOAi/qG58mWc3adb00/uN60NZKYFZ4tDXmtuyg+Eh2qzzh+KgjeO94z2Zpez7W5wBjLdzg==
X-Received: by 2002:a17:903:38c8:b0:27d:6995:990d with SMTP id d9443c01a7336-294cc72935emr14333235ad.19.1761615945478;
        Mon, 27 Oct 2025 18:45:45 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e495e8sm95878565ad.110.2025.10.27.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 18:45:44 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A10954209E50; Tue, 28 Oct 2025 08:45:42 +0700 (WIB)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v3] Documentation: ARCnet: Update obsolete contact info
Date: Tue, 28 Oct 2025 08:44:52 +0700
Message-ID: <20251028014451.10521-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6570; i=bagasdotme@gmail.com; h=from:subject; bh=GF+MC882OMnI8S27LLYciURvp0ZasVg7CZfx3nxVP9o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkM8jOl2qfya964IqC5+ljNpGXLn242nnttqu/11EnKG j+knlsKdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiNbKMDCvbHDJnccXMaVw3 b39xgEqXqbmmjF/2l2052w+2CB6cYMLwT4vxQsU//rrnk43sOz/0fJn6mWvyMfl96qu8E30vfr9 /hx0A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

ARCnet docs states that inquiries on the subsystem should be emailed to
Avery Pennarun <apenwarr@worldvisions.ca>, for whom has been in CREDITS
since the beginning of kernel git history and her email address is
unreachable (bounce). The subsystem is now maintained by Michael
Grzeschik since c38f6ac74c9980 ("MAINTAINERS: add arcnet and take
maintainership").

In addition, there used to be a dedicated ARCnet mailing list but its
archive at epistolary.org has been shut down. ARCnet discussion nowadays
take place in netdev list. The arcnet.com domain mentioned has become
AIoT (Artificial Intelligence of Things) related Typeform page and
ARCnet info now resides on arcnet.cc (ARCnet Resource Center) instead.

Update contact information.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v2 [1]:

  * Update ARCnet info link (Randy)

[1]: https://lore.kernel.org/linux-doc/20251023025506.23779-1-bagasdotme@gmail.com/

 Documentation/networking/arcnet-hardware.rst | 22 ++++-----
 Documentation/networking/arcnet.rst          | 48 +++++---------------
 2 files changed, 21 insertions(+), 49 deletions(-)

diff --git a/Documentation/networking/arcnet-hardware.rst b/Documentation/networking/arcnet-hardware.rst
index 3bf7f99cd7bbf0..20e5075d0d0e7d 100644
--- a/Documentation/networking/arcnet-hardware.rst
+++ b/Documentation/networking/arcnet-hardware.rst
@@ -4,18 +4,20 @@
 ARCnet Hardware
 ===============
 
+:Author: Avery Pennarun <apenwarr@worldvisions.ca>
+
 .. note::
 
-   1) This file is a supplement to arcnet.txt.  Please read that for general
+   1) This file is a supplement to arcnet.rst.  Please read that for general
       driver configuration help.
    2) This file is no longer Linux-specific.  It should probably be moved out
       of the kernel sources.  Ideas?
 
 Because so many people (myself included) seem to have obtained ARCnet cards
 without manuals, this file contains a quick introduction to ARCnet hardware,
-some cabling tips, and a listing of all jumper settings I can find. Please
-e-mail apenwarr@worldvisions.ca with any settings for your particular card,
-or any other information you have!
+some cabling tips, and a listing of all jumper settings I can find. If you
+have any settings for your particular card, and/or any other information you
+have, do not hesitate to :ref:`email to netdev <arcnet-netdev>`.
 
 
 Introduction to ARCnet
@@ -72,11 +74,10 @@ level of encapsulation is defined by RFC1201, which I call "packet
 splitting," that allows "virtual packets" to grow as large as 64K each,
 although they are generally kept down to the Ethernet-style 1500 bytes.
 
-For more information on the advantages and disadvantages (mostly the
-advantages) of ARCnet networks, you might try the "ARCnet Trade Association"
-WWW page:
+For more information on ARCnet networks, visit the "ARCNET Resource Center"
+WWW page at:
 
-	http://www.arcnet.com
+	https://www.arcnet.cc
 
 
 Cabling ARCnet Networks
@@ -3226,9 +3227,6 @@ Settings for IRQ Selection (Lower Jumper Line)
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

base-commit: 5f30bc470672f7b38a60d6641d519f308723085c
-- 
An old man doll... just what I always wanted! - Clara


