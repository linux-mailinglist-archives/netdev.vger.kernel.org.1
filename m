Return-Path: <netdev+bounces-294230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cfJxBnHfHmquXAAAu9opvQ
	(envelope-from <netdev+bounces-294230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:49:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE0562EA81
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:49:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Uc9R733G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294230-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294230-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99D2D304B734
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1B3E8C70;
	Tue,  2 Jun 2026 13:36:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96873E717B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:36:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407377; cv=none; b=b9WD7engRCIv7VNUj3IirBz7UcUtS7+N5JyYG9gM2CuFKzy8u8+oB93fYuDlhdXen6D3XhlOb8uMwYAiT2LNtyHw+DL/MhmMMr5+eXBk6s/Afx4dkoZ30sxGmWPVbR0nB+iGeidcofyFVbd2/llisVm+sFAqIsLwdrQdWWz+ZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407377; c=relaxed/simple;
	bh=+FB2mNWD+mMTqn+F3bRCt0nRITKgPpAcXTfxbti41GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5dxqGXfnMJxlxIk2W+9A/hl5/EbOr8jetJ1ooAVdcE5plUVqBrymZPOys4h/ZCnV1ghgH6Xj9iIbCxQBfs8LBIDfHrbtPsFRpLsiYJRJk7v9V/JwKKECyuJt2y3Gv0sofSS1IFSvfPefZqBGOV+DysYmVPmUde3Dav0lAOZGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc9R733G; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-914ae4101b4so1440245485a.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407373; x=1781012173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRqKUEmLg14tZiwShSZMSTmsfzqKmm+Rz87fQO4vv/I=;
        b=Uc9R733G+cOXJQmf/GRCdjld2bKOp2SwYWqTcjlPb9gNGuZCZwJHrV/7ffi2hcLqvI
         GcLC3ucQDgxas4KV51XsJTuuOwAIzRCUoGthgU+nXIgXtxlj/ESHQS7vXw+rkR74Kvyi
         ThmZLztLToL9OG5mO7itBUBi/XKQuVO80fez9ozxBwgRVyEtOnE+zOixWIOTgSUXhB64
         ocYQn5tJWyg9BGO5zz0jEyFOhS5QtQEwrS5CechsRc/YdT7CHIUNCxhVFdFM6KR56FVM
         WHeuuja0Dfq9sfz13J2Z0Kh0TFNSFASDl+tak7Kfj+7ufrA4mAZXrNvt63fGlDs1vCPv
         J9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407373; x=1781012173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRqKUEmLg14tZiwShSZMSTmsfzqKmm+Rz87fQO4vv/I=;
        b=O1Jc3ewgchu2VAWMXCoCuKF/rgt0b+igbhZvmoajwrZ64O9zyjIiAQV8lBEbOla7dJ
         mBb5roau6zdHYaVegNYyFUdBlWOaRUEZYZm8ZsGmzTnzaLueN3xkT7OZBkO1darEenOZ
         +AYTZ//ImgxOtYIu/54eAn0whLvhDbqPRURCFlNtlrrnMaMnU/R2QQlR64eMmD/kNV5X
         3eDUMoNphvRCS3XwHJD18bOUnGAAo1jRYJAe1sKCppB+llE6weB0JmPH5dVjnXk0lZmh
         1U+GT9eyjxb0Z86xEjVAePULZeVgVVIVdo9euvDBBFn1F5shbGORtdVrlLoH3Q5aEjzK
         afTw==
X-Forwarded-Encrypted: i=1; AFNElJ+kIPkuxuWGQctSNwm5VR4PYFZkZxjwQgU3Z0APaLDxj05fOjE974D7tVkOJFZHVAallJ5vAd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJeyil4ordtk6hsjBAaJi0pu2/c9K//2WLComCiFj9Yo5jh8PA
	Qsv8MWivMD6va37LX2lqgP6Qs4qMgpvngZ/Hh8twClLKzL+ew4g/SCoyPLP/TLAw
X-Gm-Gg: Acq92OGlXmxRh4HxnOfOKPRZSrmdvjT9K9DDDgy9Or1lmwFiFcTuVmjWOwc/FdNRv/U
	/WoZXL+xqlRcIwYoofOpUDBYmPHZpo7Q+68JioATjYZZQi1tCv2CNsEQKGyIas4JUBeePd9DQ0t
	dXBLlsjcKbEc30VqbZI8HH3D+jNUlll5TR3EyV+NyB6aI2BBrNT+NMGCEgl2IUbjy3r+EL+BMaH
	lrUwU2NQFKc6rbT+ZY662PDD24D8TfsMPJY3l7euIewbliRMRqEKrsStu8CTUj1mFaTiGWgbLTz
	cLZZdVI0qPUdcBrY2IqZU8EzwNjSjwvcZty055nlBlvsG35e5xmMzcRaoTe3ImeiDJwNv6mvExe
	lJsVUIE/Lm1dYECd4Co/0ArQHv0Fa/n/zwzTPvbMkIcGi4Thm0ZZgAi+XspSidHBTuSzWMOrz4d
	9V/9MTXUftIakgVoNSCwRmy4hRAm17j9IZF8VILDl39iXCGi4li10E54Mtnm5HYBI0hKP5aKB8w
	Zm8ZsansGYPn1Nxo9lBsSnVAzxcG4s=
X-Received: by 2002:a05:620a:4015:b0:915:7b5e:a4c4 with SMTP id af79cd13be357-9157b5eb1fbmr401346585a.45.1780407373453;
        Tue, 02 Jun 2026 06:36:13 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915721f7d75sm346036285a.18.2026.06.02.06.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:36:12 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/4] tipc: prevent snt_unacked underflow on CONN_ACK
Date: Tue,  2 Jun 2026 09:35:54 -0400
Message-ID: <20260602133555.769727-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602133555.769727-1-michael.bommarito@gmail.com>
References: <20260602133555.769727-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294230-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CE0562EA81

tipc_sk_conn_proto_rcv() subtracts the peer-supplied connection ack
count from the unsigned 16-bit send counter snt_unacked without
checking that it does not exceed the number of messages actually
outstanding:

	tsk->snt_unacked -= msg_conn_ack(hdr);

msg_conn_ack() is read straight from a received CONN_MANAGER/CONN_ACK
message. If the ack count is larger than snt_unacked the subtraction
wraps to a near-maximum value, leaving tsk_conn_cong() permanently true
and starving the connection of further transmits.

Cap the ack to the outstanding count before subtracting. A peer (or,
for a local connection, the connected peer socket) can otherwise wedge
a TIPC connection's send side by sending an oversized connection ack.

Fixes: 10724cc7bb78 ("tipc: redesign connection-level flow control")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/tipc/socket.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f0..9c739a3cea126 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1362,9 +1362,16 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock *tsk, struct sk_buff *skb,
 			__skb_queue_tail(xmitq, skb);
 		return;
 	} else if (mtyp == CONN_ACK) {
+		u16 conn_ack = msg_conn_ack(hdr);
+
 		was_cong = tsk_conn_cong(tsk);
 		tipc_sk_push_backlog(tsk, msg_nagle_ack(hdr));
-		tsk->snt_unacked -= msg_conn_ack(hdr);
+		/* Cap a peer-supplied ack so a forged value cannot underflow
+		 * the unsigned counter and wedge connection flow control.
+		 */
+		if (conn_ack > tsk->snt_unacked)
+			conn_ack = tsk->snt_unacked;
+		tsk->snt_unacked -= conn_ack;
 		if (tsk->peer_caps & TIPC_BLOCK_FLOWCTL)
 			tsk->snd_win = msg_adv_win(hdr);
 		if (was_cong && !tsk_conn_cong(tsk))
-- 
2.53.0


