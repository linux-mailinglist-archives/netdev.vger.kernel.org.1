Return-Path: <netdev+bounces-148067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419979E04F9
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040BA169F8A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D4B205AB8;
	Mon,  2 Dec 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmEyM8rK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B986204086
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149648; cv=none; b=Ui06zgUpEe2/kj+7d72lA0Pw/rakOuQvW49tnX1ffr8OJBmUQZGu74Efw0vIv8imcAxsOnfpXvnC9U/ZwOJ3FyMWkJiuA8jzf2I329obUDLCJrkYBJhPRGUqfcHMBR8l5tvCBOt47PKP5T0pJSV9GNUiYdUC48youcWy25gcUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149648; c=relaxed/simple;
	bh=9nTc5lBxm6iQsEI968kaoAmSOgzYL1FCYMc035TxRAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/jpwUGIbHaihmag8SNVP6ocJkYt8sMfuuIM7Sp9hwqVuTo5j7y/wjKxTAmqcD9aFSGYhhDbHd7U1C+7lHY1lYS0hCXnrVEMmGe5tUw7Ol6+blXgNYuxo8y6roA9mg+GSyFhf1BxsAE4428cu9keiNmhO2cMaPS+oz5qkHJjzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmEyM8rK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d1W05VOqDmoIuUvbLho/+XrpsQQwhtbljwSHTaxp4E8=;
	b=VmEyM8rKiNWXfnLPc75GXBQzpe5Q4xu+y/IZf6RXL936BLiguLR8hmgUI8QWahdBo++lfQ
	daDISt4LnvcasJS3DKw8M1jpfq2coXdqEe3zfv862aj+EcVpadKdHYSvBFhuu4C/S4zcTm
	euNYUx7N+osPa0VRckfxwc0tPdABgwY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-hrHrU5XNOWyDmfyT8MbI0w-1; Mon,
 02 Dec 2024 09:27:21 -0500
X-MC-Unique: hrHrU5XNOWyDmfyT8MbI0w-1
X-Mimecast-MFC-AGG-ID: hrHrU5XNOWyDmfyT8MbI0w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A42921955E7A;
	Mon,  2 Dec 2024 14:27:19 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7255D30001A9;
	Mon,  2 Dec 2024 14:27:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/37] rxrpc: Implement jumbo DATA transmission and RACK-TLP
Date: Mon,  2 Dec 2024 14:26:29 +0000
Message-ID: <20241202142711.377451-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Here's a series of patches to implement two main features:

 (1) The transmission of jumbo data packets whereby several DATA packets of
     a particular size can be glued together into a single UDP packet,
     allowing us to make use of larger MTU sizes.  The basic jumbo
     subpacket capacity is 1412 bytes (RXRPC_JUMBO_DATALEN) and, say, an
     MTU of 8192 allows five of them to be transmitted as one.

     An alternative (and possibly more efficient way) would be to
     expand/shrink the capacity of each DATA packet to match the MTU and
     thus save on header and tail-gap overhead, but the Rx protocol does
     not provide a mechanism for splitting the data - especially as the
     transported data is encrypted per-packet - and so UDP fragmentation
     would be the only way to handle this.

     In fact, in the future, AF_RXRPC also needs to look at shrinking the
     packet size where the MTU is smaller - for instance in the case of
     being carried by IPv6 over wifi where there isn't capacity for a 1412
     byte capacity.

 (2) RACK-TLP to manage packet loss and retransmission in conjunction with
     the congestion control algorithm.

These allow for better data throughput and work towards being able to have
larger transmission windows.

To this end, the following changes are also made:

 (1) Use a single large array of kvec structs for the I/O thread rather
     than having one per transmission buffer.  We need a much bigger
     collection of kvecs for ping padding

 (2) Implement path-MTU probing by sending padded PING ACK packets and
     monitoring for PING RESPONSE ACKs.  The pmtud value determined is used
     to configure the construction of jumbo DATA packets.

 (3) The transmission queue is changed from a linked list of transmission
     buffer structs to a linked list of transmission-queue structs, each of
     which points to either 32 or 64 transmission buffers (depending on cpu
     word size) and various bits of metadata are concentrated in the queue
     structs rather than the buffers to make better use of the cpu cache.

 (4) SACK data is stored in the transmission-queue structures in batches of
     32 or 64 making it faster to process rather than being spread amongst
     all the individual packet buffers.

 (5) Don't change the DF flag on the UDP socket unless we need to - and
     basically only enable it for path-MTU probing.

There are also some additional bits:

 (1) Fix the handling of connection aborts to poke the aborted connections.

 (2) Don't set the MORE-PACKETS Rx header flag on the wire.  No one
     actually checks it and it is, in any case, generated inconsistently
     between implementations.

 (3) Request an ACK when, during call transmission, there's a stall in the
     app generating the data to be transmitted.

 (4) Fix attention starvation in the I/O thread by making sure we go
     through all outstanding events rather than returning to the beginning
     of the check cycle after any time we process an event.

 (5) Don't use the skbuff timestamp in the calculation of timeouts and RTT
     as we really should include local processing time in that too.
     Further, getting receive skbuff timestamps may be expensive.

 (6) Make RTT tracking per call with the saving of the value between calls,
     even within the same connection channel.  The initial call timeout
     starts off large to allow the server time to set up its state before
     the initial reply.

 (7) Don't allocate txbuf structs for ACK packets, but rather use page
     frags and MSG_SPLICE_PAGES.

 (8) Use irq-disabling locks for interactions between app threads and I/O
     threads so that the I/O thread doesn't get help up.

 (9) Make rxrpc set the REQUEST-ACK flag on an outgoing packet when cwnd is
     at RXRPC_MIN_CWND (currently 4), not at 2 which it can never reach.

(10) Add some tracing bits and pieces (including displaying the userStatus
     field in an ACK header) and some more stats counters (including
     different sizes of jumbo packets sent/received).

The patches can also be found on this branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-iothread

David

Link: https://lore.kernel.org/r/20240306000655.1100294-1-dhowells@redhat.com/ [1]

David Howells (37):
  rxrpc: Fix handling of received connection abort
  rxrpc: Use umin() and umax() rather than min_t()/max_t() where
    possible
  rxrpc: Clean up Tx header flags generation handling
  rxrpc: Don't set the MORE-PACKETS rxrpc wire header flag
  rxrpc: Show stats counter for received reason-0 ACKs
  rxrpc: Request an ACK on impending Tx stall
  rxrpc: Use a large kvec[] in rxrpc_local rather than every rxrpc_txbuf
  rxrpc: Implement path-MTU probing using padded PING ACKs (RFC8899)
  rxrpc: Separate the packet length from the data length in rxrpc_txbuf
  rxrpc: Prepare to be able to send jumbo DATA packets
  rxrpc: Add a tracepoint to show variables pertinent to jumbo packet
    size
  rxrpc: Fix CPU time starvation in I/O thread
  rxrpc: Fix injection of packet loss
  rxrpc: Only set DF=1 on initial DATA transmission
  rxrpc: Timestamp DATA packets before transmitting them
  rxrpc: Implement progressive transmission queue struct
  rxrpc: call->acks_hard_ack is now the same call->tx_bottom, so remove
    it
  rxrpc: Replace call->acks_first_seq with tracking of the hard ACK
    point
  rxrpc: Display stats about jumbo packets transmitted and received
  rxrpc: Adjust names and types of congestion-related fields
  rxrpc: Use the new rxrpc_tx_queue struct to more efficiently process
    ACKs
  rxrpc: Store the DATA serial in the txqueue and use this in RTT calc
  rxrpc: Don't use received skbuff timestamps
  rxrpc: Generate rtt_min
  rxrpc: Adjust the rxrpc_rtt_rx tracepoint
  rxrpc: Display userStatus in rxrpc_rx_ack trace
  rxrpc: Fix the calculation and use of RTO
  rxrpc: Fix initial resend timeout
  rxrpc: Send jumbo DATA packets
  rxrpc: Don't allocate a txbuf for an ACK transmission
  rxrpc: Use irq-disabling spinlocks between app and I/O thread
  rxrpc: Tidy up the ACK parsing a bit
  rxrpc: Add a reason indicator to the tx_data tracepoint
  rxrpc: Add a reason indicator to the tx_ack tracepoint
  rxrpc: Manage RTT per-call rather than per-peer
  rxrpc: Fix request for an ACK when cwnd is minimum
  rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]

 include/trace/events/rxrpc.h | 878 ++++++++++++++++++++++++++++++-----
 lib/win_minmax.c             |   1 +
 net/rxrpc/Makefile           |   1 +
 net/rxrpc/af_rxrpc.c         |   4 +-
 net/rxrpc/ar-internal.h      | 339 +++++++++++---
 net/rxrpc/call_accept.c      |  22 +-
 net/rxrpc/call_event.c       | 385 ++++++++-------
 net/rxrpc/call_object.c      |  67 +--
 net/rxrpc/conn_client.c      |  26 +-
 net/rxrpc/conn_event.c       |  38 +-
 net/rxrpc/conn_object.c      |  14 +-
 net/rxrpc/input.c            | 706 +++++++++++++++++-----------
 net/rxrpc/input_rack.c       | 422 +++++++++++++++++
 net/rxrpc/insecure.c         |   5 +-
 net/rxrpc/io_thread.c        | 109 ++---
 net/rxrpc/local_object.c     |   3 -
 net/rxrpc/misc.c             |   4 +-
 net/rxrpc/output.c           | 557 ++++++++++++++--------
 net/rxrpc/peer_event.c       | 112 ++++-
 net/rxrpc/peer_object.c      |  30 +-
 net/rxrpc/proc.c             |  58 ++-
 net/rxrpc/protocol.h         |  13 +-
 net/rxrpc/recvmsg.c          |  18 +-
 net/rxrpc/rtt.c              | 103 ++--
 net/rxrpc/rxkad.c            |  59 ++-
 net/rxrpc/rxperf.c           |   2 +-
 net/rxrpc/security.c         |   4 +-
 net/rxrpc/sendmsg.c          |  88 +++-
 net/rxrpc/sysctl.c           |   6 +-
 net/rxrpc/txbuf.c            | 127 +----
 30 files changed, 2968 insertions(+), 1233 deletions(-)
 create mode 100644 net/rxrpc/input_rack.c


