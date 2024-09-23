Return-Path: <netdev+bounces-129322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F27797ED87
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F856281B04
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A219177F13;
	Mon, 23 Sep 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3lVbBbU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF311CA84
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103699; cv=none; b=Mt07IWnOV8jYYyPywpRMVE0o5YpSUS3e6BIBq+JGM2RVNC9jbpSYUYxz00TaSDNtt7msFQKIaqsoEB+A/afL0IxU3AmUh9Zegw2poKrRisbmQmZ3uncei2tNDaoIbdRty9yxlA53lqfUgVkKIOUO9/oHpwThWyYvV+tHtlSidkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103699; c=relaxed/simple;
	bh=bVzgrEgiLhJbB7RwQoMrX0K0MRe6IV+FtaLfIEjTMTU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mShUCVq3s2tWdL0MNXzOaR8bn045mwjPkhWE/HWlzskd04Y+VCF8a4BS2lCx6NYBCN4mf4zoNgXLlJYyITFqmn2C7319YB78gAnNuyU/5Lv5tyTT0owBnLL1hq7l9wAAYRYLOGiStRacM7+8ZT7ToU4PnJOyUvQNioMk26fRQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3lVbBbU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2053f72319fso2681765ad.2
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727103697; x=1727708497; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZMKJi0ybwQHR4jHcalCgiEDAdpq36VaVWrpv9+wBLE=;
        b=U3lVbBbUuZmWviCY2qj9+B9Et0fzVQKwXbId77ue5aQAWmdhNgrKQ7w8HafG4I0ma9
         GIMhqCAtC9NjC+preu/5exb0Ldi2sAmGRJXFo/L0+rVz1HoZuGUarc591Xqh+VXM28hn
         Nj+/d7GiDhrfYHG1JkeJfvMYvqOef7QxW2jH/mthsj0dCouIoz/5kJXGjBu9llQoKN/l
         JK7kGM8u/c4o6H+TGBUxittOKPRHyOqGvjqMK9kNuNMrxcN9i1dAaUugJv2EQea6DnO6
         XlttpMZdGWLcXv1IWDB7z2t1ou94mmejNXlQST+kmi5LTHB3UiTt3xXwfuEry09TmSBt
         zREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727103697; x=1727708497;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZMKJi0ybwQHR4jHcalCgiEDAdpq36VaVWrpv9+wBLE=;
        b=QUQt4z/c8WoD0CYBJQaDV6Ilg7YcLEUozZ5MD3pxFkc4JrCG5zMHjYr5h6p05wFlqU
         7T76AYaQJ3tb67mHD6cHr4khOJpayt6MOU6KaiFjDMk9a3BXSGD92kNG16SFhLoCaDaQ
         w3S7llGzhJI4NEmRWNZd7txEpPQ/qTXUGuU0/yTqblIIgKX5nku9Hmd5/IWiFh5JbLhQ
         jQpx9nwAX8E+2zDNIQ1tOV0c3BzsTC27AxfutiNWqYJdvDzQ+7mk3SjA6lbr7aJBNC4U
         0phx76QZfY4nK+r/M1oG1MUvaWT2i6mTlNGbWpxSSrqa9q++RaJ2rDY5eo8CeMmicMts
         5UUw==
X-Gm-Message-State: AOJu0Yw3djIm0iAYkNaY8yfqWC2XLOObXq4bbBXbb0M7zFkV7L4IGaQn
	2rnIKc8ezoUyLfHiIMX2Fy3+zQ5PJDaPE+Z/E6ItF2aWUopzb8I=
X-Google-Smtp-Source: AGHT+IFiBmuKvuZrJHmh5hdopypKyj4e6u57ni2LpnUuQaA9mdwArGOZFWcd++vtuD062WmXq32cPw==
X-Received: by 2002:a17:902:ec8b:b0:205:8820:fe1c with SMTP id d9443c01a7336-208d83dff51mr74286425ad.5.1727103697402;
        Mon, 23 Sep 2024 08:01:37 -0700 (PDT)
Received: from VM-4-3-centos.localdomain ([43.128.101.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945dc76asm134305345ad.42.2024.09.23.08.01.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:01:37 -0700 (PDT)
From: "xin.guo" <guoxin0309@gmail.com>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	"xin.guo" <guoxin0309@gmail.com>
Subject: [PATCH net-next] tcp: remove unnecessary update for tp->write_seq in tcp_connect()
Date: Mon, 23 Sep 2024 23:01:31 +0800
Message-Id: <1727103691-29383-1-git-send-email-guoxin0309@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "xin.guo" <guoxin0309@gmail.com>

Commit 783237e8daf13("net-tcp: Fast Open client - sending SYN-data")
introduce tcp_connect_queue_skb() and it would overwrite tcp->write_seq,
so it is no need to update tp->write_seq before invoking
tcp_connect_queue_skb()

Signed-off-by: xin.guo <guoxin0309@gmail.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4fd746b..f255c7d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4134,7 +4134,7 @@ int tcp_connect(struct sock *sk)
 	if (unlikely(!buff))
 		return -ENOBUFS;
 
-	tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
+	tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
 	tcp_mstamp_refresh(tp);
 	tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_connect_queue_skb(sk, buff);
-- 
1.8.3.1


