Return-Path: <netdev+bounces-236386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0022C3B7F9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0A01A4482A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5D334C09;
	Thu,  6 Nov 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzRc3ES1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51E2010EE
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437491; cv=none; b=QLP2Fq/B/Js5+w7okWcvz5AyPYkXMGh5/YxiyjkKDshTPHR1oNYLC6wlJ2MSvs/nsjzmpJoshpcAw2ORL78qCje2iYjFtOxLn7qVOzmTFCG9X+gAaBZ4iNNW/qth7hFwgCSQEKdBfIPOd/gEfBVeIBeex9F+xzPVmddrCsQPoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437491; c=relaxed/simple;
	bh=xm32/PUt7XgP0AJBnuwZMLyFiMHFhdYO5mBVoIGW22o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMnH9mcUy2VO/tPih+YCEGbK4T+iZC/+A7y925nMCWWyGrqrImCqlmuWjtO1cbMDYIueqCOw8qSAuI4XyWIPdoffqjwOfmSPxYBKcjY0O2dScW6HZdH5A00rHLfpzIB2D7dW9PISRWsc/TGtUxMAmEyOs9t9DAbz75xgHcorNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzRc3ES1; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29301049db3so1324275ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762437489; x=1763042289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ2p4fKScptUntxDD4RknqhZ7LLlOjfrAorczf3l+6o=;
        b=EzRc3ES19SnWtvBn3KY8R6QK9rMxorvrsGWx/ZYYk5jdN2p37orAm1nMdf3gpYuRNC
         Tu+1/6lj73UwjxXTvCS8XdJULyde/XJPn72v9WlteOgnxzc6ZKziasd9mqFZp0edQQTv
         WHCnGrYNQZFGfcRwiDMgzSy1pXDlRDQArE6QSeHy40t7tdxZ/6RdZ4THQBWGCbvVy1Al
         itr88cNCncPgrtBnz4QTPmescf8DnpIulKvUgzuDU6WwsfnZ2MTy3dKRFInr1wAXn4gj
         CW+R+8XpBPzvVEEXuQl1TVgh/ognw0HKPlIMa0srefcQNcktzXNmMDZuJhlVxTAzOWpm
         Sfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437489; x=1763042289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ2p4fKScptUntxDD4RknqhZ7LLlOjfrAorczf3l+6o=;
        b=NjNHR8WEaFcxZq6EPo6CMiY+horPq5Ajm9r71Qx+g6gYJwbAPDQ7mBpzJ5+lPVhVgK
         bApDdmLYjivChT1cstvNQ5b4TvXK2hUkeXjb8+ovQ6QSVtNbk5QSPDOfDd3O62dwzv4k
         20svIpAhzsdbtskzQq2ZPTHguVPl5lUNMK1NT+2I92g+mdEi61EoztkFxpAnx3+u8DdY
         b+E8Lh5r8slaBImINH1Y7LOhKbzWdzI+/Cs6prN3NqwF/kJfpKRuJzVl73IDaZ3pe9gF
         G3kfljJK2RnH68G7jNLXo5a0uJSkN0T3KUZUiL3qV1Je3wh5Y/ZuQMftuixWqcKpELa5
         Vo2A==
X-Forwarded-Encrypted: i=1; AJvYcCVYgIjYpwHRAy0slVHu4LE6ohwneDKxj/KBKeTlv7LxTl4hqDxEUUMJYEpuo3AMTkGPV6x8/bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFie2WpE/1z80jApQLmmMFrdy7q0lQv304GGSO8cuIRavckvNg
	KhRzJnXr4XWNfsdbfNvUF5ZV8UwpP4RPHFoOLq6vJcfWmcvTQEx+Pcum
X-Gm-Gg: ASbGncuWEwgLYXDgUh3YNbPC+Iu+BhR8wEn0xCJP399w33JUYtRRwTdin+TcZrhewqA
	pCWgZ8T7BKJafpWSp3RSDdKxvOjdipZ/DyBfGc0ALEnnZtnWk5FZ1j3aw8t3wyJDs64LhJYo4zz
	i7TORKM6jl1qg7UPX2O7nz+OIPIl4qaO0xb19M0iXRtRrB20d5RWMLDVAeMvgEeoHgrxK4YvXgY
	vkXM1Yvcapy6XhbUjQItjvCjPpvqULwDXlEQTL6evBb6bpc2Q/Vi8JsiC7hO2kOyfAENyWob6tL
	oel21ZPmDExRah3gOskzniTiDf53jukbV1SV3X17+hSAnt4VEdOnYkUkiHWexUEzR0Ng7jaXD2u
	b5hpVJsUaCp6lXT4qBv4TnB7qwtx3uz4i2u5TdugYt57zdZShwa+iqIWvNgyrlapDsYO+N33807
	Q=
X-Google-Smtp-Source: AGHT+IEqMgZ7opDOUpiaQ/1pkphHXH5yXYJ0l9b+0/N5P7cyoOtDV0gJB9a3rdSrbl3cPEiiU+wihw==
X-Received: by 2002:a17:902:c402:b0:295:4d64:3c88 with SMTP id d9443c01a7336-2962ae532b4mr53521975ad.7.1762437488720;
        Thu, 06 Nov 2025 05:58:08 -0800 (PST)
Received: from user.. ([58.206.232.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm6439593a91.7.2025.11.06.05.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:58:08 -0800 (PST)
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
Subject: [PATCH 1/3] fix integer overflow in set_ipsecrequest
Date: Thu,  6 Nov 2025 21:56:56 +0800
Message-Id: <20251106135658.866481-2-1599101385@qq.com>
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

From: clingfei <clf700383@gmail.com>

syzbot reported a kernel BUG in set_ipsecrequest() due to an skb_over_panic.

The mp->new_family and mp->old_family is u16, while set_ipsecrequest receives
family as uint8_t,  causing a integer overflow and the later size_req calculation
error, which exceeds the size used in alloc_skb, and ultimately triggered the
kernel bug in skb_put.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Signed-off-by: Cheng Lingfei <clf700383@gmail.com>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..aa4bd29f27ea 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff *skb, const struct xfrm_kmaddress *
 
 static int set_ipsecrequest(struct sk_buff *skb,
 			    uint8_t proto, uint8_t mode, int level,
-			    uint32_t reqid, uint8_t family,
+			    u32 reqid, uint16_t family,
 			    const xfrm_address_t *src, const xfrm_address_t *dst)
 {
 	struct sadb_x_ipsecrequest *rq;
-- 
2.34.1


