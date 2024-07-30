Return-Path: <netdev+bounces-113861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591F49401F1
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 02:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC351F22861
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D89653;
	Tue, 30 Jul 2024 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xu31KtL3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27499184E
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722298676; cv=none; b=KLEv8ly762JMS558DWXSAm0Ms0ORCVBa5tAUP9Igpcci2zQb9QO/4/7JPF/gfhwdbucWPAPdQoQ1I8PNEsC2zx3UFq8PIIj9ryEi9KYqmYdz578FVyuSDgeTzwSTOX4mxWFIFSTfPTpU+aLWerSD5FHfDtQM41FT0eGpedwKsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722298676; c=relaxed/simple;
	bh=foAQ3Oij8SSAt51s1SisNTGF9SALqs5oKZFRlgZO6xo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T73XzPXexf17FgJUDApyYHPBLF3IIHE/uGXD1gVokN5JwcOXOo94ALjE/SRpAJzntVrizBjEzthzuvdF2fu2eD1dDqeCeiuH+wK8V4MWYvnrYP4HiK15+zVfm4N0vS7XmkMRvseVcLLQfOE8tY0qOHb2Q27uq7h/azz2AuxZmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xu31KtL3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66619cb2d3eso77698207b3.2
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722298674; x=1722903474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhxEE/2LRjEtYANtksHZnCV0xPKin7uj6LdLJ2eXHIE=;
        b=Xu31KtL3XCvDqM9YMrk5et+LOOdZ58ZVs9bPvoaz8lhcXLx/mAMWQhWNQA/C3lWPgK
         7OrJLP3dFUX8FmYCLhwZIqOjj2ioe/Q7MW4wcRtQM/8zsE6wMp6oCGEd6+dvKUW/Hm0t
         OPAMJbywkcef6atQXnl2TXJfufGkh1DDvTC9unn6TMuA3rhy2SsICnkUw5Oc6UwVAfKK
         y8jqLQOKKAOEyDFJBbe2R8nn4+DWRD8nFAAIfe3rIvcqPEIBEn/olpPnCuI/FouCw1Kr
         0v9BBgj+IVOm1BMwL7wKB/VVem00Qrue/yA5KBbH9ST0iv4oNnDEJOGZDsdlL0EAJpm9
         yayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722298674; x=1722903474;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhxEE/2LRjEtYANtksHZnCV0xPKin7uj6LdLJ2eXHIE=;
        b=VrgIc7VubtPTm0gHuRrPbFBdpFsU+lRv+IxGvxmR4H/a/DLBbWsY9tPF9gHCB62zMV
         IeBscCN/zY+2yx4cDpfgiP4O5g6m4JpkWZHUlnS+cKRGfo4kChlNkC4j+cqh+tqvyKlY
         uwZax24z2ARSkS6bM2HqM4t54EOmtCoPo+lBooxa7QGkh8t4psoM8BOAUwDJugyObiLv
         YcOIlB1LbUhSIM+6s9QlWama6hkj/Vq0VBv9UUc8zlwFxjm3MuBalTVBEPG2IksVfY+S
         GGyqGo8hVNLk+VtGtOTlP0acbriXz+XOA4E4RnURo5FlaxkITdWdTdybz0QDfHvcT1pN
         DX7Q==
X-Gm-Message-State: AOJu0Yy3ICvJxe3Ji+8d+qAbNVnKniMz2+WuxRkLc5hv8MD3S26DUFsa
	e0HnzIdCLc8Rgfzi7BAdjhOEbdP5Ysrxv3luxxRRJmB/7RJwyKXXZgSQw7fSZJtZ8YGTPA==
X-Google-Smtp-Source: AGHT+IEsIQG9kr9HGlqL8oNSGEjtYL9nEP3GtpleujiAeTZHeLC/Gz0pTKLsFdMmMFcydX/UOm+usSZD
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:7a79:ef2f:3d24:7a95])
 (user=maze job=sendgmr) by 2002:a05:690c:ec9:b0:62c:ea0b:a447 with SMTP id
 00721157ae682-67a051ecefemr814617b3.2.1722298674132; Mon, 29 Jul 2024
 17:17:54 -0700 (PDT)
Date: Mon, 29 Jul 2024 17:17:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240730001748.147636-1-maze@google.com>
Subject: [PATCH net v2] ipv6: fix ndisc_is_useropt() handling for PIO
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Jen Linkova <furry@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Patrick Rohr <prohr@google.com>, David Ahern <dsahern@kernel.org>, 
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
Cc: David Ahern <dsahern@kernel.org>
Cc: YOSHIFUJI Hideaki / =E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E <yoshfuji@linu=
x-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
Fixes: 048c796beb6e ("ipv6: adjust ndisc_is_useropt() to also return true f=
or PIO")
---
 net/ipv6/ndisc.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 70a0b2ad6bd7..b8eec1b6cc2c 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -227,6 +227,7 @@ struct ndisc_options *ndisc_parse_options(const struct =
net_device *dev,
 		return NULL;
 	memset(ndopts, 0, sizeof(*ndopts));
 	while (opt_len) {
+		bool unknown =3D false;
 		int l;
 		if (opt_len < sizeof(struct nd_opt_hdr))
 			return NULL;
@@ -262,22 +263,23 @@ struct ndisc_options *ndisc_parse_options(const struc=
t net_device *dev,
 			break;
 #endif
 		default:
-			if (ndisc_is_useropt(dev, nd_opt)) {
-				ndopts->nd_useropts_end =3D nd_opt;
-				if (!ndopts->nd_useropts)
-					ndopts->nd_useropts =3D nd_opt;
-			} else {
-				/*
-				 * Unknown options must be silently ignored,
-				 * to accommodate future extension to the
-				 * protocol.
-				 */
-				ND_PRINTK(2, notice,
-					  "%s: ignored unsupported option; type=3D%d, len=3D%d\n",
-					  __func__,
-					  nd_opt->nd_opt_type,
-					  nd_opt->nd_opt_len);
-			}
+			unknown =3D true;
+		}
+		if (ndisc_is_useropt(dev, nd_opt)) {
+			ndopts->nd_useropts_end =3D nd_opt;
+			if (!ndopts->nd_useropts)
+				ndopts->nd_useropts =3D nd_opt;
+		} else if (unknown) {
+			/*
+			 * Unknown options must be silently ignored,
+			 * to accommodate future extension to the
+			 * protocol.
+			 */
+			ND_PRINTK(2, notice,
+				  "%s: ignored unsupported option; type=3D%d, len=3D%d\n",
+				  __func__,
+				  nd_opt->nd_opt_type,
+				  nd_opt->nd_opt_len);
 		}
 next_opt:
 		opt_len -=3D l;
--=20
2.46.0.rc1.232.g9752f9e123-goog


