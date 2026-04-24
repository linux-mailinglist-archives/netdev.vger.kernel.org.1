Return-Path: <netdev+bounces-281072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VHdaN7X762lbTgAAu9opvQ
	(envelope-from <netdev+bounces-281072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:24:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F05464086
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 871D2300C5A6
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 23:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE53363C4A;
	Fri, 24 Apr 2026 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="wCT0je2d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A235A938
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777073074; cv=none; b=rnNW0ZfOZr+YVVbf0YYRZkArryB66QtxPMf2Jg9WjsL6MvNIPEarGilWIyePu0GHae92iHLSBjNHD0wKvDedtO6DULvC/OlNjaI6hzfO99Lx+omQSz6VQgyhIMpAT9ENwfGXMbZ0kceuPP1EWXcvYKuV65qt84Rxf/sVr92vbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777073074; c=relaxed/simple;
	bh=ZAB7yWLhrt3PojxKxlob1U+YqpObkI7oqzCGpS/jLXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkRihHOsjpPYTvBmpRnIepEn7wMNgjxz0BPwgT02rIYSej0TY17/L5Si99xgpKf9JS0I+alUuERbHpBa6Jj1OXapsNcg/ZL2/G4XisUDUzIqq/LIVaQmWOFX2UNSB2pWtlyBznzJ5H3nPhfPbekJMgPlENDtfMgeQgVt/Qtdh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=wCT0je2d; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69486849137so3167065eaf.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777073072; x=1777677872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFKYbByIj4hd+aAIBGbpbwpL5BVDzTkrqCDKwhf/SpQ=;
        b=wCT0je2d61nTWxXiA6Co8XcBHbj5DzLMOUUz5hXcPjRGpEH+/8gk4RZwt5+xCYctK+
         mICkdDG4g81/YNRAI39dCqXyIM+P5HIqU421ud+DmLy5/oGtKhw7mNGKIYfvFoZYg/Nj
         2g4k7I25dSQIMFIRa68n/9cs1zAVfT6u033+rRvZkNvC7qtHNiAVotT+48LGCCV20TsO
         imZHG3W7ZnIuGNxHeNlTm+xGagQnr+eXeiRm3aBtzI8FXs8xrjdD6C0mL4w25KN/BGGN
         op6HZEV2zRIe5TNV7PFEIrWLKfT5SFjuAYJbSFNjOuNt9xX9bihQBwoooeaOcE6HPIfB
         IJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777073072; x=1777677872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFKYbByIj4hd+aAIBGbpbwpL5BVDzTkrqCDKwhf/SpQ=;
        b=Y4W2wYXCeBssNgs+h2QqqiDv7+jK7shIsZymYOnAYPdrORehTsyvsWhrmdOPxejHry
         LhMMxMsgCxcU4l2pxLspWPXNxJG9H87WtEecGROLnntzaYgl41Uj5F3U7SLF8ZhUqAKn
         65KGOxpqROl8xSdgVGZqEyM77HZn4LkiACZtlIiLtZP0rtPvpz1p+78wjHD8g6HZJ+mK
         qLQMDgXCN5rsY184pNXI+xabOy5U8C/5n+V0ocw7iQ+d0dG34qgDs4adIvQ/S/E8cchu
         M1H3R2TQecWoQrH3WOOETo6dTSTMHwJEMwXr//ORIgkm2u8ingVegkNk7I4SUN+8BYDE
         0Etw==
X-Gm-Message-State: AOJu0YzA/w0UxQJmG5VJPsSvMpZu5/wdSN/9tVN4K96XsQjwzRLhXGep
	rKAJOvYGVhTi9aUIUvZMjyOjpp4JzqxH7Hak8LDaKLnIw8DXYj8M0tYd7V1FHQjZPoqZt7r9i/K
	zJEmX
X-Gm-Gg: AeBDievXGGKFJP6PDd4YlQaTkvzrQvocJfqyAVCCLsdVDPx58LurFuZVFiLm4Ns73bS
	4BQI/k0uSb19lBRh4XTAMGLZdhZuHXpp7WlgoMuzuI1HNMS+iVzvuCCEDDkAx1W5q6aCCURO/RU
	7WMba+WJudst+d48lRXsvJDtL1DVQ3dXwfQBPSOJ9uMw7p08IMwqeHmxnFAl85S8CtzQ3OEue+H
	oJsRgIuC3nbU9v1HJthDNH+hGr8pnnCIKMWrE/eRklBHslFxpDg6kVWe7aheNfqGb6+wjQ5AbS6
	QQ9X0cYHV1lm9BPW9oxSI1DULmeWJidWcs1w8JjpjtBufFZAgWLtrsNx3xsMRBZ2LtZD59JHYke
	zpuHpJ+ru9MGdNO2Y3HZQf9FNNrbefca/SxBYsEfMuaQRd/ik6upulUYWd43fdLuWbAACGRcsgc
	kSFXlw0Dzf1jMsgwW/t09i1+saBc238eU8xHQVo+e7ByM=
X-Received: by 2002:a05:6820:2006:b0:694:a37c:4e84 with SMTP id 006d021491bc7-694a37c6f3emr8957218eaf.27.1777073071683;
        Fri, 24 Apr 2026 16:24:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9ac54ec5sm21065005fac.13.2026.04.24.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 16:24:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] remove hamradio protocols
Date: Fri, 24 Apr 2026 16:24:27 -0700
Message-ID: <20260424232427.792249-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35F05464086
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281072-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]

The ax25, rose, and netrom have been removed upstream.
Drop support for those protocols from iproute2.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 Makefile                  |   9 ---
 include/uapi/linux/ax25.h | 117 --------------------------------------
 include/uapi/linux/rose.h |  91 -----------------------------
 include/utils.h           |   6 --
 lib/ax25_ntop.c           |  82 --------------------------
 lib/ll_addr.c             |   6 --
 lib/netrom_ntop.c         |  23 --------
 lib/rose_ntop.c           |  56 ------------------
 8 files changed, 390 deletions(-)
 delete mode 100644 include/uapi/linux/ax25.h
 delete mode 100644 include/uapi/linux/rose.h
 delete mode 100644 lib/ax25_ntop.c
 delete mode 100644 lib/netrom_ntop.c
 delete mode 100644 lib/rose_ntop.c

diff --git a/Makefile b/Makefile
index 1bebf08f..6f5d4765 100644
--- a/Makefile
+++ b/Makefile
@@ -45,18 +45,9 @@ DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
          -DARPDDIR=\"$(ARPDDIR)\" \
          -DCONF_COLOR=$(CONF_COLOR)
 
-#options for AX.25
-ADDLIB+=ax25_ntop.o
-
-#options for AX.25
-ADDLIB+=rose_ntop.o
-
 #options for mpls
 ADDLIB+=mpls_ntop.o mpls_pton.o
 
-#options for NETROM
-ADDLIB+=netrom_ntop.o
-
 CC := gcc
 HOSTCC ?= $(CC)
 DEFINES += -D_GNU_SOURCE
diff --git a/include/uapi/linux/ax25.h b/include/uapi/linux/ax25.h
deleted file mode 100644
index b496b9d8..00000000
--- a/include/uapi/linux/ax25.h
+++ /dev/null
@@ -1,117 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * These are the public elements of the Linux kernel AX.25 code. A similar
- * file netrom.h exists for the NET/ROM protocol.
- */
-
-#ifndef	AX25_KERNEL_H
-#define	AX25_KERNEL_H
-
-#include <linux/socket.h>
-
-#define AX25_MTU	256
-#define AX25_MAX_DIGIS  8
-
-#define AX25_WINDOW	1
-#define AX25_T1		2
-#define AX25_N2		3
-#define AX25_T3		4
-#define AX25_T2		5
-#define	AX25_BACKOFF	6
-#define	AX25_EXTSEQ	7
-#define	AX25_PIDINCL	8
-#define AX25_IDLE	9
-#define AX25_PACLEN	10
-#define AX25_IAMDIGI	12
-
-#define AX25_KILL	99
-
-#define SIOCAX25GETUID		(SIOCPROTOPRIVATE+0)
-#define SIOCAX25ADDUID		(SIOCPROTOPRIVATE+1)
-#define SIOCAX25DELUID		(SIOCPROTOPRIVATE+2)
-#define SIOCAX25NOUID		(SIOCPROTOPRIVATE+3)
-#define SIOCAX25OPTRT		(SIOCPROTOPRIVATE+7)
-#define SIOCAX25CTLCON		(SIOCPROTOPRIVATE+8)
-#define SIOCAX25GETINFOOLD	(SIOCPROTOPRIVATE+9)
-#define SIOCAX25ADDFWD		(SIOCPROTOPRIVATE+10)
-#define SIOCAX25DELFWD		(SIOCPROTOPRIVATE+11)
-#define SIOCAX25DEVCTL          (SIOCPROTOPRIVATE+12)
-#define SIOCAX25GETINFO         (SIOCPROTOPRIVATE+13)
-
-#define AX25_SET_RT_IPMODE	2
-
-#define AX25_NOUID_DEFAULT	0
-#define AX25_NOUID_BLOCK	1
-
-typedef struct {
-	char		ax25_call[7];	/* 6 call + SSID (shifted ascii!) */
-} ax25_address;
-
-struct sockaddr_ax25 {
-	__kernel_sa_family_t sax25_family;
-	ax25_address	sax25_call;
-	int		sax25_ndigis;
-	/* Digipeater ax25_address sets follow */
-};
-
-#define sax25_uid	sax25_ndigis
-
-struct full_sockaddr_ax25 {
-	struct sockaddr_ax25 fsa_ax25;
-	ax25_address	fsa_digipeater[AX25_MAX_DIGIS];
-};
-
-struct ax25_routes_struct {
-	ax25_address	port_addr;
-	ax25_address	dest_addr;
-	unsigned char	digi_count;
-	ax25_address	digi_addr[AX25_MAX_DIGIS];
-};
-
-struct ax25_route_opt_struct {
-	ax25_address	port_addr;
-	ax25_address	dest_addr;
-	int		cmd;
-	int		arg;
-};
-
-struct ax25_ctl_struct {
-        ax25_address            port_addr;
-        ax25_address            source_addr;
-        ax25_address            dest_addr;
-        unsigned int            cmd;
-        unsigned long           arg;
-        unsigned char           digi_count;
-        ax25_address            digi_addr[AX25_MAX_DIGIS];
-};
-
-/* this will go away. Please do not export to user land */
-struct ax25_info_struct_deprecated {
-	unsigned int	n2, n2count;
-	unsigned int	t1, t1timer;
-	unsigned int	t2, t2timer;
-	unsigned int	t3, t3timer;
-	unsigned int	idle, idletimer;
-	unsigned int	state;
-	unsigned int	rcv_q, snd_q;
-};
-
-struct ax25_info_struct {
-	unsigned int	n2, n2count;
-	unsigned int	t1, t1timer;
-	unsigned int	t2, t2timer;
-	unsigned int	t3, t3timer;
-	unsigned int	idle, idletimer;
-	unsigned int	state;
-	unsigned int	rcv_q, snd_q;
-	unsigned int	vs, vr, va, vs_max;
-	unsigned int	paclen;
-	unsigned int	window;
-};
-
-struct ax25_fwd_struct {
-	ax25_address	port_from;
-	ax25_address	port_to;
-};
-
-#endif
diff --git a/include/uapi/linux/rose.h b/include/uapi/linux/rose.h
deleted file mode 100644
index 19aa4693..00000000
--- a/include/uapi/linux/rose.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * These are the public elements of the Linux kernel Rose implementation.
- * For kernel AX.25 see the file ax25.h. This file requires ax25.h for the
- * definition of the ax25_address structure.
- */
-
-#ifndef	ROSE_KERNEL_H
-#define	ROSE_KERNEL_H
-
-#include <linux/socket.h>
-#include <linux/ax25.h>
-
-#define ROSE_MTU	251
-
-#define ROSE_MAX_DIGIS 6
-
-#define	ROSE_DEFER	1
-#define ROSE_T1		2
-#define	ROSE_T2		3
-#define	ROSE_T3		4
-#define	ROSE_IDLE	5
-#define	ROSE_QBITINCL	6
-#define	ROSE_HOLDBACK	7
-
-#define	SIOCRSGCAUSE		(SIOCPROTOPRIVATE+0)
-#define	SIOCRSSCAUSE		(SIOCPROTOPRIVATE+1)
-#define	SIOCRSL2CALL		(SIOCPROTOPRIVATE+2)
-#define	SIOCRSSL2CALL		(SIOCPROTOPRIVATE+2)
-#define	SIOCRSACCEPT		(SIOCPROTOPRIVATE+3)
-#define	SIOCRSCLRRT		(SIOCPROTOPRIVATE+4)
-#define	SIOCRSGL2CALL		(SIOCPROTOPRIVATE+5)
-#define	SIOCRSGFACILITIES	(SIOCPROTOPRIVATE+6)
-
-#define	ROSE_DTE_ORIGINATED	0x00
-#define	ROSE_NUMBER_BUSY	0x01
-#define	ROSE_INVALID_FACILITY	0x03
-#define	ROSE_NETWORK_CONGESTION	0x05
-#define	ROSE_OUT_OF_ORDER	0x09
-#define	ROSE_ACCESS_BARRED	0x0B
-#define	ROSE_NOT_OBTAINABLE	0x0D
-#define	ROSE_REMOTE_PROCEDURE	0x11
-#define	ROSE_LOCAL_PROCEDURE	0x13
-#define	ROSE_SHIP_ABSENT	0x39
-
-typedef struct {
-	char		rose_addr[5];
-} rose_address;
-
-struct sockaddr_rose {
-	__kernel_sa_family_t srose_family;
-	rose_address	srose_addr;
-	ax25_address	srose_call;
-	int		srose_ndigis;
-	ax25_address	srose_digi;
-};
-
-struct full_sockaddr_rose {
-	__kernel_sa_family_t srose_family;
-	rose_address	srose_addr;
-	ax25_address	srose_call;
-	unsigned int	srose_ndigis;
-	ax25_address	srose_digis[ROSE_MAX_DIGIS];
-};
-
-struct rose_route_struct {
-	rose_address	address;
-	unsigned short	mask;
-	ax25_address	neighbour;
-	char		device[16];
-	unsigned char	ndigis;
-	ax25_address	digipeaters[AX25_MAX_DIGIS];
-};
-
-struct rose_cause_struct {
-	unsigned char	cause;
-	unsigned char	diagnostic;
-};
-
-struct rose_facilities_struct {
-	rose_address	source_addr,   dest_addr;
-	ax25_address	source_call,   dest_call;
-	unsigned char	source_ndigis, dest_ndigis;
-	ax25_address	source_digis[ROSE_MAX_DIGIS];
-	ax25_address	dest_digis[ROSE_MAX_DIGIS];
-	unsigned int	rand;
-	rose_address	fail_addr;
-	ax25_address	fail_call;
-};
-
-#endif
diff --git a/include/utils.h b/include/utils.h
index b68d6bc4..e4e318e2 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -199,15 +199,9 @@ int matches(const char *prefix, const char *string);
 int inet_addr_match(const inet_prefix *a, const inet_prefix *b, int bits);
 int inet_addr_match_rta(const inet_prefix *m, const struct rtattr *rta);
 
-const char *ax25_ntop(int af, const void *addr, char *str, socklen_t len);
-
-const char *rose_ntop(int af, const void *addr, char *buf, socklen_t buflen);
-
 const char *mpls_ntop(int af, const void *addr, char *str, size_t len);
 int mpls_pton(int af, const char *src, void *addr, size_t alen);
 
-const char *netrom_ntop(int af, const void *addr, char *str, socklen_t len);
-
 extern int __iproute2_hz_internal;
 int __get_hz(void);
 
diff --git a/lib/ax25_ntop.c b/lib/ax25_ntop.c
deleted file mode 100644
index 3a72a43e..00000000
--- a/lib/ax25_ntop.c
+++ /dev/null
@@ -1,82 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-
-#include <errno.h>
-#include <sys/socket.h>
-#include <linux/ax25.h>
-
-#include "utils.h"
-
-const char *ax25_ntop1(const ax25_address *src, char *dst, socklen_t size);
-
-/*
- * AX.25 addresses are based on Amateur radio callsigns followed by an SSID
- * like XXXXXX-SS where the callsign consists of up to 6 ASCII characters
- * which are either letters or digits and the SSID is a decimal number in the
- * range 0..15.
- * Amateur radio callsigns are assigned by a country's relevant authorities
- * and are 3..6 characters though a few countries have assigned callsigns
- * longer than that.  AX.25 is not able to handle such longer callsigns.
- * There are further restrictions on the format of valid callsigns by
- * applicable national and international law.  Linux doesn't need to care and
- * will happily accept anything that consists of 6 ASCII characters in the
- * range of A-Z and 0-9 for a callsign such as the default AX.25 MAC address
- * LINUX-1 and the default broadcast address QST-0.
- * The SSID is just a number and not encoded in ASCII digits.
- *
- * Being based on HDLC AX.25 encodes addresses by shifting them one bit left
- * thus zeroing bit 0, the HDLC extension bit for all but the last bit of
- * a packet's address field but for our purposes here we're not considering
- * the HDLC extension bit that is it will always be zero.
- *
- * Linux' internal representation of AX.25 addresses in Linux is very similar
- * to this on the on-air or on-the-wire format.  The callsign is padded to
- * 6 octets by adding spaces, followed by the SSID octet then all 7 octets
- * are left-shifted by one bit.
- *
- * For example, for the address "LINUX-1" the callsign is LINUX and SSID is 1
- * the internal format is 98:92:9c:aa:b0:40:02.
- */
-
-const char *ax25_ntop1(const ax25_address *src, char *dst, socklen_t size)
-{
-	char c, *s;
-	int n;
-
-	for (n = 0, s = dst; n < 6; n++) {
-		c = (src->ax25_call[n] >> 1) & 0x7f;
-		if (c != ' ')
-			*s++ = c;
-	}
-
-	*s++ = '-';
-
-	n = ((src->ax25_call[6] >> 1) & 0x0f);
-	if (n > 9) {
-		*s++ = '1';
-		n -= 10;
-	}
-
-	*s++ = n + '0';
-	*s++ = '\0';
-
-	if (*dst == '\0' || *dst == '-') {
-		dst[0] = '*';
-		dst[1] = '\0';
-	}
-
-	return dst;
-}
-
-const char *ax25_ntop(int af, const void *addr, char *buf, socklen_t buflen)
-{
-	switch (af) {
-	case AF_AX25:
-		errno = 0;
-		return ax25_ntop1((ax25_address *)addr, buf, buflen);
-
-	default:
-		errno = EAFNOSUPPORT;
-	}
-
-	return NULL;
-}
diff --git a/lib/ll_addr.c b/lib/ll_addr.c
index 5e924591..7a9eb3a4 100644
--- a/lib/ll_addr.c
+++ b/lib/ll_addr.c
@@ -35,12 +35,6 @@ const char *ll_addr_n2a(const unsigned char *addr, int alen, int type,
 
 	if (alen == 16 && (type == ARPHRD_TUNNEL6 || type == ARPHRD_IP6GRE))
 		return inet_ntop(AF_INET6, addr, buf, blen);
-	if (alen == 7 && type == ARPHRD_AX25)
-		return ax25_ntop(AF_AX25, addr, buf, blen);
-	if (alen == 7 && type == ARPHRD_NETROM)
-		return netrom_ntop(AF_NETROM, addr, buf, blen);
-	if (alen == 5 && type == ARPHRD_ROSE)
-		return rose_ntop(AF_ROSE, addr, buf, blen);
 
 	snprintf(buf, blen, "%02x", addr[0]);
 	for (i = 1, l = 2; i < alen && l < blen; i++, l += 3)
diff --git a/lib/netrom_ntop.c b/lib/netrom_ntop.c
deleted file mode 100644
index 3dd6cb0b..00000000
--- a/lib/netrom_ntop.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#include <sys/socket.h>
-#include <errno.h>
-#include <linux/ax25.h>
-
-#include "utils.h"
-
-const char *ax25_ntop1(const ax25_address *src, char *dst, socklen_t size);
-
-const char *netrom_ntop(int af, const void *addr, char *buf, socklen_t buflen)
-{
-	switch (af) {
-	case AF_NETROM:
-		errno = 0;
-		return ax25_ntop1((ax25_address *)addr, buf, buflen);
-
-	default:
-		errno = EAFNOSUPPORT;
-	}
-
-	return NULL;
-}
diff --git a/lib/rose_ntop.c b/lib/rose_ntop.c
deleted file mode 100644
index c9ba712c..00000000
--- a/lib/rose_ntop.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <string.h>
-#include <errno.h>
-
-#include <linux/netdevice.h>
-#include <linux/if_arp.h>
-#include <linux/sockios.h>
-#include <linux/rose.h>
-
-#include "rt_names.h"
-#include "utils.h"
-
-static const char *rose_ntop1(const rose_address *src, char *dst,
-			      socklen_t size)
-{
-	char *p = dst;
-	int i;
-
-	if (size < 10)
-		return NULL;
-
-	for (i = 0; i < 5; i++) {
-		*p++ = '0' + ((src->rose_addr[i] >> 4) & 0xf);
-		*p++ = '0' + ((src->rose_addr[i]     ) & 0xf);
-	}
-
-	if (size == 10)
-		return dst;
-
-	*p = '\0';
-
-	return dst;
-}
-
-const char *rose_ntop(int af, const void *addr, char *buf, socklen_t buflen)
-{
-	switch (af) {
-	case AF_ROSE:
-		errno = 0;
-		return rose_ntop1((rose_address *)addr, buf, buflen);
-
-	default:
-		errno = EAFNOSUPPORT;
-	}
-
-	return NULL;
-}
-- 
2.53.0


