Return-Path: <netdev+bounces-158898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A50CAA13B02
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C854B1641C9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980422A4F8;
	Thu, 16 Jan 2025 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDSJCIV3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A071DE4E7
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034786; cv=none; b=VfwI9I3eCOnPIB5LfXj1tWkf2CLCXR1864oX2cQPqY/biQ2sR0SeEkhgJsRn3oeyJ4PtYw7mHRbz3Bk/6a1jBYtNOK6vP9RNRSBiaXPZB7rHvW8aK2hw/t5fkySzjXU2LZeRBvISaPZcymR5gkq93E8s9hNSol0Sr81B2geH5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034786; c=relaxed/simple;
	bh=x50rIRdV4oosAvzjIe9wNv//BsgsrUohkclKjRst8zg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ccCWfVTmtVFAVLvonnrNBfEc5bQoQOi8ezEi73QSWguP9C9jnHxTmW7W08i9Y47TTzJ3W0XExgj3xCFdas9K4iJMIqZOvHk3CzOOnBKaSbw7GYKgfy/tiXx9lofVuQU6B7G807CcrfkJU+0HLSXVx5RbzEe06AQgn9eDEEI2S1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDSJCIV3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737034783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TfExgzHjb5NGuBofVPfjRYOrITWrQg+ThLKOpDbGlSc=;
	b=UDSJCIV36WYd/P4rAinLjHSKJ9QSR16TvvUjxBmzmDpiJSd1hyaHRBkrZHfMIdSX/5zeW6
	hYCB+b3xWYPfDSytK0ldd7+qYYAERliS6PXz7YeEgWb8EQHMQBU31PMK1pu6fIMnxRti5y
	XZGk9Pyn3Pj+LRpFXqhiyJOQLuEJxVI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-NOzSKL8gMESpG4Rse2n0hQ-1; Thu, 16 Jan 2025 08:39:42 -0500
X-MC-Unique: NOzSKL8gMESpG4Rse2n0hQ-1
X-Mimecast-MFC-AGG-ID: NOzSKL8gMESpG4Rse2n0hQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so4443785e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737034781; x=1737639581;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfExgzHjb5NGuBofVPfjRYOrITWrQg+ThLKOpDbGlSc=;
        b=k7/6MbAs4jK75VYDsHSo2b33bMDwhNRsGZExz3wsql7LhnOWG+CshNR75d5MsWGg8w
         THC9guIKNRAfYK6PKVtAtHmvchXXpTt7/GJfyotUAcdZ2mqQpEbSO7LvYXpTigDkDU7l
         WMdMdwqZFFHMNYlKFMo3dIJ3FzZi0H9ixRg+qOQgZ0imnY6dfQzjUh524L12ShYAEHER
         n2tiMHjpj1NJ6b/wLY7/709e5/UBDM2si6wcKIwaiEWC0yBf+UWcb4vuX6hKjpeg+bfK
         69k7jD6e1W+2r8xOMTYWwsTz6IW4TeazMgtWgGv1B/qYIYGDj8sm0LqeANBdqp2V4dAB
         DafA==
X-Gm-Message-State: AOJu0Yx5ILe8WWGclViJQAqVkpm3vgJKXXz1z5XHOWcCsDYc6GcIuXE8
	pFBIRAC919CB40cBO/Vb0dUnd0LVS4DmIhkj6zkhndAgH3UGs2iJcKcWHg/ex2MQYsweJnwUNG4
	bYskF+SF1Lje1eYT1Ic3gpE/H76bHISnHa9Ur4hzU/3K2cxwaOy5bXg==
X-Gm-Gg: ASbGncssw4341LuT3spYjluKja0sBnzC5atwGUb1zzdhId7E1eQarIAkcNoynu1AkoK
	8FeA1q/JDLSrOdg+b79ynFg5wTvXPBoXplP9pOZFGqjpH0VrKLT/NRQXDUdBmeHISUV1bYpfEmU
	ONtxt27bURHbnlH1PISt4MziPFPeAaVVEDw+CGhktBG+H8JXN/edK0tqxULhzL3LsLTpBFUAxNf
	V2GK8Gq3ucaHEIRi+YQIUlAvH4kwNY6B6lf+z0fod8EOFgQ6JpmjP7ruuh+amNhB1AYxA+bl8pV
	noy9qFiOCYPpaC+pFLmpIb5zLlitan8HH1QQ
X-Received: by 2002:a05:600c:a44:b0:434:feb1:adcf with SMTP id 5b1f17b1804b1-436e26efe1fmr258131525e9.25.1737034780841;
        Thu, 16 Jan 2025 05:39:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMnHCdnVAWHnK9N0SxHtmoNf8DwawtNR7Le2GZyDEKzkO+gxxWOaU/la35B5I5AH7slFaNTA==
X-Received: by 2002:a05:600c:a44:b0:434:feb1:adcf with SMTP id 5b1f17b1804b1-436e26efe1fmr258131365e9.25.1737034780497;
        Thu, 16 Jan 2025 05:39:40 -0800 (PST)
Received: from debian (2a01cb058d23d60074daf58b34fd2b3c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:74da:f58b:34fd:2b3c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74e63fasm58906845e9.36.2025.01.16.05.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:39:39 -0800 (PST)
Date: Thu, 16 Jan 2025 14:39:38 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	osmocom-net-gprs@lists.osmocom.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2] gtp: Prepare ip4_route_output_gtp() to
 .flowi4_tos conversion.
Message-ID: <06bdb310a075355ff059cd32da2efc29a63981c9.1737034675.git.gnault@redhat.com>
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
of fl4->flowi4_tos to dscp_t, which now just becomes a matter of
dropping the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2: Remove useless parenthesis (Ido).
    Slightly reword the commit message for clarity.

 drivers/net/gtp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 89a996ad8cd0..6fd502cc52c1 100644
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
+	fl4->flowi4_tos		= inet_dscp_to_dsfield(inet_sk_dscp(inet_sk(sk)));
 	fl4->flowi4_scope	= ip_sock_rt_scope(sk);
 	fl4->flowi4_proto	= sk->sk_protocol;
 
-- 
2.39.2


