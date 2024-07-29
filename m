Return-Path: <netdev+bounces-113858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE959401C2
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 01:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9012C1C21CB0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C5118D4CA;
	Mon, 29 Jul 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3JnPos/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360B7E1
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296330; cv=none; b=CgR0ZsAJ3QTf0bSrKajIpI5UPUUYwdWi5UE/373HJ7sxRjOKHmEWqWR06b04zTZA9mH6iACO6UlGBV5JibGWxd0YtnUsjA9vkfbJiLbOkwG7YDWHykNsTccPdDaCYBoC0GSbvRnSp87Pppj/d2KdDvvC4iKgLEHatjM1f08cNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296330; c=relaxed/simple;
	bh=1KvYRTNCktzUy8tdQgN6yeB5Rc9J7OgG5uYd3UJCU0U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ev76S6kwI210/XYR6dVOyQIz+pkosUd8FqaE1yb8o3kL/WYkGigmajt/0867nxheww0EXcHDK/0faz4x9+i7ar7LnjxfLnsytGe/QbhKcZ8GIfYRvG0nVidkk4QOmmsipSonzg0v6vAItB/ncuVlyl3sGH+QEv61ga6qq5Z5uDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3JnPos/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65026e6285eso71817437b3.3
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722296327; x=1722901127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0pEU7l3o1Ju2a/S9K4WFwZN3VYcxzYxkgBsz9sSFswA=;
        b=u3JnPos/V5fT6xJMQRRC9L3XwQIXJyNHyU6YMjmCEDpgwWNJ0GpKm+7f+QS7LhpQmi
         pgoSZ5Ql9zM7BCdD2dNDGZhGwdYjvm+lyeilIfdixTmLO+Z1e3cxQbmNKtrWMh6+AqB6
         U+tVx/+AFpvy03Iri/AWvVPgbVlU3OT/An7EtJy0H4wvDnsHGOqgAMMEA/TJlXvuzk2I
         UOUdLvx3elhvuibBVg8vmrKgJhFRCy/NQB7wEIqNP+4OtUTQ93hcCfInrXxhLGj3hmiz
         n1GHxV5nILis0fJ8pgjajHcoSr5BK0XuhFqQ48TdySz4zsmjAZjqB4tnKcaH6aPrTq5J
         rvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722296327; x=1722901127;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pEU7l3o1Ju2a/S9K4WFwZN3VYcxzYxkgBsz9sSFswA=;
        b=Emryd9uXtl4q+85igNKk0N/coiDzFEHo99fVr/3lVsioEtX7kE7NXpWTj6VhHvvNfo
         AWeVSMe7NRWgeBbke/ChoS2AXurJd6+CBAZ/oe+9Hg1hvIgendfhuNeniWtGq9Uk3Bel
         iP+iotdE5HE3oipAqHEq75L5JVaqmCn6yLEHe821z3AL/0zhuZCqpYOQEpstx86uRwPM
         Lv+tOYC9TusbK5vDeNU9IhUUl9ZIV6pJ932BALJARh/KlcPFOiMtZTehUkzMoUhNcY3Y
         4m/TzGFSF4wpNqDXRG10Bu0RzLto5zhPVvFjbOTMfJVwsNhKMPuMihlWfwBJVCYLJuJJ
         04Gw==
X-Gm-Message-State: AOJu0Yxr9WSFrszItpnQglExf6h16t2OG2w3oTH3V/IdmuYR5yZMplwl
	3Vn0VkrS6u3vQREyI5d3pnnULxlYKRp0JOYXPv1TVlTg0IoyBUutSSBegW4gUzykCjTR1Q==
X-Google-Smtp-Source: AGHT+IE7WcPYauOuM53HrGG/ockvKwz+WxT4q1hpPvfoM+Z8RtCg982FD3x1dg+SU/ujDM6ksGBEPwBq
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:7a79:ef2f:3d24:7a95])
 (user=maze job=sendgmr) by 2002:a05:690c:ec6:b0:64b:5dc3:e4fe with SMTP id
 00721157ae682-67a04c27922mr511517b3.1.1722296327295; Mon, 29 Jul 2024
 16:38:47 -0700 (PDT)
Date: Mon, 29 Jul 2024 16:38:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240729233839.139227-1-maze@google.com>
Subject: [PATCH net] ipv6: fix ndisc_is_useropt() handling for PIO
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Jen Linkova <furry@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Patrick Rohr <prohr@google.com>, David Ahern <dsahern@gmail.com>, 
	"=?UTF-8?q?YOSHIFUJI=20Hideaki=20/=20=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?=" <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The current logic only works if the PIO is between two
other ND user options.  This fixes it so that the PIO
can also be either before or after other ND user options
(for example the first or last option in the RA).

side note: there's actually Android tests verifying
a portion of the old broken behaviour, so:
  https://android-review.googlesource.com/c/kernel/tests/+/3196704
fixes those up.

Cc: Jen Linkova <furry@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Patrick Rohr <prohr@google.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: YOSHIFUJI Hideaki / =E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E <yoshfuji@linu=
x-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
Fixes: 048c796beb6e ("ipv6: adjust ndisc_is_useropt() to also return true f=
or PIO")
---
 net/ipv6/ndisc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 70a0b2ad6bd7..da939996a4aa 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -197,6 +197,8 @@ static struct nd_opt_hdr *ndisc_next_option(struct nd_o=
pt_hdr *cur,
 static inline int ndisc_is_useropt(const struct net_device *dev,
 				   struct nd_opt_hdr *opt)
 {
+	// warning: kernel parsed options like ND_OPT_PREFIX_INFO
+	// also need special casing in ndisc_parse_options()
 	return opt->nd_opt_type =3D=3D ND_OPT_PREFIX_INFO ||
 		opt->nd_opt_type =3D=3D ND_OPT_RDNSS ||
 		opt->nd_opt_type =3D=3D ND_OPT_DNSSL ||
@@ -227,6 +229,7 @@ struct ndisc_options *ndisc_parse_options(const struct =
net_device *dev,
 		return NULL;
 	memset(ndopts, 0, sizeof(*ndopts));
 	while (opt_len) {
+		bool useropt =3D false;
 		int l;
 		if (opt_len < sizeof(struct nd_opt_hdr))
 			return NULL;
@@ -250,6 +253,7 @@ struct ndisc_options *ndisc_parse_options(const struct =
net_device *dev,
 			}
 			break;
 		case ND_OPT_PREFIX_INFO:
+			useropt =3D true;
 			ndopts->nd_opts_pi_end =3D nd_opt;
 			if (!ndopts->nd_opt_array[nd_opt->nd_opt_type])
 				ndopts->nd_opt_array[nd_opt->nd_opt_type] =3D nd_opt;
@@ -263,9 +267,7 @@ struct ndisc_options *ndisc_parse_options(const struct =
net_device *dev,
 #endif
 		default:
 			if (ndisc_is_useropt(dev, nd_opt)) {
-				ndopts->nd_useropts_end =3D nd_opt;
-				if (!ndopts->nd_useropts)
-					ndopts->nd_useropts =3D nd_opt;
+				useropt =3D true;
 			} else {
 				/*
 				 * Unknown options must be silently ignored,
@@ -279,6 +281,11 @@ struct ndisc_options *ndisc_parse_options(const struct=
 net_device *dev,
 					  nd_opt->nd_opt_len);
 			}
 		}
+		if (useropt) {
+			ndopts->nd_useropts_end =3D nd_opt;
+			if (!ndopts->nd_useropts)
+				ndopts->nd_useropts =3D nd_opt;
+		}
 next_opt:
 		opt_len -=3D l;
 		nd_opt =3D ((void *)nd_opt) + l;
--=20
2.46.0.rc1.232.g9752f9e123-goog


