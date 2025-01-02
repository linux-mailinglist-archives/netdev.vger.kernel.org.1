Return-Path: <netdev+bounces-154771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF949FFBCF
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA0F1883ADF
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C315B980;
	Thu,  2 Jan 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4JEZ9qU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459818BBAE
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835671; cv=none; b=HKLrqsseXzcUAtBYAADS8Lr5meJ1p0Z+3a0jNqgBMQ5yqwUAPzCtWWD5pY22iyEG9NxJ+6qYcWIESAZVLhu88X/qpFoY3FrDicq6M6XE0t6FGlyGdbDPccdzndSfp7eNtBwbscrEFtoEc6na4HSaEQwt59H8EWSNGIUy7Y+2Nr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835671; c=relaxed/simple;
	bh=hH2VHk5usEHWu2muac3LnMYM+2kmRkbt79tL6mJTEQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vng545mbwBdZ/D4jufEdJDYDVlXl46QabtoFQpOSgYk+LmSUCF+iEyFiLP4OLWMWuu7Zr9cxLrNH4W8IMSUh0E35Qku0d7+8VXYQYksopCCWp5Hg2XBVzStFvqejrsjhLtQYRb9s9eTsi5NtX4tjxZWVvq0j63zBuFp8aBHa49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4JEZ9qU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735835663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ZTtTZ+Q7MWtFriTpa2LNQ3Z0EHdCKnkW+osilKQ7/NA=;
	b=P4JEZ9qUl5zwFQA7fUpCOZxsvqTqSVnCBVqrR69jqCVdKH59nU7xHNrvq7YZOq0ISVH901
	eRWm/c3+1dER7NWrFPFbzWZLIArwrvoJ9/T8kE2QOE7rax5Dr1QSMnGiHX5lblzM3rxrva
	89UiFiWt3bf8pD3zL3sSbSJI5e0WpCE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-2r5dSUgqMte-O7OfPSsPSA-1; Thu, 02 Jan 2025 11:34:22 -0500
X-MC-Unique: 2r5dSUgqMte-O7OfPSsPSA-1
X-Mimecast-MFC-AGG-ID: 2r5dSUgqMte-O7OfPSsPSA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385dcadffebso5660357f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 08:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735835661; x=1736440461;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTtTZ+Q7MWtFriTpa2LNQ3Z0EHdCKnkW+osilKQ7/NA=;
        b=K9RXj4U2BTFlbSQMyORG8SKJlNJSPUSNIn408SDeG/mQQQN3asLiDy22cxDVQ7VSi9
         FM7ANJUmmD44axXAO9s6xrC2Dj2vW8ElS3Wt1yq/Q7CtC9Zhib6g8aQAJ017hr8zV9D+
         Umh7j0fSeYF+qVKbDAaV4KbV+HqE+xe/WVJtZzpAZelaPs0OMRL3Ianio/EBBtdpOXlI
         VXheQ/VFah26jYtu8vm+s6QmruZGvk8pw9uyKAmr4T9UVz7ZXOcv5N7+/sV1une+QBlM
         WK9zIpAZxyHzmyLb6hZpNsBpV08MRSIKTWyPoxMEXPhS8v9XA7VBYrUXaDG1h5ZitdT1
         Ak/w==
X-Gm-Message-State: AOJu0Yw4xio3PDDoDcvMRdUUFoIZYPPlntPyJh94qYjjnGNP4UcEG4Vu
	jtqGvksGGmOwzycpIBkCMTVv0MU4qysmypHIeFUPy92iDLILJJSJDG6q0cZoQVhZiL8FfalD4xd
	QzzCwN8qmGenox67pEegASLWRYaaMlxZ4LzDYebxzm2Vzm2XyyFZ6Pw==
X-Gm-Gg: ASbGncvA/SEgkRpgLV4n9DCEiR7/x/6PF0FSqUtjyV6DQxoDfhGj/8Ox5xjK9xkGFKx
	BKt9gRJSHWUChUpekPxVrrd5MhNrJtfghlof+AL8ugYQRwOgBzTVtoRftqElzP94ZahXTGJbppZ
	rjykOL9SoELIzbmJ4nKXj0Bu7LBBKFU5Waj3cM4mGXFLr4h3jo+q74H2YDudOjGviiwJIzXREhI
	j4JU39XszVpdPiw1bZfTd+B1uFoTMPuBgMKtWYPBlQvaUIWOe/PchWAM4msWxvbLoN1bS9UdeSS
	ELs8New7ySM4kTCNe53HfFMWIoTF5o+nCoc=
X-Received: by 2002:a05:6000:4012:b0:385:f195:2a8 with SMTP id ffacd0b85a97d-38a221f9fc9mr33164867f8f.30.1735835661102;
        Thu, 02 Jan 2025 08:34:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE82nvsTgcC6Yh/J6pBWP+NUJFHG2DaGkuhdzr+X/l4tLv8nl1pe7JeaOJel4VOyRqm6REp2g==
X-Received: by 2002:a05:6000:4012:b0:385:f195:2a8 with SMTP id ffacd0b85a97d-38a221f9fc9mr33164846f8f.30.1735835660757;
        Thu, 02 Jan 2025 08:34:20 -0800 (PST)
Received: from debian (2a01cb058918ce000d2a50ec66dd1898.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:d2a:50ec:66dd:1898])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2eesm39088130f8f.80.2025.01.02.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 08:34:20 -0800 (PST)
Date: Thu, 2 Jan 2025 17:34:18 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] sctp: Prepare sctp_v4_get_dst() to dscp_t
 conversion.
Message-ID: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Define inet_sk_dscp() to get a dscp_t value from struct inet_sock, so
that sctp_v4_get_dst() can easily set ->flowi4_tos from a dscp_t
variable. For the SCTP_DSCP_SET_MASK case, we can just use
inet_dsfield_to_dscp() to get a dscp_t value.

Then, when converting ->flowi4_tos from __u8 to dscp_t, we'll just have
to drop the inet_dscp_to_dsfield() conversion function.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/inet_sock.h |  6 ++++++
 net/sctp/protocol.c     | 10 +++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 3ccbad881d74..1086256549fa 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -19,6 +19,7 @@
 #include <linux/netdevice.h>
 
 #include <net/flow.h>
+#include <net/inet_dscp.h>
 #include <net/sock.h>
 #include <net/request_sock.h>
 #include <net/netns/hash.h>
@@ -302,6 +303,11 @@ static inline unsigned long inet_cmsg_flags(const struct inet_sock *inet)
 	return READ_ONCE(inet->inet_flags) & IP_CMSG_ALL;
 }
 
+static inline dscp_t inet_sk_dscp(const struct inet_sock *inet)
+{
+	return inet_dsfield_to_dscp(READ_ONCE(inet->tos));
+}
+
 #define inet_test_bit(nr, sk)			\
 	test_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags)
 #define inet_set_bit(nr, sk)			\
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 8b9a1b96695e..29727ed1008e 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -43,6 +43,7 @@
 #include <net/addrconf.h>
 #include <net/inet_common.h>
 #include <net/inet_ecn.h>
+#include <net/inet_sock.h>
 #include <net/udp_tunnel.h>
 #include <net/inet_dscp.h>
 
@@ -427,16 +428,19 @@ static void sctp_v4_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	struct dst_entry *dst = NULL;
 	union sctp_addr *daddr = &t->ipaddr;
 	union sctp_addr dst_saddr;
-	u8 tos = READ_ONCE(inet_sk(sk)->tos);
+	dscp_t dscp;
 
 	if (t->dscp & SCTP_DSCP_SET_MASK)
-		tos = t->dscp & SCTP_DSCP_VAL_MASK;
+		dscp = inet_dsfield_to_dscp(t->dscp);
+	else
+		dscp = inet_sk_dscp(inet_sk(sk));
+
 	memset(&_fl, 0x0, sizeof(_fl));
 	fl4->daddr  = daddr->v4.sin_addr.s_addr;
 	fl4->fl4_dport = daddr->v4.sin_port;
 	fl4->flowi4_proto = IPPROTO_SCTP;
 	if (asoc) {
-		fl4->flowi4_tos = tos & INET_DSCP_MASK;
+		fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
 		fl4->flowi4_scope = ip_sock_rt_scope(asoc->base.sk);
 		fl4->flowi4_oif = asoc->base.sk->sk_bound_dev_if;
 		fl4->fl4_sport = htons(asoc->base.bind_addr.port);
-- 
2.39.2


