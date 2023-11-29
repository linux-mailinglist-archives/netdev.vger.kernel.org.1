Return-Path: <netdev+bounces-52028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B137FCFE4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBBE1C2105C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4901096C;
	Wed, 29 Nov 2023 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQWT3PE0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F31FFE
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:28:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d12853cb89so36971337b3.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701242888; x=1701847688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BVg95LAAyRsUgblnFDs6ESoSmxWDm0MBY9Tw6S2vlU=;
        b=sQWT3PE0bWgUU9w4Krhoakyq8qw34wzKOhfNwv3rhdwtvaYeqvi3sKxyPqjhZeWkR0
         L2LKMFLZ3Z6fOfRayaY/admAaq1AJ4x1lm0TK3BtUTg+N23OYYleRtFbC33USkhb+iwC
         UWUH+M1hojuL45Tw9NcfM/+DuafYVF1w8O9fQOVajvBCrhKLj18heggsxbhDxOeCCSik
         +kNjEGNMnEmNZg5HJ9aElGiqDMdmMskWQVAWCVanOdRstPmjXv0rs/tl6TIbgU+FVyid
         Qrq8q5a5sZx5UvZ3lB6tMxsZ3K0btnSzgFpaVMNQI73x30eG29NYje1dipSn1myGsq+b
         NSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701242888; x=1701847688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BVg95LAAyRsUgblnFDs6ESoSmxWDm0MBY9Tw6S2vlU=;
        b=jcjYF5PxdD0IhR8KN6qjAe6ZIb3rhcO4r1fKk8JtrKWdl0F63mOBXX23rRCw0ZygLL
         o7TvMX0Liib4u75Ox6ZYZw3WXknfkOh5/yGx048nop11162hmAfUOyRdAaMMTlKTUBof
         yzvoQV8dhd5IXfKM1mEyrYCz0LAb0//Y44vurNFH/CHBV6QoHUhKUcoXSeo3OFLdBcM1
         1KcNSfgc4R5HR14Y3py/v+0oT5hj4UxC9FthkrAIAnR7+2cyxtRww9fJyrz9QIq2t575
         +Dk5DhHOTI7c/0AiL0N3tfv+8l7CRGeLhMvJ+EzGnE/vHOa3cFg2Dtw5W2pR6EwDTD2Z
         M9zQ==
X-Gm-Message-State: AOJu0YzKGXyVgZidxtDTwzHCYD/uavY9ebYOlMApgWgofTaNZHuSJtdj
	Md34aGZFw9LFON4pEFTTDuiE7lzuxf2wIS0=
X-Google-Smtp-Source: AGHT+IG3Ux7kua24ibAVxH0SSvZ7v/NEldwe8PvNZITTdVPZmsm+bfciID/9wsF9iBumWPQDkiKlcIW7iPABvY4=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:690c:4481:b0:5cb:bc6b:3439 with SMTP
 id gr1-20020a05690c448100b005cbbc6b3439mr668994ywb.10.1701242888599; Tue, 28
 Nov 2023 23:28:08 -0800 (PST)
Date: Wed, 29 Nov 2023 07:27:56 +0000
In-Reply-To: <20231129072756.3684495-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129072756.3684495-6-lixiaoyan@google.com>
Subject: [PATCH v8 net-next 5/5] tcp: reorganize tcp_sock fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

The variables are organized according in the following way:

- TX read-mostly hotpath cache lines
- TXRX read-mostly hotpath cache lines
- RX read-mostly hotpath cache lines
- TX read-write hotpath cache line
- TXRX read-write hotpath cache line
- RX read-write hotpath cache line

Fastpath cachelines end after rcvq_space.

Cache line boundaries are enforced only between read-mostly and
read-write. That is, if read-mostly tx cachelines bleed into
read-mostly txrx cachelines, we do not care. We care about the
boundaries between read and write cachelines because we want
to prevent false sharing.

Fast path variables span cache lines before change: 12
Fast path variables span cache lines after change: 8

Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 include/linux/tcp.h | 248 ++++++++++++++++++++++++--------------------
 net/ipv4/tcp.c      |  93 +++++++++++++++++
 2 files changed, 227 insertions(+), 114 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 68f3d315d2e18..f55ec155f5b71 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -194,23 +194,121 @@ static inline bool tcp_rsk_used_ao(const struct request_sock *req)
 #define TCP_RMEM_TO_WIN_SCALE 8
 
 struct tcp_sock {
+	/* Cacheline organization can be found documented in
+	 * Documentation/networking/net_cachelines/tcp_sock.rst.
+	 * Please update the document when adding new fields.
+	 */
+
 	/* inet_connection_sock has to be the first member of tcp_sock */
 	struct inet_connection_sock	inet_conn;
-	u16	tcp_header_len;	/* Bytes of tcp header to send		*/
+
+	/* TX read-mostly hotpath cache lines */
+	__cacheline_group_begin(tcp_sock_read_tx);
+	/* timestamp of last sent data packet (for restart window) */
+	u32	max_window;	/* Maximal window ever seen from peer	*/
+	u32	rcv_ssthresh;	/* Current window clamp			*/
+	u32	reordering;	/* Packet reordering metric.		*/
+	u32	notsent_lowat;	/* TCP_NOTSENT_LOWAT */
 	u16	gso_segs;	/* Max number of segs per GSO packet	*/
+	/* from STCP, retrans queue hinting */
+	struct sk_buff *lost_skb_hint;
+	struct sk_buff *retransmit_skb_hint;
+	__cacheline_group_end(tcp_sock_read_tx);
+
+	/* TXRX read-mostly hotpath cache lines */
+	__cacheline_group_begin(tcp_sock_read_txrx);
+	u32	tsoffset;	/* timestamp offset */
+	u32	snd_wnd;	/* The window we expect to receive	*/
+	u32	mss_cache;	/* Cached effective mss, not including SACKS */
+	u32	snd_cwnd;	/* Sending congestion window		*/
+	u32	prr_out;	/* Total number of pkts sent during Recovery. */
+	u32	lost_out;	/* Lost packets			*/
+	u32	sacked_out;	/* SACK'd packets			*/
+	u16	tcp_header_len;	/* Bytes of tcp header to send		*/
+	u8	chrono_type : 2,	/* current chronograph type */
+		repair      : 1,
+		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
+		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
+	__cacheline_group_end(tcp_sock_read_txrx);
+
+	/* RX read-mostly hotpath cache lines */
+	__cacheline_group_begin(tcp_sock_read_rx);
+	u32	copied_seq;	/* Head of yet unread data */
+	u32	rcv_tstamp;	/* timestamp of last received ACK (for keepalives) */
+	u32	snd_wl1;	/* Sequence for window update		*/
+	u32	tlp_high_seq;	/* snd_nxt at the time of TLP */
+	u32	rttvar_us;	/* smoothed mdev_max			*/
+	u32	retrans_out;	/* Retransmitted packets out		*/
+	u16	advmss;		/* Advertised MSS			*/
+	u16	urg_data;	/* Saved octet of OOB data and control flags */
+	u32	lost;		/* Total data packets lost incl. rexmits */
+	struct  minmax rtt_min;
+	/* OOO segments go in this rbtree. Socket lock must be held. */
+	struct rb_root	out_of_order_queue;
+	u32	snd_ssthresh;	/* Slow start size threshold		*/
+	__cacheline_group_end(tcp_sock_read_rx);
 
+	/* TX read-write hotpath cache lines */
+	__cacheline_group_begin(tcp_sock_write_tx) ____cacheline_aligned;
+	u32	segs_out;	/* RFC4898 tcpEStatsPerfSegsOut
+				 * The total number of segments sent.
+				 */
+	u32	data_segs_out;	/* RFC4898 tcpEStatsPerfDataSegsOut
+				 * total number of data segments sent.
+				 */
+	u64	bytes_sent;	/* RFC4898 tcpEStatsPerfHCDataOctetsOut
+				 * total number of data bytes sent.
+				 */
+	u32	snd_sml;	/* Last byte of the most recently transmitted small packet */
+	u32	chrono_start;	/* Start time in jiffies of a TCP chrono */
+	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
+	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
+	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
+	u32	lsndtime;
+	u32	mdev_us;	/* medium deviation			*/
+	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
+	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
+	u64	tcp_mstamp;	/* most recent packet received/sent */
+	u32	rtt_seq;	/* sequence number to update rttvar	*/
+	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
+	struct sk_buff *highest_sack;   /* skb just after the highest
+					 * skb with SACKed bit set
+					 * (validity guaranteed only if
+					 * sacked_out > 0)
+					 */
+	u8	ecn_flags;	/* ECN status bits.			*/
+	__cacheline_group_end(tcp_sock_write_tx);
+
+	/* TXRX read-write hotpath cache lines */
+	__cacheline_group_begin(tcp_sock_write_txrx);
 /*
  *	Header prediction flags
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
 	__be32	pred_flags;
-
+	u32	rcv_nxt;	/* What we want to receive next		*/
+	u32	snd_nxt;	/* Next sequence we send		*/
+	u32	snd_una;	/* First byte we want an ack for	*/
+	u32	window_clamp;	/* Maximal window to advertise		*/
+	u32	srtt_us;	/* smoothed round trip time << 3 in usecs */
+	u32	packets_out;	/* Packets which are "in flight"	*/
+	u32	snd_up;		/* Urgent pointer		*/
+	u32	delivered;	/* Total data packets delivered incl. rexmits */
+	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	app_limited;	/* limited until "delivered" reaches this val */
+	u32	rcv_wnd;	/* Current receiver window		*/
 /*
- *	RFC793 variables by their proper names. This means you can
- *	read the code and the spec side by side (and laugh ...)
- *	See RFC793 and RFC1122. The RFC writes these in capitals.
+ *      Options received (usually on last packet, some only on SYN packets).
  */
-	u64	bytes_received;	/* RFC4898 tcpEStatsAppHCThruOctetsReceived
+	struct tcp_options_received rx_opt;
+	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
+		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
+	__cacheline_group_end(tcp_sock_write_txrx);
+
+	/* RX read-write hotpath cache lines */
+	__cacheline_group_begin(tcp_sock_write_rx);
+	u64	bytes_received;
+				/* RFC4898 tcpEStatsAppHCThruOctetsReceived
 				 * sum(delta(rcv_nxt)), or how many bytes
 				 * were acked.
 				 */
@@ -220,45 +318,44 @@ struct tcp_sock {
 	u32	data_segs_in;	/* RFC4898 tcpEStatsPerfDataSegsIn
 				 * total number of data segments in.
 				 */
- 	u32	rcv_nxt;	/* What we want to receive next 	*/
-	u32	copied_seq;	/* Head of yet unread data		*/
 	u32	rcv_wup;	/* rcv_nxt on last window update sent	*/
- 	u32	snd_nxt;	/* Next sequence we send		*/
-	u32	segs_out;	/* RFC4898 tcpEStatsPerfSegsOut
-				 * The total number of segments sent.
-				 */
-	u32	data_segs_out;	/* RFC4898 tcpEStatsPerfDataSegsOut
-				 * total number of data segments sent.
-				 */
-	u64	bytes_sent;	/* RFC4898 tcpEStatsPerfHCDataOctetsOut
-				 * total number of data bytes sent.
-				 */
+	u32	max_packets_out;  /* max packets_out in last window */
+	u32	cwnd_usage_seq;  /* right edge of cwnd usage tracking flight */
+	u32	rate_delivered;    /* saved rate sample: packets delivered */
+	u32	rate_interval_us;  /* saved rate sample: time elapsed */
+	u32	rcv_rtt_last_tsecr;
+	u64	first_tx_mstamp;  /* start of window send phase */
+	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
 				 * sum(delta(snd_una)), or how many bytes
 				 * were acked.
 				 */
+	struct {
+		u32	rtt_us;
+		u32	seq;
+		u64	time;
+	} rcv_rtt_est;
+/* Receiver queue space */
+	struct {
+		u32	space;
+		u32	seq;
+		u64	time;
+	} rcvq_space;
+	__cacheline_group_end(tcp_sock_write_rx);
+	/* End of Hot Path */
+
+/*
+ *	RFC793 variables by their proper names. This means you can
+ *	read the code and the spec side by side (and laugh ...)
+ *	See RFC793 and RFC1122. The RFC writes these in capitals.
+ */
 	u32	dsack_dups;	/* RFC4898 tcpEStatsStackDSACKDups
 				 * total number of DSACK blocks received
 				 */
- 	u32	snd_una;	/* First byte we want an ack for	*/
- 	u32	snd_sml;	/* Last byte of the most recently transmitted small packet */
-	u32	rcv_tstamp;	/* timestamp of last received ACK (for keepalives) */
-	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
 	u32	last_oow_ack_time;  /* timestamp of last out-of-window ACK */
 	u32	compressed_ack_rcv_nxt;
-
-	u32	tsoffset;	/* timestamp offset */
-
 	struct list_head tsq_node; /* anchor in tsq_tasklet.head list */
-	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
-
-	u32	snd_wl1;	/* Sequence for window update		*/
-	u32	snd_wnd;	/* The window we expect to receive	*/
-	u32	max_window;	/* Maximal window ever seen from peer	*/
-	u32	mss_cache;	/* Cached effective mss, not including SACKS */
 
-	u32	window_clamp;	/* Maximal window to advertise		*/
-	u32	rcv_ssthresh;	/* Current window clamp			*/
 	u8	scaling_ratio;	/* see tcp_win_from_space() */
 	/* Information of the most recently (s)acked skb */
 	struct tcp_rack {
@@ -272,24 +369,16 @@ struct tcp_sock {
 		   dsack_seen:1, /* Whether DSACK seen after last adj */
 		   advanced:1;	 /* mstamp advanced since last lost marking */
 	} rack;
-	u16	advmss;		/* Advertised MSS			*/
 	u8	compressed_ack;
 	u8	dup_ack_counter:2,
 		tlp_retrans:1,	/* TLP is a retransmission */
 		tcp_usec_ts:1, /* TSval values in usec */
 		unused:4;
-	u32	chrono_start;	/* Start time in jiffies of a TCP chrono */
-	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
-	u8	chrono_type:2,	/* current chronograph type */
-		rate_app_limited:1,  /* rate_{delivered,interval_us} limited? */
+	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
+		recvmsg_inq : 1,/* Indicate # of bytes in queue upon recvmsg */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
-		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
-		fastopen_client_fail:2; /* reason why fastopen failed */
-	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
-		thin_lto    : 1,/* Use linear timeouts for thin streams */
-		recvmsg_inq : 1,/* Indicate # of bytes in queue upon recvmsg */
-		repair      : 1,
+		fastopen_client_fail:2, /* reason why fastopen failed */
 		frto        : 1;/* F-RTO (RFC5682) activated in CA_Loss */
 	u8	repair_queue;
 	u8	save_syn:2,	/* Save headers of SYN packet */
@@ -297,45 +386,19 @@ struct tcp_sock {
 		syn_fastopen:1,	/* SYN includes Fast Open option */
 		syn_fastopen_exp:1,/* SYN includes Fast Open exp. option */
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
-		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
-		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
-	u32	tlp_high_seq;	/* snd_nxt at the time of TLP */
+		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
 
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
-	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
-	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 
 /* RTT measurement */
-	u64	tcp_mstamp;	/* most recent packet received/sent */
-	u32	srtt_us;	/* smoothed round trip time << 3 in usecs */
-	u32	mdev_us;	/* medium deviation			*/
 	u32	mdev_max_us;	/* maximal mdev for the last rtt period	*/
-	u32	rttvar_us;	/* smoothed mdev_max			*/
-	u32	rtt_seq;	/* sequence number to update rttvar	*/
-	struct  minmax rtt_min;
 
-	u32	packets_out;	/* Packets which are "in flight"	*/
-	u32	retrans_out;	/* Retransmitted packets out		*/
-	u32	max_packets_out;  /* max packets_out in last window */
-	u32	cwnd_usage_seq;  /* right edge of cwnd usage tracking flight */
-
-	u16	urg_data;	/* Saved octet of OOB data and control flags */
-	u8	ecn_flags;	/* ECN status bits.			*/
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
-	u32	reordering;	/* Packet reordering metric.		*/
 	u32	reord_seen;	/* number of data packet reordering events */
-	u32	snd_up;		/* Urgent pointer		*/
-
-/*
- *      Options received (usually on last packet, some only on SYN packets).
- */
-	struct tcp_options_received rx_opt;
 
 /*
  *	Slow start and congestion control (see also Nagle, and Karn & Partridge)
  */
- 	u32	snd_ssthresh;	/* Slow start size threshold		*/
- 	u32	snd_cwnd;	/* Sending congestion window		*/
 	u32	snd_cwnd_cnt;	/* Linear increase counter		*/
 	u32	snd_cwnd_clamp; /* Do not allow snd_cwnd to grow above this */
 	u32	snd_cwnd_used;
@@ -343,32 +406,10 @@ struct tcp_sock {
 	u32	prior_cwnd;	/* cwnd right before starting loss recovery */
 	u32	prr_delivered;	/* Number of newly delivered packets to
 				 * receiver in Recovery. */
-	u32	prr_out;	/* Total number of pkts sent during Recovery. */
-	u32	delivered;	/* Total data packets delivered incl. rexmits */
-	u32	delivered_ce;	/* Like the above but only ECE marked packets */
-	u32	lost;		/* Total data packets lost incl. rexmits */
-	u32	app_limited;	/* limited until "delivered" reaches this val */
-	u64	first_tx_mstamp;  /* start of window send phase */
-	u64	delivered_mstamp; /* time we reached "delivered" */
-	u32	rate_delivered;    /* saved rate sample: packets delivered */
-	u32	rate_interval_us;  /* saved rate sample: time elapsed */
-
- 	u32	rcv_wnd;	/* Current receiver window		*/
-	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
-	u32	notsent_lowat;	/* TCP_NOTSENT_LOWAT */
-	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
-	u32	lost_out;	/* Lost packets			*/
-	u32	sacked_out;	/* SACK'd packets			*/
 
 	struct hrtimer	pacing_timer;
 	struct hrtimer	compressed_ack_timer;
 
-	/* from STCP, retrans queue hinting */
-	struct sk_buff* lost_skb_hint;
-	struct sk_buff *retransmit_skb_hint;
-
-	/* OOO segments go in this rbtree. Socket lock must be held. */
-	struct rb_root	out_of_order_queue;
 	struct sk_buff	*ooo_last_skb; /* cache rb_last(out_of_order_queue) */
 
 	/* SACKs data, these 2 need to be together (see tcp_options_write) */
@@ -377,12 +418,6 @@ struct tcp_sock {
 
 	struct tcp_sack_block recv_sack_cache[4];
 
-	struct sk_buff *highest_sack;   /* skb just after the highest
-					 * skb with SACKed bit set
-					 * (validity guaranteed only if
-					 * sacked_out > 0)
-					 */
-
 	int     lost_cnt_hint;
 
 	u32	prior_ssthresh; /* ssthresh saved at recovery start	*/
@@ -433,21 +468,6 @@ struct tcp_sock {
 
 	u32 rcv_ooopack; /* Received out-of-order packets, for tcpinfo */
 
-/* Receiver side RTT estimation */
-	u32 rcv_rtt_last_tsecr;
-	struct {
-		u32	rtt_us;
-		u32	seq;
-		u64	time;
-	} rcv_rtt_est;
-
-/* Receiver queue space */
-	struct {
-		u32	space;
-		u32	seq;
-		u64	time;
-	} rcvq_space;
-
 /* TCP-specific MTU probe information. */
 	struct {
 		u32		  probe_seq_start;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4c..44c745307bc21 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4563,6 +4563,97 @@ static void __init tcp_init_mem(void)
 	sysctl_tcp_mem[2] = sysctl_tcp_mem[0] * 2;	/* 9.37 % */
 }
 
+static void __init tcp_struct_check(void)
+{
+	/* TX read-mostly hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, max_window);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, rcv_ssthresh);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, reordering);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, notsent_lowat);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, gso_segs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, lost_skb_hint);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, retransmit_skb_hint);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_tx, 40);
+
+	/* TXRX read-mostly hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, tsoffset);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, snd_wnd);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, mss_cache);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, snd_cwnd);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, prr_out);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, lost_out);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, sacked_out);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_txrx, 31);
+
+	/* RX read-mostly hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, copied_seq);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rcv_tstamp);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_wl1);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, tlp_high_seq);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rttvar_us);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, retrans_out);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, advmss);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, urg_data);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, lost);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rtt_min);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, out_of_order_queue);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_ssthresh);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 69);
+
+	/* TX read-write hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, segs_out);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, data_segs_out);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, bytes_sent);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, snd_sml);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, chrono_start);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, chrono_stat);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, write_seq);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, pushed_seq);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, lsndtime);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, mdev_us);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_wstamp_ns);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_clock_cache);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_mstamp);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rtt_seq);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 113);
+
+	/* TXRX read-write hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_nxt);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_nxt);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_una);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, window_clamp);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, srtt_us);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, packets_out);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 76);
+
+	/* RX read-write hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, segs_in);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, data_segs_in);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_wup);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, max_packets_out);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, cwnd_usage_seq);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_delivered);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+}
+
 void __init tcp_init(void)
 {
 	int max_rshare, max_wshare, cnt;
@@ -4573,6 +4664,8 @@ void __init tcp_init(void)
 	BUILD_BUG_ON(sizeof(struct tcp_skb_cb) >
 		     sizeof_field(struct sk_buff, cb));
 
+	tcp_struct_check();
+
 	percpu_counter_init(&tcp_sockets_allocated, 0, GFP_KERNEL);
 
 	timer_setup(&tcp_orphan_timer, tcp_orphan_update, TIMER_DEFERRABLE);
-- 
2.43.0.rc1.413.gea7ed67945-goog


