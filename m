Return-Path: <netdev+bounces-123810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38CC966972
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7891228690C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD0B1BA292;
	Fri, 30 Aug 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="MrvCoaR1"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7113B297;
	Fri, 30 Aug 2024 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045600; cv=none; b=LRKF35uTPnzaBR0BS30madSF7QhYRiPR2Nh4wIgH9EhGRh2TDURR7B2c3LIft4+nMfsjkJ7Me2tjodw9NhUSDpYfPcniPXQfbnaiumaKUP52m6FR047ytDc0ZPhtm/PDu7RC2on3N0k8xh/mRJuxSqIfuYEB5axUyEJIhnswNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045600; c=relaxed/simple;
	bh=HX8kLOaPMTAtVknT9zY5Gl5BOvmcEacxGGF1dNteoAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RB248c5/ZYDn/1K1Zp6lYfHIvt360Tnl2Tj3wnPrbx6+J3qTXopEcOHsYaSmcmRgiMjIinRF7/WGNPOWbbaDCCDdYzgE0jqtdADTNDuewQW23zzcRsmBz8f1LvTvAIpLk/CVvv0BQ+f8l2i8zjHtkln5uUrkNiVGgxjlWtoF9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=MrvCoaR1; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 8E276200BE66;
	Fri, 30 Aug 2024 21:19:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 8E276200BE66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1725045589;
	bh=PYIyj+X/7aEiwjF1cs2nn0vYoBjyj76GNh+zXYydPpY=;
	h=From:To:Cc:Subject:Date:From;
	b=MrvCoaR13bzrgTimFFJ5RwGSA/aM6mROeGi4rHh6243Vz3Rl4QSEnIIAtr7xxXwZV
	 J62vyJwhpUbVAp7k70HUzTGloppipz3ytML52ZFHWrrI00idQi1kJjfrgoOyaAH7f9
	 K0hefm2hz8+Cc1ix/PnO5KY2X/pQ7n+0r5vkCh/+Yyu1deCVI2YyMTwtqWcJzj6gKT
	 usDDzhnrCZ7+GsTQeZeZfEi25qigtbUzsdRFzkbyszG5ymzOJyeVzb4Z0nMpQHkuTm
	 WvWffZnxKTrPTaEUzAbxtgbE5IDCCbbdfsGyTKaIztx/FPrq99GHhH28LG01wKpL6H
	 RXVAt5R27xxeQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next] ioam6: improve checks on user data 
Date: Fri, 30 Aug 2024 21:19:19 +0200
Message-Id: <20240830191919.51439-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch improves two checks on user data.

The first one prevents bit 23 from being set, as specified by RFC 9197
(Sec 4.4.1):

  Bit 23    Reserved; MUST be set to zero upon transmission and be
            ignored upon receipt.  This bit is reserved to allow for
            future extensions of the IOAM Trace-Type bit field.

The second one checks that the tunnel destination address !=
IPV6_ADDR_ANY, just like we already do for the tunnel source address.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ioam6_iptunnel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index e34e1ff24546..beb6b4cfc551 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -89,7 +89,7 @@ static bool ioam6_validate_trace_hdr(struct ioam6_trace_hdr *trace)
 	    trace->type.bit12 | trace->type.bit13 | trace->type.bit14 |
 	    trace->type.bit15 | trace->type.bit16 | trace->type.bit17 |
 	    trace->type.bit18 | trace->type.bit19 | trace->type.bit20 |
-	    trace->type.bit21)
+	    trace->type.bit21 | trace->type.bit23)
 		return false;
 
 	trace->nodelen = 0;
@@ -199,9 +199,17 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 		}
 	}
 
-	if (tb[IOAM6_IPTUNNEL_DST])
+	if (tb[IOAM6_IPTUNNEL_DST]) {
 		ilwt->tundst = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_DST]);
 
+		if (ipv6_addr_any(&ilwt->tundst)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IOAM6_IPTUNNEL_DST],
+					    "invalid tunnel dest address");
+			err = -EINVAL;
+			goto free_cache;
+		}
+	}
+
 	tuninfo = ioam6_lwt_info(lwt);
 	tuninfo->eh.hdrlen = ((sizeof(*tuninfo) + len_aligned) >> 3) - 1;
 	tuninfo->pad[0] = IPV6_TLV_PADN;
-- 
2.34.1


