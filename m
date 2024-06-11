Return-Path: <netdev+bounces-102766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB59047DF
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CCC284D0B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E41581FD;
	Tue, 11 Jun 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="jjXCc/WL"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83D157462;
	Tue, 11 Jun 2024 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150070; cv=none; b=QTqFvwShXxIeOAubQqHiGgLNfjp+9K1EQeI4BcHFwND1Sg802UHS6Jlk7BrCFgjrE9HSlNIOzB05feDNSGAhOHRHLj1hiSOR5o1nzd/vEdoO0i6soMJCUouO7yV9pGcfWecb+MkFN6JCHifNrbkN+3AG+eYXOCX600/wsBzVawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150070; c=relaxed/simple;
	bh=imPL47eGO9aBrxJvP1M11oZoTr+RAS2vWYBlCDgWnjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gx1cln2K1k9IXHIRIoHD/3EMY01c5CA/hXWGzxzcafHDNFE8mV7CgXLqLoKUQekEmxzG8xRegJimoV60bAhFrzPLA3N7eiunPEPMt6uiD5Ad921VHgOdNo7HXTLh2zhyWB5WjMQFxsUxud4jInAYaYnH83uvIny2JQU5aNMCFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=jjXCc/WL; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718150060;
	bh=imPL47eGO9aBrxJvP1M11oZoTr+RAS2vWYBlCDgWnjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjXCc/WLG+elWeHEXRqlM9m72b/JT4CjdV5amLLQhvEOLrpe4Vuw3kYHnGeoir+nh
	 RXTrIGbYueRxQ/O0G+GPvEF68tFT5aOyR0ULP25gsdg34HkWSUc+K29zqP/N207uQ4
	 +1nBVsh+A/YBMaudbCTYyppaAavB7v53Znc//WfHJ7+vR9cbDFp6dd8z/BLPjAWGhM
	 P52o08a6cTVXpX2wrscQf/1Eqd6CE4n4wHNFt/chvD/EWDZpWmv0cfXVksTnBKCLLq
	 BiZCItBkGwLraWCKJDK3XGSvqiYuwsGos5D5tQ+Z8X7BAQ9460/cjdM4zLqk9amnfg
	 PpNVLPA336G2A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7CB87600A5;
	Tue, 11 Jun 2024 23:54:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id A8D492032F8; Tue, 11 Jun 2024 23:54:00 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 9/9] flow_dissector: set encapsulation control flags for non-IP
Date: Tue, 11 Jun 2024 23:53:42 +0000
Message-ID: <20240611235355.177667-10-ast@fiberby.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611235355.177667-1-ast@fiberby.net>
References: <20240611235355.177667-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure to set encapsulated control flags also for non-IP
packets, such that it's possible to allow matching on e.g.
TUNNEL_OAM on a geneve packet carrying a non-IP packet.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 net/core/flow_dissector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 5fac97dbbd606..41311c8b0b2a4 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -434,6 +434,10 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 			ipv6->dst = key->u.ipv6.dst;
 		}
 		break;
+	default:
+		skb_flow_dissect_set_enc_control(0, ctrl_flags, flow_dissector,
+						 target_container);
+		break;
 	}
 
 	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_ENC_KEYID)) {
-- 
2.45.1


