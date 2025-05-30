Return-Path: <netdev+bounces-194335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F5AC8BF1
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 12:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FC2A22C1F
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516242222C2;
	Fri, 30 May 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ej34Hwtg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835021B9D6
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599987; cv=none; b=X1IdpLs78z6w00IeAd4aovUiW+PBlZnhmjjGZPcVUYBpbY7Rww+lZA3aXED1S49g3JfA4YHjnK1Jbk3+VeIpB2oLBG6J3o3PKSLevK2igkks6diAcwqIXbJSVbh+H2/MIo7o1f67uAWcTmtHtcu5roMX9lJI+borvvHRukKkIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599987; c=relaxed/simple;
	bh=hFydB9YOBYjZ3msdL2k+JHOGrLKKH4XADWk44gOGmbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgWhhSSOPcIaHxPHqs0gANrzXeNaQgnKGyWLe4qmq2T6iLjWDl+y2UYDAchKDBMt4gmZ2IEClsDiSPGoCi3nhtCGNJaThfE2w2jMn826vNYBoctuYxVM2kIoX+ygv4RBAJyjgQ8VyTrIyJcfiZc0+jZNSmVBSXaizEGxJLZkfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ej34Hwtg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso16524675e9.2
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748599983; x=1749204783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2AHcuc/Y1+LE8rNalUfSLxlkvoIG7YandvaKpqQbMo=;
        b=Ej34Hwtg7wUlGKQWNuhWpGghi10yHbRmXhOgctynpGQz4Z06rsARhaviVLT+adRNj5
         MsCeegJfQg7OT7LUfVvsSzL4rMLoOD89ZlXnWxNz/mCENh9U2BX7BfTV8zHDlytwFCqR
         aR1BkJm56jscIJxwtt9WMfqpiere3fAO73eNg1SvjKqs0qjKtoc0UP915QgA0A7eLiGh
         /6Te9tpmUGgcKjNFMP+O8sJ8F/3zGIcmP5UdD/0dLSBU7eP3bMLLfa/PTWaqIaYA4wlx
         84Z1oDAquhUIPL2mb9Er92Q5876JpFtxeCKXJb17Cmpkmsp+bSU+OHvh/NM4Fzm/4C+t
         UCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748599983; x=1749204783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2AHcuc/Y1+LE8rNalUfSLxlkvoIG7YandvaKpqQbMo=;
        b=tXgD0gY6thYMVX02A7Zd2B8ILMkS8nj/CxJHpsqATLXkknfM+s81hSDywhk28oTek0
         4MUC2pcCjIM1PXFl++VBo+4MuKCkABzE4AIQ6mOR58arTjCQ9vLLlFgenu3RHqSQtZzo
         oZ9g3LnZcJJ633uxQvIIbCsQ7UDGwq0WVlF+LaD0jYmvVjH9ix1hG76YgdxgnhZM/RQ5
         0ZMz9o7VeVq046/OWQpISXsg7D9OjQEcugkPFNJXbiF8VTH3E0PLeuOdk96qVh5n6WfN
         G7eZqVS2vPDO+8vR3IoqStGnObJkVmm1CidXfj1jn89nTdG/Qhj/bzHPDqruWMwYFws8
         t8Dg==
X-Gm-Message-State: AOJu0Yzn73m4x7ZVQKZKwsdfBUxeBvdQ7CD3h1kCaxYJZSt+nh1btNj9
	G3gFWZRYOTGNABsv/V813B9PZPSr61IRCbrBhsYfPj/sRV9tUnwPF5Jinc4AIxg5YsoVKRkJIh/
	csmPkBq48c+8AkJyUcJDrMNNA383g9nRTpNGd9fhIvuIYq+QL0GoqvqKY15YNOZbV
X-Gm-Gg: ASbGncsyX+bioGTgfRQyUBDpjLmqwnYAivCEmxJ1ikqMXD25ssMOIc2JYizlNTbaXul
	P73AB4aHlSolIHeja54PsnzgcszzNVFw6yK88Y66JFJ1vHRPgocDw988BbDXt2t0gVWQ7LAA/kR
	thJcRPmG0+a/LzicuMQaPK7MdduUvjwziHQZMecw4EklP3D4qgDaG6m2qWr6nwycI3UXmhNwxcM
	7YLu0A4G5oTi7DBL1pX2IKVtz5aDagNJnFms78YUA+1wldXBc5VuKdEwg0eHM7T3OyOvI7FSBLC
	zMQ2McRprz7DrMNybaX+qCJsCwEpFVgcOIBV++ZfceJtuw6SRt+RxV3XM4F52Lm+9iJ0R9d1Xg=
	=
X-Google-Smtp-Source: AGHT+IG+9IXShRr5yKhVjd1ILwDZqf+FfpCF81fW49OF0xFo/SJrGGZghEfL93rh4YlFZwlzia0/Cg==
X-Received: by 2002:a05:600c:45cc:b0:44d:a244:4983 with SMTP id 5b1f17b1804b1-450d87fd9bemr17642105e9.3.1748599982812;
        Fri, 30 May 2025 03:13:02 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:cdbd:204e:842c:3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b892sm4480956f8f.17.2025.05.30.03.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 03:13:02 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH net 1/5] ovpn: properly deconfigure UDP-tunnel
Date: Fri, 30 May 2025 12:12:50 +0200
Message-ID: <20250530101254.24044-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530101254.24044-1-antonio@openvpn.net>
References: <20250530101254.24044-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When deconfiguring a UDP-tunnel from a socket, we cannot
call setup_udp_tunnel_sock() with an empty config, because
this helper is expected to be invoked only during setup.

Get rid of the call to setup_udp_tunnel_sock() and just
revert what it did during socket initialization..

Note that the global udp_encap_needed_key and the GRO state
are left untouched: udp_destroy_socket() will eventually
take care of them.

Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index aef8c0406ec9..89bb50f94ddb 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -442,8 +442,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
  */
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
-	struct udp_tunnel_sock_cfg cfg = { };
+	struct sock *sk = ovpn_sock->sock->sk;
 
-	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
-			      &cfg);
+	/* Re-enable multicast loopback */
+	inet_set_bit(MC_LOOP, sk);
+	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
+	inet_dec_convert_csum(sk);
+
+	udp_sk(sk)->encap_type = 0;
+	udp_sk(sk)->encap_rcv = NULL;
+	udp_sk(sk)->encap_destroy = NULL;
+
+	rcu_assign_sk_user_data(sk, NULL);
 }
-- 
2.49.0


