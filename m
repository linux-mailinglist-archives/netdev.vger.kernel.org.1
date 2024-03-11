Return-Path: <netdev+bounces-79217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D20878511
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17023282724
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72B4C63F;
	Mon, 11 Mar 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv0gkCXB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA014AEC1
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173984; cv=none; b=hj8HUf1ioB9CtB4QfPRgtui2ix6sOHI8EkDKrypFdERcEx0Q9U+4ZovGlZHAaEjoj8GYwzgvSKO1to/U9c2/SiFHgIlUf1MpSmzd6A8c69p9BZN0mukpKDCtrwkiy5Tt26pItrRT86zFPekvsD9RpdK41xC65jpcC14VYyOKsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173984; c=relaxed/simple;
	bh=c+B7UgR66N15reEHbkl+Y7uzoy/IkbcEfL6S3jHr87Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci8B1ZPT0cR6kMKf2wCWsYkqCsuhsiGZ/WZ/tq84wB6xcqloIUCYGZPEJ4il3OyeROlQF5XiB3zyDQNJs4CnKt4CWDjugTsgyOIdgkSN7K0lYx5AWMstxgkaITg/50CZ4FOAECJ16Wgb9N9gVMQy3fqa1WvIX2JuFsEwkqzG5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv0gkCXB; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690c43c5b5aso15014386d6.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173981; x=1710778781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4exi5d/yvNj3CP7759dGB75kdSVVFjjVwdTDJwYCT5E=;
        b=Iv0gkCXBObXpytwch8jcytRs8Z1YEPQrDTsHDYjIDlE23HkMrlIeNtu7Q7RBO15y0K
         IKQMGoiV69n/uiUDp/IYBYdrtMugHYqtk5lr8BzzpTMIud9MwEEpCVtpirdw06b+CxuR
         uJfCfiOfFNmdI4NTDDhDCgTBhxvc4/qmSEH4HG86TYfUyXPNoJwqzF+C/yDxvLIk6ICl
         ae+R2L+yMuGfymkVI2inbZOW94btl7FS6gqXiY32RNUaA6rMe6+qn/Wz3zf2yD94W0H6
         4yfQNxDs0awC/hBPajqp67Mauh0OatfNa3FUncjFoY3vvSDCC4jh54hm3FUVjItGbe+Y
         Lu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173981; x=1710778781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4exi5d/yvNj3CP7759dGB75kdSVVFjjVwdTDJwYCT5E=;
        b=TVedKXfaPBsIar4cdJnjEtuAFJNwp+KDGLk6BRcXgflrdcsr64CYAwl4jfrR0ybxIn
         jkPyKZYT03XZf4IJyHWH15n48wTg1UTpPm7XAAUk2Y0tXkcXqxb15oCxRW+iVx2UDjQl
         ogtSYnH5e1NpwwpNbN4LtTkKIuFeE3SlfrGbDAKBzzqVrMoSBywmWXB+Y6J8Mtyj39U9
         Mg5Bh1r7Su9VxVIArI0lx0Xh1hycHThCBwEC088jSBXpCnnF3eUAA78C7t+bkLZBu0/O
         Cyj62rRkvbHdgo2b9zb1FuHiopnrEc6Z9hJiZhtY3EtsvKI4hXYU96YMPkjP5s4YGi07
         tENg==
X-Gm-Message-State: AOJu0YwtZsz7nFOXkZ/1LBBJG0p/X5ibto+oXgxSahGCyNDGKlkJdNmQ
	ayInFOkyQCQPn6CCD565Bpj7MjRBmh5LY7dLMydf83UF/G3oWEZ6BD9XMRj98Nc=
X-Google-Smtp-Source: AGHT+IG8//5Zrr6PTdi8TKMRW00pTbvo/uxQwpr2lIGPph+ZigeyDIHpHiq2xh64pDYnC0BBn5aT5g==
X-Received: by 2002:a0c:f051:0:b0:690:58d0:4fe2 with SMTP id b17-20020a0cf051000000b0069058d04fe2mr6994595qvl.44.1710173981483;
        Mon, 11 Mar 2024 09:19:41 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id w18-20020a056214013200b0068fc5887c9fsm2788245qvs.97.2024.03.11.09.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:19:40 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>
Subject: [RFC PATCH net-next 1/5] net: define IPPROTO_QUIC and SOL_QUIC constants for QUIC protocol
Date: Mon, 11 Mar 2024 12:10:23 -0400
Message-ID: <303bf7865d2bae6f7eb563d2424e0dcbfa2b9bef.1710173427.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710173427.git.lucien.xin@gmail.com>
References: <cover.1710173427.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds IPPROTO_QUIC and SOL_QUIC constants to the networking
subsystem. These definitions are essential for applications to set
socket options and protocol identifiers related to the QUIC protocol.

QUIC does not possess a protocol number allocated from IANA, and like
IPPROTO_MPTCP, IPPROTO_QUIC is merely a value used when opening a QUIC
socket with:

    socket(AF_INET, SOCK_STREAM, IPPROTO_QUIC);

Note we did not opt for UDP ULP for QUIC implementation due to several
considerations:

- QUIC's connection Migration requires at least 2 UDP sockets for one
  QUIC connection at the same time, not to mention the multipath
  feature in one of its draft RFCs.

- In-Kernel QUIC, as a Transport Protocol, wants to provide users with
  the TCP or SCTP like Socket APIs, like connect()/listen()/accept()...
  Note that a single UDP socket might even be used for multiple QUIC
  connections.

The use of IPPROTO_QUIC type sockets over UDP tunnel will effectively
address these challenges and provides a more flexible and scalable
solution.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
Signed-off-by: Pengtao He <hepengtao@xiaomi.com>
---
 include/linux/socket.h  | 1 +
 include/uapi/linux/in.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index cfcb7e2c3813..f6533dd520fd 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -384,6 +384,7 @@ struct ucred {
 #define SOL_MCTP	285
 #define SOL_SMC		286
 #define SOL_VSOCK	287
+#define SOL_QUIC	288
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index e682ab628dfa..3d7b35d1139a 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -81,6 +81,8 @@ enum {
 #define IPPROTO_ETHERNET	IPPROTO_ETHERNET
   IPPROTO_RAW = 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
+  IPPROTO_QUIC = 261,		/* A UDP-Based Multiplexed and Secure Transport */
+#define IPPROTO_QUIC		IPPROTO_QUIC
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
-- 
2.43.0


