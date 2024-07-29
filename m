Return-Path: <netdev+bounces-113827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E49400CA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCFF1C22651
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFCD18E743;
	Mon, 29 Jul 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDLEhkGc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A47E58D
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290476; cv=none; b=EW7G42a5pF/69MfZmWIzc1JjC2PyQNELutPoZH03kMySKTCkMeIdOrIYU7WbyVrGrHayNilVCljjkcjwom/mJs8EzxDYD5b4RTbG5kCv/orVnrfec/oMZRN0Jqm7m/PnlkdML8LBy7c621tfOeuAPgrJf5EShSmGcWQxrri4VEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290476; c=relaxed/simple;
	bh=XJnJPKl6k4rR66kbaouimkNBomtd+aY7wEs9T53fPio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gT05kzIcvJ2QbKUBRWx5m0tqD51qm8ml5VVdzRNIq9KHTLTx6pfS8yM/8i0W/Ine1hH/vWQby1A52H/emZVeyF5+0qh81FT0UMzPm5dxB3PkbSic25Xj5FbG4PwNq+6+6XCZFxvipCg68z0/mpKmIoScuIsPZylBivmrIEW8HBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--prohr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDLEhkGc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--prohr.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e087ed145caso4537244276.3
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722290474; x=1722895274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmEC+vBSWhMJr7hZmB+mz7nYIOW4vfmDm0ALSisHKII=;
        b=eDLEhkGcigf29WCGQlcDg8DBF2Sg02OSSbG5l2ybnN4A0OMAsJ1vlSxF7wNOlJMo6s
         U/TBxHunpTCk/m7aJaEqwK3r9KFsxLmNaF5R4HwfCuSOx8ZF8Ofu0/3Y5sgrrJpQ3H3x
         T1PsbvTuLR5iPr6Ha+jDV0uiOsmCmSBltIj25M04ov0Xc5m4ORW8UYwNdYt42T+bKvzm
         baO+AnVd4q2u8jhGf/RFqHfyiWT6H2UtlYqDqPZ6jgCtkf+aOF0l6Q7YEATjCFmQiaze
         jOu7pg7YTyETHKK16RAbXocpBNNWuBa9zjMysORb9adIWFYZ0HoiVtUUqqm27DDY4BMZ
         iqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290474; x=1722895274;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmEC+vBSWhMJr7hZmB+mz7nYIOW4vfmDm0ALSisHKII=;
        b=REWu1uhyltIBSUaIOJlFdXZNrRvMZMAXhoAklyWRoDkDc6LTb7sG19mG7ZZf+QfLaO
         evb0GXGVZTYRxTX9dkPpqFUQnKWGeo2icAkHKriZaewtmgOQum0zjM4lmFLG4XX3s5f9
         hw8N9kF9syrG/Q9+tKTOKBUOj8ZlqBX3dYQi2TGVFkPIw4GBhM4NGyX2i8Ynbw4eLRjE
         J4/EkXBLtD9Cdorq8nLy05lboG5aTMfbbB5QCkmqR2t/tcgCkRk92SWmS8eFR5axi/eK
         qP9jFseTwe1nxbEAWJzgC1NOvRACNEzlzXXvvOdssY5Rzc4mgMYFXciTwPlAD8v+0He2
         kRew==
X-Gm-Message-State: AOJu0YzBFc567mhN35kPiSsZYrBkNlHC2Kvu3hUO/ClLuU+lQ7GNyZJ7
	TyEzhoqXCxIdGOEmFMplA0XZwlBATPVC1zhlpwvRSyPcPCIAUn74LolK9E5IWax7aOdgJZOwFA=
	=
X-Google-Smtp-Source: AGHT+IFRYIg5y0aQjnn1vPqTa4tVFCxy5z25n9bXTBYy/ueK8g5T5uD31bQF416LChe13HliDNXteQQupQ==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:5e6e:b2c2:4fea:7f19])
 (user=prohr job=sendgmr) by 2002:a5b:943:0:b0:e0b:4eb5:510a with SMTP id
 3f1490d57ef6-e0b5445d9eemr306533276.4.1722290474045; Mon, 29 Jul 2024
 15:01:14 -0700 (PDT)
Date: Mon, 29 Jul 2024 15:00:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240729220059.3018247-1-prohr@google.com>
Subject: [PATCH net-next v2] Add support for PIO p flag
From: Patrick Rohr <prohr@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	David Lamparter <equinox@opensourcerouting.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

draft-ietf-6man-pio-pflag is adding a new flag to the Prefix Information
Option to signal that the network can allocate a unique IPv6 prefix per
client via DHCPv6-PD (see draft-ietf-v6ops-dhcp-pd-per-device).

When ra_honor_pio_pflag is enabled, the presence of a P-flag causes
SLAAC autoconfiguration to be disabled for that particular PIO.

An automated test has been added in Android (r.android.com/3195335) to
go along with this change.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: David Lamparter <equinox@opensourcerouting.org>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Patrick Rohr <prohr@google.com>
---
 Documentation/networking/ip-sysctl.rst | 14 ++++++++++++++
 include/linux/ipv6.h                   |  1 +
 include/net/addrconf.h                 | 10 +++++++---
 net/ipv6/addrconf.c                    | 15 ++++++++++++++-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index 3616389c8c2d..eacf8983e230 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2362,6 +2362,20 @@ ra_honor_pio_life - BOOLEAN
=20
 	Default: 0 (disabled)
=20
+ra_honor_pio_pflag - BOOLEAN
+	The Prefix Information Option P-flag indicates the network can
+	allocate a unique IPv6 prefix per client using DHCPv6-PD.
+	This sysctl can be enabled when a userspace DHCPv6-PD client
+	is running to cause the P-flag to take effect: i.e. the
+	P-flag suppresses any effects of the A-flag within the same
+	PIO. For a given PIO, P=3D1 and A=3D1 is treated as A=3D0.
+
+	- If disabled, the P-flag is ignored.
+	- If enabled, the P-flag will disable SLAAC autoconfiguration
+	  for the given Prefix Information Option.
+
+	Default: 0 (disabled)
+
 accept_ra_rt_info_min_plen - INTEGER
 	Minimum prefix length of Route Information in RA.
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 383a0ea2ab91..a6e2aadbb91b 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -89,6 +89,7 @@ struct ipv6_devconf {
 	__u8		ioam6_enabled;
 	__u8		ndisc_evict_nocarrier;
 	__u8		ra_honor_pio_life;
+	__u8		ra_honor_pio_pflag;
=20
 	struct ctl_table_header *sysctl_header;
 };
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 62a407db1bf5..b18e81f0c9e1 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -37,10 +37,14 @@ struct prefix_info {
 		struct __packed {
 #if defined(__BIG_ENDIAN_BITFIELD)
 			__u8	onlink : 1,
-			 	autoconf : 1,
-				reserved : 6;
+				autoconf : 1,
+				routeraddr : 1,
+				preferpd : 1,
+				reserved : 4;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-			__u8	reserved : 6,
+			__u8	reserved : 4,
+				preferpd : 1,
+				routeraddr : 1,
 				autoconf : 1,
 				onlink : 1;
 #else
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 55a0fd589fc8..4febf679a435 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -239,6 +239,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ioam6_id_wide		=3D IOAM6_DEFAULT_IF_ID_WIDE,
 	.ndisc_evict_nocarrier	=3D 1,
 	.ra_honor_pio_life	=3D 0,
+	.ra_honor_pio_pflag	=3D 0,
 };
=20
 static struct ipv6_devconf ipv6_devconf_dflt __read_mostly =3D {
@@ -302,6 +303,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ioam6_id_wide		=3D IOAM6_DEFAULT_IF_ID_WIDE,
 	.ndisc_evict_nocarrier	=3D 1,
 	.ra_honor_pio_life	=3D 0,
+	.ra_honor_pio_pflag	=3D 0,
 };
=20
 /* Check if link is ready: is it up and is a valid qdisc available */
@@ -2762,6 +2764,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
opt, int len, bool sllao)
 	u32 addr_flags =3D 0;
 	struct inet6_dev *in6_dev;
 	struct net *net =3D dev_net(dev);
+	bool ignore_autoconf =3D false;
=20
 	pinfo =3D (struct prefix_info *) opt;
=20
@@ -2864,7 +2867,8 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
opt, int len, bool sllao)
=20
 	/* Try to figure out our local address for this prefix */
=20
-	if (pinfo->autoconf && in6_dev->cnf.autoconf) {
+	ignore_autoconf =3D READ_ONCE(in6_dev->cnf.ra_honor_pio_pflag) && pinfo->=
preferpd;
+	if (pinfo->autoconf && in6_dev->cnf.autoconf && !ignore_autoconf) {
 		struct in6_addr addr;
 		bool tokenized =3D false, dev_addr_generated =3D false;
=20
@@ -6926,6 +6930,15 @@ static const struct ctl_table addrconf_sysctl[] =3D =
{
 		.extra1		=3D SYSCTL_ZERO,
 		.extra2		=3D SYSCTL_ONE,
 	},
+	{
+		.procname	=3D "ra_honor_pio_pflag",
+		.data		=3D &ipv6_devconf.ra_honor_pio_pflag,
+		.maxlen		=3D sizeof(u8),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dou8vec_minmax,
+		.extra1		=3D SYSCTL_ZERO,
+		.extra2		=3D SYSCTL_ONE,
+	},
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	{
 		.procname	=3D "accept_ra_rtr_pref",
--=20
2.46.0.rc1.232.g9752f9e123-goog


