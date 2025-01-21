Return-Path: <netdev+bounces-160131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14FA18798
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8293D167F27
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5F1DF26F;
	Tue, 21 Jan 2025 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg9Ds51U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880941B041B;
	Tue, 21 Jan 2025 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497316; cv=none; b=SYlrXR6/QP8yETFeMIdVpQ8ZXEQPBoxBLfV2vOtUTzIFLEFNrwuNJflNxf0t/9xfRnNSWOgd1T2+X7QQaeoe7rDG+kt0ciu8pUlI1J05XkGLrtwsNtyx4/PpZDXf2+I7ZRve414qP77tHbal84HQXjavTnhH0c7lZNn6uJ40oQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497316; c=relaxed/simple;
	bh=PLUFlnVAwt4pNFpkeYRqH66RIrFVLnpLJH68Qz45eMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/QbXP23JtLoR2JzRjApmBIzhMB8/5BPQM4cYlK8uUFA0gol1mOk5/xctFd/YVU22WSSCIMf3hrWxNasUKVMNiH9QeCNR9Z8f2BjU1Xwov+m6vvdpM+qamKOt8rBs4GpSbXCpR2jJgXUUW7hYz1qPWS+BMmXVR48rCVHzXocR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg9Ds51U; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d88cb85987so2190196d6.1;
        Tue, 21 Jan 2025 14:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737497313; x=1738102113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YW+xb/eUVpJ5Es083p9xnw5dx6Sw/v89omK44gNmElU=;
        b=Gg9Ds51UCYQvGjW4NM7vvnWaG4lyEl1O8W2f6/mD6qTjTCbenSwu3pgdPlKt3DJiA5
         Q7SbT1JK09yRMxZnF2gT6WecwkTqJohhfU/zm3esCpk++XRwUTf++qqgax3LxgK2Fjst
         mdpilRBRGp43nhtqQuJauPIpolQKKDtyNNJLbRyy/+0gSpLWlZIGWhU42KW/jLDZH2g8
         SKpc5zfskTqHHgsYxWF2yDG/usWI/nvsO8wJFVoDYIGAgmc6/GqiUyXoGNi38o6hJJFG
         7mVAIsfSYBbDtv2o6YHLqE2x1W5nV4yzu/kFa1YkeZ0njMDV06GTJZX6qcqMsKskc8TH
         +h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737497313; x=1738102113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW+xb/eUVpJ5Es083p9xnw5dx6Sw/v89omK44gNmElU=;
        b=kyRmQrHy4E2PSA+t9UrvEb9d8ov57JknJSeixifVS2wFVal3+BSUwVttkLWSSnlApU
         TP6PS7UNc2+nA0WOW4uEZCkioqbR0l1JpESEdBQKLyDPlCjs4YW8eVZpxEO9zByLjLX5
         TtVq1EIuABNxGCEDyA/Cg/fPyMSxPgHr2hP1MM0Xf516EBU5qvMEyK8s56GSqiK6vqvg
         F4LTISberE1lHLKThO9Z4V7sug1PLLJJ/jPXuYZaM87l0qg8gQUv1I9ZvkMLDzDDAtFt
         7LWYQkkGNYqrje56sjiSlh5kPMnw1NnreyhJurZjVeEalBRpp7X3g3XEn4nbtadHvaX5
         lbow==
X-Forwarded-Encrypted: i=1; AJvYcCV9cPFpJ6fiado0e/yXePD4IZ3+B4fyHYDW8pptcf5SXdQx1AyPhUhgUzwgPuhDRHMdTfPSBrmR@vger.kernel.org, AJvYcCVPTcA2oGfatTCEClC71nWQXpA5hfnZshD2eDg2nafntujiwL1hAUFciswroNcD8xNsJl4exPNUR/gBgZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELQ2VsnTUpErGV2jZT85GAJLDMzRI8G5uYu5iUrklOR/9WSZ9
	fYqsJlteFjfD23XzU20yRxNcpsvjvaf8Iafe7xnclPVsGAaylJeH
X-Gm-Gg: ASbGncuPV5qcvCiq9iH244ElE7ZB7wGDzfTr30H0ChgKDf5lurvMcy7dRBplEB6Tyc0
	bnI5I03Xl06PSbcHNzaVcoyNXkKq9g27g5EYywDLVcWDuGppCUJgaRV6jcmmfZswDuQ4b2mdi4H
	X1FxbMm1+K3D1z6wkGiSizzs1Kdpazf6gNNWMeaaa/QILIJbFHtiWqq9fQf9Iw706p8mla/eED4
	ewhYoHcQtUSJcBeLw4ZziQ1slgz3q2uXVXQcc/dUtpmg1AaL5el2prOuNE0Q60Nd9F+LhQOEGeC
	YClgl6VhU8EepsxZn3FPSJRd0eRBfMZEFxakRgmD8fV1GUgWGKi0hYkx0NUQzTg/srZB7+CLUwp
	4HZd0duUzxvKU0aUWKtM=
X-Google-Smtp-Source: AGHT+IEUtK2qT6jC7YTui1SsVFHu+5G2ZDu0M0COq8hiv/HrzTodMz8TVFaBlBVrVEExFh3EpDwoGw==
X-Received: by 2002:a05:6214:3c89:b0:6d8:9f61:de6c with SMTP id 6a1803df08f44-6e1b279dc53mr334105486d6.18.1737497313297;
        Tue, 21 Jan 2025 14:08:33 -0800 (PST)
Received: from ip-172-31-42-18.us-east-2.compute.internal (ec2-3-13-12-112.us-east-2.compute.amazonaws.com. [3.13.12.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1e9608828sm6457606d6.70.2025.01.21.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 14:08:33 -0800 (PST)
From: Feng Li <funglee@gmail.com>
X-Google-Original-From: Feng Li <feng.li@ieee.org>
To: 
Cc: feng.li@viasat.com,
	jaewon.chung@viasat.com,
	claypool@wpi.edu,
	mataeikachooei@wpi.edu,
	Feng Li <feng.li@ieee.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] TCP:  SEARCH a new slow start algorithm to replace Hystart in TCP Cubic
Date: Tue, 21 Jan 2025 17:08:07 -0500
Message-ID: <20250121220821.24694-1-feng.li@ieee.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements a new TCP slow start algorithm (SEARCH) for TCP
Cubic congestion control algorithm.  An IETF draft
(https://datatracker.ietf.org/doc/draft-chung-ccwg-search/detailed)
with detailed description of SEARCH is under review.  Moreover,  a
series of papers give more detailed implementation information of this
new slow start algorithm.

The patch mainly adds SEARCH as the default slow start algorithm for
TCP Cubic.  Please review the inline comments in the patch for the
details.

In tcp_cubic.c: (the only file changed in this patch).
- add SEARCH as a new slow start algorithm

- add new module parameters to configure SEARCH, allow user to enable/
disable SEARCH or Hystart during runtime.

- add SEARCH related variables into struct bictcp, to save memory
footprint,  SEARCH shares share the space with hystart variables within
a union
- add SEARCH related functions search_update_bins() and search_update().

Signed-off-by: Feng Li <feng.li@ieee.org>
---
 net/ipv4/tcp_cubic.c | 386 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 345 insertions(+), 41 deletions(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 76c23675ae50..57111641fdae 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -52,7 +52,6 @@ static int initial_ssthresh __read_mostly;
 static int bic_scale __read_mostly = 41;
 static int tcp_friendliness __read_mostly = 1;
 
-static int hystart __read_mostly = 1;
 static int hystart_detect __read_mostly = HYSTART_ACK_TRAIN | HYSTART_DELAY;
 static int hystart_low_window __read_mostly = 16;
 static int hystart_ack_delta_us __read_mostly = 2000;
@@ -72,8 +71,6 @@ module_param(bic_scale, int, 0444);
 MODULE_PARM_DESC(bic_scale, "scale (scaled by 1024) value for bic function (bic_scale/1024)");
 module_param(tcp_friendliness, int, 0644);
 MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
-module_param(hystart, int, 0644);
-MODULE_PARM_DESC(hystart, "turn on/off hybrid slow start algorithm");
 module_param(hystart_detect, int, 0644);
 MODULE_PARM_DESC(hystart_detect, "hybrid slow start detection mechanisms"
 		 " 1: packet-train 2: delay 3: both packet-train and delay");
@@ -82,6 +79,48 @@ MODULE_PARM_DESC(hystart_low_window, "lower bound cwnd for hybrid slow start");
 module_param(hystart_ack_delta_us, int, 0644);
 MODULE_PARM_DESC(hystart_ack_delta_us, "spacing between ack's indicating train (usecs)");
 
+//////////////////////// SEARCH ////////////////////////
+/*	enable SEARCH with command:
+ *		sudo sh -c "echo '1' > /sys/module/your_module_name/parameters/slow_start_mode"
+ *	enable HyStart with command:
+ *		sudo sh -c "echo '2' > /sys/module/cubic_with_search/parameters/slow_start_mode"
+ *	disable both SEARCH and HyStart with command:
+ *		sudo sh -c "echo '0' > /sys/module/cubic_with_search/parameters/slow_start_mode"
+ */
+
+#define MAX_US_INT 0xffff
+#define SEARCH_BINS 10		/* Number of bins in a window */
+#define SEARCH_EXTRA_BINS 15	/* Number of additional bins to cover data after shiftting by RTT */
+#define SEARCH_TOTAL_BINS 25	/* Total number of bins containing essential bins to cover RTT
+				 * shift
+				 */
+
+/* Define an enum for the slow start mode */
+enum {
+	SS_LEGACY = 0,	/* No slow start algorithm is used */
+	SS_SEARCH = 1,	/* Enable the SEARCH slow start algorithm */
+	SS_HYSTART = 2	/* Enable the HyStart slow start algorithm */
+};
+
+/* Set the default mode */
+static int slow_start_mode __read_mostly = SS_SEARCH;
+static int search_window_duration_factor __read_mostly = 35;
+static int search_thresh __read_mostly = 35;
+static int cwnd_rollback __read_mostly;
+static int search_missed_bins_threshold = 2;
+
+// Module parameters used by SEARCH
+module_param(slow_start_mode, int, 0644);
+MODULE_PARM_DESC(slow_start_mode, "0: No Algorithm, 1: SEARCH, 2: HyStart");
+module_param(search_window_duration_factor, int, 0644);
+MODULE_PARM_DESC(search_window_duration_factor, "Multiply with (initial RTT / 10) to set the window size");
+module_param(search_thresh, int, 0644);
+MODULE_PARM_DESC(search_thresh, "Threshold for exiting from slow start in percentage");
+module_param(cwnd_rollback, int, 0644);
+MODULE_PARM_DESC(cwnd_rollback, "Decrease the cwnd to its value in 2 initial RTT ago");
+module_param(search_missed_bins_threshold, int, 0644);
+MODULE_PARM_DESC(search_missed_bins_threshold, "Minimum threshold of missed bins before resetting SEARCH");
+
 /* BIC TCP Parameters */
 struct bictcp {
 	u32	cnt;		/* increase cwnd by 1 after ACKs */
@@ -95,19 +134,47 @@ struct bictcp {
 	u32	epoch_start;	/* beginning of an epoch */
 	u32	ack_cnt;	/* number of acks */
 	u32	tcp_cwnd;	/* estimated tcp cwnd */
-	u16	unused;
-	u8	sample_cnt;	/* number of samples to decide curr_rtt */
-	u8	found;		/* the exit point is found? */
-	u32	round_start;	/* beginning of each round */
-	u32	end_seq;	/* end_seq of the round */
-	u32	last_ack;	/* last time when the ACK spacing is close */
-	u32	curr_rtt;	/* the minimum rtt of current round */
+
+	/* Union of HyStart and SEARCH variables */
+	union {
+		/* HyStart variables */
+		struct {
+			u16	unused;
+			u8	sample_cnt;/* number of samples to decide curr_rtt */
+			u8	found;		/* the exit point is found? */
+			u32	round_start;	/* beginning of each round */
+			u32	end_seq;	/* end_seq of the round */
+			u32	last_ack;	/* last time when the ACK spacing is close */
+			u32	curr_rtt;	/* the minimum rtt of current round */
+		} hystart;
+
+		/* SEARCH variables */
+		struct {
+			u32	bin_duration_us;	/* duration of each bin in microsecond */
+			s32	curr_idx;	/* total number of bins */
+			u32	bin_end_us;	/* end time of the latest bin in microsecond */
+			u16	bin[SEARCH_TOTAL_BINS];	/* array to keep bytes for bins */
+			u8	unused;
+			u8	scale_factor;	/* scale factor to fit the value with bin size*/
+		} search;
+	};
 };
 
+static inline void bictcp_search_reset(struct bictcp *ca)
+{
+	memset(ca->search.bin, 0, sizeof(ca->search.bin));
+	ca->search.bin_duration_us = 0;
+	ca->search.curr_idx = -1;
+	ca->search.bin_end_us = 0;
+	ca->search.scale_factor = 0;
+}
+
 static inline void bictcp_reset(struct bictcp *ca)
 {
-	memset(ca, 0, offsetof(struct bictcp, unused));
-	ca->found = 0;
+	memset(ca, 0, offsetof(struct bictcp, hystart.unused));
+	if (slow_start_mode == SS_HYSTART)
+		ca->hystart.found = 0;
+
 }
 
 static inline u32 bictcp_clock_us(const struct sock *sk)
@@ -120,10 +187,10 @@ static inline void bictcp_hystart_reset(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
 
-	ca->round_start = ca->last_ack = bictcp_clock_us(sk);
-	ca->end_seq = tp->snd_nxt;
-	ca->curr_rtt = ~0U;
-	ca->sample_cnt = 0;
+	ca->hystart.round_start = ca->hystart.last_ack = bictcp_clock_us(sk);
+	ca->hystart.end_seq = tp->snd_nxt;
+	ca->hystart.curr_rtt = ~0U;
+	ca->hystart.sample_cnt = 0;
 }
 
 __bpf_kfunc static void cubictcp_init(struct sock *sk)
@@ -132,15 +199,17 @@ __bpf_kfunc static void cubictcp_init(struct sock *sk)
 
 	bictcp_reset(ca);
 
-	if (hystart)
+	if (slow_start_mode == SS_HYSTART)
 		bictcp_hystart_reset(sk);
 
-	if (!hystart && initial_ssthresh)
+	if (slow_start_mode != SS_HYSTART && initial_ssthresh)
 		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;
 }
 
 __bpf_kfunc static void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event)
 {
+	struct bictcp *ca = inet_csk_ca(sk);
+
 	if (event == CA_EVENT_TX_START) {
 		struct bictcp *ca = inet_csk_ca(sk);
 		u32 now = tcp_jiffies32;
@@ -158,6 +227,12 @@ __bpf_kfunc static void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event e
 		}
 		return;
 	}
+	if (event == CA_EVENT_CWND_RESTART) {
+		if (slow_start_mode == SS_SEARCH)
+			bictcp_search_reset(ca);
+		return;
+	}
+	return;
 }
 
 /* calculate the cubic root of x using a table lookup followed by one
@@ -330,6 +405,8 @@ __bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 		return;
 
 	if (tcp_in_slow_start(tp)) {
+		if (slow_start_mode == SS_HYSTART && after(ack, ca->hystart.end_seq))
+			bictcp_hystart_reset(sk);
 		acked = tcp_slow_start(tp, acked);
 		if (!acked)
 			return;
@@ -359,7 +436,11 @@ __bpf_kfunc static void cubictcp_state(struct sock *sk, u8 new_state)
 {
 	if (new_state == TCP_CA_Loss) {
 		bictcp_reset(inet_csk_ca(sk));
-		bictcp_hystart_reset(sk);
+		if (slow_start_mode == SS_SEARCH)
+			bictcp_search_reset(inet_csk_ca(sk));
+
+		if (slow_start_mode == SS_HYSTART)
+			bictcp_hystart_reset(sk);
 	}
 }
 
@@ -389,19 +470,15 @@ static void hystart_update(struct sock *sk, u32 delay)
 	struct bictcp *ca = inet_csk_ca(sk);
 	u32 threshold;
 
-	if (after(tp->snd_una, ca->end_seq))
+	if (after(tp->snd_una, ca->hystart.end_seq))
 		bictcp_hystart_reset(sk);
 
-	/* hystart triggers when cwnd is larger than some threshold */
-	if (tcp_snd_cwnd(tp) < hystart_low_window)
-		return;
-
 	if (hystart_detect & HYSTART_ACK_TRAIN) {
 		u32 now = bictcp_clock_us(sk);
 
 		/* first detection parameter - ack-train detection */
-		if ((s32)(now - ca->last_ack) <= hystart_ack_delta_us) {
-			ca->last_ack = now;
+		if ((s32)(now - ca->hystart.last_ack) <= hystart_ack_delta_us) {
+			ca->hystart.last_ack = now;
 
 			threshold = ca->delay_min + hystart_ack_delay(sk);
 
@@ -413,31 +490,31 @@ static void hystart_update(struct sock *sk, u32 delay)
 			if (sk->sk_pacing_status == SK_PACING_NONE)
 				threshold >>= 1;
 
-			if ((s32)(now - ca->round_start) > threshold) {
-				ca->found = 1;
+			if ((s32)(now - ca->hystart.round_start) > threshold) {
+				ca->hystart.found = 1;
 				pr_debug("hystart_ack_train (%u > %u) delay_min %u (+ ack_delay %u) cwnd %u\n",
-					 now - ca->round_start, threshold,
-					 ca->delay_min, hystart_ack_delay(sk), tcp_snd_cwnd(tp));
+					 now - ca->hystart.round_start, threshold,
+					 ca->delay_min, hystart_ack_delay(sk), tp->snd_cwnd);
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPHYSTARTTRAINDETECT);
 				NET_ADD_STATS(sock_net(sk),
 					      LINUX_MIB_TCPHYSTARTTRAINCWND,
 					      tcp_snd_cwnd(tp));
-				tp->snd_ssthresh = tcp_snd_cwnd(tp);
+				tp->snd_ssthresh = tp->snd_cwnd;
 			}
 		}
 	}
 
 	if (hystart_detect & HYSTART_DELAY) {
 		/* obtain the minimum delay of more than sampling packets */
-		if (ca->curr_rtt > delay)
-			ca->curr_rtt = delay;
-		if (ca->sample_cnt < HYSTART_MIN_SAMPLES) {
-			ca->sample_cnt++;
+		if (ca->hystart.curr_rtt > delay)
+			ca->hystart.curr_rtt = delay;
+		if (ca->hystart.sample_cnt < HYSTART_MIN_SAMPLES) {
+			ca->hystart.sample_cnt++;
 		} else {
-			if (ca->curr_rtt > ca->delay_min +
+			if (ca->hystart.curr_rtt > ca->delay_min +
 			    HYSTART_DELAY_THRESH(ca->delay_min >> 3)) {
-				ca->found = 1;
+				ca->hystart.found = 1;
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPHYSTARTDELAYDETECT);
 				NET_ADD_STATS(sock_net(sk),
@@ -449,6 +526,226 @@ static void hystart_update(struct sock *sk, u32 delay)
 	}
 }
 
+/* Scale bin value to fit bin size, rescale previous bins.
+ * Return amount scaled.
+ */
+static inline u8 search_bit_shifting(struct sock *sk, u64 bin_value)
+{
+	struct bictcp *ca = inet_csk_ca(sk);
+	u8 num_shift = 0;
+	u32 i = 0;
+
+	/* Adjust bin_value if it's greater than MAX_BIN_VALUE */
+	while (bin_value > MAX_US_INT) {
+		num_shift += 1;
+		bin_value >>= 1;  /* divide bin_value by 2 */
+	}
+
+	/* Adjust all previous bins according to the new num_shift */
+	for (i = 0; i < SEARCH_TOTAL_BINS; i++)
+		ca->search.bin[i] >>= num_shift;
+
+	/* Update the scale factor */
+	ca->search.scale_factor += num_shift;
+
+	return num_shift;
+}
+
+/* Initialize bin */
+static void search_init_bins(struct sock *sk, u32 now_us, u32 rtt_us)
+{
+	struct bictcp *ca = inet_csk_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u8 amount_scaled = 0;
+	u64 bin_value = 0;
+
+	ca->search.bin_duration_us = (rtt_us * search_window_duration_factor) / (SEARCH_BINS * 10);
+	ca->search.bin_end_us = now_us + ca->search.bin_duration_us;
+	ca->search.curr_idx = 0;
+	bin_value = tp->bytes_acked;
+	if (bin_value > MAX_US_INT) {
+		amount_scaled = search_bit_shifting(sk, bin_value);
+		bin_value >>= amount_scaled;
+	}
+	ca->search.bin[0] = bin_value;
+}
+
+/* Update bins */
+static void search_update_bins(struct sock *sk, u32 now_us, u32 rtt_us)
+{
+	struct bictcp *ca = inet_csk_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 passed_bins = 0;
+	u32 i = 0;
+	u64 bin_value = 0;
+	u8 amount_scaled = 0;
+
+	/* If passed_bins greater than 1, it means we have some missed bins */
+	passed_bins = ((now_us - ca->search.bin_end_us) / ca->search.bin_duration_us) + 1;
+
+	/* If we passed more than search_missed_bins_threshold bins, need to reset
+	 * SEARCH, and initialize bins
+	 */
+	if (passed_bins > search_missed_bins_threshold) {
+		bictcp_search_reset(ca);
+		search_init_bins(sk, now_us, rtt_us);
+		return;
+	}
+
+	for (i = ca->search.curr_idx + 1; i < ca->search.curr_idx + passed_bins; i++)
+		ca->search.bin[i % SEARCH_TOTAL_BINS] =
+			ca->search.bin[ca->search.curr_idx % SEARCH_TOTAL_BINS];
+
+	ca->search.bin_end_us += passed_bins * ca->search.bin_duration_us;
+	ca->search.curr_idx += passed_bins;
+
+	/* Calculate bin_value by dividing bytes_acked by 2^scale_factor */
+	bin_value = tp->bytes_acked >> ca->search.scale_factor;
+
+	if (bin_value > MAX_US_INT) {
+		amount_scaled  = search_bit_shifting(sk, bin_value);
+		bin_value >>= amount_scaled;
+	}
+
+	/* Assign the bin_value to the current bin */
+	ca->search.bin[ca->search.curr_idx % SEARCH_TOTAL_BINS] = bin_value;
+}
+
+/* Calculate delivered bytes for a window considering interpolation */
+static inline u64 search_compute_delivered_window(struct sock *sk,
+						  s32 left, s32 right, u32 fraction)
+{
+	struct bictcp *ca = inet_csk_ca(sk);
+	u64 delivered = 0;
+
+	delivered = ca->search.bin[(right - 1) % SEARCH_TOTAL_BINS]
+				- ca->search.bin[left % SEARCH_TOTAL_BINS];
+
+	/* If we are interpolating using the very first bin, the "previous" bin value is 0. */
+	if (left == 0)
+		delivered += (ca->search.bin[left % SEARCH_TOTAL_BINS]) * fraction / 100;
+	else
+		delivered += (ca->search.bin[left % SEARCH_TOTAL_BINS]
+				- ca->search.bin[(left - 1) % SEARCH_TOTAL_BINS]) * fraction / 100;
+
+	delivered += (ca->search.bin[right % SEARCH_TOTAL_BINS]
+			- ca->search.bin[(right - 1) % SEARCH_TOTAL_BINS])
+				* (100 - fraction) / 100;
+
+	return delivered;
+}
+
+/* Handle slow start exit condition */
+static void search_exit_slow_start(struct sock *sk, u32 now_us, u32 rtt_us)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bictcp *ca = inet_csk_ca(sk);
+	s32 cong_idx = 0;
+	u32 initial_rtt = 0;
+	u64 overshoot_bytes = 0;
+	u32 overshoot_cwnd = 0;
+
+	/* If cwnd rollback is enabled, the code calculates the initial round-trip time (RTT)
+	 * and determines the congestion index (`cong_idx`) from which to compute the overshoot.
+	 * The overshoot represents the excess bytes delivered beyond the estimated target,
+	 * which is calculated over a window defined by the current and the rollback indices.
+	 *
+	 * The rollback logic adjusts the congestion window (`snd_cwnd`) based on the overshoot:
+	 * 1. It first computes the overshoot congestion window (`overshoot_cwnd`), derived by
+	 *    dividing the overshoot bytes by the maximum segment size (MSS).
+	 * 2. It reduces `snd_cwnd` by the calculated overshoot while ensuring it does not fall
+	 *    below the initial congestion window (`TCP_INIT_CWND`), which acts as a safety guard.
+	 * 3. If the overshoot exceeds the current congestion window, it resets `snd_cwnd` to the
+	 *    initial value, providing a safeguard to avoid a drastic drop in case of miscalcula-
+	 *    tions  or unusual network conditions (e.g., TCP reset).
+	 *
+	 * After adjusting the congestion window, the slow start threshold (`snd_ssthresh`) is set
+	 * to the updated congestion window to finalize the rollback.
+	 */
+
+	/* If cwnd rollback is enabled */
+	if (cwnd_rollback) {
+		initial_rtt = ca->search.bin_duration_us * SEARCH_BINS * 10
+				/ search_window_duration_factor;
+		cong_idx = ca->search.curr_idx - ((2 * initial_rtt) / ca->search.bin_duration_us);
+
+		/* Calculate the overshoot based on the delivered bytes between cong_idx and
+		 * the current index
+		 */
+		overshoot_bytes = search_compute_delivered_window(sk, cong_idx,
+								  ca->search.curr_idx, 0);
+
+		/* Calculate the rollback congestion window based on overshoot divided by MSS */
+		overshoot_cwnd = overshoot_bytes / tp->mss_cache;
+
+		/* Reduce the current congestion window (cwnd) with a safety guard:
+		 * It doesn't drop below the initial cwnd (TCP_INIT_CWND) or is not
+		 * larger than the current cwnd (e.g., In the case of a TCP reset)
+		 */
+		if (overshoot_cwnd < tp->snd_cwnd)
+			tp->snd_cwnd = max(tp->snd_cwnd - overshoot_cwnd, (u32)TCP_INIT_CWND);
+		else
+			tp->snd_cwnd = TCP_INIT_CWND;
+	}
+
+	tp->snd_ssthresh = tp->snd_cwnd;
+
+	/*  If TCP re-enters slow start, the missed_bin threshold will be
+	 *   exceeded upon a bin update, and SEARCH will reset automatically.
+	 */
+}
+
+//////////////////////// SEARCH ////////////////////////
+static void search_update(struct sock *sk, u32 rtt_us)
+{
+	struct bictcp *ca = inet_csk_ca(sk);
+
+	s32 prev_idx = 0;
+	u64 curr_delv_bytes = 0, prev_delv_bytes = 0;
+	s32 norm_diff = 0;
+	u32 now_us = bictcp_clock_us(sk);
+	u32 fraction = 0;
+
+	/* by receiving the first ack packet, initialize bin duration and bin end time */
+	if (ca->search.bin_duration_us == 0) {
+		search_init_bins(sk, now_us, rtt_us);
+		return;
+	}
+
+	if (now_us < ca->search.bin_end_us)
+		return;
+
+	/* reach or pass the bin boundary, update bins */
+	search_update_bins(sk, now_us, rtt_us);
+
+	/* check if there is enough bins after shift for computing previous window */
+	prev_idx = ca->search.curr_idx - (rtt_us / ca->search.bin_duration_us);
+
+	if (prev_idx >= SEARCH_BINS && (ca->search.curr_idx - prev_idx) < SEARCH_EXTRA_BINS - 1) {
+		/* Calculate delivered bytes for the current and previous windows */
+
+		curr_delv_bytes = search_compute_delivered_window(sk,
+								  ca->search.curr_idx - SEARCH_BINS,
+								  ca->search.curr_idx, 0);
+
+		fraction = ((rtt_us % ca->search.bin_duration_us) * 100 /
+				ca->search.bin_duration_us);
+
+		prev_delv_bytes = search_compute_delivered_window(sk, prev_idx - SEARCH_BINS,
+								  prev_idx, fraction);
+
+		if (prev_delv_bytes > 0) {
+			norm_diff = ((prev_delv_bytes << 1) - curr_delv_bytes)
+					* 100 / (prev_delv_bytes << 1);
+
+			/* check for exit condition */
+			if ((2 * prev_delv_bytes) >= curr_delv_bytes && norm_diff >= search_thresh)
+				search_exit_slow_start(sk, now_us, rtt_us);
+		}
+	}
+}
+
+//////////////////////////////////////////////////////////////
 __bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack_sample *sample)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
@@ -471,8 +768,15 @@ __bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack_sample
 	if (ca->delay_min == 0 || ca->delay_min > delay)
 		ca->delay_min = delay;
 
-	if (!ca->found && tcp_in_slow_start(tp) && hystart)
-		hystart_update(sk, delay);
+	//////////////////////// SEARCH ////////////////////////
+	if (tcp_in_slow_start(tp)) {
+		if (slow_start_mode == SS_SEARCH) {
+			/* implement search algorithm */
+			search_update(sk, delay);
+		} else if (slow_start_mode == SS_HYSTART && !ca->hystart.found &&
+			   tp->snd_cwnd >= hystart_low_window)
+			hystart_update(sk, delay);
+	}
 }
 
 static struct tcp_congestion_ops cubictcp __read_mostly = {
@@ -551,5 +855,5 @@ module_exit(cubictcp_unregister);
 
 MODULE_AUTHOR("Sangtae Ha, Stephen Hemminger");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("CUBIC TCP");
-MODULE_VERSION("2.3");
+MODULE_DESCRIPTION("CUBIC TCP w/ SEARCH");
+MODULE_VERSION("3.0");
-- 
2.47.1


