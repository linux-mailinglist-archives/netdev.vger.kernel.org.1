Return-Path: <netdev+bounces-21867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A182E7651CF
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48331C2158F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806815AEC;
	Thu, 27 Jul 2023 10:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D276315AE3
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:25 +0000 (UTC)
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38AD32125
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:22 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id 5D4ED321ACB;
	Thu, 27 Jul 2023 11:41:05 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyQb-0002Xx-5u;
	Thu, 27 Jul 2023 11:41:05 +0100
Subject: [PATCH net-next 05/11] sfc: Remove PTP code for Siena
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:41:05 +0100
Message-ID: <169045446506.9625.17354309370418192215.stgit@palantir17.mph.net>
In-Reply-To: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
References: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FROM,KHOP_HELO_FCRDNS,MAY_BE_FORGED,
	NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

rx_tx_inline is now always true.
The special event list is no longer needed, event handling is always
inline.
Event MCDI_EVENT_CODE_PTP_RX is no longer needed.

Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mcdi.c |    1 
 drivers/net/ethernet/sfc/ptp.c  |  226 ---------------------------------------
 2 files changed, 1 insertion(+), 226 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index 86cfd4713b11..f7ffaa14fda4 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -1357,7 +1357,6 @@ void efx_mcdi_process_event(struct efx_channel *channel,
 			efx->type->sriov_flr(efx,
 					     MCDI_EVENT_FIELD(*event, FLR_VF));
 		break;
-	case MCDI_EVENT_CODE_PTP_RX:
 	case MCDI_EVENT_CODE_PTP_FAULT:
 	case MCDI_EVENT_CODE_PTP_PPS:
 		efx_ptp_event(efx, event);
diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 9c17cd24c549..3eab1802f6b0 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -86,9 +86,6 @@
 #define PTP_V1_VERSION_LENGTH	2
 #define PTP_V1_VERSION_OFFSET	28
 
-#define PTP_V1_UUID_LENGTH	6
-#define PTP_V1_UUID_OFFSET	50
-
 #define PTP_V1_SEQUENCE_LENGTH	2
 #define PTP_V1_SEQUENCE_OFFSET	58
 
@@ -100,17 +97,6 @@
 #define PTP_V2_VERSION_LENGTH	1
 #define PTP_V2_VERSION_OFFSET	29
 
-#define PTP_V2_UUID_LENGTH	8
-#define PTP_V2_UUID_OFFSET	48
-
-/* Although PTP V2 UUIDs are comprised a ClockIdentity (8) and PortNumber (2),
- * the MC only captures the last six bytes of the clock identity. These values
- * reflect those, not the ones used in the standard.  The standard permits
- * mapping of V1 UUIDs to V2 UUIDs with these same values.
- */
-#define PTP_V2_MC_UUID_LENGTH	6
-#define PTP_V2_MC_UUID_OFFSET	50
-
 #define PTP_V2_SEQUENCE_LENGTH	2
 #define PTP_V2_SEQUENCE_OFFSET	58
 
@@ -166,14 +152,12 @@ enum ptp_packet_state {
 
 /**
  * struct efx_ptp_match - Matching structure, stored in sk_buff's cb area.
- * @words: UUID and (partial) sequence number
  * @expiry: Time after which the packet should be delivered irrespective of
  *            event arrival.
  * @state: The state of the packet - whether it is ready for processing or
  *         whether that is of no interest.
  */
 struct efx_ptp_match {
-	u32 words[DIV_ROUND_UP(PTP_V1_UUID_LENGTH, 4)];
 	unsigned long expiry;
 	enum ptp_packet_state state;
 };
@@ -235,15 +219,9 @@ struct efx_ptp_rxfilter {
 /**
  * struct efx_ptp_data - Precision Time Protocol (PTP) state
  * @efx: The NIC context
- * @channel: The PTP channel (Siena only)
- * @rx_ts_inline: Flag for whether RX timestamps are inline (else they are
- *	separate events)
+ * @channel: The PTP channel (for Medford and Medford2)
  * @rxq: Receive SKB queue (awaiting timestamps)
  * @txq: Transmit SKB queue
- * @evt_list: List of MC receive events awaiting packets
- * @evt_free_list: List of free events
- * @evt_lock: Lock for manipulating evt_list and evt_free_list
- * @rx_evts: Instantiated events (on evt_list and evt_free_list)
  * @workwq: Work queue for processing pending PTP operations
  * @work: Work task
  * @cleanup_work: Work task for periodic cleanup
@@ -309,13 +287,8 @@ struct efx_ptp_rxfilter {
 struct efx_ptp_data {
 	struct efx_nic *efx;
 	struct efx_channel *channel;
-	bool rx_ts_inline;
 	struct sk_buff_head rxq;
 	struct sk_buff_head txq;
-	struct list_head evt_list;
-	struct list_head evt_free_list;
-	spinlock_t evt_lock;
-	struct efx_ptp_event_rx rx_evts[MAX_RECEIVE_EVENTS];
 	struct workqueue_struct *workwq;
 	struct work_struct work;
 	struct delayed_work cleanup_work;
@@ -464,25 +437,6 @@ size_t efx_ptp_update_stats(struct efx_nic *efx, u64 *stats)
 	return PTP_STAT_COUNT;
 }
 
-/* For Siena platforms NIC time is s and ns */
-static void efx_ptp_ns_to_s_ns(s64 ns, u32 *nic_major, u32 *nic_minor)
-{
-	struct timespec64 ts = ns_to_timespec64(ns);
-	*nic_major = (u32)ts.tv_sec;
-	*nic_minor = ts.tv_nsec;
-}
-
-static ktime_t efx_ptp_s_ns_to_ktime_correction(u32 nic_major, u32 nic_minor,
-						s32 correction)
-{
-	ktime_t kt = ktime_set(nic_major, nic_minor);
-	if (correction >= 0)
-		kt = ktime_add_ns(kt, (u64)correction);
-	else
-		kt = ktime_sub_ns(kt, (u64)-correction);
-	return kt;
-}
-
 /* To convert from s27 format to ns we multiply then divide by a power of 2.
  * For the conversion from ns to s27, the operation is also converted to a
  * multiply and shift.
@@ -696,12 +650,6 @@ static int efx_ptp_get_attributes(struct efx_nic *efx)
 		ptp->nic_time.minor_max = 1 << 27;
 		ptp->nic_time.sync_event_minor_shift = 19;
 		break;
-	case MC_CMD_PTP_OUT_GET_ATTRIBUTES_SECONDS_NANOSECONDS:
-		ptp->ns_to_nic_time = efx_ptp_ns_to_s_ns;
-		ptp->nic_to_kernel_time = efx_ptp_s_ns_to_ktime_correction;
-		ptp->nic_time.minor_max = 1000000000;
-		ptp->nic_time.sync_event_minor_shift = 22;
-		break;
 	case MC_CMD_PTP_OUT_GET_ATTRIBUTES_SECONDS_QTR_NANOSECONDS:
 		ptp->ns_to_nic_time = efx_ptp_ns_to_s_qns;
 		ptp->nic_to_kernel_time = efx_ptp_s_qns_to_ktime_correction;
@@ -1216,76 +1164,6 @@ static void efx_ptp_xmit_skb_mc(struct efx_nic *efx, struct sk_buff *skb)
 	return;
 }
 
-static void efx_ptp_drop_time_expired_events(struct efx_nic *efx)
-{
-	struct efx_ptp_data *ptp = efx->ptp_data;
-	struct list_head *cursor;
-	struct list_head *next;
-
-	if (ptp->rx_ts_inline)
-		return;
-
-	/* Drop time-expired events */
-	spin_lock_bh(&ptp->evt_lock);
-	list_for_each_safe(cursor, next, &ptp->evt_list) {
-		struct efx_ptp_event_rx *evt;
-
-		evt = list_entry(cursor, struct efx_ptp_event_rx,
-				 link);
-		if (time_after(jiffies, evt->expiry)) {
-			list_move(&evt->link, &ptp->evt_free_list);
-			netif_warn(efx, hw, efx->net_dev,
-				   "PTP rx event dropped\n");
-		}
-	}
-	spin_unlock_bh(&ptp->evt_lock);
-}
-
-static enum ptp_packet_state efx_ptp_match_rx(struct efx_nic *efx,
-					      struct sk_buff *skb)
-{
-	struct efx_ptp_data *ptp = efx->ptp_data;
-	bool evts_waiting;
-	struct list_head *cursor;
-	struct list_head *next;
-	struct efx_ptp_match *match;
-	enum ptp_packet_state rc = PTP_PACKET_STATE_UNMATCHED;
-
-	WARN_ON_ONCE(ptp->rx_ts_inline);
-
-	spin_lock_bh(&ptp->evt_lock);
-	evts_waiting = !list_empty(&ptp->evt_list);
-	spin_unlock_bh(&ptp->evt_lock);
-
-	if (!evts_waiting)
-		return PTP_PACKET_STATE_UNMATCHED;
-
-	match = (struct efx_ptp_match *)skb->cb;
-	/* Look for a matching timestamp in the event queue */
-	spin_lock_bh(&ptp->evt_lock);
-	list_for_each_safe(cursor, next, &ptp->evt_list) {
-		struct efx_ptp_event_rx *evt;
-
-		evt = list_entry(cursor, struct efx_ptp_event_rx, link);
-		if ((evt->seq0 == match->words[0]) &&
-		    (evt->seq1 == match->words[1])) {
-			struct skb_shared_hwtstamps *timestamps;
-
-			/* Match - add in hardware timestamp */
-			timestamps = skb_hwtstamps(skb);
-			timestamps->hwtstamp = evt->hwtimestamp;
-
-			match->state = PTP_PACKET_STATE_MATCHED;
-			rc = PTP_PACKET_STATE_MATCHED;
-			list_move(&evt->link, &ptp->evt_free_list);
-			break;
-		}
-	}
-	spin_unlock_bh(&ptp->evt_lock);
-
-	return rc;
-}
-
 /* Process any queued receive events and corresponding packets
  *
  * q is returned with all the packets that are ready for delivery.
@@ -1301,9 +1179,6 @@ static void efx_ptp_process_events(struct efx_nic *efx, struct sk_buff_head *q)
 		match = (struct efx_ptp_match *)skb->cb;
 		if (match->state == PTP_PACKET_STATE_MATCH_UNWANTED) {
 			__skb_queue_tail(q, skb);
-		} else if (efx_ptp_match_rx(efx, skb) ==
-			   PTP_PACKET_STATE_MATCHED) {
-			__skb_queue_tail(q, skb);
 		} else if (time_after(jiffies, match->expiry)) {
 			match->state = PTP_PACKET_STATE_TIMED_OUT;
 			++ptp->rx_no_timestamp;
@@ -1580,8 +1455,6 @@ static int efx_ptp_start(struct efx_nic *efx)
 static int efx_ptp_stop(struct efx_nic *efx)
 {
 	struct efx_ptp_data *ptp = efx->ptp_data;
-	struct list_head *cursor;
-	struct list_head *next;
 	int rc;
 
 	if (ptp == NULL)
@@ -1596,13 +1469,6 @@ static int efx_ptp_stop(struct efx_nic *efx)
 	efx_ptp_deliver_rx_queue(&efx->ptp_data->rxq);
 	skb_queue_purge(&efx->ptp_data->txq);
 
-	/* Drop any pending receive events */
-	spin_lock_bh(&efx->ptp_data->evt_lock);
-	list_for_each_safe(cursor, next, &efx->ptp_data->evt_list) {
-		list_move(cursor, &efx->ptp_data->evt_free_list);
-	}
-	spin_unlock_bh(&efx->ptp_data->evt_lock);
-
 	return rc;
 }
 
@@ -1642,8 +1508,6 @@ static void efx_ptp_worker(struct work_struct *work)
 		return;
 	}
 
-	efx_ptp_drop_time_expired_events(efx);
-
 	__skb_queue_head_init(&tempq);
 	efx_ptp_process_events(efx, &tempq);
 
@@ -1692,7 +1556,6 @@ int efx_ptp_probe(struct efx_nic *efx, struct efx_channel *channel)
 {
 	struct efx_ptp_data *ptp;
 	int rc = 0;
-	unsigned int pos;
 
 	if (efx->ptp_data) {
 		efx->ptp_data->channel = channel;
@@ -1706,7 +1569,6 @@ int efx_ptp_probe(struct efx_nic *efx, struct efx_channel *channel)
 
 	ptp->efx = efx;
 	ptp->channel = channel;
-	ptp->rx_ts_inline = efx_nic_rev(efx) >= EFX_REV_HUNT_A0;
 
 	rc = efx_nic_alloc_buffer(efx, &ptp->start, sizeof(int), GFP_KERNEL);
 	if (rc != 0)
@@ -1733,12 +1595,6 @@ int efx_ptp_probe(struct efx_nic *efx, struct efx_channel *channel)
 	ptp->config.flags = 0;
 	ptp->config.tx_type = HWTSTAMP_TX_OFF;
 	ptp->config.rx_filter = HWTSTAMP_FILTER_NONE;
-	INIT_LIST_HEAD(&ptp->evt_list);
-	INIT_LIST_HEAD(&ptp->evt_free_list);
-	spin_lock_init(&ptp->evt_lock);
-	for (pos = 0; pos < MAX_RECEIVE_EVENTS; pos++)
-		list_add(&ptp->rx_evts[pos].link, &ptp->evt_free_list);
-
 	INIT_LIST_HEAD(&ptp->rxfilters_mcast);
 	INIT_LIST_HEAD(&ptp->rxfilters_ucast);
 
@@ -1878,7 +1734,6 @@ static bool efx_ptp_rx(struct efx_channel *channel, struct sk_buff *skb)
 	struct efx_nic *efx = channel->efx;
 	struct efx_ptp_data *ptp = efx->ptp_data;
 	struct efx_ptp_match *match = (struct efx_ptp_match *)skb->cb;
-	u8 *match_data_012, *match_data_345;
 	unsigned int version;
 	u8 *data;
 
@@ -1894,12 +1749,6 @@ static bool efx_ptp_rx(struct efx_channel *channel, struct sk_buff *skb)
 		if (version != PTP_VERSION_V1) {
 			return false;
 		}
-
-		/* PTP V1 uses all six bytes of the UUID to match the packet
-		 * to the timestamp
-		 */
-		match_data_012 = data + PTP_V1_UUID_OFFSET;
-		match_data_345 = data + PTP_V1_UUID_OFFSET + 3;
 	} else {
 		if (!pskb_may_pull(skb, PTP_V2_MIN_LENGTH)) {
 			return false;
@@ -1909,21 +1758,6 @@ static bool efx_ptp_rx(struct efx_channel *channel, struct sk_buff *skb)
 		if ((version & PTP_VERSION_V2_MASK) != PTP_VERSION_V2) {
 			return false;
 		}
-
-		/* The original V2 implementation uses bytes 2-7 of
-		 * the UUID to match the packet to the timestamp. This
-		 * discards two of the bytes of the MAC address used
-		 * to create the UUID (SF bug 33070).  The PTP V2
-		 * enhanced mode fixes this issue and uses bytes 0-2
-		 * and byte 5-7 of the UUID.
-		 */
-		match_data_345 = data + PTP_V2_UUID_OFFSET + 5;
-		if (ptp->mode == MC_CMD_PTP_MODE_V2) {
-			match_data_012 = data + PTP_V2_UUID_OFFSET + 2;
-		} else {
-			match_data_012 = data + PTP_V2_UUID_OFFSET + 0;
-			BUG_ON(ptp->mode != MC_CMD_PTP_MODE_V2_ENHANCED);
-		}
 	}
 
 	/* Does this packet require timestamping? */
@@ -1935,17 +1769,6 @@ static bool efx_ptp_rx(struct efx_channel *channel, struct sk_buff *skb)
 		 */
 		BUILD_BUG_ON(PTP_V1_SEQUENCE_OFFSET != PTP_V2_SEQUENCE_OFFSET);
 		BUILD_BUG_ON(PTP_V1_SEQUENCE_LENGTH != PTP_V2_SEQUENCE_LENGTH);
-
-		/* Extract UUID/Sequence information */
-		match->words[0] = (match_data_012[0]         |
-				   (match_data_012[1] << 8)  |
-				   (match_data_012[2] << 16) |
-				   (match_data_345[0] << 24));
-		match->words[1] = (match_data_345[1]         |
-				   (match_data_345[2] << 8)  |
-				   (data[PTP_V1_SEQUENCE_OFFSET +
-					 PTP_V1_SEQUENCE_LENGTH - 1] <<
-				    16));
 	} else {
 		match->state = PTP_PACKET_STATE_MATCH_UNWANTED;
 	}
@@ -2109,50 +1932,6 @@ static void ptp_event_failure(struct efx_nic *efx, int expected_frag_len)
 	queue_work(ptp->workwq, &ptp->work);
 }
 
-/* Process a completed receive event.  Put it on the event queue and
- * start worker thread.  This is required because event and their
- * correspoding packets may come in either order.
- */
-static void ptp_event_rx(struct efx_nic *efx, struct efx_ptp_data *ptp)
-{
-	struct efx_ptp_event_rx *evt = NULL;
-
-	if (WARN_ON_ONCE(ptp->rx_ts_inline))
-		return;
-
-	if (ptp->evt_frag_idx != 3) {
-		ptp_event_failure(efx, 3);
-		return;
-	}
-
-	spin_lock_bh(&ptp->evt_lock);
-	if (!list_empty(&ptp->evt_free_list)) {
-		evt = list_first_entry(&ptp->evt_free_list,
-				       struct efx_ptp_event_rx, link);
-		list_del(&evt->link);
-
-		evt->seq0 = EFX_QWORD_FIELD(ptp->evt_frags[2], MCDI_EVENT_DATA);
-		evt->seq1 = (EFX_QWORD_FIELD(ptp->evt_frags[2],
-					     MCDI_EVENT_SRC)        |
-			     (EFX_QWORD_FIELD(ptp->evt_frags[1],
-					      MCDI_EVENT_SRC) << 8) |
-			     (EFX_QWORD_FIELD(ptp->evt_frags[0],
-					      MCDI_EVENT_SRC) << 16));
-		evt->hwtimestamp = efx->ptp_data->nic_to_kernel_time(
-			EFX_QWORD_FIELD(ptp->evt_frags[0], MCDI_EVENT_DATA),
-			EFX_QWORD_FIELD(ptp->evt_frags[1], MCDI_EVENT_DATA),
-			ptp->ts_corrections.ptp_rx);
-		evt->expiry = jiffies + msecs_to_jiffies(PKT_EVENT_LIFETIME_MS);
-		list_add_tail(&evt->link, &ptp->evt_list);
-
-		queue_work(ptp->workwq, &ptp->work);
-	} else if (net_ratelimit()) {
-		/* Log a rate-limited warning message. */
-		netif_err(efx, rx_err, efx->net_dev, "PTP event queue overflow\n");
-	}
-	spin_unlock_bh(&ptp->evt_lock);
-}
-
 static void ptp_event_fault(struct efx_nic *efx, struct efx_ptp_data *ptp)
 {
 	int code = EFX_QWORD_FIELD(ptp->evt_frags[0], MCDI_EVENT_DATA);
@@ -2199,9 +1978,6 @@ void efx_ptp_event(struct efx_nic *efx, efx_qword_t *ev)
 	if (!MCDI_EVENT_FIELD(*ev, CONT)) {
 		/* Process resulting event */
 		switch (code) {
-		case MCDI_EVENT_CODE_PTP_RX:
-			ptp_event_rx(efx, ptp);
-			break;
 		case MCDI_EVENT_CODE_PTP_FAULT:
 			ptp_event_fault(efx, ptp);
 			break;



