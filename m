Return-Path: <netdev+bounces-250218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E92CD2536A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D62D73004E2A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A643AE6EE;
	Thu, 15 Jan 2026 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBoWYs2h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377393ACEF0
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490091; cv=none; b=EutuNioND9/e8SkQtLhANCt306zHK6tCireCSSFnnh9kAQv8fmASvVzwEXwz/2EIK8xHm/cFPX3bbBbk4k1yD2PAq+LGooCrvhQlu3micObvYsXH1ej+GQ+vyRRFfbfkYlDxAcup9VJBbo4fJ6Js1PP/ScxrmCUhNdx2rPmdiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490091; c=relaxed/simple;
	bh=EmdrmrQatIkWYrWc3Tso6zV2W4IPfCbeSJjTG87cs5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEwaxhT0iXVyfuoL7Jx+kAY+GGY/9ZUbTZec4ey9GQwKVdUZvT+o02Ocre06bo6bKMrIgMpN+Lllc+4RMJM7p/EVBc4Y4l+vaaqBORHyinDb53X1RZn/UeI68foQSBGA5+BZL6u6qhyTgD/chJDvyPR/wYxODqLFNVG9fnv/v0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBoWYs2h; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a3d2f3299so9554266d6.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 07:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768490082; x=1769094882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XFWhnozczQdBY9wOF6c5V46t5MOgQ+lGzwQjjTNU9A=;
        b=BBoWYs2hHEOUT6FyQjNm4QI4AIsE5LVnSjCdAXGzD8YvxFZFVkmNnZ/xT+kOqH9z9n
         MsS0ahH62YfoiSIgriBzvWEtmB0vo1PFHlAQaWDKzDQozcfFRBGQPCzgeVp2zriI4SF+
         HSkE5uvCSjP5HpZSpOd9cV2mCgwhWbSBQ+XC/+IkuSOXzCOpnJbdWkCNWZCj83U9vHUb
         EedyEpXj6Yzy3T3UO6UlPh3YkHcXzBbp2NhWIqLAUSVXL/hWhbPxF9E1stM0L5orYWZr
         /e6nXGYWsGtNa3CHB9TWKFhuwduoGbfX/lrDglH4XwW7mTHSj/Tz6TBHT7cYBCtNglZg
         F2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768490082; x=1769094882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XFWhnozczQdBY9wOF6c5V46t5MOgQ+lGzwQjjTNU9A=;
        b=Pi6pnfw/XMS+c+NpX7eNE+YNx8Cwrb7OW+CfoPLbY+8aKmaWHXlWeEOLsz139MSyS4
         6BZTsNUUJFI6iW9i9LnMBPwaMh0nl6qEZm5kwJQ6EjLFGA2LQQWblk7TJMgoAbRqNFZt
         CgLpoHp83WCoTJ5YkPvVGiatNRy2Mm50K1GDZUptcOTDF5SA7ePIYotlyXI5iZe7zhwV
         fF5vLKY88Ebg8mhlb8bHfjS1G+Q/CYuqDhS/p7jpdZZtox7ORDFUorAxI3cN3UQxKB1s
         xJfr9Ks5X4HUDW0zGqMnYU4kf9g5PxvazQU89IZsISvBFk7kfXTFRvu9ZwAznY5H61ii
         EZeg==
X-Gm-Message-State: AOJu0YwcSB3HG0wwQenBE0fVWnHqcnOzCowc78IUjCrFhFeqgo9pe1TT
	4f3KuASRJAIhUg0G4EKYtljN1noKYrpFU0PU6ioYpGY4eFEHtDE7alLfQG5cc4BD
X-Gm-Gg: AY/fxX5eRvdV8EF2JTlQVxpIYLuoMplkFulS0CKKHcJxRsiHDVjhN8jUktWyJrMBZfz
	TnKXDESfSzbHtgdm7n1Foc+Erbe2j7GnPsvzK/VlcWLBvkXVvwFRrABQ/HFNP7TmM6mXAqu0iV3
	f/VHxY/5PKYGtUUHKVxAIxiBaBL6j/ivxV1v8XPziVktV5tungig7nzg1ENBbCVrTD7fdCkd+aR
	EktbAdNI6ET9dMeV+GdgliSGKk1NAZfFwlNKgD/6PO4i+GQsgwb2vCdhhLilhdfIySlK4I3Joq2
	GvpgJHrV2UY+Xhw1XBc6z2FHiP5hzhpzZk6/Ycpan42VUeUMymhK57/hVIl9pBMuVZfgNHFNlfF
	Xr/EUCwvslSMfSTg14eipgNwlj1uhPip1a8EHTHJ8+BHjPHqnrpc7tHrcYR9sfeaDGt1QhcYV8w
	lvjr7cTJ6dTGep2RlAwfpQVD3XycewYkZKuXsdQc+Kb7KfWbl01+I=
X-Received: by 2002:a05:6214:4003:b0:890:58b4:3e7c with SMTP id 6a1803df08f44-892743ded60mr90739606d6.33.1768490081454;
        Thu, 15 Jan 2026 07:14:41 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cc6edsm201030056d6.4.2026.01.15.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:14:40 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	quic@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Moritz Buhl <mbuhl@openbsd.org>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>,
	Thomas Dreibholz <dreibh@simula.no>,
	linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Steve Dickson <steved@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Alexander Aring <aahringo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	John Ericson <mail@johnericson.me>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Jason Baron <jbaron@akamai.com>,
	illiliti <illiliti@protonmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v7 01/16] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Thu, 15 Jan 2026 10:11:01 -0500
Message-ID: <87ccdbc3b8abe4fb1df5a97c0baf39d2b943eeef.1768489876.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1768489876.git.lucien.xin@gmail.com>
References: <cover.1768489876.git.lucien.xin@gmail.com>
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
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/socket.h  | 1 +
 include/uapi/linux/in.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index ec715ad4bf25..dc80de8d8c50 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -401,6 +401,7 @@ struct ucred {
 #define SOL_MCTP	285
 #define SOL_SMC		286
 #define SOL_VSOCK	287
+#define SOL_QUIC	288
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index ced0fc3c3aa5..34becd90d3a6 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -85,6 +85,8 @@ enum {
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
 #define IPPROTO_SMC		IPPROTO_SMC
+  IPPROTO_QUIC = 261,		/* A UDP-Based Multiplexed and Secure Transport	*/
+#define IPPROTO_QUIC		IPPROTO_QUIC
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
-- 
2.47.1


