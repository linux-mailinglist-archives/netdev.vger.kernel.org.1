Return-Path: <netdev+bounces-158166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE9BA10BEA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CE01881E6D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A61AA1DC;
	Tue, 14 Jan 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Th1PaURR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377641ACE12
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871143; cv=none; b=A+tT6QlY2TlcD5Jt5I/iOOzZiv/8PQdY+MiyU5HeLQU9bnnB+e7O+iSQmPh1TKUtqF6cHFZN9MrhakF2Rqf+azCBrjh6VHhTT52bghv7dVBh6XHsiCLcKPtQftLnBI/PPhiTirPSqcNQ/Y1Ky325ETvmH8Ohuvi34xI68GmcsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871143; c=relaxed/simple;
	bh=j0FDoSD8HO6TEBhTTlviQxAXmJiRe/O5zaE/xSH57TI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LWgHs5HPUMljxzHkrqedYn88/iwRQm2TE4yi9mPrWTINu29k6byY6iuPwc+Rn1exYYorciioNbOZm+qjd2HxcNaVbAltsX6TewUyBWKeyjX4BDgVdL2AWPMU8gT5OK8SwuruHIlEuJvHho3mtz/xIyWzSK3SaaoRINFAmfrHtnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Th1PaURR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736871139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8btiJW7dqUtyD2YSECzK0dDtA2i6mSiTTCgf6xt85PQ=;
	b=Th1PaURRpaEgYmPFnkAOCVaFue6yLOB9uBB9Cn2euNInpHXbwlJdIA+z3wY07sLJPFGteR
	5Alt6qKJ1uRrz/g/JPG4GKWzw7te2AmnNEtcyotVATG1lADrybfqq9KQZgrenJor1zagBx
	gc2CSigB3gzeEGBTaO7BLNFHsS+bnfM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-OzRWLlVBOJGq-NfrGZ7CDw-1; Tue, 14 Jan 2025 11:12:17 -0500
X-MC-Unique: OzRWLlVBOJGq-NfrGZ7CDw-1
X-Mimecast-MFC-AGG-ID: OzRWLlVBOJGq-NfrGZ7CDw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362552ce62so30232335e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871135; x=1737475935;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8btiJW7dqUtyD2YSECzK0dDtA2i6mSiTTCgf6xt85PQ=;
        b=ISdgG/Y81WHzilWe500aeMbW1WsvuUDwniRuzjCyMuE62trudTOnfPgBJlgDViBRHe
         w+5T+EkCqzD1Ju2nLFkyP5paRNqqFW7JJP8JufcfM9fF+XLdmBZsny416QJXv5985wId
         f3EJAZlBudJl4E4RINaNXeSDqeEUbQaZ6OVxRijTFcSCInLnL0qZoAmLFVUaj+uhfdwz
         5h0v70kWz5CGq3akKbT0pzeTCj0dhmgzIKjYTl0HOzb0/H42v0hBuowEnlz2c6aCf2Ck
         mFa7c5F4PdYLCqBfUj6dTVRlvXaUOvylc8oJgN5i3CORafDgeAZly4DhA/XRZhKgH39g
         T8pA==
X-Gm-Message-State: AOJu0YzWFHRD0lETcrZFS8zl5wxdnImWZbefdLV0Z9YsFQeYpscvlwbX
	bVugHRxwx4x9Nlsqm7ih0UI/D1Iv7s7vplT0rruV3Qd2QVhQJoDG0atdZ/GG3W3yj5JFXlspkyn
	1oJh1ZHFXuPEsckskSzvYXzO9tVs2l0vmqZOhmHKrSa/gD3AfXxnG8g==
X-Gm-Gg: ASbGncuefaIZ11Uu43A6YVdstFJgPWY55sRhLNXjcKnucSsNyDXEVRYQsPt5QV1z93y
	pvwlO3LDX7p9hLgnDS3MsJ8K+SafL6uzixEMykpyeUx9YVoMGGOo6dYuU3U52+moE85dWIXdPoH
	FBSAD5/VWaMAgxWWqKGkR+ACv3n2r5nzDMn8v4Ee1yMs6y/wv0ywq/F2xJ7lV2+Xp0SWOscfUn2
	KuByG/y3dEfNXeMSdOQbOfbkOxriI4QPQdKEswcfHTf5+GfmCVn+5vbfdYPBdvqvnW13Dox6KD+
	nmvFGIbiBm+OfxOttYxNCk2rr8AKo9hqWXU=
X-Received: by 2002:a05:600c:3ca2:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-436e26e5159mr201807655e9.25.1736871134781;
        Tue, 14 Jan 2025 08:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8vgZLrLq/RIce+Qd4DKIYTgVlfrT4M5xHfXhSzNWPnuLbJHLUdj8sxyqyQEvWyFmxwX3KRg==
X-Received: by 2002:a05:600c:3ca2:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-436e26e5159mr201807305e9.25.1736871134418;
        Tue, 14 Jan 2025 08:12:14 -0800 (PST)
Received: from debian (2a01cb058d23d60010f10d4cace4e3dd.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:10f1:d4c:ace4:e3dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fd03sm185866225e9.6.2025.01.14.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:12:13 -0800 (PST)
Date: Tue, 14 Jan 2025 17:12:12 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	osmocom-net-gprs@lists.osmocom.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] gtp: Prepare ip4_route_output_gtp() to .flowi4_tos
 conversion.
Message-ID: <bcb279c6946a5f584bc9adbe90b05f6b1997fde0.1736871011.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use inet_sk_dscp() to get the socket DSCP value as dscp_t, instead of
ip_sock_rt_tos() which returns a __u8. This will ease the conversion
of fl4->flowi4_tos to dscp_t, as it will just require to drop the
inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/gtp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 89a996ad8cd0..03d886014f5a 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -23,6 +23,8 @@
 
 #include <net/net_namespace.h>
 #include <net/protocol.h>
+#include <net/inet_dscp.h>
+#include <net/inet_sock.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/udp.h>
@@ -350,7 +352,7 @@ static struct rtable *ip4_route_output_gtp(struct flowi4 *fl4,
 	fl4->flowi4_oif		= sk->sk_bound_dev_if;
 	fl4->daddr		= daddr;
 	fl4->saddr		= saddr;
-	fl4->flowi4_tos		= ip_sock_rt_tos(sk);
+	fl4->flowi4_tos		= inet_dscp_to_dsfield(inet_sk_dscp(inet_sk((sk))));
 	fl4->flowi4_scope	= ip_sock_rt_scope(sk);
 	fl4->flowi4_proto	= sk->sk_protocol;
 
-- 
2.39.2


