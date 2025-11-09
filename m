Return-Path: <netdev+bounces-237072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D6C44602
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 20:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05432188BD21
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE0D23EA9C;
	Sun,  9 Nov 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmB2l+B6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC722F74A
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716285; cv=none; b=SXXIqE6b6yNfmUucqd48nkZvk0PWJEMixIwtJ4W9nWw+W0w/gDMyQJjVck7TfSThgVnA2RRZnsueFEl4IGBObbBKyhkbFKPQKYC9yINyheZ+V4Mlp/fNKJbUP+PCyTopQMOWUpfHRC6xfqp5GuKBdIc8bRdQMpFSWFzLmNurbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716285; c=relaxed/simple;
	bh=fdY4s91tI+lPau1JubbQ0x8fEYiPT2Mrr0LtPH6xCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNJTqYzrlrDWqbM9UQ9MXhQWFWEY5hZXpvRzSrtBRy00s6okQau5Vx+P5DxW9wb1psiP6P0A+IJopy6dRppUkgBgoXi/wVeQVzMM+rx2E6rAgn7jcrn5PHU+GluqnHj1qsLmvfJ7YztY2nnUDT6Dpwgs1kd6/ARoIPKvWGjIm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmB2l+B6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7155207964so401228366b.2
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716282; x=1763321082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=EmB2l+B6gizAHsZ+0x5DOo1VURQjq4FqFDRQAQQvD73AygzFPREL0ckIcCBdw5w6Jk
         YoBu58htsURqGLty+mAizzNY/3IvusoU0DqmNwT6xIW8xpanKD/I3z1nT/kXpZdS+mRG
         viXqFUape+RjkomJ0hKFLN3Fa3M9w+Hvc/0m/ZaMIca/PEFd8DfvX8DHjWtV6KldKmuR
         Vjjoqbfsix+FdrD/PDCRkx0SPnPYK88ygww61RWCOScP5tje3yil0Lnwfi2eIaQgDzX5
         1sIcZZiFJLrdzjJ+OMq3d6WCKdh25hwHYjxUCCiEcxBhGBFM4SHJ0kCJJvY7h/5O6/iW
         fTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716282; x=1763321082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=N0YxKAkEjPgjDdWCR3jeAlysPuAtwnJb7iG/Em3oyQSJIsFk7PaOZHpyQl9O6AGuYJ
         E21dCQks3JkZF2Vugt1QucwpTMNp4K+AY13PYt88ue9B/FEiUi4qrkGR1OrZsHatOcla
         5/kR2qNfaV4ZoavWWwgU1u/jmNGWzRgTWCpSiP1Jk1nsX57jKJgbRUMZAuzc2uwj/ha5
         k80sa1A9jxYR2I89PXUDLne1ftqPOYBrpbEJdmQT5rsj1ikgZxuDIB73Ij1N+Q3P4x6d
         HMEcgfG9A0vgk7DN+IP7jfOLyAM4xPqeQudqQG7Umeqz/fjU9cnTFA3jYhNtnShA5T4F
         Gd0w==
X-Forwarded-Encrypted: i=1; AJvYcCVMAw1E+jU5stX/HohwpvtWgTXllcAVcP6Ch9W1Fh9VFooWUwjxu4FHoXEh7JV3fA6ahbvCqtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MOg0faHVMvIFSpG7yrYTUVuwgZCgMmFapD2fxyauHu9bz/uR
	Hr7+KDPAxsmcbnhEB5SRQ6QCpTuFEAhL2So9r0S/aSz/RLCqbCkwdMh6
X-Gm-Gg: ASbGncseErIXiKXMI1fpEm3k9/kHYSrsCxuLEkc7T+fmw+hTBVO2c7dVWKJg99TaQH8
	1W4w9VQIzguzbGI7ZVBvPCiiEPyGdSJI+7QKKSOKLkiuiExhUBmpbO+QFjZv4szMpcMUVvJ11TB
	YAp8lSpqi6G6O3eJcLOHGPEw3tKyyRNo00fgg0mrJ7gylvaCC8FFiY2QgoesGsMVANRtuD2lfpL
	FyDA34VM5TKMFIvN88MGrcYdlcsOmZDHru6F6IFynSbgkWgdz3IF+tHVZRaZRW2k1I5pVq0oBIc
	Y4sfop70UWzvDF44COU0aPadwKkHJ6LUbCdMoqxLhsmzjQ6cPNqsYVCD3C76KFyeylpkMJ4O0bg
	0Xf2HVIlkD8T5KI2KEAGD45DA9+0G6ruQPkpjLExbYPYg2ePIZ7K7qA8BQOiHtdzZoQ2qsQ5U3f
	0zFa41PUmmHzyHEywkX1H8K7SZRu0imLqvMNOzAWIVnlzXb59rD0eyNmFmSh/iQomtE3ST7aOyJ
	oRbD9xp4JTexUHqLulp
X-Google-Smtp-Source: AGHT+IGz2KRI1O39uoZsEqlvnLp53H/kYakBnxCti71eJRyaYaJ3y+qwmBNp1s7c1ixCSsXVxeHDAA==
X-Received: by 2002:a17:906:ef02:b0:b72:b97b:b6fc with SMTP id a640c23a62f3a-b72e03ef38emr633081066b.30.1762716282139;
        Sun, 09 Nov 2025 11:24:42 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm919652466b.42.2025.11.09.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:24:41 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v17 nf-next 1/4] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Sun,  9 Nov 2025 20:24:24 +0100
Message-ID: <20251109192427.617142-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251109192427.617142-1-ericwouds@gmail.com>
References: <20251109192427.617142-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the conntrack hook it may not always be the case that:
skb_network_header(skb) == skb->data, i.e. skb_network_offset(skb)
is zero.

This is problematic when L4 function nf_conntrack_handle_packet()
is accessing L3 data. This function uses thoff and ip_hdr()
to finds it's data. But it also calculates the checksum.
nf_checksum() and nf_checksum_partial() both use lower skb-checksum
functions that are based on using skb->data.

Adjust for skb_network_offset(skb), so that the checksum is calculated
correctly.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/utils.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index 008419db815a..7b33fe63c5fa 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -124,16 +124,25 @@ __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
 		    unsigned int dataoff, u8 protocol,
 		    unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* pull/push because the lower csum functions assume that
+	 * skb_network_offset(skb) is zero.
+	 */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip6_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
@@ -143,18 +152,25 @@ __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
 			    unsigned int dataoff, unsigned int len,
 			    u8 protocol, unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_checksum() */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum_partial(skb, hook, dataoff, len,
-					      protocol);
+		csum = nf_ip_checksum_partial(skb, hook, dataoff - nhpull,
+					      len, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum_partial(skb, hook, dataoff, len,
-					       protocol);
+		csum = nf_ip6_checksum_partial(skb, hook, dataoff - nhpull,
+					       len, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
-- 
2.50.0


