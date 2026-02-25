Return-Path: <netdev+bounces-260733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBBQBPxfnmmaUwQAu9opvQ
	(envelope-from <netdev+bounces-260733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:35:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A94BC190F24
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 184B9307319B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B928A3FA;
	Wed, 25 Feb 2026 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhRm5ca/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A72874F8
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986937; cv=none; b=dx3NRAkrRXxt7jRXitALDU5cYxbVw2vuqxkh0/4chsQ/doVX/Lmj0xELLAcQRVqe3G8FWZySjUV/4ysU+sOt6iODovf5FdKqAJDqXERx+uagjn0GDGDP78A1eVVrmacD7cH6K2jCR0qlgra/0ktgYZgFbl1PtosQNgpYn5YA/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986937; c=relaxed/simple;
	bh=EmdrmrQatIkWYrWc3Tso6zV2W4IPfCbeSJjTG87cs5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3bz8yc182sWN+Etl9X0rVoshAO2maZn3yOlLxzSSVDylHIK1xUGyXK76CHt6okq5Ubj9fizv3/2sW+PD7U/tpdGxh11am/tacxYwstylJoGHGi9A40kDYEg0/WBQMU8ewVfmIqae0/SdvJn/lZuzu7RWbvT09MyWz1LXzEVXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhRm5ca/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-896fb37d1f0so43887846d6.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 18:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771986935; x=1772591735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XFWhnozczQdBY9wOF6c5V46t5MOgQ+lGzwQjjTNU9A=;
        b=DhRm5ca/9kXnZ9A7f59m5kWNeZeCOMRPWhaIW25VPoJUiOSzvwpbron85i4oxIxdGy
         9l62kSv4p3qBegbxpCPjczAxdPUAzcAE8ljLp+mrILcs6qMtOmAczzlYFlwk5XChWvxh
         HeQP7mS3IKKi1aWip5sY73lWuBpZlT+0kRm1c3FV0Y7aA10zKPHn4Ca1g6gMsT6lPqSw
         mUpS4lr00fQHEb7sC4Klm1UPEhI0UF1+e4jhb26E2y0sALdhs0RUAtNsR2Qe8jDS8Fvj
         aOp3uNWSFafRc4jbbU6/EOdgQ/KfCx4XZyW0uoS8ZkTSGqzxOrxF3N2hm97LFRbE8Pj8
         T+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771986935; x=1772591735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XFWhnozczQdBY9wOF6c5V46t5MOgQ+lGzwQjjTNU9A=;
        b=hMIrIvqXcJUyxg8l6dhuqiYI42k0ouqg/FkJ7C89+qheG+wuQtzOmm8htsltNRp0Nd
         e/7ZSBw7P25nRBqOVCW0gyMEVYYWXfE4Cq5zpXpFHkJWLxWsElKe2CBbAlmG81Ck/0xS
         DSNV7EuTz9wwr4aLH3BulahoYB+lODWBykY7OJRxj7EJKcDanKpRG7b21ZIZ2hXZ+g4a
         51DzsJwKgdXstia/hjOdjowqH0r2txSfU9Hb2bFG+Dygxqogn3Lwnpn4sMpUcm/P2Bdq
         /cvBfLMFvMr/3p14Zy8hKvMUpYCX4fM9s2X11zQnSrVQfGpOwT+dH0AnRcFLqBGdOLa6
         dYQw==
X-Gm-Message-State: AOJu0YwmNSAz2zsN+fIBKblspEvwjnoDNu5ldsiVZk9beerv+LYkvGHP
	jv5bZNBWBX2OkXb1RQsMVW/X687hDCcTa36Xq6an25OlSJZr5LmPFxRLgUHB56+N
X-Gm-Gg: ATEYQzz13KXg3Fayjx+oWEmuZ46jj/1N7gUyG4SDUyFSgyt0F5VJeIu8q75DmoDjcLD
	VGVLyhxTe2iebjOITqaSXhl6xmfAC6g6VC2zQJ7wr7thhVXrM8qcufbcjXfzPRNyDwH1O4LdAQt
	hwJC6hWacLvWnOVsoWQpBef/APud6bTSAvGgls15o518LcE4g50GwsZwzTHp+hlgP2STdhvZp8H
	R2xF4EiQomPm+J+I/kvOUO/wttgDfItC3760EpEFQVQKVNLMNegRcXz8XBApXC2nijKURl2pI9W
	C1BwHaMuSCqK/P1c2668NAfH2pguwKkKrwcA3gdVNu/ukmcttvkmeHwHxU+dH00u++RtqTzrOac
	t2R/G/5YkpYcoQHnGmo9RV/nV4hnEU/W2jFJrYasWihEuROHZMkQOWDbFPJNgtr0qSxXQJUlSX6
	2RPiGs5t0t0wDXbovG2J9eO29OrlFVRSkYleMwzylWkYB3lIrifu0Fn7B75LNXsGcW6Uhkvv+eH
	4BcwGt4ZECM1H+AUyhwfzSTE0PqouUKrXWK1xFsTkKcNmVTSMUfF11ry0hS8yHXDQ==
X-Received: by 2002:a05:6214:e4e:b0:87c:2c0d:309e with SMTP id 6a1803df08f44-899b8c1ee0bmr10279896d6.37.1771986935317;
        Tue, 24 Feb 2026 18:35:35 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm112363586d6.36.2026.02.24.18.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:35:34 -0800 (PST)
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
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	"Marc E . Fiuczynski" <marc@fiuczynski.com>
Subject: [PATCH net-next v10 01/15] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Tue, 24 Feb 2026 21:34:07 -0500
Message-ID: <d2fd583ab20f2c8fb9ed91bd4ef1afb1d75a8797.1771986861.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1771986861.git.lucien.xin@gmail.com>
References: <cover.1771986861.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260733-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A94BC190F24
X-Rspamd-Action: no action

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


