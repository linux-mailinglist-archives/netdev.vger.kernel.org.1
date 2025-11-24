Return-Path: <netdev+bounces-241172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD41C81077
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4963A982E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904331283C;
	Mon, 24 Nov 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW13WELa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4131282F
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994618; cv=none; b=ig/l0726TNwe4xEf3ZNu6jc9Z0/8m1VDVNMYLFLe5FzG/W2GYkj6y6c5/OYYHtvAAYjPsi4B/AyjYASkFn2UZCUo/58/TL9f9Lj7y8DarFobKOBKUjNE6O8S9clgZG5QbtMPHGZKNT4Q3niSPMzqiYjPW4+TuhNuv2Ai3jimk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994618; c=relaxed/simple;
	bh=zEN3doId9UKmo1rLmAoDue2BHiaeEn8l3OYvCK/ydP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no7vnFXMS6VJ5Uo0LfHV1TaD/yrjcLRihLDzxIzjYPhGiylUSU2KsPv7Ss6qxKYr4IpSVgDWjignvpGbsHyoly+3cd6TjdvdP/MwNPvWQBPZVb23fnKmfDHgGKlx/GpcJ7w8UCkL34GJ5MowLkW/qOH/3Zla/ooEletHI3p9kO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW13WELa; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b22624bcdaso553160485a.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 06:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763994614; x=1764599414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+6m+RaUAFXaTtrp8udufW/i4uBYkmLcVK6S66Yx8m8=;
        b=GW13WELaCJZZMZ3DNGQpWMdvXqI6V8QQwIuSRUxUpZvgFRqJGWHu/J07UjUdMK6QqH
         hYOTrQBewdeZ4HteuDK4bwV6o0Qhfap3tQAo3+xxuWvZ8Tgof17KJzPUoTdmPsyUfsZt
         i48RolOTh9pJpMdMIREgY+TJBG6jW8KhH3HLram8CjYXdIM0UqjVzAO0Gw1f1AJk9I3X
         kpSq8P+gxnnikRerbMtp7y55jzCmTaNhgeClYis44G7tr2GjwjVMprJXlfxLqL+NwWK9
         K6PX3ycNr2IW01zcKPf/ZYZwvD+L4XUKNrAg3OH/g2qwOxASXGIh8pftERmmCxKNqWqD
         l18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763994614; x=1764599414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+6m+RaUAFXaTtrp8udufW/i4uBYkmLcVK6S66Yx8m8=;
        b=CdQstGOR/cIV2G0ILOLX3leVXt04MUAHBQuXc9zH0SMAncjRb857jjdqOs178hky2E
         EFR2I6gdOZx10iqHM2YQdoBTOvKHL7JxBhINcccvHAQlrWJdxc1VEApUpQ3L4nWbLXFE
         zoH5EvE/hv0wSTfhlGSyA0Sr9UwdWGEy6LGVDnWqMLBI4qMe0johxCq8y6MuRXkasj+g
         13mX0vS6cc8UQo/ImBy7FRaWmj1j6iVeFxReRaamatscVbUqJtTyK8AleM4GMIYAesyO
         hsI24hBzN4kqrzaV5gQ9ScnziURybti7h8k+pi/CQpLvXvL8YIGak8R0d1238tlBZjwG
         3WjA==
X-Gm-Message-State: AOJu0YwGpv2Vg8D6d88GLzTceQGvoweaD3Bm8lFFAm0VhinQpBiPRSCM
	CiAwM0QL4v/EyHouMY0dyFr1uM7a5IG1NCYLmztnFmDOcRCbAk8dgjSdlMPtXaOp/7c=
X-Gm-Gg: ASbGnctUGjNU+hOPCxFszjjTtDxL5izeYmMJRR29hICPO4V2te5wCK/Ma4GpA/Yuz6a
	Rq4vUT0Xv6GDISw9PLgJZB9XxM+YBkI1aj3TjC7RvgUybY8DDbgm2SnQLpGyEl4oYY5ZVHFP6yf
	oRIcF2OXjFmGXrSaOJJRqanZVgplHLpTY/EWy/3ICLqxrT3J+dt7k8WgxTyE9UVso8F1g8R7woc
	bKLeyyFk1HXtvpTpR0nmxK4jt2eTj0MPpedl9sCy0W8nI/Dz0WCgZeLxAjOEkG3Abe2EUOunHER
	6ilj6hf+NFQbTVQAwMFci2GiK54R2XH9lyrpG/Vf3VaiJrcnrKrfsSzsfDtr839eT4HJw5xBmX8
	cNJVPCXDoafLn/Y0oOga2dAkPst6rSS/0R2akCWVtGcoaOEEVLx7KQxXs2+4icEZGJKlsITUWZk
	UROQ9rCUfpw83w8CvEjk/wcrCVo4Qf3KXXlQkUqwJLqjyHeEhIjMvkOd9QFz5vVA==
X-Google-Smtp-Source: AGHT+IH2emMikOVfexZu/RJS4gdkfoIvqPQqU/1PYqEsqJ/9N0M6heG6ovXLI4KANvL5O6yungTZiA==
X-Received: by 2002:a05:620a:319c:b0:8b0:f04c:9f0f with SMTP id af79cd13be357-8b33d498deamr1470724985a.63.1763994614234;
        Mon, 24 Nov 2025 06:30:14 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3294321fdsm929713485a.12.2025.11.24.06.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 06:30:13 -0800 (PST)
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
Subject: [PATCH net-next v5 01/16] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Mon, 24 Nov 2025 09:28:14 -0500
Message-ID: <0cb58f6fcf35ac988660e42704dae9960744a0a7.1763994509.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1763994509.git.lucien.xin@gmail.com>
References: <cover.1763994509.git.lucien.xin@gmail.com>
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
index 944027f9765e..b4563ffe552b 100644
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


