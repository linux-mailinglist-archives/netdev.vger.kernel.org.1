Return-Path: <netdev+bounces-293412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOo1EX4zHGoOLgkAu9opvQ
	(envelope-from <netdev+bounces-293412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:11:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EF16163DE
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3482300405B
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A69A381AE2;
	Sun, 31 May 2026 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEWeFCDF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9838C400
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780233081; cv=none; b=k6OpkIp86qQEW5Eb6N+2j/7JnDUy4xDpFM6/sgWLBfZYYZD+CQ2+UTgORND1IuxKWguY1yrymCDwPW2VqEkiPlmMRVs1qZd9P+0WDKmX8PjDv4veViljf5VU6E3+ljwiQDlQm8cL6Qb5KAcOztdLyYR+kQT5u6HRQvUzv8aRjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780233081; c=relaxed/simple;
	bh=+r3tYa1O4nzHNXgUenOGoOEDKkt9r6oEsRxV2HklKR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxBUfnHTelAXqv1w6vifsyoC0PsT0N01jXORDocs0nqb7Ae0hYaxMql4VWKG6walHx0nTPQJgVxk99RUr0V9uK4Or9EFNhw/T1DSbzY/wQhwj0ncu476J7KIkGbIFXgihI0Ki+hPL1NZdK9z5ipHEvs6rWsoc3Em8Ehsc/3ghDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEWeFCDF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce65629acaso8576686d6.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780233079; x=1780837879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfoS9zHnWtS92mtRPUnEWGWkqfJ2EjLVIhUjEgbm2M4=;
        b=EEWeFCDFiQf9AhAvLPeEbS02wHJ+SoYg6i99HiHKVhq4nf/Ka4UoVhZo/6PDA4zTmi
         /zvGa0MYJoQ7rrAyFO66WhE0W6qDW16cj5Uj+iRqsClv31IMWO2aSWz1H/GMaUWZ7CoV
         yVI9MP6LBSRRnL6ABaqPi8HybBbYel/RHp8vuBjQJzESYR55mVLfeeGPw6qZmUmRq92m
         LtPiTBqjRqxdQk9Y5lNN2Oc0JvWNLx5hR9lMSWf7SpMW8A+pZm3OGZJqKoo0lO6GFo1/
         8MD4XYvBrCnHYfBxe8t4GEmtiZJzrjoG2zEmdGG07NHqUmi0Nw7i4bkbbTWj7CCB/dvp
         20hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780233079; x=1780837879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CfoS9zHnWtS92mtRPUnEWGWkqfJ2EjLVIhUjEgbm2M4=;
        b=sRaxFbfZREzOtLxxG94XYcohMayYnzjTH2YSYXRnlsQW5zQwX+znuSJhrG3uwxboc+
         vpkiHx9L/bMpKJKxaUczTxZjI/2NiqMuaWkQMxKnvdH/8iqwl/pRfUcU2gOzJMO/FLNz
         h4RPAqmeLYfhVpUxN1osB+bU9c83h1hw4olHG90xO+LW7TgkWXsu/4WxrGgSK45zKKnz
         xKMJNAz43LBPW2nKtjEzjumnCykuZ1ys6H6HhART/PZDdomJZ73iV50mSESwDkAAG6ZP
         usqcdJySAi0JzxHqBaqUGVKWnIxBvqDR9OGNyaLB9qGPhbmocD/ODvV+dk0WRHcLlqyB
         Y1pg==
X-Gm-Message-State: AOJu0YyFeH8hl0CABk+0A5KChqlO/dDjWM4y2UkE/XpNhyn08ugde/la
	r2W4e7RAMeILV8L7YRidDlihf9W2a2buc0T0uZt1IWcZp6voEN+CYUqHYrSXimyFhu4=
X-Gm-Gg: Acq92OGpW4mVaGkn5DjQD3ZFF6krzprBbiB0hoTvRXtRripI38Xgkn9cdbmXwghqEty
	VTpr66fWHUbBMR2/04/Q2D3NYbdoHJbEHFOlptGA0bZ/TLotW6BoMPK/BTrW1sFC9SidUblj/5p
	Gns2lBoxrYVXUfHbDvxT1XCelnKKDJCltwBS+O6M6NbzycxlMH/Gvh/x8zHvj+Pm600tXh7v6C2
	Z4aW8TRy3iifgPeHQFIuszBY0is6VZTX0n/pObJzloP2hJOp9PNfoEvQaLGKM2h14cPR9jF0J+v
	Q9063+K4wYNBS/mp5oHW3zZ+6zgShv01R5RgIftFl8SXPVPUgHs4zHS7KYfuQSU7ocL5TiNMWwA
	egHV2nj913HvD1PuQkQicgtczdYJT+abhmnp2yCbHr6PwbMybf0iozPEpJKbUvgesgWpDZTpHvW
	nF2b7WI4/YbOMiBYvUKsX5AyGW6gb4o+KwEAU9rkS+9F61XpkfevUB9HqpPWkFDCJJsd1II7S5a
	jr1foWp39xejn9NO86x56vnNAAEd8JJuYd/B4oK45xyExjTjrq5BwhfR9+NIGMzmN7yLvUS3+LV
X-Received: by 2002:a05:6214:2a45:b0:8cc:e102:b491 with SMTP id 6a1803df08f44-8ccefd3d97fmr123451416d6.4.1780233078757;
        Sun, 31 May 2026 06:11:18 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea2163b0sm69609746d6.38.2026.05.31.06.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 06:11:16 -0700 (PDT)
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
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	mef@scarletmail.rutgers.edu,
	paul@jakma.org
Subject: [PATCH net-next v12 01/15] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Sun, 31 May 2026 09:08:37 -0400
Message-ID: <36cb9b831d8f83dd9a2ae38a8b8d81e502df388d.1780232930.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1780232930.git.lucien.xin@gmail.com>
References: <cover.1780232930.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,vger.kernel.org,gmail.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293412-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 48EF16163DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
v11:
  - Set maximum line length to 80 characters.
---
 include/linux/socket.h  | 1 +
 include/uapi/linux/in.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index ec4a0a025793..9b6c3cd766ca 100644
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
index ced0fc3c3aa5..e4072152f2e6 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -85,6 +85,8 @@ enum {
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
 #define IPPROTO_SMC		IPPROTO_SMC
+  IPPROTO_QUIC = 261,		/* A UDP-Based Multiplexed Secure Transport */
+#define IPPROTO_QUIC		IPPROTO_QUIC
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
-- 
2.47.1


