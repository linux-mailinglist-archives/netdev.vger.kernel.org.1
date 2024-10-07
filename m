Return-Path: <netdev+bounces-132884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DABB993A09
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBBD1C23601
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6396A1DCB2B;
	Mon,  7 Oct 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NjEK3HK2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590E19993D
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339406; cv=none; b=iXXq3A+fWvYZAa3Cmvq9QdK+wJA3T8R6DqKA/mYzyQQjkU4t//YDbaLBaA28zGSbjoXeJNPBRv5mCPQe3zNygg4CmRvS/oGhzPXlH660DjZ8FJTXqQu/BEr295eJ4cpV0X6hIJq/ibjqBxcmAFahjGyx/QcJHoLcQz1MRd9uu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339406; c=relaxed/simple;
	bh=pUIpk8i1wQ1Q/0z8XtuP2bi46yAb28sOlJ9m1HZABoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eyy44cz+GwIIg1ii872e4qyiwcatCyz+0kmxNWDwcCy+adnRH217fTTcBDJITxqn/tpaq4iVORmoO2M5zLMSTiBRAqYFc0vGClRV3GvKpIUToO1pzR6UGt9ATvYBIRcn6JOZRBuimqtMb+bOgjag1GwPZbdINbYpK3O7vCQYiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NjEK3HK2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b95359440so41944185ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1728339402; x=1728944202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43HapEXGd6Lc5X5h6j6PBqWrgQK7wPQguqF5TQ9rKgg=;
        b=NjEK3HK2BUxW7VpwoHMC8v3dYHNpogoiYTd7DIDzSfkNgBFDIk1H0xG+9XeJuAfNw3
         sFJNI+mSQ0ZWXD5jyOsTEhfeLaIW36Al50bTG+2+cZyOTJtQLMWyQnAro8KPoiAzLu89
         9HhBU07uPgPfyDWyQK6i4CrgmcWqzvbfjlDEcGSL9DlffTh8BXkgX+CoMNJoGV7olsxo
         VnOCwW/nU6abk0xXgjfCo1CIOsyjYdX9yUvXbJbdHibUFggK0VPqZqqfHIxFp2lXu4WE
         CNXAF+ilVHNEOBwdSKoALp8XS6ngOKrczaBHUJVGhubEK0vUKnA8kr2BoAffp9OUlMzF
         dX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339402; x=1728944202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43HapEXGd6Lc5X5h6j6PBqWrgQK7wPQguqF5TQ9rKgg=;
        b=MugJDAC2GaG42okXriMCJin9sibr636Zicbj84tOnNgj0WL2aD/78+Jl+Vjv6XbD5Z
         2r2q5JD0N1kMvREzsuYH2+NxPhhGU7Bmybmo2CnMP/ByJbvuNFYTnPwi09tOuR54AI3E
         KPNk/Y3/Un1u3zR4SNBkxk7nxkrvo/Itgf/ekESnju64t47zlYBXrICSQ9Z6bpv4WBGG
         KAFoM4B4+0c+W+TrNq882b3CO+ZSXcE3zgFOaLKq9D5Ld0dJoz5BothZEdsGs8R+m4zy
         o69WLO2+mser35JucjQu06dwWHInkHCxpau0O2EyY3Uo2vy3vbS+dqSa3UK0lbQTsud0
         hSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8m+jnYbdASZYLlr4X9C/IvA8mhUiRdCFBc0fH3e/M1XDbsGOU6tQBpBAFwgy2t2r2kDu7wiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9fIPNSfbfghIdgPzL0cJ6A7DZro73vc3803FKCWi8ygmrBJA
	S04xtRWnc5o6dVf+3aozH0rLV2at+MZVcTUkqWz3INEKqaIFr+hxttbVAzFv9tvVSBsU/gTN60k
	J
X-Google-Smtp-Source: AGHT+IHC+h7Hwu+SYTbh5uEKgKtA0wwimvtjrNHm4Z7C5dM9mz+BX1pjVZCPkdbYvZPp6CJp3hGbfg==
X-Received: by 2002:a17:902:f541:b0:20b:983c:f095 with SMTP id d9443c01a7336-20bff04cdf0mr182503845ad.51.1728339402411;
        Mon, 07 Oct 2024 15:16:42 -0700 (PDT)
Received: from localhost (fwdproxy-prn-039.fbsv.net. [2a03:2880:ff:27::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b236fsm44338085ad.19.2024.10.07.15.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:16:41 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH v1 12/15] io_uring/zcrx: add io_recvzc request
Date: Mon,  7 Oct 2024 15:16:00 -0700
Message-ID: <20241007221603.1703699-13-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241007221603.1703699-1-dw@davidwei.uk>
References: <20241007221603.1703699-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add io_uring opcode OP_RECV_ZC for doing zero copy reads out of a
socket. Only the connection should be land on the specific rx queue set
up for zero copy, and the socket must be handled by the io_uring
instance that the rx queue was registered for zero copy with. That's
because neither net_iovs / buffers from our queue can be read by outside
applications, nor zero copy is possible if traffic for the zero copy
connection goes to another queue. This coordination is outside of the
scope of this patch series. Also, any traffic directed to the zero copy
enabled queue is immediately visible to the application, which is why
CAP_NET_ADMIN is required at the registeration step.

Of course, no data is actually read out of the socket, it has already
been copied by the netdev into userspace memory via DMA. OP_RECV_ZC
reads skbs out of the socket and checks that its frags are indeed
net_iovs that belong to io_uring. A cqe is queued for each one of these
frags.

Recall that each cqe is a big cqe, with the top half being an
io_uring_zcrx_cqe. The cqe res field contains the len or error. The
lower IORING_ZCRX_AREA_SHIFT bits of the struct io_uring_zcrx_cqe::off
field contain the offset relative to the start of the zero copy area.
The upper part of the off field is trivially zero, and will be used
to carry the area id.

For now, there is no limit as to how much work each OP_RECV_ZC request
does. It will attempt to drain a socket of all available data. This
request always operates in multishot mode.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/uapi/linux/io_uring.h |   2 +
 io_uring/io_uring.h           |  10 ++
 io_uring/net.c                |  78 +++++++++++++++
 io_uring/opdef.c              |  16 +++
 io_uring/zcrx.c               | 180 ++++++++++++++++++++++++++++++++++
 io_uring/zcrx.h               |  11 +++
 6 files changed, 297 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ffd315d8c6b5..c9c9877f2ba7 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -87,6 +87,7 @@ struct io_uring_sqe {
 	union {
 		__s32	splice_fd_in;
 		__u32	file_index;
+		__u32	zcrx_ifq_idx;
 		__u32	optlen;
 		struct {
 			__u16	addr_len;
@@ -259,6 +260,7 @@ enum io_uring_op {
 	IORING_OP_FTRUNCATE,
 	IORING_OP_BIND,
 	IORING_OP_LISTEN,
+	IORING_OP_RECV_ZC,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index c2acf6180845..8cec53a63c39 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -171,6 +171,16 @@ static inline bool io_get_cqe(struct io_ring_ctx *ctx, struct io_uring_cqe **ret
 	return io_get_cqe_overflow(ctx, ret, false);
 }
 
+static inline bool io_defer_get_uncommited_cqe(struct io_ring_ctx *ctx,
+					       struct io_uring_cqe **cqe_ret)
+{
+	io_lockdep_assert_cq_locked(ctx);
+
+	ctx->cq_extra++;
+	ctx->submit_state.cq_flush = true;
+	return io_get_cqe(ctx, cqe_ret);
+}
+
 static __always_inline bool io_fill_cqe_req(struct io_ring_ctx *ctx,
 					    struct io_kiocb *req)
 {
diff --git a/io_uring/net.c b/io_uring/net.c
index d08abcca89cc..482e138d2994 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -16,6 +16,7 @@
 #include "net.h"
 #include "notif.h"
 #include "rsrc.h"
+#include "zcrx.h"
 
 #if defined(CONFIG_NET)
 struct io_shutdown {
@@ -89,6 +90,13 @@ struct io_sr_msg {
  */
 #define MULTISHOT_MAX_RETRY	32
 
+struct io_recvzc {
+	struct file			*file;
+	unsigned			msg_flags;
+	u16				flags;
+	struct io_zcrx_ifq		*ifq;
+};
+
 int io_shutdown_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_shutdown *shutdown = io_kiocb_to_cmd(req, struct io_shutdown);
@@ -1193,6 +1201,76 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	return ret;
 }
 
+int io_recvzc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_recvzc *zc = io_kiocb_to_cmd(req, struct io_recvzc);
+	unsigned ifq_idx;
+
+	if (unlikely(sqe->file_index || sqe->addr2 || sqe->addr ||
+		     sqe->len || sqe->addr3))
+		return -EINVAL;
+
+	ifq_idx = READ_ONCE(sqe->zcrx_ifq_idx);
+	if (ifq_idx != 0)
+		return -EINVAL;
+	zc->ifq = req->ctx->ifq;
+	if (!zc->ifq)
+		return -EINVAL;
+
+	/* All data completions are posted as aux CQEs. */
+	req->flags |= REQ_F_APOLL_MULTISHOT;
+
+	zc->flags = READ_ONCE(sqe->ioprio);
+	zc->msg_flags = READ_ONCE(sqe->msg_flags);
+	if (zc->msg_flags)
+		return -EINVAL;
+	if (zc->flags & ~(IORING_RECVSEND_POLL_FIRST | IORING_RECV_MULTISHOT))
+		return -EINVAL;
+
+
+#ifdef CONFIG_COMPAT
+	if (req->ctx->compat)
+		zc->msg_flags |= MSG_CMSG_COMPAT;
+#endif
+	return 0;
+}
+
+int io_recvzc(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_recvzc *zc = io_kiocb_to_cmd(req, struct io_recvzc);
+	struct io_zcrx_ifq *ifq;
+	struct socket *sock;
+	int ret;
+
+	if (!(req->flags & REQ_F_POLLED) &&
+	    (zc->flags & IORING_RECVSEND_POLL_FIRST))
+		return -EAGAIN;
+
+	sock = sock_from_file(req->file);
+	if (unlikely(!sock))
+		return -ENOTSOCK;
+	ifq = req->ctx->ifq;
+	if (!ifq)
+		return -EINVAL;
+
+	ret = io_zcrx_recv(req, ifq, sock, zc->msg_flags | MSG_DONTWAIT);
+	if (unlikely(ret <= 0) && ret != -EAGAIN) {
+		if (ret == -ERESTARTSYS)
+			ret = -EINTR;
+
+		req_set_fail(req);
+		io_req_set_res(req, ret, 0);
+
+		if (issue_flags & IO_URING_F_MULTISHOT)
+			return IOU_STOP_MULTISHOT;
+		return IOU_OK;
+	}
+
+	if (issue_flags & IO_URING_F_MULTISHOT)
+		return IOU_ISSUE_SKIP_COMPLETE;
+	return -EAGAIN;
+}
+
 void io_send_zc_cleanup(struct io_kiocb *req)
 {
 	struct io_sr_msg *zc = io_kiocb_to_cmd(req, struct io_sr_msg);
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index a2be3bbca5ff..599eb3ea5ff4 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -36,6 +36,7 @@
 #include "waitid.h"
 #include "futex.h"
 #include "truncate.h"
+#include "zcrx.h"
 
 static int io_no_issue(struct io_kiocb *req, unsigned int issue_flags)
 {
@@ -513,6 +514,18 @@ const struct io_issue_def io_issue_defs[] = {
 		.async_size		= sizeof(struct io_async_msghdr),
 #else
 		.prep			= io_eopnotsupp_prep,
+#endif
+	},
+	[IORING_OP_RECV_ZC] = {
+		.needs_file		= 1,
+		.unbound_nonreg_file	= 1,
+		.pollin			= 1,
+		.ioprio			= 1,
+#if defined(CONFIG_NET)
+		.prep			= io_recvzc_prep,
+		.issue			= io_recvzc,
+#else
+		.prep			= io_eopnotsupp_prep,
 #endif
 	},
 };
@@ -742,6 +755,9 @@ const struct io_cold_def io_cold_defs[] = {
 	[IORING_OP_LISTEN] = {
 		.name			= "LISTEN",
 	},
+	[IORING_OP_RECV_ZC] = {
+		.name			= "RECV_ZC",
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 6cd3dee8b90a..8166d8a2656e 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -7,6 +7,8 @@
 #include <linux/io_uring.h>
 #include <net/page_pool/helpers.h>
 #include <trace/events/page_pool.h>
+#include <net/tcp.h>
+#include <net/rps.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -20,6 +22,12 @@
 
 #if defined(CONFIG_PAGE_POOL) && defined(CONFIG_INET)
 
+struct io_zcrx_args {
+	struct io_kiocb		*req;
+	struct io_zcrx_ifq	*ifq;
+	struct socket		*sock;
+};
+
 static inline struct io_zcrx_area *io_zcrx_iov_to_area(const struct net_iov *niov)
 {
 	struct net_iov_area *owner = net_iov_owner(niov);
@@ -247,6 +255,11 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 	lockdep_assert_held(&ctx->uring_lock);
 }
 
+static void io_zcrx_get_buf_uref(struct net_iov *niov)
+{
+	atomic_long_add(IO_ZC_RX_UREF, &niov->pp_ref_count);
+}
+
 static bool io_zcrx_niov_put(struct net_iov *niov, int nr)
 {
 	return atomic_long_sub_and_test(nr, &niov->pp_ref_count);
@@ -462,4 +475,171 @@ const struct memory_provider_ops io_uring_pp_zc_ops = {
 	.scrub			= io_pp_zc_scrub,
 };
 
+static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
+			      struct io_zcrx_ifq *ifq, int off, int len)
+{
+	struct io_uring_zcrx_cqe *rcqe;
+	struct io_zcrx_area *area;
+	struct io_uring_cqe *cqe;
+	u64 offset;
+
+	if (!io_defer_get_uncommited_cqe(req->ctx, &cqe))
+		return false;
+
+	cqe->user_data = req->cqe.user_data;
+	cqe->res = len;
+	cqe->flags = IORING_CQE_F_MORE;
+
+	area = io_zcrx_iov_to_area(niov);
+	offset = off + (net_iov_idx(niov) << PAGE_SHIFT);
+	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
+	rcqe->off = offset + ((u64)area->area_id << IORING_ZCRX_AREA_SHIFT);
+	memset(&rcqe->__pad, 0, sizeof(rcqe->__pad));
+	return true;
+}
+
+static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
+			     const skb_frag_t *frag, int off, int len)
+{
+	struct net_iov *niov;
+
+	off += skb_frag_off(frag);
+
+	if (unlikely(!skb_frag_is_net_iov(frag)))
+		return -EOPNOTSUPP;
+
+	niov = netmem_to_net_iov(frag->netmem);
+	if (niov->pp->mp_ops != &io_uring_pp_zc_ops ||
+	    niov->pp->mp_priv != ifq)
+		return -EFAULT;
+
+	if (!io_zcrx_queue_cqe(req, niov, ifq, off, len))
+		return -ENOSPC;
+	io_zcrx_get_buf_uref(niov);
+	return len;
+}
+
+static int
+io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
+		 unsigned int offset, size_t len)
+{
+	struct io_zcrx_args *args = desc->arg.data;
+	struct io_zcrx_ifq *ifq = args->ifq;
+	struct io_kiocb *req = args->req;
+	struct sk_buff *frag_iter;
+	unsigned start, start_off;
+	int i, copy, end, off;
+	int ret = 0;
+
+	start = skb_headlen(skb);
+	start_off = offset;
+
+	if (offset < start)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		const skb_frag_t *frag;
+
+		if (WARN_ON(start > offset + len))
+			return -EFAULT;
+
+		frag = &skb_shinfo(skb)->frags[i];
+		end = start + skb_frag_size(frag);
+
+		if (offset < end) {
+			copy = end - offset;
+			if (copy > len)
+				copy = len;
+
+			off = offset - start;
+			ret = io_zcrx_recv_frag(req, ifq, frag, off, copy);
+			if (ret < 0)
+				goto out;
+
+			offset += ret;
+			len -= ret;
+			if (len == 0 || ret != copy)
+				goto out;
+		}
+		start = end;
+	}
+
+	skb_walk_frags(skb, frag_iter) {
+		if (WARN_ON(start > offset + len))
+			return -EFAULT;
+
+		end = start + frag_iter->len;
+		if (offset < end) {
+			copy = end - offset;
+			if (copy > len)
+				copy = len;
+
+			off = offset - start;
+			ret = io_zcrx_recv_skb(desc, frag_iter, off, copy);
+			if (ret < 0)
+				goto out;
+
+			offset += ret;
+			len -= ret;
+			if (len == 0 || ret != copy)
+				goto out;
+		}
+		start = end;
+	}
+
+out:
+	if (offset == start_off)
+		return ret;
+	return offset - start_off;
+}
+
+static int io_zcrx_tcp_recvmsg(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
+				struct sock *sk, int flags)
+{
+	struct io_zcrx_args args = {
+		.req = req,
+		.ifq = ifq,
+		.sock = sk->sk_socket,
+	};
+	read_descriptor_t rd_desc = {
+		.count = 1,
+		.arg.data = &args,
+	};
+	int ret;
+
+	lock_sock(sk);
+	ret = tcp_read_sock(sk, &rd_desc, io_zcrx_recv_skb);
+	if (ret <= 0) {
+		if (ret < 0 || sock_flag(sk, SOCK_DONE))
+			goto out;
+		if (sk->sk_err)
+			ret = sock_error(sk);
+		else if (sk->sk_shutdown & RCV_SHUTDOWN)
+			goto out;
+		else if (sk->sk_state == TCP_CLOSE)
+			ret = -ENOTCONN;
+		else
+			ret = -EAGAIN;
+	} else if (sock_flag(sk, SOCK_DONE)) {
+		/* Make it to retry until it finally gets 0. */
+		ret = -EAGAIN;
+	}
+out:
+	release_sock(sk);
+	return ret;
+}
+
+int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
+		 struct socket *sock, unsigned int flags)
+{
+	struct sock *sk = sock->sk;
+	const struct proto *prot = READ_ONCE(sk->sk_prot);
+
+	if (prot->recvmsg != tcp_recvmsg)
+		return -EPROTONOSUPPORT;
+
+	sock_rps_record_flow(sk);
+	return io_zcrx_tcp_recvmsg(req, ifq, sk, flags);
+}
+
 #endif
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 67512fc69cc4..ddd68098122a 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -3,6 +3,7 @@
 #define IOU_ZC_RX_H
 
 #include <linux/io_uring_types.h>
+#include <linux/socket.h>
 #include <net/page_pool/types.h>
 
 #define IO_ZC_RX_UREF			0x10000
@@ -44,6 +45,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			 struct io_uring_zcrx_ifq_reg __user *arg);
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx);
 void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx);
+int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
+		 struct socket *sock, unsigned int flags);
 #else
 static inline int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 					struct io_uring_zcrx_ifq_reg __user *arg)
@@ -56,6 +59,14 @@ static inline void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 static inline void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 }
+static inline int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
+			       struct socket *sock, unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
+int io_recvzc(struct io_kiocb *req, unsigned int issue_flags);
+int io_recvzc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+
 #endif
-- 
2.43.5


