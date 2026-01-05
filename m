Return-Path: <netdev+bounces-247003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 963BACF365E
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A19023003FE7
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA37333291B;
	Mon,  5 Jan 2026 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="PFcG9yP7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1E330D2A
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614473; cv=none; b=DTB05ee+lPIYoNweB0lJJcgfQXGo+kAOLydaIy8pum0fiwgXCK3BfMiG5Q6fP4zKLU4M6di+6t16w3vT4wU952dTTlt9ARrLsDWBLhiJImodWcb8pYUBO8btc+xtF2xXwLSyLaZa/IWxOQjD+1llI6kQowccR5tme4VH+QkfykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614473; c=relaxed/simple;
	bh=18raZhmpFTwODA8sz/4MhjDdY+LXW9FNpXfqu0ATNjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dwm0Yynd/WVBX65LUokQc7wmEDLNeVRCvyYrSI1bfyGU/t7NNtniHTB45vIR+F9MsPm7nN2/rxKUcnevOBSV/r68bjepbkByAtFsPTwFbInm+ld4MOmr8fte0Q1R5Ka2HHipMVgV3A5Myg3t4V96DB1gltyHOMoTHLgDhPqJh8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=fail smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=PFcG9yP7; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1767614159; x=1768218959; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=ovbISY9Hoz8IE0AR4zzdU++AVAbMMHC38b3c2Gj157k=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Transfer-Encoding;
   b=PFcG9yP7z9VoXEmIr2BqNkIJDeN4bHa0Jydvqgc9U8HL1ksQnG842hApeyJGmh8B+0yL3RZ+atosjVlQY0YS9YrVnAeFnEKQouVyI9+gWN2vdkqVYKPjmMPt+MF4cHtl9oDUuDZlP20jaEJ1VynrJaDCNXbLEni97iSFvHZ3LNY=
Received: from osgiliath ([188.75.189.151])
        by mail.sh.cz (14.2.0 build 9 ) with ASMTP (SSL) id 202601051255580699;
        Mon, 05 Jan 2026 12:55:58 +0100
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
Subject: [PATCH net-next v2] tcp: clarify tcp_congestion_ops functions comments
Date: Mon,  5 Jan 2026 12:55:33 +0100
Message-ID: <20260105115533.1151442-1-daniel.sedlak@cdn77.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A2D031F.695BA6CF.0006,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

The optional and required hints in the tcp_congestion_ops are information
for the user of this interface to signalize its importance when
implementing these functions.

However, cong_avoid comment incorrectly tells that it is required,
in reality congestion control must provide one of either cong_avoid or
cong_control.

In addition, min_tso_segs has not had any comment optional/required
hints. So mark it as optional since it is used only in BBR.

Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
---
changelog:
- Apply Neal's suggestion and add as Co-developed-by.
- Link: https://lore.kernel.org/netdev/20251218105819.63906-1-daniel.sedlak@cdn77.com/

 include/net/tcp.h | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0deb5e9dd911..ef0fee58fde8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1243,12 +1243,27 @@ struct rate_sample {
 struct tcp_congestion_ops {
 /* fast path fields are put first to fill one cache line */
 
+	/* A congestion control (CC) must provide one of either:
+	 *
+	 * (a) a cong_avoid function, if the CC wants to use the core TCP
+	 *     stack's default functionality to implement a "classic"
+	 *     (Reno/CUBIC-style) response to packet loss, RFC3168 ECN,
+	 *     idle periods, pacing rate computations, etc.
+	 *
+	 * (b) a cong_control function, if the CC wants custom behavior and
+	 *      complete control of all congestion control behaviors.
+	 */
+	/* (a) "classic" response: calculate new cwnd.
+	 */
+	void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
+	/* (b) "custom" response: call when packets are delivered to update
+	 * cwnd and pacing rate, after all the ca_state processing.
+	 */
+	void (*cong_control)(struct sock *sk, u32 ack, int flag, const struct rate_sample *rs);
+
 	/* return slow start threshold (required) */
 	u32 (*ssthresh)(struct sock *sk);
 
-	/* do new cwnd calculation (required) */
-	void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
-
 	/* call before changing ca_state (optional) */
 	void (*set_state)(struct sock *sk, u8 new_state);
 
@@ -1261,15 +1276,9 @@ struct tcp_congestion_ops {
 	/* hook for packet ack accounting (optional) */
 	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
 
-	/* override sysctl_tcp_min_tso_segs */
+	/* override sysctl_tcp_min_tso_segs (optional) */
 	u32 (*min_tso_segs)(struct sock *sk);
 
-	/* call when packets are delivered to update cwnd and pacing rate,
-	 * after all the ca_state processing. (optional)
-	 */
-	void (*cong_control)(struct sock *sk, u32 ack, int flag, const struct rate_sample *rs);
-
-
 	/* new value of cwnd after loss (required) */
 	u32  (*undo_cwnd)(struct sock *sk);
 	/* returns the multiplier used in tcp_sndbuf_expand (optional) */

base-commit: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
-- 
2.52.0


