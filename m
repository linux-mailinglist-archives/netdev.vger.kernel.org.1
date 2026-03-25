Return-Path: <netdev+bounces-271360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PgIJaBbw2m1qQQAu9opvQ
	(envelope-from <netdev+bounces-271360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:50:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F61731F3B4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8C7D30614E2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093371B983F;
	Wed, 25 Mar 2026 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0Kf0gSe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186712E1EE0
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410566; cv=none; b=g0WH28tleVzaCwb/Bn/AA30PJ14A/ClEm56IVMYq99zrvoL4ImjC5cHlSlvEILykoXwy4LCndTqb9rm4WJmNrXZ7hVS9gAybFBnLUn14QOEyFwkLxwrowm8tZhmsLhIC3oqNikLWwOfo9y6vgOkKZQMEDhyfIvEx24G6e6kKvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410566; c=relaxed/simple;
	bh=+r3tYa1O4nzHNXgUenOGoOEDKkt9r6oEsRxV2HklKR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIIhQ/u7x2T9mjKflKWLQcH/kOikMMU8X48f0RDMxyO5wa9DLT8IaLABphNcvE50trPWjjyItwo+3JDJ+JdWN7Kw6z3R5FJ0eh2JDEQ7FrCqJOC2ZhOO/KaVsCkqQiVhzn3sI9LC4GhOg3D/R/MMUPzznNF5bSjh+YhSPo7E8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0Kf0gSe; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cfc5941028so685141785a.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774410564; x=1775015364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfoS9zHnWtS92mtRPUnEWGWkqfJ2EjLVIhUjEgbm2M4=;
        b=V0Kf0gSeT3F669KSka82mKuzlY/dgtTlEf40TAs98ct6J8A/3+ybwJWPCsQbHuKb/K
         Pxg43s8/7hLYBIvKaRqOFMkZV5YvmLR0uuASkWJX1QHcEOWWBX4HRVTeEHvSaM5RvTeW
         9DUb59NjKrkS7IHgKkLr7EgLmZGL4GwB8sPN+yZDDt9g4vGObr+E7qjbtqtxhCek23u/
         IzhIOOjmAR8VuNpIOlhJiTsSfT516+GPIFg2r9FZhL87+UtQOoLREeiS3HbKJyiLkAbp
         MrIGtRZBTAV3BYeybz8V9l6EeB9eRaxTjFHeideMXHcotmMGjuD+lHmZkAeYEI/199s1
         xapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774410564; x=1775015364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CfoS9zHnWtS92mtRPUnEWGWkqfJ2EjLVIhUjEgbm2M4=;
        b=bGJEYk3Mj+YcIlX3zm94Pfet2ZgjvVoTKfSp2fMX1QPrSm8Qa2MiW9+Y2Aj/nPpXL5
         LGMoMRCGXvs3fAkpm+tEpPGENYVETF8RuQjbbqgoHQUObAJt+jwfP9zXHGdLYH97oQjM
         z0ce4BUoqfh84Qq+v3OchR73SX4Y7MqTWFxbNKEsSYgjIRCB301HH/JZDu9QvOw15oBd
         Rsx2l59FdYb4W1DuOTvyOwC3wu4FhjIz1szyU22IJFvhw0sPg7xezGnfIDjfinncVAnC
         gQn5LhM8wQRusrRXrdaRsatNlf97yHqgBhdfMZ8dKs8OxUrjLMDWn4piNMDHLTllMTCu
         a1vw==
X-Gm-Message-State: AOJu0YyFd5oAIs0SZG58pQrR951tXyp/YzVVe5JGhiQmDwTPG9zSJALK
	QCKXyJpniouRvMQ/W3/PuvXYjtdDUPS84GQ5soMhQFCoBANiIhhboIFW+4SnO0KQpqA=
X-Gm-Gg: ATEYQzycrPGr715aWF7tmHd7IcS4eYT3bPTOmOe0Tz4CZ5NheJJLJqoMfEeE2FAmBun
	rGnljhdgYL9fMndPvZTyNvHwm5WgpjzESNnZlL+gbqCTYf5HKWBpF7iV76rwbG1H7OGDgWExNg3
	2xbj8tniZQ6WuJoSjkDhj2sgCVV+2FWDWyAgj1QygK2SkZSJxp2+fEf4fu8WAyBgneU2Gma0YrY
	Rx0yxdhvvRPb1a9E/wbojpIG5gh7hO31l69BBVeH9ju+CI9H8EI4wDa0zrd6xULSN83UIfZhGPk
	/XP02YnuvirOXovRnXll2dojIfiqK41oi+NpHJRigkXmNaKTPzp97PLS/xlpcEuhF3zcKDhDlzI
	zKj61eeD2D7AJlbOwAovbOof72T8moqUwXZGeljy7TQ2kqDvcGRoEi5x+IzcaMUse/P/NWXXEKh
	OWDX2bX3httRlX/8sXSq2X97vyCLkLZBEBwOmCLZEhH2J3LWOv/vmQkvA7cWuvL0kjJ6qePQyzD
	diP9gM2/HfhnO0llPwdTwz0eFJXnDd40kMz9NVzZhKd1ih3bBICsOjlAwRXuL1mcQ==
X-Received: by 2002:a05:622a:5c95:b0:50b:483d:3669 with SMTP id d75a77b69052e-50b80e82d15mr29039691cf.62.1774410563747;
        Tue, 24 Mar 2026 20:49:23 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36cb2e29sm150093001cf.1.2026.03.24.20.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 20:49:23 -0700 (PDT)
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
Subject: [PATCH net-next v11 01/15] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Tue, 24 Mar 2026 23:47:06 -0400
Message-ID: <e5cb44e7a6ba57b63a3b13f853947ac88ec97335.1774410440.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1774410440.git.lucien.xin@gmail.com>
References: <cover.1774410440.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271360-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F61731F3B4
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


