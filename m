Return-Path: <netdev+bounces-115727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCFD9479E9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA653281CAE
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6712154BFF;
	Mon,  5 Aug 2024 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b="P3e6V+Rz"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AA154BE4
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854055; cv=none; b=L0kGStw/KY4PrZk3mj1XoJnb0IL9uaL2LD0IS2Leg1nbCgnWM1Ydz8bMu1vdRWWMHh69ZyI3G7ctdQDzlOkRlRng2XXDEDkGVK6kvYYxdxyes+tCH8YiXhlEb7nffCQrUz7m7vmKJdxmzO3mC4As1Y62FYSFjv2gJAnZBvDCwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854055; c=relaxed/simple;
	bh=cKReRH94wFKtKtVHMa/L36Kq71/L+wmMJYY5Az9XTAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZMzX/zboYK48aqWrYXNVLNj5Xq7/OhiZ5qCIEwWmwhdR6k5O7jfW8OEMYWUZwbNEdn3xOEqnDXK2MvTjpCd3NYoM31JKh0/qnSjr238PW9tswqLOkV0bxp7IpQRp6zJ9AA/NKuQPNR49LiFUjvX9mdc4G72jydP9JhPkTbI/gJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me; spf=pass smtp.mailfrom=kuroa.me; dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b=P3e6V+Rz; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuroa.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
	t=1722854053; bh=ZkuzDnwnrzCgvULtBdEnjPEEk57f0Z+/bZicr5k01dU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=P3e6V+Rz4yXjoMb+qo7xA4pQKBSnygPAmtqswZEwNt9IisPCrZtPSDFGxEv3L1p2z
	 vLXNfRyNnflXVafIQjbYSot3HSi0ajDyRC/sKDKtpjxIG+hp7WkPi4j7HLKRse+xu3
	 xlKnKXeeKrkMBS+5dUao/Do0bLaQcgJWhpJV2WkP84Ta5ZCcsLzbGMbe07/bFljQhB
	 gaItykGoVgG9InVP2iwN9BQieP9774JG5aaqsiARDJRo1EPH2QoFb7jTc/TE4eTRVi
	 NJRpmnpiq9TG9+f3/ek661WqtLY/7AxbGDMDpHWJxrHsw0XNT6EaRW9JeOqH+ZRPj/
	 x4f9GQ7/Tbh9Q==
Received: from tora.kuroa.me (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id AB6B6180167;
	Mon,  5 Aug 2024 10:34:08 +0000 (UTC)
From: Xueming Feng <kuro@kuroa.me>
To: "David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	David Ahern <dsahern@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xueming Feng <kuro@kuroa.me>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
Date: Mon,  5 Aug 2024 18:33:55 +0800
Message-Id: <20240805103355.219228-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BiHjgtpnWJ65c25Vo619cE8FSclVg5gG
X-Proofpoint-GUID: BiHjgtpnWJ65c25Vo619cE8FSclVg5gG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=964 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2408050076

On Mon, Aug 5, 2024 at 4:04 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> On Mon, Aug 5, 2024 at 3:23 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Aug 5, 2024 at 6:52 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > On Sat, Aug 3, 2024 at 11:48 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > > >
> > > > Hello Eric,
> > > >
> > > > On Thu, Aug 1, 2024 at 9:17 PM Eric Dumazet <edumazet@google.com> wrote:
> > > > >
> > > > > On Thu, Aug 1, 2024 at 1:17 PM Xueming Feng <kuro@kuroa.me> wrote:
> > > > > >
> > > > > > We have some problem closing zero-window fin-wait-1 tcp sockets in our
> > > > > > environment. This patch come from the investigation.
> > > > > >
> > > > > > Previously tcp_abort only sends out reset and calls tcp_done when the
> > > > > > socket is not SOCK_DEAD aka. orphan. For orphan socket, it will only
> > > > > > purging the write queue, but not close the socket and left it to the
> > > > > > timer.
> > > > > >
> > > > > > While purging the write queue, tp->packets_out and sk->sk_write_queue
> > > > > > is cleared along the way. However tcp_retransmit_timer have early
> > > > > > return based on !tp->packets_out and tcp_probe_timer have early
> > > > > > return based on !sk->sk_write_queue.
> > > > > >
> > > > > > This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> > > > > > and socket not being killed by the timers. Converting a zero-windowed
> > > > > > orphan to a forever orphan.
> > > > > >
> > > > > > This patch removes the SOCK_DEAD check in tcp_abort, making it send
> > > > > > reset to peer and close the socket accordingly. Preventing the
> > > > > > timer-less orphan from happening.
> > > > > >
> > > > > > Fixes: e05836ac07c7 ("tcp: purge write queue upon aborting the connection")
> > > > > > Fixes: bffd168c3fc5 ("tcp: clear tp->packets_out when purging write queue")
> > > > > > Signed-off-by: Xueming Feng <kuro@kuroa.me>
> > > > >
> > > > > This seems legit, but are you sure these two blamed commits added this bug ?

My bad, I wasn't sure about the intend of the original commit that did not
handle orphan sockets at the time of blaming, should have asked.

> > > > >
> > > > > Even before them, we should have called tcp_done() right away, instead
> > > > > of waiting for a (possibly long) timer to complete the job.
> > > > >
> > > > > This might be important when killing millions of sockets on a busy server.
> > > > >
> > > > > CC Lorenzo
> > > > >
> > > > > Lorenzo, do you recall why your patch was testing the SOCK_DEAD flag ?
> > > >
> > > > I guess that one of possible reasons is to avoid double-free,
> > > > something like this, happening in inet_csk_destroy_sock().
> > > >
> > > > Let me assume: if we call tcp_close() first under the memory pressure
> > > > which means tcp_check_oom() returns true and then it will call
> > > > inet_csk_destroy_sock() in __tcp_close(), later tcp_abort() will call
> > > > tcp_done() to free the sk again in the inet_csk_destroy_sock() when
> > > > not testing the SOCK_DEAD flag in tcp_abort.
> > > >
> > >
> > > How about this one which can prevent double calling
> > > inet_csk_destroy_sock() when we call destroy and close nearly at the
> > > same time under that circumstance:
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index e03a342c9162..d5d3b21cc824 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -4646,7 +4646,7 @@ int tcp_abort(struct sock *sk, int err)
> > >         local_bh_disable();
> > >         bh_lock_sock(sk);
> > >
> > > -       if (!sock_flag(sk, SOCK_DEAD)) {
> > > +       if (sk->sk_state != TCP_CLOSE) {
> > >                 if (tcp_need_reset(sk->sk_state))
> > >                         tcp_send_active_reset(sk, GFP_ATOMIC,
> > >                                               SK_RST_REASON_NOT_SPECIFIED);
> > >
> > > Each time we call inet_csk_destroy_sock(), we must make sure we've
> > > already set the state to TCP_CLOSE. Based on this, I think we can use
> > > this as an indicator to avoid calling twice to destroy the socket.
> >
> > I do not think this will work.
> >
> > With this patch, a listener socket will not get an error notification.
> 
> Oh, you're right.
> 
> I think we can add this particular case in the if or if-else statement
> to handle.
> 
> Thanks,
> Jason

Summarizing above conversation, I've made a v2-ish patch, which should
handles the double abort, and removes redundent tcp_write_queue_purge.
Please take a look, in the meanwhile, I will see if I can make a test 
for tcp_abort. If this looks good, I will make a formal v2 patch.

Any advice is welcomed. (Including on how to use this mail thread, I don't
have much experience with it.)

Signed-off-by: Xueming Feng <kuro@kuroa.me>
---
 net/ipv4/tcp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..039a9c9301b7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4614,6 +4614,10 @@ int tcp_abort(struct sock *sk, int err)
 {
 	int state = inet_sk_state_load(sk);
 
+	/* Avoid force-closing the same socket twice. */
+	if (state == TCP_CLOSE) {
+		return 0;
+	}
 	if (state == TCP_NEW_SYN_RECV) {
 		struct request_sock *req = inet_reqsk(sk);
 
@@ -4646,16 +4650,13 @@ int tcp_abort(struct sock *sk, int err)
 	local_bh_disable();
 	bh_lock_sock(sk);
 
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		if (tcp_need_reset(sk->sk_state))
-			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
-		tcp_done_with_error(sk, err);
-	}
+	if (tcp_need_reset(sk->sk_state))
+		tcp_send_active_reset(sk, GFP_ATOMIC,
+					SK_RST_REASON_NOT_SPECIFIED);
+	tcp_done_with_error(sk, err);
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
-	tcp_write_queue_purge(sk);
 	if (!has_current_bpf_ctx())
 		release_sock(sk);
 	return 0;
-- 

