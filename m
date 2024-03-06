Return-Path: <netdev+bounces-77854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF863873380
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D42F1C20CD0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C74A5F463;
	Wed,  6 Mar 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vvvNWYzW"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B55DF28
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719495; cv=none; b=lyO/idZHfmQZfF6bsAF0IJ2g0NyX96LtUDOC7SRqQxivtILF9KDXUj+p766PYLui54/xyhvdKQxjQgbpB/zkv7JRQyRa4RwD4ZwTDw+l3/hMLSk3gaI5rQD8RdmK9wq7PLWOtHgpuoh7atAYdk7Km2xMpdolkJrSuZ9EIC2HBRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719495; c=relaxed/simple;
	bh=QsJskSAwKu+28YAlY65+UaWVnI1acPgpmxxllkUe38Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvZlRaiVXj1ekK14J8SaV0UrZYOrL///aY0+doU3wMcta6I440WcsZtHGUrslR8fl7CvyD2fFcPxGoOc1UGC5H/MrRN0vkC78w1pzg5Qn3HMSZzs8bEGgHPrmk9pyJd+rf/FfCz5fisZ8Zxi3YSms5dQVUdC7FveNnLqU+NUacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vvvNWYzW; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 19C4B205CD;
	Wed,  6 Mar 2024 11:04:51 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qM70yqqO9Bif; Wed,  6 Mar 2024 11:04:50 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 951ED20748;
	Wed,  6 Mar 2024 11:04:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 951ED20748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709719484;
	bh=ZeJPSvUj92F2DTfPbJ7ejUWzQlMP7SamGYTyh4qFcZY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=vvvNWYzWB0vh3NyULg+HVxKRZtYmRRTjbZgTdgA03zGltE3OWvB6MluK1Y1rh7NPI
	 AQ1tsm/JKXmIjey0vEFLGyXtc2F3BlyEXm2xOCkDWfHPOMRA6aSvJasQjOjHlG6mxR
	 6K5oOhjuLQoV5DzDA78DZ6B0j5GnO8R4W3qCSQfqxEshEdNJkuRu8Y6a2E3uR+D+hy
	 LBGjAcLy2IblZMDsBMZWeIiXSUiuE0GaTn8fasBNJipOZZSfypu5NEE10D6TnCowjQ
	 W23C8PXvbKRzWBKTkrpaJAvwsDFoy/Z648RbfYbp0nQo8P2WENQdII+2SnJbOYigs/
	 8KbsQN7XdhkRA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 86EEB80004A;
	Wed,  6 Mar 2024 11:04:44 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:04:44 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:04:44 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D66E931829AE; Wed,  6 Mar 2024 11:04:43 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/5] xfrm: fix xfrm child route lookup for packet offload
Date: Wed, 6 Mar 2024 11:04:37 +0100
Message-ID: <20240306100438.3953516-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306100438.3953516-1-steffen.klassert@secunet.com>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Mike Yu <yumike@google.com>

In current code, xfrm_bundle_create() always uses the matched
SA's family type to look up a xfrm child route for the skb.
The route returned by xfrm_dst_lookup() will eventually be
used in xfrm_output_resume() (skb_dst(skb)->ops->local_out()).

If packet offload is used, the above behavior can lead to
calling ip_local_out() for an IPv6 packet or calling
ip6_local_out() for an IPv4 packet, which is likely to fail.

This change fixes the behavior by checking if the matched SA
has packet offload enabled. If not, keep the same behavior;
if yes, use the matched SP's family type for the lookup.

Test: verified IPv6-in-IPv4 packets on Android device with
      IPsec packet offload enabled
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7351f32052dc..da6ecc6b3e15 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2694,7 +2694,9 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 			if (xfrm[i]->props.smark.v || xfrm[i]->props.smark.m)
 				mark = xfrm_smark_get(fl->flowi_mark, xfrm[i]);
 
-			family = xfrm[i]->props.family;
+			if (xfrm[i]->xso.type != XFRM_DEV_OFFLOAD_PACKET)
+				family = xfrm[i]->props.family;
+
 			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
 			dst = xfrm_dst_lookup(xfrm[i], tos, oif,
 					      &saddr, &daddr, family, mark);
-- 
2.34.1


