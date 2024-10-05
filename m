Return-Path: <netdev+bounces-132392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06390991806
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 17:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFABB1F2238D
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE95815444E;
	Sat,  5 Oct 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSV0eDl2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A7156968
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143922; cv=none; b=uFmNnjV1gEjBCcdlL4iSlrdtEVYVULaAZ4xX3rvmkCUzKYdm0uOmP/kiUR9UdLpGxqSwCVDFUTR2KR/FFsHJD4V0CjGghzmX2Mmqty5eVH5rDan3l8L9lUQHKRC8sukD34gPezBXT6wSnaiY9YOHwZ8E8Dvd+UqOosBPVRItEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143922; c=relaxed/simple;
	bh=9wZrlBjwzBnSopm/5FVerG5f/UYRy3auzddK6HrEJdM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Wu6KkxkhwU+rN1b6Qtk2UfJ9KnzMplu64WLaJNz7wKJfdFEFV5gFRrLXG+lCvN+pYX8tH/FLgCOatUri2exSAjcI6RlYuFZgNyHN8q2T0GI9VMPEbc7q7DjArV4XAiBlJTXX9N65oEd4S7ucY77Y9RCL0IO7KWAEOId8BL//5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSV0eDl2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71de91427d5so262600b3a.2
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728143921; x=1728748721; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYy5H5I/SXU91R9MPNHHy0EVbR43i8laYmKfAg3by1g=;
        b=YSV0eDl2MrFn3jjA0ajQSSG464Vn2bk/AX7d2QJfSwj1WZaF4QB8QBjHMeEYtMkxBV
         bTOT9nZjI7hzYpknRtBl4g3QLZRKpDsmN5r9RIVh7MmdRRqr+NqpAlwRqgKyz7TANIWS
         4nyD1vjWP1UJvfWSHLPAXbZUrGVjwKmIOv/gRZquACluKu0ywb9sKvJPJXQ9yz++BrW5
         3kVJzCfWPC114dOb5zqvnBJMLrGUmj3WuJIw9792YDgIvB2JuPy8oLAh+MhHfljD4tgA
         RxLjl3wTZZX9E1r/lQ4yDOgS5Dhor5g8eS0eFoSYm4SE0eydgWYIdWLa6KRKMtVhHzEt
         9T2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728143921; x=1728748721;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYy5H5I/SXU91R9MPNHHy0EVbR43i8laYmKfAg3by1g=;
        b=MsIZ5JvhLRkL7e9hjdwp9Coo6g+iIB8FZrcw2Mx1FZFvkr/hiFb1kgQCwRW9U7y9SD
         fN7Fef6JM0GjD+MhyLN8Jw85ga9MhN3HFp5MgcVBCE7QwtBPbtJZ2drpfimmtq4rZo8r
         RnjSuarP43tC0BvumXoCoSf6Wow3rs8witmbltn9LR6XFIoTtsThhVqZ1PnwKxWiEt9+
         hSq/eu8dQTp93PFH6/L2NzgFZK0ee+lsu85uwqdkkKR88zobFxnG7yJIqPIu+Dn4NPdd
         p/iL4iwtBdZoGfj8jEfH5AaJ4iFw6DmOVkSHf2R5JMlvCcimEwKouMpebeZs/L1HXdLf
         qkzA==
X-Gm-Message-State: AOJu0Ywh+BChp5M3vPFI6a9I7gokxRoF74hawwXiS03BLF/9s/lWk8lM
	jLMvBBj/wJT5wUY3Qben0LMqudEHnePQwbzMaZ3cSbacuDlrlHFBYx8yAow=
X-Google-Smtp-Source: AGHT+IGg0pWy6kejnQKZti4urc5wnuebPbVWiEK82AFyzueuAa7ckvfQCP+ioWuSCMxKN11YpP10Tw==
X-Received: by 2002:a05:6a20:158a:b0:1cf:4212:4bd6 with SMTP id adf61e73a8af0-1d6dfabb7camr4653149637.7.1728143920630;
        Sat, 05 Oct 2024 08:58:40 -0700 (PDT)
Received: from VM-4-3-centos.localdomain ([43.128.101.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d02asm1625248b3a.197.2024.10.05.08.58.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2024 08:58:40 -0700 (PDT)
From: "xin.guo" <guoxin0309@gmail.com>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	"xin.guo" <guoxin0309@gmail.com>
Subject: [PATCH net-next v2] tcp: remove unnecessary update for tp->write_seq in tcp_connect()
Date: Sat,  5 Oct 2024 23:58:35 +0800
Message-Id: <1728143915-7777-1-git-send-email-guoxin0309@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "xin.guo" <guoxin0309@gmail.com>

Commit 783237e8daf13("net-tcp: Fast Open client - sending SYN-data")
introduces tcp_connect_queue_skb() and it would overwrite tcp->write_seq,
so it is no need to update tp->write_seq before invoking
tcp_connect_queue_skb()

Signed-off-by: xin.guo <guoxin0309@gmail.com>
---
 net/ipv4/tcp_output.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4fd746b..ee8ab9a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4134,7 +4134,10 @@ int tcp_connect(struct sock *sk)
 	if (unlikely(!buff))
 		return -ENOBUFS;
 
-	tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
+	/*SYN eats a sequence byte, write_seq updated by
+	 *tcp_connect_queue_skb().
+	 */
+	tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
 	tcp_mstamp_refresh(tp);
 	tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_connect_queue_skb(sk, buff);
-- 
1.8.3.1


