Return-Path: <netdev+bounces-306823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DjyXIbIfUmrvMAMAu9opvQ
	(envelope-from <netdev+bounces-306823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:49:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F97414DA
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:49:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ohDOZevT;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306823-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306823-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 853233019BB9
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B753BED5F;
	Sat, 11 Jul 2026 10:49:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7833BBCD
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:49:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766951; cv=none; b=rQyo44orVOD2wYufnPdvpg/wwgMD1IFfbURYyHyo0MOJsVD1HfX3Fzcss4bApndyTUG0t2BaCObXsi+wJaVTShmO1kO9WskaO3e32pye0Zv/I8pqW0Du8PiPPvxLTAGWcXdVqtqDAB2+rKiAYJ3XFQfs/7rXu6r5iDtN2zjY+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766951; c=relaxed/simple;
	bh=jMzpt1cR6AoTNSIsp+VeRZ4QHMFIIBm31IrM51LY1WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nddiGvuOrXUiDWd45OvrI15YuV7rIvvCYRoTmQRZClCz9hbU+UuHQem0An4iAvEktq+wCtuD+FbjG2mNLa1KG1KidbEZTewSJb4TTxrg/tNgHqIsZ8S1kjjf1BmQ0avuR15aBS0cbeRjveR6UVYVOcvq+JpoWpCcze9NxBFjOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohDOZevT; arc=none smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15bf399d3bso211760066b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766947; x=1784371747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwBSzhndPeMI54zLXi5IxtipPiwbYr7jJkmQfwxDNXo=;
        b=ohDOZevTKarogW4pl4gGV4aohlsEJynlwEt+v64f6kbJrH7d9OV3a+ZM+Uw8m1bfnJ
         KQpaPE6j81IaSdlx9OwxtTPFaXcDsp1yYQ/Nou6hktB53g2tsb8l9NzNLPX3YiGJD/Pn
         zzJOMi0LcTmWLxJ7UGl5wdvD6Ut//zEnk/jxHLnNFQG2mHlWTUJdSKV+JnFITDHUyHAL
         aG6jV0cnQNipAgXHfwDJD37qyeZMV/p+alPE0/JthvbNfm0yRHWxjVMic7cHTl+EOBOh
         IK6ehiuDpUYSidUFRaPPUK0YsRxvKC8LNeus3alYItdtShI0wGhFOb4QF1/CgNmz7WBi
         2mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766947; x=1784371747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwBSzhndPeMI54zLXi5IxtipPiwbYr7jJkmQfwxDNXo=;
        b=Kh6uYdNgyCs+VYetfvi/QmrBMzS8GHWRqYG3fvZpUxuRdRi0x0Oi7FwA9TOtNyL0wF
         P4dHOuXIS3/9kArtTq9qSkQus+yb91AqGnOVLRk29++aapzw/0YtKRcmCPwQgHJ8knHi
         iveaZosK4H5Optr9o8Wwzs6ZVkt4xfnfU1CEuyY8qCKol1pFM0Oo2G+PA0lrE9NRTEys
         ngmIH2g2tJhR3dYfGRhI9PU9sL/w809AToFnOYPgW28V14zhcSmxbtgkGChzOf/YNg9i
         a91ZqtbbbpIoc3kAzp2zxE5NEjdAI50+/bmD7kcsWxiu1LPMForEZR91R1v8X63Ch2rL
         /7Yg==
X-Gm-Message-State: AOJu0YwFJ6CJK0VG0BldYeTkrkRcZ+9v1D3jCv2s9l0vh8LRKJkRJD3P
	OEJLSDUnn28Fk29P/5bgO0lrAht4h73Wae4MPBC0RpFMJDQWRBnXOOaQscHPHg==
X-Gm-Gg: AfdE7cn6SVSYuQ8M5WjalllLiK4TzUAqVhdPtSy0uJMTsXOIlrNuU+3nVLXCoKOzIqE
	vTvC1HA2fzZ22KVp/VDuNgDoBkWCyWe8QL103gknR31UYy0eG7mSGdez+vCl9Wd1bUeftOksoNI
	s0ppWb3UjLiBK+gOw4l1b6psQ27PKBsFHDHRvI4XbbFLk34zBPS0fpciEy24izlMG6lcFUqBc1U
	Z57SIfgJQm6LTKRqiEqxBiqKHfWMs+1kN+Jf9PdxG2+xCvAPStRbNwEMO8C4ycBruES7vchFLoC
	+nx+JdC9KWj03gRaC3KjkplZw2AEEncqmORisIMxc3bqTCnU4CmAJvi6XmudRg6sLzK3gEsgIz7
	c5hwZBHgHZ0xVU8FiSNRRGukofZ2nzURFFx2OVxcIbVxWVvRPX4UDK0xw0J7XmaMFBBzlITHJzn
	/TkLDaNpM9IXuCwoXCCkfGEYbRZBaKVDPfzJqBfDzmWum6eNWzIEzPeIM5U6ozQS9DLUTOFwiCB
	RwiTuY6clz3MKgOzVCnliNxct16D0efRyzKliWuBp197sbMZQ==
X-Received: by 2002:a17:906:f587:b0:c15:db5c:7127 with SMTP id a640c23a62f3a-c161e88f7cemr88143166b.20.1783766946815;
        Sat, 11 Jul 2026 03:49:06 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15beb53b86sm609123166b.25.2026.07.11.03.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:49:05 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 01/10] net: pass ubuf to custom sg_from_iter callbacks
Date: Sat, 11 Jul 2026 11:48:30 +0100
Message-ID: <58db782214b7169988fe4981771d3f0a12de4529.1783614400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783614400.git.asml.silence@gmail.com>
References: <cover.1783614400.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306823-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E47F97414DA

ubuf_info and callbacks for chunking zerocopy iterators into skbs comes
in pairs in msghdr, and in the future the callback will need to know
which ubuf_info it was called with. We can't derive it from the skb as
some paths set it after the call, so pass it in.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/socket.h | 2 +-
 io_uring/net.c         | 8 ++++----
 net/core/datagram.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 2a8d7b14f1d1..5ae24847f5c4 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -90,7 +90,7 @@ struct msghdr {
 	unsigned int	msg_flags;	/* flags on received message */
 	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
 	struct ubuf_info *msg_ubuf;
-	int (*sg_from_iter)(struct sk_buff *skb,
+	int (*sg_from_iter)(struct sk_buff *skb, struct ubuf_info *ubuf,
 			    struct iov_iter *from, size_t length);
 };
 
diff --git a/io_uring/net.c b/io_uring/net.c
index 00a7df803b99..cf273d6f02b1 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -116,9 +116,9 @@ struct io_recvzc {
 	struct io_zcrx_ifq		*ifq;
 };
 
-static int io_sg_from_iter_iovec(struct sk_buff *skb,
+static int io_sg_from_iter_iovec(struct sk_buff *skb, struct ubuf_info *ubuf,
 				 struct iov_iter *from, size_t length);
-static int io_sg_from_iter(struct sk_buff *skb,
+static int io_sg_from_iter(struct sk_buff *skb, struct ubuf_info *ubuf,
 			   struct iov_iter *from, size_t length);
 
 int io_shutdown_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
@@ -1447,14 +1447,14 @@ int io_send_zc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return 0;
 }
 
-static int io_sg_from_iter_iovec(struct sk_buff *skb,
+static int io_sg_from_iter_iovec(struct sk_buff *skb, struct ubuf_info *ubuf,
 				 struct iov_iter *from, size_t length)
 {
 	skb_zcopy_downgrade_managed(skb);
 	return zerocopy_fill_skb_from_iter(skb, from, length);
 }
 
-static int io_sg_from_iter(struct sk_buff *skb,
+static int io_sg_from_iter(struct sk_buff *skb, struct ubuf_info *ubuf,
 			   struct iov_iter *from, size_t length)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index c285c6465923..f15886f40efc 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -753,7 +753,7 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 	int ret;
 
 	if (msg && msg->msg_ubuf && msg->sg_from_iter)
-		ret = msg->sg_from_iter(skb, from, length);
+		ret = msg->sg_from_iter(skb, msg->msg_ubuf, from, length);
 	else if (binding)
 		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
 	else
-- 
2.54.0


