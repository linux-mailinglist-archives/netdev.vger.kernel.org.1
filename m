Return-Path: <netdev+bounces-305756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bd7ANGUoTmoUEQIAu9opvQ
	(envelope-from <netdev+bounces-305756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:37:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E3724662
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:37:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CtN9rxaq;
	dkim=pass header.d=redhat.com header.s=google header.b=mHSXlZT8;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305756-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305756-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE6F7309B48E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6161042253E;
	Wed,  8 Jul 2026 10:29:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA94218A6
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:29:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506565; cv=none; b=Fk3AjYIM++4kbCqjqDMu2WcE0PlWBsMHN5oySI6VWJO2LkkJ8yQ0hyYkzEHmvsCgx9c0pzQmnK3TQpLoO6cmniSX5JxeSADS82IWxAV1iQ/jGPQQqoPM5n15sLY4uOa0KI6uWq7LU+S0U8yebp5dR30cRNaesjLJpFrPwWOmbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506565; c=relaxed/simple;
	bh=4Ioj+uXwmlNtFGd3w9E4QvxQHEehHS7LxUvD6BHqD3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlKkXO1KKyPmFK+Pm4xHDTMkoy/290JqxN142gO/i9Qb0FpeEa/NmOq1sOXUy3lDeNqjDIvLAyO9ucmsRT0UmpgRRPmBSgCrWzJR3EQlAaD96LE4wKsdvtcz1O5jEdFU5e0HM3uFkLLYKS1OHQi+UGWqpg4WFM8CLgG8GIyF7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtN9rxaq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mHSXlZT8; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783506555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeIXOWju9kpJlG84+jBij7M8XqoyvMRFU8kzphZpY1c=;
	b=CtN9rxaqWL9oYOuh5R3nS5YnPf8XNBsIlAqnal3+iKS62KpEuE2wq+wbMYmiTpq48W9GCS
	Epicaji/I3Oow+YOZs+cBC0mHleGOe8SMCXQq+YADzOyD7g/i08RgJJmm4QlZsUV+zV3M3
	4TAHI8lmgD/VNej/0ME/XKniRp7d5Ts=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-sJxdEJOdPmGPSJT3SYkfLw-1; Wed, 08 Jul 2026 06:29:14 -0400
X-MC-Unique: sJxdEJOdPmGPSJT3SYkfLw-1
X-Mimecast-MFC-AGG-ID: sJxdEJOdPmGPSJT3SYkfLw_1783506553
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-473f4a48e9aso388840f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783506553; x=1784111353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeIXOWju9kpJlG84+jBij7M8XqoyvMRFU8kzphZpY1c=;
        b=mHSXlZT8KnvAZcy711jz5+Jv2hR/lF93k+JS3BlWwqy60RGMRp7LL0Iijsjb0bd4Zi
         h4GZEP0sh1t2EPLNYyrQuJDnI4vWlWmpE9svV+ky/UZCx4irCm5icgVqEyLDs0fpyGq3
         AniuwdJ8yBFG3GSJv+HC6+gKuro62GQoRXfIeMnwjrjnK/DfpfIsAZwVxOKN/QY93vI2
         RLJqP+/aHC609rgqMhhfwH8hEHd++OK+yMPAuLSrtlBHUc5F2YISQfWByXm5lkAwqF8P
         s6Gx+rSYDqKDSuBbSYPpPvSL+K0BSkUQyRMlLGZRgDoeXRX3O6in9ZvvVYSJqDPC0GOX
         rqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506553; x=1784111353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QeIXOWju9kpJlG84+jBij7M8XqoyvMRFU8kzphZpY1c=;
        b=BP5RGsQsOgi4nEuo95VuP4RT3wDPP+uD6/LVd6dl+/5b50/ym1H5PCmoBBqjhiyJG4
         W6Du6AQyRhUjqx6U8RlCccsonqHfCRjG00HqzQDRjwUxdxhrmJ813Mc41UOdB7bAE5xc
         Ola58jqVVNVy3UKNmp1ar83H46Pn3cQ0souMXdZwhn7FnFl3MXJNTeCK0jP1kEbQaEvu
         zvEZT1zPyFGAjCKLyix4JqCxOpc+2Gx88kG4wm4za5GC66xJFR3uyVURt1quZSSMB3F3
         zhnQXvi0xRgPMjH1g1Z8ugKNunVnFbw7QPS7mr2uD5MG+73T8OX4Jp4zhTnS+vBUNK04
         /6xA==
X-Gm-Message-State: AOJu0Yx/3xSSGf1LiGvq98D8ucq3e5hz8WF4ZarXVnIZk20P1NA56r3J
	jVojiF2dzmqLNcR8GiKLHlw9kkUbQGpmxAy1T88/PcYqIKjILZGaczQlIft9ZN6DLfmMVijsc3+
	uWc3rClGJeVEQ/xwN0T9aMPPl8/NfWgNYwulaj/SjeRyqn1VBVoessISvbd+1CXWp/c1aA8AFVG
	AxOSP41xdyAoNXxvqTyhrdgWqzPzImCboRerJjiiIeVA==
X-Gm-Gg: AfdE7cmdbX3O0O6v9T2vz4Dy+EJouiIVVsx5F7Y7oi5DuCyhy7GbuZcOMTGbMH1v0EB
	3uCll81XbpgGmeyZsDgNmFPo6e8RgJpn4X14GZiF3ikH2VZi1qp6e7eL504APwrmmdlgjF3CHNQ
	JxGgnRuyyqps5dc5CNItICoFyKbc6ysvT8FWRq6hQTxNGpt0nm3LUdyMPnB2SPvSFgn3TWReGWb
	SKcgAVCwMUCznTQtg7+UOvJHjw+RxGDxgWt7DNpJNM5tLEK5uM1aC+6kHikEE67tV/HPsoUyjAH
	GX2BEjwtALm9TKvOQhfVi+nf3ejYI+uXfvdAlzH6Z8uRRYdyNEKm3KGLIE5ZuPNcWmH6MWAvNBe
	fqr5w2AOPIaSv3SO5QpQ7nDDk6cHCpjigIZDzg/kuEGFLmSo=
X-Received: by 2002:a05:6000:310c:b0:475:f0c2:5afb with SMTP id ffacd0b85a97d-47df078bf3fmr2020568f8f.49.1783506552671;
        Wed, 08 Jul 2026 03:29:12 -0700 (PDT)
X-Received: by 2002:a05:6000:310c:b0:475:f0c2:5afb with SMTP id ffacd0b85a97d-47df078bf3fmr2020485f8f.49.1783506551889;
        Wed, 08 Jul 2026 03:29:11 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm43045414f8f.2.2026.07.08.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:29:11 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	stable@vger.kernel.org,
	Brien Oberstein <brienpub@gmail.com>
Subject: [PATCH net v2 1/2] vsock/virtio: collapse receive queue under memory pressure
Date: Wed,  8 Jul 2026 12:29:03 +0200
Message-ID: <20260708102904.50732-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708102904.50732-1-sgarzare@redhat.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305756-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,linux.alibaba.com,google.com,kernel.org,davemloft.net,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jasowangio@gmail.com,m:sgarzare@redhat.com,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:eperezma@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:kvm@vger.kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:kuba@kernel.org,m:jasowang@redhat.com,m:stable@vger.kernel.org,m:brienpub@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 465E3724662

From: Stefano Garzarella <sgarzare@redhat.com>

When many small packets accumulate in the receive queue, the skb overhead
can exceed buf_alloc even while the payload is within bounds. This causes
virtio_transport_inc_rx_pkt() to reject packets, leading to connection
resets during large transfers under backpressure.

The issue was reported by Brien, who has a reproducer, but it is also
easily reproducible with iperf-vsock [1] using a small packet size:

  iperf3 --vsock -c $CID -l 129

which fails immediately without this patch but with commit 059b7dbd20a6
("vsock/virtio: fix potential unbounded skb queue").

Inspired by TCP's tcp_collapse() which solves a similar problem, add
virtio_transport_collapse_rx_queue() that walks the receive queue and
re-copies data into compact linear skbs to reduce the overhead.

The collapse is triggered proactively from when the number of skb queued
is close to exceeding the overhead budget.

A pre-scan counts the eligible bytes to size each allocation precisely,
avoiding waste for isolated small packets. Partially consumed skbs are
kept as-is to preserve buf_used/fwd_cnt accounting, EOM-marked skbs to
maintain SEQPACKET message boundaries, and skbs already larger than the
collapse target because they already have a good data-to-overhead ratio.

Walking a large queue may take a significant amount of time and cache
misses, causing traffic burstiness. To limit this, the collapse stops
once enough room is freed for this packet and the next one, but may
opportunistically free more to fill each collapsed skb to capacity.

[1] https://github.com/stefano-garzarella/iperf-vsock

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Cc: stable@vger.kernel.org
Reported-by: Brien Oberstein <brienpub@gmail.com>
Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
Tested-by: Brien Oberstein <brienpub@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- defined MAX_COLLAPSE_LEN macro instead of using a variable [Paolo]
- added a threshold to avoid walking all the queue while collapsing
  [Paolo]
- collapsed the queue before calling virtio_transport_inc_rx_pkt().
  While working on the threshold, I figured out that the check I was
  introducing can also be used to proactively trigger the collapse, so I
  moved the call to virtio_transport_collapse_rx_queue() before acquiring
  the rx_lock to have also a better diff to simplify backports
- improved code readability (removed `out` label, `keep` initialization,
  etc.) [Paolo + other small stuff]
- Brien kindly retested this version as well (thank you so much)
---
 net/vmw_vsock/virtio_transport_common.c | 165 +++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 09475007165b..8becad81279c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -26,6 +26,13 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+/* Max payload that can be collapsed into a single linear skb, using the same
+ * allocation threshold as virtio_vsock_alloc_skb() to avoid adding pressure
+ * on the page allocator.
+ */
+#define MAX_COLLAPSE_LEN \
+	SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM, PAGE_ALLOC_COSTLY_ORDER)
+
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout);
 static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
@@ -420,6 +427,145 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	return ret;
 }
 
+static bool virtio_transport_can_collapse(struct sk_buff *skb)
+{
+	/* skbs that are partially consumed, mark a SEQPACKET message boundary,
+	 * or are already large enough should not be collapsed: they either
+	 * need special accounting, carry protocol state, or already have a
+	 * good data-to-overhead ratio.
+	 */
+	if (VIRTIO_VSOCK_SKB_CB(skb)->offset)
+		return false;
+	if (le32_to_cpu(virtio_vsock_hdr(skb)->flags) & VIRTIO_VSOCK_SEQ_EOM)
+		return false;
+	if (skb->len >= MAX_COLLAPSE_LEN)
+		return false;
+	return true;
+}
+
+/* Iterate through the packets in the queue starting from the current skb to
+ * count the number of bytes we can collapse.
+ */
+static unsigned int
+virtio_transport_collapse_size(struct sk_buff *skb, struct sk_buff_head *queue)
+{
+	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+
+	while ((skb = skb_peek_next(skb, queue)) &&
+	       virtio_transport_can_collapse(skb)) {
+		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+
+		if (len > MAX_COLLAPSE_LEN - target)
+			return target;
+
+		target += len;
+	}
+
+	return target;
+}
+
+/* Called under lock_sock to compact the receive queue by merging small skbs.
+ * @min_to_free: minimum number of skbs to eliminate from the queue. May free
+ *               more to fill each collapsed skb to capacity.
+ */
+static void
+virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
+				   u32 min_to_free)
+{
+	struct sk_buff *skb, *next_skb, *new_skb = NULL;
+	struct sk_buff_head new_queue;
+	u32 saved = 0;
+
+	__skb_queue_head_init(&new_queue);
+
+	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {
+		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
+		u32 src_len = skb->len - src_off;
+		bool keep;
+
+		keep = !virtio_transport_can_collapse(skb);
+		if (keep) {
+			/* Finalize pending collapsed skb to preserve packet
+			 * ordering.
+			 */
+			if (new_skb) {
+				__skb_queue_tail(&new_queue, new_skb);
+				new_skb = NULL;
+				saved--;
+			}
+			goto next;
+		}
+
+		/* Finalize if this packet won't fit in the remaining tailroom,
+		 * so we can allocate a right-sized new_skb.
+		 */
+		if (new_skb && src_len > skb_tailroom(new_skb)) {
+			__skb_queue_tail(&new_queue, new_skb);
+			new_skb = NULL;
+			saved--;
+		}
+
+		if (!new_skb) {
+			unsigned int alloc_size;
+
+			/* Check after finalizing to opportunistically fill
+			 * each collapsed skb to capacity, merging more skbs
+			 * than strictly required.
+			 */
+			if (saved >= min_to_free)
+				break;
+
+			alloc_size = virtio_transport_collapse_size(skb, &vvs->rx_queue);
+
+			/* Only this skb's data is eligible, nothing to merge
+			 * with. Keep as-is.
+			 */
+			if (alloc_size <= src_len) {
+				keep = true;
+				goto next;
+			}
+
+			new_skb = virtio_vsock_alloc_linear_skb(alloc_size +
+					VIRTIO_VSOCK_SKB_HEADROOM, GFP_KERNEL);
+			if (!new_skb)
+				break;
+
+			memcpy(virtio_vsock_hdr(new_skb), hdr,
+			       sizeof(struct virtio_vsock_hdr));
+			virtio_vsock_hdr(new_skb)->len = 0;
+		}
+
+		/* Cannot fail since src_off/src_len are within bounds, but if
+		 * it does, discard new_skb to avoid queuing corrupted data.
+		 */
+		if (WARN_ON_ONCE(skb_copy_bits(skb, src_off,
+					       skb_put(new_skb, src_len),
+					       src_len))) {
+			kfree_skb(new_skb);
+			new_skb = NULL;
+			break;
+		}
+
+		le32_add_cpu(&virtio_vsock_hdr(new_skb)->len, src_len);
+		virtio_vsock_hdr(new_skb)->flags |= hdr->flags;
+
+next:
+		__skb_unlink(skb, &vvs->rx_queue);
+		if (keep) {
+			__skb_queue_tail(&new_queue, skb);
+		} else {
+			consume_skb(skb);
+			saved++;
+		}
+	}
+
+	if (new_skb)
+		__skb_queue_tail(&new_queue, new_skb);
+
+	skb_queue_splice(&new_queue, &vvs->rx_queue);
+}
+
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
@@ -1354,12 +1500,29 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	bool can_enqueue, free_pkt = false;
+	u32 len, queue_max, queue_len;
 	struct virtio_vsock_hdr *hdr;
-	u32 len;
 
 	hdr = virtio_vsock_hdr(skb);
 	len = le32_to_cpu(hdr->len);
 
+	/* virtio_transport_inc_rx_pkt() rejects packets when the per-skb
+	 * overhead (skb_queue_len * SKB_TRUESIZE(0)) exceeds buf_alloc.
+	 * Proactively collapse the queue before that happens.
+	 * No rx_lock needed: lock_sock is held by caller, preventing
+	 * concurrent enqueue or dequeue.
+	 */
+	queue_max = vvs->buf_alloc / SKB_TRUESIZE(0);
+	queue_len = skb_queue_len(&vvs->rx_queue);
+	if (queue_len >= queue_max) {
+		/* Walking a large queue may take a significant amount of time
+		 * and cache misses, causing traffic burstiness. Limit the
+		 * collapse to freeing room for this packet and the next one.
+		 * It may free more to fill each collapsed skb to capacity.
+		 */
+		virtio_transport_collapse_rx_queue(vvs, queue_len + 2 - queue_max);
+	}
+
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-- 
2.55.0


