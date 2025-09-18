Return-Path: <netdev+bounces-224525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0515B85DC6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F0B622B30
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE77D316904;
	Thu, 18 Sep 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQte7E8y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A43164CB
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210945; cv=none; b=hHZlfp9j03aummHzUc+JKcfCt4w2Wopd2v9jer3p3JcNHNevlggO0odgG1wOT4DR6hzODbNmS2C42vTBNuPOAGagNMEQLJzm8ysV3GVlSw/Ji1xySX9hx/CyXkV52/mBbNOMep/IdLSlkhQrI0wkzUhBKW7kcedJYB7fXl8OzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210945; c=relaxed/simple;
	bh=6KhddUAiqAErPbwnzW3XQnjh3/Pk/7DQeKQCWO0yw0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RiLpXbhfqjcm1gKe48U+OZrpAGasHTBWH/GQP/6eUosnOr5MmvwaIFabALL+rWIL/ffk7XYU9Ej64Gz6hLp84BIBVoaNQN15BfgZqsnpyZg1GsUnNHIarnAwwFODhS763+inPQr3S38HB7a/qhu3HSLSRjiAfgMR5jHdaIzwwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQte7E8y; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8217df6d44cso180472785a.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210943; x=1758815743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6KduFFPTTKx5ktqm5N8DBWb6dTk1ui40vkDAkDO+Wo=;
        b=vQte7E8y2y2s2gzPAjIoh2QHd6THpbqANHp/iuQUhfo199X5bePk1UzOl41f8QgFED
         4knaYSXHt8HqX3DipX43H5Zlpl/V61sa+BUvM94DzL+IvDWalbKNyh5aZPoSpcZkT2fP
         K+i/DKtrKj1a5qzA8ieChP5Ux1+3jDiuX1jd2AnyKPpwseJjBOTPd4uWbKYgGRHF2Vaq
         xrRPrqkSOzHg4PiKIGWOUuk9Veotht14ipp62Oi01imAfA/BtNMxeoo0WAvjmwN3Kee7
         sro5MKzC1G+sZyTUYslgD/u28oyz6mt4KqoRjsNIFMy0rz7mit7/Pc6kx5UxCgaGNfwI
         R6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210943; x=1758815743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6KduFFPTTKx5ktqm5N8DBWb6dTk1ui40vkDAkDO+Wo=;
        b=aU4eGy1mYd5CBgZb7+ScgtKzCd4bAxgfDJFbSA8rVdeT9PXsKYqj1JpbsPtnC/i28M
         D+CDb3VcnL2eIR/fplpDGbPnUnlK+qA7NAoPtdF7D643jfidscgPyeOSFF2GxHCWENeb
         mJ/7rthr9hszsRL6txOY1mGkO909jLaLjCXUFcSTVaph2V1j+SMqrWDLrz6vc0yWFDbZ
         xVKH+gNgFVGCmZJWyxXI88zpFK2nloIFCp+pP0SpiUF20GuJ/7bDRJGtmYRAFHjbMF7m
         H8lEbo9e5hlzLmmj8SImFn5NdMmTl5qRtHGUdBdDUOp4sNgyarsqZWpkiPDj0aN2nZR8
         PMVw==
X-Forwarded-Encrypted: i=1; AJvYcCWTXf0iQjmep4HNqclDFcLOkxz8MgA/8RJ5ETt9rtYBWjFpg0cKTXGnANPd6ZQnOB60nvv1Nnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCW83R+eyVUKD0Wg7nk3skyenJlPbVW+1dV3e6sdTTp0T21Zu
	wACGVocSzeVzSAa/Vp+ojCnv0qPWko0sQxPknfCjgVFl1Rpp5Dkk6vI2Je/0c08T/sX4LiA7ALg
	7YAr08RfCnl9Kzw==
X-Google-Smtp-Source: AGHT+IHtSeiV8wKhLi0B35X8bLvlKNJe5ztNBMr1A3GxgFmGHlwxN/4pe/x7Z5bX0mQKSDUpjJUlOJjW6MMPBg==
X-Received: from qknqf1.prod.google.com ([2002:a05:620a:6601:b0:829:9702:a0e4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1204:b0:807:673d:f025 with SMTP id af79cd13be357-83ba29b6b53mr8078285a.15.1758210942376;
 Thu, 18 Sep 2025 08:55:42 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:55:31 +0000
In-Reply-To: <20250918155532.751173-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918155532.751173-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918155532.751173-7-edumazet@google.com>
Subject: [PATCH net-next 6/7] tcp: move mtu_info to remove two 32bit holes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This removes 8bytes waste on 64bit builds.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3f282130c863d07cddd931b85f43afaf44bc7323..20b8c6e21fef36984810541a06fcb7ba8f0c45b1 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -448,6 +448,9 @@ struct tcp_sock {
 				 * the first SYN. */
 	u32	undo_marker;	/* snd_una upon a new recovery episode. */
 	int	undo_retrans;	/* number of undoable retransmissions. */
+	u32	mtu_info; /* We received an ICMP_FRAG_NEEDED / ICMPV6_PKT_TOOBIG
+			   * while socket was owned by user.
+			   */
 	u64	bytes_retrans;	/* RFC4898 tcpEStatsPerfOctetsRetrans
 				 * Total data bytes retransmitted
 				 */
@@ -494,9 +497,6 @@ struct tcp_sock {
 		u32		  probe_seq_end;
 	} mtu_probe;
 	u32     plb_rehash;     /* PLB-triggered rehash attempts */
-	u32	mtu_info; /* We received an ICMP_FRAG_NEEDED / ICMPV6_PKT_TOOBIG
-			   * while socket was owned by user.
-			   */
 #if IS_ENABLED(CONFIG_MPTCP)
 	bool	is_mptcp;
 #endif
-- 
2.51.0.384.g4c02a37b29-goog


