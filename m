Return-Path: <netdev+bounces-221779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C898B51D8A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F618831F7
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8D3375CB;
	Wed, 10 Sep 2025 16:24:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52D334733
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521472; cv=none; b=U5qcfOSCuImb1P9cRhhTi+KVVvEOKTrSjGWjblIRp+05lg2U10+o+H5ZB2yHwM0vehlUI1fsMIP6ntorunbnK+W7Bl/GBXASS26AchOdqKttbxJIcAW0wG4nptDkrEILaXNlBc0EXvOSzaEOt/IoZN8mBo3KwWCCAZ6RZVl13Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521472; c=relaxed/simple;
	bh=XKhu0ButZfP1eFEp10IuKdFzc3bsJodNLb7lW4zaCgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFz+kVLzg6o4AVKviAE8RTqHVZGseIy/osuMm98ta5CY4myuzDtP4y541BStZyjABnPPMbf+0+X5+u9a4AefWjcoMAZ6CtS0OxqNEDr1gz12KG7xdQjyZwe9ZeWGYmRADzmFOvOCR0AUkeCgYQWscvXrRaygr0yk9g9/WakHfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b47173749dbso4903569a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 09:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521470; x=1758126270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p83w/Q/IRim7hnms2A7dQTsuzOFdw9GVdjRXWe+p5Ww=;
        b=Ry097HxiSaJyAFiLeh/GrV+IgmrK8PhRvLzqe9vsgUn0nm0xxCf3mo488HJzvYoOyN
         uGv8Z+d9R92aYziA+S2QzaBB3CBzTxLl1O2oDxGJ2LPkbyS+cFUHcjWgRI7EOoqdAQaD
         g5fn/n8+tWYXpCOSXdtP/K+K9Y0mbyOlMkuY/aePjXsUWtgmBCHkRWQKntJZctG27HHw
         VBV7r4APfW2vWfsxyNqukV3mkRQPFETV5eQSGdT3hYZEPdQB4dbv2cFZlWCA7EZRJB6/
         tliOUC0RXPZpwLmMhMHDVSESvcSQ7AeEt++bSG5Vx+sfJN6RBRxyWG46W1rh433iklZo
         cukg==
X-Gm-Message-State: AOJu0Yxp2Xizj0JioYhUNdyFbPyvjKiEl6TrUkS3jGfsg2iHDsbnesjk
	AwYIWQk8uuon4JuyMWaYxcgspi9SOVmFCrVQW3CIY8XHZaOS1qi16X79Sagu
X-Gm-Gg: ASbGncv+sXnmSjMB70pYvLLlcyJN9NcyYOD/CrxeMIS1Vdtytubet5kmA2eFnOqzVlu
	W1mW7UpDLNsoKQf6SkHSeQ2S2OcCddVKHym2nk1/o4fl1B/rz4qESu9K8NN9o84RWZFrDXXcHiu
	iZM598CYZcPrL0CPi53FvClfgdO8Vsa/81HkWfzxcAD1I3H6riUrBk0pB1JHqekbWhBuJgYsKBa
	R0PMmZKdGDw0eWjfmzkZHBT/rZt3lGbNTu2bHGjRupkPIp/Jc4xn4ZmxXSO+NrwfmAkd06/HRf/
	pzCUJ934HsPKbK3MP5ELGTaAVWu19lMd9N5/OY1HS1WsJ+MsJG6KKYqHx7LHVpeDlClTbs2bbTa
	FERqkqFv6/hnOwdTG7ll2cD4yCVVFV1nostfes6aHOjLqds5iupA0FZlvi6ZPBRrEZnAUV1k+HD
	1UKC8+KkVzUq7PEtLhhEJuwOWZwASTPjm716urAQfFseCmqsL0sdrmCWcXJ3103WLKoRVudr77c
	zzHRDFX3WaHqG8=
X-Google-Smtp-Source: AGHT+IFiww+cMWoD4/EmybvtoEqMGorFwlUf88+GYf5wrs1Lt1yUTpI2n83Aakd3i8q2nSdM+bs55g==
X-Received: by 2002:a17:902:ef48:b0:259:5284:f87b with SMTP id d9443c01a7336-2595284fe1fmr78470345ad.16.1757521470367;
        Wed, 10 Sep 2025 09:24:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25a27425dc1sm31958965ad.20.2025.09.10.09.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:24:30 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2] net: devmem: expose tcp_recvmsg_locked errors
Date: Wed, 10 Sep 2025 09:24:29 -0700
Message-ID: <20250910162429.4127997-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_recvmsg_dmabuf can export the following errors:
- EFAULT when linear copy fails
- ETOOSMALL when cmsg put fails
- ENODEV if one of the frags is readable
- ENOMEM on xarray failures

But they are all ignored and replaced by EFAULT in the caller
(tcp_recvmsg_locked). Expose real error to the userspace to
add more transparency on what specifically fails.

In non-devmem case (skb_copy_datagram_msg) doing `if (!copied)
copied=-EFAULT` is ok because skb_copy_datagram_msg can return only EFAULT.

Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
--
v2: s/err <= 0/err < 0/ since we never return 0 (Jakub)
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 588932c3cf1d..9c576dc9a1f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2818,9 +2818,9 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 
 				err = tcp_recvmsg_dmabuf(sk, skb, offset, msg,
 							 used);
-				if (err <= 0) {
+				if (err < 0) {
 					if (!copied)
-						copied = -EFAULT;
+						copied = err;
 
 					break;
 				}
-- 
2.51.0


