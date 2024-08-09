Return-Path: <netdev+bounces-117191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D594D070
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E04281993
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4730194A7C;
	Fri,  9 Aug 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="1MTmKRkT"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4714D6EB;
	Fri,  9 Aug 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207533; cv=none; b=hQKyDyQZcQ/6aCDHh3Af9ryTLec6FUM4e4WdSegQuLdhsHMb24FLsoq42XhH9vfH5yuJa2vnJX/P7UB0qmuV+faxbdSktWJ4HS4ORawhAw68aFUr3nuVNza28qjBRqgOpYBIGnnbhPOToSi2aHe7JNEC+LbPk92MGaR6HqC3cJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207533; c=relaxed/simple;
	bh=o2NT6oFvuHimCA1MXB1PONFPWt1vAiHI1OrvSxld04A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PI1pGjS/GlmfwSzRbhhYS3Utk1Hr7OO0pFi7BHWZDmJ9liJAioTswR5d7cAc3AsgrtessKPnrXfojS2726bwGHC0y/19yrvmo503yPpWU5P1w6UGF8mJHRY4rkm248TPing2i8nszrLyXJ5WQgpWBf4zWGrI+iKusxszx+x6ZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=1MTmKRkT; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id A7135200BE62;
	Fri,  9 Aug 2024 14:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be A7135200BE62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723207171;
	bh=Z1lkpR1VjYvZHx4abc0F/Su8WLFB+LbWxmC6RoB3T2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1MTmKRkTiMvO0yGpXWhmlSBcfMBTWr3IxIF9Nq/U0mSl/LduuitMpjSjS6MUqc67M
	 2KWl7Uz65raAJtityfctsTbWIoOhYLa3a4/V2dDsmfytpA4YP2HL4ZZy9DIac3Fwei
	 shdm5ZzKm3DLw9Cnd1nHD/9WGjEdwkqdOpSDDR2fTtrLj3OpRNMO92g2EZk7nvTTIk
	 gP88lnoEKSwuqyzuNcZ41nMjIPToP7AFBPLGq4PvImOFtDm+YFGjAZPO0fsHR9oM7R
	 KSgTy4u4lIWGIIgCEAMtp4k/YYd3oFYqfnO6rYf/VyK4xAJPOG1npwu12NpjJx7CTa
	 k/vicBf8Xqmdw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 1/2] net: ipv6: ioam6: code alignment
Date: Fri,  9 Aug 2024 14:39:14 +0200
Message-Id: <20240809123915.27812-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809123915.27812-1-justin.iurman@uliege.be>
References: <20240809123915.27812-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch prepares the next one by correcting the alignment of some
lines.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ioam6_iptunnel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index bf7120ecea1e..cd2522f04edf 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -43,7 +43,7 @@ struct ioam6_lwt {
 	atomic_t pkt_cnt;
 	u8 mode;
 	struct in6_addr tundst;
-	struct ioam6_lwt_encap	tuninfo;
+	struct ioam6_lwt_encap tuninfo;
 };
 
 static const struct netlink_range_validation freq_range = {
@@ -73,7 +73,8 @@ static const struct nla_policy ioam6_iptunnel_policy[IOAM6_IPTUNNEL_MAX + 1] = {
 						   IOAM6_IPTUNNEL_MODE_MIN,
 						   IOAM6_IPTUNNEL_MODE_MAX),
 	[IOAM6_IPTUNNEL_DST]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
-	[IOAM6_IPTUNNEL_TRACE]	= NLA_POLICY_EXACT_LEN(sizeof(struct ioam6_trace_hdr)),
+	[IOAM6_IPTUNNEL_TRACE]	= NLA_POLICY_EXACT_LEN(
+					sizeof(struct ioam6_trace_hdr)),
 };
 
 static bool ioam6_validate_trace_hdr(struct ioam6_trace_hdr *trace)
@@ -459,9 +460,9 @@ static int ioam6_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
 static const struct lwtunnel_encap_ops ioam6_iptun_ops = {
 	.build_state		= ioam6_build_state,
 	.destroy_state		= ioam6_destroy_state,
-	.output		= ioam6_output,
+	.output			= ioam6_output,
 	.fill_encap		= ioam6_fill_encap_info,
-	.get_encap_size	= ioam6_encap_nlsize,
+	.get_encap_size		= ioam6_encap_nlsize,
 	.cmp_encap		= ioam6_encap_cmp,
 	.owner			= THIS_MODULE,
 };
-- 
2.34.1


