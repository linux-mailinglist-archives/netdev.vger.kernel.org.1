Return-Path: <netdev+bounces-118026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B229504E4
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B301C22902
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9FD1993B4;
	Tue, 13 Aug 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="kBNvXl/v"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BF1991D8;
	Tue, 13 Aug 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552058; cv=none; b=Vddqn/emmufKVbRQD8H8tpK7SVsgn0XEif6VO4CghISsfX3210c59UVb5AtC4b32IUFFW18cHd7u+VJzp8/DbyK2EZF4uNQ3To8BTriWYmNisktTjXwncnZIuqeezqrVyj6SAFFjkOvsprt9vsvwS8qrRrW2WsxpMDzBx7s0chQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552058; c=relaxed/simple;
	bh=o2NT6oFvuHimCA1MXB1PONFPWt1vAiHI1OrvSxld04A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qiNxaJI81prhxp2h7kjtT04ZSGQuOzjBaJCLdVjLvKrjkfzM/92myoc46CFc3A73CiHN24oQryQdFIaRKUbbmAt3sgduM0mgCDVtLw0N7bTB+23nXiM7LS7TNATYkyCTat+NJxV3YAv7zbt3dluT019+SF+03rcp1wg0Ovwx7+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=kBNvXl/v; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 262F1200BBBA;
	Tue, 13 Aug 2024 14:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 262F1200BBBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723552054;
	bh=Z1lkpR1VjYvZHx4abc0F/Su8WLFB+LbWxmC6RoB3T2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBNvXl/vh+GISDRCL4k3yV/+uNxjCg8+rhkHKoFaKdvvPjHwMIiiEw9YBfuDYBD2e
	 69C6Cf4T1v6MZhG+XkvUZzTK0fSw1delhg7+mVZP27X1iuNEXwUHns0xQsrqWz24W6
	 lwDOh+pcypbmxSlwh1Gv2ZbvWR0HVPbalpSmfDBiHWgnhvIuJaqDNFHWu5VJqVisMt
	 OHkl0TfNxcSN8c6aWlpXgP+bCErt2bkBjC1c0tjAFUkSfswTPapwAUWl832or002O2
	 LrlCnkFQJPmHe+FVEBfGNmAJS9f8yximm3UHn85BEqRJo8lBg+YUcQWQ7TGnRXc6LC
	 eHenBseOWnv+Q==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 1/2] net: ipv6: ioam6: code alignment
Date: Tue, 13 Aug 2024 14:27:22 +0200
Message-Id: <20240813122723.22169-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813122723.22169-1-justin.iurman@uliege.be>
References: <20240813122723.22169-1-justin.iurman@uliege.be>
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


