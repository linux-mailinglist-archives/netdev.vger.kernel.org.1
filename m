Return-Path: <netdev+bounces-191306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAFFABAC16
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 21:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93B69E2BA8
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DF7189906;
	Sat, 17 May 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="1Zq9SrJa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157A4B1E79
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747510243; cv=none; b=d76S6Ryd1sjaxJBcVD0JSTZ6Vt1Xkb0VrsOglu7tXHh58bruAbObH0tB6eHbgqSidkB+7ybTIvHWkebY6H3SQrenMcuXFQfw9pj2fOQHopUiR2wgU9V+JmR/FcnQWA/Fnlrg13wg5kJ3kJz1gEsVEhDOEHZnL0x9mpDcr4wJ70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747510243; c=relaxed/simple;
	bh=PzHxaeBkJwxBjyOaBflM2DFiwv+DHux/YO0heqr5L9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlalOuYj/4jwWbFi06G1ckLlJySqraEdcrmur7g29cf5tLtdVLAa4kXSO+ALNi3J7kIrFzcheDnwgCtxe4tyl6vhAqRmhN/itZ/54DerP4BGTCYY9EyZn3XtbOC/+9vZTBc0+3QgWgZYwTX+LFrXwnOXORDbkGcsnK5A5JblmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=1Zq9SrJa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739ab4447c7so483014b3a.0
        for <netdev@vger.kernel.org>; Sat, 17 May 2025 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747510240; x=1748115040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7l0p8CaQ/XFmABztCQ+JzuVdL1ScH6EF1ATeQN94o8=;
        b=1Zq9SrJaLar7jI8gONYDtkWTo8mPMZ1q8pbqyxLgE7+XoRWnIfrM6ybRwLmBS++8ra
         3+NFmmfKc1D11q5+/jcNprxZ1DkXI9/tq5mHdkhMfjdfdrOZwkHv6SIzGgouJU66sJvH
         pcNIbOXUFYIXqwawFXMBAW0HIDK2z9LMrNS1kF3/fEoXokz+hIUKjvXiiT5JAYJe1VNs
         MCMkiXDqt2KH7mjZ4jA0Ld+/RwxQyJBMmHwT0d8BcFxvSH5H77/dA364lcMEcfi3C9k6
         smf9o0tgdRAJJ+wJd9+IdI8J+kHvCl8XL+grSMkt9vgJefptcKNukCtN4kosEuvn+tt2
         evKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747510240; x=1748115040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7l0p8CaQ/XFmABztCQ+JzuVdL1ScH6EF1ATeQN94o8=;
        b=cx35p8aJ9bCYYgaYvLvvBKJV0DSCnT9Lf7Rsg+8szJdi1XJSFOLSB+HQrqKy+UPZbN
         Q2OV4cMBBI+/Rei1JsktSyoe3NkVT4Q+Wi6yeaPEjUSwyajGQHGUYQoCC++PdUZP/Yfl
         BsxRxlhkVKrkzdanOjiIp0MXCrW08xXVb3JEK4oAq4i7skQWjGRJ5IrLPqaytLOfRzJv
         hRq71hvcBwMyd+AMl0EyGH55YHTpD635TRAOshZFhX88qtc9cx8Squli+OPrGzEwbEzy
         hUFdcbr81jYCa89cl2j4Xft6gHZeeFh/wooL+h1y5bFeCSstv4wxDs5lph/ni20gPWdk
         5dog==
X-Forwarded-Encrypted: i=1; AJvYcCXSU6ddOyzTbYTiQSFSmf6n98wZ89B3mAjMZrXARj0OpzlwDM31n2UcrqBgjqaiC6HYi6Ia5ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLGmrMR+5Lsbz/tLZQ2NeSsJbSfwGNKjFT4PzqxJivRl2K0j3
	TMJA0K/O/1BWopC41JiP3+u/hTy+rmMDhJ9HVyNuSLxK3ZnJF5yUn0ZoDa6e4oeIcpM=
X-Gm-Gg: ASbGncsBdjWUmESnFGDjFmUwfO1dwaR7RpCJ+8fbxFd4jWaulpfTGN0zcvBJaK2P/DL
	euxn6Qxm5KaqXMyfIgADNX+t2/4ZdUOcGA+x0r/K0ZMRNoELeNPGzqift36oQwjGTzyFDBqHcA8
	kjqsw5GxsxRVRLb8ULq8gBXDMHjl+XVHuB8g+UYgJxui4UwaPhqn8okm1S9SwPXNbMpfsQjk3l1
	OMr4lH/hUy2wZsZnXHPM/BMDKjAwO09sIV/3mh4rHT/6YZZpGE1NLyAiV+iw/vRN5u9vTHIGnTD
	G6/Uil2KDqHb4mkbJ+kGLGMMiGzQwz7KJ/hGG/M1FlRw5yL2KJA=
X-Google-Smtp-Source: AGHT+IGEraykoYstz5Xzl781U8iMZXW7h88E1vbeQWD49pAFFxZSEUjuHAukjls3PDkLENkXTnXLFA==
X-Received: by 2002:a05:6a21:3a8f:b0:1ee:dd0f:2c72 with SMTP id adf61e73a8af0-21819c04410mr1723458637.1.1747510239547;
        Sat, 17 May 2025 12:30:39 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:51db:41c9:89d4:648c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb084650sm3508814a12.61.2025.05.17.12.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 12:30:39 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: wireguard@lists.zx2c4.com,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [RESEND PATCH v1 wireguard-tools] ipc: linux: Support incremental allowed ips updates
Date: Sat, 17 May 2025 12:29:51 -0700
Message-ID: <20250517192955.594735-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the interface of `wg set` to leverage the WGALLOWEDIP_F_REMOVE_ME
flag, a direct way of removing a single allowed ip from a peer,
allowing for incremental updates to a peer's configuration. By default,
allowed-ips fully replaces a peer's allowed ips using
WGPEER_REPLACE_ALLOWEDIPS under the hood. When '+' or '-' is prepended
to any ip in the list, wg clears WGPEER_F_REPLACE_ALLOWEDIPS and sets
the WGALLOWEDIP_F_REMOVE_ME flag on any ip prefixed with '-'.

$ wg set wg0 peer <PUBKEY> allowed-ips +192.168.88.0/24,-192.168.0.1/32

This command means "add 192.168.88.0/24 to this peer's allowed ips if
not present, and remove 192.168.0.1/32 if present".

Use -isystem so that headers in uapi/ take precedence over system
headers; otherwise, the build will fail on systems running kernels
without the WGALLOWEDIP_F_REMOVE_ME flag.

Note that this patch is meant to be merged alongside the kernel patch
that introduces the flag.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 src/Makefile                     |  2 +-
 src/config.c                     | 27 +++++++++++++++++++++++++++
 src/containers.h                 |  5 +++++
 src/ipc-linux.h                  |  2 ++
 src/man/wg.8                     |  8 ++++++--
 src/set.c                        |  2 +-
 src/uapi/linux/linux/wireguard.h |  9 +++++++++
 7 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 0533910..1c4b3f6 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -39,7 +39,7 @@ PLATFORM ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
 
 CFLAGS ?= -O3
 ifneq ($(wildcard uapi/$(PLATFORM)/.),)
-CFLAGS += -idirafter uapi/$(PLATFORM)
+CFLAGS += -isystem uapi/$(PLATFORM)
 endif
 CFLAGS += -std=gnu99 -D_GNU_SOURCE
 CFLAGS += -Wall -Wextra
diff --git a/src/config.c b/src/config.c
index 81ccb47..b740f73 100644
--- a/src/config.c
+++ b/src/config.c
@@ -337,6 +337,29 @@ static bool validate_netmask(struct wgallowedip *allowedip)
 	return true;
 }
 
+#if defined(__linux__)
+static inline void parse_ip_prefix(struct wgpeer *peer, uint32_t *flags, char **mask)
+{
+	/* If the IP is prefixed with either '+' or '-' consider
+	 * this an incremental change. Disable WGPEER_REPLACE_ALLOWEDIPS.
+	 */
+	switch ((*mask)[0]) {
+	case '-':
+		*flags |= WGALLOWEDIP_REMOVE_ME;
+		/* fall through */
+	case '+':
+		peer->flags &= ~WGPEER_REPLACE_ALLOWEDIPS;
+		(*mask)++;
+	}
+}
+#else
+static inline void parse_ip_prefix(struct wgpeer *peer __attribute__ ((unused)),
+				   uint32_t *flags     __attribute__ ((unused)),
+				   char **mask         __attribute__ ((unused)))
+{
+}
+#endif
+
 static inline bool parse_allowedips(struct wgpeer *peer, struct wgallowedip **last_allowedip, const char *value)
 {
 	struct wgallowedip *allowedip = *last_allowedip, *new_allowedip;
@@ -353,9 +376,12 @@ static inline bool parse_allowedips(struct wgpeer *peer, struct wgallowedip **la
 	}
 	sep = mutable;
 	while ((mask = strsep(&sep, ","))) {
+		uint32_t flags = 0;
 		unsigned long cidr;
 		char *end, *ip;
 
+		parse_ip_prefix(peer, &flags, &mask);
+
 		saved_entry = strdup(mask);
 		ip = strsep(&mask, "/");
 
@@ -387,6 +413,7 @@ static inline bool parse_allowedips(struct wgpeer *peer, struct wgallowedip **la
 		else
 			goto err;
 		new_allowedip->cidr = cidr;
+		new_allowedip->flags = flags;
 
 		if (!validate_netmask(new_allowedip))
 			fprintf(stderr, "Warning: AllowedIP has nonzero host part: %s/%s\n", ip, mask);
diff --git a/src/containers.h b/src/containers.h
index a82e8dd..8fd813a 100644
--- a/src/containers.h
+++ b/src/containers.h
@@ -28,6 +28,10 @@ struct timespec64 {
 	int64_t tv_nsec;
 };
 
+enum {
+	WGALLOWEDIP_REMOVE_ME = 1U << 0,
+};
+
 struct wgallowedip {
 	uint16_t family;
 	union {
@@ -35,6 +39,7 @@ struct wgallowedip {
 		struct in6_addr ip6;
 	};
 	uint8_t cidr;
+	uint32_t flags;
 	struct wgallowedip *next_allowedip;
 };
 
diff --git a/src/ipc-linux.h b/src/ipc-linux.h
index d29c0c5..01247f1 100644
--- a/src/ipc-linux.h
+++ b/src/ipc-linux.h
@@ -228,6 +228,8 @@ again:
 				}
 				if (!mnl_attr_put_u8_check(nlh, SOCKET_BUFFER_SIZE, WGALLOWEDIP_A_CIDR_MASK, allowedip->cidr))
 					goto toobig_allowedips;
+				if (allowedip->flags && !mnl_attr_put_u32_check(nlh, SOCKET_BUFFER_SIZE, WGALLOWEDIP_A_FLAGS, allowedip->flags))
+					goto toobig_allowedips;
 				mnl_attr_nest_end(nlh, allowedip_nest);
 				allowedip_nest = NULL;
 			}
diff --git a/src/man/wg.8 b/src/man/wg.8
index 7984539..1ec68df 100644
--- a/src/man/wg.8
+++ b/src/man/wg.8
@@ -55,7 +55,7 @@ transfer-rx, transfer-tx, persistent-keepalive.
 Shows the current configuration of \fI<interface>\fP in the format described
 by \fICONFIGURATION FILE FORMAT\fP below.
 .TP
-\fBset\fP \fI<interface>\fP [\fIlisten-port\fP \fI<port>\fP] [\fIfwmark\fP \fI<fwmark>\fP] [\fIprivate-key\fP \fI<file-path>\fP] [\fIpeer\fP \fI<base64-public-key>\fP [\fIremove\fP] [\fIpreshared-key\fP \fI<file-path>\fP] [\fIendpoint\fP \fI<ip>:<port>\fP] [\fIpersistent-keepalive\fP \fI<interval seconds>\fP] [\fIallowed-ips\fP \fI<ip1>/<cidr1>\fP[,\fI<ip2>/<cidr2>\fP]...] ]...
+\fBset\fP \fI<interface>\fP [\fIlisten-port\fP \fI<port>\fP] [\fIfwmark\fP \fI<fwmark>\fP] [\fIprivate-key\fP \fI<file-path>\fP] [\fIpeer\fP \fI<base64-public-key>\fP [\fIremove\fP] [\fIpreshared-key\fP \fI<file-path>\fP] [\fIendpoint\fP \fI<ip>:<port>\fP] [\fIpersistent-keepalive\fP \fI<interval seconds>\fP] [\fIallowed-ips\fP \fI[+|-]<ip1>/<cidr1>\fP[,\fI[+|-]<ip2>/<cidr2>\fP]...] ]...
 Sets configuration values for the specified \fI<interface>\fP. Multiple
 \fIpeer\fPs may be specified, and if the \fIremove\fP argument is given
 for a peer, that peer is removed, not configured. If \fIlisten-port\fP
@@ -72,7 +72,11 @@ the device. The use of \fIpreshared-key\fP is optional, and may be omitted;
 it adds an additional layer of symmetric-key cryptography to be mixed into
 the already existing public-key cryptography, for post-quantum resistance.
 If \fIallowed-ips\fP is specified, but the value is the empty string, all
-allowed ips are removed from the peer. The use of \fIpersistent-keepalive\fP
+allowed ips are removed from the peer. By default, \fIallowed-ips\fP replaces
+a peer's allowed ips. (Linux only) If + or - is prepended to any of the ips then
+the update is incremental; ips prefixed with '+' or '' are added to the peer's
+allowed ips if not present while ips prefixed with '-' are removed if present.
+The use of \fIpersistent-keepalive\fP
 is optional and is by default off; setting it to 0 or "off" disables it.
 Otherwise it represents, in seconds, between 1 and 65535 inclusive, how often
 to send an authenticated empty packet to the peer, for the purpose of keeping
diff --git a/src/set.c b/src/set.c
index 75560fd..992ffa2 100644
--- a/src/set.c
+++ b/src/set.c
@@ -18,7 +18,7 @@ int set_main(int argc, const char *argv[])
 	int ret = 1;
 
 	if (argc < 3) {
-		fprintf(stderr, "Usage: %s %s <interface> [listen-port <port>] [fwmark <mark>] [private-key <file path>] [peer <base64 public key> [remove] [preshared-key <file path>] [endpoint <ip>:<port>] [persistent-keepalive <interval seconds>] [allowed-ips <ip1>/<cidr1>[,<ip2>/<cidr2>]...] ]...\n", PROG_NAME, argv[0]);
+		fprintf(stderr, "Usage: %s %s <interface> [listen-port <port>] [fwmark <mark>] [private-key <file path>] [peer <base64 public key> [remove] [preshared-key <file path>] [endpoint <ip>:<port>] [persistent-keepalive <interval seconds>] [allowed-ips [+|-]<ip1>/<cidr1>[,[+|-]<ip2>/<cidr2>]...] ]...\n", PROG_NAME, argv[0]);
 		return 1;
 	}
 
diff --git a/src/uapi/linux/linux/wireguard.h b/src/uapi/linux/linux/wireguard.h
index 0efd52c..6ca266a 100644
--- a/src/uapi/linux/linux/wireguard.h
+++ b/src/uapi/linux/linux/wireguard.h
@@ -101,6 +101,10 @@
  *                    WGALLOWEDIP_A_FAMILY: NLA_U16
  *                    WGALLOWEDIP_A_IPADDR: struct in_addr or struct in6_addr
  *                    WGALLOWEDIP_A_CIDR_MASK: NLA_U8
+ *                    WGALLOWEDIP_A_FLAGS: NLA_U32, WGALLOWEDIP_F_REMOVE_ME if
+ *                                         the specified IP should be removed;
+ *                                         otherwise, this IP will be added if
+ *                                         it is not already present.
  *                0: NLA_NESTED
  *                    ...
  *                0: NLA_NESTED
@@ -184,11 +188,16 @@ enum wgpeer_attribute {
 };
 #define WGPEER_A_MAX (__WGPEER_A_LAST - 1)
 
+enum wgallowedip_flag {
+	WGALLOWEDIP_F_REMOVE_ME = 1U << 0,
+	__WGALLOWEDIP_F_ALL = WGALLOWEDIP_F_REMOVE_ME
+};
 enum wgallowedip_attribute {
 	WGALLOWEDIP_A_UNSPEC,
 	WGALLOWEDIP_A_FAMILY,
 	WGALLOWEDIP_A_IPADDR,
 	WGALLOWEDIP_A_CIDR_MASK,
+	WGALLOWEDIP_A_FLAGS,
 	__WGALLOWEDIP_A_LAST
 };
 #define WGALLOWEDIP_A_MAX (__WGALLOWEDIP_A_LAST - 1)
-- 
2.43.0


