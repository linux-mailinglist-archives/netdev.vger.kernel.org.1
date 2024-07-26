Return-Path: <netdev+bounces-113133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F8993CC39
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 03:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB04281177
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 01:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC36D80B;
	Fri, 26 Jul 2024 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5zLeFNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBEAD2D
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721955996; cv=none; b=LL12HraOAVl7u9viF8farNY0gDc/AGDpmSoxGmsg1sJ0BFLOMRAHSUWb573SX/yJEh2GHB3npAoTg8e3SFXzPKece0wXr8ufFfOEclt5VPF3SrTnNnlrLHjxCJVp5WgUnMEYLtakvScpqAQQlSyGMrVKR618P2+q7x0tzChiEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721955996; c=relaxed/simple;
	bh=Uh4MQlD82vSNoup83RKQ6r9QXdWD5HUMlYZukdkKH6k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qDJSokIxcDyPWONz988VqSQ9W2JaZ01oADvZHVsyAkwalXft1edeGpv7C0SDZy+4O8B+bHjV6hoPH3u/6slz9/6zVirJfcy1W2HyTFkWQFwdfn4kdq0I/ddZR7d6GwwtcTqBhITsZysJF1HfPixthMsqXp5YMCtDYIh3tzKBWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--prohr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5zLeFNi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--prohr.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035f7b5976so4433512276.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 18:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721955994; x=1722560794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ablXhylOaV+szIIh1rFKrx1sJi5HFmBEAmvD3bHKLcs=;
        b=P5zLeFNizMDhY1SWhjNrym41zDXZ2EOTnW/JEdsJgW6d6K+BB0IkJAXhueN8QKDrf2
         xt7DrTKr8RBbZYl4l9mdM/j8+ApvS+CXpZ7rdBMeB0Z4yZcfUd0HD9Hjp9NsbPnqynNd
         bbBTqX5iOAvwO3S+ZDmqZY2yANm9EpOJJVlSlo2Fsce28kE+yu9BZWH0Qh8+1As6r1qi
         NgwEwVEFqJygk6q5ji6u8MRxbN8JV4CLzM/GAkt/aK8fWyKytDsqWfB/T57dUuschau/
         b6T167Kj045a9R9KvD4AeDMftMnRt0ZyuyOxhjFrsa1SrXW3MXEk1S7D53WdK1yMdWtK
         PIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721955994; x=1722560794;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ablXhylOaV+szIIh1rFKrx1sJi5HFmBEAmvD3bHKLcs=;
        b=iqh+KsKb25JNlTb2GyBC5BRTJ9gRZNBHSn1EVQC5M9TRiQzf3M8lTKsqHJrknVnlO7
         hB/G5SOduIc0gWoeoAjU25FmiAqNdJ0ZaIrnWfNV6uL9/yZyttxwVTCezuksoZWNgawW
         3P2/eR2UWvtjMbIVNCtkGpjQUiE5tMcU31GiQLYOt8H1+e6/T/SceMda70iK/RSoeHq4
         k2b4TZSqldpaHsaJFMHopbGv8ga5aYKVPIQS2OJIm+QhTQ1xKOZoCDS1TeIGo/iaTuPe
         2x3TH+ZHvZEfJ4YsyD84nllvVe4e05z4s2lH62HxJZtqqZOZUm0tk40inIjTLKndSZLs
         Y6/w==
X-Gm-Message-State: AOJu0YzcZXRYHhidRWdEjjzs5YzkjBAxMTuDjiQrK+LKXAjtLY76/skY
	bGvW5MIEnZ7R1/R63bY8MJjY/w9/pXaAwrOe35CL/TwFS7brGDthK6AixX+yBgEcjtgvsOVahQ=
	=
X-Google-Smtp-Source: AGHT+IHgcdUdCfDR5SDVp0OkFkho2J9I7YtU9dvwgPeCbveFm8DcYhMpmwOdevhxqxN3Ssn2F9Hg7Tr8JQ==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:709b:73ce:5137:a99f])
 (user=prohr job=sendgmr) by 2002:a25:9c08:0:b0:e0b:2dfe:d74b with SMTP id
 3f1490d57ef6-e0b2dfeef87mr23823276.0.1721955994219; Thu, 25 Jul 2024 18:06:34
 -0700 (PDT)
Date: Thu, 25 Jul 2024 18:06:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726010629.111077-1-prohr@google.com>
Subject: [PATCH net-next] Add support for PIO p flag
From: Patrick Rohr <prohr@google.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	David Lamparter <equinox@opensourcerouting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

draft-ietf-6man-pio-pflag is adding a new flag to the Prefix Information
Option to signal the pd-per-device addressing mechanism.

When accept_pio_pflag is enabled, the presence of the p-flag will cause
an a flag in the same PIO to be ignored.

An automated test has been added in Android (r.android.com/3195335) to
go along with this change.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: David Lamparter <equinox@opensourcerouting.org>
Signed-off-by: Patrick Rohr <prohr@google.com>
---
 Documentation/networking/ip-sysctl.rst | 11 +++++++++++
 include/linux/ipv6.h                   |  1 +
 include/net/addrconf.h                 |  8 ++++++--
 net/ipv6/addrconf.c                    | 15 ++++++++++++++-
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index 3616389c8c2d..322a0329b366 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2362,6 +2362,17 @@ ra_honor_pio_life - BOOLEAN
=20
 	Default: 0 (disabled)
=20
+accept_pio_pflag - BOOLEAN
+	Used to indicate userspace support for a DHCPv6-PD client.
+	If enabled, the presence of the PIO p flag indicates to the
+	kernel to ignore the autoconf flag.
+
+	- If disabled, the P flag is ignored.
+	- If enabled, disables SLAAC to obtain new addresses from
+	  prefixes with the P flag set.
+
+	Default: 0 (disabled)
+
 accept_ra_rt_info_min_plen - INTEGER
 	Minimum prefix length of Route Information in RA.
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 383a0ea2ab91..396b87d76b55 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -89,6 +89,7 @@ struct ipv6_devconf {
 	__u8		ioam6_enabled;
 	__u8		ndisc_evict_nocarrier;
 	__u8		ra_honor_pio_life;
+	__u8		accept_pio_pflag;
=20
 	struct ctl_table_header *sysctl_header;
 };
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 62a407db1bf5..59496aa23012 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -38,9 +38,13 @@ struct prefix_info {
 #if defined(__BIG_ENDIAN_BITFIELD)
 			__u8	onlink : 1,
 			 	autoconf : 1,
-				reserved : 6;
+			 	routeraddr : 1,
+				pdpreferred : 1,
+				reserved : 4;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-			__u8	reserved : 6,
+			__u8	reserved : 4,
+				pdpreferred : 1,
+			 	routeraddr : 1,
 				autoconf : 1,
 				onlink : 1;
 #else
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 55a0fd589fc8..3e27725a12fc 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -239,6 +239,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ioam6_id_wide		=3D IOAM6_DEFAULT_IF_ID_WIDE,
 	.ndisc_evict_nocarrier	=3D 1,
 	.ra_honor_pio_life	=3D 0,
+	.accept_pio_pflag	=3D 0,
 };
=20
 static struct ipv6_devconf ipv6_devconf_dflt __read_mostly =3D {
@@ -302,6 +303,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ioam6_id_wide		=3D IOAM6_DEFAULT_IF_ID_WIDE,
 	.ndisc_evict_nocarrier	=3D 1,
 	.ra_honor_pio_life	=3D 0,
+	.accept_pio_pflag	=3D 0,
 };
=20
 /* Check if link is ready: is it up and is a valid qdisc available */
@@ -2762,6 +2764,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
opt, int len, bool sllao)
 	u32 addr_flags =3D 0;
 	struct inet6_dev *in6_dev;
 	struct net *net =3D dev_net(dev);
+	bool ignore_autoconf_flag =3D false;
=20
 	pinfo =3D (struct prefix_info *) opt;
=20
@@ -2864,7 +2867,8 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
opt, int len, bool sllao)
=20
 	/* Try to figure out our local address for this prefix */
=20
-	if (pinfo->autoconf && in6_dev->cnf.autoconf) {
+	ignore_autoconf_flag =3D READ_ONCE(in6_dev->cnf.accept_pio_pflag) && pinf=
o->pdpreferred;
+	if (pinfo->autoconf && in6_dev->cnf.autoconf && !ignore_autoconf_flag) {
 		struct in6_addr addr;
 		bool tokenized =3D false, dev_addr_generated =3D false;
=20
@@ -6926,6 +6930,15 @@ static const struct ctl_table addrconf_sysctl[] =3D =
{
 		.extra1		=3D SYSCTL_ZERO,
 		.extra2		=3D SYSCTL_ONE,
 	},
+	{
+		.procname	=3D "accept_pio_pflag",
+		.data		=3D &ipv6_devconf.accept_pio_pflag,
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


