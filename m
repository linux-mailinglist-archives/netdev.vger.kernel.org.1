Return-Path: <netdev+bounces-193337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4FAC38DE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884BB7A1729
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 05:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCA71AF0A4;
	Mon, 26 May 2025 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="Ic1RnCGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B6320F
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748236097; cv=none; b=Hqw2E9+mh95hU1nEIBtDysEC3g+OFB1nw5z1e6lMkmMnz00L5UeVfC3as1MvgeDK/iFYsuu/CiPSNwfI7L4iO4cf9MIkmizTh8jL7UiXvQftFFmQlte0L5k3rAT9GIAfbO6fBIjGWGYyJfZSjdsjpDqbnycorDtcQv2GOLf/gz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748236097; c=relaxed/simple;
	bh=VN3uKbL1JqOpb7xEOcPjFAJ2oOJbhSAV/lt65qfGpCY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eGNRdGoRgVoR1a+fgP5GMjZ3T2betDcGiSsu0FvnNqtXWHRa8qoanlc5NVPwqKqaZOf+RaE1qQ9K2/f8RW1CcjUk7pG5uK13F6khHlonyLdpVJ+1zpzIJxiQHqnhJzo6pHjaMCq5v86UZMTChkYaIpv5LHpwON5y19UeaTmwrgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=Ic1RnCGr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441ab63a415so21290465e9.3
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 22:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1748236092; x=1748840892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ywmyN/RiFF7WteRQHUKPH3zi5cyGT7RpRE4XhtfXD3Q=;
        b=Ic1RnCGrmbto5he7xm8ingV94/4jNJ3MimwhNbJRNn01noUCtwTKxh+0gsQ7niSgNn
         ZldYlZOm8YjokVNwrbjzCWz3ITuAhNokqMWbLz0S3cEOqEOcekXePPe84b530wSNyd/s
         aIFsH7dSjiCX8fXI9xKnhfV2+qLQXWc/ksBH3ran1kJ597x1SpuyJp0FLg4uL0R+gRsp
         sE1H8ytDQhRS6suc486V+4n7YaroVXJUiOCSOXSQ8uL5QHjOt50T7oE3Pj4P7CoX7wbl
         TCU4tkmU22gOQzlPGdxb4jK/iVpW34fj3N/FPFeFxLOVyn5HiFpUjXK4i8HIMbAaLHvq
         79Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748236092; x=1748840892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywmyN/RiFF7WteRQHUKPH3zi5cyGT7RpRE4XhtfXD3Q=;
        b=k/9GYRHSqSmO+yjgyXzIqjP2QznQOdT6G5WGzdf8hCBhsyJiZVMJX73otJ51AyZqjC
         nF9kpy+UWcK5zB08rFMxIBpl/zffmZmu4empV7pKeKQKwGd57Xy2Rz+JDUGBiQzFOdsi
         SlxD3GkJ6SPOkrF5lDFE7IVz5BeRqHtaqsj6y2Mm96gPG+VcxRdCKIDlBlN9nW3Y8dK6
         YBsNL0th7vXr7lylWumu6qDKxKx9rOrxuuD1SW2x8Eh4QIoU2YBp/Sq+uEqRHE1HIcOV
         pibo9D0Mishpg3Pc9FaBl+1srjVLvON4i72X7sgXcLDWzfbf/8ma8y0oFA1ZKs6wd1NT
         p+eg==
X-Forwarded-Encrypted: i=1; AJvYcCVTi3oZxmed6kTm1p4WefHQk5DYqa26HPvRxdy+KfWUezuFhs+oZfWsC99ouN6OjXbk/jnIIMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwByzPDii6D+znUFAMBMcuSM9CQlE3LocFlniQyLV7yhrNTb0Gt
	3Qyd1ZZdpKSmYHYzJI5KOkw7Z8Nwj7+WnReJ1RYG5Bq4AcWTfdtwoXymjJY/URnbe1eBaqDRCmk
	fpjBcb5wBfqWhQHPJugxMmZ6VR0wcmSghwDyEEjV6KQ==
X-Gm-Gg: ASbGncuxQPBO0FYHyxnwomnRjuiPi49ry8cEoPHML712i8xIy4wLc+8D0tqB/HH/l5d
	UHWeDtEjoJQpw2G1qqfaDwLO5JLvVzHQTHUzXm7qhFNtjlY5oYc33RnID3+yM0nqLXDAtV92F/s
	EBoBQ+8CK7fxBxn3ZG8OCTrPauOjvUjqM+bANVA6Cfynf2rRaYUbPReiVuwfyPPhJe8FuAMArIt
	F+U
X-Google-Smtp-Source: AGHT+IHQtcTKnTqIqu1AWfIXts75t/CEdk2U0zHZsJFQRNgEtFrrICKZ1gNLvc7nyaNDbGUkXhq5BKtnb5bMzcgZXLo=
X-Received: by 2002:a05:600c:6215:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-44c932f9411mr60425455e9.25.1748236092265; Sun, 25 May 2025
 22:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Date: Mon, 26 May 2025 14:08:01 +0900
X-Gm-Features: AX0GCFsCp7T-RWT5r2wyD3bTuMWuFueQJ7SnXQQHT4ejrzVyXl82yc9Vvz4Q4nc
Message-ID: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
Subject: [PATCH net] bonding: Fix header_ops type confusion
To: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Cc: =?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In bond_setup_by_slave(), the slave=E2=80=99s header_ops are unconditionall=
y
copied into the bonding device. As a result, the bonding device may invoke
the slave-specific header operations on itself, causing
netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
as the slave's private-data type.

This type-confusion bug can lead to out-of-bounds writes into the skb,
resulting in memory corruption.

This patch adds two members to struct bonding, bond_header_ops and
header_slave_dev, to avoid type-confusion while keeping track of the
slave's header_ops.

Fixes: 1284cd3a2b740 (bonding: two small fixes for IPoIB support)
Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Co-Developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
---
 drivers/net/bonding/bond_main.c | 61
++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/net/bonding.h           |  5 +++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 8ea183da8d53..690f3e0971d0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1619,14 +1619,65 @@ static void bond_compute_features(struct bonding *b=
ond)
     netdev_change_features(bond_dev);
 }

+static int bond_hard_header(struct sk_buff *skb, struct net_device *dev,
+        unsigned short type, const void *daddr,
+        const void *saddr, unsigned int len)
+{
+    struct bonding *bond =3D netdev_priv(dev);
+    struct net_device *slave_dev;
+
+    slave_dev =3D bond->header_slave_dev;
+
+    return dev_hard_header(skb, slave_dev, type, daddr, saddr, len);
+}
+
+static void bond_header_cache_update(struct hh_cache *hh, const
struct net_device *dev,
+        const unsigned char *haddr)
+{
+    const struct bonding *bond =3D netdev_priv(dev);
+    struct net_device *slave_dev;
+
+    slave_dev =3D bond->header_slave_dev;
+
+    if (!slave_dev->header_ops || !slave_dev->header_ops->cache_update)
+        return;
+
+    slave_dev->header_ops->cache_update(hh, slave_dev, haddr);
+}
+
 static void bond_setup_by_slave(struct net_device *bond_dev,
                 struct net_device *slave_dev)
 {
+    struct bonding *bond =3D netdev_priv(bond_dev);
     bool was_up =3D !!(bond_dev->flags & IFF_UP);

     dev_close(bond_dev);

-    bond_dev->header_ops        =3D slave_dev->header_ops;
+    /* Some functions are given dev as an argument
+     * while others not. When dev is not given, we cannot
+     * find out what is the slave device through struct bonding
+     * (the private data of bond_dev). Therefore, we need a raw
+     * header_ops variable instead of its pointer to const header_ops
+     * and assign slave's functions directly.
+     * For the other case, we set the wrapper functions that pass
+     * slave_dev to the wrapped functions.
+     */
+    bond->bond_header_ops.create =3D bond_hard_header;
+    bond->bond_header_ops.cache_update =3D bond_header_cache_update;
+    if (slave_dev->header_ops) {
+        bond->bond_header_ops.parse =3D slave_dev->header_ops->parse;
+        bond->bond_header_ops.cache =3D slave_dev->header_ops->cache;
+        bond->bond_header_ops.validate =3D slave_dev->header_ops->validate=
;
+        bond->bond_header_ops.parse_protocol =3D
slave_dev->header_ops->parse_protocol;
+    } else {
+        bond->bond_header_ops.parse =3D NULL;
+        bond->bond_header_ops.cache =3D NULL;
+        bond->bond_header_ops.validate =3D NULL;
+        bond->bond_header_ops.parse_protocol =3D NULL;
+    }
+
+    bond->header_slave_dev      =3D slave_dev;
+    bond_dev->header_ops        =3D &bond->bond_header_ops;

     bond_dev->type            =3D slave_dev->type;
     bond_dev->hard_header_len   =3D slave_dev->hard_header_len;
@@ -2676,6 +2727,14 @@ static int bond_release_and_destroy(struct
net_device *bond_dev,
     struct bonding *bond =3D netdev_priv(bond_dev);
     int ret;

+    /* If slave_dev is the earliest registered one, we must clear
+     * the variables related to header_ops to avoid dangling pointer.
+     */
+    if (bond->header_slave_dev =3D=3D slave_dev) {
+        bond->header_slave_dev =3D NULL;
+        bond_dev->header_ops =3D NULL;
+    }
+
     ret =3D __bond_release_one(bond_dev, slave_dev, false, true);
     if (ret =3D=3D 0 && !bond_has_slaves(bond) &&
         bond_dev->reg_state !=3D NETREG_UNREGISTERING) {
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308c19..cf8206187ce9 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -215,6 +215,11 @@ struct bond_ipsec {
  */
 struct bonding {
     struct   net_device *dev; /* first - useful for panic debug */
+    struct   net_device *header_slave_dev;  /* slave net_device for
header_ops */
+    /* maintained as a non-const variable
+     * because bond's header_ops should change depending on slaves.
+     */
+    struct   header_ops bond_header_ops;
     struct   slave __rcu *curr_active_slave;
     struct   slave __rcu *current_arp_slave;
     struct   slave __rcu *primary_slave;

