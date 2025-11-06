Return-Path: <netdev+bounces-236387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BCCC3B80B
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7376734C80A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36F9337BA7;
	Thu,  6 Nov 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+SFgT1J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CC2010EE
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437497; cv=none; b=pRN6K4BDlt+eeD4J+emK8DwCr7/DxQUBOCK31kxMkQ3qFAyIOaiCZRXM3Cjeoxvpg/7Rag1FAAmuPM/C2ET88Im7VY2yaE/wco8R0dHnBnkyAb4R29yWVgx/39qzJzWsc7ezEoS1mx38D9eNhGNOMUlfyjxpHXm23WXKHUzKUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437497; c=relaxed/simple;
	bh=DrHGCtHv53QjsxNbuUABBFBxBL0tWPAnkEs2nHbZ6kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHkuRHS42L1+ZoULZPxx9P0H4NyzzY1S4NST9Sf2KvO/9p7qcddoQNjwPPa5/c9T18UFJcPJaS6eBWR6knqZ/moQQE7PUFMH69zBiT1NKkWlDU/S8b8RLxX+EGvOcNRkgUY19ZNrFyRj7Utn06Mi8vNN4N2grPEyXzOdKw7OAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+SFgT1J; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34159ccb610so103571a91.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762437495; x=1763042295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro150xIMSRVQ4ZLxxqwU1iOGZU/wuTJeStzvIhnMN34=;
        b=d+SFgT1JpEjz+wBDVU0mC++YICGN5EveFN67TEtxAOFwKIv53jrumrj4vJwA679HwZ
         TIdfd1Hf6FPGVuL6Y0Hhz6rb+v6gVptJ2g25Oc2zLgYwbaqpfCEatqEWr+kPP69ZWR8V
         oMLlWJvAUZO67pkCgBOp7h7z1Y6pC+US48rqC3qqnm2E96tWq5VJOIOjAB+OI/ATp9rj
         a3Bw74RwqdR1WEnN0Kf+e/yNRUDVWgT7CKUlRB+1SjAUxfQ8+o0lJHOg7TMCMaDWbwKF
         0eCVCm8q0BCgm9a9x/InYGGvqAdD2/v9yAl5mZ7ztT28plE4j87vae6vsNINUPV3HWNo
         qpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437495; x=1763042295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro150xIMSRVQ4ZLxxqwU1iOGZU/wuTJeStzvIhnMN34=;
        b=FfnERlXyX78kXotwyBoNeNkcxwVVY0F7tUcT6JoytkmcmsTAQWd6vABHUNhfIeIr3p
         JgXsMUdpUekIx4ZwLblJSG1ONjqOiYKU6Pq5KsMU4BWnOdehQU4jYUPHjZZaggzr9AUx
         rUMvedEkL3MM57vaPmv9SDG0fhUkYdCcOTZ7cvLuGWbrqBfepT53gPaB9zkNOfjwZtxa
         upCwYHivjrcz32y7NChGjqibPceyH767Xe2aa9TsY+nWK0hSSkGzBnoDtasR6I+ktsGt
         7xNe8eif/dfmoRiCTCCNpm7GGxSZx4hMN6GzjCaK12PuAgx1KVcLXE3Xs1stuKKJTBs4
         /UrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs7RApgwylcPlXbGhvm+Kh6OdeZwFIYB2w9G4sHu8QB0OoS/8ptXhATBSvuNOwY/39WY2mIts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9C4CuSmSf7QqLDW7Hh7xJ59QD83EnDArfZrzJrr3lCskAt7V
	K0eWDyo/ekQKXaRL9G5bZi9g1AEifAWlULNIxYhw8bdQ2LWx38GwVmvu
X-Gm-Gg: ASbGncsnIih/HgbmhZ/ed51bX6qGIHiIK/A21Fl4z2SO/Yvs207dOSBIf7qGnpLi00c
	3q/gICGcuV2ZnCdLHJ5ScbHcSHkKD2PGV+EYl4YP3pPXEpoiCop535rV9qJ3J6yPFw0tXQyoMnD
	lQKIoSVlC5TuwdfS41d2k0popj8VO+APw97rg+sstjxTCpMDrVI3DqXophkLuYdY483yj/mpNk0
	K6MsTFeBDQJu38ONBZvtXm2ucbtPZXJe1Nxw7uREdqrbaG3Z0rozuD+vgDNyfCFmpm1ydEWxV/Z
	Cwy8kcQ2LMFtILOeeZY2Mu/rXmYvcIVz9sIiKwl+b6WASQ3Rfw7L3DYe81OmTyHDGWq7CZp4mAZ
	rAOWyFaHR+k88S4CfOKGw+VwXpHKhsnJ8nO5Bt6jzSdSyS6Fqt3tynS54Ucjpz2gM
X-Google-Smtp-Source: AGHT+IE4mUBuAxvxNOx8gzgkLs6eu5qTa8sJ0yTqgn0Map+lM4vZ+s3iiD82zXnyQVCGqYbKWG6o1w==
X-Received: by 2002:a17:90b:4a8a:b0:340:29cb:d3e8 with SMTP id 98e67ed59e1d1-341a6b0da84mr4647095a91.0.1762437495322;
        Thu, 06 Nov 2025 05:58:15 -0800 (PST)
Received: from user.. ([58.206.232.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm6439593a91.7.2025.11.06.05.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:58:14 -0800 (PST)
From: clingfei <clf700383@gmail.com>
X-Google-Original-From: clingfei <1599101385@qq.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	eadavis@qq.com,
	ssrane_b23@ee.vjti.ac.in,
	syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	clf700383@gmail.com
Subject: [PATCH 2/3] key: No support for family zero
Date: Thu,  6 Nov 2025 21:56:57 +0800
Message-Id: <20251106135658.866481-3-1599101385@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106135658.866481-1-1599101385@qq.com>
References: <20251106135658.866481-1-1599101385@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

When setting the extended skb data for sadb_x_ipsecrequest, the requested
extended data size exceeds the allocated skb data length, triggering the
reported bug.

Because family only supports AF_INET and AF_INET6, other values will cause
pfkey_sockaddr_fill() to fail, which in turn causes set_ipsecrequest() to
fail.

Therefore, a workaround is available here: using a family value of 0 to
resolve the issue of excessively large extended data length.

syzbot reported:
kernel BUG at net/core/skbuff.c:212!
Call Trace:
 skb_over_panic net/core/skbuff.c:217 [inline]
 skb_put+0x159/0x210 net/core/skbuff.c:2583
 skb_put_zero include/linux/skbuff.h:2788 [inline]
 set_ipsecrequest+0x73/0x680 net/key/af_key.c:3532

Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/key/af_key.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index aa4bd29f27ea..cfda15a5aa4d 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3526,6 +3526,9 @@ static int set_ipsecrequest(struct sk_buff *skb,
 	int socklen = pfkey_sockaddr_len(family);
 	int size_req;
 
+	if (!family)
+		return -EINVAL;
+
 	size_req = sizeof(struct sadb_x_ipsecrequest) +
 		   pfkey_sockaddr_pair_size(family);
 
-- 
2.34.1


