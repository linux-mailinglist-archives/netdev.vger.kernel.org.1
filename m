Return-Path: <netdev+bounces-281435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePFNIB2d72kbDQEAu9opvQ
	(envelope-from <netdev+bounces-281435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:30:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F57477A06
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07A853010B20
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7213E3C7D;
	Mon, 27 Apr 2026 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="N0Vpai9z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6203E3C67
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310913; cv=none; b=DjPHixsAjno0JOtnscjE245N+DswzBLCEA8WR1NCZ2V8fMnCAYZ6TncYzAaSTapYoFukKX0pwRnDdSw0ncpeTvPuRfEl759a45FzRF9kZ/bQN2lbnMcJG7xCBzk5HkKOaEmWNBdT0/fFDq8yoQngY9DAvkEOBJt+oVoMVguigas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310913; c=relaxed/simple;
	bh=jXvHJ3mCpKNTJ01ifTFRjjM2Kl7Y74pw7LCSUk3FAwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geo3syaJ7RTt+2HmVp9FM37ecsdc9lHEzougiURyLoLipmzlvKICadY1gB0kEJrB8D+nKV8pHne7FTJ7ksoPV680xeGWltiP5qdlG7FJWminICk61czWjqtIKFH5xvLN6YNCZjgT1YD8V0+42RlP7CaECnJc8aUSjRuKXSSY8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=N0Vpai9z; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40ea36b56b7so7350333fac.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777310910; x=1777915710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k02fxAkhOxLm3bpWu4bT7yYCODOiyh61+gtQymBxpCI=;
        b=N0Vpai9zOU18t8ZuQXNBIrylBUPmJN7Utml6WN6Uz0ne0liBXlAu5VGwh0wJ/Uktw2
         5ck3OFjHOanN/lt9FR72uXNOEgDBMVrVN7F6IJ+qgwmOArc0mg+IPi8IKVdxnPA5BwqK
         byD6hIPzpJPlsTf8TWwXinSlQ8lLQWPWkz+y5azPB8zr05wXXIAf9388kM14BPT4xIry
         eZGyBz9krP/b8DJO+4/QToB4+/ciDhuUulzyC1tFbNFbMPsW1eNy2Xr0oFzC915IiWce
         JOPWLKuHEkaUlChWiFwlRamljkIYPqO+pVKaaQKrvTTXrQhIRwZMpAosl3lUi/EsI/a1
         N5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777310910; x=1777915710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k02fxAkhOxLm3bpWu4bT7yYCODOiyh61+gtQymBxpCI=;
        b=n3duqXMvaWBDVYynnHB2XeEUYA97Trn73dtJ3zJzhF7fn8bzqbnUbOwEi650Qri6cm
         UaC07vpDLnlG8s6mEs419PwAOFut6iBoJcaN/xbhrXkQXySf5mHaTtaq2YaKWgWYUMqW
         tSTBsa1j+uND2iOMBQCrAhF1/Y3ik8yZiaRBFSpfqZ3ic3zA9I9zjglOKS9LyRemfm7R
         wyBOY4kYH7LXIM28AETdxT2YDhAeQKGMSx7rXiJ1A2c9kSl1LdR8RztdTSk16m8IdnLr
         hk/kUVstvA43FYQ4+TafFFUQB+pLN4l0BIDA535L0Tnhxt/v3Fkod3NjkA52FC4gGpb2
         s/gQ==
X-Gm-Message-State: AOJu0YzsMVKnIfztrH+pBKjuyEOVe+LPdLULA5eOLxZylBpCtbymN/Yg
	noRNnfYxLKzSkB+EqtU6jeuCRUgt2bgQ/YtfA7W1k1mYb5jyc8tggGnm5uYpPFvAU7iQaW2tG96
	glQzX
X-Gm-Gg: AeBDietYp+3wMQI6MWI4M7NFmy8dxspCTvIiPuX1ZixBY+9dSLMuteR0nQpGaeyUrlz
	snl2vrUsaTd8u4C6IwXzGjmYNbl06MQ1+F6k7NttQpiET7N2XO/ezmZOPXf6MCMUPSt3/wCw2xV
	6kjKW4YD9zHGnystnHvi2K+zLsCqgnXf3WLU3PjWcw1xkOwm+jNmsfI+2XqrJIKZpIFbScn18qL
	wxNQ/gIs4Il4HeNgvFwEMp//CaIqS056383zOYRrIPzW03TW5kfh/mqO/q+/fcGO5jtT4E/fHoI
	gYfVD/1er9okd4TPY8jdgvZ7UAP98bTDTAzIgNN/JPkrzjd574f2rkgPwh5AcANYNLax1YMk+Mv
	uexlqK0Af2UETs5/TpQllcW/IYeIz1hqr0O74hpNTUyHXBl+2Znx4bUw9pOpxAqDCu4GnD4BeVP
	w9VSv+40B9Z7loY//+0WegqgfZgyBHHB4PaeJbpK2sQyI=
X-Received: by 2002:a05:6870:e091:b0:41c:a7b:a8d2 with SMTP id 586e51a60fabf-42abf217259mr26324470fac.5.1777310910161;
        Mon, 27 Apr 2026 10:28:30 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42fb4f92351sm17395371fac.4.2026.04.27.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:28:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] man: remove libnetlink man page
Date: Mon, 27 Apr 2026 10:28:27 -0700
Message-ID: <20260427172827.300214-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 24F57477A06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281435-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]

The iproute2 libnetlink is not a public and stable API.
Having a man page encourages users to think it is available.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/Makefile          |   2 +-
 man/man3/Makefile     |  18 ----
 man/man3/libnetlink.3 | 200 ------------------------------------------
 3 files changed, 1 insertion(+), 219 deletions(-)
 delete mode 100644 man/man3/Makefile
 delete mode 100644 man/man3/libnetlink.3

diff --git a/man/Makefile b/man/Makefile
index c0b0d416..91dd8f3d 100644
--- a/man/Makefile
+++ b/man/Makefile
@@ -8,7 +8,7 @@ MAN_CHECK=LC_ALL=en_US.UTF-8 MANROFFSEQ='' MANWIDTH=100 man --warnings \
 # Hide man output, count and print errors.
 MAN_REDIRECT=2>&1 >/dev/null | tee /dev/fd/2 | wc -l
 
-SUBDIRS = man3 man7 man8
+SUBDIRS = man7 man8
 
 all clean install check:
 	@for subdir in $(SUBDIRS); do $(MAKE) -C $$subdir $@ || exit $$?; done
diff --git a/man/man3/Makefile b/man/man3/Makefile
deleted file mode 100644
index 1732be26..00000000
--- a/man/man3/Makefile
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-MAN3PAGES = $(wildcard *.3)
-
-all:
-
-distclean: clean
-
-clean:
-
-install:
-	$(INSTALLDIR) $(DESTDIR)$(MANDIR)/man3
-	$(INSTALLMAN) $(MAN3PAGES) $(DESTDIR)$(MANDIR)/man3
-
-check:
-	@for page in $(MAN3PAGES); do test 0 -eq $$($(MAN_CHECK) $$page \
-		$(MAN_REDIRECT)) || { echo "Error in $$page"; exit 1; }; done
-
-.PHONY: install clean distclean check
diff --git a/man/man3/libnetlink.3 b/man/man3/libnetlink.3
deleted file mode 100644
index 9a2c801c..00000000
--- a/man/man3/libnetlink.3
+++ /dev/null
@@ -1,200 +0,0 @@
-.TH libnetlink 3
-.SH NAME
-libnetlink \- A library for accessing the netlink service
-.SH SYNOPSIS
-.nf
-#include <asm/types.h>
-.br
-#include <libnetlink.h>
-.br
-#include <linux/netlink.h>
-.br
-#include <linux/rtnetlink.h>
-.sp
-int rtnl_open(struct rtnl_handle *rth, unsigned subscriptions)
-.sp
-int rtnl_wilddump_request(struct rtnl_handle *rth, int family, int type)
-.sp
-int rtnl_send(struct rtnl_handle *rth, char *buf, int len)
-.sp
-int rtnl_dump_request(struct rtnl_handle *rth, int type, void *req, int len)
-.sp
-int rtnl_dump_filter(struct rtnl_handle *rth,
-		     int (*filter)(struct sockaddr_nl *, struct nlmsghdr *n, void *),
-		     void *arg1,
-		     int (*junk)(struct sockaddr_nl *,struct nlmsghdr *n, void *),
-		     void *arg2)
-.sp
-int rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n, pid_t peer,
-	      unsigned groups, struct nlmsghdr *answer,
-.br
-	      int (*junk)(struct sockaddr_nl *,struct nlmsghdr *n, void *),
-.br
-	      void *jarg)
-.sp
-int rtnl_listen(struct rtnl_handle *rtnl,
-	      int (*handler)(struct sockaddr_nl *, struct rtnl_ctrl_data *,
-			     struct nlmsghdr *n, void *),
-	      void *jarg)
-.sp
-int rtnl_from_file(FILE *rtnl,
-	      int (*handler)(struct sockaddr_nl *,struct nlmsghdr *n, void *),
-	      void *jarg)
-.sp
-int addattr32(struct nlmsghdr *n, int maxlen, int type, __u32 data)
-.sp
-int addattr_l(struct nlmsghdr *n, int maxlen, int type, void *data, int alen)
-.sp
-int rta_addattr32(struct rtattr *rta, int maxlen, int type, __u32 data)
-.sp
-int rta_addattr_l(struct rtattr *rta, int maxlen, int type, void *data, int alen)
-.SH DESCRIPTION
-libnetlink provides a higher level interface to
-.BR rtnetlink (7).
-The read functions return 0 on success and a negative errno on failure.
-The send functions return the amount of data sent, or -1 on error.
-.TP
-rtnl_open
-Open a rtnetlink socket and save the state into the
-.B rth
-handle. This handle is passed to all subsequent calls.
-.B subscriptions
-is a bitmap of the rtnetlink multicast groups the socket will be
-a member of.
-
-.TP
-rtnl_wilddump_request
-Request a full dump of the
-.B type
-database for
-.B family
-addresses.
-.B type
-is a rtnetlink message type.
-.\" XXX
-
-.TP
-rtnl_dump_request
-Request a full dump of the
-.B type
-data buffer into
-.B buf
-with maximum length of
-.B len.
-.B type
-is a rtnetlink message type.
-
-.TP
-rtnl_dump_filter
-Receive netlink data after a request and filter it.
-The
-.B filter
-callback checks if the received message is wanted. It gets the source
-address of the message, the message itself and
-.B arg1
-as arguments. 0 as return means that the filter passed, a negative
-value is returned
-by
-.I rtnl_dump_filter
-in case of error. NULL for
-.I filter
-means to not use a filter.
-.B junk
-is used to filter messages not destined to the local socket.
-Only one message bundle is received. If there is a message
-pending, this function does not block.
-
-.TP
-rtnl_listen
-Receive netlink data after a request and pass it to
-.I handler.
-.B handler
-is a callback that gets the message source address, anscillary data, the message
-itself, and the
-.B jarg
-cookie as arguments. It will get called for all received messages.
-Only one message bundle is received. If there is a message
-pending this function does not block.
-
-.TP
-rtnl_from_file
-Works like
-.I rtnl_listen,
-but reads a netlink message bundle from the file
-.B file
-and passes the messages to
-.B handler
-for parsing. The file should contain raw data as received from a rtnetlink socket.
-.PP
-The following functions are useful to construct custom rtnetlink messages. For
-simple database dumping with filtering it is better to use the higher level
-functions above. See
-.BR rtnetlink (3)
-and
-.BR netlink (3)
-on how to generate a rtnetlink message. The following utility functions
-require a continuous buffer that already contains a netlink message header
-and a rtnetlink request.
-
-.TP
-rtnl_send
-Send the rtnetlink message in
-.B buf
-of length
-.B len
-to handle
-.B rth.
-
-.TP
-addattr32
-Add a __u32 attribute of type
-.B type
-and with value
-.B data
-to netlink message
-.B n,
-which is part of a buffer of length
-.B maxlen.
-
-.TP
-addattr_l
-Add a variable length attribute of type
-.B type
-and with value
-.B data
-and
-.B alen
-length to netlink message
-.B n,
-which is part of a buffer of length
-.B maxlen.
-.B data
-is copied.
-
-.TP
-rta_addattr32
-Initialize the rtnetlink attribute
-.B rta
-with a __u32 data value.
-
-.TP
-rta_addattr32
-Initialize the rtnetlink attribute
-.B rta
-with a variable length data value.
-
-.SH BUGS
-This library is meant for internal use, use libmnl for new programs.
-
-The functions sometimes use fprintf and exit when a fatal error occurs.
-This library should be named librtnetlink.
-
-.SH AUTHORS
-netlink/rtnetlink was designed and written by Alexey Kuznetsov.
-Andi Kleen wrote the man page.
-
-.SH SEE ALSO
-.BR netlink (7),
-.BR rtnetlink (7)
-.br
-/usr/include/linux/rtnetlink.h
-- 
2.53.0


