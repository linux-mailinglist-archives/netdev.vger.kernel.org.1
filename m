Return-Path: <netdev+bounces-208659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8266DB0C991
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D698545696
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226C2E1722;
	Mon, 21 Jul 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9zfm5Za"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC822DEA81
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118458; cv=none; b=J/bIyigZGkthaZ28p5TELs+tg7ti3oWeqDOqblj3OWS3VLD3XfyRbV6Ya7EYG6whTzhvGWInew2uykD35XRMg9W+dfZymOC/EQbcXySXF9UD759HBy/Kak1sjDaaHjI+6zlZIkjTg7FVrh6xDm/SOJJ6HTX5iUVVNjRxEcnvRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118458; c=relaxed/simple;
	bh=hpKV5pZpkXXTNMMpc7k5DRK6DX50GKTpCo+xos1KHV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW+7OLxsU1Cqc/UKmBwKqtAehsYIYMF38w1Clm1Su05ZMHy2PaHKpVptuZygteFOyZ6+SdoOTr4QGyhGOSfKe136Bp6Hqam5qYGIvLWEKE1KA0ITVPkDc0yxQM4kivIPfAj1cYYKXubarIkY1PFveRmO3Fd3t9JDkrY58Wctits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9zfm5Za; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753118456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CE0Yt8He7WkiNjqJXbwaERvp/DogVbuoIY72dk2DAA8=;
	b=F9zfm5ZaFqZYj0HI08NiPomrWE1RdylHDBeWZoqyz37N0ICLU+0OYhAOak99aztZU8I+jG
	X0G3SBY/F9ffQV7hLustTzNft93ASFTeQ5QlBjfluyRgMBRIK4n7uuGMsnedqvOiSWhTEp
	ERbNWpLzwnnXDl1y6/gICTV8jxtLP2o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-BJFfbQVgPT6DYeol4paTag-1; Mon,
 21 Jul 2025 13:20:39 -0400
X-MC-Unique: BJFfbQVgPT6DYeol4paTag-1
X-Mimecast-MFC-AGG-ID: BJFfbQVgPT6DYeol4paTag_1753118438
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36169195FE1C;
	Mon, 21 Jul 2025 17:20:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61B881800D82;
	Mon, 21 Jul 2025 17:20:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH v2 net-next 2/2] tcp: do not increment BeyondWindow MIB for old seq
Date: Mon, 21 Jul 2025 19:20:22 +0200
Message-ID: <20d147292eb4b13b6535e0ad6f56be64d9c330d3.1753118029.git.pabeni@redhat.com>
In-Reply-To: <cover.1753118029.git.pabeni@redhat.com>
References: <cover.1753118029.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The mentioned MIB is currently incremented even when a packet
with an old sequence number (i.e. a zero window probe) is received,
which is IMHO misleading.

Explicitly restrict such MIB increment at the relevant events.

Fixes: 6c758062c64d ("tcp: add LINUX_MIB_BEYOND_WINDOW")
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/tcp_input.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 81b6d3770812..71b76e98371a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5915,7 +5915,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		if (!th->rst) {
 			if (th->syn)
 				goto syn_challenge;
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_BEYOND_WINDOW);
+
+			if (reason == SKB_DROP_REASON_TCP_INVALID_SEQUENCE ||
+			    reason == SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE)
+				NET_INC_STATS(sock_net(sk),
+					      LINUX_MIB_BEYOND_WINDOW);
 			if (!tcp_oow_rate_limited(sock_net(sk), skb,
 						  LINUX_MIB_TCPACKSKIPPEDSEQ,
 						  &tp->last_oow_ack_time))
-- 
2.50.0


