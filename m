Return-Path: <netdev+bounces-247062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB737CF4323
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 15:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD5C0313B4A6
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F38334C06;
	Mon,  5 Jan 2026 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbs62fZj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750A3335091
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622095; cv=none; b=jjQONH8/jRaM9vYrQ2j5ZXArWGziwDUy4aj/H8NEyXa3/QuAJ37u5K8zR5aRgesqL+OrfoUA6lCwf5fL+NsCdqujLTHNJrYeeWlqbd0YE9GpE8529DPoYPfAsbuPYjwRFt8utpftQ2ymNWFtuhoMUznIEGmwBr1xeuYZPOxEkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622095; c=relaxed/simple;
	bh=zEN3doId9UKmo1rLmAoDue2BHiaeEn8l3OYvCK/ydP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG3rNjoZ4wiqtwyFKi4zoX86kQsgX1d/iqNPeJyuy19aExDrEObwYhZUgoTcc8NM+b3wMvDTDWXukhuXRr1bHR4uZSKLqMOjUw/JL7H5wuBRvc39Sx1/Wm2gskRIRazuuWjxYLxd3a31XINjWBY04vb5E+yuNv4fuOSzX+Yzw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbs62fZj; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4f822b2df7aso91750851cf.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 06:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767622092; x=1768226892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+6m+RaUAFXaTtrp8udufW/i4uBYkmLcVK6S66Yx8m8=;
        b=nbs62fZjoNNrnkNazI/VlOlZH5Z+0L64lVOdlicBv7qhRDSd3uzriUmI2d7AT6j8VZ
         3/0/2pZA9VeJZm7KLlZ5mL+a9XrnWjWkFPJrazCxkABXJ2giG1tQs8AZRZU+AtOgJ6RQ
         d4eCiJYHq30rr9/Mrt/RQcthrJsqocutb3vP63OxOR/s1dztkk7rNcUYlevVKhUFoAda
         JqB2MFTpqwwowx26y5ulIV9bidzOqZTuOgW3f9hXeCtvcJ50JhU+FV8zr/yFMEz/t9wP
         dLqhUmjzVcLUnZU5Hr6XHlffbzD5Xnee4+Z2AbWovpW/NfoOp7/6lXSQdVTJH/8WtVvg
         NfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622092; x=1768226892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+6m+RaUAFXaTtrp8udufW/i4uBYkmLcVK6S66Yx8m8=;
        b=uc4Jdi/IQG/bFmElp/+sWKUt1uytSy/qWuj6UcF/TEMKmolvW2Quuka2Y7NMGy5Jky
         qQBMvHlW5xNXKJ3a3uBpdTP37DR2jPz+PCNLo386AHZoAnd80bKqjyeVwNc+S5QbCb9Z
         kXT0JqutUzwZ5Jv5gjnIW2u1CTG3EQYlakTX9UpIQOtcrYZa+YYY8DUQ1SmbWz/acG+t
         j728FV18MQI4oGMb0Ujwdi3i2Xui1NV6oTWJy+Joh/8uXwLAn+ycrjSL/9HZwtmGRgX5
         2xWCCGT0fs4zJl8ccQwGJiPxqkpLBpKt2hTBCmPxMwt/ZCp/zjhkRU1cfG7bP5cJ9BNt
         j01A==
X-Gm-Message-State: AOJu0YyHuuaAeXtB8y+euuQIQ9y1svnrZRI7rcE7l2EimlUvOwlmcAu7
	4VDeOuWhY5gqaII9z1a76s1hc/F9UF0Gs0CWp+p7ZUPLo4XbJtTVl4YsdCK9xw==
X-Gm-Gg: AY/fxX72nA9Pj9NSBZIwEAY71ObdYJASvcJN28Z6OTx/eAxbpa+1bu7hZSMtZUk5pQA
	89vDqcmOHnhChn4DqyWW0AkNnXU7iDZvxe7TTEhbDPmJqb1LaaXi2LXEMkCZl7wdt1DCFTUhjIw
	mCmLPd3NSm/q/uPIJny60LronoX90wunBvGw7n6Et2alCzPiGj3msqyRe1rFJOHAvCpoZEq1p9Z
	jVziWdjryxDrZO1FnJG7mpRcrsGAoOysrMZU3YxZNHfFkrOGkzpHLiwYVsoDUbouFFoVkKWC1Ib
	6qL8j1F8//F805G/5rAvGIbt1Ef6hl7GmQppr99x+kFw7D6iuL1xfuha0PYgpVn78GtYiBtXS4K
	Rnvb33Hyt5ZCER9Od64untSwpwOti79OrHZO5sw/dSSz+wezVTDyW7i5jl16grYNNLByBvjsPzT
	PozdqZDkcY/r4PampRJ6D7M6Pr3njcfLp7KHU1Ax9YavrzslV3NhE=
X-Google-Smtp-Source: AGHT+IEHuRM2+t5qnRSVI0kl/We7szrHGppbL3OLinZ2JFHLaZJDDk0NxAF77vZNPlpHu38oz5oaFA==
X-Received: by 2002:ac8:5914:0:b0:4f1:b9ec:f6a4 with SMTP id d75a77b69052e-4f4abceebf3mr885961071cf.33.1767622091533;
        Mon, 05 Jan 2026 06:08:11 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac64a47esm368957221cf.24.2026.01.05.06.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:08:10 -0800 (PST)
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
Subject: [PATCH net-next v6 01/16] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Mon,  5 Jan 2026 09:04:27 -0500
Message-ID: <d04504f267ed7dbc7075b96e0da08feb3c301d8a.1767621882.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1767621882.git.lucien.xin@gmail.com>
References: <cover.1767621882.git.lucien.xin@gmail.com>
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


