Return-Path: <netdev+bounces-171939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BE6A4F889
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE103A0418
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083A1632E4;
	Wed,  5 Mar 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="p37Fk9NS"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39B1C7007
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162640; cv=none; b=qaTJgDXEtfzBGtKX+6u0gtAc1PLU+lL3y/scx9bD2BssXtIrRq4+iuicVs5APDJjxBz5YpQRkL5/VdZJY6Qrr28K8VJyZZc/4k8IM3iHjQ6VkZHcquse6rDzsKFsq02tyWq77c15xKXySzPAVgTdJ5tQOlZfpnnww/JGUpA2g04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162640; c=relaxed/simple;
	bh=1lLJYy802//m4QaVMFxxQbAeFNcT1aHQiJe+jvJ2zcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uKc83LHgBUQsolM2l0kHfSP1i2lvLD6Udt0OCZ0Kxk4iO825Rc5V7dauQuRycgQ+3y1+n+bHOmhKmaZ2fTnrLSq9M2arEepnxspVKLhtid8iWL1FEiAJsuHmKpT99saLUWMBBOvCcg4AUZWrfnsMq23BoJ5YzVIOC9sB65wdW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=p37Fk9NS; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 7DC9E200EECF;
	Wed,  5 Mar 2025 09:17:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 7DC9E200EECF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741162634;
	bh=McXpfBnJiRHRZI+QB01lpxYfNCBWttpip8sCvpfgCfA=;
	h=From:To:Cc:Subject:Date:From;
	b=p37Fk9NSqkwbv7ZAxCjh2XNbqpkxCN+n4n7Q5tuY/dMQY75+g4Fq2HiigreQ8FoZW
	 lYZZPNFDhaEvMZMS8aqWv4vQgB7/Gxz45jPsgq/GhTm8bYmkhzXl4UiiKECWLvuGfY
	 YejXkSssTiiEP9st0EN32J9t9J8qwKT2ooks9JRZHxu2rciXrDKieeKZL31x9TJNMH
	 gQiaUJwX34nx6WSvGH6Ps1nnYIVoxQQmUptpa+MViiXJ2lgzPRWN4Fz4VqeIaDdnDb
	 p7Jkjv2M0N5BbR0Y5Ct3lmalg59A6wq+27eDggr6ZyScaqY0hcPO3vpSlxTtw/s0df
	 OmBxNotm5B0Hw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Tom Herbert <tom@herbertland.com>
Subject: [PATCH net] net: ipv6: fix missing dst ref drop in ila lwtunnel
Date: Wed,  5 Mar 2025 09:16:55 +0100
Message-Id: <20250305081655.19032-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing skb_dst_drop() to drop reference to the old dst before
adding the new dst to the skb.

Fixes: 79ff2fc31e0f ("ila: Cache a route to translated address")
Cc: Tom Herbert <tom@herbertland.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ila/ila_lwt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index ac4bcc623603..7d574f5132e2 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -96,6 +96,7 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		}
 	}
 
+	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 	return dst_output(net, sk, skb);
 
-- 
2.34.1


