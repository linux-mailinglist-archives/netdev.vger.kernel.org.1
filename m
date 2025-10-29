Return-Path: <netdev+bounces-234013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E734C1BAC2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A09855C7370
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE4A2E040D;
	Wed, 29 Oct 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2OP5Ifu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7C2C0296
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748771; cv=none; b=tI2CqQAfCHKL0ZHHwB7bz/Wye1dO3vQkTeOQII7V1e96DI4iVKRUSR5UEn7j5aUZ+8SGDSM+VcPWADVKmHR125Ax6w5mIKzDuxTb9PT1vINq6xHFausVvxD/ART14KRYx1FqmYT/zR1NfEybnqiye4krASXeaLmI1bwabRLz/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748771; c=relaxed/simple;
	bh=AXo1SVGHBK9qT4qVLa9ToApVKadhJSI2IuUi88Evw0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5mS+RIK/caL7Ba5nqjt+TFx1G85BNogzSxTN0P6gJi5in5M2/KU3xuP94oQoEXTgI0eAr5wR8NNLBnc8pAOp/BEG7ZXsEW+O66oiRJQGESXMW7fWUCkZ+ndWiFz68L5vInoR1tdGQ8a6k6iF/X/qUQ+iboK5XSZ4VLkzZO3Ov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2OP5Ifu; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87d8fa51993so85477036d6.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761748768; x=1762353568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JTNUO8XZtm3BiSnNgj+nAIXLdP3RxRAv6TMRPMgtSY=;
        b=N2OP5Ifus6hJ1yeW3L3j1483QZYWnqbE/H0wK2W3QtsPN0soNwuPQK74sVwSF/l59v
         O74/OsZeVVRxr8pL+CWWm/28wv6g77E33zqhov4jD6J7LBvmzEfJ1DlOtshoIkjkJmMQ
         dqGT52sXRRSQ+/JHn1dFM0b3gyDk1oHA8S6SbRB4YfcZCjKuGl/H9bCM62Ns5H0OQ3+R
         q6Z5VYMPCtwO9ido2YvxzOYcRmEowqCQRHJO+oCqYAuYR/IN6HuzG5bXumd7iRJUEa6T
         1OEu1cZBzp7daLZ7OsSnjdMmDv7QY6oljSpVH4fWGtj7vWUGz1KBQLScld/LEaZ6OWBU
         ZIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748768; x=1762353568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JTNUO8XZtm3BiSnNgj+nAIXLdP3RxRAv6TMRPMgtSY=;
        b=XvzhEATzpnbTwur3BbJb5uPC99s8UZBnsSnSFgDCwoIlOTRzd7+QcQvzsj9UHc/lBT
         O8USo8F+k+I0hT6f6Ldg0EHORUyMpCLKmFSefIfO3f033e4qH5ykzal0VCinh+1V8HaQ
         XNPlwRC3I7YwLU0WAYkG0YHBb07xgbVi87HF29Dbf+BPWB3/dxDWBfFEbLWDUoTWXxO7
         +58Wkggiab5FhYFSjK+kr1JKx30+TC1FQ6oDBdLZFHweXMsFxinRVW6oKmUvCWFw1um7
         oo9meJvhlpvA0S4KvsB25gh7hfEh1jZusTdBUzStf3jm34ieqrGyUA2PubcfuwvksJBq
         6iPw==
X-Gm-Message-State: AOJu0YzpjzhYKNByaUDmVFQpAFlDlq98SBaaMQlo5EgHm7QvRUaGtR15
	ub0xeYDuLAtaiViceiAWDEMZXeCTMP9KdlHfiy6K68NEsGJtvZK+qD6pqRojvIKo2SA=
X-Gm-Gg: ASbGncswMH99c9lv0T0ZGnX/496S9x8r5hhtZ0w8PamkNgAmftSuW3OoWQraugw6MzZ
	Wl82GpdeD53jMZR8SoGc0GPFlBfY9HtTY5xAjGgAVqFCyDyFt5+zg6GhtQMejdyFOcQA9iwUekA
	FYFW0GmtF/9BffpT5kDFS0/D9i2abkplC38Zfm6YEuZnBXcVK7kK/Ik9vyG+CMqNrxQ9+NIHUWM
	gbywl3xLlwbZM3FS7LFrG5Q/TgYNKv/5QmnVmPK6666FJslMrdxuVIZeDBTJIa7D0W9OiH3hzK1
	onPU2cp7zNbMJnMAiJUlH+RE+8uAwkOWuVLNXv2vYcgcI86EE+agn75xmgP9c7/HLeiHBRcROfL
	QKg6sByWuavL5TeFCk45BXqg4t8HFYGwNDynhgVmwx4Ngwn21bIG0GQ9zp2L2InEeDgg85AkM4i
	xrZVvjFn/dybE3BOEOP1WhlQR8JpE+qsmR54e9eRpZ
X-Google-Smtp-Source: AGHT+IGyzU3okljrfBCf/3gBF/UjoS6yWE5KKQezp4IEEcQDSObh9/ucSBvOo47HR55wvw5r0njlKQ==
X-Received: by 2002:a05:6214:242a:b0:856:d1d4:d127 with SMTP id 6a1803df08f44-88009ad5454mr40989826d6.4.1761748767895;
        Wed, 29 Oct 2025 07:39:27 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a8bc4sm99556176d6.7.2025.10.29.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:39:27 -0700 (PDT)
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
	Benjamin Coddington <bcodding@redhat.com>,
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
Subject: [PATCH net-next v4 01/15] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Wed, 29 Oct 2025 10:35:43 -0400
Message-ID: <c02ccb3edc527cbb1aa64145a679994dd149d0da.1761748557.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1761748557.git.lucien.xin@gmail.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
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
---
 include/linux/socket.h  | 1 +
 include/uapi/linux/in.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 3b262487ec06..a7c05b064583 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -386,6 +386,7 @@ struct ucred {
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


