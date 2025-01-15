Return-Path: <netdev+bounces-158610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D9A12B4B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7254D3A602D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685D1D79A5;
	Wed, 15 Jan 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="K2Ul0Z8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF91D6DA1
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967620; cv=none; b=nRPOmcd4d/gV5eAPclKaoPs6pS4o6RzUEXh6ygNZ7UF6wi9FrReXh/so0R2yD2IrfL4b2ZH1kOf57dPD5jZGF6/TrcC6x97qGf0OibMDq71BRezXmQRxOZceICviqG+4ptjc2GSrpg55m1pmLXAm+IqPAvM0oa0bcolbpQd23Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967620; c=relaxed/simple;
	bh=rBYklsr0ws6SByx9giYRmM6JD047O7SblBdf3Txhrgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkNTQfRZA0t4GXXnZSzzZvNPC8dkmZKVsB9OTZurH8ACyF8sFY4ZHZSYH5cljgqW4G02T+fdmS9CDtbij3LNEmnTrNfZEq4RWGDMYhVA45eQPfLiyF8XNnRcqjXTbtn78Uy9KYbO+V7fCdmLQzK7daJg9yay7B7FNEEs0mYvQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=K2Ul0Z8n; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g61VlJobAQryvRC3yqIYqnxzEVhSl0MD6xzfyek0HCk=; t=1736967618; x=1737831618; 
	b=K2Ul0Z8nL0cVg3LgDzlEVmbsd7Iqg85uF8rVL9qr7S/1fUjESpm5SwzQ7yGl+oZDNDFFlN55OLa
	4wOjFkWL75yidDHOYcW7LM9CXQwKANSmxCMn+thc962tRaG20CAlUKz6CPsYoDB7O10gCTCbqTMVH
	LOr7cPHGn5ELvYhP5GbVcn7E4vWF48iDsgzhJHhMjYGGia/h1nL5SKZwglBa2+fjVflTuiDHXadZF
	4coKeWkgd8f0XGoKzfOm6d2yBGF2uAf4es/21cNS0cNdAWDu812JuW6eZKolnd17yAIwtfxEDpgGu
	RlWhElO83aPZ8592z1lroGOJQ0bxsZxfi7pQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:52661 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tY8cd-0002BF-Q2; Wed, 15 Jan 2025 11:00:12 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v6 02/12] net: homa: create homa_wire.h
Date: Wed, 15 Jan 2025 10:59:26 -0800
Message-ID: <20250115185937.1324-3-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250115185937.1324-1-ouster@cs.stanford.edu>
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: afbb6022ebcf875afa433248af97014c

This file defines the on-the-wire packet formats for Homa.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_wire.h | 367 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 367 insertions(+)
 create mode 100644 net/homa/homa_wire.h

diff --git a/net/homa/homa_wire.h b/net/homa/homa_wire.h
new file mode 100644
index 000000000000..df0242c4f00b
--- /dev/null
+++ b/net/homa/homa_wire.h
@@ -0,0 +1,367 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file defines the on-the-wire format of Homa packets. */
+
+#ifndef _HOMA_WIRE_H
+#define _HOMA_WIRE_H
+
+#include <linux/skbuff.h>
+
+/* Defines the possible types of Homa packets.
+ *
+ * See the xxx_header structs below for more information about each type.
+ */
+enum homa_packet_type {
+	DATA               = 0x10,
+	RESEND             = 0x12,
+	UNKNOWN            = 0x13,
+	BUSY               = 0x14,
+	NEED_ACK           = 0x17,
+	ACK                = 0x18,
+	BOGUS              = 0x19,      /* Used only in unit tests. */
+	/* If you add a new type here, you must also do the following:
+	 * 1. Change BOGUS so it is the highest opcode
+	 * 2. Add support for the new opcode in homa_print_packet,
+	 *    homa_print_packet_short, homa_symbol_for_type, and mock_skb_new.
+	 * 3. Add the header length to header_lengths in homa_plumbing.c.
+	 */
+};
+
+/** define HOMA_IPV6_HEADER_LENGTH - Size of IP header (V6). */
+#define HOMA_IPV6_HEADER_LENGTH 40
+
+/** define HOMA_IPV4_HEADER_LENGTH - Size of IP header (V4). */
+#define HOMA_IPV4_HEADER_LENGTH 20
+
+/**
+ * define HOMA_SKB_EXTRA - How many bytes of additional space to allow at the
+ * beginning of each sk_buff, before the IP header. This includes room for a
+ * VLAN header and also includes some extra space, "just to be safe" (not
+ * really sure if this is needed).
+ */
+#define HOMA_SKB_EXTRA 40
+
+/**
+ * define HOMA_ETH_OVERHEAD - Number of bytes per Ethernet packet for Ethernet
+ * header, CRC, preamble, and inter-packet gap.
+ */
+#define HOMA_ETH_OVERHEAD 42
+
+/**
+ * define HOMA_MIN_PKT_LENGTH - Every Homa packet must be padded to at least
+ * this length to meet Ethernet frame size limitations. This number includes
+ * Homa headers and data, but not IP or Ethernet headers.
+ */
+#define HOMA_MIN_PKT_LENGTH 26
+
+/**
+ * define HOMA_MAX_HEADER - Number of bytes in the largest Homa header.
+ */
+#define HOMA_MAX_HEADER 90
+
+/**
+ * struct homa_common_hdr - Wire format for the first bytes in every Homa
+ * packet. This must (mostly) match the format of a TCP header to enable
+ * Homa packets to actually be transmitted as TCP packets (and thereby
+ * take advantage of TSO and other features).
+ */
+struct homa_common_hdr {
+	/**
+	 * @sport: Port on source machine from which packet was sent.
+	 * Must be in the same position as in a TCP header.
+	 */
+	__be16 sport;
+
+	/**
+	 * @dport: Port on destination that is to receive packet. Must be
+	 * in the same position as in a TCP header.
+	 */
+	__be16 dport;
+
+	/**
+	 * @sequence: corresponds to the sequence number field in TCP headers;
+	 * used in DATA packets to hold the offset in the message of the first
+	 * byte of data. This value will only be correct in the first segment
+	 * of a GSO packet.
+	 */
+	__be32 sequence;
+
+	/**
+	 * @ack: Corresponds to the high-order bits of the acknowledgment
+	 * field in TCP headers; not used by Homa.
+	 */
+	char ack[3];
+
+	/**
+	 * @type: Homa packet type (one of the values of the homa_packet_type
+	 * enum). Corresponds to the low-order byte of the ack in TCP.
+	 */
+	__u8 type;
+
+	/**
+	 * @doff: High order 4 bits holds the number of 4-byte chunks in a
+	 * homa_data_hdr (low-order bits unused). Used only for DATA packets;
+	 * must be in the same position as the data offset in a TCP header.
+	 * Used by TSO to determine where the replicated header portion ends.
+	 */
+	__u8 doff;
+
+	/**
+	 * @reserved1: Corresponds to flag bits in TCP; currently unused
+	 * by Homa.
+	 */
+	__u8 reserved1;
+
+	/**
+	 * @window: Corresponds to the window field in TCP headers. Not used
+	 * by HOMA.
+	 */
+	__be16 window;
+
+	/**
+	 * @checksum: Not used by Homa, but must occupy the same bytes as
+	 * the checksum in a TCP header (TSO may modify this?).
+	 */
+	__be16 checksum;
+
+	/**
+	 * @reserved2: Corresponds to the urgent pointer in TCP; not used
+	 * by Homa.
+	 */
+	__be16 reserved2;
+
+	/**
+	 * @sender_id: the identifier of this RPC as used on the sender (i.e.,
+	 * if the low-order bit is set, then the sender is the server for
+	 * this RPC).
+	 */
+	__be64 sender_id;
+} __packed;
+
+/**
+ * struct homa_ack - Identifies an RPC that can be safely deleted by its
+ * server. After sending the response for an RPC, the server must retain its
+ * state for the RPC until it knows that the client has successfully
+ * received the entire response. An ack indicates this. Clients will
+ * piggyback acks on future data packets, but if a client doesn't send
+ * any data to the server, the server will eventually request an ack
+ * explicitly with a NEED_ACK packet, in which case the client will
+ * return an explicit ACK.
+ */
+struct homa_ack {
+	/**
+	 * @client_id: The client's identifier for the RPC. 0 means this ack
+	 * is invalid.
+	 */
+	__be64 client_id;
+
+	/** @server_port: The server-side port for the RPC. */
+	__be16 server_port;
+} __packed;
+
+/* struct homa_data_hdr - Contains data for part or all of a Homa message.
+ * An incoming packet consists of a homa_data_hdr followed by message data.
+ * An outgoing packet can have this simple format as well, or it can be
+ * structured as a GSO packet with the following format:
+ *
+ *    |-----------------------|
+ *    |                       |
+ *    |     data_header       |
+ *    |                       |
+ *    |---------------------- |
+ *    |                       |
+ *    |                       |
+ *    |     segment data      |
+ *    |                       |
+ *    |                       |
+ *    |-----------------------|
+ *    |      seg_header       |
+ *    |-----------------------|
+ *    |                       |
+ *    |                       |
+ *    |     segment data      |
+ *    |                       |
+ *    |                       |
+ *    |-----------------------|
+ *    |      seg_header       |
+ *    |-----------------------|
+ *    |                       |
+ *    |                       |
+ *    |     segment data      |
+ *    |                       |
+ *    |                       |
+ *    |-----------------------|
+ *
+ * TSO will not adjust @homa_common_hdr.sequence in the segments, so Homa
+ * sprinkles correct offsets (in homa_seg_hdrs) throughout the segment data;
+ * TSO/GSO will include a different homa_seg_hdr in each generated packet.
+ */
+
+struct homa_seg_hdr {
+	/**
+	 * @offset: Offset within message of the first byte of data in
+	 * this segment.
+	 */
+	__be32 offset;
+} __packed;
+
+struct homa_data_hdr {
+	struct homa_common_hdr common;
+
+	/** @message_length: Total #bytes in the message. */
+	__be32 message_length;
+
+	__be32 reserved1;
+
+	/** @ack: If the @client_id field of this is nonzero, provides info
+	 * about an RPC that the recipient can now safely free. Note: in
+	 * TSO packets this will get duplicated in each of the segments;
+	 * in order to avoid repeated attempts to ack the same RPC,
+	 * homa_gro_receive will clear this field in all segments but the
+	 * first.
+	 */
+	struct homa_ack ack;
+
+	__be16 reserved2;
+
+	/**
+	 * @retransmit: 1 means this packet was sent in response to a RESEND
+	 * (it has already been sent previously).
+	 */
+	__u8 retransmit;
+
+	char pad[3];
+
+	/** @seg: First of possibly many segments. */
+	struct homa_seg_hdr seg;
+} __packed;
+_Static_assert(sizeof(struct homa_data_hdr) <= HOMA_MAX_HEADER,
+	       "homa_data_hdr too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+_Static_assert(sizeof(struct homa_data_hdr) >= HOMA_MIN_PKT_LENGTH,
+	       "homa_data_hdr too small: Homa doesn't currently have code to pad data packets");
+_Static_assert(((sizeof(struct homa_data_hdr) - sizeof(struct homa_seg_hdr)) &
+		0x3) == 0,
+	       " homa_data_hdr length not a multiple of 4 bytes (required for TCP/TSO compatibility");
+
+/**
+ * homa_data_len() - Returns the total number of bytes in a DATA packet
+ * after the homa_data_hdr. Note: if the packet is a GSO packet, the result
+ * may include metadata as well as packet data.
+ * @skb:   Incoming data packet
+ * Return: see above
+ */
+static inline int homa_data_len(struct sk_buff *skb)
+{
+	return skb->len - skb_transport_offset(skb) -
+			sizeof(struct homa_data_hdr);
+}
+
+/**
+ * struct homa_resend_hdr - Wire format for RESEND packets.
+ *
+ * A RESEND is sent by the receiver when it believes that message data may
+ * have been lost in transmission (or if it is concerned that the sender may
+ * have crashed). The receiver should resend the specified portion of the
+ * message, even if it already sent it previously.
+ */
+struct homa_resend_hdr {
+	/** @common: Fields common to all packet types. */
+	struct homa_common_hdr common;
+
+	/**
+	 * @offset: Offset within the message of the first byte of data that
+	 * should be retransmitted.
+	 */
+	__be32 offset;
+
+	/**
+	 * @length: Number of bytes of data to retransmit; this could specify
+	 * a range longer than the total message size. Zero is a special case
+	 * used by servers; in this case, there is no need to actually resend
+	 * anything; the purpose of this packet is to trigger an UNKNOWN
+	 * response if the client no longer cares about this RPC.
+	 */
+	__be32 length;
+} __packed;
+_Static_assert(sizeof(struct homa_resend_hdr) <= HOMA_MAX_HEADER,
+	       "homa_resend_hdr too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * struct homa_unknown_hdr - Wire format for UNKNOWN packets.
+ *
+ * An UNKNOWN packet is sent by either server or client when it receives a
+ * packet for an RPC that is unknown to it. When a client receives an
+ * UNKNOWN packet it will typically restart the RPC from the beginning;
+ * when a server receives an UNKNOWN packet it will typically discard its
+ * state for the RPC.
+ */
+struct homa_unknown_hdr {
+	/** @common: Fields common to all packet types. */
+	struct homa_common_hdr common;
+} __packed;
+_Static_assert(sizeof(struct homa_unknown_hdr) <= HOMA_MAX_HEADER,
+	       "homa_unknown_hdr too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * struct homa_busy_hdr - Wire format for BUSY packets.
+ *
+ * These packets tell the recipient that the sender is still alive (even if
+ * it isn't sending data expected by the recipient).
+ */
+struct homa_busy_hdr {
+	/** @common: Fields common to all packet types. */
+	struct homa_common_hdr common;
+} __packed;
+_Static_assert(sizeof(struct homa_busy_hdr) <= HOMA_MAX_HEADER,
+	       "homa_busy_hdr too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * struct homa_need_ack_hdr - Wire format for NEED_ACK packets.
+ *
+ * These packets ask the recipient (a client) to return an ACK message if
+ * the packet's RPC is no longer active.
+ */
+struct homa_need_ack_hdr {
+	/** @common: Fields common to all packet types. */
+	struct homa_common_hdr common;
+} __packed;
+_Static_assert(sizeof(struct homa_need_ack_hdr) <= HOMA_MAX_HEADER,
+	       "homa_need_ack_hdr too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * struct homa_ack_hdr - Wire format for ACK packets.
+ *
+ * These packets are sent from a client to a server to indicate that
+ * a set of RPCs is no longer active on the client, so the server can
+ * free any state it may have for them.
+ */
+struct homa_ack_hdr {
+	/** @common: Fields common to all packet types. */
+	struct homa_common_hdr common;
+
+	/** @num_acks: Number of (leading) elements in @acks that are valid. */
+	__be16 num_acks;
+
+#define HOMA_MAX_ACKS_PER_PKT 5
+	/** @acks: Info about RPCs that are no longer active. */
+	struct homa_ack acks[HOMA_MAX_ACKS_PER_PKT];
+} __packed;
+_Static_assert(sizeof(struct homa_ack_hdr) <= HOMA_MAX_HEADER,
+	       "homa_ack_hdr too large for HOMA_MAX_HEADER; must adjust HOMA_MAX_HEADER");
+
+/**
+ * homa_local_id(): given an RPC identifier from an input packet (which
+ * is network-encoded), return the decoded id we should use for that
+ * RPC on this machine.
+ * @sender_id:  RPC id from an incoming packet, such as h->common.sender_id
+ * Return: see above
+ */
+static inline __u64 homa_local_id(__be64 sender_id)
+{
+	/* If the client bit was set on the sender side, it needs to be
+	 * removed here, and conversely.
+	 */
+	return be64_to_cpu(sender_id) ^ 1;
+}
+
+#endif /* _HOMA_WIRE_H */
-- 
2.34.1


