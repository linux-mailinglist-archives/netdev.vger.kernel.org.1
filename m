Return-Path: <netdev+bounces-208206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE1CB0A95D
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA634A437A3
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243992DC32D;
	Fri, 18 Jul 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsMm2K+V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1542E7170
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859546; cv=none; b=uQ3rI1E9X2tCIgaM9vEG80orHMbw14LDta6gzeshKaeyxl1Hu5Zpf/oPKEPCD7TrIiVIg9FInityw4jHMtSr+7PNXXI70yj9uJz1S/lMH2UPiLkeZHUW27bmyDxcZG5+YQM065DUSC6YeJT0GT7wPtnDx/VAgYL28tnMIEqPqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859546; c=relaxed/simple;
	bh=YX1bhxN+n9TvqqWdmyDvDLEF5Q1clD0vQCL43xziC10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUdkDMt3fMkRH4h3xP07XB7fk5MbflGAaV8UislXTMfZ7mnU9Ecxm5vVLx8tES3hMLyRVrmxvIpxCos0zsQeD7C+r3e0qnqnqh4eM0rtLKS69k1IozCe3tA6r/oe0yvwjpBK1qoixEzFd2hQhgwoW/AaPTcXwnPVemw2VbURmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsMm2K+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752859543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6z06SNgQkgg/pmS3wf9f6RZQ8DJRjUIKLlUuIYuBis=;
	b=hsMm2K+Vs47JzHKKxAPxQKuAz4cISaiQ1ZrrVDf8NtCzg7szTS/5NEO9oovF96kqixI4M4
	nIt/qjJTghGDSBFb4tWgMbZLgV7HvqvyyrbhJyvvcGjJyxMUi6se8oqsfXYIndJ4SvVLtm
	s9bInKHEi7zHb7O7xq9+RkkzjdCyZJs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-AMnMRhbSO8KIfYCeNy8fjg-1; Fri,
 18 Jul 2025 13:25:40 -0400
X-MC-Unique: AMnMRhbSO8KIfYCeNy8fjg-1
X-Mimecast-MFC-AGG-ID: AMnMRhbSO8KIfYCeNy8fjg_1752859538
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F25A19541A7;
	Fri, 18 Jul 2025 17:25:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9524718016F9;
	Fri, 18 Jul 2025 17:25:35 +0000 (UTC)
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
Subject: [PATCH net-next 2/2] tcp: do not increment BeyondWindow MIB for old seq
Date: Fri, 18 Jul 2025 19:25:13 +0200
Message-ID: <33f764b857dd28273784da12a3bac8dac039fbcb.1752859383.git.pabeni@redhat.com>
In-Reply-To: <cover.1752859383.git.pabeni@redhat.com>
References: <cover.1752859383.git.pabeni@redhat.com>
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
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/tcp_input.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c98de02a3c57..b708287df9b7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5911,7 +5911,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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


