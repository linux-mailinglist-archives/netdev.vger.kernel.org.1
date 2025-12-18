Return-Path: <netdev+bounces-245328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 033EBCCB856
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72FBA3038290
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5666313E02;
	Thu, 18 Dec 2025 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="gasxk3nz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C1313520
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055824; cv=none; b=L03eDDKkoYd9PuF8eUiwEDtyU32EpppgAgmR+n1p1roezE74Cc94C6bGvmce5+j+85/n+wXFy//LEMTpRAamOmkUGi668NmeZ673RXNUE7JgAALM6mDJdwNJjNZnx7vXproiij2szZS2+iddSa2H9IKXIg4/gesTx8yA+oPzaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055824; c=relaxed/simple;
	bh=m3qhbPPTet6emYPLk/FdmZqYfiHjxwq/5DJhLJ1ZJWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qd8d2JWM3Tsun1g/HtuYaIFMSAr9PJMAIhgwmDysWtpgxuhZbF1YMe5mzWZrWGUnwEd23nXMaar8XGdtEy3n/0yLuokPOz9OIqrfMeZ2wbSp1zDJT8YL+iGs+1KQdAB1nFOzO5Ac43Wla4hAHEmHn+C2Xd5yxtlaNsVEA6rPVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=gasxk3nz; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1766055512; x=1766660312; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=TcfYN/EioIQIK/V14iKotANxMJnLfju+hSW7Tpc4/o0=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Transfer-Encoding;
   b=gasxk3nzq75wT0X136vSNO9t7AeZYwbtryV73hSnTN0lgzv4tggoTXjyhPK8xLgcyDpNGEslgLaOK8CAuP7EiaTvn6xVEoPnjTU+W+4qZg8k95FPl0QzkX9pTOr2/SR+sAOO/svgWk53DSQhKDhNWbji8zzTxZH1UoyDrjGiV00=
Received: from osgiliath.superhosting.cz ([80.250.18.198])
        by mail.sh.cz (14.2.0 build 9 ) with ASMTP (SSL) id 202512181158318012;
        Thu, 18 Dec 2025 11:58:31 +0100
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>
Subject: [PATCH net-next] tcp: clarify tcp_congestion_ops functions comments
Date: Thu, 18 Dec 2025 11:58:19 +0100
Message-ID: <20251218105819.63906-1-daniel.sedlak@cdn77.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A2D031F.6943DE57.0034,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

The optional/required hints in the tcp_congestion_ops are information
for the user of this interface to signalize its importance when
implementing these functions.

However, cong_avoid comment incorrectly tells that it is required.
For example the BBR does not implement this function, thus mark it as
an optional.

In addition, min_tso_segs has not had any comment optional/required
hints. So mark it as optional since it is used only in BBR.

Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
---
 include/net/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0deb5e9dd911..a94722e4de8c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1246,7 +1246,7 @@ struct tcp_congestion_ops {
 	/* return slow start threshold (required) */
 	u32 (*ssthresh)(struct sock *sk);
 
-	/* do new cwnd calculation (required) */
+	/* do new cwnd calculation (optional) */
 	void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
 
 	/* call before changing ca_state (optional) */
@@ -1261,7 +1261,7 @@ struct tcp_congestion_ops {
 	/* hook for packet ack accounting (optional) */
 	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
 
-	/* override sysctl_tcp_min_tso_segs */
+	/* override sysctl_tcp_min_tso_segs (optional) */
 	u32 (*min_tso_segs)(struct sock *sk);
 
 	/* call when packets are delivered to update cwnd and pacing rate,

base-commit: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
-- 
2.52.0


