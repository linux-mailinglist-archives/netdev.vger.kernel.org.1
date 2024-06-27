Return-Path: <netdev+bounces-107104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7575E919D5F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 04:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1351C22D6C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114AFDDA0;
	Thu, 27 Jun 2024 02:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlOWAVZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061C134BD
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719456154; cv=none; b=mublCwg+zxuzC04BjeRoIia/C2t8N+9Su5yIKV1tskoQ36WW9TDDStkZQ6+rAwbkmJ0PWBbYyfcx6gX8iLoCaVFsMINy01dH4PIQani+kRUqm3iBqFFBu/S0/k0YbTmxElNXkaBJl+1ssPLvWlqknegRrdwcR73MCZU584SyIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719456154; c=relaxed/simple;
	bh=0iPB9ylvKR+xYlK41Wmd7I7C+NFOxbthcEdEhtSO6EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XC9428H6UYuYyCWws2cRWDtZSfkFB/lUGYiHjRx+/Wb3vgYqFTMKR2OKqn77HRaHcvud/wGms3DRyKFoKyPitNbNQpDHoGPoL4XZ12PLZBbxkJnqlqnw7fvvxk3n4tqmNxjjrzfWUnApv7JLfzCJatwqOCWII13HQbBE/k99gTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlOWAVZu; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ef66280cd7so1684191e0c.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 19:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719456151; x=1720060951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vz4RerORXXu6NVYpMOSjN+rSUnkoXoV9tlFqowdFmKc=;
        b=IlOWAVZu2DP/8zW+tl2QGDfKTAidLhsk4Y6HMN8sHQ/JZcdsu/8mSVZampHAGy4VEm
         OcNFaL691GEUFNv/FmyNAOia/l5ekAbqVH8g2zsORFT5c61Xd3DuObeld1Rv6vxfmeOZ
         vDpPfWU/Z4f5NMXlOHj4+l3ZPmq4HjjlZVycWuHRTqF9naPoDDEGAm/dIlB9LCPpP3tU
         zp3W7E6MrnK2WbK9r/1AQt0/U3SyxbszZk9FgBczWDd+1BCPliILFgTJLf7iRN8oqMye
         3CWsCMcmANOm/DDU5F4q/mSzSB1Z98UeciigO0g1gvj5Q8oGHv7WAWwVuS3nrpL1wikc
         LkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719456151; x=1720060951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vz4RerORXXu6NVYpMOSjN+rSUnkoXoV9tlFqowdFmKc=;
        b=hkuUy2zFmMEZGSPYsY3QmnmKeLF3TcZeEjDVZk23ypYvUhuEqDkf7IxoiEvZaHybnG
         V1AZlmoeEIbb+QayTDaaWHAZI0SKymrPVYAzFfXnxfUhHxK6ynd7HNbqz1tflDrblVGZ
         6fa9EF6aOqshuv59N1zRqmNFvBPPa+zRUhXeturYvzeICOUw96wIhBiiykJJUSFhP6SR
         MRymTb5yt+JenI0zC5zVyhuw3qCh1EIBR+pTE8Fvs0855YOVpRftKOLPiHphgJuANG+z
         CA5EKAdzqyO5j7NeM0wrtCwJ9T3WTVdBlITA/u4Vhrsdph/XWhR5Z3eRm8zXoIEQ+obX
         7+VA==
X-Gm-Message-State: AOJu0YxUhWKO4damIIshbA5F5Zmx+16se2WRcE4WbSz6H4iAF18alol+
	Z5DZyDBJGJQrOuXOVLjXwMIUvD/BobPivXgb96woqi4ZLav5FutB
X-Google-Smtp-Source: AGHT+IEUNsuUNhORzsY2/P6BKeeiYucWm0URSqs+uRBXhCCAgw/81PcaIKtehcTNyYNewuopnSRxTw==
X-Received: by 2002:a05:6122:202a:b0:4ed:314:b3e3 with SMTP id 71dfb90a1353d-4ef6d7d0372mr10882530e0c.3.1719456151135;
        Wed, 26 Jun 2024 19:42:31 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:416:598f:defd:fe4c:6089])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59253752fsm1428156d6.69.2024.06.26.19.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 19:42:30 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net] UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_open()
Date: Wed, 26 Jun 2024 22:42:27 -0400
Message-ID: <20240627024227.3040278-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

In some production workloads we noticed that connections could
sometimes close extremely prematurely with ETIMEDOUT after
transmitting only 1 TLP and RTO retransmission (when we would normally
expect roughly tcp_retries2 = TCP_RETR2 = 15 RTOs before a connection
closes with ETIMEDOUT).

From tracing we determined that these workloads can suffer from a
scenario where in fast recovery, after some retransmits, a DSACK undo
can happen at a point where the scoreboard is totally clear (we have
retrans_out == sacked_out == lost_out == 0). In such cases, calling
tcp_try_keep_open() means that we do not execute any code path that
clears tp->retrans_stamp to 0. That means that tp->retrans_stamp can
remain erroneously set to the start time of the undone fast recovery,
even after the fast recovery is undone. If minutes or hours elapse,
and then a TLP/RTO/RTO sequence occurs, then the start_ts value in
retransmits_timed_out() (which is from tp->retrans_stamp) will be
erroneously ancient (left over from the fast recovery undone via
DSACKs). Thus this ancient tp->retrans_stamp value can cause the
connection to die very prematurely with ETIMEDOUT via
tcp_write_err().

The fix: we change DSACK undo in fast recovery (TCP_CA_Recovery) to
call tcp_try_to_open() instead of tcp_try_keep_open(). This ensures
that if no retransmits are in flight at the time of DSACK undo in fast
recovery then we properly zero retrans_stamp. Note that calling
tcp_try_to_open() is more consistent with other loss recovery
behavior, since normal fast recovery (CA_Recovery) and RTO recovery
(CA_Loss) both normally end when tp->snd_una meets or exceeds
tp->high_seq and then in tcp_fastretrans_alert() the "default" switch
case executes tcp_try_to_open(). Also note that by inspection this
change to call tcp_try_to_open() implies at least one other nice bug
fix, where now an ECE-marked DSACK that causes an undo will properly
invoke tcp_enter_cwr() rather than ignoring the ECE mark.

Fixes: c7d9d6a185a7 ("tcp: undo on DSACK during recovery")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2e39cb881e209..e67cbeeeb95b4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3077,7 +3077,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 			return;
 
 		if (tcp_try_undo_dsack(sk))
-			tcp_try_keep_open(sk);
+			tcp_try_to_open(sk, flag);
 
 		tcp_identify_packet_loss(sk, ack_flag);
 		if (icsk->icsk_ca_state != TCP_CA_Recovery) {
-- 
2.45.2.741.gdbec12cfda-goog


