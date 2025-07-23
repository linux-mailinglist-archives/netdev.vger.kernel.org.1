Return-Path: <netdev+bounces-209243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F354FB0EC94
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58037A5DB4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF77278E6A;
	Wed, 23 Jul 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="utxWyyI+"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B5278E77
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257649; cv=none; b=pNi+c4lbbU9qHBqwUYwM/tzbaqO3P5IHNXuVelCO/leU5tFqYK0fQZpaR34PlHsZKSOAciaip5dEGg4Y2lLBmmDZSzDLJ4zNtRArprpHb1fAOwKqiASypeqCDv70ZUheSALybkgKef2VrHU/euj40tgKc1L7vxWWLF2bAdmSD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257649; c=relaxed/simple;
	bh=F3488IQ/fwpy9HXQDVmCiNG4qr9O/6e5Y0gnQabtRCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeaKm0EwQVxMzFp4Gh8O1w50kdD6BYJ7nXSb87z5F0b8WKrP4yk1pG8WofXBBkLv/HmBHwmStHc/7IIvxvkRQTOn+e7rutbHmqG4eW53P15HvyN60suACIMk5wvXJwvQIy0bE7De7SIqCxTTcMH+p/FZWkNmFVDT/dHP9Dwt1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=utxWyyI+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 64C5C20890;
	Wed, 23 Jul 2025 09:54:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgvuQKmGYJNC; Wed, 23 Jul 2025 09:54:21 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C63F620894;
	Wed, 23 Jul 2025 09:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C63F620894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257260;
	bh=noqAyrelYHbHRpuQqm0DIQnh6swECxjlZalQ3ihD5HQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=utxWyyI+Be4FaTOduBp09AK8bKNmY2fpLft7p1eSrCfh+EA/ZumjR39FLJwNnM7Kb
	 0r96CjGha5VQlLP44vW5zdt1tYY7kkxseIjJyd+GlxTHn4rjFxSB7Q4pxJL+0eb0ke
	 h43ibUIF0sIcFWcQKROFmWI4ejTaDGdbhTgpxHu9W02o5HCvHtzegt1mdBiTbnXkxG
	 gQ+9HQkPZuoc+2bryTX4uj27hyuQeKLvanCN8fxdn+JCocENB7tmVCAK0Nk/+eaI20
	 10vWh+k17TBYV5KNstbh4a+0C2SOIdcQK8lzc6+sft5CUtaS3vCe8Xmez4S5OsIw9X
	 CN4pEvZSucIvg==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 09:54:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A1F4A3184182; Wed, 23 Jul 2025 09:54:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/8] xfrm: Set transport header to fix UDP GRO handling
Date: Wed, 23 Jul 2025 09:53:56 +0200
Message-ID: <20250723075417.3432644-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723075417.3432644-1-steffen.klassert@secunet.com>
References: <20250723075417.3432644-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Tobias Brunner <tobias@strongswan.org>

The referenced commit replaced a call to __xfrm4|6_udp_encap_rcv() with
a custom check for non-ESP markers.  But what the called function also
did was setting the transport header to the ESP header.  The function
that follows, esp4|6_gro_receive(), relies on that being set when it calls
xfrm_parse_spi().  We have to set the full offset as the skb's head was
not moved yet so adding just the UDP header length won't work.

Fixes: e3fd05777685 ("xfrm: Fix UDP GRO handling for some corner cases")
Signed-off-by: Tobias Brunner <tobias@strongswan.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/xfrm4_input.c | 3 +++
 net/ipv6/xfrm6_input.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index 0d31a8c108d4..f28cfd88eaf5 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -202,6 +202,9 @@ struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	if (len <= sizeof(struct ip_esp_hdr) || udpdata32[0] == 0)
 		goto out;
 
+	/* set the transport header to ESP */
+	skb_set_transport_header(skb, offset);
+
 	NAPI_GRO_CB(skb)->proto = IPPROTO_UDP;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 841c81abaaf4..9005fc156a20 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -202,6 +202,9 @@ struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	if (len <= sizeof(struct ip_esp_hdr) || udpdata32[0] == 0)
 		goto out;
 
+	/* set the transport header to ESP */
+	skb_set_transport_header(skb, offset);
+
 	NAPI_GRO_CB(skb)->proto = IPPROTO_UDP;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
-- 
2.43.0


