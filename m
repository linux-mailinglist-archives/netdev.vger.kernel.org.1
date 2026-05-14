Return-Path: <netdev+bounces-288043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBFTL139BWrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6B5544EF1
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 775A93018096
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445833A007;
	Thu, 14 May 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpL9V5Iv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34431AF2D
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777414; cv=none; b=RIsK7+R8wr2sXHSJaD+gQKNtfnKghaOeeVflRgkCPzeICI49f0noIu4YUBL1Qje2cXs9wrtnKokG5UXssgvkvgPn8zsqa9LeRyI3XQkrwXG7OOECQKtezb9ZzmE8In7EKm2UrXTr2RVUQqLUeg5b/a0gHYKdWP/l4PlaZ5rL59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777414; c=relaxed/simple;
	bh=xaDJ6AhrGPsK6Co3K1k8EdNzGxNV+cBSK5nP6nfNhss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFGiFPED1cQ7mK0euyPBnTkjq3x1uomyfys1m+cFqPPQbK40JAeoq6/JRSoajheJ1c5nagvo020/fm1O6/5Qn4/nW9XZzKvypkx7rQ6Vv9owgGxJCgCWbNObppNBHqB1xSKbRGMcghFQcG7RjHhetJBnZZHUgTNJqxTn7QxSwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpL9V5Iv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so4284026a91.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777411; x=1779382211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDjribekpIomxI3HWRnZ6Olveu3FkT0qRUsHGP8CKgU=;
        b=OpL9V5IvESDpoQkgWQpvwiGRnw/+NSiMIa89eqKqbTA6+EX5lDKx7avFibalwTCJNX
         VZRJSximpWzfSnP2bWUUViiSNvH14U+avM8/g/nz+mc5H6R++pNAVmQXeJYYfsqYaBnc
         ua3YtxY/U2wIMBj8PL/kUejJc1HPlVJSYxpGNZ/LoZMCDL1Nk2ZWmECMEgcF482kXKnt
         bTiWBq/2fK8MFg2Xzmb+MrGg5sYDI9Ewf5/+zqdG2lTHJCEUjmoN/job3pv0a/LCTuJD
         ESvXvSnGwEonXds2OO7cYYqZ/RqYAPkAI6J8M/YGfu/OlbJqYFqa9vn5XvxBqstJWZR/
         M2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777411; x=1779382211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDjribekpIomxI3HWRnZ6Olveu3FkT0qRUsHGP8CKgU=;
        b=mQPY2C8mn4eKDCTmxxgYQffgOc8FwliebEL66BA09qWqGkUbmkYuje9RtREr8CCreI
         FARf73ETH6ktWq7Sh/O4MOpTQ4Jp7yfq5h2xB6bLvJPo+HHizNu7KuMAWRm3gz1rbmnl
         eLhRKTMeyQoyEg3DZhN6flX4f4UIXipCelwmXnE+zc3AdLS4xAJMqNJa5WhtU6sBWDqI
         Ooujl5iW396r55u7Vhkm4W4NLqBe9JpiqZxaBbIR6zPIhzwtnfaeKaLawbOumu4V+38d
         QHqBO00UNyf7gh05neGS8NY6LfP52HaZZ9+AxQI5Mmsc3TIFeNIYw3DYCWdMpqkPgi4l
         grlw==
X-Gm-Message-State: AOJu0Yzrf/FmBs5Y7vbf1zLsGbvW/1n8VBtd0UtOLycv4WQB8RSMkKdT
	aG0XtQx1C8/zHP7/9j7AJmifBKYNLHNWLirjYsIEDwtZiI9kmwd5lJi8j7qh/n2E+qc=
X-Gm-Gg: Acq92OG7rnKKRO3fWrce5ALm5WegQO3TLpEKkxAxlsLsk1xnLChcKNFOw2EcZjUFDTN
	vHiUI6XquO7IV6f9HH2gXkvczCMT/Rf7ScJ6sHT1URCxUrCGTgees/Q5Cr/jAUecpdQSxXUdGVp
	Lo0O2IpkmI+2OPXA/vYWq1hSuVwKKbJBLE/4DCBvU85yJlAI2e0ZVQRNwETdbdtTX83+u1Umfd0
	dK2FpTtoWepDJso8/CaQbEHRMtnzxbta87xqcrC62YNXWKkE4fdLluaQ5mvS29zUk06eYmBgSlC
	jjXqH5K6NoLd4IScUI61y9QB/NBws+SQLm6iLTH1ybOimaBfMEn5hdqHeTRjL/pL5NLgleex+8q
	H8GQsFc26EIXU9SAMwHTxFx6g+HW3NdYZquhuNV4fMOW4nc7krPXlaQQ7gEjBwKuTsrZEw8ZEHH
	ZHwXPbmNQeiz6x5ZhcyHWR7b1ca95IKMLBF8RNdLxc
X-Received: by 2002:a17:90b:3505:b0:365:3154:7b1 with SMTP id 98e67ed59e1d1-36951dd55famr150926a91.26.1778777410631;
        Thu, 14 May 2026 09:50:10 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe7270sm30228365ad.50.2026.05.14.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:50:10 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Tong Liu <lyutoon@gmail.com>
Subject: [PATCH net 1/4] ipv4: validate ip_options length in __ip_options_echo() against skb tail
Date: Fri, 15 May 2026 00:50:03 +0800
Message-ID: <20260514165003.436206-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C6B5544EF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288043-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

__ip_options_echo() re-reads each option length byte (RR/TS/SRR/CIPSO)
from skb->data when building the echoed options into a 40-byte
__data[] buffer.  __ip_options_compile() saved only the option offset
into IPCB(skb)->opt, not the length.  An nftables LOCAL_IN payload
write reachable from an unprivileged user namespace can mutate the
length byte between parse and recvmsg, turning a parse-time validated
7-byte option into a 255-byte read.

  unsigned char optbuf[sizeof(struct ip_options) + 40];
  /* in __ip_options_echo: */
  optlen = sptr[sopt->rr + 1];        /* re-read; nft can mutate */
  memcpy(dptr, sptr + sopt->rr, optlen); /* into 40-byte buffer */

The destination is a stack buffer in ip_cmsg_recv_retopts() and a
DEFINE_RAW_FLEX() buffer in icmp.c / ip_output.c sized
IP_OPTIONS_DATA_FIXED_SIZE (40).  KASAN reports a stack-out-of-bounds
write of size 255:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo+0x7fc/0x1310
  Write of size 255 at addr ffff88800a657950
   __asan_memcpy+0x3c/0x60
   __ip_options_echo+0x7fc/0x1310
   ip_cmsg_recv_offset+0x58b/0xd10
   udp_recvmsg+0x8da/0xc20
   ____sys_recvmsg+0x1b1/0x620

Validate that each re-read option length stays within
skb_tail_pointer(skb) before the memcpy.

Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/ipv4/ip_options.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac24..1cc6096e6dd9d 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -91,6 +91,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 
 	if (sopt->rr) {
 		optlen  = sptr[sopt->rr+1];
+		if (sptr + sopt->rr + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		soffset = sptr[sopt->rr+2];
 		dopt->rr = dopt->optlen + sizeof(struct iphdr);
 		memcpy(dptr, sptr+sopt->rr, optlen);
@@ -105,6 +107,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 	}
 	if (sopt->ts) {
 		optlen = sptr[sopt->ts+1];
+		if (sptr + sopt->ts + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		soffset = sptr[sopt->ts+2];
 		dopt->ts = dopt->optlen + sizeof(struct iphdr);
 		memcpy(dptr, sptr+sopt->ts, optlen);
@@ -145,6 +149,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 		__be32 faddr;
 
 		optlen  = start[1];
+		if (start + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		soffset = start[2];
 		doffset = 0;
 		if (soffset > optlen)
@@ -174,6 +180,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 	}
 	if (sopt->cipso) {
 		optlen  = sptr[sopt->cipso+1];
+		if (sptr + sopt->cipso + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		dopt->cipso = dopt->optlen+sizeof(struct iphdr);
 		memcpy(dptr, sptr+sopt->cipso, optlen);
 		dptr += optlen;
-- 
2.47.3


