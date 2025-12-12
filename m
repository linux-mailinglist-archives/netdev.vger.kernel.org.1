Return-Path: <netdev+bounces-244481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2050CCB8A2F
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9179304D0F5
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAD311C10;
	Fri, 12 Dec 2025 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGcdxemN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lqwlyEO/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4E2D5A16
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765536049; cv=none; b=VYZg4LE6zp6y5mqH5E3EjNYkvcHEOHwlZAkz1AcDUk4kw7y8Mc3rXYLQ8Gk/Davw4BitW+ZQkFHkYzTxBT84i0wfEJEU2fhU1QPU8J41/vMnmNlV8hGDpjFYVJVcdg2NU4Dm0xCiISNbnGwTAnfU938+xFizWn64JJ9bRq6ZvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765536049; c=relaxed/simple;
	bh=juHhcADP8tSX/U+Hzz1qM4RQI3ZNmRL0KWC/XVrAlqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3Wrbi/u1yMRxhBaNRrII0nI37TYrTnCVpbz+LqgGEyMypQw4JIxl0YAO+U0Z5lTrYsObcY92Ok+zizciCUaXHeR+igIi6MypvGrfONkVmw9jgmvLAbaNzlmBMe6aiMhqqJL4B9INyMFFmP0CtTXjfmqe7yi4XFv2qajm/QJLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGcdxemN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lqwlyEO/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765536046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btMp3bkAYfxz34CrZuJ4KKYXKtJJ+/4EuQmWIkdS/mQ=;
	b=OGcdxemN4DOa72sGoYka3K9kDwKYjSHeccM8IAfOWfegKkt4vAKo3Aokr425tYFzP4MksG
	pdGiLChnlt/9kD5RsAwR+bJwq0SrtviJEXOwf/IS8LuOa3mClc6RDw08U0ykpYaZ+xYq6Y
	1DxWe3sMLklRU69cGsJFjJAjJrOwS7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-BAVPnhBRNjiqUWSZoeainQ-1; Fri, 12 Dec 2025 05:40:44 -0500
X-MC-Unique: BAVPnhBRNjiqUWSZoeainQ-1
X-Mimecast-MFC-AGG-ID: BAVPnhBRNjiqUWSZoeainQ_1765536044
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d110fabso6538025e9.1
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765536043; x=1766140843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=btMp3bkAYfxz34CrZuJ4KKYXKtJJ+/4EuQmWIkdS/mQ=;
        b=lqwlyEO/Ikrafs7vZImffzzlTBsFpuBO0HwEqpqmQ3KSFKmASLetnhoQgqxrNPn9hf
         tYSorRBBtQKCQgdWN4DF+uYvKVg6lOsQ8xb9owasRXXlUHWxXxKvmhNJJEKKCa/RBG0P
         c2lxxcGruKyURmg9+/cm8whSMOA25+M2h9a77Gu3vi+ebPPuqfdQedELBBPrGZPJXX7o
         qqMLn5sDMdfSGoZK0aHE5A7cBaPQnne7kg5BmcrD+c+DDgK6JE+r/gd/2IZwNHT2EB0i
         O+NbfEk9R8ZUiOjOFHa8eVG9icVTJ7czd8icH+wMWsumqJ8cqP3FImIsqFyZt2gllarZ
         zYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765536043; x=1766140843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btMp3bkAYfxz34CrZuJ4KKYXKtJJ+/4EuQmWIkdS/mQ=;
        b=AEtgDTAdeGYYS7gBR1KtGpaf1Tu4/b4uTjCgu2OnwXQgLY+R5Y9S9mJgsLrf3sH788
         JYy86CY+CoiLCoGsddd3qVqmt0A/hCqhOlSiYDQ3YR5vfobmZasP8ZDe6a4Emrq5qoAF
         +thN8SpD3eNfJKyxFIf2d4Ymynemdh055j8Ov0LigvyfcACDRdCtDOteAa21UHQiX0zr
         hjtY80k/C6jHieVHAzRiCfS+dyZ2FUuVpfbM7/5eBs3MFX25I/okivuvuebQq2hT1Icn
         uUcdGMY8Iscen2iHqajDaUcoT5bJSsbwGPl6D+wKLNG69J9awTbKqwG68YG7t3PYsJBv
         7Mrw==
X-Forwarded-Encrypted: i=1; AJvYcCU2qKA/osfzgIk98AmgPRKUU0S6Jgp863VKf8BBE5UENBpSbz9FoR1OCgPF1I4k+cCuGJu32qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MXssrwMGH8aIeuPGogtf8vQ4jkfVxDZrSZn599q6WSGEu51D
	YbSX8Txqn5wkrD1w1HSHaZq2+eELVmk2YRF4F/0qzunD8uWOBuoPCzw4uoRrlnnRGeG4FTc2ZXj
	qK5sld8KYY386/cy7IOxCCrVUUgBwpFLcS6MWwASvbW9NDtG2wf3+IfWwVA==
X-Gm-Gg: AY/fxX6i54b//WqICRvnYwCIKIloO7EtjiaCGCc7bnTBxfxHKrBjbi44NoRMDp+jfn1
	0ElazuH/Oerij/woH4C8LjH9OGGn+0nBoEoCXKLeLt5UpnToK8Pgak9Z4QafrMutbhMOgpmmiiN
	tU1n1Q0IazKfaKY1mFIH3rc3P8fB0vRDTYB1smKs7BeeZWBSCCj3mZJGCVoeTdyl0YYQ6bPFIUS
	w3i8B4h4+0YDR6WPpg4l2mO79/5m8Uj+uovJQkcWqtQhUq+OcS+NsvYK83JcLlUxE9+G1IZwISg
	XSCeUB85zpguetIHBb1CXcfjlCmL+OKAIu8ST08TqlNIqWnyA6kVaZuldgG2HvyPk432wGokIWw
	NTiQrT6+1m/eJxPpXxPvKHZVZmsV9TwiQiWQp17RcHLx17B2dRFzOVlSYvPcZtQ==
X-Received: by 2002:a05:600c:4f4a:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-47a8f8a717dmr17072775e9.7.1765536043597;
        Fri, 12 Dec 2025 02:40:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnx0bmUc/ydNQn5LSl5u0NC7NieI6tARPsnRE+HvfZJmOj/MEYoW4ZaY3zSqQw060VHGGH9w==
X-Received: by 2002:a05:600c:4f4a:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-47a8f8a717dmr17072405e9.7.1765536043061;
        Fri, 12 Dec 2025 02:40:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6f118esm10057005e9.3.2025.12.12.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 02:40:41 -0800 (PST)
Date: Fri, 12 Dec 2025 11:40:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin Mathew Antony <mlbnkm1@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Message-ID: <bwmol6raorw233ryb3dleh4meaui5vbe7no53boixckl3wgclz@s6grefw5dqen>
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
 <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
 <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
 <CAGxU2F7WOLs7bDJao-7Qd=GOqj_tOmS+EptviMphGqSrgsadqg@mail.gmail.com>
 <CAMKc4jDLdcGsL5_d+4CP6n-57s-R0vzrX2M7Ni=1GeCB1cxVYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMKc4jDLdcGsL5_d+4CP6n-57s-R0vzrX2M7Ni=1GeCB1cxVYA@mail.gmail.com>

On Fri, Dec 12, 2025 at 09:56:28AM +0000, Melbin Mathew Antony wrote:
>Hi Stefano, Michael,
>
>Thanks for the suggestions and guidance.

You're welcome, but please avoid top-posting in the future:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

>
>I’ve drafted a 4-part series based on the recap. I’ve included the
>four diffs below for discussion. Can wait for comments, iterate, and
>then send the patch series in a few days.
>
>---
>
>Patch 1/4 — vsock/virtio: make get_credit() s64-safe and clamp negatives
>
>virtio_transport_get_credit() was doing unsigned arithmetic; if the
>peer shrinks its window, the subtraction can underflow and look like
>“lots of credit”. This makes it compute “space” in s64 and clamp < 0
>to 0.
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c
>b/net/vmw_vsock/virtio_transport_common.c
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -494,16 +494,23 @@ EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
>+ s64 bytes;
>  u32 ret;
>
>  if (!credit)
>  return 0;
>
>  spin_lock_bh(&vvs->tx_lock);
>- ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>- if (ret > credit)
>- ret = credit;
>+ bytes = (s64)vvs->peer_buf_alloc -

Why not just calling virtio_transport_has_space()?

>+ ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>+ if (bytes < 0)
>+ bytes = 0;
>+
>+ ret = min_t(u32, credit, (u32)bytes);
>  vvs->tx_cnt += ret;
>  vvs->bytes_unsent += ret;
>  spin_unlock_bh(&vvs->tx_lock);
>
>  return ret;
> }
>
>
>---
>
>Patch 2/4 — vsock/virtio: cap TX window by local buffer (helper + use
>everywhere in TX path)
>
>Cap the effective advertised window to min(peer_buf_alloc, buf_alloc)
>and use it consistently in TX paths (get_credit, has_space,
>seqpacket_enqueue).
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c
>b/net/vmw_vsock/virtio_transport_common.c
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -491,6 +491,16 @@ void virtio_transport_consume_skb_sent(struct
>sk_buff *skb, bool consume)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>+/* Return the effective peer buffer size for TX credit computation.
>+ *
>+ * The peer advertises its receive buffer via peer_buf_alloc, but we cap it
>+ * to our local buf_alloc (derived from SO_VM_SOCKETS_BUFFER_SIZE and
>+ * already clamped to buffer_max_size).
>+ */
>+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>+{
>+ return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>+}
>
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
>  s64 bytes;
>@@ -502,7 +512,8 @@ u32 virtio_transport_get_credit(struct
>virtio_vsock_sock *vvs, u32 credit)
>  return 0;
>
>  spin_lock_bh(&vvs->tx_lock);
>- bytes = (s64)vvs->peer_buf_alloc -
>+ bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>  ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>  if (bytes < 0)
>  bytes = 0;
>@@ -834,7 +845,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>  spin_lock_bh(&vvs->tx_lock);
>
>- if (len > vvs->peer_buf_alloc) {
>+ if (len > virtio_transport_tx_buf_alloc(vvs)) {
>  spin_unlock_bh(&vvs->tx_lock);
>  return -EMSGSIZE;
>  }
>@@ -884,7 +895,8 @@ static s64 virtio_transport_has_space(struct
>vsock_sock *vsk)
>  struct virtio_vsock_sock *vvs = vsk->trans;
>  s64 bytes;
>
>- bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+ bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>+ ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>  if (bytes < 0)
>  bytes = 0;
>
>  return bytes;
> }
>
>
>---
>
>Patch 3/4 — vsock/test: fix seqpacket msg bounds test (set client buf too)

Please just include in the series the patch I sent to you.

>
>After fixing TX credit bounds, the client can fill its TX window and
>block before it wakes the server. Setting the buffer on the client
>makes the test deterministic again.
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -353,6 +353,7 @@ static void test_stream_msg_peek_server(const
>struct test_opts *opts)
>
> static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> {
>+ unsigned long long sock_buf_size;
>  unsigned long curr_hash;
>  size_t max_msg_size;
>  int page_size;
>@@ -366,6 +367,18 @@ static void
>test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>  exit(EXIT_FAILURE);
>  }
>
>+ sock_buf_size = SOCK_BUF_SIZE;
>+
>+ setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+    sock_buf_size,
>+    "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>+
>+ setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+    sock_buf_size,
>+    "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+
>  /* Wait, until receiver sets buffer size. */
>  control_expectln("SRVREADY");
>
>
>---
>
>Patch 4/4 — vsock/test: add stream TX credit bounds regression test
>
>This directly guards the original failure mode for stream sockets: if
>the peer advertises a large window but the sender’s local policy is
>small, the sender must stall quickly (hit EAGAIN in nonblocking mode)
>rather than queueing megabytes.

Yeah, using nonblocking mode LGTM!

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -349,6 +349,7 @@
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
>+#define SMALL_SOCK_BUF_SIZE (64 * 1024ULL)
> #define MAX_MSG_PAGES 4
>
> /* Insert new test functions after test_stream_msg_peek_server, before
>  * test_seqpacket_msg_bounds_client (around line 352) */
>
>+static void test_stream_tx_credit_bounds_client(const struct test_opts *opts)
>+{
>+ ... /* full function as provided */
>+}
>+
>+static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
>+{
>+ ... /* full function as provided */
>+}
>
>@@ -2224,6 +2305,10 @@
>  .run_client = test_stream_msg_peek_client,
>  .run_server = test_stream_msg_peek_server,
>  },
>+ {
>+ .name = "SOCK_STREAM TX credit bounds",
>+ .run_client = test_stream_tx_credit_bounds_client,
>+ .run_server = test_stream_tx_credit_bounds_server,
>+ },

Please put it at the bottom. Tests are skipped by index, so we don't 
want to change index of old tests.

Please fix your editor, those diffs are hard to read without 
tabs/spaces.

Thanks,
Stefano


