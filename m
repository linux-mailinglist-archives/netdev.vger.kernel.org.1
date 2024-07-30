Return-Path: <netdev+bounces-113864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E0940256
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 02:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98081283B6A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DCC442C;
	Tue, 30 Jul 2024 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlL2qIzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655ED17D2
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299415; cv=none; b=KW2G82YAIeNpIyvdUrN1FYfclgh0kPgTjvaI9z4A5jCMAPecV5JogW4GhQWJGCWzXc9K9XvrpG/e/2u0S5dRog1xTdgweGMRYHXWwDcRUmnEzpMjtBSmvATkjFC/u8xOiUZHj1gOmAIjtxCmjpO305cjobGYKJSGl9cwi19VqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299415; c=relaxed/simple;
	bh=pdF5LZup/6LFP8urxiM7q2QapjVNNm2Bb5zkwT6EyuQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hZBEGnAQ0pke6wbKh9C++b/qA+RIqxoOM/y5Ukh5VpzYDEK7+dzIYhpp5Wr1qc/qgYsnM9l8JPYAlnGgxgSHm4CUP/XzdIh/YfBanhvR2ZpZsR/c19j+ankx+jz5OGZSQkhpDVzvAl/xWQogD8NQjSQ3EkZPYoc74BfxIxZut8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlL2qIzJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64b70c4a269so68708867b3.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 17:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722299413; x=1722904213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCwKLcHTneNYrEvPeEZdqhRis/EVH23zgMng2uPVDt8=;
        b=qlL2qIzJzKiva0MNoCAho7UyHkkFV5MfteKj/8rwcdpuzf6Z0cw6mOsmQZgCDJrAqi
         5WjtTHVUjI+2EBePqF4QsWc552TQsr9aTgJMQMpIvNC6sd+aYxzkujHTGxM5K7Z7H8id
         t2L196O/8gllLWH9gYTGyrV3o2/KVon9Y7czPggKAnhIhYHUH5Xa8u90x+wkxhLkNGNo
         WLv4MyeoRrO3Iyh1+0kNlGQhhYoMCYVlnnR8ZNkMMGb/63q/aaln0mJARSj9oiOAl2BM
         jkxKwFEaUCvTNqRHwP4bUK2dXJz6kJNLhRE1qrHE0nNbhrQQtLN38oXWi3SxnjytVjyX
         rWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299413; x=1722904213;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCwKLcHTneNYrEvPeEZdqhRis/EVH23zgMng2uPVDt8=;
        b=YpA9Z+dptlw47lIDIIId04qclNr4nC8WfUjK8qGoo7GzpF/FKkrRC39O+pZ1BkaqEk
         lJ0dJ0jfe2pnlxas+/sEjg9DpPKOpX/sYmKzlHnWE2hCy0ex27qfEHfwNsFc0SB4ix3+
         sLGqe+83i0u7UOQyEF/jqxLuDsM+7h4PDce6ZbAK35I13j20Ay4SRJJz3AEI8KlXogZK
         CwMogH5kizVUGfr1rVDn46t3fn41pbdQD88Z/KhTtNS6JzadJp8ENKcxUZbn7vLbeO1b
         dlPl2LeSIiPQhJxhhAC0AQK+GXYPaK3pa+PriwxNi7E7G0Mq2x+WH8n7fKGBe9/Rp1Ed
         WLTQ==
X-Gm-Message-State: AOJu0Yy5t0YKNvif0mE7S2Yar2/k7OpgMB+QBZETHPwSq3041urxlbPB
	bqDDYfo+jHG4ncMew3UR26ooNmZfYq/J1qu3d3kIsSD8H4yisp27uM3E+sKqPXLgdFibFA==
X-Google-Smtp-Source: AGHT+IEFIRoeab08vX5UEL6uIy2FXfXoSrd982ctTcJzezdC+oFEaS6LEYNumBx7lYwOxPLj1tObxxZW
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:7a79:ef2f:3d24:7a95])
 (user=maze job=sendgmr) by 2002:a05:690c:6612:b0:627:a6cc:d227 with SMTP id
 00721157ae682-67a08bd41a7mr417627b3.5.1722299413301; Mon, 29 Jul 2024
 17:30:13 -0700 (PDT)
Date: Mon, 29 Jul 2024 17:30:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240730003010.156977-1-maze@google.com>
Subject: [PATCH net-next] ipv6: eliminate ndisc_ops_is_useropt()
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, David Ahern <dsahern@kernel.org>, 
	"=?UTF-8?q?YOSHIFUJI=20Hideaki=20/=20=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?=" <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

as it doesn't seem to offer anything of value.

There's only 1 trivial user:
  int lowpan_ndisc_is_useropt(u8 nd_opt_type) {
    return nd_opt_type =3D=3D ND_OPT_6CO;
  }

but there's no harm to always treating that as
a useropt...

Cc: David Ahern <dsahern@kernel.org>
Cc: YOSHIFUJI Hideaki / =E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E <yoshfuji@linu=
x-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 include/net/ndisc.h | 15 ---------------
 net/6lowpan/ndisc.c |  6 ------
 net/ipv6/ndisc.c    |  4 ++--
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 7a533d5b1d59..3c88d5bc5eed 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -147,11 +147,6 @@ void __ndisc_fill_addr_option(struct sk_buff *skb, int=
 type, const void *data,
  * The following hooks can be defined; unless noted otherwise, they are
  * optional and can be filled with a null pointer.
  *
- * int (*is_useropt)(u8 nd_opt_type):
- *     This function is called when IPv6 decide RA userspace options. if
- *     this function returns 1 then the option given by nd_opt_type will
- *     be handled as userspace option additional to the IPv6 options.
- *
  * int (*parse_options)(const struct net_device *dev,
  *			struct nd_opt_hdr *nd_opt,
  *			struct ndisc_options *ndopts):
@@ -200,7 +195,6 @@ void __ndisc_fill_addr_option(struct sk_buff *skb, int =
type, const void *data,
  *     addresses. E.g. 802.15.4 6LoWPAN.
  */
 struct ndisc_ops {
-	int	(*is_useropt)(u8 nd_opt_type);
 	int	(*parse_options)(const struct net_device *dev,
 				 struct nd_opt_hdr *nd_opt,
 				 struct ndisc_options *ndopts);
@@ -224,15 +218,6 @@ struct ndisc_ops {
 };
=20
 #if IS_ENABLED(CONFIG_IPV6)
-static inline int ndisc_ops_is_useropt(const struct net_device *dev,
-				       u8 nd_opt_type)
-{
-	if (dev->ndisc_ops && dev->ndisc_ops->is_useropt)
-		return dev->ndisc_ops->is_useropt(nd_opt_type);
-	else
-		return 0;
-}
-
 static inline int ndisc_ops_parse_options(const struct net_device *dev,
 					  struct nd_opt_hdr *nd_opt,
 					  struct ndisc_options *ndopts)
diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
index 16be8f8b2f8c..c40b98f7743c 100644
--- a/net/6lowpan/ndisc.c
+++ b/net/6lowpan/ndisc.c
@@ -11,11 +11,6 @@
=20
 #include "6lowpan_i.h"
=20
-static int lowpan_ndisc_is_useropt(u8 nd_opt_type)
-{
-	return nd_opt_type =3D=3D ND_OPT_6CO;
-}
-
 #if IS_ENABLED(CONFIG_IEEE802154_6LOWPAN)
 #define NDISC_802154_SHORT_ADDR_LENGTH	1
 static int lowpan_ndisc_parse_802154_options(const struct net_device *dev,
@@ -222,7 +217,6 @@ static void lowpan_ndisc_prefix_rcv_add_addr(struct net=
 *net,
 #endif
=20
 const struct ndisc_ops lowpan_ndisc_ops =3D {
-	.is_useropt		=3D lowpan_ndisc_is_useropt,
 #if IS_ENABLED(CONFIG_IEEE802154_6LOWPAN)
 	.parse_options		=3D lowpan_ndisc_parse_options,
 	.update			=3D lowpan_ndisc_update,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index b8eec1b6cc2c..1e42e40fb379 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -200,9 +200,9 @@ static inline int ndisc_is_useropt(const struct net_dev=
ice *dev,
 	return opt->nd_opt_type =3D=3D ND_OPT_PREFIX_INFO ||
 		opt->nd_opt_type =3D=3D ND_OPT_RDNSS ||
 		opt->nd_opt_type =3D=3D ND_OPT_DNSSL ||
+		opt->nd_opt_type =3D=3D ND_OPT_6CO ||
 		opt->nd_opt_type =3D=3D ND_OPT_CAPTIVE_PORTAL ||
-		opt->nd_opt_type =3D=3D ND_OPT_PREF64 ||
-		ndisc_ops_is_useropt(dev, opt->nd_opt_type);
+		opt->nd_opt_type =3D=3D ND_OPT_PREF64;
 }
=20
 static struct nd_opt_hdr *ndisc_next_useropt(const struct net_device *dev,
--=20
2.46.0.rc1.232.g9752f9e123-goog


