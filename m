Return-Path: <netdev+bounces-293421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BlsHtQzHGoeLgkAu9opvQ
	(envelope-from <netdev+bounces-293421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:12:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D935616438
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 321CE3010655
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A94B38D018;
	Sun, 31 May 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl7ZgVOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB538D3E0
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780233097; cv=none; b=f48EYW5fEo5pi5xIXZQ66nshI9PFYD4QCKIRW1vGtsYB36A+V2hzhBaX+dA33frjpUawDcEvlcDA1g4uVs2y2TT8ebKOMZrJjZYCMc9biN7aURnzFhQOX331UdFsZPkSf5360RA8FZdASgYasg8D4E5odyrh3K+vsnmxfnt2QeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780233097; c=relaxed/simple;
	bh=JF/pgNZCkXu4wXlAWdQjqxXGAx6CPb5fjygxwGf5yg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3o3d+ru4detbyiQTvoiQD85f2hXCI9k7XqmKGUi6ySkfoX53h2uUhii/WuUB/GwEzmoF4IiBd3EzI6WA9XLEjqEbY0Hif9v1OENfN3KV2kyew90a4Ot7Xloo9KQkIbYEBKXjXApc9VF6t8khJor/w/xz1lvlWb4DBcWT5bOcy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl7ZgVOb; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ce9de10985so6360166d6.0
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780233093; x=1780837893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD8h+hRorSLm84XfqZyhJ5Cq6OE+HPlA39Bu3CUHqSM=;
        b=Fl7ZgVObAC03BIwFO1tdabBs9I2SAR04CnwwhvL5xsv1eTtXwHGEQ7xgFxXY0MAx5i
         8KddC/yhS2yIwMN/E3hQM0rWJuPaQrfLLEmY91iOoGHYDO0og2IVCT4evbU7HJCvwWDp
         lJ+Gm5vBl4Utm7JJUvtsS4jP7BonLk+jpSHqoqul2TVzrsG2DYcuaHTv6kVu0KlyyyK9
         pg5rPQA23hDdKVyaZPLWAFxD9lSl9gmbOa/XW91fKi8QGYA8c0+w3hivDlhVoqRgMdZK
         /3ZaBMMruvUldIQ3G/EGUKdNCaAteXkk9IzGZaBUeZmL5BOrChLkxWvppuV+T2EMdzsK
         7hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780233093; x=1780837893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UD8h+hRorSLm84XfqZyhJ5Cq6OE+HPlA39Bu3CUHqSM=;
        b=s9IpOg19yDNSTH7JjOdci+81QGYuLGmzHHYkRKlYvWOvoRUP92ilyQ4GDnNp1obF7P
         wO1/t4h58zdow4mGy2Ib03JItq/se3gK5khjt+cxdjVIBMGP0adqSVkfuFNOSn6LDtcT
         QmbQxkRY2xeakotX/bBZcR9rObplkgyyKWYzpxhiZl4m8VrEfEhfF9/ZHiULLECgT4VO
         eK8legzzm2gF8x/1mvoYDEGMCnlOL3VUd1g4iB1iX2fv/RwXJHPY31Akwt9DMCZay6Ka
         pQRyWQy/XAECIfHHhW7JOU+p7pC4xHUSOEIC4v0KjJNGpMH3HQEUj24Yc0/PO57Zgy4o
         ln7A==
X-Gm-Message-State: AOJu0YygZJh58fLCz3vMt/6OMpb2VOW4K6rP321nGD6ZOQMT/xFZi/jI
	i+jsTlMZ6eOhwlHVVNEQCvil8mHGuml86ez/a/ByrgSBDPQD+06yuK8tH753Bx1UWww=
X-Gm-Gg: Acq92OHVqXM05CDdv6QF0ETcU6jIrOtyOiGnhKGegYJ/bgrtn0vIdYyvsQFKlTsrMAk
	tHJaUNAzAFxfR++IqUprv4b/nUUkib+s8h34VlGGIT2wmxBZJoGoWtzQHMCfmwSnIEARf15W41+
	mZWGBpscFNzDJvDlKFXQ9tmOIcT8/UDP1AGGQBnaWc5pjQrPrYtbiR1RScQQ7yQedxQJQP69vgK
	1dDzlYnvsJLazJKp5kH/FO9bs8SoCNBOn+GvMnRr4Sb2J3e0wHjAYScDP8rmdm4cBPCxSbrvUD9
	tiZQ3HRjHymi2P1efMnADZ5yc9dADZNqin7fhZSXCn11grslyxeHkjatMhQO81XEOKwOkUsbTu5
	oo0NzGbAY26Qo5lZxzK8rejqKFEPvnOWU3rP2Y3vl0x3VJcHYSrv/4jGuM58/7IUpnThIlBxJNQ
	pGJYpQi49pqIJHc8bmqhYQBtf2uPsKLF3VSo8o1u2WFc5rBdSnq/XdBaeQDc3jTCHC2J08xEaRX
	+q7gC0HBoTCbpm0dn9MjqFkjNThhLoQvTjbcNG7khvOdIQihcnT93BrGaqSrklY8KPjWEx839Dn
X-Received: by 2002:a05:6214:2a4a:b0:896:fb99:f692 with SMTP id 6a1803df08f44-8ccf01311f7mr92034166d6.0.1780233093153;
        Sun, 31 May 2026 06:11:33 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea2163b0sm69609746d6.38.2026.05.31.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 06:11:32 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	quic@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Moritz Buhl <mbuhl@openbsd.org>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>,
	Thomas Dreibholz <dreibh@simula.no>,
	linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Steve Dickson <steved@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Alexander Aring <aahringo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	John Ericson <mail@johnericson.me>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Jason Baron <jbaron@akamai.com>,
	illiliti <illiliti@protonmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	mef@scarletmail.rutgers.edu,
	paul@jakma.org
Subject: [PATCH net-next v12 10/15] quic: add packet number space
Date: Sun, 31 May 2026 09:08:46 -0400
Message-ID: <9c4a6f3d1800529166d24be52844d8cafbf14856.1780232931.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1780232930.git.lucien.xin@gmail.com>
References: <cover.1780232930.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,vger.kernel.org,gmail.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293421-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D935616438
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch introduces 'quic_pnspace', which manages per packet number
space members.

It maintains the next packet number to assign, tracks the total length of
frames currently in flight, and records the time when the next packet may
be considered lost. It also keeps track of the largest acknowledged packet
number, the time it was acknowledged, and when the most recent ack
eliciting packet was sent. These fields are useful for loss detection,
RTT estimation, and congestion control.

To support ACK frame generation, quic_pnspace includes a packet number
acknowledgment map (pn_ack_map) that tracks received packet numbers.
Supporting functions are provided to validate and mark received packet
numbers and compute the number of gap blocks needed during ACK frame
construction.

- quic_pnspace_check(): Validates a received packet number.

- quic_pnspace_mark(): Marks a received packet number in the ACK map.

- quic_pnspace_num_gabs(): Returns the gap ACK blocks for constructing
  ACK frames.

Note QUIC uses separate packet number spaces for each encryption level
(APP, INITIAL, HANDSHAKE, EARLY) except EARLY and all generations of
APP keys use the same packet number space, as describe in
rfc9002#section-4.1.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
v5:
  - Change timestamp variables from u32 to u64 and use quic_ktime_get_us()
    to set max_pn_acked_time, as jiffies_to_usecs() is not accurate enough.
  - Reorder some members in quic_pnspace to reduce 32-bit holes (noted
    by Paolo).
v6:
  - Note for AI reviews: it's safe to do cast (u16)(pn - space->base_pn)
    in quic_pnspace_mark(), as the pn < base_pn + QUIC_PN_MAP_SIZE (4096)
    validation is always done in quic_pnspace_check(), which will always
    be called before quic_pnspace_mark() in a later patchset.
  - Note for AI reviews: failures in quic_pnspace_init() do not result in a
    pn_map leak in quic_init_sock(), because quic_destroy_sock() is always
    called to free it in err path, either via inet/6_create() or through
    quic_accept() in a later patchset.
v8:
  - Replace bitfields with plain u8 in struct quic_pnspace.
v10:
  - Fix a grammar error in the comment of quic_pnspace_check().
v11:
  - Note for AI reviews: RFC 9000 does not define integer IDs for packet
    number spaces. In this implementation, App=0, Initial=1,
    Handshake=2, and Early maps to 0 (3 % 3).
  - Set maximum line length to 80 characters.
  - clear space->pn_map pointer after free in quic_pnspace_free().
  - Change quic_pnspace_grow() to return negative errno on failure or 0
    on success.
  - Change return type of quic_pnspace_next_gap_ack() and
    quic_pnspace_set_ecn_count() to bool.
  - Return -EINVAL instead of -1 on failure in quic_pnspace_check().
v12:
  - Initialize max_pn_acked_seen to -1 in quic_pnspace_init().
  - Allow large packet number jumps when processing higher PN values
    (>= base_pn + QUIC_PN_MAP_SIZE) in quic_pnspace_check(),
    quic_pnspace_mark(), and quic_pnspace_grow().
  - Call quic_pnspace_has_gap() before updating max_pn_seen in
    quic_pnspace_mark().
  - Rename ECN-related helpers:
    quic_pnspace_set_ecn_count() -> quic_pnspace_set_ecn_peer(),
    quic_pnspace_has_ecn_count() -> quic_pnspace_has_ecn_local(),
    quic_pnspace_inc_ecn_count() -> quic_pnspace_inc_ecn_local().
  - Add QUIC_ECN_ACKED and introduce quic_pnspace_inc_ecn_acked(),
    quic_pnspace_reset_ecn_acked(), and quic_pnspace_validate_ecn() for
    validating ECN counts in ACKs.
  - Add sack_pending field in struct quic_pnspace for later use in sack
    piggybacking.
---
 net/quic/Makefile  |   2 +-
 net/quic/pnspace.c | 253 +++++++++++++++++++++++++++++++++++++++++++++
 net/quic/pnspace.h | 201 +++++++++++++++++++++++++++++++++++
 net/quic/socket.c  |  12 +++
 net/quic/socket.h  |   7 ++
 5 files changed, 474 insertions(+), 1 deletion(-)
 create mode 100644 net/quic/pnspace.c
 create mode 100644 net/quic/pnspace.h

diff --git a/net/quic/Makefile b/net/quic/Makefile
index 4d4a42c6d565..9d8e18297911 100644
--- a/net/quic/Makefile
+++ b/net/quic/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_IP_QUIC) += quic.o
 
 quic-y := common.o family.o protocol.o socket.o stream.o connid.o path.o \
-	  cong.o
+	  cong.o pnspace.o
diff --git a/net/quic/pnspace.c b/net/quic/pnspace.c
new file mode 100644
index 000000000000..46ce143a026b
--- /dev/null
+++ b/net/quic/pnspace.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <linux/slab.h>
+
+#include "common.h"
+#include "pnspace.h"
+
+int quic_pnspace_init(struct quic_pnspace *space)
+{
+	if (!space->pn_map) {
+		space->pn_map = kzalloc(BITS_TO_BYTES(QUIC_PN_MAP_INITIAL),
+					GFP_KERNEL);
+		if (!space->pn_map)
+			return -ENOMEM;
+		space->pn_map_len = QUIC_PN_MAP_INITIAL;
+	} else {
+		bitmap_zero(space->pn_map, space->pn_map_len);
+	}
+
+	space->max_time_limit = QUIC_PNSPACE_TIME_LIMIT;
+	space->next_pn = QUIC_PNSPACE_NEXT_PN;
+	space->max_pn_acked_seen = -1;
+	space->base_pn = -1;
+	return 0;
+}
+
+void quic_pnspace_free(struct quic_pnspace *space)
+{
+	space->pn_map_len = 0;
+	kfree(space->pn_map);
+	space->pn_map = NULL;
+}
+
+/* Expand the bitmap tracking received packet numbers.  Ensures the pn_map
+ * bitmap can cover at least @size packet numbers.  Allocates a larger bitmap,
+ * copies existing data, and updates metadata.
+ *
+ * Return: 0 on success, or a negative errno value on failure.
+ */
+static int quic_pnspace_grow(struct quic_pnspace *space, u16 size)
+{
+	u16 len, inc, offset;
+	unsigned long *new;
+
+	inc = ALIGN((size - space->pn_map_len), BITS_PER_LONG) +
+	      QUIC_PN_MAP_INCREMENT;
+	len = (u16)min(space->pn_map_len + inc, QUIC_PN_MAP_SIZE);
+
+	new = kzalloc(BITS_TO_BYTES(len), GFP_ATOMIC);
+	if (!new)
+		return -ENOMEM;
+
+	offset = (u16)(space->max_pn_seen + 1 - space->base_pn);
+	bitmap_copy(new, space->pn_map, offset);
+	kfree(space->pn_map);
+	space->pn_map = new;
+	space->pn_map_len = len;
+
+	return 0;
+}
+
+/* Check if a packet number has been received.
+ *
+ * Returns: 0 if the packet number has not been received.  1 if it has already
+ * been received. -EINVAL if the packet number is too old to track.
+ */
+int quic_pnspace_check(struct quic_pnspace *space, s64 pn)
+{
+	if (space->base_pn == -1) /* No packet number received yet. */
+		return 0;
+
+	if (pn < space->min_pn_seen)
+		return -EINVAL;
+
+	if (pn < space->base_pn)
+		return 1;
+	if (pn - space->base_pn < space->pn_map_len &&
+	    test_bit(pn - space->base_pn, space->pn_map))
+		return 1;
+
+	return 0;
+}
+
+/* Advance base_pn past contiguous received packet numbers.  Finds the next gap
+ * (unreceived packet) beyond @pn, shifts the bitmap, and updates base_pn
+ * accordingly.
+ */
+static void quic_pnspace_move(struct quic_pnspace *space, s64 pn)
+{
+	u16 offset;
+
+	offset = (u16)(pn + 1 - space->base_pn);
+	offset = (u16)find_next_zero_bit(space->pn_map, space->pn_map_len,
+					 offset);
+	space->base_pn += offset;
+	bitmap_shift_right(space->pn_map, space->pn_map, offset,
+			   space->pn_map_len);
+}
+
+/* Mark a packet number as received. Updates the packet number map to record
+ * reception of @pn.  Advances base_pn if possible, and updates max/min/last
+ * seen fields as needed.
+ *
+ * Returns: 0 on success or if the packet was already marked, or a negative
+ * error returned by bitmap growth when expanding the map.
+ */
+int quic_pnspace_mark(struct quic_pnspace *space, s64 pn)
+{
+	s64 last_max_pn_seen, off;
+	u64 last_max_pn_time;
+	bool has_gap;
+	int err;
+
+	if (space->base_pn == -1) {
+		/* Initialize base_pn based on the peer's first packet number
+		 * since peer's packet numbers may start at a non-zero value.
+		 */
+		quic_pnspace_set_base_pn(space, pn + 1);
+		return 0;
+	}
+
+	/* Ignore packets with number less than current base (already
+	 * processed).
+	 */
+	if (pn < space->base_pn)
+		return 0;
+
+	/* If offset is beyond current map length, try to grow the bitmap to
+	 * accommodate.
+	 */
+	off = pn - space->base_pn;
+	if (off >= space->pn_map_len) {
+		if (off >= QUIC_PN_MAP_SIZE) {
+			bitmap_zero(space->pn_map, space->pn_map_len);
+			quic_pnspace_set_base_pn(space, pn + 1);
+			return 0;
+		}
+		err = quic_pnspace_grow(space, off + 1);
+		if (err)
+			return err;
+	}
+
+	has_gap = quic_pnspace_has_gap(space);
+	if (space->max_pn_seen < pn) {
+		space->max_pn_seen = pn;
+		space->max_pn_time = space->time;
+	}
+
+	if (space->base_pn == pn) { /* PN is next expected packet. */
+		if (has_gap) /* Advance to next gap. */
+			quic_pnspace_move(space, pn);
+		else /* Fast path: increment base_pn if no gaps. */
+			space->base_pn++;
+	} else { /* Mark this packet as received in the bitmap. */
+		set_bit(off, space->pn_map);
+	}
+
+	/* Only update min and last_max_pn_seen if this packet is the current
+	 * max_pn.
+	 */
+	if (space->max_pn_seen != pn)
+		return 0;
+
+	/* Check if enough time has elapsed or enough packets have been
+	 * received to update tracking.
+	 */
+	last_max_pn_seen = min_t(s64, space->last_max_pn_seen, space->base_pn);
+	last_max_pn_time = space->last_max_pn_time;
+	if (space->max_pn_time < last_max_pn_time + space->max_time_limit &&
+	    space->max_pn_seen <= last_max_pn_seen + QUIC_PN_MAP_LIMIT)
+		return 0;
+
+	/* Advance base_pn if last_max_pn_seen is ahead of current base_pn.
+	 * This is needed because QUIC doesn't retransmit packets;
+	 * retransmitted frames are carried in new packets, so we move forward.
+	 */
+	if (space->last_max_pn_seen + 1 > space->base_pn)
+		quic_pnspace_move(space, space->last_max_pn_seen);
+
+	space->min_pn_seen = space->last_max_pn_seen;
+	space->last_max_pn_seen = space->max_pn_seen;
+	space->last_max_pn_time = space->max_pn_time;
+	return 0;
+}
+
+/* Find the next gap in received packet numbers. Scans pn_map for a gap
+ * starting from *@iter. A gap is a contiguous block of unreceived packets
+ * between received ones.
+ *
+ * Returns: true if a gap was found, false if no more gaps exist or are
+ * relevant.
+ */
+static bool quic_pnspace_next_gap_ack(const struct quic_pnspace *space,
+				      s64 *iter, u16 *start, u16 *end)
+{
+	u16 start_ = 0, end_ = 0, offset = (u16)(*iter - space->base_pn);
+
+	start_ = (u16)find_next_zero_bit(space->pn_map, space->pn_map_len,
+					 offset);
+	if (space->max_pn_seen <= space->base_pn + start_)
+		return false;
+
+	end_ = (u16)find_next_bit(space->pn_map, space->pn_map_len, start_);
+	if (space->max_pn_seen <= space->base_pn + end_ - 1)
+		return false;
+
+	*start = start_ + 1;
+	*end = end_;
+	*iter = space->base_pn + *end;
+	return true;
+}
+
+/* Generate gap acknowledgment blocks (GABs).  GABs describe ranges of
+ * unacknowledged packets between received ones, and are used in ACK frames.
+ *
+ * Returns: Number of generated GABs (up to QUIC_PN_MAP_MAX_GABS).
+ */
+u16 quic_pnspace_num_gabs(struct quic_pnspace *space,
+			  struct quic_gap_ack_block *gabs)
+{
+	u16 start, end, ngaps = 0;
+	s64 iter;
+
+	if (!quic_pnspace_has_gap(space))
+		return 0;
+
+	iter = space->base_pn;
+	/* Loop through all gaps until the end of the window or max allowed
+	 * gaps.
+	 */
+	while (quic_pnspace_next_gap_ack(space, &iter, &start, &end)) {
+		gabs[ngaps].start = start;
+		if (ngaps == QUIC_PN_MAP_MAX_GABS - 1) {
+			gabs[ngaps].end =
+				(u16)(space->max_pn_seen - space->base_pn);
+			ngaps++;
+			break;
+		}
+		gabs[ngaps].end = end;
+		ngaps++;
+	}
+	return ngaps;
+}
diff --git a/net/quic/pnspace.h b/net/quic/pnspace.h
new file mode 100644
index 000000000000..79e8fa21f7aa
--- /dev/null
+++ b/net/quic/pnspace.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#define QUIC_PN_MAP_MAX_GABS	32
+
+#define QUIC_PN_MAP_INITIAL	64
+#define QUIC_PN_MAP_INCREMENT	QUIC_PN_MAP_INITIAL
+#define QUIC_PN_MAP_SIZE	4096
+#define QUIC_PN_MAP_LIMIT	(QUIC_PN_MAP_SIZE * 3 / 4)
+
+#define QUIC_PNSPACE_MAX	(QUIC_CRYPTO_MAX - 1)
+#define QUIC_PNSPACE_NEXT_PN	0
+#define QUIC_PNSPACE_TIME_LIMIT	(333000 * 3)
+
+enum {
+	QUIC_ECN_ECT1,
+	QUIC_ECN_ECT0,
+	QUIC_ECN_CE,
+	QUIC_ECN_MAX
+};
+
+enum {
+	QUIC_ECN_LOCAL, /* ECN bits from incoming IP headers */
+	QUIC_ECN_PEER,  /* ECN bits reported by peer in ACK frames */
+	QUIC_ECN_ACKED, /* ECN bits from packets newly ACKed */
+	QUIC_ECN_DIR_MAX
+};
+
+/* Represents a gap (range of missing packets) in the ACK map.  The values are
+ * offsets from base_pn, with both 'start' and 'end' being +1.
+ */
+struct quic_gap_ack_block {
+	u16 start;
+	u16 end;
+};
+
+/* Packet Number Map (pn_map) Layout:
+ *
+ *     min_pn_seen -->++-----------------------+---------------------+---
+ *         base_pn -----^   last_max_pn_seen --^       max_pn_seen --^
+ *
+ * Map Advancement Logic:
+ *   - min_pn_seen = last_max_pn_seen;
+ *   - base_pn = first zero bit after last_max_pn_seen;
+ *   - last_max_pn_seen = max_pn_seen;
+ *   - last_max_pn_time = current time;
+ *
+ * Conditions to Advance pn_map:
+ *   - (max_pn_time - last_max_pn_time) >= max_time_limit, or
+ *   - (max_pn_seen - last_max_pn_seen) > QUIC_PN_MAP_LIMIT
+ *
+ * Gap Search Range:
+ *   - From (base_pn - 1) to max_pn_seen
+ */
+struct quic_pnspace {
+	/* ECN counters indexed by dir and ECN codepoint (ECT1, ECT0, CE) */
+	u64 ecn_count[QUIC_ECN_DIR_MAX][QUIC_ECN_MAX];
+	unsigned long *pn_map; /* Received PN bitmap for ACK generation */
+	u16 pn_map_len;        /* Length of the PN bit map (in bits) */
+	u8  need_sack;         /* Flag indicating a SACK frame should be sent */
+	u8  sack_path;         /* Path used for sending the SACK frame */
+	u8  sack_pending;      /* Delayed ACK pending */
+
+	s64 last_max_pn_seen; /* Largest PN seen before pn_map advance */
+	u64 last_max_pn_time; /* Timestamp last_max_pn_seen was received */
+	s64 min_pn_seen;      /* Smallest PN received */
+	s64 max_pn_seen;      /* Largest PN received */
+	u64 max_pn_time;      /* Timestamp max_pn_seen was received */
+	s64 base_pn; /* PN corresponding to the start of the pn_map */
+	u64 time;    /* Cached now, or latest socket accept timestamp */
+
+	s64 max_pn_acked_seen; /* Largest PN ACKed by peer */
+	u64 max_pn_acked_time; /* Timestamp max_pn_acked_seen was ACKed */
+	u64 last_sent_time;    /* Timestamp last ack-eliciting packet sent */
+	u64 loss_time;         /* Timestamp the packet can be declared lost */
+	s64 next_pn;           /* Next PN to send */
+
+	u32 max_time_limit; /* Time threshold to trigger pn_map advance */
+	u32 inflight;       /* Ack-eliciting bytes in flight */
+};
+
+static inline void
+quic_pnspace_set_max_pn_acked_seen(struct quic_pnspace *space,
+				   s64 max_pn_acked_seen)
+{
+	if (space->max_pn_acked_seen >= max_pn_acked_seen)
+		return;
+	space->max_pn_acked_seen = max_pn_acked_seen;
+	space->max_pn_acked_time = quic_ktime_get_us();
+}
+
+static inline void quic_pnspace_set_base_pn(struct quic_pnspace *space, s64 pn)
+{
+	space->base_pn = pn;
+	space->max_pn_seen = space->base_pn - 1;
+	space->last_max_pn_seen = space->max_pn_seen;
+	space->min_pn_seen = space->max_pn_seen;
+
+	space->max_pn_time = space->time;
+	space->last_max_pn_time = space->max_pn_time;
+}
+
+static inline bool quic_pnspace_has_gap(const struct quic_pnspace *space)
+{
+	return space->base_pn != space->max_pn_seen + 1;
+}
+
+static inline void quic_pnspace_inc_ecn_acked(struct quic_pnspace *space,
+					      u8 ecn)
+{
+	if (!ecn)
+		return;
+	space->ecn_count[QUIC_ECN_ACKED][ecn - 1]++;
+}
+
+static inline void quic_pnspace_reset_ecn_acked(struct quic_pnspace *space)
+{
+	space->ecn_count[QUIC_ECN_ACKED][QUIC_ECN_ECT0] = 0;
+	space->ecn_count[QUIC_ECN_ACKED][QUIC_ECN_ECT1] = 0;
+	space->ecn_count[QUIC_ECN_ACKED][QUIC_ECN_CE] = 0;
+}
+
+static inline void quic_pnspace_inc_ecn_local(struct quic_pnspace *space,
+					      u8 ecn)
+{
+	if (!ecn)
+		return;
+	space->ecn_count[QUIC_ECN_LOCAL][ecn - 1]++;
+}
+
+/* Check if any ECN-marked packets were received. */
+static inline bool quic_pnspace_has_ecn_local(struct quic_pnspace *space)
+{
+	return space->ecn_count[QUIC_ECN_LOCAL][QUIC_ECN_ECT0] ||
+	       space->ecn_count[QUIC_ECN_LOCAL][QUIC_ECN_ECT1] ||
+	       space->ecn_count[QUIC_ECN_LOCAL][QUIC_ECN_CE];
+}
+
+/* Validate ECN counts received in an ACK. */
+static inline bool quic_pnspace_validate_ecn(struct quic_pnspace *space,
+					     u64 *ecn_count)
+{
+	u64 *acked = space->ecn_count[QUIC_ECN_ACKED];
+	u64 *peer = space->ecn_count[QUIC_ECN_PEER];
+	u64 ect0, ect1, ce;
+
+	if (peer[QUIC_ECN_ECT0] > ecn_count[QUIC_ECN_ECT0] ||
+	    peer[QUIC_ECN_ECT1] > ecn_count[QUIC_ECN_ECT1] ||
+	    peer[QUIC_ECN_CE] > ecn_count[QUIC_ECN_CE])
+		return false;
+
+	/* rfc9000#section-13.4.2.1:
+	 *
+	 * ECN validation also fails if the sum of the increase in ECT(0) and
+	 * ECN-CE counts is less than the number of newly acknowledged packets
+	 * that were originally sent with an ECT(0) marking (Same for ECT(1)).
+	 */
+	ect0 = ecn_count[QUIC_ECN_ECT0] - peer[QUIC_ECN_ECT0];
+	ect1 = ecn_count[QUIC_ECN_ECT1] - peer[QUIC_ECN_ECT1];
+	ce = ecn_count[QUIC_ECN_CE] - peer[QUIC_ECN_CE];
+
+	return ect0 + ce >= acked[QUIC_ECN_ECT0] &&
+	       ect1 + ce >= acked[QUIC_ECN_ECT1];
+}
+
+/* Updates the stored ECN counters based on values received in the peer's ACK
+ * frame. Each counter is updated only if the new value is higher.
+ *
+ * Returns: true if CE count was increased (congestion indicated), false
+ * otherwise.
+ */
+static inline bool quic_pnspace_set_ecn_peer(struct quic_pnspace *space,
+					     u64 *ecn_count)
+{
+	u64 *count = space->ecn_count[QUIC_ECN_PEER];
+
+	if (count[QUIC_ECN_ECT0] < ecn_count[QUIC_ECN_ECT0])
+		count[QUIC_ECN_ECT0] = ecn_count[QUIC_ECN_ECT0];
+	if (count[QUIC_ECN_ECT1] < ecn_count[QUIC_ECN_ECT1])
+		count[QUIC_ECN_ECT1] = ecn_count[QUIC_ECN_ECT1];
+	if (count[QUIC_ECN_CE] < ecn_count[QUIC_ECN_CE]) {
+		count[QUIC_ECN_CE] = ecn_count[QUIC_ECN_CE];
+		return true;
+	}
+	return false;
+}
+
+u16 quic_pnspace_num_gabs(struct quic_pnspace *space,
+			  struct quic_gap_ack_block *gabs);
+int quic_pnspace_check(struct quic_pnspace *space, s64 pn);
+int quic_pnspace_mark(struct quic_pnspace *space, s64 pn);
+
+void quic_pnspace_free(struct quic_pnspace *space);
+int quic_pnspace_init(struct quic_pnspace *space);
diff --git a/net/quic/socket.c b/net/quic/socket.c
index 04cfbddc0304..1dfa4791242e 100644
--- a/net/quic/socket.c
+++ b/net/quic/socket.c
@@ -42,6 +42,8 @@ static void quic_write_space(struct sock *sk)
 
 static int quic_init_sock(struct sock *sk)
 {
+	u8 i;
+
 	sk->sk_write_space = quic_write_space;
 	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
 
@@ -56,11 +58,21 @@ static int quic_init_sock(struct sock *sk)
 	if (quic_stream_init(quic_streams(sk)))
 		return -ENOMEM;
 
+	for (i = 0; i < QUIC_PNSPACE_MAX; i++) {
+		if (quic_pnspace_init(quic_pnspace(sk, i)))
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
 static void quic_destroy_sock(struct sock *sk)
 {
+	u8 i;
+
+	for (i = 0; i < QUIC_PNSPACE_MAX; i++)
+		quic_pnspace_free(quic_pnspace(sk, i));
+
 	quic_path_unbind(sk, quic_paths(sk), 0);
 	quic_path_unbind(sk, quic_paths(sk), 1);
 
diff --git a/net/quic/socket.h b/net/quic/socket.h
index 9201ca3edad0..68c7b22d1e88 100644
--- a/net/quic/socket.h
+++ b/net/quic/socket.h
@@ -12,6 +12,7 @@
 #include <linux/quic.h>
 
 #include "common.h"
+#include "pnspace.h"
 #include "family.h"
 #include "stream.h"
 #include "connid.h"
@@ -43,6 +44,7 @@ struct quic_sock {
 	struct quic_conn_id_set		dest;
 	struct quic_path_group		paths;
 	struct quic_cong		cong;
+	struct quic_pnspace		space[QUIC_PNSPACE_MAX];
 };
 
 struct quic6_sock {
@@ -105,6 +107,11 @@ static inline struct quic_cong *quic_cong(const struct sock *sk)
 	return &quic_sk(sk)->cong;
 }
 
+static inline struct quic_pnspace *quic_pnspace(const struct sock *sk, u8 level)
+{
+	return &quic_sk(sk)->space[level % QUIC_CRYPTO_EARLY];
+}
+
 static inline bool quic_is_establishing(struct sock *sk)
 {
 	return sk->sk_state == QUIC_SS_ESTABLISHING;
-- 
2.47.1


