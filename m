Return-Path: <netdev+bounces-63753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF44D82F311
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 18:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F281C22E5C
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6DA1CAA2;
	Tue, 16 Jan 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kk91H8eU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6E1CA9B
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425547; cv=none; b=SQwDDltpkLpFm2hffJWo0Apaqa0L4Sx35wQQf4nFUTKLZPf4u1QWAgeAOual58OoYxcdHNf5EJZ0Ff54G7F1PskgF8psa2KXQPBLw3Ek+MU2U/RquNDkzwYIMG2xnGWcsSJPKbilhLGDqmQlLWCAINmesoVk5z6X8Q6p7+Ydcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425547; c=relaxed/simple;
	bh=BiSCUcMJfuEioaTnWymmwb+V9TxpwByFPiHXBV/mnNU=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By; b=CSSm5M+29qj4jOzTphTG8uilykoS8wFVqVVIXw/DmNOsL84hOwdbSAu9gGnfivqjPYDP+WLSPqK/D3zKEODDfVXIDbQv439XJLn4wHOxLEK/64NrS60xJRsDjL8x8XsFr/QGxyygwNEzfI6A9lzsIymCIO2C9VJkEOvHSjeJzx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kk91H8eU; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705425545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tqc9KFJGCabJrCjzQGEgP9tsgsIlTOFX0DEXJO/UWVQ=;
	b=Kk91H8eUiSVZn6j8SSN8F0iCM3xaKd/fJWLlShY/AU5GYpYePJOkBNk2uLdB4wcCvp3kVo
	ffBzXcOHKKPUWPEEuh1jEpfOgy3Ij69/g5aW3wNaNup/gnR679GXhTrajSX242BVUHMxQt
	FKdP8/HOEapbm5IP/aUX0h9Cmx9FTlc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-w-a20HyANaWegbc40y_ZEg-1; Tue, 16 Jan 2024 12:19:02 -0500
X-MC-Unique: w-a20HyANaWegbc40y_ZEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 742E61064CC6;
	Tue, 16 Jan 2024 17:19:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA8072166B32;
	Tue, 16 Jan 2024 17:18:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang.tang@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev
Subject: [PATCH net] mptcp: relax check on MPC passive fallback
Date: Tue, 16 Jan 2024 18:18:47 +0100
Message-ID: <ddfc9eec6981880271d0293d05369b3385fb9e86.1705425136.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

While testing the blamed commit below, I was able to miss (!)
packetdrill failures in the fastopen test-cases.

On passive fastopen the child socket is created by incoming TCP MPC syn,
allow for both MPC_SYN and MPC_ACK header.

Fixes: 724b00c12957 ("mptcp: refine opt_mp_capable determination")
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1117d1e84274..0dcb721c89d1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -783,7 +783,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * options.
 		 */
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK))
+		if (!(mp_opt.suboptions &
+		      (OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_ACK)))
 			fallback = true;
 
 	} else if (subflow_req->mp_join) {
-- 
2.43.0


