Return-Path: <netdev+bounces-119411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603B6955805
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 15:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211E6282A1D
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D7514D70B;
	Sat, 17 Aug 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="ak0MZbvY"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791414A099;
	Sat, 17 Aug 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723900711; cv=none; b=r4riiwe2A90Whbn1nGNj/Y5UM9YYQf/z/i/ZJolEyb873n6SbrVsyOaf3/Vds3AVaHFnuYneyLy5LbwCw6MoE7aAe6psRgBJmdGgvDZ9sWVZ3NVIa3sCPKJ+vmyX2hhdHW9HtMbKXUNborZXQzVBuYji+2+1tcjuXzHficEyz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723900711; c=relaxed/simple;
	bh=o2NT6oFvuHimCA1MXB1PONFPWt1vAiHI1OrvSxld04A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZSBys0wrrmdr5WCTdfH0L9/Pppx5gbjb+Ptf/yhDgRZj6JJKrUqkc82qms9zE6QLxusSNx/3a8Hv2aklemv7AY8xk95nzL8zP20ckmMxwnZyL9FvTysxwDsmLYV+hJ3tXHPcLazDhbApAjuY1VhG2aRnpFE37TKxZKdJbp0XD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=ak0MZbvY; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id B69F2200BE45;
	Sat, 17 Aug 2024 15:18:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be B69F2200BE45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723900707;
	bh=Z1lkpR1VjYvZHx4abc0F/Su8WLFB+LbWxmC6RoB3T2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ak0MZbvYc1OIiQl5zhcs43VvsZnsY4TCxs3eKuPtuRWBP+Rsr45APk1BwNb2O3P6H
	 YJhXrYyg7OnKp/D+1sPtztNl6Inh+aslpXlyfgQWFLwfG6bHv9p9g1HJ/MVmIs3K2V
	 8lAfQhfXhWrvbZgYWFX2pbB7ps3wsrKI8y3dAwja8STTni3/u2nBxAt7tC3vQMgA6Y
	 qbmA82Ax5hlLbQSEHqROalaKcL6lG5ONeZ2joXHC6j0pU3IRR6HpQdG28uEZU2SJJ8
	 2uWLILg4BG4UNHPlGpdoRgcQF8Z6cU0gJQegLcvV2T/3QaCvSNxkQkGIDUY30ofD1E
	 SRQKny4FZEaew==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v3 1/2] net: ipv6: ioam6: code alignment
Date: Sat, 17 Aug 2024 15:18:17 +0200
Message-Id: <20240817131818.11834-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240817131818.11834-1-justin.iurman@uliege.be>
References: <20240817131818.11834-1-justin.iurman@uliege.be>
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


