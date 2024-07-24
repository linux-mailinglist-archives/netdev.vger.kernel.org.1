Return-Path: <netdev+bounces-112749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D0B93AFCE
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62038282BFC
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947BB155A4F;
	Wed, 24 Jul 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2kTD26C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78D14375C;
	Wed, 24 Jul 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816729; cv=none; b=i64dn9lFVXe7x5FFFeT23cy6f8T0qkDFn4QIJjMrgXJxzvl2zhDHybo0lkX0JwVu1wgM8yne6FuzxKggW7ldqRBM8NkUFtDPGqnV96bf2E+m/sjXCnYv4zATCuB6yKChWukTBhxzUa7QSNrlZ752yXiF6JBe9Zl9lygIYPwZrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816729; c=relaxed/simple;
	bh=MaPFNNWlHVL72dQxlX2AXPyB7G++Hk+qanpapL+ndRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sYnOzIZ8dxYffyuAa5lXGEi6vKytRDnckV34iMowHxZ09Qqo62w1PYeqY42mCpRUGaSXvZA2aL6wJ4YLYFjjoSC7t9BNGS/hArv93O7elKZbsupLAJASiP8LbCWc7nLzvB13VfcDeNltFNOqLREury0vg7B05wKeMdFJh+ARfog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2kTD26C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5826C4AF10;
	Wed, 24 Jul 2024 10:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721816729;
	bh=MaPFNNWlHVL72dQxlX2AXPyB7G++Hk+qanpapL+ndRw=;
	h=From:Date:Subject:To:Cc:From;
	b=B2kTD26Cqe2E2XTFF30WaZZ0i5GzeJ9P0yrnskf7UmBzmfktxeNqITX8b7YSsenHd
	 edXnRtqr9LC38swfiJ2zJNlnIPH7lRSsysZsm5yBbTmw+JAT5inXm4Yz/GQrWJtvuJ
	 9hBBJ04FP83eoYs39JefBWCadKZWur323/ifM0eT8DtMBL2sY84IyH05drTpNU1XHB
	 aVLc3LAfO/z+W5rhEiuGarsE3IL9r1AZo8vzhT871XUP44+dVrxHdlIyql8VnYuluq
	 xCSu/s3MXS1RLEs6NuhMV2TxXXm41LH5t929OV6lfKbtP3SKJZAlYVWqRvLrZf1zKE
	 TvEBRbKQ8qmWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 24 Jul 2024 12:25:16 +0200
Subject: [PATCH net v3] tcp: process the 3rd ACK with sk_socket for
 TFO/MPTCP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v3-1-d48339764ce9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIvWoGYC/6WOzQ6CMBCEX8X07Jr+SAFPvocxBtoFGqQlbWk0h
 ne34WD07GEOM7OZb18koDcYyGn3Ih6TCcbZbMR+R9TQ2B7B6OwJp/xISyZhmUP02ExgMWY9Iny
 qqGYQXkOjRlDOhmVCCOMtODXmW6pazYq6U0VLSZ6fPXbmsaEvJI+Raw4HE6Lzz+2dxLbqf3Jiw
 OCIkmnaljUX4jyit3g/ON9v1MS/SdUfJA4UtCxEVxVS1J38Ia3r+gbneCpEcAEAAA==
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6097; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MaPFNNWlHVL72dQxlX2AXPyB7G++Hk+qanpapL+ndRw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmoNaWHAiN2llseqeo0kZwz3M/CqA2ILonfgrc2
 X0jtdZIEL+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqDWlgAKCRD2t4JPQmmg
 c+F5EACQ3tMY880fYL6Iky1i6g2jsYXUZ4sqa5bGWE+uLWcmAxzznin9bb6i1KtpoIV98VsPSQm
 1gAJipip17Pu6/TvVlgyIWXKIpQA32sxMvkm9HAOKr3s/OrVKc6ibrpa5ZLCBsu1xPKYu/tAoSu
 7XyhBITQpGOJ2X1ZK0QAkKKAf0NAlVgDZJTqifL6vtIf4lPb8GFLB713BU6EFovZFLLQGPOQ5y6
 4iiOETxHRlGqGp13EtpssID0H+E9tZKNxcwGsy6aiMsccV4sMdUlQ5Ftf83PbEWLm6JCxNqyWqt
 oTqNPqV9mdgtRyjKRPvRoN6lL1lfkzaj7vmwQXbL8t3liKDO8f8bJadcdrVItyCOld3+IoFBj1S
 9dxOnm8KMs5zhGMtYgc3jrJkmjvJNsrQqR7hot0Xlx5WGpoTVx/sFRgbSzG5ukeuSHxXnWEL+af
 aaIcoOkKKQi6nrQI1radDLXf08wB/sAFyUADhy2VqWI3p00vIDprb/eq2GVROR9mh/r66YeP5T9
 zSNGDXyfcJNIqLQWH/3MCZvcDNZIGXmLUCeh54A21nOLZ0B+qNT8Bhj2ZBA1NhYKnHPFof0otzo
 dRSjGzyQcKCxcgpZdTxEmVC+syuNlgPeCSZirQrSXLnZJdkswTJGhJcGFimxvphoryC5U0zrqK+
 c6BXARN/+olbgjA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'Fixes' commit recently changed the behaviour of TCP by skipping the
processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
unnecessary ACK in case of simultaneous connect(). Unfortunately, that
had an impact on TFO and MPTCP.

I started to look at the impact on MPTCP, because the MPTCP CI found
some issues with the MPTCP Packetdrill tests [1]. Then Paolo Abeni
suggested me to look at the impact on TFO with "plain" TCP.

For MPTCP, when receiving the 3rd ACK of a request adding a new path
(MP_JOIN), sk->sk_socket will be set, and point to the MPTCP sock that
has been created when the MPTCP connection got established before with
the first path. The newly added 'goto' will then skip the processing of
the segment text (step 7) and not go through tcp_data_queue() where the
MPTCP options are validated, and some actions are triggered, e.g.
sending the MPJ 4th ACK [2] as demonstrated by the new errors when
running a packetdrill test [3] establishing a second subflow.

This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
delayed. Still, we don't want to have this behaviour as it delays the
switch to the fully established mode, and invalid MPTCP options in this
3rd ACK will not be caught any more. This modification also affects the
MPTCP + TFO feature as well, and being the reason why the selftests
started to be unstable the last few days [4].

For TFO, the existing 'basic-cookie-not-reqd' test [5] was no longer
passing: if the 3rd ACK contains data, and the connection is accept()ed
before receiving them, these data would no longer be processed, and thus
not ACKed.

One last thing about MPTCP, in case of simultaneous connect(), a
fallback to TCP will be done, which seems fine:

  `../common/defaults.sh`

   0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) = 3
  +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)

  +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>
  +0 >  . 1:1(0) ack 1           <nop, nop, TS val 845707014 ecr 700, nop, nop, sack 0:1>

Simultaneous SYN-data crossing is also not supported by TFO, see [6].

Kuniyuki Iwashima suggested to restrict the processing to SYN+ACK only:
that's a more generic solution than the one initially proposed, and
also enough to fix the issues described above.

Later on, Eric Dumazet mentioned that an ACK should still be sent in
reaction to the second SYN+ACK that is received: not sending a DUPACK
here seems wrong and could hurt:

   0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
  +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)

  +0 > S  0:0(0)                <mss 1460, sackOK, TS val 1000 ecr 0,nop,wscale 8>
  +0 < S  0:0(0)       win 1000 <mss 1000, sackOK, nop, nop>
  +0 > S. 0:0(0) ack 1          <mss 1460, sackOK, TS val 3308134035 ecr 0,nop,wscale 8>
  +0 < S. 0:0(0) ack 1 win 1000 <mss 1000, sackOK, nop, nop>
  +0 >  . 1:1(0) ack 1          <nop, nop, sack 0:1>  // <== Here

So in this version, the 'goto consume' is dropped, to always send an ACK
when switching from TCP_SYN_RECV to TCP_ESTABLISHED. This ACK will be
seen as a DUPACK -- with DSACK if SACK has been negotiated -- in case of
simultaneous SYN crossing: that's what is expected here.

Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/9936227696 [1]
Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/syscalls/accept.pkt#L28 [3]
Link: https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp-dbg&test=mptcp-connect-sh [4]
Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fastopen/server/basic-cookie-not-reqd.pkt#L21 [5]
Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fastopen/client/simultaneous-fast-open.pkt [6]
Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v3:
   - Drop the patch 2/2: will be sent to net-next when re-opened (Eric)
   - Drop the 'goto consume' to always send an ACK (Eric)
   - Drop Jerry Chu from the Cc list: the email address no longer exists
   - Link to v2: https://lore.kernel.org/r/20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org
 - v2:
   - Check if the SYN bit is set instead of looking for TFO and MPTCP
     specific attributes, as suggested by Kuniyuki.
   - Updated the comment above
   - Link to v1: https://lore.kernel.org/r/20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org
---
 net/ipv4/tcp_input.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ff9ab3d01ced..454362e359da 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6819,9 +6819,6 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tcp_fast_path_on(tp);
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
-
-		if (sk->sk_socket)
-			goto consume;
 		break;
 
 	case TCP_FIN_WAIT1: {

---
base-commit: 3ba359c0cd6eb5ea772125a7aededb4a2d516684
change-id: 20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-0cbd159fc5b0

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


