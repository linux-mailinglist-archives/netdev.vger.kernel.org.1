Return-Path: <netdev+bounces-110106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21DE92B008
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAB91C21AD6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B2B12E1F1;
	Tue,  9 Jul 2024 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHo7Jb1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90B137775
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506225; cv=none; b=m8NkX0mptrdh+Lfbd0FSO6yq6RRBn3kKKJ1P815/X1kYx5JPIF5oHzQUL0jvdL6IDB2O3gYDLBRTL4BWht+g55hetFdey//SjN8CuyX7a8LhsMo6zjXszfMFBL7SNHjpN/RxYE3N5oKtiJOIjF8zGfM9kJupd66C8X2tsA57SZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506225; c=relaxed/simple;
	bh=t+fd8Ua0W5SAGhCz1imNDwt9NMPjurfkPT2IJFivpaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gALDWQrl5NHFFu0q22zmiA/xRTwgddjeySwelPk0dWLKwYC4gp1oQYHn0WIf1FdeGFQvd4eAgkknL66arRdbAe4RDSS8kypJ2Ri+EUZ9HO1jJMFT9AdN9DrqmNwJSKvDl0Sj29jBnr9eCiVzyaGPBY/U+Q/NV8ZotjKCUVtymbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHo7Jb1Y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6533680c788so72572047b3.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 23:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720506223; x=1721111023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMWw3T7z9YrPkDclPYswq8+OgJBIlNt5StLoSoxGAIs=;
        b=oHo7Jb1YbxGoD0tPfw47ineNbMGSdGGkKd5xr6oNDLvjtGgokwVgmQY9RrCecPAnRV
         h7VrlRpAUw3C2FZ4YAjiqW3rZOj+9golUp5OEuvFvducRIOTNvIYoNvIIRj2otDHM6O3
         so9aR32M0wGJX5+DpsG1R+CLdS/TwLuys9wy/lIiINhrS553MP8UIxATPaK/gxN1yCoc
         FLVIC/ibjaC1VzaHXRhF7ehmL6WJ19GvLTDS6AlZGrE7T090xNw3fQPlhFGg8fB6L7Vj
         jy7vq1Bwic6A104IQw6KzmBF3QAxs1SErrieEsFKb4UPGnwwGtVaJjIT9CPL5A0MInoZ
         w/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506223; x=1721111023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMWw3T7z9YrPkDclPYswq8+OgJBIlNt5StLoSoxGAIs=;
        b=uN9ZxMhCMC5D2wNil8sl8yz+DhzY0jE1U49VgjGDqlZQkqdnmt3mKYYy2q85A8CUdN
         kcvogw4CR0wObuwcmUkI3qlwcuWoYHOxqXtv7J7FjdPvxcDSvgdXN+H2S1wYX/1oVhQy
         ko/5hCOWZfiT4PBOJbW+QDOlmUuBRRSomPWsqA+vb+1tfgekdOWbr51zqpXZtOY2eoZC
         cflZFkmmEcReJIJUAvnaz1zzsi0sM/KZj5xuRH0bDjUxJkFMn3m7JctKqFKCmy6W+nGq
         oKbKw+8mx8JaEM2JA45xdcsJqD7ykHNtTYz87Q7c+pDHzZQ9zMJD9vVOq6/woOe2W2C5
         6Bsg==
X-Gm-Message-State: AOJu0YwM/N6ZfKhupW5qUnq/pMuiW0C3RL7X+MmBqlrWTLkro6TlgJRp
	mr2ZdDPvYmgN/TR+xDFSErLIiC0IsyrmiF2hqaG/7/6QzUD8s/QLZops9mknQEYuKHWrIXlg/QC
	57CZoxRJZ+qYw/kl2347/fCXIH91VU77ki1jn9D+o8kUgTJFN+gvKx399CKOkh1/ofZWwBSNeUA
	U5ytoCfdhxgXOThZFQcBJv62UtJXJlfDPt
X-Google-Smtp-Source: AGHT+IHPpeDLNCBts05+o/XW59Eao4ZQMCpwpvyOtSLQ/KQvy6xCAl0xwAV9TrWqrZBn/HO5o9W+PbkZ2JM=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:690c:63c8:b0:650:93e3:fe73 with SMTP id
 00721157ae682-658f01f4f68mr335067b3.5.1720506222424; Mon, 08 Jul 2024
 23:23:42 -0700 (PDT)
Date: Tue,  9 Jul 2024 14:23:25 +0800
In-Reply-To: <20240709062326.939083-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709062326.939083-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709062326.939083-4-yumike@google.com>
Subject: [PATCH ipsec v2 3/4] xfrm: Support crypto offload for inbound IPv4
 UDP-encapsulated ESP packet
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: yumike@google.com, stanleyjhu@google.com, martinwu@google.com, 
	chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"

If xfrm_input() is called with UDP_ENCAP_ESPINUDP, the packet is
already processed in UDP layer that removes the UDP header.
Therefore, there should be no much difference to treat it as an
ESP packet in the XFRM stack.

Test: Enabled dir=in IPsec crypto offload, and verified IPv4
      UDP-encapsulated ESP packets on both wifi/cellular network
Signed-off-by: Mike Yu <yumike@google.com>
---
 net/xfrm/xfrm_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index ba8deb0235ba..7cee9c0a2cdc 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -471,7 +471,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct sec_path *sp;
 
-	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0))) {
+	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0 ||
+				      encap_type == UDP_ENCAP_ESPINUDP))) {
 		x = xfrm_input_state(skb);
 
 		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
-- 
2.45.2.803.g4e1b14247a-goog


