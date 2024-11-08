Return-Path: <netdev+bounces-143246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239A69C1915
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 10:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC0D1C20FDE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB3F1E0DE0;
	Fri,  8 Nov 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZO3kBnl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72931DED55
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057963; cv=none; b=SruBy+/LKyHhSQH2L4svr/1lrobK3F02+dNZExBMX7KWTYhbiEyO3oZv6Ebyo2VLKRYJkdWj0DfFO7WiL/Gftu+U/+B3qhI+kyru6Kr2riwvC3EG+wo/HYbUS4EpJEDE0BrGrMriw1XmVpkMvmUb+UvbbQnkV8qdO0R2d8E9ZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057963; c=relaxed/simple;
	bh=CccXhL1gd50HKDvgPCy4TxonBwyTNKIlj/edBPZP59o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g68NcccQvarpiSLbUtX4QsKe4cCJtQf+PlBU9UT6PomlMCcet6VbPXA0FwJMH10+Kh21p8Yej0LKmNxM4Xr9rE8aCseusrAIo7pCbp2OqUosHKLWDeU1aBjAW2l82WcainV4Qkj1qh6RD9JWm8mv9dfA5uY9zsmHI/PBOtohp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZO3kBnl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso16224585e9.0
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 01:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731057960; x=1731662760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKxyjiJlmscE43+MXz3nq0JDfIlCoJuia7mfYA7HdxQ=;
        b=RZO3kBnlnGBJO6rTT+03GePVH7EljUtN24SnGYDNs7ofpxgGQMUmCpqwOaol6hFdDH
         +euFxkzLo7SCtMNXorHGEkSnVbWvj2neg/cHfXzd2livnpAlQPXBrOF2wL6ogVARA545
         mbgqsO4mdzjaA/OV8MJLcOZiWp3stEBwQRp6W+8fqP6abFBOy98CRcL104Rl7b0kG9Xw
         yIyy2QfdZTAhiV/bk7FP8jCgI9npOBj86HPaJmwsbZKndKsgbaDDBo9d6/kqnP98ldD/
         Jz6//S6ux7M/GeHrzHIaHXdMAiOgi5HDO8CBdK/Ym8eGO6je3OMqrbycjdREi3LKI4kq
         DkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731057960; x=1731662760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKxyjiJlmscE43+MXz3nq0JDfIlCoJuia7mfYA7HdxQ=;
        b=XvBOaeJ7pxxtp25dp5O7Kzcak+nIDuJ0ZpK+aOh0euWdIo9FHLtIheMBRoFL+/P4El
         7StdWXH0GeiDunmCvWOme77PnvgOIWIPTs2k3O2d73jPsBQcZ2+BLOJYduEac1VpCGRl
         WsR1p2UgAQpmXvCHEqjW+yYPAZmO7SaEDeehT1lYQR9f1NtOA68gCiEpAJ3N4Q3TYv+4
         3l9tNMo5LZWHeOpztX8l15zMkZhRdwIEXHRnXOg3dOO2u20VqglF3lGBk85z1y2TRx5o
         jo6zVoM/ge7Jak9iiZoQVeoJ3/LJ/aanLPkjeCttz9IPqOOPr9htEhVCBJVmQO/vF1Jf
         Af6Q==
X-Gm-Message-State: AOJu0YzRrbDDpY5UnF+cIARi3nTRYu64BdPEsg/X/o1jnxvCZ8Si9GbL
	vBe2fIkoyL7+wRodiRfjdNoRLo+j/beCX312bD7orgrU+prUUj6ZNgHMO9VrFiM=
X-Google-Smtp-Source: AGHT+IHHaRP/eh7X9cZAsQxdS5q1JFCa1qp6mKuklKed/RyKzqolXVoFELgMdgwi7SMD4gWjDVRS+Q==
X-Received: by 2002:a05:600c:1c88:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-432b74fa92amr16439815e9.3.1731057959607;
        Fri, 08 Nov 2024 01:25:59 -0800 (PST)
Received: from localhost.localdomain (mob-109-118-169-237.net.vodafone.it. [109.118.169.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b04753d5sm58470765e9.0.2024.11.08.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:25:59 -0800 (PST)
From: Emanuele Santini <emanuele.santini.88@gmail.com>
To: netdev@vger.kernel.org,
	yoshfuji@linux-ipv6.org,
	friedrich@oslage.de,
	kuba@kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	dsahern@kernel.org,
	Emanuele Santini <emanuele.santini.88@gmail.com>
Subject: [PATCH] net: ipv6: fix the address length for net_device on a GRE tunnel
Date: Fri,  8 Nov 2024 10:25:55 +0100
Message-ID: <20241108092555.5714-1-emanuele.santini.88@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'addr_len' field in 'net_device' should represent the size of the
hardware address for the device. While GRE tunneling does not require
a hardware address, a random Ethernet address is still assigned to
the 'net_device'. Therefore, the correct 'addr_len' value should be
the size of an Ethernet address (6 bytes), not the size of an IPv6
address.

This fix sets 'addr_len' to the appropriate value, ensuring
consistency in the net_device setup for IPv6 GRE tunnels.

Bug: Setting addr_len to the size of an IPv6 network address (16 bytes)
can cause a packet socket with SOCK_DGRAM to fail on 'sendto' calls.
This happens due to a check in 'packet_snd' for SOCK_DGRAM types,
which validates the address length.

This bug was introduced in kernel version 4.20.0 and is still present in the current version.

Steps to reproduce:

  ip -6 tunnel add <dev_name> mode ip6gre remote <remote_addr> local <local_addr> ttl 255
  ip link set dev <dev_name> up
  busybox udhcpc -i <dev_name> -n -f
  -> It returns Invalid Argument.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202147
Reported-by: Friedrich Oslage <friedrich@oslage.de>
Signed-off-by: Emanuele Santini <emanuele.santini.88@gmail.com>
---
 net/ipv6/ip6_gre.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 235808cfec70..db7679b04a02 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1455,7 +1455,7 @@ static void ip6gre_tunnel_setup(struct net_device *dev)
 	dev->type = ARPHRD_IP6GRE;
 
 	dev->flags |= IFF_NOARP;
-	dev->addr_len = sizeof(struct in6_addr);
+	dev->addr_len = ETH_ALEN;
 	netif_keep_dst(dev);
 	/* This perm addr will be used as interface identifier by IPv6 */
 	dev->addr_assign_type = NET_ADDR_RANDOM;
-- 
2.46.0


