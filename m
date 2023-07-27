Return-Path: <netdev+bounces-21871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC27651D5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE232810CB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28199168B5;
	Thu, 27 Jul 2023 10:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDE168A1
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:28 +0000 (UTC)
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A09331FEC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:25 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id 9CB5A321B87;
	Thu, 27 Jul 2023 11:41:37 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyR7-0002Yx-Dr;
	Thu, 27 Jul 2023 11:41:37 +0100
Subject: [PATCH net-next 11/11] sfc: Remove vfdi.h
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:41:37 +0100
Message-ID: <169045449733.9625.3985648080399297308.stgit@palantir17.mph.net>
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

It was only used for Siena SRIOV, so nothing includes it any more
in this directory.

Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/vfdi.h |  252 ---------------------------------------
 1 file changed, 252 deletions(-)
 delete mode 100644 drivers/net/ethernet/sfc/vfdi.h

diff --git a/drivers/net/ethernet/sfc/vfdi.h b/drivers/net/ethernet/sfc/vfdi.h
deleted file mode 100644
index 480b872eb4d1..000000000000
--- a/drivers/net/ethernet/sfc/vfdi.h
+++ /dev/null
@@ -1,252 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/****************************************************************************
- * Driver for Solarflare network controllers and boards
- * Copyright 2010-2012 Solarflare Communications Inc.
- */
-#ifndef _VFDI_H
-#define _VFDI_H
-
-/**
- * DOC: Virtual Function Driver Interface
- *
- * This file contains software structures used to form a two way
- * communication channel between the VF driver and the PF driver,
- * named Virtual Function Driver Interface (VFDI).
- *
- * For the purposes of VFDI, a page is a memory region with size and
- * alignment of 4K.  All addresses are DMA addresses to be used within
- * the domain of the relevant VF.
- *
- * The only hardware-defined channels for a VF driver to communicate
- * with the PF driver are the event mailboxes (%FR_CZ_USR_EV
- * registers).  Writing to these registers generates an event with
- * EV_CODE = EV_CODE_USR_EV, USER_QID set to the index of the mailbox
- * and USER_EV_REG_VALUE set to the value written.  The PF driver may
- * direct or disable delivery of these events by setting
- * %FR_CZ_USR_EV_CFG.
- *
- * The PF driver can send arbitrary events to arbitrary event queues.
- * However, for consistency, VFDI events from the PF are defined to
- * follow the same form and be sent to the first event queue assigned
- * to the VF while that queue is enabled by the VF driver.
- *
- * The general form of the variable bits of VFDI events is:
- *
- *       0             16                       24   31
- *      | DATA        | TYPE                   | SEQ   |
- *
- * SEQ is a sequence number which should be incremented by 1 (modulo
- * 256) for each event.  The sequence numbers used in each direction
- * are independent.
- *
- * The VF submits requests of type &struct vfdi_req by sending the
- * address of the request (ADDR) in a series of 4 events:
- *
- *       0             16                       24   31
- *      | ADDR[0:15]  | VFDI_EV_TYPE_REQ_WORD0 | SEQ   |
- *      | ADDR[16:31] | VFDI_EV_TYPE_REQ_WORD1 | SEQ+1 |
- *      | ADDR[32:47] | VFDI_EV_TYPE_REQ_WORD2 | SEQ+2 |
- *      | ADDR[48:63] | VFDI_EV_TYPE_REQ_WORD3 | SEQ+3 |
- *
- * The address must be page-aligned.  After receiving such a valid
- * series of events, the PF driver will attempt to read the request
- * and write a response to the same address.  In case of an invalid
- * sequence of events or a DMA error, there will be no response.
- *
- * The VF driver may request that the PF driver writes status
- * information into its domain asynchronously.  After writing the
- * status, the PF driver will send an event of the form:
- *
- *       0             16                       24   31
- *      | reserved    | VFDI_EV_TYPE_STATUS    | SEQ   |
- *
- * In case the VF must be reset for any reason, the PF driver will
- * send an event of the form:
- *
- *       0             16                       24   31
- *      | reserved    | VFDI_EV_TYPE_RESET     | SEQ   |
- *
- * It is then the responsibility of the VF driver to request
- * reinitialisation of its queues.
- */
-#define VFDI_EV_SEQ_LBN 24
-#define VFDI_EV_SEQ_WIDTH 8
-#define VFDI_EV_TYPE_LBN 16
-#define VFDI_EV_TYPE_WIDTH 8
-#define VFDI_EV_TYPE_REQ_WORD0 0
-#define VFDI_EV_TYPE_REQ_WORD1 1
-#define VFDI_EV_TYPE_REQ_WORD2 2
-#define VFDI_EV_TYPE_REQ_WORD3 3
-#define VFDI_EV_TYPE_STATUS 4
-#define VFDI_EV_TYPE_RESET 5
-#define VFDI_EV_DATA_LBN 0
-#define VFDI_EV_DATA_WIDTH 16
-
-struct vfdi_endpoint {
-	u8 mac_addr[ETH_ALEN];
-	__be16 tci;
-};
-
-/**
- * enum vfdi_op - VFDI operation enumeration
- * @VFDI_OP_RESPONSE: Indicates a response to the request.
- * @VFDI_OP_INIT_EVQ: Initialize SRAM entries and initialize an EVQ.
- * @VFDI_OP_INIT_RXQ: Initialize SRAM entries and initialize an RXQ.
- * @VFDI_OP_INIT_TXQ: Initialize SRAM entries and initialize a TXQ.
- * @VFDI_OP_FINI_ALL_QUEUES: Flush all queues, finalize all queues, then
- *	finalize the SRAM entries.
- * @VFDI_OP_INSERT_FILTER: Insert a MAC filter targeting the given RXQ.
- * @VFDI_OP_REMOVE_ALL_FILTERS: Remove all filters.
- * @VFDI_OP_SET_STATUS_PAGE: Set the DMA page(s) used for status updates
- *	from PF and write the initial status.
- * @VFDI_OP_CLEAR_STATUS_PAGE: Clear the DMA page(s) used for status
- *	updates from PF.
- */
-enum vfdi_op {
-	VFDI_OP_RESPONSE = 0,
-	VFDI_OP_INIT_EVQ = 1,
-	VFDI_OP_INIT_RXQ = 2,
-	VFDI_OP_INIT_TXQ = 3,
-	VFDI_OP_FINI_ALL_QUEUES = 4,
-	VFDI_OP_INSERT_FILTER = 5,
-	VFDI_OP_REMOVE_ALL_FILTERS = 6,
-	VFDI_OP_SET_STATUS_PAGE = 7,
-	VFDI_OP_CLEAR_STATUS_PAGE = 8,
-	VFDI_OP_LIMIT,
-};
-
-/* Response codes for VFDI operations. Other values may be used in future. */
-#define VFDI_RC_SUCCESS		0
-#define VFDI_RC_ENOMEM		(-12)
-#define VFDI_RC_EINVAL		(-22)
-#define VFDI_RC_EOPNOTSUPP	(-95)
-#define VFDI_RC_ETIMEDOUT	(-110)
-
-/**
- * struct vfdi_req - Request from VF driver to PF driver
- * @op: Operation code or response indicator, taken from &enum vfdi_op.
- * @rc: Response code.  Set to 0 on success or a negative error code on failure.
- * @u.init_evq.index: Index of event queue to create.
- * @u.init_evq.buf_count: Number of 4k buffers backing event queue.
- * @u.init_evq.addr: Array of length %u.init_evq.buf_count containing DMA
- *	address of each page backing the event queue.
- * @u.init_rxq.index: Index of receive queue to create.
- * @u.init_rxq.buf_count: Number of 4k buffers backing receive queue.
- * @u.init_rxq.evq: Instance of event queue to target receive events at.
- * @u.init_rxq.label: Label used in receive events.
- * @u.init_rxq.flags: Unused.
- * @u.init_rxq.addr: Array of length %u.init_rxq.buf_count containing DMA
- *	address of each page backing the receive queue.
- * @u.init_txq.index: Index of transmit queue to create.
- * @u.init_txq.buf_count: Number of 4k buffers backing transmit queue.
- * @u.init_txq.evq: Instance of event queue to target transmit completion
- *	events at.
- * @u.init_txq.label: Label used in transmit completion events.
- * @u.init_txq.flags: Checksum offload flags.
- * @u.init_txq.addr: Array of length %u.init_txq.buf_count containing DMA
- *	address of each page backing the transmit queue.
- * @u.mac_filter.rxq: Insert MAC filter at VF local address/VLAN targeting
- *	all traffic at this receive queue.
- * @u.mac_filter.flags: MAC filter flags.
- * @u.set_status_page.dma_addr: Base address for the &struct vfdi_status.
- *	This address must be page-aligned and the PF may write up to a
- *	whole page (allowing for extension of the structure).
- * @u.set_status_page.peer_page_count: Number of additional pages the VF
- *	has provided into which peer addresses may be DMAd.
- * @u.set_status_page.peer_page_addr: Array of DMA addresses of pages.
- *	If the number of peers exceeds 256, then the VF must provide
- *	additional pages in this array. The PF will then DMA up to
- *	512 vfdi_endpoint structures into each page.  These addresses
- *	must be page-aligned.
- */
-struct vfdi_req {
-	u32 op;
-	u32 reserved1;
-	s32 rc;
-	u32 reserved2;
-	union {
-		struct {
-			u32 index;
-			u32 buf_count;
-			u64 addr[];
-		} init_evq;
-		struct {
-			u32 index;
-			u32 buf_count;
-			u32 evq;
-			u32 label;
-			u32 flags;
-#define VFDI_RXQ_FLAG_SCATTER_EN 1
-			u32 reserved;
-			u64 addr[];
-		} init_rxq;
-		struct {
-			u32 index;
-			u32 buf_count;
-			u32 evq;
-			u32 label;
-			u32 flags;
-#define VFDI_TXQ_FLAG_IP_CSUM_DIS 1
-#define VFDI_TXQ_FLAG_TCPUDP_CSUM_DIS 2
-			u32 reserved;
-			u64 addr[];
-		} init_txq;
-		struct {
-			u32 rxq;
-			u32 flags;
-#define VFDI_MAC_FILTER_FLAG_RSS 1
-#define VFDI_MAC_FILTER_FLAG_SCATTER 2
-		} mac_filter;
-		struct {
-			u64 dma_addr;
-			u64 peer_page_count;
-			u64 peer_page_addr[];
-		} set_status_page;
-	} u;
-};
-
-/**
- * struct vfdi_status - Status provided by PF driver to VF driver
- * @generation_start: A generation count DMA'd to VF *before* the
- *	rest of the structure.
- * @generation_end: A generation count DMA'd to VF *after* the
- *	rest of the structure.
- * @version: Version of this structure; currently set to 1.  Later
- *	versions must either be layout-compatible or only be sent to VFs
- *	that specifically request them.
- * @length: Total length of this structure including embedded tables
- * @vi_scale: log2 the number of VIs available on this VF. This quantity
- *	is used by the hardware for register decoding.
- * @max_tx_channels: The maximum number of transmit queues the VF can use.
- * @rss_rxq_count: The number of receive queues present in the shared RSS
- *	indirection table.
- * @peer_count: Total number of peers in the complete peer list. If larger
- *	than ARRAY_SIZE(%peers), then the VF must provide sufficient
- *	additional pages each of which is filled with vfdi_endpoint structures.
- * @local: The MAC address and outer VLAN tag of *this* VF
- * @peers: Table of peer addresses.  The @tci fields in these structures
- *	are currently unused and must be ignored.  Additional peers are
- *	written into any additional pages provided by the VF.
- * @timer_quantum_ns: Timer quantum (nominal period between timer ticks)
- *	for interrupt moderation timers, in nanoseconds. This member is only
- *	present if @length is sufficiently large.
- */
-struct vfdi_status {
-	u32 generation_start;
-	u32 generation_end;
-	u32 version;
-	u32 length;
-	u8 vi_scale;
-	u8 max_tx_channels;
-	u8 rss_rxq_count;
-	u8 reserved1;
-	u16 peer_count;
-	u16 reserved2;
-	struct vfdi_endpoint local;
-	struct vfdi_endpoint peers[256];
-
-	/* Members below here extend version 1 of this structure */
-	u32 timer_quantum_ns;
-};
-
-#endif



