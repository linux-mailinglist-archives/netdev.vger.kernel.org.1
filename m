Return-Path: <netdev+bounces-154863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A62A0026B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999331883FAF
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E104B25763;
	Fri,  3 Jan 2025 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml6gbdfc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A93232;
	Fri,  3 Jan 2025 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735867397; cv=none; b=qcW8+u1wcIpUI+PaQagb4YhfKeoiKLyD54/8GUo7AWScskPEilzsuGtURGfClAf8Zmty215sXucVFamYmYiu3xfD3wP2V5E8HOvavBTjIfhDYvi4iujqBFy5E8I/BIBree2wfolSrqcmWX6uarJQ7sLxhVXJ7FcFsGezxYecYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735867397; c=relaxed/simple;
	bh=O4YQ5tV1IABay4kzIK6SRjsninDAuOGsUSdCE4JxqaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KI2oM6Sa5A1/GNR4b/0LMjNO6y8TUVYiVgL9G60oXWYDbU9pbOgWL27hS/LYzCesEPCIPWyZx/uT627bAKOKLDTPZsbMwTEgGY6rlRkFCDIxePDWvfJfYP/0YFY20F0JfVR3yXCX0JgAYN7yu21zn8mNVrqKqfdTlNSKQD5LUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml6gbdfc; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a77bd62fdeso85616275ab.2;
        Thu, 02 Jan 2025 17:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735867395; x=1736472195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B93VpXoJM2vXhcWEY7PyK3YqA5UpHcjd6JwjbkHzo0=;
        b=ml6gbdfcMRxWrOM5QKxnK2EK9aoglYmieAM0wpq5ovKh8Zns3+AWAQVm19q2uiVije
         3hlZC5/mgxBpSVGRk4Ez924JnHpOlSFvNKHEs/3f0Eci3XS4OEkvogjUHeFEv2rZk0KS
         x1cLN3cv+F6jT/WCj9aazJX+qfBV3a2zMdyIPrWJtb/Hx1nu1B0itHwZTL/VbRKhSXBx
         Y7mqgg5s2pbVMTJfGXfAaJGqFKjGkwz+ry6mwEnuu8sZRW3ChY9fAkzWGs2ElvmZJEbB
         HqXd6ad9Z21Ohv/osVmJcI1faRwlnt7Heal83ugyEG2FGZ98VyD9yPF5+cY2gtAvXWKc
         vWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735867395; x=1736472195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7B93VpXoJM2vXhcWEY7PyK3YqA5UpHcjd6JwjbkHzo0=;
        b=BC5PmoDiL6BhSfTel6Xgx3I6YBa+1rXrdUYHsbYH501VuWunnWth6KKLVxXtuNWtuw
         eP2szou/6M9ts9XhERMNZ+EwOl/uK10hgpCIYPf7s0Nflcba5lR46uI8YsOxGABEJtE5
         FgnQ1KxsVzKcDn7CYXnq4n+RzzgjU1DNDrvqvNcUfo9vZbJ2Zne7RFdRvjdMNJLCViax
         WbBNCA83+lWEniaO3PiI77dTABaV8aJitOfh/hwZluiDa76hbiQi2Q/+wpycs+0Wgx5O
         MVH3gPiShGgDVF184+Jl5E4glMU6/sLZUD/35raylEc8ktRnfW2NiS7RI2LkMwI4Sphh
         r4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Gf5mHQBRzMMVfpTDJhfGPJ1SdBdYqDcduGusi8A89TvK2ZvjDeaeI+4u7lSAxLWSLjiyjMGfYu/h6GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvyKrvWa8PakhfIupG8sj4VndzaIB503Ay1j20GcqPbBKbnQm
	Y4p4dLD91Kzc3B7ymXvHNsdzF7WVX025or1Ko3EOMR2xkNFkY8czc0d+5TJl
X-Gm-Gg: ASbGncuSHB/ZjnWnqnrybXyVImT2+RPaVOCX7/J3e+psEtZfgEjdBdK425UHW73/QZG
	BvlZl0yvejJkBvizaFEHAng8PWhuPCG9kkoiFnCXVWH5SkusGS5KyV8SZviemJWFb116GKjcakp
	StsUkgdYypZFJSycVTHUYQ96Aysq5IZ6q8VJCSunQ958tIdg+H3ZT0uWJ6p6V8na/TuX/bS7mnE
	6OzEksJET+rmERQCwj/Mn63IegQRcM+K55nFlf/7HmrOcdvFPWes/1fMQsuBW/Ur/Z7da5+BPoQ
	kuXUuMmIR5tnLAfqazWT95MzfVOrrSkzOwtbVM9PGwl3Qih5D0g=
X-Google-Smtp-Source: AGHT+IGRFfaix+3qkmB+g4sWwDDw2hmCu/g4jMEz3d7odVGqghLjw68x4mO0J6D480UFLd6bJI6NUA==
X-Received: by 2002:a92:ca47:0:b0:3a7:e701:bd0f with SMTP id e9e14a558f8ab-3c2d5b273d9mr401376475ab.21.1735867394959;
        Thu, 02 Jan 2025 17:23:14 -0800 (PST)
Received: from T490s.eknapm (bras-base-toroon0335w-grc-31-174-93-21-120.dsl.bell.ca. [174.93.21.120])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3cb713fb0casm57924175ab.47.2025.01.02.17.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:23:14 -0800 (PST)
From: Antonio Pastor <antonio.pastor@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: antonio.pastor@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: 802: LLC+SNAP OID:PID lookup on start of skb data
Date: Thu,  2 Jan 2025 20:23:00 -0500
Message-ID: <20250103012303.746521-1-antonio.pastor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iKkrZySKRidPLFa=KsM6h6OeO2rgW6t5WNY9OWfJazu8g@mail.gmail.com>
References: <CANn89iKkrZySKRidPLFa=KsM6h6OeO2rgW6t5WNY9OWfJazu8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

802.2+LLC+SNAP frames received by napi_complete_done() with GRO and DSA
have skb->transport_header set two bytes short, or pointing 2 bytes
before network_header & skb->data. This was an issue as snap_rcv()
expected offset to point to SNAP header (OID:PID), causing packet to
be dropped.

A fix at llc_fixup_skb() (a024e377efed) resets transport_header for any
LLC consumers that may care about it, and stops SNAP packets from being
dropped, but doesn't fix the problem which is that LLC and SNAP should
not use transport_header offset.

Ths patch eliminates the use of transport_header offset for SNAP lookup
of OID:PID so that SNAP does not rely on the offset at all.
The offset is reset after pull for any SNAP packet consumers that may
(but shouldn't) use it.

Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>
---
 net/802/psnap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/802/psnap.c b/net/802/psnap.c
index fca9d454905f..389df460c8c4 100644
--- a/net/802/psnap.c
+++ b/net/802/psnap.c
@@ -55,11 +55,11 @@ static int snap_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto drop;
 
 	rcu_read_lock();
-	proto = find_snap_client(skb_transport_header(skb));
+	proto = find_snap_client(skb->data);
 	if (proto) {
 		/* Pass the frame on. */
-		skb->transport_header += 5;
 		skb_pull_rcsum(skb, 5);
+		skb_reset_transport_header(skb);
 		rc = proto->rcvfunc(skb, dev, &snap_packet_type, orig_dev);
 	}
 	rcu_read_unlock();
-- 
2.43.0


